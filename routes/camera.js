// JavaScript Document
'use strict';

module.exports = function(OpenTok)
{
	console.log(2);
	var express  = require('express');
	var app = express.Router();
	var common   = require('../module/common');
	var products = require('../module/products');

	var randomUsername = require('../module/randos');
	var apiKey = '45517512';
	var apiSecret = '5fb964e5627b617df1a11539d69ca630217fe127';
	//require('dotenv').load();
	
	app.get('/twiliotoken/:id/:name', function(request, response) {
	    var identity = request.param('name');
	    
	    // Create an access token which we will sign and return to the client,
	    // containing the grant we just created
	    if(typeof(cameraId[request.param('id')]) === 'undefined')
		{
			 var  token = new AccessToken(	        
		    	'ACc93952f6fc6e6e9c48a88d740c75e68e',
		        'SKec589e9d2f51d32258c29d1444a3d712',	        
		        'hiPpP5eDE6O53eP92BaHpprWez9rJycx'
		    );

			 cameraId[request.param('id')]  = token;

			
		} else
		{

			 var token = cameraId[request.param('id')];
		}

	    // Assign the generated identity to the token
	    token.identity = identity;
        
        var ConversationsGrant = AccessToken.ConversationsGrant;
	    var grant = new ConversationsGrant();
        grant.configurationProfileSid = 'VSc154892143470aae38eddc51056dddc4';
        token.addGrant(grant);
        var apped = {
	        identity: identity,
	        token: token.toJwt()
	    };
	    // Serialize the token to a JWT string and include it in a JSON response
	    console.log(apped)
	    response.send(apped);
	});
    
	app.get('/test/:id/:name',function(req, res){
		         $arr.id = req.param('id'); 
		          $arr.name = req.param('name'); 
		        common.tplFile('twilio.tpl');
					    common.headerSet(1);
					    common.loadTemplateHeader(req,res,$arr);
				  
	});
	
	app.get(['/iamtheseller/:id/:seller'], function(req, res){
		$arr.id = req.param('id');
		if(typeof(cameraId) === 'undefined')
		{
			res.send(JSON.stringify({'error':'No Conference Found'}));
			res.end;
			
		}
		var seller = req.param('seller');
		if(typeof(cameraId[req.param('id')]) === 'undefined')
		{
			 var opentok = new OpenTok(apiKey, apiSecret);
              opentok.createSession(function(error, session) {
					
					if (error) { 
					  res.send(error);res.end();return false;
					}
					//session.myresult = 'session';
					
					cameraId[req.param('id')+'_seller'] = session.sessionId;
					$arr.session_seller = cameraId[req.param('id')+'_seller'];
					  // save the sessionId
					$arr.token_seller = opentok.generateToken($arr.session_seller,{
					  role :       'publisher',
					  expireTime : (new Date().getTime() / 1000)+(7 * 24 * 60 * 60),
					  data :       'userid=1,seller=1'
					});
					opentok.createSession(function(error, session) {
					
						if (error) { 
						  res.send(error);res.end();return false;
						}
						//session.myresult = 'session';
						
						cameraId[req.param('id')] = session.sessionId;
						$arr.session = cameraId[req.param('id')];
						  // save the sessionId
						$arr.token = opentok.generateToken($arr.session,{
						  role :       seller,
						  expireTime : (new Date().getTime() / 1000)+(7 * 24 * 60 * 60),
						  data :       'userid=1,seller=1'
						});
						common.tplFile('camera.tpl');
					    common.headerSet(1);
					    common.loadTemplateHeader(req,res,$arr);
				   });
					
					
			   });
			   
		}
		else
		{
			    var opentok = new OpenTok(apiKey, apiSecret);
				$arr.session_seller = cameraId[req.param('id')+'_seller'];
				  // save the sessionId
				$arr.token_seller = opentok.generateToken($arr.session_seller,{
				  role :       'subscriber',
				  expireTime : (new Date().getTime() / 1000)+(7 * 24 * 60 * 60), // in one week
				  data :       'userid=1,seller=1'
				});
				
				$arr.session = cameraId[req.param('id')];
				  // save the sessionId
				$arr.token = opentok.generateToken($arr.session,{
				  role :       seller,
				  expireTime : (new Date().getTime() / 1000)+(7 * 24 * 60 * 60), // in one week
				  data :       'userid=1,seller=1'
				});
				common.tplFile('camera.tpl');
				common.headerSet(1);
				common.loadTemplateHeader(req,res,$arr);
			
		}
		
		
	});
	console.log(app);
return app;
}