var dateFormat = require('dateformat');
var fs = require('fs');
//var stripe = require("stripe")("sk_test_K07w4koBikvc7EKOK1H59dbL00RBhy0Nn2");
var stripe = require("stripe")(global.general.stripe_secret);
var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');

const payment_log_path = global.common.path + "/public/logs/payment";

exports.create_customer_account = function (req, q, payment_data) {
    var defered = q.defer();

    var resultObj = {};
    var moment = require('moment');
    var time = moment.utc().valueOf();
    var tos_acceptance_date = Math.floor(time / 1000);
    var logfile = "Create_Customer_Account";
    var ssnfile = payment_data.ssn.substr(payment_data.ssn.length - 4);
    if (global.surl == 'http://localhost' || global.surl == 'https://localhost') {
        var site_url = 'https://hempbuyer.auctionsoftware.com';
    } else {
        var site_url = global.url;
    }

    if (payment_data.account_no == '' || payment_data.rounting_no == '') {
        resultObj.result = 2;
        resultObj.stripe_token = "- invalid Create_Account -";
        resultObj.errortext = 'Invalid Create_Account';
        exports.paylog(resultObj, logfile);
        defered.resolve(resultObj)
    } else {
        stripe.accounts.create({
            country: 'US',
            type: 'custom',
            email: payment_data.email,
            requested_capabilities: ['card_payments', 'transfers'],
            "business_type": "individual",
            "external_account": {
                "object": "bank_account",
                country: 'US',
                currency: 'usd',
                account_holder_name: payment_data.name,
                account_holder_type: 'individual',
                routing_number: payment_data.rounting_no,
                account_number: payment_data.account_no
            },
            "business_profile": {
                "mcc": "4814",
                "product_description": "Telecommunication Services",
                "url": site_url
            },
            "individual": {
                "email": payment_data.email,
                "first_name": payment_data.name,
                "last_name": payment_data.name,
                "dob": {
                    "day": payment_data.days,
                    "month": payment_data.month,
                    "year": payment_data.year
                },
                "address": {
                    "city": payment_data.city,
                    "postal_code": payment_data.zipcode,
                    "state": payment_data.state,
                    "country": 'US',
                    "line1": payment_data.address
                },
                "verification": {
                    "document": {
                        "back": payment_data.back_photo,
                        "front": payment_data.front_photo
                    }
                },
                "id_number": payment_data.ssn,
                "ssn_last_4": ssnfile,
                "phone": payment_data.phone
            },
            "tos_acceptance": {
                "date": tos_acceptance_date,
                "ip": req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.socket.remoteAddress || (req.connection.socket ? req.connection.socket.remoteAddress : null)
            }
        }).then(function(account) {
            console.log('account', account);
            exports.paylog(account, logfile);
            resultObj.success = 1;
            resultObj.account_id = account.id;
            resultObj.profile_id = account.individual.id;
            defered.resolve(resultObj)
         })
        .catch(function(err) { 
            console.log('error', err);
            exports.paylog(err, logfile);
            resultObj.success = 0;
            resultObj.errorcode = err.code;
            resultObj.stripe_token = "- Create_Account -";
            resultObj.errortext = err.message;
            defered.resolve(resultObj);
        });
    }
    return defered.promise;

}
exports.update_customer_account = function (req, q, payment_data) {
    var defered = q.defer();
    var resultObj = {};
    var moment = require('moment');
    var time = moment.utc().valueOf();
    var tos_acceptance_date = Math.floor(time / 1000);
    var logfile = "Update_Customer_Account";
    var ssnfile = payment_data.ssn.substr(payment_data.ssn.length - 4);
    if (global.surl == 'http://localhost' || global.surl == 'https://localhost') {
        var site_url = 'https://hempbuyer.auctionsoftware.com';
    } else {
        var site_url = global.url;
    }

    if (payment_data.account_no == '' || payment_data.rounting_no == '') {
        resultObj.result = 2;
        resultObj.stripe_token = "- invalid Update_Account -";
        resultObj.errortext = 'Invalid Update_Account';
        exports.paylog(resultObj, logfile);
        defered.resolve(resultObj)
    } else {
        stripe.accounts.update(
            payment_data.account_id,
            {
                email: payment_data.email,
                "business_type": "individual",
                "external_account": {
                    "object": "bank_account",
                    country: 'US',
                    currency: 'usd',
                    account_holder_type: 'individual',
                    routing_number: payment_data.rounting_no,
                    account_number: payment_data.account_no
                },
                "individual": {
                    "email": payment_data.email,
                    "address": {
                        "city": payment_data.city,
                        "postal_code": payment_data.zipcode,
                        "state": payment_data.state,
                        "country": 'US',
                        "line1": payment_data.address
                    },
                    "phone": payment_data.phone
                },
                "tos_acceptance": {
                    "date": tos_acceptance_date,
                    "ip": req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.socket.remoteAddress || (req.connection.socket ? req.connection.socket.remoteAddress : null)
                }
            },
            function (err, account) {
                if (typeof (err) === 'undefined' || err === null) {
                    exports.paylog(account, logfile);
                    resultObj.success = 1;
                    resultObj.account_id = account.id;
                    resultObj.profile_id = account.individual.id;
                } else {
                    exports.paylog(err, logfile);
                    resultObj.success = 0;
                    resultObj.errorcode = err.code;
                    resultObj.stripe_token = "- Update_Account -";
                    resultObj.errortext = err.message;
                }
                defered.resolve(resultObj)
            }
        );
    }
    return defered.promise;
}
exports.payout_to_bank = function (req, q, payment_data) {
    var defered = q.defer();

    var resultObj = {};
    var logfile = "Payout_To_Bank";
    if (payment_data.account_id == '') {
        resultObj.result = 2;
        resultObj.stripe_token = "- invalid Payout Details -";
        resultObj.errortext = 'Invalid Account token number';
        exports.paylog(resultObj, logfile);
        defered.resolve(resultObj)
    } else {

        stripe.transfers.create({
            amount: payment_data.amount,
            currency: "usd",
            destination: payment_data.account_id,
            source_type: 'bank_account',
            // source_transaction: payment_data.trans_id
        }, function (err, transfer) {

            if (typeof (err) === 'undefined' || err === null) {
                exports.paylog(transfer, logfile);
                resultObj.success = 1;
                resultObj.refer_id = transfer.id;
                resultObj.trans_id = transfer.balance_transaction;
                resultObj.destination_payment = transfer.destination_payment;
            } else {
                exports.paylog(err, logfile);
                resultObj.success = 0;
                resultObj.errorcode = err.code;
                resultObj.stripe_token = "- invalid Payout Token -";
                resultObj.errortext = err.message;
            }
            defered.resolve(resultObj)
        });
    }
    return defered.promise;
}


