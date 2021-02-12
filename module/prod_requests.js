var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');

exports.buyerRequests = function(req, mysql, q, count) {

    // console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and p.title like "%'+req.body.search+'%"';
    }

    $mysqli = { whr: whr };


    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'get_ob_products');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'count_ob_products');
    }

    var defered = q.defer();


    // console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getRequests = function(req, mysql, q, count) {

    // console.log(req.body);
    var productId = req.body.productid;
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    var whr = '';
    //mysqli['get_requests'] = 'select pr.id as req_id, p.*, pr.user_id as req_user_id, pr.qty as req_qty, date_format(pr.created_at,"%m/%d/%Y @ %H:%i") as req_date, pr.amount as req_amount, pr.unit_price as req_unit_price, pr.accepted as req_acceted, pr.`status` as req_status, pr.awarded as req_awarded, pr.awarded_date as req_awarded_date, pr.accepted_date as req_accepted_date from product_requests as pr left join projects as p on p.id = pr.product_id where p.user_id=? and p.auction = 1 and pr.accepted = 0 and pr.rejected = 0 {{whr}} order by pr.created_at DESC limit ?, ?';
    if (productId != 'all') {
        whr = ' and pr.product_id = ' + productId + ' ';
    }
    if(req.body.search !== ''){
        whr = whr + 'and p.title like "%'+req.body.search+'%"';
    }

    $mysqli = { whr: whr };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'get_requests');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'count_requests');
    }

    var defered = q.defer();


    // console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getMyRequests = function(req, mysql, q, count) {

    // console.log(req.body);
    var productId = req.body.productid;
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    var whr = '';
    //mysqli['get_requests'] = 'select pr.id as req_id, p.*, pr.user_id as req_user_id, pr.qty as req_qty, date_format(pr.created_at,"%m/%d/%Y @ %H:%i") as req_date, pr.amount as req_amount, pr.unit_price as req_unit_price, pr.accepted as req_acceted, pr.`status` as req_status, pr.awarded as req_awarded, pr.awarded_date as req_awarded_date, pr.accepted_date as req_accepted_date from product_requests as pr left join projects as p on p.id = pr.product_id where p.user_id=? and p.auction = 1 and pr.accepted = 0 and pr.rejected = 0 {{whr}} order by pr.created_at DESC limit ?, ?';
    if (productId != 'all') {
        whr = whr + ' and pr.product_id = ' + productId + ' ';
    }

    if(req.body.search !== ''){
        whr = whr + 'and p.title like "%'+req.body.search+'%"';
    }

    $mysqli = { whr: whr };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'get_my_requests');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'count_my_requests');
    }

    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getAllUserRequests = function(req, mysql, q, prodId) {

    // console.log(req.body);

    //mysqli['get_requests'] = 'select pr.id as req_id, p.*, pr.user_id as req_user_id, pr.qty as req_qty, date_format(pr.created_at,"%m/%d/%Y @ %H:%i") as req_date, pr.amount as req_amount, pr.unit_price as req_unit_price, pr.accepted as req_acceted, pr.`status` as req_status, pr.awarded as req_awarded, pr.awarded_date as req_awarded_date, pr.accepted_date as req_accepted_date from product_requests as pr left join projects as p on p.id = pr.product_id where p.user_id=? and p.auction = 1 and pr.accepted = 0 and pr.rejected = 0 {{whr}} order by pr.created_at DESC limit ?, ?';


    $mysqli = {};


    var escape_data = [prodId, req.session.userid];
    strQuery = mysqli.mysqli($mysqli, 'get_users_requests');


    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getConfirmedOffers = function(req, mysql, q, count, pTradingType) {

    console.log("getConfirmedOffers");

    var page = req.body.page;
    var perlimit = req.body.perlimit;
    var product_id = '';
    var prTradingType = '';
    page = (page > 0) ? (page - 1) * perlimit : 0;
    var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and p.title like "%'+req.body.search+'%"';
    }
    if ((typeof(req.body.productId) == undefined) || (req.body.productId == 'all'))
        product_id = '';
    else
        product_id = 'and pr.product_id = ' + req.body.productId;

    //((p.user_id = ? and p.trading_type="{{ptrading_type}}") or (pr.user_id = ? and pr.trading_type="{{prtrading_type}}"))

    if (pTradingType == 'sell')
        prTradingType = 'buy';
    else if (pTradingType == 'buy')
        prTradingType = 'sell';


    $mysqli = { whr: whr, ptrading_type: pTradingType, prtrading_type: prTradingType, productid: product_id };

    if (count == 0) {
        var escape_data = [req.session.userid, req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'get_conf_offers');
        
    } else if (count == 1) {
        var escape_data = [req.session.userid, req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'count_conf_offers');
    }

    var defered = q.defer();

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getRejectedOffers = function(req, mysql, q, count, pTradingType) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    var prTradingType = '';
    page = (page > 0) ? (page - 1) * perlimit : 0;
    var whr = '';
     if(req.body.search !== ''){
        whr = whr + 'and p.title like "%'+req.body.search+'%"';
    }
    if ((typeof(req.body.productId) == undefined) || (req.body.productId == 'all'))
        product_id = '';
    else
        product_id = 'and pr.product_id = ' + req.body.productId;

    //((p.user_id = ? and p.trading_type="{{ptrading_type}}") or (pr.user_id = ? and pr.trading_type="{{prtrading_type}}"))

    if (pTradingType == 'sell')
        prTradingType = 'buy';
    else if (pTradingType == 'buy')
        prTradingType = 'sell';

    $mysqli = {whr: whr, ptrading_type: pTradingType, prtrading_type: prTradingType, productid: product_id };

    if (count == 0) {
        var escape_data = [req.session.userid, req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'get_rejected_offers');
    } else if (count == 1) {
        var escape_data = [req.session.userid, req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'count_rejected_offers');
    }

    var defered = q.defer();

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getClosedProducts = function(req, mysql, q, count) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

    //((p.user_id = ? and p.trading_type="{{ptrading_type}}") or (pr.user_id = ? and pr.trading_type="{{prtrading_type}}"))
    var whr = '';
     if(req.body.search !== ''){
        whr = whr + 'and title like "%'+req.body.search+'%"';
    }
    $mysqli = {whr: whr};

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'get_closed_products');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'count_closed_products');
    }

    var defered = q.defer();

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.SearchPageNo = function(req, mysql, q) {

    delete data;
    data = odata = [];

    data = url.parse(req.url, true).query;
    data.where = '';
    //console.log(2);
    data.dspage = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
    return data;
}

