var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');
var cryptos = require('./crypto');
var faAPI = require('../module/forwardauction_api');
var async = require('async');


exports.checkusername = function (mysql, req) {
    $mysqli = {
        username: req.body.username
    };
    strQuery = mysqli.mysqli($mysqli, 'checkusername');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    //console.log('checkusername', query.sql)
    return defered.promise;
}
exports.checkemail = function (mysql, req) {
    $mysqli = {
        email: req.body.cg_email
    };
    strQuery = mysqli.mysqli($mysqli, 'checkEmail');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    //console.log('checkemail', query.sql)
    return defered.promise;
}
exports.verify_referral = function (mysql, req) {
    $mysqli = {
        email: req.body.ref_email
    };
    strQuery = mysqli.mysqli($mysqli, 'verify_referral');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    //console.log('checkemail', query.sql)
    return defered.promise;
}

exports.saveUser = function (req, mysql, q) {

    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var md5 = require('MD5');
    var password_salt = '12345'
    var password = md5(md5(req.body.password) + password_salt);
    if(req.body.user_type == 100 || req.body.user_type == 101 || req.body.user_type == 102) {
        var user_type = req.body.user_type - 99;

        if(user_type == 1) {
            if(req.body.cg_refered_by == '0') {
                req.body.social_media = req.body.social_media ? req.body.social_media : '';
            } else {
                req.body.social_media = '';
            }
        }
        
        strQuery = mysqli.mysqli($mysqli, 'registerUser1');
        var defered = q.defer();
        escape_data = [
            req.body.cg_email,
            req.body.cg_username,
            password,
            password_salt,
            req.body.cg_name,
            req.body.cg_email2,
            req.body.cg_email3 ? req.body.cg_email3 : '',
            req.body.cg_business_name ? req.body.cg_business_name : '',
            req.body.cg_phone,
            req.body.cg_address,
            req.body.cg_city,
            req.body.cg_state,
            req.body.cg_zipcode,
            req.body.cg_country,
            req.body.cg_rep_name ? req.body.cg_rep_name : '',
            req.body.cg_ein ? req.body.cg_ein : '',
            req.body.cg_ssn,
            req.body.cg_rep_ssn ? req.body.cg_rep_ssn : '',
            req.body.cg_rep_address ? req.body.cg_rep_address : '',
            req.body.cg_rep_city ? req.body.cg_rep_city : '',
            req.body.cg_rep_state ? req.body.cg_rep_state : '',
            req.body.cg_rep_zipcode ? req.body.cg_rep_zipcode : '',
            req.body.cg_rep_phone ? req.body.cg_rep_phone : '',
            req.body.cg_dob ? dateFormat(req.body.cg_dob, "yyyy-mm-dd") : '',
            req.body.cg_license_date ? dateFormat(req.body.cg_license_date, "yyyy-mm-dd") : '',
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

            req.body.verification_document ? req.body.verification_document : '',
            req.body.cg_refered_by ? req.body.cg_refered_by : '',
            req.body.ref_name ? req.body.ref_name : '',
            req.body.ref_email ? req.body.ref_email : '',
            req.body.ref_date ? dateFormat(req.body.ref_date, "yyyy-mm-dd") : '',
            req.body.ref_user_id ? req.body.ref_user_id : '',
            
            req.body.social_media ? req.body.social_media : '',
            req.body.social_media_other ? req.body.social_media_other : '',
            req.body.ref_other ? req.body.ref_other : '',
            req.body.rf_code ? req.body.rf_code : '',
            
            user_type.toString(),
            'pending',
            currentDate
        ];
    };
    //console.log('escape_data', escape_data);
    
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        throw err;
    });

    //console.log(query.sql);
    return defered.promise;
}

exports.get_license_expired_user = function (req, mysql, q) {
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd");
    var escape_data = [
        currentDate
    ];
    $mysqli = {
    };
    strQuery = mysqli.mysqli($mysqli, 'get_license_expired_user');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    // console.log('get_license_expired_user', query.sql)
    return defered.promise;
}

exports.getUserProfileInfo = function(req, mysql, q, id) {
    if(id == 0)
        id = (typeof(req.session) !== 'undefined') ? req.session.userid : 0;

    $mysqli =  {};
    strQuery = mysqli.mysqli($mysqli, 'getUserProfileInfo'); 
    var escape_data = [id];
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    //console.log(' USER PROFILE INFO ' + query.sql);
    return defered.promise;
}

