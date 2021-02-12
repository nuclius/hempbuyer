{include file="/common/header-1.tpl" nocache}
{include file="common/dashboard-navigation.tpl" nocache}
<style>
.p-0 {
  padding: 0px !important;
}
</style>
    <div class="container-fluid grey-bg p0">

        <div class="container m50">
          {if $empty_msg}
          <div align="center"><h3 class="green-text">{$empty_msg}</h3></div>
          {else}
          <div><h3 class="green-text">Please respond to checkout within 24 hours or your order will be released</h3></div>
          <form action="{$config.url}/product/checkout/update" method="post" id="form_cart" data-parsley-validate>
          {$t = 0}
          {foreach $loged.products as $key => $val}
        
          {$ProductPrice = parseFloat($val.qty_add * $val.bprice)}
          {$herbeeFee = parseFloat($val.qty_add * $val.prdt_herbee_fee)}
          {$ProductStax = parseFloat($val.qty_add * $val.prdt_stax)}

          {if $val.distribution_tax > $config.general.distribution_default_rate}
            {$val.distribution_tax = $config.general.distribution_default_rate}
          {/if}

          {$consultant_fee_amount = $val.consultant_fee_amount * $val.qty_add}
          {$t = parseFloat($t) + parseFloat($ProductPrice) + parseFloat($herbeeFee) + parseFloat($ProductStax) + parseFloat($val.excise_tax) + parseFloat($consultant_fee_amount)}

          {$payable_amount = parseFloat($payable_amount) + parseFloat($val.prdt_total_amount)}

          <div class="row white-bg shadow p35 div{$val.id}">
            <div class="col-md-3 padboth">
              <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="img-responsive border1 margin-auto" alt="">
              <button class="btn btn-default btn-d-b black-b margin-auto block m10 m-b-0 w100 border-radius-0" type="button" onclick="removecartitemjay('{$val.id}','{$val.rec_purchase_id}');">DELETE</button>
            </div>
            <div class="col-md-9 padboth">
              <h3 class="caption green-text m0">{$val.title} <!-- <span class="grey-text f14">- <b>By Christopher Nolan</b></span> --></h3>
                                  {if $val.rec_purchase == 1}
                    <h4 class="green-text text-right m0"><i class="">Recurring Purchase</i></h4>
                    {/if}
              <!-- <b class="green-text">In Stock</b>
              <span class="slash">/</span><b>Sold By: <span>Christopher Nolan</span></b>
              <span class="slash">/</span><b>FREE Delivery</b> -->
              <div class="m20">
                <div class="row">
                  <div class="col-md-6 margin-auto">
                    
                    <input type="hidden" placeholder="Quantity" class="p15 pb15 grey-bg border-0 cart_quantity add_qty{$val.id}" data-parsley-group="block1" name="pid[{$val.id}]" value="{$val.qty_add}" data-choosen="{$val.qty_add}" data-parsley-min="1" data-parsley-max={$val.qty-$val.sold-$val.booked+$val.qty_add} required disabled="">

                    <h5 class="black mb-25"><b>Quantity: </b><span class="format">{$val.qty_add}</span>
                      <span>{$val.short_unit}</span></h5>
                    <input type="hidden" name="confhidurl" class="confhidurl" value="{$config.url}" disabled>
                    <!--</div> <div class="col-md-6 margin-auto unit-inpt"> -->
                    <h5 class="black mb-25"><b>Product Price: </b> <span class="">$</span><span class=" format">{$ProductPrice}</span>(<span class="">$</span><span>{$val.bprice}</span>/<span>{$val.short_unit}</span>)</h5>
                    <!-- <h4 class="black"><b>Product price: <span class="red">$</span><span class="red format">{$val.bprice} {$val.units} </span></b></h4> -->
                    <h5 class="black mb-25"><b>Herbee Fee:</b> <span class="">$</span><span class=" format">{$herbeeFee}</span></h5>
                    <!-- <h4 class="black"><b>HerbeeFee: <span class="red">$</span><span class="red format">{$val.prdt_herbee_fee}</span></b></h4> -->
                    <!-- <h5 class="black mb-25"><b>Sales Tax: </b> <span class="">$</span><span class=" format">{$ProductStax}</span></h5> -->
                    <!-- <h5 class="black mb-25"><b>Sales Consultant Fee: </b> <span class="">$</span><span class=" format">{$consultant_fee_amount}</span><span>({$val.consultant_fee}%)</span></h5> -->


                    <h5 class="black mb-25"><b>Excise Tax: </b> <span class="">$</span><span class=" format">{$val.excise_tax}</span></h5>
                   <!--  <h5 class="black mb-25"><b>Cultivation Tax (If flower or trim): </b> <span class="">$</span><span class=" format">{$val.cultivation_tax}</span></h5>
                    <h5 class="black mb-25"><b>Distribution Tax: </b> <span class="">$</span><span class=" format">{$val.distribution_tax}</span></h5>
                    <h5 class="black mb-25"><b>Distribution tax and cultivation tax will be deducted from seller account after confirmation of sell</b></h5> -->
                    <!-- <h4 class="black"><b>SalesTax: <span class="red">$</span><span class="red format">{$val.prdt_stax}</span></b></h4> -->
                    <h5 class="black mb-25"><b>Total Amount: </b> <span class="">$</span><span class="format">{$val.prdt_total_amount}</span></h5>
                  </div>
 
