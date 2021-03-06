<!--============================================================================*\
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
\*============================================================================ -->

<script type="text/javascript" src="{$config.url}/js/timecircle.js"></script>
<script type="text/javascript" src="{$config.url}/js/twilio.min.js"></script>
<script type="text/javascript" src="{$config.url}/js/countdownnew.js"></script>

<!-- <script src="{$config.url}/js/jquery.bxslider.min.js"></script> --> <!-- 16 KB -->
<script src="{$config.url}/js/responsiveslides.min.js"></script>
<script src="{$config.url}/js/jquery.zoom.min.js"></script>
<script language="javascript" type="text/javascript">
var dataMsg = {
  name: '{$name}',
  id: '{$id}',
  refresh :'{$seller}',
  seller :'{$seller}',
  disconnect : 0,
  winner : 0
};
var beforeload = (new Date()).getTime();
var connected_user = false;
var converstaion_root = '';
var already_connected = false;
var meeting_user = false;
var timer = null,
            startTime = null;
var conversationsClient;
var activeConversation;
var previewMedia = false;
var identity;

// Check for WebRTC
			
$(window).load(function() {
	if (!navigator.webkitGetUserMedia && !navigator.mozGetUserMedia) {
    alert('WebRTC is not available in your browser.');
}
var afterload = (new Date()).getTime();
addseconds = (afterload-beforeload) / 1000;


          
if (!previewMedia) {
        previewMedia = new Twilio.Conversations.LocalMedia();
        Twilio.Conversations.getUserMedia().then(
        function (mediaStream) {
            previewMedia.addStream(mediaStream);
			$('#local-media').append('<span class="{$name} videoFrame"><div class="uname">Your Video</div></span>');
            previewMedia.attach('#local-media .{$name}');
        },
        function (error) {
           //console.error('Unable to access local media', error);
            log('Unable to access Camera and Microphone');
        });
		
 };
});
$(function()
{
	 loadMeetingSchedule(0);
});
function loadMeetingSchedule(id)
{
    var startFunction = function()
	{
		//console.log(5);
	    $('.schedule').html('Meeting Started');
		
		
	};
   $("#DateCountdown").TimeCircles({
	'ref_date' : new Date('{$projects.datenow}'),
	'curDate' : new Date('{$projects.addeddate}'),
	'id':'DateCountdown',
	'count_past_zero' : true,
	'count_reverse' : true,
	'seller':'{$seller}',
	'stopRunFunction' : startFunction,
	'startUserFunction': function()
	{
		meeting_user = true;
		
		$('.schedule').html('Meeting Started');	
		if((!meeting_user || !connected_user) && '{$seller}' == 0)
		{
			$('#DateCountdown').html('<div class="text-center text-danger">>Request Seller to add you in meeting through chat</div>');
		}
		loadBidStart();
	}
   });
	
}
function loadBidStart()
{
	console.log(meeting_user);
	console.log(connected_user);
 if(meeting_user && connected_user && !already_connected)
 {
	already_connected = true;
	$('#DateCountdown').html('{if $seller != 1}<button class="bidnow btn btn-success">Bid Me : $<span>{$projects.wprice+$bidincrement}</span></button> {/if}'); 
	$('.bidnow').on('click',function()
	{
	   var params = { amount:parseInt($('.project_price').html())+{$bidincrement},name:'{$name}' };
	   $(this).hide();
	  //console.log(params);
	   $.ajax({
		method:'POST',
		url:'{$config.url}/product/video/bid/{$id}',
		data:params,
		dataType:"JSON",
		success : function(data)
		{
		
			if(data.error != '')
			{
			  alert(data.error);
			  $('.bidnow').show();	
			  return false;	
			}
			var resultss = {
				id: '{$id}',
				price: params.amount,
				name:params.name
			}
			console.log(resultss);
	
			socket.emit('bidAddtime', resultss);
		}
	   });	
		
	});
 }
	
}
function updateProgress(seconds,cnt) {
            var remaining = seconds - (Date.now() - startTime) / 1000;
			//console.log(remaining);
            progress.value(remaining);
            if (remaining <= 0) {
			 if(cnt == 1)
			 {
				 
				 $('.bidnow').remove();
				 
			 }
                clearInterval(timer);
            }
        }

