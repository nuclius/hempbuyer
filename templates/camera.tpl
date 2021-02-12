<html> 
  <head></head> 
  <body> 
    <div id='myPublisherDiv'></div>
    
     
    <div id='subscribersDiv'></div> 
    
    <script src='//static.opentok.com/v2/js/opentok.min.js'></script> 
    <script> 
     var apiKey = '45517512';
     var sessionId = '{$session}'; 
     var token = '{$token}';
	 var sessionId_seller = '{$session_seller}'; 
     var token_seller = '{$token_seller}';
     var session = session_seller = '';
     var publisher = '';
	 function connectMe()
	 {   
	      session = OT.initSession(apiKey, sessionId);
	      session.on({ 
			  streamCreated: function(event) { 
				session.subscribe(event.stream, 'subscribersDiv', { insertMode: 'append' }); 
			  } 
		  }); 
		  
		  session.connect(token, function(error) {
			if (error) {
			 //console.log(error.message);
			} else {
			  session.publish('myPublisherDiv', { width: 320, height: 240 }); 
			}
		  });
	 }
	 function connectSeller()
	 {   
	      session2 = OT.initSession(apiKey, sessionId_seller);
	  
		  session2.on({ 
			  streamCreated: function(event) { 
				session.subscribe(event.stream, 'subscribersDiv', { insertMode: 'append' }); 
			  } 
		  }); 
		  session2.connect(token_seller, function(error) {
			if (error) {
			 //console.log(error.message);
			} else {
			  session2.publish('subscribersDiv', { width: 320, height: 240 }); 
			}
		  });
	 }
	 connectMe();
	 connectSeller();
	 function publish_me()
	 {
	 	//console.log('publish');
	 	 
          connectMe();
	 }
	 function unpublish_me()
	 {
	 	//console.log('unpublish');
         session.disconnect();
         session.off();
        //console.log(6);

	 }
    </script>
    <input type="text" id="no" value="{$id}" />
    <div class="Seller" onClick="window.location='{$config.url}camera/iamtheseller/'+document.getElementById('no').value+'/publisher'">I am the Seller</div>
     <div class="Seller"  id="publish_me" onclick="publish_me();">Publish Me</div>

     <div class="Seller" id="unpublish_me" onclick="unpublish_me();">UnPublish Me</div>   
  </body> 
</html>  