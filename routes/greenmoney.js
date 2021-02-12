// #### load required Modules ##################################################

var express = require('express');
var request = require('request');
var app = express.Router();
var q = require('q');
var faAPI = require('../module/forwardauction_api');
var gmoney = require('../module/greenmoney');
var products = require('../module/products');
var _ = require('underscore')

app.get('/success', function(req, res) {
    if (common.checkLogin(req, res, 0)) {
        $arr['heading_common'] = "Time to Fund Your Herbee Account";
        common.tplFile('success.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});

app.get('/cancel', function(req, res) {
    if (common.checkLogin(req, res, 0)) {
        $arr['heading_common'] = "Time to Fund Your Herbee Account";
        common.tplFile('cancel.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});

app.get('/sendcheck', function(req, res) {
    if (common.checkLogin(req, res, 0)) {

        $arr['sendcheck'] = 1;
        $arr['heading_common'] = "Time to Fund Your Herbee Account";
        common.tplFile('send-check.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});

app.get('/gateway', function(req, res) {

    if (common.checkLogin(req, res, 0)) {
        $arr['gateway'] = 1;
        $arr['heading_common'] = "Time to Fund Your Herbee Account";
        if (req.session.ref && req.session.media) {
            $arr.refers = req.session.ref;
            $arr.med = req.session.media;

        } else {
            var referals = (typeof(req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
            var media = (typeof(req.param('med')) !== 'undefined') ? req.param('med') : '';
            req.session.ref = referals;
            req.session.media = media;

            $arr.refers = req.session.ref;
            $arr.med = req.session.media;
        }

        admin = require('../module/admin');
        req.body.id = 7;
        q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function(results) {
            $arr.externalcss = ['home_1'];
            $arr['content'] = results[0][0][0];
            common.tplFile('payment-gateway.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});


app.get(['/wirefund', '/wirefund/:action', '/wirefund/:action/:id'], function(req, res) {

    var transaction_id = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : '';

    if (transaction_id > 0) {
        q.all([gmoney.wire_fund(req, config.mysql, q)]).then(function(results) {
            $arr.wirefund_amount = results[0][0][0].amount;
        });
    }

    if (req.params.action == 'success' || req.params.action == 'failure') {
        $arr.action = req.params.action;
    }

    if (req.params.action == '1') {
        $arr.action = req.params.action
        $arr.err_msg = true;
        // $arr.err_msg = "Can't pay, please increase your fund balance....!";
    }
    $arr.externaljs = ['jquery.toaster'];
    if (common.checkLogin(req, res, 0)) {
        $arr['wirefund'] = 1;
        $arr['heading_common'] = "Time to Fund Your Herbee Account";
        common.tplFile('wire-fund.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});

app.get(['/refundrequest', '/refundrequest/:action', '/refundrequest/:action/:id'], function(req, res) {
    if (common.checkLogin(req, res, 0)) {
        var transaction_id = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : '';

        if (transaction_id > 0) {
            q.all([gmoney.wire_fund(req, config.mysql, q)]).then(function(results) {
                $arr.wirefund_amount = results[0][0][0].amount;
            });
        }

        if (req.params.action == 'success' || req.params.action == 'failure') {
            $arr.action = req.params.action;
        }

        if (req.params.action == '1') {
            $arr.action = req.params.action
            $arr.err_msg = true;
            // $arr.err_msg = "Can't pay, please increase your fund balance....!";
        }

        $arr.externaljs = ['jquery.toaster'];

        if (common.checkLogin(req, res, 0)) {
            $arr['fundRequest'] = 1;
            $arr['heading_common'] = "Send fund request to Herbee";
            common.tplFile('fund_request.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }
    }
});

app.post(['/request', '/request/:action'], function(req, res) {

    if (common.checkLogin(req, res, 0)) {
        var usermail = req.session.email;
        var action = (typeof(req.param('action')) !== 'undefined') ? req.param('action') : '';
        var attach = require('../module/attach');
        if (action == 'wirefund') {
            attach.save('wirefund_receipt', req, res);

            q.all([gmoney.fundRequest(req, config.mysql, q), products.checkmailnotify(req, config.mysql, q, 33), products.checksmsnotify(req, config.mysql, q, 33)]).then(function(results) {
                var transaction_id = results[0][0].insertId;

                /* email module */

                //referral update
                var activeurl = '<br/> <a href="' + $arr.config.spath + 'login">Click Here</a>';
                email = require('../module/email');
                localm = require('../module/localmail');
            if (results[1][0].length > 0) {
                // if (global.emailcio.status == 'yes') {
                //     customerio = require('../module/customerio');
                //     customerio.uid = result.userId;
                //     console.log('userid', results);
                //     email.sendEmail('Register Forward', req.body, {
                //         siteurl: config.url,
                //         user: req.body.first_name + ' ' + req.body.last_name,
                //         activeurl: activeurl
                //     });
                // } else 
                if (global.emaillocal.status == 'yes') {
                    q.all([localm.mailtemps(req, config.mysql, q, 'Funding_your_account_moneyorder')]).then(function(results2) {

                        if (results2) {

                            var template = results2[0][0][0].template;
                            var subject_message = results2[0][0][0].subject;

                            template = template.replace('{{event.sitename}}', config.title);
                            template = template.replace('{{event.subject}}', 'Congratulations you have funded your Herbee Account!');
                            template = template.replace('{{event.message}}', 'You have successfully submitted funds for your account. Please allow 48 hours for this money to be processed and your new account balance to be reflected in your account. Your monthly membership fee will deducted from the balance of your account once monthly. Your current account balance is: $' + req.body.total + " " + 'Funds submitted: $' + req.body.amount + " " + 'Follow the link below to log in and start trading cannabis on the Herbee platform.');
                            template = template.replace('{{event.activeurl}}', activeurl);
                            template = template.replace('{{event.user}}', req.session.username);
                            template = template.replace('{{event.siteurl}}', $arr.config.url)
                            // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                            localm.sendmail(template, subject_message, usermail);

                        } else {

                            console.log("No Templates named register");
                        }


                    }).fail(function(err) {
                        console.log(err.stack);
                        res.writeHead(302, {
                            'Location': '/payment/wirefund/failure'
                        });
                        res.end();
                        throw err;
                    });

                } else {
                    console.log('No Mail Delivery method is selected');
                }
            } else { console.log('Notification off'); }

                /* email module ends here */

                res.writeHead(302, {
                    'Location': '/payment/wirefund/success/' + transaction_id
                });
                res.end();

            }).fail(function(err) {
                console.log(err.stack);
                res.writeHead(302, {
                    'Location': '/payment/wirefund/failure'
                });
                res.end();
                throw err;
            }).done();

        } else if (action == 'checkpayment') {
            // attach.save('wirefund_receipt', req, res);
            // console.log('session', req.session);

            q.all([gmoney.checkRequest(req, config.mysql, q), products.checkmailnotify(req, config.mysql, q, 34), products.checksmsnotify(req, config.mysql, q, 34)]).then(function(results) {
                var transaction_id = results[0][0].insertId;
                /* email module */

                //referral update

                var activeurl = '<br/> <a href="' + $arr.config.spath + 'login">Click Here</a>';
                console.log(1);
                email = require('../module/email');
                localm = require('../module/localmail');
                if (results[1][0].length > 0) {
                // if (global.emailcio.status == 'yes') {
                //     customerio = require('../module/customerio');
                //     customerio.uid = result.userId;
                //     email.sendEmail('Register Forward', req.body, {
                //         siteurl: config.url,
                //         user: req.body.first_name + ' ' + req.body.last_name,
                //         activeurl: activeurl
                //     });
                // } else 
                if (global.emaillocal.status == 'yes') {
                    q.all([localm.mailtemps(req, config.mysql, q, 'funding_your_account_check')]).then(function(results2) {

                        if (results2) {

                            var template = results2[0][0][0].template;
                            var subject_message = results2[0][0][0].subject;

                            template = template.replace('{{event.sitename}}', config.title);
                            template = template.replace('{{event.subject}}', "Congratulations you have funded your Herbee Account!");
                            template = template.replace('{{event.message}}', 'You have successfully submitted funds for your account. Please allow 72 hours for this money to be processed and your new account balance to be reflected in your account. Your monthly membership fee will deducted from the balance of your account once monthly. Your current account balance is: $' + req.body.total + " " + 'Funds submitted: $' + req.body.amount + " " + 'Follow the link below to log in and start trading cannabis on the Herbee platform');
                            template = template.replace('{{event.activeurl}}', activeurl);
                            template = template.replace('{{event.user}}', req.session.username);
                            template = template.replace('{{event.siteurl}}', $arr.config.url)
                            // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                            localm.sendmail(template, subject_message, req.session.email);

                        } else {

                            console.log("No Templates named register");
                        }


                    }).fail(function(err) {
                        console.log(err.stack);
                        res.writeHead(302, {
                            'Location': '/payment/wirefund/failure'
                        });
                        res.end();
                        throw err;
                    });

                } else {
                    console.log('No Mail Delivery method is selected');
                }
                } else { console.log('Notification off'); }
                /* email module ends here */

                res.writeHead(302, {
                    'Location': '/payment/wirefund/success/' + transaction_id
                });
                res.end();
            }).fail(function(err) {
                console.log(err.stack);
                res.writeHead(302, {
                    'Location': '/payment/wirefund/failure'
                });
                res.end();
                throw err;
            }).done();

        } else if (action == 'refundrequest') {
            // attach.save('wirefund_receipt', req, res);
            // console.log('session', req.session);


            q.all([gmoney.refundRequest(req, config.mysql, q), products.checkmailnotify(req, config.mysql, q, 51), products.checksmsnotify(req, config.mysql, q, 51)]).then(function(results) {
                var transaction_id = results[0][0].insertId;
                /* email module */

                //referral update

                var activeurl = '<br/> <a href="' + $arr.config.spath + 'login">Click Here</a>';
                console.log(1);
                email = require('../module/email');
                localm = require('../module/localmail');
                
                // if (global.emailcio.status == 'yes') {
                //     customerio = require('../module/customerio');
                //     customerio.uid = result.userId;
                //     email.sendEmail('Register Forward', req.body, {
                //         siteurl: config.url,
                //         user: req.body.first_name + ' ' + req.body.last_name,
                //         activeurl: activeurl
                //     });
                // } else 
                if (global.emaillocal.status == 'yes') {
                    q.all([localm.mailtemps(req, config.mysql, q, 'refund_request')]).then(function(results2) {

                        if (results2) {

                            var template = results2[0][0][0].template;
                            var subject_message = results2[0][0][0].subject;

                            template = template.replace('{{event.sitename}}', config.title);
                            template = template.replace('{{event.subject}}', 'Refund request has sent successfully...');
                            template = template.replace('{{event.message}}', 'You have successfully submitted refund request to herbee. Please allow 72 hours to proceed your request . Your current account balance is: $' + req.body.total + " " + 'Funds submitted: $' + req.body.amount + " " + 'Follow the link below to log in and start trading on the Herbee platform ');
                            template = template.replace('{{event.activeurl}}', activeurl);
                            template = template.replace('{{event.user}}', req.session.username);
                            template = template.replace('{{event.siteurl}}', $arr.config.url)
                            // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                            localm.sendmail(template, subject_message, req.session.email);

                        } else {

                            console.log("No Templates named register");
                        }


                    }).fail(function(err) {
                        console.log(err.stack);
                        res.writeHead(302, {
                            'Location': '/payment/refundrequest/failure'
                        });
                        res.end();
                        throw err;
                    });

                } else {
                    console.log('No Mail Delivery method is selected');
                }

                /* email module ends here */

                res.writeHead(302, {
                    'Location': '/payment/refundrequest/success/' + transaction_id
                });
                res.end();
            }).fail(function(err) {
                console.log(err.stack);
                res.writeHead(302, {
                    'Location': '/payment/refundrequest/failure'
                });
                res.end();
                throw err;
            }).done();

        }
    }
});


module.exports = app;