<!--              {$config.general.distribution_rate} -----
                  {$config.general.distribution_default_rate} -----
                  {$config.general.distribution_rate_status} -----
                  {$config.general.cultivation_tax} -----
                  {$config.general.cultivation_tax_status} -----
                  {$config.general.trim_tax} -----
                  {$config.general.trim_tax_status} -----
                  {$config.general.excise_tax} -----
                  {$config.general.excise_tax_markup} -----
                  {$config.general.excise_tax_status} ----- 
                -->

                  <div class="col-md-6 margin-auto">
                    {if $val.rec_purchase == 1}
                    <h5 class="black mb-25"><b>Frequency: </b> <span class=""> {$val.rec_frequency}</span></h5>
                    <h5 class="black mb-25"><b>Total Transactions: </b> <span class=""> {$val.rec_count}</span></h5>
                    <h5 class="black mb-25"><b>Cancellation Insurance: </b> <span class="">
                    {if $val.rec_cancel_ins == 1}Yes{/if}
                    {if $val.rec_cancel_ins != 1}No{/if}</span></h5>
                    <!-- <h5 class="black mb-25"><b>Reserve price: </b> <span class="">$</span><span class="format">{$val.rec_reserve_price}</span></h5> -->
                    {/if}
                  </div>
                  <div class="col-md-12">
                    <h5 class="black"><b>Description:</b> </h5>
                    <p class="description">{$val.description}</p>
                  </div>
                </div>
              </div>

            </div>

          </div>
            <!--  {$total=sumFloat($total,$val.qty_add)*sumFloat($val.bprice,$val.shipping_price)} -->
           {/foreach}
           </form>
           <form action="{$config.url}/product/checkout/confirm/" method="post" id="form_confirm" data-parsley-validate>
             <input type="hidden" name="hidamt" value="{$payable_amount}">
             <input type="checkbox" name="cod" class="cod" id="cod" value="1" style="display:none;">
           </form>
          <div class="row">
            <div class="green-bg col-md-12 p20-15 flex">
              <div class="col-md-4 margin-auto">
                <h3 class="white m0">Sub Total : <span class="white"> $<span class="total_amt1 format">

                {$payable_amount}
                </span> (<span class="total_c">{$key + 1}</span> Items) </span></h3>
              </div>
              <div class="col-md-2 margin-auto">
                <div class="row">
                  <div class="checkbox">
                    <label class="p-0">
                        <input type="checkbox" name="cod_temp" id="cod_temp" class="cod_temp" value="1">
                        <span class="cr" style="background: #ffffff;"><i class="cr-icon fa fa-check"></i></span>
                        Pay cash on delivery
                    </label>
                  </div>
                </div>
              </div>
              <div class="col-md-6 margin-auto">

                <div class="row">
                  <div class="col-md-6 padboth">
                    <!-- <button class="btn btn-default btn-d-b black-b m0 border-radius-0 f14 w100" type="button" onclick="window.location = '{$config.url}/directbuy'">Continue Shopping</button> -->
                    <a class="btn btn-default btn-d-b black-b m0 border-radius-0 f14 w100" href="{$config.url}/stores/view/{$loged.products[$key].store_id}">Continue Shopping</a>
                  </div>
                  <div class="col-md-6 padboth">
                    <button id="checkout" class="btn btn-default btn-d-b black-b m0 border-radius-0 f14 w100" type="button">Proceed to Checkout</button>
                  </div>
                </div>

              </div>
            </div>
          </div>
{/if}
        </div>

    </div>

{include file="/common/footer-1.tpl" nocache}
<style type="text/css">


  .btn-default
  {color: #fff !important;
  }
</style>
<script type="text/javascript">


numberformat();

    $('input[type=text]').on('change',function(){
        $('#form_cart').submit();
    });

    $( "#checkout" ).click(function() {
      console.log('checkout');
     var url = $('.confhidurl').val();

     //console.log("ss");
        var update_cart = 0;
        $('.cart_quantity').each(function(){
         //console.log("jj");
          var current_val = $(this).val();
          var old_val = $(this).data('choosen');
          if(current_val != old_val){
            update_cart = 1;
          }

        });
        if(update_cart > 0){
          alert('Please Update the cart');
          return false;
        }
        if(false === $('#form_cart').parsley().validate('block1'))
        {
            return false;
        }
        else {
          $('#cod').prop('checked', $('#cod_temp').prop('checked'));
           $('#form_confirm').submit();

           // window.location = url+'/product/checkout/confirm/';
        }

    });


    $('.add').click(function(){
        var current_val = $('.add_qty'+$(this).val()).val();
        var add_val = parseFloat(current_val) + 1;
           //console.log("Value isssss "+$(this).val());
        $('.add_qty'+$(this).val()).val(add_val);
    });

    $('.sub').click(function(){
        var current_val = $('.add_qty'+$(this).val()).val();
        var sub_val = parseFloat(current_val) - 1;
        if(sub_val > 0) {
            $('.add_qty'+$(this).val()).val(sub_val);
        }
    })
function removecartitemjay(id,recid)
{

  if (confirm("Are you sure you want to remove it?") == true) {
    
  //console.log(parseInt($('#qty_add').val()));
  //console.log($('addcart').find('span').html().indexOf("Add"));
  if(parseInt(id) <= 0 || id == '')
  {
        alert('Invalid Listing');
        return false;
  }
  $.ajax({
    type : 'GET',
      url  : '/product/removecart/'+id+'?recuringid='+recid,
      data : {},
      dataType : 'json',
      success  : function(data)
      {
        //console.log(data);

             if(data.success)
             {
                 window.location = '/product/checkout/cart/'
             }
             else
             {
                 window.location = '/login';
             }
      }
  });
  }
}

</script>
