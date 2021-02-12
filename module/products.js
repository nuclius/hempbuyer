var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');
exports.getCampaignData = function(req, mysql, q,uid) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_campaign_data');
    var escape_data = [uid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql + "555555555555555555");
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}
exports.totalSoldPrdtByUser = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'totalsoldbyuser');
    var escape_data = [req.session.userid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql + "555555555555555555");
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}

exports.updateBuyerPayStatus = function(req, mysql, q, bid, uid) {
    $mysqli = {}
    var defered = q.defer();
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'update_bpay_status');
    var status = req.body.pay_status!=undefined ? req.body.pay_status : 1;
    var escape_data = [status, datge,bid,uid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log('buynow paid status changed ---- '+query.sql);
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}
exports.updateBuyerPayStatusById = function(req, mysql, q, bid, uid) {
    $mysqli = {}
    var defered = q.defer();
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'update_bpay_status_by_id');
    var escape_data = [datge,bid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log('buynow paid status changed ---- '+query.sql);
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}

exports.updateSellerPayStatus = function(req, mysql, q, bid, uid, samt, commisson_s_per, commission_fee_seller) {
    $mysqli = {}
    var defered = q.defer();
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'update_spay_status');
    // mysqli['update_spay_status'] ='update buynow set seller_paid_status = "1", 
    //seller_paid_at = ?, seller_paid_amt = ? where id = ? and paid = 1 and 
    //seller_paid_status = 0 and user_id = ?';
    var escape_data = [datge,commisson_s_per, commission_fee_seller, samt, bid, uid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('buynow paid status changed ---- '+query.sql);
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}

exports.updateAdminPayStatus = function(req, mysql, q, bid, uid, aamt) {
    $mysqli = {}
    var defered = q.defer();
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'update_apay_status');
    // mysqli['update_spay_status'] ='update buynow set seller_paid_status = "1", 
    //seller_paid_at = ?, seller_paid_amt = ? where id = ? and paid = 1 and 
    //seller_paid_status = 0 and user_id = ?';
    var escape_data = [datge,aamt,bid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log('buynow paid status changed ---- '+query.sql);
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}


exports.generatePkey = function(req,pid, mysql, q){
    console.log('pid here', pid);
        var datge = dateFormat(new Date(), "yyyy");
        $mysqli = {}
        var defered = q.defer();
        strQuery = mysqli.mysqli($mysqli, 'generate_pkey');
        var escape_data = [pid];
        console.log(strQuery);
        console.log(escape_data);
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql + "555555555555555555");
        query.on('error', function(err) {
            console.log("Error in getting deals value " + err);
        })
        return defered.promise;
}

exports.generateInvoiceID = function(req,invid, mysql, q){
        console.log('pid here', invid);
        var datge = dateFormat(new Date(), "yyyy");
        $mysqli = {}
        var defered = q.defer();
        strQuery = mysqli.mysqli($mysqli, 'generate_invoiceid');
        var escape_data = [invid];
        console.log(strQuery);
        console.log(escape_data);
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql + "555555555555555555");
        query.on('error', function(err) {
            console.log("Error in getting deals value " + err);
        })
        return defered.promise;
}

exports.updDeliveryStatus = function(req, mysql, q) {

    $mysqli = {};

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var escape_data = [req.param('status'), datge, req.param('id')];

    strQuery = mysqli.mysqli($mysqli, 'update_delivery');

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}
exports.updShippingStatus = function(req, mysql, q) {

    $mysqli = {};

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var escape_data = [req.param('status'), datge, req.param('id')];

    strQuery = mysqli.mysqli($mysqli, 'update_shipping');

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}
exports.getBuynowDetails = function(req, mysql, q) {

    $mysqli = {};

    var escape_data = [req.body.id];

    strQuery = mysqli.mysqli($mysqli, 'get_buynow_details');

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}
exports.twilioSelectednumberProd = function(req, mysql, q, pid) {
    $mysqli = {};

    var escape_data = [pid];

    strQuery = mysqli.mysqli($mysqli, 'twilio7');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.twilioSelectednumberProduct = function(req, mysql, q, number) {
    $mysqli = {};

    var escape_data = [number];

    strQuery = mysqli.mysqli($mysqli, 'twilio6');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.twilioSelectednumber = function(req, mysql, q, pid, id) {
    $mysqli = {};

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [pid, datge, id];

    strQuery = mysqli.mysqli($mysqli, 'twilio5');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.twilioSelectnumber = function(req, mysql, q) {
    $mysqli = {};

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [datge];

    strQuery = mysqli.mysqli($mysqli, 'twilio4');
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.inviteAcceptDecline = function(req, mysql, q) {
    $mysqli = {};
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli, 'video3');
    //console.log(strQuery);
    var defered = q.defer();

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.ad, datge, req.body.id, req.body.email];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.inviteList = function(req, mysql, q) {
    $mysqli = {};
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli, 'video4');
    //console.log(strQuery);
    var defered = q.defer();
    var escape_data = [req.body.id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.addInvite = function(req, mysql, q, sdata) {
    $mysqli = {};
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli, 'video2');
    //console.log(strQuery);
    var defered = q.defer();

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [sdata.id, sdata.name, sdata.email, datge];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.isDigitalItem = function(req, mysql, q) {
    $mysqli = {};
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli, '983');
    //console.log(strQuery);
    var defered = q.defer();
    var escape_data = [req.param('id')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.getCategory = function(req, mysql, q) {
    $mysqli = {};
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli, 'category_queries_3');
    //console.log(strQuery);
    var defered = q.defer();
    var escape_data = [req.param('id')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.subLevelCategory = function(req, mysql, q, lft, rgt) {
    $mysqli = {};
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli, 'category_queries_2');
    //console.log(strQuery);
    var defered = q.defer();
    var escape_data = [lft, rgt];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log("qqqqqqqqqqq "+query.sql);
    return defered.promise;
}
exports.subCategory = function(req, mysql, q) {
    $mysqli = {};
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli, 'category_queries_1');
    //console.log(strQuery);
    var defered = q.defer();
    var escape_data = [req.param('id')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.productDetailId = function(req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 19);
    escape_fields = [id]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.dealsProducts = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 291);
    ////console.log(strQuery);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    escape_string = [datge, datge];
    //console.log(escape_string);
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}
exports.bestSellersProducts = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 292);
    ////console.log(strQuery);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    escape_string = [datge, datge];
    //console.log(escape_string);
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    return defered.promise;
}
exports.productCategoryItems = function(req, mysql, q, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 293);
    ////console.log(strQuery);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    escape_string = [datge, datge, id];
    //console.log(escape_string);
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    return defered.promise;
}

exports.homePageListingProducts = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'homePageListing');
    ////console.log(strQuery);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    escape_string = [datge, datge];
    //console.log(escape_string);
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    return defered.promise;
}

exports.productDetailItems = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 36);
    ////console.log(strQuery);
    var defered = q.defer();
    query = mysql.query(strQuery, defered.makeNodeResolver());
    return defered.promise;
}

