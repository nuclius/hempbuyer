{include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row">
            <!-- common sidebar here -->
              <div class="col-md-3 sidebar  mb-25  mb-25"> 
                <div class="dropdown">
                  <a class="dropdown-toggle" data-toggle="dropdown"> Messages <i class="fa fa-angle-down"></i></a>
                  {include file="common/dashboard_settings_menu.tpl" nocache}
                </div>
              </div> 
            <!-- / Sidebar -->
            <div class="col-md-9 content-area">
                <div class="row">
                    <div class="panel panel-success m5 m-t-0">
                        <div class="panel-heading green-bg">
                            <h3>Messages</h3>
                        </div>
                    </div>
                    <div class="col-md-12 white-bg-2 p35 shadow">
                        <!-- <form class="form-horizontal" action=""> -->
                        <form action="/profile_settings/update" method="POST" class="form-horizontal registration-form" id="user_profile" enctype="multipart/form-data" data-parsley-validate>
                            <!--                 <input type="hidden" name="hidden_country" id="hidden_country" value="{$users.country}">
                <input type="hidden" name="hidden_state" id="hidden_state" value="{$users.state}"> -->
                            <div class="row">
                                <div class="col-md-12">
<!-- 
                  <div class="row">
                    <div class="col-md-12 text-right m20">
                      <a class="" href="create-bussiness-pool.html"><i class="fa fa-plus icon"></i>Create New Message</a>
                    </div>
                  </div> -->

                  <div class="row">

                   {foreach $messages as $key => $val}

                    <div class="col-md-12 feed-col">


                      <div class="">

                        <h4 class="description green-text lh-22">{$val.subject}</h4>    <div align="right">{$val.date_add}</div>
                        <p class="description grey-text lh-22">
                          <i>{$val.message} </i>
                        </p>

                        <!-- <ul class="m0 p0 pull-right">
                          <li class="inline-block"><a href="#"><i class="fa fa-thumbs-up icon green-text" aria-hidden="true"></i> <span class="green-text"><b>Interested?</b></span></a> </li>
                          <li class="inline-block ml-15"><a href="#"><i class="fa fa-thumbs-down icon grey" aria-hidden="true"></i> <span><b class="grey">Not Interested? </b></span></a></li>
                        </ul> -->


                      </div>

                    </div>
                    {/foreach}

                  </div>

                </div>
                 
                            </div>
                        </form>
                    </div>
                </div>
                {$pagination_html}
            </div>
            
            <!-- / Content Area -->
        </div>
        <!-- Parent Row -->
    </div>
    <!-- dashboard-settings-con -->
</div>

<!--/ Page content -->
{include file="common/footer-1.tpl" nocache}
<script>

$(function() {
    ////console.log("{$users}");
    populateCountries("country", "state");
    var ctry = '{$users.country}';
    if (ctry != '')
        $('#country').val(ctry);
    loadState();
});


$('#filecount').filestyle({
    input: true,
    buttonName: '',
    iconName: 'fa fa-pencil',
    buttonText: ''
});

$('#profile_image').filestyle({
    input: false,
    buttonName: 'btn btn-default btn-d-b btn-d-g m5',
    iconName: '',
    buttonText: 'UPLOAD'
});

document.getElementById("profile_image").onchange = function() {
    var reader = new FileReader();

    reader.onload = function(e) {
        // get loaded data and render thumbnail.
        document.getElementById("profile_img").src = e.target.result;
    };

    // read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
};

// $('#business_type').val('{$user.business_type}').change();
</script>
</body>

</html>