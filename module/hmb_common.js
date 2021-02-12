var nsmarty = require('nsmarty');
var util = require('util');
var scriptfile = '';
var headered = 1;
var q = require('q');
var dateformatServer = require('dateformat');
var mysqli = require('./mysqli');
var module = require('../module');
var fs = require('fs');
var jwt = require('jwt-simple');
var faAPI = require('../module/forwardauction_api');
var profile = require('../module/profile_settings');
var membership = require('../module/membership');
var async = require('async');
var url = require('url');

exports.successResponse = function (res, message, result) {
    res.json({
        status: 200,
        success: true,
        message: message,
        result: result
    });
    res.end();
}

/* Changing a date format from 21/06/2017 to 2017/06/21 */
exports.changeDateFormat = function (date) {
    console.log(date);
    var d = new Date(date.split("/").reverse().join("-"));
    console.log(d);
    var dd = d.getDate();
    var mm = d.getMonth() + 1;
    var yy = d.getFullYear();
    var newdate = yy + "/" + mm + "/" + dd;
    console.log(newdate);
    return newdate;
}

/* Changing a date format from 06/22/2017 to 2017/06/22 */
exports.changeDateFormat2 = function (date) {
    console.log(date);

    str = date;
    st2 = str.split("/");

    mo = st2[0];
    dy = st2[1];
    yr = st2[2];

    var newdate = yr + "/" + mo + "/" + dy;
    console.log(newdate);
    return newdate;
}

/* gettings total days in month */
function getDaysInMonth(month, year) {
    // Since no month has fewer than 28 days
    var date = new Date(year, month, 1);
    var days = [];
    console.log('month', month, 'date.getMonth()', date.getMonth())
    while (date.getMonth() === month) {
        days.push(new Date(date));
        date.setDate(date.getDate() + 1);
    }
    return days;
}

exports.validateDates = function (str) {
    var obj = [];

    if (str == 'hourly') {
        obj.str = 'hours';
        obj.count = 1;
        return obj;
    }
    if (str == 'minutes') {
        obj.str = 'minutes';
        obj.count = 3;
        return obj;
    }
    if (str == 'daily') {
        obj.str = 'day';
        obj.count = 1;
        return obj;
    }

    if (str == 'weekly') {
        obj.str = 'week';
        obj.count = 1;
        return obj;
    }
    if (str == 'biweekly') {
        obj.str = 'week';
        obj.count = 2;
        return obj;
    }
    if (str == 'monthly') {
        obj.str = 'month';
        obj.count = 1;
        return obj;
    }
    if (str == 'quaterly') {
        obj.str = 'month';
        obj.count = 3;
        return obj;
    }
    if (str == 'bianually') {
        obj.str = 'month';
        obj.count = 6;
        return obj;
    }
    if (str == 'anually') {
        obj.str = 'month';
        obj.count = 12;
        return obj;
    }
}

exports.calulatePrice = function (req, res, data) {

    return false;
}

Date.prototype.addDays = function (days) {
    var secsDay = 86400000; // there are 86400000 secs in 1 day
    var time = this.getTime(); // number of milliseconds since midnight of January 1, 1970.
    var newdate = new Date(time + (days * secsDay));
    this.setDate(newdate.getDate());
    return newdate;
}

exports.sendJSONOutput = function (req, res, data) {
    res.send(JSON.stringify(data));
    res.end();
    return false;
}

exports.checkLoginJSON = function (req, res) {
    var data = {};
    data.success = true;
    if (typeof (req.session) === 'undefined') {
        data.success = false;
    } else if (typeof (req.session.userid) === 'undefined') {
        data.success = false;
    }
    if (!data.success) {
        this.sendJSONOutput(req, res, data);
    } else {
        return data;
    }
}

exports.getLocations = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'country_list');

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;
}

exports.getState = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'state_list');

    var defered = q.defer();
    var escape = [req.body.cid];

    query = mysql.query(strQuery, escape, defered.makeNodeResolver());

    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