exports.delete_customer_account = function (req, q, payment_data) {
    var defered = q.defer();

    var resultObj = {};
    stripe.accounts.del(
        payment_data.account_id
    ).then(function(account) {
        console.log('account', account);
        resultObj.success = 1;
        resultObj.account_id = account.id;
        resultObj.object = account.object;
        resultObj.deleted = account.deleted;
        defered.resolve(resultObj)
        })
    .catch(function(err) { 
        console.log('error', err);
        resultObj.success = 0;
        resultObj.errorcode = err.code;
        resultObj.stripe_token = "- Delete_Account -";
        resultObj.errortext = err.message;
        defered.resolve(resultObj);
    });
    return defered.promise;

}
/* exports.CreatecustomerAccount = function (payment_data, req) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var moment = require('moment');
        var time = moment.utc().valueOf();
        var tos_acceptance_date = Math.floor(time / 1000);
        var logfile = "Create_Customer_Account";
        var ssnfile = payment_data.ssn.substr(payment_data.ssn.length - 4);
        if (global.surl == 'http://localhost' || global.surl == 'https://localhost') {
            var site_url = 'https://hempbuyer.auctionsoftware.com';
        } else {
            var site_url = global.url;
        }

        if (payment_data.account_no == '' || payment_data.rounting_no == '') {
            resultObj.result = 2;
            resultObj.stripe_token = "- invalid Create_Account -";
            resultObj.errortext = 'Invalid Create_Account';
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {
            stripe.accounts.create({
                country: 'US',
                type: 'custom',
                email: payment_data.email,
                requested_capabilities: ['card_payments', 'transfers'],
                "business_type": "individual",
                "external_account": {
                    "object": "bank_account",
                    country: 'US',
                    currency: 'usd',
                    account_holder_name: payment_data.firstname + ' ' + payment_data.lastname,
                    account_holder_type: 'individual',
                    routing_number: payment_data.rounting_no,
                    account_number: payment_data.account_no
                },
                "business_profile": {
                    "mcc": "4814",
                    "product_description": "Telecommunication Services",
                    "url": site_url
                },
                "individual": {
                    "email": payment_data.email,
                    "first_name": payment_data.firstname,
                    "last_name": payment_data.lastname,
                    "dob": {
                        "day": payment_data.days,
                        "month": payment_data.month,
                        "year": payment_data.year
                    },
                    "address": {
                        "city": payment_data.city,
                        "postal_code": payment_data.zipcode,
                        "state": payment_data.state,
                        "country": 'US',
                        "line1": payment_data.address
                    },
                    "verification": {
                        "document": {
                            "back": payment_data.back_photo,
                            "front": payment_data.front_photo
                        }
                    },
                    "id_number": payment_data.ssn,
                    "ssn_last_4": ssnfile,
                    "phone": payment_data.phone
                },
                "tos_acceptance": {
                    "date": tos_acceptance_date,
                    "ip": req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.socket.remoteAddress || (req.connection.socket ? req.connection.socket.remoteAddress : null)
                }
            }, function (err, account) {
                if (typeof (err) === 'undefined' || err === null) {
                    exports.paylog(account, logfile);
                    resultObj.result = 0;
                    resultObj.account_id = account.id;
                    resultObj.profile_id = account.individual.id;
                } else {
                    exports.paylog(err, logfile);
                    resultObj.result = 1;
                    resultObj.errorcode = err.code;
                    resultObj.stripe_token = "- Create_Account -";
                    resultObj.errortext = err.message;
                }
                resolve(resultObj)
            });
        }
    })
} */


