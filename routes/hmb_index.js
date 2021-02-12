// #### load required Modules ##################################################

var express = require('express');
var reload = require('reload');
var sprintf = require('sprintf').sprintf;
var pagination = require('pagination');
// var common = require('../module/common');
var common = require('../module/hmb_common');


var openBidProducts = require('../module/openbidproducts');
var async = require('async');
var app = express.Router();
var q = require('q');
var request = require('request');
var dateFormat = require('dateformat');
var cronJob = require('cron');
var faAPI = require('../module/forwardauction_api');
var stores = require('../module/stores');
var Template = require('../module/templates');
var _ = require('underscore')
var product = require('../module/hmb_product');
var payment = require('../module/hmb_payment');
var products = require('../module/products');
var user = require('../module/hmb_user');
var admin = require('../module/admin');
var message = require('../module/hmb_message');
var classified = require('../module/classified');

var hmbLogin = require('../module/hmb_login');
var localm = require('../module/localmail');

var md5 = require('MD5');
var message = require('../module/hmb_message');
setInterval(function () {
    var dateFormat = require('dateformat');
    io.sockets.emit('sliservertime', {
        dTime: dateFormat(new Date(), "yyyy/mm/dd HH:MM:ss")
    });
}, 1000);

var fs = require('fs');

//console.log(new Date().toLocaleString('en-AU', { timeZone: 'Australia/Melbourne' }))

var usaTime = new Date().toLocaleString("en-US", {timeZone: "America/New_York"});
console.log('USA DATETIME : ' + new Date(usaTime).toLocaleString());
console.log('USA FORMATTED : ' + dateFormat(new Date(usaTime), "yyyy/mm/dd HH:MM:ss"));

/**
 *  Render About Us Page
 */
