var express = require('express');
var mailer = require('../module/mailer');
var common = require('../module/api_common');
var router = express.Router();
var errorJson = require('../api_errors');
var validationJson = require('../api_validation');
var md5 = require('md5');
var commonApi = require('../module/api_common_module');
var apiUsers = require('../module/api_user_module');
var _ = require('underscore');
var async = require('async');
var q = require('q');
var dateFormat = require('dateformat');
var jwt = require('jwt-simple');
var jwt = require('jsonwebtoken');
var Order =  require('../module/order');
var request = require("request");
// console.log(md5(md5(12345678)))

router.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});
function compareDates(date1) {
    //Get 1 day in milliseconds

    if (new Date(date1)) {
        date1 = new Date(date1)
    } else {
        return false;
    }
    var one_day = 1000 * 60 * 60 * 24;
    var date2 = new Date();

    var date1_ms = date1.getTime();
    var date2_ms = date2.getTime();
    var difference_ms = date2_ms - date1_ms;
    difference_ms = difference_ms / 1000;
    var seconds = Math.floor(difference_ms % 60);
    difference_ms = difference_ms / 60;
    var minutes = Math.floor(difference_ms % 60);
    difference_ms = difference_ms / 60;
    var hours = Math.floor(difference_ms % 24);
    var days = Math.floor(difference_ms / 24);

    if (days < 30) {
        return false;
    }
    return days;
}

function getTime(hours, minutes) {
    var time = null;
    minutes = minutes + "";
    if (hours < 12) {
        time = "AM";
    } else {
        time = "PM";
    }
    if (hours == 0) {
        hours = 12;
    }
    if (hours > 12) {
        hours = hours - 12;
    }
    if (minutes.length == 1) {
        minutes = "0" + minutes;
    }
    return hours + ":" + minutes + " " + time;
}

function slideTime(val) {
    if (!val) {
        val = 0
    }
    var minutes = parseInt(val % 60, 10);
    var hours = parseInt(val / 60 % 24, 10);
    var data = getTime(hours, minutes);
    return data;
}

function smartTrim(str, length, delim, appendix) {
    if (str.length <= length) return str;

    var trimmedStr = str.substr(0, length+delim.length);

    var lastDelimIndex = trimmedStr.lastIndexOf(delim);
    if (lastDelimIndex >= 0) trimmedStr = trimmedStr.substr(0, lastDelimIndex);

    if (trimmedStr) trimmedStr += appendix;
    return trimmedStr;
}

router.post('/login', function(req, res, next) {

    var username_data = "herbee"
    var password_data = "36da5b240365afe0803939242a8df8f3"
    var secret = "7348bb84826ed6cd9a6121803d57893b"

    async.series([
        function(callback) {
            if(!req.body.username){
                callback("Username is Empty")
            }
            if(req.body.username != username_data){
                callback("Username is invalid")
            }
            callback(null, 'username');
        },
        function(callback) {
            if(!req.body.password){
                callback("Password is Empty")
            }
            if(req.body.password != password_data){
                callback("Password is invalid")
            }
            callback(null, 'password');
        },
        function(callback) {
            if(!req.body.secret){
                callback("App Secret is Empty")
            }
            
            if(req.body.secret != secret){
                callback("App Secret is invalid")
            }
            callback(null, 'secret');
        }
    ],
    // optional callback
    function(err, results) {
        if(err){
            res.json({
                error : true,
                message : err,
                token : null
            })
            res.end();
            return false;
        }
      
        try {
            var payload =  Date.now() + req.body.username ;
            var new_token = jwt.sign({  data: payload , exp:  Math.floor(Date.now() / 1000) + (900) }, req.body.secret);
            res.json({
                error : false,
                message : "Logged  Successfully",
                token : new_token
            })
            res.end();
            return false;
        } catch(err) {
            res.json({
                error : true,
                message : err,
                token : null
            })
            res.end();
            return false;
        }
        // results is now equal to ['one', 'two']
    });
});

router.post('/status', function(req, res, next) {

    //console.log(md5(md5("herbee") + "loginsecret"))


    var secret = "7348bb84826ed6cd9a6121803d57893b"
    async.waterfall([
        function(callback) {
            const bearerHeader = req.headers['authorization'];
            if (typeof bearerHeader !== 'undefined') {
                const bearer = bearerHeader.split(' ');
                const bearerToken = bearer[1];
                try {
                    jwt.verify(bearerToken, secret, function(err, decoded) {
                        if(err){
                            callback(err.message);
                        }
                        callback(null, bearerToken);
                    });
                } catch (err) {
                    callback('Bearer Token Invalid');
                }
            }else{
                callback('Bearer Token Missing');
            }
        },
        function(arg1, callback) {
            if(!req.body.order_id){
                callback("Order ID id empty");
            }
            callback(null, req.body.order_id);
        },
        function(arg1, callback) {
            if(!req.body.status){
                callback("Order Status id empty");
            }
            callback(null, req.body.status);
        },
        function(arg1, callback) {
            q.all([Order.select_order_status(req, config.mysql, q)]).then(function(order_status) {
                if(order_status[0][0] == ""){
                    callback("Order ID not exist");
                }else{
                    callback(null, order_status[0][0][0]);
                }
            }).fail(function(err){
                callback(err);
            }).done();
          
        },
        function(arg, callback) {
            try {
                if(req.body.status == "ready_to_ship" || req.body.status == "received" || req.body.status == "picked_up" || req.body.status == "arrived" || req.body.status == "departed" || req.body.status == "onsite" || req.body.status == "waiting" || req.body.status == "delivered" || req.body.status == "undeliverable" || req.body.status == "canceled"){
                    req.body.shipping_status = arg.shipping_status;
                    req.body.delivery_status = arg.delivery_status;
                    callback(null, req.body.status);
                }else{
                    callback("Order Status is undefined");
                }
            } catch(err) { 
                callback(err)
            }
        },
        function(arg, callback) {
            try {
                if(req.body.status == "picked_up" || req.body.status == "ready_to_ship" || req.body.status == "arrived" || req.body.status == "departed" || req.body.status == "onsite" || req.body.status == "waiting"){
                    req.body.shipping_status = "1";
                }
                if(req.body.status == "delivered"){
                    req.body.shipping_status = "1";
                    req.body.delivery_status = "1";
                }
                if(req.body.status == "undeliverable" || req.body.status == "canceled"){
                    req.body.shipping_status = "1";
                    req.body.delivery_status = "0";
                }
                if(req.body.status == "ready_to_ship"){
                    req.body.shipping_status = "0";
                    req.body.delivery_status = "0";
                }
                callback(null, req.body.status);
            } catch(err) { 
                callback(err)
            }
        },
        function(arg1, callback) {
            q.all([Order.update_order_status(req, config.mysql, q)]).then(function(order_update) {
                callback(null, "Order status updated successfully");
            }).fail(function(err){
                callback(err);
            }).done();
        }
    ],
    // optional callback
    function(err, results) {
        if(err){
            res.json({
                error: true,
                message: err
            })
            res.end();
            return false;
        }
        res.json({
            error: false,
            message: results
        })
        res.end();
        return false;
    });

});

