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
// var reload = require('reload');
// var sprintf = require('sprintf').sprintf;
var common = require('../module/common');
var register = require('../module/register');
var q = require('q');
// var https = require('https');
var async = require('async');
var faAPI = require('../module/forwardauction_api');
var app = express.Router();
var dashboard = require('../module/dashboard');
var _ = require('underscore');

/* ===================== start change by divyesh (changes) ===================== */
app.post('/save', function (req, res) {

    // if ((typeof(req.params.id) === 'undefined' || req.params.id === '') && (typeof(req.params.page) === 'undefined' || req.params.page === '')) {
    // console.log("first form");
    // console.log(req.body);
    // console.log(req.body.contacts);
    // console.log(req.body.contacts[0].lname);
    data = req.body;

    var minute = 60 * 1000;

    res.cookie('username', data.username, { maxAge: minute });
    res.cookie('business_name', data.business_name, { maxAge: minute });
    res.cookie('phone', data.phone, { maxAge: minute });
    res.cookie('username', data.username, { maxAge: minute });
    res.cookie('email', data.email, { maxAge: minute });
    res.cookie('password', data.password, { maxAge: minute });
    res.cookie('cpassword', data.cpassword, { maxAge: minute });

    req.body.address1 = req.body.billing_address;
    req.body.country = req.body.billing_country;
    req.body.state = req.body.billing_state;
    req.body.city = req.body.billing_city;
    req.body.zip = req.body.billing_zip;
    req.body.billing_region = req.body.shipping_region;
    req.body.region = req.body.billing_region;

    // req.body.address1 = req.body.shipping_address;
    // req.body.country = req.body.shipping_country;
    // req.body.state = req.body.shipping_state;
    // req.body.city = req.body.shipping_city;
    // req.body.zip = req.body.shipping_zip;
    // req.body.region = req.body.shipping_region;

    req.body.stax = (typeof (req.body.stax) != 'undefined' && (req.body.stax != 'y')) ? 'n' : req.body.stax;
    req.body.stax_per = (typeof (req.body.stax_per) != 'undefined') ? req.body.stax_per : 0;
    req.body.first_name = (typeof (req.body.contacts[0].fname) != 'undefined') ? req.body.contacts[0].fname : '';
    req.body.last_name = (typeof (req.body.contacts[0].lname) != 'undefined') ? req.body.contacts[0].lname : '';



    if (data.email == '' || data.password == '' || data.cpassword == '' || data.business_name == '' || data.username == '' || data.phone == '') {
        res.writeHead(302, {
            'Location': '/register/error/Required Field Was Missing'
        });
        res.end();
        return false;
    }

    async.series({
        checkUsername: function (cb) {
            console.log('checkUsername cb', cb);
            // getting userInformations
            var callback = function (err, response) {
                cb(err, response);
                // console.log("checking username");
            }

            faAPI.checkUserExistance(req, "username", req.body.username, callback);
            // faAPI.userInfo(req, userDataCallback);
        },
        checkEmail: function (cb) {
            console.log('checkEmail cb', cb);
            // getting userInformations
            var callback = function (err, response) {
                cb(err, response);
                // console.log("checking username");
            }

            faAPI.checkUserExistance(req, "email", req.body.email, callback);
            // faAPI.userInfo(req, userDataCallback);
        },
        getBillingStateAbbr: function (cb) {
            q.all(common.getStateAbbr('', config.mysql, q, req.body.billing_state)).then(function (result1) {
                console.log('result1[0][0].sc', result1[0][0].sc);
                cb(null, result1[0][0].sc)
            }).fail(function (err) {
                console.log('err.stack', err.stack);
                cb(err, null);
                throw err;
            });
        },
        getShippingStateAbbr: function (cb) {
            q.all(common.getStateAbbr('', config.mysql, q, req.body.shipping_state)).then(function (result1) {
                console.log('result1[0][0].sc', result1[0][0].sc);
                cb(null, result1[0][0].sc)
            }).fail(function (err) {
                console.log('err.stack', err.stack);
                cb(err, null);
                throw err;
            });
        },
        getSalesAdminBySalesCode: function (cb) {
            var user = require('../module/user');
            if (req.body.sccode !== '') {
                q.all([
                    user.getSalesAdminBySalesCode(req, res, config.mysql, req.body.sccode, q)
                ]).then(function (result1) {
                    cb(null, result1[0][0])
                }).fail(function (err) {
                    console.log('err.stack', err.stack);
                    cb(err, null);
                    throw err;
                });
            } else {
                cb(null, []);
            }
        }
    },
        function (err, results) {
            if (err) {
                console.log('if (err) {', err);
                throw err;
            }

            if (results.checkUsername.exists) {
                res.writeHead(302, {
                    'Location': '/register/error/Username already exists.'
                });
                res.end();
                return false;
            } else if (results.checkEmail.exists) {
                res.writeHead(302, {
                    'Location': '/register/error/Email already exists.'
                });
                res.end();
                return false;
            } else {

                req.body.billing_state_abbr = results.getBillingStateAbbr;
                req.body.state_abbr = results.getBillingStateAbbr;
                req.body.shipping_state_abbr = results.getShippingStateAbbr;
                
                req.body.salesAdminBySalesCode = results.getSalesAdminBySalesCode.length ? results.getSalesAdminBySalesCode[0] : '';
                if (req.body.salesAdminBySalesCode != '') {
                    req.body.sc_user_id = req.body.salesAdminBySalesCode.id;
                }

                // register.save(config.mysql, req, res);
                async.series([function (callback) {
                    faAPI.registerUser(req, callback)
                }],
                    // optional callback
                    function (err, results) {

                        if (err) {
                            console.log('if (err) { 1', err);
                            throw err;
                        }

                        // result = results[0][0];
                        result = results[0];

                        var attach = require('../module/attach');
                        attach.save('business', req, res);
                        attach.save('cagreementInsert', req, res);


                        q.all([

                            register.addContacts(config.mysql, req, res, result.userId),
                            register.addShippingDetails(config.mysql, req, res, result.userId),
                            register.addBusinessDetails(config.mysql, req, res, result.userId),
                            register.addSalesSupportDetail(config.mysql, req, res, result.userId),
                            /* select id from templates = [{id : 1}, {id : 1}, {id : 1}] */
                            dashboard.get_temp_ids(req, config.mysql, q)
                        ]).then(function (result1) {
                            console.log('result1', result1);
                            var ids = _.pluck(result1[3][0], 'id');
                            var str = '';

                            for (var i = 0; i < ids.length; i++) {
                                if (ids.length == 1) {
                                    str = str + ids[i];
                                } if (ids.length - 1 == i) {
                                    str = str + ids[i];
                                } else {
                                    str = str + ids[i] + ',';
                                }
                            }
                            req.body.email_settings = str;
                            req.body.result_userid = result.userId;
                            console.log('email-setting', req.body.email_settings);
                            req.body.notify_id = 0;
                            dashboard.save_usernotify(req, config.mysql, q);

                        }).fail(function (err) {
                            console.log('err.stack', err.stack);
                            throw err;
                        });

                        if (req.body.referals != 0 && typeof (req.body.referals) != 'undefined' && req.body.medias != '' && result.userId > 0) {
                            req.body.to_id = result.userId;
                            register.referral(config.mysql, req, res);
                        }
                        /* email module */
                        customerio = require('../module/customerio');
                        customerio.uid = result.userId;
                        //referral update

                        var activeurl = '<br/> <a href="' + $arr.config.spath + '/login">click here to Login...</a>';
                        email = require('../module/email');
                        localm = require('../module/localmail');

                        if (global.emaillocal.status == 'yes') {
                            q.all([localm.mailtemps(req, config.mysql, q, 'register')]).then(function (results2) {
                                if (results2) {
                                    var template = results2[0][0][0].template;
                                    var subject_message = results2[0][0][0].subject;

                                    template = template.replace('{{event.sitename}}', config.title);
                                    template = template.replace('{{event.url}}', activeurl);
                                    template = template.replace('{{event.user}}', req.body.username);
                                    template = template.replace('{{event.siteurl}}', $arr.config.url)
                                    // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                                    localm.sendmail(template, subject_message, req.body.email);

                                } else {
                                    console.log("No Templates named register");
                                }

                            }).fail(function (err) {
                                console.log(err.stack);
                                throw err;
                            });

                            /* start Send to sub admin */
                            if (req.body.salesAdminBySalesCode != '') {
                                q.all([localm.mailtemps(req, config.mysql, q, 'confirm_new_client_member')]).then(function (results3) {
                                    if (results3) {
                                        var template = results3[0][0][0].template;
                                        var subject_message = results3[0][0][0].subject;

                                        var confirm_url = '<a href="' + $arr.config.url + '">Click Here</a>';

                                        template = template.replace('{{event.user}}', (req.body.salesAdminBySalesCode.first_name + ' ' + req.body.salesAdminBySalesCode.last_name));
                                        template = template.replace('{{event.subject}}', 'Confirm a New Client Member');
                                        template = template.replace('{{event.confirm_url}}', confirm_url);

                                        template = template.replace('{{event.username}}', req.body.username);
                                        template = template.replace('{{event.email}}', req.body.email);
                                        template = template.replace('{{event.business_name}}', req.body.business_name);
                                        template = template.replace('{{event.phone}}', req.body.phone);

                                        localm.sendmail(template, subject_message, req.body.salesAdminBySalesCode.email);

                                    } else {
                                        console.log("No Templates named confirm_new_client_member");
                                    }

                                }).fail(function (err) {
                                    console.log(err.stack);
                                    throw err;
                                });
                            }
                            /* end Send to sub admin */

                        } else { console.log('No Mail Delivery method is selected'); }
                        /* email module ends here */

                        if (typeof (req.body.fid) !== 'undefined') {
                            register.updateFid(mysql, req, res, result.userId);
                        }
                        if (typeof (req.body.lid) !== 'undefined') {
                            register.updateLid(mysql, req, res, result.userId);
                        }

                        /* Start for register success message */
                        if (req.body.helpgrow.toString() === '1') {
                            res.cookie('registerSuccessType', 2);
                        } else if (req.body.helpgrow.toString() === '0' && req.body.HerbeeSalesConsultant.toString() === '1') {
                            res.cookie('registerSuccessType', 3);
                        } else {
                            res.cookie('registerSuccessType', 1);
                        }

                        // console.log(2);
                        res.writeHead(302, {
                            // 'Location': '/register/error/Email has been dispatch to you mail id'
                            'Location': '/reg/success'
                            //add other headers here...
                        });
                        res.end();
                        return false;
                    });

                if (req.cookies.cookierefid && req.cookies.cookierefmed) {
                    res.clearCookie('cookierefid');
                    res.clearCookie('cookierefmed');
                }
                delete req.session.ref;
                delete req.session.media;
            }
        });
});
/* ===================== end change by divyesh (changes) ===================== */

