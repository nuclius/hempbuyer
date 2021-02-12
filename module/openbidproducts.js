var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');

exports.getOpenBidProducts = function(req, mysql, q, count) {
console.log('req.body', req.body);
    var limit = 'limit ';
    var page = 0;
    var cat = req.body.cat;
    var type = req.body.type;
    var sortType = req.body.sortType;
    var searchType = '';
    console.log("getOopenBid" + cat);
    // console.log(req.body.sortType);

    var whr = '';

    if (cat !== 'all' && cat !== '') {
        whr = whr + ' and category_id = ' + cat + ' ';
    }

    if (req.body.type == 'recent') {
        searchType = 'order by created_at DESC';
        if(req.session.business_type == 'dispensary') {
            whr = whr + ' and trading_type = "sell" ';
        }
    }

    if (req.body.type == 'availabledate') {
        searchType = 'order by date_added DESC'
    }

    if (req.body.type == 'selloffers') {
        if (cat !== 'all' && whr !== '')
            whr = whr + ' and trading_type = "buy" '
        else if (whr == '')
            whr = whr + 'and trading_type = "buy" '
    }

    if (req.body.type == 'buyoffers') {
        if (cat !== 'all' && whr !== '')
            whr = whr + ' and trading_type = "sell" '
        else if (whr == '')
            whr = whr + ' and trading_type = "sell" '
    }

    if (req.body.sortType == 'availablenow') {
        if (whr == '')
            whr = whr + ' and date_added <= (now() + interval 72 hour) '
        else
            whr = whr + ' and date_added <= (now() + interval 72 hour) '
    } else if (req.body.sortType == 'futurebid') {
        if (whr == '')
            whr = whr + ' and date_added > (now() + interval 72 hour) '
        else
            whr = whr + ' and date_added > (now() + interval 72 hour) '
    }

    //modified for auction condition
    /*
    if (cat !== 'all' && cat !== '') {
        whr = whr + ' where category_id = ' + cat + ' ';
    }

    if(req.body.type == 'recent') {
        searchType = 'order by created_at DESC'
    } 
    
    if(req.body.type == 'availabledate') {
        searchType = 'order by date_added DESC'
    }

    if(req.body.type == 'selloffers') { 
        if(cat !== 'all' && whr !== '')
            whr = whr + ' and trading_type = "buy" '
        else if(whr == '')
            whr = whr + 'where trading_type = "buy" '
    }

    if(req.body.type == 'buyoffers') {
        if(cat !== 'all'  && whr !== '')
            whr = whr +  ' and trading_type = "sell" '
        else if(whr == '')
            whr = whr + ' where trading_type = "sell" '
    }

    if(req.body.sortType == 'availablenow'){
        if(whr == '')
            whr = whr + ' where date_added <= (now() + interval 72 hour) '
        else
            whr = whr + ' and date_added <= (now() + interval 72 hour) '
    } else if(req.body.sortType == 'futurebid'){
        if(whr == '')
            whr = whr + ' where date_added > (now() + interval 72 hour) '
        else
            whr = whr + ' and date_added > (now() + interval 72 hour) '
    }*/

    if (req.body.page !== undefined && req.body.page > 0) {
        page = (req.body.page) * 10;
        limit = limit + page + ', 10';
    } else {
        limit = limit + page + ', 10';
    }
    console.log('req.body.page', req.body.page);
    console.log('limit', limit);

    // console.log('req.session.roleid == 2', req.session.roleid.toString() == '2');

    // if(req.session.roleid == '2') {
    //     whr = whr + ' and trading_type = "sell" '

    /* start For sales admin */
    if(req.session.roleid != undefined) {
        if(req.session.roleid.toString() == '2' || req.session.roleid.toString() == '3' || req.session.roleid.toString() == '0') {
            whr = whr + ' and trading_type = "sell" '
        } else {
            whr = whr + ' and state="' + req.session.state + '"';
        }
    } else {
        whr = whr + ' and state="' + req.session.state + '"';
    }
    /* end For sales admin */

    $mysqli = {
        limit: limit,
        whr: whr,
        search_type: searchType
    };

    var escape_data = [
        req.session.userid
    ]

    /* start For sales admin */
    if(req.session.roleid != undefined) {
        if(req.session.roleid.toString() == '2' || req.session.roleid.toString() == '3') {
            escape_data = [
                req.session.login_userid != undefined ? req.session.login_userid : req.session.userid
            ]
        }
    }
    /* end For sales admin */
    

    var defered = q.defer();

    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'count_openbid_products');
    } else if (count == 0) {
        strQuery = mysqli.mysqli($mysqli, 'get_openbid_products');
    }

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_openbid_products ------------------- ', query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getCategories = function(req, mysql, q) {
    $mysqli = {};

    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'get_categories');

    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log('getCategories', query.sql);
    return defered.promise;
}

