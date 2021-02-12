var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var mysql = [];
var callback = '';
var lft = 0;
var rgt = 0;
var cnt = 0;
var admin = require('./admin');
var md5 = require('MD5');

exports.saveeditProduct = function (req, mysql, q, prdt) {

    // console.log(req.body);


    if (typeof (req.files.product_image) !== 'undefined') {
        if (typeof (req.files.product_image[0]) === 'undefined') {

            req.body.avatar = req.files.product_image.name;
            req.body.image = req.files.product_image.originalname;
        } else {
            req.body.avatar = req.files.product_image[0].name;
            req.body.image = req.files.product_image[0].originalname;
        }
    }

    if (typeof (req.files.test_results) !== 'undefined') {
        if (typeof (req.files.test_results[0]) === 'undefined') {

            req.body.test_result = req.files.test_results.name;
            req.body.test_result_img = req.files.test_results.originalname;
        } else {
            req.body.test_result = req.files.test_results[0].name;
            req.body.test_result_img = req.files.test_results[0].originalname;
        }
    }


    $mysqli = { image: '' };
    /* update projects  set title = ?,description = ?,category_id = ?,buynow = ?, sprice = ?,rprice = ?,bprice = ?,mprice = ?,auction = ?,negotiable = ?,qty = ?,  market_status = ?,updated_at = ?, parent_category_id = ?, cannabis_type = ?,units = ?,  unit_price =?,stax =?, country=?, state=?, state_abbr=? {{image}} where id = ? limit 1*/
    strQuery = mysqli.mysqli($mysqli, 'admin_productedit');
    var defered = q.defer();

    var stax = (typeof (req.body.stax_per) == 'undefined') ? prdt.stax : parseFloat(req.body.stax_per);

    // var shipping_fee = common.currencyConverter(req.param('shipping_fee'));
    // var sprice = common.currencyConverter(req.body.sprice);
    // var rprice = common.currencyConverter(req.body.sprice);
    // var bprice = common.currencyConverter(req.body.sprice);
    // var mprice = common.currencyConverter(req.body.sprice);


    if (req.param('negotiable') == 1) {
        var buynow = 0;
    } else {
        var buynow = 1;
    }

    /*update projects set avatar = ?, image = ?, test_result = ?, test_result_img, title = ?,  brand = ?,  description = ?, category_id = ?, 
    parent_category_id = ?, auction = ?, buynow = ?, negotiable=?, 
    cannabis_type = ?,
    sprice = ?,    rprice = ?,bprice = ?,mprice = ?,qty = ?,  rfilled_qty=?, units = ?, unit_price = ?, stax =? {{image}} where id = ? limit 1*/

    var sprice = typeof (req.body.negotiable) !== 'undefined' && req.body.negotiable == 1 ? req.body.sprice : req.body.unit_price;

    var escape_data = [
        typeof (req.body.avatar) !== 'undefined' ? req.body.avatar : prdt.avatar,
        typeof (req.body.image) !== 'undefined' ? req.body.image : prdt.image,
        typeof (req.body.test_result) !== 'undefined' ? req.body.test_result : prdt.test_result,
        typeof (req.body.test_result_img) !== 'undefined' ? req.body.test_result_img : prdt.test_result_img,
        typeof (req.body.title) !== 'undefined' ? req.body.title : prdt.title,
        typeof (req.body.brand) !== 'undefined' ? req.body.brand : prdt.brand,
        typeof (req.body.description) !== 'undefined' ? req.body.description : prdt.description,
        typeof (req.body.cid) !== 'undefined' ? req.body.cid : prdt.cid,
        typeof (req.body.parentcid) !== 'undefined' ? req.body.parentcid : prdt.parentcid,
        typeof (req.body.auction) !== 'undefined' ? req.body.auction : prdt.auction,
        typeof (buynow) !== 'undefined' ? buynow : 0,
        typeof (req.body.negotiable) !== 'undefined' ? req.body.negotiable : prdt.negotiable,
        (typeof (req.body.cannabis_type) !== 'undefined' && req.body.cannabis_type == 'y') ? 'y' : 'n',    //y or n
        sprice,
        typeof (req.body.sprice) !== 'undefined' ? common.currencyConverter(req.body.sprice) : prdt.rprice,
        typeof (req.body.unit_price) !== 'undefined' ? common.currencyConverter(req.body.unit_price) : prdt.bprice,
        typeof (req.body.mprice) !== 'undefined' ? common.currencyConverter(req.body.mprice) : prdt.mprice,
        (typeof (req.body.qty) !== 'undefined') ? req.body.qty : prdt.qty,
        (typeof (req.body.qty) !== 'undefined' && (req.body.auction == 1)) ? req.body.qty : prdt.rfilled_qty,
        (typeof (req.body.units) !== 'undefined') ? req.body.units : prdt.units,
        typeof (req.body.unit_price) !== 'undefined' ? req.body.unit_price : prdt.unit_price,
        typeof (req.body.stax) !== 'undefined' ? req.body.stax : prdt.stax,
        typeof (req.body.order_type) !== 'undefined' ? req.body.order_type : prdt.order_type,
        typeof (req.body.trading_type) !== 'undefined' ? req.body.trading_type : prdt.trading_type,
        req.body.id
    ]

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    ////console.log(query.sql);
    query.on('error', function (err) {
        //console.log(query.sql);
        throw err;
    });
    return defered.promise;
}

exports.addAdminBusinessDetails = function (mysql, req, res, userId) {
    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    // console.log("addShippingDetails"+JSON.stringify(req.body));
    //update business_details set license_img = ?, business_cert = ?, ref_code=?, notification_type=?, product_offers=?, sell_offers=? where userid = ?';
    // address, country, state, city, zip, region, state_abbr, 
    strQuery = mysqli.mysqli($mysqli, "add_business_details_admin");
    var escape_string = [
        typeof (req.body.business_name) !== 'undefined' ? req.body.business_name : '',
        typeof (req.body.business_type) !== 'undefined' ? req.body.business_type : 'grower',
        typeof (req.body.license_img) !== 'undefined' ? req.body.license_img : '',
        typeof (req.body.business_cert) !== 'undefined' ? req.body.business_cert : '',
        typeof (req.body.ein_number) !== 'undefined' ? req.body.ein_number : '',
        typeof (req.body.stax) !== 'undefined' ? req.body.stax : '',
        typeof (req.body.stax_per) !== 'undefined' ? req.body.stax_per : '',
        /* Added for address same as userprofile */
        typeof (req.body.address1) !== 'undefined' ? req.body.address1 : '',
        typeof (req.body.country) !== 'undefined' ? req.body.country : '',
        typeof (req.body.state) !== 'undefined' ? req.body.state : '',
        typeof (req.body.city) !== 'undefined' ? req.body.city : '',
        typeof (req.body.zip) !== 'undefined' ? req.body.zip : '',
        typeof (req.body.region) !== 'undefined' ? req.body.region : '',
        typeof (req.body.state_abbr) !== 'undefined' ? req.body.state_abbr : '',
        datge,
        userId
    ];
    // console.log(escape_string);
    var defered = q.defer();
    // //console.log(strQuery);
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.updateBusiness = function (mysql, req, res, userId) {
    // console.log(req.body);
    // console.log(req.files);
    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    // console.log("addShippingDetails"+JSON.stringify(req.body));
    // mysqli['update_business_details'] = 'update user_extras  set business_name = ?, business_type = ?, license_img = ?, business_cert = ?, ein_number = ? where user_id = ?';
    strQuery = mysqli.mysqli($mysqli, "update_business_details");
    var escape_string = [
        typeof (req.body.business_name) !== 'undefined' ? req.body.business_name : '',
        typeof (req.body.business_type) !== 'undefined' ? req.body.business_type : '',
        typeof (req.body.license_img) !== 'undefined' ? req.body.license_img : req.body.license_image,
        typeof (req.body.business_cert) !== 'undefined' ? req.body.business_cert : req.body.business_certificate,
        typeof (req.body.ein_number) !== 'undefined' ? req.body.ein_number : '',
        typeof (req.body.stax) !== 'undefined' ? req.body.stax : '',
        typeof (req.body.stax_per) !== 'undefined' ? req.body.stax_per : '',
        /* Added for address same as userprofile */
        typeof (req.body.address1) !== 'undefined' ? req.body.address1 : '',
        typeof (req.body.country) !== 'undefined' ? req.body.country : '',
        typeof (req.body.state) !== 'undefined' ? req.body.state : '',
        typeof (req.body.city) !== 'undefined' ? req.body.city : '',
        typeof (req.body.zip) !== 'undefined' ? req.body.zip : '',
        typeof (req.body.region) !== 'undefined' ? req.body.region : '',
        typeof (req.body.state_abbr) !== 'undefined' ? req.body.state_abbr : '',
        datge,
        userId
    ];
    // console.log(escape_string);
    var defered = q.defer();
    //console.log(strQuery);
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}


exports.twiliolist = function (req, mysql, q) {
    $mysqli = {};
    var escape_data = [];


    strQuery = mysqli.mysqli($mysqli, 'twilio1');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.twilioaddnumber = function (req, mysql, q) {
    $mysqli = {};

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.param('number'), datge];

    strQuery = mysqli.mysqli($mysqli, 'twilio2');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.twilioenablenumber = function (req, mysql, q, enable) {
    $mysqli = {};

    var escape_data = [enable, req.param('id')];

    strQuery = mysqli.mysqli($mysqli, 'twilio3');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.getAllCategory = function (req, mysql, q, id, limit) {

    $mysqli = {};
    var escape_data = [];


    strQuery = mysqli.mysqli($mysqli, 274);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });

    return defered.promise;
}
exports.getAllStoreCategory = function (req, mysql, q, id, limit) {

    $mysqli = {};
    var escape_data = [];


    strQuery = mysqli.mysqli($mysqli, 10274);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updatePageContent = function (req, res, mysql, q) {
    $mysqli = {};
    var escape_data = [req.param('editor1'), req.param('id')];
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 'static3');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.showstaticContent_by_name = function (req, res, mysql, q, name) {
    $mysqli = {};
    var escape_data = [name];
    strQuery = mysqli.mysqli($mysqli, 'static_by_name');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('showstaticContent_by_name', query.sql);
    query.on('error', function (err) {
        console.log('showstaticContent_by_name', err.stack);
    });
    return defered.promise;
}
exports.showstaticContent2 = function (req, res, mysql, q, id) {
    $mysqli = {};
    var escape_data = [id];
    strQuery = mysqli.mysqli($mysqli, 'static2');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.showstaticContent = function (req, res, mysql, q) {
    $mysqli = {};
    var escape_data = [req.param('id')];
    strQuery = mysqli.mysqli($mysqli, 'static2');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.showstaticPages = function (req, res, mysql, q) {
    $mysqli = {};
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 'static1');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.approveProduct = function (req, mysql, q) {
    $mysqli = {};
    var escape_data = [req.param('id')];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, '271');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updatePaid = function (req, mysql, q, id) {
    $mysqli = {};
    var escape_data = [id];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 'cnx253');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateLftRgtCategories = function (req, mysql, q, lft, rgt, id) {
    $mysqli = {};
    var escape_data = [lft, rgt, id];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 264);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateLftRgtCategories = function (req, mysql, q, lft, rgt, id) {
    $mysqli = {};
    var escape_data = [lft, rgt, id];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 264);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateLftRgtStoreCategories = function (req, mysql, q, lft, rgt, id) {
    $mysqli = {};
    var escape_data = [lft, rgt, id];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 10264);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.deleteCategories = function (req, mysql, q) {
    $mysqli = {};

    var escape_data = [req.param('id'), req.param('id')];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 265);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    $mysqli = {};
    var escape_data = [req.param('id')];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 266);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
}
exports.deleteStoreCategories = function (req, mysql, q) {
    $mysqli = {};

    var escape_data = [req.param('id'), req.param('id')];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 10265);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //
    // $mysqli = {};
    // var escape_data = [req.param('id')];
    //
    // console.log(escape_data);
    // strQuery = mysqli.mysqli($mysqli, 10266);
    // var defered = q.defer();
    //
    // query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
}

exports.categoryupdate = function (req, mysql, q) {

    $mysqli = {};
    datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [
        req.body.categories,
        req.body.title,
        req.body.description,
        (typeof (req.body.ob_market) != undefined && req.body.ob_market == '1') ? 1 : 0,
        (typeof (req.body.db_market) != undefined && req.body.db_market == '1') ? 1 : 0,
        datenow,
        req.body.id
    ];

    // console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 261);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);

    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    })

    if (req.body.opid != req.body.categories) {
        $mysqli = {};
        var escape_data = [req.body.categories, req.body.id];

        console.log(escape_data);
        strQuery = mysqli.mysqli($mysqli, 262);
        var defered = q.defer();

        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        //console.log(query.sql);

        query.on('error', function (err) {
            console.log(err.stack);
            throw err;
        })

    }
}
exports.storecategoryupdate = function (req, mysql, q) {
    $mysqli = {};
    datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.categories, req.body.title, req.body.description, datenow, req.body.id];
    strQuery = mysqli.mysqli($mysqli, 10261);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    if (req.body.opid != req.body.categories) {
        $mysqli = {};
        var escape_data = [req.body.categories, req.body.id];
        console.log(escape_data);
        strQuery = mysqli.mysqli($mysqli, 10262);
        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    }
}
exports.addProductionAnswer = function (req, mysql, q, id) {
    $mysqli = {};
    var escape_data = [id];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 260);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    if (typeof (req.param('questions')) !== 'undefined') {
        for (i in req.param('questions')) {
            $mysqli = {};
            var ans = (req.param('questions')[i] instanceof Array) ? req.param('questions')[i].join(',') : req.param('questions')[i];
            var escape_data = [id, req.param('questions_id')[i], ans];

            console.log(escape_data);
            strQuery = mysqli.mysqli($mysqli, 258);
            var defered = q.defer();

            query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
            //return defered.promise;
        }

    }

}
exports.categoriesQuestionDetail = function (req, mysql, q) {
    $mysqli = {};
    var escape_data = [req.param('id')];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 255);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.createQuestion = function (req, mysql, q) {
    $mysqli = {};
    if (!req.body.value) {
        req.body.value = '';
    }
    if (!req.body.default) {
        req.body.default = '';
    }
    if (!req.body.required) {
        req.body.required = 0;
    }
    var escape_data = [req.body.cid, req.body.name, req.body.value, req.body.type, req.body.default, req.body.required];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 254);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateQuestion = function (req, mysql, q) {
    $mysqli = {};
    if (!req.body.value) {
        req.body.value = '';
    }
    if (!req.body.default) {
        req.body.default = '';
    }
    if (!req.body.required) {
        req.body.required = 0;
    }
    var escape_data = [req.body.name, req.body.value, req.body.type, req.body.default, req.body.required, req.body.id];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 256);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.categoriesDetail = function (req, mysql, q) {
    $mysqli = {};
    var escape_data = [req.param('cid')];


    strQuery = mysqli.mysqli($mysqli, 253);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.categoriesQuestion = function (req, mysql, q) {
    $mysqli = {};
    var escape_data = [req.param('cid')];


    strQuery = mysqli.mysqli($mysqli, 252);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.getChildCategory = function (req, mysql, q, id) {
    $mysqli = {};
    var escape_data = [id];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 263);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('escape_data');
    //console.log(query.sql);
    return defered.promise;
}
exports.getParentCategory = function (req, mysql, q, id) {
    $mysqli = {};
    var escape_data = [id];

    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 263);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.getCategoryList = function () {
    var admin = require('./admin');

    //console.log('category id is :'+cat_id);
    admin.mysql.query("SELECT * FROM `categories` order by parent_id asc", function (error, results, fields) {
        //var self = this;

        async.each(results, admin.getSubCategoryList, function (err, subcategories) {
            console.log(admin.cnt);
        });
    });
}
exports.getSubCategoryList = function (id, cb) {
    var admin = require('./admin');
    var cat_id = id['id'];

    console.log('category id is :' + cat_id);
    admin.mysql.query("SELECT * FROM `categories` WHERE `parent_id` = " + cat_id, function (error, results, fields) {
        //var self = this;
        console.log(results);
        if (results.length == 0) {

            cb(null);
        }
        async.each(results, admin.getSubCategoryList, function (err, subcategories) {
            admin.cnt += 1;
        });
    });
}
exports.changeEscrowPayment = function (req, mysql, q, m) {
    $mysqli = {};


    strQuery = mysqli.mysqli($mysqli, 'cnx243');
    var escape_data = [m, req.body.id];

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.getBuyNowRecord = function (req, mysql, q) {
    $mysqli = {};


    strQuery = mysqli.mysqli($mysqli, 'cnx242');
    var escape_data = [req.body.id];
    console.log(escape_data);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.escrowPayments = function (req, mysql, q, cnt) {
    $mysqli = {};

    if (cnt == 0) {
        strQuery = mysqli.mysqli($mysqli, 'cnx240');
        var escape_data = [(req.body.page - 1) * 10];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'cnx241');
        var escape_data = [];
    }
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.allWithdraw = function (req, mysql, q, cnt) {
    $mysqli = {};
    var escape_data = [(req.body.page - 1) * 10];
    msq = 172;
    if (cnt == 1) {
        var escape_data = [];
        msq = 174;
    }
    strQuery = mysqli.mysqli($mysqli, msq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.selectMaxrgt = function (req, mysql, q) {
    $mysqli = {};

    if (req.body.categories == 0) {
        var escape_data = [];
        strQuery = mysqli.mysqli($mysqli, 176);
    } else {
        var escape_data = [req.body.categories];
        strQuery = mysqli.mysqli($mysqli, 179);
    }

    var defered = q.defer();
    //datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.selectStoreMaxrgt = function (req, mysql, q) {
    $mysqli = {};

    if (req.body.categories == 0) {
        var escape_data = [];
        strQuery = mysqli.mysqli($mysqli, 10176);
    } else {
        var escape_data = [req.body.categories];
        strQuery = mysqli.mysqli($mysqli, 10179);
    }

    var defered = q.defer();
    //datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateLeft = function (req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 178);
    var defered = q.defer();
    //datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.mrgt];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateRight = function (req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 177);
    var defered = q.defer();
    //datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.mrgt];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateStoreLeft = function (req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 10178);
    var defered = q.defer();
    //datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.mrgt];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateStoreRight = function (req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 10177);
    var defered = q.defer();
    //datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.mrgt];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.getWithdraw = function (req, mysql, q, id) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 664);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.userBalanceUpdate = function (req, mysql, q, amount, userid) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 663);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [amount, userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.paidWithdraw = function (req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 173);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [datge, req.param('id')];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.addDigitalAttachment = function (val, mysql, q, pid) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 341);
    var defered = q.defer();
    var escape_data = [val.name, val.originalname, datge, pid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;
}
exports.addAttachment = function (val, mysql, q, pid) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 163);
    var defered = q.defer();
    console.log('******************************');
    console.log(val);
    console.log('******************************');
    var escape_data = [val.name, val.originalName, datge, pid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    var fs = require('fs')
    var gm = require('gm').subClass({ imageMagick: true });
    var watermark = global.paths.path + 'public/uploads/product/xpng.png';
    var pathTo = global.paths.path + 'public/uploads/product/' + val.name
    var pathFrom = pathTo;

    gm(pathFrom).
        gravity('SouthEast').
        draw(['image Over 0,0 0,0 "' + watermark + '"']).
        noProfile().
        write(pathTo, function (err) {
            console.log(err);
        });
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;
}
exports.deleteAttachment = function (mysql, q, req) {

    if (typeof (req.body.image) !== 'undefined') {
        if (req.body.image.length > 0) {
            var del = req.body.image_id.join().replace(/("|')/g, "");

        } else {
            req.body.avatar = '';
            req.body.image = '';
            var del = 0;
        }
    } else {
        req.body.avatar = '';
        req.body.image = '';
        var del = 0;
    }
    $mysqli = { 'delete': del };
    strQuery = mysqli.mysqli($mysqli, 165);
    var defered = q.defer();

    var escape_data = [req.body.id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.exportProductDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'product_data');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, defered.makeNodeResolver());
    return defered.promise;
}
exports.exportPaymentsDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'all_payments_data');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })

    return defered.promise;
}
exports.exportAdsCampaignsDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'total_ads_campaigns');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })

    return defered.promise;
}
exports.exportAdsDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'ads_data');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })

    return defered.promise;
}
exports.exportProjectDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 59);
    var defered = q.defer();

    var escape_data = [datge, datge, datge, datge, datge, datge];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

