var  util    = require('util');
var dateFormat = require('dateformat');     
var q = require('q');
var mysqli = require('./mysqli');
var common = require('./common');
var url = require('url');


exports.getTotalProduct = function(req,mysql,q,id)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,206);
  var dated = new Date();
  var y = dated.getFullYear();
  var m = dated.getMonth()+1;
  var escape_data = [y,id,m,y,id,y,id];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	console.log("getUserRolelogin 2 "+query.sql);
  return defered.promise;
}


exports.userInfo = function(req,mysql,q,id,field)
{
  if(id == 0)
  {
	id = (typeof(req.session) !== 'undefined' )  ? req.session.userid : 0;
  }  
  if(field == '')
  {
	field = '*';
  } 
  
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,25); 
  var escape_data = [field,id];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

  return defered.promise;
  
}

exports.getTotalProduct = function(req,mysql,q,id)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,206);
  var dated = new Date();
  var y = dated.getFullYear();
  var m = dated.getMonth()+1;
  var escape_data = [y,id,m,y,id,y,id];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	console.log("getTotalProduct 1 "+query.sql);
  return defered.promise;
}

exports.getTotalBuyNowProduct = function(req,mysql,q,id)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'total_buy_now');
  var dated = new Date();
  var y = dated.getFullYear();
  var m = dated.getMonth()+1;
  var escape_data = [y,id,m,y,id];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	console.log("getTotalBuyNowProduct "+query.sql);
  return defered.promise;
}

exports.getBusinessType = function(req,mysql,q,id)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_business_type');

  var escape_data = [id];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
 query.on('error', function(err) {
		console.log(err.stack);
		throw err;
	}); 
  return defered.promise;
}

exports.getTotalBid = function(req,mysql,q,id)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,207);
  var dated = new Date();

  var y = dated.getFullYear();
  var m = dated.getMonth()+1;
  var escape_data = [y,id,m,y,id];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	console.log("getTotalBid "+query.sql);
  return defered.promise;
}

exports.unsub_user = function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'unsub_user');

  var escape_data = [req.body.user_id];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

  return defered.promise;
}
exports.checkuser = function(req,mysql,q,ip)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,1000);
  
  var escape_data = [ip];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

  return defered.promise;
}
exports.updateUser = function(req, mysql, q,clientIp,userid,urls,browser,os){
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,1002);
  datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
  var escape_data = [userid,urls,datge,browser,os,clientIp];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  return defered.promise;
}
exports.insertUser = function(req, mysql, q,clientIp,userid,urls,browser,os){
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,1001);
  datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
  var escape_data = [userid,urls,datge,browser,os,clientIp];
  console.log( escape_data );
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  return defered.promise;
}
exports.checkcurrency = function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,1105);
  var escape_data = [];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

  return defered.promise;
}

exports.notify_msg_counter = function(req,mysql,q)
{
  
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'notify_msg_counter');
  var escape_data = [req.session.userid];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

  return defered.promise;

}

exports.getseofromurl = function(req,mysql,q,url)
{
  
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_seo_url');
  var escape_data = [url];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  
  return defered.promise;

}


exports.updateBusiness = function(mysql, req, res, userId) {
	// console.log(req.body);
	// console.log(req.files);
	$mysqli = {};
	datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
	// console.log("addShippingDetails"+JSON.stringify(req.body));
	// mysqli['update_business_details'] = 'update user_extras  set business_name = ?, business_type = ?, license_img = ?, business_cert = ?, ein_number = ? where user_id = ?';
	strQuery = mysqli.mysqli($mysqli, "update_user_details");
	var escape_string = [
		/* Added for address same as userprofile */
		req.body.address1,
		req.body.country,
		req.body.state,
		req.body.city,
		req.body.zip,
		req.body.region,
		req.body.state_abbr,
		datge,
		userId
	];
	console.log(escape_string);
	var defered = q.defer();
	console.log(strQuery);
	query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
	console.log(query.sql);
	query.on('error', function(err) {
		console.log(err.stack);
		throw err;
	});
	return defered.promise;
}

/* ===================== start change by divyesh (added) ===================== */
exports.getSalesSupport = function(req, res, mysql, user_id)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_sales_support');

  var escape_data = [user_id];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  // console.log('getSalesSupport ', query.sql);
  query.on('error', function(err) {
	console.log(err.stack);
	throw err;
  }); 
  return defered.promise;
}
exports.getSalesConsultantByCode = function(req, res, mysql, sc_code, q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_sales_consultant_by_code');

  var escape_data = [sc_code];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log('get_sales_support_by_code  ', query.sql);
  query.on('error', function(err) {
	console.log('getSalesConsultantByCode ', err.stack);
	throw err;
  }); 
  return defered.promise;
}

exports.updateSalesSupport = function(req, res, mysql, userid, q) {
  $mysqli = {};
  strQuery = mysqli.mysqli($mysqli, 'update_sales_support');
  var escape_data = [
	typeof(req.body.helpgrow) !== 'undefined' ? parseInt(req.body.helpgrow) : 0,
	typeof(req.body.HerbeeSalesConsultant) !== 'undefined' ? parseInt(req.body.HerbeeSalesConsultant) : 0,
	typeof(req.body.sccode) !== 'undefined' ? req.body.sccode : '',
	typeof(req.body.sc_user_id) !== 'undefined' ? parseInt(req.body.sc_user_id) : 0,
	typeof(req.body.start_date) !== 'undefined' ? req.body.start_date : '',
	typeof(req.body.end_date) !== 'undefined' ? req.body.end_date : '',
	typeof(req.body.cfee) !== 'undefined' ? parseInt(req.body.cfee) : 0,
	req.files.cagreement !== undefined ?
	(typeof(req.files.cagreement.name) !== 'undefined' ? req.files.cagreement.name : req.body.old_consultant_agreement) : req.body.old_consultant_agreement,
	parseInt(req.body.id)
  ];

  var defered = q.defer();
  query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
  console.log('query updateSalesSupport ', query.sql);
  query.on('error', function(err) {
	  console.log("Error updateSalesSupport " + err);
  })
  return defered.promise;
}

exports.getSalesAdminBySalesCode = function(req, res, mysql, sc_code, q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_sales_admin_by_sales_code');

  var escape_data = [sc_code];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log('get_sales_support_by_code  ', query.sql);
  query.on('error', function(err) {
	console.log('getSalesConsultantByCode ', err.stack);
	throw err;
  }); 
  return defered.promise;
}
exports.getUserDetailById = function(req, res, mysql, sc_code, q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'getUserDetailById');

  var escape_data = [sc_code];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log('getUserDetailById  ', query.sql);
  query.on('error', function(err) {
	console.log('getUserDetailById ', err.stack);
	throw err;
  }); 
  return defered.promise;
}
exports.Distributors = function(req, res, mysql, q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_distributors');

  var escape_data = [];

  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  // console.log('get_distributors ', query.sql);
  query.on('error', function(err) {
	console.log(err.stack);
	throw err;
  }); 
  return defered.promise;
}
/* ===================== end change by divyesh (added) ===================== */