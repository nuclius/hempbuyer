var  util    = require('util');
var mysqli    = require('./mysqli');
var q = require('q');
var products = require('./products');
var common = require('./common');
var url = require('url');
var dateFormat = require('dateformat');
exports.stores_detatils = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'storeDetails');
     var defered = q.defer();
     var escape_data = [req.body.project_id];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log('query', query.sql);
     return defered.promise;
}
exports.storeDetail = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_14');
     var defered = q.defer();
     var escape_data = [req.body.id];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log("store details "+query.sql);
     query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
     return defered.promise;
}
exports.getstoreid = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'getstoreid');
     var defered = q.defer();
      if(typeof(req.session.userid) === 'undefined')
        {
            var uid = 0;
           } 
           else{
            var uid =req.session.userid;
           }
     var escape_data = [uid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

     return defered.promise;
}
exports.viewUserStores  = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_13');
     var defered = q.defer();
     var escape_data = [req.session.userid];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log(query.sql)
     query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
     return defered.promise;
}
exports.getStoreReviews = function(req,mysql,q, cnt)
{
    
     
     var limit = 10
     var page = (req.body.page - 1) * 10;
    
     var mysql2 = require('./mysqli');

     if(cnt == 1){
         $mysqli = {};
        strQuery = mysql2.mysqli($mysqli,'get_store_reviews_cnt');
     } else {
                $mysqli = {limit : ' limit '+page+', '+limit};
        strQuery = mysql2.mysqli($mysqli,'get_store_reviews');   

     }
     
     var defered = q.defer();
     var escape_data = [req.body.id, req.session.userid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log(query.sql)
     query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
     return defered.promise;
}
exports.getSellerReviews = function(req,mysql,q, cnt)
{
    var limit = 10
    var page = (req.body.page - 1) * 10;
    var mysql2 = require('./mysqli');
    if(cnt == 1){
        $mysqli = {};
        strQuery = mysql2.mysqli($mysqli,'getSellerReviews_cnt');
    } else {
        $mysqli = {limit : ' limit '+page+', '+limit};
        strQuery = mysql2.mysqli($mysqli,'getSellerReviews');   
    }
    var defered = q.defer();
    var escape_data = [req.body.userid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getBuyerReviews = function(req,mysql,q, cnt)
{
    var limit = 10
    var page = (req.body.page - 1) * 10;
    var mysql2 = require('./mysqli');
    if(cnt == 1){
        $mysqli = {};
        strQuery = mysql2.mysqli($mysqli,'getBuyerReviews_cnt');
    } else {
        $mysqli = {limit : ' limit '+page+', '+limit};
        strQuery = mysql2.mysqli($mysqli,'getBuyerReviews');   
    }
    var defered = q.defer();
    var escape_data = [req.body.userid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql)
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getOverallSellerRatings = function(req,mysql,q)
{
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli,'getOverallSellerRatings');   

    var defered = q.defer();
    var escape_data = [req.body.seller_id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('getOverallSellerRatings ', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getOverallBuyerRatings = function(req,mysql,q)
{
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli,'getOverallBuyerRatings');   

    var defered = q.defer();
    var escape_data = [req.body.buyer_id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('getOverallBuyerRatings ', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.create = function(req,mysql,q)
{
    console.log("stores2");
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_1');
    var defered = q.defer();
    datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
	var filename = req.body.store_imaged;
    console.log("stores2");
    if(typeof(req.files.store_image) !== 'undefined' && req.files.store_image.name!=undefined)
    {
        filename = req.files.store_image.name;
    }
    console.log("stores3");
     /* var bannername = '';
    if(typeof(req.files.store_banner_image) !== 'undefined')
     {
          bannername = req.files.store_banner_image.name;
     }*/
	//req.body.date_started = req.body.date_started.replace(new RegExp('/','g'),'-').concat(':00');
    //req.session.userid = 55;
    //var hhhuserid = 55;
    console.log("stores4");
    var escape_data = [
        req.param('sname'),
        req.param('description'),
        req.param('pname'),
        req.param('phone'),
        req.param('address'),
        req.param('city'),
        req.param('state'),
        req.session.state_abbr,
        req.param('zip'),
        req.session.userid,
        'active',
        filename,
        datge,
        req.param('address')
    ];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.deleteStore = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_12');
     var defered = q.defer();
     var escape_data = [req.param('id')];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

     return defered.promise;
}
exports.view = function(req,mysql,q)
{
    var userid = (typeof(req.body.loguid) !== 'undefined') ? Number(req.body.loguid) : 0;
    if(typeof(req.param('sid')) == 'undefined') {
        var id = req.param('id');
    } else {
        var id = req.param('sid');
    }
    if(userid <= 0) {
        id = id.split(',');
        $mysqli = {where:' s.id IN ('+id+') '};
    } else {
        $mysqli = {where:' s.user_id = '+req.session.userid+''};
    }
    var mysql2  = require('./mysqli');
    strQuery    = mysql2.mysqli($mysqli,'stores_2');
    var defered = q.defer();
    datge       = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data = [];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
         query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.updatestoreviewc = function(req,mysql,q)
{
    var userid = (typeof(req.body.loguid) !== 'undefined') ? Number(req.body.loguid) : 0;
    if(typeof(req.param('sid')) == 'undefined') {
        var id = req.param('id');
    } else {
        var id = req.param('sid');
    }
    if(userid <= 0) {
        id = id.split(',');
        $mysqli = {where:' id IN ('+id+') '};
    } else {
        $mysqli = {where:' user_id = '+req.session.userid+''};
    }
    var mysql2  = require('./mysqli');
    strQuery    = mysql2.mysqli($mysqli,'updatestoreviewc');
    var defered = q.defer();
    datge       = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data = [id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.viewAllStores= function(req,mysql,q,cnt)
{
	 var where = '';
     var whr = '';
    
    if (((typeof(req.body.country) !== 'undefined') && (req.body.country !== '')) && ((typeof(req.body.state) !== 'undefined')) && (req.body.state !== '')) {
        whr = whr + ' and user_id in (select user_id from user_extras where state = "'+req.body.state+'")  ';
    }else if ((typeof(req.body.country) !== 'undefined') && (req.body.country !== '')) {
        whr = whr + ' and user_id in (select user_id from user_extras where country = "'+req.body.county+'")  ';
    }
	 if((typeof(req.body.title) !== 'undefined') && (req.body.title !== ''))
	 {
		 where += ' AND s.name LIKE "%'+req.param('title')+'%"';
	 }
	  if((typeof(req.body.location) !== 'undefined') && (req.body.location !== ''))
	 {
		 where += ' AND s.address LIKE "%'+req.param('location')+'%"';
	 }
	  if((typeof(req.body.status) !== 'undefined') && (req.body.status !== ''))
	 {
		 where += ' AND s.status = "'+req.param('status')+'"';
	 }

     if((typeof(req.body.db_virtualmall) !== 'undefined') && (req.body.db_virtualmall == true)){
        where = ' AND s.user_id in (select user_id from user_extras where state = "'+req.session.state+'" or business_type = "supplier")';  
     }


	 $mysqli = {where:where, whr:whr};

     var mysql2 = require('./mysqli');
      var defered = q.defer();
     if(cnt == 1)
    {
        strQuery = mysql2.mysqli($mysqli,'stores_10');
        var escape_data =  [req.session.userid];
    }
    else
    {
        strQuery = mysql2.mysqli($mysqli,'stores_16');
        page = (req.body.page - 1) * 10;
        var escape_data =  [req.session.userid, page];
    }
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log('query viewAllStores ', query.sql);
     query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
     return defered.promise;
}
exports.addStoreProducts = function(req,mysql,q)
{
	 $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_8');
     var defered = q.defer();
     var escape_data = [req.param('id'),req.param('sid'),datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss")];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log(query.sql);
     query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
     return defered.promise;
}
exports.removeProducts = function(req,mysql,q)
{
	 $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_15');
     var defered = q.defer();
     var escape_data = [req.param('id'),req.param('sid')];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

     return defered.promise;
}
exports.updateStoresAdmin = function(req,mysql,q)
{
	 $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_11');
     var defered = q.defer();
	 var filename = req.body.store_image2;
     console.log('image', req.body.store_image);
	 if(typeof(req.files.store_image) !== 'undefined')
	 {
		filename = req.files.store_image.name;
	 }
     var escape_data = [req.body.name,req.body.pname,req.body.phone,req.body.address,req.body.city,req.body.state,req.body.zip,req.body.description,filename,req.body.sid];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log('query', query.sql);
     return defered.promise;
}
exports.updateStores = function(req,mysql,q)
{
	 $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_9');
     var defered = q.defer();
	 var filename = req.body.logo;
	 if(typeof(req.files.store_image) !== 'undefined')
	 {
		filename = req.files.store_image.name;
	 }
      var bannername = req.body.banner;;
     if(typeof(req.files.store_banner_image) !== 'undefined')
     {
          bannername = req.files.store_banner_image.name;
     }
	 req.body.date_started = req.body.date_started.replace(new RegExp('/','g'),'-').concat(':00');
     var escape_data = [req.param('name'),req.param('location'),req.param('description'),req.param('website'),filename,req.param('date_started'),bannername,req.param('sid'),req.session.userid];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

     return defered.promise;
}
exports.notStoreProducts = function(req,mysql,q,storeid)
{
    var txt     = (typeof(req.param('txt')) == 'undefined') ? '' : req.param('txt');
    var cids    = (typeof(req.param('cids')) == 'undefined') ? 0 : req.param('cids');

    $mysqli = {where:' AND p2.title LIKE "%'+txt+'%" ', storeid:' IN('+storeid+') '};
    if(cids != 0) {
        $mysqli = {where:' AND p2.title LIKE "%'+txt+'%" AND p2.parent_category_id IN ('+cids+') ', storeid:' IN('+storeid+') '};
    }
    var mysql2 = require('./mysqli');
    strQuery = mysql2.mysqli($mysqli,'stores_6');
    var defered = q.defer();
    var escape_data = [req.session.userid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}
exports.viewStoreProducts = function(req,mysql,q,id)
{
	 var where = '';
	 if(typeof(req.param('cid')) !== 'undefined'  && req.param('cid') != ''  && req.param('cid') > 0)
	 {
		 where += ' and  market_status = "open" and p2.category_id IN (SELECT cc.id FROM categories AS cc INNER JOIN categories AS pc WHERE cc.lft BETWEEN pc.lft AND pc.rgt AND pc.id = '+req.param('cid')+' GROUP BY cc.id )';
	 }
	 if(typeof(req.param('search')) !== 'undefined' && req.param('search') != '')
	 {
		  where += ' and  (p2.title like "%'+req.param('search')+'%" or p2.description like "%'+req.param('search')+'%")';
	 }

      if(id == 1)
      {
           req.body.page = (typeof(req.param('page')) === 'undefined') ? 1 : req.param('page');
           limit = 15;
           where += ' limit '+(req.body.page-1)*limit+','+limit;
      }
     $mysqli = {where:where};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_3');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.param('id')];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
         console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });

     return defered.promise;
}
exports.viewStoreProductsnew = function(mysql,q,req,id)
{
    console.log("tttttt");
    console.log(req.param('cid'));
    console.log(req.param('id'));
     var where = '';
     if(typeof(req.param('cid')) !== 'undefined'  && req.param('cid') != ''  && req.param('cid') > 0)
     {
         where += ' and  market_status = "open" and  p2.category_id IN (SELECT cc.id FROM categories AS cc INNER JOIN categories AS pc WHERE cc.lft BETWEEN pc.lft AND pc.rgt AND pc.id = '+req.param('cid')+' GROUP BY cc.id )';
     }
     if(typeof(req.param('cid')) !== 'undefined'  && req.param('cid') != ''  && req.param('cid') == 0)
     {
         where += ' and  market_status = "open" and  p2.category_id IN (SELECT cc.id FROM categories AS cc INNER JOIN categories AS pc WHERE cc.lft BETWEEN pc.lft AND pc.rgt  GROUP BY cc.id )';
     }
     if(typeof(req.param('search')) !== 'undefined' && req.param('search') != '')
     {
          where += ' and  market_status = "open" and  (p2.title like "%'+req.param('search')+'%" or p2.description like "%'+req.param('search')+'%")';
     }
     if(typeof(req.param('buynow')) !== 'undefined' && req.param('buynow') == 1 && req.param('nego') == 0)
     {
          where += ' and  market_status = "open" and  p2.buynow = 1 ';
     }
     if(typeof(req.param('nego')) !== 'undefined' && req.param('nego') == 2 && req.param('buynow') == 0)
     {
        console.log('nego11111------------');
          where += ' and  market_status = "open" and  p2.buynow = 0 ';
     }
      where += 'order by p2.id DESC';
      if(id == 1)
      {
           req.body.page = (typeof(req.param('page')) === 'undefined') ? 1 : req.param('page');
           limit = 12;
           where += ' limit '+(req.body.page-1)*limit+','+limit;
      }
     $mysqli = {where:where};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_strpdt');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.session.userid,req.param('id'),req.param('id')];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log('query.sql');
     console.log(query.sql);
     return defered.promise;
}
exports.viewStoreFeaturedProducts = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_5');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.param('id')];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });

     return defered.promise;
}
exports.viewStoreCategories = function(req,mysql,q)
{
	 $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'stores_4');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.param('id')];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });

     return defered.promise;
}
exports.updateStoresname = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'updateStoresname');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.storname,req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     return defered.promise;
}
exports.updateStoresdesc = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'updateStoresdesc');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.storedesc,req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     return defered.promise;
}
exports.updateStoreslogo = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'updateStoreslogo');
     var defered = q.defer();

     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.files.store_image.name,req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     return defered.promise;
}

