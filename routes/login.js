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
var reload = require('reload');
// var sprintf = require('sprintf').sprintf;
var common = require('../module/common');
var session = require('express-session');
var app = express.Router();
var cryptos = require('../module/crypto.js');
var mysqli = require('../module/mysqli');
var cookieParser = require('cookie-parser');
var async = require('async');
var faAPI = require('../module/forwardauction_api');
var localm = require('../module/localmail');
var q = require('q');
var stores = require('../module/stores');
//login check router

/* login by email and password */
app.post('/save', function(req, res) {
    console.log('loginrunning');
    if (typeof(req.body.autologin) == 'undefined') {
        //common.checkLogin(req,res,1);

    } else
        req.session.autologin = req.body.autologinoption;

    var login = require('../module/login');

    req.body.templogin = (typeof(req.body.templogin) == 'undefined') ? 0 : req.body.templogin;

    if (req.body.templogin > 0) {
        delete session;
        req.session.userid = req.body.id;
        req.session.email = req.body.email;
        req.session.username = req.body.username;
        res.json({
            'success': true
        });
        res.end();
        return false;
    } else {
        async.series([function(callback) {
                faAPI.loginUser(req, callback);
            }],
            // optional callback
            function(err, row) {

                // console.log("1) row results is here : " + JSON.stringify(row));
                // console.log("1) row results id : " + JSON.stringify(row[0].user[0].id));

                if (err) {
                    console.log(err);
                    if (err.code == 'L0004') {
                        res.writeHead(302, {
                            'Location': '/login?error=7'
                        });
                        res.end();
                    } else if (err.code == 'D1016') {
                        res.writeHead(302, {
                            'Location': '/login?error=1'
                        });
                        res.end();
                    } else {
                        console.log(JSON.stringify(err));
                        throw err;
                    }
                } else {

                    if (row[0] != null && row[0].user.length > 0) {
                        // console.log(row[0]);
                        /* If deleted */
                        if (row[0].user[0].del_status == 1) {
                            res.writeHead(302, {
                                'Location': '/login?error=10'
                            });
                            res.end();
                            return false;
                        } else {
                            /* if pending */
                            if (row[0].user[0].status == 'unverified') {
                                res.writeHead(302, {
                                    'Location': '/login?error=5'
                                });
                                res.end();
                                return false;
                            }

                            /* if suspended */
                            if (row[0].user[0].status == 'deactivate') {
                                res.writeHead(302, {
                                    'Location': '/login?error=9'
                                });
                                res.end();
                                return false;
                            }
                             /* if rejected */
                            if (row[0].user[0].status == 'moderate') {
                                res.writeHead(302, {
                                    'Location': '/login?error=8'
                                });
                                res.end();
                                return false;
                            }

                            /* if active */
                            if (row[0].user[0].status != 'active') {
                                if (req.body.loginpage == 1) {
                                    res.writeHead(302, {
                                        'Location': '/login?error=2'
                                    });
                                    res.end();
                                    return false;
                                } else {
                                    res.writeHead(302, {
                                        'Location': '/login?error=2'
                                    });
                                    res.end();
                                    return false;
                                }
                            }
                        }
                        delete req.session.userid;
                        delete req.session.email;
                        delete req.session.username;
                        delete req.session.first_name;
                        delete req.session.last_name;
                        delete req.session.permission;
                        delete req.session.zipcode;
                        delete req.session.address;
                        delete req.session.country;
                        delete req.session.state;
                        delete req.session.state_abbr;
                        delete req.session.city;
                        delete req.session.region;
                        delete session;

                        var membership = require('../module/membership');
                        var user = require('../module/user');
                        var cart = require('../module/cart');

                        q.all([
                            membership.getUserMembership(res, config.mysql, q, row[0].user[0].id),
                            user.getTotalProduct(res, config.mysql, q, row[0].user[0].id),
                            user.getTotalBid(res, config.mysql, q, row[0].user[0].id),
                            membership.getUserRolelogin(req, config.mysql, q, row[0].user[0].id),
                            user.getTotalBuyNowProduct(res, config.mysql, q, row[0].user[0].id),
                            user.getBusinessType(res, config.mysql, q, row[0].user[0].id),
                            stores.getstoreidlogin(res, config.mysql, q, row[0].user[0].id),
                            common.getbusirestrictions(res, config.mysql, q)
                        ]).then(function(result2) {
console.log('row[0].user[0]', row[0].user[0]);
                            // if swtch user
                            if (req.body.templogin > 0) {
                                req.session.admin = 1;
                                req.session.templogin = 1;
                            }
                            // console.log('business_type', result2[5][0][0]);
                            if (result2[5][0].length > 0) {
                                req.session.business_type = result2[5][0][0].business_type;
                                req.session.business_name = result2[5][0][0].business_name;
                                req.session.stax = result2[5][0][0].stax;
                                req.session.stax_per = result2[5][0][0].stax_per;
                                if (result2[7][0].length > 0) {

                                    for (var i = 0; i < result2[7][0].length; i++) {
                                        if (result2[5][0][0].business_type == result2[7][0][i].business_type)
                                            req.session.business_settings = result2[7][0][i];
                                    }
                                }
                            }

                            if (result2[3][0][0]) {
                                if (result2[3][0][0]['recurring'] == 1) {
                                    var ch = global.bgateway.subscription.find(result2[3][0][0]['tran_id'], function(err, result) {

                                        if (result.statusHistory[0].status != 'Active') {
                                            membership.updatePaid(req, config.mysql, q, row[0].user[0].id, 0);
                                        } else {
                                            membership.updatePaid(req, config.mysql, q, row[0].user[0].id, 1);
                                        }


                                    });
                                }
                            }

                            req.session.permission = false;
                            req.session.productcountyear = 0;
                            req.session.bidcountyear = 0;
                            req.session.productcountmonth = 0;
                            req.session.bidcountmonth = 0;
                            req.session.buynowcountyear = 0;
                            req.session.buynowcountmonth = 0;

                            var permissions = result2[0][0];

                            if (permissions.length > 0) {
                                req.session.permission = true;
                            }
                            for (i in permissions) {
                                req.session[permissions[i]['varname']] = permissions[i]['value'];

                            }

                            req.session.productcountyear = (result2[1][0][0]['ycnt'] > 0) ? result2[1][0][0]['ycnt'] : 0;
                            req.session.productcountmonth = (result2[1][0][0]['mcnt'] > 0) ? result2[1][0][0]['mcnt'] : 0;

                            req.session.bidcountyear = (result2[2][0][0]['ycnt'] > 0) ? result2[2][0][0]['ycnt'] : 0;
                            req.session.bidcountmonth = (result2[2][0][0]['mcnt'] > 0) ? result2[2][0][0]['mcnt'] : 0;

                            req.session.buynowcountyear = (result2[4][0][0]['ycnt'] > 0) ? result2[4][0][0]['ycnt'] : 0;
                            req.session.buynowcountmonth = (result2[4][0][0]['mcnt'] > 0) ? result2[4][0][0]['mcnt'] : 0;

                            req.session.used_image_space = (result2[1][0][0]['used_image_space'] > 0) ? result2[1][0][0]['used_image_space'] : 0;
                            req.session.email = row[0].user[0].email;

                            req.session.userid = row[0].user[0].id;
                            req.session.roleid = row[0].user[0].role;

                            req.session.first_name = row[0].user[0].first_name;
                            req.session.username = row[0].user[0].username;
                            req.session.last_name = row[0].user[0].last_name;
                            req.session.zipcode = row[0].user[0].zip;
                            req.session.phone = row[0].user[0].phone;
                            req.session.state = row[0].user[0].state;
                            req.session.state_abbr = row[0].user[0].state_abbr;
                            req.session.city = row[0].user[0].city;
                            req.session.region = row[0].user[0].region;
                            req.session.used_attach_space = result2[1][0][0].used_image_space;
                            if (result2[6][0].length == 0) {
                                req.session.storeid = 0;
                            } else {
                                req.session.storeid = result2[6][0][0].id;
                            }

                            common.last_login_update(req,config.mysql, q)
                            //req.session.storeid =  result2[6][0][0][0].id;

                            country = row[0].user[0].country;

                            if (country == null) {

                                req.session.country = '';
                            } else {

                                //req.session.country = country.toLowerCase();
                                req.session.country = country;
                            }

                            req.session.test = true;


                            // console.log(result2[3][0].length);
                            if (result2[3][0].length > 0) {
                                req.session.membershipstatus = result2[3][0][0]['status']
                            } else {
                                req.session.membershipstatus = '';
                            }

                            /*if(typeof(result2[1][0][0]['status']) !== 'undefined') {
                                req.session.membershipstatus = result2[1][0][0]['status']
                            }
                            else
                            {
                                req.session.membershipstatus = '';
                            }
                            */


                            $arr.loged = req.session;
                            // console.log(req);
                            // console.log(req.session);
                            if (req.body.remember === '1') {
                                res.cookie('cookiepassword', req.body.password);
                                res.cookie('cookieemail', req.body.username);
                                res.cookie('cookieremember', req.body.remember);
                            } else {
                                res.clearCookie('cookiepassword');
                                res.clearCookie('cookieemail');
                                res.clearCookie('cookieremember');
                            }


                            /* Start for cart */
                            /* q.all([
                                cart.tempCartDetails(req, config.mysql, q)
                            ]).then(function(resultCart) {
                                console.log('resultCart[0][0].length', resultCart[0][0].length);
                                req.session.pid = [];
                                req.session.products = [];
                                if(resultCart[0][0].length) {
                                    for (var index = 0; index < resultCart[0][0].length; index++) {
                                        var element = resultCart[0][0][index];
                                        if(element.product_data != '') {
                                            console.log('element.product_data', element.product_data);
                                            var product_data = JSON.parse(element.product_data);
                                            req.session.pid.push(product_data.id);
                                            req.session.products.push(product_data);
                                        }
                                    }
                                }
                                setTimeout(() => {
                                    console.log('req.session.pid', req.session.pid);
                                    console.log('req.session.products', req.session.products);
                                }, 3000);
                            }); */
                            /* End for cart */

                            var allow = common.checkPermission('allow_to_post', req);

                            //Get url from login template to goto last url...
                            if (req.body.templogin) {
                                res.json({ 'status': true });
                            } else {
                                if (req.body.last_url != 'undefined' && req.body.last_url != '' && req.body.last_url) {
                                    res.writeHead(302, {
                                        'Location': req.body.last_url
                                    });
                                } else {

                                    if (row[0].user[0].balance <= 0) {

                                        res.writeHead(302, {
                                            'Location': '/payment/wirefund'
                                        })

                                    } else {

                                        if (!(req.session.permission == true && req.session.membershipstatus == 'active')) {
                                            console.log('package---------------------');

                                            res.writeHead(302, {
                                                'Location': '/package'
                                            });

                                        } else {

                                            res.writeHead(302, {
                                                'Location': '/market/selection'
                                            });

                                        }
                                    }

                                }

                                res.end();
                                return false;
                            }
                        }).fail(function(err) {
                            console.log(err.stack);
                            throw err;
                        }).done();
                    } else {
                        if (req.body.loginpage == 1) {
                            res.writeHead(302, {
                                'Location': '/login?error=1'
                            });
                            res.end();
                            return false;
                        } else {
                            res.writeHead(302, {
                                'Location': '/login?error=1'
                            });
                            res.end();
                            return false;
                        }
                    }
                    if (req.cookies.cookierefid && req.cookies.cookierefmed) {
                        res.clearCookie('cookierefid');
                        res.clearCookie('cookierefmed');
                    }
                    delete req.session.ref;
                    delete req.session.media;
                }

            });
    }
});