router.get(['/orderwithBuyNow', '/orderwithBuyNow/:id'], function(req, res, next){
    
    req.body.id = req.param('id')? req.param('id'): 1;
    var requestData = {
        id : req.body.id
    }
    request(global.fwrdauctionAPI.url + 'order', { method: "POST", json: true, body: requestData }, function(err, resp, body) {

        if (err || body.error) {
            console.log(err, " Error on Calling Order API From Posting a Product");
            res.json({
                err : "Error on Calling Order API"
            })
            res.end();
            // throw err;
        }else{
            res.json({
                body: body,
                done : "The Pick Order Data is Updated in the API Call"
            })
            res.end();
        }
    });
});


router.post('/order', function(req, res, next) {
    
    var LoginrequestData = {
        username:"herbee",
        password:"C4BF9ECCE7C47A3C7DCEE2DE0B0F5615439BACAC429CA9566D5DFADE02D296CA"
    }
    async.waterfall([
        function(callback) {
            request('http://sandbox.tec.esilaunch.com/api/token', { 
                method: "POST", 
                json: true, 
                body: LoginrequestData
            }, function(err, resp, body) {
                if(err){
                    callback(err);
                }
                if(body.error){
                    callback(body.message);
                }
                callback(null, body);
            }) 
        },
        function(loginRep, callback) {
            q.all([Order.Get_Order_Info(req, config.mysql, q)]).then(function(result) {
                
                    // console.log("=========================================================================== Get_Order_Info ===========================================================================")
                    // console.log("Order Get_Order_Info  ==  Res ==>", result[0][0][0])
                    // console.log("=========================================================================== Get_Order_Info ===========================================================================")
                    q.all([Order.getbuyershippingaddress(req, config.mysql, q,result[0][0][0].buserid)]).then(function(resultnew) {
                
                        // console.log("=========================================================================== Get_Order_Info ===========================================================================")
                        // console.log("Order Get_Order_Info  ==  Res ==>", resultnew[0][0][0])
                        // console.log("=========================================================================== Get_Order_Info ===========================================================================")
                        
                    callback(null,loginRep,result[0][0][0],resultnew[0][0][0]);
                })
            })
        },
        function(loginRep, data,shipdate,callback) {
            try { 
                var OneElement ={
                    order: {
                        provider : "herbee",
                        id : data.order_id.toString(),
                        recurring : data.b_recurring_status  == 1 ? true : false,
                        order_notes : "",
                        items : [{
                            sku: data.sku,
                            qty: data.req_qty ? data.req_qty : 0,
                            uom: data.units,
                            weight: data.req_qty ? data.req_qty : 0,
                            desc: {
                              short: smartTrim(data.product_description, 20, '', ' ...'),
                              long: data.product_description
                            },
                            state: "FB",
                            metrc: {
                                uid: "",
                                batch_rfid: ""
                            },
                            expiration_date: data.auction_end? data.auction_end.toString(): "",
                            price_incl_tax: data.b_total_amount,
                            excise_tax: data.b_excise_tax_amt,
                            fees: {
                            cultivation: data.b_cultivation_tax,
                            distribution: data.b_distribution_tax,
                            testing: 0
                            }
                        }],
                        buyer: {
                            active: compareDates(data.buyer_last_login) ? true : false,
                            account_id: data.buserid.toString(),
                            delivery_window: {
                                from: data.buyer_ship_from? slideTime(data.buyer_ship_from): "",
                                to: data.buyer_ship_to? slideTime(data.buyer_ship_to): ""
                            },
                            name: data.buyer_first_name + " " +  data.buyer_last_name,
                            phone:  data.buyer_phone,
                            email:  data.buyer_email,
                            permit: {
                                number: data.buyer_ein ? data.buyer_ein.toString() : data.buyer_ein,
                                type: data.buyer_business_type,
                                expiration: data.buyer_permit_expires? data.buyer_permit_expires.toString(): "",
                                octetStream: null
                            },
                            shipping_address: {
                                street: shipdate.address? shipdate.address: "",
                                postcode: shipdate.zipcode? shipdate.zipcode: "",
                                city: shipdate.city? shipdate.city: "",
                                state: shipdate.state? shipdate.state: "",
                            }
                        },
                        seller: {
                            active: compareDates(data.seller_last_login) ? true : false,
                            account_id: data.suserid.toString(),
                            pickup_window: {
                                from: slideTime(data.seller_ship_from),
                                to: slideTime(data.seller_ship_to)
                            },
                            name: data.seller_first_name + " " +  data.seller_last_name,
                            phone: data.seller_phone,
                            email: data.seller_email,
                            permit: {
                                number: data.seller_ein ? data.seller_ein.toString() : data.seller_ein,
                                type: data.seller_business_type,
                                expiration: data.seller_permit_expires? data.seller_permit_expires.toString(): "",
                                octetStream: null
                            },
                            pickup_address: {
                                street: data.seller_address? data.seller_address: "",
                                postcode: data.seller_zip? data.seller_zip: "",
                                city: data.seller_city? data.seller_city: "",
                                state: data.seller_state? data.seller_state: ""
                            }
                        }
                    }
                }
                
                callback(null,loginRep,OneElement);
            } catch(err) { 
                callback(err)
            }
        },
        function(loginRep,OneElement,callback) {
            request('http://sandbox.tec.esilaunch.com/api/order', { 
                method: "POST", 
                headers: {
                    Authorization: 'Bearer ' + loginRep.token,
                    'Content-Type': 'application/json'
                    },
                json: true, 
                body: OneElement 
            }, function(err, resp, body) {
                console.log("=========================================================================== Order API ===========================================================================")
                console.log("http://sandbox.tec.esilaunch.com/api/order  ==  Res ==>", body)
                console.log("=========================================================================== Order API ===========================================================================")
                if(err){
                    callback(err);
                }
                if(body.error){
                    callback(body.message);
                }
                if(body.message.error){
                    callback(body.message.message);
                }
                callback(null, OneElement);
            }) 
        }
    ], function (err, result) {
        
        if(err){
            res.json({
                error: true,
                message: err
            })
            res.end();
            return false;
        }

        res.json({
            error: false,
            message: result
        })
        res.end();
        return false;
    });
})



