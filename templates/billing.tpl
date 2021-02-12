
{include file="common/header-1.tpl" nocache}

<!-- Page content -->

{include file="common/dashboard-navigation.tpl" nocache}

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row"> 
      <!-- common sidebar here -->
      <div class="col-md-3 sidebar  mb-25  mb-25"> 
        <div class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Billing and Account Information <i class="fa fa-angle-down"></i></a>
          {include file="common/dashboard_settings_menu.tpl" nocache}
        </div>
      </div> 
      <!-- / Sidebar -->
      <div class="col-md-9 content-area">


        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Billing and Account Information</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">
          {if $updation_status}
            <div class="alert alert-success">
                <strong>Success!</strong> &nbsp;&nbsp;" Billing details updated successfully!"
            </div>
            {/if}
            <form action="{$config.url}/profile_settings/billing" data-parsley-validate method="post" id="paypal-form">
            <div class="row">

              <div class="col-xs-12 notifications">

                <div class="row">

                  <div class="col-md-6">

                    <div class="form-group">

                      <input class="w100 p15 pb15 grey-bg border-0" type="text" id="bank_name" placeholder="Bank Name" name="bank_name" value="{$billing.bank_name}" data-parsley-required data-parsley-pattern="^[a-zA-Z ]*$" pattern="^[a-zA-Z ]*$" data-parsley-pattern-message="Invalid bank name" data-parsley-required>

                    </div>

                  </div>
                  <div class="col-md-6">

                    <div class="form-group">

                      <input class="w100 p15 pb15 grey-bg border-0" type="text" id="routing_number" placeholder="Routing Number" name="routing_number" data-parsley-type="number" data-parsley-required value="{$billing.routing_number}">

                    </div>

                  </div>
                  <div class="col-md-6">

                    <div class="form-group">

                      <input class="w100 p15 pb15 grey-bg border-0" type="text" id="name" data-parsley-pattern="^[a-zA-Z ]*$" pattern="^[a-zA-Z ]*$" data-parsley-pattern-message="Invalid account holder name" placeholder="Account Holder Name" name="name" data-parsley-required value="{$billing.name}">

                    </div>

                  </div>
                  <div class="col-md-6">

                    <div class="form-group">

                      <input class="w100 p15 pb15 grey-bg border-0" data-parsley-type="number" type="text" id="account_number" placeholder="Account Number"  name="account_number" data-parsley-required value="{$billing.account_number}">
                    </div>

                  </div>

                  <div class="col-md-12">

                    <div class="form-group">
                      <button class="btn btn-default btn-d-b green-b m0" type="submit">SAVE</button>
                    </div>

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
<script type="text/javascript">
  

 $(function () {
        ////console.log("{$shipping}");
        populateCountries("country", "state");
        var ctry = '{$shipping.country}';
        if (ctry != '')
            $('#country').val(ctry);
        loadState();

    });

</script>
</body>
</html>
