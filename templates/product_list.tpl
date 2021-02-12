{if $countProducts <= 0}
<input id="finish_prod" type="hidden" value='0' name="finish_prod"/>
<h3 class="text-center">No Records Found...!</h3>
<script type="text/javascript">
    $('.filecount').filestyle({
    input: false,
    buttonName: '',
    iconName: 'fa fa-upload',
    buttonText: 'Upload Test Results '
});
$(function() {
    $('span.stars').stars();
});
</script>
{/if}
{if $countProducts > 0}
{foreach $products as $key => $val}
    {if $val.trading_type == "sell"}
    <div id="prod_{$val.id}" class="row open-bid-row border1"> 
         <div class="row">
                        <div class="col-md-12">
                        <div id="submit_form{$val.id}" data-parsley-validate>
                            <input type="hidden" name="id" value="{$val.id}"/>
                            <div class="flex" style="padding: 4px 0px">
                              {if $val.available == true}
                                  <span class="orange-available"> <b>Available Now</b></span>
                              {/if}
                              {if $val.available == false}
                                  <span class="light-orange"> <b>Future {$val.future_date}</b></span>
                              {/if}
                                <div class="col-md-2 col-sm-2 col-xs-12 margin-auto res-mtb">
                                    <div class="orange w100 text-center"><b class="buy-text">BUY</b></div>
                                    <div class="thumb">
                                        <div class="hover-div orange-bg hidden-xs">
                                            <div class="row flex">
                                                <div class="col-md-4 margin-auto"> 
                                                    {if $val.avatar == ''}
                                                     <img src="{$config.url}/images/no_img.png" class="img-responsive margin-auto" width="200px" height="150px" alt="No image">
                                                    {/if}
                                                    {if $val.avatar != ''}
                                                     <img src="{$config.imgpath}product/{$val.avatar}" class="img-responsive margin-auto" width="200px" height="150px" alt="{$val.image}">
                                                    {/if}
                                                </div>
                                                <div class="col-md-8 content margin-auto">
                                                    <div class="row">
                                                        <div class="order-type white m10">
                                                            <span>Order Type :</span>

                                                            {if $val.order_type == 'total'}
                                                                Total Orders Only
                                                            {/if}
                                                            {if $val.order_type == 'partial'}
                                                                Partial Orders Allowed
                                                            {/if}
                                                        </div>
                                                        <div class="time white m10">
                                                            <span>Date Available :</span> {$val.start_date}
                                                        </div>
                                                        <div class="view-result white">
                                                            {if $val.cannabis_type == 'y' && $val.test_result_types != 'none'}
                                                            <span>View Test Results </span> <a class="white" href="{$config.imgpath}testresult/{$val.test_result}" onclick="window.open(this.href); return false;"><i class="fa fa-list-alt" aria-hidden="true"></i></a>
                                                            {/if}
                                                            {if $val.cannabis_type == 'n' || $val.test_result_types == 'none'}
                                                            <span>Test results not available </span>
                                                            {/if}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        {if $val.avatar == ''}
                                            <img class="block margin-auto p0" height="50px" src="{$config.url}/images/no_img.png" class="img-responsiveSS" alt="No image">
                                        {/if}
                                        {if $val.avatar != ''}
                                            <img class="block margin-auto p0" height="50px" src="{$config.imgpath}product/{$val.avatar}" class="img-responsiveSS" alt="{$val.image}">
                                        {/if}
                                    </div>
                                </div> 
                                <div class="col-md-5 col-sm-4 col-xs-12 margin-auto w100-480">
                                    <div class="open-bid-item"><span class="green-text">Product Name:</span> {$val.title}</div>
                                    <div class="open-bid-item"><span class="green-text">Available Quantity :</span> <span id="prod_qty"> {$val.rfilled_qty}</span> {$val.short_unit}</div>
                                    <div class="open-bid-item">
                                       <input class="" id="qty" data-parsley-type="number"
                                        {if $val.order_type == "total"} type="hidden" value="{$val.qty}" {elseif $val.order_type == "partial"} type="text" {/if} placeholder="Requested Quantity"
                                        name="qty"
                                        {if $val.order_type == "total"} data-parsley-equals="{$val.qty}"
                                        data-parsley-equals-message="Please enter total quantity" {elseif $val.order_type == "partial"}
                                        data-parsley-min="1"
                                        data-parsley-min-message="Please enter minimum quantity 1"
                                        data-parsley-max="{$val.rfilled_qty}"
                                        data-parsley-max-message="Please enter less than remaining"
                                        {/if}
                                        data-parsley-required data-parsley-required-message="please enter the quantity" required style="width: 50%;"
                                        >
                                        </input>
                                    </div>

                                </div>
                                <div class="col-md-4 col-sm-4 col-xs-12 margin-auto"> 
                                    <div class="open-bid-item"><span class="green-text">Seller Rating:</span>
                                       <span class="stars">{$val.srating}</span> 
                                    </div>
                                    <div class="open-bid-item"><span class="green-text">Target Price :</span> ${$val.sprice} / {$val.short_unit}

                                    </div>
                                    <div class="open-bid-item">
                                         <input class="" id="offer_price" type="text" placeholder="Price Offer" name="offer_price" data-parsley-type="number" data-parsley-min-message="Offer price should be greater than 0" data-parsley-min = "1" data-parsley-required-message="please enter offer price." data-parsley-required required style="width: 50%;"></input>
                                    </div>
                                </div>
                                
                                {if $loged.roleid == 2 || $loged.roleid == 3 || $loged.roleid == 0}
                                <div class="col-md-2 col-sm-4 col-xs-12 margin-auto"> 
                                    <div class="open-bid-item"><span class="green-text">Upload Proof:</span>
                                        <br><br>
                                        <span id="proof_name"></span>
                                    </div>
                                    <div class="open-bid-item"></div>
                                    <div class="open-bid-item">
                                            <!-- <input class="" id="offer_price" type="text" placeholder="Price Offer" name="offer_price" data-parsley-type="number" data-parsley-min-message="Offer price should be greater than 0" data-parsley-min = "1" data-parsley-required-message="please enter offer price." data-parsley-required required style="width: 50%;"></input> -->
                                            <div class="bootstrap-filestyle input-group" style="margin-bottom: -40px;"><span class="group-span-filestyle " tabindex="0"><label for="filecount5" class="btn btn btn-default btn-d-b btn-d-g m5 w100 "><span class="icon-span-filestyle "></span> <span class="buttonText">UPLOAD</span></label></span></div>

                                            <input type="file" data-parsley-trigger="change" ids="{$val.id}" id="purchase_proof" name="purchase_proof" class="purchase_proof" data-parsley-required-message="Please Upload Purchanse Proof" data-parsley-required required style="opacity: 0;" accept="image/png, image/jpeg, image/jpg">
                                    </div>
                                    
                                </div>
                                {/if}
                                <div class="col-md-2 col-sm-2 col-xs-12 margin-auto">
                                    {if $logged_user == $val.user_id}
                                        <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" data-toggle="tooltip" data-placement="top" title="Can't bid on product that you owned..!" disabled="true">SUBMIT</button>
                                    {/if}
                                    {if $logged_user != $val.user_id}
                                    <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="placeBid('{$val.id}')">SUBMIT</button>
                                    {/if}
                                    <div class="mt-15">
                                      <a class="green-text ftn13 m5" href="{$config.url}/product/view/{$val.id}"><b>More Details</b></a>
                                    </div>

                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
    </div>
    {/if}
    {if $val.trading_type == "buy"}
    <div id="prod_{$val.id}" class="row open-bid-row border1"> 
                    <div class="row">
                        <div class="col-md-12">
                        <!-- <form id="submit_form{$val.id}" data-parsley-validate > -->
                        <div id="submit_form{$val.id}" data-parsley-validate>
                           <input type="hidden" name="id" value="{$val.id}"/>
                            <div class="flex" style="padding: 4px 0px;">
                              {if $val.available == true}
                                  <span class="primary-blue"> <b>Available Now</b></span>
                              {/if}
                              {if $val.available == false}
                                  <span class="sky-blue"> <b>Future {$val.future_date}</b></span>
                              {/if}

                                <div class="col-md-2 col-sm-2 col-xs-12 margin-auto res-mtb">
                                    <div class="blue w100 text-center"><b class="buy-text">SELL</b></div>
                                    <div class="thumb blue-border">
                                        <div class="hover-div blue-bg hidden-xs">
                                            <div class="row flex">
                                                <div class="col-md-4">
                                                    {if $val.avatar == ''}
                                                     <img src="{$config.url}/images/no_img.png" class="img-responsive margin-auto" width="200px" height="150px" alt="No images">
                                                    {/if}
                                                    {if $val.avatar != ''}
                                                     <img src="{$config.imgpath}product/{$val.avatar}" class="img-responsive margin-auto" width="200px" height="150px" alt="{$val.image}">
                                                    {/if}
                                                </div>
                                                <div class="col-md-8 content margin-auto">
                                                    <div class="row">
                                                        <div class="order-type white m10">
                                                            <span>Order Type :</span>
                                                            {if $val.order_type == 'total'}
                                                                Total Orders Only
                                                            {/if}
                                                            {if $val.order_type == 'partial'}
                                                                Partial Orders Allowed
                                                            {/if}
                                                        </div>
                                                        <div class="time white m10">
                                                            <span>Date Requested :</span> {$val.start_date}
                                                        </div>
                                                        <div class="view-result white">

                                                            <span>
                                                             {if $logged_user != $val.user_id}
                                                             <input type="file" class="filecount" name="test_results"/>
                                                             {/if}
                                                            </span>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        {if $val.avatar == ''}
                                        <img class="block margin-auto p0" height="50px" src="{$config.url}/images/no_img.png" class="img-responsiveSS" alt="No image">
                                        {/if}
                                        {if $val.avatar != ''}
                                        <img class="block margin-auto p0" height="50px" src="{$config.imgpath}product/{$val.avatar}" class="img-responsiveSS" alt="{$val.image}">
                                        {/if}
                                    </div>
                                </div>
 
                                <div class="col-md-5 col-sm-4 col-xs-12 margin-auto">
                                    <div class="open-bid-item"><span class="green-text">Product Name:</span> {$val.title} </div>
                                    <div class="open-bid-item"><span class="green-text">Quantity Requested:</span><span id="prod_qty"> {$val.rfilled_qty} </span> {$val.short_unit} </div>
                                    <div class="open-bid-item">
                                     <input class="" id="qty" data-parsley-type="number"
                                        {if $val.order_type == "total"} type="hidden" value="{$val.qty}" {elseif $val.order_type == "partial"} type="text" {/if} placeholder="Requested Quantity"
                                        name="qty"
                                        {if $val.order_type == "total"} data-parsley-equals="{$val.qty}"
                                        data-parsley-equals-message="Please enter total quantity" {elseif $val.order_type == "partial"}
                                        data-parsley-min="1"
                                        data-parsley-min-message="Please enter minimum quantity 1"
                                        data-parsley-max="{$val.rfilled_qty}"
                                        data-parsley-max-message="Please enter less than remaining"
                                        {/if}
                                        data-parsley-required data-parsley-required="please enter the quantity" required style="width: 50%;"
                                        >
                                        </input>
                                     
                                    </div>

                                </div>
                                <div class="col-md-4 col-sm-4 col-xs-12 margin-auto">
 
                                    <div class="open-bid-item"><span class="green-text">Buyer Rating:</span>
                                         <span class="stars">{$val.brating}</span>
                                    </div>
                                    <div class="open-bid-item"><span class="green-text">Target Price :</span> ${$val.sprice} / {$val.short_unit}
 
                                    </div>
                                    <div class="open-bid-item">
                                         <input class="" id="offer_price" type="text" placeholder="Price Offer" name="offer_price" data-parsley-type="number" data-parsley-min-message="Offer price should be greater than 0" data-parsley-min = "1" data-parsley-required-message="please enter offer price." data-parsley-required required style="width: 50%;"></input>
                                    </div>
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-12 margin-auto">
                                    {if $logged_user == $val.user_id}
                                        <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" data-toggle="tooltip" data-placement="top" title="Can't bid on product that you owned..!" disabled="true">SUBMIT</button>
                                    {/if}
                                    {if $logged_user != $val.user_id}
                                    <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="placeBid('{$val.id}')">SUBMIT</button>
                                    {/if}
                                    <div class="mt-15">
                                      <a class="green-text ftn13 m5" href="{$config.url}/product/view/{$val.id}"><b>More Details</b></a>
                                    </div>

                                </div>
                            </div>
                          </div>
                        </div>
                    </div> 
    </div>
    {/if}
{/foreach}
<script type="text/javascript">
    $('.filecount').filestyle({
    input: false,
    buttonName: '',
    iconName: 'fa fa-upload',
    buttonText: 'Upload Test Results '
});
$(function() {
    $('span.stars').stars();
});

$('.purchase_proof').change(function(e){
            var fileName = e.target.files[0].name;
            var id = $(this).attr('ids');
          $('#submit_form'+id).find('#proof_name').html(fileName);
            
        });
// $(function() {
//     $('span.stars').stars();
// });
/* Star rating completed */
</script>
{/if}


