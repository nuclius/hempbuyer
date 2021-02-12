var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var url = require('url');


var _this = this;

exports.apiCheckDealerExisting = function(mysql,req)
{
    $mysqli = {
	   	id	  : req.body.id_user,
	   	email : req.body.email	
    };    
	strQuery = mysqli.mysqli($mysqli,'car_bike_api_check_email_id');    
    var defered = q.defer();
	
	 try {
 query = mysql.query(strQuery, defered.makeNodeResolver());

}
catch (e) {
 			
            date = require('date-utils');
            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
            var identifier = {'Date':datenow}
            identifier.Event = 'Database';
            identifier.Description = 'DB error occured';
            identifier.Error=e.stack;
            common.writelog(identifier);
}
	return defered.promise; 
}

exports.apiDealerInfoUpdate = function(mysql,req,res)
{
	var md5 = require('MD5');
	datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
	var carname_str	  = req.body.name;
    var n = carname_str.indexOf(",");
	
	if(n >= 0) {
		 var name_seperation = carname_str.split(",",2);
		 req.body.first_name = name_seperation[0];
		 req.body.last_name = name_seperation[1];		
	}
	else {
		 req.body.first_name = req.body.name;
		 req.body.last_name  = '';	
	}
	
	if(typeof(req.body.password) !== 'undefined' && req.body.password != '') {
		req.body.password = req.body.password;
	}
	else {
		req.body.password = '123456car';
	}

	status = '';
	if(typeof(req.body.status) !== 'undefined' && req.body.status != '') {
		 status = ' status ="'+req.body.status +'", ';
	}

	var password_salt = '12345';
	var password 	  = md5(md5(req.body.password)+password_salt);
	
    $mysqli = {
		   country 		   : req.body.country,
		   state		   : req.body.state,
		   city 		   : req.body.location,
		   address		   : req.body.address, 
		   dealership_name : req.body.dealership_name,
		   mobile 		   : req.body.mobile,
		   password		   : password,
		   status		   : status,
		   updated_at	   : datge,
		   user_id         :req.body.id_user
    };
    
	strQuery = mysqli.mysqli($mysqli,'car_bike_api_registration_update'); 
	
	var defered = q.defer();
	
	escape_data = [req.body.first_name, req.body.last_name,req.body.id_user,req.body.email];
	//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver()); 
	 try {
 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

}
catch (e) {
 			
           date = require('date-utils');
            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
            var identifier = {'Date':datenow}
            identifier.Event = 'Database';
            identifier.Description = 'DB error occured';
            identifier.Error=e.stack;
            common.writelog(identifier);
}
	//console.log(query.sql)
	return defered.promise;
}

exports.apiDealerRegister = function(mysql,req,res)
{
	datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
	var md5 = require('MD5');
	
	if(typeof(req.body.password) !== 'undefined' && req.body.password != '') {
		req.body.password = req.body.password;
	}
	else {
		req.body.password = '123456car';
	}
	if(typeof(req.body.status) !== 'undefined' && req.body.status != '') {
		req.body.status = req.body.status;
	}
	else {
		req.body.status = 'active';
	}
	var password_salt = '12345';
	var password 	  = md5(md5(req.body.password)+password_salt);
	var carname_str	  = req.body.name;

    var n = carname_str.indexOf(",");
	
	if(n >= 0) {
		 var name_seperation = carname_str.split(",",2);
		 req.body.first_name = name_seperation[0];
		 req.body.last_name = name_seperation[1];		
	}
	else {
		 req.body.first_name = req.body.name;
		 req.body.last_name  = '';	
	}
		
    $mysqli = {
		   email 		   : req.body.email,
		   role  		   : 1,    	       
		   created_at 	   : datge,
		   password_hash   : password,
		   password_salt   : password_salt,
		   country 		   : req.body.country,
		   state		   : req.body.state,
		   city 		   : req.body.location,
		   address		   : req.body.address, 
		   dealership_name : req.body.dealership_name,
		   mobile 		   : req.body.mobile,
		   status 		   : req.body.status 
    };
    
	strQuery = mysqli.mysqli($mysqli,'car_bike_api_registration'); 
	
	var defered = q.defer();
	
	escape_data = [req.body.id_user, req.body.first_name, req.body.last_name];
	//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver()); 
	 try {
 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

}
catch (e) {
 			
             date = require('date-utils');
            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
            var identifier = {'Date':datenow}
            identifier.Event = 'Database';
            identifier.Description = 'DB error occured';
            identifier.Error=e.stack;
            common.writelog(identifier);
}

	return defered.promise;
 }
 
 
exports.apiCheckClasifiedExisting = function(mysql,req)
{
    $mysqli = {
	
	   	id	  : req.body.id
    };    
	strQuery = mysqli.mysqli($mysqli,'car_bike_api_check_classified_id');    
    var defered = q.defer();
	//query =  mysql.query(strQuery,defered.makeNodeResolver());

	 try {
 query = mysql.query(strQuery, defered.makeNodeResolver());

}
catch (e) {
 			
             date = require('date-utils');
            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
            var identifier = {'Date':datenow}
            identifier.Event = 'Database';
            identifier.Description = 'DB error occured';
            identifier.Error=e.stack;
            common.writelog(identifier);
}
	return defered.promise; 
}

exports.apiUpdateClassified = function (req, res, mysql, q) {

	datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
    $mysqli = {};
   
    var defered = q.defer();
	
	strQuery = mysqli.mysqli($mysqli, 'car_bike_api_project_update');	
	var escape_data = [
		req.body.image,
        datge,
        req.body.buynow,
        common.currencyConverter(req.body.sprice),
        common.currencyConverter(req.body.rprice),
        dateFormat(new Date(req.body.date_added), "yyyy-mm-dd HH:MM:ss"),
        dateFormat(new Date(req.body.date_closed), "yyyy-mm-dd HH:MM:ss"),
        common.currencyConverter(req.body.bprice),
        common.currencyConverter(req.body.mprice),
        common.currencyConverter(req.body.iprice),
        common.currencyConverter(req.body.sprice),        
		req.body.auction,
		req.body.bidnow_url ,
		req.body.km_driven,
		req.body.no_of_owner,
		req.body.accident_history,
		req.body.insurance,
	    req.body.year,
		req.body.id_car_variant,
		req.body.id_car_model,
		req.body.id_car_make, 
		req.body.id_city,
		req.body.id_state,
		req.body.shortlink,
		req.body.id
    ];
	
	//query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
	 try {
 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

}
catch (e) {
 			
             date = require('date-utils');
            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
            var identifier = {'Date':datenow}
            identifier.Event = 'Database';
            identifier.Description = 'DB error occured';
            identifier.Error=e.stack;
            common.writelog(identifier);
}
	return defered.promise;
}

exports.apiRevertBidding = function (req, res, mysql, q) {
	$mysqli = {	
	   	id	  : req.body.id
    };    
	var escape_data = [req.body.id];
	strQuery = mysqli.mysqli($mysqli,'car_bike_api_remove_old_bid');    
    var defered = q.defer();
	//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	 try {
 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

}
catch (e) {
 			
             date = require('date-utils');
            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
            var identifier = {'Date':datenow}
            identifier.Event = 'Database';
            identifier.Description = 'DB error occured';
            identifier.Error=e.stack;
            common.writelog(identifier);
}
	return defered.promise;	
}

exports.apiNewClassifiedSave = function (req, res, mysql, q) {
		
	datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_project_posting');	
    var defered = q.defer();
	
	var escape_data = [
		req.body.id,
		req.body.image,
        req.body.userposted,
        datge,
        datge,
        req.body.buynow,
        common.currencyConverter(req.body.sprice),
        common.currencyConverter(req.body.rprice),
        dateFormat(new Date(req.body.date_added), "yyyy-mm-dd HH:MM:ss"),
        dateFormat(new Date(req.body.date_closed), "yyyy-mm-dd HH:MM:ss"),
		req.body.status,
        req.body.cid,
        common.currencyConverter(req.body.bprice),
        common.currencyConverter(req.body.mprice),
        common.currencyConverter(req.body.iprice),
        common.currencyConverter(req.body.sprice),        
		req.body.auction,
		req.body.qty,
	    req.body.save,
		req.body.bidnow_url,
		req.body.km_driven,
		req.body.no_of_owner,
		req.body.accident_history,
		req.body.insurance,
	    req.body.year,
		req.body.id_car_variant,
		req.body.id_car_model,
		req.body.id_car_make, 
		req.body.id_city,
		req.body.id_state,
		req.body.shortlink,
    ];
	
	//query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

	 try {
 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

}
catch (e) {
 			
             date = require('date-utils');
            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
            var identifier = {'Date':datenow}
            identifier.Event = 'Database';
            identifier.Description = 'DB error occured';
            identifier.Error=e.stack;
            common.writelog(identifier);
}
	return defered.promise;
}

exports.isinWatchlist= function(req,mysql,q)
{   
   
    $mysqli = {};
	strQuery = mysqli.mysqli($mysqli,49); 
    ////console.log(strQuery);
    var defered = q.defer();

    escapeData = [ req.param('user_id'),req.param('classifiedid')];
  try {
	query =  mysql.query(strQuery,escapeData,defered.makeNodeResolver());

	return defered.promise;
	}
catch (e) { 
	}
}