/* Total open products */
exports.exportProjectOffered = function (req, mysql, q) {
    $mysqli = {};

    // datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'products_offered');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

/* Product counts which are marked as delivered by seller but not yet received */
exports.exportProjectDelivered = function (req, mysql, q) {
    $mysqli = {};

    // datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'products_delivered');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

/* Product counts which are marked as delivered by seller and received by buyer*/
exports.exportProjecSold = function (req, mysql, q) {
    $mysqli = {};

    // datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'products_sold');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}
exports.exportTaxFees = function (req, mysql, q) {
    $mysqli = {};

    // datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'all_taxes_data');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}
exports.exportDistributorPayment = function (req, mysql, q) {
    $mysqli = {};

    // datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'exportDistributorPayment');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

/* Product counts which are marked as delivered by seller and received by buyer*/
exports.exportProjecFuture = function (req, mysql, q) {
    $mysqli = {};

    // datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'products_future');
    var defered = q.defer();

    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}

exports.saveBlog = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var defered = q.defer();
    if (req.body.id <= 0) {
        strQuery = mysqli.mysqli($mysqli, 96);
        var escape_data = [req.param('title'),
        req.param('description'), datge, req.session.userid, 'open'
        ];
    } else {
        strQuery = mysqli.mysqli($mysqli, 98);
        var escape_data = [req.param('title'),
        req.param('description'), req.body.id
        ];
    }

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.selblog = function (req, mysql, q) {
    $mysqli = {};

    id = req.param('id');
    strQuery = mysqli.mysqli($mysqli, 97);
    var defered = q.defer();

    var escape_data = [id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.publishBlog = function (req, mysql, q) {
    id = req.param('id');
    if (id > 0) {

        strQuery = mysqli.mysqli($mysqli, 100);
        var defered = q.defer();
        status = 'open';
        if (req.body.action == 'unpublish') {
            status = 'unpublish';
        }
        var escape_data = [status, id];
        console.log(escape_data);

        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        return defered.promise;
    }

}
exports.blogupload = function (req, mysql, q) {

    if (typeof (req.files.blog_image) !== 'undefined') {

        $mysqli = {};

        id = req.body.id;

        strQuery = mysqli.mysqli($mysqli, 99);
        var defered = q.defer();

        var escape_data = [(typeof (req.files.blog_image) !== 'undefined') ? req.files.blog_image.originalname : '',
        (typeof (req.files.blog_image) !== 'undefined') ? req.files.blog_image.name : '', id
        ];
        console.log(escape_data);

        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        return defered.promise;
    }
}
exports.exportUserDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 60);
    var defered = q.defer();

    var escape_data = [datge, datge, datge, datge, datge, datge];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.allreviews = function (req, mysql, q, count) {
    var where = '';
    var dateFormat = require('dateformat');
    if (typeof (req.param('from_date')) !== 'undefined' && req.param('from_date') != '') {
        date1 = dateFormat(new Date(req.param('from_date')), 'yyyy-mm-dd');
        where += ' and p.created_at >= "' + date1 + ' 00:00:00"';
    }
    if (typeof (req.param('to_date')) !== 'undefined' && req.param('to_date') != '') {
        date2 = dateFormat(new Date(req.param('to_date')), 'yyyy-mm-dd');
        where += ' and p.created_at <= "' + date2 + ' 23:59:59"';
    }

    
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [];
    if (count == 1) {
        $mysqli = { where: where, limit: "" };
    } else {
        var page = (req.body.page - 1) * 10;
        $mysqli = { where: where, limit: ' limit '+page+', 10' };
    }
    strQuery = mysqli.mysqli($mysqli, 92);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;
}

exports.reviews_dispute = function (req, mysql, q, count) {
    $mysqli = {};
    var uid = req.session.userid;
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 808);
        var escape_data = [uid];
    } else {
        strQuery = mysqli.mysqli($mysqli, 808);
        var page = (req.body.page - 1) * 10;
        var escape_data = [uid, page];
        console.log(escape_data)
        //var escape_data =  [];
    }
    var defered = q.defer();


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.deletemultiplereviews = function (req, mysql, q) {

    $mysqli = {};
    var tempid = [];
    tempid = req.body.ids;
    console.log('module running', tempid);
    strQuery = mysqli.mysqli($mysqli, 'review_delete');
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;

}
exports.deletereviews = function (req, mysql, q) {

    $mysqli = {};
    var tempid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 838);
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}


exports.feedbacks = function (req, mysql, q, count) {
    require('date-util');
    $mysqli = {};

    var datge = new Date().strtotime("1 day ago").format("yyyy-mm-dd HH:MM:ss");
    console.log('.........' + datge + '..........');
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 799);
        var escape_data = [datge];
    } else {
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        strQuery = mysqli.mysqli($mysqli, 800);
        page = (page > 0) ? (page - 1) * perlimit : 0;
        var escape_data = [page, perlimit];
        console.log(escape_data)
        //var escape_data =  [];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.alldispute = function (req, mysql, q, count) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 169);
        var escape_data = [];
    } else {
        strQuery = mysqli.mysqli($mysqli, 168);
        var page = (req.body.page - 1) * 10;
        var escape_data = [page];
        console.log(escape_data)
        //var escape_data =  [];
    }
    var defered = q.defer();


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.allblog = function (req, mysql, q, count) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 95);
        var escape_data = [];
    } else {
        strQuery = mysqli.mysqli($mysqli, 94);
        page = (req.body.page - 1) * 10;
        var escape_data = [page];
        console.log(escape_data)
        //var escape_data =  [];
    }
    var defered = q.defer();


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.exportTransactionDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 340);
    var defered = q.defer();

    var escape_data = [datge, datge, datge, datge, datge, datge];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.exportReviewDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'total_reviews');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    return defered.promise;
}
exports.exportRelationDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'relationships');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    return defered.promise;
}
exports.exportTransactDashboard = function (req, mysql, q) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'transact_data');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    return defered.promise;
}

exports.getTotalCommRevenue = function (req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'get_comm_rev');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    //console.log(query.sql, " ===========111111111111111=============== ")
    return defered.promise;
}

exports.transactionSearch = function (req, mysql, q, count) {
    var dateFormat = require('dateformat');

    console.log(req.param('status'));

    mysq = 80;
    where = '';
    /* where += (typeof(req.param('userid')) !== 'undefined' && req.param('userid') != '') ? ' and i.user_id = "' + req.param('userid') + '"' : where;
     //where += (typeof(req.param('projectid')) !== 'undefined' && req.param('projectid') != '') ? ' and p.project_id = '+req.param('projectid') : where;
     where += (typeof(req.param('projectid')) !== 'undefined' && req.param('projectid') != '') ? 'and ((i.type in ("sold","winner") and i.primary_id = "' + req.param('projectid') + '") OR (i.type in ("bid") and i.primary_id IN (select b.id from bids as b where b.project_id = "' + req.param('projectid') + '")))' : '';
     where += (typeof(req.param('trans_id')) !== 'undefined' && req.param('trans_id') != '') ? ' and i.transactionid = "' + req.param('trans_id') + '"' : where;
     where += (typeof(req.param('status')) !== 'undefined' && req.param('status') != '' && req.param('status') == 'sold') ? 'and (i.type in ("sold","winner") ) and i.status="paid"' : where;
     where += (typeof(req.param('status')) !== 'undefined' && req.param('status') != '' && req.param('status') == 'buynow') ? 'and (i.type in ("sold") )' : where;
     where += (typeof(req.param('status')) !== 'undefined' && req.param('status') != '' && req.param('status') == 'bid') ? 'and (i.type in ("winner") )' : where;
     where += (typeof(req.param('status')) !== 'undefined' && req.param('status') != '' && req.param('status') == 'winner') ? 'and (i.type in ("winner") and i.status="paid" )' : where;*/

    console.log('market', req.body.market);
    if (req.body.market == 'open') {
        where += 'and p.auction = 1';
    }
    if (req.body.market == 'direct') {
        where += 'and p.auction = 0';
    }
    if (req.body.market == 'recurring') {
        where += 'and b.recurring = "1"';
    }

    req.body.country = (typeof (req.param('country')) !== 'undefined') ? req.param('country') : '';
    req.body.state = (typeof (req.param('state')) !== 'undefined') ? req.param('state') : '';
    if (req.body.country != '' && req.body.state != '') {
        where += ' and i.user_id in (select user_id from user_extras where state = "' + req.body.state + '")  ';
    } else if (req.body.country != '') {
        where += ' and i.user_id in (select user_id from user_extras where country = "' + req.body.country + '")  ';
    }
    if (typeof (req.param('from_date')) !== 'undefined' && req.param('from_date') != '') {
        date1 = dateFormat(new Date(req.param('from_date')), 'yyyy-mm-dd');
        where += ' and i.date_added >= "' + date1 + ' 00:00:00"';
    }
    if (typeof (req.param('to_date')) !== 'undefined' && req.param('to_date') != '') {
        date2 = dateFormat(new Date(req.param('to_date')), 'yyyy-mm-dd');
        where += ' and i.date_added <= "' + date2 + ' 23:59:59"';
    }
    req.body.status = (typeof (req.param('status')) !== 'undefined') ? req.param('status') : '';

    /* sorting by debit / credit */
    if (req.body.status != '') {
        where += 'and i.istatus like "%' + req.body.status + '%"'
    }

    req.body.invoice_id = (typeof (req.param('invoice_id')) !== 'undefined') ? req.param('invoice_id') : 0;
    if (req.body.invoice_id > 0) {
        where += 'and i.id  like "%' + req.body.invoice_id + '%"'
    }
    req.body.projecttit = (typeof (req.param('projecttit')) !== 'undefined') ? req.param('projecttit') : '';
    if (req.body.projecttit != '') {
        where += 'and p.title  like "%' + req.body.projecttit + '%"'
    }
    req.body.type = (typeof (req.param('type')) !== 'undefined') ? req.param('type') : '';
    if (req.body.type != '') {
        where += 'and i.type  like "%' + req.body.type + '%"'
    }

    if (req.body.tax_filter != '') {
        if(req.body.tax_filter == 'distribution'){
            where += ' and b.distribution_tax > 0 '
        } else if(req.body.tax_filter == 'cultivation') {
            where += ' and b.cultivation_tax > 0 '
        } else if(req.body.tax_filter == 'excise'){
            where += ' and b.excise_tax_amt > 0 '
        } else {
            where += '';   
        }
    }
    where+=(count == 3 || count == 4) ? ' and i.type="bought" and b.recurring="0" ':''
    $mysqli = { where: where };
    // console.log($mysqli);
    var escape_data = [(req.body.page - 1) * 10];

    if (count == 0 || count == 4) {
        mysq = 81;
        escape_data = [];
    } else if (count == 2) {
        mysq = 82;
        escape_data = [];
    }

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    // console.log("qry iss " + strQuery);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log("getting transactions query here ------------- \n",query.sql);

    query.on('error', function (err) {
        throw err;
    })

   // console.log(query.sql, " ========2222222222222222222========== ")
    return defered.promise;
}

exports.userProductSearch = function (req, mysql, q, count) {
    var dateFormat = require('dateformat');

    mysq = 74;
    var where = '';
    var where1 = '';
    var whr = '';
    var cols = '';

    if (req.body.country !== '' && req.body.state !== '') {
        whr = whr + ' and ue.country ="' + req.body.country + '" and ue.state = "' + req.body.state + '" ';
    } else if (req.body.country !== '' && req.body.state == '') {
        whr = whr + ' and ue.country ="' + req.body.country + '"';
    } else if (req.body.country == '' && req.body.state !== '') {
        whr = whr + ' and ue.state = "' + req.body.state + '" ';
    }

    var dateFormat = require('dateformat');

    if (typeof (req.param('from_date')) !== 'undefined' && req.param('from_date') != '') {
        date1 = dateFormat(new Date(req.param('from_date')), 'yyyy-mm-dd');
        where += ' and p.date_added >= "' + date1 + ' 00:00:00" ';
    }
    if (typeof (req.param('to_date')) !== 'undefined' && req.param('to_date') != '') {
        date2 = dateFormat(new Date(req.param('to_date')), 'yyyy-mm-dd');
        where += ' and p.date_added <= "' + date2 + ' 23:59:59" ';
    }

    where += (typeof (req.param('title')) !== 'undefined' && req.param('title') != '') ? ' and p.title like "%' + req.param('title') + '%" ' : where;
    where += (typeof (req.param('id')) !== 'undefined' && req.param('id') != '') ? ' and p.id = ' + req.param('id') : where;

    status = (typeof (req.param('action')) !== 'undefined' && req.param('action') != '') ? req.param('action') : '';

    req.body.market = (typeof (req.param('market')) !== 'undefined' && req.param('market') != '') ? req.param('market') : '';

    date1 = dateFormat(new Date(), 'yyyy-mm-dd HH:MM:ss');

    if (req.body.market == 'openmarket') {
        where += ' and p.auction = 1 ';
    }

    if (req.body.market == 'directmarket') {
        where += ' and p.auction = 0 ';
    }

    // console.log('date1', date1)
    if (status == 'open') {
        where += ' and p.date_added <= "' + date1 + '" and p.date_closed >= "' + date1 + '" and p.market_status = "open" ';
    }

    if (status == 'closed') {
        cols += ', b.qty as sold_qty, b.id as b_id ';
        where1 += ' left join buynow as b on b.project_id = p.id ';
        // where += ' and p.date_closed < "' + date1 + ' "';
        where += ' and b.shipping_status = "1" and b.delivery_status = "0"';
    }

    if (status == 'future') {
        var today = new Date();
        today.setHours(today.getHours() + 72);
        date3 = dateFormat(today, 'yyyy-mm-dd HH:MM:ss');
        where += ' and p.date_added > "' + date3 + '" and  p.date_closed > "' + date1 + '" ';
    }

    if (status == 'sold') {
        cols += ', b.qty as sold_qty, b.id as b_id ';
        where1 += ' left join buynow as b on b.project_id = p.id ';
        where += ' and b.paid = 1 and b.shipping_status = "1" and b.delivery_status = "1" ';
    }

    if (status == 'delete') {
        where += ' and p.market_status = "removed" ';
    }

    /*if (req.query.sort_order == '') {
        where += ' order by p.id desc';
    } else {
        where += ' ORDER BY p.' + req.query.sorting_column + ' ' + req.query.sort_order;
    }*/

    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $mysqli = { cols: cols, where: where, whr: whr, where1: where1 };

    if (req.body.page == '') {
        req.body.page = 1;
    }
    console.log('page', req.body.page);
    var escape_data = [];
    if (count == 0) {
        mysq = 73;
        escape_data = [(req.body.page - 1) * 10];
    }

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(" dssssssssf " + query.sql);

    query.on('error', function (err) {
        throw err;
    })

    //console.log("Admin product qry "+query.sql);
    return defered.promise;
}

