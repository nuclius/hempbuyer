var request = require("request");
var dateFormat = require('dateformat');
var _ = require('underscore');
var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');

// var defered = q.defer();
// return defered.promise;

// var requestData = {
//     "api_key": global.fwrdauctionAPI.api,
//     "app_key": global.fwrdauctionAPI.key
// };

//forgot password

exports.updateUserBalance = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'update_user_bal');
    var defered = q.defer();

// req.body.buyer = {
//                   balance: parseFloat(ads.refund_amt).toFixed(2),
//                   id: buyuserdetails.id
//              }

    var escape_data = [req.body.buyer.balance,req.body.buyer.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql + "555555555555555555");
    query.on('error', function(err) {
        console.log("Error in getting deals value " + err);
    })
    return defered.promise;
}


exports.updateUser2 = function(req, type, callback) {

    if (type == 'refund_ad_payment') {
        /* increase sellers account balance after product has bee sold */
        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.buyer;

        console.log("ads refund requestData : " + JSON.stringify(requestData));
    }    
    var fwAPI = require('./forwardauction_api');
    q.all(fwAPI.updateUserBalance(req, config.mysql, q)).then(function(paidStatus) {
        console.log('buyer paid status updated', paidStatus);
        console.log('buyer paid status updated', paidStatus[0]);
        console.log('buyer paid status updated', paidStatus[0].affectedRows);
        callback(null,{response : {code : "D200", affectedRows : paidStatus[0].affectedRows, insertedId : ""}});
        // next(null);
    }).fail(function(err) {
        //console.log(err.stack);
        throw err;
    })



}



/*--------------------------------------------------------below are forward api calls---------------------------------------------*/
exports.userdetails_email = function(req, type, callback) {
    console.log("++++++++user call : userdetails_email");
    req.body.api_key = global.fwrdauctionAPI.api;
    req.body.app_key = global.fwrdauctionAPI.key;
    var requestData = {
        "api_key": req.body.api_key,
        "app_key": req.body.app_key,
    };
    if (type == "email") {
        requestData.email = req.body.email;
    }
    // console.log('gkjdrifre', requestData)-
    request(global.fwrdauctionAPI.url + 'user/details/email', { method: "GET", json: true, qs: requestData }, function(err, resp, body) {
        // console.log('errrr',err)
        // console.log('res',resp)
        // console.log('forgot_detials', body)
        if (body) {
            if (body.response) {
                callback(null, body.response.user);
            } else {
                callback(body.err, null);
            }
        }
    });
}

exports.LoginResetPassword = function(req, callback) {
    console.log("++++++++user call : LoginResetPassword");
    var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //var password_salt = '12345'
    var data = {
        api_key: global.fwrdauctionAPI.api,
        app_key: global.fwrdauctionAPI.key,
        unique_key: 'id',
        id: req.body.userid,
        password_hash: req.body.confirm_password,
        //password_salt:password_salt,
        updated_at: datge
    }
    // console.log('reqqqqqqq', data)
    request.post({
        url: global.fwrdauctionAPI.url + 'user/update',
        rejectUnauthorized: false,
        form: data
    }, function(err, res, body) {

        // console.log(err);
        // console.log(JSON.stringify(body));

        var api_data = JSON.parse(body)
        if (api_data.err) {
            callback(api_data.err, null)
        } else {
            callback(null, api_data.response.user)
        }
    })

}

/****************************************************************************
 |  User Registration using Forward auction api 
 |***************************************************************************                            
 |  Input should be : {
 |  "api_key":"edfc3b4c6738a4b9901ecfa38e49bac3fc084e86",   //important
 |  "app_key":"81dd05fe38ebe2a2a9e47825174c394deaef1465",   //important
 |  "unique_key": "email",                                  //important
 |  "email": "mohit.auctionsoftware@gmail.com",             //important
 |  "first_name": "mohit",                                  //can use number of fields
 |   "last_name": "bhasvar",
 |   "username": "mohit",
 |   "password_hash": "mohit",                              //important
 |   "password_confirmation": "mohit"                       //important       
 |   }
 |
 ****************************************************************************/
