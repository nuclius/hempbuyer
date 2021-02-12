var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');
var cryptos = require('./crypto');
var faAPI = require('../module/forwardauction_api');
var async = require('async');

exports.addBusinessDetails = function(mysql, req, res, userId) {
    // console.log(req.body);
    // console.log(req.files);
    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    console.log('req.body.permit_expires', req.body.permit_expires);
    if(req.body.permit_expires != undefined) {
        req.body.permit_expires = dateFormat(new Date(req.body.permit_expires), "yyyy-mm-dd HH:MM:ss");
    } else {
        req.body.permit_expires = '000-00-00 00:00:00';
    }
    // console.log("addShippingDetails"+JSON.stringify(req.body));
    //update business_details set license_img = ?, business_cert = ?, ref_code=?, notification_type=?, product_offers=?, sell_offers=? where userid = ?';
    strQuery = mysqli.mysqli($mysqli, "add_business_details");
    var escape_string = [
        typeof(req.body.business_name) !== 'undefined' ? req.body.business_name : '',
        typeof(req.body.business_type) !== 'undefined' ? req.body.business_type : '',
        typeof(req.files.licenses) !== 'undefined' ? req.files.licenses.name : '',
        typeof(req.files.certificates) !== 'undefined' ? req.files.certificates.name : '',
        typeof(req.body.ein_number) !== 'undefined' ? req.body.ein_number : '',
        typeof(req.body.permit_expires) !== 'undefined' ? req.body.permit_expires : '',
        typeof(req.body.ref_code) !== 'undefined' ? req.body.ref_code : 'n',
        typeof(req.body.notification_type) !== 'undefined' ? req.body.notification_type : 'email',
        typeof(req.body.product_offers) !== 'undefined' ? req.body.product_offers : 'n',
        /**/
        typeof(req.body.sell_offers) !== 'undefined' ? req.body.sell_offers : 'n',
        typeof(req.body.stax) !== 'undefined' ? req.body.stax : 'n',
        typeof(req.body.stax_per) !== 'undefined' ? req.body.stax_per : 0,
        /* Added for address same as userprofile */
        req.body.address1,
        req.body.country,
        req.body.state,
        req.body.city,
        req.body.zip,
        req.body.region,
        req.body.state_abbr,
        datge,
        userId
    ];
    var defered = q.defer();

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log(query.sql, " ============^^^^^^^^^^^^^^^^^^^^^============= ", escape_string);
    query.on('error', function(err) {
        console.log('error addBusinessDetails', err.stack);
        throw err;
    });
    return defered.promise;
}


exports.checkShippingAddress = function(mysql, req, res, userId) {
    $mysqli = {};
    // console.log("addShippingDetails"+JSON.stringify(req.body));
    strQuery = mysqli.mysqli($mysqli, "check_cnx247");
    //    'insert into shipping (first_name,last_name,email,phone,address,country,state,city,zipcode,user_id) values (?,?,?,?,?,?,?,?,?,?)';
    var escape_string = [
        userId
    ];
    var defered = q.defer();

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("checking shipping detials :---- " + query.sql);
    query.on('error', function(err) {
        throw err;
    });
    
    return defered.promise;
}

exports.addShippingDetails = function(mysql, req, res, userId) {
    $mysqli = {};
    // console.log("addShippingDetails"+JSON.stringify(req.body));
    strQuery = mysqli.mysqli($mysqli, "cnx247");
    //    'insert into shipping (first_name,last_name,email,phone,address,country,state,city,zipcode,user_id) values (?,?,?,?,?,?,?,?,?,?)';
    var escape_string = [
        typeof(req.body.username) !== 'undefined' ? req.body.username : '',
        typeof(req.body.lname) !== 'undefined' ? req.body.lname : '',
        typeof(req.body.email) !== 'undefined' ? req.body.email : '',
        typeof(req.body.phone) !== 'undefined' ? req.body.phone : '',
        typeof(req.body.shipping_address) !== 'undefined' ? req.body.shipping_address : '',
        typeof(req.body.shipping_country) !== 'undefined' ? req.body.shipping_country : '',
        typeof(req.body.shipping_state) !== 'undefined' ? req.body.shipping_state : '',
        typeof(req.body.shipping_state_abbr) !== 'undefined' ? req.body.shipping_state_abbr : '',
        typeof(req.body.shipping_city) !== 'undefined' ? req.body.shipping_city : '',
        typeof(req.body.shipping_region) !== 'undefined' ? req.body.shipping_region : '',
        typeof(req.body.shipping_zip) !== 'undefined' ? req.body.shipping_zip : '',
        typeof(req.body.from_hour) !== 'undefined' ? req.body.from_hour : '0',
        typeof(req.body.to_hour) !== 'undefined' ? req.body.to_hour : '1439',
        userId,
        ''
    ];
    var defered = q.defer();

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("add shipping detials" + query.sql);
    query.on('error', function(err) {
        console.log('add shipping detials err ', err);
        throw err;
    });
    
    return defered.promise;
}

