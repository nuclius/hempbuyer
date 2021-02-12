/*============================================================================*\
 || ########################################################################## ||
 || # Auction Software Marketplace[*]version[*] Build [*]build[*]
 || # ---------------------------------------------------------------------- # ||
 || # Customer License # [*]license[*]
 || # ---------------------------------------------------------------------- # ||
 || # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
 || # This file may not be redistributed in whole or significant part.       # ||
 || # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
 || # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
 || # ---------------------------------------------------------------------- # ||
 || ########################################################################## ||
 \*============================================================================*/

// #### load required Modules ##################################################

var express = require('express');
var common = require('../module/common');
var app = express.Router();
var zip = require('express-zip');
var q = require('q');
var sprintf = require('sprintf').sprintf;
var mysqli = require('../module/mysqli');
var dashboard = require('../module/dashboard');
var cryptos = require('../module/crypto.js');
var adwords = require('../module/adwords');
var async = require('async');
var _ = require('underscore');
var faAPI = require('../module/forwardauction_api');
var openBidProducts = require('../module/openbidproducts');
var products = require('../module/products');
var request = require('request');
//required js
app.use(function (req, res, next) {

    if (common.checkLogin(req, res, 0)) {
        products = require('../module/products');
        next();
    } else {
        return false;
    }

});

