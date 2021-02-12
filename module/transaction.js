var dateFormat = require('dateformat');
var mysqli = require('./mysqli');

exports.getTransaction1= function(req,mysql,q)
{
	$mysqli = {};
	
	// strQuery = mysqli.mysqli($mysqli); 
    //console.log(strQuery);
    var defered = q.defer();
    
    var escape_string = [];
	query =  mysql.query('select * from transaction1',escape_string,defered.makeNodeResolver());
	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	})
	return defered.promise;	
}

exports.updateTransaction2= function(req,mysql,q)
{
	$mysqli = {};
	
	// strQuery = mysqli.mysqli($mysqli); 
    //console.log(strQuery);
    var defered = q.defer();
    
    var escape_string = [req.body.name, req.body.status];
	query =  mysql.query('insert into transaction2(name, status) values(?,?)',escape_string,defered.makeNodeResolver());
	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	})
	return defered.promise;	
}

exports.updateTransaction3= function(req,mysql,q)
{
	$mysqli = {};
	
	// strQuery = mysqli.mysqli($mysqli); 
    //console.log(strQuery);
    var defered = q.defer();
    
    var escape_string = [req.body.name, req.body.status];
	query =  mysql.query('insert into transaction3(name, status) values(?,?)',escape_string,defered.makeNodeResolver());
	query.on('error',function(err){
		console.log(err.stack);
		throw err;
	})
	return defered.promise;	
}