</script>
<script src="{$config.url}/js/twilio.common.js"></script><script src="{$config.url}/js/twilio.conversation.js"></script>
<script language="javacsript" type="text/javascript">
socket.on('callConf',function(msg_p)
{
	console.log(msg_p);
	if(msg_p.id == '{$id}')
	{
	 $('#add-number').html('Call Now '+msg_p.phone);
	 $('#add-number').off();
	 $('#add-number').show();
	}
});
socket.on('userOnline', function (msg) {
	console.log(msg);
	if(msg.name == '{$name}' && msg.disconnect == 1 && msg.id == '{$id}')
	{
	  //conversationsClient.disconnect();
	 //console.log('disconnect');
	 //console.log(conversation_root);
	  conversation_root.disconnect();
	}
	else if (msg.seller == 1 && msg.disconnect == 0 && msg.id == '{$id}' && msg.winner == 1)
	{
		
		         $('.schedule').html('Meeting Closed');
		         $('#BidCountdown').countdown360().stop();
		         $('.topper').parent().append('<img src="{$config.url}/images/trophy.png" />');
				 $('#BidCountdown').html('<img src="{$config.url}/images/soldout.png" style="width:100%;" />');
		
	}
	else if('{$seller}' ==  1 && msg.id == '{$id}' && msg.name != '{$name}'  && msg.disconnect == 0)
	{
		$('.'+msg.name).remove();
		$('.logger').append('<div class="row '+msg.name+'"><div class="text-warning col-md-6">'+msg.name+'</div><div class="text-success col-md-6 cursor" style="cursor:pointer;" onclick="connect(\''+msg.name+'\')">Connect</div></div>');
	}
	else if('{$seller}' !=  1 && msg.refresh == 1  && msg.disconnect == 0 && msg.id == '{$id}')
	{
	 //console.log(2);	
	  window.location.reload();	
	}
	
});

socket.on('bidAddtime', function (msg) {
	if(msg.id == '{$id}')
	{
		$('.videoFrame .uname.topper').removeClass('topper');
		$('.videoFrame.'+msg.name+' .uname').addClass('topper');
		$('.project_price').html(msg.price);
		console.log('{$bidincrement}');
		$('.bidnow span').html(parseInt(msg.price)+parseInt('{$bidincrement}'));
		$('.sbidprice').removeClass('sbidprice');
		$('.bidprice').html(msg.price).addClass('sbidprice');
		loadMeetingSchedule(1);
		$('.bids').prepend('<div class="col-md-12"><div class="col-md-6 text-danger">'+msg.name+'</div><div class="col-md-6 text-danger">$'+msg.price+'</div></div>');
		 $("#BidCountdown").countdown360({
       	 radius      : 60,
         seconds     : 10,
         fontColor   : '#FFFFFF',
         autostart   : false,
         onComplete  : function () {  
				 {if $seller == 1}closeProject('{$id}'){/if}
				 
		 }
	  }).start();
	}
	if(msg.name == '{$name}')
	{
		$('.bidnow').hide();
	}
	else
	{
		$('.bidnow').show();
	}
});
$(function()
{

	  $('#productInfo').hide();
$('#add-number').on('click',function()
{
	var params = {};
	$.ajax({
	method:'GET',
	url:'{$config.url}/product/calltoken/{$id}/{$name}',
	data:params,
	dataType:"JSON",
	success : function(data)
	{   
	    var msg_phone = { 
		                  phone:data.phone,
		                  id:'{$id}' 
		                 };
		console.log(msg_phone);
	    socket.emit('callConf', msg_phone);
		console.log(msg_phone);
		
	}
});
});
});



$.getJSON('/product/twiliotoken/{$projects.id}/{$name}', function(data) {

   //console.log(data);
    identity = data.identity;
    var accessManager = new Twilio.AccessManager(data.token);
   //console.log(data.token)
   
    // Check the browser//console to see your generated identity. 
    // Send an invite to yourself if you want! 
   //console.log(identity);
   //console.log(accessManager);
    // Create a Conversations Client and connect to Twilio
    conversationsClient = new Twilio.Conversations.Client(accessManager);
   //console.log(conversationsClient);
    conversationsClient.listen().then(clientConnected,function() {
       //console.log('Connected to Twilio!');
    }, function (error) {
       //console.log('Could not connect to Twilio: ' + error.message);
    });
});

// Successfully connected!
function clientConnected() {
    log("Connected to Twilio. Listening for incoming Invites as '" + conversationsClient.identity + "'");
	console.log(dataMsg);
    socket.emit('userOnline',dataMsg);
    conversationsClient.on('invite', function (invite) {
        log('Incoming invite from: ' + invite.from);
		$('.bidnow').show();
        invite.accept().then(conversationStarted);
    });

    // Bind button to create conversation
   	
}

// Conversation is live
function conversationStarted(conversation) {
	conversation_root = conversation;
    log('In an active Conversation');
	connected_user = true;
	loadBidStart();
    activeConversation = conversation;
    // Draw local video, if not already previewing
    if (!previewMedia) {
        conversation.localMedia.attach('#local-media');
    }

    // When a participant joins, draw their video on screen
    conversation.on('participantConnected', function (participant) {
		
		$('#remote-media').append('<span class="'+participant.identity+' videoFrame search_category"><div class="uname">'+participant.identity+'</div></span>');
		$('.logger .'+participant.identity).remove();
		$('.connecter').append('<div class="row '+participant.identity+'"><div class="text-warning col-md-6">'+participant.identity+'</div><div class="text-success col-md-6 cursor" style="cursor:pointer;"></div></div>');
        log("Participant '" + participant.identity + "' connected");
        participant.media.attach('#remote-media .'+participant.identity);
    });

    // When a participant disconnects, note in log
    conversation.on('participantDisconnected', function (participant) {
		$('.connecter .'+participant.identity).remove();
		$('#remote-media .'+participant.identity).remove();
        log("Participant '" + participant.identity + "' disconnected");
    });

    // When the conversation ends, stop capturing local video
    conversation.on('ended', function (conversation) {
		$('.connecter .'+conversationsClient.identity).remove();
		
		$('#remote-media .'+participant.identity).remove();
		
        
        log("Connected to Twilio. Listening for incoming Invites as '" + conversationsClient.identity + "'");
        conversation.localMedia.stop();
        conversation.disconnect();
        activeConversation = null;
    });
}