/* Getting state abbriviation */
exports.getStateAbbr = function (req, mysql, q, state) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'state_abbr');

    var defered = q.defer();
    var escape = [state];

    query = mysql.query(strQuery, escape, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

/* Getting Business type restriction settings here */
exports.getbusirestrictions = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_business_settings');

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

exports.demoFormSubmit = function (req, mysql, q) {
    $mysqli = {};
    var dateFormat = require('dateformat');
    datge = new Date();
    var escape_data = [
        req.body.first_name,
        req.body.last_name,
        req.body.email,
        req.body.address,
        req.body.country_code,
        datge
    ];

    strQuery = mysqli.mysqli($mysqli, 297);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.productQuestion = function (req, mysql, q) {
    $mysqli = {};
    var escape_data = [req.body.pid];

    strQuery = mysqli.mysqli($mysqli, 259);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.categoriesAllQuestion = function (req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 257);

    var defered = q.defer();
    var escape_data = [req.param('cid'), req.param('cid')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.checkPermission = function (action, req) {
    // console.log(req.session);
    if (req.session.admin == 1) {
        return true
    } else {
        if (req.session[action] == 1 && req.session.permission == true && req.session.membershipstatus == 'active') {
            return true;
        } else {
            return false;
        }
    }

}
exports.checkLimitReached = function (action, req) {

    if (action == 'monthly_bid_limit') {
        var l = req.session.bidcountmonth;
    }
    if (action == 'bid_limit') {
        var l = req.session.bidcountyear;
    }
    if (action == 'monthly_project_limit') {
        var l = req.session.productcountmonth;
    }
    if (action == 'project_limit') {
        var l = req.session.productcountyear;
    }

    if (action == 'monthly_buynow_limit') {
        var l = req.session.buynowcountmonth - 1;
    }

    if (action == 'buynow_limit') {
        var l = req.session.buynowcountyear;
    }

    if (l == -1) {
        l = 1;
    }
    if (l === 'null') {
        l = 0;
    }


    if (req.session[action] > l) {
        return true;

    } else if (req.session[action] == -1) {
        return true;
    } else {
        return false;
    }
}
exports.allCategoriesList = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 175);

    var defered = q.defer();
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.allStoreCategoriesList = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 10175);

    var defered = q.defer();
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.admincpId = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 166);

    var defered = q.defer();
    var escape_data = [
        ['id', 'email']
    ];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.randomNumber = function (howMany, chars) {
    var crypto = require('crypto');


    chars = chars || "1234567890";
    var rnd = crypto.randomBytes(howMany),
        value = new Array(howMany),
        len = chars.length;

    for (var i = 0; i < howMany; i++) {
        value[i] = chars[rnd[i] % len]
    };

    return value.join('');

}

exports.urlparameter = function (query, leave) {
    var s = '';

    for (var i in query) {

        if (i != '') {
            s += i + '=' + query[i] + '&';
        }

    }
    for (var k in leave) {

        if (k != '') {
            s = s.replace(new RegExp(k + '=' + query[i] + '&', 'g'), '');
        }


    }

    return s;
}

exports.SearchPageNo = function (req, mysql, q) {

    delete data;
    data = odata = [];

    data = url.parse(req.url, true).query;
    data.where = '';
    //console.log(2);
    data.dspage = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    return data;
}

exports.fetchCountries = function (mysql) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 267);

    var defered = q.defer();
    var escape_data = [0];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.fetchStates = function (mysql, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 268);

    var defered = q.defer();
    var escape_data = [id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}