exports.stripeCardDelete = function (data, card, callback) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "stripeCardsave_";
        customer = stripe.customers.deleteSource(
            card.token_id,
            card.card_id,
            function (err, customer) {
                if (err) {
                    exports.paylog(err, logfile);
                    resultObj.result = 1;
                    resultObj.message = err.message;
                } else {
                    exports.paylog(customer, logfile);
                    resultObj.result = 0;
                    resultObj.profileid = customer.id;
                    resultObj.customer = customer;
                }
                resolve(resultObj);
            });
    })
}
exports.stripeCardUpdate = function (data, card, callback) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "stripeCardsave_";
        customer = stripe.customers.createSource(
            card.token_id,
            {
                source: data.body.token_id
            }, function (err, customer) {
                if (err) {
                    exports.paylog(err, logfile);
                    resultObj.result = 1;
                    resultObj.message = err.message;
                } else {
                    exports.paylog(customer, logfile);
                    resultObj.result = 0;
                    resultObj.profileid = customer.id;
                    resultObj.customer = customer;
                }
                resolve(resultObj);
            });
    })
}
exports.stripeCardsave = function (data, callback) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "stripeCardsave_";
        customer = stripe.customers.create({
            source: data.body.token_id,
            name: data.session.first_name
        }, function (err, customer) {
            if (err) {
                exports.paylog(err, logfile);
                resultObj.result = 1;
                resultObj.message = err.message;
            } else {
                exports.paylog(customer, logfile);
                resultObj.result = 0;
                resultObj.profileid = customer.id;
                resultObj.customer = customer;
            }
            resolve(resultObj);
        });
    })
}
exports.paylog = function (logdata, filename) {
    var tdate = dateFormat(new Date(), "yyyy_mm_dd_HH_MM");
    filename = filename + "_" + tdate + ".log";
    logdata = JSON.stringify(logdata, null, 2);
    savPath = payment_log_path + "/" + filename;

    if (!fs.existsSync(payment_log_path))
        fs.mkdirSync(payment_log_path);

    fs.writeFile(savPath, logdata, function (err) {
        if (err) throw err;
        return true;
    });
}
exports.CreatePayment = function (payment_data) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "CreatePayment_";
        if (payment_data.amount == 0) {
            resultObj.result = 0;
            resultObj.transid = "- invalid amount - $0";
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {
            stripe.charges.create(payment_data, function (err, charge) {
                if (typeof (err) === 'undefined' || err === null) {
                    exports.paylog(charge, logfile);
                    resultObj.result = 0;
                    resultObj.transid = charge.id;
                    resultObj.charge = charge;
                } else {
                    exports.paylog(err, logfile);
                    resultObj.result = 1;
                    resultObj.errorcode = err.code;
                    resultObj.transid = "- invalid amount - $0";
                    resultObj.errortext = err.message;
                }
                resolve(resultObj)
            });
        }
    })
}
exports.CreateBankToken = function (payment_data) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "Create_Bank_Token_";
        if (payment_data.rounting_no == '' || payment_data.account_no == '') {
            resultObj.result = 2;
            resultObj.stripe_token = "- invalid Bank Details -";
            resultObj.errortext = 'Invalid stripe token number';
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {
            stripe.tokens.create({
                bank_account: {
                    country: 'US',
                    currency: 'usd',
                    account_holder_name: payment_data.holdername,
                    account_holder_type: 'individual',
                    routing_number: payment_data.rounting_no,
                    account_number: payment_data.account_no
                }
            }, function (err, token) {
                if (typeof (err) === 'undefined' || err === null) {
                    exports.paylog(token, logfile);
                    resultObj.result = 0;
                    resultObj.stripe_token = token.id;
                    resultObj.bank_account = token.bank_account.id;
                } else {
                    exports.paylog(err, logfile);
                    resultObj.result = 1;
                    resultObj.errorcode = err.code;
                    resultObj.stripe_token = "- invalid Bank Token -";
                    resultObj.errortext = err.message;
                }
                resolve(resultObj)
            });
        }
    })
}
exports.DeleteBankToken = function (payment_data) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "Delete_Bank_Token";
        if (payment_data.rounting_no == '' || payment_data.account_no == '') {
            resultObj.result = 2;
            resultObj.stripe_token = "- invalid Bank Details -";
            resultObj.errortext = 'Invalid stripe token number';
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {
            stripe.customers.deleteSource(
                payment_data.customer,
                payment_data.bank_account,
                function (err, confirmation) {
                    if (typeof (err) === 'undefined' || err === null) {
                        exports.paylog(confirmation, logfile);
                        resultObj.result = 0;
                        resultObj.bank_account = confirmation.id;
                    } else {
                        exports.paylog(err, logfile);
                        resultObj.result = 1;
                        resultObj.errorcode = err.code;
                        resultObj.stripe_token = "- invalid Bank Token -";
                        resultObj.errortext = err.message;
                    }
                    resolve(resultObj)
                }
            );
        }
    })
}
exports.AddBankToken = function (bank_data) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "ADD_Bank_Token_";
        if (bank_data.customer == '' || bank_data.bank_account == '') {
            resultObj.result = 2;
            resultObj.stripe_token = "- invalid Bank Token -";
            resultObj.status = "error";
            resultObj.errortext = 'Invalid stripe token number';
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {

            stripe.customers.createSource(
                bank_data.customer,
                {
                    source: bank_data.stripe_token,
                },
                function (err, bank_account) {
                    if (typeof (err) === 'undefined' || err === null) {
                        exports.paylog(bank_account, logfile);
                        resultObj.result = 0;
                        resultObj.bank_account = bank_account.id;
                        resultObj.customer = bank_account.customer;
                        resultObj.status = bank_account.status;
                    } else {
                        exports.paylog(err, logfile);
                        resultObj.result = 1;
                        resultObj.errorcode = err.code;
                        resultObj.stripe_token = "- invalid Bank Token -";
                        resultObj.status = "error";
                        resultObj.errortext = err.message;
                    }
                    resolve(resultObj)
                }
            );
        }
    })
}
exports.CustomerNew = function (customer_data) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "Create_Customer_Bank_Token_";
        if (customer_data.stripe_token == '' || customer_data.bank_account == '') {
            resultObj.result = 2;
            resultObj.stripe_token = "- invalid Create Customer Token -";
            resultObj.status = "error";
            resultObj.errortext = 'Invalid stripe token number';
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {

            stripe.customers.create({
                description: 'Customer for Bank Account',
                source: customer_data.stripe_token,
                email: customer_data.customer_email,
                name: customer_data.holdername
            }, function (err, customer) {
                if (typeof (err) === 'undefined' || err === null) {
                    exports.paylog(customer, logfile);
                    resultObj.result = 0;
                    resultObj.customer = customer.id;
                } else {
                    exports.paylog(err, logfile);
                    resultObj.result = 1;
                    resultObj.errorcode = err.code;
                    resultObj.stripe_token = "- invalid Create Customer Token -";
                    resultObj.status = "error";
                    resultObj.errortext = err.message;
                }
                resolve(resultObj)
            });
        }
    })
}
exports.AddBankTocutsromer = function (custoner_data) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "Update_Bank_Token_";
        if (custoner_data.customer == '' || custoner_data.bank_account == '') {
            resultObj.result = 2;
            resultObj.bank_account = "- invalid Bank Token -";
            resultObj.status = "error";
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {

            stripe.customers.update(
                custoner_data.customer,
                function (err, customer) {
                    if (typeof (err) === 'undefined' || err === null) {
                        exports.paylog(customer, logfile);
                        resultObj.result = 0;
                        resultObj.customer_id = customer.id;
                    } else {
                        exports.paylog(err, logfile);
                        resultObj.result = 1;
                        resultObj.errorcode = err.code;
                        resultObj.stripe_token = "- invalid Bank Token -";
                        resultObj.errortext = err.message;
                    }
                    resolve(resultObj)
                }
            );

        }
    })
}
//ACH Payment gateway
exports.CreateAccountTOCustomer = function (payment_data, req) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var moment = require('moment');
        var time = moment.utc().valueOf();
        var tos_acceptance_date = Math.floor(time / 1000);
        var logfile = "Create_Account";
        if (payment_data.customer == '' || payment_data.bank_account == '') {
            resultObj.result = 2;
            resultObj.stripe_token = "- invalid Create_Account -";
            resultObj.errortext = 'Invalid Create_Accountr';
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {
            stripe.accounts.create({
                country: 'US',
                type: 'custom',
                email: 'sathish.auctionsoftware@gmail.com',
                requested_capabilities: ['card_payments', 'transfers'],
                "business_type": "individual",
                "external_account": {
                    "object": "bank_account",
                    country: 'US',
                    currency: 'usd',
                    account_holder_name: 'vijay',
                    account_holder_type: 'individual',
                    routing_number: '110000000',
                    account_number: '000123456789'
                },
                "business_profile": {
                    "mcc": "4814",
                    "product_description": "Telecommunication Services",
                    "url": "http://somos.moblearn.net"
                },
                "individual": {
                    "email": "sathish.auctionsoftware@gmail.com",
                    "first_name": 'vijay',
                    "last_name": "kumar",
                    "dob": {
                        "day": '09',
                        "month": '02',
                        "year": '1995'
                    },
                    "address": {
                        "city": 'Odessa',
                        "postal_code": '79762',
                        "state": 'TX',
                        "country": 'US',
                        "line1": '4901 E University Blvd'
                    },
                    "id_number": '000000000',
                    "ssn_last_4": "0000",
                    "phone": "+19722005516"
                },
                "tos_acceptance": {
                    "date": tos_acceptance_date,
                    "ip": req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.socket.remoteAddress || (req.connection.socket ? req.connection.socket.remoteAddress : null)
                }
            }, function (err, account) {
                if (typeof (err) === 'undefined' || err === null) {
                    exports.paylog(account, logfile);
                    resultObj.result = 0;
                    resultObj.account_id = account.id;
                    resultObj.stripe_key = account.keys;
                } else {
                    exports.paylog(err, logfile);
                    resultObj.result = 1;
                    resultObj.errorcode = err.code;
                    resultObj.stripe_token = "- Create_Account -";
                    resultObj.errortext = err.message;
                }
                resolve(resultObj)
            });
        }
    })
}
exports.AddexternalAccountTOCustomer = function (payment_data) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "Add_External_Account";
        if (payment_data.customer == '' || payment_data.bank_account == '') {
            resultObj.result = 2;
            resultObj.stripe_token = "- invalid External_Account -";
            resultObj.errortext = 'Invalid External_Accountr';
            exports.paylog(resultObj, logfile);
            resolve(resultObj)
        } else {
            stripe.accounts.createExternalAccount(
                payment_data.account_id,
                {
                    external_account: payment_data.bank_account,
                },
                function (err, bank_account) {
                    if (typeof (err) === 'undefined' || err === null) {
                        exports.paylog(bank_account, logfile);
                        resultObj.result = 0;
                        resultObj.bank_id = bank_account.id;
                        resultObj.account_id = bank_account.account;
                        resultObj.status = bank_account.status;
                    } else {
                        exports.paylog(err, logfile);
                        resultObj.result = 1;
                        resultObj.errorcode = err.code;
                        resultObj.stripe_token = "- External_Account -";
                        resultObj.errortext = err.message;
                    }
                    resolve(resultObj)
                }
            );
        }
    })
}
exports.deleteexternalAccountTOCustomer = function (payment_data) {
    return new Promise((resolve, reject) => {
        var resultObj = {};
        var logfile = "Delete_External_Account";
        stripe.accounts.del(
            payment_data,
            function (err, confirmation) {
                if (typeof (err) === 'undefined' || err === null) {
                    exports.paylog(confirmation, logfile);
                    resultObj.result = 0;
                    resultObj.status = confirmation.deleted;
                } else {
                    exports.paylog(err, logfile);
                    resultObj.result = 1;
                    resultObj.stripe_token = "- Delete_Account -";
                    resultObj.errortext = err.message;
                }
                resolve(resultObj)
            }
        )
    })
}

