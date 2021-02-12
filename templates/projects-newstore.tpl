
                        {if $proj|count ==  0}
    <div class="col-sm-12" style="text-align: center;"><h2>No Products Found!!</h2></div>
    {/if}
                        {foreach $proj as $key => $val}
                        {if $val.units == 'pounds'}
                        {assign var="shortunit" value='lbs'}
                        {elseif $val.units == 'ounces'}
                        {assign var="shortunit" value='oz'}
                        {elseif $val.units == 'grams'}
                        {assign var="shortunit" value='gm'}
                        {elseif $val.units == 'units'}
                        {assign var="shortunit" value='Unit'}
                        {/if}
                        {if $key%4 == 0}<div class="row items-row">{/if}
                        <div class="col-md-3 item-col shadow res-item-col" id="{$val.id}">
                        <input type="hidden" name="storeids" class="storeids" value="{$val.storeid}">
                         <input type="hidden" name="pdtc" class="pdtc" value="{$val.qty}">
                                <ul>
                                    <li class="price-offer">
                                        <!-- <strike>$200</strike> (50%) -->
                                        <span class="price">${$val.unit_price}/{$shortunit}</span>
                                    </li>
                                    {if $val.user_id == $loged.userid && ($val.p_bidcount < 1 && $val.sold < 1)}
                                    <span class="fa fa-trash icon f12 right {$val.id}" id="{$val.id}"></span>
                                    {/if}
                                    <!-- <li class="favourate">
                                        <i class="fa fa-heart-o" aria-hidden="true"></i>
                                    </li> -->
                                </ul>
                                <div class="item-thumb">
                                    <img src="{if $val.avatar == ''}{$config.url}/images/no_img.png    {elseif $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" class="margin-auto" alt="">
                                </div>
                                <ul class="item-details mb-0">
                                    <li class="ptitle">{$val.title}</li>
                                    <li>Brand SKU: <i><b>{$val.pkey}</b></i></li>
                                    <li>Qty Available:<span id="qty{$val.id}"> {$val.qty - ($val.sold + $val.booked)}</span></li>
                                    <li class="text-center"><a href="{$config.url}/product/sview/{$val.id}"><i>More Details</i></a></li>
                                    <!-- <li><a href="#"><i>Review</i></a></li> -->
                                </ul>
                                <p class="description"><i></i></p>
                                <div class="reccuring-purchase">
                                    <!-- <a href="#"><img src="images/reccuring.png" alt="reccuring"><span>Make this a recurring purchase?</span></a> -->
                                </div>
                                <div class="btn-wrapper">
                                {if $val.buynow == 1 && ($loged.business_settings.open_bid == 1 || $loged.roleid==0)}
                                    <button class="btn btn-default btn-d black-g buy_nego_btn" data-record-pdt="{$val.id}" data-record-pdtc="{$val.qty - ($val.sold + $val.booked)}" type="button" name="button" data-toggle="modal" data-target="#myModal" data-user-id="{$val.user_id}" {if $loged.userid == $val.user_id}disabled {/if} {if  ($val.qty - ($val.sold + $val.booked))<=0}disabled {/if}>BUY NOW <span class="icon flaticon-shopping-cart"></span></button>
                                {/if}    
                                {if $val.buynow == 0}
                                   <button class="btn btn-default btn-d black-g {$val.id} buy_nego_btn" id="{$val.id}" data-record-userid="{$loged.userid}" data-record-price="{$val.sprice}" data-record-pdtc="{$val.qty}" data-record-pdt="{$val.id}" type="button" name="button" data-toggle="modal" data-target="#negotiable" data-user-id="{$val.user_id}" {if $val.bidcount > 0} disabled {/if}{if $loged.userid == $val.user_id}disabled {/if} >negotiable <img src="/images/negotiable.png" class="img-responsive"  alt="negotiable"></button>
                                {/if}
                                </div>
                            </div>
                        {if $key%4 == 3}</div>{/if}

                        {/foreach}
                         {if $key%4 < 3}</div>{/if}


                        </div>
<script type="text/javascript">

    $(document).ready(function () {
var sid =$('.storeids').val();
        $('.srchtxt').click(function(){
     var search =$('#srchtxt').val();
        $.ajax({
      type : 'POST',
       dataType : 'json',
      url : '/searchstorepdts',
      data : 'ajax=1&search='+search+'&id='+sid,
      success : function(data) {
        $('.ajaxappend').html(data.html);
        //changeSubCategory

      }
    });
  });

   $('.right').click(function(){
     var pid =this.id;
     var confirm1 = confirm('Are you sure to Remove?');
     if (confirm1) {
        $.ajax({
      type : 'POST',
       dataType : 'json',
      url : '/deletestorepdts',
      data : 'pid='+pid,
      success : function(data) {
     $('#'+pid).hide();
         //window.location.reload();

      }
    });
    }
    else{
        return false;
    }
  });

    });
</script>
