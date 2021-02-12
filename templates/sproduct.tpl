 {include file="common/header-1.tpl" nocache}

 <style type="text/css">

    tbody{
      overflow-y: scroll;
      height: 100px;
    }

 </style>

<!-- Page content -->
<div class="container-fluid bgBannerFluid">
    <h1>Direct Buy Market</h1>
        {include file="common/common_navigation.tpl" nocache}
</div>
<div class="container-fluid">
    <div class="container m35 p35-15">
        <ol class="breadcrumb">
            <li><a class="grey-text" href="{$config.url}/stores/view/{$store_idpdt}">Store View</a></li>
            <li><a href="{$config.url}/product/sview/{$projects.id}">{$projects.title}</a></li>

            <!-- http://localhost:3026/product/view/589 -->
        </ol>
        <a class="btn btn-success  green-b  pull-right" href="{$config.url}/stores/view/{$store_idpdt}"><i class="fa fa-arrow-left"></i> Back</a>
        <div class="row">
            <div class="col-md-4 margin-auto">
                <h4 class="green-text text-center m0 p15 white green-bg" style="text-transform: capitalize;">{$projects.title}</h4>
                <div id="carousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        {foreach $images as $key => $val}
                        <div class="item {if $key == 0} active{/if}">
                            <div class="product-thumb-large">
                              <img src='{$config.imgpath}product/{$val.avatar}' alt='{$val.image}' />
                            </div>
                        </div>
                        {/foreach}
                    </div>
                </div>
                <div class="clearfix">
                    <div id="thumbcarousel" class="carousel slide" data-interval="false">
                        <div class="carousel-inner">
                            {if $images.length <= 1}
                                <div class="item active">
                                    {foreach $images as $key => $val}
                                            <div class="item active">
                                            </div>
                                    {/foreach}
                                </div>
                            {/if}
                            {if $images.length > 1}
                                <div class="item active">
                                    {foreach $images as $key => $val}
                                        {if $key == 0}
                                            <div class="item active">
                                        {/if}
                                        {if $key%4 == 0}
                                            </div>
                                            <div class="item">
                                        {/if}
                                                <div data-target="#carousel" data-slide-to="{$key}" class="thumb">
                                                    <div class="product-thumb-small">
                                                      <img src='{$config.imgpath}product/{$val.avatar}' alt='{$val.image}' />
                                                    </div>
                                                </div>
                                        {if $key == $image_length}
                                            </div>
                                        {/if}
                                    <!-- <img src='{$config.imgpath}product/{$val.avatar}' alt='{$val.image}' /> -->
                                    {/foreach}
                                </div>
                            {/if}
                            <!-- /item -->
                        </div>
                        <!-- /carousel-inner -->
                        {if $images.length > 4}
                            <a class="left carousel-control" href="#thumbcarousel" role="button" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                            <a class="right carousel-control" href="#thumbcarousel" role="button" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
                        {/if}
                    </div>
                    <!-- /thumbcarousel -->
                </div>
                <!-- /clearfix -->
            </div>
            <div class="col-md-8 margin-auto">
                <div class="row">
                    <div class="col-md-6">
                        <ul class="p0">
                            {if $projects.trading_type == 'sell'}

                                <li class="p5"><b>Quantity Requested : </b> {$projects.qty}{$projects.unit}</li>
                                <li class="p5"><b>Unit price : </b> ${$projects.unit_price}/{$projects.short_unit}</li>
                                {foreach $category as $key => $val} {if $projects.category_id == $val.id} {foreach $category as $key => $v} {if $val.parent_id == $v.id}
                                <li class="p5"><b>Category : </b> {$v.name}</li>
                                <li class="p5"><b>Sub Category : </b> {$val.name}</li>
                                {/if} {/foreach} {/if} {/foreach}
                                <li class="p5"><b>Date Requested : </b> {$projects.date_add}</li>
                            {/if}

                            {if $projects.trading_type == 'buy'}
                               <!--  <li class="p5"><b>Target Price : </b> ${$projects.sprice}</li> -->
                                <li class="p5"><b>Brand SKU: </b> {$projects.pkey}</li>
                                <li class="p5"><b>Total Quantity : </b> {$projects.qty} {$projects.unit}</li>
                                <li class="p5"><b>Unit Price : </b> ${$projects.unit_price}/{$projects.short_unit}</li>

                                {foreach $category as $key => $val}
                                    {if $projects.category_id == $val.id}
                                        {foreach $category as $key => $v}
                                            {if $val.parent_id == $v.id}
                                            <li class="p5"><b>Category : </b> {$v.name}</li>
                                            <li class="p5"><b>Sub Category : </b> {$val.name}</li>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                {/foreach}

                                <li class="p5"><b>Date Available : </b> {$projects.date_add}</li>
                                <li class="p5"><b>Sales Tax : </b> {$projects.stax}%</li>
                                <li class="p5"><b>Sales Consultant Fee : </b> {$projects.consultant_fee}%</li>
                                <li class="p5">
                                    <b>Description :</b>
                                    <p class="description mt-5 grey-text p5">{$projects.description}</p>
                                </li>
                            {/if}
                            <!-- <li class="p5"><b>Bidders : </b> {$projects.bidders}</li> -->
                               <!--  {if $projects.order_type == 'total'}
                                <li class="p5"><b>Order Type : </b> Total Orders Only</li>
                                {/if} {if $projects.order_type == 'partial'}
                                <li class="p5"><b>Order Type : </b> Partial Orders Only</li>
                                {/if} -->
                        </ul>
                        <div class="m10 m-t-0 p5">
                            {if $projects.cannabis_type == 'y'}
                                {if $projects.test_result != ''}
                                    <b>View Test Result :</b> 
                                    <span>
                                        <a href="{$config.imgpath}testresult/{$projects.test_result}" onclick="window.open(this.href); return false;"> {$projects.test_result_img} <i class="fa fa-list icon"></i> </a>
                                        <!-- <a href="#" download>File.pdf <i class="fa fa-download icon"></i> </a> -->
                                    </span>
                                {/if}
                                {if $testresults_length >0}
                                    <b>All Test Results :</b> <br>
                                    <span>
                                        {foreach $testresults as $key => $val}
                                        <span class="eximage_{$val.id}">
                                            <a onclick="deleteImage('{$projects.id}', '{$val.id}')"> <i class="fa fa-trash icon" title="Delete image"></i></a> | 
                                            <a href="{$config.imgpath}testresult/{$val.avatar}" onclick="window.open(this.href); return false;"> {$projects.test_result_img} <i class="fa fa-list icon"></i> {$val.image}</a>
                                            <br>
                                        </span>
                                        {/foreach}
                                    </span>
                                {/if}
                            {/if}
                        </div>
                        <div class="m10 m-t-0 p5">
                            {if $projects.cert_analysis == 'y'}
                                {if $certs_analysis_length >0}
                                    <b>All certificate analysis :</b> <br>
                                    <span>
                                        {foreach $certs_analysis as $key => $val}
                                        <span class="eximage_{$val.id}">
                                            <a onclick="deleteImage('{$projects.id}', '{$val.id}')"> <i class="fa fa-trash icon" title="Delete image"></i></a> | 
                                            <a href="{$config.imgpath}certificates/{$val.avatar}" onclick="window.open(this.href); return false;"> {$projects.test_result_img} <i class="fa fa-list icon"></i> {$val.image}</a>
                                             <br>
                                        </span>
                                        {/foreach}
                                    </span>
                                {/if}
                            {/if}
                        </div>
                        <!-- <b class="p5">Description :</b>
                        <p class="description mt-5 grey-text p5">{$projects.description}</p> -->
                    </div>
                {if $projects.auction == 1}
                    <div class="col-md-6">

                    <div class="req-status-table">

                    {if $prod_requests.length > 0}

                      <table class="table table-bordered">
                      <thead>
                      <tr class="green-text text-center m0 p15 white green-bg">
                      <th>Amount $</th><th>Qty({$projects.short_unit})</th><th>Status</th><th>Date</th>
                      <!-- <th>Updated Date</th> -->
                      </tr>
                      </thead>
                      <tbody>
                      {foreach $prod_requests as $key => $val}
                        <tr>
                        <td>${$val.amount}</td>
                        <td>{$val.qty}</td>
                        <td>
                            {if $val.accepted}
                                Accepted
                            {/if}
                            {if $val.rejected}
                                Rejected
                            {/if}
                            {if !$val.accepted && !$val.rejected}
                                Pending
                            {/if}
                        </td>
                        <td>
                        {$val.req_date}
                        </td>
                        <!-- <td>
                            {if $val.accepted == 1}
                                {$val.acc_date}
                            {/if}
                            {if $val.rejected == 1}
                                {$val.rej_date}
                            {/if}
                            {if ((!$val.accepted) && (!$val.rejected))}
                            NA
                            {/if}
                        </td> -->
                        </tr>
                        {/foreach}
                        </tbody>
                      </table>

                      {/if}
                      </div>


                      <div>
                                                              {if $projects.rfilled_qty > 0}

                             {if $loged.userid != $projects.user_id}
                             <form id="submit_form"  data-parsley-validate method="post" action="{$config.url}/product/request/save">

                                <input type="hidden" name="id" value="{$projects.id}"/>

                                        <!-- <input class="" id="qty"  data-parsley-type="number"
                                        type="text" placeholder="Quantity Requested"
                                        name="qty"
                                        {if $projects.order_type == "total"} data-parsley-equals="{$projects.qty}"
                                        data-parsley-equals-message="Please enter total quantity"
                                        {elseif $projects.order_type == "partial"}
                                        data-parsley-min="1"
                                        data-parsley-min-message="Please enter total quantity {$projects.rfilled_qty} or less"
                                        data-parsley-max="{$projects.rfilled_qty}"
                                        data-parsley-max-message="Please enter total quantity {$projects.rfilled_qty} or less"
                                        {/if}
                                        data-parsley-required data-parsley-required="please enter the quantity" required /> -->

                                            {if $projects.order_type == "partial"}
                                             <input class="w100 p15 pb15 grey-bg border-0" id="qty" data-parsley-type="number"
                                            type="text" placeholder="Requested Quantity"
                                            name="qty"
                                            data-parsley-min="1"
                                            data-parsley-min-message="Please enter less than remaining or {$projects.rfilled_qty}"
                                            data-parsley-max="{$projects.rfilled_qty}"
                                            data-parsley-max-message="Please enter less than remaining or {$projects.rfilled_qty}"
                                            data-parsley-required data-parsley-required="please enter the quantity" style="width: 50%;"
                                            >
                                            </input>
                                            {/if}

                                            {if $projects.order_type == "total"}
                                            <input class="w100 p15 pb15 grey-bg border-0 mt-15" id="qty" data-parsley-type="number"
                                            type="text" placeholder="Requested Quantity"
                                            name="qty"
                                            data-parsley-min="{$projects.rfilled_qty}"
                                            data-parsley-min-message="Please enter total quantity"
                                            data-parsley-max="{$projects.rfilled_qty}"
                                            data-parsley-max-message="Please enter total quantity"
                                            data-parsley-equals="{$projects.rfilled_qty}"
                                            data-parsley-equals-message="Please enter total quantity"
                                            data-parsley-required data-parsley-required="please enter the quantity" style="width: 50%;"
                                            >
                                            </input>
                                            {/if}


                                <input class="w100 p15 pb15 grey-bg border-0 mt-15" id="offer_price" type="text" placeholder="Price Offer"
                                         name="offer_price" data-parsley-type="number" data-parsley-min-message="Offer price should be greater than 0" data-parsley-min = "1" data-parsley-required-message="please enter offer price." data-parsley-required/>

                                         {if $error != ''}
                                             <div class="err-message">
                                             {$error}
                                             </div>
                                         {/if}

                                <button class="btn btn btn-default btn-d-b btn-d-g white pull-right" style="" onclick="submitform()">SUBMIT</button>
                             </form>
                             {/if}
                                                                     {/if}
                             </div>
                             {/if}
                            {if $loged.userid == $projects.user_id}
                               <!--  <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="editProduct(this, {$val.id})">EDIT</button>   -->
                                {if $projects.sold ==0 && $projects.booked ==0}
                               <a href="{$config.url}/dashboard/product/edit/{$projects.id}" class="btn btn-success  green-b">EDIT</a>
                               <a href="{$config.url}/dashboard/product/delete/{$projects.id}" class="btn btn-success  green-b">DELETE</a>

                                 {/if}
                            {/if}
                    </div>
                </div>
                <!-- <hr> -->
                <!-- <button class="btn btn-default btn-d-b green-b customized m0" type="submit">BID</button> -->
            </div>

                        
        </div>
            </div>
                        
                    </div>
    </div>