//  Local video preview

    


// Activity log
function log(message) {
	console.log(message);
	{if $seller == 1}
    $('#log-content').append('<br />'+message+'<br />');
	{/if}
}

</script>
<div id="start" style="display:none;"></div>
<script language="javascript">


{if $seller ==  1}
     function disconnect(inviteTo)
	{
		dataMsg.name = inviteTo;dataMsg.disconnect = 1;dataMsg.refresh = 0;
		socket.emit('userOnline',dataMsg);
		dataMsg.name = '{$name}';
	}
    function connect(inviteTo)
	{
       //console.log(inviteTo);
        if (activeConversation) {
            // Add a participant
            activeConversation.invite(inviteTo);
            } else {
            // Create a conversation
            var options = {};
            if (previewMedia) {
                options.localMedia = previewMedia;
            }
            conversationsClient.inviteToConversation(inviteTo, options).then(conversationStarted, function (error) {
                log('Unable to create conversation');
               //console.error('Unable to create conversation', error);
            });
        }
	}
   {/if}
{if $seller == 1}   
function closeProject(id)
{
	var params = {};
	$.ajax({
	method:'GET',
	url:'{$config.url}/product/video-conference-close/{$id}',
	data:params,
	dataType:"JSON",
	success : function(data)
	{   
	    if(data.error == '')
		{
			dataMsg.refresh = 0;dataMsg.winner = 1; 
			socket.emit('userOnline',dataMsg);
		}
		else
		{
		  alert(data.error);	
		}
	}
	});
}
{/if}

var myArray = ['#ff0000','#00ff00','#0000ff','#ccc','#666','#9C6','#333','#939'];
var rand = myArray[Math.floor(Math.random() * myArray.length)];
var dataChat = { bootup:1,data:'',id:'{$id}',color:rand};
socket.on('chatOnline',function(chatData)
{
	console.log(chatData);
	if(chatData.id == '{$id}')
	{
	   
	    if(chatData.bootup == 1 && '{$seller}'  == 1)
		{   
		    dataChat.bootup = 2;
		    dataChat.data = $('.msg_group').html() 
			socket.emit('chatOnline',dataChat);
			dataChat.bootup = 0;
		}
		 else if(chatData.bootup == 2 && '{$seller}' != 1 && dataChat.bootup == 1)
		{
			
			$('.msg_group').html(chatData.data+'<br />'); 
			dataChat.bootup = 0;
		}
		else if(chatData.bootup == 0 && typeof(chatData.name) !== 'undefined')
		{
			
			$('.msg_group').append('<div class="message-box"><div class="visitor-message" data-color="'+chatData.color+'" style="background-color:'+chatData.color+';"><span class="visitor-message-tip" style="border-right-color:'+chatData.color+'"></span>'+chatData.data+'<span class="visitor_name"> Sent By '+chatData.name+'</span></div><br /></div>');
		}
		
	}
	
});
socket.emit('chatOnline',dataChat);
function sendChatMsg()
{
	dataChat.bootup = 0;
	dataChat.name = '{$name}';
	dataChat.data = $('.chatmsg').val();
	socket.emit('chatOnline',dataChat);
	$('.chatmsg').val('');
}
function chatOpen(obj)
{
  var chat = $(obj).find('i').hasClass('fa-sort-desc');
  if(chat)
  {
	  $(obj).find('i').addClass('fa-sort-asc').removeClass('fa-sort-desc');
	  $('.chat-content').hide();
  }
  else
  {
	  $(obj).find('i').addClass('fa-sort-desc').removeClass('fa-sort-asc');
	  $('.chat-content').show();
  }
}
function inviterList()
{
	var params = { id:'{$id}' };
	$.ajax({
	method:'GET',
	url:'{$config.url}/product/video-invite-list/{$id}',
	data:params,
	dataType:"JSON",
	success : function(data)
		{  
		    var d = $('.invitehide tbody').html();
			$('#invitorlist tbody').html('');
			for(i in data)
			{
				data[i].accept = ((data[i].accept == 1) ? 'Accept' : (data[i].accept == 2) ? 'Decline' : 'Not Replied'); 
				$('#invitorlist tbody').append(d.replace('##name',data[i].name).replace('##email',data[i].email).replace('##accept',data[i].accept));
				
			}
		
		
		}
	});
}
</script>