router.post('/pickup', function(req, res, next) {
    var LoginrequestData = {
        username:"herbee",
        password:"C4BF9ECCE7C47A3C7DCEE2DE0B0F5615439BACAC429CA9566D5DFADE02D296CA"
    }
    async.waterfall([
        function(callback) {
            request('http://sandbox.tec.esilaunch.com/api/token', { 
                method: "POST", 
                json: true, 
                body: LoginrequestData
            }, function(err, resp, body) {
                //console.log('http://sandbox.tec.esilaunch.com/api/token == res ==>', body)
                if(err){
                    callback(err);
                }
                if(body.error){
                    callback(body.message);
                }
                callback(null, body);
            }) 
        },
        function(loginRep, callback) {
            //console.log(req.body.id, "   ==========$$$$$$$$$$$$$$$$$$$$$$$$$$============  ")
            q.all([Order.get_Product_Info(req, config.mysql, q)]).then(function(result) {
                console.log("=========================================================================== get_Product_Info ===========================================================================")
                console.log(result[0][0][0])
                console.log("=========================================================================== get_Product_Info ===========================================================================")
                callback(null,loginRep,result[0][0][0]);
            })
        },
        function(loginRep, data, callback) {
            var  OneElement = {};
            try {
                OneElement.product = [{
                    sku: data.sku,
                    qty: data.req_qty,
                    uom: data.req_units,
                    weight: data.req_qty + " " + data.req_units,
                    metrc: {
                      uid: null,
                      batch_rfid: null,
                    }
                  }]
                  OneElement.pickup  = {
                    street:  data.seller_address,
                    postcode:  data.seller_zip ,
                    city:  data.seller_city,
                    state: data.seller_state
                  }
                  OneElement.window  = {
                    from: slideTime(data.seller_ship_from),
                    to: slideTime(data.seller_ship_to)
                  }

                  //console.log("Req Body for PicUP  = ===", OneElement)

                  callback(null,loginRep,OneElement);
            } catch(err) { 
                callback(err)
            }
        },
        function(loginRep,OneElement,callback) {
            request('http://sandbox.tec.esilaunch.com/api/pickup', { 
                method: "POST", 
                headers: {
                    Authorization: 'Bearer ' + loginRep.token,
                    'Content-Type': 'application/json'
                    },
                json: true, 
                body: OneElement 
            }, function(err, resp, body) {
                console.log("=========================================================================== pickup API ===========================================================================")
                console.log("http://sandbox.tec.esilaunch.com/api/pickup  ==  Res ==>", body)
                console.log("=========================================================================== pickup API ===========================================================================")
                if(err){
                    callback(err);
                }
                if(body.error){
                    callback(body.message);
                }
                if(body.message.error){
                    callback(body.message.message);
                }
                callback(null, body);
            }) 
        }
    ], function (err, result) {
        //console.log(err, "  ===========================================  ", result)
        if(err){
            res.json({
                error: true,
                message: err
            })
            res.end();
            return false;
        }

        res.json({
            error: false,
            message: result
        })
        res.end();
        return false;
    });
})

//getting the user details based on various key values

router.post('/checktimezone', common.authorizeAPIkey, function(req, res, next) {
    var connection = $arr.config.mysql;
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    if(req.data.err){
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            if(rows.insertId > 0){
                res.send(req.data);
                res.end()
            }
        });
    } else {
        var moment = require("moment-timezone");
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","Success","D200",NULL,NULL,"'+req.data.response.error_state+'","0","'+req.body.api_id+'")'
        // console.log(insert_txn_query)
        connection.query(insert_txn_query, function(err, rows, fields) {
            if(rows.insertId > 0){
                res.send(moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss'));
                res.end();
            }
        });

    }
});

router.post('/altertable/users', common.authorizeAPIkey, function(req, res, next) {
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    var connection = $arr.config.mysql;
    console.log(req.body.api_id)
    if(req.data.err){
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var data = {
            err : {},
            response:{}
        }
        var error = ''
        var errorCode = ''
        console.log(req.body)
        async.series({
            mandatoryCheck: function (validCbk) {
                if(req.body.alter_query == ''){
                    errorCode = 'D1080'
                    validCbk(null,null)
                } else {
                    validCbk(null,null)
                }
            },
            alterTable: function (alterCbk) {
                if(errorCode){
                    alterCbk(null,null)
                } else {
                    q.all([apiUsers.alterAPIUserTable(req,config.mysql,q)]).then(function(apiRes){
                        alterCbk(null,null)
                    }).catch(function(err){
                        console.log(err)
                        if(err.errno == 1060){
                            errorCode = 'D1081'
                            alterCbk(null,null)
                        } else {
                            error = err.Error
                            errorCode = 'D1080'
                            alterCbk(null,null)
                        }
                    });
                }
            },
            function (err, results) {
                if(errorCode){
                    data.response = null
                    data.err.code = errorCode
                    if(error){
                        data.err.description = errorJson[errorCode] + '-' + error
                    } else {
                        data.err.description = errorJson[errorCode]
                    }
                    var error_state;
                    var status;
                    error_state = commonApi.getErrorState(errorCode)
                    if(error_state == "no issues"){
                        status = "Success"
                    } else {
                        status = "failed"
                    }
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end()
                        }
                    });
                } else {
                    // console.log("********")
                    data.err = null
                    errorCode = data.response.code = 'D200'
                    data.response.description = errorJson[errorCode];
                    data.response.error_state = commonApi.getErrorState(errorCode)
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                    // console.log(insert_txn_query)
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end();
                        }
                    });
                }
            }
        });
    }
});

