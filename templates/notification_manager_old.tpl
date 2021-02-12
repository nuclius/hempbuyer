<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->

{include file="/common/header-1.tpl" nocache}
<style>
.table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td{
      border-top: none;
}

</style>
{literal}

<script type="text/javascript">

$(document).ready(function(){
    
    var addemids = $("input.bemail:checked").map(function(){
        return this.value;
    }).toArray();

    var addsmids = $("input.bsms:checked").map(function(){
        return this.value;
    }).toArray();
    $('#email_settings').val(addemids);
    $('#sms_settings').val(addsmids);

  $(".settings").click(function(){
    
    var addemids = $("input.bemail:checked").map(function(){
        return this.value;
    }).toArray();
    
    $('#email_settings').val(addemids);

    var addsmids = $("input.bsms:checked").map(function(){
        return this.value;
    }).toArray();
    
     $('#sms_settings').val(addsmids);

                       
  })
  $("#verifybtn").click(function(){
   
    var ph_no = $('#mobile-number').val();
    ph_no = ph_no.replace('+','');
    var request = $.ajax({
      url: "/verifyno?p="+ph_no,
      type: "GET",
    });
    request.done(function(msg) {
      $(".verification").html(msg);
      if(msg == 'Phone number is already verified.'){ $(".textdesc").html(''); }
      $("#verifyinfo").modal('show');

    });
    
  });
  $('#notified').click(function(){
    alert("Your Settings Are Saved");
    return true;

  });
  
});
</script>
{/literal}

<div class="container">

<div class="row">
<div class="col-sm-3 col-xs-12 txtfun3 padlef0 mobile_view">
<div class="daashbrd_cngpswd" style="padding-top:10px;"><a href="/dashboard/my" class="clrr">Dashboard</a> &gt;&gt; {$phrase.notification}</div>

 {include file="left-profile-nav.tpl" nocache} </div>

<div class="col-md-9 ionoti3">

{if $verified neq 1}
<div class="ionoti1 row">
<div class="col-md-3 ionoti7">{$phrase.sms_notification}</div>
<div class="form-group col-md-5"><input type="text" class="form-control" id="mobile-number" {if $user_phones} value="{$user_phones}" {/if}  placeholder="Phone no">
<span id="valid-msg" style="color:#075A0B;" class="hide"> {$phrase.valid}</span>
<span id="error-msg" style="color:#F00;" class="hide">{$phrase.invalid_number}</span></div>
<div class="col-md-2"><button id="verifybtn" type="button" class="btn btn-default">{$phrase.verify}</button></div>
</div>
{/if}

<div class="col-md-12 ionoti2">{$phrase.the_marketplace_sends_email_based_on_a_wide_variety_of_events_that_may_occur_as_seen_below}</div>

<!-- <div class="col-md-12 ionoti2">
  <div>Show specific user type</div>
  <div>
  <label class="radio-inline">
  <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" checked="checked"> All Type
</label>
<label class="radio-inline">
  <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> Buyer
</label>
<label class="radio-inline">
  <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3"> Seller
</label>
</div>
  </div> -->

<div class="col-md-12 table-responsive iome6 ionoti5 buyer">

<table class="table stab">
    <thead>
      <tr class="ionoti4" >
        <th class="iome9 ionoti9">{$phrase.notification_to_buyer}:</th>
        <th class="text-center iome9 ionoti0">{$phrase.email}</th>
        <th  class="text-center iome9 ionoti0">{$phrase.sms}</th>
        <th  class="text-center iome9">&nbsp;</th>
        <th  class="text-center iome9">&nbsp;</th>
        <th  class="text-center iome9">&nbsp;</th>
       
      </tr>
    </thead>
    <tbody>
    {$fieldcount = 0}
    {foreach $buyer_titles as $key => $val}   
    {$fieldcount = 1}
      <tr>
        
        <td class="iome7 ionoti9"> {$val.notifications}   </td>
        <td class="iome7 ionoti0" align="center">
          <input class="bemail settings"  value="{$val.id}" type="checkbox" 
          <input class="bsms settings" value="{$val.id}" type="checkbox"
            {foreach $email_items as $keys => $valids}
              {if $val.id == $valids}
                checked=true
              {/if}
            {/foreach} >
        </td>
        <td class="iome7 ionoti0" value="{$val.id}" align="center">
          <input class="bsms settings" value="{$val.id}" type="checkbox"
            {foreach $sms_items as $keys => $valids}
              {if $val.id == $valids}
                checked=true
              {/if}
              {if $verified neq 1}
              disabled
              {/if}
            {/foreach} >
        </td>
        <td class="iome7" align="center">&nbsp;</td>
        <td class="iome7" align="center">&nbsp;</td>
        <td class="iome7" align="center">&nbsp;</td>
        
      </tr>
      {/foreach}
            {if $fieldcount ==0}
      <tr>
           <td colspan="5">
             {$phrase.no_notification_titles} !!!
           </td>
      </tr>
      {/if}
        
    </tbody>
  </table></div>
  
  
  <div class="col-md-12 table-responsive iome6 ionoti5">
<table class="table stab">
    <thead>
      <tr class="ionoti4" >
        <th class="iome9 ionoti9" >{$phrase.notification_to_seller}:</th>
        <th class="text-center iome9 ionoti0">{$phrase.email}</th>
        <th  class="text-center iome9 ionoti0">{$phrase.sms}</th>
        <th  class="text-center iome9">&nbsp;</th>
        <th  class="text-center iome9">&nbsp;</th>
        <th  class="text-center iome9">&nbsp;</th>
       
      </tr>
    </thead>
    <tbody>
    {$fieldcount = 0}
    {foreach $seller_titles as $key => $val} 
    {$fieldcount = 1}
      <tr>
      
        <td class="iome7 ionoti9"> {$val.notifications}   </td>
        <td class="iome7 ionoti0" align="center">
          <input class="bemail settings"  value="{$val.id}" type="checkbox"  
          {foreach $email_items as $keys => $valids}
            {if $val.id == $valids}
              checked=true
            {/if}
          {/foreach} >
        </td>
        <td class="iome7 ionoti0" align="center">
          <input class="bsms settings"  value="{$val.id}" type="checkbox" 
            {foreach $sms_items as $keys => $valids}
            {if $val.id == $valids}
              checked=true
            {/if}
             {if $verified neq 1}
              disabled
              {/if}
          {/foreach} >
        </td>
        <td class="iome7" align="center">&nbsp;</td>
        <td class="iome7" align="center">&nbsp;</td>
        <td class="iome7" align="center">&nbsp;</td>
        
      </tr>
      {/foreach}
            {if $fieldcount ==0}
      <tr>
           <td colspan="5">
             {$phrase.no_notification_titles} !!!
           </td>
      </tr>
      {/if}
        
    </tbody>
  </table></div>
  
  <div class="col-md-12 ionoti6">
  <form action="{$config.url}/dashboard/save_notification" method="post">
    <input type="hidden" name="notify_id" id="notify_id" value="{$notify_id}">

    <input type="hidden" name="email_settings" id="email_settings">
    <input type="hidden" name="sms_settings" id="sms_settings">

    <button type="submit" id="notified" class="btn btn-danger">{$phrase.save}</button>
    <button type="button" class="btn btn-default">{$phrase.cancel}</button>
</form>
  
  
  
  </div>
  
  

</div>

</div>


</div>
{$disable_zip_popup = 1}
{include file="/common/footer-1.tpl" nocache} 

