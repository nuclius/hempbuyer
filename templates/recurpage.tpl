{include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid store-fluid post-item-fluid grey-bg p0">
    
    <div class="container white-bg shadow p35-15 m50">
    
    <div class="flex ">

        <div class="col-sm-12 item-col frpd  margin-auto grey-bg">
            
            <div class="col-md-4 col-sm-6 col-xs-6 w100-480">
            <ul class="p0">
                <li class="item">
                 <a   href="{$config.url}/product/view/{$recur_data.id}"><b>Product Name :</b> {$recur_data.title}</a>
                </li>
                 <li class="item">
                <b>Quantity Requested per Recurring :</b> {$recur_data.rp_qty} {$recur_data.short_unit}
                </li>
                 <li class="item">
                <b>Start Date :</b> {$recur_data.rp_sdate} 
                <br> <b>End Date :</b> {$recur_data.rp_edate}
                </li>
                 <li class="item">
                <b>Price :</b> {$recur_data.bprice} {$recur_data.short_unit}
                </li>
                </ul>            
            </div>
            
              <div class="col-md-4 col-sm-6 col-xs-6 w100-480">
            <ul class="p0">
                <li class="item">
            <b>Frequency :</b> {$recur_data.frequency}
                </li>
                 <li class="item">
           <b>Cancellation Insurance Status :</b> {if $recur_data.cancellation == 1}yes{/if}{if $recur_data.cancellation == 0}No{/if}
                </li>
                 <li class="item">
         <b>Recurring Status :</b> {$recur_paid}/{$recur_data.count}
                </li>
                 <li class="item">
           <b>Reserve Amount :</b> {$recur_data.reserve_price}
                </li>
                </ul>            
            </div>
            
            
           
            <!-- <br> Quantity Available : {$recur_data.qty} -->
            
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 padboth">
            <table class="table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Recurring Date</th>
                        <th>Amount/{$recur_data.unit}</th>
                        <th>Quantity</th>
                        <th>Total Amount</th>
                        <th>Payment Status(Paid/Unpaid)</th>
                        <!-- <th>Action</th> -->
                    </tr>
                </thead>
                <tbody>
                    {foreach $recur_schedules as $key => $val}
                    <tr>
                        <td>{$key+1}</td>
                        <td>{$val.recurring_at}</td>
                        <td>{$val.amount}</td>
                        <td>{$val.qty}</td>
                        <td>{$recur_data.rp_amount}</td>
                        <td>{$val.payment_status}</td>
<!--                         <td>
                            {if $val.payment_status == 'paid'}View Invoice{/if} {if $val.payment_status == 'unpaid'}Unpaid{/if}
                        </td> -->
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
     </div>
    
    </div>
    
</div>
<!--/ Page content -->
{include file="common/footer-1.tpl" nocache}
<script type="text/javascript">
$('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
$('#pagination').find('ul').removeClass('pagination');
</script>
</body>

</html>