exports.fetchCities = function (mysql, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 268);

    var defered = q.defer();
    var escape_data = [id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.processIndex = function (row, req, res, $arr) {

    $arr.projects = row;

    $arr.loged = req.session;

    if ($arr['pagetitle'] == '') {
        module.index(req, res, $arr);
    } else {
        module.other(req, res, $arr);
    }


}

exports.processIndexajax = function (row, req, res, $arr) {

    $arr.proj = row.projects;
    module.otherAjax(req, res, $arr);


}

exports.checkmobile = function (req, res, tid) {

    if (tid == 0) {
        var status = "0";
        res.send({ 'status': status, 'msg': "Not Valid User" });
        res.end();
        return false;
    } else {
        var secret = '123456';
        try {
            var decoded = jwt.decode(tid, secret);
            if (req.session.username != decoded) {
                var status = "0";
                res.send({ 'status': status, 'msg': "Not Valid User" });
                res.end();
                return false;
            } else {
                return true;
            }
        } catch (err) {
            if (err) {
                var status = "0";
                res.send({ 'status': status, 'msg': "Not Valid User" });
                res.end();
                return false;
            }
        }


    }

}

exports.checkLogin = function (req, res, id) {

    if (typeof (req.session) === 'undefined' && id == 0) {
        if (req.headers.referer)
            res.writeHead(302, {
                'Location': '/signin'
                //add other headers here...
            });
        res.end();

        return false;

    } else if (typeof (req.session.userid) === 'undefined' && id == 0) {

        res.writeHead(302, {
            // 'Location': '/login'
            'Location': '/signin'
            //add other headers here...
        });
        res.end();
        return false;
    } else {
        if (req.session.userid > 0 && id == 1) {

            res.writeHead(302, {
                'Location': '/'
                //add other headers here...
            });
            res.end();
            return true;
        }
    }
    return true;

}
exports.checkLoginCB = function (req, res, id, cb) {

    if (typeof (req.session) === 'undefined' && id == 0) {
        if (req.headers.referer)
            res.writeHead(302, {
                'Location': '/login'
                //add other headers here...
            });
        res.end();

        cb(false);
        return false;

    } else if (typeof (req.session.userid) === 'undefined' && id == 0) {

        res.writeHead(302, {
            // 'Location': '/login'
            'Location': '/'
            //add other headers here...
        });
        res.end();
        cb(false);
        return false;
    } else {
        if (req.session.userid > 0 && id == 1) {

            res.writeHead(302, {
                'Location': '/'
                //add other headers here...
            });
            res.end();
            cb(false);
            return true;
        }
    }

}
exports.admincheckLogin = function (req, res, id) {
    if (typeof (req.session) === 'undefined' && id == 0) {
        res.writeHead(302, {
            'Location': '/admin/login'
            //add other headers here...
        });
        res.end();
        return false;
    } else if (typeof (req.session.userid) === 'undefined' && id == 0) {
        res.writeHead(302, {
            'Location': '/admin/login'
            //add other headers here...
        });
        res.end();
        return false;
    } else {
        if (req.session.userid > 0 && id == 1 && req.session.admin == 1) {

        } else {
            res.writeHead(302, {
                'Location': '/admin/login/'
                //add other headers here...
            });
            res.end();
            return false;
        }
    }
    return true;
}
exports.checkLoginajax = function (req, res, id) {
    if (typeof (req.session) === 'undefined' && id == 0) {
        return false;
    } else if (typeof (req.session.userid) === 'undefined' && id == 0) {
        return false;
    } else {
        return true; 
    }

}
// var allProductCategories

exports.productCategories = function (mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 5);

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    /* console.log("Query productCategories::"+query.sql);*/
    return defered.promise;
}

exports.locations = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 702);

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;
}
exports.tplFile = function (file) {
    this.scriptfile = file;
}

exports.headerSet = function (data) {

    this.headered = data;
}
exports.ajaxjson = function (res, data) {
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify(data));
}