exports.apiDeleteWatchlist = function (req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_delete_watchlist');

    var defered = q.defer();

    var escape_data = [req.param('id'), req.param('user_id')];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
     try {
 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

}
catch (e) {
 			
             date = require('date-utils');
            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
            var identifier = {'Date':datenow}
            identifier.Event = 'Database';
            identifier.Description = 'DB error occured';
            identifier.Error=e.stack;
            common.writelog(identifier);
}
    return defered.promise;
}

exports.carSearchPageNo = function(req,mysql,q){

  delete data;
  data = odata = [];
  
  data = url.parse(req.url,true).query;
  data.where = '';
  //console.log(2);
  data.dspage = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
  return data;
}

exports.iframeMyBids = function(req,mysql,q,count,restype)
{
		if(typeof(restype) !== 'undefined' && restype== 'won') {
					
			var page = req.body.page1;
			var perlimit = req.body.perlimit;
			page = (page > 0) ? (page-1)*perlimit : 0;  
			if(count == 1){
				var limit = 'limit '+page+','+ perlimit;
			}
			else {
				limit = "";
			} 
			
			$mysqli =  {limit : limit};    
			
			strQuery = mysqli.mysqli($mysqli,'car_bike_api_my_won_bids');
			var defered = q.defer();
			var escape_data =  [req.body.user_id,page];	
			
			//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
			 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 		
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}	
			return defered.promise;
		}
		
		else {
			
			datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
			
			if(restype == 'active'){
				var where = ' and b.declined=0 and p.market_status = "open" and p.date_closed >= "'+datge+'"';
				var page = req.body.page;				
			}
			else if(restype == 'lost'){

				 var where = ' and b.awarded = 0 and p.market_status != "open" and (select count(bb.id) as cnt from bids as bb where bb.project_id = p.id and bb.user_id = b.user_id and bb.awarded = 1) = 0';
				var page = req.body.page2;
			}
			
			where += ' and b.id in (select max(bc.id) as cnt from bids as bc where bc.project_id = p.id and bc.user_id = b.user_id)';
				   
			
			
			var perlimit = req.body.perlimit;
			page = (page > 0) ? (page-1)*perlimit : 0;	
			
			if(count == 1){
				var limit = 'limit '+page+','+ perlimit;
			}
			else{
				 limit = "";
			}
	
			$mysqli =  {where : where,limit : limit};
	
			strQuery = mysqli.mysqli($mysqli,'car_bike_api_my_lost_bids');	    
			var defered = q.defer();			

			var escape_data =  [req.body.user_id,page];
	
			//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
			 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
			//console.log(query.sql)
			return defered.promise;		
		}		
}


exports.mobileiframeMyBids = function(req,mysql,q,count,restype)
{
		if(typeof(restype) !== 'undefined' && restype== 'won') {
					
			var page = req.body.page;
			var perlimit = req.body.perlimit;
			page = (page > 0) ? (page-1)*perlimit : 0;  
			if(count == 1){
				var limit = 'limit '+page+','+ perlimit;
			}
			else {
				limit = "";
			} 
			
			$mysqli =  {limit : limit};    
			
			strQuery = mysqli.mysqli($mysqli,'car_bike_api_my_won_bids');
			var defered = q.defer();
			var escape_data =  [req.body.user_id,page];	
			
			//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());	
			try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
			return defered.promise;
		}
		
		else {
			
			datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');


			var where =' where 1=1 ';
			if(restype == 'active'){
				where += ' and b.declined=0 and p.market_status = "open" and p.date_closed >= "'+datge+'"';
				var page = req.body.page;
			}
			else{
				where += ' and b.awarded = 0 and (p.date_closed <= "'+datge+'" OR (p.market_status != "open")) and (select count(bb.id) as cnt from bids as bb where bb.project_id = p.id and bb.user_id = b.user_id and bb.awarded = 1) = 0';				
				var page = req.body.page;
			}
				   
			where += ' and b.id in (select max(bc.id) as cnt from bids as bc where bc.project_id = p.id and bc.user_id = b.user_id)';
			
			var perlimit = req.body.perlimit;
			page = (page > 0) ? (page-1)*perlimit : 0;	
			
			if(count == 1){
				var limit = 'limit '+page+','+ perlimit;
			}
			else{
				 limit = "";
			}
	
			$mysqli =  {where : where,limit : limit};
	
			strQuery = mysqli.mysqli($mysqli,'car_bike_api_my_lost_bids');	    
			var defered = q.defer();			

			var escape_data =  [req.body.user_id,page];
	
			//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
			try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
			return defered.promise;		
		}		
}


exports.apiBidHistoryFromat = function (results,req) {
	
	req_bid_data = [];
	var user_id = 0;
	// Bidder Name Anonymous Logic
	if(typeof( req.param('user_id')) !== 'undefined')  {
		user_id = req.param('user_id');
	}
	else if(typeof(req.body.user_id) !== 'undefined'){
		user_id = req.body.user_id;
	}
	else if(typeof(req.session.user_id) !== 'undefined') {
		user_id = req.session.user_id;
	}
	else if(typeof(req.session.userid) !== 'undefined') {
		user_id = req.session.userid;
	}
	
	bid_list = '';
	bidderName = [];
	trackBidderName = [];
	bidderAnnonymouseName = 1;
	
	results.reverse();
	
	for(var ii= 0 ; ii < results.length ; ii++){
		
		arrUserId = results[ii]['user_id'];
		
		if(bidderName.indexOf(arrUserId) <= -1) {
			 bidderName.push(arrUserId);
			 if(arrUserId == user_id) {
				  trackBidderName[arrUserId] = 'ME';
			 }
			 else {
				  trackBidderName[arrUserId] = 'Bidder '+bidderAnnonymouseName;
				  bidderAnnonymouseName++;
			 }
		}
	}
	
	results.reverse();	

	for (i in results) {
		 arrUserId 	   		= results[i]['user_id'];										
	     results[i]['bidder_annonymous_name'] = trackBidderName[arrUserId];
		 results[i]['proposed_amount'] =  common.numberWithCommas(common.currencyConverter(results[i]['proposed_amount']));
		 req_bid_data[i] = results[i];
    }
	
	return req_bid_data;
}