app.get(['/', '/:id'], function (req, res) {

    if (typeof (req.session) !== 'undefined' && req.session.userid > 0) {
        res.writeHead(302, {
            'Location': '/'
        });
        res.end();
        return false;
    }

    var admin = require('../module/admin');
    req.body.id = 4;
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        // console.log(JSON.stringify(results));
        $arr['terms'] = results[0][0][0].content;
        $arr.externaljs = ['register', 'jquery.mask.min'];
        $arr.error = $arr.r_id = '';
        register.loadRegisterPage(req, res, $arr, config);
    })

});


app.get('/error/:error', function (req, res) {
    $arr.error = req.param('error');
    register.loadRegisterPage(req, res, $arr, config);
});

app.post('/check_username_exist', function (req, res) {

    async.series({
        checkUsername: function (cb) {
            // getting userInformations
            var callback = function (err, response) {
                cb(err, response);
                console.log("checking username");
            }

            faAPI.checkUserExistance(req, "username", req.body.username, callback);
            // faAPI.userInfo(req, userDataCallback);

        }
    },
        function (err, results) {
            console.log(results);
            console.log(req.body);
            if (err) {
                console.log(err);
                throw err;
            }
            if (results.checkUsername.exists == true) {
                if (req.session.username == req.body.username) {
                    res.json(0);
                } else
                    res.json(1);
            } else res.json(0);

        });
});

