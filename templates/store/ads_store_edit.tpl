

{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
 <link rel="stylesheet" href="{$config.url}/css/mystyle.css" />
  <link rel="stylesheet" href="{$config['externalcss']}jquery.datetimepicker.css" type="text/css" />
<style type="text/css">
  .inner-addon .glyphicon{
    cursor: pointer;
    pointer-events: unset;
  }
  .labelasd{
    display: inline-block;
    width: 150px;
  }
</style>

<!-- Page content -->

<div class="container-fluid bgBannerFluid">
    <h1>Market Activity Dashboard</h1>
       {include file="common/common_navigation.tpl" nocache}
</div>

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">

        <div class="col-md-3 sidebar  mb-25  mb-25"> 
    <div class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Edit Your Advertisment <i class="fa fa-angle-down"></i></a>
          {include file="common/ads_settings_menu.tpl" nocache}
    </div>
</div> 
      <!-- / Sddebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Edit Your Advertisment </h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">

            <form class="form-horizontal"  data-parsley-validate method="post" enctype="multipart/form-data" action="{$config.url}/adwords/save">

              <input type="hidden" name="id" id="id" value="{$adwords_details.id}"  />
             <input type="hidden" name="storeid" value="{$adwords_details.store_id}">
                 <input type="hidden" name="store_id" value="{$adwords_details.store_id}">
                  <input type="hidden" name="exist_img" value="{$adwords_details.banner}">
                <div class="row">
                    <div class="col-md-12">

                        <div class="form-group">
                          <div class="col-sm-12">
                             <input class="w100 p15 pb15 grey-bg border-0" type="hidden" class="form-control" id="ad_name" placeholder="Store Name*" name="ad_name" data-parsley-required required  value="{$adwords_details.ad_title}">
                             <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="" placeholder="Ad title*" name="" data-parsley-required required  value="{$adwords_details.ad_title}" disabled>
                              <input class="w100 p15 pb15 grey-bg border-0" type="hidden" class="form-control" id="ad_title" placeholder="Ad title*" name="ad_title" data-parsley-required required  value="{$adwords_details.ad_title}">
                            <input type="hidden" class="form-control" value="{$config.url}/stores/view/{$storeid}"  name="ad_url" required/>
                          <!--   <div class="checkbox">

                              <label class="p0">
                              <input name="featured" type="checkbox" {if $storedata.featured ==1} chedcked {/if} value="1">
                                <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                Feature your store in the Direct Buy Market - <span class="f16 green-text"><b>$1/day</b> </span>

                              </label>

                            </div> -->
                          </div>
                          <div class="col-sm-6">
                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" class="form-control" id="pwd" placeholder="Brand title" name="pwd"> -->
                          </div>
                        </div>

                        <div class="form-group">
                          <div class="col-sm-12">
                            <input type="hidden" name="ad_content" value="{$adwords_details.ad_content}">
                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Description" name="" rows="5" cols="80"  data-parsley-required required placeholder="Say something about the company to customers" disabled>{$adwords_details.ad_content}</textarea>
                          </div>
                          <div class="col-sm-6">
                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" class="form-control" id="pwd" placeholder="Brand URL*" name="pwd"> -->
                          </div>
                        </div>

                        <div class="form-group">
                          <div class="col-sm-12">

                            <div class="row flex">

                              <div class="col-md-12 margin-auto">

                                <div class="row flex">
                                  {if $adwords_details.banner != ''}
                                  <div class="col-md-12 margin-auto">
                                    <div id="store-img" class="pro-thumb grey-bg flex">
                                            <img id="filec5" src="{$config.imgpath}ad_image/{$adwords_details.banner}" class="img-responsive margin-auto" alt="">
                                  </div>
                                  <div id="store-img-or" class="margin-auto padboth">OR</div>
                                  </div>
                                   {/if}
                                   {if $adwords_details.banner == ''}
                                  <div class="col-md-12 margin-auto">
                                    <div id="store-img" class="pro-thumb grey-bg flex">
                                            <img id="filec5" src="{$config.imgpath}store/{$adwords_details.existing_img}" class="img-responsive margin-auto" alt="">
                                  </div>
                                  <div id="store-img-or" class="margin-auto padboth">OR</div>
                                  </div>
                                   {/if}
                                 </div>
                                 <div class="row flex">
                                 <!-- </div> -->
                                  <div class="col-md-12 margin-auto">
                                    <div class="checkbox">
                                      <label class="p0">
                                        <input type="checkbox" class="click-this" value="">
                                        <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                        Upload New Store Ad Image
                                      </label>
                                    </div>
                                    <div class="show-this">
                                      <div class="col-md-6 pro-thumb grey-bg pdtp">
                                        <img id="imagePreview" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                      </div>
                                      <div class="col-md-6 margin-auto">
                                        <span class="f12 m5 labelasd"><i>Upload Image</i></span>
                                        <input type="file"  name="ad_image" id="banner" multiple="multiple" data-parsley-errors-container="#ad_image-err">
                                      </div>

                                      <span id="ad_image-err" class="err-message"></span>

                                         <div class="clearfix"></div>

                                    </div>
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

                              <b>Advertising Time Frame</b> <br>
                              <span class="f12">Note: If you would like to advertise your store continuously leave the end date field blank.</span>
                              <br>
                              <br>
                              <div class="form-group">
                                <div class="col-sm-12">
                                    <div class="inner-addon right-addon">
                                        <i class="glyphicon glyphicon-calendar"></i>
                                      <input type="text" required class="w100 p15 pb15 grey-bg border-0" name="start_date"  id="start_date" placeholder="dd/mm/yyyy"  autocomplete="off" value="{$adwords_details.start_day}">
                                    </div>
                                </div>

                            </div>

                            <div class="form-group">
                              <div class="col-sm-12">
                                <div class="inner-addon right-addon">
                                  <input id="show_campaign" name="show_campaign" type="hidden" value="1"  >
                                    <i class="glyphicon glyphicon-calendar"></i>
                                     <input   type="text" class="w100 p15 pb15 grey-bg border-0" name="end_date"  id="date_addeddd" placeholder="dd/mm/yyyy"  autocomplete="off" value="{$adwords_details.end_date}">
                                </div>
                              </div>
                            </div>
                            


                            </div>


                        </div>


                        <div class="form-group">

                          <div class="col-sm-12">

                            <div class="text-center m35">
                              <b>Advertising Budget</b>
                            </div>

                            <div class="row">

                              <div class="col-md-6 hide">
                                <label class="f12">How much do you plan to spend on clicks per day?  </label>

                                <input class="w100 p15 pb15 grey-bg border-0" type="text" id="per_day" placeholder="Minimum Budget : $2.00 per click" name="per_click_amount" value="{$adwords_details.budget_per_click}">
                              </div>
                              <div class="col-md-6">
                                <label class="f12">What is the maximum budget do you wish to spend on a day?   </label>
                               <input class="w100 p15 pb15 grey-bg border-0" type="text" id="" placeholder="Minimum Budget" required data-parsley-min="5" name="per_day_amount" value="{$adwords_details.budget_per_day}">
                              </div>

                            </div>

                          </div>

                        </div>

                          <div class="row flex">
                              <div class="col-sm-2 margin-auto">
                               <button  class="btn btn-default btn-d-b green-b m0" type="submit" class="btn btn-default">UPDATE</button>
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
 <script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
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



$('#date_addeddd').change(function() {
   if($('#date_addeddd').val() !="")
{

  $('#show_campaign').val(0);
}
else
{
$('#show_campaign').val(1);
}
});

$('#ad_title').change(function() {


  $('#ad_name').val($('#ad_title').val());

});
</script>
<script>
/* jquery datepicker - Date available */
    $("#start_date").datetimepicker({
    timepicker:false,
    format:'d/m/Y',
    step: 5,
    minDate:0,
    minTime:0
    /*,
    onChangeDateTime: function(dp,$input){
     startDate = $("#start_date").val();
      endDate = $("#date_addeddd").val();
     if(startDate<endDate){
       $("#date_addeddd").val('');
      }
    }*/
  });
    $("#date_addeddd").datetimepicker({
    timepicker:false,
    format:'d/m/Y',
    step: 5,
    minDate:0,
    minTime:0
    /*,
    onClose: function(current_time, $input){
       startDate = $("#start_date").val();
    var endDate = $("#date_addeddd").val();
      if(startDate>endDate){
       $("#date_addeddd").val('');
      }
    }*/
  });

 $(document).ready(function(){
    $('.show-this').hide();
    $('.click-this').change(function(){
        if(this.checked){
            $('.show-this').fadeIn('slow');
            $('#store-img').hide();
            $('#store-img-or').hide();
        }else{ 
          $('.show-this').fadeOut('slow');
          $('#store-img').show();
          $('#store-img-or').show();
        }

    });
  });
</script>
