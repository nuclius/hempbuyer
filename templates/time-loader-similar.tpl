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

<!-- <script async> -->
  <script async>
    var productIdData = '{$val.id}' ? '{$val.id}' : '{$projects.id}';
    var closedData = '{$val.closed}' ? '{$val.closed}' :
      '{$projects.closed}' //'{$val.closed}' ? '{$val.closed}' : '{$projects.closed}'
    var marketStatusData = '{$val.market_status}' ? '{$val.market_status}' :
      '{$projects.market_status}' //'{$val.market_status}' ? '{$val.market_status}' : '{$projects.market_status}'
  
    timeProject[productIdData] = currentTime; //new Date('{$datenow}');   
    clearvar[productIdData] = setInterval(function () {});
    clockws[productIdData] = document.getElementById('mysimilar' + productIdData);
  
    targetDate[productIdData] = new Date(new Date(closedData.split('GMT')[0]));
    
    if (marketStatusData == 'open') {
      //clock[productIdData].innerHTML = countdown(targetDate[productIdData]).toString();
      setIntreval(productIdData, marketStatusData);
    } else {
      //clockws[productIdData] = document.getElementById('mysimilar' + productIdData);
      if(productIdData && productIdData.length > 0) {
        document.getElementById('mysimilar' + productIdData).innerHTML = 'closed';
  
        if(document.getElementById('myBid' + productIdData)) {
          document.getElementById('myBid' + productIdData).style.display = "none";
          document.getElementById('myBid' + productIdData).style.visibility = "hidden";
        }
      }
    }
  
    function setIntreval(t, e) {
      for (;;) { 
          // if (100 == (new Date).getMilliseconds()) {
            if (true) {
  
              clearvar[t] = setInterval(function() {
                  if (timeProject[t] = currentTime, targetDate[t] >= timeProject[t]) {
                      if (document.getElementById("mysimilar" + t))
                          if ($('[id="mysimilar' + t + '"]').length > 1)
                              for (var e = 0; e < $('[id="mysimilar' + t + '"]').length; e++) document.getElementsByClassName("mysimilar" + t) && document.getElementsByClassName("mysimilar" + t)[e] && (document.getElementsByClassName("mysimilar" + t)[e].innerHTML = countTimer(new Date(timeProject[t]), targetDate[t]));
                          else document.getElementById("mysimilar" + t).innerHTML = countTimer(new Date(timeProject[t]), targetDate[t])
                  } else {
                      var a = window.location.pathname;
                      // if(clockws[t])
                      // clockws[t].innerHTML = "Closed", a.toString().toLowerCase().indexOf("/product/view/") >= 0 && (clearInterval(clearvar[t]), location.reload())
  
                      if(clockws[t]) {
                      //clockws[t].innerHTML = "Closed", a.toString().toLowerCase().indexOf("/product/view/") >= 0 && (clearInterval(clearvar[t]));
                        clockws[t].innerHTML = "Closed", a.toString().toLowerCase().indexOf("/product/view/") >= 0 && (clearInterval(clearvar[t]));
                      }
                      
                      if(document.getElementById('myBid' + t)) {
                        document.getElementById('myBid' + t).style.display = "none";
                        document.getElementById('myBid' + t).style.visibility = "hidden";
                      }
                  }
              }, 1e3);
              break
          }
      }
    }
  
  function countTimer (start,end){
          let t = end - start;
          let days = Math.floor(t / (1000 * 60 * 60 * 24));
          let hours = Math.floor((t % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
          let mins = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60));
          let secs = Math.floor((t % (1000 * 60)) / 1000);
  
  
          var displayDate = '';
  
          if(days > 0){
              displayDate += days + 'D : ';
          }
  
          displayDate += ("0"+hours).slice(-2) + 'H : '+ ("0"+mins).slice(-2) + 'M : '+ ("0"+secs).slice(-2) + ' S';
  
          return displayDate;
      }
  
  
  </script>