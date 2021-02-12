/**
 * Created by Raj on 9/28/2015.
 */

/*============================================================================*\
 || ########################################################################## ||
 || # Auction Software Marketplace[*]version[*] Build [*]build[*]
 || # ---------------------------------------------------------------------- # ||
 || # Customer License # [*]license[*]
 || # ---------------------------------------------------------------------- # ||
 || # Copyright �2014�[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
 || # This file may not be redistributed in whole or significant part.       # ||
 || # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
 || # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
 || # ---------------------------------------------------------------------- # ||
 || ########################################################################## ||
 \*============================================================================*/

// #### load required Modules ##################################################

var express = require('express');
var common = require('../module/common');
var user = require('../module/user');
var app = express.Router();
var q = require('q');
var mysqli = require('../module/mysqli');
var adwords = require('../module/adwords');
var products = require('../module/products');

// var CronJob = require('cron').CronJob;
// var job = new CronJob({
//     cronTime: '00 00 00 * * *',
//     onTick: function() {
//         q.all(adwords.resetAdwordsDaysClick($arr.config.mysql, q)).then(function() {

//         });
//     },
//     start: false,
//     timeZone: 'America/Chicago'
// });

// job.start();

app.get(['/show_adwords', '/show_adwords/:error'], function(req, res) {
    if (common.checkLogin(req, res, 0)) {
        common.tplFile('adwords_manager.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    } else { 
        return false; 
    }

});

app.get(['/show_all_adwords/:type'], function(req, res) {
    common.checkLogin(req, res, 0);
    req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.type = (typeof(req.param('type')) !== 'undefined') ? req.param('type') : 0;
    console.log("typeeeee is " + req.body.type);
    $arr.error = (typeof(req.param('error')) != 'undefined') ? req.param('error') : 0;
    q.all([adwords.getAllAdvertiseDetails(req, $arr.config.mysql, q, 0), adwords.getAllAdvertiseDetails(req, $arr.config.mysql, q, 1)]).then(function(results) {
        var pagination = require('pagination');
        $arr['pagination'] = results[1][0].length;
        $arr['adwords_details'] = results[0][0];
        //$arr.deposit_amount = results[2][0][0].deposit_amount;

        var paginator = new pagination.SearchPaginator({ prelink: '/adwords/show_all_adwords/' + req.body.type, current: req.body.page, rowsPerPage: 12, totalResult: $arr['pagination'] });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('show_all_adwords.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function(err) {
        console.log(err.stack);
        throw err;
    }).done();

});


app.get(['/add_deposit', '/add_deposit/:strid'], function(req, res) {
    common.checkLogin(req, res, 0);
    var braintree = require("braintree");
    var braintrees = require('../module/braintrees');
    var gateway = global.bgateway;
    $arr.pkey = global.stripe.publishkey;
    $arr.vp_id = global.voguepay.merchantid;

    braintrees.generateToken(global.bgateway, templateCallback, req);

    function templateCallback(err, response) {

        creditcard = require('../module/creditcard');

        q.all([creditcard.AllMyPayments(req, $arr.config.mysql, q)]).then(function(results) {
            $arr.creditCards = results[0][0];
            gateway.clientToken.generate({}, function(err, response) {
                //console.log('response callback');
                $arr.storeid = (typeof(req.param('strid')) !== 'undefined') ? req.param('strid') : 0;
                $arr.clientToken = response.clientToken;
                console.log($arr.clientToken);
                common.tplFile('add_deposit.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });

        }).fail(function(err) {
            console.log(err.stack);
            throw err;
        }).done();
    }

});

// app.get('/update_user_click/:id/:userid/:budget_per_click', function(req, res) {
//     common.checkLogin(req, res, 0);
//     var cmn = require('../module/common');
//     req.body.id = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : 0;
//     req.session.ad_clicked = req.body.id;
//     req.body.userid = (typeof(req.param('userid')) !== 'userid') ? req.param('userid') : 0;
//     req.body.budget_per_click = (typeof(req.param('userid')) !== 'budget_per_click') ? req.param('budget_per_click') : 0;
//     if(req.body.userid != req.session.userid){
//         q.all([adwords.update_deposit_onclick(req, $arr.config.mysql, q), adwords.get_ads_track(req, $arr.config.mysql, q)]).then(function(result) {
//         req.body.tid = 0;
//         if (result[1][0].length > 0) {
//             req.body.tid = result[1][0][0].id;
//         }
//         q.all([adwords.update_deposit_onclick_day(req, $arr.config.mysql, q)]).then(function(result) {
//             var data = { success: true, error: '', redirect: true };
//             cmn.renderJson(res, data);
//         });
//             req.session.ads_id = req.body.id;
//         }).fail(function(err) {
//             console.log(err.stack);
//             throw err;
//         }).done();

//     } else {
//         var data = { success: true, error: 'own store or product', redirect: true };
//             cmn.renderJson(res, data);
//     }


// });

app.get('/update_user_click/:id', function(req, res) {

    console.log('update_user_click called.....');
    if (common.checkLogin(req, res, 0)) {
        var cmn = require('../module/common');
        var data = { success: true, error: '', redirect: false, red_url: '' };
        req.body.id = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : 0;
        req.session.ad_clicked = req.body.id;

        q.all([adwords.getAdwordsById(req, $arr.config.mysql, q)]).then(function(adword) {
            // console.log(JSON.stringify(adword));

            if (adword[0][0].length > 0) {
                req.body.userid = (typeof(adword[0][0][0].user_id) != 'undefined') ? adword[0][0][0].user_id : 0;
                req.body.budget_per_click = (typeof(adword[0][0][0].budget_per_click) != 'undefined') ? adword[0][0][0].budget_per_click : 0;
                console.log("----------------------" + req.body.userid)
                console.log("----------------------" + req.body.budget_per_click)
                if (req.body.userid != req.session.userid) {

                    q.all([adwords.get_ads_track(req, $arr.config.mysql, q)]).then(function(updateAdTrqck) {
                        req.body.tid = 0;
                        if (updateAdTrqck[0][0].length > 0) {
                                    req.body.tid = updateAdTrqck[0][0][0].id;
                            }
                            q.all([adwords.update_deposit_onclick_day(req, $arr.config.mysql, q),adwords.update_deposit_onclick(req, $arr.config.mysql, q)]).then(function(result) {
                                // var data = { success: true, error: '', redirect: true };
                                data.redirect = false;
                                data.red_url = adword[0][0][0].ad_url;
                                cmn.renderJson(res, data);
                                res.end();
                            }).fail(function(err) {
                                console.log(err.stack);
                                throw err;
                            }).done();
                            req.session.ads_id = req.body.id;
                        
                    }).fail(function(err) {
                        console.log(err.stack);
                        throw err;
                    }).done();

                } else {
                    // var data = { success: true, error: 'own store or product', redirect: true };
                    if(adword[0][0][0].type == 'product'){
                        data.error = 'Own Product';    
                    } else {
                        data.error = 'Own Store';    
                    }
                    
                    data.redirect = false;
                    data.red_url = adword[0][0][0].ad_url;
                    cmn.renderJson(res, data);
                    res.end();
                }

            } else {
                console.log("-----------------error--------data----not available----"+req.body.id);

                    data.success = false,
                    data.error = 'No data'
                    cmn.renderJson(res, data);
                    res.end();
            }

        }).fail(function(err) {
            console.log(err.stack);
            throw err;
        }).done();




    }

});


app.get(['/edit_adwords/:type/:id', '/edit_adwords/:type/:id/;strid'], function(req, res) {
    common.checkLogin(req, res, 0);
    req.body.type = (typeof(req.param('type')) !== 'undefined') ? req.param('type') : 0;
    req.body.id = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : 0;
    var strid = (typeof(req.param('strid')) !== 'undefined') ? req.param('strid') : '';
    q.all([adwords.adwords_op(req, $arr.config.mysql, q)]).then(function(result) {
        //console.log(result);
        if (Number(strid) > 0) {
            var link = '/stores/current_campaigns/' + strid + '';
        } else if (Number(strid) == 0) {
            var link = '/stores/current_campaigns';
        } else {
            var link = '/stores/current_campaigns';
        }
        res.writeHead(302, {
            'Location': '' + link + ''
        });
        res.end();
        return false;
    }).fail(function(err) {
        console.log(err.stack);
        throw err;
    }).done();


});

app.get(['/add_adwords', '/add_adwords/:strid', '/create_adwords/:error'], function(req, res) {
    common.checkLogin(req, res, 0);
    $arr.error = (typeof(req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr.storeid = (typeof(req.param('strid')) !== 'undefined') ? req.param('strid') : 0;
    common.tplFile('add_adwards.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});

app.get(['/edit/:id', '/edit/:id/:strid'], function(req, res) {
    if (common.checkLogin(req, res, 0)) {
        req.body.id = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : 0;
        var dateFormat = require('dateformat');
        var product = require('../module/products');
        q.all([
            adwords.getAdwordsById(req, config.mysql, q),
            product.myproducts(req, $arr.config.mysql, q, 1),
            product.myproductsbrand(req, $arr.config.mysql, q, 1),
            adwords.selectstoreads(req, $arr.config.mysql, q, req.session.storeid)
        ]).then(function(results) {

            if (results[3][0].length > 0) {
                $arr['alreadyads'] = 1;
                $arr['alreadyadid'] = results[3][0][0].id;
                $arr['alreadyadsid'] = results[3][0][0].store_id;
            } else {
                $arr['alreadyads'] = 0;
            }

            $arr.prod_list = results[1][0];
            $arr.brand_list = results[2][0];
            $arr.adwords_details = results[0][0][0];
            if ($arr.adwords_details.end_date != '' && $arr.adwords_details.end_date != '0000-00-00') {
                $arr.adwords_details.end_date = dateFormat($arr.adwords_details.end_date, 'dd/mm/yyyy')
            } else {
                $arr.adwords_details.end_date = '';
            }
            if ($arr.adwords_details.start_day != '' && $arr.adwords_details.start_day != '0000-00-00') {
                $arr.adwords_details.start_day = dateFormat($arr.adwords_details.start_day, 'dd/mm/yyyy')
            } else {
                $arr.adwords_details.start_day = '';
            }
            $arr.storeid = (typeof(req.param('strid')) !== 'undefined') ? req.param('strid') : 0;

            // console.log(results[0][0][0].type);
            // console.log("type");
            if (results[0][0][0].type == 'store') {
                $arr.adsmenu = { store: 'active' };

                common.tplFile('store/ads_store_edit.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            }
            if (results[0][0][0].type == 'product') {
                console.log("type1");
                common.tplFile('store/ads_pdt_edit.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            }
            if (results[0][0][0].type == 'product' && results[0][0][0].brand_name != '') {
                console.log("type2");
                common.tplFile('store/ads_edit_brand.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            }
            if (results[0][0][0].type == 'supplier') {
                $arr.adsmenu = { store: 'active' };
                console.log("type3");
                common.tplFile('store/ads_store_edit.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            }
        }).fail(function(err) {
            console.log(err.stack);
            throw err;
        }).done();

    }

});

app.post('/save', function(req, res) {
    console.log('req.body', req.body);

    if (common.checkLogin(req, res, 0)) {
        var faAPI = require('../module/forwardauction_api');

        var fieldNames = 'email,first_name,last_name,username,id,balance,phone';
        var whereCondition = ' where id = ' + req.session.userid;
        var per_day_amt = parseFloat(req.body.per_day_amount) > 0 ? req.body.per_day_amount : 0;
        if (req.body.per_day_amount > -1) {
            var userDataCallback = function(err, response) {
                if (err) {
                    console.log(err);
                }
                console.log(response);
                sessionuser = response.results[0];
                var strid = ((typeof(req.body.storeid)) !== 'undefined') ? req.body.storeid : '';
                if (parseInt(req.body.id) > 0) {
                    q.all([adwords.updateAdwords(req, config.mysql, q)]).then(function(result) {
                        if (Number(strid) > 0) {
                            var link = '/stores/current_campaigns/' + strid + '';
                        } else {
                            var link = '/adwords/current_campaigns/Adwords details updated successfully';
                        }
                        res.writeHead(302, {
                            'Location': '' + link + ''
                        });
                        res.end();
                        return false;
                    }).fail(function(err) {
                        console.log(err.stack);
                        throw err;
                    }).done();
                } else {
                    console.log(parseFloat(sessionuser.balance));
                    d1 = common.changeDateFormat2(req.body.start_date);
                    d2 = common.changeDateFormat2(req.body.end_date);
                    console.log(d1 + " ------- " + d2);
                    var date1 = new Date(d1);
                    var date2 = new Date(d2);
                    var timeDiff = Math.abs(date2.getTime() - date1.getTime());
                    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
                    diffDays = diffDays + 1;
                    console.log("differece daysa ---- " + diffDays);
                    var total_click = parseFloat(diffDays) * parseFloat(req.body.total_click);
                    req.body.total_clicks = total_click;
                    var total_amt = 0;
                    if(req.body.per_day_amount > 0) {
                        total_amt = parseFloat(diffDays) * parseFloat(req.body.per_day_amount);
                    }
                    req.body.totalamount = total_amt;
                    console.log("clickamount ---------------- " + global.ads.clickamount);
                    console.log("total_amount ------------ " + total_amt);
                    if (parseFloat(sessionuser.balance) >= parseFloat(total_amt)) {
                        q.all([adwords.saveAdwords(req, config.mysql, q)]).then(function(result) {

                            payments = require('../module/payment');
                            payments.transactionid = 0;
                            payments.gateway = 'account';
                            payments.sessionsdata = [];
                            payments.sessionsdata.title = 'ads';
                            payments.sessionsdata.email = sessionuser.email;
                            payments.sessionsdata.url = $arr.config.url + '/stores/current_campaigns/'
                            payments.sessionsdata.userid = req.session.userid;
                            payments.sessionsdata.first_name = sessionuser.first_name;
                            payments.sessionsdata.last_name = sessionuser.last_name;
                            req.body.commission = 0;
                            payments.payid = result[0][0].insertId;
                            payments.type = 'ad_payment';
                            payments.name = 'ads';
                            payments.buynow_id = '0';
                            payments.cart_id = '0';
                            payments.amount = total_amt;
                            payments.buyer = { id: req.session.userid };
                            payments.seller = { id: '1' };
                            payments.qty = 0;

                            q.all([payments.insertInvoice(req)]).then(function(invoice) {

                                req.body.invoice_id = invoice[0][0].insertId;

                                q.all([
                                    products.generateInvoiceID(req, req.body.invoice_id, config.mysql, q),
                                    cart.paidBid(req, config.mysql, q, req.body.invoice_id, 'account')
                                ]).then(function(resul) {
                                    console.log('results here', resul);
                                }).fail(function(err) {
                                    console.log(err.stack);
                                    throw err;
                                }).done();

                                req.body.buyer = {
                                    balance: parseFloat(req.body.currentbalance) - parseFloat(total_amt),
                                    id: req.session.userid
                                };

                                faAPI.updateUser(req, 'ad_spend', function(err, resp) {

                                    if (Number(strid) > 0) {
                                        var link = '/stores/current_campaigns/' + strid + '';
                                    } else {
                                        var link = '/adwords/current_campaigns/Adwords details added successfully';
                                    }

                                    res.writeHead(302, {
                                        'Location': '' + link + ''
                                    });
                                    res.end();
                                    return false;
                                });

                                console.log(invoice);
                                console.log(invoice[0][0].insertId);

                            }).fail(function(err) {
                                console.log(err.stack);
                                throw err;
                            }).done();


                        }).fail(function(err) {
                            console.log(err.stack);
                            throw err;
                        }).done();

                    } else {

                        console.log("rrrrrrrrr")
                        res.writeHead(302, {
                            'Location': req.body.returnurls + '?blserr=1'
                        });

                        res.end();
                        return false;
                    }
                }
            }

            faAPI.callUserQuery('no_type', fieldNames, whereCondition, userDataCallback);
        } else {
            console.log("rrrrrrrrr")
            res.writeHead(302, {
                'Location': req.body.returnurls + '?error=Please enter the amount multiple of per day amount'
            });

            res.end();
            return false;
        }
    }

});

app.post('/pay', function(req, res) {
    var checksid = (typeof(req.body.storeid) != 'undefined') ? '/' + req.body.storeid : '';
    console.log(checksid);
    if (typeof(req.body.paymentMethodNonceInputField) === 'undefined' || req.body.paymentMethodNonceInputField == '') {

        req.body.paymentMethodNonceInputField = req.body.payment_method_nonce;

    }

    if (typeof(req.body.payment_method_nonce) === 'undefined' || req.body.payment_method_nonce == '') {

        req.body.payment_method_nonce = req.body.paymentMethodNonceInputField;

    }


    if (req.param('savecard') == 1 || req.param('savepaypal') == 1) {

        var braintrees = require('../module/braintrees');

        global.bgateway.mysql = $arr.config.mysql;

        braintrees.saveCreditCard(global.bgateway, req, res, payProcess);

    } else if (req.param('paymentmethod') == 'cc' || req.param('paymentmethod') == 'paypal') {

        payProcess(1, '');

    } else {

        creditcard = require('../module/creditcard');

        q.all([creditcard.PickPayments(req, $arr.config.mysql, q, req.param('paymentmethod'))]).then(function(resu) {


            if (resu[0][0][0].user_id == req.session.userid) {

                req.body.token = resu[0][0][0].token_id;

                payProcess(1, '');

            } else {

                res.writeHead(302, {

                    'Location': '/membership/setup/Invalid Card'

                });

                res.end();
                return false;

            }


        });

    }


    function payProcess(err, resp) {

        if (err == 0) {

            res.writeHead(302, {

                'Location': '/membership/setup/' + resp

            });

            res.end();

            return false;

        }

        var price = req.body.amount;
        var price2 = price;

        price = (price / req.session.currencyrate).toFixed(2)

        if (req.param('savecard') == 1) {

            var pay = {

                amount: price,

                paymentMethodToken: resp.creditCard.token,

                options: {

                    submitForSettlement: true

                }
            };

        } else if (req.param('savepaypal') == 1) {

            var pay = {

                amount: price,

                paymentMethodToken: resp.paypalAccount.token,

                options: {

                    submitForSettlement: true

                }
            };

        } else if (typeof(req.body.token) !== 'undefined') {

            var pay = {

                amount: price,

                paymentMethodToken: req.body.token,

                options: {

                    submitForSettlement: true

                }
            };

        } else {

            var pay = {

                amount: price,

                paymentMethodNonce: req.param('paymentMethodNonceInputField'),

                options: {


                    submitForSettlement: true

                }
            };

        }

        console.log("Pay is " + JSON.stringify(pay));

        var ml = global.bgateway.transaction.sale(pay, function(err, result) {

            if (result.success) {

                if (result.transaction.status) {
                    payments = require('../module/payment');
                    var dateFormat = require('dateformat');
                    var data = [];
                    data.status = 'active';
                    data.paid_date = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
                    data.paid = 1;


                    payments.transactionid = result.transaction.id;
                    payments.gateway = 'braintree';
                    payments.sessionsdata = [];
                    payments.sessionsdata.title = data.name + ' Deposit';
                    payments.sessionsdata.email = req.session.email;
                    payments.sessionsdata.phone = req.session.phone;
                    payments.sessionsdata.url = '';
                    payments.sessionsdata.userid = req.session.userid;
                    payments.sessionsdata.first_name = req.session.first_name;
                    payments.sessionsdata.last_name = req.session.last_name;
                    payments.payid = 1;
                    payments.type = 'Deposit Fee';
                    payments.name = ' Deposit';
                    payments.amount = price2;
                    //console.log(payments);
                    //user.reduceBalance(req,config.mysql,q,payments.sessionsdata.userid,payments.amount);
                    payments.insertInvoice(req);

                    req.body.transactionid = result.transaction.id;
                    q.all([adwords.update_deposit(req, config.mysql, q)]).then(function(result) {
                        res.writeHead(302, {

                            'Location': '/adwords/add_adwords' + checksid + ''

                        });

                        res.end();
                        return false;
                    }).fail(function(err) {
                        console.log(err.stack);
                        throw err;
                    }).done();

                } else {

                    $arr['error'] = result.transaction.processorResponseText;
                    console.log($arr['error']);
                    res.writeHead(302, {

                        'Location': '/adwords/add_adwords/' + $arr['error']

                    });

                    res.end();
                    return false;

                }

            } else {

                $arr['error'] = '';


                $arr['error'] += result.message;
                console.log($arr['error']);

                res.writeHead(302, {
                    'Location': '/adwords/add_adwords/' + $arr['error']
                });

                res.end();

                return false;

            }

        });



    }


});
app.get(['/edit_adwordsadmin/:type/:id', '/edit_adwords/:type/:id/;strid'], function(req, res) {
    common.checkLogin(req, res, 0);
    req.body.type = (typeof(req.param('type')) !== 'undefined') ? req.param('type') : 0;
    req.body.id = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : 0;
    var strid = (typeof(req.param('strid')) !== 'undefined') ? req.param('strid') : '';
    q.all([adwords.adwords_op2(req, $arr.config.mysql, q)]).then(function(result) {
        var arow = result[0][0].affectedRows;
        if (arow > 0) {
            res.send(JSON.stringify({ 'success': 1 }));
        } else {
            res.send(JSON.stringify({ 'success': 0 }));
        }
        res.end();
        return false;
    });


});
module.exports = app;