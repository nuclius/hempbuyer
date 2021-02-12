var q = require('q');
var commonApi = require('../module/api_common_module');
var apiUsers = require('../module/api_user_module');
var mysqli = require('./mysqli');

exports.checkLogin = function(req,res,next) {
   if(req.session && req.session.admin){
      res.locals.admin = req.session.admin;
      res.locals.userid = req.session.userid;
      res.locals.email = req.session.email;
      next();
   }else{
      res.locals.userid = "";
      res.writeHead(302, {
         'Location': '/api/auth/admin'
      });
      res.end();
      return false;
   }
}

exports.authorizeAPIkey = function(req,res,next) {
    typeof req.query.api_key != 'undefined' ? req.body.api_key = req.query.api_key : ''
    typeof req.query.app_key != 'undefined' ? req.body.app_key = req.query.app_key : ''
    typeof req.query.type != 'undefined' ? req.body.type = req.query.type : ''

    typeof req.body.api_key != 'undefined' ? req.body.api_key = req.body.api_key : ''
    typeof req.body.app_key != 'undefined' ? req.body.app_key = req.body.app_key : ''
    typeof req.body.type != 'undefined' ? req.body.type = req.body.type : ''

    var errorJson = require('../api_errors');
    var validationJson = require('../api_validation');
    var data = {
        err : {},
        response:{}
    }
    var error = ''
    var errorCode = ''
    var project = ''

    var action = 'details'
    var details = {}

   q.all([apiUsers.getApiUserByApiKey(req,config.mysql,q,2)]).then(function(apiRes){
    //console.log(apiRes[0][0][0]);
      if(apiRes[0][0].length > 0){
        req.body.api_id = apiRes[0][0][0].id;
        if(apiRes[0][0][0].enabled == 1){
          req.body.table_name = project = apiRes[0][0][0].project_name;
        } else {
          errorCode = 'S1003'
        }
      } else {
          req.body.api_id = 0
          errorCode = 'S1002'
      }
      if(errorCode){
          data.response = null
          data.err.code = errorCode
          data.err.error_state = commonApi.getErrorState(errorCode)
          if(error){
              data.err.description = errorJson[errorCode] + '-' + error
          }else{
              data.err.description = errorJson[errorCode]
          }

      } else {
          data.err = null
          errorCode = data.response.code = 'D200'
          data.response.error_state = commonApi.getErrorState(errorCode)
          data.response.description = errorJson[errorCode];
          data.response.details = details;
      }
      req.data = data;
      next();
  }).catch(function(err){
      error = err.code
      errorCode = 'D000'
      next();
  });
}


exports.insertTransactionRequests = function(req,res,next, escape_string) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli,'insert_transaction');
    var deferred = q.defer();
    query =  mysql.query(strQuery,escape_string,deferred.makeNodeResolver());
    console.log(query.sql)
    return deferred.promise;
}