exports.winnerPrd = function(mysql, q, data) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 36);
    ////console.log(strQuery);
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;
}
exports.saveProduct = function(req, mysql, q, prdt) {


    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx249');
    var defered = q.defer();
    newfilename = {};
    newfilename.name = '';
    newfilename.originalname = '';
    var duration = (typeof(req.param('duration')) !== 'undefined') ? req.param('duration')[0] : prdt['duration'];
    var duration_level = 'D';
    var time = (typeof(req.param('time')) !== 'undefined') ? req.param('time') : prdt['time'];
    var future = (typeof(req.param('future')) !== 'undefined') ? req.param('future') : prdt['future'];
    var time_level = (typeof(req.param('timelevel')) !== 'undefined') ? req.param('timelevel') : prdt['time_level'];
    req.body.date_added = dateFormat(req.body.date_added + ':00', "yyyy-mm-dd HH:MM:ss");
    req.body.date_closed = dateFormat(req.body.date_closed + ':00', "yyyy-mm-dd HH:MM:ss");
    req.body.rprice = (typeof(req.body.vauction) == 'undefined') ? req.body.rprice : req.body.sprice;
    if (prdt.market_status == 'draft') {
        if (req.session.admin == 1) {
            prdt.market_status = 'open';
        } else {
            prdt.market_status = 'moderate';
        }
    }
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var location = (typeof(req.param('location')) === 'undefined') ? '' : req.param('location');

    if (req.body.currency_type == 'dollar') {
        var shipping_fee = (typeof(req.param('shipping_fee')) != 'undefined') ? Number(common.currencyConverter(req.param('shipping_fee'))) * req.session.currencyrate : 0;
        var sprice = (typeof(req.body.sprice) != 'undefined') ? Number(common.currencyConverter(req.body.sprice)) * req.session.currencyrate : 0;
        var rprice = (typeof(req.body.rprice) != 'undefined') ? Number(common.currencyConverter(req.body.rprice)) * req.session.currencyrate : 0;
        var bprice = (typeof(req.body.bprice) != 'undefined') ? Number(common.currencyConverter(req.body.bprice)) * req.session.currencyrate : 0;
        var mprice = (typeof(req.body.mprice) != 'undefined') ? Number(common.currencyConverter(req.body.mprice)) * req.session.currencyrate : 0;
    } else {
        shipping_fee = common.currencyConverter(req.param('shipping_fee'));
        sprice = common.currencyConverter(req.body.sprice);
        rprice = common.currencyConverter(req.body.rprice);
        bprice = common.currencyConverter(req.body.bprice);
        mprice = common.currencyConverter(req.body.mprice);
    }

    var escape_data = [req.body.title,
        req.param('description'),
        (typeof(req.body.product_image) !== 'undefined') ? req.body.avatar : newfilename.originalname,
        (typeof(req.body.product_image) !== 'undefined') ? req.body.product_image : newfilename.originalname,
        req.param('cid'),
        req.param('tags'),
        shipping_fee,
        req.param('shipping_description'),
        (typeof(req.param('buynow')) === 'undefined') ? 0 : req.param('buynow'),
        (typeof(req.param('featured')) === 'undefined') ? 0 : req.param('featured'),
        (typeof(req.param('home_page_listing_fee')) === 'undefined') ? 0 : req.param('home_page_listing_fee'),
        sprice,
        rprice,
        bprice,
        mprice,
        (typeof(req.param('auction')) === 'undefined') ? 0 : req.param('auction'),
        (typeof(req.param('is_location')) === 'undefined') ? 0 : req.param('is_location'),
        (typeof(req.param('document')) === 'undefined') ? '' : req.param('document'),
        (typeof(req.param('work_loc')) === 'undefined') ? 0 : req.param('work_loc'),
        (typeof(req.param('auction')) === 'undefined' || req.param('auction') == 0) ? req.param('qty') : 1,
        (typeof(req.param('paypal_email')) !== 'undefined') ? req.param('paypal_email') : '',
        duration,
        duration_level,
        time,
        time_level,
        future,
        req.body.date_added,
        req.body.date_closed,
        (typeof(req.param('save')) === 'undefined') ? 'draft' : prdt.market_status,
        (typeof(req.param('country')) === 'undefined') ? '' : req.param('country'),
        (typeof(req.param('state')) === 'undefined') ? '' : req.param('state'),
        (typeof(req.param('city')) === 'undefined') ? '' : req.param('city'),
        location,
        datge,
        (typeof(req.param('vauction')) === 'undefined') ? 0 : 1,
        req.body.parentcid,
        req.body.product_weight,
        req.body.product_width,
        req.body.product_height,
        req.body.id
    ]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

/* directbuy product editing */
exports.saveeditProduct = function(req, mysql, q, prdt) {

$mysqli = {image :''};
    newfilename = {};
    newfilename.name = '';
    newfilename.originalname = '';

    newfilename2 = {};
    newfilename2.name = '';
    newfilename2.originalname = '';

    // console.log(req.files.product_image);

    if (typeof(req.files.product_image) !== 'undefined') {
        if (typeof(req.files.product_image[0]) === 'undefined') {
            newfilename.name = req.files.product_image.name;
            newfilename.originalname = req.files.product_image.originalname;
            req.body.avatar = req.files.product_image.name;
            req.body.product_image = req.files.product_image.originalname;
            $mysqli = { image : ', avatar = "'+req.body.avatar+'", image = "'+req.body.product_image+'"'};
        } else {
            newfilename.name = req.files.product_image[0].name;
            newfilename.originalname = req.files.product_image[0].originalname;
            req.body.avatar = req.files.product_image[0].name;
            req.body.product_image = req.files.product_image[0].originalname;
            $mysqli = { image : ', avatar = "'+req.body.avatar+'", image = "'+req.body.product_image+'"'};
        }
    }
    if (typeof(req.files.cert_analysis_img) !== 'undefined') {
        if (typeof(req.files.cert_analysis_img[0]) === 'undefined') {
            newfilename2.name = req.files.cert_analysis_img.name;
            newfilename2.originalname = req.files.cert_analysis_img.originalname;
        } else {
            newfilename2.name = req.files.cert_analysis_img[0].name;
            newfilename2.originalname = req.files.cert_analysis_img[0].originalname;
        }
    } else {
        newfilename2.name = prdt.cert_analysis_img;
    }

// console.log("here------"+req.body.avatar);
// console.log("here------"+req.body.product_image);

    // $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'productedit');
    var defered = q.defer();
    newfilename = {};
    newfilename.name = '';
    newfilename.originalname = '';
    var duration_level = 'D';
    req.body.date_added = dateFormat(req.body.date_added + ':00', "yyyy-mm-dd HH:MM:ss");
    req.body.date_closed = dateFormat(req.body.date_closed + ':00', "yyyy-mm-dd HH:MM:ss");
    req.body.rprice = (typeof(req.body.vauction) == 'undefined') ? req.body.rprice : req.body.sprice;
    var prostatus = 'open';
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var location = (typeof(req.param('location')) === 'undefined') ? '' : req.param('location');
    var unit_price = (typeof(req.body.unit_price) == 'undefined') ? req.body.unit_price : req.body.unit_price;
    if (req.body.currency_type == 'dollar') {
        var shipping_fee = (typeof(req.param('shipping_fee')) != 'undefined') ? Number(common.currencyConverter(req.param('shipping_fee'))) * req.session.currencyrate : 0;
        var sprice = (typeof(req.body.sprice) != 'undefined') ? Number(common.currencyConverter(req.body.sprice)) * req.session.currencyrate : 0;
        var rprice = (typeof(req.body.rprice) != 'undefined') ? Number(common.currencyConverter(req.body.rprice)) * req.session.currencyrate : 0;
        var bprice = (typeof(req.body.bprice) != 'undefined') ? Number(common.currencyConverter(req.body.bprice)) * req.session.currencyrate : 0;
        var mprice = (typeof(req.body.mprice) != 'undefined') ? Number(common.currencyConverter(req.body.mprice)) * req.session.currencyrate : 0;
    } else {
        shipping_fee = common.currencyConverter(req.param('shipping_fee'));
        sprice = common.currencyConverter(req.body.sprice);
        rprice = common.currencyConverter(req.body.rprice);
        bprice = common.currencyConverter(req.body.bprice);
        mprice = common.currencyConverter(req.body.mprice);
    }
    if (req.param('negotiable') == 1) {
        var buynow = 0;
    } else {
        var buynow = 1;
    }

    var stax = (typeof(req.session.stax_per) == 'undefined') ? 0 : parseFloat(req.session.stax_per);

    var escape_data = [req.body.pkey, req.body.title,
        (typeof(req.body.metrc_id) !== 'undefined') ? req.body.metrc_id : '',
        req.body.descript,
        req.param('subcategoryid'),
        buynow,
        sprice,
        rprice, //rprice,
        sprice,
        sprice,
        // (typeof(req.param('negotiable')) == 'undefined' || req.param('negotiable') != '1') ? 0 : 1,
        0,
        (typeof(req.param('negotiable')) == 'undefined' || req.param('negotiable') != '1') ? 0 : 1,
        (typeof(req.body.qty) !== undefined) ? req.param('qty') : 1,
        prostatus,
        datge,
        (typeof(req.body.categoryid) !== 'undefined') ? req.body.categoryid : '',
        (typeof(req.body.cinfuse) === 'undefined') ? 'n' : req.body.cinfuse,
        (typeof(req.body.units) !== undefined) ? req.body.units : 'ounces',
        unit_price,
        stax,
        req.session.country,
        req.session.state,
        req.session.state_abbr,
        (typeof(req.param('store_prdt')) === 'undefined') ? 'n' : req.param('store_prdt'),
        (typeof(req.param('store_prdt_msg')) === 'undefined') ? '' : req.param('store_prdt_msg'),
        (typeof(req.param('interim_testing_status')) === 'undefined') ? 'n' : req.param('interim_testing_status'),
        (typeof(req.param('interim_testing_status_msg')) === 'undefined') ? '' : req.param('interim_testing_status_msg'),
        (typeof(req.param('cert_analysis')) === 'undefined') ? 'n' : req.param('cert_analysis'),
        newfilename2.name,
        (typeof(req.param('default_distributor')) === 'undefined') ? 'n' : req.param('default_distributor'),
        (typeof(req.param('additional_service')) === 'undefined') ? 'n' : req.param('additional_service'),
        (typeof(req.param('additional_service_type')) === 'undefined') ? '' : req.param('additional_service_type'),
        (typeof(req.param('cultivation_tax_status')) === 'undefined') ? 'y' : req.param('cultivation_tax_status'),
        (typeof(req.param('test_result_types')) === 'undefined') ? '' : req.param('test_result_types'),
        (typeof(req.param('herbee_facility_status')) === 'undefined') ? '' : req.param('herbee_facility_status'),
        req.body.id
    ]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        console.log(query.sql);
        throw err;
    });
    return defered.promise;
}
exports.post = function(req, res, arr) {
    common.tplFile('post.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr);
};
exports.openBidPost = function(req, res, arr) {
    common.tplFile('post-item-open-market.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr);
};
exports.deleteWatchlist = function(req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 53);

    var defered = q.defer();

    var escape_data = [req.param('id'), req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.mywatchlist = function(req, mysql, q) {
    $mysqli = {};
    var page = req.body.page;
    page = (page > 0) ? (page - 1) * 10 : 0;


    strQuery = mysqli.mysqli($mysqli, 51);

    var defered = q.defer();

    var escape_data = [req.session.userid, page];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.totalmywatchlist = function(req, mysql, q) {
    $mysqli = {};
    page = req.body.page;
    strQuery = mysqli.mysqli($mysqli, 52);

    var defered = q.defer();

    var escape_data = [req.session.userid];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.deleteSearch = function(req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, "deletesearch");

    var defered = q.defer();

    var escape_data = [req.body.id, req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}
exports.searchsavedsearch = function(req, mysql, q, id) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 299);

    var defered = q.defer();

    var escape_data = [id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}
exports.savesearch = function(req, mysql, q, data) {

    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    page = req.body.page;
    strQuery = mysqli.mysqli($mysqli, "savesearch");

    var defered = q.defer();

    var escape_data = [req.param('title'), req.param('encrypt'), req.session.userid, datge, req.param('searchtext')];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}

exports.savedsearch = function(req, mysql, q, count) {
    $mysqli = {};

    if (count == 1) {
        console.log("GGGGGGGGGG");
        strQuery = mysqli.mysqli($mysqli, "savedsearch1");
        var escape_data = [req.session.userid];
    } else {
        strQuery = mysqli.mysqli($mysqli, "savedsearch");
        var page = (req.body.page - 1) * 10;
        var escape_data = [req.session.userid, page];
    }


    var defered = q.defer();


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}

exports.getResearchData = function(req, mysql, q, count) {
    var whr = '';

    if (count == 0) {
        whr = whr + '';
    } else if (count == 1) {
        whr = whr + ' where user_id = ' + req.session.userid + ' ';
    }

    $mysqli = { whr: whr };

    strQuery = mysqli.mysqli($mysqli, "get_research_data");


    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
console.log(count+"::::;getResearchData::"+query.sql)
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}

// /* getting product wise research data */
// exports.getResearchDataFlower = function(req, mysql, q, count) {
//     var whr = '';

//     if (count == 0) {
//         whr = whr + '';
//     } else if (count == 1) {
//         whr = whr + ' where user_id = ' + req.session.userid;
//     }
// // req.body.start_date
// // req.body.end_date

//     if ((req.body.sdate !== '') && (typeof(req.body.sdate) != 'undefined')) {
//         if(whr == ''){
//             whr = whr + ' where '+'p.created_at > "'+req.body.sdate+'" ';
//         } else {
//             whr = whr + ' and p.created_at > "'+req.body.sdate+'" ';
//         }
//     }

//     if ((req.body.edate !== '') && (typeof(req.body.edate) != 'undefined')) {
//         if(whr == ''){
//             whr = whr + ' where '+' p.created_at < "'+req.body.edate+'" ';
//         } else {
//             whr = whr + ' and p.created_at < "'+req.body.edate+'" ';
//         }
//     }

//     if ((req.body.start_date !== '') && (typeof(req.body.start_date) != 'undefined')) {
//         if(whr == ''){
//             whr = whr + ' where '+'p.created_at > "'+req.body.start_date+'" ';
//         } else {
//             whr = whr + ' and p.created_at > "'+req.body.start_date+'" ';
//         }
//     }

//     if ((req.body.end_date !== '') && (typeof(req.body.end_date) != 'undefined')) {
//         if(whr == ''){
//             whr = whr + ' where '+' p.created_at < "'+req.body.end_date+'" ';
//         } else {
//             whr = whr + ' and p.created_at < "'+req.body.end_date+'" ';
//         }
//     }

//  $mysqli = { whr: whr };

//     strQuery = mysqli.mysqli($mysqli, "get_research_flower");
//     var defered = q.defer();
//     query = mysql.query(strQuery, defered.makeNodeResolver());
//     console.log(query.sql);
//     query.on('error', function(err) {
//         throw err;
//     });
//     return defered.promise;
// }

/* getting transactionwise research data */
exports.getResearchDataFlower = function(req, mysql, q, count) {
    var whr = '';

/*
    select 
    ROUND( AVG(b.amount),2 ) as avg_amount,
    ROUND( AVG(b.qty),2 ) as avg_qty,
    sc.name as sub_cat, pc.name as parent_cat, b.id as buynow_id, c.id as cart_id, p.id product_id, i.* 
    from invoices i left join checkout c on c.id = i.cart_id 
    left join buynow b on b.cart_id = c.id 
    left join projects p on i.primary_id = p.id 
    left join categories sc on p.category_id = sc.id 
    left join categories pc on p.parent_category_id=pc.id 
    where i.type = "bought"
*/

    if (count == 0) {
        whr = whr + '';
    } else if (count == 1) {
        // whr = whr + ' and i.user_id = ' + req.session.userid + ' and ue.state like "%'+req.session.state+'%"';
        whr = whr + ' and (b.user_id= '+req.session.userid+' or b.request_userid = '+req.session.userid+') and ue.state like "%'+req.session.state+'%"';
    }

// req.body.start_date
// req.body.end_date
if(((req.body.sdate == '') || (typeof(req.body.sdate) == 'undefined')) && ((req.body.edate == '') || (typeof(req.body.edate) == 'undefined'))){
            whr = whr + ' and DATE(i.paid_date) >= DATE_SUB( CURDATE(), INTERVAL 1 MONTH ) and DATE(i.paid_date) <= "'+dateFormat(new Date(), "yyyy-mm-dd")+'" ';
} else {
    if ((req.body.sdate !== '') && (typeof(req.body.sdate) != 'undefined')) {
            whr = whr + ' and DATE(i.paid_date) >= "'+dateFormat(new Date(req.body.sdate), "yyyy-mm-dd")+'" ';
    }

    if ((req.body.edate !== '') && (typeof(req.body.edate) != 'undefined')) {
            whr = whr + ' and DATE(i.paid_date) <= "'+dateFormat(new Date(req.body.edate), "yyyy-mm-dd")+'" ';
    }
}

    

    if ((req.body.start_date !== '') && (typeof(req.body.start_date) != 'undefined')) {
            whr = whr + ' and DATE(i.paid_date) >= "'+dateFormat(new Date(req.body.start_date), "yyyy-mm-dd")+'" ';
    }

    if ((req.body.end_date !== '') && (typeof(req.body.end_date) != 'undefined')) {
            whr = whr + ' and DATE(i.paid_date) <= "'+dateFormat(new Date(req.body.end_date), "yyyy-mm-dd")+'" ';
    }

    $mysqli = { whr: whr };

    strQuery = mysqli.mysqli($mysqli, "get_research_flower");

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    console.log(count+"::::;getResearchDataFlower::"+query.sql)

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
 
exports.searchProducts = function(mysql, q, data, count) {
    var row = '';
    var limit = '';
    var order = '';
    where = '';
    ////console.log(data);
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    if (data['page'] == 'index') {
        row = 7;
        where = ' and market_status = "open" ';
        limit = ' limit 0 , 12'
    } else if (data['page'] == 'live') {
        row = 7;
        where = ' and market_status = "open"';
    } else if (data['page'] == 'future') {
        row = 8;
    } else if (data['page'] == 'closed') {
        row = 9;
    } else if (data['page'] == 'shop') {
        row = 10;
    } else {
        row = 13;
        where = ' and market_status = "open" and date_closed >= "' + datge + '" and date_added <= "' + datge + '" ';
    }

    if (data.uid > 0) {
        where += ' and p.user_id =  ' + data.uid;
    }
    if (data.toprice > 0) {
        where += ' and case when p.auction = 0 then p.bprice >=  ' + data.toprice + ' else p.wprice >=  ' + data.toprice + ' end';
    }
    if (data.fromprice > 0) {
        where += ' and case when p.auction = 0 then p.bprice <=  ' + data.fromprice + ' else p.wprice <=  ' + data.fromprice + ' end';
    }
    if (data.cmprice > 0) {
        where += 'AND(p.bprice >=' + data.cmprice + ' or sprice >= ' + data.cmprice + ')';
    }

    if (data.mens_discount > 0) {
        where += ' and 100 * (p.mprice - p.bprice)/p.mprice >= ' + data.mens_discount;
    }

    if (data.mobile_dis > 0) {
        where += ' and 100 * (p.mprice - p.bprice)/p.mprice = ' + data.mobile_dis;
    }

    if (data.health_dis > 0) {
        where += ' and 100 * (p.mprice - p.bprice)/p.mprice >= ' + data.health_dis;
    }

    if (data.shipping_desc != '') {
        where += ' and shipping_description = "' + data.shipping_desc + '"';

    }
    where += ' AND IF((qty-sold-booked) > 0,true,false)';
    order = data.order;
    ////console.log(order);
    if (order == '' || typeof(data.order) === 'undefined') {
        order = ' date_closed asc ';
    } else if (order == 2) {
        order = ' id desc ';
    } else if (order == 3) {
        order = ' sea_price asc ';
    } else if (order == 4) {
        order = ' sea_price desc ';
    } else {
        order = ' date_closed asc ';

    }
    ////console.log(data);
    if (data['page'] != 'index') {
        //console.log(count);
        if (count == 1) {
            order += 'limit ' + (data.spage - 1) * data.perlimit + ',' + data.perlimit;
        }
    }
    $mysqli = {
        search: data['search'],
        cid: data['cid'],
        datge: datge,
        limit: limit,
        where: data['where'] + where,
        pid: 0,
        order: order
    };

    if (data['cid'] != '') {
        $mysqli.cid = mysqli.mysqli($mysqli, 'cid');
    } else {
        $mysqli.cid = '';
    }
    if (data['titlesonly'] > 0 && data['titlesonly'] != '' && data['search'] != '') {
        $mysqli.search = mysqli.mysqli($mysqli, 'title');
    } else if (data['titlesonly'] == '' && data['search'] != '') {
        $mysqli.search = mysqli.mysqli($mysqli, 'search');
    } else {
        $mysqli.search = '';
    }

    if (data['images'] != '') {

        $mysqli.where += mysqli.mysqli($mysqli, 'avatar');
    }
    if (data['freeshipping'] != '') {

        $mysqli.where += mysqli.mysqli($mysqli, 'noshipping');
    }
    if (data['projectid'] > 0) {
        $mysqli.pid = parseInt(data['projectid']);
        $mysqli.where += mysqli.mysqli($mysqli, 'pid');
    }
    ////console.log($mysqli);
    strQuery = mysqli.mysqli($mysqli, row);
    ////console.log(row);

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    //console.log("Query is "+query.sql);

    return defered.promise;
}

exports.getAllOpenProductsLimit = function(req, mysql, q) { 

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getAllOpenProductsLimit');
    ////console.log(strQuery);
    var defered = q.defer();

    query = mysql.query(strQuery, [req.session.userid ? req.session.userid : 0], defered.makeNodeResolver());
    //console.log('SQL getAllOpenProductsLimit : ', query.sql)

    return defered.promise;
}

exports.getOpenProducts = function(req, mysql, q) { 

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var whereCond = 'products.id != 0 and products.market_status = "open" AND products.user_id != 0 ';

    // if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
    //     whereCond += 'and products.user_id = '+ req.body.loggedUserId.toString() +'';

    if(req.body.status && req.body.status != 'undefined')
        whereCond += 'and products.market_status IN ('+ req.body.status.toString() +')';

    $mysqli = {whereCond : whereCond};
    //$mysqli = {whereCond : '1'};
    strQuery = mysqli.mysqli($mysqli, 'getAllOpenProducts');
    ////console.log(strQuery);
    var defered = q.defer();

    query = mysql.query(strQuery, [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0], defered.makeNodeResolver());
    //console.log('SQL all : ', query.sql)

    return defered.promise;
}



exports.getOpenProductsSearch = function(req, mysql, q, count, currentUser) {
    var escape_data = [];
    //var whereCond = 'products.market_status = "open"';
    var whereCond = 'products.id != 0 and products.market_status = "open" AND products.user_id != 0 ';
    if (req.body.categorySelected)
        whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and products.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        // whereCond += 'and FIND_IN_SET ('+ req.body.keywordSeach.toString() +', products.keywords)'
        whereCond += 'and (products.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR products.title like "%'+ req.body.keywordSeach.toString() +'%" OR products.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    // if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
    //     whereCond += 'and products.user_id = '+ req.body.loggedUserId.toString() +' ';

    if(req.body.status && req.body.status != 'undefined')
        whereCond += 'and products.market_status IN ('+ req.body.status.toString() +')';

    console.log("currentUser", currentUser)
    if(currentUser)
        whereCond += ' and products.user_id = ' + req.session.userid;

    var orderBy = '';
    if(typeof(req.body.sort_by) != "undefined" && req.body.sort_by != '') {
        if(req.body.sort_by == "price_asc")
            orderBy = 'ORDER BY products.start_price ASC ';
        else if(req.body.sort_by == "price_desc")
            orderBy = 'ORDER BY products.start_price DESC ';
        else if(req.body.sort_by == "startdate_asc")
            orderBy = 'ORDER BY products.start_date ASC ';
        else if(req.body.sort_by == "startdate_desc")
            orderBy = 'ORDER BY products.start_date DESC ';
        else if(req.body.sort_by == "enddate_asc")
            orderBy = 'ORDER BY products.end_date ASC ';
        else if(req.body.sort_by == "enddate_desc")
            orderBy = 'ORDER BY products.end_date DESC ';
        else if(req.body.sort_by == "id_asc")
            orderBy = 'ORDER BY products.id ASC ';
        else if(req.body.sort_by == "id_desc")
            orderBy = 'ORDER BY products.id DESC';
    }

    if(count){
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0, page, perlimit];
        $mysqli = {whereCond : whereCond, orderBy : orderBy};
        strQuery = mysqli.mysqli($mysqli, 'getAllOpenProductsLimit');
    }else{
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0];
        $mysqli = {whereCond : whereCond};
        strQuery = mysqli.mysqli($mysqli, 'getAllOpenProducts');
    }
    var defered = q.defer();
    query = mysql.query(strQuery,escape_data, defered.makeNodeResolver());
    console.log('SELLER SQL : ', query.sql)

    return defered.promise;
}

// exports.getOpenProducts = function(req, mysql, q) { 

//     datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
//     $mysqli = {};
//     strQuery = mysqli.mysqli($mysqli, 'getAllOpenProducts');
//     ////console.log(strQuery);
//     var defered = q.defer();

//     query = mysql.query(strQuery, defered.makeNodeResolver());
//     console.log('SQL : ', query.sql)

//     return defered.promise;
// }



exports.getCategoryList = function(req, mysql, q, flag) { 

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getCategoryList'); 
    ////console.log(strQuery);

    if(flag == 1){
        strQuery = mysqli.mysqli($mysqli, 'getSubCategoryList'); 
    }
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log('getCategoryList SQL : ', query.sql)

    return defered.promise;
}


exports.getStateListUnique = function(req, mysql, q) { 

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getStateListUnique');
    ////console.log(strQuery);
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    //console.log('getStateListUnique SQL : ', query.sql)

    return defered.promise;
}
exports.homeProducts = function(mysql, q, all) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = { datge: datge };
    strQuery = mysqli.mysqli($mysqli, all);
    ////console.log(strQuery);
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;
}
exports.isinWatchlist = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 49);
    ////console.log(strQuery);
    var defered = q.defer();

    escapeData = [req.session.userid, req.param('id')];

    query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());

    return defered.promise;
}
exports.addWatchlist = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 50);
    ////console.log(strQuery);
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    escapeData = [req.param('id'), req.session.userid, datge];
    //console.log(escapeData);
    query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());

    return defered.promise;
}
exports.testresultImages = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, "get_testr_images");
    var defered = q.defer();
    escape_data = [req.body.id];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.certImages = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, "get_certs");
    var defered = q.defer();
    escape_data = [req.body.id];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.productImage = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 164);
    var defered = q.defer();
    escape_data = [req.body.id];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.updateFeatureData = function(req, mysql, q, id) {
    $mysqli = { feature: '', home_page: '' };
    if (req.session.featured_add) {
        $mysqli.feature = 'feature = 1';
    }
    if (req.session.home_listing_add) {
        if (req.session.featured_add) {
            $mysqli.feature = 'feature = 1,home_page_listing_fee = 1';
        } else {
            $mysqli.feature = 'home_page_listing_fee = 1';
        }

    }
    strQuery = mysqli.mysqli($mysqli, 'cnx250');
    var defered = q.defer();
    escape_data = [id];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    query.on("error", function(err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;
}
exports.updateUnFeatureData = function(req, mysql, q, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 296);
    var defered = q.defer();
    escape_data = [id];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.save = function(req, res, mysql, q) {
    //var qs = require('qs');
    //req.body = qs.parse(req.body);


    newfilename = {};
    newfilename.name = '';
    newfilename.originalname = '';
    console.log(req.files.product_image);

    if (typeof(req.files.product_image) !== 'undefined') {
        if (typeof(req.files.product_image[0]) === 'undefined') {

            newfilename.name = req.files.product_image.name;
            newfilename.originalname = req.files.product_image.originalname;
        } else {
            newfilename.name = req.files.product_image[0].name;
            newfilename.originalname = req.files.product_image[0].originalname;
        }
    }

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 14);
    //req.body.date_added =   '2015-02-02';
    /*if(typeof(req.param('future')) !== 'undefined' && req.param('future') == 1 && typeof(req.param('date_added')) !== 'undefined')
     {
     var t = (typeof(req.param('time')) !== 'undefined') ? parseInt(req.param('time')) : 0;
     if(req.param('timelevel') == 'PM')
     {
     if(t > 11)
     {
     t = 11;
     }
     var t = t+12;
     }
     if(t <= 9)
     {
     t = '0'+t;
     }
     req.body.date_added = dateFormat(req.body.date_added +' '+t+':00:00',"yyyy-mm-dd HH:MM:ss");;
     }
     else
     {
     req.body.date_added = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     }
     d = 10;
     if(req.param('duration') !== 'undefined' && req.param('duration') > 0)
     {
     d = req.param('duration')[0];
     } */

    req.body.date_added = req.body.date_added + ':00';
    req.body.date_closed = req.body.date_closed + ':00';
    //console.log(req.body.date_added);
    //console.log(req.body.date_closed);

    //console.log( dateFormat(new Date(req.body.date_added),"yyyy-mm-dd HH:MM:ss"));
    //console.log(new Date(req.body.date_added));
    //console.log(new Date(req.body.date_closed));


    //req.body.date_added = req.body.date_added+' 00:00:00';
    //req.body.date_closed = new Date(req.body.date_added).addDays(d);

    var defered = q.defer();
    req.body.iprice = 0.01;
    //req.body.sprice = 0.01;

    var prostatus = 'moderate';

    if (req.session.admin == 1) {
        prostatus = 'open';
    }
    if (req.body.save == 'moderate') {
        prostatus = 'moderate';
    }
    if (req.body.bulkupload) {
        req.body.avatar = req.body.new_image;
        req.body.product_image = req.body.old_image;
    }
    req.body.rprice = (typeof(req.body.vauction) == 'undefined') ? req.body.rprice : req.body.sprice;

    var duration = (typeof(req.param('duration')) !== 'undefined') ? req.param('duration')[0] : '';
    var duration_level = 'D';
    var time = (typeof(req.param('time')) !== 'undefined') ? req.param('time') : '';
    var future = (typeof(req.param('future')) !== 'undefined') ? req.param('future') : 0;
    var time_level = (typeof(req.param('timelevel')) !== 'undefined') ? req.param('timelevel') : '';

    var location = (typeof(req.param('location')) === 'undefined') ? '' : req.param('location');
    if (req.body.currency_type == 'dollar') {
        var shipping_fee = (typeof(req.param('shipping_fee')) != 'undefined') ? Number(common.currencyConverter(req.param('shipping_fee'))) * req.session.currencyrate : 0;
        var sprice = (typeof(req.body.sprice) != 'undefined') ? Number(common.currencyConverter(req.body.sprice)) * req.session.currencyrate : 0;
        var rprice = (typeof(req.body.rprice) != 'undefined') ? Number(common.currencyConverter(req.body.rprice)) * req.session.currencyrate : 0;
        var bprice = (typeof(req.body.bprice) != 'undefined') ? Number(common.currencyConverter(req.body.bprice)) * req.session.currencyrate : 0;
        var mprice = (typeof(req.body.mprice) != 'undefined') ? Number(common.currencyConverter(req.body.mprice)) * req.session.currencyrate : 0;
        var iprice = (typeof(req.body.iprice) != 'undefined') ? Number(common.currencyConverter(req.body.iprice)) * req.session.currencyrate : 0;
        var sprice = (typeof(req.body.sprice) != 'undefined') ? Number(common.currencyConverter(req.body.sprice)) * req.session.currencyrate : 0;
    } else {
        var shipping_fee = common.currencyConverter(req.param('shipping_fee'));
        var sprice = common.currencyConverter(req.body.sprice);
        var rprice = common.currencyConverter(req.body.rprice);
        var bprice = common.currencyConverter(req.body.bprice);
        var mprice = common.currencyConverter(req.body.mprice);
        var iprice = common.currencyConverter(req.body.iprice);
        var sprice = common.currencyConverter(req.body.sprice);
    }
    //location = location.toLowerCase();
    var escape_data = [req.body.title,
        req.param('description'),
        /*(typeof(req.files.product_image) !== 'undefined') ? newfilename.name : ((typeof(req.body.avatar) !== 'undefined') ? req.body.avatar[0] : ''),
        (typeof(req.files.product_image) !== 'undefined') ? newfilename.originalname : ((typeof(req.body.avatar) !== 'undefined') ? req.body.image[0] : ''),*/
        (typeof(req.body.product_image) !== 'undefined') ? req.body.avatar : '',
        (typeof(req.body.product_image) !== 'undefined') ? req.body.product_image : '',
        req.param('cid'),
        req.param('tags'),
        (typeof(req.session) !== 'undefined') ? req.session.userid : 0,
        shipping_fee,
        (typeof(req.param('shipping_description')) === 'undefined') ? '' : req.param('shipping_description'),
        datge,
        datge,
        (typeof(req.param('buynow')) === 'undefined') ? 0 : req.param('buynow'),
        0,
        sprice,
        rprice,
        dateFormat(new Date(req.body.date_added), "yyyy-mm-dd HH:MM:ss"),
        dateFormat(new Date(req.body.date_closed), "yyyy-mm-dd HH:MM:ss"),
        1,
        bprice,
        mprice,
        iprice,
        sprice,
        //common.currencyConverter(req.body.sprice),
        (typeof(req.param('auction')) === 'undefined') ? 0 : req.param('auction'),
        (typeof(req.param('is_location')) === 'undefined') ? 0 : req.param('is_location'),
        (typeof(req.param('document')) === 'undefined') ? '' : req.param('document'),
        (typeof(req.param('work_loc')) === 'undefined') ? 0 : req.param('work_loc'),
        (typeof(req.param('auction')) === 'undefined' || req.param('auction') == 0) ? req.param('qty') : 1,
        req.param('paypal_email'),
        duration,
        duration_level,
        time,
        time_level,
        future,
        (typeof(req.param('save')) === 'undefined') ? 'draft' : prostatus,
        (typeof(req.param('country')) === 'undefined') ? '' : req.param('country'),
        (typeof(req.param('state')) === 'undefined') ? '' : req.param('state'),
        (typeof(req.param('city')) === 'undefined') ? '' : req.param('city'),
        location,
        (typeof(req.files.digital_image) === 'undefined') ? 0 : 1,
        (typeof(req.param('vauction')) === 'undefined') ? 0 : 1,
        req.body.parentcid,
        req.body.product_weight,
        req.body.product_width,
        req.body.product_height,
        /**/

        /**/
    ];
    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.usermaildata = function(req, res, mysql, q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'usermaildata');

    var defered = q.defer();
    var escape_data = [req.session.state];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
console.log('query', query.sql);
    return defered.promise;
}
exports.savestorepdts = function(req, res, mysql, q) {
    console.log('savestorepdts ---- ')
    //var qs = require('qs');
    //req.body = qs.parse(req.body);


    newfilename = {};
    newfilename.name = '';
    newfilename.originalname = '';

    newfilename2 = {};
    newfilename2.name = '';
    newfilename2.originalname = '';


    if (typeof(req.files.product_image) !== 'undefined') {
        if (typeof(req.files.product_image[0]) === 'undefined') {
            newfilename.name = req.files.product_image.name;
            newfilename.originalname = req.files.product_image.originalname;
            req.body.avatar = req.files.product_image.name;
            req.body.product_image = req.files.product_image.originalname;
        } else {
            newfilename.name = req.files.product_image[0].name;
            newfilename.originalname = req.files.product_image[0].originalname;
            req.body.avatar = req.files.product_image[0].name;
            req.body.product_image = req.files.product_image[0].originalname;
        }
    }

   if (typeof(req.files.cert_analysis_img) !== 'undefined') {
        if (typeof(req.files.cert_analysis_img[0]) === 'undefined') {
            newfilename2.name = req.files.cert_analysis_img.name;
            newfilename2.originalname = req.files.cert_analysis_img.originalname;
        } else {
            newfilename2.name = req.files.cert_analysis_img[0].name;
            newfilename2.originalname = req.files.cert_analysis_img[0].originalname;
        }
    }

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'insert_store_products');

    /*
    mysqli['insert_store_products'] = 'insert into projects  (
    title,description,avatar,image,category_id,parent_category_id,user_id,created_at,updated_at,date_closed,sprice,rprice,wprice,date_added,status,buynow,negotiable,qty,cannabis_type,units, market_status, unit_price,stax, stax_amount,brand) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
    */

    // req.body.start_date = req.body.start_date + ':00';
    var date_added = datge;
    var endDate = date_added;
    datge1 = new Date();
    var ss = datge1.getDate();
    var endingDate = datge1.setDate(datge1.getDate() + 365);
    // req.body.date_closed = req.body.date_closed + ':00';

    var defered = q.defer();
    req.body.iprice = 0.01;
    //req.body.sprice = 0.01;

    // var prostatus = 'moderate';
    var prostatus = 'open';

    if (req.session.admin == 1) {
        prostatus = 'open';
    }

    // if (req.body.save == 'moderate') {
    //     prostatus = 'moderate';
    // }

    if (req.body.save == 'moderate') {
        prostatus = 'open';
    }

    if (req.body.bulkupload) {
        req.body.avatar = req.body.new_image;
        req.body.product_image = req.body.old_image;
    }

    //req.body.rprice = (typeof(req.body.target_price) == 'undefined') ? req.body.rprice : req.body.target_price;
    var unit_price = (typeof(req.body.unit_price) == 'undefined') ? req.body.unit_price : req.body.unit_price;


    if (req.body.currency_type == 'dollar') {
        var shipping_fee = (typeof(req.param('shipping_fee')) != 'undefined') ? Number(common.currencyConverter(req.param('shipping_fee'))) * req.session.currencyrate : 0;
        var sprice = (typeof(req.body.sprice) != 'undefined') ? Number(common.currencyConverter(req.body.sprice)) * req.session.currencyrate : 0;
        var rprice = (typeof(req.body.rprice) != 'undefined') ? Number(common.currencyConverter(req.body.rprice)) * req.session.currencyrate : 0;
        var bprice = (typeof(req.body.bprice) != 'undefined') ? Number(common.currencyConverter(req.body.bprice)) * req.session.currencyrate : 0;
        unit_price = (typeof(unit_price) != 'undefined') ? Number(common.currencyConverter(unit_price)) * req.session.currencyrate : 0;
        // stax_amount = (typeof(stax_amount) != 'undefined') ? Number(common.currencyConverter(stax_amount)) * req.session.currencyrate : 0;

        // var bprice = (typeof(req.body.bprice) != 'undefined') ? Number(common.currencyConverter(req.body.bprice))*req.session.currencyrate : 0;
        // var mprice = (typeof(req.body.mprice) != 'undefined') ? Number(common.currencyConverter(req.body.mprice))*req.session.currencyrate : 0;
        // var iprice = (typeof(req.body.iprice) != 'undefined') ? Number(common.currencyConverter(req.body.iprice))*req.session.currencyrate : 0;
    } else {
        var shipping_fee = common.currencyConverter(req.param('shipping_fee'));
        var sprice = common.currencyConverter(req.body.sprice);
        var rprice = common.currencyConverter(req.body.rprice);
        var bprice = common.currencyConverter(req.body.bprice);
        unit_price = common.currencyConverter(unit_price);
        // stax_amount = common.currencyConverter(stax_amount);
        // var bprice = common.currencyConverter(req.body.bprice);
        // var mprice = common.currencyConverter(req.body.mprice);
        // var iprice = common.currencyConverter(req.body.iprice);
    }

    var stax = (typeof(req.session.stax_per) == 'undefined') ? 0 : parseFloat(req.session.stax_per);

    var stax_amount = 0;
    if (stax > 0)
        stax_amount = parseFloat(bprice) * (parseFloat(stax) / 100);

    if (req.body.currency_type == 'dollar') {

        stax_amount = (typeof(stax_amount) != 'undefined') ? Number(common.currencyConverter(stax_amount)) * req.session.currencyrate : 0;

    } else {

        stax_amount = common.currencyConverter(stax_amount);

    }

    if (req.param('negotiable') == 1) {
        var buynow = 0;
    } else {
        var buynow = 1;
    }

    var consultant_fee = (typeof(req.body.consultant_fee) == 'undefined') ? 0 : Number(req.body.consultant_fee);
    var consultant_fee_amount = (consultant_fee > 0 && unit_price > 0) ? ( (Number(unit_price) * consultant_fee) / 100 ) : 0;

    var escape_data = [
        req.body.pkey,
        req.body.title,
        (typeof(req.body.metrc_id) !== 'undefined') ? req.body.metrc_id : '',
        req.param('descript'),
        (typeof(req.files.product_image) !== 'undefined') ? req.body.avatar : '',
        (typeof(req.files.product_image) !== 'undefined') ? req.body.product_image : '',
        (typeof(req.body.subcategoryid) !== 'undefined') ? req.body.subcategoryid : '',
        (typeof(req.body.categoryid) !== 'undefined') ? req.body.categoryid : '',
        (typeof(req.session) !== 'undefined') ? req.session.userid : 0,
        datge,
        datge,
        dateFormat(new Date(endingDate), "yyyy-mm-dd HH:MM:ss"),
        sprice, //sprice,
        sprice, //rprice,
        sprice, //wprice,
        unit_price, //bprice,
        datge,
        1,
        buynow,
        (typeof(req.param('negotiable')) === 'undefined') ? 0 : req.param('negotiable'),
        (typeof(req.body.qty) !== undefined) ? req.param('qty') : 1, //(typeof(req.param('auction')) === 'undefined' || req.param('auction') == 0) ? req.param('qty') : 1,
        (typeof(req.body.cinfuse) === 'undefined') ? 'n' : req.body.cinfuse,
        (typeof(req.body.units) !== undefined) ? req.body.units : 'ounces',
        'open',
        unit_price,
        stax,
        stax_amount,
        consultant_fee,
        consultant_fee_amount,
        req.body.brand,
        req.session.country,
        req.session.state,
        req.session.state_abbr,
        // (typeof(req.param('save')) === undefined) ? 'draft' : prostatus
        (typeof(req.param('store_prdt')) === 'undefined') ? 'n' : req.param('store_prdt'),
        (typeof(req.param('store_prdt_msg')) === 'undefined') ? '' : req.param('store_prdt_msg'),
        (typeof(req.param('interim_testing_status')) === 'undefined') ? 'n' : req.param('interim_testing_status'),
        (typeof(req.param('interim_testing_status_msg')) === 'undefined') ? '' : req.param('interim_testing_status_msg'),
        (typeof(req.param('cert_analysis')) === 'undefined') ? 'n' : req.param('cert_analysis'),
        newfilename2.name,
        (typeof(req.param('default_distributor')) === 'undefined') ? 'n' : req.param('default_distributor'),
        (typeof(req.param('additional_service')) === 'undefined') ? 'n' : req.param('additional_service'),
        (typeof(req.param('additional_service_type')) === 'undefined') ? '' : req.param('additional_service_type'),
        (typeof(req.param('cultivation_tax_status')) === 'undefined') ? 'y' : req.param('cultivation_tax_status'),
        (typeof(req.param('test_result_types')) === 'undefined') ? 'y' : req.param('test_result_types'),
        (typeof(req.param('herbee_facility_status')) === 'undefined') ? 'y' : req.param('herbee_facility_status'),
        (typeof(req.param('cod')) === 'undefined') ? '0' : req.param('cod')
    ];

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}


