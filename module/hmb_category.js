var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');

exports.getCategories = function (req, mysql, q, parent_id) {
    var where = '';
    if (parent_id > -1) {
        where = ' AND parent_id=' + parent_id;
    }
    $mysqli = {
        where: where
    } 
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'getCategories');
    var escape_data = [parent_id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getCategories", query.sql);
    query.on('error', function (err) {
        console.log("Error in getCategories", err);
    })
    return defered.promise;
}