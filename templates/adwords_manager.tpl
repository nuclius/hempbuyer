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

{include file="/common/header-1.tpl" nocache}


<div class="container-fluid bgBannerFluid">
    <h1>Market Activity Dashboard</h1>
            {include file="common/common_navigation.tpl" nocache}
<!--         <div class="row">
            <div class="col-sm-12 confLinkCol">


                <ul>
                  <a href="market-selection.html"><li>
                    <i class="fa fa-home" aria-hidden="true"></i>
                    Welcome Page</li></a>
                  <a href="open-bid-market.html"><li><span class="icon flaticon-auction"></span>Open Market</li></a>
                  <a href="directbuy.html"><li><span class="icon flaticon-shopping-cart"></span>Direct Market</li></a>
                  <a href="store-view.html"><li><span class="flaticon-business icon"></span>My Store</li></a>
                  <a href="#"><li><img src="{$config.url}/images/ads.png" alt="">Advertising </li></a>
                  <a href="#"><li><span class="icon flaticon-research-work"></span>Research</li></a>

                  <li style="position:relative">
                    <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"><i class="flaticon-settings"></i>Settings
                    <span class="caret"></span></button>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">

                      <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-profile.html">Profile</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Messages</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-payments.html">Payments</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Contact information</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-change-password.html">Change Password</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-shipping.html">Shipping address changes</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-account.html">Billing and Account Information</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-notifications.html">Notifications</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-ads||.html">Advertisement</a></li>
                    </ul>
                  </li>

                </ul>
            </div>
        </div> -->
</div>

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">

    {include file="/common/ads_settings_menu.tpl" nocache}

      <!-- / Sddebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Advertise Your Store</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">

            <form class="form-horizontal" action="/action_page.php">
                <div class="row">
                    <div class="col-md-12">

                        <div class="form-group">
                          <div class="col-sm-12">
                            <input class="w100 p15 pb15 grey-bg border-0" type="email" class="form-control" id="email" placeholder="Store Name*" name="email">
                            <div class="checkbox">

                              <label class="p0">
                                <input type="checkbox" value="">
                                <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                Feature your store in the Direct Buy Market - <span class="f16 green-text"><b>$1/day</b> </span>

                              </label>

                            </div>
                          </div>
                          <div class="col-sm-6">
                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" class="form-control" id="pwd" placeholder="Brand title" name="pwd"> -->
                          </div>
                        </div>

                        <div class="form-group">
                          <div class="col-sm-12">
                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Description" name="name" rows="5" cols="80"></textarea>
                          </div>
                          <div class="col-sm-6">
                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" class="form-control" id="pwd" placeholder="Brand URL*" name="pwd"> -->
                          </div>
                        </div>

                        <div class="form-group">
                          <div class="col-sm-6">

                            <div class="row flex">

                              <div class="col-md-12 margin-auto">

                                <div class="row flex">

                                  <div class="col-md-6 margin-auto">
                                    <div class="pro-thumb grey-bg p15">
                                        <img src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                    </div>
                                  </div>

                                  <div class="col-md-6 margin-auto">
                                    <span class="f12 m5"><i>Upload Ad Image</i></span>
                                    <input type="file" id="banner" multiple="multiple">
                                  </div>

                                </div>

                              </div>

                              <!-- <div class="col-md-4 margin-auto">

                                <button class="btn btn-default btn-d-g btn-d-b m0" type="button" name="button">Verify</button>

                              </div> -->

                            </div>


                          </div>
                          <div class="col-sm-6">
                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" class="form-control" id="pwd" placeholder="Keywords" name="pwd"> -->
                          </div>
                        </div>

                        <div class="form-group">


                            <div class="col-md-6">

                              <b>Show Ads Duration</b> <br>
                              <span class="f12">Note: Does not pick an end date the ads will run until ends the campaign</span>
                              <br>
                              <br>
                              <div class="form-group">
                                <div class="col-sm-12">
                                    <div class="inner-addon right-addon">
                                        <i class="glyphicon glyphicon-calendar"></i>
                                        <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="Start Date" name="email">
                                    </div>
                                </div>

                            </div>

                            <div class="form-group">
                              <div class="col-sm-12">
                                <div class="inner-addon right-addon">
                                    <i class="glyphicon glyphicon-calendar"></i>
                                    <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="End Date" name="email">
                                </div>
                              </div>
                            </div>
                              <!-- <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Sunday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Monday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Tuesday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Wednesday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Thursday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Friday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Saturday
                                </label>

                              </div> -->


                            </div>

                            <div class="col-md-6">

                              <b>Targeting Sections*</b> <br>
                              <span class="f12">Note: If none is selected, ad will get displayed in all sections.</span>
                              <br>
                              <br>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="" checked>
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Direct Buy Market
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  $0.50/click
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  $0.25/click
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="" checked>
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  $0.25/click
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  $0.15/click
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="" checked>
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  $0.15/click
                                </label>

                              </div>

                              <!-- <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Clients Signup
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Freelancers Signup
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Find Freelancers
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Post Project
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Clients DashBoard
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Find Projects
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  User Account Pages
                                </label>

                              </div> -->

                            </div>

                        </div>

                        <div class="form-group">

                          <div class="col-sm-12">

                            <div class="form-group">
                              <div class="col-sm-12">
                                <div class="text-center m35">
                                  <b>Show Ads Duration </b>
                                </div>

                                  <div class="radio-con">

                                        <div class="radio2">
                                          <input id="radio-4" name="radio" type="radio" value="testdisable" checked>
                                          <label  for="radio-4" class="radio-label f14">Continuously (you can pause or remove your Ads any time)</label>
                                       </div>

                                       <div class="radio2">
                                         <input id="radio-3" name="radio" type="radio" value="test">
                                         <label for="radio-3" class="radio-label f14">Until a specific date</label>
                                       </div>

                                  </div>
                              </div>
                            </div>

                            <div class="row testresult">
                                <div class="col-md-12 test-result">
                                  <div class="input-group">
                                    <input type="text" class="form-control" placeholder="28/06/2016">
                                    <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar"></i></span>
                                  </div>
                                </div>
                            </div>

                          </div>

                        </div>

                        <div class="form-group">

                          <div class="col-sm-12">

                            <div class="text-center m35">
                              <b>Ads Budget </b>
                            </div>

                            <div class="row">

                              <!-- <div class="col-md-6">
                                <label class="f12">Your bid (the maximum you are willing to pay per click) </label>
                                <input class="w100 p15 pb15 grey-bg border-0" type="password" id="pwd" placeholder="Minimum bid : US$2.00 Per Click" name="pwd">
                              </div> -->
                              <div class="col-md-6">
                                <label class="f12">What is the most you're willing to spend per day?  </label>
                                <input class="w100 p15 pb15 grey-bg border-0" type="password" id="pwd" placeholder="Maximum Budget: $5.00/day" name="pwd">
                              </div>

                            </div>

                          </div>



                        </div>

                          <div class="row flex">
                              <div class="col-sm-2 margin-auto">
                                <button onclick="window.location.href='dashboard-ads.html'" class="btn btn-default btn-d-b green-b m0" type="button" class="btn btn-default">Create</button>
                              </div>
                          </div>
                    </div>
                </div>
            </form>

          </div>

        </div>

      </div>
      <!-- / Content Area -->


    </div>
    <!-- Parent Row -->

  </div>
  <!-- dashboard-settings-con -->

</div>


{include file="/common/footer-1.tpl" nocache}