exports.updateStoressocial = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');

    $mysqli = {where:req.body.urlname};
     strQuery = mysql2.mysqli($mysqli,'updateStoressocial');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.socialname,req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     return defered.promise;
}
exports.updateStoressocialrem = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');

    $mysqli = {where:req.body.urlname};
     strQuery = mysql2.mysqli($mysqli,'updateStoressocialrem');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
     return defered.promise;
}

exports.updateStoresbanner = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'updateStoresbanner');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.files.store_banner_image.name,req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
     return defered.promise;
}
exports.updateStoresbannerrem = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');

    $mysqli = {};
     strQuery = mysql2.mysqli($mysqli,'updateStoresbannerrem');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
     return defered.promise;
}
exports.updateStoresbannerpos = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');

    $mysqli = {};
     strQuery = mysql2.mysqli($mysqli,'updateStoresbannerpos');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.left,req.body.top,req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
     return defered.promise;
}
exports.updateStoreshomepage = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');

    $mysqli = {};
     strQuery = mysql2.mysqli($mysqli,'updateStoreshomepage');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.homename,req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
     return defered.promise;
}
exports.updateStoresaboutus = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');

    $mysqli = {};
     strQuery = mysql2.mysqli($mysqli,'updateStoresaboutus');
     var defered = q.defer();
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.aboutus,req.body.storeid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
     return defered.promise;
}