exports.registerUser = function(req, callback) {
    console.log("++++++++user call : registerUser");
    var unique_key = req.body.unique_key;

    req.body.api_key = global.fwrdauctionAPI.api;
    req.body.app_key = global.fwrdauctionAPI.key;
    $arr.message = '';
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    // console.log(req.body);

    var requestData = {

        "api_key": req.body.api_key,
        "app_key": req.body.app_key,
        "unique_key": "email", //important
        "email": req.body.email,
        "first_name": (typeof(req.body.first_name) === 'undefined') ? req.body.username : req.body.first_name, //can use number of fields
        "last_name": (typeof(req.body.last_name) === 'undefined') ? '' : req.body.last_name,
        "nick_name": (typeof(req.body.nick_name) === 'undefined') ? '' : req.body.nick_name,
        "username": (typeof(req.body.username) === 'undefined') ? '' : req.body.username,
        "phone": req.body.phone,
        "password_hash": req.body.password, //important
        "password_confirmation": req.body.cpassword, //important 
        "country": (typeof(req.body.country) === 'undefined') ? '' : req.body.country,
        "city": (typeof(req.body.city) === 'undefined') ? '' : req.body.city,
        "address1": (typeof(req.body.address1) === 'undefined') ? '' : req.body.address1,
        "address2": (typeof(req.body.address2) === 'undefined') ? '' : req.body.address2,
        "state": (typeof(req.body.state) === 'undefined') ? '' : req.body.state,
        "state_abbr": (typeof(req.body.state_abbr) === 'undefined') ? '' : req.body.state_abbr,
        "zip": (typeof(req.body.zip) === 'undefined') ? '' : req.body.zip,
        "region": (typeof(req.body.region) === 'undefined') ? '' : req.body.region,
        "aboutme": (typeof(req.body.aboutme) === 'undefined') ? '' : req.body.aboutme,
        "image": (typeof(req.body.image) === 'undefined') ? '' : req.body.imdefault_providerage,
        "avatar": (typeof(req.body.avatar) === 'undefined') ? '' : req.body.avatar,
        "role": (typeof(req.body.role) === 'undefined') ? 1 : req.body.role,
        "default_provider": (typeof(req.body.default_provider) === 'undefined') ?'n' : req.body.default_provider,
        "default_transport": (typeof(req.body.default_transport) === 'undefined') ?'n' : req.body.default_transport,
        "created_at": datge,
        "status":(typeof(req.body.status) === 'undefined') ? "unverified" : req.body.status
    };

    // console.log(requestData);

    // res.send(JSON.stringify(requestData));

    request(global.fwrdauctionAPI.url + 'user/save', { method: "POST", json: true, body: requestData }, function(err, resp, body) {

        if (err) {
            throw err;
        }

        if (body) {
            if (body.response) {

                callback(null, body.response);
            } else if (body.err) {
                // $arr.message = body.err.code + " : " + body.err.description;
                callback(body.err, null);
            }
        }
    });
}

exports.user_email = function(req, res, callback){

    var obj = {
        api_key : global.fwrdauctionAPI.api,
        app_key : global.fwrdauctionAPI.key,
        field_names : "email, first_name",
        where_condition:' where id = '+req.body.tempid+'',
        type:"no_type"
    }
    request({
        url : global.fwrdauctionAPI.url + 'users/common',
        qs : obj
    }, function(err, res, data){
        if(err){
             console.log('Error' +err);
        } else {
            // console.log('data', data)
            data = JSON.parse(data);
            callback(data.response.results)
        }
    });   
}

/****************************************************************************
 |  Check the user is exist or not by using username, email and phone number|
 ****************************************************************************/