exports.updateUserProfileInfo = function(req, mysql, q) {
    $mysqli = {};
    var d = '';
    var user_id = 0;
    Object.keys(req.body).map(function(key, index) {
        if(key == 'user_id') {
            user_id = req.body[key];
            d += 'id = ' + req.body[key];
        } else
            d += key + ' = "' + req.body[key] + '", ';
    });
    $mysqli = {
        fields : d
    }

    strQuery = mysqli.mysqli($mysqli, 'updateUserProfileInfo');
    var escape_data = [user_id];
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    //console.log(' UPDATE USER INFO ' + query.sql);
    query.on('error', function (err) {
        throw err;
    });
    return defered.promise;
}

exports.updateUserProfilePic = function(req, mysql, q, user_id, file_name) {
    $mysqli = {};
    $mysqli = {
        fields : 'profile_pic = "' + file_name + '" ' 
    }

    strQuery = mysqli.mysqli($mysqli, 'updateUserProfileInfo');
    var escape_data = [user_id];
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    //console.log(' UPDATE USER PROFILE PIC INFO ' + query.sql);
    query.on('error', function (err) {
        throw err;
    });
    return defered.promise;
}

exports.updateUserPasswordInfo = function(req, mysql, q, user_id, new_password) {
    $mysqli = {};
    $mysqli = {
        fields : 'password = "' + new_password + '" ' 
    }

    strQuery = mysqli.mysqli($mysqli, 'updateUserProfileInfo');
    var escape_data = [user_id];
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    //console.log(' UPDATE USER PASSWORD INFO ' + query.sql);
    query.on('error', function (err) {
        throw err;
    });
    return defered.promise;
}

/**
 *  Save Contact Us Data
 */
