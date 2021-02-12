var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');
exports.show = function(mysql, callback) {
    var row = [];
    callback(row);
}
exports.getCsvPayments = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx252');
    var defered = q.defer();

    var escape_data = [req.session.userid, req.session.userid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.getPayments = function(req, mysql, q) {

    var whr = '';
    var where = '';
    var inv_id = '';

    
    if (req.body.istatus !== '') {  
            where = where + ' and i.istatus = "'+req.body.istatus+'"';    
        if(req.body.istatus == "credit"){
            whr = whr + ' or b.request_userid = "'+req.session.userid+'"';    
        }
    } else {
            whr = whr + ' or b.request_userid = "'+req.session.userid+'"';   
    }

    if (req.body.status !== '') {
        inv_id = inv_id + ' and i.status = "'+req.body.status+'"';
    }

    if (req.body.type !== '') {
        inv_id = inv_id + ' and i.type = "'+req.body.type+'"';
    }

    if(req.body.invoice_id !== '' || req.body.status !== ''){
        inv_id = inv_id + ' and i.id like "%'+req.body.invoice_id+'%"';
    }



   /* req.body.start_date = ((typeof(req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : dateFormat((req.param('start_date'), "yyyy-mm-dd HH:MM:ss"));
    req.body.end_date = ((typeof(req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' :dateFormat((req.param('end_date'), "yyyy-mm-dd HH:MM:ss"));
*/



    if( req.body.start_date != '' && req.body.end_date ==''){
        inv_id = inv_id + ' and i.date_added <="'+ req.body.start_date+'" ';
    }

    if( req.body.end_date !== '' && req.body.start_date ==''){
        inv_id = inv_id + ' and i.date_added =>"'+ req.body.end_date+'" ';
    }

    if(req.body.end_date != '' && req.body.start_date !=''){
        //inv_id = inv_id + ' and (i.date_added <="'+ req.body.end_date+'" or i.date_added >= "'+req.body.end_date+'") ';
        inv_id = inv_id + ' and (i.date_added BETWEEN "'+req.body.start_date+'" and "'+req.body.end_date+'") ';
    }

    // $mysqli = { whr: whr };
    $mysqli = { whr: whr , where : where, inv_id : inv_id};
    strQuery = mysqli.mysqli($mysqli, 'cnx245');
    var defered = q.defer();
    page = (req.body.page - 1) * req.body.perlimit;
    limit = req.body.perlimit;
    // var escape_data = [req.session.userid, req.session.userid, req.session.userid, page, limit];
    var escape_data = [req.session.userid, req.session.userid, page, limit];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getPayments "+query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}
exports.getAllPayments = function(req, mysql, q) {
    var whr = '';
    var where = '';
    var inv_id = '';

    
    if (req.body.istatus !== '') {  
            where = where + ' and i.istatus = "'+req.body.istatus+'"';    
        if(req.body.istatus == "credit"){
            whr = whr + ' or b.request_userid = "'+req.session.userid+'"';    
        }
    } else {
            whr = whr + ' or b.request_userid = "'+req.session.userid+'"';   
    }

    if (req.body.status !== '') {
        inv_id = inv_id + ' and i.status = "'+req.body.status+'"';
    }

    if (req.body.type !== '') {
        inv_id = inv_id + ' and i.type = "'+req.body.type+'"';
    }

    if(req.body.invoice_id !== '' || req.body.status !== ''){
        inv_id = inv_id + ' and i.id like "%'+req.body.invoice_id+'%"';
    }
    req.body.start_date = req.param('start_date');
    req.body.end_date = req.param('end_date');


    if( req.body.start_date != '' && req.body.end_date ==''){
        inv_id = inv_id + ' and i.date_added <="'+ req.body.start_date+'" ';
    }

    if( req.body.end_date !== '' && req.body.start_date ==''){
        inv_id = inv_id + ' and i.date_added =>"'+ req.body.end_date+'" ';
    }

    if(req.body.end_date != '' && req.body.start_date !=''){
        //inv_id = inv_id + ' and (i.date_added <="'+ req.body.end_date+'" or i.date_added >= "'+req.body.end_date+'") ';
        inv_id = inv_id + ' and (i.date_added BETWEEN "'+req.body.start_date+'" and "'+req.body.end_date+'") ';
    }
    // $mysqli = { whr: whr };
    $mysqli = { whr: whr , where : where, inv_id : inv_id};
    strQuery = mysqli.mysqli($mysqli, 'cnx244');
    var defered = q.defer();
    page = (req.body.page - 1) * 10;
    // var escape_data = [req.session.userid, req.session.userid, req.session.userid];
    var escape_data = [req.session.userid, req.session.userid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}

exports.listfeedback = function(req, mysql, q, count) {
    $mysqli = {};
    var page = req.body.page;
    var perlimit = req.body.perlimit;

    var defered = q.defer();
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 1) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }

    $mysqli = { limit: limit };
    var escape_data = [req.session.userid];
    console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, '298');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.setAverageFeedBack = function(req, mysql, q, avg, m) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx236');
    var defered = q.defer();
    var escape_data = [avg, m];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.submitFeedbackCart = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx235');
    var defered = q.defer();
    var escape_data = [req.body.bid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.addFeedBackPoint = function(req, mysql, q, m, point, id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx234');
    var defered = q.defer();
    var escape_data = [m, point, id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.addFeedBack = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx233');
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    var escape_data = [req.body.title, req.body.content, datge, req.body.bid]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.getFeedBack = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx232');
    var defered = q.defer();
    var escape_data = [req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.addInvoice = function(req, mysql, q) {
    $mysqli = {};
    //cnx239
    strQuery = mysqli.mysqli($mysqli, 'cnx239new');
    var defered = q.defer();
    var escape_data = [req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
   
    console.log("Get Invoice details Query is " + query.sql);
    return defered.promise;
}
exports.getFeedBackData = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx238');
    var defered = q.defer();
    var escape_data = [req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateShippTrackInfo = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx231');
    var defered = q.defer();
    var escape_data = [req.body.shipping_info, req.body.shipping_id, req.body.shipping_service, req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.addUserReview = function(req, mysql, q, avg, m) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx237');
    var defered = q.defer();
    var escape_data = [avg, m]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.deleteBuynowRecord = function(req, mysql, q) {
    id = req.body.id;
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'delete_buybow');
    var defered = q.defer();
    var escape_data = [req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}

exports.getBuynowRecord = function(req, mysql, q) {
    id = req.body.id;
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx220');
    var defered = q.defer();
    var escape_data = [req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getBuynowRecord "+query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}

exports.getDBBuynowRecord = function(req, mysql, q) {
    id = req.body.id;
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx220db');
    var defered = q.defer();
    var escape_data = [req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getBuynowRecord "+query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}

exports.getBidsRecord = function(req, mysql, q) {
    id = req.body.id;
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx221');
    var defered = q.defer();
    var escape_data = [req.body.id]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.paymentBuyNowRelease = function(req, mysql, q, id) {

    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'cnx222');
    var defered = q.defer();
    var escape_data = [datge, id, req.session.userid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}
exports.paymentBuyNowCancel = function(req, mysql, q, id) {

    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'cnx223');
    var defered = q.defer();
    var escape_data = [datge, id, req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.paymentBidRelease = function(req, mysql, q, id) {

    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'cnx224');
    var defered = q.defer();
    var escape_data = [datge, id, req.session.user_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.paymentBidCancel = function(req, mysql, q, id) {

    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'cnx225');
    var defered = q.defer();
    var escape_data = [datge, id, req.session.user_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.saveaddress = function(req, mysql, q, doauction) {
    $mysqli = {};
    if (doauction == 'save')
        strQuery = mysqli.mysqli($mysqli, 101);
    if (doauction == 'update')
        strQuery = mysqli.mysqli($mysqli, 103);
    var defered = q.defer();
    var escape_data = [req.body.name,
        req.body.address1,
        req.body.address2,
        req.body.country,
        req.body.state,
        req.body.city,
        req.body.zipcode,
        req.body.phone,
        (typeof(req.session) !== 'undefined') ? req.session.userid : 0,
        req.body.type
    ]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.getAddresses = function(req, mysql, q, Addtype) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 102);
    var defered = q.defer();
    var escape_data = [(typeof(req.session) !== 'undefined') ? req.session.userid : 0, Addtype]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}


exports.getReferral = function(req, mysql, q, isadmin, count) {
    $mysqli = {};
    if (isadmin == 1) {
        if (count == 1) {
            strQuery = mysqli.mysqli($mysqli, 120);
            var escape_data = [];
        } else {
            strQuery = mysqli.mysqli($mysqli, 118);
            page = (req.body.page - 1) * 10;
            var escape_data = [page];
        }
    } else {
        strQuery = mysqli.mysqli($mysqli, 105);
        var escape_data = [(typeof(req.session) !== 'undefined') ? req.session.userid : 0]
    }
    var defered = q.defer();
    // var escape_data =  [(typeof(req.session) !== 'undefined')  ? req.session.userid : 0]               
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);
    return defered.promise;
}

exports.getOpenProjects = function(req, mysql, q) {
    datge = dateFormat(new Date(), "yyyy-mm-dd");
    $mysqli = { datge: datge };
    strQuery = mysqli.mysqli($mysqli, 106);
    var defered = q.defer();
    var escape_data = [(typeof(req.session) !== 'undefined') ? req.session.userid : 0]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}


exports.saveAutobid = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 107);
    var defered = q.defer();
    var escape_data = [(typeof(req.session) !== 'undefined') ? req.session.userid : 0,
        req.body.project_id,
        req.body.start_amount,
        req.body.amount,
        req.body.amount,
        dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss")
    ]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}


exports.checkAutobid = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 109);
    var defered = q.defer();
    var escape_data = [(typeof(req.session) !== 'undefined') ? req.session.userid : 0,
        req.body.project_id
    ]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.fetchAutobidlist = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 110);
    var defered = q.defer();
    var escape_data = [(typeof(req.session) !== 'undefined') ? req.session.userid : 0]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.getBuynowDetail = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 982);
    var defered = q.defer();
    var escape_data = [req.param('id'), req.session.userid]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.mybuynow = function(req, mysql, q, count) {
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    console.log('page' + req.session.userid);
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 1) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }
    console.log('page' + limit);
    $mysqli = { limit: limit };
    cnt = 'cnx227';
    var escape_data = [req.session.userid];

    //console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, cnt);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

exports.myorders = function(req, mysql, q, count) {
    var page = req.body.page;
    var perlimit = req.body.perlimit;
    console.log('page' + req.session.userid);
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 1) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }
    var where = "";
    if (req.body.searchtitle) {
        where += " and title like '%" + req.body.searchtitle + "%'";
    }
    if (((typeof(req.body.searchdateFrom) !== 'undefined') && req.body.searchdateFrom !== 'null' && req.body.searchdateFrom !== '') && ((typeof(req.body.searchdateTo) !== 'undefined') && req.body.searchdateTo !== 'null' && req.body.searchdateTo !== '')) {
        where += " and b.date_added BETWEEN '" + req.body.searchdateFrom + "' AND '" + req.body.searchdateTo + "'";
    }
    if (((typeof(req.body.pricefrom) !== 'undefined') && req.body.pricefrom !== 'null' && req.body.pricefrom !== '') && ((typeof(req.body.priceto) !== 'undefined') && req.body.priceto !== 'null' && req.body.priceto !== '')) {
        where += " and b.amount BETWEEN '" + req.body.pricefrom + "' AND '" + req.body.priceto + "'";

    }

    console.log('page' + limit);
    $mysqli = { limit: limit, where: where };
    cnt = 'cnx2227';
    var escape_data = [req.session.userid];

    //console.log(escape_data);
    strQuery = mysqli.mysqli($mysqli, cnt);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('************************************************************');
    console.log(query.sql);
    console.log('************************************************************');
    return defered.promise;
}

exports.updateReferralStatus = function(req, mysql, q, rid) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 119);
    var defered = q.defer();
    var escape_data = [rid]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}


exports.removeAddresses = function(req, mysql, q, Addtype) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 121);
    var defered = q.defer();
    var escape_data = [(typeof(req.session) !== 'undefined') ? req.session.userid : 0, Addtype]
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.getFeedFields = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 802);
    var defered = q.defer();
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.listfeedbackrating = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, '810');
    var defered = q.defer();
    var escape_data = [req.session.userid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.emailshipdetails = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, '816');
    var defered = q.defer();
    var escape_data = [req.body.id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.allreferrals = function(req, mysql, q, count) {

    $mysqli = {};
    var id = req.session.userid;
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 850);
        var escape_data = [id];
    } else {
        strQuery = mysqli.mysqli($mysqli, 849);
        page = (req.body.page - 1) * 10;
        var escape_data = [id, page];
    }

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.totalpoints = function(req, mysql, q) {

    $mysqli = {};
    var id = req.session.userid;
    strQuery = mysqli.mysqli($mysqli, 848);
    var defered = q.defer();
    var escape_data = [id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.buyer_title = function(req, mysql, q) {

    $mysqli = {};
    var id = req.session.userid;
    strQuery = mysqli.mysqli($mysqli, 651);
    var defered = q.defer();
    var escape_data = [id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;

}

exports.seller_title = function(req, mysql, q) {

    $mysqli = {};
    var id = req.session.userid;
    strQuery = mysqli.mysqli($mysqli, 652);
    var defered = q.defer();
    var escape_data = [id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;

}
exports.get_temp_ids = function(req, mysql, q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'templates_id');

    var defered = q.defer();
    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;
}
exports.save_usernotify = function(req, mysql, q) {
    $mysqli = {};
    console.log("&&&&&&&&&&&&&&&&&&&&&&&&&",req.body.result_userid,req.session.userid,req.body.notify_id);
    if (req.body.notify_id == 0) {
        strQuery = mysqli.mysqli($mysqli, 653);
        var escape_data = [req.body.result_userid,  req.body.email_settings, req.body.email_settings];  
    } else {
        strQuery = mysqli.mysqli($mysqli, 655);
        var escape_data = [req.session.userid, req.body.email_settings, req.body.sms_settings, req.body.notify_id];

    }

    console.log("666666666666666666666666666");
    console.log(strQuery);
    console.log(escape_data);
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;

}

exports.get_settings = function(req, mysql, q) {

    $mysqli = {};
    var id = req.session.userid;
    strQuery = mysqli.mysqli($mysqli, 654);
    var defered = q.defer();
    var escape_data = [req.session.userid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;

}

exports.verified_phone = function(req, mysql, q) {

    $mysqli = {};
    var id = req.session.userid;
    strQuery = mysqli.mysqli($mysqli, 656);
    var defered = q.defer();
    req.body.Called = req.body.Called.replace('+', '');
    var escape_data = ['+' + req.body.Called, req.body.uid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.phoneverified = function(req, mysql, q) {

    $mysqli = {};
    var id = req.session.userid;
    strQuery = mysqli.mysqli($mysqli, 657);
    var defered = q.defer();
    var escape_data = [req.session.userid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;

}

exports.getcartnowRecord = function(req, mysql, q) {
    id = req.body.id;
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'yab5');
    var defered = q.defer();
    var escape_data = [req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}


exports.blocked_users = function(req, mysql, q, count) {

    $mysqli = {};
    var id = req.session.userid;

    var defered = q.defer();
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 500);
        var escape_data = [id];
    } else {
        strQuery = mysqli.mysqli($mysqli, 503);
        page = (req.body.page - 1) * 15;
        var escape_data = [id, page];
    }

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.block_user = function(req, mysql, q) {

    $mysqli = {};
    var sid = req.session.userid;
    var email = req.body.block_mail;
    strQuery = mysqli.mysqli($mysqli, 501);
    var defered = q.defer();
    var escape_data = [email, sid, dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss")];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.unblock_user = function(req, mysql, q, id) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 502);
    var defered = q.defer();
    var escape_data = [id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.check_uid = function(req, mysql, q, mail) {

    $mysqli = {};
    var sid = req.session.userid;
    var uid = mail;
    strQuery = mysqli.mysqli($mysqli, 504);
    var defered = q.defer();
    var escape_data = [uid, sid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.check_if_exist = function(req, mysql, q, mail) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 505);
    var defered = q.defer();
    var escape_data = [mail];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.block_bids_of_user = function(req, mysql, q) {

    $mysqli = {};
    var sid = req.session.userid;
    var email = req.body.block_mail;
    strQuery = mysqli.mysqli($mysqli, 507);
    var defered = q.defer();
    var escape_data = [email, sid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.block_buys_of_user = function(req, mysql, q) {

    $mysqli = {};
    var sid = req.session.userid;
    var email = req.body.block_mail;
    strQuery = mysqli.mysqli($mysqli, 508);
    var defered = q.defer();
    var escape_data = [email, sid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.transfer_product = function(req, mysql, q) {

    $mysqli = {};
    var sid = req.body.product_id;
    var email = req.body.transfer_mail;
    strQuery = mysqli.mysqli($mysqli, 550);
    var defered = q.defer();
    var escape_data = [email, sid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.cancel_ownerbids = function(req, mysql, q) {

    $mysqli = {};
    var sid = req.body.product_id;
    var email = req.body.transfer_mail;
    strQuery = mysqli.mysqli($mysqli, 553);
    var defered = q.defer();
    var escape_data = [email, sid];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.getuser_details = function(req, mysql, q, email) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 551);
    var defered = q.defer();
    var escape_data = [email];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.product_details = function(req, mysql, q, id) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 552);
    var defered = q.defer();
    var escape_data = [id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

exports.get_mail_ids = function(req, mysql, q, id) {



    var sim = id;
    $mysqli = { search: sim };
    strQuery = mysqli.mysqli($mysqli, 510);
    var defered = q.defer();
    var escape_data = [];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}

exports.get_debits = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_debits');
    var defered = q.defer();
    var escape_data = [req.session.userid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.sale_figure = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'sale_figure');
    var defered = q.defer();
    var escape_data = [req.session.userid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.getSellerPerformance = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_seller_performance');
    var defered = q.defer();
    var escape_data = [req.session.userid, req.param('id')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}

exports.getBuyerPerformance = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_buyer_performance');
    var defered = q.defer();
    var escape_data = [req.session.userid, req.param('id')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}


exports.seller_performance = function(req, mysql, q) {
    $mysqli = {
        seller_id: req.body.seller_id,
        store_id: req.body.store_id,
        product_id: req.body.product_id,
        accurate: req.body.accurate,
        performance: req.body.performance,
        delivery: req.body.delivery,
        packing: req.body.packing,
        questions: req.body.questions,
        resolving: req.body.resolving,
        customer_support: req.body.customer_support,
        satisfaction: req.body.satisfaction,
        comment: req.body.comment,
        buyer_id: req.session.userid,
        admin_approval: 0,
        avg_rating : req.body.avg_rating
    };
    strQuery = mysqli.mysqli($mysqli, 'seller_performance');
    var defered = q.defer();
    var escape_data = [req.session.userid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.insert_Sreview_data = function(req, mysql, q, data) {
    var buy_id = (typeof(req.body.buy_id) !== 'undefined') ? req.body.buy_id : 0;
    var comment = (typeof(data.comment) !== 'undefined') ? data.comment : '';
    var avg_rating = (typeof(data.avg_rating) !== 'undefined') ? data.avg_rating : 0;
    var id = (typeof(data.id) !== 'undefined') ? data.id : 0;
    $mysqli = {};
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'review_insert');
    var defered = q.defer();
    var escape_data = [req.session.userid, buy_id, datge,'review',comment,avg_rating,0,0,id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query',query.sql);
    return defered.promise;
}
exports.insert_review_data = function(req, mysql, q, data) {
    var buy_id = (typeof(req.body.buy_id) !== 'undefined') ? req.body.buy_id : 0;
    var comment = (typeof(data.comment) !== 'undefined') ? data.comment : '';
    var avg_rating = (typeof(data.avg_rating) !== 'undefined') ? data.avg_rating : 0;
    var id = (typeof(data.id) !== 'undefined') ? data.id : 0;
    $mysqli = {};
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'review_insert');
    var defered = q.defer();
    var escape_data = [req.session.userid, buy_id, datge,'review',comment,avg_rating,0,id,0];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query',query.sql);
    return defered.promise;
}
exports.seller_performance_data = function(req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'seller_performance_data');
    var defered = q.defer();
    var escape_data = [req.body.insert_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.buyer_performance_data = function(req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'buyer_performance_data');
    var defered = q.defer();
    var escape_data = [req.body.insert_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.buyer_performance = function(req, mysql, q) {
    $mysqli = {
        buyer_id: req.body.buyer_id,
        store_id: req.body.store_id,
        delivery: req.body.delivery,
        deliveryinfo: req.body.deliveryinfo,
        prodinspect: req.body.prodinspect,
        delreceipt: req.body.delreceipt,
        personnel: req.body.personnel,
        tpayment: req.body.tpayment,
        comment: req.body.comment != undefined ? req.body.comment : '',
        seller_id: req.session.userid,
        admin_approval: 0,
        avg_rating: req.body.avg_rating
    };

    strQuery = mysqli.mysqli($mysqli, 'buyer_performance');
    var defered = q.defer();
    var escape_data = [req.session.userid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}


exports.getResearchReport = function(req, mysql, q, count) {

    // console.log(req.param('id'));

    $mysqli = { whr : '' };

    if(req.body.sortby != ''){
        $mysqli = { whr : ' and ' + '(c.name like "%'+req.body.sortby+'%" or cat.name like "%'+req.body.sortby+'%")' };
        //(c.name like "%Concentrate%" or cat.name like "%Flowere%")
    }

    var defered = q.defer();

    if(count == 0){
        var page = (req.body.page - 1) * req.body.limit;
        strQuery = mysqli.mysqli($mysqli, 'get_research_report');
        escape_fields = [req.session.userid, page, req.body.limit,];
    } else if (count == 1){
        strQuery = mysqli.mysqli($mysqli, 'get_research_reportc');
        escape_fields = [req.session.userid];
    }  else if (count == 2){
        strQuery = mysqli.mysqli($mysqli, 'get_research_reportcd');
        escape_fields = [req.session.userid];
    }

 
    // strQuery = mysqli.mysqli($mysqli, 'get_research_report');
    
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.delete_product = function(req, mysql, q) {
    id = req.body.id;
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'delete_product');
    var defered = q.defer();
    var escape_data = [req.body.id]
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err.stack;
    })
    return defered.promise;
}
