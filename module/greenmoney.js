var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var products = require('./products');

exports.checkUserBuynow = function(req, mysql, q) {
    id = req.body.id;
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'check_buynow_rec');
    var defered = q.defer();
    var escape_data = [req.body.id, req.body.buyer_id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

exports.checkBuynow = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'check_buynow');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var escape_data = [
        obj.user_id,
        obj.project_id,
        obj.qty,
        obj.amount,
        obj.commission,
        obj.accept,
        obj.request_id,
        datenow
    ];

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });

    return defered.promise;

}

exports.insertBuynow = function(req, mysql, q, obj) {

    // console.log("----obj----: " + JSON.stringify(obj));

    if (typeof(obj.cart_id) != 'undefined') {
        $mysqli = { cart_id_value: ',' + obj.cart_id, cart_id: ', cart_id' };
    } else {
        $mysqli = { cart_id_value: '', cart_id: '' };
    }

    var nego_status = (typeof(obj.negotiable) == 'undefined' || obj.negotiable == 0) ? 0 : 1;

    strQuery = mysqli.mysqli($mysqli, 'insert_buynow');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    
    /* ===================== start change by divyesh (changes) ===================== */
    var escape_data = [
        obj.user_id,
        obj.project_id,
        obj.qty,
        parseFloat(obj.amount),
        obj.commission,
        obj.accept,
        obj.request_id,
        datenow,
        parseFloat(obj.total_amount),
        parseFloat(obj.commission_amt),
        obj.stax_status,
        parseFloat(obj.stax_per),
        parseFloat(obj.stax_amt),
        (typeof(obj.consultant_fee) == 'undefined') ? 0 : obj.consultant_fee ,
        (typeof(obj.consultant_fee_amount) == 'undefined') ? 0 : obj.consultant_fee_amount,

(typeof(obj.excise_markup_per) == 'undefined') ? 0 : obj.excise_markup_per,
(typeof(obj.excise_markup_value) == 'undefined') ? 0 : obj.excise_markup_value,
(typeof(obj.excise_tax_per) == 'undefined') ? 0 : obj.excise_tax_per,
(typeof(obj.excise_tax) == 'undefined') ? 0 : obj.excise_tax,
(typeof(obj.distribution_tax_per) == 'undefined') ? 0 : obj.distribution_tax_per,
(typeof(obj.distribution_tax) == 'undefined') ? 0 : obj.distribution_tax,
(typeof(obj.cultivation_tax) == 'undefined') ? 0 : obj.cultivation_tax,
(typeof(obj.cultivation_tax_per) == 'undefined') ? 0 : obj.cultivation_tax_per,

// excise_markup_per,excise_markup_amt,excise_tax_per,excise_tax_amt,distribution_tax_per,distribution_tax,cultivation_tax,cultivation_tax_per,

        (typeof(obj.paid) == 'undefined') ? 0 : obj.paid ,
        datenow,
        obj.request_userid,
        nego_status,
        (req.session.cod!=undefined && req.session.cod==1 ? 1 : 0)
    ];
    /* ===================== end change by divyesh (changes) ===================== */

    var defered = q.defer();
    console.log(strQuery);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });

    return defered.promise;

}

exports.fundRequest = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'fund_request');
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_string = [
        req.session.userid,
        req.body.amount,
        datge,
        req.files.wirefund_receipt.name,
        req.files.wirefund_receipt.originalname
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.checkRequest = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'check_request');
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_string = [
        req.session.userid,
        req.body.amount,
        datge
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}

exports.refundRequest = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'refund_request');
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_string = [
        req.session.userid,
        req.body.amount,
        datge
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}

