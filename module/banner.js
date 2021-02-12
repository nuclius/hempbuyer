var fs = require('fs');
var mysqli = require('./mysqli');
var dateFormat = require('dateformat');
exports.deleteProducts= function(req,mysql,q)
{
	$mysqli = {};
	var row = 281;
	
	strQuery = mysqli.mysqli($mysqli,row); 
    //console.log(strQuery);
    var defered = q.defer();
    
    var escape_string = [req.body.id];
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	})
	return defered.promise;	
}
exports.editBanner = function(req,mysql,q)
{
	$mysqli = {};
	var row = 280;
	
	strQuery = mysqli.mysqli($mysqli,row); 
    //console.log(strQuery);
    var defered = q.defer();
    
    var escape_string = [req.body.id];
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	})
	return defered.promise;	
}
exports.listMyBanner = function(req,mysql,q,cnt)
{
	req.body.page = (typeof(req.body.page) == 'undefined') ? 1 : req.body.page;
    $mysqli = {};
	var row = 275;
	var escape_string = [(req.body.page-1)*10];
	if(cnt == 1)
	{
		row = 276;
		escape_string = [];
	}
	strQuery = mysqli.mysqli($mysqli,row); 
    //console.log(strQuery);
    var defered = q.defer();
    

	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());

	return defered.promise;	
}
exports.randomBanner = function(req,mysql,q)
{
	$mysqli = {};
	var row = 282;
	
	strQuery = mysqli.mysqli($mysqli,row); 
    //console.log(strQuery);
    var defered = q.defer();
    
    var escape_string = [];
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	})
	return defered.promise;	
}
exports.listProducts = function(req,mysql,q)
{
	$mysqli = {};
	var row = 277;
	
	strQuery = mysqli.mysqli($mysqli,row); 
    //console.log(strQuery);
    var defered = q.defer();
    
    var escape_string = [];
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	})
	return defered.promise;	
}
exports.updateProducts = function(req,mysql,q,cnt)
{
	$mysqli = {};
	var row = 279;
	
	strQuery = mysqli.mysqli($mysqli,row); 
    //console.log(strQuery);
    var defered = q.defer();
    datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_string = [req.body.name,req.body.subtitle,req.files.banner_image.name,req.files.banner_image.originalname,req.body.pcat,req.body.enable,req.body.offer_price,req.body.id];
	console.log(escape_string);
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());

	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	})
	return defered.promise;	
}
exports.insertProducts = function(req,mysql,q,cnt)
{
	$mysqli = {};
	var row = 278;
	
	strQuery = mysqli.mysqli($mysqli,row); 
    //console.log(strQuery);
    var defered = q.defer();
    datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    console.log(req.files.banner_image);
    var escape_string = [req.body.name,req.body.subtitle,req.files.banner_image.name,req.files.banner_image.originalname,req.body.pcat,req.body.enable,datge,req.body.offer_price];
	console.log(escape_string);
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	});
	return defered.promise;	
}
exports.listactiveads = function(req,mysql,q,cnt)
{
	var where = '';
	if (req.body.country !== '' && req.body.state !== '') {
        where = where + ' and user_id in (select user_id from user_extras where state = "'+req.body.state+'")  ';
    }else if (req.body.country !== '') {
    	where = where + ' and user_id in (select user_id from user_extras where country = "'+req.body.country+'")  ';
    };
    if(req.body.to_date !== '' && req.body.from_date == ''){
        where = where + ' and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date == ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date !== ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    }
    req.body.page = (typeof(req.body.page) == 'undefined') ? 1 : req.body.page;
    $mysqli = {where: where};
    var row = 'listactiveads';
    var escape_string = [(req.body.page-1)*10];
    if(cnt == 1)
    {
        row = 'listactiveadsc';
        escape_string = [];
    }
    strQuery = mysqli.mysqli($mysqli,row); 
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;    
}
exports.listinactiveads = function(req,mysql,q,cnt)
{	var where = '';
	if (req.body.country !== '' && req.body.state !== '') {
        where = where + ' and user_id in (select user_id from user_extras where state = "'+req.body.state+'")  ';
    }else if (req.body.country !== '') {
    	where = where + ' and user_id in (select user_id from user_extras where country = "'+req.body.country+'")  ';
    };
    if(req.body.to_date !== '' && req.body.from_date == ''){
        where = where + ' and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date == ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date !== ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    }
    req.body.page = (typeof(req.body.page) == 'undefined') ? 1 : req.body.page;
    $mysqli = {where: where};
    var row = 'listinactiveads';
    var escape_string = [(req.body.page-1)*10];
    if(cnt == 1)
    {
        row = 'listinactiveadsc';
        escape_string = [];
    }
    strQuery = mysqli.mysqli($mysqli,row); 
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;    
}
exports.liststores = function(req,mysql,q,cnt)
{
	var where = '';
	if (req.body.country !== '' && req.body.state !== '') {
        where = where + ' and user_id in (select user_id from user_extras where state = "'+req.body.state+'")  ';
    }else if (req.body.country !== '') {
    	where = where + ' and user_id in (select user_id from user_extras where country = "'+req.body.country+'")  ';
    };
    if(req.body.to_date !== '' && req.body.from_date == ''){
        where = where + ' and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date == ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date !== ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    }
    req.body.page = (typeof(req.body.page) == 'undefined') ? 1 : req.body.page;
    $mysqli = {where: where};
	var row = 'liststores';
	var escape_string = [(req.body.page-1)*10];
	if(cnt == 1)
	{
		row = 'liststoresc';
		escape_string = [];
	}
	strQuery = mysqli.mysqli($mysqli,row); 
    var defered = q.defer();
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	console.log(query.sql);
	return defered.promise;	
}
exports.listproduct = function(req,mysql,q,cnt)
{
	var where = '';
	if (req.body.country !== '' && req.body.state !== '') {
        where = where + ' and user_id in (select user_id from user_extras where state = "'+req.body.state+'")  ';
    }else if (req.body.country !== '') {
    	where = where + ' and user_id in (select user_id from user_extras where country = "'+req.body.country+'")  ';
    };
    if(req.body.to_date !== '' && req.body.from_date == ''){
        where = where + ' and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date == ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date !== ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    }
    req.body.page = (typeof(req.body.page) == 'undefined') ? 1 : req.body.page;
    $mysqli = {where: where};
	var row = 'listproduct';
	var escape_string = [(req.body.page-1)*10];
	if(cnt == 1)
	{
		row = 'listproductc';
		escape_string = [];
	}
	strQuery = mysqli.mysqli($mysqli,row); 
    var defered = q.defer();
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	console.log(query.sql);
	return defered.promise;	
}
exports.listbrand = function(req,mysql,q,cnt)
{
	var where = '';
	if (req.body.country !== '' && req.body.state !== '') {
        where = where + ' and user_id in (select user_id from user_extras where state = "'+req.body.state+'")  ';
    }else if (req.body.country !== '') {
    	where = where + ' and user_id in (select user_id from user_extras where country = "'+req.body.country+'")  ';
    };
    if(req.body.to_date !== '' && req.body.from_date == ''){
        where = where + ' and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date == ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" ';
    } else if(req.body.from_date !== '' && req.body.to_date !== ''){
        where = where + ' and a.created_at >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") +'" and a.created_at <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") +'" ';
    }
    req.body.page = (typeof(req.body.page) == 'undefined') ? 1 : req.body.page;
    $mysqli = {where: where};
	var row = 'listbrand';
	var escape_string = [(req.body.page-1)*10];
	if(cnt == 1)
	{
		row = 'listbrandc';
		escape_string = [];
	}
	strQuery = mysqli.mysqli($mysqli,row); 
    var defered = q.defer();
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	console.log(query.sql);
	return defered.promise;	
}
exports.editStore = function(req,mysql,q)
{
	req.body.page = (typeof(req.body.page) == 'undefined') ? 1 : req.body.page;
    $mysqli = {};
	var row = 'editStore';
	var escape_string = [req.body.id];
	strQuery = mysqli.mysqli($mysqli,row); 
    var defered = q.defer();
	query =  mysql.query(strQuery,escape_string,defered.makeNodeResolver());
	console.log(query.sql);
	return defered.promise;	
}