exports.save = function(req, res, mysql, q) {
    //var qs = require('qs');
    //req.body = qs.parse(req.body);

    newfilename = {};
    newfilename.name = '';
    newfilename.originalname = '';

    newfilename2 = {};
    newfilename2.name = '';
    newfilename2.originalname = '';

    console.log(req.files.product_image);

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


    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'insert_openbid_products');

    // req.body.start_date = req.body.start_date + ':00';
    var date_added = new Date(req.body.start_date);
    var endingDate = date_added.setDate(date_added.getDate() + 365);
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

    req.body.rprice = (typeof(req.body.target_price) == 'undefined') ? req.body.rprice : req.body.target_price;
    // var unit_price = Number(req.body.target_price) / Number(req.body.qty);
    var unit_price = req.body.target_price;
    var stax = (typeof(req.session.stax_per) == 'undefined') ? 0 : parseFloat(req.session.stax_per);
    var stax_amount = 0;

    if (req.body.currency_type == 'dollar') {
        var shipping_fee = (typeof(req.param('shipping_fee')) != 'undefined') ? Number(common.currencyConverter(req.param('shipping_fee'))) * req.session.currencyrate : 0;
        var sprice = (typeof(req.body.target_price) != 'undefined') ? Number(common.currencyConverter(req.body.target_price)) * req.session.currencyrate : 0;
        var rprice = (typeof(req.body.rprice) != 'undefined') ? Number(common.currencyConverter(req.body.rprice)) * req.session.currencyrate : 0;
        unit_price = (typeof(unit_price) != 'undefined') ? Number(common.currencyConverter(unit_price)) * req.session.currencyrate : 0;
    } else {
        var shipping_fee = common.currencyConverter(req.param('shipping_fee'));
        var sprice = common.currencyConverter(req.body.target_price);
        var rprice = common.currencyConverter(req.body.rprice);
        unit_price = common.currencyConverter(unit_price);
    }

    if (stax > 0)
        stax_amount = parseFloat(sprice) * (parseFloat(stax) / 100);
    if (req.body.currency_type == 'dollar') {
        stax_amount = (typeof(stax_amount) != 'undefined') ? Number(common.currencyConverter(stax_amount)) * req.session.currencyrate : 0;
    } else {
        stax_amount = common.currencyConverter(stax_amount);
    }

    console.log("stax_amount : " + stax_amount);
    console.log("stax : " + stax);

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    /* ===================== start change by divyesh (changes) ===================== */
    var qty = (typeof(req.body.qty) !== undefined) ? req.param('qty') : 1;

    var consultant_fee = (typeof(req.body.consultant_fee) == 'undefined') ? 0 : Number(req.body.consultant_fee);
    var consultant_fee_amount = (consultant_fee > 0) ? ( (Number(sprice) * consultant_fee) / 100 ) : 0;

    var escape_data = [
        req.body.pkey,
        req.body.title,
        (typeof(req.body.metrc_id) !== 'undefined') ? req.body.metrc_id : '',
        req.param('description'),
        (typeof(req.files.product_image) !== 'undefined') ? req.body.avatar : '',
        (typeof(req.files.product_image) !== 'undefined') ? req.body.product_image : '',
        (typeof(req.body.category) !== 'undefined') ? req.body.category : '',
        (typeof(req.body.subcategory) !== 'undefined') ? req.body.subcategory : '',
        (typeof(req.session) !== 'undefined') ? req.session.userid : 0,
        datge,
        sprice, //sprice,
        rprice, //rprice,
        sprice, //wprice,
        dateFormat(new Date(req.body.start_date), "yyyy-mm-dd HH:MM:ss"),
        dateFormat(new Date(endingDate), "yyyy-mm-dd HH:MM:ss"),
        1,
        1, // (typeof(req.param('auction')) === 'undefined') ? 0 : req.param('auction'),
        qty, //(typeof(req.param('auction')) === 'undefined' || req.param('auction') == 0) ? req.param('qty') : 1,
        qty,
        (typeof(req.body.trading_type) !== undefined) ? req.body.trading_type : 'buy',
        (typeof(req.body.cannabis_type) === 'undefined') ? 'n' : req.body.cannabis_type,
        (typeof(req.body.order_type) !== undefined || req.body.order_type !== null) ? req.body.order_type : 'total',
        (typeof(req.body.units) !== undefined) ? req.body.units : 'ounces',
        prostatus,
        unit_price,
        stax,
        stax_amount,
        consultant_fee,
        consultant_fee_amount,
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
        (typeof(req.param('distributor_id')) === 'undefined') ? 0 : (req.param('interim_testing_status')=='y' ? req.param('distributor_id') : 0)
        // (typeof(req.param('save')) === undefined) ? 'draft' : prostatus
    ];
    // store_prdt,store_prdt_msg,interim_testing_status,interim_testing_status_msg,cert_analysis,cert_analysis_img,default_distributor,additional_service,additional_service_type
    /* ===================== end change by divyesh (changes) ===================== */

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}


