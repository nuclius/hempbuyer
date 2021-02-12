{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->

                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">

                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="icon flaticon-flower-with-leaves"></i> {$pharse.escrow} <i class="fa fa-hand-o-right"></i> <i class="fa fa-search"></i> List
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">


                </div>

{if $success}
<div class="alert alert-success"> <strong>{$error}!</strong> </div>
{/if}
{if $failure}
<div class="alert alert-danger"> <strong>{$error}!</strong> </div>
{/if}
<form action="" method="post" id="pay_chk">
<div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>{$pharse.product_title}</th>
                                        <th>{$pharse.image}</th>
                                        <th>{$pharse.seller}</th>
                                        <th>{$pharse.buyer}</th>
                                        <th>{$pharse.qty}</th>
                                        <th>{$pharse.amount}</th>
                                        <th>{$pharse.status}</th>
                                        <th>{$pharse.commission}</th>
                                        <th>{$pharse.shipping_info}</th>
                                        <th>{$pharse.action}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {$paymentscount =0}
                                 {foreach $payments as $key => $val}
                                  {$paymentscount =1}
                                    <tr>
                                        <td><a href="{$config.url}/product/view/{$val.project_id}">{$val.title}</a></td>

                                        <td><a href="#" title="{$val.title}"> <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" width="50" height="50" alt="1"></a></td>
                                        <td>{$val.name}</td>
                                        <td>{$val.uname}</td>
                                        <td>{$val.qty}</td>
                                        <td>${$val.amt}</td>
                                        <td>{if $val.paid == 1} {if $val.release == 1} {$pharse.released} <br />date:{$val.r_date} <br />
                                          {/if} {if $val.release == 0} {$pharse.paid} <br />{$val.pay_date}{/if} {/if}{if $val.paid == 0} {$pharse.unpaid} {/if}</td>
                                          <td>${$val.commission}</td>
                                        <td>{$val.first_name} {$val.last_name},<br />
                                          {$val.address}<br />{$val.city}<br />{$val.state}</td>
                                        <td>
                                           {if $val.paypal_address==''}
                                              {$val.paypal_address='kprasadbe@gmail.com'}
                                           {/if}
                                            {if $val.paid == 1}
                                            Payable Amount:${$val.amt-$val.commission} <br />
                                          {if $val.admin == 0}<a href="{$config.url}/admincp/escrow/release/{$val.buynow_id}">{$pharse.mark_as_paid}</a> (paypal:{$val.paypal_address})<br /> <a href="{$config.url}/admincp/escrow/cancel/{$val.buynow_id}">{$pharse.cancel}</a>
                                          <br />
                                           <div style="display:inline">
                                              <input type="checkbox" name="payer[{$val.buynow_id}][id]" class="payer_id" value="{$val.buynow_id}" />
                                            <span id="exclude{$val.buynow_id}">
                                              <input type="hidden" name="payer[{$val.buynow_id}][paypal_address]" value="{$val.paypal_address}" disabled/>
                                              <input type="hidden" name="payer[{$val.buynow_id}][amount]" value="{$val.amt-$val.commission}" disabled/> {$pharse.select_to_pay}
                                            </span>
                                           </div>
                                          {/if}
                                          {if $val.admin == 1}{$pharse.released}{/if}
                                          {if $val.admin == 2}{$pharse.refunded}{/if}{/if}
                                            </td>
                                    </tr>
                                 {/foreach}
                                 {if $paymentscount == 0}
                                 <tr>
                                     <td colspan="10">
                                         {$pharse.no_records_found_!!!}
                                     </td>
                                 </tr>
                                 {/if}
                                </tbody>
                            </table>


                            {$pagination_html}
                        </div>
                        </form>
                        <input type="submit" class="btn btn-success" value="Do select Payment" onclick="doSelectedPayment(this)"  style="margin-bottom:2%; margin-top:2%;"/>


                <!-- /.row -->
</div>

 <p style="padding-bottom:2%;">{$pharse.to_create_new_preapproval_key}<a href="#" onclick="doApprovalProcess(this)">{$pharse.click_here}</a></p>


{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript">
    // Disale & enable textbox according to checkbox
    $('.payer_id').change(function() {
        console.log("Div is #exclude"+$(this).val());
       // var pdiv = ;
        if($(this).is(":checked")) {
            $('#exclude'+$(this).val() +' '+ ':input').prop('disabled',false);
        }else{
            $('#exclude'+$(this).val() + 'input').prop('disabled',true);
        }
    });

function doApprovalProcess(obj)
{

 if($(obj).html() != 'please wait....')
 {
   var params = { ADMIN_PAYPAL_EMAIL: '{$config.paypal.address}',ADAPTIVE_MODE: {if $config.paypal.sandbox == 'yes'}  'sandbox' {else} 'production' {/if},
               ADAPTIVE_USERNAME:'{$config.paypal.paypal_username}',ADAPTIVE_PASSWORD: '{$config.paypal.paypal_password}',ADAPTIVE_SIGNATURE: '{$config.paypal.paypal_signature}',ADAPTIVE_APP_ID: '{$config.paypal.paypal_api}',site: '{$config.common.url}',page: '/paypal/paypal_process.php?action=_key_response',rsite: '{$config.url}/admincp/escrow/',action : '_get_approval_key',vsite:'{$config.url}/paypal/pkey/',url:'{$config.common.url}',page: '/paypal/paypal_process.php' };
  //var params = [];
 // params['ADMIN_PAYPAL_EMAIL'] = 'prasad@ilancecustomization.com';
 console.log(params);
  $.ajax({
    type: "GET",
    dataType: 'json',
    url: "{$config.common.url}/paypal/paypal_process.php",
    data: params,
    success: function(data){
        console.log(data);
        $(obj).html('click here.');
        if(data.success)
        {
            {if $config.paypal.sandbox == 'yes'}
            window.location = 'https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-preapproval&preapprovalkey='+data.key;
            {else}
            window.location = 'https://www.paypal.com/cgi-bin/webscr?cmd=_ap-preapproval&preapprovalkey='+data.key;
            {/if}
            console.log(data.key);
        }
        else
        {
           alert(data.message);
        }
     }
    });
  }
}

function doSelectedPayment(obj)
{

 if($(obj).val() != 'please wait....')
 {
   var params = { ADMIN_PAYPAL_EMAIL: '{$config.paypal.address}',ADAPTIVE_MODE: {if $config.paypal.sandbox == 'yes'}  'sandbox' {else} 'production' {/if},
               ADAPTIVE_USERNAME:'{$config.paypal.paypal_username}',ADAPTIVE_PASSWORD: '{$config.paypal.paypal_password}',ADAPTIVE_SIGNATURE: '{$config.paypal.paypal_signature}',ADAPTIVE_APP_ID: '{$config.paypal.paypal_api}',site: '{$config.common.url}',page: '/paypal/paypal_process.php?action=_key_response',rsite: '{$config.url}/admincp/escrow/',action : '_do_payment',vsite:'{$config.url}/paypal/pay/',url:'{$config.common.url}',page: '/paypal/paypal_process.php',p_key:'{$config.paypal.preapproval_key}' };
  //var params = [];
 // params['ADMIN_PAYPAL_EMAIL'] = 'prasad@ilancecustomization.com';
 var datas =      $('#pay_chk').serialize()+'&'+$.param(params)
 console.log(datas);
  $.ajax({
    type: "GET",
    dataType: 'json',
    url: "{$config.common.url}/paypal/paypal_process.php",
    data:datas,
    success: function(data){
        $(obj).val('Do select Payment');
        console.log(data);
        console.log('https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-preapproval&preapprovalkey='+data.key);
        //return false;
        if(data.success)
        {
             window.location.reload();
            console.log(data.key);
        }
        else
        {
            alert(data.message);
        }
     }
    });
  }
}
</script>