exports.futureProducts = function(mysql, q, all) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = { datge: datge };
    strQuery = mysqli.mysqli($mysqli, all);

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;
}
exports.mysoldproducts = function(req, mysql, q, count) {
    $mysqli = {}
    var defered = q.defer();
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }
     var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and title like "%'+req.body.search+'%"';
    }
    $mysqli = { whr: whr, limit: limit };

    strQuery = mysqli.mysqli($mysqli, "cnx225");
    var defered = q.defer();
    var escape_data = [req.session.userid, page];
    //console.log('limit=' + limit + 'page' + page);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}
exports.myproducts = function(req, mysql, q, cnt) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    //status = 'open';
    where = ' and date_closed >= "' + datge + '" and (market_status = "open" or market_status = "moderate")';
    mys = 15;
    mys = 18;
    if (req.param('cmd') == 'sold') {
        where = ' and (market_status = "sold" or sold > 0)';
    }
    if (req.param('cmd') == 'draft') {
        where = ' and market_status = "draft"';
    }
    if (req.param('cmd') == 'closed') {
        where = '  and market_status NOT IN ("draft","sold")   and ((market_status = "closed")  or date_closed < "' + datge + '")';
    }
    if (cnt == 0 && Number(req.body.pids) != 0) {
        where += ' and p.id NOT IN (' + req.body.pids + ')';
    }
    $mysqli = { where: where };

    var page = req.body.page;
    var perlimit = req.body.perlimit;
    ////console.log($mysqli);
    if (cnt == 0) {

        strQuery = mysqli.mysqli($mysqli, 15);

        page = (page > 0) ? (page - 1) * perlimit : 0;

        escape_fields = [req.session.userid, page, perlimit];

    } else {
        $mysqli = { where: where };
        strQuery = mysqli.mysqli($mysqli, 18);
        escape_fields = [req.session.userid]
    }
    ////console.log(escape_fields);

    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

    query.on('error', function(err) {

        throw err;
    });

    return defered.promise;
}

