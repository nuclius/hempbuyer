var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');

exports.getProduct = function (req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getProduct');
    var escape_data = [req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getProduct", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
}


exports.getStateList = function (req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getStateList');
    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log("getStateList", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
}

exports.deletecertificate = function (req, res, mysql, q) {
    $mysqli = {};
    var escape_data = [req.body.certificate_id];
    strQuery = mysqli.mysqli($mysqli, 'deletecertificate');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.saveProduct = function (req, res, mysql, q) {
    // productData = req.body.productData;
    // req.body.contaminant_screening_data = req.body.hms + "," + req.body.micro_ms + "," + req.body.prs + "," + req.body.srs;
    //req.body.certificate_types = '';
    var loggedUserId = req.session.userid ? req.session.userid : 0;
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
    (req.body.srs ? req.body.srs : '') + ',' +
    (req.body.terpene_profile ? req.body.terpene_profile : '');

    $mysqli = {};
    var escape_data = [
        loggedUserId,
        req.body.title,
        dateFormat(req.body.start_date, "yyyy-mm-dd HH:MM"),
        dateFormat(req.body.end_date, "yyyy-mm-dd HH:MM"),
        req.body.category_id,
        req.body.subcategory_id,
        req.body.type,
        req.body.type == 'auction' ? 1 : 0,
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
        req.body.packaging_description, 
        req.body.unit_of_measurement,
        dateFormat(req.body.manufacture_date, "yyyy-mm-dd HH:MM"),
        req.body.certificate_types,
        dateFormat(req.body.certificate_date, "yyyy-mm-dd HH:MM"),
        req.body.contaminant_screening ? req.body.contaminant_screening : 0,
        req.body.contaminant_screening_data,
        req.body.sops,
        req.body.payment_method ? req.body.payment_method : '',
        req.body.payment_method_other ? req.body.payment_method_other : '',
        '', //req.body.product_image.length ? req.body.product_image[0] : '',
        'open',
        req.body.amount_sold ? req.body.amount_sold : 0,
        req.body.moq ? req.body.moq : 0,
        req.body.product_place ? req.body.product_place : '',
        req.body.product_renew ? req.body.product_renew : '',
        req.body.qty_available ? req.body.qty_available : '',
        req.body.keywords ? req.body.keywords : null,
        req.body.amount_sold ? req.body.amount_sold : 0
    ];
    //console.log('escape_data', escape_data);
    strQuery = mysqli.mysqli($mysqli, 'insertProduct');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("saveProduct", query.sql);
    query.on('error', function (err) {
        console.log("Error in saveProduct", err);
    })
    return defered.promise;
}

exports.saveProductDocument = function (req, res, mysql, q, imageData, product_id) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var extension = imageData.name.split('.')[1];
    var fileType = '';
    if(extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
        fileType = 'image';
    } else {
        fileType = 'pdf';
    }
    $mysqli = {};
    var escape_data = [
        product_id,
        imageData.name,
        imageData.name,
        datge,
        0,
        fileType
    ];
    strQuery = mysqli.mysqli($mysqli, 'saveProductDocument');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.savecertificatesDocument = function (req, res, mysql, q, certificateData, product_id, user_id) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {};
    var escape_data = [
        user_id,
        product_id,
        certificateData.name,
        certificateData.fileType,
        1,
        datge,
    ];
    strQuery = mysqli.mysqli($mysqli, 'savecertificatesDocument');
    var defered = q.defer(); 
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('savecertificatesDocument query', query.sql);
    return defered.promise;
}




exports.relistProductToAuction = function (req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'relistProductToAuction');
    query = mysql.query(strQuery, [req.body.newQty, req.body.startPrice, req.body.startPrice, req.body.reservePrice, req.body.id], defered.makeNodeResolver());
    console.log("relistProductToAuction", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
}


exports.clearProductBidHistory = function (req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'clearProductBidHistory');
    query = mysql.query(strQuery, [req.body.id], defered.makeNodeResolver());
    console.log("clearProductBidHistory", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
} 


exports.getProductDetails = function (req, mysql, q) {
    $mysqli = {}
    var userid = req.session.userid ? req.session.userid : 0;
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getProductDetails');
    query = mysql.query(strQuery, [userid, req.body.id], defered.makeNodeResolver());
    console.log("getProductDetails", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
}



exports.insertBuyNowRecord = function (req, mysql, q, data) {
    $mysqli = {}
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'insertBuyNowRecord');
    console.log(data, "data")
    var escape_data = [
        data.projectId,
        req.session.userid,
        data.amount,
        data.type,
        data.paid,
        data.qty,
        datge,
        datge
    ];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("insertBuyNow", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
}

exports.updateBuyNow = function (req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'updateBuyNow');
    query = mysql.query(strQuery, [req.body.buyQty, req.body.id], defered.makeNodeResolver());
    console.log("updateBuyNow", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
}
exports.updateBuyNowOffer = function (req, mysql, q) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'updateBuyNowOffer');
    query = mysql.query(strQuery, [datge, req.body.buyQty, req.body.id], defered.makeNodeResolver());
    console.log("updateBuyNowOffer", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
}



exports.getBidHistory = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getBidHistory');
    var escape_data = [req.body.id]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.getProductSellerDetail = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getProductSellerDetail');
    var escape_data = [req.body.id]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}



exports.placeBid = function (req, mysql, q) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 20);
    var escape_data = [req.body.id,
        (typeof (req.session.userid) !== 'undefined') ? req.session.userid : '1',
        datge,
        req.body.enteramount
    ]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}





exports.updateWinPrice = function (req, mysql, q) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'updateWinPrice');
    var escape_data = [ req.body.enteramount, req.body.id]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.getProductImages = function (req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getProductImages');
    query = mysql.query(strQuery, [req.body.id], defered.makeNodeResolver());
    console.log("getProductImages", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProduct", err);
    })
    return defered.promise;
}

exports.getDetailBidHistory = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getDetailBidHistory');
    var escape_data = [req.body.id]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.getProductForClose = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getProductForClose');
    datge = dateFormat(new Date(), "yyyy-mm-dd H:MM:ss"); 
    escape_fields = [datge]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    //  console.log('Close Product SQL : ', query.sql)
    return defered.promise;
}

exports.closeProjects = function (req, mysql, q, status, pid) {
    
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'closeProjects'); 
    escape_fields = [status, pid]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    // console.log('Product closing  : ', query.sql)
    return defered.promise;
}

/**
 *  Save Product to Draft
 */