exports.product_id = function(req, res, mysql, q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'user_id');
    var defered = q.defer();
    var escape_data = [req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(error){
        throw error;
    })
    return defered.promise;
}


exports.saveRequests = function(req, res, mysql, q) {
    //var qs = require('qs');
    //req.body = qs.parse(req.body);

    var user_id = req.session.userid;
    var behalf_cc_id = 0;
    var is_on_behalf = req.body.is_on_behalf != undefined ? 1 : req.body.is_on_behalf;
    var purchase_behalf_documents = '';
    if(is_on_behalf) {
        user_id = req.body.behalf_user_id != null ? req.body.behalf_user_id : 0;
        behalf_cc_id = req.body.behalf_cc_id;
        purchase_behalf_documents = req.files.purchase_behalf_documents.name
    }

    console.log("request_body"+req.body);
    //'insert into product_requests (product_id, user_id, qty, amount, created_at) values (?,?,?,?,?)';
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'insert_product_request');

    var defered = q.defer();

    if (req.body.currency_type == 'dollar') {
        var offer_price = (typeof(req.param('offer_price')) != 'undefined') ? Number(common.currencyConverter(req.param('offer_price'))) * req.session.currencyrate : 0;
        var unit_price = (typeof(req.param('offer_price')) != 'undefined') ? Number(common.currencyConverter(req.param('offer_price') / req.param('qty'))) * req.session.currencyrate : 0;
    } else {
        var offer_price = common.currencyConverter(req.param('offer_price'));
        var unit_price = (common.currencyConverter(req.param('offer_price') / req.param('qty')));
    }
    //'insert into product_requests (product_id, user_id, qty, amount, unit_price, units, trading_type, created_at) values (?,?,?,?,?,?,?,?)';
    var escape_data = [
        req.body.id,
        user_id,
        req.body.qty,
        offer_price,
        unit_price,
        req.body.units,
        req.body.trading_type,
        datge,
        behalf_cc_id,
        purchase_behalf_documents
        // (typeof(req.param('save')) === undefined) ? 'draft' : prostatus
    ];

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}



/* Accept product requests */
exports.acceptRequest = function(req, res, mysql, q) {

    console.log(req.body);

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'accept_request');

    // mysqli['accept_request'] = 'update product_requests set accepted = ?, accepted_date = ? where id = ? and product_id = ?';

    var defered = q.defer();

    var escape_data = [
        1,
        datge,
        req.body.req_id,
        req.body.id
    ];

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

