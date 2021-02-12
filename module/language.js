var fs = require('fs');
var mysqli = require('./mysqli');
var dateFormat = require('dateformat');

exports.add_groups = function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'new_language_group');
  var escape_data = [req.body.group_name,req.body.group_desc];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;
}

exports.add_language = function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'new_language');
  var datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
  var column_name = 'for_'+req.body.lang_name.toLowerCase().replace(/\s+/g, '');
  var escape_data = [req.body.lang_name,req.body.direction,req.body.locale,datge,column_name];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;
}

exports.add_language_column = function(req,mysql,q)
{

  $mysqli =  {};
  var clname = 'for_'+req.body.lang_name.toLowerCase().replace(/\s+/g, '');
  console.log(clname);
  $mysqli =  {clname: clname};
  strQuery = mysqli.mysqli($mysqli,'language_column');
   
  var escape_data = [];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;

}

exports.getAllLangs  = function(req,mysql,q)
{

  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_languages');
  var escape_data = [];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  return defered.promise;

}

exports.getAllGroups  = function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_groups');
  var escape_data = [];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  return defered.promise;

}
exports.add_phrase = function(req,mysql,q)
{
  $mysqli =  {};
  $mysqli =  {clname: req.body.sellang};
  strQuery = mysqli.mysqli($mysqli,'new_phrase');
  var escape_data = [req.body.selgroup,req.body.temp_var,req.body.phrase];
  console.log(escape_data);
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

  query.on('error',function(e){
    console.log(e.stack);
  })
 
  return defered.promise;

}

exports.check_phrase = function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'check_phrase');
  var escape_data = [req.body.temp_var,req.body.selgroup];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
   
  return defered.promise;

}
exports.check_language= function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'check_language');
  var escape_data = [req.body.lang_name];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;

}

exports.check_group= function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'check_group');
  var escape_data = [req.body.group_name];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;

}
exports.updatephrase = function(req,mysql,q)
{
  $mysqli =  {};
  $mysqli =  {clname: req.body.sellang};
  strQuery = mysqli.mysqli($mysqli,'updatephrase');
  var escape_data = [req.body.phrase,req.body.temp_var];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  query.on('error',function(e){
    console.log(e.stack);
  })
  
  return defered.promise;

}
exports.language_phrases_admin = function(req,mysql,q)
{
  $mysqli =  {};
  strQuery = mysqli.mysqli($mysqli,'get_admin_phrase');
  var escape_data = [];
  var defered = q.defer();
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  
  return defered.promise;

}

exports.deactivealllanguage = function(req,mysql,q){

  $mysqli = {};
  var defered = q.defer();
  $mysqli =  {};
  var escape_data = [];
  strQuery = mysqli.mysqli($mysqli,'deactivate_langs');
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;

}
exports.activate_languages = function(req,mysql,q){

  $mysqli = {};
  var defered = q.defer();
  $mysqli =  {};
  var escape_data = [req.body.active_lang];
  strQuery = mysqli.mysqli($mysqli,'activate_langs');
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;

}
exports.getAllPhrases = function(req,mysql,q){

  $mysqli = {};
  var defered = q.defer();
  $mysqli =  {};
  var escape_data = [];
  strQuery = mysqli.mysqli($mysqli,'get_phrases');
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;

}
exports.getrelatedPhrase = function(req,mysql,q){
  $mysqli = {};
  $mysqli =  {clname: req.body.langid};
  var defered = q.defer();
  var escape_data = [req.body.phraseid];
  strQuery = mysqli.mysqli($mysqli,'get_related_phrase');
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;

}
exports.updatesinglePhrase = function(req,mysql,q){
  
  $mysqli = {};
  $mysqli =  {clname: req.body.lang_list};
  var defered = q.defer();
  var escape_data = [req.body.phrase_value,req.body.phrase_list];
  strQuery = mysqli.mysqli($mysqli,'update_single_phrase');
  query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
  console.log(query.sql);
  return defered.promise;

}