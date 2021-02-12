{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

  <style type="text/css">

  span.w-100 {
 /* width: 140px;*/
  float: left;
  height: 48px;
}
.pro_image {
  border-radius: 3px;
  background-color: #FFF;
  box-shadow: 0px 0px 2px #ccc;
  text-align: center;
   line-height:0;
  margin: 0px auto 0px;
  background-position: center center;
  background-size: cover;
  display: inline-block;
   width: auto;
  padding: 10px;
 height: auto;
}
.addresscity {
	color:#F00;
}
</style>
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-user"></i>  <i class="fa fa-hand-o-right"></i> <i class="fa fa-edit"></i> {if $users.id == 0 or $users.id == ''} {$pharse.add} {else} Edit {/if} {$pharse.users} <i class="fa fa-hand-o-right"></i> {$users.first_name} {$users.last_name} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-8"> {if $error == 'saved'}
      <div class="alert alert-success"> <strong>{$pharse.saved!}</strong>{if $stat_msg !=''} {$stat_msg} {else} {$users.first_name} {$pharse.profile_was_successfully_changed}{/if} </div>
      {elseif $error != ''}
      <div class="alert alert-danger"> <strong>{$error}</strong> </div>
      {/if}
    <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="admin_form" method="post" enctype="multipart/form-data" action="{$config.url}/admincp/users/save">
    <input type="hidden" value="{$users.id}" name="id" />
    <div class="form-group">
      <label>{$pharse.profile_pic}</label><br />

       <div class="pro_image"><img src="{if $users.avatar == ''} {$config['imgpath']}no_img.png {else if $users.avatar != ''}{$config['imgpath']}profile/{$users.avatar}{/if}" width="82" title="{$users.first_name}" height="83" alt="{$val.title}"></a> </div>
       <div class="fileUpload btn btn-primary redbg5"> <span>{$pharse.browse}</span>
    <input id="uploadBtn" type="file" class="upload" name="profile_image" {if(!($users.avatar))}  {/if}>
  </div>

      <!--input type="file" name="profile_image"-->
    </div>
    <div class="form-group">
      <label>{$pharse.first_name}</label>
      <input class="form-control" placeholder="Enter First Name" value="{$users.first_name}" name="first_name" data-parsley-group="block1" required>
    </div>
    <div class="form-group">
      <label>{$pharse.last_name}</label>
      <input class="form-control" placeholder="Enter Last Name" value="{$users.last_name}" name="last_name" data-parsley-group="block1" required>
    </div>
    <div class="form-group">
      <label for="inputEmail"  >{$pharse.phone_number:}</label>
      <input type="text" id="phone" name="phone" placeholder="Eg: 0123123456, +919874563210" class="form-control"  value="{if($users.phone)}{$users.phone} {/if}" title="Phone Number" maxlength="12" data-parsley-pattern="^[\d\+\-\.\(\)\/\s]*$" data-parsley-validation-threshold="0" data-parsley-trigger="keyup" data-parsley-pattern-message="Enter valid phone number">
    </div>
    <div class="form-group">
      <label>{$pharse.email}</label>
      <input class="form-control" name="email" type="email" value="{$users.email}" data-parsley-group="block1" required>
    </div>
    <div class="form-group">
      <label>{$pharse.password} <small>({$pharse.leave_empty_to_keep_same})</small></label>
      <input type="password" class="form-control" name="password" id="password" data-parsley-group="block1" >
    </div>
    <div class="form-group">
      <label>{$pharse.confirm_password}</label>
      <input type="password" class="form-control" name="cpassword" data-parsley-group="block1" >
    </div>

        <div class="form-group">
            <label>{$pharse.country:}</label>
            <select class="form-control" name="country" id="country" data-parsley-required-message="Please select country" data-parsley-message="Please select country">

            </select>
        </div>

        <div class="form-group">
            <label>{$pharse.state:}</label>
            <select id="state" name="state" class="form-control" data-parsley-required-message="Please select state"></select>

            </select>
        </div>

        <div class="form-group">
            <label>{$pharse.city:}</label>
            <input type="text" id="city" name="city" placeholder="Enter your city" class="form-control" value="{if($users.city)} {$users.city} {/if}" title="City" maxlength="50" data-parsley-required-message="Please enter city">

        </div>

        <input type="hidden" name="hidden_country" id="hidden_country" value="{$users.country}">
        <input type="hidden" name="hidden_state" id="hidden_state" value="{$users.state}">


    <div class="form-group">
      <label for="inputEmail">{$pharse.address_line_1:}</label>
      <input type="text" id="address_line1" name="address1" placeholder="Enter your address line1" class="form-control" value="{if($users.address1)} {$users.address1} {/if}" title="Address Line 1" maxlength="50">
    </div>
    <div class="form-group">
      <label for="inputEmail"  >{$pharse.address_line_2:}</label>
      <input type="text" id="address_line2" name="address2" placeholder="Enter your address line2" class="form-control"  value="{if($users.address2)} {$users.address2} {/if}" title="Address Line 2" maxlength="50">
    </div>


    <div class="form-group">
      <label for="inputEmail"  >{$pharse.zipcode:}</label>
      <input type="text" id="zipcode" name="zip" placeholder="Enter zipcode" class="form-control" value="{if($users.zip)} {$users.zip} {/if}" title="Zipcode" maxlength="10" >
    </div>

    <!--<div class="form-group addresscity">{if ($users.city)} {$users.city}{$users.state} {$users.country} {/if}</div>
    <input type="hidden" name="state" id="state" value="{$users.state}" />
    <input type="hidden" name="country" id="country" value="{$users.country}" />
    <input type="hidden" name="city" id="city" value="{$users.city}" />-->
    <div class="form-group">
      <label for="inputEmail"  >{$pharse.profile_url:}</label>
      <input class="form-control" placeholder="Enter Url" name="profile_url" value="{$users.profile_url}">
    </div>
    <div class="form-group">
      <label for="inputEmail"  >{$pharse.paypal_address:}</label>
      <input class="form-control" placeholder="Paypal E-mail" name="paypal_address" value="{$users.paypal_address}" >
    </div>
    <div class="form-group">
      <label>{$pharse.status}</label>
      <select class="form-control" name="status" data-parsley-group="block1" required>
        <option value="active" {if $users.status == 'active'} selected {/if}>{$pharse.active}</option>
        <option value="moderate" {if $users.status == 'moderate'} selected {/if}>{$pharse.moderate}</option>
        <option value="deactivate" {if $users.status == 'deactivate'} selected {/if}>{$pharse.deactivate}</option>
        <option value="unsubscribe" {if $users.status == 'unsubscribe'} selected {/if}>{$pharse.unsubscribe}</option>
        <option value="unverified" {if $users.status == 'unverified'} selected {/if}>{$pharse.unverified}</option>
      </select>
    </div>

     <div class="form-group">
      <label>{$pharse.about_me}</label>
      <textarea class="form-control" rows="3"  name="aboutme" data-parsley-group="block1">{$users.aboutme}</textarea>
    </div>
    <div class="form-group">
      <label for="inputEmail">{$pharse.select_categories_you_are_interested:}</label>
      </div>
    <div class="form-group">

      {foreach $category as $key => $val} <span class="col-sm-3 w-100">
      <input type="checkbox"  name="categories[]" value="{$val.id}" pid="{$val.parent_id}"  class="m-left-6"/>
      <span class="p-left-5">{$val.name} </span> </span> {/foreach}

      <div class="clear"></div>
      </div>

    <input  type="submit"  class="btn btn-success" value="submit">
    </div>

    </form>
  </div>

  <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}