exports.updateUser = function (req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 54);
    var defered = q.defer();

    var escape_data = [
        req.body.email,
        req.body.first_name,
        req.body.last_name,
        req.body.aboutme,
        req.body.avatar,
        req.body.image,
        req.body.address1,
        req.body.address2,
        req.body.country,
        req.body.state,
        req.body.city,
        req.body.zip,
        req.body.phone,
        req.body.profile_url,
        req.body.paypal_address,
        req.body.status,
        req.body.id
    ];

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        throw err;
    })
    return defered.promise;
}
exports.updateUserStatus = function (req, mysql, q) {
    $mysqli = {};


    strQuery = mysqli.mysqli($mysqli, 69);
    var defered = q.defer();

    var escape_data = [req.body.status, req.body.id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateUserPassword = function (req, mysql, q) {
    $mysqli = {};


    strQuery = mysqli.mysqli($mysqli, 57);
    var defered = q.defer();

    var escape_data = [req.body.password, req.body.salt, req.body.id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.listUserCategories = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 117);
    escape_fields = [req.body.id]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.userdelete = function (req, mysql, q) {

    $mysqli = {};
    var uid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 701);
    var defered = q.defer();
    escape_data = [uid];
    //console.log(strQuery);
    console.log('delete');
    console.log(uid);


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
    //console.log(feedid);

}
exports.managecategories = function (req, mysql, q, mcat) {
    $mysqli = {};
    var defered = q.defer();

    q.all(this.checkProfilecategory(req, mysql, q, mcat)).then(function (results) {
        if (results[0].length == 0) {
            strQuery = mysqli.mysqli($mysqli, 116);
            escape_fields = [req.body.id, mcat]
            query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
        }

    });

    return defered.promise;
}

exports.checkProfilecategory = function (req, mysql, q, userCid) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 114);
    escape_fields = [req.body.id, userCid]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.removeCategories = function (req, mysql, q) {
    var cateArray = '';
    if (typeof (req.body.categories) == 'undefined')
        implodeats = '0';
    else {
        cateArray = req.body.categories;
        implodeats = cateArray.join(',');
    }
    //   console.log(33333333333);
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 115);
    escape_fields = [req.body.id, implodeats]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.editUser = function (req, mysql, q) {
    $mysqli = {};


    strQuery = mysqli.mysqli($mysqli, 25);
    var defered = q.defer();

    var escape_data = [
        ['email', 'first_name', 'last_name', 'balance', 'id', 'avatar', 'aboutme', 'password_hash', 'password_salt', 'status', 'image', 'address1', 'address2', 'country', 'state', 'city', 'zip', 'phone', 'profile_url', 'paypal_address'], req.body.id
    ];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.userList = function (req, mysql, q, count) {
    $mysqli = {};

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    page = (req.body.page - 1) * 10;

    // mysqli[62] = 'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users where status = ? order by id DESC limit ?, 10 ';
    // mysqli[63] = 'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users where (status = ? or status = ?) order by id DESC limit ?, 10';
    // mysqli[64] = 'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users order by id DESC limit ?, 10';

    if (req.body.action == 'all' && count == 1) {
        strQuery = mysqli.mysqli($mysqli, 64);
        var escape_data = [page];
    } else if (req.body.action == 'cancel' && count == 1) {
        strQuery = mysqli.mysqli($mysqli, 63);
        var escape_data = ['unsubscribe', 'deactivate', page];
    } else if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 62);
        var escape_data = [req.body.action, page];
    }

    if (req.body.action == 'all' && count == 0) {
        strQuery = mysqli.mysqli($mysqli, 67);
        var escape_data = [];
    } else if (req.body.action == 'cancel' && count == 0) {
        strQuery = mysqli.mysqli($mysqli, 66);
        var escape_data = ['unsubscribe', 'deactivate'];
    } else if (count == 0) {
        strQuery = mysqli.mysqli($mysqli, 65);
        var escape_data = [req.body.action];
    }
    var defered = q.defer();

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.saveProduct = function (req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 72);

    var defered = q.defer();
    newfilename = {};
    newfilename.name = '';
    newfilename.originalname = '';
    if (typeof (req.files.product_image) !== 'undefined') {
        if (typeof (req.files.product_image[0]) === 'undefined') {

            newfilename.name = req.files.product_image.name;
            newfilename.originalname = req.files.product_image.originalname;
        } else {
            newfilename.name = req.files.product_image[0].name;
            newfilename.originalname = req.files.product_image[0].originalname;
        }
    }

    var escape_data = [req.body.title,
    req.param('description'),
    (typeof (req.files.product_image) !== 'undefined') ? newfilename.name : ((typeof (req.body.avatar) !== 'undefined') ? req.body.avatar[0] : ''),
    (typeof (req.files.product_image) !== 'undefined') ? newfilename.originalname : ((typeof (req.body.avatar) !== 'undefined') ? req.body.image[0] : ''),
    req.param('cid'),
    req.param('tags'),
    common.currencyConverter(req.param('shipping_fee')),
    req.param('shipping_description'),

    (typeof (req.param('buynow')) === 'undefined') ? 0 : req.param('buynow'),
    (typeof (req.param('feature')) === 'undefined') ? 0 : req.param('feature'),
    //dateFormat(new Date(req.body.date_added),"yyyy-mm-dd HH:MM:ss"),
    //dateFormat(new Date(req.body.date_closed),"yyyy-mm-dd")+' 23:59:59',
    common.currencyConverter(req.body.sprice),
    common.currencyConverter(req.body.rprice),
    common.currencyConverter(req.body.bprice),
    common.currencyConverter(req.body.mprice),
    (typeof (req.param('auction')) === 'undefined') ? 0 : req.param('auction'),
    (typeof (req.param('is_location')) === 'undefined') ? 0 : req.param('is_location'),
    (typeof (req.param('document')) === 'undefined') ? 0 : req.param('document'),
    (typeof (req.param('work_loc')) === 'undefined') ? 0 : req.param('work_loc'),
    (typeof (req.param('auction')) === 'undefined' || req.param('auction') == 0) ? req.param('qty') : 1,
    (typeof (req.param('paypal_email')) === 'undefined') ? req.param('paypal_email') : '',
    (typeof (req.param('save')) === 'undefined') ? 'draft' : 'open',
    req.body.id
    ]
    console.log(req.body);
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.userListSearch = function (req, mysql, q, count) {
    //$mysqli =  {};

    $mysqli = {
        email: req.body.email,
        last_name: req.body.last_name,
        status: req.body.status,
        first_name: req.body.first_name
    }
    page = (req.body.page - 1) * 10;
    escape_data = [];
    if (count == 0) {
        strQuery = mysqli.mysqli($mysqli, 71);
    } else {
        strQuery = mysqli.mysqli($mysqli, 70);
        escape_data = [page];
    }
    var defered = q.defer();

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.addUser = function (req, mysql, q, count) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var md5 = require('MD5');
    var password_salt = '12345'
    var password = md5(md5(req.body.password) + password_salt);
    console.log(req.body);
    $mysqli = {
        email: req.body.email,
        role: 1,
        created_at: datge,
        password_hash: password,
        password_salt: password_salt,
    };

    strQuery = mysqli.mysqli($mysqli, 11);


    var defered = q.defer();
    escape_data = [req.body.first_name, req.body.last_name];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.categoriesList = function (req, mysql, q, count) {
    $mysqli = {};

    escape_data = [];
    if (count == 1) {
        escape_data = [(req.body.page - 1) * 10];
        strQuery = mysqli.mysqli($mysqli, 75);
    } else {
        strQuery = mysqli.mysqli($mysqli, 76);
        escape_data = [];
    }
    var defered = q.defer();

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.storecategoriesList = function (req, mysql, q, count) {
    $mysqli = {};

    escape_data = [];
    if (count == 1) {
        escape_data = [(req.body.page - 1) * 10];
        strQuery = mysqli.mysqli($mysqli, 1075);
    } else {
        strQuery = mysqli.mysqli($mysqli, 1076);
        escape_data = [];
    }
    var defered = q.defer();

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.selectCategories = function (req, mysql, q) {
    $mysqli = {};

    escape_data = [req.body.id];

    strQuery = mysqli.mysqli($mysqli, 77);

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.selectStoreCategories = function (req, mysql, q) {
    $mysqli = {};

    escape_data = [req.body.id];

    strQuery = mysqli.mysqli($mysqli, 1077);

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.categorySave = function (req, mysql, q) {
    $mysqli = {};
    id = req.body.id;
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    title = req.body.title;
    description = req.body.description;
    if (id == 0) {
        escape_data = [
            title,
            description,
            datge,
            datge,
            req.body.mrgt + 1,
            req.body.mrgt + 2,
            req.body.categories,
            (typeof (req.body.ob_market) != undefined || req.body.ob_market == 1) ? 1 : 0,
            (typeof (req.body.db_market) != undefined || req.body.db_market == 1) ? 1 : 0
        ];
        query = 78;
    } else {
        escape_data = [title, description, datge, id];
        query = 79;
    }
    // console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, query);

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    //console.log(query.sql);

    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    })

    return defered.promise;

}
exports.storeCategorySave = function (req, mysql, q) {
    $mysqli = {};
    id = req.body.id;
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    title = req.body.title;
    description = req.body.description;
    if (id == 0) {
        escape_data = [title, description, datge, datge, req.body.mrgt + 1, req.body.mrgt + 2, req.body.categories];
        query = 1078;
    } else {
        escape_data = [title, description, datge, id];
        query = 1079;
    }
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, query);

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}


exports.addbalance = function (req, mysql, q, from_ref) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 28);
    var defered = q.defer();
    escape_data = [global.general.referral_bonus, from_ref];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.deleteFeedback = function (req, mysql, q) {

    $mysqli = {};
    var feedid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 801);
    var defered = q.defer();
    escape_data = [feedid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
    //console.log(feedid);

}

exports.FeedbackFields = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 802);
    var defered = q.defer();
    escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.addFeedbackfield = function (req, mysql, q) {

    $mysqli = {};
    var feed_label = req.body.feedlabel;
    var feed_order = req.body.feedorder;
    strQuery = mysqli.mysqli($mysqli, 803);
    var defered = q.defer();
    escape_data = [feed_label, feed_order];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.updateFeedbackfield = function (req, mysql, q) {

    $mysqli = {};
    var feed_id = req.body.id;
    var feed_label = req.body.title;
    var feed_order = req.body.feed_order;
    strQuery = mysqli.mysqli($mysqli, 806);
    var defered = q.defer();
    escape_data = [feed_label, feed_order, feed_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.deleteFeedbackfield = function (req, mysql, q) {

    $mysqli = {};
    var feedid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 804);
    var defered = q.defer();
    escape_data = [feedid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
    //console.log(feedid);

}

exports.feedbackdetailsbyId = function (req, mysql, q) {

    $mysqli = {};
    var feedid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 805);
    var defered = q.defer();
    escape_data = [feedid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
    //console.log(feedid);

}

exports.FeedbackDatelist = function (req, res, mysql, q) {
    require('date-util');
    var datge = req.param('days');
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 807);
    var defered = q.defer();
    escape_data = [datge];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;


}


exports.addetemplates = function (req, mysql, q, $arr) {
    require('date-util');
    $mysqli = {};
    var date_added = $arr.datenow;
    var email_label = req.body.email_name;
    var email_sub = req.body.email_suject;
    var email_type = req.body.email_type;

    if (req.body.buyer) {
        var buyer = 1;
    } else {
        var buyer = 0
    };
    if (req.body.seller) {
        var seller = 1;
    } else {
        var seller = 0
    };
    if (req.body.admin) {
        var admin = 1;
    } else {
        var admin = 0
    };
    if (req.body.general) {
        var general = 1;
    } else {
        var general = 0
    };

    var method = 'email';
    var email_text = req.body.editor1;
    var status = 1;

    strQuery = mysqli.mysqli($mysqli, 820);
    var defered = q.defer();
    escape_data = [email_label, email_sub, email_type, method, email_text, date_added, buyer, seller, admin, general, status];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('adddddddddd' + defered.promise.insertId);
    return defered.promise;


}

exports.alltemps = function (req, mysql, q, count, type) {

    $mysqli = {};
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    var defered = q.defer();
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }

    $mysqli = { limit: limit };
    var escape_data = [type];
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, '821');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.etempsbyId = function (req, mysql, q) {

    $mysqli = {};
    var tempid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 822);
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
    //console.log(feedid);

}

exports.updateetemplates = function (req, mysql, q) {

    $mysqli = {};
    var etemp_id = req.body.id;
    var email_label = req.body.email_name;
    var email_sub = req.body.email_suject;
    var email_type = req.body.email_type;
    var email_text = req.body.editor1;

    if (req.body.buyer) {
        var buyer = 1;
    } else {
        var buyer = 0
    };
    if (req.body.seller) {
        var seller = 1;
    } else {
        var seller = 0
    };
    if (req.body.admin) {
        var admin = 1;
    } else {
        var admin = 0
    };
    if (req.body.general) {
        var general = 1;
    } else {
        var general = 0
    };


    strQuery = mysqli.mysqli($mysqli, 823);
    var defered = q.defer();
    escape_data = [email_label, email_sub, email_type, email_text, buyer, seller, admin, general, etemp_id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.deletetemp = function (req, mysql, q) {

    $mysqli = {};
    var tempid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 824);
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
    //console.log(feedid);

}
exports.searchtemplates = function (req, mysql, q, count, type) {

    $mysqli = {};
    var where = '';
    if ($arr['users'] == 'buyer') {
        where += ' and buyer = 1';
    } else if ($arr['users'] == 'seller') {
        where += ' and seller = 1';
    } else if ($arr['users'] == 'admin') {
        where += ' and admin = 1';
    } else if ($arr['users'] == 'general') {
        where += ' and general = 1';
    }

    where += (typeof ($arr['subjects']) !== 'undefined' && $arr['subjects'] != '') ? ' and subject like "%' + $arr['subjects'] + '%"' : where;
    where += (typeof ($arr['types']) !== 'undefined' && $arr['types'] != '') ? ' and type = "' + $arr['types'] + '"' : where;

    var page = req.body.page;
    var perlimit = req.body.perlimit;

    var defered = q.defer();
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }

    $mysqli = { where: where, limit: limit };
    var escape_data = [type];
    console.log('wjere' + $arr['users']);
    strQuery = mysqli.mysqli($mysqli, '825');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("email query is " + query.sql);
    return defered.promise;

}

exports.addstemplates = function (req, mysql, q, $arr) {
    require('date-util');
    $mysqli = {};
    var date_added = $arr.datenow;
    var sms_label = req.body.sms_name;
    var sms_sub = req.body.sms_suject;
    var sms_type = req.body.sms_type;

    if (req.body.buyer) {
        var buyer = 1;
    } else {
        var buyer = 0
    };
    if (req.body.seller) {
        var seller = 1;
    } else {
        var seller = 0
    };
    if (req.body.admin) {
        var admin = 1;
    } else {
        var admin = 0
    };
    if (req.body.general) {
        var general = 1;
    } else {
        var general = 0
    };

    var method = 'sms';
    var sms_text = req.body.editor1;
    var status = 1;

    strQuery = mysqli.mysqli($mysqli, 828);
    var defered = q.defer();
    escape_data = [sms_label, sms_sub, sms_type, method, sms_text, date_added, buyer, seller, admin, general, status];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.updatestemplates = function (req, mysql, q) {

    $mysqli = {};
    var etemp_id = req.body.id;
    var sms_label = req.body.sms_name;
    var sms_sub = req.body.sms_suject;
    var sms_type = req.body.sms_type;
    var sms_text = req.body.editor1;

    if (req.body.buyer) {
        var buyer = 1;
    } else {
        var buyer = 0
    };
    if (req.body.seller) {
        var seller = 1;
    } else {
        var seller = 0
    };
    if (req.body.admin) {
        var admin = 1;
    } else {
        var admin = 0
    };
    if (req.body.general) {
        var general = 1;
    } else {
        var general = 0
    };


    strQuery = mysqli.mysqli($mysqli, 829);
    var defered = q.defer();
    escape_data = [sms_label, sms_sub, sms_type, sms_text, buyer, seller, admin, general, etemp_id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}


exports.csvcheckBytitle = function (req, mysql, q, title) {
    $mysqli = {};
    var tempid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 826);
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

/*
exports.addtempbyCSV = function (req, mysql, q, arr) {
    try {
        $mysqli = {};
        console.log("Title issssssssssss ");
        console.log(arr);
        var title = arr['title'];
        var subject = arr['subject'];
        var type = arr['type'];
        var method = arr['method'];
        var template = arr['template'];
        var date_added = arr['date_added'];
        var buyer = arr['buyer'];
        var seller = arr['seller'];
        var admin = arr['admin'];
        var general = arr['general'];
        var status = arr['status'];

        strQuery = mysqli.mysqli($mysqli, 827);
        var defered = q.defer();
        escape_data = [title, subject, type, method, template, date_added, buyer, seller, admin, general, status];
    } catch (e) {
        console.log(e.stack);
    }
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Import query " + query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
    })
    return defered.promise;


}
*/
// New code added from car & bike
exports.addtempbyCSV = function (req, mysql, q, arr) {
    //console.log(JSON.stringify(arr));
    $mysqli = {};
    var title = arr['title'];
    var subject = arr['subject'];
    var type = arr['type'];
    var method = arr['method'];
    var template = arr['template'];
    var date_added = arr['date_added'];
    var buyer = arr['buyer'];
    var seller = arr['seller'];
    var admin = arr['admin'];
    var general = arr['general'];
    var status = arr['status'];
    var id = arr['id'];
    var defered = q.defer();

    if (id > 0) {

        strQuery = mysqli.mysqli($mysqli, 829);
        escape_data = [title, subject, type, template, buyer, seller, admin, general, id];
    } else {
        strQuery = mysqli.mysqli($mysqli, 827);
        escape_data = [title, subject, type, method, template, date_added, buyer, seller, admin, general, status];

    }

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;


}
exports.exportfull = function (req, mysql, q, count, type) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [];
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, '819');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.addmailer = function (req, mysql, q, $arr) {

    $mysqli = {};

    var opt_name = req.body.opt_name;
    var apiuser = req.body.apiuser;
    var apikey = req.body.apikey;
    var type = req.body.type;
    var status = 0;

    strQuery = mysqli.mysqli($mysqli, 830);
    var defered = q.defer();
    escape_data = [opt_name, apiuser, apikey, type, status];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query);
    return defered.promise;

}

exports.allmailers = function (req, mysql, q, count, type) {

    $mysqli = {};
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    var defered = q.defer();
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }

    $mysqli = { limit: limit };
    var escape_data = [];
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, 832);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.mailersbyid = function (req, mysql, q) {

    $mysqli = {};
    var tempid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 833);
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
    //console.log(feedid);

}

