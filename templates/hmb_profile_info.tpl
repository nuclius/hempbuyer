{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}

    <style>
        .wrapper1 {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            position: absolute;
            top: 0px;
            right: -60px;
        }
        .wrapper1 .file-upload {
            height: 50px;
            width: 50px;
            border-radius: 100px;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 4px solid #FFFFFF;
            overflow: hidden;
            background-image: linear-gradient(to bottom, #DBE2EA 50%, #878B95 50%);
            background-size: 100% 200%;
            transition: all 1s;
            color: #adadad;
            font-size: 100px;
            box-shadow: 2px 2px 4px 0px #e6e6e6;
        }
        .wrapper1 .file-upload input[type='file'] {
            height: 200px;
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
            cursor: pointer;
        }
        .wrapper1 .file-upload:hover {
            background-position: 0 -100%;
            color: #2F2E32;
        }
        .lakodama
        {
                font-size: 20px;
        }
        .custom-select {
            background-color: #fff !important;
        }
    </style>
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    PROFILE
                </h3>
            </div> 
        </div>
         <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href="/profileInfo" class="active">Profile Info</a></li>
                    <li><a href="/passwordInfo" class="">Change Password</a></li>
                    <li><a href="/paymentInfo" class="">Payment</a></li>
                    <li><a href="/transactionsInfo" class="">Transactions</a></li> 
                    <li><a href="/bank_list" class="">Bank Details</a></li> 
                </ul>
            </div>
            <div class="db-right-con">
                <div class="ppic-wrap" style="display: none;">
                    <img src="/uploads/{$userData.profile_pic}" class="pp-img profile-pic" alt="No Image Available" onerror="this.onerror=null;this.src='/no_image.png';" />
                    <div class="wrapper1">
                        <div class="file-upload">
                            <input type="file" name="profilePic" onchange="editProfilePicUpload(this);" accept=".png, .jpeg, .jpg" /> <i class="fa fa-edit lakodama"></i>
                        </div>
                    </div> 
                </div>
                <div role="tabpanel">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs rps-tabs" role="tablist">
                        {if $role == '1' || $role == '2' || $role == '3'}
                        <li role="Representative">
                            <a href="#ind-info" aria-controls="ind-info" role="tab" data-toggle="tab" class="{if $role=='1'}active{else/}{/if}">
                                {if $role=='1'}Individual Info{/if}
                                {if $role=='2'}Representative Info{/if}
                                {if $role=='3'}Company Info{/if}
                            </a>
                        </li>
                        {/if}
                         
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane {if $role=='1' || $role == '2' || $role == '3'}active{else/}{/if}" id="ind-info">
                            <form class="pp-form user_info" data-parsley-validate novalidate id="user_info">
                                {if $role == '3'}
                                    <div class="row">
                                        <div class="col-12 form-group">
                                            <label class="sf-label">Company Name</label>
                                            <div class="icon-input">
                                                <div class="icon-box">
                                                    <img src="images/company.png" alt="" />
                                                </div>
                                                <input class="form-control userInfo" data-field="business_name" value="{if !$userData.business_name}{else/}{$userData.business_name}{/if}" placeholder="Company Name" required />
                                            </div>
                                        </div> 
                                    </div>
                                {/if}
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Name</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/user.png" alt="" />
                                            </div>
                                            <input class="form-control userInfo" data-field="name" value="{if !$userData.name}{else/}{$userData.name}{/if}" placeholder="Name" required />
                                        </div>                                    
                                    </div>

                                     

                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Email</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/email.png" alt="" />
                                            </div>
                                            <input type="email" class="form-control userInfo" data-field="email2" value="{if !$userData.email2}{else/}{$userData.email2}{/if}" placeholder="Email" required />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Phone Number</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/flag.png" alt="" />
                                            </div>
                                            <input class="form-control phone_us userInfo" data-field="phone" value="{if !$userData.phone}{else/}{$userData.phone}{/if}" placeholder="Phone Number" required parsley-type="phone" data-parsley-trigger="change" data-parsley-minlength="17" data-parsley-minlength-message="Phone number is invalid." />
                                        </div>
                                    </div>

                

                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Street Address</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control userInfo" data-field="address" value="{if !$userData.address}{else/}{$userData.address}{/if}" placeholder="Street Address" required />
                                        </div>
                                    </div>
                                </div>
                                 
                                <div class="row"> 
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">City</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control userInfo" data-field="city" value="{if !$userData.city}{else/}{$userData.city}{/if}" placeholder="City" required />
                                        </div>
                                    </div>

                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">State</label>
                                        <div class="clearfix cselec-wrap">
                                            <select class="custom-select loc-selc userInfo" data-field="state" required>
                                                {foreach $states as $key => $val}
                                                    <option value="{$val.abbrev}" {if $state==$val.abbrev}selected{/if}>{$val.name} </option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row"> 

                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Country</label>
                                        <div class="clearfix cselec-wrap">
                                            <select class="custom-select loc-selc userInfo" data-field="country" required>
                                                <option value='United States' selected>United States</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Zipcode</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control userInfo" data-field="zipcode" placeholder="Zipcode" value="{if !$userData.zipcode}{else/}{$userData.zipcode}{/if}" required />
                                        </div>
                                    </div>
                                </div>
                                 
                                <div class="pt-3">
                                    <input type="hidden" id="user-id" value="{$userData.id}">
                                    <button class="btn btn-brown btn-lg save_user_info" type="button">SAVE CHANGES</button>
                                    <span id="userInfoError" style="text-align: center; color: red;"></span>
                                </div>
                            </form>
                        </div>
                        <div role="tabpanel" class="tab-pane {if $role=='2'}active{else/}{/if}" id="rep-info" style="display: none;">
                            <form>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">First Name</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/user.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Jerry" />
                                        </div>
                                    </div> 
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Phone Number - 1</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/flag.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="1-834-454-0923" />
                                        </div>
                                    </div> 
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Email</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/email.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Jerry@ghj.com" />
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Street Address</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Pegasus Street Executive Center. 11325" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Suite / Other</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Suite / Others" />
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">City</label>
                                        <div class="clearfix cselec-wrap">
                                            <select class="custom-select loc-selc">
                                                <option>Dallas</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">State</label>
                                        <div class="clearfix cselec-wrap">
                                            <select class="custom-select loc-selc">
                                                <option>Texas</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Zipcode</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="1910" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Country</label>
                                        <div class="clearfix cselec-wrap">
                                            <select class="custom-select loc-selc">
                                                <option>United States</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="pt-3">
                                    <button class="btn btn-brown btn-lg" type="button" data-toggle="modal" data-target="#ps-success">SAVE CHANGES</button>
                                </div>
                            </form>
                        </div>
                        <div role="tabpanel" class="tab-pane {if $role=='3'}active{else/}{/if}" id="comp-info" style="display: none;">
                            <form>
                                <div class="row">
                                    <div class="col-12 form-group">
                                        <label class="sf-label">Company Name</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/company.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Company Name" />
                                        </div>
                                    </div> 
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">First Name</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/user.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Jerry" />
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Last Name</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/user.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Lidwin" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Phone Number - 1</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/flag.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="1-834-454-0923" />
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Phone Number - 2</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/flag.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="1-834-454-0923" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Email</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/email.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Jerry@ghj.com" />
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Street Address</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Pegasus Street Executive Center. 11325" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Suite / Other</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="Suite / Others" />
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">City</label>
                                        <div class="clearfix cselec-wrap">
                                            <select class="custom-select loc-selc">
                                                <option>Dallas</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">State</label>
                                        <div class="clearfix cselec-wrap">
                                            <select class="custom-select loc-selc">
                                                <option>Texas</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Zipcode</label>
                                        <div class="icon-input">
                                            <div class="icon-box">
                                                <img src="images/marker.png" alt="" />
                                            </div>
                                            <input class="form-control" placeholder="1910" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="sf-label">Country</label>
                                        <div class="clearfix cselec-wrap">
                                            <select class="custom-select loc-selc">
                                                <option>United States</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="pt-3">
                                    <button class="btn btn-brown btn-lg" type="button" data-toggle="modal" data-target="#ps-success">SAVE CHANGES</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
         </div>
    </div>
</section>

<div class="modal fade hb-modal" id="userInfo-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body"> 
                <h4 class="text-center">YOU HAVE BEEN SUCCESSFULLY UPDATED YOUR PROFILE</h4> 
                <div class="lsc-msg">
                    <img src="./images/user-icon.png" alt="user">
                </div>
                <!-- <div class="ss-txt">
                    YOU HAVE BEEN SUCCESSFULLY UPDATED
                </div> -->
                <button class="btn btn-prev" type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    THANK YOU
                </button>
            </div> 
        </div>
    </div>
</div>

<script>
       $(document).ready(function (e) {
           console.log('called1')
            $(document).keypress(function (e) {
                if (e.which == 13) {
                    console.log('called')
                    if ($("#userInfo-success").css("display") == "block") {
                        $("#userInfo-success").modal('hide')
                    }
                }
            });
        });
    
</script>

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        $('.phone_us').mask('+1 (000) 000-0000');

        $('body').on('click', '.save_user_info', function (e) {
            if ($('.user_info').parsley().validate()) {
                var dataobj = {};
                var updatedColumns = '';
                $('.userInfo').each(function(i, v) {
                    var fieldName = $(this).attr('data-field');
                    var fieldValue = $(this).val();
                    dataobj[fieldName] = fieldValue;
                });
                var userId = $('#user-id').val();
                if(userId && userId != 0 && userId != "undefined" && userId != null) {
                    dataobj['user_id'] = userId;
                    $.ajax({
                        type: "POST",
                        url: "{$config.url}/updateProfileInfo",
                        data: dataobj,
                        dataType: 'json',
                        success: function (data) {
                            if (data.status == 'success')
                                $('#userInfo-success').modal('show');
                            else
                                $('#userInfoError').html(data.statusText);
                        }
                    });
                } else
                    $('#userInfoError').html('Cannot update user information');
            }
        });
    });

    /* Start Upload User Profile Picture */
    function editProfilePicUpload(obj) {
        var files = $('input[name="profilePic"]')[0].files;
        var formData = new FormData();
        formData.append('profile', files[0]);
        formData.append('id', $('#user-id').val());
        var fileName = '';
        $.ajax({
            url : '/uploadProfilePic',
            type : 'POST',
            xhr: function() {
                var myXhr = $.ajaxSettings.xhr();
                return myXhr;
            },
            data : formData,
            processData: false,
            contentType: false,
            success : function(res) {
                fileName = res;
            },
            error: function(e) {
                console.log(e);
            },
        }).done(function() {
            $('.profile-pic').attr('src', base_url+'/uploads/'+fileName);
        });
    }
    /* End Upload User Profile Picture */
</script>