/* Rendering login page */
app.get('/', function(req, res) {

    if (typeof(req.session) !== 'undefined' && req.session.userid > 0) {
        res.writeHead(302, {
            'Location': '/'
        });
        res.end();
        return false;
    } else {

        console.log(3);
        if (req.cookies.cookierefid && req.cookies.cookierefmed) {
            req.session.ref = req.cookies.cookierefid;
            req.session.media = req.cookies.cookierefmed;
            $arr.refers = req.session.ref;
            $arr.med = req.session.media;
        }
        $arr['last_url'] = common.last_url(req);
        Recaptcha = require('recaptcha').Recaptcha;

        //    var PUBLIC_KEY  = config.captachapublickey,
        // PRIVATE_KEY = config.captachaprivatekey;

        var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
            PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';

        console.log(PUBLIC_KEY + '&&' + PRIVATE_KEY);
        var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
        $arr.captchahtml = recaptcha.toHTML();


        if (req.cookies.cookieemail) {
            $arr['cookieemail'] = req.cookies.cookieemail;
            $arr['cookiepassword'] = req.cookies.cookiepassword;
            $arr['cookieremember'] = req.cookies.cookieremember;

        }
        if (req.param('error')) {
            if (req.param('error') == 1) {
                $arr['login_error'] = 'Invalid Username/Password';
            }
            if (req.param('error') == 2) {
                $arr['login_error'] = 'Your account is deactivated.Please <a style="text-decoration: underline !important;" href="'+ global.url +'/contact">Contact Support</a>';
            }
            if (req.param('error') == 3) {
                $arr['login_error'] = 'Registered successfully. Please check your mail to activate your account';
            }
            if (req.param('error') == 4) {
                $arr['login_error'] = 'Your account is activated!';
            }
            if (req.param('error') == 5) {
                $arr['login_error'] = 'Your account has been not activated yet.';
            }
            if (req.param('error') == 6) {
                $arr['login_error'] = 'Admin will activate your account in 48 hours, Thank you for registering...';
            }
            if (req.param('error') == 7) {
                $arr['login_error'] = 'Invalid Password';
            }
            if (req.param('error') == 8) {
                $arr['login_error'] = 'Your account activation request has been rejected. Please <a href="'+ global.url +'/contact">Contact Support</a>';
            }
            if (req.param('error') == 9) {
                $arr['login_error'] = 'Your account has been suspended. Please <a style="text-decoration: underline !important;" href="'+ global.url +'/contact">Contact Support</a>';
            }
            if (req.param('error') == 10) {
                $arr['login_error'] = 'Your account has been deleted. Please <a style="text-decoration: underline !important;" href="'+ global.url +'/contact">Contact Support</a>';
            }
        } else {
            $arr['login_error'] = '';
        }


        //common.checkLogin(req,res,1);

        $arr.loged = req.session;
        var login = require('../module/login');
        console.log(4);
        login.login(req, res, $arr);
    }
});