</div>

<!-- <div class="modal fade" id="successModal1" role="dialog">
<div class="modal-dialog margin-auto">

  <div class="modal-content margin-auto">
    <div class="modal-header p0">

      <div class="panel panel-success border-0 m-b-0">
        <div class="panel-heading green-bg">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h3>{$error}</h3>
        </div>
      </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default btn-d black-g m0" data-dismiss="modal">Close</button>
    </div>
  </div>
</div>
</div> -->

<!--/ Page content -->
{include file="common/footer-1.tpl" nocache}

<!-- {if $error != ''}
<script type="text/javascript">
    $(document).ready(function(){
        $("#successModal1").modal();
    });

</script>
{/if}
 -->
<script type="text/javascript">
//On scroll call the draw function

/* To delete the images */
    function deleteImage(pid,id){
        $.ajax({
            type : "get",
            url : "/product/delete/images/"+pid+"/"+id,
            data : {  },
            success : function(data) {
                console.log(data)
                if(data == 1){
                    $('.eximage_'+id).hide();
                }
            }

        });

    }

$(window).scroll(function() {
    drawLines();
});

//If you have more than one SVG per page this will pick it up
function drawLines() {
    $.each($("path"), function(i, val) {
        var line = val;
        drawLine($(this), line);
    });
}

//draw the line
function drawLine(container, line) {
    var length = 1;
    var pathLength = line.getTotalLength();
    var distanceFromTop = container.offset().top - $(window).scrollTop();
    var percentDone = 1 - (distanceFromTop / $(window).height());
    length = percentDone * pathLength;
    line.style.strokeDasharray = [length, pathLength].join(' ');
   //console.log("strokeDasharray: " + [length, pathLength].join(' '));
}


function submitform(){
    // event.preventDefault();
   //console.log("submit form");
        if($("#submit_form").parsley().validate()){
            $("#submit_form").submit();
        }
}

</script>
</body>

</html>
