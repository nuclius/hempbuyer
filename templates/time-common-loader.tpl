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

<script src="{$config.url}/js/countdown.js"></script>
<script type="text/javascript"> 
var clock = [];  
var targetDate = [];  
var clearvar = []; 
var timeProject = []; 
function setIntreval(id,market_status)
{
   clearvar[id] =  setInterval(function(){
         

      timeProject[id] = new Date(timeProject[id]);
      
      if(targetDate[id] >= timeProject[id])
      {
         clock[id].innerHTML = countdown(targetDate[id]).toString();
      }
      else
      {
        
          
          
           clock[id].innerHTML = 'Closed';
      }
      
  }, 1000);
}
function meee(id,dateee,price)
  {  
 // id = '126';
 // alert(dateee);
    clearInterval(clearvar[id]);
    clock[id] = document.getElementById('my'+id)
    , targetDate[id] = new Date(dateee); // Jan 1, 2050;
 
    clock[id].innerHTML = countdown(targetDate[id]).toString();
     setIntreval(id);
    
  }
</script>