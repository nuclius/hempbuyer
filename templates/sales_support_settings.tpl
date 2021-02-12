<!-- ===================== start change by divyesh (added) ===================== -->
{include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">
      <!-- common sidebar here -->
      <div class="col-md-3 sidebar  mb-25  mb-25">
        <div class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Sales Support <i class="fa fa-angle-down"></i></a>
          {include file="common/dashboard_settings_menu.tpl" nocache}
        </div>
      </div>
      <!-- / Sidebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

            <div class="panel-heading green-bg">
              <h3>Sales Support</h3>
            </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">
            {if $updation_status}
            <div class="alert {if $updation_status==1}alert-success{/if} {if $updation_status==2}alert-danger{/if}">
              {$update_message}
            </div>
            {/if}


            <form action="/profile_settings/update_sales_support_settings" method="POST"
              class="form-horizontal registration-form" id="registration_form" enctype="multipart/form-data"
              data-parsley-validate>
              <fieldset>
                <div class="">
                  <div class="col-md-12 form-group text-left ">
                    <label class="lab-clr"> Would you like to be contacted by a Sales Consultant to discuss how Herbee
                      can
                      help grow your business?</label>
                    <div>
                      <div class="radio radio-inline radio-primary pull-left">
                        <input type="radio" name="helpgrow" id="helpgrow1" value="1" {if $ss_data.help_grow==1}
                          checked="checked" {/if}> <label for="helpgrow1"> Yes </label>
                      </div>
                      <div class="radio radio-inline radio-primary">
                        <input type="radio" name="helpgrow" id="helpgrow2" value="0" {if $ss_data.help_grow==0}
                          checked="checked" {/if}> <label for="helpgrow2"> No </label>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="no_helpgrow">
                  <div class="">
                    <div class="col-md-12 form-group text-left ">
                      <label class="lab-clr">Do you already have a Herbee Sales Consultant?</label>
                      <div>
                        <div class="radio radio-inline radio-primary pull-left">
                          <input type="radio" name="HerbeeSalesConsultant" id="HerbeeSalesConsultant1" value="1" {if
                            $ss_data.sales_consultant==1} checked="checked" {/if}> <label for="HerbeeSalesConsultant1">
                          Yes </label>
                        </div>
                        <div class="radio radio-inline radio-primary">
                          <input type="radio" name="HerbeeSalesConsultant" id="HerbeeSalesConsultant2" value="0" {if
                            $ss_data.sales_consultant==0} checked="checked" {/if}> <label for="HerbeeSalesConsultant2">
                          No </label>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="yes_HerbeeSalesConsultant">
                    <div class="form-group">
                      <div class="col-md-6">
                        <div class="">
                          <label>Sales Consultant Code </label>
                          <input data-parsley-trigger="change focusout" type="text"
                            class="w100 p15 pb15 grey-bg border-0" id="sccode" name="sccode" value="{$ss_data.sc_code}"
                            data-mask="AAAAA" placeholder="Sales Consultant Code" data-parsley-group="block2"
                            data-parsley-required-message="Please enter Sales Consultant Code" data-required="true"
                            data-parsley-required data-parsley-errors-container="#sccode-register-err">
                        </div>
                        <!-- <span id="sccode-check-err" class="err-message"></span> -->
                        <span id="sccode-register-err" class="err-message"></span>
                      </div>
                      <div class="col-md-6">
                        <div class="">
                          <label>Confirm Sales Consultant Code</label>
                          <input data-parsley-trigger="change focusout" type="text"
                            class="w100 p15 pb15 grey-bg border-0" id="csccode" name="csccode"
                            value="{$ss_data.sc_code}" data-mask="AAAAA" placeholder="Confirm Sales Consultant Code"
                            data-parsley-equalto="#sccode" data-parsley-errors-container="#csccode-err"
                            data-parsley-group="block2"
                            data-parsley-equalto-message="Sales Consultant Code do not match."
                            data-parsley-required-message="Please enter Sales Consultant Code to confirm"
                            data-required="true" data-parsley-required>
                        </div>
                        <span id="csccode-err" class="err-message"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-md-6">
                        <label class="lab-clr"> Consultant Agreement (*.jpg, *.jpeg, *.gif etc.)</label>
                        <div class="reg_file_upload">
                          <input data-parsley-trigger="change focusout" type="file" id="cagreement" name="cagreement"
                            data-parsley-errors-container="#cagreement_img-err" accept="image/*"
                            data-parsley-fileextension='jpg jpeg gif png' />
                        </div>
                        <div style="overflow: hidden;" class="mt-15">
                          <img id="cagreementImg" src="{$config.url}/uploads/cagreement/{$ss_data.consultant_agreement}"
                            height="100px" style="margin: auto; display: block;" />
                        </div>
                        <button type="button" class="btn btn-grn wid100 fnt14 mt-15"
                          onclick="chooseConsultantAgreement();" tabindex="3">Upload</button>
                        <span id="cagreement_img-err" class="err-message"></span>

                        <!-- <button type="submit" class="btn btn-grn wid100 fnt14">Upload</button> -->
                      </div>
                    </div>
                    <div class="form-group mt-20">
                      <div class="col-md-6">
                        <div class="">
                          <label>Start Date</label>
                          <input name="start_date" id="start_date" class="date_picker w100 p15 pb15 grey-bg border-0"
                            placeholder="Start Date" data-parsley-required-message="Please enter start date"
                            data-required="true" data-parsley-required data-parsley-errors-container="#sdate-err"
                            value="{$ss_data.start_date}" autocomplete="off">
                        </div>
                        <span id="sdate-err" class="err-message"></span>
                      </div>
                      <div class="col-md-6">
                        <div class=" ">
                          <label>End Date</label>
                          <input name="end_date" id="end_date" class="date_picker w100 p15 pb15 grey-bg border-0"
                            placeholder="End Date" data-parsley-required-message="Please enter end date"
                            data-required="true" data-parsley-required data-parsley-errors-container="#edate-err"
                            value="{$ss_data.end_date}" autocomplete="off">
                        </div>
                        <span id="edate-err" class="err-message"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-md-6">
                        <div class="">
                          <label>Consultant Fee %</label>
                          <input type="text" name="cfee" id="cfee" class="w100 p15 pb15 grey-bg border-0"
                            placeholder="Consultant Fee %" data-parsley-required-message="Please enter consultant fee"
                            data-required="true" data-parsley-required data-parsley-errors-container="#cfee-err"
                            data-parsley-type="number" data-parsley-minlength="1" data-parsley-maxlength="3"
                            value="{$ss_data.consultant_fee}">
                        </div>
                        <span id="cfee-err" class="err-message"></span>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="text-right">
                  <button type="submit" class="btn btn-grn" tabindex="37">Save</button>
                </div>
              </fieldset>

              <input type="hidden" name="email" value="{$email}">
              <input type="hidden" name="old_sc_code" value="{$ss_data.sc_code}">
              <input type="hidden" name="old_consultant_agreement" value="{$ss_data.consultant_agreement}">
              <input type="hidden" name="id" value="{$ss_data.id}">

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
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script>

  $(document).ready(function () {
    $('input[type=radio][name=helpgrow]').change(function () {
      if (this.value == '1') {
        $('.no_helpgrow').hide();
      }
      if (this.value == '0') {
        $('.no_helpgrow').show();
      }
    });

    $('input[type=radio][name=HerbeeSalesConsultant]').change(function () {
      if (this.value == '1') {
        $('.yes_HerbeeSalesConsultant').show();
      }
      if (this.value == '0') {
        $('.yes_HerbeeSalesConsultant').hide();
      }
    });

    $(function () {
      Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
      Date.format = 'mm/dd/yyyy';
      var dt = '{$serverdate}';

      var logic1 = function (currentDateTime) {
        var begD = new Date(currentDateTime)
        var endD = new Date($("#end_date").val());
        if (begD == 'Invalid Date') {
          alert('Please Select Start Date');
          $("#end_date").val('');
        } else if (endD != 'Invalid Date' && begD > endD) {
          alert('Start Date Must Be less Than End date');
          $("#start_date").val('');
        }
      };
      $("#start_date").datetimepicker({
        inline: false,
        step: 01,
        onChangeMonth: logic1,
        onSelectDate: logic1,
        minDate: dt,
        format: 'Y-m-d H:m',
      });

      var logic = function (currentDateTime) {
        var begD = new Date($("#start_date").val());
        var endD = new Date(currentDateTime);
        if (begD == 'Invalid Date') {
          alert('Please Select Start Date');
          $("#end_date").val('');
        } else if (begD > endD) {
          alert('End Date Must Be Greater Than Start date');
          $("#end_date").val('');
        }

      };
      $("#end_date").datetimepicker({
        step: 01,
        onChangeMonth: logic,
        onSelectDate: logic,
        showHeader: 2,
        minDate: dt,
        format: 'Y-m-d H:m',
      });
    });


  });

  function chooseConsultantAgreement() {
    $("#cagreement").click();
  }
  document.getElementById("cagreement").onchange = function () {
    var reader = new FileReader();
    reader.onload = function (e) {
      ////console.log(e);
      // get loaded data and render thumbnail.
      document.getElementById("cagreementImg").src = e.target.result;
    };
    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
  };
</script>

</body>

</html>
<!-- ===================== end change by divyesh (added) ===================== -->