exports.productDetailById = function(prodId, mysql, q) {

    // console.log(req.param('id'));

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'new19');
    escape_fields = [prodId]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}


exports.productDetail = function(req, mysql, q) {

    console.log(req.param('id'));

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'new19');
    escape_fields = [req.param('id')]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.cartitemDetail = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'timer12');
    escape_fields = [req.param('id'), req.session.userid]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.productDetails = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 162);
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    escape_fields = [datge]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.soldStatus = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'soldStatus');
    //escape_fields = [status, req.param('id')]
    ////console.log(escape_fields);
    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;
}
exports.closeProject = function(req, mysql, q, status) {
    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 34);
    escape_fields = [status, req.param('id')]
    ////console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.closeProjects = function(req, mysql, q, status, pid) {
    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 34);
    escape_fields = [status, pid]
    ////console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    // console.log("Close the product " + query.sql);
    return defered.promise;
}
exports.shopProducts = function(mysql, q) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = { datge: datge };
    strQuery = mysqli.mysqli($mysqli, 6);

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;
}
exports.bidWinner = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 160);

    var defered = q.defer();
    //console.log(1);
    escape_fields = [req.session.userid, req.body.id];
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.auctionSold = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 161);

    var defered = q.defer();
    escape_fields = [req.session.userid, req.body.id];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.otherItems = function(req, mysql, q, id, pid) {
    //console.log(id);
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = { datge: datge };
    strQuery = mysqli.mysqli($mysqli, 'cnx254');

    var defered = q.defer();
    escape_fields = [id, pid];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.closeProducts = function(mysql, q) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = { datge: datge };
    strQuery = mysqli.mysqli($mysqli, 4);

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;
}
exports.shortDescribe = function(results) {
    req_data = [];
    //console.log(results);



    for (i in results) {

        /* Date of product availability for open bid market*/
        if (results[i].auction == 1) {
            var hours = 60 * 60 * 1000;
            // console.log("day : "+hours);

            var firstDate = new Date(results[i].date_added); //date of start auction
            var curDate = new Date(Date.now()); //current date
            var start_date = new Date(results[i].start_date); //formated start date
            var secondDate = new Date(results[i].checkAvail); //date_added - 72 hours

            var diffHours = Math.round((secondDate.getTime() - curDate.getTime()) / (hours));

            // console.log("date_added : "+firstDate);
            // console.log("available Date : "+secondDate);
            // console.log("diff : "+diffHours);

            if (diffHours < 0) {
                results[i].available = true;
            } else if (diffHours > 0) {
                results[i].available = false;
                results[i].available_date = (firstDate.getMonth() + 1) + '/' + firstDate.getDate() + '/' + (firstDate.getFullYear() - 2000);
                // console.log("future_date "+results[i].future_date);
            } else {
                results[i].available_date = (firstDate.getMonth() + 1) + '/' + firstDate.getDate() + '/' + (firstDate.getFullYear() - 2000);
            }
        }

        if (results[i].order_type == 'total') {
            results[i].order_type_text = 'Total Orders Only';
        } else if (results[i].order_type == 'partial') {
            results[i].order_type_text = 'Partial Orders Allowed';
        }
        /* added by mohit : for units measuring ('ounces','pounds','grams','units') 
            use unit or short_unit
        */
        if (results[i].qty > 1) {
            if (results[i].units == 'pounds') {
                results[i].unit = 'Pounds';
                results[i].short_unit = 'lbs';
            } else if (results[i].units == 'ounces') {
                results[i].unit = 'Ounces';
                results[i].short_unit = 'oz';
            } else if (results[i].units == 'grams') {
                results[i].unit = 'Grams';
                results[i].short_unit = 'gm';
            } else if (results[i].units == 'units') {
                results[i].unit = 'Units';
                results[i].short_unit = 'Units';
            }
        } else {
            if (results[i].units == 'pounds') {
                results[i].unit = 'Pound';
                results[i].short_unit = 'lbs';
            } else if (results[i].units == 'ounces') {
                results[i].unit = 'Ounce';
                results[i].short_unit = 'oz';
            } else if (results[i].units == 'grams') {
                results[i].unit = 'Gram';
                results[i].short_unit = 'gm';
            } else if (results[i].units == 'units') {
                results[i].unit = 'Unit';
                results[i].short_unit = 'Unit';
            }
        }



        ////console.log(results[i]['date_closed']);
        if (results[i]['date_closed'] !== null || typeof(results[i]['date_closed']) !== 'undefined') {
            ////console.log(1);
            date1 = new Date(results[i]['date_closed']);
            date3 = new Date(results[i]['date_added']);
            date2 = new Date();
            diffDays = date1.getTime() - date2.getTime();;
            ////console.log(diffDays)​
            results[i]['closed'] = date1;
            results[i]['ptime'] = dateFormat(results[i]['date_closed'], 'mmmm dS, yyyy');
            results[i]['stime'] = dateFormat(results[i]['date_added'], 'mm/dd/yyyy: HH:MM');
            results[i]['ctime'] = dateFormat(results[i]['date_closed'], 'mmmm dS, yyyy');
            if (results[i]['bids'] === null) {
                results[i]['bids'] = 0;
            }
            if (results[i]['bprice'] === 'NaN') {
                results[i]['bprice'] = 0.00;
            }
            ////console.log('Reserve '+results[i]['rprice'])
            if (results[i]['sprice'] === 'NaN') {
                results[i]['sprice'] = 0.00;
            }
            if (results[i]['rprice'] === 'NaN') {
                results[i]['rprice'] = 0.00;
            }
            if (results[i]['iprice'] === 'NaN') {
                results[i]['iprice'] = 0.00;
            }
            if (results[i]['wprice'] === 'NaN') {
                results[i]['wprice'] = 0.00;
            }
            if (diffDays > 0 || results[i]['market_status'] == 'sold') {
                results[i]['status'] = 'open';
                if (results[i]['market_status'] == 'sold') {
                    results[i]['status'] = 'sold';

                } else if (results[i]['market_status'] == 'removed') {
                    results[i]['status'] = 'deleted';
                } else if (date3 > date2) {
                    results[i]['status'] = 'future';
                } else if (results[i]['market_status'] == 'moderate') {
                    results[i]['status'] = 'moderate';
                }


            } else {
                if (results[i]['market_status'] == 'closed') {
                    results[i]['status'] = 'closed';
                } else if (results[i]['market_status'] == 'draft') {
                    results[i]['status'] = 'closed';
                } else {
                    results[i]['status'] = 'deleted';
                }
            }
            results[i]['day'] = common.dateMeasure(diffDays);
        }
        results[i]['avatar'] = (results[i]['avatar'] !== null && typeof(results[i]['avatar']) !== 'undefined') ? results[i]['avatar'] : '';
        if (results[i]['sprice'] != null || typeof(results[i]['sprice']) !== 'undefined') {
            results[i]['sprice'] = common.currencyConverter(results[i]['sprice']);
            results[i]['rprice'] = common.currencyConverter(results[i]['rprice']);
            results[i]['wsprice'] = common.currencyConverter(results[i]['wprice'] + results[i]['iprice']);
            results[i]['wprice'] = common.currencyConverter(results[i]['wprice']);
            results[i]['mprice'] = common.currencyConverter(results[i]['mprice']);
            results[i]['iprice'] = common.currencyConverter(results[i]['iprice']);
            results[i]['bprice'] = common.currencyConverter(results[i]['bprice']);
            results[i]['shipping_price'] = common.currencyConverter(results[i]['shipping_price']);
            results[i]['r_sprice'] = common.currencyConverter(((results[i]['sprice'] / results[i]['qty']) * results[i]['rfilled_qty']));
            results[i]['ptitle'] = common.shorten(results[i]['title'], 28);
        }

        req_data[i] = results[i];

    }

    return req_data;
}