<script language="javascript" type="text/javascript">
function checkStateCity(form,id)
    {
      console.log(id);
      console.log("http://maps.googleapis.com/maps/api/geocode/json?address="+$('#'+form+' #zipcode').val());
      var params = {};
      if (window.XDomainRequest) {
            if (window.XDomainRequest) {
                var xdr = new XDomainRequest();
                var query = "http://maps.googleapis.com/maps/api/geocode/json?address="+$('#'+form+' #zipcode').val();
                if (xdr) {
                    xdr.onload = function () {
                      console.log(JSON.parse(xdr.responseText));
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
      console.log(data);
      if(data['results'].length > 0)
          {
            var m = data['results'][0]['address_components'].length;

           $('#'+form+' #city').val(data['results'][0]['address_components'][m-3]['long_name']);
           $('#'+form+' #state').val(data['results'][0]['address_components'][m-2]['long_name']);
           $('#'+form+' #country').val(data['results'][0]['address_components'][m-1]['long_name']);
           $('#'+form+' .addresscity').html($('#city').val()+','+$('#state').val()+','+$('#country').val());
           if(id > 0)
           {
             $('#'+form).submit();
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
var initValues = {};
{if {$mcats} != ''}
var initValues = '{$mcats}'.split(',');
{/if}
//alert(initValues);
$(':checkbox[name^="categories"]').each(function () {

    //alert($.inArray($(this).val(), initValues));
                    $(this).prop("checked", ($.inArray($(this).val(), initValues) != -1));
                });

$(function()
{
   $('input[name="categories[]"]').each(function(){
    $(this).on('click',function(){
       var pid = $(this).attr('pid');
       var vid = $(this).attr('value');
       if(pid > 0)
       {
         if(!$(this).is(':checked'))
            {
             $('input[name="categories[]"][value="'+pid+'"]').attr('checked',false);
            }



       }
       else
       {
        if($(this).is(':checked'))
         {
          $('input[name="categories[]"][pid="'+vid+'"]').each(function()
          {
             $(this).attr('checked',false);
             $(this).click();
          });


         }
         else
         {
           $('input[name="categories[]"][pid="'+vid+'"]').each(function()
          {

             $(this).attr('checked',false);
           });
         }
       }
    });
  });
    var ctry = '{$users.country}';
  console.log(ctry);
  if(ctry !='')
  {

    $('#country').val(ctry);
    if($('#country option[value="{$users.country}"]').length > 0)
    {
    loadLocation('country',$('#country option[value="{$users.country}"]').attr('attr'),'{$users.state}','{$users.city}');
    }
    //loadLocation('state',$('#states option[value="{$users.state}"]').val(),'{$users.city}');
  }
//loadProfilePage();
    loadState();

});
</script>