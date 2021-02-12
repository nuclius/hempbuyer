var q = require('q');
var mysqli = require('./mysqli');
var common = require('./common');

exports.Get_Order_Info = function(req,mysql,q)
{  
    $mysqli = {};
    var defered = q.defer();
	strQuery = mysqli.mysqli($mysqli,'order_api_req'); 
    escape_fields = [req.body.id];	
    query =  mysql.query(strQuery,escape_fields,defered.makeNodeResolver());
    console.log(query.sql, "  ===============================Get Order Info ===================================== ")
    // var cowsay = require("cowsay");
    // console.log(cowsay.say({
    //     text : query.sql,
    //     e : "oO",
    //     T : "U "
    // }));
	return defered.promise;
}

exports.get_Product_Info = function(req,mysql,q)
{  
    $mysqli = {};
    var defered = q.defer();
	strQuery = mysqli.mysqli($mysqli,'product_api_req'); 
    escape_fields = [req.body.id];	
    query =  mysql.query(strQuery,escape_fields,defered.makeNodeResolver());
    // console.log(query.sql, " ============= ")
	return defered.promise;
}

exports.warehouseSkuONProduct = function(req,mysql,q,id,sku)
{  
    $mysqli = {};
    var defered = q.defer();
	strQuery = mysqli.mysqli($mysqli,'warehouseSkuONProduct'); 
    escape_fields = [sku, id];	
    query =  mysql.query(strQuery,escape_fields,defered.makeNodeResolver());
    // console.log(query.sql, " ============= warehouseSkuONProduct")
	return defered.promise;
}


exports.select_order_status = function(req,mysql,q)
{  
    $mysqli = {};
    var defered = q.defer();
	strQuery = mysqli.mysqli($mysqli,'select_order_status'); 
    escape_fields = [req.body.order_id];	
	query =  mysql.query(strQuery,escape_fields,defered.makeNodeResolver());
	return defered.promise;
}

exports.getbuyershippingaddress = function(req,mysql,q,id)
{  
    $mysqli = {};
    var defered = q.defer();
	strQuery = mysqli.mysqli($mysqli,'getship_details'); 
    escape_fields = [id];	
	query =  mysql.query(strQuery,escape_fields,defered.makeNodeResolver());
	return defered.promise;
}

exports.update_order_status = function(req,mysql,q)
{  
    $mysqli = {};
    var defered = q.defer();
	strQuery = mysqli.mysqli($mysqli,'update_order_status'); 
    escape_fields = [req.body.shipping_status, req.body.delivery_status, req.body.status, req.body.order_id];
    query =  mysql.query(strQuery,escape_fields,defered.makeNodeResolver());
	return defered.promise;
}