exports.apiClassifiedFromat = function (results,device) {
		
	device = (typeof(device) !== 'undefined') ? device : 0;
	req_data = [];

    for (i in results) {
        if (results[i]['date_closed'] !== null || typeof(results[i]['date_closed']) !== 'undefined') {

            date1 = new Date(results[i]['date_closed']);
            date3 = new Date(results[i]['date_added']);
            date2 = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
            diffDays = date1.getTime() -  new Date(date2).getTime();
            results[i]['closed'] = date1;
			
			if(device == 0) {
				results[i]['ptime'] = dateFormat(results[i]['date_closed'], 'mmmm dS, yyyy');
				results[i]['stime'] = dateFormat(results[i]['date_added'], 'mmmm dS, yyyy');
				results[i]['ctime'] = dateFormat(results[i]['date_closed'], 'mmmm dS, yyyy');
				results[i]['current_time'] = dateFormat(date2, 'm/d/yyyy HH:MM:ss');
				results[i]['carbike_bidnow_url'] = global.carbike_url+results[i]['bidnow_url']+global.carbike_suffix_url;				
			}
			
			else {
				
				delete results[i]['category_id'];
				delete results[i]['subcategory'];
				delete results[i]['tags'];
				delete results[i]['work_loc'];
				delete results[i]['country'];
				delete results[i]['state'];
				delete results[i]['invite_people'];
				delete results[i]['created_at'];
				delete results[i]['updated_at'];
				delete results[i]['budget_type'];
				delete results[i]['feature'];
				delete results[i]['home_page_listing_fee'];
				delete results[i]['shipping_price'];
				delete results[i]['shipping_description'];

				delete results[i]['is_same_location'];
				delete results[i]['paypal_address'];
				delete results[i]['future'];
				delete results[i]['duration'];
				delete results[i]['time'];
				delete results[i]['time_level'];
				delete results[i]['duration_type'];
				delete results[i]['booked'];
				delete results[i]['city'];
				delete results[i]['sell_location'];
				delete results[i]['used_image_space'];
				delete results[i]['is_digital'];
				delete results[i]['closed'];
				delete results[i]['document'];							
							
			}
			if(device == 0) { 
           	 	results[i]['timer_time'] = dateFormat(results[i]['date_closed'], 'm/d/yyyy HH:MM:ss');
				results[i]['timern_time'] = dateFormat(results[i]['date_closed'], 'yyyy/mm/dd HH:MM:ss');
				results[i]['servern_time'] = common.dateConvertionSettings(new Date(),'YYYY/MM/DD HH:mm:ss');
				
				results[i]['timer_time_android'] = dateFormat(results[i]['date_closed'], 'yyyy-mm-dd HH:MM:ss');
			}
			else {
				 results[i]['timern_time'] = dateFormat(results[i]['date_closed'], 'yyyy/mm/dd HH:MM:ss');
				 results[i]['servern_time'] = common.dateConvertionSettings(new Date(),'YYYY/MM/DD HH:mm:ss');
				 results[i]['timer_time'] = dateFormat(results[i]['date_closed'], 'm/d/yyyy HH:MM:ss');
				 results[i]['timer_time_android'] = dateFormat(results[i]['date_closed'], 'yyyy-mm-dd HH:MM:ss');
			}
			if (results[i]['bids'] === null) {
                results[i]['bids'] = 0;
            
			}
            if (results[i]['bprice'] === 'NaN') {
                results[i]['bprice'] = 0.00;
            }

            if (results[i]['sprice'] === 'NaN') {
                results[i]['sprice'] = 0.00;
            }
			
            if (results[i]['rprice'] === 'NaN') {
                results[i]['rprice'] = 0.00;
            }
			
            if (results[i]['iprice'] === 'NaN') {
                results[i]['iprice'] = 0.00;
            }
			
            if (results[i]['wprice'] === 'NaN') {
                results[i]['wprice'] = 0.00;
            }
			
            if (diffDays > 0 || results[i]['market_status'] == 'sold') {
                results[i]['status'] = 'open';
                
				if (results[i]['market_status'] == 'sold') {
                    results[i]['status'] = 'sold';

                }
				
                else if (results[i]['market_status'] == 'removed') {
                    results[i]['status'] = 'deleted';
                }
				
                else if (date3 > date2) {
                    results[i]['status'] = 'future';
                }
				
				else if (results[i]['market_status'] == 'paymentpending') {
                    results[i]['status'] = 'paymentpending';
                }
				else if (results[i]['market_status'] == 'awarded') {
                    results[i]['status'] = 'awarded';
                }
				
                else if (results[i]['market_status'] == 'moderate') {
                    results[i]['status'] = 'moderate';
                }
            }
            else {
                if (results[i]['market_status'] == 'closed') {
                    results[i]['status'] = 'closed';
                }
				else if (results[i]['market_status'] == 'draft') {
                    results[i]['status'] = 'closed';
                }
				else if (results[i]['market_status'] == 'paymentpending') {
                    results[i]['status'] = 'paymentpending';
                }
				else if (results[i]['market_status'] == 'awarded') {
                    results[i]['status'] = 'awarded';
                }
                else {
                    results[i]['status'] = 'deleted';
                }
            }
            results[i]['day'] = common.dateMeasure(diffDays);
        }
		results[i]['bidding_status_text'] = '';
        if (results[i]['sprice'] != null || typeof(results[i]['sprice']) !== 'undefined') {
            results[i]['sprice']  = common.currencyConverter(results[i]['sprice']);
            results[i]['fsprice']  =common.currencyConverter( common.currencyConverter(results[i]['sprice']));
            results[i]['rprice']  = common.currencyConverter(results[i]['rprice']);
             results[i]['frprice']  =common.currencyConverter(common.currencyConverter(results[i]['rprice']));
            results[i]['wsprice'] = common.currencyConverter(results[i]['wprice'] + results[i]['iprice']);
            results[i]['wprice']  = common.currencyConverter(results[i]['wprice']);
			results[i]['fwprice'] = common.numberWithCommas(common.currencyConverter(results[i]['wprice']));
            results[i]['mprice']  = common.currencyConverter(results[i]['mprice']);
            results[i]['fmprice']  = common.numberWithCommas(common.currencyConverter(results[i]['mprice']));
            results[i]['iprice']  = common.currencyConverter(results[i]['iprice']);
            results[i]['fiprice']  = common.numberWithCommas(common.currencyConverter(results[i]['iprice']));
            results[i]['bprice']  = common.currencyConverter(results[i]['bprice']);
			results[i]['fbprice'] = common.numberWithCommas(results[i]['bprice']);
			if(device == 0) {			
            	results[i]['shipping_price'] = common.currencyConverter(results[i]['shipping_price']);
			}
			//results[i]['title'] = results[i]['vehicle_myear']+' '+ results[i]['make_name']+' '+results[i]['model_name']+' '+results[i]['variant_name']
			
        }
		if (results[i]['proposed_amount'] != null || typeof(results[i]['proposed_amount']) !== 'undefined') {
			if(typeof(results[i]['wprice']) || results[i]['wprice'] != null) {
				if(device == 1) {
						results[i]['bidding_status_text'] = results[i]['proposed_amount'] < results[i]['wprice'] ? 'You have been outbid.' : 'You\'re the highest bidder.';
				}
				else {
					results[i]['bidding_status_text'] = results[i]['proposed_amount'] < results[i]['wprice'] ? '<span style="color:red">You have been outbid.</span>' : 'You\'re the highest bidder.';
				}
				results[i]['wprice'] = common.numberWithCommas(results[i]['wprice']);
			}
		}
		if (results[i]['vehicle_km_driven'] != null || typeof(results[i]['vehicle_km_driven']) !== 'undefined') {
			results[i]['vehicle_km_driven'] = common.numberWithCommas(results[i]['vehicle_km_driven']);
		}
		if (results[i]['amount'] != null || typeof(results[i]['amount']) !== 'undefined') {
			results[i]['amount'] = common.numberWithCommas(results[i]['amount']);
		}
		if (results[i]['proposed_amount'] != null || typeof(results[i]['proposed_amount']) !== 'undefined') {
			results[i]['proposed_amount'] = common.numberWithCommas(results[i]['proposed_amount']);		    
		}
		if (results[i]['vehicle_no_of_owner'] != null || typeof(results[i]['vehicle_no_of_owner']) !== 'undefined') {
			results[i]['vehicle_no_of_owner'] = common.ordinalSuffixOf(results[i]['vehicle_no_of_owner']);
		}

		if(global.general.allowhighbid == 1 && results[i]['highbid'] == 0) {
			results[i]['highbid'] = 0;
		}
		if(device == 1) {
			results[i]['bidding_status_text'] = results[i]['win'] !=1 ? 'You have been outbid.' : 'You\'re the highest bidder.';
			results[i]['bidding_status_text'] = results[i]['wprice'] >results[i]['proposed_amount'] ? 'You have been outbid.' : 'You\'re the highest bidder.';
		}
				
        req_data[i] = results[i];
    }
    return req_data;
}

exports.iframeMywatchlist = function (req, mysql, q) {
    $mysqli = {};
    var page = req.body.page;
    page = (page > 0) ? (page - 1) * 10 : 0;


    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_my_watchlist');

    var defered = q.defer();

    var escape_data = [req.param('user_id'), page];
    //query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			 date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
    return defered.promise;
}

exports.mobileiframeMywatchlist = function (req, mysql, q) {
    $mysqli = {};

	var page = req.body.page;
	
	var perlimit = req.body.perlimit;
	
	page = (page > 0) ? (page-1)*perlimit : 0;  
	
	var limit = 'limit '+page+','+ perlimit;
	
	$mysqli =  {limit : limit};    

    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_my_watchlist_mobile');

    var defered = q.defer();

    var escape_data = [req.param('user_id'), page];
    //query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
    return defered.promise;
}

exports.iframeTotalMywatchlist = function (req, mysql, q) {
    $mysqli = {};
    page = req.body.page;
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_my_total_watchlist');

    var defered = q.defer();

    var escape_data = [req.param('user_id')];
    // 
    //query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
    return defered.promise;
}

exports.apiBasicClassifiedFromat = function (results,device) {
	req_data = [];
	device = (typeof(device) !== 'undefined') ? device : 0;
    for (i in results) {
		if(device ==1){
			delete results[i]['date_closed']; 
		}
        if (results[i]['vehicle_km_driven'] != null || typeof(results[i]['vehicle_km_driven']) !== 'undefined') {
			results[i]['vehicle_km_driven'] = common.numberWithCommas(results[i]['vehicle_km_driven']);
		}
		if (results[i]['vehicle_no_of_owner'] != null || typeof(results[i]['vehicle_no_of_owner']) !== 'undefined') {
			results[i]['vehicle_no_of_owner'] = common.ordinalSuffixOf(results[i]['vehicle_no_of_owner']);
		}
		if (results[i]['wprice'] != null || typeof(results[i]['wprice']) !== 'undefined') {
			results[i]['wprice'] = common.numberWithCommas(results[i]['wprice']);
		}		
		  results[i]['servern_time'] = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
        req_data[i] = results[i];
    }
    return req_data;	
}

exports.apiAddWishlist = function (req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 50);
    var defered = q.defer();
    datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
    escapeData = [req.param('classifiedid'),req.param('user_id'), datge];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
    try {
				 query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

    return defered.promise;
}

exports.apiRemoveWishlist = function (req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 53);
    var defered = q.defer();
    escapeData = [req.param('classifiedid'),req.param('user_id')];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
    try {
				 query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				           date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

    return defered.promise;

}

exports.apiWishListAddRemove = function (req, mysql) {
	if(req.param('status') == 1)  {
		this.apiAddWishlist(req,mysql,q);
	}
	else if(req.param('status') ==2) {
		this.apiRemoveWishlist(req,mysql,q);	 
	}
	return true;
}