//checkUserExistance(req, "email", req.body.email)
exports.checkUserExistance = function(req, type, option, callback) {
    console.log("++++++++user call : checkUserExistance");
    // var type = req.body.type;

    req.body.api_key = global.fwrdauctionAPI.api;
    req.body.app_key = global.fwrdauctionAPI.key;
    $arr.message = '';

    var requestData = {
        "api_key": req.body.api_key,
        "app_key": req.body.app_key,
        "type": type
    };

    // requestData.type = type;

    if (type == "email") {
        requestData.email = option;
        // console.log("email");
    } else if (type == "username") {
        requestData.username = option;
        // console.log("username");
    } else if (type == "phone") {
        requestData.phone = option;
        // console.log("phone");
    }

    // console.log(requestData);

    request(global.fwrdauctionAPI.url + 'checkentry', { method: "POST", json: true, body: requestData }, function(err, resp, body) {

        if (err) {
            // throw err;
            console.log(err);
            callback(err, null);
            // callback(err, null);
        } else {

            if (body) {
                if (body.response) {
                    // if (body.response.code == 'D200') {
                    //     if (!body.response.exists) {
                    //         // $arr.message = "success";
                    //     } else {
                    //         // $arr.message = "This " + type + " already exists. Please login.";
                    //     }
                    // }
                    callback(null, body.response);
                } else {
                    // if (body.err.code == 'S1002') {
                    //     $arr.message = "S1002 :" + body.err.description
                    // }
                    // if (body.err.code == 'S1003') {
                    //     $arr.message = "S1002 : " + body.err.description
                    // }
                    // if (body.err.code == 'D000') {
                    //     $arr.message = "D000 : " + body.err.description
                    // }
                    callback(body.err, null);
                }
                console.log("forwardauctionAPI - " + type);
                // console.log(body);
            }

        }
    });

}

/****************************************************************************
 |  Login user with username, email or Phone                                |
 ****************************************************************************/
exports.loginUser = function(req, callback) {
    // console.log(req.body);
    req.body.api_key = global.fwrdauctionAPI.api;
    req.body.app_key = global.fwrdauctionAPI.key;
    // $arr.message = '';

    var requestData = {
        "api_key": req.body.api_key,
        "app_key": req.body.app_key,
        "password_hash": req.body.password,
        "type": "email",
        "email": req.body.username
    };
 
    // console.log(requestData);

    request(global.fwrdauctionAPI.url + 'login/save', { method: "POST", json: true, body: requestData }, function(err, resp, body) {

        if (err) {
            console.log(err);
            // throw err;
        }

        // console.log(JSON.stringify(body));
        console.log("dddddddddddd")
        console.log(body)
        if (body) {
            if (body.response) {
                if (body.response.code && body.response.code == 'D200') {
                    if (!body.response.exists) {
                        // $arr.message = body.response.description;

                    } else {
                        // $arr.message = body.response.code + " : " + body.response.description;
                        // callback(null, body);
                    }
                } else {
                    if (body.err.code == 'S1002') {
                        // $arr.message = "S1002 :" + body.err.description
                    }
                    if (body.err.code == 'S1003') {
                        // $arr.message = "S1002 : " + body.err.description
                    }
                    if (body.err.code == 'D000') {
                        // $arr.message = "D000 : " + body.err.description
                    }
                }
                callback(null, body.response);
            } else if (body.err) {
                // $arr.message = body.err.code + " : " + body.err.description;
                callback(body.err, null);
            }

        }else{

        }

        // console.log($arr.message);

    });

}



/****************************************************************************
 |  Password Reset
 |***************************************************************************                            
 |  Input should be : { 
 |      "password_hash": "mohit",
 |      "password_confirmation": "mohit",
 |      "id": "456"
 | }
 |
 ****************************************************************************/
