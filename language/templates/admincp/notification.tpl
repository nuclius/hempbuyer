{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.notification_management} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
 
 <!-- <div class="col-md-12">
 <div class="col-md-4 col-sm-4">
 <div class="par3">Master email address</div>
 <div><input type="text" class="form-control" /></div>
 </div>
 <div class="col-md-4 col-sm-4"></div>
 <div class="col-md-3 col-sm-3">
 <div class="par3">Send test email?</div>
 <div><select class="form-control">
  <option>Select auction</option>
   <option >Yes</option>
  <option selected>No</option>
  
</select> </div>
 </div>
 </div>
  -->
 <!-- <div class="col-md-12 par2"><div class="col-md-12">Please whitelist the following email in your email application: support@auctionsoftware.com</div>
 </div>
 
<div class="col-md-12">
<div class="col-md-2 col-sm-2" style="padding-left:0;"><button class="btn btn-black" style=" font-size:14px;">Save</button></div> -->
 <div class="col-md-7 col-sm-7"></div>
  </div>
  
  <div class="col-md-12">
   <div class="col-md-12">
  <div class="col-md-12 search_tbar">
  <div class="col-md-7 sbar_lbl">
    {$pharse.notifications}
      </div>
      </div>
  <!--div class="col-md-1 sbar_lbl">
  Filter By
  </div>
  <div class="col-md-4">
    <select class="form-control" id="orderby">
      <option value="1">1 Weak</option>
      <option value="2">1 Month</option>
      
    </select>
  </div-->
  </div>
  <div class="col-md-12 par1">{$pharse.the_marketplace_sends_email_based_on_a_wide_variety_of_events_that_may_occur_as_seen_below._some_notifications_such_as_payment_information_will_be_sent_regardless_of_your_email_preference_setting}</div>
  
  
  <div class="col-md-12 table-responsive">
  <table class="table stab">
  <tr>
  <th>{$pharse.notification_title}</th>
  <th style="text-align:center">{$pharse.buyer}</th>
  <th style="text-align:center">{$Pharse.seller}</th>
  
  </tr>
{$fieldcount = 0}
{foreach $titles as $key => $val}   
{$fieldcount = 1}
  <tr>
  <td>
  <div class="stab2"><img src="http://auctionsoftwaremarketplace.com:2001/images/mailbox.jpg" class="img-responsive" alt="">{$val.notifications}</div>
  </td>
  <td align="center"><input type="checkbox" {if $val.buyer == 1}checked{/if} onclick="return false"/></td>
  <td align="center"><input type="checkbox" {if $val.seller == 1}checked{/if} onclick="return false"/></td>
  
  </tr>
  
  {/foreach}
            {if $fieldcount ==0}
             <tr>
                 <td colspan="5">
                   {$pharse.no_notification_titles_!!!}
                 </td>
             </tr>
         {/if}
  
  </table>
  
  

</div>
</div>
<div style="clear:both;"></div>
</div> 
   
   
 </div> 
</div> 

{include file="/admincp/footer.tpl" nocache} 


