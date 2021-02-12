 {include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row">
            <!-- common sidebar here -->
              <div class="col-md-3 sidebar  mb-25  mb-25"> 
                <div class="dropdown">
                  <a class="dropdown-toggle" data-toggle="dropdown">Sales Tax <i class="fa fa-angle-down"></i></a>
                  {include file="common/dashboard_settings_menu.tpl" nocache}
                </div>
              </div> 
            <!-- / Sidebar -->
            <div class="col-md-9 content-area">
                <div class="row">
                    <div class="panel panel-success m5 m-t-0">
                        <div class="panel-heading green-bg">
                            <h3>Sales Tax</h3>
                        </div>
                    </div>
                    <div class="col-md-12 white-bg-2 p35 shadow">
                        {if $updation_status}
                        <div class="alert alert-success">
                            <strong>Success!</strong> &nbsp;&nbsp;" Sales tax updated successfully!"
                        </div>
                        {/if}
                        <form action="{$config.url}/profile_settings/stax" data-parsley-validate method="post" id="paypal-form" onsubmit="return salestaxcheck()">
                            <div class="row">
                                <div class="col-xs-12 notifications">
                                    <div class="row">
                                        <div class="col-md-12 form-group form-inline text-left ">
                                            <label class="lab-clr">Do you need to charge local sales tax on items sold?</label>                                            
                                            <!-- <label class="lab-clr">Do you need to charge sales tax on items sold?</label> -->
                                            <!-- <div> -->
                                            <div class="radio radio-inline radio-primary ">
                                                <input data-parsley-trigger="change focusout" type="radio" name="stax" id="stax1" value="y" {if $stax.stax=='y'} checked="true" {/if} >
                                                <label for="stax1"> Yes </label>
                                                <!--                               </div>
                                  <div class="radio radio-inline radio-primary"> -->
                                                <input data-parsley-trigger="change focusout" type="radio" name="stax" id="stax2" value="n" {if $stax.stax=='n'} checked="true" {/if}>
                                                <label for="stax2"> No </label>
                                            </div>
                                            <!-- </div> -->
                                        </div>
                                    </div>
                                    <div class="row">
                                      <div class="col-md-12 form-group form-inline text-left ">
                                          <label class="lab-clr">Enter the sales tax percentage</label>
                                          <div class="input-group">
                                            <input data-parsley-trigger="change focusout" class="form-control" name="stax_per" id="stax_per" data-parsley-required class="form-control" type="text" data-parsley-type="number" data-parsley-min="1" data-parsley-min-message="Please enter value more than or equal to 1" data-parsley-required-message="Please enter sales tax" placeholder="Sales tax (%)" class="form-control" data-required="true" data-parsley-group="block3" data-parsley-group="block3" data-parsley-errors-container="#stax_per-err" value="{$stax.stax_per}" />
                                            <span class="input-group-addon" id="basic-addon2">&nbsp;</span>
                                          </div>
                                      <span id="stax_per-err" class="err-message"></span>
                                      </div>
                                       <!--  <div class="col-md-6">
                                            <div class="form-group">
                                                <input class="w100 p15 pb15 grey-bg border-0" type="text" id="stax_per" placeholder="Routing Number" name="stax_per" data-parsley-type="number" data-parsley-required value="{$stax.stax_per}">
                                            </div>
                                        </div> -->
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <button class="btn btn-default btn-d-b green-b m0" type="submit">SAVE</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>

                        <span class="notes">
                            Note : If Herbee is your distributor/transporter, the system will automatically collect taxes required by the state.  You are required to collect and file all local taxes.  Please input any local sales tax required for items you sell.
                        </span>
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



<script type="text/javascript">
$(function() {
    ////console.log("{$shipping}");
    populateCountries("country", "state");
    var ctry = '{$shipping.country}';
    if (ctry != '')
        $('#country').val(ctry);
    loadState();

});

   /* sales tax */
    $('input[type=radio][name=stax]').change(function() {
       //console.log('running');
      if (this.value == 'y') { 
        $('input[type=text][name=stax_per]').prop('disabled', false);
        $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
        $('input[type=text][name=stax_per]').attr({ "data-parsley-required-message" : "Please enter sales tax" , "data-parsley-required":true });
        $('input[type=text][name=stax_per]').prop('title','Enter the sales tax(%)...!');
        $('#stax_per-err').show();
      }
      if (this.value == 'n') { 
        $('input[type=text][name=stax_per]').val(0);
        $('input[type=text][name=stax_per]').prop('disabled', true);
        $('input[type=text][name=stax_per]').prop('data-toggle','tooltip');
        $('input[type=text][name=stax_per]').removeAttr("data-parsley-required data-parsley-min data-required");
        $('input[type=text][name=stax_per]').prop('title','Select yes to enable...!');
        $('#stax_per-err').hide();
      }
    });
</script>

{if $stax.stax=='n'}

<script type="text/javascript">
 $('input[type=radio][name=stax]').prop('checked', true).trigger('change');  
</script>

{/if}

</body>

</html>

<script type="text/javascript">
    function salestaxcheck(){
     if($('#stax1').is(':checked') && $('#stax_per').val() <= 0) {
      swal('Invalid Sales Tax Value');
      return false;
     }else{
      return true;
     }
    }
</script>