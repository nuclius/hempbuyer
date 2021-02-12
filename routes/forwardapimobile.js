  /*============================================================================*\
 || ########################################################################## ||
 || # Auction Software Marketplace[*]version[*] Build [*]build[*]
 || # ---------------------------------------------------------------------- # ||
 || # Customer License # [*]license[*]
 || # ---------------------------------------------------------------------- # ||
 || # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
 || # This file may not be redistributed in whole or significant part.       # ||
 || # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
 || # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
 || # ---------------------------------------------------------------------- # ||
 || ########################################################################## ||
 \*============================================================================*/
// #### load required Modules ##################################################
var express = require('express');
var reload = require('reload');
var sprintf = require('sprintf').sprintf;
var common = require('../module/common');
var register = require('../module/register');
var app = express.Router();
var q = require('q');
var request = require('request');
var carApi = require('../module/forwardapi');
var products = require('../module/products');
var jwt = require('jwt-simple');

app.use(function(req, res, next) {	
    var carApi = require('../module/forwardapi');
	//carApi.closeExpiredItems(req, config.mysql);
	next();
});



// Login API

app.get(['/login'], function(req, res) {
	var carApi = require('../module/forwardapi');
	if(typeof(req.param('username')) === 'undefined' || req.param('username') == '') {
		var msg = "User Id Empty";
        var status = "0";
        res.send({'status': status, 'msg': msg});
        res.end();	
		return false;	
	}
	if(typeof(req.param('password')) === 'undefined' || req.param('password') == '') {
		var msg = "Password Empty";
        var status = "0";
        res.send({'status': status, 'msg': msg});
        res.end();	
		return false;	
	}
	
	req.body.username = req.param('username');
	req.body.password = req.param('password');

    req.session.username = req.body.username;
	
	var login = require('../module/login');
		function processObject(row)	{	
			if(row == '') {
				var status = "0";
				res.send({'status': status, 'msg': "Username or Password is wrong"});
				res.end();	
				return false;	
			}
			if(row.length > 0) {

                var payload = req.body.username;
                var secret = '123456';
                var token = jwt.encode(payload, secret);

				if(row[0].status == 'moderate')	{					
					var status = "0";
					res.send({'status': status, 'msg': "User is in moderate state"});
					res.end();	
					return false;	
				}
				if(row[0].status != 'active') {
					var status = "0";
					res.send({'status': status, 'msg': "User is in moderate state"});
					res.end();	
					return false;		
				}
					var status = "1";
					res.send({'status': status, 'msg': "success","id_user":row[0].id, token_id :token});
					res.end();	
					return false;
			}
		 }
		var userprocess = login.process(req,config.mysql,processObject);
	
});

// Register API

app.get(['/register'], function(req, res) {
	var carApi = require('../module/forwardapi');
    var common = require('../module/common');

    //var tokenid =(typeof(req.param('token_id')) !== 'undefined') ? req.param('token_id') : 0 ;

   // var callfun =common.checkmobile(req,res,tokenid);


        if(typeof(req.param('first_name')) === 'undefined' || req.param('first_name') == '') {
            var msg = "First Name is Empty";
            var status = "0";
            res.send({'status': status, 'msg': msg});
            res.end();
            return false;
        }

        if(typeof(req.param('last_name')) === 'undefined' || req.param('last_name') == '') {
            var msg = "Last Name is Empty";
            var status = "0";
            res.send({'status': status, 'msg': msg});
            res.end();
            return false;
        }

        if(typeof(req.param('email')) === 'undefined' || req.param('email') == '') {
            var msg = "Email is Empty";
            var status = "0";
            res.send({'status': status, 'msg': msg});
            res.end();
            return false;
        }

        if(typeof(req.param('password')) === 'undefined' || req.param('password') == '') {
            var msg = "Password Empty";
            var status = "0";
            res.send({'status': status, 'msg': msg});
            res.end();
            return false;
        }


        req.body.first_name = req.param('first_name');
        req.body.last_name = req.param('last_name');
        req.body.email = req.param('email');
        req.body.password = req.param('password');

        var register = require('../module/register');

        q.all([register.checkemail(config.mysql,req)]).then(function(results){
            console.log(results[0][0])
            if(results[0][0].length > 0) {
                var msg = "Email Already Exist!";
                var status = "0";
                res.send({'status': status, 'msg': msg});
                res.end();
                return false;
            }
            else {
                register.mobileSave(config.mysql,req, res);
            }

        });




          	
});

// Embed Script for Listing Page (Search Page) classified details