exports.saveProductToDraft = function (req, res, mysql, q) {
    // req.body.contaminant_screening_data = req.body.hms + "," + req.body.micro_ms + "," + req.body.prs + "," + req.body.srs;
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
    (req.body.srs ? req.body.srs : '') + ',' +
    (req.body.terpene_profile ? req.body.terpene_profile : '');

    var loggedUserId = req.session.userid ? req.session.userid : 0;
    $mysqli = {};
    var escape_data = [
        loggedUserId,
        req.body.title ? req.body.title : '',
        req.body.start_date ? dateFormat(req.body.start_date, "yyyy-mm-dd HH:MM") : '',
        req.body.end_date ? dateFormat(req.body.end_date, "yyyy-mm-dd HH:MM") : '',
        req.body.category_id ? req.body.category_id : 0,
        req.body.subcategory_id ? req.body.subcategory_id : 0,
        req.body.type ? req.body.type : '',
        req.body.type == 'auction' ? 1 : 0,
        req.body.is_buynow ? req.body.is_buynow : 0,
        req.body.start_price ? req.body.start_price : 0,
        req.body.reserve_price ? req.body.reserve_price : 0,
        req.body.buynow_price ? req.body.buynow_price : 0,
        req.body.buynow_qty ? req.body.buynow_qty : 0,
        req.body.fixed_price ? req.body.fixed_price : 0,
        req.body.fixed_qty ? req.body.fixed_qty : 0,
        req.body.offer_price ? req.body.offer_price : 0,
        req.body.offer_qty ? req.body.offer_qty : 0,
        req.body.description ? req.body.description : '',
        req.body.packaging_description ? req.body.packaging_description : '', 
        req.body.unit_of_measurement ? req.body.unit_of_measurement : '',
        req.body.manufacture_date ? dateFormat(req.body.manufacture_date, "yyyy-mm-dd HH:MM") : '',
        req.body.certificate_types ? req.body.certificate_types : '',
        req.body.certificate_date ? dateFormat(req.body.certificate_date, "yyyy-mm-dd HH:MM") : '',
        req.body.contaminant_screening ? req.body.contaminant_screening : 0,
        req.body.contaminant_screening_data ? req.body.contaminant_screening_data : '',
        req.body.sops ? req.body.sops : '',
        req.body.payment_method ? req.body.payment_method : '',
        req.body.payment_method_other ? req.body.payment_method_other : '',
        '', //req.body.product_image.length ? req.body.product_image[0] : '',
        'draft',
        req.body.amount_sold ? req.body.amount_sold : 0,
        req.body.moq ? req.body.moq : 0,
        req.body.product_place ? req.body.product_place : '',
        req.body.product_renew ? req.body.product_renew : '',
        req.body.qty_available ? req.body.qty_available : 0,
        req.body.keywords ? req.body.keywords : null,
        req.body.amount_sold ? req.body.amount_sold : 0
    ];
    console.log('escape_data', escape_data);
    strQuery = mysqli.mysqli($mysqli, 'insertProduct');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log("saveProduct", query.sql);
    query.on('error', function (err) {
        console.log("Error in saveProduct", err);
    });
    return defered.promise;
}

/**
 *  Save Product Video URL
 */
exports.saveProductVideoUrl = function (req, res, mysql, q, video_url, product_id) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var escape_data = [
        product_id,
        video_url,
        video_url,
        datge,
        0,
        'video'
    ];
    strQuery = mysqli.mysqli($mysqli, 'saveProductDocument');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
/**
 *  Delete Product Video URL
 */
exports.deleteProductDocument = function (req, res, mysql, q, product_id, type) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var escape_data = [
        type,
        product_id
    ];
    strQuery = mysqli.mysqli($mysqli, 'deleteProductDocument');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("deleteProductDocument", query.sql);
    return defered.promise;
}
/**
 *  Delete Product Video URL
 */
exports.deleteProductDocumentByName = function (req, mysql, q, name) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var escape_data = [
        name
    ];
    strQuery = mysqli.mysqli($mysqli, 'deleteProductDocumentByName');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("deleteProductDocumentByName", query.sql);
    return defered.promise;
}
/**
 *  Delete Certificate
 */
exports.deleteCertificateByName = function (req, mysql, q, name) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var escape_data = [
        name
    ];
    strQuery = mysqli.mysqli($mysqli, 'deleteCertificateByName');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("deleteCertificateByName", query.sql);
    return defered.promise;
}

/**
 *  Get Product Certificate
 */
exports.getProductCertificate = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getProductCertificate');
    query = mysql.query(strQuery, [req.body.id], defered.makeNodeResolver());
    //console.log("getProductCertificate", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProductCertificate ", err);
    })
    return defered.promise;
}

/**
 *  Get Product Media Files
 */
exports.getProductMediaFiles = function (req, mysql, q, type) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getProductMediaFiles');
    query = mysql.query(strQuery, [req.body.id, type], defered.makeNodeResolver());
    //console.log("getProductMediaFiles", query.sql);
    query.on('error', function (err) {
        console.log("Error in getProductMediaFiles ", err);
    })
    return defered.promise;
}

/**
 *  Update Drafted Product
 */
