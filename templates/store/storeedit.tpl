{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}

    <link rel="stylesheet" href="{$config.url}/css/jquery.datetimepicker.css" type="text/css" />
    <link rel="stylesheet" href="{$config.url}/css/mystyle.css" />
  <!--   <div class="container spc fonfm1 menu_pad">
        <div class="col-md-12 store_mwrap menu_pad">
            <form action="{$config.url}/stores/create" method="post" enctype="multipart/form-data">
              
            </form>
        </div>
    </div> -->
    <!-- page content  -->

    <div class="container-fluid store-fluid grey-bg p0">
        <div class="page-caption m50">
            <h1>Edit Your Store</h1>
        </div>
        <div class="row  m50"><div class="col-md-12 flex">
            <div class="col-lg-6 col-md-8 margin-auto white-bg-2 p35 shadow">
                <h3 class="fancy-title green text-center">Let's get started</h3>
                <p class="description text-center m30">
                    Let's get started on your store!  Its easy.  First load your company logo, give a brief description for customers,  and input your contact data.  Then you are open for business.
                </p>
                <form action="{$config.url}/stores/create" method="post" enctype="multipart/form-data" class="form-horizontal" data-parsley-validate>
                <input type="hidden" name="storeid" value="{$store.id}">
                <input type="hidden" name="store_imaged" value="{$store.logo}">
                <input type="hidden" name="country" value="{$store.country}">
                <input type="hidden" name="address" value="{$store.address}">
                <input type="hidden" name="state" value="{$store.state}">
                <input type="hidden" name="city" value="{$store.city}">
                <input type="hidden" name="region" value="{$store.region}">
                <input type="hidden" name="zip" value="{$store.zip}">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                              <div class="col-sm-3">
                                  <div class="pro-thumb grey-bg flex sedit-img">

                                            {if $store.logo != ''}
                                            <img id="filec" src="{$config.url}/uploads/store/{$store.logo}" class="img-responsive margin-auto" alt="" accept="image/*">
                                            {/if}
                                            {if $store.logo == ''}
                                            <img id="filec" src="{$config.url}/images/upload-img.png" class="img-responsive margin-auto" alt="" accept="image/*">
                                            {/if}
                                                
                                            </div>
                                  <div class="flex">
                                                <div class="margin-auto">
                                                    <span class="f12 m5"><i>Upload Item Images (*.jpeg, *.jpg, *.png etc.)</i></span>
                                                    <input type="file" id="filecount" name="store_image" {if $store.logo == ''}
 data-parsley-required data-parsley-required-message="Please select images" {/if} multiple="multiple" accept="image/*">
                                                </div>
                                            </div>
                              </div>
                              <div class="col-sm-9">
                                <textarea class="grey-bg w100 border-0 p15 pb15" data-parsley-required required placeholder="Say something about the company to customers" name="description" rows="6" cols="80">{$store.description}</textarea>
                              </div>
                            </div>
                             <div class="form-group">
                              <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" data-parsley-required required class="form-control" id="email" placeholder="Store Name" name="sname" value="{$store.name}">
                                <!--  data-parsley-pattern="^[a-zA-Z ]+$" -->
                              </div>
                             
                            </div>
                            <div class="form-group">
                              <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text"  data-parsley-required required class="form-control" id="email" placeholder="Contact Person Name" name="pname" value="{$store.pname}">
                                <!--  data-parsley-pattern="^[a-zA-Z ]+$" -->
                              </div>
                              <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" data-parsley-minlength="12"  data-parsley-required required class="form-control" id="pwd" placeholder="Phone" name="phone" value="{$store.phone}" data-mask="000-000-0000" data-parsley-trigger="change focusout" data-parsley-notequalto="#phone" data-parsley-group="block1" data-parsley-errors-container="#phone0-err">

                              </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                  *Default address as per your profile can not be change.
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                  <textarea class="grey-bg w100 border-0 p15 pb15" data-parsley-required required placeholder="Address" name="address" rows="6" cols="80" disabled="true">{$store.address}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                              <!-- <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" data-parsley-required required class="form-control" id="email" placeholder="Street" name="street">
                              </div> -->
                              <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" data-parsley-pattern="^[a-zA-Z ]+$" data-parsley-required required class="form-control" id="pwd" placeholder="City" name="city" value="{$store.city}" disabled="true">
                              </div>
                            </div>

                            <div class="form-group">
                              <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" data-parsley-pattern="^[a-zA-Z ]+$" data-parsley-required required class="form-control" id="email" placeholder="State" name="state" value="{$store.state}" disabled="true">
                              </div>
                              <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" data-parsley-required required data-parsley-length="[5,6]" class="form-control" id="pwd" placeholder="Zip Code" name="zip" value="{$store.zip}" disabled="true">
                              </div>
                            </div>

                              <div class="row flex">
                                  <div class="col-sm-2 margin-auto" style="margin-right:30px;">
                                    <button  class="btn btn-default btn-d-b green-b m0" type="submit" class="btn btn-default">UPDATE</button>
                                  </div>
                              </div>
                        </div>
                    </div>
                </form>

            </div> </div>
        </div>
    </div>