router.get('/user/details/:type', common.authorizeAPIkey, function(req, res, next) {
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    var connection = $arr.config.mysql;
    console.log(req.body.api_id)
    if(req.data.err){
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var data = {
            err : {},
            response:{}
        }
        var error = ''
        var errorCode = '';
        req.body.table_name = 'hmb';
        var putable = req.body.table_name + "_users";
        var user = []
        req.query.type = req.param('type')
        // var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
        async.series({
            mandatoryCheck: function (validCbk) {
                if(req.query.type == 'email' || req.query.type == 'username' || req.query.type == 'phone' || req.query.type == 'userid'){
                    if(typeof req.query[req.query.type] == 'undefined'){
                        error = req.query.type
                        errorCode = 'D1001'
                        validCbk(null,null)
                    }else{
                        validCbk(null,null)
                    }
                }else{
                    errorCode = 'D1015'
                    validCbk(null,null)
                }
            },
            checkEntry : function(entryCbk){
                if(errorCode){
                    entryCbk(null,null)
                }else{
                    var dquery;
                    if(req.query.type == "email"){
                        dquery = " email = '"+req.query.email+"'";
                    }
                    if(req.query.type == "username"){
                        dquery = " username = '"+req.query.username+"'";
                    }
                    if(req.query.type == "phone"){
                        dquery = " phone = '"+req.query.phone+"'";
                    }
                    if(req.query.type == "userid"){
                        dquery = " id = '"+req.query.userid+"'";
                    }

                    connection.query('SELECT * from ' + putable + ' where '+dquery+'', function(err, rows, fields) {
                        console.log(this.sql)
                        if (err) {
                            console.log(err)
                            error = err.code
                            errorCode = 'D000'
                            entryCbk(null,null)
                        } else {
                            if (rows.length > 0) {
                                user = rows[0]
                                entryCbk(null,null)
                            } else {
                                errorCode = 'D1016'
                                entryCbk(null,null)
                            }
                        }
                    });
                }
            }
        },
        function (err, results) {
            if(errorCode){
                data.response = null
                data.err.code = errorCode
                if(error){
                    data.err.description = errorJson[errorCode] + '-' + error
                } else {
                    data.err.description = errorJson[errorCode]
                }
                var error_state;
                var status;
                error_state = commonApi.getErrorState(errorCode)
                if(error_state == "no issues"){
                    status = "Success"
                } else {
                    status = "failed"
                }
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end()
                    }
                });
            } else {
                // console.log("********")
                data.err = null
                errorCode = data.response.code = 'D200'
                data.response.description = errorJson[errorCode];
                data.response.error_state = commonApi.getErrorState(errorCode)
                data.response.user = user ;
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                // console.log(insert_txn_query)
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end();
                    }
                });
            }
        });
    }
});

router.post('/user/customquery', common.authorizeAPIkey, function(req, res, next) {
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    if(req.data.err){
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var data = {
            err : {},
            response:{}
        }
        var error = ''
        var errorCode = ''

        var connection = $arr.config.mysql;
        var putable = req.body.table_name + "_users";
        var searchquery = req.body.searchquery;

        var user = []
        async.series({
            checkEntry : function(entryCbk){
                if(errorCode){
                    entryCbk(null,null)
                }else{
                    var dquery;
                    if(searchquery == ''){
                        error = err.code
                        errorCode = 'D000'
                        entryCbk(null,null)
                    }
                    connection.query('SELECT ' + searchquery + ' from '+putable+'', function(err, rows, fields) {

                        if (err) {
                            console.log(err)
                            error = err.code
                            errorCode = 'D000'
                            entryCbk(null,null)
                        } else {
                            if (rows.length > 0) {
                                user = rows
                                entryCbk(null,null)
                            } else {
                                errorCode = 'D1016'
                                entryCbk(null,null)
                            }
                        }
                    });
                }
            }
        },
        function (err, results) {
            if(errorCode){
                data.response = null
                data.err.code = errorCode
                if(error) {
                    data.err.description = errorJson[errorCode] + '-' + error
                } else {
                    data.err.description = errorJson[errorCode]
                    // data.err.error_state = errorTypeJSON[errorCode]
                }
                var error_state;
                var status;
                error_state = commonApi.getErrorState(errorCode)
                if(error_state == "no issues"){
                    status = "Success"
                } else {
                    status = "failed"
                }
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end()
                    }
                });
            }else{
                data.err = null
                errorCode = data.response.code = 'D200'
                data.response.description = errorJson[errorCode];
                data.response.user = user;
                data.response.error_state = commonApi.getErrorState(errorCode)
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                // console.log(insert_txn_query)
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end();
                    }
                });
            }
        });
    }
});

