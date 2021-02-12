{include file="common/header-1.tpl" nocache}
<!-- page content  -->
{include file="common/dashboard-navigation.tpl" nocache}

<div class="container">


  <!-- Modal -->
  <div class="modal reccuring-modal fade in" id="confirm" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header border-0">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <div class="panel panel-success m0">
            <div class="panel-heading green-bg">
                <h3>Are you sure ?</h3>
            </div>
          </div>
        </div>
        <div class="modal-body">


          <h3 class="text-center grey-text m20">You are targetting <span class="green-text mmem">100</span> Business and You will be charged <span class="red mprice">$10</span></h3>

          <div class="row">

            <div class="col-md-10 col-md-offset-1">

              <div class="row">

                <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                    <div class="scrl" id="style-1">
                    	Please note that it is a violation of the terms of use policy to send any message soliciting the sale of any product also appearing on the Herbal Electronic Exchange in an effort to circumvent any protections, services, taxes, or fees.  Users may be subject to sanction, suspension or expulsion if found violating this policy
                    </div>
                </div>

              </div>

              <div class="row">

                <div class="col-md-12">

                  <div class="checkbox">
                    <label class="p0">
                      <input type="checkbox" value="1" name="confirmcheck" class="confirmcheck">
                      <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                      I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                    </label>
                  </div>

                </div>

              </div>

            </div>

          </div>

        </div>
        <div class="modal-footer">

          <div class="row">
            <div class="col-md-10 col-md-offset-1">
              <div class="row">
                <div class="col-md-12">
                  <button class="btn btn-default btn-d black-g confirmclick" type="button" name="button" data-toggle="modal" data-target="#negotiable">Confirm </button>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>




    <div class="container-fluid grey-bg p0">
        <div class="page-caption m50">
            <h1>Create your Targeted Message</h1>
        </div>
        <div class="row  m50"><div class="col-md-12 flex">
            <div class="col-lg-6 col-md-8 margin-auto white-bg-2 p35 shadow">
                <!-- <h3 class="fancy-title green text-center">Create your Targeted Message</h3> -->
                {if $error}
                 <h3 class="fancy-title red text-center">{$error}</h3>
                {/if}
                <p class="description text-center m30 m-t-0">
                    Define the target market for your message, by creating a title, choosing the type of business you want to target, the state and city. </p>
                 <form  method="POST" id="relationcompose" data-parsley-validate class="form-horizontal" action="{$config.url}/dashboard/relationshipsend">
                    <div class="row">
                    <input type="hidden" name="tarhidprice" class="tarhidprice" value="">
                    <input type="hidden" name="tarhidmem" class="tarhidmem" value="">
                    <input type="hidden" name="user_id" class="user_id" value="{$loged.userid}">
                    <input type="hidden" name="relcharge" class="relcharge" value="{$relatiocharge}">
                    <input type="hidden" name="currentbalance" class="currentbalance" value="{$userbalance.balance}">
                        <div class="col-md-12">

                            <div class="form-group">
                              <div class="col-sm-6">
                                <input class="w100 p15 pb15 grey-bg border-0" type="text" class="form-control" id="tittle" placeholder="Enter Message Title" name="tittle" data-parsley-required-message="Please Enter Message Title" data-required="true" data-parsley-required 
                               data-parsley-pattern="^[A-Za-z ]*$" 
                               pattern="^[A-Za-z ]*$" data-parsley-pattern-message="Please Enter Message Title">
                              </div>
                              <div class="col-sm-6">

                                <select class="w100 p15 pb15 grey-bg border-0 busstarget" data-parsley-required data-parsley-required-message="Please Select Type of Business" place-holder="Select Type of Business"  data-parsley-required name="busstype" id="btye">
                                  {foreach $relationtype as $key => $val}
                                  <option class="black" value="">Type of Business</option>
                                  <option class="black" value="grower" data-id="{$val.grower}">Grower</option>
                                  <option class="black" value="producer" data-id="{$val.producer}" >Producer</option>
                                  <option class="black" value="dispensary" data-id="{$val.dispensary}">Dispensary</option>
                                  <option class="black" value="supplier" data-id="{$val.supplier}">Supplier</option>
                                  {/foreach} 
                                  </select>
                                  <span class="green-text tarmessage" style="display: none;">You are targetting <span class="tarmem">100</span> Business and You will be charged <span class="tarprice">$10</span></span>
                              </div>
                            </div>
                            <div class="form-group">
                            <div class="col-sm-6">
                            
                        <select class="w100 p15 pb15 grey-bg border-0 busstarget" name="shipping_country" id="country" data-parsley-required-message="Please select country" place-holder="Targetting Country" data-parsley-required>
                            <option value="">Targetting Country</option>
                        </select>
                       
                            </div>
                            <div class="col-sm-6">
                           
                        <select class="w100 p15 pb15 grey-bg border-0 busstarget" name="shipping_state" id="state"  data-parsley-required data-parsley-required-message="Please select state" place-holder="Targetting State"  data-parsley-required>
                                <option value="">Targetting State</option>
                            </select>
                       
                            </div>
                               </div>

                            <div class="form-group">
                              <div class="col-sm-6">
                                 <div class="input-group">

                        <input class="w100 p15 pb15 grey-bg border-0" placeholder="Targetting City" name="shipping_city" value="{$shipping_city}" id="cityt"  class="form-control" type="text"  class="form-control" />
                        <!-- data-parsley-required data-parsley-required-message="Please enter City" data-required="true" data-parsley-group="block1" data-parsley-required -->
                         
                        </div>
                              </div>
                              <div class="col-sm-6">
                                
                        <select class="w100 p15 pb15 grey-bg border-0 busstarget" name="region" id="region"   place-holder="Targetting Region"  >
                                <option value="">Targetting Region</option>
                                <option value="north west">North West</option>
                                <option value="south west">South West</option>
                                <option value="north east">North East</option>
                                <option value="south east">South East</option>
                            </select>
                            <!-- data-parsley-required data-parsley-required-message="Please select Region" data-parsley-required -->
                              </div>
                            </div>
                            
                            <div class="form-group">
                              <div class="col-md-12">
                                <textarea class="grey-bg w100 p15 pb15 border1" placeholder="Type your 140 characters message" name="message" rows="6" cols="80" data-parsley-required-message = "Please Enter Message" data-parsley-required data-parsley-maxlength="140" ></textarea>
                                <br>
                                <span class="green-text tarmessage" style="display: none;">You are targetting <span class="tarmem">100</span> Business and You will be charged <span class="tarprice">$10</span></span>
                              </div>
                            </div>



                              <div class="row flex">
                                  <div class="col-sm-2 margin-auto" style="margin-right:30px;">
                                    <button class="btn btn-default btn-d-b green-b m0" id="relatbtn" type="button"  data-target="#confirm" data-record-price="" data-record-mem="" onclick="showvali(this);">SEND</button>
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
<script>
var gprice,gmem = '';
function showvali(val){
  var vali =  $('#relationcompose').parsley().validate();
  if(vali === false){return false;}
  gprice = $(val).attr('data-record-price');
  gmem = $(val).attr('data-record-mem');
  $($(val).data('target')).modal();
}
$(document).ready(function () {
  $('.busstarget').change(function(){
    //var mem = $(this).find(':selected').attr('data-id');
    // relatiocharge
    var relcharge = $('.relcharge').val();
    var btype = $('#btye').find(":selected").val();
    var tcount = $('#country').find(":selected").val();
    var tstate = $('#state').find(":selected").val();
    var tstate = $('#state').find(":selected").val();
    var region = $('#region').find(":selected").val();
    var city = $('#cityt').val();
    //console.log("btype"+btype+"/tcount"+tcount+"/tstate"+tstate+"/region"+region+"/city"+city);
    if(btype!='' && tcount!='' && tstate!=''){

      $.ajax({
      type : 'POST',
       dataType : 'json',
      url : '/bustargetcount',
      data : 'btype='+btype+'&tcount='+tcount+'&tstate='+tstate+'&region='+region+'&city='+city,
      success : function(data) {
                 //console.log(data);
         if(data.success == 1){

          var mem = data.countuser;

          var price = (parseFloat(mem) * parseFloat(relcharge)).toFixed(2);
         //console.log('price', price);
          $('.tarmessage').fadeIn();
          $('.tarmem').html(mem);
          $('.tarprice').html('$'+price);
          $('.tarhidprice').val(price);
          $('.tarhidmem').val(mem);
          $('#relatbtn').attr('data-record-price', price);
          $('#relatbtn').attr('data-record-mem', mem);
           $('#relatbtn').prop("disabled",false);
         }
         else{
          var mem = data.countuser;
          var price = (parseFloat(mem) * parseFloat(relcharge)).toFixed(2);
          $('.tarmessage').fadeIn();
          $('.tarmem').html(mem);
          $('.tarprice').html('$'+price);
          $('.tarhidprice').val(price);
          $('.tarhidmem').val(mem);
          $('#relatbtn').attr('data-record-price', price);
          $('#relatbtn').attr('data-record-mem', mem);
          $('#relatbtn').prop("disabled",true);
         }

      }
      });

    }

});
   $("#cityt").focusout('paste',function() {
    //var mem = $(this).find(':selected').attr('data-id');
    var btype = $('#btye').find(":selected").val();
    var tcount = $('#country').find(":selected").val();
    var tstate = $('#state').find(":selected").val();
    var tstate = $('#state').find(":selected").val();
    var region = $('#region').find(":selected").val();
    var city = $('#cityt').val();
    var relcharge = $('.relcharge').val();
    //console.log("btype"+btype+"/tcount"+tcount+"/tstate"+tstate+"/region"+region+"/city"+city);
    if(btype!='' && tcount!='' && tstate!=''){

      $.ajax({
      type : 'POST',
       dataType : 'json',
      url : '/bustargetcount',
      data : 'btype='+btype+'&tcount='+tcount+'&tstate='+tstate+'&region='+region+'&city='+city,
      success : function(data) {
                         //console.log(data);
         if(data.success == 1){
          var mem = data.countuser;
          var price = (mem * relcharge).toFixed(2);
          $('.tarmessage').fadeIn();
          $('.tarmem').html(mem);
          $('.tarprice').html('$'+price);
          $('.tarhidprice').val(price);
          $('.tarhidmem').val(mem);
          $('#relatbtn').attr('data-record-price', price);
          $('#relatbtn').attr('data-record-mem', mem);
          $('#relatbtn').prop("disabled",false);

         }
         else{
          var mem = data.countuser;
          var price = (mem * relcharge).toFixed(2);
          $('.tarmessage').fadeIn();
          $('.tarmem').html(mem);
          $('.tarprice').html('$'+price);
          $('.tarhidprice').val(price);
          $('.tarhidmem').val(mem);
          $('#relatbtn').attr('data-record-price', price);
          $('#relatbtn').attr('data-record-mem', mem);
           $('#relatbtn').prop("disabled",true);
         }

      }
      });

    }

});
   
  $('#confirm').on('show.bs.modal', function(e) {
            //var data = $(e.relatedTarget).data();
            //console.log(data);
            $('.mprice', this).text(gprice);
            $('.mmem', this).text(gmem);
            //$('.btn-ok', this).data('recordId', data.pdt);
            //$('.btn-ok', this).data('recordId', data.userid);
        });

   $('.confirmclick').click(function() {
       var bls_amount  =parseFloat({$userbalance.balance});
       var charged_amt = parseFloat($('.mprice').text());

    if($(".confirmcheck").prop('checked') == true){
        if(bls_amount >= charged_amt){
            $("#relationcompose").submit();
        }else{
            alert("Please Check Your Account Balance");
        }
     } 
     else{
      alert("please check the terms and condtions");
     }

   });
}); 
    $(function () {
        var ctry = '{$shipping.country}';
        if (ctry != '')
            $('#country').val(ctry);

    });

    $(function () {
        ////console.log("{$users}");
        //populateCountries("country1", "state1");
        populateCountries("country", "state");
        var ctry = '{$users.country}';
        if (ctry != '')
            $('#country').val(ctry);
            //$('#country1').val(ctry);
        loadState();

    });

    
</script>
<script type="text/javascript">
  $('.howworks').click(function(){
   $('html, body').animate({
       scrollTop: $("#howworksSec").offset().top
   }, 1000);
  });
</script>
<script>

    $('#filecount').filestyle({
     input : true,
     buttonName : '',
     iconName : 'fa fa-pencil',
     buttonText: ''
    });

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
</script>