exports.apiCarBikeGetClasifiedListing = function(req, mysql){

    $mysqli = {};
	$mysqli = {classifiedarray : req.body.classified_array,current_date : common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')};
   
	if(typeof(req.param('user_id')) !== 'undefined' && req.param('user_id') != '' && req.param('user_id') > 0) {
        $mysqli.watchlist = mysqli.mysqli($mysqli, 'car_bike_api_watchlist');
		$mysqli.watchlistselect = mysqli.mysqli($mysqli, 'car_bike_api_watchlist_select');
		$mysqli.userid = req.param('user_id');
    }
    else {
        $mysqli.watchlist = '';
		$mysqli.watchlistselect = '';
    }
	
	var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_fetch_classified_listings');
    escape_fields = [];

    //query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    try {
				 query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

    return defered.promise;
}

exports.mobileCarBikeGetClasifiedListing = function(req, mysql,count){
	var page = req.body.page;
	var perlimit = parseInt(req.body.perlimit);
	
	page = (page > 0) ? (page-1)*perlimit : 0;	
	where = '';
		
		if(typeof(req.param('maxprice')) !== 'undefined' && req.param('maxprice') != '') {
			var maxPrice = req.param('maxprice');
			if(!isNaN(maxPrice)) {
				where += ' AND p.wprice <= "'+maxPrice+'"';
			}
		}
		
		if(typeof(req.param('minprice')) !== 'undefined' && req.param('minprice') != '') {
			var minPrice = req.param('minprice');
			if(!isNaN(minPrice)) {
				where += ' AND p.wprice >= "'+minPrice+'" ';
			}
		}
		
		/*if(typeof(req.param('fuel')) !== 'undefined' && req.param('fuel') != '') {
			var fuel = req.param('fuel');
			where += ' AND va.id_car_fuel ="'+fuel+'" ';			
		}	
		
		if(typeof(req.param('state')) !== 'undefined' && req.param('state') != '') {
			var stateSelected = req.param('state');
			where += ' AND st.id_state IN( '+stateSelected+') ';			
		}		
		 		
		if(typeof(req.param('city')) !== 'undefined' && req.param('city') != '') {
			var citySelected = req.param('city');
			where += ' AND cy.id_city IN( '+citySelected+') ';			
		}		
		
		if(typeof(req.param('manufacturer')) !== 'undefined' && req.param('manufacturer') != '') {
			var manufacturerSelected = req.param('manufacturer');
			where += ' AND mk.id_car_make IN( '+manufacturerSelected+') ';
		 }
		 
		if(typeof(req.param('makemodel')) !== 'undefined' && req.param('makemodel') != '') {
			var makemodelSelected = req.param('makemodel');
			where += ' AND mo.id_car_model IN( '+makemodelSelected+') ';
		 }
		
		if(typeof(req.param('maxyear')) !== 'undefined' && req.param('maxyear') != '') {
			var maxYear = req.param('maxyear');
			if(!isNaN(maxYear)) {
				where += ' AND p.vehicle_myear <= "'+maxYear+'"';
			}
		}
		
		if(typeof(req.param('minyear')) !== 'undefined' && req.param('minyear') != '') {
			var minYear = req.param('minyear');
			if(!isNaN(minYear)) {
				where += ' AND p.vehicle_myear >= "'+minYear+'"';
			}
		}
		
		if(typeof(req.param('minKM')) !== 'undefined' && req.param('minKM') != '') {
			var minKM = req.param('minKM');
			if(!isNaN(minKM)) {
				where += ' AND p.vehicle_km_driven >= "'+minKM+'"';
			}
		}
		
		
		if(typeof(req.param('maxKM')) !== 'undefined' && req.param('maxKM') != '') {
			var maxKM = req.param('maxKM');
			if(!isNaN(maxKM)) {
				where += ' AND p.vehicle_km_driven <= "'+maxKM+'"';
			}
		}*/
		
		var orderbySql ,orderby ,orderbytype;
		
		if(typeof(req.param('orderby')) !== 'undefined' && req.param('orderby') != '' && (req.param('orderby') == 'wprice' || req.param('orderby') == 'vehicle_myear')) {
			orderby = req.param('orderby'); 
		}
		else {
			orderby = ''; 
		}
		
		if(typeof(req.param('orderbytype')) !== 'undefined' && req.param('orderbytype') != '' ) {
			 orderbytype = req.param('orderbytype'); 
		}
		else {
			orderbytype = '';
		}
				
		if(orderby != '' && orderbytype != '' && (orderbytype == 'asc' || orderbytype == 'desc')){
			orderbySql = " ORDER BY p."+orderby+" "+orderbytype;
		}
		else {
			orderbySql = ' ORDER BY p.id DESC';
		}
		
	    var escape_data =  [];
	
		if(count == 1){
			var limit = 'limit '+page+','+ perlimit;
			var queryname = 'car_bike_api_fetch_classified_listings_mobile'
		}
		else{
			var limit = "";
			var queryname = 'car_bike_api_fetch_classified_listings_mobile_0'
		}
		    
		var cid = typeof(req.body.catid) !== 'undefined' && req.body.catid != '' ?  req.body.catid : 0;

		
		$mysqli = {};
		
		
		
		$mysqli =  {where : where, limit:limit, orderbySql : orderbySql,cid:cid};	
		
		if(cid !=  0) {
			console.log("LILLLLLLLLLLLLLLY CIDD");
			$mysqli.cid = mysqli.mysqli($mysqli, 'cid');
		}
		else {
			$mysqli.cid = '';
		}	
		
		if(typeof(req.param('user_id')) !== 'undefined' && req.param('user_id') != '' && req.param('user_id') > 0) {
			$mysqli.watchlist = mysqli.mysqli($mysqli, 'car_bike_api_watchlist');
			$mysqli.watchlistselect = mysqli.mysqli($mysqli, 'car_bike_api_watchlist_select');
			$mysqli.userid = req.param('user_id');
		}
		
		else {
			$mysqli.watchlist = '';
			$mysqli.watchlistselect = '';
		}
		
		var defered = q.defer();
		strQuery = mysqli.mysqli($mysqli, queryname);
		escape_fields = [page,perlimit];
		
		//query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
		try {
			query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
			console.log(query.sql)
		}
		catch (e) {
			var date = require('date-utils');
			datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
			var identifier = {'Date':datenow}
			identifier.Event = 'Database';
			identifier.Description = 'DB error occured';
			identifier.Error=e.stack;
			common.writelog(identifier);
		}
		//console.log(query.sql);
		return defered.promise;
}

exports.closeExpiredItems = function(req, mysql){

  var bids = require('../module/bid');
  
  var date = require('date-utils');
  datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
  var products = require('../module/products');
	
  cart = require('../module/cart.js')
  var addTasksToProject = function(pid, cb) { // called once for each project row
  var prdt = pid;
  
  req.params.id = pid.id;
  var bids = require('../module/bid');
  var carApi = require('../module/carapi');

  closeddate = dateFormat(new Date(prdt['date_closed']),"yyyy-mm-dd HH:MM:ss");

  	if((Date.compare(closeddate,datenow) <= 0 ) && prdt['market_status'] == 'open') {

         q.all([bids.selectAwardBid(req,config.mysql,q)]).then(function(results1){

            if(results1[0][0].length > 0)
           	{				
				var bid = results1[0][0][0];
				
		      	if(pid.rprice <= bid.proposed_amount) {
					
					status = 'paymentpending';				
					products.closeProjects(req,config.mysql,q,status,pid.id);
 				    carApi.apiCurlRequest(prdt['id'],prdt['wprice'],'auction_paymentpending');
					payments = require('../module/payment');
					bids.makeAwardBid(req,config.mysql,q,results1[0][0][0].id);
					payments.transactionid = 0;
					payments.gateway = 'account';
					payments.sessionsdata = [];
					payments.sessionsdata.title = pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name;
					payments.sessionsdata.email = bid.email;
					payments.sessionsdata.url = $arr.config.url+'/product/view/'+pid.id;
					payments.sessionsdata.userid = bid.user_id;

					payments.sessionsdata.first_name = bid.first_name;
					payments.sessionsdata.last_name = bid.last_name;
					req.body.commission = $arr.config.general.commission_fee;
					payments.payid = pid.id;
					payments.type = 'winner';
					payments.name = pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name;;
					payments.amount = bid.proposed_amount;

					//Send Push Notification
					var saveNotifyArray = [];
					if(bid.push_notify_token){

						req.body.push_title = 'Congrats! You Won the Item +'+pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name;;
						req.body.classified_id = pid.id;
						req.body.registrationTokens = bid.push_notify_token;
						datenow = common.dateConvertionSettings(new Date(), 'YYYY-MM-DD HH:mm:ss');
						var arr_val = new Array(req.body.push_title, req.body.classified_id, bid.push_notify_token, bid.user_id, datenow);

						saveNotifyArray.push(arr_val);
						req.body.saveNotifyArray = saveNotifyArray;
						var self = this;
						_this.sendNotification(req,callbackFun);

						function callbackFun(err,push_res){
							console.log("Send notification to Winners "+new Date());
							console.log(push_res);
						}
					}

					payments.insertInvoice(req);

				     req.body.local_pick = 0;
                
			/*	  if(pid.shipping_description == 'Local pick up only'){
                      req.body.local_pick = 1;
                  }else{
                      req.body.local_pick = 0;
                  } */

					cart.insertBidnow(req,config.mysql,q,payments);				
					payments = require('../module/payment');
					message = require('../module/message');
					var dat = require('date-util');
					req.body.toid = bid.user_id;
					req.body.first_name = bid.first_name;
					req.body.last_name = bid.last_name; 
					req.body.r_id = Date.parse(new Date())/1000;
					req.body.toemail = bid.email;
					req.body.tophone = bid.phone;
					req.body.fromid = pid.user_id;
					req.body.pid = pid.id;
					req.body.subject = 'Congrats! You Won the Item +'+pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name;
					req.body.message = 'You Won the item.<br />Item Title : '+pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name;+'<br />Item Price : Rs '+payments.amount+'<br />Item URL: '+global.carbike_url+pid.bidnow_url+global.carbike_suffix_url+'<br />Contact Seller :'+pid['first_name']+'<br />Seller email address : '+pid['email'];
				  
					if(pid['phone'] != '' && pid['phone'] != null)
					{
						req.body.message += '<br />Seller Contact Phone: '+pid.phone;
					}
					
					message.addWithoutmessages(req,config.mysql,q);
					
 		   			localm	= require('../module/localmail');

       	   			if(global.mailgun.status == 'yes'){
						
						q.all([localm.mailtemps(req,config.mysql,q,'winner_buyer')]).then(function(results2){

							if(results2){

								var template = results2[0][0][0].template;
								var subject = results2[0][0][0].subject;
                               var template1 = results2[0][0][0].template;
								template = template.split('{{event.sitename}}' ).join( config.title);
								template = template.split('{{event.subject}}' ).join( req.body.subject);
								template = template.split('{{event.fname}}' ).join( req.body.first_name);
								template = template.split('{{event.tname}}' ).join( req.body.last_name);
								template = template.split('{{event.user}}' ).join( req.body.first_name+' '+ req.body.last_name);
								template = template.split('{{event.message}}' ).join( req.body.message);
								template = template.split('{{event.classifiedlink}}' ).join( global.carbike_url+pid.bidnow_url+global.carbike_suffix_url);
								template = template.split('{{event.title}}' ).join( pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name);
								template = template.split('{{event.price}}' ).join( common.numberWithCommas(payments.amount));
								template = template.split('{{event.siteurl}}').join( config.url);
								template = template.split('{{event.sitename2}}').join( config.title);
                               subject = subject.split('{{event.sitename}}' ).join( config.title);
                                subject = subject.split('{{event.subject}}' ).join( req.body.subject);
                                subject = subject.split('{{event.fname}}' ).join( req.body.first_name);
                                subject = subject.split('{{event.tname}}' ).join( req.body.last_name);
                                subject = subject.split('{{event.user}}' ).join( req.body.first_name+' '+ req.body.last_name);
                                subject = subject.split('{{event.message}}' ).join( req.body.message);
                                subject = subject.split('{{event.classifiedlink}}' ).join( global.carbike_url+pid.bidnow_url+global.carbike_suffix_url);
                                subject = subject.split('{{event.title}}' ).join( pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name);
                                subject = subject.split('{{event.price}}' ).join( common.numberWithCommas(payments.amount));
                                subject = subject.split('{{event.siteurl}}').join( config.url);
                                subject = subject.split('{{event.sitename2}}').join( config.title);
								template1 = template1.split('{{event.sitename}}' ).join( config.title);
								template1 = template1.split('{{event.subject}}' ).join( req.body.subject);
								template1 = template1.split('{{event.fname}}' ).join( req.body.first_name);
								template1 = template1.split('{{event.tname}}' ).join( req.body.last_name);
								template1 = template1.split('{{event.user}}' ).join('Admin');
								template1 = template1.split('{{event.message}}' ).join( req.body.message);
								template1 = template1.split('{{event.classifiedlink}}' ).join( global.carbike_url+pid.bidnow_url+global.carbike_suffix_url);
								template1 = template1.split('{{event.title}}' ).join( pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name);
								template1 = template1.split('{{event.price}}' ).join( common.numberWithCommas(payments.amount));
								template1 = template1.split('{{event.siteurl}}').join( config.url);
								template1 = template1.split('{{event.sitename2}}').join( config.title);
								carApi.sendMailMailgun(template,subject,req.body.toemail);
                                carApi.sendMailMailgun(template1, subject, global.general.adminemail);
                               
							}
							else{
								console.log('No template named winner_buyer');
							}
							
						});

					}

					else{ console.log('No Mail Delivery method is selected'); }					

				}  
				else if(prdt['market_status'] == 'open') {
					 status = 'closed';
					 products.closeProjects(req,config.mysql,q,status,pid.id);
					 carApi.apiCurlRequest(prdt['id'],prdt['wprice'],'auction_closed');
           		} 
           } 
           else if(prdt['market_status'] == 'open')
           {
				 status = 'closed';
				 products.closeProjects(req,config.mysql,q,status,pid.id);
				 carApi.apiCurlRequest(prdt['id'],prdt['wprice'],'auction_closed');
           } 
            cb(null);  
           }).fail(function(err){
			 console.log(err.stack);
			 throw err;
		 }).done();
     }
  };
  
  q.all([products.productDetails(req,config.mysql,q)]).then(function(results){
		if(results[0][0].length > 0)
		{  
		  var async = require('async');
		  async.each(results[0][0], addTasksToProject, function(err) {
			  if (err) return console.error("Error in asynch "+err);
			  return true;
			});
		}
		else
		{
			return true;
		}
   }).fail(function(err){
		 console.log(err.stack);
		 throw err;
	 }).done();
}

exports.getProductDetail = function  (req, mysql, q) {
	
	
	
    $mysqli = {};
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_get_product_detail');
    datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
    escape_fields = [req.body.id]
    //  
    //query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    try {
				 query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            var date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

    return defered.promise;
	
}

exports.awardListingPriceMet = function(req, mysql,pid){
    
	var carApi = require('../module/carapi');
	
	var bids = require('../module/bid');
    
    var date = require('date-utils');
    datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
    var products = require('../module/products');	
    cart = require('../module/cart.js')
  
	req.body.pid = typeof(pid) !== 'undefined' && pid != '' ? pid : 0;
		 
	q.all([carApi.getProductDetail(req,config.mysql,q),bids.selectAwardBid(req,config.mysql,q)]).then(function(results){
		
		if(results[0][0].length > 0){  	
			pid  = results[0][0][0];	
			prdt = results[0][0][0];
			bid  = results[1][0][0];
			
			status = 'paymentpending';				
			products.closeProjects(req,config.mysql,q,status,prdt['id']);
			carApi.apiCurlRequest(prdt['id'],prdt['wprice'],'auction_paymentpending');
			payments = require('../module/payment');
			bids.makeAwardBid(req,config.mysql,q,bid['id']);
			payments.transactionid = 0;
			payments.gateway = 'account';
			payments.sessionsdata = [];
			payments.sessionsdata.title = pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name;
			payments.sessionsdata.email = bid.email;
			payments.sessionsdata.url = $arr.config.url+'/product/view/'+pid.id;
			payments.sessionsdata.userid = bid.user_id;
	
			payments.sessionsdata.first_name = bid.first_name;
			payments.sessionsdata.last_name = bid.last_name;
			req.body.commission = $arr.config.general.commission_fee;
			payments.payid = pid.id;
			payments.type = 'winner';
			payments.name = pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name;
			payments.amount = bid.proposed_amount;
	
			payments.insertInvoice(req);
	
		  
		    req.body.local_pick = 0;
                
			/*	 if(pid.shipping_description == 'Local pick up only'){
				  req.body.local_pick = 1;
			  }else{
				  req.body.local_pick = 0;
			  } */
	
			cart.insertBidnow(req,config.mysql,q,payments);				
			payments = require('../module/payment');
			message = require('../module/message');
			var dat = require('date-util');
			req.body.toid = bid.user_id;
			req.body.first_name = bid.first_name;
			req.body.last_name = bid.last_name; 
			req.body.r_id = Date.parse(new Date())/1000;
			req.body.toemail = bid.email;
			req.body.tophone = bid.phone;
			req.body.fromid = pid.user_id;
			req.body.pid = pid.id;
			req.body.subject = pid.bidnow_url+'Congrats! You Won the Item ';
			req.body.message = 'You Won the item.<br />Item Title : '+pid.title+'<br />Item Price : Rs '+payments.amount+'<br />Item URL: '+global.carbike_url+pid.bidnow_url+global.carbike_suffix_url+'<br />Contact Seller :'+pid['first_name']+'<br />Seller email address : '+pid['email'];
		  
			if(pid['phone'] != '' && pid['phone'] != null)
			{
				req.body.message += '<br />Seller Contact Phone: '+pid.phone;
			}
			
			message.addWithoutmessages(req,config.mysql,q);
			
			localm	= require('../module/localmail');
	
			
			if(global.mailgun.status == 'yes'){				
				q.all([localm.mailtemps(req,config.mysql,q,'winner_buyer')]).then(function(results2){
	
					if(results2){
	
						var template = results2[0][0][0].template;
						var subject = results2[0][0][0].subject;
	                     var template1 = results2[0][0][0].template;
						template = template.split('{{event.sitename}}' ).join( config.title);
						template = template.split('{{event.subject}}' ).join( req.body.subject);
						template = template.split('{{event.fname}}' ).join( req.body.first_name);
						template = template.split('{{event.tname}}' ).join( req.body.last_name);
						template = template.split('{{event.user}}' ).join( req.body.first_name+' '+ req.body.last_name);
						template = template.split('{{event.message}}' ).join( req.body.message);
						template = template.split('{{event.classifiedlink}}' ).join( global.carbike_url+pid.bidnow_url+global.carbike_suffix_url);
						template = template.split('{{event.title}}' ).join( pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name);
						template = template.split('{{event.price}}' ).join( common.numberWithCommas(payments.amount));
						template = template.split('{{event.siteurl}}').join( config.url);
						template = template.split('{{event.sitename2}}').join( config.title);
						subject = subject.split('{{event.sitename}}' ).join( config.title);
						subject = subject.split('{{event.subject}}' ).join( req.body.subject);
						subject = subject.split('{{event.fname}}' ).join( req.body.first_name);
						subject = subject.split('{{event.tname}}' ).join( req.body.last_name);
						subject = subject.split('{{event.user}}' ).join( req.body.first_name+' '+ req.body.last_name);
						subject = subject.split('{{event.message}}' ).join( req.body.message);
						subject = subject.split('{{event.classifiedlink}}' ).join( global.carbike_url+pid.bidnow_url+global.carbike_suffix_url);
						subject = subject.split('{{event.title}}' ).join( pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name);
						subject = subject.split('{{event.price}}' ).join( common.numberWithCommas(payments.amount));
						subject = subject.split('{{event.siteurl}}').join( config.url);
						subject = subject.split('{{event.sitename2}}').join( config.title);
						carApi.sendMailMailgun(template,subject,req.body.toemail);	

							    template1 = template1.split('{{event.sitename}}' ).join( config.title);
								template1 = template1.split('{{event.subject}}' ).join( req.body.subject);
								template1 = template1.split('{{event.fname}}' ).join( req.body.first_name);
								template1 = template1.split('{{event.tname}}' ).join( req.body.last_name);
								template1 = template1.split('{{event.user}}' ).join('Admin');
								template1 = template1.split('{{event.message}}' ).join( req.body.message);
								template1 = template1.split('{{event.classifiedlink}}' ).join( global.carbike_url+pid.bidnow_url+global.carbike_suffix_url);
								template1 = template1.split('{{event.title}}' ).join( pid.vehicle_myear+' '+ pid.make_name+' '+pid.model_name+' '+pid.variant_name);
								template1 = template1.split('{{event.price}}' ).join( common.numberWithCommas(payments.amount));
								template1 = template1.split('{{event.siteurl}}').join( config.url);
								template1 = template1.split('{{event.sitename2}}').join( config.title);

								
                                carApi.sendMailMailgun(template1, subject, global.general.adminemail);
					}
					else{
						console.log('No template named winner_buyer');
					}
				});
			}
			else{ console.log('No Mail Delivery method is selected'); }				
		}
   	 }).fail(function(err){
		 console.log(err.stack);
		 throw err;
	 }).done();
}

exports.outBidderAddMessages = function(req,mysql,q)
{

    var products = require('../module/products');
	var carApi = require('../module/carapi');
	datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
	strQuery = mysqli.mysqli($mysqli,156);
	
	req.body.fromid = (typeof(req.body.fromid) === 'undefined') ? req.session.userid : req.body.fromid;
	req.body.pid = (typeof(req.body.pid) === 'undefined') ? 0 : req.body.pid;

	var toid = req.body.toid;
	var toemail = req.body.toemail;
	var tophone = req.body.tophone;
	var fname = req.body.first_name;
	var lname = req.body.last_name;
	var messages =  req.body.message;
	var subjects = req.body.subject;
	var fromid = req.body.fromid;
	var pid = req.body.pid;
	var rid = req.body.r_id;	  	


	var escape_data =  [fromid,toid,subjects,messages,datge,rid,'open','open',pid];	
					
	var defered = q.defer();
				
	//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            var date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
	
	if(req.body.nid > 0){
		
		q.all([products.usermailnotify(req,config.mysql,q,req.body.toid,req.body.nid),products.usersmsnotify(req,config.mysql,q,req.body.toid,req.body.nid)]).then(function(results5){
			
			 if(global.mailgun.status == 'yes'){
				 
				q.all([localm.mailtemps(req,config.mysql,q,'outbid_event')]).then(function(results2){
					
					if(results2){
						var template = results2[0][0][0].template;
						var subject_message = results2[0][0][0].subject;		
						subject_message = subject_message.split('{{event.subjtitle}}').join( req.body.title12);											
						subject_message = subject_message.split('{{event.title}}').join( req.body.title12);											
						template = template.split('{{event.subject}}' ).join( subject_message);
						template = template.split('{{event.title}}').join( req.body.title12);	
						template = template.split('{{event.fname}}' ).join( fname);
						template = template.split('{{event.uname}}' ).join( fname+' '+lname);
						template = template.split('{{event.user}}' ).join( fname+' '+lname);
						template = template.split('{{event.tname}}' ).join( lname);
						template = template.split('{{event.classified_title}}').join( req.body.title12);
						template = template.split('{{event.classifiedlink}}').join( req.body.clas_bidnow_url);
						template = template.split('{{event.message}}' ).join( req.body.message);
						template = template.split('{{event.siteurl}}').join( config.url);
						template = template.split('{{event.sitename}}').join( config.title);
						template = template.split('{{event.sitename2}}').join( config.title);
						subject_message = subject_message.split('{{event.subject}}' ).join( subject_message);
                        subject_message = subject_message.split('{{event.title}}').join( req.body.title12);   
                        subject_message = subject_message.split('{{event.fname}}' ).join( fname);
                        subject_message = subject_message.split('{{event.uname}}' ).join( fname+' '+lname);
                        subject_message = subject_message.split('{{event.user}}' ).join( fname+' '+lname);
                        subject_message = subject_message.split('{{event.tname}}' ).join( lname);
                        subject_message = subject_message.split('{{event.classified_title}}').join( req.body.title12);
                        subject_message = subject_message.split('{{event.classifiedlink}}').join( req.body.clas_bidnow_url);
                        subject_message = subject_message.split('{{event.message}}' ).join( req.body.message);
                        subject_message = subject_message.split('{{event.siteurl}}').join( config.url);
                        subject_message = subject_message.split('{{event.sitename}}').join( config.title);
                        subject_message = subject_message.split('{{event.sitename2}}').join( config.title);
                        carApi.sendMailMailgun(template,subject_message,toemail);
					}
					else {
						console.log("No Tempales");
					}
					
				}).fail(function(err){
					console.log(err.stack);
				}).done();
			}
			else { console.log('No Mail Delivery method is selected'); }
			
		});
	}

	else {

		if(global.mailgun.status == 'yes'){	            
			
			q.all([localm.mailtemps(req,config.mysql,q,'message_sent')]).then(function(results2){
				
				if(results2){
					var template = results2[0][0][0].template;
					var subject_message = results2[0][0][0].subject;						
					template = template.split('{{event.subject}}' ).join( req.body.subject);
					template = template.split('{{event.fname}}' ).join( fname);
					template = template.split('{{event.tname}}' ).join( lname);
					template = template.split('{{event.user}}' ).join( fname+' '+lname);
					template = template.split('{{event.message}}' ).join( req.body.message);
					template = template.split('{{event.classifiedlink}}').join( req.body.clas_bidnow_url);
					template = template.split('{{event.siteurl}}').join( config.url);
					template = template.split('{{event.sitename2}}').join( config.title);
					carApi.sendMailMailgun(template,req.body.subject,toemail);
				}
				else {
					console.log("No Tempales");
				}
				
			}).fail(function(err){
				console.log(err.stack);
			}).done();	
		}

		else { console.log('No Mail Delivery method is selected'); }
	}
	return defered.promise;
}

exports.apiMoveToClassifieds = function(mysql,req) {
	$mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_move_classified');
    var defered = q.defer();
    escapeData = [req.body.id];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
    try {
	 query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());

	}
	catch (e) {				
		var date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		var identifier = {'Date':datenow}
		identifier.Event = 'Database';
		identifier.Description = 'DB error occured';
		identifier.Error=e.stack;
		common.writelog(identifier);
	}
    return defered.promise;
}

