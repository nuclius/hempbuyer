 </div>
        <!-- /#page-wrapper -->

    </div>

<div class="modal fade" id="wireContact" role="dialog">
    <div class="modal-dialog modal-sm wd50" >
        <!-- Modal content-->
        <div id="contact_form" class="modal-content">
            <div class="modal-header p0">
                <div class="panel panel-success border-0">
                    <div class="panel-heading green-bg">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3>Enter the message...!</h3>
                    </div>
                </div>
            </div>
            <div class="modal-body form-horizontal">
              <form id="con_form" data-parsley-validate>
                <input type="hidden" value="0" name="r_id" id="r_id">
                <div class="form-group">
                    <label class="col-sm-3 col-md-2 control-label">Email-ID* :</label>
                    <div class="col-sm-9 col-md-10">
                        <input type="email" name="users" id="to_email" disabled="" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-md-2 control-label">Subject : </label>
                    <div class="col-sm-9 col-md-10">
                        <input type="sub_msg" name="subject" id="sub_msg" data-parsley-required data-parsley-required-message="Please enter subject" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 col-md-2 control-label">Message : </label>
                    <div class="col-sm-9 col-md-10">
                        <textarea name="message" id="body_msg" rows="6" data-parsley-required data-parsley-required-message="Please enter message to proceed..."></textarea>
                    </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default btn-d-b green-b m0" type="button" onclick="sendMessage()">SEND</button>
                <button class="btn btn-default btn-d-b green-b m0" type="button" data-dismiss="modal">CLOSE</button>
            </div>
        </div>
    </div>
</div>

 <!-- /#wrapper -->
 <!-- jQuery -->
 <script src="{$config.dpath}js/jquery.js"></script>
 <script src="{$config['externaljs']}intlTelInput.js"></script>
 <script src="{$config['externaljs']}bootstrap-filestyle.min.js"></script>
 <!-- <script src="{$config['externaljs']}sweetalert2.all.min.js"></script> -->
 <script src="{$config['externaljs']}sweetalert.min.js"></script>
 <!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
 <script src="{$config['externaljs']}jquery.datePicker.js"></script>
 <script src="{$config['externaljs']}jquery.datetimepicker.js"></script>
 <script>
    function formatMoney(number) {
        var numbers = number.toString().replace(/,/g, '');
        numbers = Number(parseFloat(numbers).toFixed(2)).toLocaleString();
        if(!numbers.includes('.')) {
            numbers = numbers+'.00';
        }
        return numbers;
    }
     $(function () {

         if(parseInt({$cnt}) >= 0){
             $('.addcart').prop('disabled',true);
         }

         var telInput = $("#mobile-number"),
                 errorMsg = $("#error-msg"),
                 validMsg = $("#valid-msg");

         // initialise plugin
         telInput.intlTelInput({
             nationalMode: false,
             utilsScript: "{$config['externaljs']}utils.js"
         });

         // on blur: validate
         telInput.blur(function () {
             if ($.trim(telInput.val())) {
                 if (telInput.intlTelInput("isValidNumber")) {
                     validMsg.removeClass("hide");
                     //$('#ad').find('input[type=submit]').prop('disabled', false);
                     $('.submit_form').prop('disabled', false);


                 } else {
                     telInput.addClass("error");
                     errorMsg.removeClass("hide");
                     validMsg.addClass("hide");
                     $('.submit_form').prop('disabled', true);
                 }
             }
         });

         // on keydown: reset
         telInput.keydown(function () {

             telInput.removeClass("error");
             errorMsg.addClass("hide");
             validMsg.addClass("hide");
         });

     });


 </script>


<script type="text/javascript">
$(document).on("click", ".contact_modal", function() {
    var uid = $(this).data('id');
    var to_email = $(this).data('email');
    $(".modal-body #uid").val(uid);
    $(".modal-body #to_email").val(to_email);
    $(".modal-body #sub_msg").val('');
    $(".modal-body #body_msg").val('');
});

