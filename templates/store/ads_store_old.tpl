

{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
 <link rel="stylesheet" href="{$config.url}/css/mystyle.css" />
<!-- Page content -->

<div class="container-fluid bgBannerFluid">
    <h1>Dashboard</h1>
        <div class="row">
            <div class="col-sm-12 confLinkCol">


                <ul>
                  <a href="market-selection.html"><li>
                    <!-- <span class="icon flaticon-auction"></span> -->
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
                     <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Open Bid Market</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Direct Buy Market</a></li> -->

                    </ul>
                  </li>

                </ul>
            </div>
        </div>
</div>

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">

      <div class="col-md-3 sidebar   mb-25">

        <ul class="sidebar-menu links-wrapper">
          <li class="maincat p0"><a href="dashboard.html">Dashboard</a></li>
          <li class="maincat p0"><a href="dashboard-profile.html">Profile</a></li>
          <li class="maincat"><a href="#">Messages</a></li>
          <li class="maincat"><a href="dashboard-payments.html">Payments</a></li>
          <li class="maincat"><a href="#">Contact information</a></li>
          <li class="maincat"><a href="dashboard-change-password.html">Change Password</a></li>
          <li class="maincat"><a href="dashboard-shipping.html">Shipping address changes</a></li>
          <li class="maincat"><a href="dashboard-account.html">Billing and Account Information</a></li>
          <li class="maincat"><a href="dashboard-notifications.html">Notifications</a></li>
          <li class="maincat active"><a href="dashboard-ads.html">Advertisement</a></li>


        </ul>

      </div>
      <!-- / Sddebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Advertise Your Store</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">

            <form class="form-horizontal"  data-parsley-validate method="post" enctype="multipart/form-data" action="{$config.url}/adwords/save">

              <input type="hidden" name="id" id="id" value="0"  />
             <input type="hidden" name="storeid" value="{$storeid}">
                 <input type="hidden" name="store_id" value="{$storeid}">
                     <input type="hidden" name="ad_type" value="store">
                <div class="row">
                    <div class="col-md-12">

                        <div class="form-group">
                          <div class="col-sm-12">
                            <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="ad_name" placeholder="Store Name*" name="ad_name" data-parsley-required required  value="{$storedata.name}">
                            <input type="hidden" class="form-control" value="/stores/view/id={$storeid}"  name="ad_url" required/>
                            <div class="checkbox">

                              <label class="p0">
                                <input name="featured" type="checkbox" value="1">
                                <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                Featured
                              </label>

                            </div>
                          </div>
                          <div class="col-sm-12">
                          <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="ad_name" placeholder="Ad title*" name="ad_title" data-parsley-required required  value="{$storedata.name}">
                          </div>
                        </div>

                        <div class="form-group">
                          <div class="col-sm-12">
                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Description" name="ad_content" rows="5" cols="80"  data-parsley-required required placeholder="Say something about the company to customers">{$storedata.description}</textarea>
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
                                        <img id="imagePreview" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                    </div>
                                  </div>

                                  <div class="col-md-6 margin-auto">
                                    <span class="f12 m5"><i>Upload Store Image</i></span>
                                    <input type="file"  required name="ad_image" id="banner" multiple="multiple">
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

                              <b>Days of the Week*</b> <br>
                              <span class="f12">Note: If none is selected, ad will get displayed on all the days.</span>
                              <br>
                              <br>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" name="days" value="Sunday">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Sunday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" name="days" value="Monday">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Monday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" name="days" value="Tuesday">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Tuesday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" name="days" value="Wednesday">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Wednesday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" name="days" value="Thursday">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Thursday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" name="days" value="Friday">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Friday
                                </label>

                              </div>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" name="days" value="Saturday">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Saturday
                                </label>

                              </div>


                            </div>

                            <div class="col-md-6">

                              <b>Targeting Sections*</b> <br>
                              <span class="f12">Note: If none is selected, ad will get displayed in all sections.</span>
                              <br>
                              <br>

                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="Direct_Buy_Market" name="target_section" >
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Direct Buy Market
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="Section_1" name="target_section">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Section 1
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="Section_2" name="target_section" >
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Section 2
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="Section_3"  name="target_section">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Section 3
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="Section_4" name="target_section">
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Section 4
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="Section_5"  name="target_section" >
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Section 5
                                </label>

                              </div>
                              <div class="checkbox">

                                <label class="p0">
                                  <input type="checkbox" value="Section_6"  name="target_section" >
                                  <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                  Section 6
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
                                          <input id="radio-4" name="show_campaign" type="radio" value="1" checked>
                                          <label  for="radio-4" class="radio-label f14">Continuously (you can pause or remove your Ads any time)</label>
                                       </div>

                                       <div class="radio2">
                                         <input id="radio-3" name="show_campaign" type="radio" value="0">
                                         <label for="radio-3" class="radio-label f14">Until a specific date</label>
                                       </div>

                                  </div>
                              </div>
                            </div>

                            <div class="row testresult">
                                <div class="col-md-12 test-result">
                                  <div class="input-group">
                                    <input type="text" class="form-control" name="end_date"  id="date_addeddd" placeholder="mm/dd/yyyy"  autocomplete="off" >
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

                              <div class="col-md-6">
                                <label class="f12">Your bid (the maximum you are willing to pay per click) </label>
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" id="ppc" placeholder="Minimum bid : US$2.00 Per Click" required  data-parsley-min="2" name="per_click_amount">
                              </div>
                              <div class="col-md-6">
                                <label class="f12">What is the most you're willing to spend per day?  </label>
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" id="per_day" placeholder="Minimum budget : US$5.00 per day" required data-parsley-min="5"  name="per_day_amount">
                              </div>

                            </div>

                          </div>



                        </div>

                          <div class="row flex">
                              <div class="col-sm-2 margin-auto">
                                <button  class="btn btn-default btn-d-b green-b m0" type="submit" class="btn btn-default">Create</button>
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



<!--/ Page content -->
 
{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
 
<script>

$('#banner').filestyle({
     input : false,
     buttonName : 'btn btn-default btn-d-b green-b m0',
     iconName : '',
     buttonText: 'Choose File'
    });
</script>
<script type="text/javascript">
$(function() {
    $("#banner").on("change", function()
    {
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
 
        if (/^image/.test( files[0].type)){ // only image file
            var reader = new FileReader(); // instance of the FileReader
            reader.readAsDataURL(files[0]); // read the local file
 
            reader.onloadend = function(){ // set image data as background of div
                $("#imagePreview").attr("src",  this.result);
            }
        }
    });
});
</script>