app.get('/aboutUs', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    q.all([
        admin.showstaticContent_by_name(req, res, config.mysql, q, 'about_us')
    ]).then(function (result) {
        arr_temp["static_page"] = result[0][0][0];

        common.headerSet(1);
        common.tplFile('hmb_about_us.tpl');
        common.loadTemplateHeader(req, res, arr_temp);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.get('/how_it_works', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    
    q.all([
        admin.showstaticContent_by_name(req, res, config.mysql, q, 'how_it_works')
    ]).then(function (result) {
        arr_temp["static_page"] = result[0][0][0];

        common.tplFile('hmb_how_it_works.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get('/privacy_policy', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    
    q.all([
        admin.showstaticContent_by_name(req, res, config.mysql, q, 'privacy_policy')
    ]).then(function (result) {
        arr_temp["static_page"] = result[0][0][0];

        common.tplFile('hmb_privacy_policy.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get('/terms_of_use', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    
    q.all([
        admin.showstaticContent_by_name(req, res, config.mysql, q, 'terms_of_use')
    ]).then(function (result) {
        arr_temp["static_page"] = result[0][0][0];

        common.tplFile('hmb_terms_of_use.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.get('/feeSchedule', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    q.all([
        admin.showstaticContent_by_name(req, res, config.mysql, q, 'fee_schedule')
    ]).then(function (result) {
        arr_temp["static_page"] = result[0][0][0];

        common.tplFile('hmb_feeSchedule.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.get('/values_ethics', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    q.all([
        admin.showstaticContent_by_name(req, res, config.mysql, q, 'values_ethics')
    ]).then(function (result) {
        arr_temp["static_page"] = result[0][0][0];

        common.tplFile('hmb_valuesEthics.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.get('/auctionmarket', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    common.tplFile('hmb_auctionmarket.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);
});
app.get('/referralTerms', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    common.tplFile('hmb_referralTerms.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);
});
app.get('/buyerjoin', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    common.tplFile('hmb_buyerjoin.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);
});
app.get('/sellerjoin', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    common.tplFile('hmb_sellerjoin.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);
});
app.get('/faq', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    common.tplFile('hmb_faq.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);
});
app.get('/affiliate_terms', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    
    q.all([
        admin.showstaticContent_by_name(req, res, config.mysql, q, 'affiliate_terms')
    ]).then(function (result) {
        arr_temp["static_page"] = result[0][0][0];

        common.tplFile('hmb_affiliate_terms.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get(['/comingsoon'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    common.tplFile('coming_soon.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);

});
app.get('/checkAccess', function (req, res) {
    var extend = require('util')._extend; 
    var arr_temp = extend({}, $arr);
    common.tplFile('access.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);
});
app.post('/setAccess', function (req, res) {
    console.log('setAccess')
    req.session['isDev'] = true;
    console.log('req.session.redirect_url', req.session.redirect_url);
    if(req.session.redirect_url != '') {
        res.writeHead(302, {
            'Location': req.session.redirect_url
        });  
    } else {
        res.writeHead(302, {
            'Location': '/'
        });
    }
    res.end();
    return false;
});

app.get('/servertime', function (req, res) {
    var dateFormat = require('dateformat');
    datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    res.send(datenow);
    res.end();
    return false;
});
app.get('/clearlog', function (req, res) {
    var fs = require('fs')
    path = $arr.config.path + '/public/images/hempbuyer.log';
    // console.log("Path is " + path);
    fs.truncate(path, 0, function (err) {
        if (err) {
            console.error(err);
            res.end(err.message);
        }
        console.log("File truncated successfully");

        res.end('File truncated successfully');
        return false;
    })
});

app.get('/dailyremainder', function (req, res) {
    var extend = require('util')._extend;
    q.all([
        localm.mailtemps(req, config.mysql, q, 'license_expired'),
        user.get_license_expired_user(req, config.mysql, q)
    ]).then(function (result) {
        if (global.emaillocal.status == 'yes') {
            if (result) {
                for (var index = 0; index < result[1][0].length; index++) {
                    req.body.id = result[1][0][index].id;
                    req.body.status = 'inactive';
                    admin.updateUsersStatus(req, config.mysql, q);

                    var activeurl = $arr.config.spath + 'signin';
                    var template = result[0][0][0].template;
                    var subject_message = result[0][0][0].subject;
                    var logo_url = $arr.config.spath+'images/logo.png';
                    template = template.replace('{{event.sitename}}', config.title);
                    template = template.replace('{{event.active_url}}', activeurl);
                    template = template.replace('{{event.user}}', result[1][0][index].name);
                    template = template.replace('{{event.siteurl}}', $arr.config.url);
                    template = template.replace('{{event.logo_url}}', logo_url);

                    localm.sendmail(template, subject_message, result[1][0][index].email);
                }
            } else {
                console.log("No Templates named license_expired");
            }
        }
 
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
    
    res.end();
    return false;
});

app.get(['/', '/home', '/reg/:error', '/log/:lerror', '/reg/', '/log/', '/unsub_success/:success'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    //console.log('called')
    req.body.status = "'open'";
    q.all([
        product.getFeaturedProducts(req, config.mysql, q),
        product.getUpcomingProducts(req, config.mysql, q)
    ]).then(function (productData) {
        arr_temp['featuredProducts'] = productData[0][0];
        arr_temp['upcomingProducts'] = productData[1][0];
        common.tplFile('home.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);
    });

});

app.post('/uploadFile/:cntfle', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    //console.log('req.files', req.files);
    //console.log('req.body', req.body.type);
    var finalresult = {
        files: []
    };
    
    if(req.body.type) {
        var filesData = req.files[req.body.type];
        if (req.param('cntfle') > 1) {
            for (l in filesData) {
                filesData[l].basenam = (typeof (filesData[l].name) === 'undefined') ? '' : filesData[l].name.substr(0, filesData[l].name.lastIndexOf('.'));
            }
            finalresult.files = filesData;
        } else {
            filesData.basenam = (typeof (filesData.name) === 'undefined') ? '' : filesData.name.substr(0, filesData.name.lastIndexOf('.'));
            finalresult.files.push(filesData);
        }
    }
    // finalresult.s3Url = global.settingscdn.s3_image_url;
    //console.log(finalresult)
    res.json(finalresult);
    res.end();
    return false
});

app.get('/market', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    /*q.all([products.getOpenProductsSearch(req, config.mysql, q, true), products.getCategoryList(req, config.mysql, q), products.getStateListUnique(req, config.mysql, q), products.getOpenProductsSearch(req, config.mysql, q)]).then(function (productData) {
        arr_temp['products'] = productData[0][0];
        arr_temp['allProducts'] = productData[3][0];
        arr_temp['categoryList'] = productData[1][0];
        arr_temp['stateList'] = productData[2][0];
        arr_temp['keywordSeachHome'] = req.param('keywordSeachHome') ? req.param('keywordSeachHome') : '';

        arr_temp['currentPage'] = req.body.page;
        common.tplFile('hmb_market.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);
    });*/
    req.body.status = "'open'";
    q.all([products.getCategoryList(req, config.mysql, q), products.getStateListUnique(req, config.mysql, q), product.getActiveProductsSearch(req, config.mysql, q, '', ''), products.getCategoryList(req, config.mysql, q, 1)]).then(function (productData) {
        arr_temp['categoryList'] = productData[0][0];
        console.log("arr_temp['subCategoryList']", productData[3][0])

        arr_temp['subCategoryList'] = productData[3][0];
        arr_temp['stateList'] = productData[1][0]; 
        arr_temp['allProducts'] = productData[2][0]; 
        arr_temp['keywordSeachHome'] = req.param('keywordSeachHome') ? req.param('keywordSeachHome') : '';
        arr_temp['attributes'] = [
            { value: 'certified_organic', text: 'Certified Organic' },
            { value: 'gmp', text: 'GMP' },
            { value: 'iso', text: 'ISO' },
            { value: 'kosher', text: 'Kosher' },
            { value: 'sqf', text: 'SQF' },
            { value: 'fda_registered', text: 'FDA Registered' },
            { value: 'outdoor', text: 'Outdoor' },
            { value: 'indoor', text: 'Indoor' },
            { value: 'greenhouse', text: 'Greenhouse' },
            { value: 'light_deprivation', text: 'Light Deprivation' },
            { value: 'co2', text: 'CO2' },
            { value: 'ethanol', text: 'Ethanol' },
            { value: 'hydrocarbon_extraction', text: 'Hydrocarbon extraction' },
            { value: 'statement_of_origin_available', text: 'Statement of origin available' },
            { value: 'statement_of_compliance_available', text: 'Statement of compliance available' }
        ];
        arr_temp['screening'] = [
            { value: 'potency', text: 'Potency' },
            { value: 'prs', text: 'Pesticide Residue Screening' },
            { value: 'micro_ms', text: 'Microbiology & Mycotoxin Screening' },
            { value: 'hms', text: 'Heavy Metals Screening' },
            { value: 'srs', text: 'Solvent Residue Screening' }
        ];

        arr_temp['currentPage'] = req.body.page;
        common.tplFile('hmb_market.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);
    });
});


app.post('/searchMarket', function (req, res) {
    //console.log("searchMarket", req.body.categorySelected)
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    req.body.status = "'open'";
    q.all([product.getActiveProductsSearch(req, config.mysql, q, 1, ''), product.getActiveProductsSearch(req, config.mysql, q, 2, '')]).then(function (productData) {
        arr_temp['products'] = productData[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, {
            page: ''
        });

        //arr_temp['pagination'] = productData[1][0].length;
        arr_temp['pagination'] = productData[1][0][0]['totalCount'];

        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page ? req.body.page : 0,
            rowsPerPage: 9,
            totalResult: arr_temp['pagination'],
            ajax: true
        });

        arr_temp['pagination_html'] = paginator.render();
        common.headerSet(0);
        common.tplFile('hmb_market_product.tpl');
        common.loadTemplateHeader(req, res, arr_temp);
    });
});

app.get('/signup', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    arr_temp["afcode"] = req.param('afcode') ? req.param('afcode') : '';
    console.log('arr_temp["afcode"]', arr_temp["afcode"]);
    req.body.afcode = arr_temp["afcode"];

    delete req.session.userid;
    delete req.session.email;
    delete req.session.username;
    delete req.session.name;
    delete req.session.zipcode;
    delete req.session.state;
    delete req.session.city;
    delete req.session.country;
    delete req.session.status;
    delete req.session.role;
    req.session.userLoggedIn = 0; // False
    global.userLoggedIn = 0; // False

    q.all([
        product.getStateList(req, config.mysql, q),
        user.check_referral_affiliats_exists_using_code(req, config.mysql, q)
    ]).then(function (results) {
        arr_temp.states = results[0][0];
        arr_temp.ref_data = {};
        if(results[1][0].length) {
            arr_temp.ref_data = results[1][0][0];
        }
        common.headerSet(1);
        common.tplFile('hmb_registration.tpl');
        common.loadTemplateHeader(req, res, arr_temp);
    });
});


/**
 *  Render Contact Us Page
 */
app.get('/contactUs', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    arr_temp['google_captcha'] = global.general.google_captcha;
    common.headerSet(1);
    common.tplFile('hmb_contact_us.tpl');
    common.loadTemplateHeader(req, res, arr_temp);
});

/**
 *  Render Login Page
 */
app.get('/signin', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    delete req.session.userid;
    delete req.session.email;
    delete req.session.username;
    delete req.session.name;
    delete req.session.zipcode;
    delete req.session.state;
    delete req.session.city;
    delete req.session.country;
    delete req.session.status;
    delete req.session.role;
    delete req.session.profilepic;
    delete req.session.bank_account_added;
    req.session.userLoggedIn = 0; // False
    global.userLoggedIn = 0; // False
  
    arr_temp['cookieemail'] = '';
    arr_temp['cookiepassword'] = '';
    arr_temp['cookieremember'] = 0;
    if (req.cookies.cookieemail && req.cookies.cookieemail != undefined && req.cookies.cookieemail != null) {
        arr_temp['cookieemail'] = req.cookies.cookieemail;
        arr_temp['cookiepassword'] = req.cookies.cookiepassword;
        arr_temp['cookieremember'] = req.cookies.cookieremember;
    }

    common.headerSet(1);
    common.tplFile('hmb_login.tpl');
    common.loadTemplateHeader(req, res, arr_temp);
});

/**
 *  User Logout
 */
app.get('/logout', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    delete req.session.userid;
    delete req.session.email;
    delete req.session.username;
    delete req.session.name;
    delete req.session.zipcode;
    delete req.session.state;
    delete req.session.city;
    delete req.session.country;
    delete req.session.status;
    delete req.session.role;
    delete req.session.profilepic;
    req.session.userLoggedIn = 0; // False
    global.userLoggedIn = 0; // False

    res.writeHead(302, {
        'Location': '/signin'
    });
    res.end();
    return false;
});

app.get('/logout_referral', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    delete req.session.referral_user_data; // True
    req.session.userReferralLoggedIn = 0; // True
    global.userReferralLoggedIn = 0; // True

    res.writeHead(302, {
        'Location': '/signin_referral'
    });
    res.end();
    return false;
});

/**
 *  Check Valid Login Credentials
 */
app.post('/checkUser', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    delete req.session.userid;
    delete req.session.email;
    delete req.session.username;
    delete req.session.name;
    delete req.session.zipcode;
    delete req.session.state;
    delete req.session.city;
    delete req.session.country;
    delete req.session.status;
    delete req.session.role;
    delete req.session.ssn;
    delete req.session.rep_ssn;
    delete req.session.profilepic;
    delete req.session.bank_account_added;
    req.session.userLoggedIn = 0; // False
    global.userLoggedIn = 0; // False
    //delete session;

    q.all([
        hmbLogin.checkUser(config.mysql, req)
    ]).then(function (results) {
        var obj = {
            data: '',
            status: 'failed',
            statusText: 'User details not matched'
        };
        if(results[0][0].length > 0) {
            var pswdSalt = results[0][0][0]['password_salt'];
            var pswd = results[0][0][0]['password'];
            if (pswd === md5(md5(req.body.login_password) + pswdSalt)) {
                if(results[0][0][0]['status'] === 'active') {
                    if (req.body.login_remember == 1) {
                        res.cookie('cookiepassword', req.body.login_password);
                        res.cookie('cookieemail', req.body.login_username);
                        res.cookie('cookieremember', req.body.login_remember);
                    }

                    req.session.userid = results[0][0][0]['id'];
                    req.session.username = results[0][0][0]['username'];
                    req.session.email = results[0][0][0]['email'];
                    req.session.name = results[0][0][0]['name'];
                    req.session.zipcode = results[0][0][0]['zipcode'];
                    req.session.address = results[0][0][0]['address'];
                    req.session.state = results[0][0][0]['state'];
                    req.session.city = results[0][0][0]['city'];
                    req.session.country = results[0][0][0]['country'];
                    req.session.status = results[0][0][0]['status'];
                    req.session.role = results[0][0][0]['role'];
                    req.session.ssn = results[0][0][0]['ssn'] ? results[0][0][0]['ssn'].replace(/-/g, '') : '';
                    req.session.rep_ssn = results[0][0][0]['rep_ssn'] ? results[0][0][0]['rep_ssn'].replace(/-/g, '') : '';
                    req.session.profilepic = results[0][0][0]['profile_pic'];
                    req.session.bank_account_added = results[0][0][0]['bank_account_added'];
                    req.session.userLoggedIn = 1; // True
                    global.userLoggedIn = 1; // True
                    delete req.session.referral_user_data; // True
                    delete req.session.userReferralLoggedIn; // True
                    global.userReferralLoggedIn = 0; // True
                    obj.data = results[0][0][0];
                    obj.status = 'success';
                } else {
                    obj.data = '';
                    obj.status = 'failed';
                    obj.statusText = 'User status not active. Waiting for admin approval.';
                }
            } else {
                obj.data = '';
                obj.status = 'failed';
                obj.statusText = 'User password not match. Enter correct password.';
            }
        }
        res.send(obj);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

/******************************************** SELLER DASHBOARD - STARTS **********************************************/
/**
 *  Render My Auction Open Product Page
 */
app.get('/seller/openAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');
    
    arr_temp['chat_popup'] = req.param('chat_popup') ? req.param('chat_popup') : '';
    
    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        // q.all([products.getOpenProductsSearch(req, config.mysql, q, true), products.getOpenProductsSearch(req, config.mysql, q)]).then(function (productData) {
        //     arr_temp['products'] = productData[0][0];
        //     arr_temp['allProducts'] = productData[1][0];
        q.all([product.getOpenProductsSearch(req, config.mysql, q, false, true)]).then(function (productData) {
            arr_temp['allProducts'] = productData[0][0];

            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_open_product.tpl'); 
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Render My Auction Sold Product Page
 */
app.get('/seller/soldAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        // q.all([products.getOpenProductsSearch(req, config.mysql, q, true), products.getOpenProductsSearch(req, config.mysql, q)]).then(function (productData) {
        //     arr_temp['products'] = productData[0][0];
        //     arr_temp['allProducts'] = productData[1][0];
        //q.all([product.getOpenProductsSearch(req, config.mysql, q, false, true)]).then(function (productData) {
        /* q.all([product.getSoldProductsSearch(req, config.mysql, q, 0)]).then(function (productData) {
            arr_temp['allProducts'] = productData[0][0]; */
            
            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_sold_product.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        /* }); */
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Render My Auction Draft Product Page
 */
app.get('/seller/draftAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        // q.all([products.getOpenProductsSearch(req, config.mysql, q, true), products.getOpenProductsSearch(req, config.mysql, q)]).then(function (productData) {
        //     arr_temp['products'] = productData[0][0];
        //     arr_temp['allProducts'] = productData[1][0];
        q.all([product.getOpenProductsSearch(req, config.mysql, q, false, true)]).then(function (productData) {
            arr_temp['allProducts'] = productData[0][0];
            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_draft_product.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        });
    } else {            

        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Render My Auction Closed Product Page
 */
app.get('/seller/closedAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        // q.all([products.getOpenProductsSearch(req, config.mysql, q, true), products.getOpenProductsSearch(req, config.mysql, q)]).then(function (productData) {
        //     arr_temp['products'] = productData[0][0];
        //     arr_temp['allProducts'] = productData[1][0];
        q.all([product.getOpenProductsSearch(req, config.mysql, q, false, true)]).then(function (productData) {
            arr_temp['allProducts'] = productData[0][0];
            
            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_closed_product.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.post('/searchMyAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    var tplFile = 'hmb_open_product_template.tpl';
    if(req.body.status && req.body.status != 'undefined') {
        if(req.body.status == "'open'")
            tplFile = 'hmb_open_product_template.tpl';
        else if(req.body.status == "'sold'")
            tplFile = 'hmb_sold_product_template.tpl';
        else if(req.body.status == "'draft'")
            tplFile = 'hmb_draft_product_template.tpl';
        else if(req.body.status == "'closed'")
            tplFile = 'hmb_closed_product_template.tpl';
    }

    q.all([product.getOpenProductsSearch(req, config.mysql, q, true, true), product.getSellerProductsSearch(req, config.mysql, q)]).then(function (productData) {
        arr_temp['products'] = productData[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, {
            page: ''
        });

        //arr_temp['pagination'] = productData[1][0].length;
        arr_temp['pagination'] = productData[1][0][0]['totalCount'];

        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page ? req.body.page : 0,
            rowsPerPage: 9,
            totalResult: arr_temp['pagination'],
            ajax: true

        });

        arr_temp['pagination_html'] = paginator.render();
        common.headerSet(0);
        //common.tplFile('hmb_open_product_template.tpl');
        common.tplFile(tplFile);
        common.loadTemplateHeader(req, res, arr_temp);
    });
}); 

app.post('/searchAuctionPage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    var tplFile = 'hmb_open_product_template.tpl';
    if(req.body.status && req.body.status != 'undefined') {
        if(req.body.status == "'open'")
            tplFile = 'hmb_open_product_template.tpl';
        else if(req.body.status == "'sold'")
            tplFile = 'hmb_sold_product_template.tpl';
        else if(req.body.status == "'draft'")
            tplFile = 'hmb_draft_product_template.tpl';
        else if(req.body.status == "'closed'")
            tplFile = 'hmb_closed_product_template.tpl';
    }

    if(typeof(req.body.status) != 'undefined' && req.body.status != "" && req.body.status != "'sold'") {
        //q.all([products.getOpenProductsSearch(req, config.mysql, q, true), products.getOpenProductsSearch(req, config.mysql, q)]).then(function (productData) {
        q.all([product.getSellerProductsSearch(req, config.mysql, q, true), product.getSellerProductsSearch(req, config.mysql, q)]).then(function (productData) {
            arr_temp['products'] = productData[0][0];

            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, {
                page: ''
            });

            //arr_temp['pagination'] = productData[1][0].length;
            arr_temp['pagination'] = productData[1][0][0]['totalCount'];

            var paginator = new pagination.SearchPaginator({
                prelink: 'javascript:paginationSearch',
                current: req.body.page ? req.body.page : 0,
                rowsPerPage: 9,
                totalResult: arr_temp['pagination'],
                ajax: true

            });

            arr_temp['pagination_html'] = paginator.render();
            common.headerSet(0);
            //common.tplFile('hmb_open_product_template.tpl');
            common.tplFile(tplFile);
            common.loadTemplateHeader(req, res, arr_temp);
        });
    } else {
        q.all([product.getSoldProductsSearch(req, config.mysql, q, 0), product.getSoldProductsSearch(req, config.mysql, q, 1)]).then(function (productData) {
            arr_temp['products'] = productData[0][0];

            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, {
                page: ''
            });

            //arr_temp['pagination'] = productData[1][0].length;
            arr_temp['pagination'] = productData[1][0].length;

            var paginator = new pagination.SearchPaginator({
                prelink: 'javascript:paginationSearch',
                current: req.body.page ? req.body.page : 0,
                rowsPerPage: 9,
                totalResult: arr_temp['pagination'],
                ajax: true

            });

            arr_temp['pagination_html'] = paginator.render();
            common.headerSet(0);
            //common.tplFile('hmb_open_product_template.tpl');
            common.tplFile(tplFile);
            common.loadTemplateHeader(req, res, arr_temp);
        });
    }
});
/******************************************** SELLER DASHBOARD - ENDS **********************************************/

/******************************************** BUYER DASHBOARD - STARTS **********************************************/
/**
 *  Render My Auction Active Product Page
 */
app.get('/buyer/activeAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        // q.all([products.getActiveProductsSearch(req, config.mysql, q, true), products.getActiveProductsSearch(req, config.mysql, q)]).then(function (productData) {
        //     arr_temp['products'] = productData[0][0];
        //     arr_temp['allProducts'] = productData[1][0];
        q.all([product.getActiveProductsSearch(req, config.mysql, q, '', 1)]).then(function (productData) {
            arr_temp['allProducts'] = productData[0][0];
            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_active_product.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.post('/buyerSearchAuctionPage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    var tplFile = 'hmb_active_product_template.tpl';
    if(req.body.status && req.body.status != 'undefined') {
        if(req.body.status == "'open'")
            tplFile = 'hmb_active_product_template.tpl';
    }

    q.all([product.getActiveProductsSearch(req, config.mysql, q, '1', 1), product.getActiveProductsSearch(req, config.mysql, q, '2', 1)]).then(function (productData) {
        arr_temp['products'] = productData[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, {
            page: ''
        });

        //arr_temp['pagination'] = productData[1][0].length;
        arr_temp['pagination'] = productData[1][0][0]['totalCount'];
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page ? req.body.page : 0,
            rowsPerPage: 9,
            totalResult: arr_temp['pagination'],
            ajax: true
        });

        arr_temp['pagination_html'] = paginator.render();
        common.headerSet(0);
        common.tplFile(tplFile);
        common.loadTemplateHeader(req, res, arr_temp);
    });
});

/**
 *  Render My Auction Won Product Page
 */
app.get('/buyer/wonAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        // q.all([products.getWonProductsSearch(req, config.mysql, q, true), products.getWonProductsSearch(req, config.mysql, q)]).then(function (productData) {
        //     arr_temp['products'] = productData[0][0];
            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_won_product.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        //});
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.post('/buyerSearchWonAuctionPage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    /* var tplFile = 'hmb_won_product_template.tpl';
    if(req.body.status && req.body.status != 'undefined') {
        if(req.body.status == "'won'")
            tplFile = 'hmb_won_product_template.tpl';
    } */
    var tplFile = 'hmb_buy_product_template.tpl';
    if(req.body.status && req.body.status != 'undefined') {
        if(req.body.status == "'won'")
            tplFile = 'hmb_buy_product_template.tpl';
    }

    req.body.list_type = 'Auction';
    arr_temp['list_type'] = req.body.list_type;
    // q.all([product.getWonProductsSearch(req, config.mysql, q, 0), product.getWonProductsSearch(req, config.mysql, q, 1)]).then(function (productData) {
    q.all([product.getBuyProductsSearch(req, config.mysql, q, 0), product.getBuyProductsSearch(req, config.mysql, q, 1)]).then(function (productData) {
        arr_temp['products'] = productData[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, {
            page: ''
        });

        arr_temp['pagination'] = productData[0][0].length;
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page ? req.body.page : 0,
            rowsPerPage: 9,
            totalResult: arr_temp['pagination'],
            ajax: true
        });

        arr_temp['pagination_html'] = paginator.render();
        common.headerSet(0);
        common.tplFile(tplFile);
        common.loadTemplateHeader(req, res, arr_temp);
    });
});

/**
 *  Render My Auction Lost Product Page
 */
app.get('/buyer/lostAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        // q.all([products.getLostProductsSearch(req, config.mysql, q, true), products.getLostProductsSearch(req, config.mysql, q)]).then(function (productData) {
        //     arr_temp['products'] = productData[0][0];
            
            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_lost_product.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        //});
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.post('/buyerSearchLostAuctionPage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    var tplFile = 'hmb_lost_product_template.tpl';
    if(req.body.status && req.body.status != 'undefined') {
        if(req.body.status == "'lost'")
            tplFile = 'hmb_lost_product_template.tpl';
    }

    q.all([product.getLostProductsSearch(req, config.mysql, q, true), product.getLostProductsSearch(req, config.mysql, q)]).then(function (productData) {
        arr_temp['products'] = productData[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, {
            page: ''
        });

        if(productData[1][0].length) {
            arr_temp['pagination'] = productData[1][0][0]['totalCount'];
        } else {
            arr_temp['pagination'] = 0;
        }

        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page ? req.body.page : 0,
            rowsPerPage: 9,
            totalResult: arr_temp['pagination'],
            ajax: true
        });

        arr_temp['pagination_html'] = paginator.render();
        common.headerSet(0);
        common.tplFile(tplFile);
        common.loadTemplateHeader(req, res, arr_temp);
    });
});

/**
 *  Render My Auction Buy Product Page
 */
app.get('/buyer/buyAuction', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        // q.all([products.getBuyProductsSearch(req, config.mysql, q, true), products.getBuyProductsSearch(req, config.mysql, q)]).then(function (productData) {
        //     arr_temp['products'] = productData[0][0];
            
            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_buy_product.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        //});
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.post('/buyerSearchBuyAuctionPage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    var tplFile = 'hmb_buy_product_template.tpl';
    if(req.body.status && req.body.status != 'undefined') {
        if(req.body.status == "'buy'")
            tplFile = 'hmb_buy_product_template.tpl';
    }

    req.body.list_type = 'Buynow';
    arr_temp['list_type'] = req.body.list_type;

    q.all([product.getBuyProductsSearch(req, config.mysql, q, 0), product.getBuyProductsSearch(req, config.mysql, q, 1)]).then(function (productData) {
        arr_temp['products'] = productData[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, {
            page: ''
        });

        arr_temp['pagination'] = productData[1][0].length;

        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page ? req.body.page : 0,
            rowsPerPage: 9,
            totalResult: arr_temp['pagination'],
            ajax: true
        });

        arr_temp['pagination_html'] = paginator.render();
        common.headerSet(0);
        common.tplFile(tplFile);
        common.loadTemplateHeader(req, res, arr_temp);
    });
});
/******************************************** BUYER DASHBOARD - ENDS **********************************************/

/**
 *  Get Bid History
 */
app.post('/getDetailBidHistory', function (req, res) {
    var extend = require('util')._extend;
    if(req.body.id && req.body.id != "" && req.body.id != "undefined") {
        q.all([product.getDetailBidHistory(req, config.mysql, q)]).then(function (result) {
            var obj = {
                data: []
            };

            if (result[0][0].length > 0) 
                obj.data = result[0][0];

            res.send(obj);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        var obj = {
            data: []
        };
        res.send(obj);
    }
});

app.get('/closeProduct', function(req, res) {
    var extend = require('util')._extend; var arr_temp = extend({}, $arr);
    //  console.log("CLOSE ALL First :: ")
    // localm = require('../module/localmail');
    var dateFormat = require('dateformat');
    datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    // cart = require('../module/cart.js')
    var date = require('date-utils');

    config.mysql.beginTransaction( function(terr) {
        var addTasksToProjectnew = function(pid, cb) { // called once for each project row
            var status = 'closed';
            product.closeProjects(req, config.mysql, q, status, pid.id, 0);
        }
        q.all([product.getProductForClose(req, config.mysql, q)]).then(function(results) {
            if (results[0] && results[0][0].length > 0) {
                var async = require('async');
                async.mapSeries(results[0][0], addTasksToProjectnew, function(err) {
                    config.mysql.commit(function(cerr) {
                        //console.log('pre level commit 1 - a'+cerr);
                    });
                    if (err) return console.error("Error in asynch " + err);
                    res.send('200');
                    res.end();
                });
            } else {
                config.mysql.commit(function(cerr) {
                    //console.log('pre level commit 1 - a'+cerr);
                });
                res.send('200');
                res.end();
            }
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    });
});

/**
 *  Render My Profile - Profile Info Page
 */
app.get('/profileInfo', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([user.getUserProfileInfo(req, config.mysql, q, req.body.loggedUserId), product.getStateList(req, config.mysql, q)]).then(function (results) {
            if(results[0][0].length > 0) {
                arr_temp['userData'] = results[0][0][0];
                arr_temp['states'] = results[1][0];
                arr_temp['role'] = results[0][0][0]['role'];
                arr_temp['state'] = results[0][0][0]['state'];
                common.tplFile('hmb_profile_info.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, arr_temp);
            } else {
                res.writeHead(302, {
                    'Location': '/signin'
                });
                res.end();
                return false;
            }
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Update My Profile - Profile Info Page
 */
app.post('/updateProfileInfo', function (req, res) {
    var extend = require('util')._extend;
    var loggedUserId = req.session.userid ? req.session.userid : 0;
    if(loggedUserId != "" && loggedUserId != 0) {
        q.all([user.updateUserProfileInfo(req, config.mysql, q)]).then(function (results) {
            var obj = {
                status: 'success',
                statusText: 'Profile successfully updated'
            };
            res.send(obj);
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Update My Profile - Profile Info ( Profile Picture ) Page
 */
app.post('/uploadProfilePic', function (req, res) {
    var extend = require('util')._extend;

    var loggedUserId = req.session.userid ? req.session.userid : 0;
    if(loggedUserId != "" && loggedUserId != 0) {
        q.all([user.getUserProfileInfo(req, config.mysql, q, req.body.id)]).then(function (results) {
            if(results[0][0].length > 0) {
                var oldFileName = results[0][0][0]['profile_pic'];
                if(oldFileName && oldFileName != "" && oldFileName != "undefined" && oldFileName != null)
                    fs.unlink(global.path + "/public/uploads/"+oldFileName);

                var ext = (typeof (req.files.profile.name) === 'undefined') ? '' : req.files.profile.name.lastIndexOf('.');
                var pathext = (ext < 0) ? '' : req.files.profile.name.substr(ext);
                var filename = (typeof (req.files.profile.name) === 'undefined') ? '' : req.files.profile.name.substr(0, req.files.profile.name.lastIndexOf('.'));

                q.all([user.updateUserProfilePic(req, config.mysql, q, req.body.id, filename+pathext)]).then(function (results1) {
                    req.session.profilepic = filename+pathext;
                    res.json(filename+pathext);
                    res.end();
                    return false;
                });
            }
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Render My Profile - Change Password Page
 */
app.get('/passwordInfo', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        arr_temp['id'] = req.body.loggedUserId;
        common.headerSet(1);
        common.tplFile('hmb_password_info.tpl');
        common.loadTemplateHeader(req, res, arr_temp);
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Update My Profile - Change Password Page
 */
app.post('/updatePasswordInfo', function (req, res) {
    var extend = require('util')._extend;
    var loggedUserId = req.session.userid ? req.session.userid : 0;
    if(loggedUserId != "" && loggedUserId != 0) {
        q.all([user.getUserProfileInfo(req, config.mysql, q, loggedUserId)]).then(function (results) {
            if(results[0][0].length > 0) {
                var dbPassword = results[0][0][0]['password'];
                var passwordSalt = results[0][0][0]['password_salt'];
                var oldPassword = req.body.oldPassword;

                if (dbPassword !== md5(md5(req.body.oldPassword) + passwordSalt)) {
                    var obj = {
                        status: 'failed',
                        statusText: 'Old Password not match'
                    };
                    res.send(obj);
                } else {
                    var newPassword = req.body.newPassword;
                    var encryptedNewPassword = md5(md5(newPassword) + passwordSalt);
                    q.all([user.updateUserPasswordInfo(req, config.mysql, q, req.body.userId, encryptedNewPassword), localm.mailtemps(req, config.mysql, q, 'password_changed_success')]).then(function (results1) {

                        var template = results1[1][0][0].template;
                        var subject_message = results1[1][0][0].subject;
                        var logo_url = $arr.config.spath + 'images/logo.png';
                        var resetUrl = $arr.config.spath + 'signin/';

                        template = template.replace('{{event.sitename}}', config.title);
                        template = template.replace('{{event.url}}', $arr.config.spath);
                        template = template.replace('{{event.user}}', req.session.name);
                        template = template.replace('{{event.siteurl}}', resetUrl);
                        template = template.replace('{{event.logo_url}}', logo_url);

                        localm.sendmail(template, subject_message, req.session.email);
                        
                        var obj = {
                            status: 'success',
                            statusText: 'Profile successfully updated'
                        };
                        res.send(obj);
                    });
                }
            } else {
                res.writeHead(302, {
                    'Location': '/signin'
                });
                res.end();
                return false;
            }
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});


/**
 *  Render My Profile - Payment Info Page
 */
app.get('/paymentInfo', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    arr_temp['product_id'] = req.param('id') ? req.param('id') : 0;
    console.log('arr_temp[product_id]', arr_temp['product_id']);
    arr_temp['invoice_id'] = req.param('invoice_id') ? req.param('invoice_id') : 0;
    console.log('arr_temp[invoice_id]', arr_temp['invoice_id']);
    if(!arr_temp['product_id'] || !arr_temp['invoice_id']) {
        res.writeHead(302, {
            'Location': '/transactionsInfo'
        });
        res.end();
        return false;
    }
    req.body.id = arr_temp['invoice_id'];

    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([
            user.getUserProfileInfo(req, config.mysql, q, req.body.loggedUserId), 
            product.getStateList(req, config.mysql, q),
            user.get_user_bank_list(req, config.mysql, q, 1),
            product.get_invoice_details(req, config.mysql, q),
        ]).then(function (results) {
            arr_temp['bid_details'] = results[3][0][0];

            if(results[0][0].length > 0) {
                arr_temp['userData'] = results[0][0][0];
                arr_temp['states'] = results[1][0];
                arr_temp['role'] = results[0][0][0]['role'];
                arr_temp['state'] = results[0][0][0]['state'];
                arr_temp['bank_list'] = results[2][0];
                common.tplFile('hmb_payment_info.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, arr_temp);
            } else {
                res.writeHead(302, {
                    'Location': '/signin'
                });
                res.end();
                return false;
            }
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.get(['/bank', '/bank/:id'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    arr_temp['page_name'] = 'bank_details';
    req.body.id = req.param('id') != undefined ? req.param('id') : 0;
    if(req.session.userid > 0) {
        q.all([
            user.get_bank_details(req, config.mysql, q),
            product.getStateList(req, config.mysql, q)
        ]).then(function (results) {

            // if(results[0][0].length > 0) {
                arr_temp['bank_detail'] = results[0][0][0];
                arr_temp['states'] = results[1][0];
                common.tplFile('hmb_bank_details.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, arr_temp);
            // } else {
            //     res.writeHead(302, {
            //         'Location': '/signin'
            //     });
            //     res.end();
            //     return false;
            // }
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Render My Profile - Transactions Info Page
 */
app.get('/transactionsInfo', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([user.getUserProfileInfo(req, config.mysql, q, req.body.loggedUserId), product.getStateList(req, config.mysql, q)]).then(function (results) {
            if(results[0][0].length > 0) {
                arr_temp['userData'] = results[0][0][0];
                arr_temp['states'] = results[1][0];
                arr_temp['role'] = results[0][0][0]['role'];
                arr_temp['state'] = results[0][0][0]['state'];
                common.tplFile('hmb_transactions_info.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, arr_temp);
            } else {
                res.writeHead(302, {
                    'Location': '/signin'
                });
                res.end();
                return false;
            }
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});
app.post(['/transaction_list', '/transaction_list/:action'], function (req, res) {
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    $arr.productstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    
    q.all([
        product.transaction_list(req, config.mysql, q, 0),
        product.transaction_list(req, config.mysql, q, 1),
    ]).then(function (results) {
        console.log('results[1][0].length', results[1][0].length);
        var list = [];
        if(results[0][0].length) {
            list = results[0][0];
        }
        $arr.transaction_list = list;
        $arr.totalData = results[1][0].length;

        common.tplFile('hmb_transactions_info_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

/**
 *  Render Forgot Password Page
 */
app.get('/forgotPassword', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    delete req.session.userid;
    delete req.session.email;
    delete req.session.username;
    delete req.session.name;
    delete req.session.zipcode;
    delete req.session.state;
    delete req.session.city;
    delete req.session.country;
    delete req.session.status;
    delete req.session.role;
    delete req.session.profilepic;
    req.session.userLoggedIn = 0; // False
    global.userLoggedIn = 0; // False

    common.headerSet(1);
    common.tplFile('hmb_forgot_password.tpl');
    common.loadTemplateHeader(req, res, arr_temp);
});

/**
 *  Check Valid Login Credentials
 */
app.post('/checkUserEmail', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    delete req.session.userid;
    delete req.session.email;
    delete req.session.username;
    delete req.session.name;
    delete req.session.zipcode;
    delete req.session.state;
    delete req.session.city;
    delete req.session.country;
    delete req.session.status;
    delete req.session.role;
    delete req.session.profilepic;
    req.session.userLoggedIn = 0; // False
    global.userLoggedIn = 0; // False
    //delete session;

    q.all([
        hmbLogin.checkUser(config.mysql, req)
    ]).then(function (results) {
        var obj = {
            status: 'failed',
            statusText: 'Email or Username not found'
        };
        if(results[0][0].length > 0) {
            if(results[0][0][0]['status'] === 'active') {
                if (global.emaillocal.status == 'yes') {
                    q.all([localm.mailtemps(req, config.mysql, q, 'reset_password')]).then(function (results2) {
                        if (results2) {
                            var template = results2[0][0][0].template;
                            var subject_message = results2[0][0][0].subject;
                            var logo_url = $arr.config.spath + 'images/logo.png';
                            var resetUrl = $arr.config.spath + 'resetPassword/' + results[0][0][0]['id'];

                            template = template.replace('{{event.sitename}}', config.title);
                            template = template.replace('{{event.url}}', $arr.config.spath);
                            template = template.replace('{{event.user}}', results[0][0][0]['name']);
                            template = template.replace('{{event.siteurl}}', $arr.config.url);
                            template = template.replace('{{event.logo_url}}', logo_url);
                            template = template.replace('{{event.resetUrl}}', resetUrl);

                            localm.sendmail(template, subject_message, results[0][0][0]['email']);

                            obj.status = 'success';
                            obj.statusText = 'Reset password link successfully sent to your email. Please check your email.';
                            res.send(obj);
                        } else {
                            obj.status = 'failed';
                            obj.statusText = 'Email Template not found for reset password';
                            res.send(obj);
                        }
                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    });
                } else {
                    obj.status = 'failed';
                    obj.statusText = 'Email options not enabled in your site. Please contact admin.';
                    res.send(obj);
                }
            } else {
                obj.status = 'failed';
                obj.statusText = 'User status not active. Waiting for admin approval.';
                res.send(obj);
            }
        } else {
            res.send(obj);
        }
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

/**
 *  Render Reset Password Page
 */
app.get('/resetPassword/:id', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    delete req.session.userid;
    delete req.session.email;
    delete req.session.username;
    delete req.session.name;
    delete req.session.zipcode;
    delete req.session.state;
    delete req.session.city;
    delete req.session.country;
    delete req.session.status;
    delete req.session.role;
    delete req.session.profilepic;
    req.session.userLoggedIn = 0; // False
    global.userLoggedIn = 0; // False
    //delete session;

    var user_id = req.param('id') != undefined ? req.param('id') : 0;
    if(user_id != 0) {
        arr_temp['id'] = user_id;

        common.headerSet(1);
        common.tplFile('hmb_reset_password.tpl');
        common.loadTemplateHeader(req, res, arr_temp);
    } else
        res.redirect('/signin');
});

/**
 *  Update Reset Password
 */
app.post('/resetPassword', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    delete req.session.userid;
    delete req.session.email;
    delete req.session.username;
    delete req.session.name;
    delete req.session.zipcode;
    delete req.session.state;
    delete req.session.city;
    delete req.session.country;
    delete req.session.status;
    delete req.session.role;
    delete req.session.profilepic;
    req.session.userLoggedIn = 0; // False
    global.userLoggedIn = 0; // False
    //delete session;

    if(req.body.userId != "" && req.body.userId != "0" && typeof(req.body.userId) != "undefined") {
        q.all([user.getUserProfileInfo(req, config.mysql, q, req.body.userId)]).then(function (results) {
            if(results[0][0].length > 0) {
                var passwordSalt = results[0][0][0]['password_salt'];
                var newPassword = req.body.newPassword;
                var encryptedNewPassword = md5(md5(newPassword) + passwordSalt);
                q.all([user.updateUserPasswordInfo(req, config.mysql, q, req.body.userId, encryptedNewPassword)]).then(function (results1) {

                    q.all([localm.mailtemps(req, config.mysql, q, 'password_changed_success')]).then(function (results1) {

                        var template = results1[0][0][0].template;
                        var subject_message = results1[0][0][0].subject;
                        var logo_url = $arr.config.spath + 'images/logo.png';
                        var resetUrl = $arr.config.spath + 'signin/';
                        template = template.replace('{{event.sitename}}', config.title);
                        template = template.replace('{{event.url}}', $arr.config.spath);
                        template = template.replace('{{event.user}}', results[0][0][0]['name']);
                        template = template.replace('{{event.siteurl}}', resetUrl);
                        template = template.replace('{{event.logo_url}}', logo_url);

                        localm.sendmail(template, subject_message, results[0][0][0]['email']);
                    });

                    var obj = {
                        status: 'success',
                        statusText: 'Password reset successfully'
                    };
                    res.send(obj);
                });
            } else {
                res.writeHead(302, {
                    'Location': '/signin'
                });
                res.end();
                return false;
            }
        });
    } else
        res.redirect('/signin');
});

/**
 *  Save Contact Us Data
 */
app.post('/saveContactUs', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    q.all([
        user.saveContactUs(req, config.mysql, q)
    ]).then(function (results) {
        var obj = {
            status: 'failed',
            statusText: 'Contact email not found'
        };
        if(typeof(req.body.contact_email) != "undefined" && req.body.contact_email != "") {
            if (global.emaillocal.status == 'yes') {
                q.all([
                    localm.mailtemps(req, config.mysql, q, 'contact_us'),
                    localm.mailtemps(req, config.mysql, q, 'contact_us_response')
                ]).then(function (results2) {
                    if (results2) {
                        console.log('contact_us');
                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;
                        var logo_url = $arr.config.spath + 'images/logo.png';

                        template = template.replace('{{event.sitename}}', config.title);
                        template = template.replace('{{event.url}}', $arr.config.spath);
                        template = template.replace('{{event.user}}', 'Admin');
                        template = template.replace('{{event.siteurl}}', $arr.config.url);
                        template = template.replace('{{event.logo_url}}', logo_url);

                        template = template.replace('{{event.contact_name}}', req.body.contact_name);
                        template = template.replace('{{event.contact_email}}', req.body.contact_email);
                        template = template.replace('{{event.contact_phone}}', req.body.contact_phone);
                        template = template.replace('{{event.contact_subject}}', req.body.contact_subject);
                        template = template.replace('{{event.contact_message}}', req.body.contact_message);
                        localm.sendmail(template, subject, global.general.adminemail);
                        //localm.sendmail(template, subject_message, 'rajkumar.auctionsoftware@gmail.com');

                        console.log('contact_us_response');
                        var template = results2[1][0][0].template;
                        var subject = results2[1][0][0].subject;
                        var logo_url = $arr.config.spath + 'images/logo.png';
                        template = template.replace('{{event.sitename}}', config.title);
                        template = template.replace('{{event.user}}', req.body.contact_name);
                        template = template.replace('{{event.logo_url}}', logo_url);
                        localm.sendmail(template, subject, req.body.contact_email);
                        console.log('req.body.contact_email', req.body.contact_email);

                        obj.status = 'success';
                        obj.statusText = 'Contact us details successfully sent to HempBuyer Admin.';
                        res.send(obj);
                    }
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                });
            } else {
                obj.status = 'success';
                obj.statusText = 'Contact us details successfully saved';
                res.send(obj);
            }
        } else {
            obj.status = 'failed';
            obj.statusText = 'Contact email not found';
            res.send(obj);
        }
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

/**
 *  CRON JOB - Check & Change Open Product Status to Closed Once End Date Met
 */
app.get('/changeOpenProductStatus', function(req, res) {
    q.all([
        product.getOpenProductIds(req, config.mysql, q),
        product.getOpenProductList(req, config.mysql, q)
    ]).then(function(results) {
        if (results[0][0][0]['id']) {
            // product.updateOpenProductStatus(req, config.mysql, q, results[0][0][0]['id']);
        
            q.all([
                localm.mailtemps(req, config.mysql, q, 'auction_ended_without_reserve_price_meet'),
                localm.mailtemps(req, config.mysql, q, 'your_auction_has_winning_bid'),
                localm.mailtemps(req, config.mysql, q, 'your_bid_did_was_unsuccessful_as_did_not_match_reserve_price'),
                localm.mailtemps(req, config.mysql, q, 'bid_placed_successful_after_close'),
                localm.mailtemps(req, config.mysql, q, 'auction_won'),
            ]).then(function(resultsEmail) {
                if (resultsEmail[0][0].length > 0) {
                    for (var index = 0; index < results[1][0].length; index++) {
                        var renewData = {
                            product_id: results[1][0][index].id
                        }
                        console.log('results[1][0][index].reserve_price > results[1][0][index].win_price', results[1][0][index].reserve_price > results[1][0][index].win_price);
                        if(results[1][0][index].type == 'auction') {
                            if(results[1][0][index].reserve_price > results[1][0][index].win_price && results[1][0][index].renew > 0) {
                                product.reduceProductRenewCount(req, config.mysql, q, results[1][0][index].id);
                                io.sockets.emit('product_renewed', renewData);
                            } else {
                                product.updateOpenProductStatus(req, config.mysql, q, results[0][0][0]['id']);
                            }
                        } else if(results[1][0][index].renew > 0) {
                            product.reduceProductRenewCount(req, config.mysql, q, results[1][0][index].id);
                            io.sockets.emit('product_renewed', renewData);
                        }

                        if(results[1][0][index].type == 'auction') {
                            if(results[1][0][index].reserve_price > results[1][0][index].win_price) {
                                // send to seller
                                console.log('auction_ended_without_reserve_price_meet');
                                var template = resultsEmail[0][0][0].template;
                                var subject = resultsEmail[0][0][0].subject;
                                var view_url = config.url + '/seller/closedAuction';
                                var product_id = '<a href="' + config.url + '/product/view/' + results[1][0][index].id + '">' + results[1][0][index].id + '</a>';
                                template = template.replace('{{event.user}}', results[1][0][index].seller_name);
                                template = template.replace('{{event.product_id}}', product_id);
                                template = template.replace('{{event.unsold_product}}', view_url);
                                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                                localm.sendmail(template, subject, results[1][0][index].seller_email);

                                // send to highest bidder
                                var highest_bidder = results[1][0][index].highest_bidder ? results[1][0][index].highest_bidder.split(',') : [];
                                if(highest_bidder.length) {
                                    console.log('your_bid_did_was_unsuccessful_as_did_not_match_reserve_price');
                                    var template = resultsEmail[2][0][0].template;
                                    var subject = resultsEmail[2][0][0].subject;

                                    var product_id = '<a href="' + config.url + '/product/view/' + results[1][0][index].id + '">' + results[1][0][index].id + '</a>';
                                    template = template.replace('{{event.user}}', highest_bidder[1]);
                                    template = template.replace('{{event.product_id}}', product_id);
                                    template = template.replace('{{event.unsold_product}}', view_url);
                                    template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                                    localm.sendmail(template, subject, highest_bidder[2]);
                                }
                                console.log('highest_bidder', highest_bidder);
                            } else {
                                var highest_bidder = results[1][0][index].highest_bidder ? results[1][0][index].highest_bidder.split(',') : [];

                                /* var buynow_data = {
                                    product_id: results[1][0][index].id,
                                    userid: highest_bidder[0],
                                    amount: results[1][0][index].win_price,
                                    type: 'Auction',
                                    qty: results[1][0][index].moq
                                };
                                product.add_buynow(req, config.mysql, q, buynow_data); */
                                req.body.product_id = results[1][0][index].id;
                                req.body.type = 'Auction';
                                req.body.amount = results[1][0][index].win_price;
                                req.body.gateway = '';
                                req.body.transactionid = '';
                                req.body.shipping_amount = 0;
                                req.body.qty = results[1][0][index].moq;
                                req.body.invoice_user_id = highest_bidder[0];
                                product.generate_invoice(req, config.mysql, q)

                                console.log('your_auction_has_winning_bid');
                                var template = resultsEmail[1][0][0].template;
                                var subject = resultsEmail[1][0][0].subject;
                                template = template.replace('{{event.user}}', results[1][0][index].seller_name);
                                template = template.replace('{{event.title}}', results[1][0][index].title);
                                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                                localm.sendmail(template, subject, results[1][0][index].seller_email);

                                var productLink = config.url + '/product/view/' + results[1][0][index].id;
                                
                                console.log('bid_placed_successful_after_close');
                                var template = resultsEmail[3][0][0].template;
                                var subject = resultsEmail[3][0][0].subject;
                                template = template.replace('{{event.user}}', highest_bidder[1]);
                                template = template.replace('{{event.maxAmount}}', results[1][0][index].win_price);
                                template = template.replace('{{event.amount}}', results[1][0][index].win_price);
                                template = template.replace('{{productLink}}', productLink);
                                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                                localm.sendmail(template, subject, highest_bidder[2]);

                                console.log('auction_won');
                                var template = resultsEmail[4][0][0].template;
                                var subject = resultsEmail[4][0][0].subject;
                                template = template.replace('{{event.user}}', highest_bidder[1]);
                                template = template.replace('{{event.title}}', results[1][0][index].title);
                                template = template.replace('{{event.price}}', results[1][0][index].win_price);
                                template = template.replace('{{event.url}}', productLink);
                                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                                localm.sendmail(template, subject, highest_bidder[2]);
                            }
                        }

                    }
                    
                }
            });

        }
        res.end();
        return false;
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

/******************************************** BUYER DASHBOARD - WATCHLIST - STARTS **********************************************/
/**
 *  Add / Remove Product in Watchlist
 */
app.post('/addToWatchlist', function(req, res) {
    if(typeof(req.session.userid) != "undefined" && req.session.userid != "" && req.session.userid != "0") {
        if(typeof(req.body.productId) != "undefined" && req.body.productId != "" && req.body.productId != "0") {
            q.all([product.getWatchlist(req, config.mysql, q)]).then(function(results) {
                var id = 0;
                if(results[0][0].length > 0)
                    id = results[0][0][0]['id'];

                q.all([product.updateWatchlistStatus(req, config.mysql, q, id)]).then(function(results1) {
                    if(req.body.status == 'active') {
                        req.body.id = req.body.productId;
                        q.all([
                            localm.mailtemps(req, config.mysql, q, 'item_added_in_watchlist'),
                            product.getProductDetails(req, config.mysql, q)
                        ]).then(function(resultsEmail) {
                            console.log('item_added_in_watchlist');
                            if (resultsEmail[0][0].length > 0) {
                                var template = resultsEmail[0][0][0].template;
                                var subject = resultsEmail[0][0][0].subject;
                                template = template.replace('{{event.user}}', req.session.name);
                                template = template.replace('{{event.title}}', resultsEmail[1][0][0].title);
                                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                                localm.sendmail(template, subject, req.session.email);
                            }
                        });
                    }

                    var obj = {
                        status: 'success',
                        statusText: (req.body.status == 'active') ? 'Product successfully added to Watchlist' : 'Product successfully removed from watchlist'
                    };
                    res.send(obj);
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        } else {
            var obj = {
                status: 'failed',
                statusText: 'Product id not found'
            };
            res.send(obj);
        }
    } else {
        var obj = {
            status: 'session_expired',
            statusText: 'session_expired'
        };
        res.send(obj);
    }
});

/**
 *  Render My Auction Watchlist Page
 */
app.get('/buyer/watchlist', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([product.getWatchlistSearch(req, config.mysql, q, '')]).then(function (productData) {
            arr_temp['allProducts'] = productData[0][0];
            
            arr_temp['currentPage'] = req.body.page;
            common.tplFile('hmb_watchlist.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.post('/buyerSearchWatchlist', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    var tplFile = 'hmb_watchlist_template.tpl';
    if(req.body.status && req.body.status != 'undefined') {
        if(req.body.status == "'buy'")
            tplFile = 'hmb_watchlist_template.tpl';
    }

    q.all([product.getWatchlistSearch(req, config.mysql, q, '1'), product.getWatchlistSearch(req, config.mysql, q, '2')]).then(function (productData) {
        arr_temp['products'] = productData[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, {
            page: ''
        });

        arr_temp['pagination'] = productData[1][0][0]['totalCount'];

        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page ? req.body.page : 0,
            rowsPerPage: 9,
            totalResult: arr_temp['pagination'],
            ajax: true
        });

        arr_temp['pagination_html'] = paginator.render();
        common.headerSet(0);
        common.tplFile(tplFile);
        common.loadTemplateHeader(req, res, arr_temp);
    });
});
/******************************************** BUYER DASHBOARD - WATCHLIST - ENDS **********************************************/
app.post('/sendMessage', function (req, res) {
    req.body.pid = req.body.m_product_id;
    req.body.fromid = req.session.userid;
    req.body.toid = req.body.m_seller_id;
    req.body.toemail = req.body.m_seller_email;
    req.body.first_name = req.body.m_seller_name;
    req.body.subject = req.body.m_subject;
    req.body.message = req.body.m_message;
    req.body.view_url = config.url+'/inbox/all';
    req.body.r_id = Date.parse(new Date())/1000;
    q.all([
        message.getUserMessagesAlreadyExists(req, config.mysql, q)
    ]).then(function (results) {
        if(results[0][0].length > 0) {
            req.body.r_id = results[0][0][0]['r_id'];
            req.body.subject = results[0][0][0]['subject'];
        }

        q.all([
            message.addmessages(req, config.mysql, q)
        ]).then(function (result) {
            res.json({
                status: 200,
                success: true
            })
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

/**
 *  Get Unread Message Count
 */
app.post('/getUserUnreadMessageCount', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([message.getInboxOverallAndUnreadMessageCount(req, config.mysql, q, req.body.loggedUserId)]).then(function (result) {
            var obj = {
                status : 'success',
                totalInboxMessageCount : result[0][0][0]['totalInboxMessageCount'],
                totalInboxUnreadMessageCount : result[0][0][0]['totalInboxUnreadMessageCount']
            };
            res.send(obj);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        var obj = {
            status : 'session_expired',
            totalInboxMessageCount : 0,
            totalInboxUnreadMessageCount : 0
        };
        res.send(obj);
    }
});
app.post('/sendFeedback', function (req, res) {
    q.all([
        product.addFeedback(req, config.mysql, q)
    ]).then(function (result) {
        res.json({
            status: 200,
            success: true
        })
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.post('/get_feedback', function (req, res) {
    q.all([
        product.get_feedback(req, config.mysql, q)
    ]).then(function (result) {
        res.json({
            status: 200,
            success: true,
            result: result[0][0][0]
        })
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get(['/advertisement'], function (req, res) {

    if (common.checkLogin(req, res, 0)) {
        var extend = require('util')._extend;
        var arr_temp = extend({}, $arr);
        arr_temp['activePage'] = 'advertisement';

        /* q.all([
            product.getFeaturedProducts(req, config.mysql, q),
        ]).then(function (productData) { */
            // arr_temp['featuredProducts'] = productData[0][0];
            common.tplFile('hmb_advertisement.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        /* }); */
    }
});
app.get(['/advertisements'], function (req, res) {

    // res.redirect('/comingsoon');
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    common.tplFile('coming_soon.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    return;
    
    if (common.checkLogin(req, res, 0)) {

        var extend = require('util')._extend;
        var arr_temp = extend({}, $arr);
        arr_temp['activePage'] = 'advertisements';

        /* q.all([
            product.getFeaturedProducts(req, config.mysql, q),
        ]).then(function (productData) { */
            // arr_temp['featuredProducts'] = productData[0][0];
            common.tplFile('hmb_advertisements.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        /* }); */
    }
});
app.post(['/advertisements_list'], function (req, res) {
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.userstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        product.advertisements_list(req, config.mysql, q, 0),
        product.advertisements_list(req, config.mysql, q, 1),
        product.total_ads_amount(req, config.mysql, q)
    ]).then(function (results) {
        var users = [];
        if(results[0][0].length) {
            users = results[0][0];
        }
        $arr.adsData = users;
        $arr.totalData = results[1][0].length;
        $arr.total_amount = results[2][0][0].total_amount ? results[2][0][0].total_amount : 0;
        
        console.log('$arr.totalData', $arr.totalData);
        /* res.json({
            status: 200,
            success: true,
            data: users
        });
        res.end();
        return false; */
        common.tplFile('hmb_advertisements_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.post(['/get_ad_details'], function (req, res) {
    q.all([
        product.get_ad_details(req, config.mysql, q)
    ]).then(function (results) {
        var users = [];
        if(results[0][0].length) {
            users = results[0][0][0];
            users.target_sec_id = users.target_sec_id.split(',');
            var pages = [];
            if(users.target_sec_id[0] == "home") { pages.push("Home"); }
            if(users.target_sec_id[1] == "product_view") { pages.push("Product View"); }
            if(users.target_sec_id[2] == "dashboard") { pages.push("Dashboard"); }
            if(users.target_sec_id[3] == "product_post") { pages.push("Product Post"); }
            users.target_sec_id = pages.join(', ');
        }
        res.json({
            status: 200,
            success: true,
            result: users
        });
        res.end();
        return false;
    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.post('/save_ad', function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        q.all([
            product.save_ad(req, config.mysql, q),
            user.add_user_balance(req, config.mysql, q)
        ]).then(function (result) {
            res.json({
                status: 200,
                success: true,
                result: result[0][0][0]
            })
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        res.json({
            status: 500,
            success: false,
            result: ''
        })
    }
});
app.post('/update_ad_status', function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        q.all([
            product.update_ad_status(req, config.mysql, q)
        ]).then(function (result) {
            res.json({
                status: 200,
                success: true,
                result: result[0][0][0]
            })
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        res.json({
            status: 500,
            success: false,
            result: ''
        })
    }
});
app.post('/update_classified_status', function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        q.all([
            product.update_classified_status(req, config.mysql, q)
        ]).then(function (result) {
            res.json({
                status: 200,
                success: true,
                result: result[0][0][0]
            })
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        res.json({
            status: 500,
            success: false,
            result: ''
        })
    }
});

app.post('/postbanners/:cntfle', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    console.log('req.files', req.files);
    var finalresult = {
        banners: []
    };

    if (req.param('cntfle') > 1) {
        for (l in req.files.banners) {
            req.files.banners[l].basenam = (typeof (req.files.banners[l].name) === 'undefined') ? '' : req.files.banners[l].name.substr(0, req.files.banners[l].name.lastIndexOf('.'));
        }
        finalresult.banners = req.files.banners;
    } else {
        req.files.banners.basenam = (typeof (req.files.banners.name) === 'undefined') ? '' : req.files.banners.name.substr(0, req.files.banners.name.lastIndexOf('.'));
        finalresult.banners.push(req.files.banners);
    }
    // finalresult.s3Url = global.settingscdn.s3_image_url;
    console.log(finalresult)
    res.json(finalresult);
    res.end();
    return false
});
app.post(['/deletebanner'], function (req, res) {

    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    if (req.body.banner_id > 0) {
        q.all([product.deletebanner(req, res, config.mysql, q)]).then(function (results) {
            res.json(1);
            res.end();
            return false;
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        fs.unlink(global.path + "/public/uploads/banners/" + req.body.name, function (err) {
            if (!err) {
                console.log('successfully deleted ' + req.body.name);
            }
        });
        res.json(1);
        res.end();
        return false;
    }
});
app.post(['/get_ads'], function (req, res) {
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.userstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        product.get_ads(req, config.mysql, q, 0)
    ]).then(function (results) {
        var users = [];
        if(results[0][0].length) {
            users = results[0][0];
        }
        $arr.ads_list = users;
        common.tplFile('hmb_ads_list.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.post('/click_ad', function (req, res) {
    req.body.update_amount
    q.all([
        product.get_ad_detail(req, config.mysql, q),
    ]).then(function (resultAd) {
        req.body.update_amount = resultAd[0][0][0].budget_per_click;
        req.body.userid = resultAd[0][0][0].user_id;
        q.all([
            product.click_ad(req, config.mysql, q),
            user.minus_user_balance(req, config.mysql, q)
        ]).then(function (result) {
            res.json({
                status: 200,
                success: true,
                result: resultAd[0][0][0]
            })
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.post('/postcompanylogo/:cntfle', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    console.log('req.files', req.files);
    var finalresult = {
        classified: []
    };

    if (req.param('cntfle') > 1) {
        for (l in req.files.classified) {
            req.files.classified[l].basenam = (typeof (req.files.classified[l].name) === 'undefined') ? '' : req.files.classified[l].name.substr(0, req.files.classified[l].name.lastIndexOf('.'));
        }
        finalresult.classified = req.files.classified;
    } else {
        req.files.classified.basenam = (typeof (req.files.classified.name) === 'undefined') ? '' : req.files.classified.name.substr(0, req.files.classified.name.lastIndexOf('.'));
        finalresult.classified.push(req.files.classified);
    }
    // finalresult.s3Url = global.settingscdn.s3_image_url;
    console.log(finalresult)
    res.json(finalresult);
    res.end();
    return false
});
app.post(['/classifieds/', '/classifieds/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.userstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        classified.getClassifieds(req, config.mysql, q, 0),
        classified.getClassifieds(req, config.mysql, q, 1),
    ]).then(function (results) {
        var listData = [];
        if(results[0][0].length) {
            listData = results[0][0];
            for (var index = 0; index < results[0][0].length; index++) {
                results[0][0][index].images = results[0][0][index].images.split(',');
            }
        }
        $arr.listData = listData;
        $arr.totalData = results[1][0].length;
        common.tplFile('classified_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});


app.get(['/dummy_query'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    //console.log('called')
    req.body.query = req.param("query");
    console.log('req.body.query', req.body.query);
    if(req.body.query) {

        q.all([
            product.dummyQuery(req, config.mysql, q)
        ]).then(function (listData) {
            res.json({
                success: true,
                length: listData[0][0].length,
                result: listData[0][0]
            });
            res.end();
            return false;
        });
    } else {
        res.json({
            success: false,
            result: 'Please pass query'
        });
        res.end();
        return false;
    }

});

app.get(['/removeFromFeaturedAuction'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    q.all([
        product.removeFromFeaturedAuction(req, config.mysql, q)
    ]).then(function (listData) {
        res.json({
            success: true,
            length: listData[0][0].length,
            result: listData[0][0]
        });
        res.end();
        return false;
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get(['/register_referral'], function (req, res) {
    var extend = require('util')._extend;
    common.tplFile('hmb_register_referral.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.post(['/register_referral'], function (req, res) {
    var dateFormat = require('dateformat');

    function makeid(length) {
        var result           = '';
        var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for ( var i = 0; i < length; i++ ) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }
    req.body.code = makeid(20);
    q.all([
        user.check_referral_affiliats_exists(req, config.mysql, q)
    ]).then(function (aResults) {
        console.log('aResults[0][0].length', aResults[0][0].length);
        if(aResults[0][0].length) {
            res.json({
                status: 222,
                success: false,
                error: 'Email already register'
            });
            res.end();
            return false;
        } else {
            q.all([
                user.register_referral(req, config.mysql, q),
                localm.mailtemps(req, config.mysql, q, 'send_referral_code')
            ]).then(function (results) {
                if (global.emaillocal.status == 'yes') {
                    var banner1 = '<a href="'+$arr.config.spath+'signup?afcode='+req.body.code+'"><img src="'+$arr.config.spath+'image/logo.png" alt="Hempbuyer" width="728" height="90" border="0"></a>';
                    banner1 = banner1.replace(/</g, '&lt;').replace(/</g, '&gt;');

                    var banner2 = '<a href="'+$arr.config.spath+'signup?afcode='+req.body.code+'"><img src="'+$arr.config.spath+'image/logo.png" alt="Hempbuyer" width="90" height="90" border="0"></a>';
                    banner2 = banner2.replace(/</g, '&lt;').replace(/>/g, '&gt;');

                    var banner3 = '<a href="'+$arr.config.spath+'signup?afcode='+req.body.code+'"><img src="'+$arr.config.spath+'image/logo.png" alt="Hempbuyer" width="180" height="180" border="0"></a>';
                    banner3 = banner3.replace(/</g, '&lt;').replace(/>/g, '&gt;');

                    var referral_link = $arr.config.spath+'signup?afcode='+req.body.code;
                    
                    var template = results[1][0][0].template;
                    var subject_message = results[1][0][0].subject;
                    var logo_url = $arr.config.spath+'images/logo.png';
                    template = template.replace('{{event.user}}', req.body.rf_name);
                    template = template.replace('{{event.referral_link}}', referral_link);
                    template = template.replace('{{event.referral_banner_1}}', banner1);
                    template = template.replace('{{event.referral_banner_2}}', banner2);
                    template = template.replace('{{event.referral_banner_3}}', banner3);
                    template = template.replace('{{event.siteurl}}', $arr.config.url);
                    template = template.replace('{{event.logo_url}}', logo_url);

                    localm.sendmail(template, subject_message, req.body.rf_email);
                }

                res.json({
                    status: 200,
                    success: true,
                    returl: {}
                });
                res.end();
                return false;
            }).fail(function (err) {
                res.json({
                    status: 500,
                    success: false,
                    error: err
                });
                res.end();
                return false;
            }).done();
        }
    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.get(['/test_delete_customer'], function (req, res) {
    var account_id = req.param('account_id') != undefined ? req.param('account_id') : 0;
    var payment_data = {
        account_id: account_id
    }
    q.all([
        payment.delete_customer_account(req, q, payment_data)
    ]).then(function (results) {
        console.log('results', results);
        res.json({
            status: 200,
            success: true,
            result: results
        });
    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.get(['/test_create_customer'], function (req, res) {
    var payment_data = {
        ssn: '111000000',
        account_no: '000123456789',
        rounting_no: '111000000',
        email: 'divesh1@auctionsoftware.com',
        name: 'Divyesh',
        days: 01,
        month: 01,
        year: 2000,
        city: 'Ahmedabad',
        zipcode: '380015',
        state: 'AK',
        address: 'Malbar Hills Apartment',
        back_photo: '',
        front_photo: '',
        phone: '12025550149',
    };
    q.all([
        payment.create_customer_account(req, q, payment_data)
    ]).then(function (results) {
        console.log('results', results);
        res.json({
            status: 200,
            success: true,
            result: results
        });
    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.post(['/add_edit_bank_details'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var payment_data = {
        ssn: req.session.ssn ? req.session.ssn : (req.session.rep_ssn ? req.session.rep_ssn : 111111111),
        account_no: req.body.account_number,
        rounting_no: req.body.routing_number,
        email: req.session.email,
        name: req.body.account_name,
        days: 01,
        month: 01,
        year: 2000,
        city: req.body.city,
        state: req.body.state,
        zipcode: req.session.zipcode,
        address: req.session.address,
        back_photo: null,
        front_photo: null,
        phone: req.body.phone
    };
    if(req.body.bank_id > 0) {
        payment_data.account_id = req.body.account_id;
    }
    q.all([
        req.body.bank_id > 0 ? payment.update_customer_account(req, q, payment_data) : payment.create_customer_account(req, q, payment_data),
        user.get_user_bank_list(req, config.mysql, q, 1),
    ]).then(function (accountResult) {
        console.log('accountResult', accountResult);
        if(accountResult[0].success == 1) {
            req.session.bank_account_added = 1;
            req.session.save();
            req.body.stripe_account_id = accountResult[0].account_id;
            req.body.stripe_profile_id = accountResult[0].profile_id;
            req.body.is_primary = accountResult[1][0].length ? 0 : 1;
            q.all([
                user.add_edit_bank_details(req, config.mysql, q, 0)
            ]).then(function (results) {
                var bank_id = req.body.bank_id > 0 ? req.body.bank_id : results[0][0]["insertId"];
                // user.update_stripe_bank_account_detail(req, config.mysql, q, accountResult[0])
                
                res.json({
                    status: 200,
                    success: true,
                    result: results[0][0][0],
                    bank_id: bank_id
                });
                res.end();
                return false;

            }).fail(function (err) {
                res.json({
                    status: 500,
                    success: false,
                    error: err
                });
                res.end();
                return false;
            }).done();
        } else {
            res.json({
                status: 500,
                success: false,
                error: accountResult[0].errortext
            });
            res.end();
            return false;
        }

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();

});
app.post(['/get_bank_details'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    q.all([
        user.get_bank_details(req, config.mysql, q)
    ]).then(function (results) {
        
        res.json({
            status: 200,
            success: true,
            result: results[0][0][0]
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.get(['/invoice/:id'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var invoice_id = req.param('id') != undefined ? req.param('id') : 0;
    req.body.id = invoice_id;
    if(invoice_id != 0) {
        q.all([
            product.get_invoice_details(req, config.mysql, q)
        ]).then(function (result) {
            arr_temp['id'] = invoice_id;
            arr_temp['invoice_data'] = result[0][0][0];

            common.headerSet(1);
            common.tplFile('hmb_invoice.tpl');
            common.loadTemplateHeader(req, res, arr_temp);
        }).fail(function (err) {
            res.json({
                status: 500,
                success: false,
                error: err
            });
            res.end();
            return false;
        }).done();
    } else {
        res.redirect('/signin');
    }
});
app.post(['/make_duplicate_product'], function (req, res) {
    q.all([
        product.make_duplicate_product(req, config.mysql, q)
    ]).then(function (results) {
        console.log('req.body.product_id', req.body.product_id);
        req.body.new_product_id = results[0][0].insertId;
        console.log('req.body.product_id', req.body.product_id);
        q.all([
            product.make_duplicate_product_documents(req, config.mysql, q)
        ]).then(function (results1) {
            req.body.id = req.body.new_product_id;
            q.all([
                product.getProductMediaFiles(req, config.mysql, q, 'image')
            ]).then(function (resultsDoc) {
                
                console.log('results1', resultsDoc[0][0]);
                var pdoc = {};
                if(resultsDoc[0][0].length) {
                    
                    pdoc = resultsDoc[0][0];
                    var path = global.path + "/public/uploads/product/";
                    var async = require('async')
                    async.eachSeries(pdoc, function (index, next){ 
                        fs.readFile(path+index.image.split(req.body.new_product_id)[1], function (err, data) {
                            if (err) throw err;
                            fs.writeFile(path+index.image, data, function (err) {
                                if (err) throw err;
                                console.log('It\'s saved!');
                                next();
                            });
                        });
                    }, function(err) {
                        console.log('iterating done');
                    }); 
                    
                    /* for (index = 0; index < pdoc.length; index++) {
                        const element = pdoc[index];
                        console.log('pdoc[index].image 0', pdoc[index].image);
                        var image = pdoc[index].image;
                        var iname = pdoc[index].image.split(req.body.new_product_id)[1];
                        console.log('path+pdoc[index].image.split(req.body.new_product_id)[1]', path+pdoc[index].image.split(req.body.new_product_id)[1]);
                        fs.readFile(path+pdoc[index].image.split(req.body.new_product_id)[1], function (err, data) {
                            if (err) throw err;
                            fs.writeFile(path+image, data, function (err) {
                                if (err) throw err;
                                console.log('It\'s saved!');
                            });
                        });
                    } */
                }
            });
             
            console.log('results1', results1[0][0]);
            var users = {};
            if(results1[0][0].length) {
                users = results1[0][0][0];
            }
            res.json({
                status: 200,
                success: true,
                result: users
            });
            res.end();
            return false;
        }).fail(function (err) {
            res.json({
                status: 500,
                success: false,
                error: err
            });
            res.end();
            return false;
        }).done();
    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.get(['/signin_referral'], function (req, res) {
    var extend = require('util')._extend;
    common.tplFile('hmb_login_referral.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.post('/checkReferralUser', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.session.userReferralLoggedIn = 0; // True
    global.userReferralLoggedIn = 0; // True

    q.all([
        hmbLogin.checkReferralUser(config.mysql, req)
    ]).then(function (results) {
        var obj = {
            data: '',
            status: 'failed',
            statusText: 'User details not matched'
        };
        if(results[0][0].length > 0) {
            var pswdSalt = results[0][0][0]['password_salt'];
            var pswd = results[0][0][0]['password'];
            if (pswd === md5(md5(req.body.login_password) + pswdSalt)) {
                if(results[0][0][0]['status'] === 'active') {
                    if (req.body.login_remember == 1) {
                        res.cookie('cookiepassword', req.body.login_password);
                        res.cookie('cookieemail', req.body.login_username);
                    }

                    req.session.referral_user_data = results[0][0][0]; // True
                    req.session.userReferralLoggedIn = 1; // True
                    global.userReferralLoggedIn = 1; // True

                    obj.data = results[0][0][0];
                    obj.status = 'success';
                } else {
                    obj.data = '';
                    obj.status = 'failed';
                    obj.statusText = 'User status not active. Waiting for admin approval.';
                }
            } else {
                obj.data = '';
                obj.status = 'failed';
                obj.statusText = 'User password not match. Enter correct password.';
            }
        }
        res.send(obj);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.get(['/banners'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    arr_temp['loged_referral'] = {};
    arr_temp['referral_data'] = {};
    
    if(req.session.referral_user_data) {
        arr_temp['loged_referral'] = req.session.referral_user_data;
        console.log('req.session.referral_user_data', req.session.referral_user_data);
        req.body.rf_email = req.session.referral_user_data.email;
    } else if(!req.session.userReferralLoggedIn) {
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
    }

    q.all([
        admin.get_banner_list(req, config.mysql, q),
        // user.check_referral_affiliats_exists(req, config.mysql, q)
    ]).then(function (results) {
        var listData = [];
        var banner_data = {
            banner1: '',
            banner2: '',
            banner3: ''
        }
        if(results[0][0].length) {
            listData = results[0][0];
            for (var index = 0; index < listData.length; index++) {
                banner_data['banner'+listData[index].cid] = listData[index].image;
            }
        }
        arr_temp['banner_data'] = banner_data;

        common.tplFile('hmb_referral_banner.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

/**
 *  Render Set shipping address
 */
app.get('/set_shipping_info', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    arr_temp['page_name'] = 'set_shipping_address';

    arr_temp['product_id'] = req.param('id') ? req.param('id') : 0;
    arr_temp['bid_id'] = req.param('bid_id') ? req.param('bid_id') : 0;
    arr_temp['invoice_id'] = req.param('invoice_id') ? req.param('invoice_id') : 0;
    if(!arr_temp['product_id'] || (!arr_temp['bid_id'] && !arr_temp['invoice_id'])) {
        res.writeHead(302, {
            'Location': '/transactionsInfo'
        });
        res.end();
        return false;
    }
    if(arr_temp['bid_id']) {
        req.body.id = arr_temp['bid_id'];
    } else {
        req.body.id = arr_temp['invoice_id'];
    }

    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([
            user.get_shipping_list(req, config.mysql, q), 
            product.getStateList(req, config.mysql, q)
        ]).then(function (results) {
            console.log('results[0][0]', results[0][0]);
            arr_temp['shipping_list'] = results[0][0];
            arr_temp['shipping_list_json'] = JSON.stringify(results[0][0]);
            arr_temp['state_list'] = results[1][0];
            common.tplFile('hmb_set_shipping_info.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        });
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.get(['/bank_list'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    arr_temp['page_name'] = 'bank_list';

    if(req.session.userid > 0) {

        common.tplFile('hmb_bank_list.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);
            
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});
app.post(['/bank_list'], function (req, res) {
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    $arr.productstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    
    q.all([
        user.get_user_bank_list(req, config.mysql, q, 0),
        user.get_user_bank_list(req, config.mysql, q, 1),
    ]).then(function (results) {
        var list = [];
        if(results[0][0].length) {
            list = results[0][0];
        }
        $arr.list_data = list;
        $arr.totalData = results[1][0].length;

        common.tplFile('hmb_bank_list_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.post(['/set_primary_bank'], function (req, res) {

    q.all([
        user.set_primary_bank(req, config.mysql, q)
    ]).then(function (results) {
        
        res.json({
            status: 200,
            success: true,
            result: results[0][0][0]
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.post(['/delete_bank'], function (req, res) {

    q.all([
        user.get_bank_details(req, config.mysql, q),
        user.delete_bank(req, config.mysql, q)
    ]).then(function (results) {
        console.log('results[1][0]', results[0][0]);
        if(results[0][0].length) {
            if(results[0][0][0].stripe_account_id != '') {
                var account_data = {
                    account_id: results[0][0][0].stripe_account_id
                }
                console.log('account_data', account_data);
                payment.delete_customer_account(req, q, account_data)
            }
        }
        res.json({
            status: 200,
            success: true,
            result: results[0][0][0]
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.get(['/escrow_details/:invoice_id'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    arr_temp['page_name'] = 'escrow_details';
    req.body.invoice_id = req.param('invoice_id') != undefined ? req.param('invoice_id') : 0;
    arr_temp['invoice_id'] = req.body.invoice_id;

    if(req.session.userid > 0) {
        common.tplFile('hmb_escrow_details.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, arr_temp);
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});
app.post(['/add_edit_escrow_details'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    req.body.status = 'waiting_for_escrow_payment';
    q.all([
        product.add_edit_escrow_details(req, config.mysql, q, 0),
        product.update_invoice_status(req, config.mysql, q),
        product.product_details_using_invoice_id(req, config.mysql, q),
        localm.mailtemps(req, config.mysql, q, 'seller_added_escrow_details')
    ]).then(function (results) {
        var product_data = results[2][0][0];

        var template = results[3][0][0].template;
        var subject_message = results[3][0][0].subject;
        var logo_url = $arr.config.spath + 'images/logo.png';
        var click_url = $arr.config.spath + 'buyer/buyAuction';
        if(product_data.invoice_type == 'Auction') {
            click_url = $arr.config.spath + 'buyer/wonAuction';
        }
        template = template.replace('{{event.sitename}}', config.title);
        template = template.replace('{{event.user}}', product_data.buyer_name);
        template = template.replace('{{event.url}}', click_url);
        template = template.replace('{{event.product_title}}', product_data.title);
        template = template.replace('{{event.logo_url}}', logo_url);
        localm.sendmail(template, subject_message, product_data.buyer_email);

        var template = results[3][0][0].template;
        click_url = $arr.config.spath + 'admincp/transactions';
        template = template.replace('{{event.user}}', 'Admin');
        template = template.replace('{{event.url}}', click_url);
        template = template.replace('{{event.sitename}}', config.title);
        template = template.replace('{{event.product_title}}', product_data.title);
        template = template.replace('{{event.logo_url}}', logo_url);
        localm.sendmail(template, subject_message, global.general.adminemail);

        res.json({
            status: 200,
            success: true,
            result: results[0][0],
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();

});
app.post(['/add_escrow_transaction_id'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    req.body.invoice_id = req.body.tr_invoice_id;
    req.body.status = 'waiting_for_seller_confirmation';
    req.body.gateway = "escrow";
    q.all([
        product.add_transaction_id(req, config.mysql, q),
        product.update_invoice_status(req, config.mysql, q),
        product.product_details_using_invoice_id(req, config.mysql, q),
        localm.mailtemps(req, config.mysql, q, 'buyer_added_escrow_transaction_id')
    ]).then(function (results) {
        var product_data = results[2][0][0];

        var template = results[3][0][0].template;
        var subject_message = results[3][0][0].subject;
        var logo_url = $arr.config.spath + 'images/logo.png';
        var click_url = $arr.config.spath + 'seller/soldAuction';
        template = template.replace('{{event.sitename}}', config.title);
        template = template.replace('{{event.user}}', product_data.seller_name);
        template = template.replace('{{event.url}}', click_url);
        template = template.replace('{{event.product_title}}', product_data.title);
        template = template.replace('{{event.logo_url}}', logo_url);
        localm.sendmail(template, subject_message, product_data.seller_email);

        click_url = $arr.config.spath + 'admincp/transactions';
        template = template.replace('{{event.user}}', 'Admin');
        template = template.replace('{{event.url}}', click_url);
        template = template.replace('{{event.sitename}}', config.title);
        template = template.replace('{{event.product_title}}', product_data.title);
        template = template.replace('{{event.logo_url}}', logo_url);
        localm.sendmail(template, subject_message, global.general.adminemail);

        res.json({
            status: 200,
            success: true,
            result: results[0][0]
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();

});
app.post(['/update_invoice_status'], function (req, res) {
    q.all([
        product.update_invoice_status(req, config.mysql, q),
        product.product_details_using_invoice_id(req, config.mysql, q),
        localm.mailtemps(req, config.mysql, q, 'seller_have_confirmed_escrow_payment')
    ]).then(function (results) {

        if(req.body.status == 'paid') {
            var product_data = results[1][0][0];

            var template = results[2][0][0].template;
            var subject_message = results[2][0][0].subject;
            var logo_url = $arr.config.spath + 'images/logo.png';
            var click_url = $arr.config.spath + 'buyer/buyAuction';
            if(product_data.invoice_type == 'Auction') {
                click_url = $arr.config.spath + 'buyer/wonAuction';
            }
            template = template.replace('{{event.sitename}}', config.title);
            template = template.replace('{{event.user}}', product_data.buyer_name);
            template = template.replace('{{event.url}}', click_url);
            template = template.replace('{{event.product_title}}', product_data.title);
            template = template.replace('{{event.logo_url}}', logo_url);
            localm.sendmail(template, subject_message, product_data.buyer_email);

            var template = results[2][0][0].template;
            click_url = $arr.config.spath + 'admincp/transactions';
            template = template.replace('{{event.user}}', 'Admin');
            template = template.replace('{{event.url}}', click_url);
            template = template.replace('{{event.sitename}}', config.title);
            template = template.replace('{{event.product_title}}', product_data.title);
            template = template.replace('{{event.logo_url}}', logo_url);
            localm.sendmail(template, subject_message, global.general.adminemail);
        }

        res.json({
            status: 200,
            success: true,
            result: results[0][0]
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();

});
app.get(['/send_mail_to_unread_chat_offer'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    q.all([
        product.get_unread_chat_offer_message(req, config.mysql, q),
        localm.mailtemps(req, config.mysql, q, 'you_have_new_message_from_offer_product')
    ]).then(function (listData) {
        var data = listData[0][0];
        if(data.length) {
            for (var index = 0; index < data.length; index++) {
                req.body.receiver_id = data[index].receiver_id;
                product.update_mail_send_for_offer_message(req, config.mysql, q);
                
                var template = listData[1][0][0].template;
                var subject_message = listData[1][0][0].subject;
                var logo_url = $arr.config.spath + 'images/logo.png';
                var click_url = $arr.config.spath + 'product/view/' + data[index].product_id;
                if(data[index].receiver_id == data[index].seller_id) {
                    click_url = $arr.config.spath + 'seller/openAuction';
                }
                template = template.replace('{{event.sitename}}', config.title);
                template = template.replace('{{event.user}}', data[index].receiver_name);
                template = template.replace('{{event.url}}', click_url);
                template = template.replace('{{event.product_title}}', data[index].product_title);
                template = template.replace('{{event.logo_url}}', logo_url);
                localm.sendmail(template, subject_message, data[index].receiver_email);
            }
        }
        res.json({
            success: true,
            length: listData[0][0].length,
            result: listData[0][0]
        });
        res.end();
        return false;
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

module.exports = app;