function sendMessage() {
  
    if ($('#con_form').parsley().validate()) {
      $.ajax({
              type: 'POST',
              url: '{$config.url}/admincp/payment/sendmsg',
              data: {
                  r_id: $('#contact_form').find('#r_id').val(),
                  id: $('#contact_form').find('#uid').val(),
                  users: $('#contact_form').find('#to_email').val(),
                  subject: $('#contact_form').find('#sub_msg').val(),
                  message: $('#contact_form').find('#body_msg').val()
              },
              dataType: 'json',
              success: function(data) {
                  if (data.data == 1) {
                    swal('Message Sent');
                      $('#wireContact').modal('hide');
                  } else {
                    swal('Message Failed');
                      $('#wireContact').modal('hide');
                  }
              }
          });
    } else {
      swal('Please validate details...');
    }
    
    
}
</script>
<!-- Modal -->


<script type="text/javascript">

var formFunction = '';
/* function closeAll()
{
  $.ajax({
        type: "GET",
        url: "{$config.url}/product/closeall",
        data: '',        
        success: function(data){
         //console.log(2);
         //console.log(data);
            
           
         }
        });
       
} */
$(function() {

    populateCountries("country", "state");
    populateCountries("country_abbr", "state_abbr");
 //console.log(2);
//   closeAll();
  if(typeof(startDate) !== 'undefined')
  $("#date_added").datepicker({ minDate: startDate });

});
function intializeForm(form)
{
  formFunction = form;
}
function checkStateCity(form,id)
    {
     //console.log(id);
     //console.log("http://maps.googleapis.com/maps/api/geocode/json?address="+$('#'+form+' #zipcode').val());
      var params = {};
      if (window.XDomainRequest) {
            if (window.XDomainRequest) {
                var xdr = new XDomainRequest();
                var query = "http://maps.googleapis.com/maps/api/geocode/json?address="+$('#'+form+' #zipcode').val();
                if (xdr) {
                    xdr.onload = function () {
                     //console.log(JSON.parse(xdr.responseText));
                        sZipcode(JSON.parse(xdr.responseText),form,id);
                     }
                    xdr.onerror = function () { /* error handling here */ }
                    xdr.open('GET', query);
                    xdr.send();
                }
            }
        }
        else {
       $.ajax({
        type: "GET",
        url: "http://maps.googleapis.com/maps/api/geocode/json?address="+$('#'+form+' #zipcode').val(),
        data: params,
        
        success: function(data){
          sZipcode(data,form,id);
            
           
         }
        });
       }
    }   
    function sZipcode(data,form,id)
    {
     //console.log(data);
      if(data['results'].length > 0)
          {
            var m = data['results'][0]['address_components'].length;
           
           $('#'+form+' #city').val(data['results'][0]['address_components'][m-3]['long_name']);
           $('#'+form+' #state').val(data['results'][0]['address_components'][m-2]['long_name']);
           $('#'+form+' #country').val(data['results'][0]['address_components'][m-1]['long_name']);
           $('#'+form+' .addresscity').html($('#city').val()+','+$('#state').val()+','+$('#country').val());
           if(id == 1)
           {
             $('#'+form).submit();
           }  
           if(id == 2)
           {
             formFunction();
           }
          }
          else
          {
            alert('Invalid Zipcode');
            //$('#'+form+' #zipcode').focus();
            $('#'+form+' .addresscity').html('Invalid Zipcode');
            return false;
          }
    }
</script>
{foreach $external2js as $key => $val}
 <script src="{$config['externaljs']}{$val}.js"  type="text/javascript"></script>
{/foreach}
    <!-- Bootstrap Core JavaScript -->
    <script src="{$config.dpath}js/bootstrap.min.js"></script>
    <script src="{$config.dpath}js/common.js"></script>

 <script src="https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js"></script>

 <script src="https://cdn.datatables.net/1.10.9/js/dataTables.bootstrap.min.js"></script>
<script src="{$config.dpath}js/jquery.datePicker.js"  type="text/javascript"></script>

 <script>
     $(function(){
         $(document).ready(function(){
             $('#example').DataTable();
         });
     })

 </script>

</body>

</html>
