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

var util = require('util');
var express = require('express');
var reload = require('reload');
var async = require('async');
var q = require('q');
var sprintf = require('sprintf').sprintf;
var faAPI = require('../module/forwardauction_api');
var common = require('../module/common');
var app = express.Router();
var stores = require('../module/stores');

app.use(function (req, res, next) {
    //req.session.userid = 1;   
    if (common.checkLogin(req, res, 0)) {
        next();
    } else return false;
    // common.checkLogin(req, res, 0);

    //req.session.userid = 1;

});

var profile = require('../module/profile_settings');

/*  update sales rac details info */
app.post('/stax', function (req, res) {

    $arr.externalcss = ['sidebar-menu', 'style'];
    $arr.externaljs = ['jquery.mask.min'];
    var uid = req.session.userid;
    var user_email = req.session.email;
    console.log(req.body);
    q.all([profile.staxDetails(req, config.mysql, q, uid)]).then(function (results) {

        q.all([profile.updateStaxDetails(req, config.mysql, q)]).then(function (resul) {
            if (resul[0][0].affectedRows > 0) {
                req.session.stax = req.body.stax;
                req.session.stax_per = req.body.stax_per;
            }

            // $arr.loged.stax = req.body.stax;
            // $arr.loged.stax_per = typeof(req.body.stax_per !== 'undefined') ? req.body.stax_per : 0;

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

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        });
        // $arr.loged = req.session;
        //  $arr.loged.stax = req.body.stax;
        //   $arr.loged.stax_per = typeof(req.body.stax_per !== 'undefined') ? req.body.stax_per : 0;
        res.writeHead(302, {
            'Location': '/profile_settings/stax/success'
        });

        res.end();
        return false;

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });

});