app.post('/check_email_exist', function (req, res) {

    async.series({
        checkEmail: function (cb) {
            // getting userInformations
            var callback = function (err, response) {
                cb(err, response);
                console.log("checking email");
            }

            faAPI.checkUserExistance(req, "email", req.body.email, callback);
            // faAPI.userInfo(req, userDataCallback);

        }
    },
        function (err, results) {
            if (err) {
                // console.log(err);
                throw err;
            }
            if (results.checkEmail.exists == true) {
                if (req.session.email == req.body.email) {
                    res.json(0);
                } else
                    res.json(1);
            } else res.json(0);

        });
});

/* ===================== start change by divyesh (added) ===================== */
app.post('/check_sales_consultant_code_exist', function (req, res) {

    if (req.body.sccode.trim() === '') {
        res.json({ status: 200, 'exists': false });
        return true;
    }

    q.all([
        register.checkSalesConsultantCodeExist(config.mysql, req, res)
    ]).then(function (result1) {
        if (result1[0][0][0] !== undefined && result1[0][0][0]['id'] > 0) {
            res.json({ status: 200, 'exists': true });
        } else {
            res.json({ status: 200, 'exists': false });
        }
    });
});
/* ===================== end change by divyesh (added) ===================== */


//Todo check mobile number already exist in db or not - Added by PK
app.post('/check_phone_exist', function (req, res) {

    async.series({
        checkPhone: function (cb) {
            // getting userInformations
            var callback = function (err, response) {
                cb(err, response);
                console.log("checking contact number");
            }

            faAPI.checkUserExistance(req, "phone", req.body.phone, callback);
            // faAPI.userInfo(req, userDataCallback);

        }
    },
        function (err, results) {
            if (err) {
                // console.log(err);
                throw err;
            }
            if (results.checkPhone.exists == true) {
                console.log("8888888888888888888888888");
                console.log(req.session);
                if (req.session.phone == req.body.phone) {
                    res.json(0);
                } else
                    res.json(1);
            } else res.json(0);

        });
});

module.exports = app;