exports.projectDetails = function(req, mysql, q, fields, id) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 55);
    escape_fields = [fields, id]
    ////console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.removeProjectMultiple = function(req, mysql, q, id) {
    console.log('ids', req.body.ids);
    $mysqli = {};
    var tempid = [];
    tempid = req.body.ids;
    strQuery = mysqli.mysqli($mysqli, 'product_delete_multiple');
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;
}
exports.removeProject = function(req, mysql, q, id) {
    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 56);
    escape_fields = [id]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}


exports.getcategory = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 253);
    escape_fields = [req.param('cid')]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}


exports.categoryusr = function(req, mysql, q) {


    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 283);
    escape_fields = [req.param('cid')]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;

}

exports.maincatVal = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 853);
    escape_fields = [];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log('maincatVal', query.sql);
    return defered.promise;

}

exports.subcatVal = function(req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 854);
    escape_fields = [];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;

}



exports.updateAttachmentLimit = function(req, mysql, q, size) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'update_attach_limit');
    escape_fields = [size, req.body.id];
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    delete req.session.aid;
    return defered.promise;

}
exports.title_exist = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 855);
    console.log('****************************sssssss*******');
    escape_fields = [];
    console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());


    return defered.promise;



}

exports.checkmailnotify = function(req, mysql, q, nid) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 660);

    escape_fields = [req.session.userid, nid];
    console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log('query', query.sql);

    return defered.promise;


}