exports.updatemailer = function (req, mysql, q) {

    $mysqli = {};
    var id = req.body.id;
    var opt_name = req.body.opt_name;
    var apiuser = req.body.apiuser;
    var apikey = req.body.apikey;
    var type = req.body.type;
    var status = 0;

    strQuery = mysqli.mysqli($mysqli, 831);
    var defered = q.defer();
    escape_data = [opt_name, apiuser, apikey, type, id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.deletemailer = function (req, mysql, q) {

    $mysqli = {};
    var tempid = req.body.id;
    strQuery = mysqli.mysqli($mysqli, 834);
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
    //console.log(feedid);

}
exports.deactivatemailer = function (req, mysql, q, id) {

    $mysqli = {};
    var tempid = id;
    strQuery = mysqli.mysqli($mysqli, 835);
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.checkactivated = function (req, mysql, q, type) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 836);
    var defered = q.defer();
    escape_data = [type];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query);
    return defered.promise;

}
exports.activatemailer = function (req, mysql, q, id) {

    $mysqli = {};
    var tempid = id;
    strQuery = mysqli.mysqli($mysqli, 837);
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}


exports.shippers = function (req, mysql, q, count) {

    $mysqli = {};
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    var defered = q.defer();
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }

    $mysqli = { limit: limit };
    var escape_data = [];
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, '712');

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}

exports.shippersnew = function (req, mysql, q) {

    $mysqli = {};

    var defered = q.defer();
    req.body.domestic = req.body.domestic == 1 ? 1 : 0;
    req.body.international = req.body.international == 1 ? 1 : 0;
    req.body.sort = (typeof (req.body.sort) == 'undefined') ? 10 : req.body.sort;

    $mysqli = {};
    var escape_data = [req.body.title, req.body.shipcode, req.body.domestic, req.body.international, req.body.carrier, req.body.trackurl, req.body.sort];
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, '713');
    //console.log(strQuery);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}


exports.shippersdel = function (req, mysql, q) {

    $mysqli = {};

    var defered = q.defer();


    $mysqli = {};
    var escape_data = [req.body.id];
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, '714');
    //console.log(strQuery);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}

exports.reorderfeedfields = function (req, mysql, q, newp, oldp, count) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [newp, oldp];
    console.log(escape_data);
    console.log(newp + 'FADASDASDASDASDA' + oldp);
    if (count == 0) {
        strQuery = mysqli.mysqli($mysqli, '811');
    } else {
        strQuery = mysqli.mysqli($mysqli, '812');
    }
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.rearrangefields = function (req, mysql, q, position, count) {
    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [position];
    if (count == 0) {
        strQuery = mysqli.mysqli($mysqli, '813');
    } else {
        strQuery = mysqli.mysqli($mysqli, '814');
    }
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;


}

/* This Section is reports */

exports.csvInvoicesRep = function (req, mysql, q, status) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    console.log(checks);

    var limit = '';
    if (req.body.limit_results != '') {
        limit += 'limit 0,' + req.body.limit_results;
    } else {
        limit += '';
    }
    var order = "order by i.id " + req.body.orderradio;


    $mysqli = { limit: limit, order: order };
    if (req.body.optionsRadios == 'fixed') {

        var checks = req.body.rangepast;
        console.log(checks);
        if (checks == 'day') {
            strQuery = mysqli.mysqli($mysqli, '600');
        } else if (checks == 'week') {
            strQuery = mysqli.mysqli($mysqli, '601');
        } else if (checks == 'month') {
            strQuery = mysqli.mysqli($mysqli, '602');
        } else {
            strQuery = mysqli.mysqli($mysqli, '603');
        }

        var escape_data = [status];
    } else {

        var from_date = req.body.fromdate;
        var to_date = req.body.todate;
        var escape_data = [status, from_date, to_date];
        strQuery = mysqli.mysqli($mysqli, '604');


    }
    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;

}


exports.csvSellerRep = function (req, mysql, q, status) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};

    var limit = '';
    if (req.body.limit_results != '') {
        limit += 'limit 0,' + req.body.limit_results;
    } else {

        limit += '';
    }

    var order = "order by id " + req.body.orderradio;


    $mysqli = { limit: limit, order: order };

    if (status == 1) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, '605');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, '606');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, '607');
            } else {
                strQuery = mysqli.mysqli($mysqli, '608');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '609');


        }
    } else if (status == 2) {


        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks + limit + order);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, '610');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, '611');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, '612');
            } else {
                strQuery = mysqli.mysqli($mysqli, '613');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            console.log(to_date);
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '614');


        }

    } else if (status == 3) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, '615');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, '616');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, '617');
            } else {
                strQuery = mysqli.mysqli($mysqli, '618');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '619');

        }


    } else if (status == 4) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, '620');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, '621');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, '622');
            } else {
                strQuery = mysqli.mysqli($mysqli, '623');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '624');

        }


    }

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;

}

exports.csvBuyerRep = function (req, mysql, q, status) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};

    var limit = '';
    if (req.body.limit_results != '') {
        limit += 'limit 0,' + req.body.limit_results;
    } else {

        limit += '';
    }
    var order = "order by id " + req.body.orderradio;


    $mysqli = { limit: limit, order: order };

    if (status == 1) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, '625');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, '626');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, '627');
            } else {
                strQuery = mysqli.mysqli($mysqli, '628');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '629');


        }
    } else if (status == 2) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, '630');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, '631');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, '632');
            } else {
                strQuery = mysqli.mysqli($mysqli, '633');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '634');

        }


    } else {

    }

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.csvAdsRep = function (req, mysql, q, status) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};

    var limit = '';
    if (req.body.limit_results != '') {
        limit += 'limit 0,' + req.body.limit_results;
    } else {

        limit += '';
    }
    var order = "order by id " + req.body.orderradio;


    $mysqli = { limit: limit, order: order };

    if (status == 1) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, 'ads_day');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, 'ads_week');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, 'ads_month');
            } else {
                strQuery = mysqli.mysqli($mysqli, 'ads_year');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '629');


        }
    } else if (status == 2) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, '630');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, '631');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, '632');
            } else {
                strQuery = mysqli.mysqli($mysqli, '633');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '634');

        }


    } else {

    }

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.csvRiskRep = function (req, mysql, q, status) {

    $mysqli = {};

    var defered = q.defer();

    var limit = '';

    if (req.body.limit_results != '') {
        limit += 'limit 0,' + req.body.limit_results;
    } else {
        limit += '';
    }

    var order = "order by id " + req.body.orderradio;

    $mysqli = { limit: limit, order: order };

    if (status == 1) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            // console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, 'risk_day');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, 'risk_week');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, 'risk_month');
            } else {
                strQuery = mysqli.mysqli($mysqli, 'risk_year');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '629');

        }
    } else if (status == 2) {

        if (req.body.optionsRadios == 'fixed') {

            var checks = req.body.rangepast;
            console.log(checks);
            if (checks == 'day') {
                strQuery = mysqli.mysqli($mysqli, '630');
            } else if (checks == 'week') {
                strQuery = mysqli.mysqli($mysqli, '631');
            } else if (checks == 'month') {
                strQuery = mysqli.mysqli($mysqli, '632');
            } else {
                strQuery = mysqli.mysqli($mysqli, '633');
            }

            var escape_data = [];
        } else {

            var from_date = req.body.fromdate;
            var to_date = req.body.todate;
            var escape_data = [from_date, to_date];
            strQuery = mysqli.mysqli($mysqli, '634');

        }


    } else {

    }

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.csvCommissionRep = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    console.log(checks);

    var limit = '';
    if (req.body.limit_results != '') {
        limit += 'limit 0,' + req.body.limit_results;
    } else {
        limit += '';
    }
    var order = "order by b.id " + req.body.orderradio;


    $mysqli = { limit: limit, order: order };
    if (req.body.optionsRadios == 'fixed') {

        var checks = req.body.rangepast;
        console.log(checks);
        if (checks == 'day') {
            strQuery = mysqli.mysqli($mysqli, '635');
        } else if (checks == 'week') {
            strQuery = mysqli.mysqli($mysqli, '636');
        } else if (checks == 'month') {
            strQuery = mysqli.mysqli($mysqli, '637');
        } else {
            strQuery = mysqli.mysqli($mysqli, '638');
        }

        var escape_data = [];
    } else {

        var from_date = req.body.fromdate;
        var to_date = req.body.todate;
        var escape_data = [from_date, to_date];
        strQuery = mysqli.mysqli($mysqli, '639');


    }
    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}


/* This Section is reports  **Ends Here**   */



/* Notifaication Starts Here  */

exports.notifications = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, '650');

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;


}


/* Notification Ends Here*/

exports.deletereferral = function (req, mysql, q, id) {
    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [id];
    strQuery = mysqli.mysqli($mysqli, 847);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.checkReferral = function (rid, ruid, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    var escape_data = [rid, ruid];
    strQuery = mysqli.mysqli($mysqli, 'get_refer_details');

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    })

    return defered.promise;

}
exports.getLoggedguest = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 1003);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.getLoggeduser = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 1004);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.getDefaultCurrency = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = ['default'];
    strQuery = mysqli.mysqli($mysqli, 1100);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.getCustomCurrency = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 1101);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.updatecurrency = function (req, mysql, q, id) {
    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [id];
    strQuery = mysqli.mysqli($mysqli, 1102);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.deactiveallcurrency = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 1103);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.updateCurrencyrate = function (req, mysql, q, id, rate) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [rate, id];
    strQuery = mysqli.mysqli($mysqli, 1106);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.csvLanguagePhrases = function (req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 'get_all_thephrases');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.update_language_phrase = function (req, mysql, q, dataArray) {
    console.log(dataArray);
    $mysqli = {};
    $mysqli = { clname: dataArray['lang_column'] };
    var defered = q.defer();

    var escape_data = [dataArray['words'], dataArray['phrase'], dataArray['group_id']];
    strQuery = mysqli.mysqli($mysqli, 'update_phrases');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    return defered.promise;

}
exports.checkseourl = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    var escape_data = [req.body.page_url.trim()];
    strQuery = mysqli.mysqli($mysqli, 'get_seo_url');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}


