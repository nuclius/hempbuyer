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

<html> 
  <head></head> 
  <body> 
  <style type="text/css">
  * {
  box-sizing:border-box;
}

html, body {
  padding:0;
  margin:0;
  height:100%;
  width:100%;
  color:#dedede;
  background-color: #849091;
  font-family: 'Helvetica Neue', Helvetica, sans-serif;
}

header {
  width:100%;
  position:absolute;
  text-align:center;
  bottom:20px;
}

header a, header a:visited {
  font-size:18px;
  color:#dedede;
  text-decoration:none;
}

header a:hover {
  text-decoration:underline;
}

section {
  height:70%;
  background-color:#2B2B2A;
}

section input {
  display:block;
  height:52px;
  width:800px;
  margin:10px auto;
  outline:none;
  background-color:transparent;
  border:none;
  border-bottom:1px solid #2B2B2A;
  padding:0;
  font-size:42px;
  color:#eee;
}

#messages {
  background-color:#232323;
  padding:10px;
  height:100%;
  width:800px;
  margin:0 auto;
  overflow-y:auto;
}

#messages p {
  margin:5px 0;
  padding:0;
}

.info {
  margin:5px 0;
  font-style:italic;
}

.message-container {
  margin:5px 0;
  color:#fff;
}

.message-container .username {
  display:inline-block;
  margin-right:5px;
  font-weight:bold;
  color:#849091;
}

.me, .username.me {
  font-weight:bold;
  color:cyan;
}

.message-container .username.me {
  display:inline-block;
  margin-right:5px;
}</style>
  <div id="remote-media"></div>
  <div id="controls">
    <div id="preview">
      <p class="instructions">Hello Beautiful</p>
      <div id="local-media"></div>
      <button id="button-preview">Preview My Camera</button>
    </div>
    <div id="invite-controls">
      <p class="instructions">Invite another Video Client</p>
      <input id="invite-to" type="text" placeholder="Identity to send an invite to" />
      <button id="button-invite">Send Invite</button>
    </div>
    <div id="log">
      <p>&gt;&nbsp;<span id="log-content">Preparing to listen</span>...</p>
    </div>
  </div><!-- /controls --> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  <script src="https://media.twiliocdn.com/sdk/js/common/v0.1/twilio-common.min.js"></script>
  <script src="https://media.twiliocdn.com/sdk/js/conversations/v0.13/twilio-conversations.min.js"></script>
<script language="javacsript" type="text/javascript">
var conversationsClient;
var activeConversation;
var previewMedia;
var identity;

// Check for WebRTC
if (!navigator.webkitGetUserMedia && !navigator.mozGetUserMedia) {
    alert('WebRTC is not available in your browser.');
}

$.getJSON('/camera/twiliotoken/{$id}/{$name}', function(data) {
   //console.log(data.token);
    identity = data.identity;
    var accessManager = new Twilio.AccessManager(data.token);
 
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
    document.getElementById('invite-controls').style.display = 'block';
    log("Connected to Twilio. Listening for incoming Invites as '" + conversationsClient.identity + "'");

    conversationsClient.on('invite', function (invite) {
        log('Incoming invite from: ' + invite.from);
        invite.accept().then(conversationStarted);
    });

    // Bind button to create conversation
    document.getElementById('button-invite').onclick = function () {
        var inviteTo = document.getElementById('invite-to').value;
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
    };
}

// Conversation is live
function conversationStarted(conversation) {
    log('In an active Conversation');
    activeConversation = conversation;
    // Draw local video, if not already previewing
    if (!previewMedia) {
        conversation.localMedia.attach('#local-media');
    }

    // When a participant joins, draw their video on screen
    conversation.on('participantConnected', function (participant) {
        log("Participant '" + participant.identity + "' connected");
        participant.media.attach('#remote-media');
    });

    // When a participant disconnects, note in log
    conversation.on('participantDisconnected', function (participant) {
        log("Participant '" + participant.identity + "' disconnected");
    });

    // When the conversation ends, stop capturing local video
    conversation.on('ended', function (conversation) {
        log("Connected to Twilio. Listening for incoming Invites as '" + conversationsClient.identity + "'");
        conversation.localMedia.stop();
        conversation.disconnect();
        activeConversation = null;
    });
}

//  Local video preview
document.getElementById('button-preview').onclick = function () {
    if (!previewMedia) {
        previewMedia = new Twilio.Conversations.LocalMedia();
        Twilio.Conversations.getUserMedia().then(
        function (mediaStream) {
            previewMedia.addStream(mediaStream);
            previewMedia.attach('#local-media');
        },
        function (error) {
           //console.error('Unable to access local media', error);
            log('Unable to access Camera and Microphone');
        });
    };
};

// Activity log
function log(message) {
    document.getElementById('log-content').innerHTML = message;
}

</script>
</body> 
</html>  