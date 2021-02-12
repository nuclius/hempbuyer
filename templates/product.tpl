 {include file="common/header-1.tpl" nocache}

 <style type="text/css">

    tbody{
      overflow-y: scroll;
      height: 100px;
    }

 </style>

<!-- Page content -->
<div class="container-fluid bgBannerFluid">
    <h1>Open Bid Market</h1>
        {include file="common/common_navigation.tpl" nocache}
</div>
<div class="container-fluid">
    <div class="container m35 p35-15">
            {if $loged.userid == $projects.user_id}
                <div class="alert alert-success">
                    You cannot see your own post in Open Bid Market. You can see post in the Open Bid Market <a href="{$config.url}/dashboard/myrequests"> "My Posted Bids" </a>
                </div>
            {/if}
        <ol class="breadcrumb">
            <li><a class="grey-text" href="{$config.url}/openbid/market">Open Bid Market</a></li>
            <li><a href="{$config.url}/product/view/{$projects.id}">{$projects.title}</a></li>
            <!-- http://localhost:3026/product/view/589 -->
        </ol>
        <div class="row">
            <div class="col-md-4 col-sm-6 col-xs-12 margin-auto">
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
            <div class="col-md-8 col-sm-6 col-xs-12 margin-auto">
                <div class="row">
                    <div class="col-md-6">
                        <ul class="p0 res-mt">
                            <!-- ===================== start change by divyesh (changes) ===================== --> 
                            {if $projects.trading_type == 'sell'}
                                <li class="p5"><b>Target Price : </b> ${$projects.sprice}/{$projects.short_unit}</li>
                                <li class="p5"><b>Available Quantity : </b> {$projects.qty}{$projects.unit}</li>
                                <li class="p5"><b>Sales tax : </b> {$projects.stax} %</li>
                                <li class="p5"><b>Sales Consultant Fee : </b> {$projects.consultant_fee} %</li>
                                
                                <!-- <li class="p5"><b>Unit price : </b> ${$projects.unit_price}/{$projects.short_unit}</li> -->
                                {foreach $category as $key => $val} {if $projects.category_id == $val.id} {foreach $category as $key => $v} {if $val.parent_id == $v.id}
                                <li class="p5"><b>Category : </b> {$v.name}</li>
                                <li class="p5"><b>Sub Category : </b> {$val.name}</li>
                                {/if} {/foreach} {/if} {/foreach}
                                <li class="p5"><b>Date Requested : </b> {$projects.date_add}</li>
                            {/if}

                            {if $projects.trading_type == 'buy'}
                                <!-- <li class="p5"><b>Target Price : </b> ${$projects.sprice}</li> -->
                                <li class="p5"><b>Target Price : </b> ${$projects.sprice}/{$projects.short_unit}</li>
                                <li class="p5"><b>Quantity Requested : </b> {$projects.qty} {$projects.unit}</li>
                                <li class="p5"><b>Sales Consultant Fee : </b> {$projects.consultant_fee} %</li>
                                <!-- <li class="p5"><b>Unit price : </b> ${$projects.unit_price}/{$projects.short_unit}</li> -->

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

                            {/if}
                            <!-- ===================== end change by divyesh (changes) ===================== -->
                            <li class="p5"><b>Bidders : </b><span id="bidders">{$projects.bidders}</span></li>
                                {if $projects.order_type == 'total'}
                                <li class="p5"><b>Order Type : </b> Total Orders Only</li>
                                {/if} {if $projects.order_type == 'partial'}
                                <li class="p5"><b>Order Type : </b> Partial Orders Only</li>
                                {/if}
                            <li class="p5">
                                <b>Description :</b>
                                <p class="description mt-5 grey-text p5">{$projects.description}</p>
                            </li>
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
                            {if $loged.userid == $projects.user_id && $projects.bidders <= 0}

                               <a id="edit-product-btn" href="{$config.url}/dashboard/openbid/product/edit/{$projects.id}" class="btn btn-success">EDIT</a>
                               <a id="edit-product-btn" href="{$config.url}/dashboard/openbid/product/delete/{$projects.id}" class="btn btn-success">DELETE</a>

                            {/if}
                    </div>
                </div>

            </div>



        </div>

    </div>
</div>

<!--/ Page content -->
{include file="common/footer-1.tpl" nocache}

<script type="text/javascript">

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
//On scroll call the draw function
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

  socket.on('requestAccepted', function (data) {

   //console.log(data);

    $('#request_status_'+data.req_id).text("Accepted");
    if(data.rfilled_qty > 0){
        $('#qty').attr('data-parsley-max', data.rfilled_qty);
        $('#rfilled_qty').text(data.rfilled_qty);
    } else if(data.rfilled_qty <= 0){
        $('#product_status').html('<h3>Closed</h3>');
    }
    // $('#submit_form').find('input').data('id').
    ////console.log(data);

    // socket.emit('my other event', { my: 'data' });
  });

  socket.on('requestRejected', function (data) {
    $('#request_status_'+data.req_id).text("Rejected");
    ////console.log(data);

    // socket.emit('my other event', { my: 'data' });
  });



  socket.on('bidPlaced', function (data) {
    if(data.bidPlaced == 1){
        $('#edit-product-btn').remove();
        $('#bidders').text('1');
    }

  });

  // #edit-product-btn

</script>
</body>

</html>