app.get('/logout/new', function(req, res) {

    var admin = typeof(req.session.admin) == 'undefined' ? '' : req.session.admin;
    var templogin = typeof(req.session.templogin) == 'undefined' ? '' : req.session.templogin;

    if(admin == 1){
        delete session;
        req.session.destroy();
        res.writeHead(302, {
            'Location': '/admin/login'
        });
        res.end();
    }

    if(templogin > 0) { // IF it is not a admin

        console.log("In elseeeeeeeeeeeeeee");
        res.writeHead(302, {
            'Location': '/admincp/dashboard/'
        });
        res.end();
        return false;

    } else {
            delete session;
            req.session.destroy();
            common.checkLogin(req, res, 0);
    }

});

app.get('/logout', function(req, res) {
    if (req.session.admin == 1) {
        delete req.session.admin;
        delete req.session.userid;
        delete req.session.email;
        delete session;

        res.writeHead(302, {
            'Location': '/admin/login'
        });
        res.end();
        return false
    };
    if (typeof(req.session.pid) === 'undefined') {
        console.log("g4g4g4g4g4");
        delete req.session.userid;
        delete req.session.email;
        res.cookie('cookierefid', req.session.ref);
        res.cookie('cookierefmed', req.session.media);
        // console.log("Temp login issssssssssss " + req.session.templogin);
        if ((typeof(req.session.templogin) == 'undefined')) { // IF it is not a admin
            delete session;
            //req.session.destroy();
            common.checkLogin(req, res, 0);
        } else {
            console.log("In elseeeeeeeeeeeeeee");
            res.writeHead(302, {
                'Location': '/admincp/dashboard/'
            });
            res.end();
            return false;
        }

    } else {
        console.log("w8w8w8w8w8w");
        var cart = require('../module/cart');
        var sess_length = req.session.pid.length;
        /*   q.all([cart.tempCartDetails(req, config.mysql, q)]).then(function(results){
                  if (results.length>0) {
                      console.log('length', results[0][0].length);
                  for (var i = 0; i < results[0][0].length; i++) {
                      console.log('cart',results[0][0][i]);
                      cart.removeBookedQty(req, config.mysql, q, results[0][0][i].project_id, results[0][0][i].qty);
                       };
                  };
              });*/
        // console.log('asdasd' + sess_length);
        for (i = 0; i < sess_length; i++) {

            // console.log(req.session.pid[i]);
            // console.log(req.session.products[i]['qty_add']);
            console.log("2232323232232323");
            console.log(req.session.pid[i]);
            var newpdt = [];
            newpdt['project_id'] = req.session.pid[i]

            cart.deleterecurring(req, config.mysql, q, newpdt);
            cart.removeTempItem(req, config.mysql, q, req.session.pid[i], req.session.products[i]['qty_add']);

            //delete req.session.pid[i];
            //delete req.session.products[i]['qty_add'];
            req.session.pid = req.session.pid.filter(function(n) {
                return n != undefined
            });
            req.session.products = req.session.products.filter(function(n) {
                return n != undefined
            });

            delete req.session.pid[i];
            delete req.session.products[i]['qty_add'];

        }
        req.session.pid = [];
        // console.log('asd' + req.session.pid.length);
        // console.log('asd' + req.session.pid);
        if (req.session.pid.length == 0) {
            delete req.session.temp_cart_id;
            delete req.session.temp_time_id;
            delete req.session.pid;
            delete req.session.products;
            delete req.session.timer;
            delete req.session.userid;
            delete req.session.email;
            delete req.session.phone;
            res.cookie('cookierefid', req.session.ref);
            res.cookie('cookierefmed', req.session.media);
            if ((typeof(req.session.templogin) == 'undefined')) { // IF it is not a admin
                delete session;
                console.log('asdasd');
                req.session.destroy();
                req.body.last_url = '';

                common.checkLogin(req, res, 0);

            } else {
                res.writeHead(302, {
                    'Location': '/admincp/dashboard'
                });
                res.end();
                return false;
            }
        }

    }
});