exports.loadTemplateHeader = function (req, res, arr) {
    arr.numberWithCommas = this.numberWithCommas;
    var self = this;

    arr.file = this.scriptfile;
    arr.homepage = '';
    arr.unread_chat_list = 0;
    if (this.scriptfile == 'home.tpl') {
        arr.homepage = 'true';
    } else {
        arr.homepage = 'false';
    }
    arr.headered = this.headered;
    arr.loged = req.session;
    arr.commonfunction = this;
    arr.sumFloat = this.sumFloat;
    arr.subFloat = this.subFloat;
    arr.parseFloat = this.parseFloat;
    arr.loged.phonevalid = (typeof (req.session.phonevalid) === 'undefined') ? '' : req.session.phonevalid;
    arr.last_urls = req.protocol + '://' + req.get('host') + req.originalUrl;
    var user = require('./user');
    var users = require('./hmb_user');
    /*this part is to track users in Site */
    var fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
    fullUrl = fullUrl.replace(/\/$/, "");
    var useragent = require('useragent');
    var requestIp = require('request-ip');
    var clientIp = requestIp.getClientIp(req);

    var agent = useragent.parse(req.headers['user-agent']);

    if (typeof (req.session.userid) !== 'undefined') {
        q.all([user.checkuser(req, $arr.config.mysql, q, clientIp)]).then(function (results) {
            if (results[0][0].length > 0) {
                user.updateUser(req, config.mysql, q, clientIp, req.session.userid, req.originalUrl, agent.toAgent(), agent.os.toString());
            } else {
                user.insertUser(req, config.mysql, q, clientIp, req.session.userid, req.originalUrl, agent.toAgent(), agent.os.toString());
            }
        });
    } else {
        q.all([user.checkuser(req, $arr.config.mysql, q, clientIp)]).then(function (results) {
            if (results[0][0].length > 0) {
                user.updateUser(req, config.mysql, q, clientIp, 0, req.originalUrl, agent.toAgent(), agent.os.toString());
            } else {
                user.insertUser(req, config.mysql, q, clientIp, 0, req.originalUrl, agent.toAgent(), agent.os.toString());
            }
        });
    }

    /*this part is to track users in Site**********Ends Here */
    if (typeof (req.session.themeno) !== 'undefined') {
        arr.themeno = req.session.themeno;
    } else {
        req.session.themeno = 0;
        arr.themeno = req.session.themeno;
    }

    if (typeof (req.session.autologin) !== 'undefined') {
        arr.autologin = req.session.autologin;
    } else {
        req.session.autologin = 0;
        arr.autologin = req.session.autologin;
    }

    arr.nuller = null;
    if (typeof (req.param('ln')) !== 'undefined') {
        req.session.language = req.param('ln')
    }
    /*if(typeof(req.session.language) !== 'undefined')
     {

     global.language_identifier = JSON.parse(fs.readFileSync('./public/uploads/product/'+req.session.language+'_language.json', 'utf-8'));
     //console.log(global.language_identifier);
     }
     //arr.pharse = arr._phrase = arr.phrase = global.language_identifier.language.phrases;*/
    // console.log("***********************************************************************************");
    // console.log(arr.pharse);
    if (typeof (arr.datenow) === 'undefined') {
        var dateFormat = require('dateformat');
        arr.datenow = new Date();
    }

    arr.serverdate = dateformatServer(new Date(), "yyyy/mm/dd HH:MM:ss");
    arr.current_year = dateformatServer(new Date(), "yyyy");
    

    uid = 0;

    if (typeof (req.session) !== 'undefined') {
        if (typeof (req.session.userid) !== 'undefined') {
            uid = req.session.userid;
        }
    }

    arr.ads_page_show = global.ads_page_show;
    arr.adsclickamount = global.ads.clickamount;

    arr.currencyConverter = this.currencyConverter;
    arr.convertKbToMb = this.convertKbToMb;
    arr.shorten = this.shorten;
    arr.convertBytesToKb = this.convertBytesToKb;
    // q.all([this.productCategories(arr.config.mysql, q), user.userInfo(req, arr.config.mysql, q, uid, ['balance', 'reserve_amount']), user.notify_msg_counter(req, arr.config.mysql, q), user.checkcurrency(req, arr.config.mysql, q), user.getseofromurl(req, arr.config.mysql, q, fullUrl)]).then(function (results) {

    async.series({
        getProductCategories: function (cb) {
            // getting product all categories
            q.all([self.productCategories(arr.config.mysql, q)]).then(function (results) {

                // console.log("Async testing : " + JSON.stringify(results));
                cb(null, results);

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        },
        getUserInfo: function (cb) {
            // getting userInformations
            var userDataCallback = function (err, response) {

                // console.log(JSON.stringify(response));
                cb(null, response);
            }

            faAPI.userInfo(req, uid, userDataCallback);
        },
        notifyMsgCounter: function (cb) {
            // getting notify message counter number

            q.all([user.notify_msg_counter(req, arr.config.mysql, q)]).then(function (results) {

                // console.log("Async testing : " + JSON.stringify(results));
                cb(null, results);

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();

        },
        checkCurrency: function (cb) {
            // getting notify message counter number

            q.all([user.checkcurrency(req, arr.config.mysql, q)]).then(function (results) {

                // console.log("Async testing : " + JSON.stringify(results));
                cb(null, results);

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();

        },
        getSeoFromUrl: function (cb) {
            // getting notify message counter number
            //mysqli['get_seo_url'] = 'select * from seo where url = ? order by id desc limit 1';
            q.all([user.getseofromurl(req, arr.config.mysql, q, fullUrl)]).then(function (results) {

                cb(null, results);

            }).fail(function (err) {
                console.log(err.stack);
            }).done();
        },
        getStaxDetails: function (cb) {
            // getting notify message counter number
            //mysqli['get_seo_url'] = 'select * from seo where url = ? order by id desc limit 1';
            q.all([profile.staxDetails(req, config.mysql, q, req.session.userid)]).then(function (results) {

                cb(null, results);

            }).fail(function (err) {
                console.log(err.stack);
            }).done();
        },
        getMembership: function (cb) {
            // getting notify message counter number
            //mysqli['get_seo_url'] = 'select * from seo where url = ? order by id desc limit 1';
            q.all([membership.getUserMembership(req, config.mysql, q, req.session.userid)]).then(function (results) {

                cb(null, results);

            }).fail(function (err) {
                console.log(err.stack);
            }).done();
        },
        /* ===================== start change by divyesh (added) ===================== */
        getSalesSupportDetails: function (cb) {
            // getting notify message counter number
            //mysqli['get_seo_url'] = 'select * from seo where url = ? order by id desc limit 1';
            q.all([user.getSalesSupport(req, res, config.mysql, req.session.userid)]).then(function (results) {

                cb(null, results);

            }).fail(function (err) {
                console.log(err.stack);
            }).done();
        },
        get_unread_chat_list: function (cb) {
            // getting notify message counter number
            //mysqli['get_seo_url'] = 'select * from seo where url = ? order by id desc limit 1';
            q.all([users.get_unread_chat_list(req, res, config.mysql, req.session.userid)]).then(function (results) {

                cb(null, results);

            }).fail(function (err) {
                console.log(err.stack);
            }).done();
        }

    }, function (err, results) {

        if (err) {
            console.log(err);
        } else {

            /* ===================== start change by divyesh (added) ===================== */
            console.log("results.get_unread_chat_list[0][0]---------==-=-==-=-===-")
            console.log(results.get_unread_chat_list[0][0])
            arr.unread_chat_list = results.get_unread_chat_list[0][0];

            if (results.getSalesSupportDetails[0][0].length > 0) {
                if (results.getSalesSupportDetails[0][0][0].help_grow == 0
                    && results.getSalesSupportDetails[0][0][0].sales_consultant == 1) {
                    req.session.is_consultant_fee = 'y';
                    req.session.consultant_fee = results.getSalesSupportDetails[0][0][0].consultant_fee;
                    arr.loged.is_consultant_fee = 'y';
                    arr.loged.consultant_fee = results.getSalesSupportDetails[0][0][0].consultant_fee;
                } else {
                    req.session.is_consultant_fee = 'n';
                    arr.loged.is_consultant_fee = 'n';
                    req.session.consultant_fee = 0;
                    arr.loged.consultant_fee = 0;
                }

            } else {
                req.session.is_consultant_fee = 'n';
                arr.loged.is_consultant_fee = 'n';
                req.session.consultant_fee = 0;
                arr.loged.consultant_fee = 0;
            }
           
            var fs = require('fs'),
                ini = require('ini');

            var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
            var mode = configed['section']['mode']['Maintenance_mode'];
            var seomode = configed['section']['seo']['enabled'];

            var originalurl = req.originalUrl;

            arr.pageofjs = req.originalUrl;
            var n = originalurl.search("admin");
            if (n < 1) {
                if (mode == 'yes' && originalurl != '/') {
                    res.writeHead(302, { 'Location': '/' });
                    res.end();
                    return false;
                }
            }
            if (originalurl.indexOf("/dashboard") > -1 || originalurl == '/profile_settings')
                arr.pageofjs = '/dashboard/';

            arr.category = results.getProductCategories[0][0];
            cats = results.getProductCategories[0][0];

            var maincategory = [];
            var subcategory = [];
            cats.forEach(function (item) {
                if (item.parent_id == 0) {
                    maincategory.push(item);
                }
            });

            cats.forEach(function (item) {
                if (item.parent_id > 0) {
                    subcategory.push(item);
                }
            });

            arr.maincategory = maincategory;
            arr.subcategory = subcategory;

            var dateFormat = require('dateformat');
            arr.dateFormat = dateFormat;
            arr['seomode'] = seomode;
            arr['msgcount'] = results.notifyMsgCounter[0][0][0].msgs;
            arr['currency'] = results.checkCurrency[0][0][0].symbol;
            arr['phrases'] = global.phrases;
            arr['phrase'] = global.phrase;

            req.session.currencyrate = results.checkCurrency[0][0][0].rate;

            arr.userbalance = [];

            if (uid != 0) {
                arr.loged.country = results.getUserInfo.user.country;
                arr.loged.state = results.getUserInfo.user.state;
                arr.loged.state_abbr = results.getUserInfo.user.state_abbr;

                req.session.country = results.getUserInfo.user.country;
                req.session.state = results.getUserInfo.user.state;
                if (results.getUserInfo.user.state_abbr == '' && uid != 1) {
                    q.all(self.getStateAbbr('', config.mysql, q, req.session.state)).then(function (result1) {
                        $arr.loged['state_abbr'] = req.session.state_abbr = result1[0][0].sc;
                        arr.loged.state_abbr = req.session.state_abbr = result1[0][0].sc;
                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    });
                } else {
                    req.session.state_abbr = results.getUserInfo.user.state_abbr;
                }

            }

            if (results.getUserInfo !== null) {
                if (results.getUserInfo.user !== undefined) {
                    //user.userInfo(req, arr.config.mysql, q, uid, ['balance', 'reserve_amount'])
                    arr.userbalance.balance = results.getUserInfo.user.balance;
                    arr.userbalance.reserve_amount = results.getUserInfo.user.reserve_amount;

                    /* instant redirection to logout if admin changes any status */

                    if (results.getUserInfo.user.del_status == 1) {
                        res.writeHead(302, {
                            'Location': global.url + '/login/logout'
                        });
                        res.end();
                        return false;
                    } else {
                        /* if pending */
                        if (results.getUserInfo.user.status == 'unverified') {
                            res.writeHead(302, {
                                'Location': global.url + '/login/logout'
                            });
                            res.end();
                            return false;
                        }

                        /* if suspended */
                        if (results.getUserInfo.user.status == 'deactivate') {
                            res.writeHead(302, {
                                'Location': global.url + '/login/logout'
                            });
                            res.end();
                            return false;
                        }
                        /* if rejected */
                        if (results.getUserInfo.user.status == 'moderate') {
                            res.writeHead(302, {
                                'Location': global.url + '/login/logout'
                            });
                            res.end();
                            return false;
                        }

                        /* if active */
                        if (results.getUserInfo.user.status != 'active') {
                            if (req.body.loginpage == 1) {

                                res.writeHead(302, {
                                    'Location': global.url + '/login/logout'
                                });
                                res.end();
                                return false;
                            } else {
                                res.writeHead(302, {
                                    'Location': global.url + '/login/logout'
                                });
                                res.end();
                                return false;
                            }
                        }
                    }
                }
            }
            if (results.getSeoFromUrl[0].length > 0) {
                arr.metas = results.getSeoFromUrl[0][0];
            }
            arr['metatitle'] = 'sadasdas';

            // console.log(arr.metas);

            if (uid > 0) {
                arr.userbalance.ledger = parseFloat(results.getUserInfo.user.balance - results.getUserInfo.user.reserve_amount).toFixed(2);
                arr.userbalance.balance = parseFloat(results.getUserInfo.user.balance).toFixed(2);
            } else {
                arr.userbalance = [];
                arr.userbalance.ledger = arr.userbalance.balance = 0;
            }

            arr.userbalance.balance = parseFloat(arr.userbalance.balance).toFixed(2);

            /* updating stax details */

            if (results.getStaxDetails[0][0].length > 0) {
                req.session.stax = results.getStaxDetails[0][0][0].stax;
                req.session.stax_per = results.getStaxDetails[0][0][0].stax_per;
                req.session.business_type = results.getStaxDetails[0][0][0].business_type;
                arr.loged.stax = results.getStaxDetails[0][0][0].stax;
                arr.loged.stax_per = results.getStaxDetails[0][0][0].stax_per;
                arr.loged.business_type = results.getStaxDetails[0][0][0].business_type;
            }

            /* updating membership details */
            if (results.getMembership[0][0].length > 0) {
                var permissions = results.getMembership[0][0];
                var membershipstatus = results.getMembership[0][0][0].membership_status;
                if (permissions.length > 0) {
                    req.session.permission = true;
                    req.session.membershipstatus = membershipstatus;
                    arr.permission = true;
                    arr.membershipstatus = membershipstatus;
                }
                for (i in permissions) {
                    req.session[permissions[i]['varname']] = permissions[i]['value'];
                    arr[permissions[i]['varname']] = permissions[i]['value'];
                }
            }
            nsmarty.tpl_path = arr.config.path + '/templates/';
            if (typeof (req.session.language) !== 'undefined') {
                nsmarty.tpl_path = arr.config.path + 'language/templates/';
            }
            nsmarty.clearCache(arr.file);

            if (!arr.headered) {
                function ajaxjsonrun(data) {
                    res.setHeader('Content-Type', 'application/json');
                    res.json({ html: data });
                    res.end();
                }

                stream = nsmarty.assigndata(arr.file, arr, ajaxjsonrun);

            } else {
                function onlyUnique(value, index, self) {
                    return self.indexOf(value) === index;
                }

                delete defaultcss;
                defaultcss = ['parsley'];

                if (typeof (arr['externalcss']) !== 'undefined') {

                    arr['external2css'] = arr['externalcss'].concat(defaultcss).filter(onlyUnique);
                    delete arr['externalcss'];
                } else {

                    arr['external2css'] = defaultcss;
                }
                delete defaultjs;
                defaultjs = ['parsley'];

                if (typeof (arr['externaljs']) !== 'undefined') {

                    arr['external2js'] = arr['externaljs'].concat(defaultjs).filter(onlyUnique);;
                    delete arr['externaljs'];
                } else {

                    arr['external2js'] = defaultjs;
                }
                arr['timer'] = 0;
                if (typeof (req.session.pid) !== 'undefined') {
                    var moment = require('moment')
                    var dateFormat = require('dateformat');
                    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
                    var startDate = moment(req.session.temp_time_id, 'YYYY-M-DD HH:mm:ss')
                    var endDate = moment(datenow, 'YYYY-M-DD HH:mm:ss');
                    var secondsDiff = req.session.timer - endDate.diff(startDate, 'seconds');
                    arr['timer'] = secondsDiff;
                }
                
                res.setHeader('Content-Type', 'text/html; charset=UTF-8');
                nsmarty.clearCache(arr.file);
                stream = nsmarty.assign(arr.file, arr);
                util.pump(stream, res);
                
            }
        }
    })
}
exports.renderJson = function (res, data) {
    console.log('renderJson section');
    res.setHeader('Content-Type', 'application/json');
    res.json(data);
    res.end()
}
exports.currencyConverter = function (data) {
    return parseFloat(data).toFixed(2);
}
exports.shorten = function (data, num) {
    if (data == '' || data == null) {
        return data;
    }
    var length = data.length;
    var s = require('string');
    if (length > num) {
        return s(data).stripTags().s.substring(0, num) + '...';
    }
    return s(data).stripTags().s;
}

exports.parseFloat = function (data) {
    data = parseFloat(data).toFixed(2);
    return parseFloat(data);
}
exports.sumFloat = function (data, data2) {
    data = parseFloat(data) + parseFloat(data2);
    return parseFloat(data);
}
exports.subFloat = function (data, data2) {
    data = (parseFloat(data) - parseFloat(data2)).toFixed(2);
    return parseFloat(data);
}
exports.convertBytesToKb = function (val) {
    kbvalue = (parseFloat(val) / 1024).toFixed(2);
    return kbvalue;
}

exports.convertKbToMb = function (val) {
    kbvalue = (parseFloat(val) / 1024).toFixed(2);
    return kbvalue;
}

exports.convertMbToKb = function (val) {
    mbvalue = (parseFloat(val) * 1000).toFixed(2);
    return mbvalue;
}

/*exports.convertbytesToMb= function(val){
 mbvalue = (parseFloat(val)/1048576).toFixed(2);
 return mbvalue;
 }*/

//var Splitter = require('split_er');
exports.dateMeasure = function (ms) {
    var d, h, m, s;
    s = Math.floor(ms / 1000);
    m = Math.floor(s / 60);
    s = s % 60;
    h = Math.floor(m / 60);
    m = m % 60;
    d = Math.floor(h / 24);
    h = h % 24;
    m = (m < 10) ? '0' + m : m;
    h = (h < 10) ? '0' + h : h;
    s = (s < 10) ? '0' + s : s;
    d = (d < 10) ? '0' + d : d;
    return d + 'd:' + h + 'h:' + m + 'm:' + s + 's';
}

exports.categoryDropdown = function (mysql) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cat1');

    var defered = q.defer();
    var escape_data = [0];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('categoryDropdown', query.sql);
    query.on('error', function (err) {

        throw err;
    });
    return defered.promise;

}


exports.productSubCategories = function (mysql, catid) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cat2');

    var defered = q.defer();
    var escape_data = [catid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        throw err;
    });
    return defered.promise;

}

exports.firstLetterCapital = function (str) {
    return str.replace(/\b./g, function (m) {
        return m.toUpperCase();
    });
};

exports.last_url = function (req) {

    return req.headers['referer'];
}
exports.getAdminphrase = function (mysql) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_admin_phrase');

    var defered = q.defer();
    var escape_data = [];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        console.log('err', err);
        throw err;
    });
    return defered.promise;

}
exports.getHomephrase = function (mysql) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_home_phrase');

    var defered = q.defer();
    var escape_data = [];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {

        throw err;
    });
    return defered.promise;

}