/* Reject product requests */
exports.rejectRequest = function(req, res, mysql, q) {

    console.log(req.body);
    // mysqli['reject_request'] = 'update product_requests set rejected = ?, rejected_date = ?, rejected_msg = ?, where id = ? and product_id = ?';
    var msg = typeof(req.body.rej_msg) !== 'undefined' ? req.body.rej_msg : ''

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'reject_request');

    var defered = q.defer();

    var escape_data = [
        1,
        datge,
        msg,
        req.body.req_id,
        req.body.id
    ];

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

/*reject the multiple product requests : after accept the request */
exports.rejectRequests = function(req, res, mysql, q) {
    /*  
         need parameters : bidding userdetails, bidding id, product id, logged in user info
    */
    console.log(req.body);

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'reject_requests');

    var defered = q.defer();
    /*
    mysqli['reject_request'] = 'update product_requests set rejected = ?, rejected_date = ? where accepted = 0 and product_id = ?';
    mysqli['reduce_product_qty'] = 'update projects set filled_qty = ?, market_status=? where product_id = ?';
    */
    //mysqli['reject_requests'] = 'update product_requests set rejected = ?, rejected_date = ? where qty < ? and accepted = 0 and product_id = ?';
    var escape_data = [
        1,
        datge,
        req.body.rfilled_qty,
        req.body.id
    ];

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

/* Changing product status after request acceptance or rejection */
exports.changeProductStatus = function(req, res, mysql, q) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var closed_date = ''
    var prod_status = 'open';
    var defered = q.defer();

    // req.body.qty = prdt[0].qty;
    // req.body.amount = prdt[0].sprice;
    // req.body.unit_price = prdt[0].unit_price;
    // req.body.filled_qty = prdt[0].filled_qty - rd.qty;
    // req.body.rfilled_qty = qty - prdt[0].req.body.filled_qty

    if (req.body.qty == req.body.filled_qty && req.body.rfilled_qty == 0) {
        prod_status = 'sold';
        closed_date = ', date_closed = "' + datge+'"';
    } else {
        prod_status = 'open'
    }

    $mysqli = { closed_date: closed_date };
    //'update projects set filled_qty = ?, rfilled_qty=?, market_status=? where product_id = ?';

    var escape_data = [
        req.body.filled_qty, //should be accepted quantity + filled quantity
        req.body.rfilled_qty, //sould be remaining quantity = qty - filled qty
        prod_status, //should be 'open'/'closed'
        req.body.id
    ];

    strQuery = mysqli.mysqli($mysqli, 'change_prodstatus');

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.buyer_id = function(req, res, mysql, q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'buyerid');
    var defered = q.defer();
    var escape_data = [req.body.req_id, req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('prabakaran', query.sql);
    query.on('error', function(error){
        throw error;
    })
    return defered.promise;
}

exports.getRequestDetails = function(req, res, mysql, q, reqId) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_request_detail');
    //mysqli['get_request_detail'] = 'select * from product_requests where id=? and product_id = ?';
    var defered = q.defer();

    var escape_data = [
        reqId,
        req.body.id
    ];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}