exports.checksmsnotify = function(req, mysql, q, nid) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 661);

    escape_fields = [req.session.userid, nid];
    console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.usermailnotify = function(req, mysql, q, uid, nid) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 660);

    escape_fields = [uid, nid];
    console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());


    return defered.promise;


}

exports.usersmsnotify = function(req, mysql, q, uid, nid) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 661);

    escape_fields = [uid, nid];
    console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());


    return defered.promise;


}

exports.getAllCats = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 274);

    escape_fields = [];
    console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());


    return defered.promise;


}
exports.checkblocked = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 506);
    // console.log("req session here : "+JSON.stringify(req.session));
    escape_fields = [req.body.id, req.session.email];
    console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.mysoldproductssearch = function(req, mysql, q, count) {
    $mysqli = {}
    var defered = q.defer();
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }

    var where = "";
    if (req.body.searchsales) {
        where += " and p.title like '%" + req.body.searchsales + "%'";
    }
    if (((typeof(req.body.date_from) !== 'undefined') && req.body.date_from !== 'null' && req.body.date_from !== '') && ((typeof(req.body.date_to) !== 'undefined') && req.body.date_to !== 'null' && req.body.date_to !== '')) {
        where += " and b.date_added BETWEEN '" + req.body.date_from + "' AND '" + req.body.date_to + "'";
    }
    if (((typeof(req.body.minprice_vendor) !== 'undefined') && req.body.minprice_vendor !== 'null' && req.body.minprice_vendor !== '') && ((typeof(req.body.maxprice_vendor) !== 'undefined') && req.body.maxprice_vendor !== 'null' && req.body.maxprice_vendor !== '')) {
        where += " and b.amount BETWEEN '" + req.body.minprice_vendor + "' AND '" + req.body.maxprice_vendor + "'";

    }

    $mysqli = { where: where };

    strQuery = mysqli.mysqli($mysqli, "search225");
    var defered = q.defer();
    var escape_data = [req.session.userid, page];
    //console.log('limit=' + limit + 'page' + page);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.myproductssearch = function(req, mysql, q, cnt) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    //status = 'open';
    where = ' and date_closed >= "' + datge + '" and (market_status = "open" or market_status = "moderate")';
    mys = 15;
    mys = 18;
    if (req.param('cmd') == 'sold') {
        where = ' and (market_status = "sold" or sold > 0)';
    }
    if (req.param('cmd') == 'draft') {
        where = ' and market_status = "draft"';
    }
    if (req.param('cmd') == 'closed') {
        where = '  and market_status NOT IN ("draft","sold")   and ((market_status = "closed")  or date_closed < "' + datge + '")';
    }


    var page = req.body.page;
    var perlimit = req.body.perlimit;

    if (req.body.searchsales) {
        where += " and title like '%" + req.body.searchsales + "%'";
    }
    if (((typeof(req.body.date_from) !== 'undefined') && req.body.date_from !== 'null' && req.body.date_from !== '') && ((typeof(req.body.date_to) !== 'undefined') && req.body.date_to !== 'null' && req.body.date_to !== '')) {
        where += " and date_added BETWEEN '" + req.body.date_from + "' AND '" + req.body.date_to + "'";
    }
    if (((typeof(req.body.minprice_vendor) !== 'undefined') && req.body.minprice_vendor !== 'null' && req.body.minprice_vendor !== '') && ((typeof(req.body.maxprice_vendor) !== 'undefined') && req.body.maxprice_vendor !== 'null' && req.body.maxprice_vendor !== '')) {
        where += " and bprice BETWEEN '" + req.body.minprice_vendor + "' AND '" + req.body.maxprice_vendor + "'";

    }
    $mysqli = { where: where };
    ////console.log($mysqli);
    if (cnt == 0) {
        strQuery = mysqli.mysqli($mysqli, 'search15');

        page = (page > 0) ? (page - 1) * perlimit : 0;

        escape_fields = [req.session.userid, page, perlimit];

    } else {
        $mysqli = { where: where };
        strQuery = mysqli.mysqli($mysqli, 18);
        escape_fields = [req.session.userid]
    }
    ////console.log(escape_fields);

    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    console.log('*******************************************************');
    console.log(query.sql);
    console.log('*******************************************************');
    query.on('error', function(err) {

        throw err;
    });

    return defered.promise;
}
exports.getproductIds = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getproductIds');
    escape_fields = [req.session.userid];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.myproductsbrand = function(req, mysql, q, cnt) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    //status = 'open';
    where = ' and date_closed >= "' + datge + '" and (market_status = "open" or market_status = "moderate")';
    mys = 15;
    mys = 18;
    if (req.param('cmd') == 'sold') {
        where = ' and (market_status = "sold" or sold > 0)';
    }
    if (req.param('cmd') == 'draft') {
        where = ' and market_status = "draft"';
    }
    if (req.param('cmd') == 'closed') {
        where = '  and market_status NOT IN ("draft","sold")   and ((market_status = "closed")  or date_closed < "' + datge + '")';
    }
    if (cnt == 0 && Number(req.body.pids) != 0) {
        where += ' and p.id NOT IN (' + req.body.pids + ')';
    }
    $mysqli = { where: where };

    var page = req.body.page;
    var perlimit = req.body.perlimit;
    ////console.log($mysqli);
    if (cnt == 0) {

        strQuery = mysqli.mysqli($mysqli, 15);

        page = (page > 0) ? (page - 1) * perlimit : 0;

        escape_fields = [req.session.userid, page, perlimit];

    } else {
        $mysqli = { where: where };
        strQuery = mysqli.mysqli($mysqli, 'myproductsbrandb');
        escape_fields = [req.session.userid]
    }
    ////console.log(escape_fields);

    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

    query.on('error', function(err) {

        throw err;
    });

    return defered.promise;
}