router.post('/user/update', common.authorizeAPIkey, function (req, res, next) {

    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    if (req.data.err) {
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var fields = [];
        var fieldvalues = [];
        var type,type1 = '';
        var user_id;
        var userObj = []

        var data = {
            err: {},
            response: {}
        }
        var error = ''
        var errorCode = ''

        var action = 'user_update'
        var putable = req.body.table_name + "_users";

        for (var key in req.body) {
            if (req.body.hasOwnProperty(key)) {

                if (key != "table_name" && key != "id" && key != "api_id" && key != "api_key" &&  key != "app_key" &&  key != "unique_key") {
                    fields.push("" + key + " = '" + req.body[key] + "'");
                    if (key == "password_hash" || key == "password_confirmation") {
                        if (req.body[key] == '') {
                            fields.splice(fields.indexOf(key), 1);
                        } else {
                            
                            fields.splice(fields.indexOf(key), 1);
                            if(req.body.password_salt){
                                console.log("pass salt",req.body.password_salt,req.body.password_hash)
                                var password_hash = md5(md5(req.body[key]) + req.body.password_salt);
                            }else{
                                var password_hash = md5(md5(req.body[key]));
                            }

                            fields.push("" + key + " = '" + password_hash + "'");
                            fieldvalues.push("" + password_hash + "");
                        }
                    } else {

                        fieldvalues.push("" + req.body[key] + "");
                    }
                }
                else {
                }
            }
        }
        var connection = $arr.config.mysql;
        var newString = fieldvalues.length === 0 ? "" : "'" + fieldvalues.join("','") + "'";
        var newfields = fields.length === 0 ? "" : fields.join(",");

        async.series([
            function mandatoryCheck(validCbk) { // Field Validation
                var givenFields = req.body
                var keyValues = _.keys(givenFields)

                var reg_re_fields = validationJson[action]
                var missedFields = _.difference(reg_re_fields, keyValues)

                if (missedFields.length > 0) {
                    error = missedFields
                    errorCode = 'D1001'
                    validCbk(null, null)
                } else {
                    if(req.body.id == '' || isNaN(req.body.id)){
                        errorCode = 'L0008'
                        validCbk(null, null)
                    }else{
                        user_id = req.body.id
                        validCbk(null, null)
                    }
                }
            },
            function checkDuplicateEntry(checkentry) {
                if (errorCode) {
                    checkentry(null, null)
                } else {
                    if (req.body.unique_key == "email" && req.body.email) {
                        type = 'email = "' + req.body.email + '"';
                    }
                    if (req.body.unique_key == "username" && req.body.username) {
                        type = 'username = "' + req.body.username + '"';
                    }
                    if (req.body.unique_key == "phone" && req.body.phone) {
                        type = 'phone = "' + req.body.phone + '"';
                    }
                    if (req.body.unique_key == "username_email" && req.body.username && req.body.email) {
                        if(req.body.username && req.body.email){
                            type = 'username = "' + req.body.username + '"';
                            req.body.unique_key1 = 'email'
                            type1 = 'email = "' + req.body.email + '"';
                        }else if(req.body.email){
                            type = 'email = "' + req.body.email + '"';
                        }else if(req.body.username){
                            type = 'username = "' + req.body.username + '"';
                        }else{

                        }
                    }

                    if (req.body.unique_key == "phone_email") {
                        if(req.body.phone && req.body.email){
                            type = 'phone = "' + req.body.phone + '"';
                            req.body.unique_key1 = 'email'
                            type1 = 'email = "' + req.body.email + '"';
                        }else if(req.body.email){
                            type = 'email = "' + req.body.email + '"';
                        }else if(req.body.phone){
                            type = 'phone = "' + req.body.phone + '"';
                        }else{

                        }

                    }
                    if(type){
                        connection.query('SELECT * from ' + putable + ' where ' + type, function (err, rows, fields) {
                            if (err) {
                                console.log("Error in update 1")
                                console.log(err)
                                errorCode = 'D000'
                                checkentry(null, null);
                            } else {
                                if (rows.length > 0) {
                                    if(req.body.id = rows[0].id){
                                        checkentry(null, null)
                                    } else {
                                        error = req.body.unique_key
                                        errorCode = 'R1000'
                                        checkentry(null, null);
                                    }
                                } else {
                                    if(type1){
                                        connection.query('SELECT * from ' + putable + ' where ' + type1, function (err1, rows1, fields1) {
                                            if (err1) {
                                                console.log("Error in update 2")
                                                console.log(err1)
                                                errorCode = 'D000'
                                                checkentry(null, null)
                                            } else {
                                                if (rows1.length > 0) {
                                                    if(req.body.id = rows1[0].id){
                                                        checkentry(null, null)
                                                    } else {
                                                        error = req.body.unique_key1
                                                        errorCode = 'R1000'
                                                        checkentry(null, null);
                                                    }
                                                } else {
                                                    checkentry(null, null)
                                                }
                                            }
                                        });
                                    }
                                    else{
                                        checkentry(null, null)
                                    }

                                }
                            }
                        });
                    }
                    else{
                        checkentry(null, null)
                    }

                }

            },
            function insertTransaction(transactionCbk) { // Insert a transaction for this API request
                transactionCbk(null, null)
            },
            function updateUser(insertcb) {
                if (errorCode) {
                    insertcb(null, null);
                } else {
                    console.log("query to execute")
                    console.log('Update ' + putable + ' set ' + newfields + ' where id = ?')
                    connection.query('Update ' + putable + ' set ' + newfields + ' where id = ?', [user_id], function(err, rows, fields) {
                        if (err) {
                            console.log("Update Error")
                            console.log(err)
                            errorCode = 'D000';
                            insertcb(null, null);
                        } else {
                            if (rows.affectedRows > 0) {
                                insertcb(null, null);
                            } else {
                                errorCode = 'D000'
                                insertcb(null, null);
                            }
                        }
                    });
                }
            },
            function getUpdatedUser(updatecb) {
                if (errorCode) {
                    updatecb(null, null);
                } else {
                    connection.query('SELECT * from ' + putable + ' where id = ?', [user_id], function(err, rows, fields) {
                        if (err) {
                            console.log("Error in update 3")
                            console.log(err)
                            errorCode = 'D000';
                            updatecb(null, null);
                        } else {
                            if (rows.length > 0) {
                                console.log("It came if")
                                userObj = rows
                                updatecb(null, null);
                            } else {
                                console.log("It came else")
                                errorCode = 'D000'
                                updatecb(null, null);
                            }
                        }
                    });
                }
            },

        ], function callback(err, results) {
            if (errorCode) {
                data.response = null
                data.err.code = errorCode
                if (error) {
                    data.err.description = errorJson[errorCode] + '-' + error
                } else {
                    data.err.description = errorJson[errorCode]
                }
                data.err.updated = false
                var error_state;
                var status;
                error_state = commonApi.getErrorState(errorCode)
                if(error_state == "no issues"){
                    status = "Success"
                } else {
                    status = "failed"
                }
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end()
                    }
                });
            } else {
                data.err = null
                errorCode = data.response.code = 'D200'
                data.response.description = errorJson[errorCode]
                data.response.updated = true
                data.response.user = userObj;
                data.response.error_state = commonApi.getErrorState(errorCode)
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                // console.log(insert_txn_query)
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end();
                    }
                });
            }
        });
    }
});


router.post('/checkentry', common.authorizeAPIkey,  function(req, res, next) {
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    if(req.data.err){
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var data = {
            err : {},
            response:{}
        }
        var error = ''
        var errorCode = ''
        var action = 'check_entry'
        var exist = false;

        async.series({
                mandatoryCheck: function (validCbk) { // Field Validation
                        var givenFields = req.body
                        var keyValues = _.keys(givenFields)

                        var bid_required_fields = validationJson[action]
                        var missedFields = _.difference(bid_required_fields, keyValues)
                        if(missedFields.length >  0){
                            error = missedFields
                            errorCode = 'D1001'
                            validCbk(null,null)
                        }else{
                            if(req.body.type == 'email' || req.body.type == 'username' || req.body.type == 'phone'){
                                if(typeof req.body[req.body.type] == 'undefined'){
                                    error = req.body.type
                                    errorCode = 'D1001'
                                    validCbk(null,null)
                                }else{
                                    validCbk(null,null)
                                }
                            }else{
                                errorCode = 'L0003'
                                validCbk(null,null)
                            }
                        }
                   },
                  checkEntry : function(entryCbk){
                      if(errorCode){
                          entryCbk(null,null)
                      }else{
                          var dquery;
                          if(req.body.type == "email"){
                              dquery = " email = '"+req.body.email+"'";
                          }
                          if(req.body.type == "username"){
                              dquery = " username = '"+req.body.username+"'";
                          }
                          if(req.body.type == "phone"){
                              dquery = " phone = '"+req.body.phone+"'";
                          }

                          console.log("55555555555555555555555555555555555");
                          console.log(req.body.table_name + "_users");
                          var putable = req.body.table_name + "_users";
                          var connection = $arr.config.mysql;
                          connection.query('SELECT * from ' + putable + ' where '+dquery+'', function(err, rows, fields) {
                            console.log(this.sql)
                              if (err) {
                                  error = err.code
                                  errorCode = 'D000'
                                  entryCbk(null,null)
                              } else {
                                console.log(rows)
                                  if (rows.length > 0) {
                                      exist = true
                                      entryCbk(null,null)
                                  } else {
                                      entryCbk(null,null)
                                  }
                              }
                          });
                      }
                  }
            },
            function (err, results) {

                if(errorCode){
                    data.response = null
                    data.err.code = errorCode
                    if(error){
                        data.err.description = errorJson[errorCode] + '-' + error
                    }else{
                        data.err.description = errorJson[errorCode]
                    }
                    var error_state;
                    var status;
                    error_state = commonApi.getErrorState(errorCode)
                    if(error_state == "no issues"){
                        status = "Success"
                    } else {
                        status = "failed"
                    }
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end()
                        }
                    });
                }else{
                    data.err = null
                    errorCode = data.response.code = 'D200'
                    data.response.description = errorJson[errorCode];
                    data.response.exists = exist ;
                    data.response.error_state = commonApi.getErrorState(errorCode)
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                    // console.log(insert_txn_query)
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end();
                        }
                    });
                }
            });

    }
});

