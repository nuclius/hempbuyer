{include file="/common/header-1.tpl" nocache}
{include file="common/dashboard-navigation.tpl" nocache}
    <div class="container-fluid grey-bg p0">
        
        <div class="container m50">
         {$total = 0}
          {$i = 0}
          <form action="{$config.url}/product/checkout/update" method="post" id="form_cart" data-parsley-validate>
          {foreach $loged.products as $key => $val}
          {$t = $val.qty_add*$val.bprice)}
         {$t = parseFloat($t)}
          <div class="row white-bg shadow p35 div{$val.id}">
            <div class="col-md-3">
              <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="img-responsive border1" alt="">
              <button class="btn btn-default btn-d-b black-b margin-auto block m10 m-b-0 w100 border-radius-0" type="button" onclick="removecartitemjay('{$val.id}');">DELETE</button>
            </div>
            <div class="col-md-9">
              <h3 class="caption green-text m0">{$val.title} <!-- <span class="grey-text f14">- <b>By Christopher Nolan</b></span> --></h3>
                                  {if $val.rec_purchase == 1}
                    <h4 class="black"><b><span class="red">Recurring Purchase</span></b></h4>
                    {/if}
              <!-- <b class="green-text">In Stock</b>
              <span class="slash">/</span><b>Sold By: <span>Christopher Nolan</span></b>
              <span class="slash">/</span><b>FREE Delivery</b> -->
              <div class="m20">

                <div class="row flex">
                  <div class="col-md-6 margin-auto">
                  {if $val.rec_purchase == 1}
                    <h4 class="black"><b>Frequency: <span class="red">{$val.rec_frequency}</span></b></h4>
                    <h4 class="black"><b>Total Transactions: <span class="red">{$val.rec_count}</span></b></h4>
                    <h4 class="black"><b>Cancellation Insurance: <span class="red">
                    {if $val.rec_cancel_ins == 1}Yes{/if}
                    {if $val.rec_cancel_ins != 1}No{/if}</span></b></h4>
                    {/if}
                    <h4 class="black"><b>Product price: <span class="red">$</span><span class="red format">{$val.bprice} {$val.units} </span></b></h4>
                    <h4 class="black"><b>HerbeeFee: <span class="red">$</span><span class="red format">{$herfee * $val.qty_add}</span></b></h4>
                    <h4 class="black"><b>SalesTax: <span class="red">$</span><span class="red format">{$tax * $val.qty_add}</span></b></h4>
                  </div>

                  <div class="col-md-3 margin-auto">
                    <input placeholder="Quantity" class="w100 p15 pb15 grey-bg border-0 cart_quantity add_qty{$val.id}" data-parsley-group="block1" name="pid[{$val.id}]" value="{$val.qty_add}" data-choosen="{$val.qty_add}" data-parsley-min="1" data-parsley-max={$val.qty-$val.sold-$val.booked+$val.qty_add} required disabled=""></input>
                    <input type="hidden" name="confhidurl" class="confhidurl" value="{$config.url}" disabled>
                  </div>
                  <div class="col-md-3">

                  </div>
                </div>

                <p class="description grey-text lh-22 m5">
                  {$val.description}
                </p>

              </div>

            </div>

          </div>
          {$total=sumFloat($total,($val.qty_add * $val.bprice)))}
           {/foreach}
           </form>
           <form action="{$config.url}/product/checkout/confirm/" method="post" id="form_confirm" data-parsley-validate>
             <input type="hidden" name="hidamt" value="{$allam}">

           </form>
          <div class="row">
            <div class="green-bg col-md-12 p20-15 flex">
              <div class="col-md-6 margin-auto">
                <h3 class="white m0">Sub Total : <span class="white"> $<span class="total_amt1 format">{$allam}</span> (<span class="total_c">{$key + 1}</span> Items) </span></h3>
              </div>
              <div class="col-md-6 margin-auto">

                <div class="row">
                  <div class="col-md-6">
                    <button class="btn btn-default btn-d-b black-b m0 border-radius-0 f14 w100" type="button" onclick="window.location = '{$config.url}/directbuy'">Continue Shopping</button>
                  </div>
                  <div class="col-md-6">
                    <button id="checkout" class="btn btn-default btn-d-b black-b m0 border-radius-0 f14 w100" type="button">Proceed to Checkout</button>
                  </div>
                </div>

              </div>
            </div>
          </div>

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
function removecartitemjay(id)
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
      url  : '/product/removecart/'+id,
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