exports.updateShippingDetails = function(mysql, req, res, userId) {
    $mysqli = {};
    // console.log("addShippingDetails"+JSON.stringify(req.body));
    strQuery = mysqli.mysqli($mysqli, "update_cnx247");
    // 'insert into shipping (first_name,last_name,email,phone,address,country,state,city,zipcode,user_id) values (?,?,?,?,?,?,?,?,?,?)';
    var escape_string = [
        typeof(req.body.username) !== 'undefined' ? req.body.username : '',
        typeof(req.body.lname) !== 'undefined' ? req.body.lname : '',
        typeof(req.body.email) !== 'undefined' ? req.body.email : '',
        typeof(req.body.phone) !== 'undefined' ? req.body.phone : '',
        typeof(req.body.shipping_address) !== 'undefined' ? req.body.shipping_address : '',
        typeof(req.body.shipping_country) !== 'undefined' ? req.body.shipping_country : '',
        typeof(req.body.shipping_state) !== 'undefined' ? req.body.shipping_state : '',
        typeof(req.body.shipping_state_abbr) !== 'undefined' ? req.body.shipping_state_abbr : '',
        typeof(req.body.shipping_city) !== 'undefined' ? req.body.shipping_city : '',
        typeof(req.body.shipping_region) !== 'undefined' ? req.body.shipping_region : '',
        typeof(req.body.shipping_zip) !== 'undefined' ? req.body.shipping_zip : '',
        typeof(req.body.from_hour) !== 'undefined' ? req.body.from_hour : '0',
        typeof(req.body.to_hour) !== 'undefined' ? req.body.to_hour : '1439',
        userId
    ];
    var defered = q.defer();

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("add shipping detials" + query.sql);
    query.on('error', function(err) {
        throw err;
    });
    
    return defered.promise;
}

exports.addBankDetails = function(mysql, req, res, userId) {
    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, "add_bank_details");
    //'insert into bank_details (name, bank_name, account_number, account_type, address, country, state, city ,userid, created_at) values (?,?,?,?,?,?,?,?,?,?)';
    var escape_string = [
        req.body.account_name, 
        req.body.bank_name, 
        req.body.account_number, 
        req.body.account_type, 
        req.body.routing_number, 
        req.body.billing_address, 
        req.body.billing_country, 
        req.body.billing_state, 
        req.body.billing_city, 
        req.body.billing_zip, 
        datge,        
        userId
    ];

    console.log(escape_string);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("add bank details" + query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.mobileSave = function(mysql, req, res) {
    var self = this;
    q.all([self.dosave(mysql, req)]).then(function(results) {

        result = results[0][0];


        customerio = require('./customerio');
        customerio.uid = result.insertId;
        //referral update

        var activeurl = '<br />To activate your account.Please <a href="' + $arr.config.spath + 'activate/' + result.insertId + '">click here</a>';
        console.log(1);
        email = require('./email');
        localm = require('./localmail');


        q.all([localm.mailtemps(req, config.mysql, q, 'register')]).then(function(results2) {

            if (results2) {

                var template = results2[0][0][0].template;
                var subject_message = results2[0][0][0].subject;

                template = template.replace('{{event.sitename}}', "Auction Software.com");
                template = template.replace('{{event.activeurl}}', activeurl);
                template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);
                var carApi = require('../module/forwardapi');
                carApi.sendMailMailgun(template, subject_message, req.body.email);
            } else {

                console.log("No Tempales named register");
            }
        });


        var msg = "Registered Successfull. Please activate the email.";
        var status = "1";
        res.send({ 'status': status, 'msg': msg });
        res.end();
        return false;
    });
}

