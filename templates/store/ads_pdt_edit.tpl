{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
 <link rel="stylesheet" href="{$config.url}/css/mystyle.css" />
  <link rel="stylesheet" href="{$config['externalcss']}jquery.datetimepicker.css" type="text/css" />

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
          <a class="dropdown-toggle" data-toggle="dropdown">Edit Your Product<i class="fa fa-angle-down"></i></a>
          {include file="common/ads_settings_menu.tpl" nocache}
    </div>
</div> 
      <!-- / Sddebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Edit Your Product</h3>
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
                           <div class="form-group">
                          <div class="col-sm-6">

                           <select class="w100 p15 pb15 grey-bg border-0" onchange="pro_data(this.value)" name ="product_id" data-parsley-required required>
                          
                            {foreach $prod_list as $key => $val}
                    
                                 <option value='{$val.id}' {if $adwords_details.product_id == $val.id} selected {/if}> {$val.title} </option>
                           {/foreach}

                            </select>
                            
                          </div>
                          <div class="col-sm-6">
                             <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="ad_title" placeholder="Ad title  "  name="ad_title" data-parsley-required required value="{$adwords_details.ad_title}">
                             <input class="w100 p15 pb15 grey-bg border-0" type="hidden" class="form-control" id="ad_name" placeholder="Product Name*" name="ad_name"  data-parsley-required required value="{$adwords_details.ad_title}">
                             <input type="hidden" id="ad_url" class="form-control" value="{$config.url}/product/view/id={$proid}"  name="ad_url" required/>
                            <!-- <div class="checkbox">

                              <label class="p0">
                                <input name="featured" type="checkbox" {if $storedata.featured ==1} chedcked {/if} value="1">
                                <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                Feature your product in the Direct Buy Market - <span class="f16 green-text"><b>$1/day</b> </span>

                              </label>

                            </div> -->
                          </div>
                          <div class="col-sm-6">
                            <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" class="form-control" id="pwd" placeholder="Brand title" name="pwd"> -->
                          </div>
                        </div>

                        <div class="form-group">
                          <div class="col-sm-12">
                           <textarea class="grey-bg w100 border-0 p15 pb15"  name="ad_content" placeholder="Description" name="name" rows="5" id="desc" cols="80" data-parsley-required required placeholder="Say something about the Product to customers">{$adwords_details.ad_content}</textarea>
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

                                  {if $adwords_details.banner != ''}
                                  <div class="col-md-6 margin-auto">

                                   
                                     
                                    <div class="pro-thumb grey-bg flex">
                                 
                                            <img id="filec5" src="{$config.imgpath}ad_image/{$adwords_details.banner}" class="img-responsive margin-auto" alt="">
                                  
                                  </div>
                                 
                                  </div>
                                  <div class="">OR</div>
                                   {/if}
                                  <div class="col-md-6 margin-auto">
                                   <div class="pro-thumb grey-bg p15">
                                      <img id="imagePreview" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="">
                                    </div>
                                  <div class="col-md-6 margin-auto">
                                    <span class="f12 m5 labelasd"><i>Upload Product Ad Image</i></span>
                                    <input type="file"   {if $adwords_details.banner == ''} required  {/if} name="ad_image" id="banner" multiple="multiple">
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
                                        <input type="text" class="form-control" name="start_date"  id="start_date" placeholder="mm-dd-yyyy"  autocomplete="off" value="{$adwords_details.start_day}" required>
                                    </div>
                                </div>

                            </div>

                            <div class="form-group">
                              <div class="col-sm-12">
                                <div class="inner-addon right-addon">
                                       <input id="show_campaign" name="show_campaign" type="hidden" value="1"  >
                                    <i class="glyphicon glyphicon-calendar"></i>
                                       <input   type="text" class="form-control" name="end_date"  id="date_addeddd" placeholder="dd/mm/yyyy"  autocomplete="off" value="{$adwords_details.end_date}">
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

                            <!-- <div class="col-md-6">

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
                              
                              

                            </div> -->

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
                              <input class="w100 p15 pb15 grey-bg border-0" type="hidden" id="ppc" placeholder="Minimum bid : US$2.00 Per Click" required  data-parsley-min="2" name="per_click_amount" value="1">
                              <div class="col-md-6">
                                <label class="f12">How much do you plan to spend on clicks per day?   </label>
                               <input class="w100 p15 pb15 grey-bg border-0" type="text" id="per_day" placeholder="Minimum Budget : $5.00 per day" required   data-parsley-min="5" name="per_day_amount" value="{$adwords_details.budget_per_day}">
                              </div>

                            </div>

                          </div>



                        </div>

                          <div class="row flex">
                              <div class="col-sm-2 margin-auto">
                              <button  class="btn btn-default btn-d-b green-b m0" type="submit" class="btn btn-default">Update</button>
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


<script type="text/javascript">

function pro_data(y)
{

$("#ad_url").val("/product/view/"+y);

request='';

  $.ajax({
                type : 'GET',
                url  : '{$config.url}/stores/pro_detail/'+y,
                data : request,
                dataType : 'json',
                success  : function(data)
                {
                     
                        //console.log(data);
                     
                     ds=data.pro_detail;

                     $("#ad_title").val(ds.title);
                     $("#ad_name").val(ds.title);
                     $("#desc").val(ds.description);

                }
            });
}
</script>


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
    minTime:0,
    onChangeDateTime: function(dp,$input){
     startDate = $("#start_date").val();
      endDate = $("#date_addeddd").val();
     if(startDate<endDate){
       $("#date_addeddd").val('');
      }
    }
  });
    $("#date_addeddd").datetimepicker({
    timepicker:false,
   format:'d/m/Y',
    step: 5,
    minDate:0,
    minTime:0,
    onClose: function(current_time, $input){
       startDate = $("#start_date").val();
    var endDate = $("#date_addeddd").val();
      if(startDate>endDate){
       $("#date_addeddd").val('');
      }
    }
  });
</script>