exports.addseo = function (req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    var escape_data = [req.body.page_name, req.body.page_url.trim(), req.body.meta_title, req.body.meta_desc, ''];
    strQuery = mysqli.mysqli($mysqli, 'add_seo');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.getseo = function (req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 'get_added_seo');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.getseobyid = function (req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [id];
    strQuery = mysqli.mysqli($mysqli, 'get_seo_by_id');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.editseobyid = function (req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [req.body.page_name, req.body.page_url, req.body.meta_title, req.body.meta_desc, '', id];
    strQuery = mysqli.mysqli($mysqli, 'edit_seo_by_id');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.deleteseobyid = function (req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    var escape_data = [id];
    strQuery = mysqli.mysqli($mysqli, 'delete_seo_by_id');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.selectMaxStoreCategory = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 'select_max_length');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.maxStoreCategoryLength = function (req, mysql, q) {
    var max_length = (typeof (req.body.length) != 'undefined') ? req.body.length : 0;
    var id = (typeof (req.body.id) != 'undefined') ? req.body.id : 0;
    $mysqli = {};
    var defered = q.defer();
    if (id > 0) {
        var escape_data = [max_length, id];
        strQuery = mysqli.mysqli($mysqli, 'update_max_length');
    } else {
        var escape_data = [max_length];
        strQuery = mysqli.mysqli($mysqli, 'insert_max_length');
    }
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.SaveStoreCategoryids = function (req, mysql, q) {
    var storeids = (typeof (req.body.storeids) != 'undefined') ? req.body.storeids : 0;
    var id = (typeof (req.body.id) != 'undefined') ? req.body.id : 0;
    $mysqli = {};
    var defered = q.defer();
    if (id > 0) {
        var escape_data = [storeids, id];
        strQuery = mysqli.mysqli($mysqli, 'update_max_length2');
    } else {
        var escape_data = [storeids];
        strQuery = mysqli.mysqli($mysqli, 'insert_max_length2');
    }
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.select_all_store = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 'select_all_store');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.deactivatePrimaryStore = function (req, mysql, q) {
    $mysqli = { 'where': ' show_homepage="0"' };
    var defered = q.defer();
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 'update_primary_store');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    return defered.promise;
}
exports.activatePrimaryStore = function (req, mysql, q) {
    var selected_ids = (typeof (req.body.selected_ids) != 'undefined') ? req.body.selected_ids : 0;
    $mysqli = { 'where': ' show_homepage="1" WHERE id in(' + selected_ids + ')' };
    var defered = q.defer();
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 'update_primary_store');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    return defered.promise;
}
exports.saveStoreSubscription = function (req, mysql, q) {
    var title = (typeof (req.body.title) != 'undefined') ? req.body.title : '';
    var description = (typeof (req.body.description) != 'undefined') ? req.body.description : 'store';
    var amount = (typeof (req.body.amount) != 'undefined') ? req.body.amount : '0';
    var online = (typeof (req.body.online) != 'undefined') ? req.body.online : '0';
    var inperson = (typeof (req.body.inperson) != 'undefined') ? req.body.inperson : '0';
    var store = (typeof (req.body.store) != 'undefined') ? Number(req.body.store) : 0;
    var product = (typeof (req.body.product) != 'undefined') ? Number(req.body.product) : 0;
    var category = (typeof (req.body.category) != 'undefined') ? Number(req.body.category) : 0;
    var liveauction = (typeof (req.body.liveauction) != 'undefined') ? Number(req.body.liveauction) : 0;
    var filestorage = (typeof (req.body.filestorage) != 'undefined') ? req.body.filestorage : "";
    var storagetype = (typeof (req.body.storagetype) != 'undefined') ? req.body.storagetype : "";
    var shipstation = (typeof (req.body.shipstation) != 'undefined') ? req.body.shipstation : "";
    var shippinglabel = (typeof (req.body.shippinglabel) != 'undefined') ? req.body.shippinglabel : "no";
    var support = (typeof (req.body.support) != 'undefined') ? req.body.support : "no";
    var fraudanalysis = (typeof (req.body.fraudanalysis) != 'undefined') ? req.body.fraudanalysis : "no";
    var ordercreation = (typeof (req.body.ordercreation) != 'undefined') ? req.body.ordercreation : "no";
    var discount = (typeof (req.body.discount) != 'undefined') ? req.body.discount : "no";
    var websiteblog = (typeof (req.body.websiteblog) != 'undefined') ? req.body.websiteblog : "no";
    var ssl = (typeof (req.body.ssl) != 'undefined') ? req.body.ssl : "no";
    var giftcard = (typeof (req.body.giftcard) != 'undefined') ? req.body.giftcard : "no";
    var proreports = (typeof (req.body.proreports) != 'undefined') ? req.body.proreports : "no";
    var cartrecovery = (typeof (req.body.cartrecovery) != 'undefined') ? req.body.cartrecovery : "no";
    var reportbuilder = (typeof (req.body.reportbuilder) != 'undefined') ? req.body.reportbuilder : "no";
    var shippingrates = (typeof (req.body.shippingrates) != 'undefined') ? req.body.shippingrates : "no";
    var customizationhours = (typeof (req.body.customizationhours) != 'undefined') ? req.body.customizationhours : "";
    var status = (typeof (req.body.status) != 'undefined') ? req.body.status : "active";
    var planid = (typeof (req.body.planid) != 'undefined') ? req.body.planid : "";
    var addcoding = (typeof (req.body.addcoding) != 'undefined') ? req.body.addcoding : "";
    var subid = (typeof (req.body.subid) != 'undefined') ? req.body.subid : "0";

    $mysqli = {};
    var defered = q.defer();
    if (subid == 0) {

        // var escape_data = [title, amount, type, status, counts, planid, datetype];
        var escape_data = [title, description, amount, online, inperson, store, product, category, liveauction, filestorage, storagetype, shipstation, shippinglabel, support, fraudanalysis, ordercreation, discount, websiteblog, ssl, giftcard, proreports, cartrecovery, reportbuilder, shippingrates, customizationhours, addcoding, status, planid]
        strQuery = mysqli.mysqli($mysqli, 'insertPlanList');
    } else {
        // var escape_data = [title, amount, type, status, counts, planid, datetype, subid];
        var escape_data = [title, description, amount, online, inperson, store, product, category, liveauction, filestorage, storagetype, shipstation, shippinglabel, support, fraudanalysis, ordercreation, discount, websiteblog, ssl, giftcard, proreports, cartrecovery, reportbuilder, shippingrates, customizationhours, addcoding, status, planid, subid]
        strQuery = mysqli.mysqli($mysqli, 'updatePlanList');
    }
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    console.log('------------------------------------');
    return defered.promise;
}
exports.getStoreSubscription = function (req, mysql, q) {
    $mysqli = { fields: ' * ', where: '' };
    var defered = q.defer();
    var escape_data = [];
    strQuery = mysqli.mysqli($mysqli, 'getStorePlanlist');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.deleteStoreSubscription = function (req, mysql, q) {
    var id = (typeof (req.body.plid) != 'undefined') ? Number(req.body.plid) : 0;
    $mysqli = {};
    var defered = q.defer();
    var escape_data = [id];
    strQuery = mysqli.mysqli($mysqli, 'deleteStorePlanList');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}


exports.getAllRecurrings = function (req, mysql, q, count) {

    where = '';
    var whr1 = '';
    if (req.body.country !== '' && req.body.state !== '') {
        whr1 = whr1 + ' and rp.user_id in (select user_id from user_extras where state = "' + req.body.state + '")  ';
    } else if (req.body.country !== '') {
        whr1 = whr1 + ' and rp.user_id in (select user_id from user_extras where country = "' + req.body.country + '")  ';
    }
    var dateFormat = require('dateformat');
    if (typeof (req.param('from_date')) !== 'undefined' && req.param('from_date') != '') {
        date1 = dateFormat(new Date(req.param('from_date')), 'yyyy-mm-dd');
        where += ' and rp.date_added >= "' + date1 + ' 00:00:00"';
    }
    if (typeof (req.param('to_date')) !== 'undefined' && req.param('to_date') != '') {
        date2 = dateFormat(new Date(req.param('to_date')), 'yyyy-mm-dd');
        where += ' and rp.date_added <= "' + date2 + ' 23:59:59"';
    }
    var whr = ' ';
    // uids = [];
    var uids = typeof (req.body.uids) == 'undefined' ? [] : req.body.uids;

    console.log("uids ------ ", uids);

    var str = '';
    for (var i = 0; i < uids.length; i++) {
        if (i == 0) {
            str = str + '(' + uids[i];
            if ((uids.length - 1) == 0) {
                str = str + uids[i] + ')';
            }
        } else if (i == (uids.length - 1)) {
            str = str + uids[i] + ')';
        } else {
            str = str + uids[i] + ', ';
        }
    }

    if (uids.length > 0) {
        whr = " and rp.user_id in " + str + " ";
    }

    $mysqli = { whr: whr, whr1: whr1, where: where };

    // datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    if (count == 0)
        strQuery = mysqli.mysqli($mysqli, 'get_recur_list');
    else if (count == 1)
        strQuery = mysqli.mysqli($mysqli, 'get_recur_list_count');

    //console.log(strQuery);
    var defered = q.defer();

    var escape_data = [(req.body.page - 1) * req.body.limit, req.body.limit];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;
}


exports.adminRecCancelApproval = function (req, mysql, q, id) {

    $mysqli = {};

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'admin_cancel_approval');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [datge, datge, id];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    return defered.promise;
}

exports.getPartialUData = function (req, mysql, q, ids) {

    $mysqli = { ids: '' };

    var str = '';
    if (ids.length > 0) {
        if (ids.length > 1) {
            for (var i = 0; i < ids.length; i++) {
                if (i == 0) {
                    str = str + 'where ue.user_id  in (' + ids[i]
                    if (ids.length > 1) {
                        str = str + ',';
                    }
                } else if (i == (ids.length - 1)) {
                    str = str + ids[i] + ')';
                } else {
                    str = str + ids[i] + ', ';
                }
            }
        } else {
            str = str + 'where ue.user_id  in (' + ids[0] + ')';
        }

    }

    $mysqli = { ids: str };

    console.log("str here-------------------" + str);

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'get_partial_udata');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [ids];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    //console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

// admin.removeAllProducts(req, config.mysql, q, req.body.id), 
// admin.rejectAllPrdtRequests(req, config.mysql, q, req.body.id), 
// admin.removeAllAdwords(req, config.mysql, q, req.body.id), 
// admin.rejectAllRecurrings(req, config.mysql, q, req.body.id)

exports.removeAllProducts = function (req, mysql, q, userId) {

    $mysqli = {};

    // console.log("str here-------------------" + str);

    strQuery = mysqli.mysqli($mysqli, 'remove_all_products');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [userId];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

exports.rejectAllRecurrings = function (req, mysql, q, userId) {

    $mysqli = {};


    // console.log("str here-------------------" + str);

    strQuery = mysqli.mysqli($mysqli, 'remove_all_recurring');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [userId];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

exports.removeAllAdwords = function (req, mysql, q, userId) {

    $mysqli = {};

    // console.log("str here-------------------" + str);
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'remove_all_adwords');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [datge, userId];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

exports.rejectAllPrdtRequests = function (req, mysql, q, userId) {

    $mysqli = {};

    // console.log("str here-------------------" + str);
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'reject_all_prdtrequest');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [datge, userId];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

/* ===================== start change by divyesh (added) ===================== */
exports.getAllConsultantodes = function (req, mysql, q, userId) {
    const defered = q.defer();
    $mysqli = { where: req.body.whereCondition };
    strQuery = mysqli.mysqli($mysqli, 'get_consultant_codes');
    query = mysql.query(strQuery, null, defered.makeNodeResolver());
    return defered.promise;
}


exports.saveConsultantCode = function (req, mysql, q, userId) {
    const defered = q.defer();
    $mysqli = { valuesData: req.body.valuesData };
    strQuery = mysqli.mysqli($mysqli, 'save_consultant_code');
    query = mysql.query(strQuery, null, defered.makeNodeResolver());
    return defered.promise;
}

exports.deleteConsultantCode = function (req, mysql, q, userId) {
    const defered = q.defer();
    $mysqli = { whereCondition: req.body.whereCondition };
    strQuery = mysqli.mysqli($mysqli, 'delete_consultant_code');
    query = mysql.query(strQuery, null, defered.makeNodeResolver());
    return defered.promise;
}


exports.getSpecificConsultantCode = function (req, mysql, q, userId) {
    const defered = q.defer();
    $mysqli = { whereCondition: req.body.whereCondition };
    strQuery = mysqli.mysqli($mysqli, 'get_specific_consultant_code');
    query = mysql.query(strQuery, null, defered.makeNodeResolver());
    return defered.promise;
}

exports.updateSpecificConsultantCode = function (req, mysql, q, userId) {
    const defered = q.defer();
    $mysqli = { whereCondition: req.body.whereCondition, updateCondition: req.body.updateCondition };
    strQuery = mysqli.mysqli($mysqli, 'update_specific_consultant_code');
    query = mysql.query(strQuery, null, defered.makeNodeResolver());
    return defered.promise;
}

exports.getMembersBySalesAdmin = function (req, mysql, q, userId, fieldNames, whereCondition) {
    const defered = q.defer();
    $mysqli = { select_field: fieldNames, where: whereCondition };
    strQuery = mysqli.mysqli($mysqli, 'getMembersBySalesAdmin');
    query = mysql.query(strQuery, null, defered.makeNodeResolver());
    return defered.promise;
}

exports.updateUserConsultantCodeFee = function (req, mysql, q) {
    const defered = q.defer();
    $mysqli = { whereCondition: req.body.whereCondition, updateCondition: req.body.updateCondition };
    strQuery = mysqli.mysqli($mysqli, 'updateUserConsultantCodeFee');
    query = mysql.query(strQuery, null, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;
}

exports.getSalesTransactions = function (req, mysql, q, count) {
    var dateFormat = require('dateformat');

    console.log(req.param('status'));

    where = ' and i.type="bought" AND seller_ss.sc_user_id=' + req.session.login_userid + ' AND (date_format(i.date_added,"%m/%d/%Y %H:%i") > date_format(seller_ss.start_date,"%m/%d/%Y %H:%i") AND date_format(i.date_added,"%m/%d/%Y %H:%i") < date_format(seller_ss.end_date,"%m/%d/%Y %H:%i") )';

    req.body.country = (typeof (req.param('country')) !== 'undefined') ? req.param('country') : '';
    req.body.state = (typeof (req.param('state')) !== 'undefined') ? req.param('state') : '';
    if (req.body.country != '' && req.body.state != '') {
        where += ' and i.user_id in (select user_id from user_extras where state = "' + req.body.state + '")  ';
    } else if (req.body.country != '') {
        where += ' and i.user_id in (select user_id from user_extras where country = "' + req.body.country + '")  ';
    }
    if (typeof (req.param('from_date')) !== 'undefined' && req.param('from_date') != '') {
        date1 = dateFormat(new Date(req.param('from_date')), 'yyyy-mm-dd');
        where += ' and i.date_added >= "' + date1 + ' 00:00:00"';
    }
    if (typeof (req.param('to_date')) !== 'undefined' && req.param('to_date') != '') {
        date2 = dateFormat(new Date(req.param('to_date')), 'yyyy-mm-dd');
        where += ' and i.date_added <= "' + date2 + ' 23:59:59"';
    }
    req.body.status = (typeof (req.param('status')) !== 'undefined') ? req.param('status') : '';

    if (req.body.status != '') {
        where += 'and i.istatus like "%' + req.body.status + '%"'
    }

    req.body.invoice_id = (typeof (req.param('invoice_id')) !== 'undefined') ? req.param('invoice_id') : 0;
    if (req.body.invoice_id > 0) {
        where += 'and i.id  like "%' + req.body.invoice_id + '%"'
    }
    req.body.projecttit = (typeof (req.param('projecttit')) !== 'undefined') ? req.param('projecttit') : '';
    if (req.body.projecttit != '') {
        where += 'and p.title  like "%' + req.body.projecttit + '%"'
    }
    /* req.body.type = (typeof (req.param('type')) !== 'undefined') ? req.param('type') : '';
    if (req.body.type != '') {
        where += 'and i.type  like "%' + req.body.type + '%"'
    } */

    var sort = req.param('sort')!=undefined ? req.param('sort') : 'i.id';
    var direction = req.param('direction')!=undefined ? req.param('direction') : 'asc';
    var orderby = 'order by ' + sort +' ' + direction;
    console.log('orderby', orderby);

    var limit = ' LIMIT ' + ((req.body.page - 1) * 10) + ', 10';
    var escape_data = [];
    mysq = 'getSalesTransactions';
    if(count == 2) {    // for download
        limit = '';
    }
    $mysqli = { where: where, limit: limit, orderby: orderby };
    if (count == 0) {   // for count
        mysq = 'getSalesTransactionsCount';
        escape_data = [];
    }

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('getSalesTransactions ', query.sql);
    query.on('error', function (err) {
        throw err;
    })

    return defered.promise;
}
exports.getBehalfUsers = function (req, mysql, q, userId) {
    const defered = q.defer();
    $mysqli = { where: req.body.whereCondition };
    strQuery = mysqli.mysqli($mysqli, 'getBehalfUsers');
    query = mysql.query(strQuery, null, defered.makeNodeResolver());
    console.log('getBehalfUsers ', query.sql);
    return defered.promise;
}

exports.getPurchaseHistory = function (req, mysql, q, count) {
    var dateFormat = require('dateformat');

    mysq = 'getPurchaseHistory';
    where = ' AND pr.behalf_cc_id>0 AND cc.created_by=' + req.session.login_userid;
    if (req.body.market == 'open') {
        where += 'and p.auction = 1';
    }
    if (req.body.market == 'direct') {
        where += 'and p.auction = 0';
    }
    if (req.body.market == 'recurring') {
        where += 'and b.recurring = "1"';
    }

    req.body.country = (typeof (req.param('country')) !== 'undefined') ? req.param('country') : '';
    req.body.state = (typeof (req.param('state')) !== 'undefined') ? req.param('state') : '';
    if (req.body.country != '' && req.body.state != '') {
        where += ' and i.user_id in (select user_id from user_extras where state = "' + req.body.state + '")  ';
    } else if (req.body.country != '') {
        where += ' and i.user_id in (select user_id from user_extras where country = "' + req.body.country + '")  ';
    }
    if (typeof (req.param('from_date')) !== 'undefined' && req.param('from_date') != '') {
        date1 = dateFormat(new Date(req.param('from_date')), 'yyyy-mm-dd');
        where += ' and i.date_added >= "' + date1 + ' 00:00:00"';
    }
    if (typeof (req.param('to_date')) !== 'undefined' && req.param('to_date') != '') {
        date2 = dateFormat(new Date(req.param('to_date')), 'yyyy-mm-dd');
        where += ' and i.date_added <= "' + date2 + ' 23:59:59"';
    }
    req.body.status = (typeof (req.param('status')) !== 'undefined') ? req.param('status') : '';

    if (req.body.status != '') {
        where += 'and i.istatus like "%' + req.body.status + '%"'
    }

    req.body.invoice_id = (typeof (req.param('invoice_id')) !== 'undefined') ? req.param('invoice_id') : 0;
    if (req.body.invoice_id > 0) {
        where += 'and i.id  like "%' + req.body.invoice_id + '%"'
    }
    req.body.projecttit = (typeof (req.param('projecttit')) !== 'undefined') ? req.param('projecttit') : '';
    if (req.body.projecttit != '') {
        where += 'and p.title  like "%' + req.body.projecttit + '%"'
    }
    req.body.type = (typeof (req.param('type')) !== 'undefined') ? req.param('type') : '';
    if (req.body.type != '') {
        where += 'and i.type  like "%' + req.body.type + '%"'
    }

    if (req.body.tax_filter != '') {
        if(req.body.tax_filter == 'distribution'){
            where += ' and b.distribution_tax > 0 '
        } else if(req.body.tax_filter == 'cultivation') {
            where += ' and b.cultivation_tax > 0 '
        } else if(req.body.tax_filter == 'excise'){
            where += ' and b.excise_tax_amt > 0 '
        } else {
            where += '';   
        }
    }

    
    var escape_data = [];
    var limit = ' limit '+((req.body.page - 1) * 10)+', 10';
    $mysqli = { where: where, limit: limit };

    if (count == 0) {
        mysq = 'getPurchaseHistory_c';
    }
    console.log('limit', limit);
    

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('getPurchaseHistory ', query.sql);
    query.on('error', function (err) {
        throw err;
    })

    return defered.promise;
}

exports.addrecurring = function(req, res, mysql) {

    console.log("exports.addrecurring : " + req.body.cancellation_per);

    var cmn = require('./common');
    var dateMath = require('date-arithmetic');

    /* months week and year management here using 'weekly'-1,'biweekly'-2,'monthly'-1,'quaterly'-3,'bianually'-6,'anually'-12*/
    var obj = cmn.validateDates(req.param('frequency'));

    var start_date = new Date(req.param('sdate'));
    console.log(start_date);
    var end_date = dateMath.add(new Date(start_date), ((parseInt(req.param('edate')) * parseInt(obj.count)) - 1), obj.str);
    console.log(end_date);

    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'addrecurre');

    var defered = q.defer();

    var escape_data = [
        req.param('buserid'),
        req.param('project_id'),
        datenow,
        req.param('frequency'), //frequencies
        req.param('rqty'),
        dateFormat(start_date, "yyyy-mm-dd HH:MM:ss"),
        req.param('edate'), //count
        dateFormat(end_date, "yyyy-mm-dd HH:MM:ss"),
        req.param('insurance'),
        req.session.ntemp_cart_id,
        req.body.cancellation_per
    ];

    // console.log("addrecurring6");
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;

}

exports.addItem = function(id, req, res, mysql) {
    console.log(req.session);
    membership_status = true;
    req.body.id = id;
    var self = this;
    var cmn = require('./common');

    if (typeof(req.session.userid) === 'undefined') {
        var data = { success: false, error: '', redirect: true };
        cmn.renderJson(res, data);
    }
    if (typeof(req.session.userid) === 'undefined') {
        var data = { success: false, error: '', redirect: true };
        cmn.renderJson(res, data);
    }

    q.all([products.productDetail(req, mysql, q)]).then(function(results) {
        try {
            var prdt = products.shortDescribe(results[0][0]);
            prdt = prdt[0];
            //console.log(prdt);console.log("uiuiuiuiuiu");
            //prdt.qty_add = 1;
            var dateFormat = require('dateformat');
            // console.log("a1");
            var date = require('date-utils');
            // console.log("b1");
            // console.log(req.param('qty'));
            prdt['qty_add'] = (typeof(req.param('qty')) !== 'undefined') ? req.param('qty') : 1;
            // console.log("c1");
            // console.log(prdt['qty_add']);

            /* Update payment details here */
            var freq = prdt['frequency'];
            // console.log("-----------------prdt id -------------> : " + prdt['id']);

            var end = new Date(prdt['edate']);
            var start = new Date(prdt['sdate']);
            var duration = prdt['count'];

            var calfee = parseFloat(prdt['bprice']) * parseFloat(global.general.cancel_insurance_fee) / 100;
            // console.log("-------" + global.general.cancel_insurance_fee + "----------calfee-------------> : " + calfee);

            // console.log("-----------------prdt['qty_add']-------------> : " + prdt['qty_add']);

            var herbeefee = parseFloat(prdt['bprice']) * parseFloat(global.general.commission_fee) / 100;
            // console.log("--------" + global.general.commission_fee + "---------herbeefee-------------> : " + herbeefee);

            var stax = parseFloat(prdt['bprice']) * parseFloat(prdt['stax']) / 100;

            var consultant_fee_amount = parseFloat(prdt['consultant_fee_amount']);
            // console.log("--------" + prdt['stax'] + "---------tax-------------> : " + stax);

            /* calculating distribution tax percentage - will be deducted from seller side */
            var prdtTotalAmount = (parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add']));
            var distribution_tax = 0;
            var distribution_tax_per = 0;


            if(global.general.distribution_rate_status == 'yes' && escape(prdt.default_distributor).toLowerCase() == 'y'){
                distribution_tax_per = parseFloat(global.general.distribution_rate);
                distribution_tax = parseFloat(prdtTotalAmount) * parseFloat(global.general.distribution_rate)/100
                if(distribution_tax > parseFloat(global.general.distribution_default_rate)){
                    distribution_tax = parseFloat(global.general.distribution_default_rate)
                }
            } 


            /* Calculating excise tax */
            var excise_tax_markup = 0
            var excise_markup_per = 0
            var excise_tax = 0
            var excise_tax_per = 0


            /* calculating excise markup value and percentage */
/*  
    excise_tax_status == yes and If 
    default_distributor == 'y' and 
    buisness_type == 'dispensary' and
    product type is flower or edibles 
    then excise tax should be charge 
*/
console.log("-------------excise tax changes here----------------");
console.log(global.general.excise_tax_status)
console.log(escape(prdt.default_distributor).toLowerCase())
console.log(req.session.business_type)
console.log(escape(prdt.pc_name).toLowerCase())
console.log("-------------excise tax changes here----------------");
console.log("-------------Calculate excise tax ----------------",(global.general.excise_tax_status == 'yes' && escape(prdt.default_distributor).toLowerCase() == 'y' && req.session.buisness_type == 'dispensary' &&(escape(prdt.pc_name).toLowerCase() == 'flower' || escape(prdt.pc_name).toLowerCase() == 'edibles')));


            if(global.general.excise_tax_status == 'yes' && escape(prdt.default_distributor).toLowerCase() == 'y' && req.session.business_type == 'dispensary' &&(escape(prdt.pc_name).toLowerCase() == 'flower' || escape(prdt.pc_name).toLowerCase() == 'edibles')){
            // if(global.general.excise_tax_status == 'yes'){
                /* calculating markup value */
                excise_markup_per = parseFloat(global.general.excise_tax_markup);
                excise_tax_markup = parseFloat(parseFloat(prdtTotalAmount) * (parseFloat(global.general.excise_tax_markup)/100)).toFixed(2);
                // console.log("excise_tax markeup value --- "+excise_tax);
                // console.log("total amount --- "+parseFloat(prdtTotalAmount));

                /* calculating excise tax percentage and value */
                excise_tax_per = parseFloat(global.general.excise_tax)
                excise_tax = parseFloat((parseFloat(prdtTotalAmount) + parseFloat(excise_tax_markup)) * (parseFloat(global.general.excise_tax)/100)).toFixed(2);
            } else {
                excise_markup_per = 0;
                excise_tax_markup = 0;
                excise_tax_per = 0;
                excise_tax = 0;
            }

            /* calculating cultivation tax */
            var cultivation_tax = 0
            var cultivation_tax_per = 0
            /* calculating cultivation tax percentage  - will be deducted from seller side */
            if(escape(prdt.cultivation_tax_status).toLowerCase() == 'n'){
                if(escape(prdt.pc_name).toLowerCase() == 'flower'){
                    if(global.general.cultivation_tax_status == 'yes'){
                        cultivation_tax = parseFloat(global.general.cultivation_tax) * parseFloat(prdt['qty_add']);
                        cultivation_tax_per = parseFloat(global.general.cultivation_tax);
                    }
                } else if(escape(prdt.pc_name).toLowerCase() == escape('Trim/Cannabis Leaves').toLowerCase()){
                    if(global.general.trim_tax_status == 'yes'){
                        cultivation_tax = parseFloat(global.general.trim_tax) * parseFloat(prdt['qty_add']);
                        cultivation_tax_per = parseFloat(global.general.trim_tax);
                    }
                }
            }

            // console.log("--------" + prdt['stax'] + "---------tax-------------> : " + stax);
            var totalAmount = (parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add'])) + (parseFloat(prdt['qty_add']) * parseFloat(herbeefee)) + (parseFloat(prdt['qty_add']) * parseFloat(stax)) + (parseFloat(prdt['qty_add']) * parseFloat(consultant_fee_amount)) + parseFloat(excise_tax);
            
            // console.log("---" + (parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add'])) + "-----" + (parseFloat(prdt['qty_add']) * herbeefee) + "-----" + (parseFloat(prdt['qty_add']) * stax) + "----totalAmount-------------> : " + totalAmount);
            if (prdt.rec_cancel_ins == 1) {
                totalAmount = totalAmount + (parseFloat(prdt['qty_add']) * calfee);
            }

            if (typeof(req.param('recupur')) !== 'undefined') {

                prdt.rec_purchase = req.param('recupur');
                prdt.rec_cancel_ins = req.param('insurance');
                prdt.rec_frequency = req.param('frequency');
                prdt.rec_count = req.param('edate');
                prdt.rec_purchase_id = req.body.rec_id;

                if (prdt.rec_cancel_ins == 1) {
                    prdt.rec_reserve_price = 0;
                    // prdt.rec_reserve_price = ((((parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add'])) * parseFloat(prdt.rec_count))) / 2);
                    // totalAmount = totalAmount + (parseFloat(prdt['qty_add']) * calfee);
                } else {
                    // prdt.rec_reserve_price = ((((parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add'])) * parseFloat(prdt.rec_count))));
                    prdt.rec_reserve_price = 0;
                }

                /* (15 * 2 * 2 ) -  */
                totalAmount = parseFloat(totalAmount) + parseFloat(prdt.rec_reserve_price);
                prdt.rec_start_date = req.body.rec_start_date;
                prdt.rec_end_date = req.body.rec_end_date;
                prdt.rec_user_id = req.body.rec_user_id;
                prdt.rec_date_added = req.body.rec_date_added;
                prdt.rec_paid = req.body.rec_paid;
                prdt.rec_active = req.body.rec_active;

            }


            prdt['prdt_stax'] = stax;
            prdt['prdt_total_amount'] = totalAmount;
            prdt['prdt_total_amountr'] = prdtTotalAmount;
            prdt['prdt_herbee_fee'] = herbeefee;
            prdt['pdt_cancel_fee'] = calfee;
            console.log('prdt', prdt);

            prdt['distribution_tax'] = distribution_tax;
            prdt['distribution_tax_per'] = distribution_tax_per;

            prdt['excise_tax_markup'] = excise_tax_markup;
            prdt['excise_markup_per'] = excise_markup_per;
            prdt['excise_tax'] = excise_tax;
            prdt['excise_tax_per'] = excise_tax_per;

            prdt['cultivation_tax'] = cultivation_tax;
            prdt['cultivation_tax_per'] = cultivation_tax_per;
            /* End */

            prdt['qty'] = parseInt(prdt['qty']);
            prdt['booked'] = parseInt(prdt['booked']);
            prdt['sold'] = parseInt(prdt['sold']);
            prdt['qty_add'] = parseInt(prdt['qty_add']);

            prdt['shipping_price'] = common.currencyConverter(prdt['shipping_price']);
            prdt['bprice'] = common.currencyConverter(prdt['bprice']);
            // console.log("d1");
            var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

            // console.log("e1");
            var closeddate = dateFormat(new Date(prdt['date_closed']), "yyyy-mm-dd HH:MM:ss");
            var k_l = false;
            // console.log("f1");
            if (typeof(req.session.pid) !== 'undefined') {

                if (req.session.pid.indexOf(prdt.id) >= 0) {
                    var k_l = true;
                }
            }
            // console.log("g1");
            //prdt['m_qty_add'] = prdt['qty_add'];
            if (typeof(req.session.pid) !== 'undefined') {
                if (req.session.pid.indexOf(prdt.id) >= 0) {

                    prdt['booked'] = prdt['booked'] - parseInt(req.session.products[req.session.pid.indexOf(prdt.id)]['qty_add']);

                }
            }
            // console.log("h1");
            if (prdt['market_status'] == 'closed') {
                var data = { success: false, error: 'Project Ended!' };
                cmn.renderJson(res, data);
            }

            if ((Date.compare(closeddate, datenow) <= 0 ) && prdt['market_status'] == 'open' && !k_l) {
                var data = {success: false, error: 'Project Ended!'};
                cmn.renderJson(res, data);
            }
            else if (prdt['qty'] - prdt['sold'] - prdt['booked'] <= 0 && !k_l) {
                var data = {success: false, error: 'Project Sold!'};
                cmn.renderJson(res, data);
            }
            else if (prdt['qty'] - prdt['sold'] - prdt['booked'] - prdt['qty_add'] < 0 && !k_l) {
                var data = {
                    success: false,
                    error: parseInt(prdt['qty'] - prdt['sold'] - prdt['booked']) + ' Only Available !'
                };
                cmn.renderJson(res, data);
            }
            else {
                // console.log("i1");
                req.session.buynowcountyear = parseInt(req.session.buynowcountyear) + parseInt(prdt['qty_add']);
                req.session.buynowcountmonth = parseInt(req.session.buynowcountmonth) + parseInt(prdt['qty_add']);
                //membership_status =  common.checkLimitReached('monthly_buynow_limit',req);
                membership_status = true;
                // console.log("k1");
                if (membership_status) {
                    // console.log("l1");
                    if (typeof(req.session.pid) !== 'undefined') {
                        // console.log("m1");
                        if (req.session.pid.indexOf(prdt.id) >= 0) {
                            var mn_req_id = req.session.pid.indexOf(prdt.id);

                            admin.removeTempItem(req, mysql, q, id, req.session.products[mn_req_id]['qty_add']);
                             delete req.session.pid[mn_req_id];
                             delete req.session.products[mn_req_id];

                             req.session.pid = req.session.pid.filter(function (n) {
                                 return n != undefined
                             });
                             req.session.products = req.session.products.filter(function (n) {
                                 return n != undefined
                             });
                            // console.log(prdt);
                            // console.log("*********FFFFFFFFFFFFF***************");
                            // console.log(req.session);


                             if (req.session.pid.length == 0) {
                                 delete req.session.temp_cart_id;
                                 delete req.session.temp_time_id;
                                 delete req.session.pid;
                                 delete req.session.products;
                                 delete req.session.timer;
                                 req.session.pid = [];
                                 req.session.products = [];
                             }

                             admin.addTempItem(req, mysql, q, id, prdt['qty_add'], prdt);
                            req.session.pid.push(prdt.id);
                            req.session.products.push(prdt);
                            

                        } else {
                            admin.addTempItem(req, mysql, q, id, prdt['qty_add'], prdt);
                            req.session.pid.push(prdt.id);
                            req.session.products.push(prdt);
                        }

                    } else {
                        // console.log("tyyyyyyyyyyyyyyyyyelseigyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
                        // console.log(req.body);
                        // console.log("n1");
                        //req.session.temp_cart_id = Date.parse(new Date()) / 1000;
                        req.session.temp_cart_id = req.session.ntemp_cart_id;
                        //console.log(req.session);
                        var dateFormat = require('dateformat');
                        req.session.temp_time_id = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
                        admin.addTempItem(req, mysql, q, id, prdt['qty_add'], prdt);
                        req.session.pid = [];
                        req.session.products = [];
                        req.session.pid.push(prdt.id);
                        req.session.products.push(prdt);
                    }
                } else {
                    console.log("o1");
                    req.session.buynowcountyear = parseInt(req.session.buynowcountyear) - parseInt(prdt['qty_add']);
                    req.session.buynowcountmonth = parseInt(req.session.buynowcountmonth) - parseInt(prdt['qty_add']);
                }

                var data = { success: true, error: '', add: 1, membership_status: membership_status };
                cmn.renderJson(res, data);

            }
        } catch (e) {
            console.log("Add or removing cart error " + e.stack);
        }

    }).fail(function(error) {
        console.log(error.stack);
        throw error;
    }).done();

}
exports.removeTempItem = function(req, mysql, q, id, qty, r_id) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer4');
    req.session.buynowcountyear = parseInt(req.session.buynowcountyear) - parseFloat(qty);
    req.session.buynowcountmonth = parseInt(req.session.buynowcountmonth) - parseFloat(qty);


    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [r_id, id, req.param('buserid')];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })

    
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer3');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [qty, id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })
    return defered.promise;
}
exports.addTempItem = function(req, mysql, q, id, qty, prdt) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer1');
    console.log(2);
    var defered = q.defer();
    //var date = require('date-utils');
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [id, datenow, req.session.temp_cart_id, qty, 0, 0, req.param('buserid'), JSON.stringify(prdt)];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("f4f4f4f4f");
    console.log(query.sql);
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer2');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [qty, id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })
    return defered.promise;
}

exports.distributorUserProductSearch = function (req, mysql, q, count, where_new) {
    var dateFormat = require('dateformat');

    mysq = 74;
    var where = '';
    var where1 = '';
    var whr = '';
    var cols = '';

    if (req.body.country !== '' && req.body.state !== '') {
        whr = whr + ' and ue.country ="' + req.body.country + '" and ue.state = "' + req.body.state + '" ';
    } else if (req.body.country !== '' && req.body.state == '') {
        whr = whr + ' and ue.country ="' + req.body.country + '"';
    } else if (req.body.country == '' && req.body.state !== '') {
        whr = whr + ' and ue.state = "' + req.body.state + '" ';
    }

    if (typeof (req.param('from_date')) !== 'undefined' && req.param('from_date') != '') {
        date1 = dateFormat(new Date(req.param('from_date')), 'yyyy-mm-dd');
        where += ' and p.date_added >= "' + date1 + ' 00:00:00" ';
    }
    if (typeof (req.param('to_date')) !== 'undefined' && req.param('to_date') != '') {
        date2 = dateFormat(new Date(req.param('to_date')), 'yyyy-mm-dd');
        where += ' and p.date_added <= "' + date2 + ' 23:59:59" ';
    }

    where += (typeof (req.param('title')) !== 'undefined' && req.param('title') != '') ? ' and p.title like "%' + req.param('title') + '%" ' : where;
    where += (typeof (req.param('id')) !== 'undefined' && req.param('id') != '') ? ' and p.id = ' + req.param('id') : where;

    status = (typeof (req.param('action')) !== 'undefined' && req.param('action') != '') ? req.param('action') : '';

    date1 = dateFormat(new Date(), 'yyyy-mm-dd HH:MM:ss');

    where += ' and p.auction = 1 AND p.interim_testing_status="y" AND p.distributor_id='+req.session.userid;

    where += where_new;

    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $mysqli = { cols: cols, where: where, whr: whr, where1: where1 };

    if (req.body.page == '') {
        req.body.page = 1;
    }
    console.log('page', req.body.page);
    var escape_data = [];
    if (count == 0) {
        mysq = 73;
        escape_data = [(req.body.page - 1) * 10];
    }

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(" dssssssssf " + query.sql);

    query.on('error', function (err) {
        throw err;
    })

    //console.log("Admin product qry "+query.sql);
    return defered.promise;
}


/* ===================== Start code for HempBuyer ===================== */
exports.getUsers = function (req, mysql, q, count) {
    var where = '';
    if(req.body.from_date) {
        where += ' AND date_format(u.created_at, "%m-%d-%Y") >= date_format('+req.body.from_date+', "%m-%d-%Y")';
    }
    if(req.body.to_date) {
        where += ' AND date_format(u.created_at, "%m-%d-%Y") <= date_format('+req.body.to_date+', "%m-%d-%Y")';
    }
    if(req.body.username) {
        where += ' AND u.username LIKE "%'+req.body.username+'%"';
    }
    if(req.body.email) {
        where += ' AND u.email LIKE "%'+req.body.email+'%"';
    }
    if(req.body.status) {
        where += ' AND u.status LIKE "'+req.body.status+'"';
    }
    if(req.body.r_status) {
        if(req.body.r_status == 'h_referral') {
            where += ' AND u.refered_by=2';
        } else if(req.body.r_status == 'r_affiliate') {
            where += ' AND u.refered_by=4';
        } else {
            where += ' AND u.refered_by NOT IN(2,4)';
        }
    }
    if(req.body.state) {
        where += ' AND u.state LIKE "%'+req.body.state+'%"';
    }

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getUsers');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getUsers", query.sql);
    query.on('error', function (err) {
        console.log("Error in getUsers", err); 
    })
    return defered.promise;
}
exports.updateUsersStatus = function (req, mysql, q) {
    var where = '';
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'updateUsersStatus');
    var escape_data = [req.body.status, req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("updateUsersStatus", query.sql);
    query.on('error', function (err) {
        console.log("Error in updateUsersStatus", err); 
    })
    return defered.promise;
}

exports.getUserDetail = function(req, mysql, q, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getUserDetail');
    var defered = q.defer();
    var escape_data = [id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getUserDetail", query.sql);
    return defered.promise;
}
exports.changePassword = function (req, mysql, q) {
    var where = '';
    var password_salt = '12345'
    var password = md5(md5(req.body.password) + password_salt);
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'changePasswordByAdmin');
    var escape_data = [password, req.body.user_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("changePassword", query.sql);
    query.on('error', function (err) {
        console.log("Error in changePassword", err); 
    })
    return defered.promise;
}

exports.saveUserDetail = function (req, mysql, q) {

    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    if(req.body.role == 1 || req.body.role == 2 || req.body.role == 3) {
        var user_type = req.body.role;
        console.log('req.body', req.body);
        
        strQuery = mysqli.mysqli($mysqli, 'saveUserDetailByAdmin');
        var defered = q.defer();
        escape_data = [
            req.body.name,
            req.body.email2,
            req.body.business_name ? req.body.business_name : '',
            req.body.phone,
            req.body.address,
            req.body.city,
            req.body.state,
            req.body.zipcode,
            req.body.country,
            req.body.rep_name ? req.body.rep_name : '',
            req.body.ein ? req.body.ein : '',
            req.body.ssn ? req.body.ssn : '',
            req.body.rep_ssn ? req.body.rep_ssn : '',
            req.body.rep_address ? req.body.rep_address : '',
            req.body.rep_city ? req.body.rep_city : '',
            req.body.rep_state ? req.body.rep_state : '',
            req.body.rep_zipcode ? req.body.rep_zipcode : '',
            req.body.rep_phone ? req.body.rep_phone : '',
            req.body.dob ? dateFormat(req.body.dob, "yyyy-mm-dd") : '',
            req.body.status ? req.body.status : '',
            currentDate,
            req.body.user_id ? req.body.user_id : ''
        ];
    }
    
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        throw err;
    });

    console.log(query.sql);
    return defered.promise;
}
exports.saveUserLicenseDetail = function (req, mysql, q) {
    console.log('req.body', req.body);
    strQuery = mysqli.mysqli($mysqli, 'saveUserLicenseDetailByAdmin');
    var defered = q.defer();

    if(req.body.role == 1) {
        if(req.body.cg_refered_by == '0') {
            req.body.social_media = req.body.social_media ? req.body.social_media : '';
        } else {
            req.body.social_media = '';
        }
    }

    escape_data = [
        dateFormat(req.body.license_date, "yyyy-mm-dd"),
        req.body.cg_refered_by,
        req.body.social_media ? req.body.social_media : '',
        req.body.social_media_other ? req.body.social_media_other : '',
        req.body.ref_other ? req.body.ref_other : '',
        req.body.ref_name ? req.body.ref_name : '',
        req.body.ref_email ? req.body.ref_email : '',
        req.body.ref_date && req.body.ref_date!='0000-00-00 00:00:00' ? dateFormat(req.body.ref_date, "yyyy-mm-dd") : '',
        req.body.ref_phone ? req.body.ref_phone : '',
        req.body.ref_user_id ? req.body.ref_user_id : '',
        req.body.license ? req.body.license : '',

        req.body.license_requested ? req.body.license_requested : '',
        req.body.l_issue_date ? dateFormat(req.body.l_issue_date, "yyyy-mm-dd") : '',
        req.body.l_country ? req.body.l_country : '',
        req.body.l_state ? req.body.l_state : '',
        req.body.l_type ? req.body.l_type : '',
        req.body.l_type_other ? req.body.l_type_other : '',
        req.body.l_number ? req.body.l_number : '',
        req.body.l_state_business ? req.body.l_state_business : '',
        req.body.l_state_number ? req.body.l_state_number : '',

        req.body.verification_doc,
        req.body.user_id ? req.body.user_id : ''
    ];
    
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        throw err;
    });

    console.log(query.sql);
    return defered.promise;
}
/* ===================== End code for HempBuyer ===================== */

