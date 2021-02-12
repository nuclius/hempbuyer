var common = require('./common');
var util = require('util');
var session = require('express-session');
var mysqli = require('./mysqli');
var q = require('q');
var fs = require('fs');
//var products = require('./products');
var common = require('./common');
var url = require('url');
//configure = require('../configure');
//default setters
/*config = configure.app();*/
exports.saveADetails = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'cnx255');
    var escape_data = [req.body.zipcode, req.body.state, req.body.city, req.body.country, req.body.address, req.body.address2, req.session.userid];

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.addShippingDetails = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'cnx247');
    var escape_data = [req.param('f_name'), req.param('l_name'), req.param('email'), req.param('phone'), req.param('address'), req.param('country1'), req.param('state1'),req.body.state_abbr, req.param('city'),req.body.region, req.param('zipcode'),req.body.from_hour, req.body.to_hour, req.session.userid, req.param('delivery_instruction')];

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);

    query.on('error', function(err) {
        console.log(err.stack);
    })
    return defered.promise;
}
exports.updateShippingDetails = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'update_cnx247');
    var escape_data = [
        req.param('f_name'),
        req.param('l_name'),
        req.param('email'),
        req.param('phone'),
        req.param('address'),
        req.param('country'),
        req.param('state'),
        req.body.state_abbr,
        req.param('city'),
        req.body.region,
        req.param('zipcode'),
        req.body.from_hour,
        req.body.to_hour,
        req.param('delivery_instruction'),
        req.session.userid
    ];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(escape_data);
    //console.log(query.sql)
    return defered.promise;
}
/* add new Billing details */
exports.addBillingDetails = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'insert_bank_details');
    var escape_data = [req.session.userid, req.param('name'), req.param('bank_name'), req.param('routing_number'), req.param('account_number')];

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}

/* Update Billing details */
exports.updateBillingDetails = function(req, mysql, q) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'update_bank_details');
    var escape_data = [req.param('name'), req.param('bank_name'), req.param('account_number'), req.param('routing_number'), req.session.userid];

    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
  
    return defered.promise;

}
/* end */

/* Update Sales tax details */
exports.updateStaxDetails = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'update_stax_details');
    var escape_data = [
        (typeof(req.body.stax) != undefined && req.body.stax == 'y') ? 'y' : 'n',
        typeof(req.body.stax_per) != undefined ? req.body.stax_per : 0,
        req.session.userid
    ];

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        console.log(err.stack);
    })

    return defered.promise;
}
/* end */

exports.profileDetails = function(req, mysql, q, fields) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 25);
    var uid = (typeof(req.param('viewuid')) === 'undefined') ? req.session.userid : req.param('viewuid')
    escape_fields = [fields, uid];


    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    return defered.promise;
}
exports.shippingDetails = function(req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'cnx246');
    escape_fields = [id]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
   console.log("shippingDetails "+query.sql)
    query.on('error', function(err) {
        console.log(err.stack);
    })
    return defered.promise;
}
exports.staxDetails = function(req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'get_stax_details');
    escape_fields = [id]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    query.on('error', function(err) {
        console.log(err.stack);
    })
    return defered.promise;
}
exports.billingDetails = function(req, mysql, q, id) {

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'get_billing_details');
    escape_fields = [id]
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

    query.on('error', function(err) {
        console.log(err.stack);
    })
    return defered.promise;
}
exports.saveDetails = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    var userdet = req.body;
    q.all(this.profileDetails(req, config.mysql, q, ['image', 'avatar'])).then(function(results) {
        userdet.image = (typeof(req.files.profile_image) !== 'undefined') ? req.files.profile_image.name : results[0][0]['avatar'];
        userdet.avatar = (typeof(req.files.profile_image) !== 'undefined') ? req.files.profile_image.originalname : results[0][0]['image'];
        if (typeof(req.files.profile_image) !== 'undefined') {
            fs.unlink(config.path + "public/uploads/profile/" + results[0][0]['avatar'], function(err) {
                if (!err)
                    console.log('successfully deleted ' + results[0][0]['avatar']);
            });
        }
        if (req.session.phone == userdet.phone) {
            strQuery = mysqli.mysqli($mysqli, 54);
        } else {
            strQuery = mysqli.mysqli($mysqli, 'newphone');
        }
        escape_fields = [userdet.email, userdet.firstname, userdet.lastname, userdet.nickname, userdet.aboutme, userdet.image, userdet.avatar, userdet.address1, '', userdet.country, userdet.state, userdet.city, userdet.zip, userdet.phone, userdet.url, userdet.paypal_address, req.session.userid]
        console.log(escape_fields);
        query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
        req.session.email = req.body.email;
        req.session.email = req.body.phone;
        req.session.first_name = req.body.firstname;
        req.session.last_name = req.body.lastname;
        req.session.country = req.body.country;

    });
    return defered.promise;
}

exports.managecategories = function(req, mysql, q, mcat) {
    $mysqli = {};
    var defered = q.defer();

    q.all(this.checkProfilecategory(req, mysql, q, mcat)).then(function(results) {
        if (results[0].length == 0) {
            strQuery = mysqli.mysqli($mysqli, 116);
            escape_fields = [req.session.userid, mcat]
            query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
        }

    });

    return defered.promise;
}

exports.checkProfilecategory = function(req, mysql, q, userCid) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 114);
    var uid = (typeof(req.param('viewuid')) === 'undefined') ? req.session.userid : req.param('viewuid');
    //escape_fields = [fields,uid]
    escape_fields = [uid, userCid];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.removeCategories = function(req, mysql, q) {
    var cateArray = '';
    if (typeof(req.body.categories) == 'undefined')
        implodeats = '0';
    else {
        cateArray = req.body.categories;
        implodeats = cateArray.join(',');
    }
    //	 console.log(33333333333);
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 115);
    escape_fields = [req.session.userid, implodeats]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.listUserCategories = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 117);
    escape_fields = [req.session.userid]
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}