exports.last_login_update = function (req, mysql, q) {
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'last_login_update');
    var defered = q.defer();
    var escape_data = [datenow, req.session.userid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {

        throw err;
    });
    return defered.promise;

}




/* getting expired memberships */
exports.getExpiredMemberships = function (mysql) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_expired_memberships');

    var defered = q.defer();
    var escape_data = [];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

exports.changeMembershipStatus = function (mysql, ids) {
    console.log(ids);
    var idss = [];
    if (ids.length > 0) {
        for (i in ids) {
            if ((ids.length - 1) == i) {
                idss = idss + ids[i];
            } else {
                idss = idss + ids[i] + ', '
            }
        }
    }

    console.log("idss :------ " + idss);

    $mysqli = { ids: idss };
    strQuery = mysqli.mysqli($mysqli, 'change_membership_status');

    var defered = q.defer();
    var escape_data = [];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}


/* to add decimal places */
exports.addDecimalPlaces = function (action, results) {

    req_data = [];
    //console.log(results);
    if (action == 'users') {
        for (var i in results) {
            results[i].balance = (parseFloat(results[i].balance)).toFixed(2);
        }
        return results;
    }
    if (action == 'funds_requests') {
        for (var i in results) {
            results[i].amount = (parseFloat(results[i].amount)).toFixed(2);
            results[i].balance = (parseFloat(results[i].balance)).toFixed(2);
        }
        return results;
    }
    if (action == 'buynow_rec') {
        console.log('roundoff in common');
        for (var i in results) {
            console.log(results[i].b_cancel_ins_amt);
            console.log(results[i].b_cancel_ins_per);
            results[i].b_cancel_ins_amt = (parseFloat(results[i].b_cancel_ins_amt)).toFixed(2);
            results[i].b_cancel_ins_per = (parseFloat(results[i].b_cancel_ins_per)).toFixed(2);
            results[i].b_total_amount = (parseFloat(results[i].b_total_amount)).toFixed(2);
        }
        return results;
    }
    if (action == 'seller_sold') {
        for (var i in results) {
            results[i].b_total_amount = (parseFloat(results[i].b_total_amount)).toFixed(2);
            results[i].b_cancel_ins_amt = (parseFloat(results[i].b_cancel_ins_amt)).toFixed(2);
            results[i].b_reserve_amt = (parseFloat(results[i].b_reserve_amt)).toFixed(2);
        }
        return results;
    }
    if (action == 'trans_herbee_fee') {
        for (var i in results) {
            results[i].herbee_fee = (parseFloat(results[i].herbee_fee)).toFixed(2);
        }
        return results;
    }
    if (action == 'reviews') {
        console.log(JSON.stringify(results));
        for (var i in results) {
            results[i].rating = (parseFloat(results[i].rating)).toFixed(2);
        }
        return results;
    }


};

exports.numberWithCommas = function(x) {
    x = x == '' ? 0 : x;
    x = parseFloat(x.toString().replace(/,/g,'').replace('$','')).toFixed(2);
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}