exports.updateDraftProduct = function (req, res, mysql, q) {
    // req.body.contaminant_screening_data = req.body.hms + "," + req.body.micro_ms + "," + req.body.prs + "," + req.body.srs;
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
    (req.body.srs ? req.body.srs : '') + ',' +
    (req.body.terpene_profile ? req.body.terpene_profile : '');

    var loggedUserId = req.session.userid ? req.session.userid : 0;
    $mysqli = {};

    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //req.body.end_date <= currentDate
    var escape_data = [
        loggedUserId,
        req.body.title ? req.body.title : '',
        req.body.start_date ? dateFormat(req.body.start_date, "yyyy-mm-dd HH:MM") : '',
        req.body.end_date ? dateFormat(req.body.end_date, "yyyy-mm-dd HH:MM") : '',
        req.body.category_id ? req.body.category_id : 0,
        req.body.subcategory_id ? req.body.subcategory_id : 0,
        req.body.type ? req.body.type : '',
        req.body.type == 'auction' ? 1 : 0,
        req.body.is_buynow ? req.body.is_buynow : 0,
        req.body.start_price ? req.body.start_price : 0,
        req.body.reserve_price ? req.body.reserve_price : 0,
        req.body.buynow_price ? req.body.buynow_price : 0,
        req.body.buynow_qty ? req.body.buynow_qty : 0,
        req.body.fixed_price ? req.body.fixed_price : 0,
        req.body.fixed_qty ? req.body.fixed_qty : 0,
        req.body.offer_price ? req.body.offer_price : 0,
        req.body.offer_qty ? req.body.offer_qty : 0,
        req.body.description ? req.body.description : '',
        req.body.packaging_description ? req.body.packaging_description : '', 
        req.body.unit_of_measurement ? req.body.unit_of_measurement : '',
        req.body.manufacture_date ? dateFormat(req.body.manufacture_date, "yyyy-mm-dd HH:MM") : '',
        req.body.certificate_types ? req.body.certificate_types : '',
        req.body.certificate_date ? dateFormat(req.body.certificate_date, "yyyy-mm-dd HH:MM") : '',
        req.body.contaminant_screening ? req.body.contaminant_screening : 0,
        req.body.contaminant_screening_data ? req.body.contaminant_screening_data : '',
        req.body.sops ? req.body.sops : '',
        req.body.payment_method ? req.body.payment_method : '',
        req.body.payment_method_other ? req.body.payment_method_other : '',
        '', //req.body.product_image.length ? req.body.product_image[0] : '',
        'draft',
        req.body.amount_sold ? req.body.amount_sold : 0,
        req.body.moq ? req.body.moq : 0,
        req.body.product_place ? req.body.product_place : '',
        req.body.product_renew ? req.body.product_renew : '',
        req.body.qty_available ? req.body.qty_available : 0,
        req.body.keywords ? req.body.keywords : null,
        req.body.amount_sold ? req.body.amount_sold : 0,
        req.body.product_id
    ];
    console.log('escape_data', escape_data);
    strQuery = mysqli.mysqli($mysqli, 'updateProduct');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("updateDraftProduct", query.sql);
    query.on('error', function (err) {
        console.log("Error in updateDraftProduct", err);
    });
    return defered.promise;
}
exports.updateProduct = function (req, res, mysql, q) {
    // req.body.contaminant_screening_data = req.body.hms + "," + req.body.micro_ms + "," + req.body.prs + "," + req.body.srs;
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
    (req.body.srs ? req.body.srs : '') + ',' +
    (req.body.terpene_profile ? req.body.terpene_profile : '');

    var loggedUserId = req.session.userid ? req.session.userid : 0;
    $mysqli = {};

    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //req.body.end_date <= currentDate
    var escape_data = [
        loggedUserId,
        req.body.title ? req.body.title : '',
        req.body.start_date ? dateFormat(req.body.start_date, "yyyy-mm-dd HH:MM") : '',
        req.body.end_date ? dateFormat(req.body.end_date, "yyyy-mm-dd HH:MM") : '',
        req.body.category_id ? req.body.category_id : 0,
        req.body.subcategory_id ? req.body.subcategory_id : 0,
        req.body.type ? req.body.type : '',
        req.body.type == 'auction' ? 1 : 0,
        req.body.is_buynow ? req.body.is_buynow : 0,
        req.body.start_price ? req.body.start_price : 0,
        req.body.reserve_price ? req.body.reserve_price : 0,
        req.body.buynow_price ? req.body.buynow_price : 0,
        req.body.buynow_qty ? req.body.buynow_qty : 0,
        req.body.fixed_price ? req.body.fixed_price : 0,
        req.body.fixed_qty ? req.body.fixed_qty : 0,
        req.body.offer_price ? req.body.offer_price : 0,
        req.body.offer_qty ? req.body.offer_qty : 0,
        req.body.description ? req.body.description : '',
        req.body.packaging_description ? req.body.packaging_description : '', 
        req.body.unit_of_measurement ? req.body.unit_of_measurement : '',
        req.body.manufacture_date ? dateFormat(req.body.manufacture_date, "yyyy-mm-dd HH:MM") : '',
        req.body.certificate_types ? req.body.certificate_types : '',
        req.body.certificate_date ? dateFormat(req.body.certificate_date, "yyyy-mm-dd HH:MM") : '',
        req.body.contaminant_screening ? req.body.contaminant_screening : 0,
        req.body.contaminant_screening_data ? req.body.contaminant_screening_data : '',
        req.body.sops ? req.body.sops : '',
        req.body.payment_method ? req.body.payment_method : '',
        req.body.payment_method_other ? req.body.payment_method_other : '',
        '', //req.body.product_image.length ? req.body.product_image[0] : '',
        'open',
        req.body.amount_sold ? req.body.amount_sold : 0,
        req.body.moq ? req.body.moq : 0,
        req.body.product_place ? req.body.product_place : '',
        req.body.product_renew ? req.body.product_renew : '',
        req.body.qty_available ? req.body.qty_available : 0,
        req.body.keywords ? req.body.keywords : null,
        req.body.amount_sold ? req.body.amount_sold : 0,
        req.body.product_id
    ];
    console.log('escape_data', escape_data);
    strQuery = mysqli.mysqli($mysqli, 'updateProduct');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("saveProduct", query.sql);
    query.on('error', function (err) {
        console.log("Error in updateProduct", err);
    });
    return defered.promise;
}

exports.getOpenProductIds = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getOpenProductIds');
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    escape_fields = [datge]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.getOpenProductList = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getOpenProductList');
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    escape_fields = [datge]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.updateOpenProductStatus = function (req, mysql, q, pid) {
    $mysqli = {};
    var defered = q.defer();
    $mysqli = { id : pid };
    strQuery = mysqli.mysqli($mysqli, 'updateOpenProductStatus'); 
    escape_fields = ['closed']
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

/**
 *  Get Measurements
 */
exports.getMeasurements = function (req, mysql, q, type) {
    var where = " status = '" + escape(type) + "' ";
    $mysqli = { whereCond : where, orderBy : '' };
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'checkMeasurementName');
    query = mysql.query(strQuery, [], defered.makeNodeResolver());
    console.log("getMeasurements", query.sql);
    query.on('error', function (err) {
        console.log("Error in getMeasurements", err);
    })
    return defered.promise;
}

/**
 *  Find Product in Watchlist
 */
exports.getWatchlist = function(req, mysql, q) {
    var escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0, req.body.productId];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getWatchlist');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('FIND WATCHLIST SQL : ', query.sql)
    return defered.promise;
}

/**
 *  Insert / Update Watchlist Status
 */
exports.updateWatchlistStatus = function(req, mysql, q, id) {
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0, req.body.productId, req.body.status, currentDate, id];
    $mysqli = {};
    if(id != "" && id != 0)
        strQuery = mysqli.mysqli($mysqli, 'updateWatchlist');
    else
        strQuery = mysqli.mysqli($mysqli, 'insertWatchlist');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('INSERT / UPDATE WATCHLIST SQL : ', query.sql)
    return defered.promise;
}

/**
 *  Buyer Dashboard - Watchlist List
 */
exports.getWatchlistSearch = function(req, mysql, q, count) {
    var escape_data = [];

    var whereCond = 'products.id != 0 ';
    if (req.body.categorySelected)
        whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and products.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        // whereCond += 'and FIND_IN_SET ('+ req.body.keywordSeach.toString() +', products.keywords)'
        whereCond += 'and (products.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR products.title like "%'+ req.body.keywordSeach.toString() +'%" OR products.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and w.user_id = '+ req.body.loggedUserId.toString() +' ';

    whereCond += 'and w.status = "active" ';
    whereCond += 'and products.market_status != "closed" ';

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
        strQuery = mysqli.mysqli($mysqli, 'getAllWatchlistLimit');
    } else if(count == 2) {
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0];
        $mysqli = {whereCond : whereCond};
        strQuery = mysqli.mysqli($mysqli, 'getAllWatchlistCount');
    } else {
        escape_data = [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0];
        $mysqli = {whereCond : whereCond};
        strQuery = mysqli.mysqli($mysqli, 'getAllWatchlist');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('WATCHLIST SQL : ', query.sql)
    return defered.promise;
}

