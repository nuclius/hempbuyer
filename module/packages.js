var q = require('q');
var mysqli = require('./mysqli');
var common = require('./common');
exports.show = function(req,mysql,q)
{  
    $mysqli = {};
    var defered = q.defer();
    
	strQuery = mysqli.mysqli($mysqli,26); 
    
    escape_fields = [];	
	query =  mysql.query(strQuery,escape_fields,defered.makeNodeResolver());

	return defered.promise;
}
exports.getPackageInfo = function(req,mysql,q,id)
{  
    $mysqli = {};
    var defered = q.defer();
    
	strQuery = mysqli.mysqli($mysqli,29); 
    
    escape_fields = [id];	
	query =  mysql.query(strQuery,escape_fields,defered.makeNodeResolver());

	return defered.promise;
}
exports.getuserdetails = function(req, mysql, q, userid) {
    $mysqli = {};
    var escape_data = [userid];
    msq = 844;

    strQuery = mysqli.mysqli($mysqli, msq);
    var defered = q.defer();
    console.log("check session id"+query.sql);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}