exports.resetPassword = function(req, res, callback) {

    console.log("++++++++user call : resetPassword");

    var unique_key = req.body.unique_key;

    req.body.api_key = global.fwrdauctionAPI.api;
    req.body.app_key = global.fwrdauctionAPI.key;
    $arr.message = '';

    var requestData = {
        "api_key": req.body.api_key,
        "app_key": req.body.app_key,
        "password_hash": req.body.password_hash, //important
        "password_confirmation": req.body.password_confirmation, //important   
        "id": req.body.id
    };


    console.log("++++++++user call : resetPassword-------------"+requestData);

    // res.send(JSON.stringify(requestData));

    request(global.fwrdauctionAPI.url + 'password/save', { method: "POST", json: true, body: requestData }, function(err, resp, body) {
// console.log(err);
// console.log(resp);
// console.log(body);

        if (err) {
            throw err;
        }
        if (body) {
            if (body.response) {
                // console.log("forwardauctionAPI - userInfo function" + body.response.user.id + " : " + body.response.user.first_name);
                // console.log(body.response);
                data = body.response.user
                // callback(null, body.response);
            } else {
                data = body.err
                // callback(body.err, null);
            }
        }

        // if (body) {
        //     if (body.response) {
        //         if (body.response.code && body.response.code == 'D200') {
        //             if (!body.response.exists) {
        //                 $arr.message = body.response.description;
        //             } else {
        //                 $arr.message = body.response.code + " : " + body.response.description;
        //             }
        //         } else {
        //             if (body.err.code == 'S1002') {
        //                 $arr.message = "S1002 :" + body.err.description
        //             }
        //             if (body.err.code == 'S1003') {
        //                 $arr.message = "S1002 : " + body.err.description
        //             }
        //             if (body.err.code == 'D000') {
        //                 $arr.message = "D000 : " + body.err.description
        //             }
        //         }
        //     } else if (body.err) {
        //         $arr.message = body.err.code + " : " + body.err.description;
        //     }

        // }

    });
}

/****************************************************************************
 |  GET call : Gertting user information using userid
 |***************************************************************************  
 |  input call : 
 |       https://api.auctionsoftwaremarketplace.com/api/v1/user/details/userid?api_key=edfc3b4c6738a4b9901ecfa38e49bac3fc084e86&app_key=81dd05fe38ebe2a2a9e47825174c394deaef1465&userid=456
 |                            
 |  output should be : {
 |      "err":null,
 |      "response":{
 |          "code":"D200",
 |          "description":"Success",
 |          "user":{"id":456,"email":"mohit.auctionsoftware@gmail.com","role":null,"first_name":".......
 |
 ****************************************************************************/
exports.userInfo = function(req, uid, callback) {
    // console.log("getting uid " + uid);
    // console.log(req);
    req.body.api_key = global.fwrdauctionAPI.api;
    req.body.app_key = global.fwrdauctionAPI.key;
    $arr.message = '';

    // if (uid == 0) {
    //     uid = (typeof(req.session) !== 'undefined') ? req.session.userid : 0;
    // }


    var requestData = {
        "api_key": req.body.api_key,
        "app_key": req.body.app_key,
        "userid": uid
    };

    // console.log("getting user id from session"+req.session.userid);

    // console.log("requested data " + JSON.stringify(requestData));

    // res.send(JSON.stringify(requestData));
    request(global.fwrdauctionAPI.url + 'user/details/userid', { method: "GET", json: true, qs: requestData }, function(err, resp, body) {

        if (body) {
            if (body.response) {
                // console.log("forwardauctionAPI - userInfo function" + body.response.user.id + " : " + body.response.user.first_name);
                // console.log(body.response);
                data = body.response.user
                callback(null, body.response);
            } else {
                data = body.err
                callback(body.err, null);
            }
        }
    });
}

//product view page to get user data by type
exports.getUserByType = function(req, object, callback) {

    var formObj = {
        api_key: global.fwrdauctionAPI.api,
        app_key: global.fwrdauctionAPI.key,

    }
    formObj[object.type] = object.value
    // console.log('res_data',formObj)
    request({
        rejectUnauthorized: false,
        url: global.fwrdauctionAPI.url + 'user/details/' + object.type,
        qs: formObj
    }, function(error, response, body) {
        // console.log('body_of_data',body)
        if (body) {
            body = JSON.parse(body)
            if (body.err) {
                callback(body.err, null)
            } else {
                // console.log('body.response')
                callback(null, body.response)
            }
        } else {
            callback(error, null)
        }

    })

}