/* GET users saving. */
router.post('/user/save', common.authorizeAPIkey, function (req, res, next) {
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    if(req.data.err) {
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var fields = [];
        var fieldvalues = [];
        var putable;
        var type,type1;
        var user_id;

        var data = {
            err: {},
            response: {}
        }
        var error = ''
        var errorCode = ''

        var action = 'registration'


        for (var key in req.body) {
            if (req.body.hasOwnProperty(key)) {
                if (key != "table_name" && key != "api_key" && key != "app_key" && key != "unique_key" && key != "api_id") {
                    fields.push(key);
                    if (key == "password_hash" || key == "password_confirmation") {
                        var md5 = require('md5');
                        if(req.body.password_salt){
                            var password_hash = md5(md5(req.body[key]) + req.body.password_salt);
                        }else{
                            var password_hash = md5(md5(req.body[key]));
                        }

                        fieldvalues.push("" + password_hash + "");
                    } else {
                        fieldvalues.push("" + req.body[key] + "");
                    }
                } else {
                    putable = req.body.table_name + "_users";
                }
            }
        }
        var connection = $arr.config.mysql;
        var newString = fieldvalues.length === 0 ? "" : "'" + fieldvalues.join("','") + "'";
        var newfields = fields.length === 0 ? "" : fields.join(",");

        async.series([
            function mandatoryCheck(validCbk) { // Field Validation
                var givenFields = req.body
                var keyValues = _.keys(givenFields)
                var reg_re_fields
                if(req.body.unique_key == "email"){
                  reg_re_fields = ["unique_key", "email", "password_hash", "password_confirmation"]
                } else if(req.body.unique_key == "username"){
                  reg_re_fields = ["unique_key", "username", "password_hash", "password_confirmation"]
                } else if(req.body.unique_key == "phone"){
                  reg_re_fields = ["unique_key", "phone", "password_hash", "password_confirmation"]
                } else {
                  reg_re_fields = validationJson[action]
                }

                var missedFields = _.difference(reg_re_fields, keyValues)

                if (missedFields.length > 0) {
                    error = missedFields
                    errorCode = 'D1001'
                    validCbk(null, null)
                } else {
                    validCbk(null, null)
                }
            },
            function checkDuplicateEntry(checkentry) {
                if (errorCode) {
                    checkentry(null, null)
                } else {
                    if (req.body.unique_key == "email") {
                        type = 'email = "' + req.body.email + '"';
                    }
                    if (req.body.unique_key == "username") {
                        type = 'username = "' + req.body.username + '"';
                    }
                    if (req.body.unique_key == "phone") {
                        type = 'phone = "' + req.body.phone + '"';
                    }
                    if (req.body.unique_key == "username_email") {
                        if(req.body.username && req.body.email){
                            type = 'username = "' + req.body.username + '"';
                            req.body.unique_key1 = 'email'
                            type1 = 'email = "' + req.body.email + '"';
                        }else if(req.body.email){
                            type = 'email = "' + req.body.email + '"';
                        }else if(req.body.username){
                            type = 'username = "' + req.body.username + '"';
                        }else{

                        }
                    }
                    if (req.body.unique_key == "phone_email") {
                        if(req.body.phone && req.body.email){
                            type = 'phone = "' + req.body.phone + '"';
                            req.body.unique_key1 = 'email'
                            type1 = 'email = "' + req.body.email + '"';
                        }else if(req.body.email){
                            type = 'email = "' + req.body.email + '"';
                        }else if(req.body.phone){
                            type = 'phone = "' + req.body.phone + '"';
                        }else{

                        }
                    }
                    connection.query('SELECT * from ' + putable + ' where ' + type, function (err, rows, fields) {
                        if (err) {
                            errorCode = 'D000'
                        } else {
                            if (rows.length > 0) {
                                error = req.body.unique_key
                                errorCode = 'R1000'
                                checkentry(null, null);
                            } else {
                                if(req.body.unique_key1){
                                    connection.query('SELECT * from ' + putable + ' where ' + type1, function (err1, rows1, fields1) {
                                        if (err1) {
                                            errorCode = 'D000'
                                        } else {
                                            if (rows1.length > 0) {
                                                error = req.body.unique_key1
                                                errorCode = 'R1000'
                                                checkentry(null, null);
                                            } else {
                                                checkentry(null, null)
                                            }
                                        }
                                    });
                                } else {
                                    checkentry(null, null)
                                }

                            }
                        }
                    });
                }

            },
            function insertTransaction(transactionCbk) { // Insert a transaction for this API request
                transactionCbk(null, null)
            },
            function insertUser(insertcb) {
                if (errorCode) {
                    insertcb(null, null);
                } else {
                    var test = connection.query('insert into ' + putable + '(' + newfields + ') values(' + newString + ')', function (err, rows, fields) {
                        console.log("here-----"+test.sql)
                        if (err) {
                            console.log(err)
                            error = err.stack
                            errorCode = 'D000';
                            insertcb(null, null);
                        } else {
                            if (rows.affectedRows > 0) {
                                user_id = rows.insertId
                                insertcb(null, null);
                            } else {
                                errorCode = 'D000'
                                insertcb(null, null);
                            }
                        }
                    });
                }
            }
        ], function callback(err, results) {
            if (errorCode) {
                data.response = null
                data.err.code = errorCode
                if (error) {
                    data.err.description = errorJson[errorCode] + '-' + error
                } else {
                    data.err.description = errorJson[errorCode]
                }
                var error_state;
                var status;
                error_state = commonApi.getErrorState(errorCode)
                if(error_state == "no issues"){
                    status = "Success"
                } else {
                    status = "failed"
                }
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end()
                    }
                });
            } else {
                data.err = null
                errorCode = data.response.code = 'D200'
                data.response.description = errorJson[errorCode]
                data.response.userId = user_id;
                data.response.error_state = commonApi.getErrorState(errorCode)
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                // console.log(insert_txn_query)
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end();
                    }
                });
            }
        });
    }
});

