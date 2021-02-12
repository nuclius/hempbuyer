

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
          <a class="dropdown-toggle" data-toggle="dropdown">Advertise Your Store<i class="fa fa-angle-down"></i></a>
          {include file="common/ads_settings_menu.tpl" nocache}
    </div>
</div>
      <!-- / Sddebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Advertise Your Store</h3>
              </div>

          </div>
            {if $blserr ==1}
            <div class="col-md-12 alert alert-danger text-center" style="font-size: 20px">
                Your Account Balance Is Low. Please Credit Your Accout And Then Proceed.
            </div>
            {/if}
          <div class="col-md-12 white-bg-2 p35 shadow">

            <form class="form-horizontal"  data-parsley-validate method="post" enctype="multipart/form-data" action="{$config.url}/adwords/save">

                 <input type="hidden" name="id" id="id" value="0"  />
                 <input type="hidden" id="returnurls" name="returnurls" value=""  />
                <input type="hidden" name="currentbalance" class="currentbalance" value="{$userbalance.balance}">
                 <input type="hidden" name="storeid" value="{$storeid}">
                 <input type="hidden" name="store_id" value="{$storeid}">
                 <input type="hidden" name="exist_img" value="{$storedata.logo}">
                 <input type="hidden" name="ad_type" value="store">
                <div class="row">
                    <div class="col-md-12 xs-pdlr">

                        <div class="form-group">
                          <div class="col-sm-12">
                             <input class="w100 p15 pb15 grey-bg border-0" type="hidden" class="form-control" id="ad_name" placeholder="Store Name*" name="ad_name" data-parsley-required required  value="{$storedata.name}">
                             <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="" placeholder="Ad title*" name="" data-parsley-required required  value="{$storedata.name}" disabled>
                             <input class="w100 p15 pb15 grey-bg border-0" type="hidden" class="form-control" id="ad_title" placeholder="Ad title*" name="ad_title" data-parsley-required required  value="{$storedata.name}">
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

                        <div class="row form-group flex-center">
                          <div class="col-sm-6">
                            <div class="row flex-center">
                              <div class="col-sm-12">
                                {if $storedata.logo != ''}
                                <div class="col-md-12 margin-auto">
                                  <div id="store-img" class="pro-thumb flex pdtp">
                                    <img id="filec5" src="{$config.imgpath}store/{$storedata.logo}" class="img-responsive margin-auto" alt="">
                                  </div>
                                </div>
                                 {/if}
                              </div>
                              <div class="col-sm-12 text-center">
                                <div id="store-img-or" class="margin-auto padboth">OR</div>
                              </div>
                              <div class="col-sm-12 text-center">
                                <div class="row flex">
                              <!-- </div> -->
                                   <div class="col-md-12 margin-auto">
                                     <div class="show-this">
                                       <div class="col-md-12 pro-thumb pdtp">
                                         <img id="imagePreview" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                       </div>
                                       <div class="col-md-12 margin-auto">
                                         <span class="f12 m5 labelasd"><i>Upload Image</i></span>
                                         <input type="file"   {if $storedata.logo == ''} required  {/if} name="ad_image" id="banner"  data-parsley-errors-container="#ad_image-err" multiple>
                                       </div>

                                       <span id="ad_image-err" class="err-message"></span>

                                          <div class="clearfix"></div>

                                     </div>
                                     <div class="checkbox">
                                       <label class="p0">
                                         <input type="checkbox" class="click-this" value="">
                                         <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                         Upload New Store Ad Image
                                       </label>
                                     </div>
                                    </div>
                             </div>
                              </div>

                              </div>
                          </div>
                          <div class="col-sm-6">
                            <input type="hidden" name="ad_content" value="{$storedata.description}">
                            <textarea class="grey-bg w100 border-0 p15 pb15" placeholder="Description" name="" rows="9" cols="80"  data-parsley-required required placeholder="Say something about the company to customers" disabled>{$storedata.description}</textarea>
                          </div>
                          <div class="col-sm-6">
                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" class="form-control" id="pwd" placeholder="Brand URL*" name="pwd"> -->
                          </div>
                        </div>

                        <div class="form-group">
                          <!-- <div class="col-sm-12"> -->

                            <!-- <div class="row flex"> -->

                              <!-- <div class="col-md-12 margin-auto"> -->






                              <!-- </div> -->

                              <!-- <div class="col-md-4 margin-auto">

                                <button class="btn btn-default btn-d-g btn-d-b m0" type="button" name="button">Verify</button>

                              </div> -->

                            <!-- </div> -->


                          <!-- </div> -->
                          <div class="col-sm-6">
                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" class="form-control" id="pwd" placeholder="Keywords" name="pwd"> -->
                          </div>
                        </div>

                        <div class="form-group">


                            <div class="col-md-12">

                              <b>Advertising Time Frame</b> <br>
                              <span class="f12">Note: If you would like to advertise your store continuously leave the end date field blank.</span>
                              <br>
                              <br>
                                <div class="">
                                <div class="row   form-group">
                                    <div class="col-sm-6 inner-addon pstch right-addon">
                                        <label>Start Date</label>
                                        <div class="pos-rel">
                                          <i class="glyphicon glyphicon-calendar"></i>
                                          <input type="text" class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change" name="start_date"  id="start_date" placeholder="mm/dd/yyyy"  autocomplete="off" data-parsley-required-message="Please select start date..." data-parsley-required required>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 inner-addon pstch right-addon">
                                        <input id="show_campaign" name="show_campaign" type="hidden" value="1">
                                        <label>End Date</label>
                                        <div class="pos-rel">
                                          <i class="glyphicon glyphicon-calendar"></i>
                                          <input   type="text" class="w100 p15 pb15 grey-bg border-0" name="end_date"  id="date_addeddd" data-parsley-trigger="change" placeholder="mm/dd/yyyy"  autocomplete="off" data-parsley-required-message="Please select end date..."  data-parsley-required required>
                                        </div>
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

                              <!-- <div class="col-md-6">
                                <label class="f12">Your bid (the maximum you are willing to pay per click) </label>
                                <input class="w100 p15 pb15 grey-bg border-0" type="password" id="pwd" placeholder="Minimum bid : US$2.00 Per Click" name="pwd">
                              </div> -->
                               <!-- <input class="w100 p15 pb15 grey-bg border-0" type="hidden" id="ppc" placeholder="Minimum bid : $2.00 Per Click" required  data-parsley-min="2" name="per_click_amount" value="1"> -->
                              <div class="col-md-6 hide">
                                <label class="f12">How much do you plan to spend on clicks per day?  </label>
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" id="per_day" placeholder="Minimum Budget"
                                name="per_click_amount" value="{$adsclickamount}">
                                  <span style="color:red" class="t_click"></span>
                                  
                              </div>
                              <div class="col-md-6">
                                <!-- {$config.ads.clickamount} -->
                                <!-- <label class="f12">What is your maximum daily budget for advertising?  Herbee will make sure you do not exceed this amount.  The current cost per click is $ {$config.ads.clickamount}.</label> -->
                                <label class="f12" style="font-weight: normal;">What is your maximum daily budget for advertising? Herbee will make sure you do not exceed this amount. The current cost per click is $ {if $loged.business_type == 'grower' || $loged.business_type == 'producer'}0{else}2{/if}.  Upon setting up your campaign, Herbee will deduct the total anticipated spend from your account to make sure you get the desired exposure.  If your campaign does not get the targeted number of clicks during the window you arrange, don't worry.  Herbee will automatically refund the balance your unspent advertising funds to your account. <b>---For a short time we are allowing early Growers and Producer members of the Herbee market to advertise at zero cost.  In the future there will be a price to advertise which we will announce prior to instituting any change.</b></label>
                                <!-- <input class="w100 p15 pb15 grey-bg border-0 numberonly" type="text" id="" placeholder="Maximum Budget per day" data-parsley-trigger="change focusout" data-parsley-min="{$adsclickamount}" name="per_day_amount" required> -->
                                {if $loged.business_type != 'grower' && $loged.business_type != 'producer'}
                                  <input class="w100 p15 pb15 grey-bg border-0 numberonly" type="text" id="" placeholder="Maximum Budget per day" data-parsley-trigger="change focusout" data-parsley-min="{$adsclickamount}" name="per_day_amount" required>
                                  <input type="hidden" id="t_click" name="total_click">
                                {/if}
                                {if $loged.business_type == 'grower' || $loged.business_type == 'producer'}
                                  <input class="w100 p15 pb15 grey-bg border-0 numberonly" type="text" id="" placeholder="Maximum Budget per day" data-parsley-trigger="change focusout" data-parsley-min="0" name="per_day_amount" required value="0" readonly>
                                  <input type="hidden" id="t_click" name="total_click" value="0">
                                {/if}

                              </div>
                                <span class="t_click"></span>
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
    var rurl =window.location.href
    $('#returnurls').val(rurl)
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
    format:'m/d/Y',
    step: 5,
    minDate:0,
    minTime:0,
    scrollMonth:false,
    scrollTime:false,
  scrollInput:false,
    onChangeDateTime: function(dp,$input){

    var from = $("#start_date").val().split("/");
    var startDate = new Date(from[2], from[0] - 1, from[1]);

    var from = $("#date_addeddd").val().split("/");
    var endDate = new Date(from[2], from[0] - 1, from[1]);

     if(startDate>endDate){
       $("#date_addeddd").val('');
      }
    }
  });
    $("#date_addeddd").datetimepicker({
    timepicker:false,
    format:'m/d/Y',
    step: 5,
    minDate:0,
    minTime:0,
    scrollMonth:false,
    scrollTime:false,
    scrollInput:false,
    onClose: function(current_time, $input){
    // var startDate = $("#start_date").val();
    // var endDate = $("#date_addeddd").val();

    var from = $("#start_date").val().split("/");
    var startDate = new Date(from[2], from[0] - 1, from[1]);

    var from = $("#date_addeddd").val().split("/");
    var endDate = new Date(from[2], from[0] - 1, from[1]);

      if(startDate>endDate){
       $("#date_addeddd").val('');
      }
    }
  });
</script>


<script type="text/javascript">
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
    $('input[name="per_day_amount"]').on('blur',function(){
        if($(this).val() ){
            var clickamt ={$adsclickamount};
            var userclickamt = $(this).val();
            var totalclick = userclickamt/clickamt;
            var totalclick_d = (totalclick).toString();
            var res =  totalclick_d.indexOf(".");
            if(res >=0){
                $('.t_click').text('Admin set '+clickamt+' per click.Please set multiples of this amount');
                $(this).val('')
            }else{
                $('.t_click').text('Based on your daily budget, your advertisement will continue until you receive '+totalclick+' clicks during a day.');
                $('#t_click').val(totalclick);
            }
        }else{
            $('.t_click').text('')
        }
           });
  });

  $("input[type=file]").change(function() {

    var val = $(this).val();

    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
        case 'gif': case 'jpg': case 'png': case 'jpeg':
        $('#post_submit').prop('disabled',false);
            break;
        default:
            $(this).val('');
            // error message here
            $('#post_submit').prop('disabled','true');
            $(this).parents().find(".badge").remove();
            $("#imagePreview").attr("src",  "{$config.url}/images/upload-img.png");
            alert("not an image");
            break;
    }
});

</script>
