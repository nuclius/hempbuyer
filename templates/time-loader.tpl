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
  var productIdData = '{$projects.id}' ? '{$projects.id}' : '{$val.id}';
  var closedData = '{$projects.closed}' ? '{$projects.closed}' :
    '{$val.closed}' //'{$val.closed}' ? '{$val.closed}' : '{$projects.closed}'
  var start_data = '{$projects.start_date}' ? '{$projects.start_date}' : '{$val.start_date}';
  var marketStatusData = '{$projects.market_status}' ? '{$projects.market_status}' :
    '{$val.market_status}' //'{$val.market_status}' ? '{$val.market_status}' : '{$projects.market_status}'

  timeProject[productIdData] = currentTime; //new Date('{$datenow}');   
  clearvar[productIdData] = setInterval(function () {});
  clockws[productIdData] = document.getElementById('my' + productIdData);

  targetDate[productIdData] = new Date(new Date(closedData.split('GMT')[0]));
  startDate[productIdData] = new Date(new Date(start_data.split('GMT')[0]));
  if (marketStatusData == 'open') {
    //clock[productIdData].innerHTML = countdown(targetDate[productIdData]).toString();
    // setTimeout(() => {
      setIntreval(productIdData, marketStatusData);
    // });
  } else {
    //clockws[productIdData] = document.getElementById('my' + productIdData);
    if(productIdData && productIdData.length > 0) {
      document.getElementById('my' + productIdData).innerHTML = 'closed';

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
                    if (document.getElementById("my" + t))
                      var end_date = targetDate[t];
                      var startIn = '';
                      if(startDate[t] > timeProject[t]) {
                        end_date = startDate[t];
                        startIn = 'Start In ';
                        if($("#buyNowBtn").length) $("#buyNowBtn").attr('disabled', 'disabled');
                        if($("#submitBidBtnView").length) $("#submitBidBtnView").attr('disabled', 'disabled');
                      } else {
                        if($("#buyNowBtn").length) $("#buyNowBtn").attr('disabled', false);
                        if($("#submitBidBtnView").length) $("#submitBidBtnView").attr('disabled', false);
                      }
                        if ($('[id="my' + t + '"]').length > 1)
                        {
                            for (var e = 0; e < $('[id="my' + t + '"]').length; e++) document.getElementsByClassName("my" + t) && document.getElementsByClassName("my" + t)[e] && (document.getElementsByClassName("my" + t)[e].innerHTML = startIn + countTimer(new Date(timeProject[t]), end_date));
                        } else {
                          if(document.getElementById("my" + t)) { 
                            document.getElementById("my" + t).innerHTML = startIn + countTimer(new Date(timeProject[t]), end_date)
                          }
                        }
                } else {
                    var a = window.location.pathname;
                    // if(clockws[t])
                    // clockws[t].innerHTML = "Closed", a.toString().toLowerCase().indexOf("/product/view/") >= 0 && (clearInterval(clearvar[t]), location.reload())

                    if(clockws[t]) {
                    //clockws[t].innerHTML = "Closed", a.toString().toLowerCase().indexOf("/product/view/") >= 0 && (clearInterval(clearvar[t]));
                      if('{$page_name}' == 'product_view') {
                        if($(".bidder_status").html() == 'You are the higher bidder' && +'{$previewData.reserve_price}' <= +'{$previewData.win_price}') {
                            $(".bidder_status").html("Congratulations you have been won this product");
                        } else if($(".bidder_status").html() == 'You have been out bidded') {
                            $(".bidder_status").html("You lost this product");
                        }
                        $('#submitBidBtnView').attr('disabled','disabled');
                        $('#submitBidBtnView').hide();
                        $('#submitBidBtn').attr('disabled','disabled');
                        $('#bid_check').attr('disabled','disabled');
                        $('#bid_amount_div').hide();
                        $('#buyNowBtn').hide();
                      }
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

        displayDate += ("0"+hours).slice(-2) + 'H : '+ ("0"+mins).slice(-2) + 'M : '+ ("0"+secs).slice(-2) + 'S';

        return displayDate;
    }


</script>