exports.saveContactUs = function(req, mysql, q) {
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var id = (typeof(req.session.userid) !== 'undefined') ? req.session.userid : 0;
    var escape_data = [
        req.body.contact_name,
        req.body.contact_email,
        req.body.contact_phone,
        req.body.contact_subject,
        req.body.contact_message,
        req.body.contact_email_notify,
        'contact_us',
        currentDate,
        id
    ];
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'saveContactUs');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function (err) {
        throw err;
    });
    return defered.promise;
}
exports.checkSubscribe = function (mysql, req) {
    var escape_data = [
        req.body.cg_email
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'checkSubscribe');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log('checkemail', query.sql)
    return defered.promise;
}
exports.subscribe = function (mysql, req) {
    var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var escape_data = [
        req.body.cg_email,
        req.body.existing_user,
        req.body.user_id,
        currentDate
    ];

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'subscribe');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log('checkemail', query.sql)
    return defered.promise;
}
exports.getUserDetail = function (req, mysql, q) {
    var escape_data = [
        req.body.userid
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'getUserDetail');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log('checkemail', query.sql)
    return defered.promise;
}
exports.add_user_balance = function (req, mysql, q) {
    var escape_data = [
        req.body.ad_spend_perday,
        req.session.userid
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'add_user_balance');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('add_user_balance', query.sql);
    return defered.promise;
}
exports.minus_user_balance = function (req, mysql, q) {
    var escape_data = [
        req.body.update_amount,
        req.body.userid
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'minus_user_balance');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('minus_user_balance', query.sql);
    return defered.promise;
}
exports.register_referral = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var md5 = require('MD5');
    var password_salt = '12345'
    var password = md5(md5(req.body.rf_password) + password_salt);

    var escape_data = [
        req.body.rf_name,
        req.body.rf_company_name,
        req.body.rf_email,
        password,
        password_salt,
        req.body.code,
        req.body.rf_phone,
        req.body.rf_address,
        req.body.rf_city,
        req.body.rf_state,
        req.body.rf_zipcode,
        'active',
        cdate
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'register_referral');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('register_referral', query.sql);
    return defered.promise;
}
exports.check_referral_affiliats_exists = function (req, mysql, q) {

    var escape_data = [
        req.body.rf_email
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'check_referral_affiliats_exists');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('check_referral_affiliats_exists', query.sql);
    return defered.promise;
}
exports.check_referral_affiliats_exists_using_code = function (req, mysql, q) {

    var escape_data = [
        req.body.afcode
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'check_referral_affiliats_exists_using_code');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('check_referral_affiliats_exists_using_code', query.sql);
    return defered.promise;
}
exports.get_user_bank_list = function (req, mysql, q, count) {
    var where = ' AND bk.user_id='+req.session.userid;
    var limit = '';
    if(count == 0) {
        req.body.startFrom = (req.body.page - 1) * req.body.limit;
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'get_user_bank_list');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("get_user_bank_list", query.sql);
    query.on('error', function (err) {
        console.log("Error in get_user_bank_list", err); 
    })
    return defered.promise;
}
exports.get_bank_details = function (req, mysql, q) {

    var escape_data = [
        req.body.id
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_bank_details');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_bank_details', query.sql);
    return defered.promise;
}
exports.add_edit_bank_details = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {};
    var escape_data = [];
    if(req.body.bank_id > 0) {
        escape_data = [
            req.session.userid,
            req.body.swift_code,
            req.body.account_name,
            req.body.account_number,
            req.body.routing_number,
            req.body.city,
            req.body.state,
            req.body.country,
            req.body.phone,
            req.body.remmitance_information,
            'active',
            req.body.stripe_account_id,
            req.body.stripe_profile_id,
            req.body.bank_id
        ];
        strQuery = mysqli.mysqli($mysqli, 'edit_bank_details');
    } else {
        escape_data = [
            req.session.userid,
            req.body.swift_code,
            req.body.account_name,
            req.body.account_number,
            req.body.routing_number,
            req.body.city,
            req.body.state,
            req.body.country,
            req.body.phone,
            req.body.remmitance_information,
            req.body.is_primary,
            'active',
            req.body.stripe_account_id,
            req.body.stripe_profile_id,
            cdate
        ];
        strQuery = mysqli.mysqli($mysqli, 'add_bank_details');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('add_edit_bank_details', query.sql);
    return defered.promise;
}
exports.get_shipping_list = function (req, mysql, q) {

    var escape_data = [
        req.session.userid
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_shipping_list');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_shipping_list', query.sql);
    query.on('error', function (err) {
        console.log("Error in get_shipping_list", err);
    })
    return defered.promise;
}
exports.set_shipping_info = function (req, mysql, q) {
    var cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = {};
    var escape_data = [];
    if(req.body.shipping_id > 0) {
        escape_data = [
            req.body.name,
            req.body.address,
            req.body.country,
            req.body.zipcode,
            req.body.city,
            req.body.state,
            req.body.email,
            req.body.phone,
            req.body.delivery_instruction,
            req.body.shipping_id
        ];
        strQuery = mysqli.mysqli($mysqli, 'edit_shipping_info');
    } else {
        escape_data = [
            req.body.name,
            req.body.address,
            req.body.country,
            req.body.zipcode,
            req.body.city,
            req.body.state,
            req.session.userid,
            req.body.email,
            req.body.phone,
            req.body.delivery_instruction,
            'active',
            cdate
        ];
        strQuery = mysqli.mysqli($mysqli, 'add_shipping_info');
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('set_shipping_info', query.sql);
    query.on('error', function (err) {
        console.log("Error in set_shipping_info", err);
    })
    return defered.promise;
}
exports.get_shipping_details = function (req, mysql, q) {
    req.body.id = req.body.shipping_id ? req.body.shipping_id : req.body.id;
    var escape_data = [
        req.body.id
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_shipping_details');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('get_shipping_details', query.sql);
    query.on('error', function (err) {
        console.log("Error in get_shipping_details", err);
    })
    return defered.promise;
}
exports.set_primary_bank = function (req, mysql, q) {
    var defered = q.defer();

    var escape_data = [
        req.session.userid
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'remove_primary_bank');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('remove_primary_bank', query.sql);

    var escape_data = [
        req.body.id
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'set_primary_bank');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('set_primary_bank', query.sql);
    return defered.promise;
}
exports.delete_bank = function (req, mysql, q) {
    var defered = q.defer();
    var escape_data = [
        req.body.id
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'delete_bank');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('delete_bank', query.sql);
    return defered.promise;
}
exports.get_unread_chat_list = function (req, res, mysql, userid) {

    var escape_data = [
        userid
    ];
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'unread_chat_list');
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('unread_chat_list', query.sql);
    return defered.promise;
}