exports.dbmarketbuyerpurchase = function(req, mysql, q, count) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + ' and p.title like "%'+req.body.search+'%"';
    }
    if(req.body.filter !== ''){
        if(req.body.filter == 'received') {
            whr = whr + ' and b.delivery_status="1"';
        } else if(req.body.filter == 'recurring') {
            whr = whr + ' and b.recurring="1"';
        } else if(req.body.filter == 'cod_paid') {
            whr = whr + ' and b.cod=1';
        }
    }
    

    $mysqli = { whr: whr };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'dbbuyyertab');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'dbbuyyertabcount');
    }

    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}


exports.updateRschPayStatus = function(req, mysql, q, id, recurp_id) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'change_rschpay_status');

    var pay_status = (req.session.cod!=undefined && req.session.cod==1 ? "unpaid" : "paid");
    var escape_data = [pay_status, id, recurp_id];

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
exports.updateRScheduleStarted = function(req, mysql, q, id, recurp_id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'updateRScheduleStarted');

    var escape_data = [id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('updateRScheduleStarted ', query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.dbmarketbuyerrpurchase = function(req, mysql, q, count) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

   var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and p.title like "%'+req.body.search+'%"';
    }

    $mysqli = { whr: whr };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'dbbuyyerrecurringtab');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'dbbuyyerrecurringtabc');
    }

    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getRpurchaseById = function(req, mysql, q) {

    console.log(req.body);
    
    $mysqli = {};

    var escape_data = [req.body.id];
    strQuery = mysqli.mysqli($mysqli, 'get_rec_byid');

    var defered = q.defer();

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getRScheculeById = function(req, mysql, q) {

    console.log(req.body);
    
    $mysqli = {};

    var escape_data = [req.body.id];
    strQuery = mysqli.mysqli($mysqli, 'get_rec_schedules');

    var defered = q.defer();

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
exports.countPaidSchedules = function(id, mysql, q) {

    $mysqli = {};

    var escape_data = [id];
    strQuery = mysqli.mysqli($mysqli, 'count_paid_schedule');

    var defered = q.defer();

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.getUnpaidRecurrings = function(mysql, q) {
 
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_unpaid_recurrings');
    var defered = q.defer();
    query = mysql.query(strQuery, defered.makeNodeResolver());
    // console.log('get_unpaid_recurrings', query.sql);
       query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}

exports.getFutureRecurrings = function(mysql, q) {
 
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_future_recurrings');
    var defered = q.defer();
    query = mysql.query(strQuery, defered.makeNodeResolver());
       query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}

exports.reduceReserveAmt = function(req, mysql, q, id, price) {
    console.log(id);
    console.log(price);
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'reduce_reserve_amt');
    var escape_data = [price,id];
    var defered = q.defer();
    query = mysql.query(strQuery,escape_data, defered.makeNodeResolver());
    console.log(query.sql);
       query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}

exports.addReserveAmount = function(req, mysql, q, id, price) {
    console.log(id);
    console.log(price);
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'update_reserve_price2');
    var escape_data = [price,id];
    var defered = q.defer();
    query = mysql.query(strQuery,escape_data, defered.makeNodeResolver());
    console.log(query.sql);
       query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}

exports.dbmarketbuyernego = function(req, mysql, q, count) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

    var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and p.title like "%'+req.body.search+'%"';
    }

    $mysqli = { whr: whr };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'dbmarketbuyernegodb');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'dbmarketbuyernegodbc');
    }

    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