exports.Add_Card_In_Stripe = function (payment_data) {
    return new Promise((resolve, reject) => {
        var logfile = "Card_Add";
        var resultObj = {};
        stripe.customers.createSource(
            payment_data.customer_token ? payment_data.customer_token : "", {
            source: payment_data.token.id
        },
            function (err, card) {
                if (err) {
                    logfile = "Card_Add_err";
                    exports.paylog(err, logfile);
                    resultObj.result = 0;
                } else {
                    logfile = "Card_Add";
                    exports.paylog(card, logfile);
                    resultObj.result = 1;
                    resultObj.card = card;
                }
                resolve(resultObj)
            })

    })
}

exports.set_default_source = function (customerid, card_id, callback) {
    var logfile = "Card_Update";
    var resultObj = {}
    stripe.customers.update(
        customerid, {
        default_source: card_id
    },
        function (err, customer) {
            if (err) {
                exports.paylog(err, logfile);
                resultObj.result = 0;
            } else {
                exports.paylog(customer, logfile);
                resultObj.result = 1;
                resultObj.customer = customer;
            }
            callback(resultObj);
        }
    );
}

exports.set_card_active = function (card_id) {
    var set_active = mysqclass.mysqli({}, "set_active_card");
    global.mysql.query(set_active, [card_id])
}