exports.addStorepdts = function(req, mysql,q,pdtid){

    $mysqli = {};
    var mysqli = require('./mysqli');
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'addstorepdt');
    escape_fields = [req.body.storeid,pdtid];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.checkproduct = function(req, mysql,q,pdtid){

    $mysqli     = {};
    var mysqli  = require('./mysqli');
    var defered = q.defer();
    strQuery    = mysqli.mysqli($mysqli, 'checkproduct');
    escape_fields = [pdtid];
    query       = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.addstorepdtnew = function(req,mysql,q,pdtid)
{
    var mysql2  = require('./mysqli');
    $mysqli     = {};
    strQuery    = mysql2.mysqli($mysqli,'addstorepdtnew');
    var defered = q.defer();
    var escape_data = [pdtid,req.body.storeid,datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss")];
    query       =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());

    $mysqli2     = {};
    strQuery2    = mysql2.mysqli($mysqli2,'updatestoreproject');
    var datge    = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
        datge1   = datge.split('-');
        datge2   = Number(datge1[0])+10;
        datge    = datge.replace(Number(datge1[0]),datge2);
    escape_data2 = [datge, pdtid];
    query2       =  mysql.query(strQuery2, escape_data2, defered.makeNodeResolver());
    return defered.promise;
}

exports.csvInvoicesRep = function (req, mysql, q) {

    $mysqli = {};
    var mysql2 = require('./mysqli');
    var defered = q.defer();
    $mysqli = {};
    console.log(checks);

    var limit = '';
    if (req.body.limit_results != '') {
        limit += 'limit 0,' + req.body.limit_results;
    }
    else {
        limit += '';
    }
    var order = "order by i.id " + req.body.orderradio;

    var gettype =(typeof(req.body.gettype) !== 'undefined') ? req.body.gettype : '';
    storeid = (typeof(req.body.storeid) != 'undefined') ? req.body.storeid : 0;
    storeid = storeid.split(',');

    if(gettype == 'income') {
        feilds = 'SUM(b.amount) as totalamount';
    } else {
        feilds = 'b.*,s.*,p.title';
    }


    $mysqli = {limit: limit, order: order,storeid:storeid,feilds:feilds};
    if (req.body.method == 'fixed') {

        var checks = req.body.rangepast;
        console.log(checks);
        if (req.body.within == 'day') {
            strQuery = mysql2.mysqli($mysqli, 'storeday');
        }

        else if (req.body.within == 'week') {
            strQuery = mysql2.mysqli($mysqli, 'storeweek');
        }

        else if (req.body.within == 'month') {
            strQuery = mysql2.mysqli($mysqli, 'storemonth');
        }

        else {
            strQuery = mysql2.mysqli($mysqli, 'storeall');
        }

        var escape_data = [];
    }

    else {

        var from_date = req.body.from_date;
        var to_date = req.body.to_date;
        var from_date1 = dateFormat(from_date,"yyyy-mm-dd");
        var to_date1 = dateFormat(to_date,"yyyy-mm-dd");
        var escape_data = [from_date1, to_date1];
        strQuery = mysql2.mysqli($mysqli, 'storefromto');


    }


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}

exports.updateCatgeoryInStore = function (req, mysql, q) {
    var mysqli  = require('./mysqli');
    $mysqli     = {};
    var defered = q.defer();

    var cat_ids = (typeof(req.body.default_ids) != 'undefined') ? req.body.default_ids : 0;
    var id      = (typeof(req.body.id) != 'undefined') ? req.body.id : 0;
    strQuery = mysqli.mysqli($mysqli, 'updateCatInStore');
    escape_fields = [cat_ids, id];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.updateFeatureProject = function (req, mysql, q) {
    var project_id = (typeof(req.body.ids) == 'undefined') ? 0 : req.body.ids;
    var featured   = (typeof(req.body.featured) == 'undefined') ? 0 : req.body.featured;

    var mysqli  = require('./mysqli');
    var defered = q.defer();
    var where = '';
    if(Number(featured) == 1) {
        where = 'feature = "1" WHERE id in('+project_id+')';
    } else if(Number(featured) == 2) {
        where = 'feature = "0" WHERE id in('+project_id+')';
    }
    $mysqli = {where : where};

    strQuery = mysqli.mysqli($mysqli, 'updateFeatureProject');
    escape_fields = [];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.updateUnstockProject = function (req, mysql, q) {
    var project_ids = (typeof(req.body.ids) == 'undefined') ? 0 : req.body.ids;
    var store_id    = (typeof(req.body.sid) == 'undefined') ? 0 : req.body.sid;
    var mysqli  = require('./mysqli');
    var defered = q.defer();
    $mysqli     = {where : 'WHERE project_id in('+project_ids+') AND store_id = '+store_id+''};
    strQuery    = mysqli.mysqli($mysqli, 'updateUnstockProject');
    escape_fields = [];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.selectProductOrder = function (req, mysql, q) {
    var store_id    = (typeof(req.body.sid) == 'undefined') ? 0 : req.body.sid;
    var category_id = (typeof(req.body.cid) == 'undefined') ? 0 : req.body.cid;
    var mysqli  = require('./mysqli');
    var defered = q.defer();
    $mysqli     = {};
    strQuery    = mysqli.mysqli($mysqli, 'selectProductOrder');
    escape_fields = [store_id, category_id];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;

}
exports.selectStoreProductOrder = function (req, mysql, q) {
    var store_id    = (typeof(req.param('id')) == 'undefined') ? 0 : req.param('id');
    var mysqli  = require('./mysqli');
    var defered = q.defer();
    $mysqli     = {};
    strQuery    = mysqli.mysqli($mysqli, 'selectStoreProductOrder');
    escape_fields = [store_id];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
        console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });

    return defered.promise;
}

exports.updateProductOrder = function (req, mysql, q, type) {
    var project_ids = (typeof(req.body.ids) == 'undefined') ? 0 : req.body.ids;
    var store_id    = (typeof(req.body.sid) == 'undefined') ? 0 : req.body.sid;
    var category_id = (typeof(req.body.cid) == 'undefined') ? 0 : req.body.cid;
    var mysqli  = require('./mysqli');
    var defered = q.defer();
    $mysqli     = {};
    if(type == 1) {
        strQuery    = mysqli.mysqli($mysqli, 'updateProductOrder');
    } else if(type == 2){
        strQuery    = mysqli.mysqli($mysqli, 'insertProductOrder');
    }
    escape_fields = [project_ids, store_id, category_id];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.getAllStores= function(req,mysql,q,count){
    var mysqli   = require('./mysqli');
    var defered  = q.defer();
    var userid   = Number(req.body.loguserid);
    var where = '';
    if(userid > 0) {
        where += ' WHERE s.user_id='+userid+' ';
    }
    var page     = req.body.page;
    var perlimit = 12;
        page     = (page > 0) ? (page - 1) * perlimit : 0;
    if(count == 0) {
        var limit = ' ORDER BY id DESC, adstore DESC limit ' + page + ',' + perlimit;
    } else {
        limit = " ORDER BY id DESC, adstore DESC";
    }
    limit = where+limit;

    $mysqli = {limit: limit};
    strQuery    = mysqli.mysqli($mysqli, 'getallstores');
    escape_fields = [];
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.getStorePlanlist = function(req,mysql,q){
    var plan_id   = (typeof(req.body.plan_val) == 'undefined') ? 0 : req.body.plan_val;
    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    var where     = ' WHERE 1=1 ';

    if(plan_id == 0) {
        $mysqli       = {where: where, fields:' * '};
    } else {
        $mysqli       = {where: where+' AND id = '+plan_id+'', fields:' * '};
    }

    strQuery      = mysqli.mysqli($mysqli, 'getStorePlanlist');
    escape_fields = [];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.saveStorePlan = function(req,mysql,q){
    var amount            = (typeof(req.body.amount) == 'undefined') ? 0 : Number(req.body.amount);
    var storeid           = (typeof(req.body.storeid) == 'undefined') ? 0 : Number(req.body.storeid);
    var plan_id           = (typeof(req.body.plan_val) == 'undefined') ? 0 : Number(req.body.plan_val);

    var sub_id            = (typeof(req.body.sub_id) == 'undefined') ? '' : req.body.sub_id;
    var nextBillingDate   = (typeof(req.body.nextBillingDate) == 'undefined') ? '' : req.body.nextBillingDate;
    var trans_id          = (typeof(req.body.transaction_id) == 'undefined') ? '' : req.body.transaction_id;
    var status            = (typeof(req.body.paystatus) == 'undefined') ? '' : req.body.paystatus;

    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    $mysqli       = {};
    strQuery      = mysqli.mysqli($mysqli, 'saveStorePlan');
    escape_fields = [storeid,req.session.userid,plan_id,amount,status,sub_id,nextBillingDate,trans_id];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    console.log('------------------------------------------------------2');
    return defered.promise;
}
exports.updateStorePlan = function(req,mysql,q){
    var sub_id            = (typeof(req.body.sub_id) == 'undefined') ? '' : req.body.sub_id;
    var nextBillingDate   = (typeof(req.body.nextBillingDate) == 'undefined') ? '' : req.body.nextBillingDate;
    var trans_id          = (typeof(req.body.transaction_id) == 'undefined') ? '' : req.body.transaction_id;
    var status            = (typeof(req.body.paystatus) == 'undefined') ? '' : req.body.paystatus;

    var updatecolumn = " status = '"+status+"', next_billing_date = '"+nextBillingDate+"', transaction_id = '"+trans_id+"' ";
    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    $mysqli       = {updatecolumn: updatecolumn};
    strQuery      = mysqli.mysqli($mysqli, 'updateStorePlan');
    escape_fields = [sub_id];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    console.log('------------------------------------------------------1');
    return defered.promise;
}
exports.deleteStoreMultiple = function(req,mysql,q){
     $mysqli = {};
    var tempid = [];
    tempid = req.body.ids;
    strQuery = mysqli.mysqli($mysqli, 'deleteStoreMultiple');
    var defered = q.defer();
    escape_data = [tempid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;
}
exports.deleteStorePlan = function(req,mysql,q){
    var plan_id   = (typeof(req.body.plan_id) == 'undefined') ? 0 : Number(req.body.plan_id);
    
    var defered   = q.defer();
    $mysqli       = {};
    strQuery      = mysqli.mysqli($mysqli, 'deleteStorePlan');
    escape_fields = [plan_id];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.getStorePlan = function(req,mysql,q){
    var sub_id   = (typeof(req.body.sub_id) == 'undefined') ? 0 : req.body.sub_id;
    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    $mysqli       = {};
    strQuery      = mysqli.mysqli($mysqli, 'getStorePlan');
    escape_fields = [sub_id];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    console.log('------------------------------------------------------2');
    return defered.promise;
}
exports.getSubscriptionCount = function(req,mysql,q){
    var storeid   = (typeof(req.body.sid) == 'undefined') ? 0 : Number(req.body.sid);
    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    $mysqli       = {};
    strQuery      = mysqli.mysqli($mysqli, 'getSubscriptionCount');
    escape_fields = [storeid];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    console.log('---------------------------------------------0-1');
    return defered.promise;
}
exports.storeCategoryDetails = function(req,mysql,q){
    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    $mysqli       = {};
    strQuery      = mysqli.mysqli($mysqli, 'storeCategoryDetails');
    escape_fields = [];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.storeDashboardFilter = function(req,mysql,q,count) {
    var searchtype = (typeof(req.body.searchtype) != 'undefined') ? req.body.searchtype : 'store';
    if(searchtype == 'store') {
        var where = '1=1';
    } else {
        var where = " p.market_status = 'open' ";
    }
    var userid   = Number(req.body.loguserid);
    if(userid > 0) {
        where += ' AND s.user_id='+userid+' ';
    }

    var tagstitle = req.body.tagstitle;
        tagstitle = tagstitle.split('|');
    var category = req.body.category;
        category = category.split('|');
    var location = req.body.location;
        location = location.split('|');
    if(tagstitle.length > 0) {
        var tempwhere = '';
        where += ' AND (';
        for(var i = 0; i < tagstitle.length; i++) {
            if (tagstitle[i] != '') {
                tempwhere += (i > 0) ? ' OR ' : '';
                if (searchtype == 'store') {
                    tempwhere += ' s.aboutus LIKE "%'+tagstitle[i]+'%" OR s.name LIKE "%'+tagstitle[i]+'%" ';
                } else {
                    tempwhere += ' p.tags LIKE "%'+tagstitle[i]+'%" OR p.title LIKE "%'+tagstitle[i]+'%" ';
                }
            }
        }
        where += (tempwhere != '') ? tempwhere : '1=1';
        where += ') ';
    }
    if(category.length > 0) {
        var tempwhere = '';
        where += ' AND (';
        for(var i = 0; i < category.length; i++) {
            if (category[i] != '') {
                tempwhere += (i > 0) ? ' OR ' : '';
                if (searchtype == 'store') {
                    tempwhere += ' FIND_IN_SET('+category[i]+',s.selected_category)';
                } else {
                    tempwhere += ' FIND_IN_SET('+category[i]+',p.parent_category_id)';
                }
            }
        }
        where += (tempwhere != '') ? tempwhere : '1=1';
        where += ') ';
    }
    if(location.length > 0) {
        var tempwhere = '';
        where += ' AND (';
        for(var i = 0; i < location.length; i++) {
            if (location[i] != '') {
                tempwhere += (i > 0) ? ' OR ' : '';
                if (searchtype == 'store') {
                    tempwhere += ' u.country LIKE "%'+location[i]+'%"';
                } else {
                    tempwhere += ' p.country LIKE "%'+location[i]+'%"';
                }
            }
        }
        where += (tempwhere != '') ? tempwhere : '1=1';
        where += ') ';
    }

    var page     = req.body.page;
    var perlimit = 12;
        page     = (page > 0) ? (page - 1) * perlimit : 0;
    if(count == 0) {
        var limit = '  ORDER BY id DESC, adstore DESC limit ' + page + ',' + perlimit;
    } else {
        limit = "  ORDER BY id DESC, adstore DESC";
    }
    where = where+limit;
    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    $mysqli       = {where : where};
    strQuery      = mysqli.mysqli($mysqli, 'storedashboardfilter');
    escape_fields = [];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
// exports.selectAdStores = function (req, mysql, q) {
//     var mysqli    = require('./mysqli');
//     var defered   = q.defer();
//     $mysqli       = {};
//     strQuery      = mysqli.mysqli($mysqli, 'selectAdStores');
//     escape_fields = [];
//     query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
//     console.log(query);
//     console.log('-----------------------------1111');
//     return defered.promise;
// }
exports.selectAdStores = function (req, mysql, q) {
    var mysql2  = require('./mysqli');
    var defered = q.defer();

    var limit = '';
    if(req.body.limit_results != '') {
        limit += 'limit 0,' + req.body.limit_results;
    } else {
        limit += '';
    }

    var gettype =(typeof(req.body.gettype) !== 'undefined') ? req.body.gettype : '';
    storeid = (typeof(req.body.storeid) != 'undefined') ? req.body.storeid : 0;
    storeid = storeid.split(',');

    var where = '1=1';
    if (req.body.method == 'fixed') {
        if(req.body.within == 'day') {
            where = 'DATE(sp.date) = DATE(DATE_SUB(SYSDATE(), INTERVAL 1 DAY))';
        } else if (req.body.within == 'week') {
            where = 'DATE(sp.date) BETWEEN DATE(DATE_SUB(SYSDATE(), INTERVAL 1 WEEK)) AND DATE(SYSDATE())';
        } else if (req.body.within == 'month') {
            where  = 'DATE(sp.date) BETWEEN DATE(DATE_SUB(SYSDATE(), INTERVAL 1 MONTH)) AND DATE(SYSDATE())';
        } else {
            where = 'DATE(sp.date) BETWEEN DATE(DATE_SUB(SYSDATE(), INTERVAL 1 YEAR)) AND DATE(SYSDATE())';
        }
    } else {
        var from_date = req.body.from_date;
        var to_date = req.body.to_date;
        var from_date1 = dateFormat(from_date,"yyyy-mm-dd");
        var to_date1 = dateFormat(to_date,"yyyy-mm-dd");
        where  = 'DATE(sp.date) BETWEEN DATE('+from_date1+') AND DATE('+to_date1+')';
    }
    if(gettype == 'income') {
        feilds = 'sum(sp.amount) as totalamount';
    } else {
        feilds = 'sp.*,s.name';
    }
    $mysqli = {limit: limit, storeid:storeid, where:where,feilds:feilds};

    strQuery = mysql2.mysqli($mysqli, 'selectplantransaction');
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('------');
    console.log(query.sql);
    return defered.promise;

}
exports.selectStorePlan = function (req, mysql, q) {
    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    storeid       = (typeof(req.body.storeid) != 'undefined') ? req.body.storeid : 0;
    storeid       = storeid.split(',');
    $mysqli       = {storeid: storeid};
    strQuery      = mysqli.mysqli($mysqli, 'selectstoreplan');
    escape_fields = [req.session.userid];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}

exports.updateStoreStatus = function (req, mysql, q) {
    var id = (typeof(req.param('id')) != 'undefined') ? req.param('id') : 0;
    var status = (typeof(req.param('status')) != 'undefined') ? req.param('status') : '';

    var mysqli    = require('./mysqli');
    var defered   = q.defer();
    $mysqli       = {};
    strQuery      = mysqli.mysqli($mysqli, 'updatestorestatus');
    escape_fields = [status, id];
    query         = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    return defered.promise;
}
exports.storePaid = function (req, mysql, q) {
    var mysql2  = require('./mysqli');
    var defered = q.defer();
    $mysqli     = {};
    storeid     = (typeof(req.body.storeid) != 'undefined') ? req.body.storeid : 0;
    storeid     = storeid.split(',');
    strQuery    = mysql2.mysqli($mysqli, 'storePaid');
    query       = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(query.sql);
    return defered.promise;

}

exports.productDetail = function(req, mysql, q) {
var mysql2 = require('./mysqli');
    console.log(req.param('id'));

    $mysqli = {};
    var defered = q.defer();

    strQuery = mysql2.mysqli($mysqli, 'ads_product_details');
    escape_fields = [req.param('id')]
        //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getstoreidlogin = function(req,mysql,q,id)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'getstoreid');
     var defered = q.defer();
     
     var escape_data = [id];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log(query.sql);
     return defered.promise;
}
exports.storeupdate = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'storeupdate');
     var defered = q.defer();
     var filename = req.body.store_imaged;
     if(typeof(req.files.store_image) !== 'undefined' && req.files.store_image.name!=undefined)
     {
        filename = req.files.store_image.name;
     }
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     //req.body.date_started = req.body.date_started.replace(new RegExp('/','g'),'-').concat(':00');
     var escape_data = [req.body.sname,req.body.description,filename,req.body.pname,req.body.phone,req.body.street,req.body.city,req.body.state,req.body.zip,req.body.address,datge,req.body.storeid];
     console.log(escape_data);
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log(query.sql);
     return defered.promise;
}
exports.insertStoreImage = function(req,mysql,q, file)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'insertStoreImage');
     var defered = q.defer();
     var file = file.name;
     
     datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
     var escape_data = [req.body.store_id, file, datge];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log('insertStoreImage === ', query.sql);
     return defered.promise;
}
exports.storedeletepdt = function(req,mysql,q)
{
     $mysqli = {};
     var mysql2 = require('./mysqli');
     strQuery = mysql2.mysqli($mysqli,'storedeletepdt');
     var defered = q.defer();
     
     var escape_data = [req.body.pid];
     query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
     console.log(query.sql);
     return defered.promise;
}


exports.getSalesReport = function(req, mysql, q, count) {

    // console.log(req.param('id'));Price BETWEEN 10 AND 20;
    var whr = '';
    var where = '';
    if (req.body.sdate !='' || req.body.edate !='') {
        where += 'and (i.paid_date >= "'+dateFormat(req.body.sdate,"yyyy-mm-dd HH:MM:ss")+'" and i.paid_date <= "'+dateFormat(req.body.edate,"yyyy-mm-dd HH:MM:ss")+'")';
    }
    if (req.body.categoryId != 0) {
        where += 'and p.parent_category_id = '+req.body.categoryId+'';
    }
    $mysqli = {where:where, whr:whr};
    var mysqls = require('./mysqli');
    var defered = q.defer();
    if(count == 0){
        var page = (req.body.page - 1) * req.body.limit;
        strQuery = mysqls.mysqli($mysqli, 'get_sales_report');
        escape_fields = [req.session.userid, page, req.body.limit];
    } else if (count == 1){
        strQuery = mysqls.mysqli($mysqli, 'get_sales_reportc');
        escape_fields = [req.session.userid];
    }  else if (count == 2){
        strQuery = mysqls.mysqli($mysqli, 'get_sales_reportcd');
        escape_fields = [req.session.userid,req.session.userid];
    }
    // strQuery = mysqli.mysqli($mysqli, 'get_research_report');
    
    //console.log(escape_fields);
    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log("getSalesReport "+query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
    
}
exports.getAllStoresByUsers= function(req,mysql,q,cnt)
{
	 var where = '';
     var whr = '';
    
    if((typeof(req.body.db_virtualmall) !== 'undefined') && (req.body.db_virtualmall == true)) {
        where = ' AND s.user_id in (select user_id from user_extras where state = "'+req.body.state+'" or business_type = "supplier")';  
    }

    $mysqli = {where:where, whr:whr};
    var mysql2 = require('./mysqli');
    var defered = q.defer();
    if(cnt == 1) {
        strQuery = mysql2.mysqli($mysqli,'stores_10');
        var escape_data =  [req.body.user_id];
    } else {
        strQuery = mysql2.mysqli($mysqli,'stores_16');
        page = (req.body.page - 1) * 10;
        var escape_data =  [req.body.user_id, page];
    }
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('query viewAllStores ', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getBuyerReviewsDetail = function(req,mysql,q)
{
    var mysql2 = require('./mysqli');
    $mysqli = {};
    strQuery = mysql2.mysqli($mysqli,'getBuyerReviewsDetail');
    
    var defered = q.defer();
    var escape_data = [req.body.rating_id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('getBuyerReviewsDetail', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getSellerReviewsDetail = function(req,mysql,q)
{
    var mysql2 = require('./mysqli');
    $mysqli = {};
    strQuery = mysql2.mysqli($mysqli,'getSellerReviewsDetail');
    
    var defered = q.defer();
    var escape_data = [req.body.rating_id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('getSellerReviewsDetail', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getPendingPayments = function(req,mysql,q, count)
{
    var mysql2 = require('./mysqli');
    if(count == 1) {
        strQuery = mysql2.mysqli($mysqli,'getPendingPayments_count');
    } else {
        strQuery = mysql2.mysqli($mysqli,'getPendingPayments');
    }
    

    var defered = q.defer();
    var escape_data = [req.body.userid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('getPendingPayments ', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getPayPendingDetail = function(req,mysql,q)
{
    var mysql2 = require('./mysqli');
    $mysqli = {};
    strQuery = mysql2.mysqli($mysqli,'getPayPendingDetail');
    
    var defered = q.defer();
    var escape_data = [1, req.body.product_id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('getPayPendingDetail', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.getUserBalance = function(req,mysql,q)
{
    var mysql2 = require('./mysqli');
    $mysqli = {};
    strQuery = mysql2.mysqli($mysqli,'getUserDetailById');
    
    var defered = q.defer();
    var escape_data = [req.body.userid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('getUserBalance', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.decreaseUserBalance = function(req,mysql,q)
{
    var mysql2 = require('./mysqli');
    $mysqli = {};
    strQuery = mysql2.mysqli($mysqli,'decreaseUserBalance');
    
    var defered = q.defer();
    var escape_data = [req.body.decreaseAmount, req.body.userid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log('decreaseUserBalance', query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}