exports.updateProduct = function(req, mysql, q, prdt) {

$mysqli = { image : ''};
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

    
    strQuery = mysqli.mysqli($mysqli, 'update_openbid_products');

    // req.body.start_date = req.body.start_date + ':00';
    var date_added = new Date(req.body.start_date);
    var endingDate = date_added.setDate(date_added.getDate() + 365);
    // req.body.date_closed = req.body.date_closed + ':00';

    var defered = q.defer();
    // req.body.iprice = 0.01;
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

    req.body.rprice = (typeof(req.body.target_price) == 'undefined') ? req.body.rprice : req.body.target_price;
    // var unit_price = Number(req.body.target_price) / Number(req.body.qty);
    var unit_price = req.body.target_price;

    var stax = (typeof(req.session.stax_per) == 'undefined') ? 0 : Number(req.session.stax_per);
    var stax_amount = 0;

    if (req.body.currency_type == 'dollar') {
        // var shipping_fee = (typeof(req.param('shipping_fee')) != 'undefined') ? Number(common.currencyConverter(req.param('shipping_fee'))) * req.session.currencyrate : prdt.shipping_fee;
        var sprice = (typeof(req.body.target_price) != 'undefined') ? Number(common.currencyConverter(req.body.target_price)) * req.session.currencyrate : prdt.sprice;
        var rprice = (typeof(req.body.rprice) != 'undefined') ? Number(common.currencyConverter(req.body.rprice)) * req.session.currencyrate : prdt.rprice;
        unit_price = (typeof(unit_price) != 'undefined') ? Number(common.currencyConverter(unit_price)) * req.session.currencyrate : prdt.unit_price;
        // stax_amount = (typeof(stax_amount) != 'undefined') ? Number(common.currencyConverter(stax_amount)) * req.session.currencyrate : prdt.stax_amount;
        // var bprice = (typeof(req.body.bprice) != 'undefined') ? Number(common.currencyConverter(req.body.bprice))*req.session.currencyrate : 0;
        // var mprice = (typeof(req.body.mprice) != 'undefined') ? Number(common.currencyConverter(req.body.mprice))*req.session.currencyrate : 0;
        // var iprice = (typeof(req.body.iprice) != 'undefined') ? Number(common.currencyConverter(req.body.iprice))*req.session.currencyrate : 0;
    } else {
        // var shipping_fee = common.currencyConverter(req.param('shipping_fee'));
        var sprice = common.currencyConverter(req.body.target_price);
        var rprice = common.currencyConverter(req.body.rprice);
        unit_price = common.currencyConverter(unit_price);
        // stax_amount = common.currencyConverter(stax_amount);
        // var bprice = common.currencyConverter(req.body.bprice);
        // var mprice = common.currencyConverter(req.body.mprice);
        // var iprice = common.currencyConverter(req.body.iprice);
    }



    if (stax > 0)
        stax_amount = Number(sprice) * (Number(stax) / 100);

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    /* ===================== start change by divyesh (changes) ===================== */
    var qty = (typeof(req.body.qty) !== undefined) ? req.param('qty') : 1;

    var consultant_fee = (typeof(req.body.consultant_fee) == 'undefined') ? 0 : Number(req.body.consultant_fee);
    var consultant_fee_amount = (consultant_fee > 0) ? ( (Number(sprice) * consultant_fee) / 100 ) : 0;
    

    var escape_data = [
        req.body.pkey,
        req.body.title,
        (typeof(req.body.metrc_id) !== 'undefined') ? req.body.metrc_id : '',
        req.param('description'),
        // (typeof(req.files.product_image) !== 'undefined') ? req.body.avatar : '',
        // (typeof(req.files.product_image) !== 'undefined') ? req.body.product_image : '',
        (typeof(req.body.category) !== 'undefined') ? req.body.category : prdt.parent_category_id,
        (typeof(req.body.subcategory) !== 'undefined') ? req.body.subcategory : prdt.category_id,
        // (typeof(req.session) !== 'undefined') ? req.session.userid : 0,
        datge,
        sprice, //sprice,
        rprice, //rprice,
        sprice, //wprice,
        dateFormat(new Date(req.body.start_date), "yyyy-mm-dd HH:MM:ss"),
        dateFormat(new Date(endingDate), "yyyy-mm-dd HH:MM:ss"),
        1,  //status
        1, // (typeof(req.param('auction')) === 'undefined') ? 0 : req.param('auction'),
        qty, //(typeof(req.param('auction')) === 'undefined' || req.param('auction') == 0) ? req.param('qty') : 1,
        qty, // rfilled_qty
        (typeof(req.body.trading_type) !== undefined) ? req.body.trading_type : 'buy',
        (typeof(req.body.cannabis_type) === 'undefined') ? prdt.cannabis_type : req.body.cannabis_type,
        (typeof(req.body.order_type) !== undefined || req.body.order_type !== null) ? req.body.order_type : prdt.order_type,
        (typeof(req.body.units) !== undefined) ? req.body.units : prdt.units,
        prostatus,
        unit_price,
        stax,
        stax_amount,
        consultant_fee,
        consultant_fee_amount,
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
        req.body.id,
        req.session.userid
        // (typeof(req.param('save')) === undefined) ? 'draft' : prostatus
    ];
    /* ===================== end change by divyesh (changes) ===================== */

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

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
exports.getAllProdNames = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'get_all_prodNames');
    escape_fields = [req.session.userid];
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;

}