/****************************************************************************
 |  POST call : Update User information
 |***************************************************************************  
 |  input call : 
 |       https://api.auctionsoftwaremarketplace.com/api/v1/user/update
 |
 |      input should be : 
 |        {
 |           "api_key":"edfc3b4c6738a4b9901ecfa38e49bac3fc084e86",
 |           "app_key":"81dd05fe38ebe2a2a9e47825174c394deaef1465",
 |           "unique_key" : "email" / "phone" / "username"         
 |           "email": "mohit.auctionsoftware@gmail.com",
 |           "id" : "456",
 |           "first_name": "mohit",
 |           "last_name": "bhasvar",
 |           "username": "mohit",
 |           "password_hash": "mohit",
 |           "password_confirmation": "mohit",
 |           "city" : "nashik",
 |           "phone" : 9595696116
 |        }
 |      unique_key is optional as per developers requirements
 |      Here unique_key is the field which we don't want to change or defined this as a unique field.
 |      it can be contains multiple fields saperated by comma.
 |                            
 |  output should be : 
 |      {
 |        "err": null,
 |        "response": {
 |          "code": "D200",
 |          "description": "Success",
 |          "updated": true,
 |          "user": [
 |            {"id":456,"email":"mohit.auctionsoftware@gmail.com","role":null,"first_name":".......
 |
 ****************************************************************************/