exports.checkUsername = function(mysql, req) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'check_username');


    var escape_string = [req.body.username];
    var defered = q.defer();

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());

    return defered.promise;
}
exports.checkNickName = function(mysql, req) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'video1');


    var escape_string = [req.body.nick_name];
    var defered = q.defer();

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());

    return defered.promise;
}
exports.show = function(mysql, callback) {
    var row = [];
    callback(row);
}
exports.loadPage = function(req, res, $arr, config) {
    //console.log(req.param('id'));
    if (typeof(req.param('id')) != 'undefined')
        $arr.r_id = req.param('id');
    $arr.register_fail = true;
    $arr.register_error = req.param('error');
    $arr.externaljs = ['register'];
    Recaptcha = require('recaptcha').Recaptcha;

    var PUBLIC_KEY = config.captachapublickey,
        PRIVATE_KEY = config.captachaprivatekey;
    console.log(PUBLIC_KEY + '&&' + PRIVATE_KEY);
    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();



    function processIndex(row) {
        common.tplFile('index.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
    this.show(config.mysql, processIndex);
}


exports.saveUser = function(req, mysql, q) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var md5 = require('MD5');
    var password_salt = '12345'
    var password = md5(md5(req.body.password) + password_salt);
    strQuery = mysqli.mysqli($mysqli, 'registerUser');
    var defered = q.defer();
    escape_data = [
        req.body.cg_email,
        'test',
        password,
        password_salt,
        req.body.cg_name,
        req.body.cg_city,
        req.body.cg_state,
        req.body.cg_zip,
        req.body.cg_country,
        req.body.cg_state,
        req.body.cg_ssn,
        req.body.cg_bdate,
        req.body.cg_licence_data,
        "",
        "",
        datge,
        datge
    ];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });

    console.log(query.sql);
    return defered.promise;
}