router.post(['/login/save'], common.authorizeAPIkey,  function(req, res) {
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    if(req.data.err){
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var data = {
            err : {},
            response:{}
        }
        var error = ''
        var errorCode = ''

        var connection = $arr.config.mysql;
        var putable = req.body.table_name + "_users";

        var user = []

        req.query.type = req.param('type')

        async.series({
                mandatoryCheck: function (validCbk) {
                    if(req.body.type == 'email' || req.body.type == 'username' || req.body.type == 'phone' || req.body.type == 'username_email'){
                        if(req.body.type == 'username_email'){
                            if(typeof req.body['username'] != 'undefined' || typeof req.body['email'] != 'undefined'){
                                if(typeof req.body.password_hash == 'undefined'){
                                    error ='password_hash'
                                    errorCode = 'D1001'
                                    validCbk(null,null)
                                }else{
                                    validCbk(null,null)
                                }

                            }else{
                                error ='username / email'
                                errorCode = 'D1001'
                                validCbk(null,null)
                            }
                        }else if(req.body.type == 'phone_email'){
                            if(typeof req.body['phone'] != 'undefined' || typeof req.body['email'] != 'undefined'){
                                if(typeof req.body.password_hash == 'undefined'){
                                    error ='password_hash'
                                    errorCode = 'D1001'
                                    validCbk(null,null)
                                }else{
                                    validCbk(null,null)
                                }

                            }else{
                                error ='username / email'
                                errorCode = 'D1001'
                                validCbk(null,null)
                            }
                        }
                        else{
                            if(typeof req.body[req.body.type] == 'undefined'){
                                error = req.body.type
                                errorCode = 'D1001'
                                validCbk(null,null)
                            }else{
                                if(typeof req.body.password_hash == 'undefined'){
                                    error ='password_hash'
                                    errorCode = 'D1001'
                                    validCbk(null,null)
                                }else{
                                    validCbk(null,null)
                                }
                            }
                        }
                    }
                    else{
                        errorCode = 'D1015'
                        validCbk(null,null)
                    }
                },
                checkEntry : function(entryCbk){
                    if(errorCode){
                        entryCbk(null,null)
                    }else{
                        var dquery;
                        if(req.body.type == "email"){
                            dquery = " email = '"+req.body.email+"'";
                        }
                        if(req.body.type == "username"){
                            dquery = " username = '"+req.body.username+"'";
                        }
                        if(req.body.type == "phone"){
                            dquery = " phone = '"+req.body.phone+"'";
                        }
                        if(req.body.type == "username_email"){
                            if(req.body.email){
                                dquery = " username = '"+req.body.email+"' or email ='"+req.body.email+"'";
                            }else{
                                dquery = " username = '"+req.body.username+"' or email ='"+req.body.username+"'";
                            }
                        }
                        if(req.body.type == "phone_email"){
                            if(req.body.phone){
                                dquery = " phone = '"+req.body.phone+"' or email ='"+req.body.phone+"'";
                            }else{
                                dquery = " phone = '"+req.body.email+"' or email ='"+req.body.email+"'";
                            }
                        }

                        connection.query('SELECT * from ' + putable + ' where '+dquery+'', function(err, rows, fields) {
                            if (err) {
                                error = err.code
                                errorCode = 'D000'
                                entryCbk(null,null)
                            } else {
                                if (rows.length > 0) {
                                    user = rows
                                    var md5 = require('md5');
                                    if(req.body.password_salt){
                                        var password_hash = md5(md5(req.body['password_hash']) + req.body.password_salt);
                                    }else{
                                        var password_hash = md5(md5(req.body['password_hash']));
                                    }

                                    if(password_hash == user[0].password_hash){
                                        entryCbk(null,null)
                                    }else{
                                        errorCode = 'L0004'
                                        entryCbk(null,null)
                                    }

                                } else {
                                    errorCode = 'D1016'
                                    entryCbk(null,null)
                                }
                            }
                        });
                    }
                }
            },
            function (err, results) {

                if(errorCode){
                    data.response = null
                    data.err.code = errorCode
                    if(error){
                        data.err.description = errorJson[errorCode] + '-' + error
                    }else{
                        data.err.description = errorJson[errorCode]
                    }
                    var error_state;
                    var status;
                    error_state = commonApi.getErrorState(errorCode)
                    if(error_state == "no issues"){
                        status = "Success"
                    } else {
                        status = "failed"
                    }
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end()
                        }
                    });
                }else{
                    data.err = null
                    errorCode = data.response.code = 'D200'
                    data.response.description = errorJson[errorCode];
                    data.response.user = user ;
                    data.response.error_state = commonApi.getErrorState(errorCode)
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                    // console.log(insert_txn_query)
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end();
                        }
                    });
                }
            });


    }
});

