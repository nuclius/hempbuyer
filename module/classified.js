var mysqli = require('./mysqli');
var products = require('./products');
var q = require('q');
var dateFormat = require('dateformat');
var topHTMLtext = '';


exports.addNewClassified = function(req,mysql,q)
{
 	var now = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
	 escape_data = [];
	strQuery = mysqli.mysqli($mysqli,'addNewClassified'); 
	var defered = q.defer(); 
	console.log(req.body);
	var escape_data =  [
		req.body.name, req.body.title, req.body.category, req.body.description, req.body.website, req.body.email, (req.body.is_special ? 1 : 0), req.session.userid, now, now, req.body.images, req.body.company_logo,
		req.body.short_description,
		req.body.state,
		req.body.city
	];
    console.log(escape_data);
	query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	console.log('Classified Insert : ', query.sql)
    return defered.promise;
}

exports.getClassified = function(req,mysql,q)
{
 
	strQuery = mysqli.mysqli($mysqli,'getClassified'); 
	var defered = q.defer(); 
	console.log(req.body);
	var escape_data =  []
    console.log(escape_data);
	query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	console.log('Classified GET : ', query.sql)
    return defered.promise;
}
exports.getClassifiedDetail = function(req,mysql,q)
{
	strQuery = mysqli.mysqli($mysqli,'getClassifiedDetail'); 
	var defered = q.defer(); 
	console.log(req.body);
	var escape_data =  [req.body.id]
    console.log(escape_data);
	query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	console.log('Classified GET : ', query.sql)
    return defered.promise;
}




exports.getClassifieds = function (req, mysql, q, count) {
    var where = '';
	where += ' AND ad.status="active"';
    if (req.body.state) {
        var whereAttr = [];
        if(Array.isArray(req.body.state)) {
            where += " AND ad.state IN (" + req.body.state + ") ";
        } else {
            where += " AND ad.state=" + req.body.state + "";
        }
    }
    if(req.body.city) {
        where += ' AND ad.city LIKE "%'+req.body.city.replace("'","").replace("'","")+'%"';
    }
    if (req.body.category) {
        var whereAttr = [];
        if(Array.isArray(req.body.category)) {
            where += " AND ad.category IN (" + req.body.category + ") ";
        } else {
            where += " AND ad.category=" + req.body.category + "";
        }
    }

    var limit = '';
    if(!count) {
        limit = " LIMIT " + req.body.startFrom + ',' + req.body.limit;
    }
    $mysqli = {
        where: where,
        limit: limit
    }
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getClassifieds');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getClassifieds", query.sql);
    query.on('error', function (err) {
        console.log("Error in getClassifieds", err); 
    })
    return defered.promise;
}