app.get('/deposit', function (req, res) {
    var braintrees = require('../module/braintrees');
    var user = require('../module/user');

    braintrees.generateToken(global.bgateway, templateCallback, req);

    function templateCallback(err, response) {

        creditcard = require('../module/creditcard');

        q.all([creditcard.AllMyPayments(req, $arr.config.mysql, q), user.userInfo(req, $arr.config.mysql, q, 0, ['balance_amount', 'balance'])]).then(function (results) {

            $arr.creditCards = results[0][0];
            $arr.users = results[1][0][0];

            //console.log('response callback');

            $arr.clientToken = response.clientToken;

            common.tplFile('add_site_deposit.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    }

});
app.post('/deposit/pay', function (req, res) {
    if (typeof (req.body.paymentMethodNonceInputField) === 'undefined' || req.body.paymentMethodNonceInputField == '') {

        req.body.paymentMethodNonceInputField = req.body.payment_method_nonce;

    }

    if (typeof (req.body.payment_method_nonce) === 'undefined' || req.body.payment_method_nonce == '') {

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

        q.all([creditcard.PickPayments(req, $arr.config.mysql, q, req.param('paymentmethod'))]).then(function (resu) {


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

        } else if (typeof (req.body.token) !== 'undefined') {

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

        var ml = global.bgateway.transaction.sale(pay, function (err, result) {

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
                    payments.amount = price;
                    //console.log(payments);
                    //user.reduceBalance(req,config.mysql,q,payments.sessionsdata.userid,payments.amount);
                    payments.insertInvoice(req);

                    req.body.transactionid = result.transaction.id;
                    q.all([payments.update_deposit(req, config.mysql, q)]).then(function (result) {
                        res.writeHead(302, {

                            'Location': '/dashboard/deposit'

                        });

                        res.end();
                        return false;
                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    }).done();

                } else {

                    $arr['error'] = result.transaction.processorResponseText;
                    console.log($arr['error']);
                    res.writeHead(302, {

                        'Location': '/dashboard/deposit/' + $arr['error']

                    });

                    res.end();
                    return false;

                }

            } else {

                $arr['error'] = '';


                $arr['error'] += result.message;
                console.log($arr['error']);

                res.writeHead(302, {
                    'Location': '/dashboard/deposit/' + $arr['error']
                });

                res.end();

                return false;

            }

        });



    }


});
app.post('/cc', function (req, res, callback) {

    var braintrees = require('../module/braintrees');
    global.bgateway.mysql = $arr.config.mysql;
    braintrees.saveCreditCard(global.bgateway, req, res, refreshCallback);

    function refreshCallback(err, resp) {
        if (typeof (resp.creditCard) === 'undefined') {
            page = 'paypal';
            msg = 'paypal account details updated successfully';
        } else {
            page = 'cc';
            msg = 'Card details has been updated successfully';
        }

        if (err == 0) {
            console.log("Saved creditcard Save " + JSON.stringify(err));
            res.writeHead(302, { 'Location': '/dashboard/payment/cc/Invalid card details' });
            res.end();
            return false;
            // return false;
        } else {
            res.writeHead(302, { 'Location': '/dashboard/payment/' + page + '/' + msg });
            res.end();
            return false;
            // return false;
        }
    }
});

app.get(['/payment/saved', '/payment/saved/:error'], function (req, res) {
    creditcard = require('../module/creditcard');
    $arr.error = (typeof (req.param('error')) == 'undefined') ? '' : req.param('error');
    q.all([creditcard.AllMyPayments(req, $arr.config.mysql, q)]).then(function (results) {
        $arr.creditCards = results[0][0];
        common.tplFile('savedpayments.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/feedback'], function (req, res) {
    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 5;

    q.all([dashboard.listfeedback(req, $arr.config.mysql, q, 1), dashboard.listfeedback(req, $arr.config.mysql, q, 0), dashboard.listfeedbackrating(req, $arr.config.mysql, q)]).then(function (results) {
        $arr.feedbacks = results[0][0];
        $arr.ratings = results[2][0];
        $arr['pagination'] = results[1][0].length;

        var pagination = require('pagination');

        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/feedback',
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();

        common.tplFile('feedback_1.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });
});

app.get(['/deletesearch/:id'], function (req, res) {
    req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    q.all([products.deleteSearch(req, config.mysql, q, 1)]).then(function (results) {
        res.writeHead(302, {
            'Location': '/dashboard/searchitems'
        });
        res.end();
        return false;
    });
});

app.get(['/searchitems/', '/searchitems/:page'], function (req, res) {
    console.log('Called Search.....')
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    var products = require('../module/products');
    q.all([
        products.savedsearch(req, config.mysql, q, 1),
        products.savedsearch(req, config.mysql, q, 0)
    ]).then(function (results) {

        $arr['pagination'] = results[0][0].length;
        $arr['searchlist'] = results[1][0];
        var pagination = require('pagination');
        fquery = '';
        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/searchitems/' + fquery,
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();

        common.tplFile('searchitems.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });
});

app.get(['/market/research'], function (req, res) {
    var dateFormat = require('dateformat');
    if (common.checkLogin(req, res, 0)) {

        var allow = common.checkPermission('access_to_research_of_the_forward_market ', req);

        $arr.externalcss = ['jquery.datetimepicker'];
        $arr.externaljs = ['jquery.datetimepicker'];
        $arr['heading_common'] = "Market research";
        $arr.start_date = ((typeof (req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : req.param('start_date');
        $arr.end_date = ((typeof (req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : req.param('end_date');
        //req.body.start_date = ((typeof(req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : common.changeDateFormat(req.param('start_date'));
        //req.body.end_date = ((typeof(req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : common.changeDateFormat(req.param('end_date'));

        req.body.start_date = ((typeof (req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : dateFormat(req.param('start_date'), "yyyy-mm-dd");
        req.body.end_date = ((typeof (req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : dateFormat(req.param('end_date'), "yyyy-mm-dd");

        req.body.state = ((typeof (req.param('state')) === 'undefined') || req.param('state') == '') ? req.session.state : req.param('state');
        // console.log(req.body.start_date);
        // console.log(req.body.end_date);
        q.all([
            products.getResearchData(req, config.mysql, q, 0),
            products.getResearchData(req, config.mysql, q, 1),
            products.getResearchDataFlower(req, config.mysql, q, 0),
            products.getResearchDataFlower(req, config.mysql, q, 1),
            products.getAdminMarketActivity(req, config.mysql, q, '')
        ]).then(function (results) {
            // console.log(JSON.stringify(results));
            $arr.re_data = results[0][0][0];
            $arr.re_data_user = results[1][0][0];
            $arr.re_flower = results[2][0][0];
            $arr.re_flower_user = results[3][0][0];

            // $arr.market_activity = results[4][0];

            // var market_activity = results[4][0];

            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, { page: '' });

            $arr['search'] = query;

            // $arr.days = [{day:1},{day:2},{day:3},{day:4},{day:5},{day:6},{day:7}];
            var days = _.pluck(results[4][0], 'day_date');
            // _.pluck(stooges, 'name');
            console.log("step1")
            var avg_qty = _.pluck(results[4][0], 'avg_qty');
            console.log("step1")
            var avg_unit_price = _.pluck(results[4][0], 'avg_unit_price');
            console.log("step1")

            console.log(days);
            console.log(avg_qty);
            console.log(avg_unit_price);

            $arr.price = avg_unit_price;
            $arr.qty = avg_qty;
            $arr.days = days

            common.tplFile('market-research.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
        //}
    } else {
        return false;
    }
});

app.get(['/market/seller/research'], function (req, res) {
    var dateFormat = require('dateformat');
    if (common.checkLogin(req, res, 0)) {

        var allow = common.checkPermission('access_to_research_of_the_forward_market ', req);

        $arr.externalcss = ['jquery.datetimepicker'];
        $arr.externaljs = ['jquery.datetimepicker'];
        $arr['heading_common'] = "Market research";
        $arr.start_date = ((typeof (req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : req.param('start_date');
        $arr.end_date = ((typeof (req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : req.param('end_date');
        //req.body.start_date = ((typeof(req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : common.changeDateFormat(req.param('start_date'));
        //req.body.end_date = ((typeof(req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : common.changeDateFormat(req.param('end_date'));

        req.body.start_date = ((typeof (req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : dateFormat(req.param('start_date'), "yyyy-mm-dd");
        req.body.end_date = ((typeof (req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : dateFormat(req.param('end_date'), "yyyy-mm-dd");

        req.body.state = ((typeof (req.param('state')) === 'undefined') || req.param('state') == '') ? req.session.state : req.param('state');
        // console.log(req.body.start_date);
        // console.log(req.body.end_date);
        q.all([
            products.getResearchData(req, config.mysql, q, 0),
            products.getResearchData(req, config.mysql, q, 1),
            products.getResearchDataFlower(req, config.mysql, q, 0),
            products.getResearchDataFlower(req, config.mysql, q, 1),
            products.getAdminMarketActivity(req, config.mysql, q, '')
        ]).then(function (results) {
            // console.log(JSON.stringify(results));
            $arr.re_data = results[0][0][0];
            $arr.re_data_user = results[1][0][0];
            $arr.re_flower = results[2][0][0];
            $arr.re_flower_user = results[3][0][0];

            // $arr.market_activity = results[4][0];

            // var market_activity = results[4][0];

            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, { page: '' });

            $arr['search'] = query;

            // $arr.days = [{day:1},{day:2},{day:3},{day:4},{day:5},{day:6},{day:7}];
            var days = _.pluck(results[4][0], 'day_date');
            // _.pluck(stooges, 'name');
            console.log("step1")
            var avg_qty = _.pluck(results[4][0], 'avg_qty');
            console.log("step1")
            var avg_unit_price = _.pluck(results[4][0], 'avg_unit_price');
            console.log("step1")

            console.log(days);
            console.log(avg_qty);
            console.log(avg_unit_price);

            $arr.price = avg_unit_price;
            $arr.qty = avg_qty;
            $arr.days = days

            common.tplFile('market-research.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
        //}
    } else {
        return false;
    }
});

app.get(['/market/research/:action'], function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        var dateFormat = require('dateformat');
        var allow = common.checkPermission('access_to_research_of_the_forward_market ', req);

        $arr.externalcss = ['jquery.datetimepicker'];
        $arr.externaljs = ['jquery.datetimepicker'];
        $arr['heading_common'] = "Market research Report";
        $arr.start_date = ((typeof (req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : req.param('start_date');
        $arr.end_date = ((typeof (req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : req.param('end_date');
        //req.body.start_date = ((typeof(req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : common.changeDateFormat(req.param('start_date'));
        //req.body.end_date = ((typeof(req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : common.changeDateFormat(req.param('end_date'));
        req.body.start_date = ((typeof (req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : dateFormat(req.param('start_date'), "yyyy-mm-dd");
        req.body.end_date = ((typeof (req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : dateFormat(req.param('end_date'), "yyyy-mm-dd");


        req.body.sortby = ((typeof (req.param('sortby')) === 'undefined') || req.param('sortby') == '') ? '' : req.param('sortby');
        $arr.sortby = ((typeof (req.param('sortby')) === 'undefined') || req.param('sortby') == '') ? '' : req.param('sortby');

        console.log(req.body.start_date);
        console.log(req.body.end_date);

        req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
        if (req.param('action') == 'report') {
            req.body.limit = 10;

            q.all([
                dashboard.getResearchReport(req, config.mysql, q, 0),
                dashboard.getResearchReport(req, config.mysql, q, 1),
                products.getResearchDataFlower(req, config.mysql, q, 0)
            ]).then(function (results) {
                // console.log(JSON.stringify(results));
                $arr['pagination'] = 100;
                $arr['list'] = products.shortDescribe(results[0][0]);
                $arr['research_data'] = results[2][0][0];

                var pagination = require('pagination');
                var url = require('url');
                var url_parts = url.parse(req.url, true);
                var query = url_parts.query;

                $arr['search'] = query;
                fquery = common.urlparameter(query, { page: '' });

                var paginator = new pagination.SearchPaginator({
                    prelink: '/dashboard/market/research/report?' + fquery,
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: results[1][0][0].total_inv
                });

                $arr['pagination_html'] = paginator.render();

                common.tplFile('market-research-report.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        } else if (req.param('action') == 'download') {
            q.all([
                dashboard.getResearchReport(req, config.mysql, q, 2),
                products.getResearchDataFlower(req, config.mysql, q, 0)
            ]).then(function (result) {
                var k = result[0][0].length;
                resultk = products.shortDescribe(result[0][0]);
                mk = result[1][0][0];
                var j = 0;
                arr = [];

                data2 = [
                    'Product Purchased',
                    'Category',
                    'Sub Category',
                    'My Avg Transaction Price / lb',
                    'Market Avg Transaction Price',
                    'My Price VS Mkt',
                    'My Volume',
                    'Market Volume',
                    'My Mkt Share Volume',
                    'Unit of Measure'
                ];
                arr.push(data2);
                for (i in resultk) {
                    j++;
                    var mk_price = 0;
                    var mk_vol = 0;
                    if (resultk[i].parent_cat_name == 'Flower') {
                        mk_price = parseFloat(mk.avg_flower_amt).toFixed(2);
                        mk_vol = mk.total_flower_qty;
                        console.log(mk_price);
                        console.log(mk_vol);
                    } else if (resultk[i].parent_cat_name == 'Dry Concentrates') {
                        mk_price = parseFloat(mk.avg_dryc_amt).toFixed(2);
                        mk_vol = mk.total_dryc_qty;
                        console.log(mk_price);
                        console.log(mk_vol);
                    } else if (resultk[i].parent_cat_name == 'Oil Concentrates') {
                        mk_price = parseFloat(mk.avg_oilc_amt).toFixed(2);
                        mk_vol = mk.total_oilc_qty;
                        console.log(mk_price);
                        console.log(mk_vol);
                    } else if (resultk[i].parent_cat_name == 'Edibles') {
                        mk_price = parseFloat(mk.avg_edible_amt).toFixed(2);
                        mk_vol = mk.total_edible_qty;
                        console.log(mk_price);
                        console.log(mk_vol);
                    }

                    data2 = [
                        resultk[i]['p_title'],
                        resultk[i]['parent_cat_name'],
                        resultk[i]['cat_name'] + '(' + resultk[i]['pid'] + ')',
                        resultk[i]['p_unit_price'] + '/' + resultk[i]['short_unit'],
                        mk_price + '/' + resultk[i]['short_unit'],
                        (parseFloat(mk_price) - parseFloat(resultk[i]['p_unit_price'])).toFixed(2),
                        resultk[i]['i_qty'],
                        mk_vol,
                        ((resultk[i].i_qty / mk_vol) * 100) + '%',
                        resultk[i]['units']
                    ];
                    arr.push(data2);
                }
                res.setHeader('Content-disposition', 'attachment; filename=report.csv');
                res.csv(arr);
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }

    } else {
        return false;
    }

});


app.get(['/notification_manager'], function (req, res) {
    $arr['heading_common'] = "Dashboard - Notifications";
    q.all([
        dashboard.buyer_title(req, $arr.config.mysql, q),
        dashboard.seller_title(req, $arr.config.mysql, q),
        dashboard.get_settings(req, $arr.config.mysql, q)
        // ,
        // dashboard.phoneverified(req, $arr.config.mysql, q)
    ]).then(function (notify) {
        var email_array = [];
        var sms_array = [];
        $arr['buyer_titles'] = notify[0][0];
        $arr['seller_titles'] = notify[1][0];


        if (notify[2][0].length > 0) {

            $arr['get_details'] = notify[2][0];

            email_array = notify[2][0][0]['email'].split(',');
            sms_array = notify[2][0][0]['sms'].split(',');

            $arr['email_items'] = email_array.map(Number);
            $arr['sms_items'] = sms_array.map(Number);

            $arr['notify_id'] = notify[2][0][0]['id'];


        } else {
            $arr['notify_id'] = 0;
        }

        // $arr['user_phones'] = (typeof(notify[3][0][0]['phone']) == 'undefined' || notify[3][0][0]['phone'] == 'null' || notify[3][0][0]['phone'] == '') ? '' : notify[3][0][0]['phone'];
        // $arr['verified'] = notify[3][0][0]['verifyphone'];

        common.tplFile('notification_manager.tpl');
        common.headerSet(1);

        
        common.loadTemplateHeader(req, res, $arr);

    });


});


app.get(['/referrals'], function (req, res) {
    common.checkLogin(req, res, 0);

    $arr['heading_common'] = "Referrals";
    var pagination = require('pagination');

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    q.all([dashboard.allreferrals(req, config.mysql, q, 0), dashboard.allreferrals(req, config.mysql, q, 1), dashboard.totalpoints(req, config.mysql, q)]).then(function (results) {

        var result = _.pluck(results[0][0], 'user_id');

        async.series({
            getSellerDetails: function (checkblock_cbk) {
                faAPI.appendUserDataForObject('id', 'id as user_id, first_name,email,phone,last_name,nick_name,review,avatar as uimage', result, results[0][0], 'user_id', function (messageFromErr, messageFromRes) {

                    console.log("====================================");
                    console.log('Getting user and products details : ' + JSON.stringify(messageFromRes));
                    checkblock_cbk(null, messageFromRes);
                });
            }

        }, function (err, results1) {
            if (err) {
                console.log(err);
            }
            //console.log('combined results here : ' + JSON.stringify(results1.getSellerDetails));
            results[0][0] = results1.getSellerDetails;



            $arr['refers'] = results[0][0];
            $totalrefers = results[1][0].length;
            if (results[2][0][0].points) { $arr['bonus'] = results[2][0][0].points; } else { $arr['bonus'] = 0; }
            $arr.title = global.common.title;

            var paginator = new pagination.SearchPaginator({ prelink: '/dashboard/referrals', current: req.body.page, rowsPerPage: 10, totalResult: $totalrefers });
            $arr['pagination_html'] = paginator.render();

            common.tplFile('referrals.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        });
    });


});

app.get(['/payment/cc', '/payment/cc/:error'], function (req, res) {
    var braintrees = require('../module/braintrees');
    braintrees.generateToken(global.bgateway, templateCallback, req);

    function templateCallback(err, response) {
        $arr.clientToken = response.clientToken;
        $arr.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
        common.tplFile('creditcard.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});

app.get('/payment/delete/:id/:type', function (req, res) {
    $arr.type = (typeof (req.param('type')) == 'undefined') ? '' : req.param('type');
    if ($arr.type != 'Paypal') {

        var braintrees = require('../module/braintrees');
        global.bgateway.paymentMethod.delete('dh37r6');
    }
    var creditcard = require('../module/creditcard');

    creditcard.delete(req, config.mysql, q);

    res.writeHead(302, { 'Location': '/dashboard/payment/saved/Payment detail has been deleted successfully' });
    res.end();
    return false;
    return false;

});

app.get(['/payment/paypal', '/payment/paypal/:error'], function (req, res) {
    var braintrees = require('../module/braintrees');
    braintrees.generateToken(global.bgateway, templateCallback, req);

    function templateCallback(err, response) {
        $arr.clientToken = response.clientToken;
        $arr.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
        common.tplFile('paypal.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});


app.post('/feature/', function (req, res) {

    projects = require('../module/products');
    var price = req.session.featured_home_listing;
    var brain_cust_id = global.bcustomer_prefix + req.session.userid;

    q.all([projects.productDetail(req, config.mysql, q)]).then(function (result) {
        pid = result[0][0][0];

        var ml = global.bgateway.transaction.sale({
            amount: price,
            paymentMethodNonce: req.param('paymentMethodNonceInputField'),
            options: {
                submitForSettlement: true
            }
        }, function (err, result) {
            if (result.success) {
                if (result.transaction.status) {

                    projects.updateFeatureData(req, config.mysql, q, req.body.id);
                    if (req.session.featured_add) {
                        $arr.type = 'Feature Listing Fee';
                    }
                    if (req.session.home_listing_add) {
                        if (req.session.featured_add) {
                            $arr.type = 'Feature & Home Page Listing Fee';
                        } else {
                            $arr.type = 'Home Page Listing Fee';
                        }
                    }
                    payments = require('../module/payment');
                    payments.transactionid = result.transaction.id;
                    payments.gateway = 'account';
                    payments.sessionsdata = [];
                    payments.sessionsdata.title = pid.title;
                    payments.sessionsdata.email = req.session.email;
                    payments.sessionsdata.url = config.url + '/product/view/' + pid.id;
                    payments.sessionsdata.userid = req.session.userid;
                    payments.sessionsdata.first_name = req.session.first_name;
                    payments.sessionsdata.last_name = req.session.last_name;
                    payments.payid = pid.id;
                    payments.type = $arr.type;
                    payments.name = pid.title;
                    payments.amount = price;
                    payments.insertInvoice(req);
                    if (pid.market_status != 'draft') {
                        res.writeHead(302, { 'Location': '/dashboard/my' });
                        res.end();
                        return false;
                        return false;
                    } else {
                        res.writeHead(302, { 'Location': '/dashboard/my?cmd=draft' });
                        res.end();
                        return false;
                        return false;
                    }
                } else {
                    $arr['error'] = result.transaction.processorResponseText;
                    res.writeHead(302, {
                        'Location': '/dashboard/feature/' + req.param('id') + '/' + $arr['error']
                    });
                    res.end();
                    return false;
                }
            } else {
                $arr['error'] = '';

                $arr['error'] += result.message;

                res.writeHead(302, {
                    'Location': '/dashboard/feature/' + req.param('id') + '/' + $arr['error']
                });
                res.end();
                return false;
            }
        });

    });

});

app.get(['/feature/:id', '/feature/:id/:error'], function (req, res) {
    projects = require('../module/products');
    if (req.session.featured_add) {
        $arr.title = 'Feature Listing Fee';
    }
    if (req.session.home_listing_add) {
        if (req.session.featured_add) {
            $arr.title = 'Feature & Home Page Listing Fee';
        } else {
            $arr.title = 'Home Page Listing Fee';
        }
    }
    var brain_cust_id = global.bcustomer_prefix + req.session.userid;
    var s = global.bgateway.customer.find(brain_cust_id, function (err, customer) { });
    $arr.error = (typeof (req.body.error) === 'undefined') ? '' : req.body.error;
    q.all([projects.productDetail(req, config.mysql, q)]).then(function (result) {

        var braintrees = require('../module/braintrees');
        braintrees.generateToken(global.bgateway, generateToken, req);

        function generateToken(err, response) {


            if (response.success) {
                $arr.amount = 0;
                $arr.projects = result[0][0][0];
                $arr.id = req.param('id');
                $arr.amount = req.session.featured_home_listing;
                $arr.clientToken = response.clientToken;
                $arr.externalcss = ['buyer2'];
                common.tplFile('feature.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            } else {
                $arr['error'] += err;
                res.writeHead(302, {
                    'Location': '/dashboard/feature/' + req.param('id') + '/' + $arr['error']
                });
                res.end();
                return false;
            }
        }
    });
});


app.post('/product/save', function (req, res) {

    var attach = require('../module/attach');
    var admin = require('../module/admin');
    projects = require('../module/products');
    delete req.session.featured_home_listing;
    delete req.session.featured_add;
    delete req.session.home_listing_add;
    req.body.id = (typeof (req.body.id) === 'undefined') ? 0 : req.body.id;
    req.body.cid = (typeof (req.body.cid) == 'undefined') ? req.body.mcid : req.body.cid;

    if (req.body.id > 0) {
        // admin.deleteAttachment(config.mysql, q, req);

        var total_size = 0;
        q.all([projects.productDetail(req, config.mysql, q)]).then(function (result) {

            if (typeof (req.session.aid) !== 'undefined') {

                if (typeof (req.session.aid[req.body.random_id]) !== 'undefined') {

                    for (var i in req.session.aid[req.body.random_id]) {

                        if (req.session.aid[req.body.random_id][i] != null) {

                            req.body.product_image = req.session.aid[req.body.random_id][i].originalName;
                            req.body.avatar = req.session.aid[req.body.random_id][i].name;

                            admin.addAttachment(req.session.aid[req.body.random_id][i], config.mysql, q, req.body.id);

                            sizeInKb = common.parseFloat(req.session.aid[req.body.random_id][i].size);

                            total_size = total_size + sizeInKb;
                        }
                    }
                }
            }

            if (typeof (req.files.digital_image) !== 'undefined') {

                if (typeof (req.files.digital_image.name) !== 'undefined') {

                    admin.addDigitalAttachment(req.files.digital_image, config.mysql, q, req.body.id);
                }
                for (var i in req.files.digital_image) {

                    if (req.files.digital_image[i] != null) {


                        admin.addDigitalAttachment(req.files.digital_image[i], config.mysql, q, req.body.id);

                        sizeInKb = common.parseFloat(req.files.digital_image[i].size);

                        total_size = total_size + sizeInKb;
                    }
                }

            }

            q.all([products.productImage(req, config.mysql, q)]).then(function (imgArray) {

                var imgArrayCount = imgArray[0][0].length;

                if (imgArrayCount > 0 && req.body.product_image == null) {

                    req.body.product_image = imgArray[0][0][0].image;
                    req.body.avatar = imgArray[0][0][0].avatar;
                }
                projects.saveProduct(req, config.mysql, q, result[0][0][0]);
                admin.addProductionAnswer(req, config.mysql, q, req.body.id);


                size = common.convertBytesToKb(total_size)
                req.session.used_attach_space = common.sumFloat(req.session.used_attach_space, size);
                projects.updateAttachmentLimit(req, config.mysql, q, size);

                req.session.featured_home_listing = 0;
                if (req.body.featured == 1 && result[0][0][0].feature == 0) {
                    req.session.featured_home_listing = global.general.feature_listing_fee;
                    req.session.featured_add = 1;

                }
                if (req.body.home_page_listing_fee == 1 && result[0][0][0].home_page_listing_fee == 0) {
                    req.session.featured_home_listing = common.sumFloat(req.session.featured_home_listing, global.general.home_page_listing_fee);
                    req.session.home_listing_add = true;

                }
                if (req.body.featured == 1 && result[0][0][0].feature == 0 || req.body.home_page_listing_fee == 1 && result[0][0][0].home_page_listing_fee == 0) {
                    res.writeHead(302, { 'Location': '/dashboard/feature/' + req.body.id });

                    res.end();
                    return false;
                    return false;
                }
                if (req.body.sid > 0) {
                    res.writeHead(302, { 'Location': '/stores/view/' + req.body.sid });

                    res.end();
                    return false;
                    return false;
                }
                if (typeof (req.body.save) !== 'undefined') {
                    res.writeHead(302, { 'Location': '/dashboard/my' });
                    res.end();
                    return false;
                    return false;
                } else {
                    res.writeHead(302, { 'Location': '/dashboard/my?cmd=draft' });
                    res.end();
                    return false;
                    return false;
                }
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();

    } else {
        // attach.save('product', req, res);

        if (typeof (req.session.aid) !== 'undefined') {

            if (typeof (req.session.aid[req.body.random_id]) !== 'undefined') {

                for (i in req.session.aid[req.body.random_id]) {

                    if (req.session.aid[req.body.random_id][i] != null) {

                        req.body.product_image = req.session.aid[req.body.random_id][i].originalName;
                        req.body.avatar = req.session.aid[req.body.random_id][i].name;
                        break;

                    }
                }
            }
        }
        console.log('****************image********************');

        console.log(req.body.product_image);
        console.log(req.body.avatar);
        console.log('************************************');
        q.all([projects.save(req, res, config.mysql, q), projects.checkmailnotify(req, config.mysql, q, 3), projects.checksmsnotify(req, config.mysql, q, 3)]).then(function (l) {

            req.body.p_id = l[0][0].insertId;
            req.body.id = l[0][0].insertId;

            admin.addProductionAnswer(req, config.mysql, q, req.body.p_id);
            var total_size = 0;
            if (typeof (req.body.sid) !== 'undefined') {
                req.body.id = req.body.p_id;
                var stores = require('../module/stores');
                stores.addStoreProducts(req, config.mysql, q);

            }

            if (typeof (req.session.aid) !== 'undefined') {

                if (typeof (req.session.aid[req.body.random_id]) !== 'undefined') {

                    for (i in req.session.aid[req.body.random_id]) {

                        if (req.session.aid[req.body.random_id][i] != null) {

                            req.body.product_image = req.session.aid[req.body.random_id][i].originalName;
                            req.body.avatar = req.session.aid[req.body.random_id][i].name;
                            admin.addAttachment(req.session.aid[req.body.random_id][i], config.mysql, q, req.body.id);

                            sizeInKb = common.parseFloat(req.session.aid[req.body.random_id][i].size);

                            total_size = total_size + sizeInKb;
                        }
                    }
                }
            }
            if (typeof (req.files.digital_image) !== 'undefined') {


                if (typeof (req.files.digital_image.name) !== 'undefined') {

                    admin.addDigitalAttachment(req.files.digital_image, config.mysql, q, req.body.id);
                }
                for (i in req.files.digital_image) {

                    if (req.files.digital_image[i] != null) {


                        admin.addDigitalAttachment(req.files.digital_image[i], config.mysql, q, req.body.id);

                        sizeInKb = common.parseFloat(req.files.digital_image[i].size);

                        total_size = total_size + sizeInKb;
                    }
                }

            }
            size = common.convertBytesToKb(total_size)
            req.session.used_attach_space = common.sumFloat(req.session.used_attach_space, size);
            projects.updateAttachmentLimit(req, config.mysql, q, size);

            var cat_name = '';

            q.all([products.getcategory(req, config.mysql, q)]).then(function (cat) {
                req.body.fromid = (typeof (req.body.fromid) === 'undefined') ? req.session.userid : req.body.fromid;
                req.body.cat_name = cat[0][0][0].name;
                var cat_name = cat[0][0][0].name;
                q.all([products.categoryusr(req, config.mysql, q)]).then(function (catusr) {
                    catusrs = catusr[0][0];
                    email = require('../module/email');
                    message = require('../module/message');
                    var dat = require('date-util');
                    for (i in catusrs) {
                        var activeurl = 'test mail';
                        req.body.nid = 8;
                        req.body.first_name = catusrs[i]['first_name'];
                        req.body.last_name = catusrs[i]['last_name'];
                        req.body.toemail = req.body.email = catusrs[i]['email'];
                        req.body.tophone = catusrs[i]['phone'];
                        req.body.toid = catusrs[i]['id'];
                        req.body.pid = req.body.p_id;
                        req.body.r_id = Date.parse(new Date()) / 1000;
                        req.body.subject = 'New product (' + req.body.title + ') has been added';
                        req.body.message = req.body.title + ' has been added on ' + cat_name + '. To view product details .Please <a href="' + $arr.config.spath + 'product/view/' + req.body.p_id + '">click here</a>';
                        req.body.phmessage = req.body.title + ' has been added on ' + cat_name + '.';
                        message.addmessages(req, config.mysql, q);


                        //email.sendEmail('item_added',req.body,{user:req.body.first_name+' '+req.body.last_name,activeurl:activeurl,product_name:req.body.title,cat:req.body.cat_name,link:plink, });
                    }
                });
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();

            localm = require('../module/localmail');

            console.log(req.body);
            if (l[1][0].length > 0) {

                // if (global.emailcio.status == 'yes') {

                //     customerio = require('../module/customerio');
                //     customerio.uid = req.session.userid;
                //     customerio.inits();
                //     customerio.createCustomer({
                //         email: req.session.email,
                //         user: { firstName: req.session.first_name, lastName: req.session.last_name }
                //     });
                //     customerio.sendEmail({
                //         event: 'project_posted',
                //         content: {
                //             user: req.session.first_name + ' ' + req.session.last_name,
                //             name: req.body.title,
                //             url: config.url + '/product/view/' + req.body.p_id,
                //             unsub_url: global.unsub_url + '/' + req.session.userid

                //         }
                //     });


                // } else 
                if (global.emaillocal.status == 'yes') {


                    q.all([localm.mailtemps(req, config.mysql, q, 'project_posted')]).then(function (results2) {

                        if (results2) {

                            var template = results2[0][0][0].template;
                            var subject = results2[0][0][0].subject;

                            template = template.replace('{{event.sitename}}', "Auction Software.com");
                            template = template.replace('{{event.user}}', req.session.first_name + ' ' + req.session.last_name);
                            template = template.replace('{{event.name}}', req.body.title);
                            template = template.replace('{{event.url}}', config.url + '/product/view/' + req.body.p_id);
                            console.log(template);
                            localm.sendmail(template, subject, req.session.email);
                        } else {

                            console.log('No template named project_posted');
                        }


                    });

                } else {
                    console.log('No Mail Delivery method is selected');
                }

            } else { console.log('Email method is not Selected for product posting'); }

            if (l[2][0].length > 0) {

                if (global.smstwo.status == 'yes') {

                    twillio = require('../module/twillio');

                    q.all([twillio.smstemps(req, config.mysql, q, 'project_posted')]).then(function (results3) {

                        if (results3) {

                            var template = results3[0][0][0].template;

                            template = template.replace('{{event.sitename}}', "Auction Software.com");
                            template = template.replace('{{event.user}}', req.session.first_name + ' ' + req.session.last_name);
                            template = template.replace('{{event.name}}', req.body.title);
                            template = template.replace('{{event.url}}', config.url + '/product/view/' + req.body.p_id);
                            console.log('[][][][][][][][][][][]][][][][][][]');
                            console.log(template);
                            twillio.sendsms(template, req.session.phone);

                        } else {

                            console.log('No template name project_posted');
                        }

                    });

                }
            } else { console.log('SMS method is not Selected for product posting'); }


            req.session.productcountyear = parseInt(req.session.productcountyear) + 1;

            req.session.productcountmonth = parseInt(req.session.productcountmonth) + 1;

            req.session.featured_home_listing = 0;
            if (req.body.featured == 1) {
                req.session.featured_home_listing = global.general.feature_listing_fee;
                req.session.featured_add = true;
            }
            if (req.body.home_page_listing_fee == 1) {
                req.session.featured_home_listing = common.sumFloat(req.session.featured_home_listing, global.general.home_page_listing_fee);
                req.session.home_listing_add = true;
            }
            if (req.body.featured == 1 || req.body.home_page_listing_fee) {

                res.writeHead(302, { 'Location': '/dashboard/feature/' + l[0][0].insertId });

                res.end();
                return false;
                return false;
            }
            if (req.body.sid > 0) {
                res.writeHead(302, { 'Location': '/stores/view/' + req.body.sid });

                res.end();
                return false;
                return false;
            }
            if (typeof (req.body.save) !== 'undefined') {
                res.writeHead(302, { 'Location': '/dashboard/my' });
                res.end();
                return false;
                return false;
            } else {
                res.writeHead(302, { 'Location': '/dashboard/my?cmd=draft' });
                res.end();
                return false;
                return false;
            }

        }).fail(function (error) {
            console.log(error.stack);
            throw error;

        }).done();
    }
});

/* direct buy product posting and editing here */
app.post('/storeproduct/save', function (req, res) {
    console.log(req.files);
    var attach = require('../module/attach');
    var admin = require('../module/admin');
    projects = require('../module/products');
    delete req.session.featured_home_listing;
    delete req.session.featured_add;
    delete req.session.home_listing_add;
    req.body.id = (typeof (req.body.id) === 'undefined') ? 0 : req.body.id;
    req.body.cid = (typeof (req.body.cid) == 'undefined') ? req.body.mcid : req.body.cid;
    //req.body.stax = (typeof(req.body.stax) == 'undefined') ? 0 : req.body.stax;
    console.log('store product', req.body);
    if (req.body.id > 0) {
        // admin.deleteAttachment(config.mysql, q, req);

        var total_size = 0;

        q.all([products.productImage(req, config.mysql, q), products.productDetail(req, config.mysql, q)]).then(function (imgArray) {

            var imgArrayCount = imgArray[0][0].length;
            var prdt = imgArray[1][0][0];
            if (imgArrayCount > 0 && req.body.product_image == null) {

                req.body.product_image = imgArray[0][0][0].image;
                req.body.avatar = imgArray[0][0][0].avatar;
            }

            projects.saveeditProduct(req, config.mysql, q, prdt);

            attach.save('product', req, res);

            if (req.files.product_image !== undefined) {
                q.all([attach.saveAttachments(req, config.mysql, q, req.body.id)]).then(function (result) {
                    // console.log(JSON.stringify(result));
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

            console.log(req.files.test_results);

            console.log('uploading test results');
            if (req.files.test_results !== undefined) {
                q.all([attach.saveTestresultss(req,req.files.test_results, config.mysql, q, prdt.id)]).then(function(result) {
                    console.log('test results ----',JSON.stringify(result));
                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

            console.log('uploading test cert_analysis_img');
            if (req.files.cert_analysis_img !== undefined) {
                q.all([attach.saveTestresultss(req,req.files.cert_analysis_img, config.mysql, q, prdt.id)]).then(function(result) {
                    console.log('saveTestresultss ----',JSON.stringify(result));
                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

            if (req.body.sid > 0) {
                res.writeHead(302, { 'Location': '/stores/view/' + req.body.sid });

                res.end();
                return false;
            }
            console.log('req.body.last_url');
            console.log(req.body.last_url);
            if (req.body.last_url != 'undefined' && req.body.last_url != '' && req.body.last_url) {
                res.writeHead(302, {
                    'Location': req.body.last_url
                });
                res.end();
            } else {
                res.writeHead(302, {
                    'Location': '/product/sview/' + req.body.id
                });
                res.end();
            }
            /*res.writeHead(302, { 'Location': req.headers.referer });
            res.end();
            res.writeHead(302, {
                'Location': '/product/sview/' + req.body.id
            });
            res.end();*/
            return false;
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();

    } else {
        console.log('step -1');
        console.log(req.files);
        common.checkLogin(req, res, 0);
        $arr.error = '';
        var attach = require('../module/attach');
        attach.save('product', req, res);
        console.log('step -2');
        q.all([
            projects.savestorepdts(req, res, config.mysql, q),
            projects.checkmailnotify(req, config.mysql, q, 3),
            projects.checksmsnotify(req, config.mysql, q, 3),
            projects.usermaildata(req, res, config.mysql, q)
        ]).then(function (results) {

            console.log('step -3');
            localm = require('../module/localmail');
            req.body.p_id = results[0][0].insertId;
            req.body.id = results[0][0].insertId;
            console.log("result : ");
            console.log("-----last result : ", results[0][0].insertId);
            /* q.all(projects.generatePkey(req, results[0][0].insertId, config.mysql, q)).then(function (resul) {
                console.log('results here', resul);
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done(); */

            var requestData = {
                id : results[0][0].insertId
            }
            request(global.fwrdauctionAPI.url + 'pickup', { method: "POST", json: true, body: requestData }, function(err, resp, body) {

                if (err || body.error) {
                    console.log(err, "====*************************====== Error ShipEdge on Calling PickUp API ====*************************====== ");
                    // throw err;
                }else{
                    var Order =  require('../module/order');
                    q.all([Order.warehouseSkuONProduct(req, config.mysql, q, results[0][0].insertId, body.message.warehouseSku[0]['warehouseSku'])]).then(function(result) {
                        console.log("====*************************====== ShipEdge on Calling PickUp API is Updated Succesfully  ====*************************====== ");
                    }).fail(function(err) {
                        console.log(err.stack);
                       // throw err;
                    }).done();
                }
            });
            console.log("last result : ", results[0][0].insertId);
            if (typeof (req.body.sid) !== 'undefined') {
                // req.body.id = req.body.p_id;
                var stores = require('../module/stores');
                q.all(stores.addStoreProducts(req, config.mysql, q)).then(function (resul) {
                    console.log('results here', resul);
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }
            console.log("last result : ", results[0][0].insertId);
            if (req.files.product_image !== undefined) {
                q.all([attach.saveAttachments(req, config.mysql, q, results[0][0].insertId)]).then(function (result) {
                    // console.log(JSON.stringify(result));
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }
            console.log('uploading test results');
            if (req.files.test_results !== undefined) {
                q.all([attach.saveTestresultss(req,req.files.test_results, config.mysql, q,  results[0][0].insertId)]).then(function(result) {
                    console.log('test results ----',JSON.stringify(result));
                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

            console.log('uploading test cert_analysis_img');
            if (req.files.cert_analysis_img !== undefined) {
                q.all([attach.saveTestresultss(req,req.files.cert_analysis_img, config.mysql, q,  results[0][0].insertId)]).then(function(result) {
                    console.log('saveTestresultss ----',JSON.stringify(result));
                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

            // console.log(results[1][0]);
            if (results[1][0].length > 0) {

                // if (global.emailcio.status == 'yes') {

                //     customerio = require('../module/customerio');
                //     customerio.uid = req.session.userid;
                //     customerio.inits();
                //     customerio.createCustomer({ email: req.session.email, user: { firstName: req.session.first_name, lastName: req.session.last_name } });
                //     customerio.sendEmail({ event: 'project_posted', content: { siteurl: config.url, user: req.session.first_name + ' ' + req.session.last_name, name: req.body.title, url: config.url + '/product/view/' + results[0][0].insertId } });

                // } else 
                if (global.emaillocal.status == 'yes') {
                    var activeurl = '<br/> To view product please <a href="' + $arr.config.url + '/product/sview/' + results[0][0].insertId + '">Click Here</a>';
                    q.all([localm.mailtemps(req, config.mysql, q, 'project_posted')]).then(function (results2) {

                        if (results2) {

                            var template = results2[0][0][0].template;
                            var subject = results2[0][0][0].subject;

                            template = template.replace('{{event.sitename}}', global.common.title);
                            template = template.replace('{{event.user}}', req.session.first_name + ' ' + req.session.last_name);
                            template = template.replace('{{event.title}}', req.body.title);
                            template = template.replace('{{event.url}}', activeurl);

                            //console.log(template);
                            localm.sendmail(template, subject, req.session.email);
                        } else {

                            console.log('No template named project_posted');
                        }

                    });

                } else { console.log('No Mail Delivery method is selected'); }

                if (global.emaillocal.status == 'yes') {
                    var activeurl = '<br/> To view product please <a href="' + $arr.config.url + '/product/view/' + results[0][0].insertId + '">Click Here</a>';
                    q.all([localm.mailtemps(req, config.mysql, q, 'project_posted_admin')]).then(function(results2) {

                        if (results2) {

                            var template = results2[0][0][0].template;
                            var subject = results2[0][0][0].subject;

                            var price = (typeof(req.body.unit_price) == 'undefined') ? req.body.unit_price : req.body.unit_price;

                            template = template.replace('{{event.subject}}', subject);
                            template = template.replace('{{event.sitename}}', global.common.title);
                            template = template.replace('{{event.user}}', req.session.first_name + ' ' + req.session.last_name);
                            template = template.replace('{{event.title}}', req.body.title);
                            template = template.replace('{{event.target_price}}', price);
                            template = template.replace('{{event.url}}', activeurl);

                            //console.log(template);
                            localm.sendmail(template, subject, global.general.adminemail);
                        } else {

                            console.log('No template named project_posted_admin');
                        }

                    });

                } else { console.log('No Mail Delivery method is selected'); }

            } else { console.log('Notification off'); }

            if(req.param('store_prdt') == 'y' || req.param('interim_testing_status') == 'y' || req.param('default_distributor') == 'y' || req.param('additional_service') == 'y'){
                if (global.emaillocal.status == 'yes') {
                    var activeurl = '<br/> To view product please <a href="' + $arr.config.url + '/product/view/' + results[0][0].insertId + '">Click Here</a>';
                    
                     var msgs =  '';
                     msgs += req.param('store_prdt') == 'y' ? '<br>Store product facility' : '';
                     msgs += req.param('interim_testing_status') == 'y' ? '<br>Interim testing service' : '' ;
                     msgs += req.param('default_distributor') == 'y' ? '<br>Default herbee distribution service' : '';
                     msgs += req.param('additional_service') == 'y' ? '<br>Additional Service requested<br>' : '';

                    q.all([localm.mailtemps(req, config.mysql, q, 'service_request')]).then(function(results2) {

                        if (results2) {

                            var template = results2[0][0][0].template;
                            var subject = results2[0][0][0].subject;

                            template = template.replace('{{event.seller_details}}', '<br>Name : '+req.session.first_name+' '+req.session.last_name + '<br>Email : '+req.session.email);
                            template = template.replace('{{event.subject}}', subject);
                            template = template.replace('{{event.sitename}}', global.common.title);
                            template = template.replace('{{event.user}}', 'admin');
                            template = template.replace('{{event.title}}', req.body.title);
                            template = template.replace('{{event.message}}', msgs);
                            template = template.replace('{{event.url}}', activeurl);

                            console.log(template);
                            localm.sendmail(template, subject, global.general.adminemail);
                        } else {

                            console.log('No template named project_posted');
                        }

                    });

                } else { 
                    console.log('No Mail Delivery method is selected'); 
                }
             }


            if (results[2][0].length > 0) {

                if (global.smstwo.status == 'yes') {

                    twillio = require('../module/twillio');

                    q.all([twillio.smstemps(req, config.mysql, q, 'project_posted')]).then(function (results3) {

                        if (results3) {

                            var template = results3[0][0][0].template;

                            template = template.replace('{{event.sitename}}', "Auction Software.com");
                            template = template.replace('{{event.user}}', req.session.first_name + ' ' + req.session.last_name);
                            template = template.replace('{{event.name}}', req.body.title);
                            template = template.replace('{{event.url}}', config.url + '/product/view/' + req.body.p_id);

                            //console.log(template);
                            twillio.sendsms(template, req.session.phone);

                        } else {

                            console.log('No template name project_posted')
                        }

                    });

                }
            } else { console.log('SMS method not selected for project_posted') }
            console.log('results', results[3][0]);
            var user_ids = _.pluck(results[3][0], 'user_id');
            console.log('user_ids', user_ids);
            faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name', user_ids, results[3][0], 'user_id', function (apiUsersErr, apiUsersRes) {
                var activeurls = '<br/> To view product please <a href="' + $arr.config.url + '"/product/sview/"' + results[0][0].insertId + '"">Click Here</a>';
                q.all([localm.mailtemps(req, config.mysql, q, 'product_offers')]).then(function (mailresults) {

                    for (var i = apiUsersRes.length - 1; i >= 0; i--) {
                        if (apiUsersRes[i].user_id != req.session.userid) {
                            if (mailresults) {
                                var template1 = mailresults[0][0][0].template;
                                var subject1 = mailresults[0][0][0].subject;
                                template1 = template1.replace('{{event.user}}', apiUsersRes[i].first_name + ' ' + apiUsersRes[i].last_name);
                                template1 = template1.replace('{{event.title}}', req.body.title);
                                template1 = template1.replace('{{event.url}}', activeurls);
                                localm.sendmail(template1, subject1, toemail);
                            } else {
                                console.log('No template named project_posted');
                            }

                        }
                        var toemail = apiUsersRes[i].email;

                    }
                });

            });

            res.writeHead(302, {
                'Location': '/stores/view/' + req.body.sid
            });
            res.end();
            return false;
        });
    }
});

app.get('/feedback/submit', function (req, res) {
    $arr.externalcss = ['buyer2'];
    common.tplFile('review-confirm.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

/* Showing receipt by invoice id - which having details of whole transaction made at a time with multiple products */
app.get('/invoices/:id', function (req, res) {

    invoices = require('../module/invoices');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 0;
    q.all([invoices.viewTransactions(req, config.mysql, q)]).then(function (results) {
        $arr['transaction'] = results[0];
        common.tplFile('invoices.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

/* Showing receipt by buynow id by single product */
app.get('/invoice/:id', function (req, res) {

    // console.log(req.headers)
    // console.log(req.body)
    // console.log(req.headers.referer)

    $arr.last_url = typeof (req.param('last_url')) != 'undefined' ? req.param('last_url') : req.headers.referer;
    $arr.externalcss = ['buyer2'];
    req.body.id = req.param('id');
    q.all([dashboard.addInvoice(req, config.mysql, q)]).then(function (results) {

       // console.log("----------------results------------------: " + JSON.stringify(results));
        var result = _.pluck(results[0][0], 'suserid');

        async.series({
            getSellerDetails: function (checkblock_cbk) {
                faAPI.appendUserDataForObject('id', 'id as suserid,concat(first_name," ",last_name) as seller_name,email as seller_email,address1 as seller_address,country as seller_country,state as seller_state,city as seller_city,zip as seller_zip,phone as seller_phone', result, results[0][0], 'suserid', function (messageFromErr, messageFromRes) {

                    console.log("====================================");
                    console.log('Getting user and products details : ' + JSON.stringify(messageFromRes));
                    checkblock_cbk(null, messageFromRes);
                });
            }

        }, function (err, results1) {

            if (err) {
                console.log(err);
            }

            console.log("----------------results1------seller details-------: " + JSON.stringify(results1));

            results[1] = results1.getSellerDetails;
            var profile = require('../module/profile_settings');
            var result = _.pluck(results[0][0], 'buserid');
            async.series({
                getBuyerDetails: function (checkblock_cbk) {
                    faAPI.appendUserDataForObject('id', 'id as buserid, concat(first_name," ",last_name) as buyer_name', result, results[0][0], 'buserid', function (messageFromErr, messageFromRes) {
                        checkblock_cbk(null, messageFromRes);
                    });
                },
                getCheckoutDetails: function (checkblock_cbk) {

                    q.all([cart.getCartDetailscart(req, config.mysql, q, results[0][0][0].buynow_cart_id)]).then(function (checkoutDetails) {
                        // q.all([cart.shippingDetails(req, config.mysql, q, results[0][0][0].buserid)]).then(function(shippingDetails) {
                        checkblock_cbk(null, checkoutDetails[0][0]);
                    }).fail(function (error) {
                        console.log("Error : " + error.stack);
                        throw error;
                    }).done();

                }

            }, function (err, results2) {

                console.log("----------------results2------buyer details-------: " + JSON.stringify(results2.getBuyerDetails));
                console.log("----------------results2------check details-------: " + JSON.stringify(results2.getCheckoutDetails));

                if (err) {
                    console.log(err);
                }

                $arr['heading_common'] = "Invoice";
                results[1] = results2.getCheckoutDetails;



                var invoice = products.shortDescribe(results[0][0]);
                $arr.invoice = invoice[0];
                console.log('invoice', $arr.invoice);
                if ($arr.invoice != 'undefined') {
                    $arr['invoice_total_amount'] = parseFloat($arr.invoice.total_amount).toFixed(2);
                }
                console.log('invoice', $arr.invoice);
                $arr.checkoutData = results[1][0];
                if(req.session.admin == 1){
                    common.tplFile('admincp/invoice.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                }else{
                    common.tplFile('invoice.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                }
                

            });
        });
    });
});

/* Payment receipt for membership, wire_payment, check_payment etc. except than products sold */
app.get('/admin/receipt/:id', function (req, res) {

    // console.log(req.headers)
    // console.log(req.body)
    // console.log(req.headers.referer)

    $arr.last_url = typeof (req.param('last_url')) != 'undefined' ? req.param('last_url') : req.headers.referer;
    $arr.externalcss = ['buyer2'];
    req.body.id = req.param('id');
    q.all([dashboard.addInvoice(req, config.mysql, q)]).then(function (results) {

        console.log("----------------results------------------: " + JSON.stringify(results));
        var result = _.pluck(results[0][0], 'suserid');

        async.series({
            getSellerDetails: function (checkblock_cbk) {
                faAPI.appendUserDataForObject('id', 'id as suserid,concat(first_name," ",last_name) as seller_name,email as seller_email,address1 as seller_address,country as seller_country,state as seller_state,city as seller_city,zip as seller_zip,phone as seller_phone', result, results[0][0], 'suserid', function (messageFromErr, messageFromRes) {

                    console.log("====================================");
                    console.log('Getting user and products details : ' + JSON.stringify(messageFromRes));
                    checkblock_cbk(null, messageFromRes);
                });
            }

        }, function (err, results1) {

            if (err) {
                console.log(err);
            }

            console.log("----------------results1------seller details-------: " + JSON.stringify(results1));

            results[1] = results1.getSellerDetails;
            var profile = require('../module/profile_settings');
            var result = _.pluck(results[0][0], 'buserid');
            async.series({
                getBuyerDetails: function (checkblock_cbk) {
                    faAPI.appendUserDataForObject('id', 'id as buserid, concat(first_name," ",last_name) as buyer_name', result, results[0][0], 'buserid', function (messageFromErr, messageFromRes) {
                        checkblock_cbk(null, messageFromRes);
                    });
                },
                getCheckoutDetails: function (checkblock_cbk) {

                    q.all([cart.getCartDetailscart(req, config.mysql, q, results[0][0][0].buynow_cart_id)]).then(function (checkoutDetails) {
                        // q.all([cart.shippingDetails(req, config.mysql, q, results[0][0][0].buserid)]).then(function(shippingDetails) {
                        checkblock_cbk(null, checkoutDetails[0][0]);
                    }).fail(function (error) {
                        console.log("Error : " + error.stack);
                        throw error;
                    }).done();

                }

            }, function (err, results2) {

                console.log("----------------results2------buyer details-------: " + JSON.stringify(results2.getBuyerDetails));
                console.log("----------------results2------check details-------: " + JSON.stringify(results2.getCheckoutDetails));

                if (err) {
                    console.log(err);
                }

                $arr['heading_common'] = "Invoice";
                results[1] = results2.getCheckoutDetails;



                var invoice = products.shortDescribe(results[0][0]);
                $arr.invoice = invoice[0];
                console.log('invoice', $arr.invoice);
                if ($arr.invoice != 'undefined') {
                    $arr['invoice_total_amount'] = parseFloat($arr.invoice.total_amount).toFixed(2);
                }
                console.log('invoice', $arr.invoice);
                $arr.checkoutData = results[1][0];

                common.tplFile('invoice.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);

            });
        });
    });
});

app.get('/openbid/invoice/:id', function (req, res) {
    $arr.externalcss = ['buyer2'];
    req.body.id = req.param('id');

    q.all([dashboard.addInvoice(req, config.mysql, q)]).then(function (results) {

        var result = _.pluck(results[0][0], 'suserid');
        async.series({
            getSellerDetails: function (checkblock_cbk) {
                faAPI.appendUserDataForObject('id', 'id as user_id,concat(first_name," ",last_name) as name,email as seller_email,address1 as uaddress,country as seller_country,state as seller_state,city as seller_city,zip as seller_zip,phone as seller_phone', result, results[0][0], 'suserid', function (messageFromErr, messageFromRes) {
                    console.log("====================================");
                    console.log('Getting user and products details : ' + JSON.stringify(messageFromRes));
                    checkblock_cbk(null, messageFromRes);
                });
            }

        }, function (err, results1) {

            if (err) {
                console.log(err);
            }

            results[1][0] = results1.getSellerDetails;

            var result = _.pluck(results[0][0], 'buserid');

            async.series({

                getBuyerDetails: function (checkblock_cbk) {
                    faAPI.appendUserDataForObject('id', 'id as from_id, concat(first_name," ",last_name) as uname', result, results[0][0], 'buserid', function (messageFromErr, messageFromRes) {
                        checkblock_cbk(null, messageFromRes);
                    });
                }

            }, function (err, results2) {
                if (err) {
                    console.log(err);
                }
                results[2][0] = results2.getBuyerDetails;
                $arr.invoice = results[0][0][0];

                console.log("---------------results here-----------------: " + results);

                common.tplFile('invoice.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        });
    });
});

app.post('/feedback/add', function (req, res) {
    req.body.id = req.body.bid;
    q.all([dashboard.addFeedBack(req, config.mysql, q), dashboard.getBuynowRecord(req, config.mysql, q), dashboard.getFeedFields(req, config.mysql, q)]).then(function (results) {
        var m = results[0][0].insertId;
        var avg = 0;
        // var avg = parseFloat((parseInt(req.param('rating[1]'))+parseInt(req.param('rating[2]'))+parseInt(req.param('rating[4]'))+parseInt(req.param('rating[5]')))/5,2);
        var fields_count = results[2][0].length;
        var review_fields = results[2][0];
        for (var i = 0; i < fields_count; i++) {

            dashboard.addFeedBackPoint(req, config.mysql, q, m, req.param('rating[' + results[2][0][i].id + ']'), results[2][0][i].id);
            avg = avg + parseInt(req.param('rating[' + results[2][0][i].id + ']'));
        }
        avg = parseFloat(avg / fields_count);

        dashboard.setAverageFeedBack(req, config.mysql, q, avg, m);

        // dashboard.addFeedBackPoint(req,config.mysql,q,m,req.param('rating[2]'),2);
        // //dashboard.addFeedBackPoint(req,config.mysql,q,m,req.param('rating[3]'),3);
        // dashboard.addFeedBackPoint(req,config.mysql,q,m,req.param('rating[4]'),4);
        // dashboard.addFeedBackPoint(req,config.mysql,q,m,req.param('rating[5]'),5);
        dashboard.submitFeedbackCart(req, config.mysql, q);

        projects = require('../module/products');
        req.body.id = results[1][0][0].project_id;
        q.all([projects.productDetail(req, config.mysql, q)]).then(function (resu) {
            dashboard.addUserReview(req, config.mysql, q, avg, resu[0][0][0].user_id);
            res.writeHead(302, { 'Location': '/dashboard/feedback/submit' });
            res.end();
            return false;
            return false;
        });
    });
});

app.get(['/payment/:action/:type/:id'], function (req, res) {
    req.body.action = req.param('action');
    req.body.type = req.param('type');
    req.body.id = req.param('id');
    $arr.externalcss = ['buyer2'];
    if (req.body.action == 'feedback') {
        if (req.body.type == 'buy') {
            q.all([dashboard.getFeedBack(req, config.mysql, q), dashboard.getFeedFields(req, config.mysql, q)]).then(function (results) {
                $arr['projects'] = results[0][0][0];
                $arr['fields'] = results[1][0];
                $arr['fieds_count'] = results[1][0].length;

                common.tplFile('add_bfeedback.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        }

    }
    if (req.body.action == 'release' || req.body.action == 'cancel') {
        if (req.body.type == 'buy') {
            q.all([dashboard.getBuynowRecord(req, config.mysql, q)]).then(function (results) {
                if (results[0][0].length == 0) {
                    res.writeHead(302, { 'Location': '/dashboard/my' });
                    res.end();
                    return false;
                }
                var k = results[0][0][0];
                if (k.user_id != req.session.userid) {
                    res.writeHead(302, { 'Location': '/dashboard/my' });
                    res.end();
                    return false;
                }
                if (k.release == 0 && req.body.action == 'release') {
                    dashboard.paymentBuyNowRelease(req, config.mysql, q, id);
                    common.tplFile('payment_released.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                } else if (k.release == 0 && req.body.action == 'cancel') {
                    dashboard.paymentBuyNowCancel(req, config.mysql, q, id);
                    common.tplFile('payment_cancelled.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                } else if (k.release == 1) {
                    common.tplFile('payment_released.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                } else if (k.release == 2) {
                    common.tplFile('payment_cancelled.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                }
            });
        }
        if (req.body.type == 'bid') {
            q.all([dashboard.getBidsRecord(req, config.mysql, q)]).then(function (results) {
                if (results[0][0].length == 0) {
                    res.writeHead(302, { 'Location': '/dashboard/my' });
                    res.end();
                    return false;
                }
                var k = results[0][0][0];
                if (k.user_id != req.session.userid) {
                    res.writeHead(302, { 'Location': '/dashboard/my' });
                    res.end();
                    return false;
                }
                if (k.release == 0 && req.body.action == 'release') {
                    dashboard.paymentBidRelease(req, config.mysql, q, id);
                    common.tplFile('payment_released.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                } else if (k.release == 0 && req.body.action == 'cancel') {
                    dashboard.paymentBidCancel(req, config.mysql, q, id);
                    common.tplFile('payment_cancelled.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                } else if (k.release == 1) {
                    common.tplFile('payment_released.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                } else if (k.release == 2) {
                    common.tplFile('payment_cancelled.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                }
            });
        }
    }
});

app.get(['/my/', '/my/:page'], function (req, res) {
    var adwords = require('../module/adwords');
    $arr.error = '';
    var products = require('../module/products');
    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 5;

    //req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 0;
    var dateFormat = require('dateformat');
    q.all([products.getproductIds(req, config.mysql, q)]).then(function (results2) {
        var pids = results2[0][0][0].projectids;
        if (pids) {
            req.body.pids = pids;
        } else {
            req.body.pids = 0;
        }
        q.all([products.myproducts(req, config.mysql, q, 0), products.myproducts(req, config.mysql, q, 1), adwords.show_ads(req, config.mysql, q, 'Seller Dashboard')]).then(function (results) {
            $arr['projects'] = products.shortDescribe(results[0][0]);
            $arr['pagination'] = results[1][0].length;
            $arr['adwords'] = results[2][0];
            $arr.page_name = 'Seller Dashboard';
            var pagination = require('pagination');
            fquery = '';
            if (typeof (req.param('cmd')) !== 'undefined') {
                fquery = '?cmd=' + req.param('cmd');
                $arr['cmd'] = req.param('cmd');

            }
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/my' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });
            $arr['dateFormat'] = dateFormat;
            $arr['pagination_html'] = paginator.render();
            common.tplFile('myprojects.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }).fail(function (error) {
            console.log("Error : " + error.stack);
            throw error;
        }).done();
    }).fail(function (error) {
        console.log("Error : " + error.stack);
        throw error;
    }).done();
});

app.get(['/mysold/', '/mysold/:page'], function (req, res) {
    $arr.error = '';
    var bids = require('../module/bid');
    var products = require('../module/products');
    var data = bids.SearchPageNo(req, config.mysql, q);
    // req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 0;

    req.body.page = data.dspage;
    req.body.perlimit = 5;
    var adwords = require('../module/adwords');
    var dateFormat = require('dateformat');
    q.all([
        products.mysoldproducts(req, config.mysql, q, 0),
        products.mysoldproducts(req, config.mysql, q, 1),
        adwords.show_ads(req, config.mysql, q, 'Seller Dashboard')
    ]).then(function (results) {

        $arr['projects'] = products.shortDescribe(results[0][0]);
        $arr['pagination'] = results[1][0].length;
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Seller Dashboard';
        var pagination = require('pagination');
        fquery = '';

        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }

        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/mysold' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['dateFormat'] = dateFormat;
        $arr['pagination_html'] = paginator.render();
        common.tplFile('mysold.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});


app.post('/withdrawal', function (req, res) {

    user = require('../module/user');
    withdraw = require('../module/withdraw');
    if (typeof (req.body.amount) === 'undefined' || typeof (req.body.paymethod) === 'undefined' || typeof (req.body.paydetails) === 'undefined') {
        res.writeHead(302, {
            'Location': '/dashboard/withdrawal/error/Invalid datas'
        });
        res.end();
        return false;
    }
    if (parseFloat(req.body.amount) <= 0) {
        res.writeHead(302, {
            'Location': '/dashboard/withdrawal/error/Amount Invalid'
        });
        res.end();
        return false;
    }
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 0;
    q.all([user.userInfo(req, config.mysql, q, req.session.userid, ['balance', 'balance_amount'])]).then(function (results) {
        $arr['users'] = results[0][0][0]
        if ($arr['users']['balance'] >= req.body.amount) {
            bid = require('../module/bid');
            bid.reduceBalance(req, config.mysql, q, req.body.amount);
            withdraw.addWithdraw(req, config.mysql, q);
            res.writeHead(302, {
                'Location': '/dashboard/withdrawal/success/Withdraw Request Sent'
            });
            res.end();
            return false;
        } else {
            res.writeHead(302, {
                'Location': '/dashboard/withdrawal/error/Withdraw Amount must not be greater than available amount'
            });
            res.end();
            return false;
        }
    });

});

app.get(['/withdrawal', '/withdrawal/:action/:message'], function (req, res) {

    withdraw = require('../module/withdraw');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 0;
    $arr['action'] = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    $arr['message'] = (typeof (req.param('message')) !== 'undefined') ? req.param('message') : '';
    q.all([withdraw.mywithdraw(req, config.mysql, q)]).then(function (results) {
        $arr['withdraw'] = results[0][0];
        common.tplFile('withdrawal.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.get(['/mybids', '/mybids:page'], function (req, res) {
    var module = require('../module');
    var bids = require('../module/bid');
    var adwords = require('../module/adwords');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 5;
    q.all([bids.mybids(req, config.mysql, q, 1), bids.mybids(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = products.shortDescribe(results[0][0]);
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        fquery = '';

        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/mybids' + fquery,
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('mybids.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/mywon', '/mywon:page'], function (req, res) {
    var adwords = require('../module/adwords');
    var bids = require('../module/bid');
    var dateFormat = require('dateformat');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 5;

    q.all([bids.mywon(req, config.mysql, q, 1), bids.mywon(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = products.shortDescribe(results[0][0]);
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        fquery = '';
        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }

        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/mywon' + fquery,
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('mywon.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

app.get('/watchlist/:id', function (req, res) {

    products = require('../module/products');
    products.deleteWatchlist(req, config.mysql, q);
    req.session.watchlistdelete = true;
    res.writeHead(302, {
        'Location': '/dashboard/watchlist'
    });
    res.end();
    return false;

});

app.post(['/messages/save'], function (req, res) {

    messages = require('../module/message');
    user = require('../module/user');

    req.body.r_id = parseInt(req.body.r_id);
    req.body.pid = 0;
    if (req.body.r_id <= 0) {
        q.all([common.admincpId(req, config.mysql, q)]).then(function (result) {
            req.body.toid = result[0][0][0]['id'];
            var dat = require('date-util');
            req.body.r_id = Date.parse(new Date());
            q.all([user.userInfo(req, config.mysql, q, req.body.toid, ['email', 'first_name', 'last_name'])]).then(function (results) {
                req.body.toemail = results[0][0][0]['email'];
                req.body.first_name = results[0][0][0]['first_name'];
                req.body.last_name = results[0][0][0]['last_name'];
                messages.addmessages(req, config.mysql, q);
                res.writeHead(302, {
                    'Location': '/dashboard/messages/sent/'
                });
                res.end();
                return false;
            });
        });
    } else {
        q.all([messages.showmessages(req, config.mysql, q, 1), common.admincpId(req, config.mysql, q)]).then(function (results) {
            $arr['messages'] = results[0][0];
            if ($arr['messages'].length == 0) {
                res.writeHead(302, {
                    'Location': '/dashboard/messages'
                });
                res.end();
                return false;
            }
            if ($arr['messages'][0]['from_id'] != req.session.userid && $arr['messages'][0]['to_id'] != req.session.userid) {
                res.writeHead(302, {
                    'Location': '/dashboard/messages'
                });
                res.end();
                return false;
            }
            req.body.toid = ($arr['messages'][0]['from_id'] == req.session.userid) ? $arr['messages'][0]['to_id'] : $arr['messages'][0]['from_id'];
            req.body.subject = $arr['messages'][0]['subject'];
            req.body.pid = $arr['messages'][0]['project_id'];

            q.all([user.userInfo(req, config.mysql, q, req.body.toid, ['email', 'first_name', 'last_name'])]).then(function (results) {
                req.body.toemail = results[0][0][0]['email'];
                req.body.first_name = results[0][0][0]['first_name'];
                req.body.last_name = results[0][0][0]['last_name'];
                messages.addmessages(req, config.mysql, q);
                res.writeHead(302, {
                    'Location': '/dashboard/messages/view/' + req.body.r_id
                });
                res.end();
                return false;
            });
        });
    }
});

app.get(['/messages/:action/:r_id'], function (req, res) {

    $arr.externalcss = ['buyer2'];
    messages = require('../module/message');
    req.body.r_id = (typeof (req.param('r_id')) !== 'undefined') ? req.param('r_id') : 0;
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    $arr['r_id'] = req.body.r_id;
    $arr['heading_common'] = "Messages";
    req.body.r_id = parseInt(req.body.r_id);
    if (req.body.r_id <= 0) {
        res.writeHead(302, {
            'Location': '/dashboard/messages'
        });
        res.end();
        return false;
    }
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    $arr['action'] = req.body.action;
    if (req.body.action != 'view') {
        messages.movemessages(req, config.mysql, q);
        res.writeHead(302, {
            'Location': '/dashboard/messages/view/' + req.body.r_id
        });
        res.end();
        return false;
    }
    q.all([messages.showmessages(req, config.mysql, q, 1), messages.showmessages(req, config.mysql, q, 0)]).then(function (results) {
        try {
            $arr['messages'] = results[0][0];
            if ($arr['messages'].length == 0) {
                res.writeHead(302, {
                    'Location': '/dashboard/messages'
                });
                res.end();
                return false;

            }
            if ($arr['messages'][0]['from_id'] != req.session.userid && $arr['messages'][0]['to_id'] != req.session.userid) {
                res.writeHead(302, {
                    'Location': '/dashboard/messages'
                });
                res.end();
                return false;
            }
            if ($arr['messages'].length > 0) {

                var pagination = require('pagination');

                $arr['pagination'] = results[1][0].length;

                var paginator = new pagination.SearchPaginator({
                    prelink: '/dashboard/messages/' + req.body.action + '/' + req.body.r_id,
                    current: req.body.page,
                    rowsPerPage: 5,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();
                req.body.r_id = $arr['messages'][0]['r_id'];
                messages.readmessages(req, config.mysql, q);
            }
        } catch (e) {
            console.log("error in show messages " + e.stack);
        }
        common.tplFile('message-view.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/messages', '/messages/:action'], function (req, res) {

    messages = require('../module/message');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    messages.updateviewed(req, config.mysql, q);
    $arr['action'] = req.body.action;
    $arr['heading_common'] = "Messages";
    if (req.body.action == 'compose') {
        common.tplFile('compose.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    } else {
        console.log('running');
        q.all([messages.mymessages(req, config.mysql, q, 0), messages.mymessages(req, config.mysql, q, 1), messages.mymessages(req, config.mysql, q, 2), adwords.show_ads(req, config.mysql, q, 'Messages')]).then(function (results) {
            $arr['pagination'] = results[1][0].length;
            $arr['messages'] = results[0][0];
            console.log('messages', $arr['messages']);
            $arr['unreadmessage'] = results[2][0].length;
            $arr['adwords'] = results[3][0]
            $arr.page_name = 'Messages';
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/messages/' + req.body.action + '/',
                current: req.body.page,
                rowsPerPage: 5,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();
            common.tplFile('messages.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});

app.post('/messages/:del_action/:action', function (req, res) {
    messages = require('../module/message');
    req.body.action = typeof ((req.param('action')) !== 'undefined') ? req.param('action') : '';
    if (req.body.del_action == 'delete') {
        q.all(messages.deleteMessages(req, config.mysql, q)).then(function (results) {

            res.send(JSON.stringify({ 'success': true }));

        });
    } else if (req.body.del_action == 'undelete') {
        q.all(messages.unDeleteMessages(req, config.mysql, q)).then(function (results) {

            res.send(JSON.stringify({ 'success': true }));

        });
    }

});

app.get('/watchlist', function (req, res) {

    products = require('../module/products');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 0;
    if (typeof (req.session.watchlistdelete) !== 'undefined') {
        delete req.session.watchlistdelete;
        $arr['save'] = true;
    }
    q.all([products.mywatchlist(req, config.mysql, q), products.totalmywatchlist(req, config.mysql, q)]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mywatchlist'] = results[0][0];
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/watchlist',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('mywatchlist.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});


app.get('/download/:id', function (req, res) {
    var bids = require('../module/bid');
    var dashboard = require('../module/dashboard');
    var filesDownload = function (files, name) {

        res.zip(files, name);

    }
    q.all([dashboard.getBuynowDetail(req, $arr.config.mysql, q)]).then(function (results) {

        var files = [];
        var name = [];
        for (i in results[0][0]) {
            var m = {};
            m.path = $arr.config.common.path + 'public/uploads/product/' + results[0][0][i].avatar;
            m.name = results[0][0][i].image;
            files.push(m);

            if (i == results[0][0].length - 1) {
                filesDownload(files, results[0][0][i].title + '.zip');
            }
        }

    });

});

app.get('/buynow', function (req, res) {
    var bids = require('../module/bid');
    var dashboard = require('../module/dashboard');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 5;
    q.all([dashboard.mybuynow(req, config.mysql, q, 1), dashboard.mybuynow(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = results[0][0];
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/buynow',
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('mybids.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.get('/wonauctions', function (req, res) {

    bids = require('../module/bid');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 0;
    q.all([bids.mywonauctions(req, config.mysql, q), bids.totalmywonauctions(req, config.mysql, q)]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = results[0][0];
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/wonauctions',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('wonauctions.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.get('/review', function (req, res) {

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 0;
    $arr['externalcss'] = ['bootstrap', 'font-awesome', 'star-rating',];
    $arr['externaljs'] = ['bootstrap', 'star-rating'];
    $arr['reviewaction'] = false;

    common.tplFile('review.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);


});

app.post('/review', function (req, res) {

    review = require('../module/review');
    q.all([review.reviewAdd(req, config.mysql, q)]).then(function (results) {
        $arr['reviewaction'] = true;
        res.writeHead(302, {
            'Location': '/reviews'
        });
        res.end();
        return false;
    });

});

app.get('/transactions', function (req, res) {

    invoices = require('../module/invoices');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 0;
    q.all([invoices.mytransactions(req, config.mysql, q), invoices.totalmytransactions(req, config.mysql, q)]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['transaction'] = results[0][0];
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/transactions',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('transactions.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});


app.get('/checkout/invoices/:id', function (req, res) {
    stores = require('../module/stores');
    invoices = require('../module/invoices');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 0;
    q.all([invoices.viewCheckoutTransactions(req.params.id, config.mysql, q)]).then(function (results) {
        $arr['transaction'] = products.shortDescribe(results[0][0]);
        $arr['transaction_amount'] = parseFloat($arr['transaction'][0].amount).toFixed(2);
        console.log('transaction', $arr['transaction']);
        $arr['heading_common'] = "Invoice";
        $arr['last_url'] = common.last_url(req);

        req.body.project_id = $arr['transaction'][0].p_id;
        q.all([adwords.adwords_details(req, config.mysql, q), stores.stores_detatils(req, config.mysql, q)]).then(function (data) {
            if (data[0][0][0].store_id == data[1][0][0].store_id) {
                adwords.addPurchaseClick(req, config.mysql, q);
                adwords.addPurchaseClickAds(req, config.mysql, q);
            }
        });
        common.tplFile('invoices.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get('/password', function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        // common.checkLogin(req, res, 0);

        $arr['password'] = 1;
        $arr['heading_common'] = "Change Password";
        common.tplFile('passwordchange.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    } else return false;

});

app.post('/changepassword', function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        // common.checkLogin(req, res, 0);
        $arr['save'] = true;
        console.log("changepassword")
        if (typeof (req.body.isajax) != 'undefined' && req.body.isajax == 1) {

            req.body.username = req.session.email
            async.series([function (callback) {
                faAPI.loginUser(req, callback);
            }],
                function (err, row) {
                    if (err) {
                        if (err.code == 'L0004') {
                            console.log('err', err.code);
                            res.json(0);
                        } else {
                            console.log('err', err);
                        }
                        // throw err;
                    } else {
                        if (row == null) {
                            res.json(0);
                            return false;
                        } else {
                            res.json(1);
                            return false;
                        }
                    }
                })
            console.log("changepassword1")
        } else {
            req.body.confirm_password = req.body.new_password;
            req.body.userid = req.session.userid;
            var user_email = req.session.email;

            // var first_name = req.session.first_name;
            faAPI.LoginResetPassword(req, function (error, respon) {
                if (respon) {
                    $arr['save'] = true;

                    /* email module */
                    var activeurl = '<br/> <a href="' + $arr.config.spath + 'login">Click Here</a>';
                    email = require('../module/email');
                    localm = require('../module/localmail');

                    // if (global.emailcio.status == 'yes') {
                    //     customerio = require('../module/customerio');
                    //     customerio.uid = result.userId;
                    // } else 
                    if (global.emaillocal.status == 'yes') {
                        q.all([localm.mailtemps(req, config.mysql, q, 'account_settings')]).then(function (results2) {

                            if (results2) {

                                var template = results2[0][0][0].template;
                                var subject_message = results2[0][0][0].subject;

                                // template = template.replace('{{event.sitename}}', config.title);
                                template = template.replace('{{event.activeurl}}', activeurl);
                                template = template.replace('{{event.user}}', req.session.first_name);
                                template = template.replace('{{event.subject}}', 'Your account settings have been changed');
                                // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                                localm.sendmail(template, subject_message, user_email);

                            } else {
                                console.log("No Templates named register");
                            }

                        }).fail(function (err) {
                            console.log(err.stack);
                            throw err;
                        });

                    } else { console.log('No Mail Delivery method is selected'); }

                    /* email module ends here */

                    res.writeHead(302, {
                        'Location': '/dashboard/password'
                    });
                    res.end();
                    return false;
                } else { }
            })
            console.log("changepassword2")
        }
    } else return false;
    // common.checkLogin(req, res, 0);

    // req.body.confirm_password = req.body.new_password;
    // req.body.userid = req.session.userid;
    // faAPI.LoginResetPassword(req, function(error, respon) {
    //     if (respon) {
    //         $arr['save'] = true;
    //         res.writeHead(302, {
    //             'Location': '/dashboard/password'
    //         });
    //         res.end();
    //         return false;
    //     } else {}
    // })

    // $arr['save'] = true;
    // mysql = config.mysql;
    // var md5 = require('MD5');
    // var password_salt = '12345'
    // var password = md5(md5(req.body.new_password) + password_salt);
    // strQuery = mysqli.mysqli($mysqli, 57);

    // if (typeof(req.body.isajax) != 'undefined' && req.body.isajax == 1) {

    //     $mysqli = { username: req.session.email };
    //     strQuery = mysqli.mysqli($mysqli, 0);

    //     query = mysql.query(strQuery, function(error, results, fields) {
    //         if (results.length > 0) {
    //             result = results[0];
    //             result.password = md5(md5(req.param('password')) + result['password_salt']);
    //             if (result.password == result.password_hash) {
    //                 res.json(1);
    //                 return false;
    //             } else {
    //                 res.json(0);
    //                 return false;
    //             }
    //         }
    //     });
    // } else {
    //     $mysqli = {};
    //     var defered = q.defer();
    //     escape_data = [password, password_salt, req.session.email];
    //     query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //     res.writeHead(302, {
    //         'Location': '/dashboard/password'
    //     });
    //     res.end();
    //     return false;
    // }

});
app.get('/Myaddress', function (req, res) {
    q.all([dashboard.getAddresses(req, config.mysql, q, 'shipping'), dashboard.getAddresses(req, config.mysql, q, 'billing')]).then(function (results) {
        $arr['shipping'] = results[0][0][0];
        $arr['billing'] = results[1][0][0];
        common.tplFile('Addresses.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/payments', '/payments/:action'], function (req, res) {

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.perlimit = 10;
    req.body.invoice_id = typeof (req.param('invoice_id')) !== 'undefined' ? req.param('invoice_id') : '';
    req.body.status = typeof (req.param('status')) !== 'undefined' ? req.param('status') : '';
    req.body.istatus = typeof (req.param('istatus')) !== 'undefined' ? req.param('istatus') : '';
    req.body.type = typeof (req.param('type')) !== 'undefined' ? req.param('type') : '';
    // req.body.type = typeof(req.param('type')) !== 'undefined' ? req.param('type') : '';
    // req.body.type = typeof(req.param('type')) !== 'undefined' ? req.param('type') : '';

    req.body.start_date = typeof (req.param('start_date')) !== 'undefined' ? req.param('start_date') : '';
    req.body.end_date = typeof (req.param('end_date')) !== 'undefined' ? req.param('end_date') : '';

    // $arr.externalcss = ['buyer2', 'change_psd'];
    if (req.param('action') == 'download') {
        
        q.all([
            dashboard.getPayments(req, config.mysql, q),
            dashboard.getAllPayments(req, config.mysql, q)
        ]).then(function (results) {
            // console.log('results', results[0][0]);
            // console.log(JSON.stringify(results[0][0]));
            $arr['payments'] = results[1][0];
            $arr['cnt'] = results[1][0].length;
            console.log('results[1][0].length', results[1][0].length);
            

            var k = results[1][0].length;
            resultk = results[1][0];
            var j = 0;
            arr = [];

            data2 = [
                'Invoice Id',
                'Description',
                'Sales Tax',
                'Distribution Tax',
                'Total Paid',
                'Status'
            ];
            arr.push(data2);
            for (i in resultk) {
                j++;
                var desc = resultk[i].description;
                if (resultk[i].primary_id == 0) {
                    desc = resultk[i].type;
                }
                var tax = '-';
                console.log('resultk[i].stax_amt', resultk[i]['stax_amt']);
                if (resultk[i]['stax_amt']!=0) {
                    tax = resultk[i]['stax_amt'];
                }
                var dtax = '-';
                console.log('resultk[i].distribution_tax', resultk[i]['distribution_tax']);
                if (resultk[i]['distribution_tax']!=0) {
                    dtax = resultk[i]['distribution_tax'];
                }
                var status = 'Paid';
                if (resultk[i].status == 'paid' && resultk[i].tr_type == 'credit') {
                    status = 'Credited';
                }

                data2 = [
                    resultk[i]['id'],
                    desc, // + ' Created at : '+resultk[i]['i_date_added'],
                    tax,
                    dtax,
                    parseFloat(resultk[i]['amount']).toFixed(2),
                    status
                ];
                arr.push(data2);
            }
            res.setHeader('Content-disposition', 'attachment; filename=Transactions.csv');
            res.csv(arr);
        }).fail(function (error) {
            console.log("Error : " + error.stack);
            throw error;
        }).done();
        
    } else {
        q.all([
            dashboard.getPayments(req, config.mysql, q),
            dashboard.getAllPayments(req, config.mysql, q)
        ]).then(function (results) {
            // console.log('results', results[0][0]);
            // console.log(JSON.stringify(results[0][0]));
            $arr['payments'] = results[0][0];
            console.log('$arr["payments"]', $arr['payments']);
            // console.log(results[0][0]);
            $arr['payments_activity'] = 1;
            $arr['heading_common'] = "Payment activity";
            $arr['cnt'] = results[1][0].length;
            $arr.externalcss = ['jquery.datetimepicker'];
            $arr.externaljs = ['jquery.datetimepicker'];
            var pagination = require('pagination');
            var bids = require('../module/bid');

            var data = bids.SearchPageNo(req, config.mysql, q);
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });

            if (typeof (req.param('invoice_id')) !== 'undefined') {
                fquery = '/?invoice_id=' + req.param('invoice_id') + '&status=' + req.param('status') + '&istatus=' + req.param('istatus') + '&type=' + req.param('type');
            }

            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/payments' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['cnt']
            });

            $arr.pagination_html = paginator.render();

            common.tplFile('payments.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (error) {
            console.log("Error : " + error.stack);
            throw error;
        }).done();
    }
});

app.get('/paymentexport', function (req, res) {

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    $arr.externalcss = ['buyer2', 'change_psd'];
    q.all([dashboard.getCsvPayments(req, config.mysql, q)]).then(function (result) {
        var k = result[0][0].length;
        resultk = result[0][0];
        var j = 0;
        arr = [];
        data2 = ['InvoiceId', 'Project Title', 'Type', 'Status', 'Amount', 'Date Added', 'Paid Date'];
        arr.push(data2);
        for (i in resultk) {
            j++;
            data2 = [resultk[i]['id'], resultk[i]['description'], resultk[i]['type'], resultk[i]['istatus'], resultk[i]['amount'], resultk[i]['date_add'], resultk[i]['date_paid']];
            arr.push(data2);
        }
        res.setHeader('Content-disposition', 'attachment; filename=report.csv');
        res.csv(arr);
    });


});

app.post('/Myaddress', function (req, res) {

    q.all([dashboard.getAddresses(req, config.mysql, q, req.body.type)]).then(function (results) {
        if (results[0][0].length > 0)
            var doauction = 'update';
        else
            var doauction = 'save';
        q.all(dashboard.saveaddress(req, config.mysql, q, doauction)).then(function (results) {
            res.writeHead(302, {
                'Location': '/dashboard/Myaddress'
            });
            res.end();
            return false;
        });
    });

});

app.get('/Address/:type', function (req, res) {
    $arr['shipping'] = '';
    req.body.type = (typeof (req.param('type')) !== 'undefined') ? req.param('type') : 'shipping';
    q.all([dashboard.getAddresses(req, config.mysql, q, req.body.type)]).then(function (results) {
        if (results[0][0].length > 0)
            $arr['shipping'] = results[0][0][0];

        $arr['type'] = req.body.type;
        common.tplFile('Myaddress.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});


app.get('/referral', function (req, res) {

    $arr['referral'] = $arr['referrallink'] = '';
    $arr['heading_common'] = "Referral";
    q.all(dashboard.getReferral(req, config.mysql, q, 0)).then(function (results) {
        $arr['referrallink'] = cryptos.encrypt(req.session.userid.toString());
        $arr['referral'] = results[0];
        common.tplFile('referral.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.get('/autobid', function (req, res) {
    $arr['referral'] = $arr['referrallink'] = $arr['Autobids'] = $arr['project'] = '';
    q.all([dashboard.getOpenProjects(req, config.mysql, q), dashboard.fetchAutobidlist(req, config.mysql, q)]).then(function (results) {
        $arr['project'] = results[0][0];
        $arr['Autobids'] = results[1][0];
        common.tplFile('autobid.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get('/', function (req, res) {

    res.writeHead(302, {
        'Location': '/'
    });
    res.end();
    return false;
});

app.post('/autobid', function (req, res) {
    q.all(dashboard.checkAutobid(req, config.mysql, q)).then(function (results) {
        if (results[0].length == 0) {
            q.all(dashboard.saveAutobid(req, config.mysql, q));
        }
        res.writeHead(302, {
            'Location': '/dashboard/autobid'
        });
        res.end();
        return false;
    });
});

app.get('/RemoveAddress/:type', function (req, res) {
    $arr['shipping'] = '';
    req.body.type = (typeof (req.param('type')) !== 'undefined') ? req.param('type') : 'shipping';
    q.all([dashboard.removeAddresses(req, config.mysql, q, req.body.type)]).then(function (results) {
        res.writeHead(302, {
            'Location': '/dashboard/Myaddress'
        });
        res.end();
        return false;
    });
});


app.post('/save_notification', function (req, res) {

    console.log("-------====================", req.body);
    req.body.result_userid = req.session.userid;
    dashboard.save_usernotify(req, config.mysql, q);

    console.log(req.body.buyermail_settings + '::' + req.body.sellersms_settings)
    res.writeHead(302, {
        'Location': '/dashboard/notification_manager'
    });
    res.end();
    return false;


});

app.get('/blockusers', function (req, res) {
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;

    q.all([dashboard.blocked_users(req, config.mysql, q, 0), dashboard.blocked_users(req, config.mysql, q, 1)]).then(function (results) {

        $arr['blocked'] = results[0][0];
        $arr['your_mailid'] = req.session.email;
        console.log(req.session.email);
        $arr['cnt'] = results[1][0].length;
        console.log($arr['blocked']);
        var pagination = require('pagination');
        $arr['uid'] = req.session.id;
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/blockusers',
            current: req.body.page,
            rowsPerPage: 15,
            totalResult: $arr['cnt']
        });
        $arr.pagination_html = paginator.render();
        common.tplFile('block_users.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.post('/blockids', function (req, res) {

    dashboard.block_user(req, config.mysql, q);
    dashboard.block_bids_of_user(req, config.mysql, q);
    dashboard.block_buys_of_user(req, config.mysql, q);

    res.writeHead(302, {
        'Location': '/dashboard/blockusers'
    });
    res.end();
    return false;


});

app.get('/unblock/:id', function (req, res) {

    req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    q.all([dashboard.unblock_user(req, config.mysql, q, req.body.id)]).then(function (results) {
        res.writeHead(302, {
            'Location': '/dashboard/blockusers'
        });
        res.end();
        return false;
    });
});

app.post('/checkid', function (req, res) {

    q.all([dashboard.check_uid(req, config.mysql, q, req.body.bid)]).then(function (results) {
        if (results[0][0].length > 0) {
            res.send("blocked");
        } else {
            res.send("notblocked");
        }
    });


});
app.post('/check_if_exist', function (req, res) {

    q.all([dashboard.check_if_exist(req, config.mysql, q, req.body.bid)]).then(function (results) {
        if (results[0][0].length > 0) {
            res.send("exist");
        } else {
            res.send("notexist");
        }
    });


});

app.post('/getmailids', function (req, res) {
    var lists = '';
    q.all([dashboard.get_mail_ids(req, config.mysql, q, req.body.bid)]).then(function (results) {
        if (results[0][0].length > 0) {
            for (var i = 0; i < results[0][0].length; i++) {
                lists += '<li><a role="menuitem" tabindex="-1" href="javascript:void(0);">' + results[0][0][i].email + '</a></li>'
            }
        } else {
            lists += '<li>No mail Ids</li>';
        }
        res.send(lists);
    });


});

app.post('/transfer_ownership', function (req, res) {

    message = require('../module/message');

    q.all([dashboard.getuser_details(req, config.mysql, q, req.body.transfer_mail), dashboard.product_details(req, config.mysql, q, req.body.product_id), dashboard.transfer_product(req, config.mysql, q), dashboard.cancel_ownerbids(req, config.mysql, q)]).then(function (results) {
        console.log(results[0][0]);
        req.body.toid = results[0][0][0].id;
        req.body.first_name = results[0][0][0].first_name;
        req.body.last_name = results[0][0][0].last_name;
        req.body.r_id = Date.parse(new Date()) / 1000;
        req.body.toemail = req.body.transfer_mail;
        req.body.fromid = req.session.user_id;
        req.body.pid = req.body.product_id;
        req.body.subject = 'You are the new owner';
        req.body.message = 'You are the new owner of ' + results[1][0][0].title + ' .Happy Selling !.';
        message.addmessages(req, config.mysql, q);

        res.writeHead(302, {
            'Location': '/dashboard/my'
        });
        res.end();
        return false;

    });


});
app.get(['/newmessages', '/newmessages/:action'], function (req, res) {
    if (req.session.sellers == 1) {
        $arr['sellers'] = 1;
    } else {
        $arr['sellers'] = 0;
    }
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['mysales'] = 'active';
    messages = require('../module/message');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    messages.updateviewed(req, config.mysql, q);
    $arr['action'] = req.body.action;
    if (req.body.action == 'compose') {
        common.tplFile('compose.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    } else {
        q.all([messages.mymessages(req, config.mysql, q, 0), messages.mymessages(req, config.mysql, q, 1), messages.mymessages(req, config.mysql, q, 2), adwords.show_ads(req, config.mysql, q, 'Messages')]).then(function (results) {
            $arr['pagination'] = results[1][0].length;
            $arr['messages'] = results[0][0];
            $arr['unreadmessage'] = results[2][0].length;
            $arr['adwords'] = results[3][0];
            $arr['keywords'] = "";
            $arr.page_name = 'Messages';
            var parameter = req.body.action;
            if (req.body.action == 'search') {
                req.body.keyword = req.query.keyword;
                parameter += '?keyword=' + req.query.keyword
                $arr['keywords'] = req.query.keyword;
            }
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/newmessages/' + parameter,
                current: req.body.page,
                rowsPerPage: 5,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();
            common.tplFile('temp_message.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});

// app.get(['/mysales/', '/mysales/:page'], function(req, res) {

//     delete $arr['menu'];
//     $arr['menu'] = [];
//     $arr['menu']['mysales'] = 'active';
//     $arr.error = '';
//     var bids = require('../module/bid');
//     var products = require('../module/products');
//     var data = bids.SearchPageNo(req, config.mysql, q);
//     // req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 0;

//     req.body.page = data.dspage;
//     req.body.perlimit = 5;
//     var adwords = require('../module/adwords');
//     var dateFormat = require('dateformat');
//     q.all([products.mysoldproducts(req, config.mysql, q, 0), products.mysoldproducts(req, config.mysql, q, 1), adwords.show_ads(req, config.mysql, q, 'Seller Dashboard')]).then(function(results) {
//         $arr['projects'] = products.shortDescribe(results[0][0]);
//         $arr['pagination'] = results[1][0].length;
//         $arr['adwords'] = results[2][0];
//         $arr.page_name = 'Seller Dashboard';
//         var pagination = require('pagination');
//         fquery = '';
//         /* Counter */

//         $arr['cnt'] = results[1][0].length;
//         var start_count = ((req.body.page - 1) * req.body.perlimit) + 1;
//         var end_count = 0;
//         $arr['start_count'] = start_count;
//         if (results[1][0].length - start_count > req.body.perlimit) {
//             end_count = start_count + (req.body.perlimit - 1);
//         } else {
//             end_count = start_count + (results[1][0].length - start_count);
//         }
//         $arr['end_count'] = end_count;

//         /* Counter */

//         if (typeof(req.param('cmd')) !== 'undefined') {
//             fquery = '?cmd=' + req.param('cmd');
//         }
//         var paginator = new pagination.SearchPaginator({
//             prelink: '/dashboard/mysales' + fquery,
//             current: req.body.page,
//             rowsPerPage: req.body.perlimit,
//             totalResult: $arr['pagination']
//         });
//         $arr['dateFormat'] = dateFormat;
//         $arr['pagination_html'] = paginator.render();
//         common.tplFile('mysales.tpl');
//         common.headerSet(1);
//         common.loadTemplateHeader(req, res, $arr);
//     });
// });

app.get(['/newpayments'], function (req, res) {

    if (req.session.sellers == 1) {
        $arr['sellers'] = 1;
    } else {
        $arr['sellers'] = 0;
    }
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['credits'] = 'active';
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    $arr.externalcss = ['buyer2', 'change_psd'];
    q.all([dashboard.getPayments(req, config.mysql, q), dashboard.getAllPayments(req, config.mysql, q)]).then(function (results) {
        $arr['payments'] = results[0][0];

        $arr['cnt'] = results[1][0].length;
        var pagination = require('pagination');
        var start_count = ((req.body.page - 1) * 10) + 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        if (results[1][0].length - start_count > 10) {
            end_count = start_count + 9;
        } else {
            end_count = start_count + (results[1][0].length - start_count);
        }
        $arr['end_count'] = end_count;
        var end_count = ((req.body.page - 1) * 10) + 1;
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/newpayments',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['cnt']
        });
        $arr.pagination_html = paginator.render();

        common.tplFile('newpayments.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });
});

app.get('/myorders', function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['orders'] = 'active';
    var bids = require('../module/bid');
    var dashboard = require('../module/dashboard');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 5;
    q.all([dashboard.mybuynow(req, config.mysql, q, 1), dashboard.mybuynow(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;

        /* Counter */

        $arr['cnt'] = results[1][0].length;
        var start_count = ((req.body.page - 1) * req.body.perlimit) + 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        if (results[1][0].length - start_count > req.body.perlimit) {
            end_count = start_count + (req.body.perlimit - 1);
        } else {
            end_count = start_count + (results[1][0].length - start_count);
        }
        $arr['end_count'] = end_count;

        /* Counter */

        $arr['mybids'] = results[0][0];
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/myorders',
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('myorders.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.post('/myorders', function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['orders'] = 'active';
    var bids = require('../module/bid');
    var dashboard = require('../module/dashboard');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 5;


    q.all([dashboard.myorders(req, config.mysql, q, 1), dashboard.myorders(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = results[0][0];
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';

        /* Counter */

        $arr['cnt'] = results[0][0].length;
        var start_count = 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        $arr['end_count'] = results[0][0].length;

        /* Counter */



        if (req.body.searchtitle) {
            $arr['searchtitle'] = req.body.searchtitle;
        }
        if (req.body.searchdateFrom) {
            $arr['datefrom'] = req.body.searchdateFrom;
        }
        if (req.body.searchdateTo) {
            $arr['dateto'] = req.body.searchdateTo;
        }
        if (req.body.pricefrom) {
            $arr['pricefrom'] = req.body.pricefrom;
        }
        if (req.body.priceto) {
            $arr['priceto'] = req.body.priceto;
        }

        common.tplFile('myorders.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.post(['/mysales/', '/mysales/:page'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['mysales'] = 'active';
    $arr.error = '';
    var bids = require('../module/bid');
    var products = require('../module/products');
    var data = bids.SearchPageNo(req, config.mysql, q);
    // req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 0;

    req.body.page = data.dspage;
    req.body.perlimit = 5;
    var adwords = require('../module/adwords');
    var dateFormat = require('dateformat');
    q.all([products.mysoldproductssearch(req, config.mysql, q, 0), products.mysoldproductssearch(req, config.mysql, q, 1), adwords.show_ads(req, config.mysql, q, 'Seller Dashboard')]).then(function (results) {
        $arr['projects'] = products.shortDescribe(results[0][0]);
        $arr['pagination'] = results[1][0].length;
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Seller Dashboard';
        var pagination = require('pagination');
        fquery = '';
        /* Counter */

        $arr['cnt'] = results[1][0].length;
        var start_count = 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        $arr['end_count'] = results[1][0].length;

        /* Counter */
        if (req.body.searchsales) {
            $arr['searchsales'] = req.body.searchsales;
        }
        if (req.body.date_from) {
            $arr['date_from'] = req.body.date_from;
        }
        if (req.body.date_to) {
            $arr['dateto'] = req.body.date_to;
        }
        if (req.body.minprice_vendor) {
            $arr['minprice_vendor'] = req.body.minprice_vendor;
        }
        if (req.body.maxprice_vendor) {
            $arr['maxprice_vendor'] = req.body.maxprice_vendor;
        }


        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/mysales' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });
        $arr['dateFormat'] = dateFormat;

        common.tplFile('mysales.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.get(['/myselling/', '/myselling/:page'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['myselling'] = 'active';
    var adwords = require('../module/adwords');
    $arr.error = '';
    var products = require('../module/products');
    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 5;

    //req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 0;
    var dateFormat = require('dateformat');
    q.all([products.myproducts(req, config.mysql, q, 0), products.myproducts(req, config.mysql, q, 1), adwords.show_ads(req, config.mysql, q, 'Seller Dashboard')]).then(function (results) {
        $arr['projects'] = products.shortDescribe(results[0][0]);
        $arr['pagination'] = results[1][0].length;
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Seller Dashboard';
        var pagination = require('pagination');
        fquery = '';
        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
            $arr['cmd'] = req.param('cmd');

        }
        /* Counter */

        $arr['cnt'] = results[0][0].length;
        var start_count = 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        $arr['end_count'] = results[0][0].length;

        /* Counter */


        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/myselling' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });
        $arr['dateFormat'] = dateFormat;
        $arr['pagination_html'] = paginator.render();
        common.tplFile('myselling.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (error) {
        console.log("Error : " + error.stack);
        throw error;
    }).done();
});

app.post(['/myselling/', '/myselling/:page'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['myselling'] = 'active';
    var adwords = require('../module/adwords');
    $arr.error = '';
    var products = require('../module/products');
    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 5;

    //req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 0;
    var dateFormat = require('dateformat');
    q.all([products.myproductssearch(req, config.mysql, q, 0), products.myproductssearch(req, config.mysql, q, 1), adwords.show_ads(req, config.mysql, q, 'Seller Dashboard')]).then(function (results) {
        $arr['projects'] = products.shortDescribe(results[0][0]);
        $arr['pagination'] = results[1][0].length;
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Seller Dashboard';
        var pagination = require('pagination');


        /* Counter */

        $arr['cnt'] = results[1][0].length;
        var start_count = 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        $arr['end_count'] = results[1][0].length;

        /* Counter */

        if (req.body.searchsales) {
            $arr['searchsales'] = req.body.searchsales;
        }
        if (req.body.date_from) {
            $arr['date_from'] = req.body.date_from;
        }
        if (req.body.date_to) {
            $arr['dateto'] = req.body.date_to;
        }
        if (req.body.minprice_vendor) {
            $arr['minprice_vendor'] = req.body.minprice_vendor;
        }
        if (req.body.maxprice_vendor) {
            $arr['maxprice_vendor'] = req.body.maxprice_vendor;
        }

        fquery = '';
        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
            $arr['cmd'] = req.param('cmd');

        }

        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/my' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });
        $arr['dateFormat'] = dateFormat;

        common.tplFile('myselling.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (error) {
        console.log("Error : " + error.stack);
        throw error;
    }).done();
});
app.get(['/activebids', '/activebids:page'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['orders'] = 'active';
    var module = require('../module');
    var bids = require('../module/bid');
    var adwords = require('../module/adwords');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 5;
    q.all([bids.mybids(req, config.mysql, q, 1), bids.mybids(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = products.shortDescribe(results[0][0]);
        $arr['adwords'] = results[2][0];
        $arr['cmd'] = req.param('cmd');
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        fquery = '';

        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/activebids' + fquery,
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        /* Counter */

        $arr['cnt'] = results[1][0].length;
        var start_count = ((req.body.page - 1) * req.body.perlimit) + 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        if (results[1][0].length - start_count > req.body.perlimit) {
            end_count = start_count + (req.body.perlimit - 1);
        } else {
            end_count = start_count + (results[1][0].length - start_count);
        }
        $arr['end_count'] = end_count;

        /* Counter */

        $arr['pagination_html'] = paginator.render();
        common.tplFile('activebids.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

app.post(['/activebids', '/activebids:page'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['orders'] = 'active';
    var module = require('../module');
    var bids = require('../module/bid');
    var adwords = require('../module/adwords');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 5;
    q.all([bids.activebids(req, config.mysql, q, 1), bids.activebids(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = products.shortDescribe(results[0][0]);
        $arr['adwords'] = results[2][0];
        $arr['cmd'] = req.param('cmd');
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        fquery = '';

        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/activebids' + fquery,
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });



        /* Counter */

        $arr['cnt'] = results[0][0].length;
        var start_count = 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        $arr['end_count'] = results[0][0].length;

        /* Counter */

        if (req.body.searchtitle) {
            $arr['searchtitle'] = req.body.searchtitle;
        }
        if (req.body.searchdateFrom) {
            $arr['datefrom'] = req.body.searchdateFrom;
        }
        if (req.body.searchdateTo) {
            $arr['dateto'] = req.body.searchdateTo;
        }
        if (req.body.pricefrom) {
            $arr['pricefrom'] = req.body.pricefrom;
        }
        if (req.body.priceto) {
            $arr['priceto'] = req.body.priceto;
        }


        common.tplFile('activebids.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});
app.get(['/wonbids', '/wonbids:page'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['orders'] = 'active';
    var adwords = require('../module/adwords');
    var bids = require('../module/bid');
    var dateFormat = require('dateformat');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 5;

    q.all([bids.mywon(req, config.mysql, q, 1), bids.mywon(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = products.shortDescribe(results[0][0]);
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        fquery = '';
        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }

        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/wonbids' + fquery,
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        /* Counter */

        $arr['cnt'] = results[1][0].length;
        var start_count = ((req.body.page - 1) * req.body.perlimit) + 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        if (results[1][0].length - start_count > req.body.perlimit) {
            end_count = start_count + (req.body.perlimit - 1);
        } else {
            end_count = start_count + (results[1][0].length - start_count);
        }
        $arr['end_count'] = end_count;

        /* Counter */

        $arr['pagination_html'] = paginator.render();
        common.tplFile('wonbids.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

app.post(['/wonbids', '/wonbids:page'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['orders'] = 'active';
    var adwords = require('../module/adwords');
    var bids = require('../module/bid');
    var dateFormat = require('dateformat');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 5;

    q.all([bids.wonbids(req, config.mysql, q, 1), bids.wonbids(req, config.mysql, q, 0), adwords.show_ads(req, config.mysql, q, 'Buyer Dashboard')]).then(function (results) {
        $arr['pagination'] = results[1][0].length;
        $arr['mybids'] = products.shortDescribe(results[0][0]);
        $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        fquery = '';
        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }

        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/wonbids' + fquery,
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        /* Counter */

        $arr['cnt'] = results[0][0].length;
        var start_count = 1;
        var end_count = 0;
        $arr['start_count'] = start_count;
        $arr['end_count'] = results[0][0].length;

        /* Counter */

        if (req.body.searchtitle) {
            $arr['searchtitle'] = req.body.searchtitle;
        }
        if (req.body.searchdateFrom) {
            $arr['datefrom'] = req.body.searchdateFrom;
        }
        if (req.body.searchdateTo) {
            $arr['dateto'] = req.body.searchdateTo;
        }
        if (req.body.pricefrom) {
            $arr['pricefrom'] = req.body.pricefrom;
        }
        if (req.body.priceto) {
            $arr['priceto'] = req.body.priceto;
        }


        common.tplFile('wonbids.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/buyer'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['buyer_dash'] = 'active';
    delete req.session.sellers;
    var profile = require('../module/profile_settings');
    var message = require('../module/message');

    q.all([profile.profileDetails(req, config.mysql, q, ['email', 'id', 'first_name', 'last_name', 'aboutme', 'image', 'avatar', 'address1', 'address2', 'country', 'state', 'city', 'zip', 'phone', 'paypal_address', 'profile_url', 'verifyphone', 'created_at']), message.dashmessages(req, config.mysql, q, 1), dashboard.mybuynow(req, config.mysql, q, 0), dashboard.get_debits(req, config.mysql, q)]).then(function (results) {
        $arr['users'] = results[0][0][0];
        $arr['messages'] = results[1][0];
        $arr['products'] = results[2][0];
        $arr['debits'] = results[3][0][0].total_purchase;
        $arr['orders'] = results[3][0][0].total_orders;

        common.tplFile('buyer.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();


});
app.get(['/seller'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['seller_dash'] = 'active';

    req.session.sellers = 1;

    var profile = require('../module/profile_settings');
    var message = require('../module/message');
    var products = require('../module/products');
    req.body.page = 1;
    req.body.perlimit = 5;

    q.all([profile.profileDetails(req, config.mysql, q, ['email', 'id', 'first_name', 'last_name', 'aboutme', 'image', 'avatar', 'address1', 'address2', 'country', 'state', 'city', 'zip', 'phone', 'paypal_address', 'profile_url', 'verifyphone', 'created_at']), message.dashmessages(req, config.mysql, q, 1), products.myproducts(req, config.mysql, q, 0), dashboard.sale_figure(req, config.mysql, q)]).then(function (results) {
        $arr['users'] = results[0][0][0];
        $arr['messages'] = results[1][0];
        $arr['products'] = results[2][0];
        $arr['products_count'] = results[2][0].length;
        $arr['sale_amount'] = results[3][0][0].sale_amount;
        $arr['total_sales'] = results[3][0][0].total_sales;

        common.tplFile('seller.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();


});

/*Db market*/
app.get(['/dbmarket', '/dbmarket:page'], function (req, res) {

    console.log("dbmarket");
    $arr['myrequests'] = 1;
    // var module = require('../module');
    var bids = require('../module/bid');
    // var adwords = require('../module/adwords');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.filter = typeof (req.param('filter')) !== 'undefined' ? req.param('filter') : '';
    req.body.page = data.dspage;

    req.body.perlimit = 10;


    q.all([prodRequests.dbmarketbuyerpurchase(req, config.mysql, q, 0),
    prodRequests.dbmarketbuyerpurchase(req, config.mysql, q, 1),
        // prodRequests.dbmarketbuyerrpurchase(req, config.mysql, q, 0),
        // prodRequests.dbmarketbuyerrpurchase(req, config.mysql, q, 1),
        // prodRequests.dbmarketbuyernego(req, config.mysql, q, 0),
        // prodRequests.dbmarketbuyernego(req, config.mysql, q, 1),
        // prodRequests.dbmarketbuyernegodec(req, config.mysql, q, 0),
        // prodRequests.dbmarketbuyernegodec(req, config.mysql, q, 1)
    ]).then(function (results) {

        //buy records for login user
        // console.log("buyers products here : ", JSON.stringify(results[0][0]));

        $arr['pagination'] = results[1][0][0].productsCount;
        var prdt = common.addDecimalPlaces('buynow_rec', results[0][0]);
        $arr['myProducts'] = products.shortDescribe(prdt);
        // $arr['myProducts2'] = products.shortDescribe(results[2][0]);
        // $arr['myProducts3'] = products.shortDescribe(results[4][0]);
        // $arr['myProducts4'] = products.shortDescribe(results[6][0]);
        // console.log("described products" + JSON.stringify($arr['myProducts']));
        // $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }
        if(fquery=='') { fquery +='?'; }else{ fquery += '&'; }
        fquery += 'filter=' + req.body.filter;
        $arr['filter'] = req.body.filter;
    
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/dbmarket/' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";

        common.tplFile('dbmarket.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log("err", err.stack);
        throw err;
    }).done();

});
/* DB market Ends here */


/*---------------------------------- Open bid users dashboard - starts -----------------------------------------*/
/* Edit product for openbid market */
app.get(['/openbid/product/edit/:id', '/openbid/product/edit/:id/:msg'], function (req, res) {



    // app.get(['/openbid/product/edit/:id', '/openbid/product/edit/:id/:sid'], function(req, res) {
    if (common.checkLogin(req, res, 0)) {
        $arr['openbid'] = 1;
        var products = require('../module/products');
        var dateFormat = require('dateformat');
        $arr.datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
        req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
        $arr.msg = (typeof (req.param('msg')) === 'undefined') ? '' : req.param('msg');

        if (req.param('msg') == 'success') {
            $arr.updation_status = true;
        } else {
            $arr.updation_status = false;
        }

        $arr.externalcss = ['jquery.datetimepicker'];
        $arr.externaljs = ['jquery.datetimepicker'];
        $arr['heading_common'] = "POST YOUR ITEM";

        // $arr.sid = req.body.sid = (typeof(req.param('sid')) === 'undefined') ? 0 : req.param('sid');

        // $arr['fee'] = global.general.feature_listing_fee;
        // var user = require('../module/user');

        async.series({

            getproductdetails: function (product_cbk) {
                console.log('getproductdetails');
                q.all([products.productDetail(req, config.mysql, q),products.testresultImages(req, config.mysql, q),products.certImages(req, config.mysql, q)]).then(function (results) {

                    // console.log(JSON.stringify(results[0][0]));

                        if (results[2][0].length > 0) {
                            $arr['certs_analysis'] = results[2][0][0];
                            $arr['certs_analysis_length'] = results[2][0].length;
                        }

                        if (results[1][0].length > 0) {
                            $arr['testresults'] = results[1][0][0];
                            $arr['testresults_length'] = results[1][0].length;
                        }

                    if (results[0][0].length > 0) {

                        /* if (results[0][0][0].bids != 0) {
                            res.writeHead(302, {
                                'Location': '/dashboard/myrequests'
                            });
                            res.end();
                            return false;
                        } */

                        if (req.session.userid == results[0][0][0].user_id) {
                            req.body.seller = 1;
                        }

                        if (req.session.userid != results[0][0][0].user_id) {
                            res.writeHead(302, {
                                'Location': '/dashboard/myrequests'
                            });
                            res.end();
                            return false;
                        }

                        var getUser = {
                            type: 'userid',
                            value: results[0][0][0].user_id
                        }
                        faAPI.getUserByType(req, getUser, function (apiErr, apiRes) {
                            if (apiErr) {
                                product_cbk(null, null)
                            } else {
                                if (results[0][0][0].sold != 0) {
                                    res.writeHead(302, {
                                        'Location': '/dashboard/myrequests'
                                    });
                                    res.end();
                                    return false;
                                } else {
                                    results[0][0][0]['username'] = apiRes.user.username
                                    results[0][0][0]['email'] = apiRes.user.email
                                    results[0][0][0]['first_name'] = apiRes.user.first_name
                                    results[0][0][0]['last_name'] = apiRes.user.last_name
                                    results[0][0][0]['role'] = apiRes.user.role
                                    results[0][0][0]['city'] = apiRes.user.city
                                    results[0][0][0]['country'] = apiRes.user.country
                                    results[0][0][0]['paypal_address'] = apiRes.user.paypal_address
                                    results[0][0][0]['user_avatar'] = apiRes.user.avatar
                                    results[0][0][0]['since'] = dateFormat(apiRes.user.created_at, "dd/mm/yyyy")

                                    $arr['projects'] = products.shortDescribe(results[0][0]);

                                    console.log(JSON.stringify($arr['projects']));
                                    $arr['projects'] = $arr['projects'][0];
                                    $arr['projects']['sell_location'] = (typeof ($arr['projects']['sell_location']) == 'undefined') ? '' : $arr['projects']['sell_location'];

                                    if (new Date($arr['projects']['date_added']) < new Date($arr.datenow)) {
                                        $arr.datenow = dateFormat(new Date($arr['projects']['date_added']), "yyyy-mm-dd HH:MM:ss");
                                    }

                                    $arr['home_page_fee'] = global.general.home_page_listing_fee;
                                    // $arr['projects']['date_add'] = dateFormat(new Date($arr['projects']['date_added']), "yyyy/mm/dd HH:MM");
                                    $arr['projects']['date_close'] = dateFormat(new Date($arr['projects']['date_closed']), "yyyy/mm/dd HH:MM");
                                    $arr['pid'] = common.randomNumber(5);
                                    $arr.oneusd = req.session.currencyrate;
                                    $arr['currencytype'] = config.productsetting.currency;

                                    if (config.productsetting.currency == 'dollar') {
                                        $arr['projects']['sprice'] = (Number($arr['projects']['sprice']) / Number($arr.oneusd)).toFixed(2);
                                        $arr['projects']['rprice'] = (Number($arr['projects']['rprice']) / Number($arr.oneusd)).toFixed(2);
                                        $arr['projects']['shipping_price'] = (Number($arr['projects']['shipping_price']) / Number($arr.oneusd)).toFixed(2);
                                        $arr['projects']['bprice'] = (Number($arr['projects']['bprice']) / Number($arr.oneusd)).toFixed(2);
                                        $arr['projects']['mprice'] = (Number($arr['projects']['mprice']) / Number($arr.oneusd)).toFixed(2);
                                        $arr['projects']['iprice'] = (Number($arr['projects']['iprice']) / Number($arr.oneusd)).toFixed(2);
                                        $arr['projects']['wprice'] = (Number($arr['projects']['wprice']) / Number($arr.oneusd)).toFixed(2);
                                        $arr['projects']['wsprice'] = (Number($arr['projects']['wsprice']) / Number($arr.oneusd)).toFixed(2);
                                    }
                                    product_cbk(null, null);
                                }
                            }
                        })
                    } else {
                        product_cbk(null, null);
                    }
                }).fail(function (err) {

                    console.log(err.stack);
                    throw err;
                }).done();
            },
            getproductImage: function (productImage_cbk) {
                console.log('getproductImage');
                q.all([products.productImage(req, config.mysql, q)]).then(function (produc_im_res) {
                    if (produc_im_res[0][0].length > 0) {
                        $arr['image'] = produc_im_res[0][0];
                        productImage_cbk(null, null)
                    } else {
                        productImage_cbk(null, null)
                    }
                }).fail(function (err) {

                    console.log(err.stack);
                    throw err;
                }).done();

            },
            getuserInfo: function (userInfo_cbk) {
                console.log('getuserInfo');
                faAPI.userInfo(req, req.session.userid, function (err, resp) {
                    if (err) {
                        $arr.user = ''
                        userInfo_cbk(null, null)
                    }
                    if (resp) {
                        $arr.user = resp.user
                        userInfo_cbk(null, null)
                    }
                })

            },
            getlocations: function (locations_cbk) {
                console.log('getlocations');
                q.all([common.locations(req, config.mysql, q)]).then(function (locations) {
                    if (locations[0][0].length > 0) {
                        $arr.locations = locations[0][0];
                        locations_cbk(null, null)
                    } else {
                        $arr.locations = ''
                        locations_cbk(null, null)
                    }

                }).fail(function (err) {

                    console.log(err.stack);
                    throw err;
                }).done();
            },
            getshow_ads: function (show_ads_cbk) {
                console.log('getshow_ads');
                q.all([adwords.show_ads(req, config.mysql, q, 'Sell an Item')]).then(function (show_ads) {
                    if (show_ads[0][0].length > 0) {
                        $arr['adwords'] = show_ads[0][0];
                        show_ads_cbk(null, null)
                    } else {
                        $arr['adwords'] = ''
                        show_ads_cbk(null, null)
                    }
                }).fail(function (err) {

                    console.log(err.stack);
                    throw err;
                }).done();
            }
        }, function (err, result) {
            common.tplFile('post-item-open-market.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        })
    } else return false;
});

/* openbid market - edit product */
app.post('/openbid/product/save', function (req, res) {

    // console.log(JSON.stringify(req.body));
    if (common.checkLogin(req, res, 0)) {
        var attach = require('../module/attach');
        var admin = require('../module/admin');
        projects = require('../module/products');

        delete req.session.featured_home_listing;
        delete req.session.featured_add;
        delete req.session.home_listing_add;

        req.body.id = (typeof (req.body.id) === 'undefined') ? 0 : req.body.id;
        req.body.cid = (typeof (req.body.cid) == 'undefined') ? req.body.mcid : req.body.cid;

        // if (req.body.id > 0) {
        // admin.deleteAttachment(config.mysql, q, req);

        var total_size = 0;
        q.all([projects.productDetail(req, config.mysql, q)]).then(function (result) {

            // console.log(req.files.product_image);
            // console.log(req.files.test_results);
            if (req.files.product_image != undefined) {
                console.log('calling save attachemnt');
                q.all([attach.saveAttachments(req, config.mysql, q, result[0][0][0].id)]).then(function (result) {
                    console.log("save attachments");
                    // console.log(JSON.stringify(result));
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

            console.log('uploading test results');
            console.log('req.files.test_results', req.files.test_results);
            if (req.files.test_results !== undefined) {
                q.all([attach.saveTestresultss(req,req.files.test_results, config.mysql, q, result[0][0][0].id)]).then(function(result) {
                    console.log('test results ----',JSON.stringify(result));
                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

            console.log('uploading test cert_analysis_img');
            if (req.files.cert_analysis_img !== undefined) {
                q.all([attach.saveTestresultss(req,req.files.cert_analysis_img, config.mysql, q, result[0][0][0].id)]).then(function(result) {
                    console.log('saveTestresultss ----',JSON.stringify(result));
                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

            q.all([openBidProducts.updateProduct(req, config.mysql, q, result[0][0][0])]).then(function (results) {

                res.writeHead(302, { 'Location': '/product/view/' + result[0][0][0].id });
                res.end();
                return false;

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();


        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

/* openbid dashboard - open task */
app.get(['/myrequests', '/myrequests/:prodid'], function (req, res) {
    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        console.log("myrequests");
        $arr['myrequests'] = 1;
        $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";

        $arr.externalcss = ['jquery-ui-autocomplete'];
        $arr.externaljs = ['jquery-ui-autocomplete'];

        // var module = require('../module');
        var bids = require('../module/bid');
        // var adwords = require('../module/adwords');
        var prodRequests = require('../module/prod_requests');
        var data = bids.SearchPageNo(req, config.mysql, q);
        req.body.productid = typeof (req.params.prodid) !== 'undefined' ? req.params.prodid : 'all';
        req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
        req.body.page = data.dspage;

        req.body.perlimit = 10;

        q.all([
            prodRequests.buyerRequests(req, config.mysql, q, 0),
            prodRequests.buyerRequests(req, config.mysql, q, 1),
            openBidProducts.getAllProdNames(req, config.mysql, q)
        ]).then(function (results) {

            console.log("All products names are here :" + JSON.stringify(results[2][0]));
            $arr['prod_titles'] = _.pluck(results[2][0], 'title');
            console.log(JSON.stringify($arr['prod_titles']));

            //buy records for login user
            // console.log("buyers products here : ", JSON.stringify(results[0][0]));




            $arr['pagination'] = results[1][0][0].productsCount;
            $arr['myProducts'] = products.shortDescribe(results[0][0]);

            // console.log("described products" + JSON.stringify($arr['myProducts']));
            // $arr['adwords'] = results[2][0];
            $arr.page_name = 'Buyer Dashboard';
            var pagination = require('pagination');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });


            if (typeof (req.param('search')) !== 'undefined') {
                fquery = '?search=' + req.param('search');
            }
            console.log('page', req.body.page);
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/myrequests/' + req.body.productid + '/' + fquery,

                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('myrequests.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {

            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

app.get(['/dbmarket/recuring', '/dbmarket/recuring:page'], function (req, res) {

    console.log("dbmarket");
    $arr['myrequests'] = 1;
    // var module = require('../module');
    var bids = require('../module/bid');
    $arr['heading_common'] = "Recuring schedule";
    // var adwords = require('../module/adwords');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;
    req.body.perlimit = 10;

    q.all([
        prodRequests.dbmarketbuyerrpurchase(req, config.mysql, q, 0),
        prodRequests.dbmarketbuyerrpurchase(req, config.mysql, q, 1)
    ]).then(function (results) {

        // buy records for login user
        // console.log("buyers products here : ", JSON.stringify(results[0][0]));

        $arr['pagination'] = results[1][0][0].productsCountr;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);

        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        fquery = common.urlparameter(query, { page: '' });
        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }

        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/dbmarket/recuring' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";

        common.tplFile('dbmarketrecur.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/dbmarket/recuring/view/:id', '/dbmarket/recuring/view/:id/:page'], function (req, res) {

    req.body.id = typeof (req.params.id) !== undefined ? req.params.id : 0;
    var prodRequests = require('../module/prod_requests');

    q.all([
        prodRequests.getRpurchaseById(req, config.mysql, q),
        prodRequests.getRScheculeById(req, config.mysql, q),
        prodRequests.countPaidSchedules(req.body.id, config.mysql, q)
    ]).then(function (results) {

        console.log(JSON.stringify(results));

        $arr.recur_data = products.shortDescribe(results[0][0]);
        $arr.recur_data = $arr.recur_data[0];
        $arr.recur_schedules = results[1][0];
        $arr.recur_paid = results[2][0][0].paid_rsch;

        common.tplFile('recurpage.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

// console.log("dbmarket");
// $arr['myrequests'] = 1;
// // var module = require('../module');
// var bids = require('../module/bid');
// // var adwords = require('../module/adwords');
// var prodRequests = require('../module/prod_requests');
// var data = bids.SearchPageNo(req, config.mysql, q);

// req.body.page = data.dspage;

// req.body.perlimit = 10;

// q.all([prodRequests.dbmarketbuyerrpurchase(req, config.mysql, q, 0), prodRequests.dbmarketbuyerrpurchase(req, config.mysql, q, 1)]).then(function(results) {

//     //buy records for login user
//     // console.log("buyers products here : ", JSON.stringify(results[0][0]));
//     $arr['pagination'] = results[1][0][0].productsCountr;
//     $arr['myProducts'] = products.shortDescribe(results[0][0]);
//     // $arr['myProducts2'] = products.shortDescribe(results[2][0]);
//     //$arr['myProducts3'] = products.shortDescribe(results[4][0]);
//     // $arr['myProducts4'] = products.shortDescribe(results[6][0]);
//     // $arr['adwords'] = results[2][0];
//     $arr.page_name = 'Buyer Dashboard';
//     var pagination = require('pagination');
//     fquery = '';

//     if (typeof(req.param('cmd')) !== 'undefined') {
//         fquery = '?cmd=' + req.param('cmd');
//     }
//     var paginator = new pagination.SearchPaginator({
//         prelink: '/dashboard/dbmarket/recuring' + fquery,
//         current: data.dspage,
//         rowsPerPage: req.body.perlimit,
//         totalResult: $arr['pagination']
//     });

//     $arr['pagination_html'] = paginator.render();
//     $arr['heading_common'] = "Market Activity Dashboard";
//     common.tplFile('dbmarketrecur.tpl');
//     common.headerSet(1);
//     common.loadTemplateHeader(req, res, $arr);

// }).fail(function(err) {

//     console.log(err.stack);
//     throw err;
// }).done();

app.get(['/dbmarket/negotiation', '/dbmarket/negotiation:page'], function (req, res) {

    console.log("dbmarket");
    $arr['myrequests'] = 1;
    // var module = require('../module');
    var bids = require('../module/bid');
    // var adwords = require('../module/adwords');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;

    req.body.perlimit = 10;

    q.all([
        prodRequests.dbmarketbuyernego(req, config.mysql, q, 0),
        prodRequests.dbmarketbuyernego(req, config.mysql, q, 1)
    ]).then(function (results) {

        //buy records for login user
        // console.log("buyers products here : ", JSON.stringify(results[0][0]));
        $arr['pagination'] = results[1][0][0].productsCountb;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);

        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;
        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/dbmarket/negotiation' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";
        common.tplFile('dbmarketnego.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/dbmarket/rejectorder', '/dbmarket/rejectorder:page'], function (req, res) {

    console.log("dbmarketsssssss");
    $arr['myrequests'] = 1;
    // var module = require('../module');
    var bids = require('../module/bid');
    // var adwords = require('../module/adwords');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;

    req.body.perlimit = 10;

    q.all([prodRequests.dbmarketbuyernegodec(req, config.mysql, q, 0),
    prodRequests.dbmarketbuyernegodec(req, config.mysql, q, 1)
    ]).then(function (results) {

        //buy records for login user
        // console.log("buyers products here : ", JSON.stringify(results[0][0]));
        $arr['pagination'] = results[1][0][0].productsCountb;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);
        // $arr['myProducts2'] = products.shortDescribe(results[2][0]);
        //$arr['myProducts3'] = products.shortDescribe(results[4][0]);
        // $arr['myProducts4'] = products.shortDescribe(results[6][0]);
        // $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;
        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/dbmarket/rejectorder' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";
        common.tplFile('dbmarketnegore.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/seller/selling', '/seller/selling:page'], function (req, res) {

    console.log("sellerselling");
    $arr['myrequests'] = 1;
    // var module = require('../module');
    var bids = require('../module/bid');
    // var adwords = require('../module/adwords');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;

    req.body.perlimit = 10;

    q.all([prodRequests.sellerselling(req, config.mysql, q, 0),
    prodRequests.sellerselling(req, config.mysql, q, 1)
    ]).then(function (results) {

        //buy records for login user
        // console.log("buyers products here : ", JSON.stringify(results[0][0]));
        $arr['pagination'] = results[1][0][0].productsCount;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);
        // $arr['myProducts2'] = products.shortDescribe(results[2][0]);
        //$arr['myProducts3'] = products.shortDescribe(results[4][0]);
        // $arr['myProducts4'] = products.shortDescribe(results[6][0]);
        // $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/seller/selling' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";
        common.tplFile('dbsellselling.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/seller/sold', '/seller/sold:page'], function (req, res) {

    // console.log("sellerselling");
    $arr['myrequests'] = 1;
    // var module = require('../module');
    var bids = require('../module/bid');
    // var adwords = require('../module/adwords');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;
    req.body.perlimit = 5;

    q.all([products.mysoldproducts(req, config.mysql, q, 0),
    products.mysoldproducts(req, config.mysql, q, 1)
    ]).then(function (results) {
        //buy records for login user
        // console.log("buyers products here : ", JSON.stringify(results[0][0]));
        $arr['pagination'] = results[1][0].length;
        var prdt = common.addDecimalPlaces('seller_sold', results[0][0]);
        $arr['myProducts'] = products.shortDescribe(prdt);
        // $arr['myProducts2'] = products.shortDescribe(results[2][0]);
        // $arr['myProducts3'] = products.shortDescribe(results[4][0]);
        // $arr['myProducts4'] = products.shortDescribe(results[6][0]);
        // $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/seller/sold' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";
        common.tplFile('dbsellsold.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/seller/negotiation', '/seller/negotiation:page'], function (req, res) {

    console.log("sellerselling");
    $arr['myrequests'] = 1;
    // var module = require('../module');
    var bids = require('../module/bid');
    // var adwords = require('../module/adwords');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;

    req.body.perlimit = 10;

    q.all([prodRequests.sellernegot(req, config.mysql, q, 0),
    prodRequests.sellernegot(req, config.mysql, q, 1)
    ]).then(function (results) {

        //buy records for login user
        // console.log("buyers products here : ", JSON.stringify(results[0][0]));
        $arr['pagination'] = results[1][0][0].productsCount;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);

        // $arr['adwords'] = results[2][0];
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/seller/negotiation' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";

        common.tplFile('dbsellnego.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});


/* -------------------------------------------------------------------------------------------------------
                               openbid dashboard - Orders to confirm 
       Getting all offers posted by buyers or sellers to users (biddings) for both buy/sell product
       Having AJAX call on this page to confirm (accept/reject/reject with message) the request
-------refer------------1) app.post('/request/:action/:id', function(req, res) { -------------------------
----------------------------------------------------------------------------------------------------------*/
app.get(['/mycorders', '/mycorders/:prodid', '/mycorders/:prodid:page'], function (req, res) {
    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        console.log("mycorders");
        $arr['mycorders'] = 1;
        $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";
        // var module = require('../module');
        var bids = require('../module/bid');
        // var adwords = require('../module/adwords');
        var prodRequests = require('../module/prod_requests');
        var data = bids.SearchPageNo(req, config.mysql, q);


        req.body.productid = typeof (req.params.prodid) !== 'undefined' ? req.params.prodid : 'all';
        req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
        console.log(req.body.productid);
        req.body.page = data.dspage;

        req.body.perlimit = 10;
        var user = require('../module/user');
        q.all([prodRequests.getRequests(req, config.mysql, q, 0), prodRequests.getRequests(req, config.mysql, q, 1)]).then(function (results) {

            //buy records for login user
            // console.log("buyers products here : ", JSON.stringify(results[0][0]));

            $arr['pagination'] = results[1][0][0].req_count;
            $arr['myProducts'] = products.shortDescribe(results[0][0]);
            // $arr['adwords'] = results[2][0];
            $arr.page_name = 'Buyer Dashboard';
            var pagination = require('pagination');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });

            if (typeof (req.param('search')) !== 'undefined') {
                fquery = '?search=' + req.param('search');
            }
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/mycorders/' + req.body.productid + '' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('mycorders.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {

            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

/*-------------------------------------------------------------------------------------------------------------------------
                                openbid dashboard - my offers - displayind all placed bids 
---------------------------------------------------------------------------------------------------------------------------*/
app.get(['/myoffers', '/myoffers/:prodid/'], function (req, res) {

    // console.log(req.param('search'));
    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        console.log("myoffers");
        $arr['myoffers'] = 1;
        $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";
        // var module = require('../module');
        var bids = require('../module/bid');
        // var adwords = require('../module/adwords');
        var prodRequests = require('../module/prod_requests');
        var data = bids.SearchPageNo(req, config.mysql, q);

        req.body.productid = typeof (req.params.prodid) !== 'undefined' ? req.params.prodid : 'all';
        req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
        console.log(req.body.productid);
        req.body.page = data.dspage;
        // req.body.page = req.param('page');
        req.body.perlimit = 10;


        q.all([
            prodRequests.getMyRequests(req, config.mysql, q, 0),
            prodRequests.getMyRequests(req, config.mysql, q, 1)
        ]).then(function (results) {

            //buy records for login user
            // console.log("buyers products here : ", JSON.stringify(results[0][0]));

            $arr['pagination'] = results[1][0][0].req_count;
            $arr['myProducts'] = products.shortDescribe(results[0][0]);
            // $arr['adwords'] = results[2][0];
            $arr.page_name = 'Buyer Dashboard';
            var pagination = require('pagination');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });

            if (typeof (req.param('search')) !== 'undefined') {
                fquery = '?search=' + req.param('search');
            }

            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/myoffers/' + req.body.productid + '/' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('myoffers.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {

            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

/* openbid dashboard - confirm purchases */
app.get(['/mypurchase', '/mypurchase/:prodId', '/mypurchase/:prodId:page'], function (req, res) {
    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        $arr['mypurchase'] = 1;
        $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";

        req.body.productId = (typeof (req.params.prodId) == 'undefined') ? 'all' : req.params.prodId;
        req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
        console.log("mypurchase");
        // var module = require('../module');
        var bids = require('../module/bid');
        // var adwords = require('../module/adwords');
        var prodRequests = require('../module/prod_requests');
        var data = bids.SearchPageNo(req, config.mysql, q);

        req.body.page = data.dspage;

        req.body.perlimit = 10;

        q.all([
            prodRequests.getConfirmedOffers(req, config.mysql, q, 0, "buy"),
            prodRequests.getConfirmedOffers(req, config.mysql, q, 1, "buy")
        ]).then(function (results) {

            //buy records for login user
            // console.log("buyers products here : ", JSON.stringify(results[0][0]));

            $arr['pagination'] = results[1][0][0].req_count;
            $arr['myProducts'] = products.shortDescribe(results[0][0]);
            // $arr['adwords'] = results[2][0];
            $arr.page_name = 'Buyer Dashboard';
            var pagination = require('pagination');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });

            if (typeof (req.param('search')) !== 'undefined') {
                fquery = '?search=' + req.param('search');
            }
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/mypurchase' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('myconfoffers.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

/* openbid dashboard - rejected purchases */
// app.get(['/myrpurchase', '/myrpurchase:page'], function (req, res) {
app.get(['/myrpurchase', '/myrpurchase/:prodId', '/myrpurchase/:prodId:page'], function (req, res) {
    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        req.body.productId = (typeof (req.params.prodId) == 'undefined') ? 'all' : req.params.prodId;
        req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';

        $arr['myrpurchase'] = 1;
        $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";
        console.log("mycorders");
        // var module = require('../module');
        var bids = require('../module/bid');
        // var adwords = require('../module/adwords');
        var prodRequests = require('../module/prod_requests');
        var data = bids.SearchPageNo(req, config.mysql, q);

        req.body.page = data.dspage;

        req.body.perlimit = 10;


        q.all([prodRequests.getRejectedOffers(req, config.mysql, q, 0, "buy"), prodRequests.getRejectedOffers(req, config.mysql, q, 1, "buy")]).then(function (results) {

            //buy records for login user
            // console.log("buyers products here : ", JSON.stringify(results[0][0]));

            $arr['pagination'] = results[1][0][0].req_count;
            $arr['myProducts'] = products.shortDescribe(results[0][0]);
            // $arr['adwords'] = results[2][0];
            $arr.page_name = 'Buyer Dashboard';
            var pagination = require('pagination');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });
            if (typeof (req.param('search')) !== 'undefined') {
                fquery = '?search=' + req.param('search');
            }
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/myrpurchase' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();
            common.tplFile('myrejoffers.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {

            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

// app.get(['/myrpurchase', '/myrpurchase/:prodId', '/myrpurchase/:prodId:page'], function(req, res) {

/* openbid dashboard - confirm sales */
app.get(['/mysale', '/mysale/:prodId', '/mysale:page'], function (req, res) {

    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        req.body.productId = (typeof (req.params.prodId) == 'undefined') ? 'all' : req.params.prodId;
        req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
        $arr['mysale'] = 1;
        $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";

        console.log("mycorders");
        // var module = require('../module');
        var bids = require('../module/bid');
        // var adwords = require('../module/adwords');
        var prodRequests = require('../module/prod_requests');
        var data = bids.SearchPageNo(req, config.mysql, q);

        req.body.page = data.dspage;

        req.body.perlimit = 10;


        q.all([prodRequests.getConfirmedOffers(req, config.mysql, q, 0, "sell"),
        prodRequests.getConfirmedOffers(req, config.mysql, q, 1, "sell")
        ]).then(function (results) {

            //buy records for login user
            // console.log("buyers products here : ", JSON.stringify(results[0][0]));

            $arr['pagination'] = results[1][0][0].req_count;
            $arr['myProducts'] = products.shortDescribe(results[0][0]);
            // $arr['adwords'] = results[2][0];
            $arr.page_name = 'Buyer Dashboard';
            var pagination = require('pagination');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });

            if (typeof (req.param('search')) !== 'undefined') {
                fquery = '?search=' + req.param('search');
            }
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/mysale' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('myconfoffers.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {

            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

//app.get(['/myrsale', '/myrsale:page'], function(req, res) {
/* openbid dashboard - rejected sales */
app.get(['/myrsale', '/myrsale/:prodId', '/myrsale:page'], function (req, res) {

    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        req.body.productId = (typeof (req.params.prodId) == 'undefined') ? 'all' : req.params.prodId;
        req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
        $arr['myrsale'] = 1;
        $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";

        console.log("mycorders");
        // var module = require('../module');
        var bids = require('../module/bid');
        // var adwords = require('../module/adwords');
        var prodRequests = require('../module/prod_requests');
        var data = bids.SearchPageNo(req, config.mysql, q);

        req.body.page = data.dspage;

        req.body.perlimit = 10;

        q.all([prodRequests.getRejectedOffers(req, config.mysql, q, 0, "sell"), prodRequests.getRejectedOffers(req, config.mysql, q, 1, "sell")]).then(function (results) {

            //buy records for login user
            // console.log("buyers products here : ", JSON.stringify(results[0][0]));

            $arr['pagination'] = results[1][0][0].req_count;
            $arr['myProducts'] = products.shortDescribe(results[0][0]);
            // $arr['adwords'] = results[2][0];
            $arr.page_name = 'Buyer Dashboard';
            var pagination = require('pagination');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });

            if (typeof (req.param('search')) !== 'undefined') {
                fquery = '?search=' + req.param('search');
            }
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/myrsale' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('myrejoffers.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {

            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

/* openbid dashboard - Inventory - all closed products */
app.get(['/openbid_inventory', '/openbid_inventory/:prodId', '/openbid_inventory:page'], function (req, res) {

    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        req.body.productId = (typeof (req.params.prodId) == 'undefined') ? 'all' : req.params.prodId;
        req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
        $arr['openbid_inventory'] = 1;
        $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";

        console.log("openbid_inventory");
        // var module = require('../module');
        var bids = require('../module/bid');
        // var adwords = require('../module/adwords');
        var prodRequests = require('../module/prod_requests');
        var data = bids.SearchPageNo(req, config.mysql, q);

        req.body.page = data.dspage;

        req.body.perlimit = 10;

        q.all([prodRequests.getClosedProducts(req, config.mysql, q, 0), prodRequests.getClosedProducts(req, config.mysql, q, 1)]).then(function (results) {

            //buy records for login user
            console.log("buyers products here : ", JSON.stringify(results[1][0]));

            $arr['pagination'] = results[1][0][0].productsCount;
            $arr['myProducts'] = products.shortDescribe(results[0][0]);
            // $arr['adwords'] = results[2][0];
            $arr.page_name = 'Buyer Dashboard';
            $arr.page_name = 'Buyer Dashboard';
            var pagination = require('pagination');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;

            fquery = common.urlparameter(query, { page: '' });

            if (typeof (req.param('search')) !== 'undefined') {
                fquery = '?search=' + req.param('search');
            }
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/openbid_inventory' + fquery,
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('openbid_inventory.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {

            console.log(err.stack);
            throw err;
        }).done();
    } else return false;
});

/* ends here */

/* Relationship module here */
app.get(['/relationship', '/relationship/:action'], function (req, res) {
    messages = require('../module/message');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    $arr['error'] = (typeof (req.param('error')) !== 'undefined') ? req.param('error') : '';
    $arr['heading_common'] = "RELATIONSHIP DASHBOARD";
    messages.updateviewed(req, config.mysql, q);
    $arr.relatiocharge = $arr.config.general.relationship_charge;
    $arr['action'] = req.body.action;
    if (req.body.action == 'create') {
        q.all([messages.btyperelation(req, config.mysql, q)]).then(function (results) {
            $arr['relationtype'] = results[0][0];
            common.tplFile('rcompose.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    } else if (req.body.action == 'inbox') {
        q.all([messages.relationship(req, config.mysql, q, 0),
        messages.relationship(req, config.mysql, q, 1),
        messages.btyperelation(req, config.mysql, q)
        ]).then(function (results) {
            var result = _.pluck(results[0][0], 'from_id');
            async.series({
                getSellerDetails: function (checkblock_cbk) {
                    faAPI.appendUserDataForObject('id', 'id as user_id,concat(first_name," ",last_name) as fname', result, results[0][0], 'from_id', function (messageFromErr, messageFromRes) {
                        console.log("messageFromRes 1")
                        console.log(messageFromRes)
                        checkblock_cbk(null, messageFromRes);

                    });
                }

            }, function (err, results1) {
                if (err) {
                    console.log(err);
                }
                console.log("hjjjjjjjjjjjjjjjjjjjjjjjjjj");
                console.log(results1.getSellerDetails);

                results[0][0] = results1.getSellerDetails;
                var result = _.pluck(results[0][0], 'to_id');
                async.series({
                    getSellerDetails1: function (checkblock_cbk) {
                        faAPI.appendUserDataForObject('id', 'id as to_id, concat(first_name," ",last_name) as tname', result, results[0][0], 'to_id', function (messageFromErr, messageFromRes) {
                            console.log("messageFromRes 2")
                            console.log(messageFromRes)
                            checkblock_cbk(null, messageFromRes);

                        });
                    }

                }, function (err, results1) {
                    console.log('res', results1);
                    if (err) {
                        console.log(err);
                    }
                    results[0][0] = results1.getSellerDetails1;
                    $arr['pagination'] = results[1][0].length;
                    $arr['messages'] = results[0][0];
                    $arr['relationtype'] = results[2][0];
                    var pagination = require('pagination');
                    var paginator = new pagination.SearchPaginator({
                        prelink: '/dashboard/relationship/inbox',
                        current: req.body.page,
                        rowsPerPage: 5,
                        totalResult: $arr['pagination']
                    });

                    $arr['pagination_html'] = paginator.render();
                    common.tplFile('inbox.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                });

            });
        });
    } else if (req.body.action == 'sent') {
        q.all([messages.relationshipsent(req, config.mysql, q, 0), messages.relationshipsent(req, config.mysql, q, 1), messages.btyperelation(req, config.mysql, q)]).then(function (results) {

            $arr['pagination'] = results[1][0].length;
            $arr['messages'] = results[0][0];
            $arr['relationtype'] = results[2][0];
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/dashboard/relationship/sent',
                current: req.body.page,
                rowsPerPage: 5,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();
            common.tplFile('sentre.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        });
    } else {
        q.all([messages.relationshipcenter(req, config.mysql, q, 0), messages.relationshipcenter(req, config.mysql, q, 1), messages.btyperelation(req, config.mysql, q), adwords.show_ads(req, config.mysql, q, 'Messages')]).then(function (results) {
            var result = _.pluck(results[0][0], 'from_id');
            async.series({
                getSellerDetails: function (checkblock_cbk) {
                    faAPI.appendUserDataForObject('id', 'id as from_id,concat(first_name," ",last_name) as fname,email as femail,address1 as faddress1,address2 as faddress2,state as fstate,city as fcity', result, results[0][0], 'from_id', function (messageFromErr, messageFromRes) {
                        checkblock_cbk(null, messageFromRes);
                    });
                }

            }, function (err, results1) {
                if (err) {
                    console.log(err);
                }
                results[0][0] = results1.getSellerDetails;
                var result = _.pluck(results[0][0], 'to_id');
                async.series({
                    getSellerDetails1: function (checkblock_cbk) {
                        faAPI.appendUserDataForObject('id', 'id as to_id, concat(first_name," ",last_name) as tname,email as temail,address1 as taddress1,address2 as taddress2,state as tstate,city as tcity', result, results[0][0], 'to_id', function (messageFromErr, messageFromRes) {

                            checkblock_cbk(null, messageFromRes);

                        });
                    }

                }, function (err, results1) {
                    if (err) {
                        console.log(err);
                    }
                    results[0][0] = results1.getSellerDetails1;
                    console.log("fghfgf");
                    console.log(results[0][0]);
                    $arr['pagination'] = results[1][0].length;
                    $arr['messages'] = results[0][0];
                    $arr['relationtype'] = results[2][0];
                    $arr['adwords'] = results[3][0];
                    $arr.page_name = 'Messages';
                    var pagination = require('pagination');
                    var paginator = new pagination.SearchPaginator({
                        prelink: '/dashboard/relationship/',
                        current: req.body.page,
                        rowsPerPage: 5,
                        totalResult: $arr['pagination']
                    });

                    $arr['pagination_html'] = paginator.render();
                    common.tplFile('relationship.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                });

            });
        });
    }
});

app.post('/relationshipsend', function (req, res) {

    common.checkLogin(req, res, 0);
    message = require('../module/message');
    localm = require('../module/localmail');

    q.all([
        message.addpolldetails(req, config.mysql, q),
        message.checksendDetails(req, config.mysql, q),
        products.checkmailnotify(req, config.mysql, q, 25),
        products.checksmsnotify(req, config.mysql, q, 25)
    ]).then(function (results) {
        var result = _.pluck(results[1][0], 'user_id');
        async.series({
            getSellerDetails: function (checkblock_cbk) {
                faAPI.appendUserDataForObject('id', 'id as user_id,concat(first_name," ",last_name) as fname,email', result, results[1][0], 'user_id', function (messageFromErr, messageFromRes) {
                    checkblock_cbk(null, messageFromRes);
                });
            },
            updateSenderDetails: function (checkblock_cbk) {
                var sender_id = req.session.userid != '' && typeof (req.session.userid) != 'undefined' ? req.session.userid : 0;
                var sender_target_amount = req.body.tarhidprice != '' && typeof (req.body.tarhidprice) != 'undefined' ? req.body.tarhidprice : 0;
                var sender_balance = req.body.currentbalance != '' && typeof (req.body.currentbalance) != 'undefined' ? req.body.currentbalance : 0;
                if (parseFloat(sender_balance) >= parseFloat(sender_target_amount)) {

                    var sender_final_balance = parseFloat(sender_balance) - parseFloat(sender_target_amount);
                    req.body.buyer = {
                        balance: sender_final_balance,
                        id: sender_id
                    }
                    faAPI.updateUser(req, 'bought_product', function (err, resp) {

                        var payments = require('../module/payment');
                        payments.sessionsdata = [];
                        // payments.sessionsdata.title = prdt[0][0][0].title;
                        payments.sessionsdata.email = req.session.email;
                        payments.sessionsdata.url = $arr.config.url + '/';
                        payments.sessionsdata.userid = req.session.userid;

                        payments.sessionsdata.first_name = req.session.first_name;
                        payments.sessionsdata.last_name = req.session.last_name;

                        payments.transactionid = 0;
                        payments.gateway = 'account';
                        payments.buyer = { 'id': req.session.userid, 'first_name': req.session.first_name, 'last_name': req.session.last_name, 'email': req.session.email, 'phone': req.session.phone }
                        payments.payid = 0;
                        payments.name = req.body.tittle;
                        payments.payid = 0;
                        payments.type = 'relationship';
                        payments.buynow_id = 0;
                        payments.cart_id = 0;
                        payments.amount = sender_target_amount;
                        payments.qty = 0;

                        // req.body.buyer = {
                        //     balance: parseFloat(buyer.balance) - parseFloat(data.amount),
                        //     id: buyer.id
                        // }

                        // payments = require('../module/payment');

                        // payments.transactionid = 0;
                        // payments.gateway = 'account';
                        // payments.sessionsdata = [];
                        // payments.sessionsdata.title = prdt[0][0][0].title;
                        // payments.sessionsdata.email = seller.email;
                        // payments.sessionsdata.url = $arr.config.url + '/product/view/' + prdt[0][0][0].id;
                        // payments.sessionsdata.userid = req.session.userid;

                        // payments.sessionsdata.first_name = seller.first_name;
                        // payments.sessionsdata.last_name = seller.last_name;
                        // req.body.commission = $arr.config.general.commission_fee;

                        // payments.payid = prdt[0][0][0].id;
                        // payments.type = 'bought';
                        // payments.name = prdt[0][0][0].title;
                        // payments.buynow_id = buyNowRecord[0][0][0].id;
                        // payments.cart_id = cart_id;
                        // payments.amount = buyNowRecord[0][0][0].total_amount;
                        // payments.buyer = buyer;
                        // payments.seller = seller;
                        // payments.qty = buyNowRecord[0][0][0].qty;

                        q.all([payments.insertInvoice(req)]).then(function (invoice) {

                            q.all(products.generateInvoiceID(req, invoice[0][0].insertId, config.mysql, q)).then(function (invoices) {
                                checkblock_cbk(null, { status: 'success' });
                            }).fail(function (err) {
                                console.log(err.stack);
                                throw err;
                            }).done();


                        }).fail(function (error) {
                            console.log(error.stack);
                        }).done();
                    });
                } else {
                    checkblock_cbk(null, { status: 'fail' });
                }

            }

        }, function (err, results1) {
            if (err) {
                console.log(err);
            }

            results[1][0] = results1.getSellerDetails;
            var sender_details = results1.updateSenderDetails;
            var dat = require('date-util');
            var plid = results[0][0].insertId;
            req.body.rpool_id = plid;
            mailuser = results[1][0];
            if (sender_details.status == 'success' && sender_details.status != '' && typeof (sender_details.status) != 'undefined') {
                for (i in mailuser) {
                    req.body.toid = mailuser[i].user_id;
                    if (req.body.toid != req.session.userid) {
                        message.insertpolldetailspmb(req, config.mysql, q);
                    }
                    if (results[2][0].length > 0) {
                        var activeurl = '<br/> <a href="' + $arr.config.spath + 'dashboard/relationship/inbox">Click Here</a>';
                        q.all([localm.mailtemps(req, config.mysql, q, 'relationship_message')]).then(function (results2) {
                            if (results2[0][0].length > 0) {

                                var template = results2[0][0][0].template;
                                var subject = req.body.tittle;
                                template = template.replace('{{event.subject}}', 'You have targetted by ' + req.session.first_name + ' ' + req.session.last_name + ', Please ' + activeurl + ' to see your appropriate user informations.');
                                template = template.replace('{{event.user}}', mailuser[i].fname);
                                template = template.replace('{{event.url}}', $arr.config.url);
                                localm.sendmail(template, subject, mailuser[i].email);

                            } else {
                                res.end();
                                return false;
                            }
                        });
                    } else { console.log('Notification off'); }
                }
                res.writeHead(302, {
                    'Location': '/dashboard/relationship/sent'
                });
                res.end();
                return false;
            } else {
                res.writeHead(302, {
                    'Location': '/dashboard/relationship/create?error=Please Check Your Account Balance'
                });
                res.end();
                return false;
            }
        });
    });
});

app.get(['/seller/recuring', '/seller/recuring:page'], function (req, res) {

    console.log("sellerrecuring");
    $arr['myrequests'] = 1;

    var bids = require('../module/bid');
    var prodRequests = require('../module/prod_requests');

    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;
    req.body.perlimit = 10;

    q.all([
        prodRequests.sellerrecuring(req, config.mysql, q, 0),
        prodRequests.sellerrecuring(req, config.mysql, q, 1)
    ]).then(function (results) {
        $arr['pagination'] = results[1][0][0].rcurrcount;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }

        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/seller/recuring' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";

        common.tplFile('dbsellrecuring.tpl');
        // common.tplFile('dbmarketrecur.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/seller/rejected', '/seller/rejected:page'], function (req, res) {

    console.log("sellerrejected");
    $arr['myrequests'] = 1;
    var bids = require('../module/bid');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;
    console.log('req.body.page', req.body.page);
    req.body.perlimit = 10;
    q.all([prodRequests.sellerrejected(req, config.mysql, q, 0), prodRequests.sellerrejected(req, config.mysql, q, 1)]).then(function (results) {
        $arr['pagination'] = results[1][0][0].rcurrcount;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/seller/rejected' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";
        common.tplFile('dbsellreject.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/seller/inventory', '/seller/inventory:page'], function (req, res) {

    console.log("sellerinventory");
    $arr['myrequests'] = 1;
    var bids = require('../module/bid');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;
    console.log("req.param('search')", req.param('page'));
    console.log('req.body.page', req.body.page);
    console.log('req.param("search")', req.param('sort'));
    console.log('req.param("direction")', req.param('direction'));
    $arr.sort_col = req.param('sort') != undefined ? req.param('sort') : '';
    $arr.direction = req.param('direction') != undefined ? req.param('direction') : '';
    $arr.page = req.body.page;

    req.body.perlimit = 10;
    q.all([prodRequests.sellerinventory(req, config.mysql, q, 0), prodRequests.sellerinventory(req, config.mysql, q, 1)]).then(function (results) {
        $arr['pagination'] = results[1][0][0].rcurrcount;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);
        console.log("$arr['myProducts']", $arr['myProducts']);
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search') + '&sort='+$arr.sort_col+'&direction='+$arr.direction;
        } else {
            fquery = '?search=&sort='+$arr.sort_col+'&direction='+$arr.direction;
        }
        $arr['fquery'] = fquery;
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/seller/inventory' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";
        common.tplFile('dbsellinventory.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/seller/inventorbyproduct', '/seller/inventorbyproduct:page'], function (req, res) {

    console.log("sellerinventorybyproduct");
    $arr['myrequests'] = 1;
    var bids = require('../module/bid');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.search = typeof (req.param('search')) !== 'undefined' ? req.param('search') : '';
    req.body.page = data.dspage;
    req.body.perlimit = 10;
    q.all([prodRequests.sellerinventory(req, config.mysql, q, 0), prodRequests.sellerinventory(req, config.mysql, q, 1)]).then(function (results) {
        $arr['pagination'] = results[1][0][0].rcurrcount;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);
        console.log("$arr['myProducts']", $arr['myProducts']);
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        $arr['search'] = query;

        fquery = common.urlparameter(query, { page: '' });

        if (typeof (req.param('search')) !== 'undefined') {
            fquery = '?search=' + req.param('search');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/seller/inventorbyproduct' + fquery,
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";
        common.tplFile('dbsellinventorybyproduct.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/seller/accepted', '/seller/accepted:page'], function (req, res) {

    console.log("sellerrejected");
    $arr['myrequests'] = 1;
    var bids = require('../module/bid');
    var prodRequests = require('../module/prod_requests');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 10;
    q.all([prodRequests.selleraccepted(req, config.mysql, q, 0), prodRequests.selleraccepted(req, config.mysql, q, 1)]).then(function (results) {
        $arr['pagination'] = results[1][0][0].rcurrcount;
        $arr['myProducts'] = products.shortDescribe(results[0][0]);
        $arr.page_name = 'Buyer Dashboard';
        var pagination = require('pagination');
        fquery = '';

        if (typeof (req.param('cmd')) !== 'undefined') {
            fquery = '?cmd=' + req.param('cmd');
        }
        var paginator = new pagination.SearchPaginator({
            prelink: '/dashboard/seller/accepted' + fquery,
            current: data.dspage,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        $arr['heading_common'] = "Market Activity Dashboard";
        common.tplFile('dbsellaccept.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {

        console.log(err.stack);
        throw err;
    }).done();

});

/* Buyer seller performance rating implementation */
app.get(['/seller_performance/:id/:pid', '/seller_performance/:id/:pid/:sid', '/seller_performance/:id/:pid/:sid/:err'], function (req, res) {

    console.log(req.headers)
    console.log(req.body)
    console.log(req.url)
    // q.all([dashboard.getSellerPerformance(req, config.mysql, q, 1)]).then(function(results) {
    //     console.log(results);
    //     if(results[0][0][0]){
    //         $arr.rating_data = results[0][0][0];
    //         $arr['id'] = typeof(req.param('id')) !== 'undefined' ? req.param('id') : 0;
    //         $arr['store_id'] = typeof(req.param('sid')) !== 'undefined' ? req.param('sid') : 0;
    //         $arr['err'] = typeof(req.param('err')) !== 'undefined' ? req.param('err') : 0;

    //         common.tplFile('seller_performance.tpl');
    //         common.headerSet(1);
    //         common.loadTemplateHeader(req, res, $arr);    
    //     } else {
    $arr['buy_id'] = typeof (req.param('buy_id')) !== 'undefined' ? req.param('buy_id') : 0;
    $arr['id'] = typeof (req.param('id')) !== 'undefined' ? req.param('id') : 0;
    $arr['store_id'] = typeof (req.param('sid')) !== 'undefined' ? req.param('sid') : 0;
    $arr['product_id'] = typeof (req.param('pid')) !== 'undefined' ? req.param('pid') : 0;
    $arr['err'] = typeof (req.param('err')) !== 'undefined' ? req.param('err') : 0;
    $arr['last_url'] = typeof (req.param('last_url')) !== 'undefined' ? req.param('last_url') : req.headers.referer;


    // console.log("last url here ---------------------- "+config.url+'');
    // console.log("last url here ---------------------- "+req.headers.referer);

    common.tplFile('seller_performance.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
    //     }

    // }).fail(function(err) {
    //     console.log(err.stack);
    //     throw err;
    // }).done();

});

app.post(['/seller_performance',], function (req, res) {
// console.log('req.body', req.body);return false;
    req.body.avg_rating = (((typeof (req.body.accurate) !== undefined ? parseFloat(req.body.accurate) : 0) +
        (typeof (req.body.delivery) !== undefined ? parseFloat(req.body.delivery) : 0) +
        (typeof (req.body.packing) !== undefined ? parseFloat(req.body.packing) : 0) +
        (typeof (req.body.customer_support) !== undefined ? parseFloat(req.body.customer_support) : 0) +
        (typeof (req.body.satisfaction) !== undefined ? parseFloat(req.body.satisfaction) : 0)) / 5).toFixed(2);
        req.body.avg_rating = Math.round(req.body.avg_rating);
        /* 
        (typeof (req.body.resolving) !== undefined ? parseFloat(req.body.resolving) : 0) +
        (typeof (req.body.questions) !== undefined ? parseFloat(req.body.questions) : 0) +
        (typeof (req.body.performance) !== undefined ? parseFloat(req.body.performance) : 0) + */

    q.all([dashboard.seller_performance(req, config.mysql, q, 1)]).then(function (results) {
        req.body.insert_id = results[0][0].insertId;
        q.all([dashboard.seller_performance_data(req, config.mysql, q)]).then(function (result) {
            var data = result[0][0][0];
            (dashboard.insert_Sreview_data(req, config.mysql, q, data));
        });
        $arr['msg'] = "Performance review successfully Added !"

        // res.writeHead(302, {
        //     'Location': '/dashboard/seller_performance/' + req.body.seller_id + '/' + req.body.product_id + '/' + req.body.store_id + '/1?'+req.body.last_url
        // });
        // res.end();
        res.writeHead(302, {
            'Location': req.body.last_url
        });
        res.end();
        return false;
    });

});


app.get(['/buyer_performance/:id', '/buyer_performance/:id/:sid', '/buyer_performance/:id/:sid/:err'], function (req, res) {
    $arr['buy_id'] = typeof (req.param('buy_id')) !== 'undefined' ? req.param('buy_id') : 0;
    $arr['id'] = typeof (req.param('id')) !== 'undefined' ? req.param('id') : 0;
    $arr['store_id'] = typeof (req.param('sid')) !== 'undefined' ? req.param('sid') : 0;
    $arr['err'] = typeof (req.param('err')) !== 'undefined' ? req.param('err') : 0;
    $arr['last_url'] = typeof (req.param('last_url')) !== 'undefined' ? req.param('last_url') : req.headers.referer;

    common.tplFile('buyer_performance.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});

app.post(['/buyer_performance',], function (req, res) {

    console.log(req.body);

    req.body.delivery = (typeof (req.body.delivery) !== undefined ? req.body.delivery : 0);
    req.body.avg_rating = (((typeof (req.body.delivery) !== undefined ? parseFloat(req.body.delivery) : 0) + (typeof (req.body.deliveryinfo) !== undefined ? parseFloat(req.body.deliveryinfo) : 0) + (typeof (req.body.prodinspect) !== undefined ? parseFloat(req.body.prodinspect) : 0) + (typeof (req.body.delreceipt) !== undefined ? parseFloat(req.body.delreceipt) : 0) + (typeof (req.body.personnel) !== undefined ? parseFloat(req.body.personnel) : 0) ) / 5).toFixed(2);

    // req.body.avg_rating = Math.round(req.body.avg_rating);
    
    q.all([dashboard.buyer_performance(req, config.mysql, q, 1)]).then(function (results) {
        req.body.insert_id = results[0][0].insertId;
        q.all([dashboard.buyer_performance_data(req, config.mysql, q)]).then(function (result) {
            var data = result[0][0][0];
            (dashboard.insert_review_data(req, config.mysql, q, data));
        });
        $arr['msg'] = "Performance review successfully Added !"

        res.writeHead(302, {
            'Location': req.body.last_url
        });
        res.end();
        return false;
    });
});
/* end */


app.get(['/product/edit/:id', '/product/edit/:id/:sid'], function (req, res) {


    var products = require('../module/products');
    var dateFormat = require('dateformat');
    $arr.datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    $arr.sid = req.body.sid = (typeof (req.param('sid')) === 'undefined') ? 0 : req.param('sid');
    $arr.externalcss = ['datePicker'];
    $arr.externaljs = ['jquery.datePicker'];
    $arr['fee'] = global.general.feature_listing_fee;
    $arr['last_url'] = req.headers.referer;
    var user = require('../module/user');
    q.all([
        products.productDetail(req, config.mysql, q),
        products.productImage(req, config.mysql, q),
        user.userInfo(req, config.mysql, q, req.session.userid, ['paypal_address', 'zip']),
        common.locations(req, config.mysql, q), 
        adwords.show_ads(req, config.mysql, q, 'Sell an Item'),
        products.isDigitalItem(req, config.mysql, q), 
        products.maincatVal(req, config.mysql, q), 
        products.testresultImages(req, config.mysql, q),
        products.certImages(req, config.mysql, q)
    ]).then(function (result) {

       


        try {
            // console.log("market status checking here-------------------"+JSON.stringify(result));
            $arr['projects'] = products.shortDescribe(result[0][0]);
            //  || (result[0][0][0].sold > 0)
            if ((result[0][0][0].market_status != 'open')) {
                if (result[0][0][0].auction == '1') {
                    res.writeHead(302, {
                        'Location': config.url + '/product/view/' + req.body.id
                    });
                    res.end();
                    return false;
                }
                if (result[0][0][0].buynow == '1') {
                    res.writeHead(302, {
                        'Location': config.url + '/product/sview/' + req.body.id
                    });
                    res.end();
                    return false;
                }
            }

            if (result[8][0].length > 0) {
                $arr['certs_analysis'] = result[8][0][0];
                $arr['certs_analysis_length'] = result[8][0].length;
            }

            if (result[7][0].length > 0) {
                $arr['testresults'] = result[7][0][0];
                $arr['testresults_length'] = result[7][0].length;
            }

            $arr.user = result[2][0][0];
            $arr.digital_files = result[5][0];
            $arr.locations = result[3][0];
            $arr['projects'] = $arr['projects'][0];
            // console.log('market_status here-------------------------->');
            // console.log($arr['projects']['market_status'])
            // console.log($arr['projects'].market_status);

            // $arr['projects']['sell_location'] = (typeof($arr['projects']['sell_location']) == 'undefined') ? '' : common.firstLetterCapital($arr['projects']['sell_location']);
            $arr['projects']['sell_location'] = (typeof ($arr['projects']['sell_location']) == 'undefined') ? '' : $arr['projects']['sell_location'];
            $arr['adwords'] = result[4][0];
            if (new Date($arr['projects']['date_added']) < new Date($arr.datenow)) {
                $arr.datenow = dateFormat(new Date($arr['projects']['date_added']), "yyyy-mm-dd HH:MM:ss");
            }
            $arr['home_page_fee'] = global.general.home_page_listing_fee;
            $arr['projects']['date_add'] = dateFormat(new Date($arr['projects']['date_added']), "yyyy/mm/dd HH:MM");
            $arr['projects']['date_close'] = dateFormat(new Date($arr['projects']['date_closed']), "yyyy/mm/dd HH:MM");
            $arr['image'] = result[1][0];
            console.log('$arr["image"]', $arr['image']);
            $arr['pid'] = common.randomNumber(5);
            $arr.oneusd = req.session.currencyrate;
            $arr['currencytype'] = config.productsetting.currency;
            $arr.catego = result[6][0];
            if (config.productsetting.currency == 'dollar') {
                $arr['projects']['sprice'] = (Number($arr['projects']['sprice']) / Number($arr.oneusd)).toFixed(2);
                $arr['projects']['rprice'] = (Number($arr['projects']['rprice']) / Number($arr.oneusd)).toFixed(2);
                $arr['projects']['shipping_price'] = (Number($arr['projects']['shipping_price']) / Number($arr.oneusd)).toFixed(2);
                $arr['projects']['bprice'] = (Number($arr['projects']['bprice']) / Number($arr.oneusd)).toFixed(2);
                $arr['projects']['mprice'] = (Number($arr['projects']['mprice']) / Number($arr.oneusd)).toFixed(2);
                $arr['projects']['iprice'] = (Number($arr['projects']['iprice']) / Number($arr.oneusd)).toFixed(2);
                $arr['projects']['wprice'] = (Number($arr['projects']['wprice']) / Number($arr.oneusd)).toFixed(2);
                $arr['projects']['wsprice'] = (Number($arr['projects']['wsprice']) / Number($arr.oneusd)).toFixed(2);
            }
            /* if ($arr['projects'].bids != 0 || $arr['projects'].sold != 0) {
                 res.writeHead(302, {
                     'Location': '/dashboard/my'
                 });
                 res.end();
                 return false;
             } else {
                 common.tplFile('post.tpl');
             }*/
            common.tplFile('post.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        } catch (e) {
            console.log("Error in edit info " + e.stack);
        }
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

app.get('/product/delete/:id', function (req, res) {

    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    q.all([dashboard.delete_product(req, config.mysql, q, 1)]).then(function (results) {
        $arr['msg'] = "Product deleted !"

        res.writeHead(302, {
            'Location': '/dashboard/seller/selling'
        });
        res.end();
        return false;
    });

});
app.get('/openbid/product/delete/:id', function (req, res) {

    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    q.all([dashboard.delete_product(req, config.mysql, q, 1)]).then(function (results) {
        $arr['msg'] = "Product deleted !"

        res.writeHead(302, {
            'Location': '/dashboard/myrequests'
        });
        res.end();
        return false;
    });

});

module.exports = app;