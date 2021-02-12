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
		
		
		$('.schedule').html('Meeting Started');	
		
	}
   });
	
}



</script>