exports.updateFundRequest = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'update_fund_request');
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_string = [
        req.body.status,
        req.body.rej_msg,
        req.body.id
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}
exports.getUnverifiedCount = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_unverified_count');
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.getFundRequests = function(req, mysql, q, type, count, uids) {
    var dateFormat = require('dateformat');

    var mysq = 'get_fund_requests_count';
    var whr = '';
    var str = '';

 
    if (type != '') {
        if (type != 'all') {
            whr = whr + ' where type = "' + type + '" ';
        } else {
            whr = '';
        }
    }

    if (req.body.from_date != '') {
        req.body.from_date = dateFormat((req.body.from_date), "yyyy-mm-dd")
        if (whr == '') {
            whr = whr + ' where DATE(created_at) >= "' + req.body.from_date + '" ';
        } else {
            whr = whr + ' and DATE(created_at) >= "' + req.body.from_date + '" ';
        }


    }

    if (req.body.to_date != '') {
        req.body.to_date = dateFormat((req.body.to_date), "yyyy-mm-dd");

        if (whr == '') {
            whr = whr + ' where DATE(created_at) <= "' + req.body.to_date + '" ';
        } else {
            whr = whr + ' and DATE(created_at) <= "' + req.body.to_date + '" ';
        }
    }

    if (req.body.req_status != '') {
        // req.body.req_status = dateFormat((req.body.req_status), "yyyy-mm-dd");

        if (whr == '') {
            whr = whr + ' where status= "' + req.body.req_status + '" ';
        } else {
            whr = whr + ' and status= "' + req.body.req_status + '" ';
        }
    }

   if (uids.length > 0) {
        for (var i = 0; i < uids.length; i++) {
            if (i == 0) {
                if(whr != ''){
                    str = str + ' and user_id in (' + uids[i];    
                } else {
                    str = str + ' where user_id in (' + uids[i];    
                }

                if ((uids.length - 1) == 0) {
                    str = str + uids[i] + ')';
                } else {
                    str = str + ', ';
                }
            } else if (i == (uids.length - 1)) {
                str = str + uids[i] + ')';
            } else {
                str = str + uids[i] + ', ';
            }
        }
    }

    $mysqli = { whr: whr +' '+ str};

    var escape_data = [];

    if (count == 0) {
        mysq = 'get_fund_requests';
        escape_data = [(req.body.page - 1) * 10, 10];
    }

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    })

    //console.log("Admin product qry "+query.sql);
    return defered.promise;
}
exports.getReFundRequests = function(req, mysql, q, type, count, uids) {
    var dateFormat = require('dateformat');

    var mysq = 'get_fund_requests_count';
    var whr = '';
    var str = '';

 
    if (type != '') {
        if (type != 'all') {
            whr = whr + ' where type = "' + type + '" ';
        } else {
            whr = '';
        }
    }

    if (req.body.from_date != '') {
        req.body.from_date = dateFormat((req.body.from_date), "yyyy-mm-dd")
        if (whr == '') {
            whr = whr + ' where DATE(created_at) >= "' + req.body.from_date + '" ';
        } else {
            whr = whr + ' and DATE(created_at) >= "' + req.body.from_date + '" ';
        }


    }

    if (req.body.to_date != '') {
        req.body.to_date = dateFormat((req.body.to_date), "yyyy-mm-dd");

        if (whr == '') {
            whr = whr + ' where DATE(created_at) <= "' + req.body.to_date + '" ';
        } else {
            whr = whr + ' and DATE(created_at) <= "' + req.body.to_date + '" ';
        }
    }

   if (uids.length > 0) {
        for (var i = 0; i < uids.length; i++) {
            if (i == 0) {
                if(whr != ''){
                    str = str + ' and user_id in (' + uids[i];    
                } else {
                    str = str + ' where user_id in (' + uids[i];    
                }

                if ((uids.length - 1) == 0) {
                    str = str + uids[i] + ')';
                } else {
                    str = str + ', ';
                }
            } else if (i == (uids.length - 1)) {
                str = str + uids[i] + ')';
            } else {
                str = str + uids[i] + ', ';
            }
        }
    }

    $mysqli = { whr: whr +' '+ str};

    var escape_data = [];

    if (count == 0) {
        mysq = 'get_fund_requests';
        escape_data = [(req.body.page - 1) * 10, 10];
    }

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    })

    //console.log("Admin product qry "+query.sql);
    return defered.promise;
}

exports.getFundRequest = function(req, mysql, q) {
    var dateFormat = require('dateformat');

    var mysq = 'get_fund_request';

    $mysqli = {};

    var escape_data = [req.body.id];

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    })

    //console.log("Admin product qry "+query.sql);
    return defered.promise;
}

exports.updatePaymentReq = function(req, mysql, q) {
    var dateFormat = require('dateformat');

    var mysq = 'update_payrequest';

    $mysqli = {};

    var escape_data = [req.body.status, req.body.amount, req.body.id];

    strQuery = mysqli.mysqli($mysqli, mysq);
    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    })

    //console.log("Admin product qry "+query.sql);
    return defered.promise;
}

exports.wire_fund = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'wire_fund');
    var escape_string = [
        req.params.id
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}