/*  update stax page */
app.get(['/stax', '/stax/:action'], function (req, res) {

    $arr['stax'] = 1;
    $arr['heading_common'] = "Sales tax Info";

    $arr.externalcss = ['sidebar-menu', 'style'];
    $arr.updation_status = (typeof (req.params.action) !== 'undefined') ? true : false;
    var uid = req.session.userid;
    q.all([profile.staxDetails(req, config.mysql, q, uid), common.getLocations(req, config.mysql, q)]).then(function (results) {
        if (results[0][0].length > 0) {
            $arr['stax'] = results[0][0][0];
            console.log(JSON.stringify(results[0][0][0]));
        } else {
            $arr['stax'] = [];
            $arr['stax']['first_name'] = '';
        }
        $arr.country = results[1][0];
        common.tplFile('stax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });
});


app.get('/', function (req, res) {

    // $arr['mcats'] = $arr['users'] = '';
    // $arr.externalcss = ['buyer2', 'change_psd'];
    $arr.externaljs = ['jquery.mask.min', 'scripts'];
    // var module = require('../module');
    $arr.pagetitle = '';
    $arr.ptitle = 'profile_settings';
    $arr['heading_common'] = "Profile Setting";

    $arr.profile_settings = 1;

    /*new code*/
    async.series({
        getUserInfo: function (cb) {
            // getting userInformations
            var userDataCallback = function (err, response) {
                cb(null, response);
            }

            faAPI.userInfo(req, req.session.userid, userDataCallback);
        }
    }, function (err, results) {
        console.log('results', results);
        var user = require('../module/user');
        req.body.seller_id = req.session.userid;
        req.body.buyer_id = req.session.userid;

        q.all([user.getBusinessType(res, config.mysql, q, results.getUserInfo.user.id), stores.getOverallSellerRatings(req, $arr.config.mysql, q), stores.getOverallBuyerRatings(req, $arr.config.mysql, q)]).then(function (results2) {
            // console.log('results2', results2);
            // console.log(results2);
            // console.log(results);
            if (results2[0].length > 0) {
                results.getUserInfo.user.business_type = results2[0][0][0].business_type;
                results.getUserInfo.user.business_name = results2[0][0][0].business_name;
                results.getUserInfo.user.license_img = results2[0][0][0].license_img;
                results.getUserInfo.user.business_cert = results2[0][0][0].business_cert;
            }

            // console.log(results);
            $arr['users'] = results.getUserInfo.user;

            $arr['seller_rating'] = results2[1][0][0].seller_rating != null ? results2[1][0][0].seller_rating : 0;
            $arr['buyer_rating'] = results2[2][0][0].buyer_rating != null ? results2[2][0][0].buyer_rating : 0;

            console.log('results2[1][0][0].seller_rating', results2[1][0][0].seller_rating);

            console.log("here :" + JSON.stringify($arr['users']));
            //console.log($arr['country']);
            for (i in $arr['users']) {
                if ($arr['users'][i] == "null" || $arr['users'][i] == null) {
                    $arr['users'][i] = '';
                }
            }
            // q.all(profile.listUserCategories(req, config.mysql, q)).then(function(results2) {
            //     $arr['mcats'] = results2[0][0][0]['mcat'];
            common.tplFile('profile_settings.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        });

        // });
    });

    //  $arr.externalcss = ['buyer2','change_psd']; 
    //  var module = require('../module');
    //  $arr.pagetitle = '';
    //  $arr.ptitle = 'profile_settings';
    //  common.checkLogin(req,res,0);
    //  q.all([profile.profileDetails(req,config.mysql,q,['email','id','first_name','last_name','aboutme','image','avatar','address1','address2','country','state','city','zip','phone','paypal_address','profile_url','verifyphone','nick_name'])]).then(function(results){
    //  $arr['users'] = results[0][0][0];

    //  //console.log($arr['country']);
    //  for(i in $arr['users'])
    //  {
    //      if($arr['users'][i] == null)
    //      {
    //          $arr['users'][i] = '';
    //      }   
    //  }
    //  q.all(profile.listUserCategories(req,config.mysql,q)).then(function(results2){ 
    // $arr['mcats'] = results2[0][0]['mcat'];
    // common.tplFile('profile_settings.tpl');
    // common.headerSet(1);
    // common.loadTemplateHeader(req,res,$arr);
    //  });
    // });    
});

app.post('/address', function (req, res) {
    req.session.zipcode = req.param('zipcode');
    profile.saveADetails(req, config.mysql, q);
    res.writeHead(302, {
        'Location': '/profile_settings/'
    });
    res.end();
    return false;
});

app.get('/view/:viewuid', function (req, res) {
    $arr['mcats'] = $arr['users'] = '';
    $arr.externalcss = ['buyer2', 'change_psd'];
    var module = require('../module');
    $arr.pagetitle = '';
    $arr.ptitle = 'profile_settings';
    q.all(profile.profileDetails(req, config.mysql, q, ['email', 'id', 'first_name', 'last_name', 'aboutme', 'image', 'avatar', 'address1', 'address2', 'country', 'state', 'city', 'zip', 'phone', 'paypal_address', 'profile_url'])).then(function (results) {
        $arr['users'] = results[0][0];
        q.all(profile.listUserCategories(req, config.mysql, q)).then(function (results2) {
            $arr['mcats'] = results2[0][0]['mcat'];
            console.log($arr['mcats']);
            common.tplFile('profile_view.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    });
});

app.post('/shipping', function (req, res) {
    $arr.externalcss = ['sidebar-menu', 'style'];
    $arr.externaljs = ['jquery.mask.min'];
    var uid = req.session.userid;
    var user_email = req.session.email;
    $arr['heading_common'] = "Shipping Info";
    q.all([profile.shippingDetails(req, config.mysql, q, uid),common.getStateAbbr('', config.mysql, q, req.body.state)]).then(function (results) {
        req.body.state_abbr = results[1][0][0].sc;

        console.log(results[0][0].length, "  <<<<<<<<============================================= ")
        if (results[0][0].length == 0) {
            profile.addShippingDetails(req, config.mysql, q);
        } else {
            
            profile.updateShippingDetails(req, config.mysql, q);

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
        }

        // var str = req.headers.referer;
        // var n = str.includes("/profile_settings/shipping");

        res.writeHead(302, {
            'Location': '/profile_settings/shipping/success'
        });

        res.end();
        return false;
    });
});

app.get(['/shipping', '/shipping/:action'], function (req, res) {
    $arr['shipping'] = 1;
    $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";

    $arr.externalcss = ['sidebar-menu'];
    $arr.externaljs = ['jquery.mask.min'];
    $arr.updation_status = (typeof (req.params.action) !== 'undefined') ? true : false;
    var uid = req.session.userid;
    q.all([profile.shippingDetails(req, config.mysql, q, uid), common.getLocations(req, config.mysql, q)]).then(function (results) {
        if (results[0][0].length > 0) {
            $arr['shipping'] = results[0][0][0];
            if(results[0][0][0].first_name == ''){
                $arr['shipping']['first_name'] = results[0][0][0].business_name;
            }
            if(results[0][0][0].last_name == ''){
                $arr['shipping']['last_name'] = results[0][0][0].business_name;
            }
        } else {
            $arr['shipping'] = [];
            $arr['shipping']['first_name'] = '';
        }
        $arr['shipping'] = results[0][0][0];
        $arr.country = results[1][0];
        common.tplFile('shipping.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

/*  update billing info */
app.post('/billing', function (req, res) {


    $arr.externalcss = ['sidebar-menu', 'style'];
    $arr.externaljs = ['jquery.mask.min'];
    var uid = req.session.userid;
    var user_email = req.session.email;

    q.all([profile.billingDetails(req, config.mysql, q, uid)]).then(function (results) {

        if (results[0][0].length == 0) {
            profile.addBillingDetails(req, config.mysql, q);
        } else {
            profile.updateBillingDetails(req, config.mysql, q);

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

        }

        res.writeHead(302, {
            'Location': '/profile_settings/billing/success'
        });

        res.end();
        return false;
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });

});

/*  update billing page */
app.get(['/billing', '/billing/:action'], function (req, res) {
    $arr['billing'] = 1;
    $arr['heading_common'] = "MARKET ACTIVITY DASHBOARD";

    $arr.externalcss = ['sidebar-menu', 'style'];
    $arr.externaljs = ['jquery.mask.min'];
    $arr.updation_status = (typeof (req.params.action) !== 'undefined') ? true : false;
    var uid = req.session.userid;
    q.all([profile.billingDetails(req, config.mysql, q, uid), common.getLocations(req, config.mysql, q)]).then(function (results) {
        if (results[0][0].length > 0) {
            $arr['billing'] = results[0][0][0];
            console.log(JSON.stringify(results[0][0][0]));
        } else {
            $arr['billing'] = [];
            $arr['billing']['first_name'] = '';
        }
        $arr.country = results[1][0];
        common.tplFile('billing.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });
});


app.post('/update/', function (req, res) {

    var attach = require('../module/attach');
    var user = require('../module/user');
    attach.save('profile', req, res);
    $arr['save'] = true;
    //should be replace with FAApi - userInfo async call : reference >> 1

    /* FAapi method need's to be place here */
    // req.body.address1,
    // req.body.country,
    // req.body.state,
    // req.body.city,
    // req.body.zip,
    // req.body.region,
    // req.body.state_abbr,
    // console.log("front end data" + JSON.stringify(req.body));

    async.series({

        setStateAbbr: function (cb) {
            q.all(common.getStateAbbr('', config.mysql, q, req.body.state)).then(function (result1) {
                req.body.state_abbr = result1[0][0].sc;
                console.log(result1[0][0].sc)
                cb(null, result1[0][0].sc)
            }).fail(function (err) {
                console.log(err.stack);
                cb(err, null);
                throw err;
            });
        },
        updateUser: function (cb) {
            // getting userInformations
            var updateUserCallback = function (err, response) {
                console.log("*************************")
                if (!err) {
                    delete req.session.username;
                    req.session.username = req.body.username;
                    $arr.loged = req.session
                }
                cb(null, response);
            }

            faAPI.updateUser(req, '', updateUserCallback);
        },
        getBusinessType: function (cb) {

            q.all([user.getBusinessType(req, config.mysql, q, req.session.userid)]).then(function (result1) {
                cb(null, result1[0][0])
            }).fail(function (err) {
                console.log(err.stack);
                cb(err, null);
                throw err;
            });
        }
    }, function (err, results) {
        // console.log(results);
        // console.log(results.getBusinessType.length > 0);
        // console.log(results.getBusinessType[0].business_type);
        if (err) {
            console.log(err.stack);
        }

        // typeof(req.body.business_name) !== 'undefined' ? req.body.business_name : '',
        // typeof(req.body.business_type) !== 'undefined' ? req.body.business_type : '',
        // typeof(req.body.license_img) !== 'undefined' ? req.body.license_img : '',
        // typeof(req.body.business_cert) !== 'undefined' ? req.body.business_cert : '',
        // typeof(req.body.ein_number) !== 'undefined' ? req.body.ein_number : '',
        // typeof(req.body.stax) !== 'undefined' ? req.body.stax : '',
        // typeof(req.body.stax_per) !== 'undefined' ? req.body.stax_per : '',
        // /* Added for address same as userprofile */
        // req.body.address1,
        // req.body.country,
        // req.body.state,
        // req.body.city,
        // req.body.zip,
        // req.body.region,
        // req.body.state_abbr,
        // datge,
        // userId

        // console.log("profile settings", JSON.stringify(results));
        var user_email = req.session.email;
        console.log(req.body);
        var admin = require('../module/admin');
        if (results.getBusinessType.length > 0) {
            user.updateBusiness(config.mysql, req, res, req.session.userid)
        }
        delete admin;

        if (typeof (req.body.categories) != 'undefined') {
            var async = require('async');
            async.each(req.body.categories, managecats, function (err) {
                if (err) return console.error(err);
                res.writeHead(302, {
                    'Location': '/profile_settings/'
                });
                res.end();
                return false;
            });
        } else {

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
                'Location': '/profile_settings/'
            });
            res.end();
            return false;
        }

    });

});

/*
app.post('/update/', function(req, res){
    console.log(JSON.stringify(req.body));
    res.json(req.body);
    // var attach = require('../module/attach');
    // attach.save('profile',req,res);  
    // $arr['save'] = true;

    // q.all(profile.saveDetails(req,config.mysql,q)).then(function(results){
    //  var managecats = function(mcat, cb) {
    //      profile.managecategories(req,config.mysql,q,mcat);
    //      cb(null);  
    //  }   
    //  profile.removeCategories(req,config.mysql,q);
    //  if(typeof(req.body.categories) !='undefined')
    //  {
    //      var async = require('async');
    //      async.each(req.body.categories, managecats, function(err) {
    //          if (err) return console.error(err);
    //          res.writeHead(302, {
    //              'Location': '/profile_settings/'
    //          });
    //          res.end();return false;
    //      });
    //  }
    //  else
    //  {
    //      res.writeHead(302, {
    //          'Location': '/profile_settings/'
    //      }); 
    //      res.end();return false;
    //  }
    // });
});*/

/* ===================== start change by divyesh (added) ===================== */
app.get(['/sales_support_settings/', '/sales_support_settings/:action'], function (req, res) {

    $arr.externaljs = ['jquery.mask.min', 'scripts'];
    $arr.pagetitle = '';
    $arr.ptitle = 'sales_support_settings';
    $arr['heading_common'] = "Sales Support";
    $arr['email'] = req.session.email;
    $arr['update_message'] = '';
    $arr.updation_status = 0;
    if (typeof (req.params.action) !== 'undefined') {

        if (req.params.action == 'invalid_code') {
            $arr['update_message'] = 'invalid Sales Consultant Code.';
            $arr.updation_status = 2;
        } else {
            $arr['update_message'] = 'Sales Support updated successfully.';
            $arr.updation_status = 1;
        }
    }

    $arr.sales_support_settings = 1;

    var user = require('../module/user');
    q.all([
        user.getSalesSupport(req, res, config.mysql, req.session.userid)
    ]).then(function (result1) {
        $arr['ss_data'] = result1[0][0][0];

        common.tplFile('sales_support_settings.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });;
});


app.post('/update_sales_support_settings/', function (req, res) {

    var attach = require('../module/attach');
    var user = require('../module/user');
    var register = require('../module/register');

    $arr['update_message'] = '';

    q.all([
        user.getSalesConsultantByCode(req, res, config.mysql, req.body.sccode, q)
    ]).then(function (resultSS) {
        console.log('resultSS[0][0] ', resultSS[0][0]);
        if (resultSS[0][0].length > 0) {

            if (typeof (req.files.cagreement) !== 'undefined') {
                console.log('req.files', req.files);
                attach.save('cagreement', req, res);
            }

            req.body.sc_user_id = resultSS[0][0][0].created_by;

            q.all([
                parseInt(req.body.id) > 0 ?
                    user.updateSalesSupport(req, res, config.mysql, req.session.userid, q)
                    :
                    register.addSalesSupportDetail(config.mysql, req, res, req.session.userid)
            ]).then(function (result1) {
                res.writeHead(302, {
                    'Location': '/profile_settings/sales_support_settings/success'
                });
                res.end();
                return false;
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            });
        } else {
            res.writeHead(302, {
                'Location': '/profile_settings/sales_support_settings/invalid_code'
            });
            res.end();
            return false;
        }

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });
});


app.get(['/transaction_ratings'], function (req, res) {

    $arr.externaljs = ['jquery.mask.min', 'scripts'];
    $arr.pagetitle = '';
    $arr.ptitle = 'transaction_ratings';
    $arr['heading_common'] = "Transaction Ratings";
    $arr['email'] = req.session.email;
    $arr['update_message'] = '';
    $arr.transaction_ratings = 1;
    req.body.page = typeof(req.param('page')) == 'undefined' ? 1 : req.param('page');

    req.body.seller_id = req.session.userid;
    req.body.buyer_id = req.session.userid;
    req.body.userid = req.session.userid;
    
    var user = require('../module/user');
    q.all([
        (req.session.business_type=='dispensary') ? stores.getBuyerReviews(req, $arr.config.mysql, q, 0) : stores.getSellerReviews(req, $arr.config.mysql, q, 0) ,
        (req.session.business_type=='dispensary') ? stores.getBuyerReviews(req, $arr.config.mysql, q, 1) : stores.getSellerReviews(req, $arr.config.mysql, q, 1) ,
        stores.getOverallSellerRatings(req, $arr.config.mysql, q),
        stores.getOverallBuyerRatings(req, $arr.config.mysql, q),
    ]).then(function(results) {

        $arr['pagination'] = results[1][0][0].total_reviews;
        $arr['reviews'] = results[0][0];

        $arr['seller_rating'] = results[2][0][0].seller_rating != null ? results[2][0][0].seller_rating : 0;
        $arr['buyer_rating'] = results[3][0][0].buyer_rating != null ? results[3][0][0].buyer_rating : 0;
        console.log('results[2][0][0].seller_rating', results[2][0][0].seller_rating);
        console.log('results[3][0][0].buyer_rating', results[3][0][0].buyer_rating);

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, { page: '' });
        $arr['search'] = query;
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/profile_settings/transaction_ratings/' + fquery,
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination'],
        });

        $arr['pagination_html'] = paginator.render();

        common.tplFile('transaction_ratings.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });;
});

app.get(['/ratings/:action/:rating_id'], function (req, res) {

    $arr.externaljs = ['jquery.mask.min', 'scripts'];
    $arr.pagetitle = '';
    $arr.ptitle = 'transaction_ratings';
    $arr['heading_common'] = "Transaction Ratings";
    $arr['email'] = req.session.email;
    $arr['update_message'] = '';
    $arr.transaction_ratings = 1;
    req.body.page = typeof(req.param('page')) == 'undefined' ? 1 : req.param('page');

    req.body.rating_id = req.params.rating_id;
    var action = req.params.action;

    q.all([
        (action == 'buyer') ? stores.getBuyerReviewsDetail(req, $arr.config.mysql, q) : stores.getSellerReviewsDetail(req, $arr.config.mysql, q)
    ]).then(function(results) {

        $arr['rating_data'] = results[0][0][0];
        $arr['rating_data'].rating_type = action;
        
        console.log('results[0][0]', results[0][0][0]);

        common.tplFile('transaction_ratings_detail.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });;
});

app.get(['/pending_payments'], function (req, res) {

    $arr.externaljs = ['jquery.mask.min', 'scripts'];
    $arr.pagetitle = '';
    $arr.ptitle = 'pending_payments';
    $arr['heading_common'] = "Transaction Ratings";
    $arr['email'] = req.session.email;
    $arr['update_message'] = '';
    $arr.pending_payments = 1;
    req.body.page = typeof(req.param('page')) == 'undefined' ? 1 : req.param('page');
    // req.body.product_id = typeof(req.param('product_id')) == 'undefined' ? 0 : req.param('product_id');
    req.body.userid = req.session.userid;
    
    var user = require('../module/user');
    q.all([
        stores.getPendingPayments(req, $arr.config.mysql, q, 0),
        stores.getPendingPayments(req, $arr.config.mysql, q, 1)
    ]).then(function(results) {

        $arr['pagination'] = results[1][0].length;
        $arr['payments'] = results[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, { page: '' });
        $arr['search'] = query;
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/profile_settings/transaction_ratings/' + fquery,
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination'],
        });

        $arr['pagination_html'] = paginator.render();

        common.tplFile('pending_payments.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });;
});
app.get(['/pay_pending_payment/:product_id/:amount'], function (req, res) {

    $arr.externaljs = ['jquery.mask.min', 'scripts'];
    $arr.pagetitle = '';
    $arr.ptitle = 'transaction_ratings';
    $arr['heading_common'] = "Transaction Ratings";
    $arr['email'] = req.session.email;
    $arr['update_message'] = '';
    $arr.transaction_ratings = 1;
    req.body.page = typeof(req.param('page')) == 'undefined' ? 1 : req.param('page');
    req.body.product_id = typeof(req.param('product_id')) == 'undefined' ? 0 : req.param('product_id');
    req.body.amount = typeof(req.param('amount')) == 'undefined' ? 0 : parseFloat(req.param('amount'));
    
    req.body.userid = req.session.userid;

    q.all([
        stores.getUserBalance(req, $arr.config.mysql, q)
    ]).then(function(resultsU) {
        console.log('getUserBalance', resultsU[0][0][0]);
        if(resultsU[0][0][0].balance > req.body.amount) {
            req.body.decreaseAmount = req.body.amount;

            q.all([
                stores.decreaseUserBalance(req, $arr.config.mysql, q),
                stores.getPayPendingDetail(req, $arr.config.mysql, q)
            ]).then(function(results) {

                /* $arr['rating_data'] = results[0][0][0];
                
                console.log('results[0][0]', results[0][0][0]); */

                res.writeHead(302, {
                    'Location': '/profile_settings/pending_payments'
                });
                res.end();
                return false;

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            });
        } else {
            res.writeHead(302, {
                'Location': '/payment/wirefund/1'
            });
            res.end();
            return false;
        }
        
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });
});
/* ===================== end change by divyesh (added) ===================== */

module.exports = app;
