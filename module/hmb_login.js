var mysqli = require('./mysqli');
var q = require('q');
var async = require('async');
var md5 = require('MD5');

exports.process = function (req, mysql, callback) {
	$mysqli = { username: req.param('username') };
	strQuery = mysqli.mysqli($mysqli, 'admin_login');

	query = mysql.query(strQuery, function (error, results, fields) {
		if (error) {
			console.log(err.stack);
			callback('');
		}
		if (results.length > 0) {
			result = results[0];
			var password = md5(md5(req.body.password) + result['password_salt']);
			if (result.password == password || typeof (req.body.autologin) != 'undefined' || req.body.templogin) {
				callback(results);

			} else {
				if (result.password == password) {
					callback(results);
				}
				else {
					callback('');
				}
			}
		}
		else {
			callback('');
		}
	});

}


/**
 *  Check Login Credentials Exists or Not
 */
exports.checkUser = function (mysql, req) {
    $mysqli = {
        username : req.body.login_username,
        password : req.body.login_password
    };
    strQuery = mysqli.mysqli($mysqli, 'checkLoginCredentials');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    query.on('error', function (err) {
        throw err;
    });
    return defered.promise;
}

exports.checkReferralUser = function (mysql, req) {
    $mysqli = {
        username : req.body.login_username,
        password : req.body.login_password
    };
    strQuery = mysqli.mysqli($mysqli, 'checkReferralLoginCredentials');
    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    query.on('error', function (err) {
        throw err;
    });
    return defered.promise;
}