exports.loadRegisterPage = function(req, res, $arr, config) {
    //console.log(req.param('id'));
    if (typeof(req.param('id')) != 'undefined')
        $arr.r_id = req.param('id');
        $arr.register_fail = '';
        $arr.register_error = req.param('error');


    // Recaptcha = require('recaptcha').Recaptcha;
    //    var PUBLIC_KEY  = config.captachapublickey,
    //        PRIVATE_KEY = config.captachaprivatekey;
    //        console.log(PUBLIC_KEY+'&&'+PRIVATE_KEY);
    // var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    // $arr.captchahtml = recaptcha.toHTML();
    // console.log($arr);
    function processIndex(row) {
        common.tplFile('register.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
    this.show(config.mysql, processIndex);
}
exports.checkemail = function(mysql, req) {
    $mysqli = {
        email: req.body.cg_email
    };
    strQuery = mysqli.mysqli($mysqli, 'checkEmail');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
console.log("ggggghhhhhhhhhhhhhh ")
console.log(query.sql)
    return defered.promise;
}
exports.save = function(mysql, req, res) {
    var self = this;

    // console.log("registration data : " + JSON.stringify(req.body));

    // q.all([self.dosave(mysql, req)]).then(function(results) {

    //added By Mohit
    async.series([function(callback) {
            faAPI.registerUser(req, callback)
        }],
        // optional callback
        function(err, results) {


            if (err) {
                throw err;
            }

            // result = results[0][0];
            result = results[0];
            console.log(result);

            console.log("results from module\/register" + JSON.stringify(results));

            var attach = require('../module/attach');
            attach.save('business', req, res);

            //adding shipping detials
            // q.all([self.addContacts(config.mysql, req, res, result.insertId), self.addShippingDetails(config.mysql, req, res, result.insertId), self.addBusinessDetails(config.mysql, req, res, result.insertId)]).then(function(result1) {
            q.all([self.addContacts(config.mysql, req, res, result.userId), self.addShippingDetails(config.mysql, req, res, result.insertId), self.addBusinessDetails(config.mysql, req, res, result.userId)]).then(function(result1) {

                // console.log(result1);

                if (req.body.billing_type == "bank") {
                    q.all([self.addBankDetails(config.mysql, req, res, result.userId)]).then(function(result) {
                        console.log("bank details added");
                    }).fail(function(err) {
                        console.log(err.stack);
                        throw err;
                    });
                }

            }).fail(function(err) {
                console.log(err.stack);
                throw err;
            });


            if (req.body.referals != 0 && typeof(req.body.referals) != 'undefined' && req.body.medias != '' && result.userId > 0) {

                req.body.to_id = result.userId;
                self.referral(config.mysql, req, res);

            }


            customerio = require('./customerio');
            customerio.uid = result.userId;
            //referral update

            var activeurl = '<br />To activate your account.Please <a href="' + $arr.config.spath + 'activate/' + result.userId + '">click here</a>';
            console.log(1);
            email = require('./email');
            localm = require('./localmail');

            if (global.emailcio.status == 'yes') {
                email.sendEmail('Register Forward', req.body, { siteurl: config.url, user: req.body.first_name + ' ' + req.body.last_name, activeurl: activeurl });
            }
            /*req.session.userid = result.insertId;
            req.session.email = req.body.email;
            req.session.first_name = req.body.first_name;
            req.session.last_name = req.body.last_name;*/
            else if (global.emaillocal.status == 'yes') {
                q.all([localm.mailtemps(req, config.mysql, q, 'register')]).then(function(results2) {

                    if (results2) {

                        var template = results2[0][0][0].template;
                        var subject_message = results2[0][0][0].subject;

                        template = template.replace('{{event.sitename}}', "Auction Software.com");
                        template = template.replace('{{event.activeurl}}', activeurl);
                        template = template.replace('{{event.user}}', req.body.username);
                        // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                        localm.sendmail(template, subject_message, req.body.email);

                    } else {

                        console.log("No Templates named register");
                    }


                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                });

            } else { console.log('No Mail Delivery method is selected'); }

            if (typeof(req.body.fid) !== 'undefined') {
                self.updateFid(mysql, req, res, result.userId);
            }
            if (typeof(req.body.lid) !== 'undefined') {
                self.updateLid(mysql, req, res, result.userId);
            }
            console.log(2);

            // $arr.userData.reg_user_id = result.insertId;
            // $arr.fname = typeof(req.body.username) == 'undefined' ? '' : req.body.username;
            // $arr.lname = typeof(req.body.lname) == 'undefined' ? '' : req.body.lname;
            // $arr.email = typeof(req.body.email) == 'undefined' ? '' : req.body.email;
            // $arr.phone = typeof(req.body.phone) == 'undefined' ? '' : req.body.phone;

            res.writeHead(302, {
                // 'Location': '/register/error/Email has been dispatch to you mail id'
                'Location': '/login/?error=3'
                    //add other headers here...
            });
            res.end();
            return false;

        });
    // }).fail(function(err) {
    //     console.log(err.stack);
    //     throw err;
    // });
}
exports.random = function(high, low) {

    return Math.random() * (high - low) + low;

}
exports.updateFid = function(mysql, req, res, uid) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 87);

    var defered = q.defer();
    escape_data = [req.body.fid, req.body.fid_json, uid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.addContacts = function(mysql, req, res, uid) {

    console.log(req.body.contacts);
    var contacts = req.body.contacts;
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var contactsString = "";
    for (var i = 0; i < contacts.length; i++) {
        // contacts[i].user_id = uid;

        if (i > 0) {
            contactsString = contactsString + ", (\"" + contacts[i].fname + "\", \"" + contacts[i].lname + "\", \"" + contacts[i].phone + "\", \"" + contacts[i].email + "\", \"" + datge + "\", 0, \"" + uid + "\" )";
        } else {
            contactsString = contactsString + "(\"" + contacts[i].fname + "\", \"" + contacts[i].lname + "\", \"" + contacts[i].phone + "\", \"" + contacts[i].email + "\", \"" + datge + "\", 0, \"" + uid + "\" )";
        }

    }

    $mysqli = {
        contactsData: contactsString
    };

    strQuery = mysqli.mysqli($mysqli, "add_contacts");

    var defered = q.defer();
    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}


exports.checkfid = function(mysql, req) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 88);

    var defered = q.defer();
    escape_data = [req.body.fid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.updateLid = function(mysql, req, res, uid) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 89);

    var defered = q.defer();
    escape_data = [req.body.lid, req.body.lid_json, uid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.checklid = function(mysql, req) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 90);

    var defered = q.defer();
    escape_data = [req.body.lid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.dosave = function(mysql, data) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var md5 = require('MD5');
    var password_salt = '12345'
    var password = md5(md5(data.body.password) + password_salt);
    //console.log(data.body);
    // console.log("from dosave method : "+JSON.stringify(data.body.contacts[0]));

    $mysqli = {
        first_name: (typeof(data.body.username) === 'undefined') ? '' : data.body.username,
        // last_name: (typeof(data.body.contacts[0].lname) === 'undefined') ? '' : data.body.contacts[0].lname,
        email: data.body.email,
        role: 1,
        password_hash: password,
        password_salt: password_salt,
        created_at: datge,
        // country : data.body.country,
        // state : data.body.state,
        phone: data.body.phone,
        business_name: (typeof(data.body.business_name) === 'undefined') ? '' : data.body.business_name,
        username: (typeof(data.body.username) === 'undefined') ? '' : data.body.username,
        nick_name: (typeof(data.body.username) === 'undefined') ? '' : data.body.username
    };

    strQuery = mysqli.mysqli($mysqli, 11);

    var defered = q.defer();
    escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });

    console.log(query.sql);
    return defered.promise;
}