/**
 *  Buyer Dashboard - Active Products List
 */
exports.getActiveProductsSearch = function(req, mysql, q, count, flag) {
    var escape_data = [];
console.log('req.body.categorySelected', req.body.categorySelected);

    var whereCond = 'products.id != 0 AND products.user_id != 0 ';
    if (req.body.categorySelected){
        if(req.body.subCategorySelected){
        whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') or products.subcategory_id in('+  req.body.subCategorySelected.toString() +') ';
        }
        else{
            whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') ';
        }

    }else if(req.body.subCategorySelected){
        whereCond += ' and products.subcategory_id in('+  req.body.subCategorySelected.toString() +') ';
    }

    if (req.body.stateSelected)
        whereCond += 'and products.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        // whereCond += 'and FIND_IN_SET ('+ req.body.keywordSeach.toString() +', products.keywords)'
        whereCond += 'and (' +
        'products.keywords like "%'+ req.body.keywordSeach.toString() +'%"' + 
        ' OR products.title like "%'+ req.body.keywordSeach.toString() +'%"' + 
        ' OR products.description like "%'+ req.body.keywordSeach.toString() +'%"' + 
        (req.body.keywordSeach.toString().split('PRODUCT').length > 1 ? ' OR products.id LIKE TRIM(LEADING "0" FROM '+ req.body.keywordSeach.toString().split('PRODUCT')[1] +') ' : '')
        + ') ';

    /* if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and products.user_id != '+ req.body.loggedUserId.toString() +' '; */

    if(req.body.status && req.body.status != 'undefined')
        whereCond += 'and products.market_status IN ('+ req.body.status.toString() +') ';

    if(req.body.filter_type && req.body.filter_type != 'undefined')
        whereCond += 'and products.type = "'+ req.body.filter_type + '" ';
    
    if(typeof(flag) != 'undefined' && flag != '')
        whereCond += 'and (SELECT COUNT(id) FROM bids WHERE project_id = products.id) > 0 ';

    if((typeof(req.body.start_price) != 'undefined' && req.body.start_price != '' && req.body.start_price != '0') && (typeof(req.body.end_price) != 'undefined' && req.body.end_price != '' && req.body.end_price != '0'))
        whereCond += 'and ( products.start_price >= ' + req.body.start_price.toString() + ' and products.start_price <= ' + req.body.end_price.toString() + ' ) ';
    else if(typeof(req.body.start_price) != 'undefined' && req.body.start_price != '' && req.body.start_price != '0')
        whereCond += 'and products.start_price >= ' + req.body.start_price.toString() + ' ';
    else if(typeof(req.body.end_price) != 'undefined' && req.body.end_price != '' && req.body.end_price != '0')
        whereCond += 'and products.start_price <= ' + req.body.end_price.toString() + ' ';

    if (req.body.attributeSelected) {
        var whereAttr = [];
        if(Array.isArray(req.body.attributeSelected)) {
            for (var index = 0; index < req.body.attributeSelected.length; index++) {
                whereAttr.push('FIND_IN_SET('+ req.body.attributeSelected[index] +', products.certificate_types)');
            }
            whereCond += " AND (" + whereAttr.join(" OR ") + ") ";
        } else {
            whereCond += " AND FIND_IN_SET(" + req.body.attributeSelected + ", products.certificate_types) ";
        }
    }
    if (req.body.screeningSelected) {
        var whereAttr = [];
        if(Array.isArray(req.body.screeningSelected)) {
            for (var index = 0; index < req.body.screeningSelected.length; index++) {
                whereAttr.push('FIND_IN_SET('+ req.body.screeningSelected[index] +', products.contaminant_screening_data)');
            }
            whereCond += " AND (" + whereAttr.join(" OR ") + ") ";
        } else {
            whereCond += " AND FIND_IN_SET(" + req.body.screeningSelected + ", products.contaminant_screening_data) ";
        }
    }
    
    //var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:00");
    //whereCond += 'and products.start_date >= "' + currentDate.toString() + '" ';
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd");
    whereCond += 'and "'+currentDate+'" BETWEEN DATE(products.start_date) AND DATE(products.end_date) ';

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
/* exports.getWonProductsSearch = function(req, mysql, q, count) { 
    var escape_data = [];

    var whereCond = 'products.id != 0 AND products.user_id != 0 AND products.market_status!="open" AND b.type="Auction"';
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
        whereCond += 'and b.userId = '+ req.body.loggedUserId.toString() +' ';


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

    var userId = (typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0;
    var having = '';
    
    var limit = '';
    if(count) {
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        limit = ' LIMIT '+page+', '+perlimit;
    }
    escape_data = [config.general.transaction_fee_per, userId];
    $mysqli = {whereCond : whereCond, orderBy : orderBy, having: having, limit: limit};
    strQuery = mysqli.mysqli($mysqli, 'get_all_won_products');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('BUYER WON SQL : ', query.sql);
    query.on('error', function (err) {
        console.log("Error in get_all_won_products", err);
    });
    return defered.promise;
} */

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
    whereCond += 'and bids.status = 1 ';

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
    var userId = (typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0;
    var having = '';
    if(userId) {
        having = 'HAVING highBidder!='+userId;
    }

    if(count) {
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        escape_data = [userId, page, perlimit];
        $mysqli = {whereCond : whereCond, orderBy : orderBy, having: having};
        strQuery = mysqli.mysqli($mysqli, 'getAllLostProductsLimit');
    } else {
        escape_data = [userId];
        $mysqli = {whereCond : whereCond, having: having};
        strQuery = mysqli.mysqli($mysqli, 'getAllLostProductsCount');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('BUYER LOST SQL : ', query.sql)
    return defered.promise;
}

/**
 *  Buyer Dashboard - Buy Products List
 */
exports.getBuyProductsSearch = function(req, mysql, q, count) {
    var escape_data = [];

    var whereCond = 'p.id != 0 AND p.user_id != 0 AND i.type="'+req.body.list_type+'"';
    if (req.body.categorySelected)
        whereCond += 'and p.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and p.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        // whereCond += 'and FIND_IN_SET ('+ req.body.keywordSeach.toString() +', products.keywords)'
        whereCond += 'and (p.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR p.title like "%'+ req.body.keywordSeach.toString() +'%" OR p.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and p.user_id != '+ req.body.loggedUserId.toString() +' ';

    if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
        whereCond += 'and i.user_id = '+ req.body.loggedUserId.toString() +' ';    

    var orderBy = '';
    if(typeof(req.body.sort_by) != "undefined" && req.body.sort_by != '') {
        if(req.body.sort_by == "price_asc")
            orderBy = 'ORDER BY p.start_price ASC ';
        else if(req.body.sort_by == "price_desc")
            orderBy = 'ORDER BY p.start_price DESC ';
        else if(req.body.sort_by == "startdate_asc")
            orderBy = 'ORDER BY p.start_date ASC ';
        else if(req.body.sort_by == "startdate_desc")
            orderBy = 'ORDER BY p.start_date DESC ';
        else if(req.body.sort_by == "enddate_asc")
            orderBy = 'ORDER BY p.end_date ASC ';
        else if(req.body.sort_by == "enddate_desc")
            orderBy = 'ORDER BY p.end_date DESC ';
        else if(req.body.sort_by == "id_asc")
            orderBy = 'ORDER BY p.id ASC ';
        else if(req.body.sort_by == "id_desc")
            orderBy = 'ORDER BY p.id DESC';
    }

    var userid = (typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0;
    var limit = '';
    if(!count) {
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        limit = 'LIMIT '+page+', '+perlimit;
    }
    escape_data = [config.general.transaction_fee_per];
    $mysqli = { whereCond : whereCond, orderBy : orderBy, limit: limit };
    strQuery = mysqli.mysqli($mysqli, 'getAllBuyProductsLimit');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('BUYER BUY SQL : ', query.sql)
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
        whereCond += 'and products.market_status IN ('+ req.body.status.toString() +') ';

    //var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:00");
    //whereCond += 'and products.start_date >= "' + currentDate.toString() + '" ';
    /*var currentDate = dateFormat(new Date(), "yyyy-mm-dd");
    whereCond += 'and "'+currentDate+'" BETWEEN DATE(products.start_date) AND DATE(products.end_date) ';*/
    
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

exports.getAllOpenProductsLimit = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getAllOpenProductsLimit');
    var defered = q.defer();
    query = mysql.query(strQuery, [req.session.userid ? req.session.userid : 0], defered.makeNodeResolver());
    console.log('SQL getAllOpenProductsLimit : ', query.sql)
    return defered.promise;
}

exports.getOpenProducts = function(req, mysql, q) { 
    //var whereCond = 'products.id != 0 and products.market_status = "open" AND products.user_id != 0 ';
    var whereCond = 'products.id != 0 and products.user_id != 0 ';
    // if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
    //     whereCond += 'and products.user_id = '+ req.body.loggedUserId.toString() +'';

    if(typeof(req.body.status) != 'undefined' && req.body.status != "")
        whereCond += 'and products.market_status IN ('+ req.body.status.toString() +') ';

    //var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:00");
    //whereCond += 'and products.start_date >= "' + currentDate.toString() + '" ';
    /*if(typeof(req.body.status) != 'undefined' && req.body.status != "'draft'") {
        var currentDate = dateFormat(new Date(), "yyyy-mm-dd");
        whereCond += 'and "'+currentDate+'" BETWEEN DATE(products.start_date) AND DATE(products.end_date) ';
    }*/

    $mysqli = {whereCond : whereCond};
    strQuery = mysqli.mysqli($mysqli, 'getAllOpenProducts');
    var defered = q.defer();
    query = mysql.query(strQuery, [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0], defered.makeNodeResolver());
    console.log('SQL all : ', query.sql)
    return defered.promise;
}
exports.getFeaturedProducts = function(req, mysql, q) { 
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var limitProduct = config.general.featured_products_limit ? config.general.featured_products_limit : 5;
    var limit = " LIMIT 0," + limitProduct;
    var whereCond = 'products.market_status="open" AND products.id != 0 and products.user_id != 0 AND products.is_featured=1';
    whereCond += ' AND date_format(products.f_start_date, "%m-%d-%Y %H:%i:%s") <= date_format("'+cdate+'", "%m-%d-%Y %H:%i:%s") AND date_format(products.f_end_date, "%m-%d-%Y %H:%i:%s") >= date_format("'+cdate+'", "%m-%d-%Y %H:%i:%s")';

    $mysqli = {whereCond : whereCond, limit: limit};
    strQuery = mysqli.mysqli($mysqli, 'getFeaturedProducts');
    var defered = q.defer();
    query = mysql.query(strQuery, [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0], defered.makeNodeResolver());
    console.log('getFeaturedProducts', query.sql)
    return defered.promise;
}
exports.getUpcomingProducts = function(req, mysql, q) {
    var limitProduct = config.general.upcoming_products_limit ? config.general.upcoming_products_limit : 5;
    var limit = " LIMIT 0," + limitProduct;

    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var whereCond = ' date_format(products.start_date, "%m-%d-%Y %H:%i:%s") > date_format("'+cdate+'", "%m-%d-%Y %H:%i:%s")';

    $mysqli = {whereCond: whereCond, limit: limit};
    strQuery = mysqli.mysqli($mysqli, 'getUpcomingProducts');
    var defered = q.defer();
    query = mysql.query(strQuery, [(typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0], defered.makeNodeResolver());
    console.log('getUpcomingProducts', query.sql)
    return defered.promise;
}

exports.getOpenProductsSearch = function(req, mysql, q, count, currentUser) {
    var escape_data = [];
    //var whereCond = 'products.market_status = "open"';
    //var whereCond = 'products.id != 0 and products.market_status = "open" AND products.user_id != 0 ';
    var whereCond = 'products.id != 0 and products.user_id != 0 ';
    if (req.body.categorySelected)
        whereCond += 'and products.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and products.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        // whereCond += 'and FIND_IN_SET ('+ req.body.keywordSeach.toString() +', products.keywords)'
        whereCond += 'and (products.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR products.title like "%'+ req.body.keywordSeach.toString() +'%" OR products.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    // if(req.body.loggedUserId && req.body.loggedUserId != 'undefined' && req.body.loggedUserId != 0)
    //     whereCond += 'and products.user_id = '+ req.body.loggedUserId.toString() +' ';

    if(typeof(req.body.status) != 'undefined' && req.body.status != "")
        whereCond += 'and products.market_status IN ('+ req.body.status.toString() +') ';

    if(currentUser)
        whereCond += 'and products.user_id = ' + req.session.userid + ' ';

    //var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:00");
    //whereCond += 'and products.start_date >= "' + currentDate.toString() + '" ';
    /*if(typeof(req.body.status) != 'undefined' && req.body.status != "'draft'") {
        var currentDate = dateFormat(new Date(), "yyyy-mm-dd");
        whereCond += 'and "'+currentDate+'" BETWEEN DATE(products.start_date) AND DATE(products.end_date) ';
    }*/

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

/**
 *  Seller Dashboard - Sold Products List
 */
exports.getSoldProductsSearch = function(req, mysql, q, count) {
    var escape_data = [];
    var whereCond = 'p.id != 0 and p.user_id != 0 ';
    if (req.body.categorySelected)
        whereCond += 'and p.category_id in('+ req.body.categorySelected.toString() +') ';

    if (req.body.stateSelected)
        whereCond += 'and p.product_place in('+ req.body.stateSelected.toString() +') ';

    if (req.body.keywordSeach)
        whereCond += 'and (p.keywords like "%'+ req.body.keywordSeach.toString() +'%" OR p.title like "%'+ req.body.keywordSeach.toString() +'%" OR p.description like "%'+ req.body.keywordSeach.toString() +'%") ';

    var orderBy = '';
    if(typeof(req.body.sort_by) != "undefined" && req.body.sort_by != '') {
        if(req.body.sort_by == "price_asc")
            orderBy = 'ORDER BY i.amount ASC ';
        else if(req.body.sort_by == "price_desc")
            orderBy = 'ORDER BY i.amount DESC ';
        else if(req.body.sort_by == "qty_asc")
            orderBy = 'ORDER BY i.qty ASC ';
        else if(req.body.sort_by == "qty_desc")
            orderBy = 'ORDER BY i.qty DESC ';
        else if(req.body.sort_by == "date_asc")
            orderBy = 'ORDER BY i.date_added ASC ';
        else if(req.body.sort_by == "date_desc")
            orderBy = 'ORDER BY i.date_added DESC ';
        else if(req.body.sort_by == "id_asc")
            orderBy = 'ORDER BY i.id ASC ';
        else if(req.body.sort_by == "id_desc")
            orderBy = 'ORDER BY i.id DESC';
    }
    var userid = (typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0;

    var limit = '';
    if(!count){
        var page = req.body.page;
        var perlimit = req.body.perlimit;
        page = (page > 0) ? (page - 1) * perlimit : 0;
        limit = ' LIMIT '+page+', '+perlimit;
    }
    escape_data = [config.general.transaction_fee_per, userid, userid, userid, userid];
    $mysqli = {whereCond : whereCond, orderBy : orderBy, limit: limit};
    strQuery = mysqli.mysqli($mysqli, 'getAllSellerSoldProductsLimit');

    var defered = q.defer();
    query = mysql.query(strQuery,escape_data, defered.makeNodeResolver());
    console.log('SELLER SOLD PRODUCT SQL : ', query.sql);
    query.on('error', function (err) {
        console.log("Error in getSoldProductsSearch", err);
    })
    return defered.promise;
}
exports.getSimilarProduct = function (req, mysql, q, where) {
    var limitProduct = config.general.similar_products_limit ? config.general.similar_products_limit : 5;
    var limit = " LIMIT 0," + limitProduct;
    $mysqli = { whereCond : where, limit: limit };
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getSimilarProduct');
    query = mysql.query(strQuery, [], defered.makeNodeResolver());
    console.log("getSimilarProduct", query.sql);
    query.on('error', function (err) {
        console.log("Error in getSimilarProduct", err);
    })
    return defered.promise;
}
exports.addFeedback = function(req, mysql, q) {
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'addFeedback');
    var escape_data = [req.session.userid, req.body.f_invoice_id, req.body.f_product_id, req.body.f_rate, req.body.f_comment, datge];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.get_feedback = function(req, mysql, q) {
    strQuery = mysqli.mysqli($mysqli, 'get_feedback');
    var escape_data = [req.body.feedback_id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.transaction_list = function (req, mysql, q, count) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd");
    
    var userid = (typeof(req.session.userid) != 'undefined' && req.session.userid != '' && req.session.userid != '0') ? req.session.userid : 0;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    var where = 'p.id != 0 AND i.user_id='+userid;
    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'transaction_list');
    var escape_data = [userid, userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("transaction_list", query.sql);
    query.on('error', function (err) {
        console.log("Error in transaction_list", err); 
    })
    return defered.promise;
}
exports.save_ad = function(req, mysql, q) {
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    console.log('req.body', req.body);
    req.body.day_of_week = (req.body.ad_sunday ? req.body.ad_sunday : '') + ',' +
    (req.body.ad_monday ? req.body.ad_monday : '') + ',' +
    (req.body.ad_tuesday ? req.body.ad_tuesday : '') + ',' +
    (req.body.ad_wednesday ? req.body.ad_wednesday : '') + ',' +
    (req.body.ad_thursday ? req.body.ad_thursday : '') + ',' +
    (req.body.ad_friday ? req.body.ad_friday : '') + ',' +
    (req.body.ad_saturday ? req.body.ad_saturday : '');

    req.body.target_sec_id = (req.body.ad_home ? req.body.ad_home : '') + ',' +
    (req.body.ad_product_view ? req.body.ad_product_view : '') + ',' +
    (req.body.ad_dashboard ? req.body.ad_dashboard : '') + ',' +
    (req.body.ad_product_post ? req.body.ad_product_post : '');

    strQuery = mysqli.mysqli($mysqli, 'save_ad');
    var escape_data = [
        req.body.ad_name,
        req.body.ad_title,
        req.body.ad_content,
        req.body.ad_url,
        req.body.ad_banner ? req.body.ad_banner : '',
        req.body.add_type=='1' ? 1 : 0,
        req.body.ad_end_date ? dateFormat(req.body.ad_end_date, "yyyy-mm-dd") : '',
        req.body.day_of_week,
        req.body.target_sec_id,
        req.body.ad_keywords,
        req.body.ad_budget_perclick,
        req.body.ad_spend_perday,
        req.session.userid,
        datge
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.advertisements_list = function (req, mysql, q, count) {
    var where = '';
    where += ' AND ad.user_id='+req.session.userid;

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'advertisements_list');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("advertisements_list", query.sql);
    query.on('error', function (err) {
        console.log("Error in advertisements_list", err); 
    })
    return defered.promise;
}
exports.total_ads_amount = function(req, mysql, q) {
    strQuery = mysqli.mysqli($mysqli, 'total_ads_amount');
    var escape_data = [req.body.feedback_id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.update_ad_status = function(req, mysql, q) {
    strQuery = mysqli.mysqli($mysqli, 'update_ad_status');
    var escape_data = [req.body.status, req.body.id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.update_classified_status = function(req, mysql, q) {
    strQuery = mysqli.mysqli($mysqli, 'update_classified_status');
    var escape_data = [req.body.status, req.body.id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.get_ads = function (req, mysql, q, count) {
    var where = '';
    if(req.session.userid) {
        where += ' AND ad.user_id!='+req.session.userid;
    }
    if(req.body.page) {
        where += ' AND FIND_IN_SET("'+req.body.page+'", ad.target_sec_id)';
    }

    var limit = '';
    req.body.startFrom = 0;
    req.body.limit = 10;
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_ads');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("get_ads", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_ads", err); 
    })
    return defered.promise;
}
exports.click_ad = function(req, mysql, q) {
    strQuery = mysqli.mysqli($mysqli, 'click_ad');
    var escape_data = [req.body.id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.get_ad_detail = function(req, mysql, q) {
    strQuery = mysqli.mysqli($mysqli, 'get_ad_detail');
    var escape_data = [req.body.id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.getClassifiedDetail = function(req,mysql,q)
{
	console.log('getClassifiedDetail');
	strQuery = mysqli.mysqli($mysqli,'getClassifiedDetail'); 
	var defered = q.defer(); 
	var escape_data =  [req.body.id]
    console.log(escape_data);
	query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	console.log('getClassifiedDetail ', query.sql);
    return defered.promise;
}
exports.dummyQuery = function(req, mysql, q) {
    $mysqli = {
        query: req.body.query
    }
    strQuery = mysqli.mysqli($mysqli, 'dummyQuery');
    var escape_data = [];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('dummyQuery', query.sql);
    return defered.promise;
}
exports.removeFromFeaturedAuction = function(req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var where = ' AND is_featured=1 AND date_format(f_end_date, "%m-%d-%Y %H:%i:%s") <= date_format("'+cdate+'", "%m-%d-%Y %H:%i:%s")';
    $mysqli = {
        where: where
    };
    strQuery = mysqli.mysqli($mysqli, 'removeFromFeaturedAuction');
    var escape_data = [];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    // console.log('removeFromFeaturedAuction', query.sql);
    return defered.promise;
}
exports.get_offer_chats = function(req, mysql, q) {
    var where = '';
    if(req.body.id) {
        where = ' AND oc.id='+req.body.id;
    } else if(req.body.receiver_id) {
        where += ' AND oc.product_id='+req.body.product_id+' AND (oc.sender_id='+req.body.receiver_id+' OR oc.receiver_id='+req.body.receiver_id+')';
        where_unread = ' AND oc.product_id='+req.body.product_id+' AND oc.receiver_id='+req.session.userid+' AND oc.sender_id='+req.body.receiver_id;
    } else {
        where = ' AND oc.product_id='+req.body.product_id+' AND (oc.sender_id='+req.session.userid+' OR oc.receiver_id='+req.session.userid+')';
        where_unread = ' AND oc.product_id='+req.body.product_id+' AND oc.receiver_id='+req.session.userid;
    }

    if(!req.body.id) {
        $mysqli = {
            where: where_unread
        };
        strQuery = mysqli.mysqli($mysqli, 'update_unread_offer_flag');
        var escape_data = [];
        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    }
    
    $mysqli = {
        where: where
    };
    strQuery = mysqli.mysqli($mysqli, 'get_offer_chats');
    var escape_data = [];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.get_offer_user_chats = function(req, mysql, q) {
    var where = '';
    if(req.body.id) {
        where = ' AND oc.id='+req.body.id;
    } else {
        where = ' AND oc.product_id='+req.body.product_id+' AND oc.sender_id!='+req.session.userid+'';
    }
    $mysqli = {
        where: where
    };
    strQuery = mysqli.mysqli($mysqli, 'get_offer_user_chats');
    var escape_data = [];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_offer_user_chats', query.sql);
    return defered.promise;
}
exports.send_offer_message = function(req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'send_offer_message');
    var escape_data = [
        req.body.product_id,
        req.body.seller_id,
        req.body.sender_id,
        req.body.receiver_id,
        0,
        req.body.message,
        'active',
        cdate
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    // console.log('send_offer_message', query.sql);
    return defered.promise;
}
exports.submit_final_offer = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'submit_final_offer');
    var escape_data = [
        req.body.amount,
        req.body.offer_buyer_id,
        req.body.product_id
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('submit_final_offer', query.sql);
    return defered.promise;
}
exports.get_buyer_unread_offer_chat = function (req, mysql, q) {
    $mysqli = {};
    var userid = req.session.userid ? req.session.userid : 0;
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_buyer_unread_offer_chat');
    query = mysql.query(strQuery, [req.body.product_id, userid], defered.makeNodeResolver());
    console.log("get_buyer_unread_offer_chat", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_buyer_unread_offer_chat", err);
    })
    return defered.promise;
}
exports.get_seller_rattings = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_seller_rattings');
    query = mysql.query(strQuery, [req.body.seller_id], defered.makeNodeResolver());
    console.log("get_seller_rattings", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_seller_rattings", err);
    })
    return defered.promise;
}
exports.get_seller_average_rattings = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_seller_average_rattings');
    query = mysql.query(strQuery, [req.body.seller_id], defered.makeNodeResolver());
    console.log("get_seller_average_rattings", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_seller_average_rattings", err);
    })
    return defered.promise;
}
exports.get_bid_details = function (req, mysql, q, pid) {
    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_bid_details'); 
    escape_fields = [req.body.id]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log("get_bid_details", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_bid_details", err);
    })
    return defered.promise;
}
exports.generate_invoice = function(req, mysql, q) {
    req.body.transaction_fee_per = parseFloat(config.general.transaction_fee_per);
    req.body.transaction_fee = (req.body.amount * parseFloat(config.general.transaction_fee_per) ) / 100;
    req.body.total_amount = (parseFloat(req.body.amount) + parseFloat(req.body.shipping_amount) + parseFloat(req.body.transaction_fee));

    var user_id = req.body.invoice_user_id ? req.body.invoice_user_id : req.session.userid;
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'generate_invoice');
    var escape_data = [
        req.body.transactionid,
        req.body.gateway,
        cdate,
        user_id,
        req.body.product_id,
        req.body.type,
        req.body.amount,
        req.body.shipping_amount,
        req.body.transaction_fee,
        req.body.transaction_fee_per,
        req.body.total_amount,
        'waiting_for_shipping_address',
        'debit',
        '',
        req.body.qty
    ];
    console.log('escape_data', escape_data);
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("generate_invoice", query.sql);
    query.on('error', function (err) {
        console.log("Error in generate_invoice", err);
    })
    return defered.promise;
}
exports.get_invoice_details = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_invoice_details'); 
    escape_fields = [req.body.id]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.get_ad_details = function (req, mysql, q, pid) {
    $mysqli = {};
    var defered = q.defer();
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_ad_details'); 
    escape_fields = [req.body.id]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log("get_ad_details", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_ad_details", err);
    })
    return defered.promise;
}
exports.make_duplicate_product = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'make_duplicate_product');
    escape_fields = [req.body.product_id]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log("make_duplicate_product", query.sql);
    query.on('error', function (err) {
        console.log("Error in make_duplicate_product", err);
    });
    return defered.promise;
}
exports.make_duplicate_product_documents = function (req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'make_duplicate_product_image');
    escape_fields = [req.body.new_product_id, req.body.new_product_id, req.body.new_product_id, req.body.product_id]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log("make_duplicate_product_image", query.sql);
    query.on('error', function (err) {
        console.log("Error in make_duplicate_product_image", err);
    });

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'make_duplicate_product_certificates');
    escape_fields = [req.body.new_product_id, req.body.product_id]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log("make_duplicate_product_certificates", query.sql);
    query.on('error', function (err) {
        console.log("Error in make_duplicate_product_certificates", err);
    });
    
    return defered.promise;
}
exports.get_buynow_detail = function(req, mysql, q) {
    $mysqli = {};
    var escape_data = [req.body.id];
    strQuery = mysqli.mysqli($mysqli, 'get_buynow_detail');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_buynow_detail', query.sql);
    query.on('error', function(err) {
        console.log("Error get_buynow_detail " + err);
    })
    return defered.promise;
}
exports.make_transaction = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var escape_data = [
        req.body.product_id,
        req.session.userid,
        req.body.amount,
        req.body.type,
        1,
        req.body.gateway,
        req.body.qty,
        cdate,
        ''
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'make_transaction');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('make_transaction', query.sql);
    query.on('error', function (err) {
        console.log("Error in make_transaction", err);
    })
    return defered.promise;
}
exports.add_buynow = function (req, mysql, q, data) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var escape_data = [
        data.product_id,
        data.userid,
        data.amount,
        data.type,
        0,
        '',
        data.qty,
        cdate,
        ''
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'add_buynow');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('add_buynow', query.sql);
    query.on('error', function (err) {
        console.log("Error in add_buynow", err);
    })
    return defered.promise;
}
exports.update_transaction = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var escape_data = [
        1,
        req.body.gateway,
        cdate,
        req.body.id
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'update_transaction');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('update_transaction', query.sql);
    query.on('error', function (err) {
        console.log("Error in update_transaction", err);
    })
    return defered.promise;
}
exports.change_product_end_date = function(req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    req.body.end_date = dateFormat(req.body.end_date, "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'change_product_end_date');
    var escape_data = [
        req.body.end_date,
        req.body.product_id
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('change_product_end_date', query.sql);
    query.on('error', function (err) {
        console.log("Error in change_product_end_date", err);
    })
    return defered.promise;
}
exports.set_shipping_id = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'set_shipping_id');
    var escape_data = [
        req.body.shipping_id,
        req.body.invoice_id
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('set_shipping_id', query.sql);
    query.on('error', function (err) {
        console.log("Error in set_shipping_id", err);
    })
    return defered.promise;
}
exports.set_shipping_amount = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'set_shipping_amount');
    var escape_data = [
        req.body.shipping_amount,
        req.body.shipping_amount,
        req.body.status,
        req.body.invoice_id
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('set_shipping_amount', query.sql);
    query.on('error', function (err) {
        console.log("Error in set_shipping_amount", err);
    })
    return defered.promise;
}
exports.get_product_and_buyer_details_using_invoice = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_product_and_buyer_details_using_invoice');
    var escape_data = [
        req.body.invoice_id
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_product_and_buyer_details_using_invoice', query.sql);
    query.on('error', function (err) {
        console.log("Error in get_product_and_buyer_details_using_invoice", err);
    })
    return defered.promise;
}
exports.add_edit_escrow_details = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var escape_data = [];
    if(req.body.id > 0) {
        escape_data = [
            req.body.escrow_company,
            '',
            req.body.user_name,
            req.body.user_company,
            req.body.user_email,
            req.body.user_phone,
            req.body.bank_name,
            req.body.account_name,
            req.body.account_number,
            req.body.routing_number,
            req.body.id
        ];
        strQuery = mysqli.mysqli($mysqli, 'edit_escrow_details');
    } else {
        escape_data = [
            req.body.invoice_id,
            req.body.escrow_company,
            '',
            req.body.user_name,
            req.body.user_company,
            req.body.user_email,
            req.body.user_phone,
            req.body.bank_name,
            req.body.account_name,
            req.body.account_number,
            req.body.routing_number,
            'active',
            cdate
        ];
        strQuery = mysqli.mysqli($mysqli, 'add_escrow_details');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('add_edit_escrow_details', query.sql);
    return defered.promise;
}
exports.add_transaction_id = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {};
    var escape_data = [];
    escape_data = [
        req.body.tr_transaction_id,
        cdate,
        req.body.gateway,
        req.body.tr_invoice_id
    ];
    strQuery = mysqli.mysqli($mysqli, 'add_transaction_id');

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('add_transaction_id', query.sql);
    return defered.promise;
}
exports.update_invoice_status = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {};
    var escape_data = [];
    escape_data = [
        req.body.status,
        req.body.invoice_id
    ];
    strQuery = mysqli.mysqli($mysqli, 'update_invoice_status');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('update_invoice_status', query.sql);
    return defered.promise;
}
exports.product_details_using_invoice_id = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {};
    var escape_data = [];
    escape_data = [
        req.body.invoice_id
    ];
    strQuery = mysqli.mysqli($mysqli, 'product_details_using_invoice_id');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('product_details_using_invoice_id', query.sql);
    return defered.promise;
}
exports.saveProductToSEO = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {};
    var escape_data = [];
    escape_data = [
        req.body.product_id,
        req.body.title,
        req.body.keywords ? req.body.keywords : null,
        req.body.description,
        cdate
    ];
    strQuery = mysqli.mysqli($mysqli, 'saveProductToSEO');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('saveProductToSEO', query.sql);
    return defered.promise;
}
exports.reduceProductRenewCount = function (req, mysql, q, pid) {
    $mysqli = {};
    var defered = q.defer();
    $mysqli = { };
    strQuery = mysqli.mysqli($mysqli, 'reduceProductRenewCount'); 
    escape_fields = [pid]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.get_unread_chat_offer_message = function (req, mysql, q, pid) {
    var dt = new Date();
        dt.setHours( dt.getHours() - 1 );
    var cdate = dateFormat(dt, "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var defered = q.defer();
    var where = ' AND date_format(oc.created_date, "%m-%d-%Y %H:%i:%s") <= date_format("'+cdate+'", "%m-%d-%Y %H:%i:%s")';

    $mysqli = { where: where };
    strQuery = mysqli.mysqli($mysqli, 'get_unread_chat_offer_message'); 
    escape_fields = []
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    // console.log('get_unread_chat_offer_message', query.sql);
    return defered.promise;
}
exports.update_mail_send_for_offer_message = function (req, mysql, q, pid) {
    var dt = new Date();
        dt.setHours( dt.getHours() - 1 );
    var cdate = dateFormat(dt, "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    var defered = q.defer();
    var where = ' AND date_format(created_date, "%m-%d-%Y %H:%i:%s") <= date_format("'+cdate+'", "%m-%d-%Y %H:%i:%s")';
    $mysqli = { where: where };
    strQuery = mysqli.mysqli($mysqli, 'update_mail_send_for_offer_message'); 
    escape_fields = [req.body.receiver_id]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}