exports.dbmarketbuyernegodec = function(req, mysql, q, count) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

     var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and p.title like "%'+req.body.search+'%"';
    }

    $mysqli = { whr: whr };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'dbmarketbuyernegodbacc');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'dbmarketbuyernegodbaccc');
    }

    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.sellerselling = function(req, mysql, q, count) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

    var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and title like "%'+req.body.search+'%"';
    }

    $mysqli = { whr: whr + ' and auction=0 ' };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'selleropen');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'selleropenc');
    }

    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.sellersold = function(req, mysql, q, count) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

    $mysqli = {};

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'sellersoldb');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'sellersoldbc');
    }

    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
exports.sellernegot = function(req, mysql, q, count) {

    console.log(req.body);
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

     var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and title like "%'+req.body.search+'%"';
    }
    $mysqli = { whr: whr };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'sellernegotdb');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'sellernegotdbc');
    }

    var defered = q.defer();


    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
exports.btncheckrecurup = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'btncheckrecurupdb');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [req.body.rid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}
exports.buyerRecCancelReq = function(req, mysql, q, id) {

    $mysqli = {};

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'buyer_cancel_req');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [datge, id];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}

exports.sellerRecCancelApproval = function(req, mysql, q, id) {

    $mysqli = {};

    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'seller_cancel_approval');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [datge, id];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}

/* getting buyer_id from negotiable requests*/
exports.nego_buyer_id = function(req, res, mysql, q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'nego_buyerid');
    var defered = q.defer();
    var escape_data = [req.body.req_id, req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('getting negotiable buyer id ------------------- ' + query.sql);
    query.on('error', function(error){
        throw error;
    })
    return defered.promise;
}

exports.btnacceptnegom = function(req, mysql, q) {

    $mysqli = {};
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'btnacceptnegomd');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [datge,req.body.bid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("btnacceptnegom "+query.sql);
    return defered.promise;

}

exports.declineRemainMax = function(req, mysql, q) {

    $mysqli = {};
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'btnaccept_declinemax');
    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    //var escape_data = [req.body.remain_qty, req.body.pid]
    // var escape_data = [datge, req.body.qty, req.body.pid];
    var escape_data = [datge, req.body.remain_qty, req.body.pid];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("declineRemainMax "+query.sql);
    query.on('error', function(err) {
        throw err;
    });


    return defered.promise;

}
exports.btnrejectnegom = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'btnrejectnegomd');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [req.body.bid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}
exports.btnrejectnegomesgm = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'btnrejectnegomesgmd');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [req.body.rmesg, req.body.bid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}

/* Getting recurrings at seller side */
exports.sellerrecuring = function(req, mysql, q, count) {
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

    var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and title like "%'+req.body.search+'%"';
    }
    $mysqli = { whr: whr};

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'sellerrecuring');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'sellerrecuringc');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('sellerrecuring ', query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.sellerrejected = function(req, mysql, q, count) {
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

    var whr = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and title like "%'+req.body.search+'%"';
    }
    $mysqli = { whr: whr };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'sellerrejected');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'sellerrejectedc');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