exports.apiCheckNewClassifiedEmailTrigger = function(mysql,prev_date,current_date) {
	$mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_find_new_listing');
    var defered = q.defer();
    escapeData = [prev_date,current_date];
    
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
 	
try {
	query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
}
catch (e) {			
	var date = require('date-utils');
	datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
	var identifier = {'Date':datenow}
	identifier.Event = 'Database';
	identifier.Description = 'DB error occured';
	identifier.Error=e.stack;
	common.writelog(identifier);
}
    return defered.promise;
}

exports.apiUpdateNotificationProject = function(classifiedId,mysql) {
	$mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_update_notified');
    var defered = q.defer();
    escapeData = [classifiedId];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
    try {
	 query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
	}
	catch (e) {				
		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		var identifier = {'Date':datenow}
		identifier.Event = 'Database';
		identifier.Description = 'DB error occured';
		identifier.Error=e.stack;
		common.writelog(identifier);
	}
    return defered.promise;
}

exports.apiGetAllDealersEmail = function(mysql) {
	$mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_get_all_dealers_email');
    var defered = q.defer();
    escapeData = [];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
    try {
		query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());	
	}
	catch (e) {	
		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		var identifier = {'Date':datenow}
		identifier.Event = 'Database';
		identifier.Description = 'DB error occured';
		identifier.Error=e.stack;
		common.writelog(identifier);
	}
    return defered.promise;
}

