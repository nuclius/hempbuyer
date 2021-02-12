{include file="common/header-1.tpl" nocache}

<!-- Page content -->

{include file="common/dashboard-navigation.tpl" nocache}

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">
<!-- common sidebar here -->
      <div class="col-md-3 sidebar  mb-25  mb-25">
        <div class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Change Password <i class="fa fa-angle-down"></i></a>
          {include file="common/dashboard_settings_menu.tpl" nocache}
        </div>
      </div>
      <!-- / Sidebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Change Password</h3>
              </div>

          </div>

<div class="container">
  <!-- Trigger the modal with a button -->
<!--   <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#password_change">Open Modal</button> -->

  <!-- Modal -->
  <div class="modal fade" id="password_change" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content border-0">
        <div class="modal-header p0">
          <div class="panel panel-success border-0 m0">
              <div class="panel-heading green-bg">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h3>Password Reset</h3>
              </div>
          </div>
        </div>
        <div class="modal-body p35">
          <p class="text-center success-alert">Password Successfully Updated.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default btn-d-b green-b m0 centering f14" data-dismiss="modal">Close</button>
        </div>
      </div>

    </div>
  </div>

</div>




          <div class="col-md-12 white-bg-2 p35 shadow">

            <div class="row">

              <div class="col-xs-12 notifications">

                <div class="row">

                  <div class="col-md-12">
                  <form action="/dashboard/changepassword" method="post" id="change_password" name="change_password" accept-charset="utf-8" data-parsley-validate>

                    <div class="form-group">
<input type="password" id="old_password" name="old_password" title="Old Password" data-parsley-required-message="Please enter old password" data-parsley-group="block1" class="w100 p15 pb15 grey-bg border-0" placeholder="Old Password" required>
                      <!-- <input class="w100 p15 pb15 grey-bg border-0" type="password" id="password" placeholder="Current Password" name="old_password"> -->

                    </div>

                    <div class="form-group">
 <input type="password" id="new_password" name="new_password" data-parsley-minlength="6" data-parsley-required-message="Please enter new password" data-parsley-minlength-message ="Please enter a minimum of 6 characters" data-parsley-length-message ="Please enter a minimum of 6 characters" data-parsley-type-message="Password should be alphanumeric"  data-parsley-type="alphanum" title="New Password" data-parsley-group="block1" maxlength="20" required data-parsley-notequalto="#old_password" data-required="true" placeholder="New Password" class="w100 p15 pb15 grey-bg border-0" data-parsley-error-message="Password should not same as old password">
                      <!-- <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="New Password" name="email"> -->

                    </div>

                    <div class="form-group">
<input type="password" id="new_password" name="confirm_password" placeholder="Confirm Password" title="Confirm Password" data-parsley-group="block1" maxlength="20" required data-parsley-equalto="#new_password" class="w100 p15 pb15 grey-bg border-0" data-parsley-error-message="Password entered don't match">
                      <!-- <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="Confirm Password" name="email"> -->

                    </div>

                    <div class="form-group">
                    <button type="button" id="changepassword" class="btn btn-default btn-d-b green-b m0 centering f14">{$phrase.save}</button>
                      <!-- <button class="btn btn-default btn-d-b green-b m0" type="button">SAVE</button> -->
                    </div>
</form>
                  </div>

                </div>

              </div>

              </div>

            </div>




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
{if($save == true)}
            <script type="text/javascript">
              $(window).on('load',function(){
                  $('#password_change').modal('show');
              });
            </script>
{/if}

{include file="common/footer-1.tpl" nocache}
{literal}

<script language="javascript" type="text/javascript">
window.ParsleyValidator.addValidator('notequalto',
    function (value, requirement) {
        return value !== $(requirement).val();
    }, 32)
    .addMessage('en', 'notequalto', 'This values should not be the same.');
window.ParsleyConfig = {
  validators: {
    notdefault: {
      fn: function (value, requirement) {
        return value !== requirement;
      },
      priority: 32
    }
  },
  i18n: {
    en: {
      notdefault: 'This value may not be equal to %s'
    }
  }
};

      $('#changepassword').click(function()
      {
        window.ParsleyConfig = {
          validators: {
            notequalto: {
              fn: function (value, requirement) {
                return value !== requirement;
              },
              priority: 32
            }
          },
          i18n: {
            en: {
              notdefault: 'This value may not be equal to %s'
            }
          }
        };
        if(true == $('#change_password').parsley().validate('block1'))
        {

        $.ajax(
        {
          type:'POST',
          url :'/dashboard/changepassword',
          data: {isajax:1,password:$('#old_password').val()},
          dataType:'json',
          success:function(data)
          {
           //console.log('data',data);

            if(data == 1){
              $('#change_password').submit();
            } else if(data == 0){
              $('#old_password').next('ul').html('<li class="parsley-required">Old Password is in-correct</li>');
            }

          }

        });
        }
       });
</script>
{/literal}
</body>
</html>