exports.set_card_inactive = function (customer_id) {
    var set_inactive = mysqclass.mysqli({}, "set_inactive");
    global.mysql.query(set_inactive, [customer_id])
}

//
exports.update_card = function (req) {
    var card_inputs = [
        req.session.first_name,
        req.body.card_details.customer.customer,
        "**** **** **** " + req.body.card_details.customer.last4,
        'active',
        dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"),
        dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"),
        req.session.userid,
        req.body.card_details.customer.brand,
        req.body.card_details.customer.exp_month,
        req.body.card_details.customer.exp_year,
        req.body.card_details.customer.address_zip,
        req.body.card_details.customer.id,
        req.session.userid
    ];
    var insert_cards = mysqclass.mysqli({}, "sm_update_credit_cards");
    global.mysql.query(insert_cards, card_inputs)
}

exports.insert_card = function (req) {
    var card_inputs = [
        req.session.first_name,
        req.body.card_details.customer.id,
        "**** **** **** " + req.body.card_details.customer.sources.data[0].last4,
        'active',
        dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"),
        dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"),
        req.session.userid,
        req.body.card_details.customer.sources.data[0].brand,
        req.body.card_details.customer.sources.data[0].exp_month,
        req.body.card_details.customer.sources.data[0].exp_year,
        req.body.card_details.customer.sources.data[0].address_zip,
        req.body.card_details.customer.sources.data[0].id
    ];

    var insert_cards = mysqclass.mysqli({}, "sm_create_credit_cards");
    global.mysql.query(insert_cards, card_inputs)
}


