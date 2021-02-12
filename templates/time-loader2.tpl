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

<script>
timeProjects['{$val.id}'] = new Date('{$datenow}');   
clearvars['{$val.id}'] = setInterval(function(){});
clocks['{$val.id}'] = document.getElementById('mys{$val.id}');
targetDates['{$val.id}'] = new Date('{$val.closed}'); 
 
  clocks['{$val.id}'].innerHTML = countdown(targetDates['{$val.id}']).toString();
  setIntreval('{$val.id}','{$val.market_status}');

  var pid = '{$val.id}';

      var dt = '{$val.closed}';
     ////console.log(dt);
       var resultss = {
            id: pid,
            date: dt,
            price:'{$val.wprice}',
      pric_l : $('.pric_l').html(),
      bid_history :  $('.bid_history').html()    
        }
    //console.log(resultss);
    socket.on('bidAddtime', function(msg){
        var checkval = '#price'+msg.id;

    // meee(msg.id,msg.date);
       
    
 if(typeof(msg.price)!='undefined'&&msg.price>0 && '#price{$val.id}' == checkval)
 {

         $('#price{$val.id}').html(msg.price);
         ////console.log("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");

 }


    meee2(msg.id,msg.date,msg.price);
    });

   // socket.emit('bidAddtime', resultss);
    


  </script> 

  
