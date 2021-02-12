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

{include file="common/header-1.tpl" nocache}

<div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header border-0 p0 ">
          <div class="panel panel-success border-0">
            <div class="panel-heading green-bg">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Payment Successfully Done !!!</h3>
            </div>
          </div>
        </div>
      <div class="modal-body">
        <p class="f16 p35 text-center lh-22 black">
          <span class="green-text" style="font-size:1.5em">Congratulations!</span> <br><br>
           You have succesfully wired <b class="green-text">$1000.00</b> to Herbee! An account specialist will verify these funds and credit your account within 24 hours.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-d-b btn-d-g m5">Proceed to Herbee</button>
      </div>
    </div>
  </div>
</div>

<!-- Page content -->

<div class="container-fluid bgBannerFluid">
    <h1 style="top:50%;">Time to Fund Your Herbee Account</h1>
</div>

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row"> 

      <div class="col-md-12 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Cancel Page</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">

            <div class="row">

              <div class="col-xs-12 notifications text-center">

                <p class="description mb-25 lh-22">
                  You have successfully canceled your payment. Your account has not been funded.
                </p>


                <hr>

                <div class="row flex">
                  <div class="col-md-6 margin-auto text-center">
                        <span style="font-size:1.5em">Current Account Balance: <b class="green-text">$1000.00</b></span>
                  </div>
                </div>

                <hr>

                <div class="row">
                  <div class="col-md-12">
                    <div class="form-group">
                      <button onclick="window.location='wire-fund.html'" class="btn btn-default btn-d-b green-b m0 pull-right" type="button">Go to Funding Page</button>
                    </div>

                  </div>
                </div>

              </div>

          </div>

            </div>




          </div>

        </div>

      </div>
      <!-- / Content Area -->


    </div>
    <!-- Parent Row -->

  </div>
  <!-- dashboard-settings-con -->

</div>



<!--/ Page content -->


{include file="common/footer-1.tpl" nocache}

</body>
</html>