exports.apiGetAllDealersMobile= function(mysql) {
	$mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_get_all_dealers_mobile');
    var defered = q.defer();
    escapeData = [];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
     try {
		query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());		
	}
	catch (e) {		
		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		var identifier = {'Date':datenow}
		identifier.Event = 'Database';
		identifier.Description = 'DB error occured';
		identifier.Error=e.stack;
		common.writelog(identifier);
	}
   return defered.promise;
}

exports.sendMailMailgun = function(data,subject,toemail){ 

	var api_key = global.mailgun.api;
	var domain = global.mailgun.domain;
	var mailgun = require('mailgun-js')({ apiKey: api_key, domain: domain });
	var mailcomposer = require('mailcomposer');
	
	data = data.replace('{{event.sitelogo}}', config.url+"/images/home/logo.png");	
	console.log(toemail);
	var mail = mailcomposer({
		  from: config.title+' <'+global.general.adminemail+'>',
		  to: toemail,
		  subject: subject,
		  body: subject,
		  html: data
	});
	
	mail.build(function(mailBuildError, message) {
	 
		var dataToSend = {
			to: toemail,
			message: message.toString('ascii')
		};
	  
		mailgun.messages().sendMime(dataToSend, function (sendError, body) {
			if (sendError) {
				console.log(sendError);
				return;
			}
			else {
				//console.log(body);
				return;
			}
		});
	});
	return;
}