exports.referral = function(mysql, req, res) {
    $mysqli = {};
    var bonus = global.general.referral_bonus;
    var from_ref = req.body.referals;
    from_ref=from_ref.replace( /^\D+/g, ''); ;
    var to_ref = req.body.to_id;
    var meds =  (typeof(req.session.media) === 'undefined') ? "Direct" :req.session.media;
    if (meds == 'fb') { meds = 'Facebook' }
    if (meds == 'twi') { meds = 'Twitter' }
    if (meds == 'in') { meds = 'Linked In' }
    if (meds == 'pin') { meds = 'Pinterest' }
    if (meds == 'mail') { meds = 'EMail' }
    if (meds == 'share') { meds = 'Share This' }
    strQuery = mysqli.mysqli($mysqli, 104);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss")
    escape_data = [from_ref, to_ref, datge, meds, bonus, 0];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //self.addbalance(mysql,data,from_ref);
    return defered.promise;
}

exports.addbalance = function(mysql, req, from_ref) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 28);
    var defered = q.defer();
    escape_data = [config.referral_bonus, from_ref];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

/* ===================== start change by divyesh (added) ===================== */
exports.addSalesSupportDetail = function(mysql, req, res, userId) {
    $mysqli = {};
    // console.log("addShippingDetails"+JSON.stringify(req.body));
    strQuery = mysqli.mysqli($mysqli, "add_sales_support");
    //    'insert into shipping (first_name,last_name,email,phone,address,country,state,city,zipcode,user_id) values (?,?,?,?,?,?,?,?,?,?)';
    console.log('req.files.cagreement', req.files.cagreement);
    var escape_string = [
        userId,
        typeof(req.body.helpgrow) !== 'undefined' ? parseInt(req.body.helpgrow) : 0,
        typeof(req.body.HerbeeSalesConsultant) !== 'undefined' ? parseInt(req.body.HerbeeSalesConsultant) : 0,
        typeof(req.body.sccode) !== 'undefined' ? req.body.sccode : '',
        typeof(req.body.sc_user_id) !== 'undefined' ? parseInt(req.body.sc_user_id) : 0,
        typeof(req.body.start_date) !== 'undefined' ? req.body.start_date : '',
        typeof(req.body.end_date) !== 'undefined' ? req.body.end_date : '',
        typeof(req.body.cfee) !== 'undefined' ? parseInt(req.body.cfee) : 0,
        req.body.helpgrow.toString() === '0' && req.body.HerbeeSalesConsultant.toString() === '1' ?
        (req.files.cagreement != undefined ? req.files.cagreement.name != undefined ? req.files.cagreement.name : '' : '') : ''
    ];
    var defered = q.defer();
    console.log('escape_string', escape_string);

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("addSalesConsultantDetail " + query.sql);
    query.on('error', function(err) {
        throw err;
    });
    
    return defered.promise;
}

exports.checkSalesConsultantCodeExist = function(mysql, req, res) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, "check_sales_consultant_code_exist");
    var escape_string = [
        req.body.email,
        req.body.sccode
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("checkSalesConsultantCodeExist " + query.sql);
    query.on('error', function(err) {
        throw err;
    });
    
    return defered.promise;
}
/* ===================== end change by divyesh (added) ===================== */