exports.sellerinventory = function(req, mysql, q, count) {
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

    var whr = '';
    var ordering = '';
    $mysqli = {};
     if(req.body.search !== ''){
        whr = whr + 'and title like "%'+req.body.search+'%"';
    }

    if(req.param('sort') != undefined && req.param('sort')!='') {
        var direction = '';
        if(req.param('direction')!=undefined && req.param('direction')!='') {
            direction = req.param('direction');
        }
        ordering = ' ORDER BY ' + req.param('sort') + ' ' + direction;
    }

    $mysqli = { whr: whr, ordering: ordering };

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'sellerinventory');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'sellerinventoryc');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('sellerinventory ', query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
exports.selleraccepted = function(req, mysql, q, count) {
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    page = (page > 0) ? (page - 1) * perlimit : 0;

    $mysqli = {};

    if (count == 0) {
        var escape_data = [req.session.userid, page, perlimit];
        strQuery = mysqli.mysqli($mysqli, 'selleraccepted');
    } else if (count == 1) {
        var escape_data = [req.session.userid];
        strQuery = mysqli.mysqli($mysqli, 'selleracceptedc');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
exports.updateprojectqty = function(req, mysql, q, pid, qty) {

    $mysqli = {};
    // strQuery = mysqli.mysqli($mysqli, 'updateprojectqty');
    // var escape_data1 = [qty, pid];
    strQuery1 = mysqli.mysqli($mysqli, 'updateprojectsold');
    var defered = q.defer();
    var escape_data = [qty, pid];
    //console.log(escape_data);               
    // query = mysql.query(strQuery, escape_data1, defered.makeNodeResolver());
    console.log(query.sql);
    query = mysql.query(strQuery1, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}

exports.checkRequestStatus = function(req, mysql, q, bid,pid) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'check_req_status');
    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [bid,pid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log("checprocount"+query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;

}

exports.checkBuynowForNRequest = function(req, mysql, q, bid,pid) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'check_buynow_req');
    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [bid,pid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log("checprocount"+query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;

}

exports.checprocount = function(req, mysql, q, pid) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'checprocount');
    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [pid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log("checprocount"+query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;

}

exports.getprobid = function(req, mysql, q, pid) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getprobid');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [pid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}

exports.updatebidstatus = function(req, mysql, q, bid) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'updatebidstatus');

    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [bid]
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}

exports.rejectNegoRequests = function(req, mysql, q, pid, remainQty, rejMsg) {

// prodRequests.rejectNegoRequests(req, config.mysql, q, pid, remainig_qty, "Rejected due to insufficient quantity. available quantity is "+remainig_qty);
//mysqli['reject_remain_nreq'] ='UPDATE negotiable SET declined = 1, declined_date=?, reject_mesg = ? WHERE project_id = ? and awarded = 0 and qty_request > ?';
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'reject_remain_nreq');
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    //req.body.userid,req.body.qtyreq;
    var escape_data = [datge,rejMsg,pid,remainQty];
    //console.log(escape_data);               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;

}

exports.makeBoughtnego = function(req, mysql, q, id, bprice, qty) {
    $mysqli = {};


    strQuery = mysqli.mysqli($mysqli, 'negobuynow');
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [id, req.session.userid, bprice, qty, 0, datge];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}

exports.getnegoamt = function(req, mysql, q, bid) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'negoamt');
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [bid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getnegoamt "+query.sql);
    return defered.promise;
}

exports.getRecurring = function(mysql, q, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getrecurre');
    var defered = q.defer();
    var escape_data = [id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
 
    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.acceptRecurring = function(mysql, q, status, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'change_recur_status');
    var defered = q.defer();
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [status, datge, id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
 
    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.rejectRecurring = function(mysql, q, status, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'change_recur_status');
    var defered = q.defer();
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [status, datge, id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
 
    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.buyer_id = function(req, res, mysql, q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'buyerid_recurring');
    var defered = q.defer();
    var escape_data = [req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    // console.log('prabakaran', query.sql);
    query.on('error', function(error){
        throw error;
    })
    return defered.promise;
}


/* update last inf-fund-date in recurring purchase while recurring cron */
exports.updateInfFundDate = function(req, mysql, q, id) {
    $mysqli = {}
    var defered = q.defer();
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'update_inf_fund_at');
    // mysqli['update_spay_status'] ='update buynow set seller_paid_status = "1", 
    //seller_paid_at = ?, seller_paid_amt = ? where id = ? and paid = 1 and 
    //seller_paid_status = 0 and user_id = ?';
    var escape_data = [datge,id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log('buynow paid status changed ---- '+query.sql);
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}