exports.updateUser = function(req, type, callback) {

    console.log("++++++++user call1 : updateUser" + req.body);
    // console.log("++++++++user call2 : updateUser" + req.file);
    // console.log("++++++++user call3 : updateUser" + req.files);

    // var unique_key = (typeof(req.body.unique_key) === 'undefined') ? '' : req.body.unique_key;

    req.body.api_key = global.fwrdauctionAPI.api;
    req.body.app_key = global.fwrdauctionAPI.key;
    $arr.message = '';
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    // console.log(req.body);

    if (type == 'status') {
        // console.log("type : " + type);
        var requestData = {

            "api_key": req.body.api_key,
            "app_key": req.body.app_key,
            "unique_key": "id", //important
            "id": req.body.id,
            "status": req.body.status

        };

        if (req.body.email !== "undefined" || req.body.email !== 'null' || req.body.email !== '') {
            if (req.session.email !== req.body.email) {
                requestData.email = req.body.email;
            }
        }

    } else if (type == '') {
        // console.log("type : " + type);
        var requestData = {

            "api_key": req.body.api_key,
            "app_key": req.body.app_key,
            "unique_key": "id", //important
            "email": req.body.email,
            "id": req.session.userid,
            "first_name": req.body.first_name,
            "last_name": req.body.last_name,
            // "nick_name": req.body.nickname,
            "address1": req.body.address,
            // "address2": req.body.address,
            "aboutme": req.body.aboutme,
            "phone": req.body.phone,
            "country": req.body.country,
            "state": req.body.state,
            "zip": req.body.zip,
            "city": req.body.city,
            "region": req.body.region,
            "state_abbr": req.body.state_abbr,
            "default_provider" : req.body.default_provider,
            "default_transport":req.body.default_transport
            // "paypal_address": req.body.paypal_address,
            // "profile_url": req.body.profile_url,

        };

        if (req.body.email !== "undefined" || req.body.email !== 'null' || req.body.email !== '') {
            if (req.session.email !== req.body.email) {
                requestData.email = req.body.email;
            } else {
                requestData.email = req.session.email;
            }
        } else {
            requestData.email = req.session.email;
        }

        if (req.body.username !== "undefined" || req.body.username !== 'null' || req.body.username !== '') {
            if (req.session.username !== req.body.username) {
                requestData.username = req.body.username;
            } else {
                requestData.username = req.session.username;
            }
        } else {
            requestData.email = req.session.email;
        }

        if (typeof(req.files) !== 'undefined' && !(_.isEmpty(req.files))) {
            // console.log("checking req.files : "+JSON.stringify(req.files));
            // console.log("checking req.files : "+JSON.stringify(req.files.length));
            // console.log(_.isEmpty(req.files));
            if (typeof(req.files.profile_image) !== 'undefined') {
                requestData.image = req.files.profile_image.originalname;
                requestData.avatar = req.files.profile_image.name;
            }
        }

    } else if (type == 'admin_updateusers') {

        
        var requestData = req.body.updateFields;

        requestData.api_key = req.body.api_key;
        requestData.app_key = req.body.app_key;
        requestData.unique_key = "id";

        if (typeof(req.files) !== 'undefined' && !(_.isEmpty(req.files))) {
            if (typeof(req.files.profile_image) !== 'undefined') {
                requestData.image = req.files.profile_image.originalname;
                requestData.avatar = req.files.profile_image.name;
            }
        }
        console.log("admin_updateusers fields : " + JSON.stringify(req.body.updateFields));
        console.log("admin_updateusers fields : " + requestData);

    } else if (type == 'admin_approve_payment') {
                /* Admin payment approval - if approved then it will credit to users account */
        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.updateFields;
        requestData.api_key = global.fwrdauctionAPI.api;
        requestData.app_key = global.fwrdauctionAPI.key;
        requestData.unique_key = "id";
        console.log("admin_approve_payment requestData : " + JSON.stringify(requestData));

    } else if (type == 'bought_product') {
        /* decrease the users account balance*/
        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.buyer;

        requestData.api_key = global.fwrdauctionAPI.api;
        requestData.app_key = global.fwrdauctionAPI.key;
        requestData.unique_key = "id";
        console.log("bought product requestData : " + JSON.stringify(requestData));

    } else if (type == 'ad_spend') {
        /* decrease the users account balance on advertising a store, product, and brand */
        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.buyer;
        requestData.api_key = global.fwrdauctionAPI.api;
        requestData.app_key = global.fwrdauctionAPI.key;
        requestData.unique_key = "id";
        console.log("ad_spend requestData : " + JSON.stringify(requestData));
        
    } else if (type == 'sold_product') {
        /* increase sellers account balance after product has bee sold */
        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.seller;

        requestData.api_key = global.fwrdauctionAPI.api;
        requestData.app_key = global.fwrdauctionAPI.key;
        requestData.unique_key = "id";


        console.log("sold_product requestData : " + JSON.stringify(requestData));
    } else if (type == 'herbee_commission') {
        /* increase admin account balance */
        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.admin;

        requestData.api_key = global.fwrdauctionAPI.api;
        requestData.app_key = global.fwrdauctionAPI.key;
        requestData.unique_key = "id";

        console.log("herbee_commission requestData : " + JSON.stringify(requestData));
    } else if (type == 'refund_reserve_amounts') {

        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.seller;

        requestData.api_key = global.fwrdauctionAPI.api;
        requestData.app_key = global.fwrdauctionAPI.key;
        requestData.unique_key = "id";


        console.log("seller side requestData : " + JSON.stringify(requestData));
    } else if (type == 'refund_reserve_amountb') {

        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.buyer;

        requestData.api_key = global.fwrdauctionAPI.api;
        requestData.app_key = global.fwrdauctionAPI.key;
        requestData.unique_key = "id";


        console.log("buyer side requestData : " + JSON.stringify(requestData));
    } else if (type == 'refund_reserve_amounta') {

        // console.log("admin_approve_payment fields : " + JSON.stringify(req.body.updateFields));
        var requestData = req.body.admin_user;

        requestData.api_key = global.fwrdauctionAPI.api;
        requestData.app_key = global.fwrdauctionAPI.key;
        requestData.unique_key = "id";

        console.log("admin side requestData : " + JSON.stringify(requestData));

    } else if (type == 'delete_user') {

        var datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
        var requestData = {};
        requestData.api_key = req.body.api_key;
        requestData.app_key = req.body.app_key;
        requestData.unique_key = "id";
        requestData.id = req.body.id;
        requestData.del_status = '1';
        requestData.deleted_at = datge;
        requestData.status = "deactivate";
        // console.log("Delete User : " + JSON.stringify(req.body.updateFields));
        console.log("delete user call",requestData)

    }

    // console.log(JSON.stringify(requestData));
    request(global.fwrdauctionAPI.url + 'user/update', { method: "POST", json: true, body: requestData }, function(err, resp, body) {

        if (err) {
            throw err;
        }

        if (body) {
            console.log(JSON.stringify(body));
            if (body.response) {
                if (body.response.code && body.response.code == 'D200') {
                    if (!body.response.exists) {
                        $arr.message = body.response.description;
                    } else {
                        $arr.message = body.response.code + " : " + body.response.description;
                    }
                } else {
                    if (body.err.code == 'S1002') {
                        $arr.message = "S1002 :" + body.err.description;
                    }
                    if (body.err.code == 'S1003') {
                        $arr.message = "S1002 : " + body.err.description;
                    }
                    if (body.err.code == 'D000') {
                        $arr.message = "D000 : " + body.err.description;
                    }
                }

            } else if (body.err) {
                $arr.message = body.err.code + " : " + body.err.description;
            }
            callback(null, body);
        } else {
            callback(null, null);
        }

        // res.send(JSON.stringify($arr.message));
        console.log($arr.message);


    });
}