/**
 *  Get Product List 
 */
exports.getProducts = function (req, mysql, q, count) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd");
    
    var where = 'products.id != 0';
    if(req.body.start_from_date)
        where += ' AND date_format(products.start_date, "%m-%d-%Y") >= "'+req.body.start_from_date+'"';
    if(req.body.start_to_date)
        where += ' AND date_format(products.start_date, "%m-%d-%Y") <= "'+req.body.start_to_date+'"';
    if(req.body.end_from_date)
        where += ' AND date_format(products.end_date, "%m-%d-%Y") >= "'+req.body.end_from_date+'"';
    if(req.body.end_to_date)
        where += ' AND date_format(products.end_date, "%m-%d-%Y") <= "'+req.body.end_to_date+'"';
    if(req.body.market_status)
        where += ' AND products.market_status = "'+req.body.market_status+'"';
    if(req.body.type)
        where += ' AND products.type = "'+req.body.type+'"';
    if(req.body.title)
        where += ' AND products.title LIKE "%'+req.body.title+'%"';

    where += ' AND products.market_status != "draft" ';

    if(req.body.action == 'featured') {
        where += ' AND products.is_featured=1 ';
    } else if(req.body.action == 'upcoming') {
        where += ' AND date_format(products.start_date, "%m-%d-%Y") > date_format("'+cdate+'", "%m-%d-%Y")';
    }

    var orderBy = ' ORDER BY products.id DESC ';
    var escape_data = [];
    $mysqli = {whereCond : where, orderBy : orderBy};
    if(count) {
        var page = req.body.page;
        var perlimit = req.body.limit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [0, page, parseInt(perlimit)];
        strQuery = mysqli.mysqli($mysqli, 'getAllSellerProductsLimit');
    } else {
        escape_data = [0];
        strQuery = mysqli.mysqli($mysqli, 'getAllSellerProductsCount');
    }

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function (err) {
        console.log("Error in getProducts", err); 
    })
    return defered.promise;
}