app.get(['/getClassifiedListing'], function(req, res) {
	
	var carApi = require('../module/forwardapi');
	
    req.body.callback = typeof(req.param('callback')) !== 'undefined' ? req.param('callback') : 'fetchListingCallback';
	
	req.body.perlimit = (typeof(req.param('perlimit')) !== 'undefined'  && req.param('perlimit') != '') ? req.param('perlimit') : 10;
    req.body.page = (typeof(req.param('page')) !== 'undefined' && req.param('page') != '') ? req.param('page') : 1;

	req.body.maxprice = (typeof(req.param('maxprice')) !== 'undefined' && req.param('maxprice') != '') ? req.param('maxprice') : '';
	req.body.minprice = (typeof(req.param('minprice')) !== 'undefined' && req.param('minprice') != '') ? req.param('minprice') : '';
	req.body.fuel = (typeof(req.param('fuel')) !== 'undefined' && req.param('fuel') != '') ? req.param('fuel') : '';
	req.body.state = (typeof(req.param('state')) !== 'undefined' && req.param('state') != '') ? req.param('state') : '';
	req.body.city = (typeof(req.param('city')) !== 'undefined' && req.param('city') != '') ? req.param('city') : '';
	req.body.manufacturer = (typeof(req.param('manufacturer')) !== 'undefined' && req.param('manufacturer') != '') ? req.param('manufacturer') :'';
	req.body.makemodel = (typeof(req.param('makemodel')) !== 'undefined' && req.param('makemodel') != '') ? req.param('makemodel') : '';
	req.body.maxyear = (typeof(req.param('maxyear')) !== 'undefined' && req.param('maxyear') != '') ? req.param('maxyear') : '';
	req.body.minyear = (typeof(req.param('minyear')) !== 'undefined' && req.param('minyear') != '') ? req.param('minyear') : '';
	req.body.minKM = (typeof(req.param('minKM')) !== 'undefined' && req.param('minKM') != '') ? req.param('minKM') : '';
	req.body.maxKM = (typeof(req.param('maxKM')) !== 'undefined' && req.param('maxKM') != '') ? req.param('maxKM') : ''; 
    req.body.catid = (typeof(req.param('catid')) !== 'undefined' && req.param('catid') != '') ? req.param('catid') : ''; 

    q.all([carApi.mobileCarBikeGetClasifiedListing(req, config.mysql,0),carApi.mobileCarBikeGetClasifiedListing(req, config.mysql,1)]).then(function(results) {
          
	    if( results[1][0].length>0){           
     		results[1][0][0]['rslts']=results[0][0].length;
        }

		val_str=JSON.stringify(results[1][0]);
     
        if (results[0][0].length > 0) {			
			arr_active_listings = {};       
			arr_active_listings['totalcount'] 	  = results[0][0].length;		
			arr_active_listings['perlimit']	  	  = req.body.perlimit;		
			arr_active_listings['page']		  	  = req.body.page;			
			arr_active_listings['activeListings'] = carApi.apiClassifiedFromat(results[1][0],1);			
			res.send({'status': 1,'result':arr_active_listings});

        } else {
            res.send({'status': 0 ,'result': 'No Lisitngs Found'});
        }
        res.end();
        return false;
    }).fail(function(err) {
		res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();
});

// Embed Script for Bidding Page (View Page) classified details

app.get(['/getClassifiedBidInfo'], function(req, res) {	
    
	var carApi = require('../module/forwardapi');
	
    var emitArr = [];
    emitArr.loadstatus = 1;

    req.body.id = (typeof(req.param('classifiedid')) !== 'undefined') ? req.param('classifiedid') : 0;

    req.session.userid = req.param('user_id');
    var products = require('../module/products');
	
	q.all([products.productDetail(req, config.mysql, q), products.getAllCats(req, config.mysql, q), products.checkblocked(req, config.mysql, q)]).then(function(results) {

		var arr_bid = {};
    	arr_bid['bidshow'] = (typeof(req.param('user_id')) !== 'undefined') ? true : false;

        bids = require('../module/bid');
        var dateFormat = require('dateformat');
        var date = require('date-utils');
        datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
        var catnames = [];
        var cat_nos = 0;
        var cid = 0;
        var limits = 2;
        var blocked = 0;
        prdt = results[0][0][0];

        if (results[2][0].length > 0) {
            arr_bid['blocked'] = 1;
        } else {
            arr_bid['blocked'] = 0;
        }
        arr_bid.reservemeet = false;
		
		if (results[0][0].length > 0) {
			
        try {
            if (parseFloat(prdt.rprice) <= parseFloat(prdt.wprice)) {
                arr_bid.reservemeet = true;
            }
        } catch (e) {
            console.log("Error in reserve meet " + e.stack);
        }
	
        closeddate = dateFormat(new Date(prdt['date_closed']), "yyyy-mm-dd HH:MM:ss"); 
        addeddate = dateFormat(new Date(prdt['date_added']), "yyyy-mm-dd HH:MM:ss");
		
        if ((Date.compare(closeddate, datenow) <= 0) && prdt['market_status'] == 'open') {
			var project_format  = carApi.apiClassifiedFromat(results[0][0],1);
            arr_bid['projects'] = project_format[0];
			
            var arr = {
                'status': 0,
                'msg': 'The Classified is '+prdt['market_status'],
				'result': arr_bid
            };
			
		    res.send(arr);
            res.end();
            return false;
        }
        
		arr_bid.live_status = 1;
        if ((Date.compare(addeddate, datenow) > 0) && prdt['market_status'] == 'open') {
            arr_bid.live_status = 0;
        }
        user = require('../module/user');
        req.body.pid = req.param('id');

        q.all([bids.bidHistory(req, config.mysql, q, 0), bids.bidHistory(req, config.mysql, q, 1), products.bidWinner(req, config.mysql, q), products.auctionSold(req, config.mysql, q), products.productImage(req, config.mysql, q), user.userInfo(req, config.mysql, q, prdt.user_id, ['first_name', 'last_name']), products.isinWatchlist(req, config.mysql, q), bids.getProxyDetails(req, config.mysql, q, 'get_highest_biduser'), bids.checkbidPlaced(req, config.mysql, q)]).then(function(results2) {

            arr_bid['bids'] = carApi.apiBidHistoryFromat(results2[0][0],req);
            arr_bid['bcnt'] = results2[1][0][0]['bid'];
            arr_bid['winbid'] =  arr_bid['soldhim'] = arr_bid['placedbid'] = arr_bid['inwatchlist'] = arr_bid['user_bidded_status'] = false;
			//arr_bid['highbid'] = false;
            arr_bid['placedbidamount'] = 0;
            arr_bid['proxy_bid_details'] = results2[7][0][0]

            if (results2[8][0].length > 0) { //Get the last bid id
                if (results2[8][0][0].user_id == req.param('user_id')) {
                    arr_bid['user_bidded_status'] = true;
                    arr_bid['current_bid'] = (results2[8][0][0].proposed_amount);
                }
            }

            arr_bid['highbid_user_id'] = 0;
            var project_format = carApi.apiClassifiedFromat(results[0][0],1);
            arr_bid['projects'] = project_format[0];
            arr_bid['next_bid'] = (common.sumFloat(parseFloat(arr_bid['projects'].wprice), parseFloat(arr_bid['projects'].iprice)));
			
            if (results2[0][0].length > 0 && typeof(req.param('user_id')) !== 'undefined') {
                // If proxy bidding is off & curret user is highest user
                if (results2[0][0][0]['user_id'] == req.param('user_id') && parseInt(global.general.proxy_bidding) == 0) {
                    //arr_bid['highbid'] = true;
                    arr_bid['highbid_user_id'] = req.param('user_id');
                    arr_bid['next_bid'] = (common.sumFloat(parseFloat(arr_bid['projects'].wprice), parseFloat(arr_bid['projects'].iprice)));
				}
            }
            if (results2[2][0].length > 0) {
                arr_bid['winbid'] = true;
            }
            if (results2[3][0].length > 0) {
                arr_bid['soldhim'] = true;
            }
            if (results2[6][0].length > 0) {
                arr_bid['inwatchlist'] = true;
            }

			var fnext_bid_calc = common.sumFloat(parseFloat(arr_bid['projects'].wprice), parseFloat(arr_bid['projects'].iprice));
            arr_bid['fnext_bid'] 	  = common.numberWithCommas(fnext_bid_calc);
		    arr_bid['fcurrent_bid']   = arr_bid['projects'].fwprice;
		
            arr_bid['user_id'] = req.param('user_id');
            delete req.session;
            if (arr_bid.length < 0) {
                res.send({"status":"0","result":arr_bid});
                res.end();
                return false;
            } else {
                res.send({"status":"1","result":arr_bid}); 
                res.end();
                return false;
            }

        }).fail(function(err) {
			res.send({"status":"0","result":err.stack}); 
			res.end();
			return false;
			throw err;
        }).done();
		}
		else {
            res.send({'status': '0', 'msg': 'The Classified is closed'});
            res.end();
            return false;
		}
    }).fail(function(err) {
         res.send({"status":"0","result":err.stack}); 
         res.end();
         return false;
         throw err;
    }).done();
});


// Request from Embbed Code To get watchlist count for that user

app.get(['/getWishlistCount'], function(req, res) {
		
	var carApi = require('../module/forwardapi');

	if(typeof(req.param('user_id')) === 'undefined' || req.param('user_id') == '') {
		var msg = "User Id Empty";
        var status = "0";
        res.send({'status': status, 'msg': msg});
        res.end();	
		return false;	
	}
	q.all([carApi.iframeTotalMywatchlist(req, config.mysql, q)]).then(function(results) {
		if(results[0][0].length	 > 0) {
			res.send({'status': '1','watchcount': results[0][0].length});
			res.end();
			return false;
		}
		else {
			res.send({'status': '0','watchcount':0});
			res.end();
			return false;
		}
		
	}).fail(function(err) {		
         res.send({"status":"0","result":err.stack}); 
		console.log(err.stack);
		res.end();
		return false;		
	}).done();

});

// Request from Embbed Code To Add or Remove From Watchlist

app.get(['/watchlistAddRemove'], function(req, res) {

 
    if (typeof(req.param('status')) !== 'undefined' && req.param('status') != '' && req.param('status') > 0) {
        req.body.status = req.param('status');
    } else {
        res.send({'status': 0,'msg': 'Status Attribute Not Found'});
        res.end();
        return false;
    }


	if(typeof(req.param('classifiedid')) === 'undefined' || req.param('classifiedid') == '') {
		var msg = "Classified Id Not Found";
        var status = 0;
        res.send({'status': status, 'msg': msg});
        res.end();	
		return false;	
	}

	if(typeof(req.param('user_id')) === 'undefined' || req.param('user_id') == '') {
		var msg = "User Id Not Found";
        var status = 0;
        res.send({'status': status, 'msg': msg});
        res.end();	
		return false;	
	}

	req.body.user_id  = typeof(req.param('user_id')) !== 'undefined' ? req.param('user_id') : 0;
	req.body.id   	  = typeof(req.param('classifiedid')) !== 'undefined' ? req.param('classifiedid') : 0;
	
	var carApi = require('../module/forwardapi');
    var localm = require('../module/localmail');
	var products = require('../module/products');
	var user = require('../module/user');
    q.all([carApi.apiWishListAddRemove(req, config.mysql),products.productDetail(req,config.mysql,q), user.userInfo(req, config.mysql, q, req.body.user_id, ['first_name', 'email', 'last_name'])]).then(function(results) {

        if (req.param('status') == 1) {
            var msg = "Successfully added to watchlist";
			var watch_user_email = req.body.user_id;
			if(results[2][0].length > 0 && results[1][0].length > 0) {
				q.all([localm.mailtemps(req,config.mysql,q,'watchlist_added')]).then(function(results2){
					var template = results2[0][0][0].template;
					var subject = results2[0][0][0].subject;
					template = template.replace('{{event.user}}' , results[2][0][0].first_name+' '+results[2][0][0].last_name);
					template = template.replace('{{event.title}}' , results[1][0][0].title);
					template = template.replace('{{event.siteurl}}', config.url);
					template = template.replace('{{event.sitename}}', config.title);
					template = template.replace('{{event.sitename2}}', config.title);
					carApi.sendMailMailgun(template, subject,  results[2][0][0].email);					
				});
				var status = "1";		
			}
			else {            	
				var msg = "Classified does not exist";
            	var status = "0";
			}
        } else if (req.param('status') == 2) {
            var msg = "Successfully removed from watchlist";
            var status = 1;
        } else {
            var msg = "Something went wrong please try later";
            var status = 0;
        }

		dateFormat = require('dateformat');
		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		
		var identifier = {'Date':datenow}
		identifier.Event = 'wish list  ';
		identifier.Email = req.session.email;
		identifier.Description = msg;
		identifier.Ip_address =req.headers['x-forwarded-for'] || req.connection.remoteAddress;
		identifier['User-agent']=   req.headers['user-agent'];        
		identifier.Remote_Host=req.headers.host;
		identifier['REQUEST_URI']='forwardapi/watchlistAddRemove';
		identifier['HTTP_referer']=req.headers.referer;
		identifier.Data=req.body;
		common.tracelog(identifier);
		
		res.send({'status': status, 'msg': msg});
		res.end();
		return false;
        
    }).fail(function(err) {
		res.send({'status': 0,'msg':err.stack});
		res.end();
		return false;
	}).done();
});

// Request from Embbed Code To submit Bid

app.get(['/submitBidToAuction'], function(req, res) {

    var products = require('../module/products'),
        bids = require('../module/bid'),
        bid = require('../module/bid'),
        user = require('../module/user');
		carApi = require('../module/forwardapi');
		
    var emitArray = [];
	var arr_sub_bid = {};
	
    req.body.callback = typeof(req.param('callback')) !== 'undefined' ? req.param('callback') : 'submitBidCallback';

    if (typeof(req.param('user_id')) !== 'undefined' && req.param('user_id') != '' && req.param('user_id') > 0) {
        req.session.userid = req.param('user_id');
    } else {
        res.send({'status': 0,'msg': 'Invalid User Id','error_code': 'invaliduserid'});
        res.end();
        return false;
    }

    if (typeof(req.param('id')) !== 'undefined' && req.param('id') != '' && req.param('id') > 0) {
        req.body.id = req.param('id');
        req.body.wsprice = req.param('wsprice');
    } else {
        res.send({'status': 0,'msg': 'Classified Id Invalid','error_code': 'invalidclassifiedid'});
        res.end();
        return false;
    }
	
	if(typeof(req.body.wsprice) === 'undefined' || req.body.wsprice == '' || isNaN(req.body.wsprice) || req.body.wsprice.length > 15) {
		res.send({
            'status' : 0,
			'msg' : 'Bid Amount is not a valid one',
			'error_code' : 'invalidbidprice'               
		});
		res.end();
		return false;
	}

    update = 0;

    q.all([bids.maxcheckbidPlaced(req, config.mysql, q), products.productDetail(req, config.mysql, q), user.userInfo(req, config.mysql, q, req.session.userid, ['first_name', 'email', 'last_name', 'balance', 'reserve_amount','phone'])]).then(function(results) {

        useristhere = results[2][0].length;
		
        if (useristhere <= 0) {
	        res.send({'status': 0,'msg': 'User Id Invalid','error_code': 'invaliduserid'});
            res.end();
            return false;
        }
		
		var current_user_email, current_user_first_name ,current_user_last_name,current_user_phone;
        req.session.email = current_user_email =  results[2][0][0]['email'];
        req.session.first_name = current_user_first_name = results[2][0][0]['first_name'];
        req.session.last_name = current_user_last_name = results[2][0][0]['last_name'];
		current_user_phone = results[2][0][0]['phone']

        maxisthere = results[0][0].length;
        maxuid = 0;
        maxamt = 0;
        maxbid = [];
        if (maxisthere > 0) {
            maxbid = results[0][0][0];
            maxuid = maxbid.user_id;
            maxamt = maxbid.amt;
        }
        prdt = results[1][0][0];	
		 prdt.highbid = 1;
        if (prdt.user_id == req.session.userid) {
		    res.send({'status': 0,'msg': 'You can\'t submit bid for the item you posted','error_code': 'sameuser'});
            res.end();
            return false;
        }
        req.body.starting_price = prdt.wprice;
        req.body.title = prdt.title;
		
		
		next_bid = parseFloat(prdt.wprice) + parseFloat(prdt.iprice);
				
		
		if (req.body.wsprice <= prdt.wprice || req.body.wsprice < next_bid) {			
			
			var reservemeet = false;
					
			
			if (parseFloat(prdt.rprice) <= parseFloat(prdt.wprice)) {
				reservemeet = true;
			}
			
            res.send({
                'status': 0,
                'error_code': 'invalidbid',
                'msg': 'Please submit higher bid!',
                'lastbid': prdt.wprice,
                'nextbid': next_bid,
				'allowHighBid' : prdt.highbid,
				'flastbid': common.numberWithCommas(common.currencyConverter(prdt.wprice)),
                'fnextbid': common.numberWithCommas(next_bid),
				'reservemeet' :reservemeet
            });
			
            res.end();
            return false;
        }

        var dateFormat = require('dateformat');
        var date = require('date-utils');

        datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss');
        closeddate = dateFormat(new Date(prdt['date_closed']), "yyyy-mm-dd HH:MM:ss");
        maxamnt = (maxuid > 0 && maxuid == req.session.user_id) ? maxamt : 0;
        req.body.placeamt = config.perbid;

        if ((Date.compare(closeddate, datenow) <= 0) && prdt['market_status'] == 'open') {
            res.send({
                'status': 0,
                'error_code': 'classifiedclosed',
                'msg': 'This is closed Product!'
            });
            res.end();
            return false;
        } else if (prdt['market_status'] != 'open') {
            res.send({
                'status': 0,
                'error_code': 'classifiedclosed',
                'msg': 'This is closed Product!'
            });
            res.end();
            return false;
        }
		/*		
		if((req.body.wsprice) > prdt.bprice &&  prdt.highbid == 0) { 		
			res.send({
                'status': 0,
                'error_code': 'highbidnotallowed',
				'allowHighBid' : prdt.highbid,
                'msg': 'Bid amount should not be greater than Listing Price'
            });
            res.end();
            return false;
		}*/

        q.all(bid.placeBid(req, config.mysql, q, 1)).then(function(resbid) {
			
            req.body.placebid = resbid[0].insertId;

			// Function to check two bid at a same time
			q.all(bid.checkBidMicroSec(req, config.mysql, q)).then(function(resMicSecExist) {
				
				if(resMicSecExist[0].length > 0) {
					bidsuccess = false;
					for(var ibid = 0; ibid < resMicSecExist[0].length; ibid++) {
	 
						if(ibid == 0) {	
								
	 						arr_sub_bid['duplicatebidcount'] = resMicSecExist[0].length;
							arr_sub_bid['winnerid'] = resMicSecExist[0][ibid].user_id;
							
							if(req.session.userid == resMicSecExist[0][ibid].user_id) {						
								bidsuccess = true;
							}
							bid.updateBid(req, config.mysql, q);
					 
							if (maxuid > 0) {
								req.body.bid = maxbid.id;
								req.body.buid = maxbid.user_id;
								req.body.amt = parseFloat(maxbid.amt, 2) + parseFloat(results[1][0][0]['shipping_price'], 2);
							}
								 
							//carApi.apiCurlRequest(req.body.id,req.body.wsprice,'current_price');
	 
							arr_sub_bid['placedbid'] = true;
							arr_sub_bid['placedbidamount'] = emitArray['placedbidamount'] = req.body.wsprice;
										 
							/*if(((parseFloat(prdt.bprice) - parseFloat(req.body.wsprice)) <  parseFloat(prdt.iprice)) && prdt.highbid == 0) {
								arr_sub_bid['nextbidamount'] = emitArray['nextbidamount'] =  prdt.bprice;
								arr_sub_bid['next_bid'] = prdt.bprice;
							}
							else {*/
								arr_sub_bid['nextbidamount'] = emitArray['nextbidamount'] =  parseFloat(req.body.wsprice) + parseFloat(prdt['iprice']);
								arr_sub_bid['next_bid'] = parseFloat(req.body.wsprice) + parseFloat(prdt['iprice']);
							//}					
								 
							arr_sub_bid['fplacedbidamount'] = emitArray['fplacedbidamount'] = common.numberWithCommas(req.body.wsprice);
							arr_sub_bid['fnextbidamount'] = emitArray['fnextbidamount'] = common.numberWithCommas(arr_sub_bid['next_bid']);
				
							arr_sub_bid['reservemeet'] = emitArray['reservemeet'] =  false;
									
							
							if (parseFloat(prdt.rprice) <= parseFloat(arr_sub_bid['placedbidamount'])) {
								arr_sub_bid['reservemeet'] =  emitArray['reservemeet'] = true;
							}
									 
							localm = require('../module/localmail');
							
							q.all([bids.allbidders(req, config.mysql, q, prdt.id, req.session.userid), products.checkmailnotify(req, config.mysql, q, 1), products.checksmsnotify(req, config.mysql, q, 1), products.usermailnotify(req, config.mysql, q, results[1][0][0]['user_id'], 10), products.usersmsnotify(req, config.mysql, q, results[1][0][0]['user_id'], 10), bids.bidHistory(req, config.mysql, q, 0), bids.bidHistory(req, config.mysql, q, 1)]).then(function(bidders) {
				
								var tot_bidders = bidders[0][0].length;
								arr_sub_bid['newbidhistory1'] =  carApi.apiBidHistoryFromat(bidders[5][0],req);
								arr_sub_bid['newbidhistory2'] = bidders[6][0];
								message = require('../module/message');
								var dat = require('date-util');

                                registrationTokens = [];
                                var saveNotifyArray = [];
                                datenow = common.dateConvertionSettings(new Date(), 'YYYY-MM-DD HH:mm:ss');
                                req.body.push_title = 'You are outbid on Product ' + prdt.vehicle_myear+' '+prdt.make_name+' '+prdt.model_name+' '+prdt.variant_name;
                                req.body.classified_id = prdt.id;
                                for(i in bidders[0][0]) {
                                    if (bidders[0][0][i].push_notify_token) {

                                        registrationTokens.push(bidders[0][0][i].push_notify_token);
                                        var arr_val = new Array(req.body.push_title, req.body.classified_id, bidders[0][0][i].push_notify_token, bidders[0][0][i].user_id, datenow);
                                        saveNotifyArray.push(arr_val);
                                    }
                                }

                                req.body.registrationTokens = registrationTokens;
                                if(registrationTokens.length > 0) {

                                    arr_sub_bid.registertoken = registrationTokens;
                                    carApi.sendNotification(req, callbackFun);
                                }

                                function callbackFun(err,push_res) {
                                    console.log("Send notification to outbidders "+new Date());
                                    arr_sub_bid.push_response = push_res;
                                    console.log(push_res);
                                }


                                for (var k = 0; k < tot_bidders; k++) {
									req.body.nid = 7;
									req.body.first_name = bidders[0][0][k].first_name;
									req.body.last_name = bidders[0][0][k].last_name;
									req.body.toemail = req.body.email = bidders[0][0][k].email;
									req.body.tophone = bidders[0][0][k].phone;
									req.body.toid = bidders[0][0][k].user_id;
									req.body.pid = bidders[0][0][k].project_id;
									req.body.r_id = Date.parse(common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')) / 1000; 
									req.body.subject = 'You are outbid on Product ' + prdt.vehicle_myear+' '+prdt.make_name+' '+prdt.model_name+' '+prdt.variant_name;
									req.body.title12 =  prdt.vehicle_myear+' '+prdt.make_name+' '+prdt.model_name+' '+prdt.variant_name;
									req.body.clas_bidnow_url = global.carbike_url+prdt.bidnow_url+global.carbike_suffix_url;
									req.body.phmessage = prdt.vehicle_myear+' '+prdt.make_name+' '+prdt.model_name+' '+prdt.variant_name + ' has been bidded with higher amount by someone.';
									carApi.outBidderAddMessages(req, config.mysql, q);
									
								}											
											 	
								if (global.mailgun.status == 'yes') {					
									
								   q.all([localm.mailtemps(req, config.mysql, q, 'bid_submitted')]).then(function(results2) {
				
										if (results2) {
											var template = results2[0][0][0].template;
											var subject = results2[0][0][0].subject;
											template = template.replace('{{event.sitename}}', config.title);
											template = template.replace('{{event.user}}', current_user_first_name + ' ' + current_user_last_name);
											template = template.replace('{{event.title}}', prdt.title);
											template = template.replace('{{event.classifiedlink}}', global.carbike_url+prdt.bidnow_url+global.carbike_suffix_url);
											template = template.replace('{{event.amount}}', common.numberWithCommas(req.body.wsprice));
											template = template.replace('{{event.siteurl}}', config.url);
											template = template.replace('{{event.sitename2}}', config.title);
											carApi.sendMailMailgun(template, subject, current_user_email);
										} else {
											console.log("No templates named bid_submitted");
										}
									});
									
											 		
									q.all([localm.mailtemps(req, config.mysql, q, 'bid_received')]).then(function(results2) {
										if (results2) {
											var template = results2[0][0][0].template;
											var subject = results2[0][0][0].subject;
											template = template.replace('{{event.sitename}}', config.title);
											template = template.replace('{{event.user}}', results[1][0][0]['first_name'] + ' ' + results[1][0][0]['last_name']);
											template = template.replace('{{event.title}}', prdt.title);
											template = template.replace('{{event.amount}}', common.numberWithCommas(common.currencyConverter(req.body.wsprice)));
											template = template.replace('{{event.classifiedlink}}', global.carbike_url+prdt.bidnow_url+global.carbike_suffix_url);
											template = template.replace('{{event.siteurl}}' , config.url);
											template = template.replace('{{event.sitename2}}', config.title);
											carApi.sendMailMailgun(template, subject, results[1][0][0]['email']);
										} else {
											console.log("No templates named bid_received");
										}
									});
								} else {
									console.log('No Mail Delivery method is selected');
								}	
								 
					
													
								/*if((req.body.wsprice) == prdt.bprice && prdt.highbid == 0) { 
									q.all([carApi.awardListingPriceMet(req,config.mysql, q,req.body.id)]).then(function(successResults) {
											arr_sub_bid['awardedStatus'] = 1;
											arr_sub_bid['classifiedid'] = req.body.id;
											arr_sub_bid['status'] = emitArray['bidStatus'] = 'success';
											
											io.sockets.emit('bidUpdateToAllUsers', arr_sub_bid);	
											
											if(resMicSecExist[0].length == 1) {	
												 res.send( {'status': 1,'result':arr_sub_bid});				
												res.end();
												return false;							
											}
																
									}).fail(function(err) {
											arr_sub_bid['errorstack'] = err.stack
											console.log(err.stack);
									}).done();
								}
								else {*/
									arr_sub_bid['awardedStatus'] = 0;
									arr_sub_bid['classifiedid'] = req.body.id;
									arr_sub_bid['status'] = emitArray['bidStatus'] = 'success';
                                      dateFormat = require('dateformat');
                                    date = require('date-utils');
                                     datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
                                    var identifier = {'Date':datenow}
                                    identifier.Event = 'bid submited';
                                    identifier.Email = req.session.email;
                                    identifier.Description = 'bid submited  Successfully';
                                    identifier.Ip_address =req.headers['x-forwarded-for'] || req.connection.remoteAddress;
                                    identifier['User-agent']=   req.headers['user-agent'];        
                                    identifier.Remote_Host=req.headers.host;
                                    identifier['REQUEST_URI']='forwardapi/submitBidToAuction';
                                    identifier['HTTP_referer']=req.headers.referer;
                                    identifier.Data=req.body;
                                    common.tracelog(identifier);

									io.sockets.emit('bidUpdateToAllUsers', arr_sub_bid);

									if(resMicSecExist[0].length == 1) {	
										 res.send( {'status': 1,'result':arr_sub_bid});				
										res.end();
										return false;							
									}								
								//}          
								
							}).fail(function(err) {
								arr_sub_bid['errorstack'] = err.stack
								console.log(err.stack);									
							}).done();
						}
						else {
							req.body.duplicate_bid = resMicSecExist[0][ibid].id;
							bid.deleteDuplicateBidMicroSec(req, config.mysql, q);
							
							reservemeet = false;
							
							if (parseFloat(prdt.rprice) <= parseFloat(prdt.wprice)) {
								reservemeet = true;
							}
									
							/*if((parseFloat(prdt.bprice) - parseFloat(prdt.wprice)) <  parseFloat(prdt.iprice) && prdt.highbid == 0) {
								next_bid =  parseFloat(prdt.bprice);	
							}
							else {*/
								next_bid = parseFloat(prdt.wprice) + parseFloat(prdt.iprice);
							//}	
								
							if(req.session.userid == resMicSecExist[0][ibid].user_id) {
								var arr_sub_bid_f = {};								
								arr_sub_bid_f['status'] ='Fail';
								arr_sub_bid_f['error_code'] = 'invalidbid';
								arr_sub_bid_f['msg'] =  'Please submit higher bid!';
								arr_sub_bid_f['lastbid'] = prdt.wprice;
								arr_sub_bid_f['nextbid'] = next_bid;
								arr_sub_bid_f['allowHighBid'] =  prdt.highbid;
								arr_sub_bid_f['flastbid'] =  prdt.highbid;
								arr_sub_bid_f['fnextbid'] =  common.numberWithCommas(next_bid);
								arr_sub_bid_f['reservemeet'] = reservemeet;		
								arr_sub_bid_f['duplicatebidcount'] = resMicSecExist[0].length;
								arr_sub_bid_f['winnerid'] = resMicSecExist[0][0].user_id;						
							}
						}
												
						if(ibid == resMicSecExist[0].length-1 && resMicSecExist[0].length > 1) {	
							/*if((req.body.wsprice) == prdt.bprice && prdt.highbid == 0) { 
								arr_sub_bid['awardedStatus'] = 1;
								arr_sub_bid['classifiedid'] = req.body.id;
								arr_sub_bid['status'] = emitArray['bidStatus'] = 'success';
							}
							else {*/
								arr_sub_bid['awardedStatus'] = 0;
								arr_sub_bid['classifiedid'] = req.body.id;
								arr_sub_bid['status'] = emitArray['bidStatus'] = 'success';
							//}
							
							arr_sub_bid['duplicatebidcount'] = resMicSecExist[0].length;
							arr_sub_bid['winnerid'] = resMicSecExist[0][0].user_id;
							
							io.sockets.emit('bidUpdateToAllUsers', arr_sub_bid);
							res.send( {'status': 1,'result':arr_sub_bid});				
							res.end();
							return false;
						}
					}					
				}
				
		 	}).fail(function(err) {
					res.send({"status":"0","result":err.stack}); 
					console.log(err.stack);
					res.end();
					return false;
					throw err;
       	    }).done();
			
        }).fail(function(err) {
				res.send({"status":"0","result":err.stack}); 
				console.log(err.stack);
				res.end();
				return false;
				throw err;
        }).done();

    });
	
});

app.get(['/testSocket'], function(req, res) {
	socket.on('test', function(msg){
        console.log("Test Listiening app");
		io.sockets.emit('testresponsefromweb',  msg); 
    });
});

// Iframe for Delete Watchlist

app.get(['/apiDeleteWatchlist'], function(req, res) {
	
	var carApi = require('../module/forwardapi');
	
	if(typeof(req.param('user_id')) === 'undefined' || req.param('user_id') == '' || typeof(req.param('id')) === 'undefined' || req.param('id') == '') {
		res.send( {'status': 0,'msg':"Invalid Parameters"});		
		res.end();
		return false;
	}
	if(typeof(req.param('user_id')) !== 'undefined' && typeof(req.param('id') !== 'undefined')) {
		carApi.apiDeleteWatchlist(req, config.mysql, q);
		res.send( {'status': 1,'msg':"Successfully Deleted From watchlist"});	
		res.end();
		return false;
	}
});


// API for Watchlist

app.get(['/apiWatchlist'], function(req, res) {

	var carApi = require('../module/forwardapi');
	var arr_watch = {};
    if (typeof(req.param('user_id')) === 'undefined' || req.param('user_id') == '') {
		res.send( {'status': 0,'msg':'User Id Undefined'});
		res.end();
		return false;
    } else {
		
		 req.body.perlimit = typeof(req.param('perlimit')) !== 'undefined' ? req.param('perlimit') : 10;
         req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
	     req.body.user_id = typeof(req.param('user_id')) !== 'undefined' ? req.param('user_id') : 0;
		
        q.all([carApi.mobileiframeMywatchlist(req, config.mysql, q), carApi.iframeTotalMywatchlist(req, config.mysql, q)]).then(function(results) {

			arr_watch['totalcount'] = results[1][0].length;		
			arr_watch['perlimit'] =  req.body.perlimit ;		
			arr_watch['page'] = req.body.page
		
           	arr_watch['mywatchlist'] = carApi.apiBasicClassifiedFromat(results[0][0],1);
		    res.send( {'status': 1,'result':arr_watch});

         }).fail(function(err) {
			res.send({"status":0,"result":err.stack}); 
			res.end();
			return false;
			throw err;
		}).done();
    }
});

app.get(['/BidHistory/:id','/BidHistory/:id/:user_id'], function(req, res) {
    
    var carApi = require('../module/forwardapi');
    
	if (typeof(req.param('user_id')) !== 'undefined' && req.param('user_id') != '')   {
        req.body.user_id = req.param('user_id');
    } 
    if (typeof(req.param('id')) !== 'undefined' && req.param('id') != '')   {
        req.body.classified_array = req.param('id');
    } else {
        var arr = {
            'status': '0',
            'msg': 'Something went wrong'
        };
        res.send(arr);
        res.end();
        return false;
    }
    var bids = require('../module/bid');
             

    q.all([bids.bidHistory(req,config.mysql,q,0)]).then(function(results) {

           val_str=JSON.stringify(carApi.apiBidHistoryFromat(results[0][0],req));

        if (results[0][0].length > 0) {         
            
            res.send({'status': '0','bidhtmlloop' : carApi.apiBidHistoryFromat(results[0][0],req)});
        } else {
            var arr = {
                'status': '0',
                'msg': 'Something went wrong'
            };
            res.send(arr);
        }
        res.end();
        return false;
    }).fail(function(err) {
        console.log(err.stack);
        throw err;
    }).done();

});

// Iframe for Activebids
app.get(['/apiActivebids/'], function(req, res) {
	var carApi = require('../module/forwardapi');

	if (typeof(req.param('user_id')) === 'undefined') {
		res.send( {'status': 0,'msg':'User Id Undefined'});
		res.end();
		return false;
    }
    
	req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.perlimit = typeof(req.param('perlimit')) !== 'undefined' ? req.param('perlimit') : 10;
    req.body.user_id = typeof(req.param('user_id')) !== 'undefined' ? req.param('user_id') : 0;

    q.all([carApi.mobileiframeMyBids(req, config.mysql, q, 1, 'active'), carApi.mobileiframeMyBids(req, config.mysql, q, 0, 'active')]).then(function(results) {		 
		arr_active_bids = {};
       
	    arr_active_bids['totalcount'] = results[1][0].length;		
		arr_active_bids['perlimit'] =  req.body.perlimit ;		
		arr_active_bids['page'] = req.body.page
		
        arr_active_bids['myactivebids'] = carApi.apiClassifiedFromat(results[0][0],1);
		
 		res.send( {'status': 1,'result':arr_active_bids});
		res.end();
		return false;
		
    }).fail(function(err) {
        res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();
});


// API for MyBids (Won)

app.get(['/apiMybidsWon/'], function(req, res) {

	if (typeof(req.param('user_id')) === 'undefined') {
		res.send( {'status': 0,'msg':'User Id Undefined'});
		res.end();
		return false;
    }
	
	var carApi = require('../module/forwardapi');
    var dateFormat = require('dateformat');

    var data = carApi.carSearchPageNo(req, config.mysql, q);

	var arr_mybids = {};

    req.body.user_id = typeof(req.param('user_id')) !== 'undefined' ? req.param('user_id') : 0;
	
    req.body.perlimit = typeof(req.param('perlimit')) !== 'undefined' ? req.param('perlimit') : 10;
    req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;

    q.all([carApi.mobileiframeMyBids(req, config.mysql, q, 1, 'won'), carApi.mobileiframeMyBids(req, config.mysql, q, 0, 'won')]).then(function(results) {
		
		arr_mybids['totalcount'] = results[1][0].length;		
		arr_mybids['perlimit'] =  req.body.perlimit ;		
		arr_mybids['page'] = req.body.page
		
        arr_mybids['mywonbids'] = carApi.apiClassifiedFromat(results[0][0],1);
				
        res.send( {'status': 1,'result':arr_mybids});
		res.end();
		return false;

    }).fail(function(err) {
		res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();

});

// API for MyBids (Lost)

app.get(['/apiMybidsLost/'], function(req, res) {

	if (typeof(req.param('user_id')) === 'undefined') {
		res.send( {'status': 0,'msg':'User Id Undefined'});
		res.end();
		return false;
    }
	
	var carApi = require('../module/forwardapi');
    var dateFormat = require('dateformat');

    var data = carApi.carSearchPageNo(req, config.mysql, q);

	var arr_mybids = {};
	
    req.body.user_id = typeof(req.param('user_id')) !== 'undefined' ? req.param('user_id') : 0;
	req.body.perlimit = typeof(req.param('perlimit')) !== 'undefined' ? req.param('perlimit') : 10;
    req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
	
    q.all([carApi.mobileiframeMyBids(req, config.mysql, q, 1, 'lost'), carApi.mobileiframeMyBids(req, config.mysql, q, 0, 'lost')]).then(function(results) {		
		arr_mybids['totalcount'] = results[1][0].length;		
		arr_mybids['perlimit'] =  req.body.perlimit ;		
		arr_mybids['page'] = req.body.page
		
	    arr_mybids['mylostbids'] = carApi.apiClassifiedFromat(results[0][0],1);

        res.send( {'status': 1,'result':arr_mybids});
		res.end();
		return false;

    }).fail(function(err) {
		res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();

});

// search Filter API Details

app.get(['/searchFiltersMenu/'], function(req, res) {

	var carApi = require('../module/forwardapi');
	
	var arr_searchFilters = {};

    q.all([carApi.getCarManufacturesMob(req, config.mysql, q), carApi.getCarFuelMob(req, config.mysql, q), carApi.getCarLocationMob(req, config.mysql, q)]).then(function(results) {		
		
		arr_searchFilters['manufacturers'] = results[0][0];		
		arr_searchFilters['manufacturers'].unshift({"id_car_make":0,"make_name":"Select Manufacturers"});
		arr_searchFilters['fuel'] = results[1][0];	
		arr_searchFilters['fuel'].unshift({"id_car_fuel":0, "fuel_name":"Select Fuel"});	
		arr_searchFilters['location'] = results[2][0];
		arr_searchFilters['location'].unshift({"city_name":"Select City","id_city":0,"state_name":"Select State","id_state":0});
		
		console.log("Manufacturers "+arr_searchFilters['manufacturers']);
		
        val_str = JSON.stringify(arr_searchFilters);

		date = require('date-utils');
		datenow = common.dateConvertionSettings(new Date(),'YYYY-MM-DD HH:mm:ss')
		
        res.send( {'status': 1,'result':arr_searchFilters});
		res.end();
		return false;

    }).fail(function(err) {
		res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();
});

app.get(['/searchFilterGetModels/'], function(req, res) {

	var carApi = require('../module/forwardapi');
	
	var arr_get_models = {};
	
    q.all([carApi.getCarModelsMob(req, config.mysql, q)]).then(function(results) {		
		arr_get_models['filterModels'] = results[0][0];		
		arr_get_models['filterModels'].unshift({"id_car_model":0,"model_name":"Select Model","id_car_make":0});
        res.send( {'status': 1,'result':arr_get_models});
		res.end();
		return false;
    }).fail(function(err) {
		res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();

});

app.get(['/searchFilterGetcities/'], function(req, res) {

	var carApi = require('../module/forwardapi');
	
	var arr_get_cities = {};
	
    q.all([carApi.getCarCitiesMob(req, config.mysql, q)]).then(function(results) {		
		arr_get_cities['filtercities'] = results[0][0];		
		arr_get_cities['filtercities'].unshift({"id_city":0,"city_name":"Select City","id_state":0});
        res.send( {'status': 1,'result':arr_get_cities});
		res.end();
		return false;
    }).fail(function(err) {
		res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();

});


app.get(['/carSpecInfo/'], function(req, res) {

	var carApi = require('../module/forwardapi');
	
	var arr_car_spec = {};
	req.body.cid = (typeof( req.param('cid')) !== 'undefined' && req.param('cid') != '' && !isNaN(req.param('cid'))) ? req.param('cid') : 0;
	//req.body.cid = req.param('cid');
	if(req.body.cid  > 0) {
		q.all([carApi.getCarSpecifications(req, config.mysql, q)]).then(function(results) {	
		results[0][0][0].vehicle_km_driven=common.numberWithCommas(results[0][0][0].vehicle_km_driven);	
			arr_car_spec['carSpecifications'] = results[0][0];		
			res.send( {'status': 1,'result':arr_car_spec});
			res.end();
			return false;
		}).fail(function(err) {
			res.send({"status":0,"result":err.stack}); 
			res.end();
			return false;
			throw err;
		}).done();
	}
	else {
		var arr = {
			'status': 'fail',
			'msg': 'Invalid Classified Id'
		};
		res.send(arr);
		res.end();
		return false;
	}

});

app.post("/getReqToken",function(req,res){
    var users = require('../module/user');
    req.body.token = (typeof(req.body.token) == 'undefined') ? '' : req.body.token;

    q.all(users.saveToken(req,config.mysql,q)).then(function(checkStatus){
        console.log(checkStatus)
        res.json({'status' : 1,'token' :req.body.token,'user_id' : req.body.user_id,res : checkStatus });

        res.end();

    }).fail(function(err) {
        res.send({"status":0,"result":err.stack});
        res.end();
        return false;
        throw err;
    }).done();


});

app.get("/getUnreadNotifications",function(req,res){
    var users = require('../module/user');
    req.body.user_id = (typeof(req.query.user_id) == 'undefined') ? '' : req.body.token;

    q.all([users.getUnreadNotifications(req,config.mysql,q,1),users.getUnreadNotifications(req,config.mysql,q,0)]).then(function(checkStatus){

        res.json({'status' : 1,'notify_details' :checkStatus[0][0],'notify_count' : checkStatus[1][0].length});

        res.end();

    }).fail(function(err) {
        console.log(err.stack);
        res.send({"status":0,"result":err.stack});
        res.end();
        return false;
        throw err;
    }).done();


});

app.post("/updateUnreadNotifications",function(req,res){
    var users = require('../module/user');
    req.body.notify_id = (typeof(req.body.notify_id) == 'undefined') ? '' : req.body.notify_id;

    q.all([users.updateUnreadNotifications(req,config.mysql,q)]).then(function(checkStatus){

        res.json({'status' : 1});

        res.end();

    }).fail(function(err) {
        console.log()
        res.send({"status":0,"result":err.stack});
        res.end();
        return false;
        throw err;
    }).done();


});

app.get(['/searchFiltersParentCategory/'], function(req, res) {

	var carApi = require('../module/forwardapi');
	
	var arr_searchFilters = {};
    q.all([carApi.getFilterParentCategory(req, config.mysql, q)]).then(function(results) {		
		
		arr_searchFilters['parentcategory'] = results[0][0];		
		arr_searchFilters['parentcategory'].unshift({"id":0,"name":"All Categories"});
				
        val_str = JSON.stringify(arr_searchFilters);

        res.send( {'status': 1,'result':arr_searchFilters});
		res.end();
		return false;

    }).fail(function(err) {
		res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();
});

app.get(['/searchFiltersChildCategory/'], function(req, res) {

	var carApi = require('../module/forwardapi');
	
	var arr_get_child= {};
	req.body.cid = (typeof( req.param('cid')) !== 'undefined' && req.param('cid') != '' && !isNaN(req.param('cid'))) ? req.param('cid') : 0;
    q.all([carApi.getFilterChildCategory(req, config.mysql, q)]).then(function(results) {	
		if(results[0][0].length >0)	 {
			arr_get_child['childcat'] = results[0][0];		
			res.send( {'status': 1,'result':arr_get_child});
	    }
      	else {
    		 res.send( {'status': 0,'result':"No Child Found"});
	  	}
		res.end();
		return false;
    }).fail(function(err) {
		res.send({"status":0,"result":err.stack}); 
	    res.end();
		return false;
        throw err;
    }).done();

});


module.exports = app; 