router.post(['/password/save'], common.authorizeAPIkey,  function(req, res) {
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    if(req.data.err){
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var fields = [];
        var fieldvalues = [];
        var putable;
        var id;
        var password_hash;
        var data = {
            err : {},
            response:{}
        }
        var error = ''
        var errorCode = ''

        // var action = 'registration'
        var details = {}
        if(req.body.password_hash == req.body.password_confirmation){
            for (var key in req.body) {
                if (req.body.hasOwnProperty(key)) {
                    if (key != "table_name" && key != "id") {
                        if (key == "password_hash" || key == "password_confirmation") {
                            var md5 = require('md5');
                            if(req.body.password_salt){
                                password_hash = md5(md5(req.body[key]) + req.body.password_salt);
                            }else{
                                password_hash = md5(md5(req.body[key]));
                            }

                            fields.push("" + key + " = '" + password_hash + "'");
                            fieldvalues.push("" + password_hash + "");
                        } else {
                            fieldvalues.push("" + req.body[key] + "");
                        }
                    } else if(key == "table_name") {
                        putable = req.body[key] + "_users";
                    } else if(key == "id") {
                        id = req.body[key];
                    }
                }
            }
        } else {
            errorCode = 'L0004'
            data.response = null
            data.err.code = errorCode
            data.err.description = errorJson[errorCode]
            res.send(data);
            res.end();
        }


        var connection = $arr.config.mysql;
        var newString = fieldvalues.length === 0 ? "" : "'" + fieldvalues.join("','") + "'";
        var newfields = fields.length === 0 ? "" : fields.join(",");

        connection.query('Update ' + putable + ' set ' + newfields + ' where id = ?', [id], function(err, rows, fields) {
            if (err) {
                error = err.code
                errorCode = 'D000'
                if(errorCode){
                    data.response = null
                    data.err.code = errorCode
                    if(error){
                        data.err.description = errorJson[errorCode] + '-' + error
                    }else{
                        data.err.description = errorJson[errorCode]
                    }
                    var error_state;
                    var status;
                    error_state = commonApi.getErrorState(errorCode)
                    if(error_state == "no issues"){
                        status = "Success"
                    } else {
                        status = "failed"
                    }
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end()
                        }
                    });
                }
            } else {
                if (rows.affectedRows > 0) {
                    data.err = null
                    errorCode = data.response.code = 'L0001'
                    data.response.description = errorJson[errorCode]
                    data.response.error_state = commonApi.getErrorState(errorCode)
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                    // console.log(insert_txn_query)
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end();
                        }
                    });
                } else {
                    errorCode = 'L0008'
                    data.response = null
                    data.err.code = errorCode
                    data.err.description = errorJson[errorCode]
                    data.response.error_state = commonApi.getErrorState(errorCode)
                    var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                    // console.log(insert_txn_query)
                    connection.query(insert_txn_query, function(err, rows, fields) {
                        if(rows.insertId > 0){
                            res.send(data);
                            res.end();
                        }
                    });
                }
            }
        });
     }
});

router.get('/users/common', common.authorizeAPIkey,  function(req, res, next) {
    // console.log('req-----------------------------------------------------------------------');
    var txn_id_val = "DS_TXN_"+Math.floor(1000 + Math.random() * 9000);
    var connection = $arr.config.mysql;
    if(req.data.err){
        var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","failed",NULL,"'+req.data.err.code+'","'+req.data.err.description+'","'+req.data.err.error_state+'","0","'+req.body.api_id+'")'
        connection.query(insert_txn_query, function(err, rows, fields) {
            res.send(req.data);
            res.end()
        });
    } else {
        var data = {
            err : {},
            response:{}
        }
        var error = ''
        var errorCode = ''
        var action = 'custom_query'
        var finalResults = []
        async.series({
            mandatoryCheck: function (validCbk) { // Field Validation
                var givenFields = req.query
                var keyValues = _.keys(givenFields)

                var bid_required_fields = validationJson[action]
                var missedFields = _.difference(bid_required_fields, keyValues)
                if(missedFields.length >  0){
                    error = missedFields
                    errorCode = 'D1001'
                    validCbk(null,null)
                }else{
                    if(req.query.field_names == '' || req.query.where_condition == '' || req.query.type == ''){
                        error = missedFields
                        errorCode = 'D1018'
                        validCbk(null,null)
                    }else{
                        validCbk(null,null)
                    }
                }
            },
            queryExecution : function(entryCbk){
                if(errorCode){

                    entryCbk(null,null)
                }else{

                    var fieldName = req.query.field_names
                    var condition = req.query.where_condition // condition or 'no_where'
                    var fieldType = req.query.type // field type or 'no_type'
                    var tableName = req.body.table_name + "_users";
                    var joins = req.query.joins != undefined ? req.query.joins : '';
                    // console.log('req.query', req.query);

                    var queryToExecute = ''

                    if(req.query.type == 'no_type' && req.query.where_condition != 'no_where'){
                        console.log("case1")
                        //  Developer will send the whole where condition with where / order by or group by
                        if(joins != '') {
                            fieldName = 'u.'+fieldName.split(',').join(',u.');
                            tableName = tableName + ' AS u '
                        }
                        if(condition != '') {
                            // condition = 'u.'+condition.split('AND').join(',u.');
                        }
                        queryToExecute = 'SELECT '+fieldName +' from ' + tableName + joins +' '+ condition
                    }
                    else if(req.query.where_condition == 'no_where'){
                        console.log("case2")
                        //  Developer don't want where condition
                        queryToExecute = 'SELECT '+fieldName+' from ' + tableName
                    }else{
                        console.log("case3")
                        //  Developer send 'where condition' and 'field type' it should not have order by Ex : fieldType = id and condition = 1,2,3,4 so the query will be ==>> id in (1,2,3,4)
                        queryToExecute = 'SELECT '+fieldName+' from ' + tableName + ' where '+fieldType+' in ('+condition+')'
                    }

                    connection.query(queryToExecute, function(err, rows, fields) {
                        console.log("custom query")
                        console.log(queryToExecute)
                        if (err) {
                            console.log(err)
                            error = err.code
                            errorCode = 'D000'
                            entryCbk(null,null)
                        } else {
                            finalResults = rows
                           entryCbk(null,null)
                        }
                    });
                }
            }
        },
        function (err, results) {

            if(errorCode){
                data.response = null
                data.err.code = errorCode
                if(error){
                    data.err.description = errorJson[errorCode] + '-' + error
                }else{
                    data.err.description = errorJson[errorCode]
                }
                var error_state;
                var status;
                error_state = commonApi.getErrorState(errorCode)
                if(error_state == "no issues"){
                    status = "Success"
                } else {
                    status = "failed"
                }
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+status+'",NULL,"'+errorCode+'","'+data.err.description+'","'+error_state+'","0","'+req.body.api_id+'")'
                
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end()
                    }
                });
            }else{
                data.err = null
                errorCode = data.response.code = 'D200'
                data.response.description = errorJson[errorCode];
                data.response.results = finalResults ;
                data.response.error_state = commonApi.getErrorState(errorCode)
                var insert_txn_query = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_state,payable_transaction,api_user_id) VALUES("'+txn_id_val+'","'+req.url+'","'+data.response.description+'","'+data.response.code+'",NULL,"'+data.response.error_state+'","0","'+req.body.api_id+'")'
                // console.log(insert_txn_query)
                connection.query(insert_txn_query, function(err, rows, fields) {
                    if(rows.insertId > 0){
                        res.send(data);
                        res.end();
                    }
                });
            }
        });
    }
});

module.exports = router;