exports.apiCurlRequest = function(id,current_price,type){/*

	var formData = {
		'id_classified' :id,
		'current_price' : current_price,
		'type' : type
    };

    var username = "carandbike";
    var password = "kar8kiaZ";

    var host = global.carbike_url;
    var domain = "";
    var messages_path = "/UsedCar/Auction/Callback/";
    var uri = host + messages_path;
	var request = require('request');

	// Uncomment After Move to live requested by Prabhu to stop for staging purpose	
	
 	request.post(uri, {form: formData}, function (error, response, body) {
		if (!error && response.statusCode == 200) {
			//console.log("CURL :Success updated "+type);
			//console.log(body);
		} else {			
			//console.log("CURL: Something Wrong\n");
			//console.log(body+"\n");
		}
	}).auth(username, password, false);	
*/}

exports.apiCurlRequestSold = function(req){/*
    
	var formData = {
		'id_classified' :req.body.id_classified,
		'sold_price' : req.body.sold_price,
		'type' : req.body.type,
		'id_user' : req.body.id_user,
		'payment_date' : req.body.payment_date
    };

    var username = "carandbike";
    var password = "kar8kiaZ";

    var host = global.carbike_url;
    var domain = "";
    var messages_path = "/UsedCar/Auction/Callback/";
    var uri = host + messages_path;
	var request = require('request');

	// Uncomment After Move to live requested by Prabhu to stop for staging purpose
	
 	request.post(uri, {form: formData}, function (error, response, body) {
		if (!error && response.statusCode == 200) {
			//console.log("CURL :Success updated "+req.body.type);
			//console.log(body);
		} else {			
			//console.log("CURL: Something Wrong\n");
			//console.log(body+"\n");
		}
	}).auth(username, password, false);	
*/}

exports.fetchLocationAutoComplete = function(req,mysql,q)  {
	$mysqli = {searchText:req.body.searchText};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_get_location_state_city');
    var defered = q.defer();
    escapeData = [];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
     try {
	 	query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());	
	 }
	 catch (e) {					
		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		var identifier = {'Date':datenow}
		identifier.Event = 'Database';
		identifier.Description = 'DB error occured';
		identifier.Error=e.stack;
		common.writelog(identifier);
	}
    return defered.promise; 
}

exports.fetchMakeModelAutoComplete = function(req,mysql,q)  {
	$mysqli = {searchText:req.body.searchText};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_get_manufacturer_model_year');
    var defered = q.defer();
    escapeData = [];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
     try {
				 query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
    return defered.promise;
}
exports.fetchProductAutoComplete = function(req,mysql,q)  {
	$mysqli = {searchText:req.body.searchText};
    strQuery = mysqli.mysqli($mysqli, 'an_data1');
    var defered = q.defer();
    escapeData = [];
    //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
     try {
				 query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
    return defered.promise;
}

exports.carApiAdminUpdateHighBid = function(req,mysql,q)  {
	$mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'car_bike_api_admin_highbid_update');
    var defered = q.defer();
    var escapeData = [req.body.highbid, req.body.pid];
   //query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
     try {
				 query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
	
    return defered.promise;
}

exports.carApiAdminUpdatePushNotify = function(req,mysql,q)  {
	$mysqli = {};
	strQuery = mysqli.mysqli($mysqli, 'car_bike_api_admin_push_notify__update');
	var defered = q.defer();
	var escapeData = [req.query.push_notify, req.body.pid];
	//query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
	try {
		query = mysql.query(strQuery, escapeData, defered.makeNodeResolver());
		//console.log("Update notify "+query.sql);
	}
	catch (e) {

		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		var identifier = {'Date':datenow}
		identifier.Event = 'Database';
		identifier.Description = 'DB error occured';
		identifier.Error=e.stack;
		common.writelog(identifier);
	}

	return defered.promise;
}
exports.transactionalBidHistory = function(req,mysql,q,id)
{

        $mysqli =  {};
        sql = 'car_bike_transaction_bid_history';
        
        var escape_data =  [req.param('id')]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();
	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());				 

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		return defered.promise;
}

exports.carApiMakeAllBidAwardedZero = function(req,mysql,q,id)
{

        $mysqli =  {};
        sql = 'car_bike_make_all_bid_awarded_zero';
        
        var escape_data =  [req.param('id')]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();
	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		return defered.promise;
}

exports.carApiMakeBidAwardedOne = function(req,mysql,q,id) {
        $mysqli =  {};
        sql = 'car_bike_make_bid_awarded_one';
        datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
        var escape_data =  [datge,req.param('id'),req.param('bid')]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();
	    
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		return defered.promise;
}

exports.carApiUpdateTransactionalDetailWithAwardWinner = function(req,mysql,q,id) {

        $mysqli =  {};
        sql = 'car_bike_update_transaction_with_winner';
        
        var escape_data =  [req.param('uid'), req.param('bidamount'), req.param('id'), req.param('transactionID')]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 

	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		return defered.promise;
}

exports.carApiUpdateBuynowDetailWithAwardWinner = function(req,mysql,q,id) {
	
        $mysqli =  {};
        sql = 'car_bike_update_buynow_with_winner';
        
        var escape_data =  [req.param('uid'),req.param('bidamount'),req.param('id'),req.param('uid')]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		return defered.promise;
}

exports.carApiUpdateBidPayRequest = function(req,mysql,q) {
	
        $mysqli =  {};
        sql = 'car_bike_update_bid_pay_request';
        
        var escape_data =  [req.body.id,req.body.biduserid]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		try {
			 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

		}
		catch (e) {					
			date = require('date-utils');
			datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
			var identifier = {'Date':datenow}
			identifier.Event = 'Database';
			identifier.Description = 'DB error occured';
			identifier.Error=e.stack;
			common.writelog(identifier);
		}
		return defered.promise;
}

exports.carApiUpdateBidCancelPayRequest = function(req,mysql,q) {
	
        $mysqli =  {};
        sql = 'car_bike_update_bid_cancel_pay_request';
        
        var escape_data =  [req.body.id,req.body.biduserid]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		try {
			 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
		}
		catch (e) {					
			date = require('date-utils');
			datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
			var identifier = {'Date':datenow}
			identifier.Event = 'Database';
			identifier.Description = 'DB error occured';
			identifier.Error=e.stack;
			common.writelog(identifier);
		}
		return defered.promise;
}

exports.apiCheckReferenceDataExisting = function(mysql, req) {
	 	$mysqli =  {};
        sql = 'car_bike_check_reference_data_existing';
        
        var escape_data =  [req.body.id_car_variant, req.body.id_car_model, req.body.id_car_make, req.body.id_city,req.body.id_state ]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

		return defered.promise;
}

exports.apiAddNewCarVariant = function(mysql, req) {
	 	$mysqli =  {};
        sql = 'car_bike_add_new_car_variant';
        
        var escape_data =  [req.body.id_car_variant, req.body.variant_name, req.body.id_car_fuel, req.body.id_car_model]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
					 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

		return defered.promise;
}


exports.apiAddNewCarModel = function(mysql, req) {
	 	$mysqli =  {};
        sql = 'car_bike_add_new_car_model';
        
        var escape_data =  [ req.body.id_car_model, req.body.model_name, req.body.id_car_make ]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

		return defered.promise;
}


exports.apiAddNewCarMake = function(mysql, req) {
	 	$mysqli =  {};
        sql = 'car_bike_add_new_car_make';
        
        var escape_data =  [req.body.id_car_make, req.body.make_name ]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

		return defered.promise;
}


exports.apiAddNewCarCity = function(mysql, req) {
	 	$mysqli =  {};
        sql = 'car_bike_add_new_car_city';
        
        var escape_data =  [ req.body.id_city, req.body.city_name, req.body.id_state]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}

		return defered.promise;
}