/****************************************************************************
 |  POST call : Update User status for user activation
 |***************************************************************************  
 |  input call : 
 |       https://api.auctionsoftwaremarketplace.com/api/v1/user/update
 |
 |      input should be : 
 |        {
 |           "api_key":"edfc3b4c6738a4b9901ecfa38e49bac3fc084e86",
 |           "app_key":"81dd05fe38ebe2a2a9e47825174c394deaef1465",
 |           "unique_key" : "email" / "phone" / "username"         
 |           "email": "mohit.auctionsoftware@gmail.com",
 |           "id" : "456",
 |           "first_name": "mohit",
 |           "last_name": "bhasvar",
 |           "username": "mohit",
 |           "password_hash": "mohit",
 |           "password_confirmation": "mohit",
 |           "city" : "nashik",
 |           "phone" : 9595696116
 |        }
 |      unique_key is optional as per developers requirements
 |      Here unique_key is the field which we don't want to change or defined this as a unique field.
 |      it can be contains multiple fields saperated by comma.
 |                            
 |  output should be : 
 |      {
 |        "err": null,
 |        "response": {
 |          "code": "D200",
 |          "description": "Success",
 |          "updated": true,
 |          "user": [
 |            {"id":456,"email":"mohit.auctionsoftware@gmail.com","role":null,"first_name":".......
 |
 ****************************************************************************/

exports.activateUser = function(req, userid, callback) {

    console.log("++++++++user call : activateUser");

    // var unique_key = (typeof(req.body.unique_key) === 'undefined') ? '' : req.body.unique_key;

    req.body.api_key = global.fwrdauctionAPI.api;
    req.body.app_key = global.fwrdauctionAPI.key;

    $arr.message = '';

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var requestData = {
        "api_key": req.body.api_key,
        "app_key": req.body.app_key,
        "unique_key": "email", //important
        "id": userid,
        "status": "active"
    };

    request(global.fwrdauctionAPI.url + 'user/update', { method: "POST", json: true, body: requestData }, function(err, resp, body) {

        if (err) {
            throw err;
        }

        if (body) {
            if (body.response) {
                callback(null, body.response);
                // if (body.response.code && body.response.code == 'D200') {
                //     if (!body.response.exists) {
                //         $arr.message = body.response.description;
                //     } else {
                //         $arr.message = body.response.code + " : " + body.response.description;
                //     }
                // } 
            } else if (body.err) {
                callback(body.err, null);
                // $arr.message = body.err.code + " : " + body.err.description;
            }

        } else {
            callback(null, null);
        }

        // res.send(JSON.stringify($arr.message));
        // console.log($arr.message);

    });
}