/* for admin to get total volume of openbid market products and directbuy market product with buynow and nego products */
exports.getAdminResearchData = function(req, mysql, q, count) {
    var whr = '';

    $mysqli = { whr: whr };

    strQuery = mysqli.mysqli($mysqli, "get_aresearch_data");


    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}
/* Getting admin ob research data */
exports.getAdminOBResearchData = function(req, mysql, q, count) {
    var whr = '';

    $mysqli = { whr: whr };

if(count == 0){
    strQuery = mysqli.mysqli($mysqli, "get_obar_data");
} else if (count == 1) {
    strQuery = mysqli.mysqli($mysqli, "get_obar1_data");
}else if (count == 2) {
    strQuery = mysqli.mysqli($mysqli, "get_obar2_data");
}
    


    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}
exports.getAdminDBResearchData = function(req, mysql, q, count) {
    var whr = '';

    $mysqli = { whr: whr };

    if(count == 0){
        strQuery = mysqli.mysqli($mysqli, "get_dbar_data");
    } else if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, "get_dbar1_data");
    }else if (count == 2) {
        strQuery = mysqli.mysqli($mysqli, "get_dbar2_data");
    }

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}

/* Research data for both line charts for herbee market activity */
exports.getAdminMarketActivity = function(req, mysql, q, count) {
    var whr = '';

    var datge = dateFormat(new Date(), "yyyy-mm-dd");

    console.log(req.body.start_date)

    var datge = ((typeof(req.body.start_date) != 'undefined') && (req.body.start_date != '')) ? dateFormat(new Date(req.body.start_date), "yyyy-mm-dd") : dateFormat(new Date().setDate(new Date().getDate() - 30), "yyyy-mm-dd");
    var edatge = ((typeof(req.body.end_date) != 'undefined') && (req.body.end_date != '')) ? dateFormat(new Date(req.body.end_date), "yyyy-mm-dd") : dateFormat(new Date(), "yyyy-mm-dd");

    if(req.body.state != ''){
        whr = whr + ' and ue.state like "%'+req.session.state+'%" ';
    }

$mysqli = { whr: whr };

    // $mysqli = { datge: datge };
    strQuery = mysqli.mysqli($mysqli, "get_admin_mactivity");
    var defered = q.defer();
    // var escape_data = [datge, datge, datge, edatge]
    var escape_data = [datge, edatge]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(count+"::::;getAdminMarketActivity::"+query.sql)
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}

exports.getAdminOBPieData = function(req, mysql, q, count) {
    var whr = '';

    $mysqli = { whr: whr };

    strQuery = mysqli.mysqli($mysqli, "get_ob_pie_data");


    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}
exports.getAdminDBPieData = function(req, mysql, q, count) {
    var whr = '';

    $mysqli = { whr: whr };

    strQuery = mysqli.mysqli($mysqli, "get_db_pie_data");


    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}
exports.getMemRenewalDate = function(mysql, q,del,cnt) {

    $mysqli = {};
    if(cnt == 1){
        strQuery = mysqli.mysqli($mysqli, "getMemRenewalDetails");
        var escape_data = [];
    }else{
        strQuery = mysqli.mysqli($mysqli, "UpdateMemRenewalDetails");
        var escape_data = [del.nextRenewalDate,del.user_id];
    }
    var defered = q.defer();
    query = mysql.query(strQuery,escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}

exports.updateDistributorProduct = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    var d_invoice = '';
    if(req.files.d_invoice != undefined) {
        if(req.files.d_invoice.name != undefined) {
            d_invoice = req.files.d_invoice.name;
        }
    }

    strQuery = mysqli.mysqli($mysqli, 'updateDistributorProduct');
    escape_fields = [d_invoice, req.body.d_price, req.body.id];
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    delete req.session.aid;
    return defered.promise;

}

