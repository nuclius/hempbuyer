var mysqli = require('./mysqli');
var dateFormat = require('dateformat');


exports.checkifuserexists =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'checkusername');
    var deferred = q.defer();
    var escape_string = [req.body.user_name];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.perprojectData =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'status_per_page');
    var deferred = q.defer();
    var escape_string = [req.param('id')];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.perprojectDataDay =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'per_project_per_day');
    var deferred = q.defer();
    var escape_string = [req.param('id')];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.perprojectDataHour =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'per_project_per_hour');
    var deferred = q.defer();
    var escape_string = [req.param('id')];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.perprojectStats =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'perproject_stats');
    var deferred = q.defer();
    var escape_string = [req.param('id')];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}


exports.apiUserPersonalData =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'get_api_user_data');
    var deferred = q.defer();
    var escape_string = [req.param('id')];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.checkifprojectexists =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'checkprojectname');
    var deferred = q.defer();
    var escape_string = [req.body.project_name];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}



exports.insertApiObjects =  function(req,mysql,q){
    var needed = []
    var enables = []
    if(req.body.modules){
        var modules = req.body.modules.split(",")
        for(var i = 0; i < modules.length; i++){
            needed.push("enable_"+modules[i])
            enables.push("1");
        }
    }
    // console.log(needed.join(','))
    $mysqli = {needed: needed.join(','), enables: enables.join(',')};
    var today = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli,'insert_api_user');
    var deferred = q.defer();
    var escape_string = [req.body.api_key,req.body.app_key,req.body.user_name,req.body.project_name,req.body.timezone,today,'active',0];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    console.log(query.sql)
    return deferred.promise;
}

exports.updateAPIUser =  function(req,mysql,q){
    var needed = []
    var notneeded = []

    if(req.body.modules != ''){
        var modules = req.body.modules.split(",")
        for(var i = 0; i < modules.length; i++){
            needed.push("enable_"+modules[i]+" = 1")
        }
    }

    if(req.body.modules_no != ''){
        var modules_no = req.body.modules_no.split(",")
        for(var i = 0; i < modules_no.length; i++){
            notneeded.push("enable_"+modules_no[i]+" = 0")
        }
    }
    console.log(needed.join(','))
    console.log(notneeded.join(','))
    console.log(req.body)
    if(notneeded != ''){
       notneeded = notneeded.join(',')+","
    }
    $mysqli = {needed: needed.join(','), notneeded: notneeded};
    strQuery = mysqli.mysqli($mysqli,'update_api_user');
    var deferred = q.defer();
    var escape_string = [req.body.timezone, req.body.id];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    console.log(query.sql)
    return deferred.promise;
}

exports.getAPIUserByID =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'api_user_get_query');
    var deferred = q.defer();
    var escape_string = [req.body.lastinsertAPIid];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    console.log(query.sql)
    return deferred.promise;
}

exports.getAPIUserByIDForUpdate =  function(req,mysql,q){
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'api_user_get_query');
    var deferred = q.defer();
    var escape_string = [req.body.id];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    console.log(query.sql)
    return deferred.promise;
}

exports.getApiUserByApiKey =  function(req,mysql,q,type){
    $mysqli = {};
    var where = ''
    if(type == 1){
        where = ' where api_key = "'+req.body.api_key+'"'
    }else if(type == 2){
        where = ' where api_key = "'+req.body.api_key+ '" and app_key = "'+req.body.app_key+'"'
    }else if(type == 3){
        where = ' where project_name = "'+req.body.project_name+ '"'
    }
    $mysqli.where = where
    strQuery = mysqli.mysqli($mysqli,'get_api_user');
    var deferred = q.defer();
    var escape_string = [req.body.api_key];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    // console.log("API check",query.sql)
    return deferred.promise;
}



exports.insertApiBiddingTable =  function(req,mysql,q){
    $mysqli = {};

    var tableName = req.body.project_name+'_bids'
    $mysqli.table_name = tableName

    strQuery = mysqli.mysqli($mysqli,'create_bidding_table1');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_bidding_table2');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_bidding_table3');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    return deferred.promise;
}



exports.insertApiProxyTable =  function(req,mysql,q){
    $mysqli = {};

    var tableName = req.body.project_name+'_proxybid'
    $mysqli.table_name = tableName

    strQuery = mysqli.mysqli($mysqli,'create_proxy_table1');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_proxy_table2');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_proxy_table3');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    return deferred.promise;
}

exports.dropUserTable =  function(req,mysql,q){
    $mysqli = {};
    var tableName = req.body.project_name+'_users'
    $mysqli.table_name = tableName
    strQuery = mysqli.mysqli($mysqli,'drop_table');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.dropBiddingTable =  function(req,mysql,q){
    $mysqli = {};
    var tableName = req.body.project_name+'_bids'
    $mysqli.table_name = tableName
    strQuery = mysqli.mysqli($mysqli,'drop_table');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    var tableName = req.body.project_name+'_proxybid'
    $mysqli.table_name = tableName
    strQuery = mysqli.mysqli($mysqli,'drop_table');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.dropCartTable =  function(req,mysql,q){
    $mysqli = {};
    var tableName = req.body.project_name+'_cart_temp'
    $mysqli.table_name = tableName
    strQuery = mysqli.mysqli($mysqli,'drop_table');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.dropProjectsTable =  function(req,mysql,q){
    $mysqli = {};
    var tableName = req.body.project_name+'_projects'
    $mysqli.table_name = tableName
    strQuery = mysqli.mysqli($mysqli,'drop_table');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.insertApiUserTable =  function(req,mysql,q){
    $mysqli = {};

    var tableName = req.body.project_name+'_users'
    $mysqli.table_name = tableName

    strQuery = mysqli.mysqli($mysqli,'create_users_table1');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_users_table2');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_users_table3');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    return deferred.promise;
}

exports.alterAPIUserTable =  function(req,mysql,q){
    $mysqli = {};
    var tableName = req.body.table_name+'_users'
    $mysqli.table_name = tableName
    $mysqli.fields = req.body.alter_query
    strQuery = mysqli.mysqli($mysqli,'alter_user_table');
    var deferred = q.defer();
    query =  mysql.query(strQuery,deferred.makeNodeResolver());
    console.log(query.sql)
    return deferred.promise;
}

exports.insertApiCartTable =  function(req,mysql,q){
    $mysqli = {};

    var tableName = req.body.project_name+'_cart_temp'
    $mysqli.table_name = tableName

    strQuery = mysqli.mysqli($mysqli,'create_cart_temp_table1');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_cart_temp_table2');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_cart_temp_table3');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    return deferred.promise;
}
exports.insertApiprojectTable =  function(req,mysql,q){
    $mysqli = {};

    var tableName = req.body.project_name+'_projects'
    $mysqli.table_name = tableName

    strQuery = mysqli.mysqli($mysqli,'create_projects_table1');
    var deferred = q.defer();
    var escape_string = [];
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_projects_table2');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    strQuery = mysqli.mysqli($mysqli,'create_projects_table3');
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());

    return deferred.promise;
}
