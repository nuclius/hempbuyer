{include file="common/header-1.tpl" nocache}
<div class="main_container">
  <div class="row dashboard">
    <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
    <div class="col-md-9">
      <h4 class="ds_brd">{$pharse.withdrawals}</h4>
       {if $message != ''}
         <div class="row">
            <div class="bg {if $action == 'error'}bg-danger{else}bg-success{/if} padding-20  m-top-40"> <i class="fa fa-warning"></i> {$message}. </div>
          </div>
       {/if}
      <div class="row">
       <div class="col-md-6"><b>{$pharse.available_balance_to_withdraw:}</b>${$userbalance.ledger}
         </div>
      </div> 
      <div class="row">
       <div class="col-md-6"> 
       <form name="" data-parsley-validate action="{$config.url}/dashboard/withdrawal" method="post">
       <div class="form-group">
         <label>{$pharse.amount_to_withdraw}</label>
         <input type="text" name="amount" value="" placeholder="0.00" required class="form-control floatpoint">

       </div>
      
       <div class="form-group">
         <label>{$pharse.payment_mode}</label>
         <select name="paymethod" required  class="form-control">
                   <option value="Paypal">{$pharse.paypal}</option>
                   <option value="ACH">{$pharse.ach}</option>
                   <option value="Cheque">{$pharse.cheque}</option>
         </select>
         
       </div>
       <div class="form-group">
         <label>{$pharse.payment_details}(paypal address/ACH details/Bank Details</label>
         <textarea required name="paydetails"  class="form-control"></textarea>
         
       </div>
       <button type="submit" class="btn btn-success">"{$pharse.confirm_withdraw}"</button>
      </form>
    </div>
      </div> 


      <div class="row mblue_box">
        <div class="col-md-2">{$pharse.amount}</div>
        <div class="col-md-4">{$phares.date_requested}</div>
        <div class="col-md-2">{$pharse.paid}</div>
        <div class="col-md-4">{$pharse.pay_method}</div>
        <!--<div class="col-md-3"> Amount </div>-->
      </div>
      {if $withdraw|count <=  0}
      <div class="row mblue_box1" style="text-align:center;"> {$pharse.no_withdraw_found }</div>
      {else}
      {foreach $withdraw as $key => $val}
      <div class="row mblue_box1">
        <div class="col-md-2">$ {$val.amount}</div>
        <div class="col-md-4">{$val.date_added}</div>
        <div class="col-md-2">{if $val.paid} {$pharse.paid} {elseif !$val.paid} {$pharse.unpaid} {/if}</div>
        <div class="col-md-4">{$val.method} {$val.details}</div>
        <!--<div class="col-md-3">{$val.proposed_amount}</div>-->
        
      </div>
      {/foreach}
      {/if} 
  </div>
</div>
</div>
{include file="common/footer-1.tpl" nocache} 