/**
 *  Buyer Dashboard - Active Products List
 */
exports.getActiveProductsSearch = function(req, mysql, q, count, flag) {
    var escape_data = [];

    var whereCond = 'products.id != 0 AND products.user_id != 0 ';
    if (req.body.categorySelected)
        whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and products.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        // whereCond += 'and FIND_IN_SET ('+ req.body.keywordSeach.toString() +', products.keywords)'
        whereCond += 'and (products.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR products.title like "%'+ req.body.keywordSeach.toString() +'%" OR products.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and products.user_id != '+ req.body.loggedUserId.toString() +' ';

    if(req.body.status && req.body.status != 'undefined')
        whereCond += 'and products.market_status IN ('+ req.body.status.toString() +') ';

    if(typeof(flag) != 'undefined' && flag != '')
        whereCond += 'and (SELECT COUNT(id) FROM bids WHERE project_id = products.id) > 0 ';

    if((typeof(req.body.start_price) != 'undefined' && req.body.start_price != '' && req.body.start_price != '0') && (typeof(req.body.end_price) != 'undefined' && req.body.end_price != '' && req.body.end_price != '0'))
        whereCond += 'and ( products.start_price >= ' + req.body.start_price.toString() + ' and products.start_price <= ' + req.body.end_price.toString() + ' ) ';
    else if(typeof(req.body.start_price) != 'undefined' && req.body.start_price != '' && req.body.start_price != '0')
        whereCond += 'and products.start_price >= ' + req.body.start_price.toString() + ' ';
    else if(typeof(req.body.end_price) != 'undefined' && req.body.end_price != '' && req.body.end_price != '0')
        whereCond += 'and products.start_price <= ' + req.body.end_price.toString() + ' ';

    var orderBy = '';
    if(typeof(req.body.sort_by) != "undefined" && req.body.sort_by != '') {
        if(req.body.sort_by == "price_asc")
            orderBy = 'ORDER BY products.start_price ASC ';
        else if(req.body.sort_by == "price_desc")
            orderBy = 'ORDER BY products.start_price DESC ';
        else if(req.body.sort_by == "startdate_asc")
            orderBy = 'ORDER BY products.start_date ASC ';
        else if(req.body.sort_by == "startdate_desc")
            orderBy = 'ORDER BY products.start_date DESC ';
        else if(req.body.sort_by == "enddate_asc")
            orderBy = 'ORDER BY products.end_date ASC ';
        else if(req.body.sort_by == "enddate_desc")
            orderBy = 'ORDER BY products.end_date DESC ';
        else if(req.body.sort_by == "id_asc")
            orderBy = 'ORDER BY products.id ASC ';
        else if(req.body.sort_by == "id_desc")
            orderBy = 'ORDER BY products.id DESC';
    }

    if(count == 1) {
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0, page, perlimit];
        $mysqli = {whereCond : whereCond, orderBy : orderBy};
        strQuery = mysqli.mysqli($mysqli, 'getAllOpenProductsLimit');
    } else if(count == 2) {
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0];
        $mysqli = {whereCond : whereCond};
        strQuery = mysqli.mysqli($mysqli, 'getAllOpenProductsCount');
    } else {
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0];
        $mysqli = {whereCond : whereCond};
        strQuery = mysqli.mysqli($mysqli, 'getAllOpenProducts');
    }
  
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('BUYER SQL : ', query.sql)

    return defered.promise;
}

/**
 *  Buyer Dashboard - Won Products List
 */
exports.getWonProductsSearch = function(req, mysql, q, count) { 
    var escape_data = [];

    var whereCond = 'products.id != 0 AND products.user_id != 0 ';
    if (req.body.categorySelected)
        whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and products.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        // whereCond += 'and FIND_IN_SET ('+ req.body.keywordSeach.toString() +', products.keywords)'
        whereCond += 'and (products.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR products.title like "%'+ req.body.keywordSeach.toString() +'%" OR products.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and products.user_id != '+ req.body.loggedUserId.toString() +' ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and bids.user_id = '+ req.body.loggedUserId.toString() +' ';

    whereCond += 'and bids.awarded = 1 ';

    var orderBy = '';
    if(typeof(req.body.sort_by) != "undefined" && req.body.sort_by != '') {
        if(req.body.sort_by == "price_asc")
            orderBy = 'ORDER BY products.start_price ASC ';
        else if(req.body.sort_by == "price_desc")
            orderBy = 'ORDER BY products.start_price DESC ';
        else if(req.body.sort_by == "startdate_asc")
            orderBy = 'ORDER BY products.start_date ASC ';
        else if(req.body.sort_by == "startdate_desc")
            orderBy = 'ORDER BY products.start_date DESC ';
        else if(req.body.sort_by == "enddate_asc")
            orderBy = 'ORDER BY products.end_date ASC ';
        else if(req.body.sort_by == "enddate_desc")
            orderBy = 'ORDER BY products.end_date DESC ';
        else if(req.body.sort_by == "id_asc")
            orderBy = 'ORDER BY products.id ASC ';
        else if(req.body.sort_by == "id_desc")
            orderBy = 'ORDER BY products.id DESC';
    }

    if(count) {
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0, page, perlimit];
        $mysqli = {whereCond : whereCond, orderBy : orderBy};
        strQuery = mysqli.mysqli($mysqli, 'getAllWonProductsLimit');
    } else {
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0];
        $mysqli = {whereCond : whereCond};
        strQuery = mysqli.mysqli($mysqli, 'getAllWonProductsCount');
    }
  
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('BUYER WON SQL : ', query.sql)

    return defered.promise;
}

/**
 *  Buyer Dashboard - Lost Products List
 */
exports.getLostProductsSearch = function(req, mysql, q, count) {
    var escape_data = [];

    var whereCond = 'products.id != 0 AND products.user_id != 0 ';
    if (req.body.categorySelected)
        whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and products.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        // whereCond += 'and FIND_IN_SET ('+ req.body.keywordSeach.toString() +', products.keywords)'
        whereCond += 'and (products.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR products.title like "%'+ req.body.keywordSeach.toString() +'%" OR products.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and products.user_id != '+ req.body.loggedUserId.toString() +' ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and bids.user_id = '+ req.body.loggedUserId.toString() +' ';

    whereCond += 'and bids.awarded = 0 ';

    var orderBy = '';
    if(typeof(req.body.sort_by) != "undefined" && req.body.sort_by != '') {
        if(req.body.sort_by == "price_asc")
            orderBy = 'ORDER BY products.start_price ASC ';
        else if(req.body.sort_by == "price_desc")
            orderBy = 'ORDER BY products.start_price DESC ';
        else if(req.body.sort_by == "startdate_asc")
            orderBy = 'ORDER BY products.start_date ASC ';
        else if(req.body.sort_by == "startdate_desc")
            orderBy = 'ORDER BY products.start_date DESC ';
        else if(req.body.sort_by == "enddate_asc")
            orderBy = 'ORDER BY products.end_date ASC ';
        else if(req.body.sort_by == "enddate_desc")
            orderBy = 'ORDER BY products.end_date DESC ';
        else if(req.body.sort_by == "id_asc")
            orderBy = 'ORDER BY products.id ASC ';
        else if(req.body.sort_by == "id_desc")
            orderBy = 'ORDER BY products.id DESC';
    }

    if(count) {
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0, page, perlimit];
        $mysqli = {whereCond : whereCond, orderBy : orderBy};
        strQuery = mysqli.mysqli($mysqli, 'getAllLostProductsLimit');
    } else {
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0];
        $mysqli = {whereCond : whereCond};
        strQuery = mysqli.mysqli($mysqli, 'getAllLostProductsCount');
    }
  
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('BUYER LOST SQL : ', query.sql)

    return defered.promise;
}

/**
 *  Seller Dashboard - Products List
 */
exports.getSellerProductsSearch = function(req, mysql, q, count) {
    var escape_data = [];
    var whereCond = 'products.id != 0 AND products.user_id != 0 ';
    if (req.body.categorySelected)
        whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and products.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        whereCond += 'and (products.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR products.title like "%'+ req.body.keywordSeach.toString() +'%" OR products.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and products.user_id = '+ req.body.loggedUserId.toString() +' ';

    if(req.body.status && req.body.status != 'undefined')
        whereCond += 'and products.market_status IN ('+ req.body.status.toString() +')';
    
    var orderBy = '';
    if(typeof(req.body.sort_by) != "undefined" && req.body.sort_by != '') {
        if(req.body.sort_by == "price_asc")
            orderBy = 'ORDER BY products.start_price ASC ';
        else if(req.body.sort_by == "price_desc")
            orderBy = 'ORDER BY products.start_price DESC ';
        else if(req.body.sort_by == "startdate_asc")
            orderBy = 'ORDER BY products.start_date ASC ';
        else if(req.body.sort_by == "startdate_desc")
            orderBy = 'ORDER BY products.start_date DESC ';
        else if(req.body.sort_by == "enddate_asc")
            orderBy = 'ORDER BY products.end_date ASC ';
        else if(req.body.sort_by == "enddate_desc")
            orderBy = 'ORDER BY products.end_date DESC ';
        else if(req.body.sort_by == "id_asc")
            orderBy = 'ORDER BY products.id ASC ';
        else if(req.body.sort_by == "id_desc")
            orderBy = 'ORDER BY products.id DESC';
    }

    if(count) {
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0, page, perlimit];
        $mysqli = {whereCond : whereCond, orderBy : orderBy};
        strQuery = mysqli.mysqli($mysqli, 'getAllSellerProductsLimit');
    } else {
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0];
        $mysqli = {whereCond : whereCond};
        strQuery = mysqli.mysqli($mysqli, 'getAllSellerProductsCount');
    }
  
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('SELLER PRODUCT SQL : ', query.sql)

    return defered.promise;
}