/**
 *  Get Product Detail 
 */
exports.getProductDetails = function(req, mysql, q, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getProductDetails');
    var defered = q.defer();
    var escape_data = [0, id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getProductDetails", query.sql);
    return defered.promise;
}

exports.updateProductInfo = function (req, res, mysql, q) {
    $mysqli = {};
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //req.body.end_date <= currentDate
    var escape_data = [
        req.body.title,
        dateFormat(req.body.start_date, "yyyy-mm-dd HH:MM"),
        dateFormat(req.body.end_date, "yyyy-mm-dd HH:MM"),
        req.body.category_id,
        req.body.subcategory_id,
        req.body.type,
        req.body.is_buynow ? req.body.is_buynow : 0,
        req.body.start_price,
        req.body.reserve_price,
        req.body.buynow_price,
        req.body.buynow_qty,
        req.body.fixed_price,
        req.body.fixed_qty,
        req.body.offer_price,
        req.body.offer_qty,
        req.body.description,
        req.body.unit_of_measurement,
        '', //req.body.product_image.length ? req.body.product_image[0] : '',
        req.body.market_status,
        req.body.amount_sold,
        req.body.moq,
        req.body.product_renew,
        req.body.amount_sold,
        currentDate,
        req.body.product_id
    ];
    //console.log('escape_data', escape_data);
    strQuery = mysqli.mysqli($mysqli, 'updateProductInfo');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log("updateProductInfo", query.sql);
    query.on('error', function (err) {
        console.log("Error in updateProductInfo", err);
    });
    return defered.promise;
}
exports.updateManufactureInfo = function (req, res, mysql, q) {
    $mysqli = {};
    var escape_data = [
        req.body.packaging_description,
        req.body.keywords,
        dateFormat(req.body.manufacture_date, "yyyy-mm-dd HH:MM"),
        req.body.qty_available ? req.body.qty_available : 0,
        req.body.product_place,
        req.body.product_id
    ];
    strQuery = mysqli.mysqli($mysqli, 'updateManufactureInfo');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log("updateManufactureInfo", query.sql);
    query.on('error', function (err) {
        console.log("Error in updateManufactureInfo", err);
    });
    return defered.promise;
}
exports.updateCertificateInfo = function (req, res, mysql, q) {
    /* req.body.contaminant_screening_data = req.body.hms + "," + req.body.micro_ms + "," + req.body.prs + "," + req.body.srs; */
    /* req.body.certificate_types = (req.body.ctype_certified_organic ? req.body.ctype_certified_organic : '') + ',' +
    (req.body.ctype_gmp ? req.body.ctype_gmp : '') + ',' +
    (req.body.ctype_iso ? req.body.ctype_iso : '') + ',' +
    (req.body.ctype_kosher ? req.body.ctype_kosher : '') + ',' +
    (req.body.ctype_sqf ? req.body.ctype_sqf : '') + ',' +
    (req.body.ctype_fda_registered ? req.body.ctype_fda_registered : '') + ',' +
    (req.body.ctype_statement_of_origin ? req.body.ctype_statement_of_origin : '') + ',' +
    (req.body.ctype_statement_of_compliance ? req.body.ctype_statement_of_compliance : ''); */
    req.body.certificate_types = (req.body.ctype_certified_organic ? req.body.ctype_certified_organic : '') + ',' +
    (req.body.ctype_gmp ? req.body.ctype_gmp : '') + ',' +
    (req.body.ctype_iso ? req.body.ctype_iso : '') + ',' +
    (req.body.ctype_kosher ? req.body.ctype_kosher : '') + ',' +
    (req.body.ctype_sqf ? req.body.ctype_sqf : '') + ',' +
    (req.body.ctype_fda_registered ? req.body.ctype_fda_registered : '') + ',' +
    (req.body.ctype_outdoor ? req.body.ctype_outdoor : '') + ',' +
    (req.body.ctype_indoor ? req.body.ctype_indoor : '') + ',' +
    (req.body.ctype_greenhouse ? req.body.ctype_greenhouse : '') + ',' +
    (req.body.ctype_light_deprivation ? req.body.ctype_light_deprivation : '') + ',' +
    (req.body.ctype_co2 ? req.body.ctype_co2 : '') + ',' +
    (req.body.ctype_ethanol ? req.body.ctype_ethanol : '') + ',' +
    (req.body.ctype_hydrocarbon_extraction ? req.body.ctype_hydrocarbon_extraction : '') + ',' +
    (req.body.ctype_statement_of_origin_available ? req.body.ctype_statement_of_origin_available : '') + ',' +
    (req.body.ctype_statement_of_compliance_available ? req.body.ctype_statement_of_compliance_available : '');

    req.body.contaminant_screening_data = (req.body.potency ? req.body.potency : '') + ',' +
    (req.body.prs ? req.body.prs : '') + ',' +
    (req.body.micro_ms ? req.body.micro_ms : '') + ',' +
    (req.body.hms ? req.body.hms : '') + ',' +
    (req.body.srs ? req.body.srs : '');

    $mysqli = {};
    var escape_data = [
        req.body.certificate_types,
        dateFormat(req.body.certificate_date, "yyyy-mm-dd HH:MM"),
        req.body.contaminant_screening ? req.body.contaminant_screening : 0,
        req.body.contaminant_screening_data,

        req.body.product_id
    ];
    strQuery = mysqli.mysqli($mysqli, 'updateCertificateInfo');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log("updateCertificateInfo", query.sql);
    query.on('error', function (err) {
        console.log("Error in updateCertificateInfo", err);
    });
    return defered.promise;
}
exports.updatePaymentInfo = function (req, res, mysql, q) {
    $mysqli = {};
    var escape_data = [
        req.body.sops,
        req.body.payment_method,
        req.body.payment_method_other ? req.body.payment_method_other : '',

        req.body.product_id
    ];
    strQuery = mysqli.mysqli($mysqli, 'updatePaymentInfo');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log("updatePaymentInfo", query.sql);
    query.on('error', function (err) {
        console.log("Error in updatePaymentInfo", err);
    });
    return defered.promise;
}

/**
 *  Get Measurement List 
 */
exports.getMeasurements = function (req, mysql, q, count) {
    var where = 'id != 0';
    if(req.body.status)
        where += ' AND status = "'+req.body.status+'"';
    if(req.body.measurementname)
        where += ' AND unit_name LIKE "%'+escape(req.body.measurementname).toLowerCase()+'%"';
    var orderBy = ''
    var escape_data = [];
    $mysqli = {whereCond : where, orderBy : orderBy};
    if(count) {
        var page = req.body.page;
        var perlimit = req.body.limit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [page, parseInt(perlimit)];
        strQuery = mysqli.mysqli($mysqli, 'getAllMeasurementsLimit');
    } else
        strQuery = mysqli.mysqli($mysqli, 'getAllMeasurementsCount');

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        console.log("Error in getMeasurements", err); 
    });
    return defered.promise;
}

exports.checkMeasurementName = function (req, mysql, q) {
    var where = " LCASE(unit_name) = '" + escape(req.body.measurement_name).toLowerCase() + "' ";
    $mysqli = { whereCond : where };
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'checkMeasurementName');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("checkMeasurementName", query.sql);
    query.on('error', function (err) {
        console.log("Error in checkMeasurementName", err); 
    })
    return defered.promise;
}

exports.createMeasurement = function (req, mysql, q) {
    var where = '';
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'insertMeasurement');
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.measurement_name, req.body.measurement_status, currentDate];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("insertMeasurement", query.sql);
    query.on('error', function (err) {
        console.log("Error in insertMeasurement", err); 
    })
    return defered.promise;
}

exports.updateMeasurementsStatus = function (req, mysql, q) {
    var where = '';
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'updateMeasurement');
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.status, currentDate, req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("updateMeasurement", query.sql);
    query.on('error', function (err) {
        console.log("Error in updateMeasurement", err); 
    })
    return defered.promise;
}

/**
 *  Get Product Purchase History List 
 */
exports.getProductsPurchaseHistory = function (req, mysql, q, flag, id) {
    var where = 'p.id != 0';
    if(req.body.start_from_date)
        where += ' AND date_format(p.start_date, "%m-%d-%Y") >= "'+req.body.start_from_date+'"';
    if(req.body.start_to_date)
        where += ' AND date_format(p.start_date, "%m-%d-%Y") <= "'+req.body.start_to_date+'"';
    if(req.body.end_from_date)
        where += ' AND date_format(p.end_date, "%m-%d-%Y") >= "'+req.body.end_from_date+'"';
    if(req.body.end_to_date)
        where += ' AND date_format(p.end_date, "%m-%d-%Y") <= "'+req.body.end_to_date+'"';
    if(req.body.market_status)
        where += ' AND p.market_status = "'+req.body.market_status+'"';
    if(req.body.type)
        where += ' AND p.type = "'+req.body.type+'"';
    if(req.body.purchase_type)
        where += ' AND b.type = "'+req.body.purchase_type+'"';
    if(req.body.title)
        where += ' AND p.title LIKE "%'+req.body.title+'%"';
    if(id && id != "" && id != "0")
        where += ' AND b.projectId = '+id;
    if(req.body.purchase_from_date)
        where += ' AND date_format(b.date_added, "%m-%d-%Y") >= "'+req.body.purchase_from_date+'"';
    if(req.body.purchase_to_date)
        where += ' AND date_format(b.date_added, "%m-%d-%Y") <= "'+req.body.purchase_to_date+'"';
    if(req.body.purchase_status)
        where += ' AND b.paid = '+req.body.purchase_status;
    var orderBy = ' ORDER BY b.id DESC';
    var escape_data = [];
    $mysqli = {whereCond : where, orderBy : orderBy};
    if(flag) {
        var page = req.body.page;
        var perlimit = req.body.limit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [page, parseInt(perlimit)];
        strQuery = mysqli.mysqli($mysqli, 'getAllProductsPurchasedHistoryLimit');
    } else 
        strQuery = mysqli.mysqli($mysqli, 'getAllProductsPurchasedHistoryCount');

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(' PRODUCTS PURCHASED HISTORY ' + query.sql);
    query.on('error', function (err) {
        console.log("Error in getProductsPurchasedHistory", err); 
    })
    return defered.promise;
}