<!-- / page content  -->

{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
<script src="{$config.url}/js/jquery.mask.min.js" type="text/javascript"></script>
<script type="text/javascript">
  $('.howworks').click(function(){
   $('html, body').animate({
       scrollTop: $("#howworksSec").offset().top
   }, 1000);
  });
</script>
<script>

$('#filecount').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});


//     $('#filecount').filestyle({
//     input: false,
//     buttonName: 'btn btn-default btn-d-b btn-d-g m5',
//     iconName: '',
//     buttonText: 'UPLOAD'
// });

</script>
<script>
   AOS.init({
      offset: 200,
      duration: 600,
      easing: 'ease-in-sine',
      delay: 100,
    });
</script>
<script type="text/javascript">
//On scroll call the draw function
$(window).scroll(function() {
drawLines();
});

//If you have more than one SVG per page this will pick it up
function drawLines(){
$.each($("path"), function(i, val){
  var line = val;
  drawLine($(this), line);
});
}

//draw the line
    function drawLine(container, line){
var length = 1;
var pathLength = line.getTotalLength();
var distanceFromTop = container.offset().top - $(window).scrollTop();
var percentDone = 1 - (distanceFromTop / $(window).height());
length = percentDone * pathLength;
line.style.strokeDasharray = [length,pathLength].join(' ');
console.log("strokeDasharray: "+[length,pathLength].join(' '));
}

// document.getElementById("filecount").onchange = function() {
//     var reader = new FileReader();

//     reader.onload = function(e) {
//         // get loaded data and render thumbnail.
//         document.getElementById("filec").src = e.target.result;
//     };
//     $("#filecount").parent().find('ul').hide();
//     // read the image file as a data URL.
//     reader.readAsDataURL(this.files[0]);
// };


$("#filecount").on("change", function()
    {

      var val = $(this).val();

    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
        case 'gif': case 'jpg': case 'png': case 'jpeg':
              $('#post_submit').prop('disabled',false);
              var files = !!this.files ? this.files : [];
              if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support

              if (/^image/.test( files[0].type)){ // only image file
                  var reader = new FileReader(); // instance of the FileReader
                  reader.readAsDataURL(files[0]); // read the local file

                  reader.onloadend = function(){ // set image data as background of div
                      $("#filec").attr("src",  this.result);
                  }
              }
            break;
        default:
            $(this).val('');
            $(this).parents().find(".badge").remove();
            $("#filec").attr("src",  "{if $store.logo !=''}{$config.url}/uploads/store/{$store.logo}{/if}{if $store.logo ==''}{$config.url}/images/upload-img.png{/if}");
            // error message here
            $('#post_submit').prop('disabled','true');
            alert("not an image");
            break;
    }

    });

</script>