exports.Add_Card = function (req, res) {
    exports.Add_Card_In_Stripe(req.body, function (obj) {
        if (obj.result == 1) {
            // insert into credit cards
            exports.insert_card(obj.card, 'inactive', req.body.userid, req.body.name)
            res.send({ success: true });
        } else {
            res.send({ success: false });
        }
    })
}

exports.change_card_status = function (req, res) {

    exports.set_card_inactive(req.body.customer_id);

    exports.set_card_active(req.body.card_id);

    exports.set_default_source(req.body.customer_id, req.body.card_id, function (obj) {
        if (obj.result) {
            res.send({ success: true });
        } else {
            res.send({ success: false });
        }
    })
}


exports.updateCardDetails = function (req, res) {
    var resultObj = {}
    var logfile = "Card Update";

    req.body.month = req.body.expiry_date.split('/')[0]
    req.body.year = req.body.expiry_date.split('/')[1]

    stripe.customers.updateSource(
        req.body.customer_id,
        req.body.card_id, {
        exp_month: req.body.month,
        exp_year: req.body.year,
        name: req.body.name
    },
        function (err, card) {
            if (err) {
                resultObj.result = 1;
                resultObj.data = err;
                exports.paylog(err, logfile);
            } else {
                resultObj.result = 1;
                resultObj.data = card;
                exports.paylog(card, logfile);
            }
            exports.updateCardDB(card, req);
            res.send({ success: true })
        }
    );
}

exports.updateCardDB = function (card, req) {
    var card_inputs = [
        card.exp_year.toString(),
        card.exp_month,
        req.body.name,
        card.id
    ];
    var insert_cards = mysqclass.mysqli({}, "update_credit_cards");
    global.mysql.query(insert_cards, card_inputs)
}