//appendUserDataForObject
exports.appendUserDataForObject = function(type, fieldNames, whereCondition, appendObject, appendKey, callback) {
    console.log("++++++++user call : appendUserDataForObject");
    // console.log(type);
    // console.log(fieldNames);
    // console.log(whereCondition);
    // console.log(appendObject);
    // console.log(appendKey);
    // faAPI.appendUserDataForObject('id', 'id as user_id, first_name,email,phone,last_name,nick_name,review,avatar as uimage', result, results[0][0], 'user_id', function(messageFromErr, messageFromRes) {
    var async = require('async')
    var _ = require('underscore')

    var object = {
        api_key: global.fwrdauctionAPI.api,
        app_key: global.fwrdauctionAPI.key,
        field_names: fieldNames, 
        where_condition: whereCondition,
        type: type
    }
    // console.log('objecctttt', object)

    request({
        rejectUnauthorized: false,
        url: global.fwrdauctionAPI.url + 'users/common',
        qs: object
    }, function(error, response, body) {
        // console.log(error);
        // console.log('dataaaaaa', body);
        if (body) {
            body = JSON.parse(body)
            if (body.err) {
                callback(body.err, null)
            } else {

                async.each(body.response.results, function(singleUser, callback2) {

                    async.each(appendObject, function(singleFeedback1, callback1) {

                        if (singleUser[appendKey] == singleFeedback1[appendKey]) {
                            try {
                                singleFeedback1 = _.extend(singleFeedback1, singleUser)
                            } catch (err) {
                                console.log("Extend Error")
                                console.log(err)
                            }
                        }
                        callback1();
                    }, function(err) {
                        console.log(err);
                        callback2(null, null)
                    });

                }, function(err) {
                    console.log(err);
                    callback(null, appendObject)
                });

            }
        } else {
            callback(error, null)
        }

    })
}

//search email
exports.callUserQuery = function(type, fieldNames, whereCondition, callback) {
    console.log("++++++++user call : callUserQuery");
    var formObject = {
        api_key: global.fwrdauctionAPI.api,
        app_key: global.fwrdauctionAPI.key,
        field_names: fieldNames,
        where_condition: whereCondition,
        type: type
    }
    // console.log('datatattata', formObject)
    // request({ url: global.fwrdauctionAPI.url + 'users/common', rejectUnauthorized: false, qs: formObject }, function(err, response, body) {
    request({ url: global.fwrdauctionAPI.url + 'users/common', rejectUnauthorized: false, qs: formObject }, function(err, response, body) {
        if (body) {
            // console.log('body_data', body)
            body = JSON.parse(body)
            if (body.err) {
                callback(body.err, null)
            } else {
                // console.log('respond=se', body.response)
                callback(null, body.response)
            }
        } else {
            callback(err, null)
        }
    });

}
//for sales users list
exports.callUserQuerySales = function(type, fieldNames, whereCondition, joins, callback) {
    console.log("++++++++user call : callUserQuerySales");
    var formObject = {
        api_key: global.fwrdauctionAPI.api,
        app_key: global.fwrdauctionAPI.key,
        field_names: fieldNames,
        where_condition: whereCondition,
        type: type,
        joins: joins
    }
    // console.log('datatattata', formObject)
    // request({ url: global.fwrdauctionAPI.url + 'users/common', rejectUnauthorized: false, qs: formObject }, function(err, response, body) {
    request({ url: global.fwrdauctionAPI.url + 'users/common', rejectUnauthorized: false, qs: formObject }, function(err, response, body) {
        if (body) {
            // console.log('body_data', body)
            body = JSON.parse(body)
            if (body.err) {
                callback(body.err, null)
            } else {
                // console.log('respond=se', body.response)
                callback(null, body.response)
            }
        } else {
            callback(err, null)
        }
    });

}
//search email

//custom query to execute
exports.customUserQuery = function(query, callback) {

    console.log("++++++++user call : customUserQuery");

    var requestData = {
        "api_key": global.fwrdauctionAPI.api,
        "app_key": global.fwrdauctionAPI.key,
        "searchquery": query
    };
    request(global.fwrdauctionAPI.url + 'user/customquery', { method: "POST", json: true, body: requestData }, function(err, resp, body) {
        if (err)
            callback(err, null);
        if (body) {
            if (body.response) {
                data = body.response.user
                callback(null, body.response);
            } else {
                data = body.err
                callback(body.err, null);
            }
        }
    });
}