app.get('/forgot_password', function(req, res) {
    $arr['textStatus'] = '';
    var url = require('url');
    var datas_ = url.parse(req.url, true).query;
    if (datas_['id'] == '' || typeof(datas_['id']) == 'undefined') {
        $arr['step1'] = true;
        $arr['step2'] = false;
        $arr['verifyurl'] = '';
        $arr['id'] = '';
    } else {
        $arr['step2'] = true;
        $arr['step1'] = false;
        $arr['verifyurl'] = $arr['id'] = datas_['id'];
    }

    common.tplFile('forgot_password.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.post('/forgot_password', function(req, res) {

    async.series([function(callback) {
            faAPI.userdetails_email(req, "email", callback);
        }],
        // optional callback
        function(err, results) {

            // console.log(JSON.stringify(results));

            if (err) {

                console.log(err);

                $arr['step1'] = true;
                $arr['step2'] = false;
                $arr['step3'] = false;
                if (err.code == 'D1016') {
                    $arr['textStatus'] = 'Please enter registered Email id.';
                }
                // throw err;
            } else {
                if (results.length > 0 && results[0]['email'] == req.body.email) {
                    //customerio = require('../module/customerio');
                    //customerio.uid = results[0]['id'];
                    //customerio.inits();
                    //customerio.createCustomer({ email: req.body.email, user: { firstName: results[0]['first_name'], lastName: results[0]['last_name'] } });
                    var u_ID = results[0]['id'].toString();
                    var hw = cryptos.encrypt(req.body.email + '#' + u_ID);


                    $arr['verifyurl'] = config.url + '/login/forgot_password?id=' + hw
                    //customerio.sendEmail({ event: 'forgot_password', content: { passwordurl: $arr['verifyurl'], firstName: results[0]['first_name'], lastName: results[0]['last_name'] } });
                    q.all([localm.mailtemps(req, config.mysql, q, 'forgot_password')]).then(function(results2) {
                        if (results2) {
                            var template = results2[0][0][0].template;
                            var subject_message = results2[0][0][0].subject;
                            template = template.replace('{{event.user}}', results[0]['first_name']);
                            template = template.replace('{{event.user_name}}', results[0]['last_name']);
                            template = template.replace('{{event.verifyurl}}', $arr['verifyurl']);
                            // template = template.replace('{{event.verifyurl}}', $arr['verifyurl']);
                            template = template.replace('{{event.url}}', config.url);
                            localm.sendmail(template, subject_message, req.body.email);
                            $arr['step1'] = false;
                            $arr['step2'] = false;
                            $arr['step3'] = true;
                            $arr['textStatus'] = 'Email has been dispatched to your Registered Email ID to reset your Password';
                            // res.end();
                            return false;
                        } else {
                            $arr['textStatus'] = 'Please enter correct details';
                        }
                    });
                    $arr['id'] = u_ID;
                } else {
                    $arr['step1'] = false;
                    $arr['step2'] = false;
                    $arr['step3'] = true;
                    $arr['textStatus'] = 'Email did not match with record';
                }
            }


        })

    common.tplFile('forgot_password.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.post('/changepassword', function(req, res) {


    var activationId = cryptos.decrypt(req.param('id'));
    activationId = activationId.split('#')
    var activationEmail = activationId[0]
    var activationIdd = activationId[1]
    req.body.userid = activationIdd
    req.body.email = activationEmail

    async.series([function(callback) {
            faAPI.checkUserExistance(req, "email", activationEmail, callback)
        }],
        // optional callback
        function(err, results) {
            if (err) {
                console.log(err)
                throw err;
            }

            // console.log(results);
            if (results) {
                if (results[0].exists) {

                    faAPI.LoginResetPassword(req, function(error, respon) {
                        if (respon[0]) {
                            q.all([localm.mailtemps(req, config.mysql, q, 'reset_password_ack')]).then(function(results2) {
                                if (results2[0][0].length > 0) {
                                    var template = results2[0][0][0].template;
                                    var subject = results2[0][0][0].subject;
                                    template = template.replace('{{event.user}}', respon[0].first_name);
                                    template = template.replace('{{event.user_name}}', respon[0].first_name);
                                    template = template.replace('{{event.url}}', config.url);
                                    localm.sendmail(template, subject, req.body.email);
                                    $arr['pcStatus'] = 1;
                                    res.writeHead(302, {
                                        'Location': '/'
                                    });
                                    res.end();
                                    return false;
                                } else {
                                    res.end();
                                    return false;
                                }
                            });

                        } else {
                            $arr['textStatus'] = 'Please enter correct details';
                        }
                    })

                } else {
                    $arr['textStatus'] = 'Please enter correct details';
                }
            }
        })
});


app.get('/remainder', function(req, res) {
    console.log('Remainder.Works');
});


module.exports = app;