exports.apiAddNewCarState = function(mysql, req) {
	 	$mysqli =  {};
        sql = 'car_bike_add_new_car_state';
        
        var escape_data =  [ req.body.id_state, req.body.state_name ]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		
		return defered.promise;
}

exports.getCarManufacturesMob = function(req,mysql, q) {
	 	$mysqli =  {};
        sql = 'car_bike_api_get_manufacturers_mobile';
        
        var escape_data =  [  ]
	   
		strQuery = mysqli.mysqli($mysqli,sql); 
	    
	    var defered = q.defer();	    
	                 
		query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		
		return defered.promise;
}

exports.getCarFuelMob = function(req,mysql, q)  {
	 	
		$mysqli =  {};
        sql = 'car_bike_api_get_fuel_mobile';        
        var escape_data =  [ ]	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());		
		return defered.promise;
}

exports.getCarLocationMob = function(req,mysql, q)  {
	 	
		$mysqli =  {};
        sql = 'car_bike_api_get_location_state_city_mobile';        
        var escape_data =  []	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
				//console.log(query.sql);
				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}		
		return defered.promise;
}

exports.getCarModelsMob = function(req,mysql, q) {
		$mysqli = {};
		$mysqli = {'id_car_make' : req.param('makeid')};
        sql = 'car_bike_api_get_models_mobile';        
        var escape_data =  []	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}	
		return defered.promise;
}


exports.getCarCitiesMob = function(req,mysql, q) {
		$mysqli = {};
		$mysqli = {'id_state' : req.param('state')};
        sql = 'car_bike_api_get_city_mobile';        
        var escape_data =  []	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());	
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		return defered.promise;
}
exports.winner_reminder= function(req,mysql, q) {
		$mysqli = {};
		//$mysqli = {'id_state' : req.param('state')};
        sql = 'winner_reminder';        
        var escape_data =  []	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());	
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		return defered.promise;
}
exports.apiCloseClassifiedAuction = function(req,res,mysql, q) {
		$mysqli = {};
        sql = 'car_bike_api_close_classified_auction';        
        var escape_data =  [req.body.cid]	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());	
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		return defered.promise;
}

exports.getCarSpecifications = function(req,mysql, q) {
		$mysqli = {};
        sql = 'car_bike_api_get_car_spec_mobile';        
        var escape_data =  [req.body.cid]	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				             date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}	
		return defered.promise;
}

exports.updateProjectClassifiedStatus = function(cid,status,mysql, q) {
		$mysqli = {};
        sql = 'car_bike_api_update_classified_status';        
        var escape_data =  [status,cid]	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());	
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		//console.log(query.sql);
		return defered.promise;
}

exports.apiRemoveTransactionEntry = function(mysql, pid) {
		$mysqli = {};
        sql = 'car_bike_api_remove_transaction_entry';        
        var escape_data =  [pid]	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());	
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		//console.log(query.sql);
		return defered.promise;
}

exports.apiRemoveBuynowEntry = function(mysql, pid) {
		$mysqli = {};
        sql = 'car_bike_api_remove_buynow_entry';        
        var escape_data =  [pid]	   
		strQuery = mysqli.mysqli($mysqli,sql); 	    
	    var defered = q.defer();	    	                 
		//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());	
		 try {
				 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

				}
				catch (e) {
				 			
				            date = require('date-utils');
				            datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
				            var identifier = {'Date':datenow}
				            identifier.Event = 'Database';
				            identifier.Description = 'DB error occured';
				            identifier.Error=e.stack;
				            common.writelog(identifier);
				}
		//console.log(query.sql);
		return defered.promise;
}

exports.getNotifiedProject = function(mysql,q){
	$mysqli =  {};

	strQuery = mysqli.mysqli($mysqli,'get_push_notified_projects');

	var datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');

	escape_data = [datge,datge];

	var defered = q.defer();

	query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	//console.log("Notifu po "+query.sql);

	return defered.promise;
}

exports.getPushNotifiedUser = function(mysql,q){
	$mysqli =  {};

	strQuery = mysqli.mysqli($mysqli,'get_push_notified_users');

	var datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');

	escape_data = [datge,datge];

	var defered = q.defer();

	query =  mysql.query(strQuery,defered.makeNodeResolver());
	//console.log("USer qry "+query.sql);
	return defered.promise;
}

exports.sendNotification = function(req,callback){
	//console.log(req.body);
	var gcm = require('node-gcm');
	var message = new gcm.Message({
		collapseKey: 'demo',
		priority: 'high',
		contentAvailable: true,
		delayWhileIdle: true,
		timeToLive: 3,

		data: {
			classified_id : req.body.classified_id,
			key1: req.body.push_title,
			key2: 'message2'
		},
		notification: {
			title: 'Car & Bike',
			//icon: "ic_launcher",
			body : req.body.push_title,
		},

	});
	var registrationTokens1 = [];
	registrationTokens1.push('regToken1');
	registrationTokens1.push('regToken2');
	console.log(registrationTokens1);
	//console.log(message.params.notification);
	//Add your mobile device registration tokens here
	//var registrationTokens = ['eBrh0vbFWxc:APA91bEyjv71gkFjiDOArmS6qYhVc3QPCHzFoeZ1c9Xk_Z6ibJyn4fqwmXieWoonf6etRssTTbsWtINUxNPM261X5KFZElpo3dB9QGAzVRokrRqT5PH_ZHber2HZllFLvq2oBgVLswo8'];

	//var registrationTokens = ['fNZtoEX6ZFE:APA91bHqmHqMNpPRffCsqJ2CQ-USTYoUxM_yRjXrXlkXhf6whlMq7ui_ttOKZDeXohPoQFfgZKho-WZ_SjJM96EhorO_L0fMqaJ0S3OfOQ0PuTw8Upuz9gZ8kDiNg-29xWjKzTL250iz','dpa3DlfeyRA:APA91bFUFQuo4_oh4gq3LSCbTGZwrtJXvCbk97lLgHop3jr_aCbRtAbTugyCBYK-C3JuAcZhlKOtEL4ieeA-eYKDB7CilWqn_NvYk-OFMoAHL0kLlvU0DA8aDEFfqR0n-vpwSJSqSWfn'];
	if((req.body.registrationTokens) instanceof Array){
		var registrationTokens = req.body.registrationTokens;
	}else {
		var  registrationTokens = [req.body.registrationTokens];
	}

	console.log(registrationTokens);
	//Replace your developer API key with GCM enabled here
	var sender = new gcm.Sender('AIzaSyCC3qGGSbUSWt3-2dY-XpQGvJQWYPD2mhE');

	console.log("Sent to this token " +JSON.stringify(req.body));

	sender.send(message, {registrationTokens: registrationTokens}, function (err, response) {
		if (err) {
			console.error(err);
		} else {
			if(req.body.saveNotifyArray) {
				_this.savePushNotification(req, config.mysql, req.body.saveNotifyArray);
			}
			callback(null,response);
		}
	});

}

exports.savePushNotification = function(req,mysql,saveNotifyArray){

	$mysqli =  {};

	strQuery = mysqli.mysqli($mysqli,'save_push_notification');

	var datge = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');

	//escape_data = [];

	var defered = q.defer();

	query =  mysql.query(strQuery,[saveNotifyArray],defered.makeNodeResolver());
	console.log("Sve notify qry "+query.sql);
	query.on('error',function(err){
		console.log(err.stack);
	})
	return defered.promise;
}

exports.getFilterParentCategory = function(req,mysql,q){


	$mysqli = {};
	sql = 'carapi_get_parent_category';        
	var escape_data =  []	   
	strQuery = mysqli.mysqli($mysqli,sql); 	    
	var defered = q.defer();	    	  

	//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	try {
		 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
	}
	catch (e) {
		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		var identifier = {'Date':datenow}
		identifier.Event = 'Database';
		identifier.Description = 'DB error occured';
		identifier.Error=e.stack;
		ommon.writelog(identifier);
	}	
	return defered.promise;
}

exports.getFilterChildCategory = function(req,mysql,q){


	$mysqli = {};
	sql = 'carapi_get_child_category';        
	var escape_data =  [req.body.cid]	   
	strQuery = mysqli.mysqli($mysqli,sql); 	    
	var defered = q.defer();	    	  
			    	                 
	//query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
	try {
		 query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
	}
	catch (e) {
		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		var identifier = {'Date':datenow}
		identifier.Event = 'Database';
		identifier.Description = 'DB error occured';
		identifier.Error=e.stack;
		common.writelog(identifier);
	}	
	return defered.promise;
}