/**
 *  Get Product Bidding History List 
 */
exports.getProductsBiddingHistory = function (req, mysql, q, flag, id) {
    var where = 'p.id != 0';
    if(req.body.start_from_date)
        where += ' AND date_format(p.start_date, "%m-%d-%Y") >= "'+req.body.start_from_date+'"';
    if(req.body.start_to_date)
        where += ' AND date_format(p.start_date, "%m-%d-%Y") <= "'+req.body.start_to_date+'"';
    if(req.body.end_from_date)
        where += ' AND date_format(p.end_date, "%m-%d-%Y") >= "'+req.body.end_from_date+'"';
    if(req.body.end_to_date)
        where += ' AND date_format(p.end_date, "%m-%d-%Y") <= "'+req.body.end_to_date+'"';
    if(req.body.market_status)
        where += ' AND p.market_status = "'+req.body.market_status+'"';
    if(req.body.type)
        where += ' AND p.type = "'+req.body.type+'"';
    if(req.body.title)
        where += ' AND p.title LIKE "%'+req.body.title+'%"';
    if(id && id != "" && id != "0")
        where += ' AND b.project_id = '+id;
    if(req.body.bid_from_date)
        where += ' AND date_format(b.created_at, "%m-%d-%Y") >= "'+req.body.bid_from_date+'"';
    if(req.body.bid_to_date)
        where += ' AND date_format(b.created_at, "%m-%d-%Y") <= "'+req.body.bid_to_date+'"';
    if(req.body.bid_awarded)
        where += ' AND b.awarded = '+req.body.bid_awarded;
    where += ' AND b.status = 1';
    var orderBy = ' ORDER BY b.id DESC';
    var escape_data = [];
    $mysqli = {whereCond : where, orderBy : orderBy};
    if(flag) {
        var page = req.body.page;
        var perlimit = req.body.limit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [page, parseInt(perlimit)];
        strQuery = mysqli.mysqli($mysqli, 'getAllProductsBiddingHistoryLimit');
    } else 
        strQuery = mysqli.mysqli($mysqli, 'getAllProductsBiddingHistoryCount');

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(' PRODUCTS BIDDING HISTORY ' + query.sql);
    query.on('error', function (err) {
        console.log("Error in getProductsBiddingHistory", err); 
    })
    return defered.promise;
}

exports.getReferrals = function (req, mysql, q, count) {
    var where = '';
    if(req.body.from_date) {
        where += ' AND date_format(u.created_at, "%m-%d-%Y") >= date_format('+req.body.from_date+', "%m-%d-%Y")';
    }
    if(req.body.to_date) {
        where += ' AND date_format(u.created_at, "%m-%d-%Y") <= date_format('+req.body.to_date+', "%m-%d-%Y")';
    }
    if(req.body.username) {
        where += ' AND u.username LIKE "%'+req.body.username+'%"';
    }
    if(req.body.email) {
        where += ' AND u.email LIKE "%'+req.body.email+'%"';
    }
    if(req.body.status) {
        where += ' AND u.status LIKE "'+req.body.status+'"';
    }
    if(req.body.state) {
        where += ' AND u.state LIKE "%'+req.body.state+'%"';
    }

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getReferrals');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getReferrals", query.sql);
    query.on('error', function (err) {
        console.log("Error in getReferrals", err); 
    })
    return defered.promise;
}
exports.update_isfeatured = function(req, mysql, q, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'update_isfeatured');
    var defered = q.defer();
    if(!req.body.is_featured) {
        req.body.start_date = '';
        req.body.end_date = '';
    }
    var escape_data = [req.body.is_featured, req.body.start_date, req.body.end_date, req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("update_isfeatured", query.sql);
    return defered.promise;
}

/**
 *  Admin Dashboard Count
 */
exports.adminDashboardCount = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'adminDashboardCount');
    var defered = q.defer();
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd");
    var escape_data = [currentDate];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Admin Dashboard Count ", query.sql);
    query.on('error', function (err) {
        console.log("Error in getReferrals", err); 
    })
    return defered.promise;    
}
exports.getSubscriptionUsers = function (req, mysql, q, count) {
    var where = '';
    if(req.body.from_date) {
        where += ' AND date_format(u.created_at, "%m-%d-%Y") >= date_format('+req.body.from_date+', "%m-%d-%Y")';
    }
    if(req.body.to_date) {
        where += ' AND date_format(u.created_at, "%m-%d-%Y") <= date_format('+req.body.to_date+', "%m-%d-%Y")';
    }
    if(req.body.email) {
        where += ' AND u.email LIKE "%'+req.body.email+'%"';
    }
    if(req.body.existing_user != '') {
        where += ' AND u.existing_user='+req.body.existing_user;
    }

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getSubscriptionUsers');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getSubscriptionUsers", query.sql);
    query.on('error', function (err) {
        console.log("Error in getSubscriptionUsers", err); 
    })
    return defered.promise;
}
exports.getAds = function (req, mysql, q, count) {
    var where = '';
    if(req.body.ad_name) {
        where += ' AND ad.ad_name LIKE "%'+req.body.ad_name+'%"';
    }
    if(req.body.created_by) {
        where += ' AND u.name LIKE "%'+req.body.created_by+'%"';
    }
    if(req.body.status) {
        where += ' AND ad.status LIKE "'+req.body.status+'"';
    }
    /* if(req.body.state) {
        where += ' AND u.state LIKE "%'+req.body.state+'%"';
    } */

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getAds');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getAds", query.sql);
    query.on('error', function (err) {
        console.log("Error in getAds", err); 
    })
    return defered.promise;
}

exports.getClassifieds = function (req, mysql, q, count) {
    var where = '';
    if(req.body.status) {
        where += ' AND ad.status LIKE "'+req.body.status+'"';
    }
    if(req.body.classified_name) {
        where += ' AND ad.name LIKE "%'+req.body.classified_name+'%"';
    }
    if(req.body.created_by) {
        where += ' AND u.name LIKE "%'+req.body.created_by+'%"';
    }
    if(req.body.state) {
        where += ' AND ad.state LIKE "%'+req.body.state.replace("'","").replace("'","")+'%"';
    }
    if(req.body.city) {
        where += ' AND ad.city LIKE "%'+req.body.city.replace("'","").replace("'","")+'%"';
    }

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getClassifieds');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getClassifieds", query.sql);
    query.on('error', function (err) {
        console.log("Error in getClassifieds", err); 
    })
    return defered.promise;
}

exports.get_offer_product_sellers = function (req, mysql, q, count) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_offer_product_sellers');
    var escape_data = [];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_offer_product_sellers', query.sql)
    query.on('error', function (err) {
        console.log("Error in get_offer_product_sellers", err); 
    })
    return defered.promise;
}
exports.get_offer_product_list = function (req, mysql, q, count) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd");
    
    var where = ' AND p.id!=0';
    // var where = ' AND p.id!=0 AND p.type="offer"';
    if(req.body.market_status)
        where += ' AND p.market_status = "'+req.body.market_status+'"';
    if(req.body.seller_id)
        where += ' AND p.user_id = "'+req.body.seller_id+'"';
    if(req.body.product_type)
        where += ' AND p.type = "'+req.body.product_type+'"';
    
    var orderBy = ' ORDER BY last_message DESC ';
    var limit = '';
    var escape_data = [];
    
    if(!count) {
        var page = req.body.page;
        var perlimit = req.body.limit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        limit = ' LIMIT '+page+', '+parseInt(perlimit);
    } else {
    }
    $mysqli = {
        where : where, 
        orderBy : orderBy,
        limit: limit
    };
    strQuery = mysqli.mysqli($mysqli, 'get_offer_product_list');

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function (err) {
        console.log("Error in getProducts", err); 
    })
    return defered.promise;
}
exports.get_offer_buyer_list = function (req, mysql, q, count) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd");
    
    var where = ' AND p.id='+req.body.product_id;
    
    var orderBy = ' ORDER BY last_message DESC ';
    var limit = '';
    var escape_data = [];
    
    if(!count) {
        var page = req.body.page;
        var perlimit = req.body.limit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        limit = ' LIMIT '+page+', '+parseInt(perlimit);
    } else {
    }
    $mysqli = {
        where : where, 
        orderBy : orderBy,
        limit: limit
    };
    strQuery = mysqli.mysqli($mysqli, 'get_offer_buyer_list_admin');

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_offer_buyer_list_admin', query.sql)
    query.on('error', function (err) {
        console.log("Error in get_offer_buyer_list_admin", err); 
    })
    return defered.promise;
}
exports.get_offer_product_chat_list = function (req, mysql, q, count) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd");
    
    var where = ' AND oc.product_id='+req.body.product_id+' AND (oc.sender_id='+req.body.buyer_id+' OR oc.receiver_id='+req.body.buyer_id+')';

    /* Start Update admin unread flag */
    $mysqli = {
        where : where
    };
    strQuery = mysqli.mysqli($mysqli, 'update_admin_unread_flag');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('update_admin_unread_flag', query.sql)
    /* End Update admin unread flag */


    var orderBy = ' ORDER BY oc.id ASC ';
    var limit = '';
    var escape_data = [];
    
    if(!count) {
        var page = req.body.page;
        var perlimit = req.body.limit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        limit = ' LIMIT '+page+', '+parseInt(perlimit);
    } else {
    }
    $mysqli = {
        where : where, 
        orderBy : orderBy,
        limit: limit
    };
    strQuery = mysqli.mysqli($mysqli, 'get_offer_product_chat_list');

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_offer_product_chat_list', query.sql)
    query.on('error', function (err) {
        console.log("Error in getProducts", err); 
    })
    return defered.promise;
}
exports.get_referral_program = function (req, mysql, q, count) {
    var where = '';
    if(req.body.status) {
        where += ' AND rf.status LIKE "'+req.body.status+'"';
    }
    if(req.body.rf_name) {
        where += ' AND rf.name LIKE "%'+req.body.rf_name+'%"';
    }
    if(req.body.rf_company) {
        where += ' AND rf.company LIKE "%'+req.body.rf_company+'%"';
    }
    if(req.body.rf_email) {
        where += ' AND rf.email LIKE "%'+req.body.rf_email+'%"';
    }

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_referral_program');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("get_referral_program", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_referral_program", err); 
    })
    return defered.promise;
}
exports.get_banner_list = function (req, mysql, q, count) {
    $mysqli = {
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_banner_list');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("get_banner_list", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_banner_list", err); 
    })
    return defered.promise;
}
exports.get_banner_detail = function (req, mysql, q, count) {
    $mysqli = {
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_banner_detail');
    var escape_data = [req.body.banner_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("get_banner_detail", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_banner_detail", err); 
    })
    return defered.promise;
}
exports.save_banner = function (req, mysql, q, count) {
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {
    }
    var defered = q.defer();
    if(req.body.id) {
        var escape_data = [req.body.banner_name, req.body.banner_id];
        strQuery = mysqli.mysqli($mysqli, 'update_banner');
    } else {
        strQuery = mysqli.mysqli($mysqli, 'insert_banner');
        var escape_data = [req.body.banner_id, req.body.banner_name, currentDate];
    }
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("save_banner", query.sql);
    query.on('error', function (err) {
        console.log("Error in save_banner", err); 
    })
    return defered.promise;
}
exports.get_transactions = function (req, mysql, q, count) {
    var where = '';
    if(req.body.tr_gateway) {
        where += ' AND i.gateway LIKE "'+req.body.tr_gateway+'"';
    }
    if(req.body.tr_email) {
        where += ' AND buyer.email LIKE "%'+req.body.tr_email+'%"';
    }
    if(req.body.tr_title) {
        where += ' AND p.title LIKE "%'+req.body.tr_title+'%"';
    }
    if(req.body.tr_transaction_id) {
        where += ' AND i.transactionid LIKE "%'+req.body.tr_transaction_id+'%"';
    }
    if(req.body.tr_from_date) {
        where += ' AND date_format(i.date_added, "%m-%d-%Y") >= date_format("'+req.body.tr_from_date+'", "%m-%d-%Y")';
    }
    if(req.body.tr_to_date) {
        where += ' AND date_format(i.date_added, "%m-%d-%Y") <= date_format("'+req.body.tr_to_date+'", "%m-%d-%Y")';
    }
    if(req.body.tr_status) {
        where += ' AND i.status = "'+req.body.tr_status+'"';
    }
    if(req.body.tr_escrow_choice) {
        where += ' AND es.escrow_company = "'+req.body.tr_escrow_choice+'"';
    }

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_transactions');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("get_transactions", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_transactions", err); 
    })
    return defered.promise;
}
exports.get_net_revenue = function (req, mysql, q, count) {
    $mysqli = {
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_net_revenue');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        console.log("Error in get_net_revenue", err); 
    })
    return defered.promise;
}
exports.update_invoice_release_status = function (req, mysql, q, count) {
    var where = '';
    var defered = q.defer();
    if(Array.isArray(req.body.invoice_id)) {
        where = " id IN ('"+req.body.invoice_id.join("','")+"')";
    } else {
        where = " id IN ("+req.body.invoice_id+")";
    }
    $mysqli = {
        where: where
    }
    strQuery = mysqli.mysqli($mysqli, 'update_invoice_release_status');
    var escape_data = [
        req.body.status
    ];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("update_invoice_release_status", query.sql);
    query.on('error', function (err) {
        console.log("Error in update_invoice_release_status", err); 
    })
    return defered.promise;
}
exports.update_invoice_release_transaction = function (req, mysql, q, count) {
    $mysqli = {
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'update_invoice_release_transaction');
    var escape_data = [
        req.body.refer_id,
        req.body.trans_id,
        req.body.destination_payment,
        req.body.invoice_id
    ];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        console.log("Error in update_invoice_release_transaction", err); 
    })
    return defered.promise;
}
exports.get_buyer_bank_detail_using_invoice_id = function (req, mysql, q, count) {
    $mysqli = {
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_buyer_bank_detail_using_invoice_id');
    var escape_data = [req.body.invoice_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("get_buyer_bank_detail_using_invoice_id", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_buyer_bank_detail_using_invoice_id", err); 
    })
    return defered.promise;
}
exports.get_seo_management = function (req, mysql, q, count) {
    var where = '';
    if(req.body.tr_title) {
        where += ' AND p.title LIKE "%'+req.body.tr_title+'%"';
    }
    if(req.body.tr_from_date) {
        where += ' AND date_format(seo.created_date, "%m-%d-%Y") >= date_format("'+req.body.tr_from_date+'", "%m-%d-%Y")';
    }
    if(req.body.tr_to_date) {
        where += ' AND date_format(seo.created_date, "%m-%d-%Y") <= date_format("'+req.body.tr_to_date+'", "%m-%d-%Y")';
    }

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_seo_management');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("get_seo_management", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_seo_management", err); 
    })
    return defered.promise;
}
exports.update_medata = function (req, mysql, q, count) {
    $mysqli = {
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'update_medata');
    var escape_data = [
        req.body.meta_title,
        req.body.meta_key,
        req.body.meta_description,
        req.body.id
    ];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("update_medata", query.sql);
    query.on('error', function (err) {
        console.log("Error in update_medata", err); 
    })
    return defered.promise;
}
exports.update_transaction_contract = function (req, mysql, q, count) {
    $mysqli = {
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'update_transaction_contract');
    var escape_data = [req.files.transaction_contract.name, req.body.transaction_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        console.log("Error in update_transaction_contract", err); 
    })
    return defered.promise;
}
exports.get_product_seller_detail_using_invoiceid = function (req, mysql, q, count) {
    var where = '';
    var defered = q.defer();
    if(Array.isArray(req.body.invoice_id)) {
        where = " AND i.id IN ('"+req.body.invoice_id.join("','")+"')";
    } else {
        where = " AND i.id IN ('"+req.body.invoice_id+"')";
    }
    $mysqli = {
        where: where
    };

    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_product_seller_detail_using_invoiceid');
    var escape_data = [req.body.invoice_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        console.log("Error in get_product_seller_detail_using_invoiceid", err); 
    })
    return defered.promise;
}