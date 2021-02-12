{include file="common/header-1.tpl" nocache}
<!-- page content  -->
<div class="container-fluid bgBannerFluid">
    <h1>Open Bid Market</h1>
    {include file="common/common_navigation.tpl" nocache}
</div>
<script>
var loadmore = 0;
</script>
<!-- Loader -->
<div class="clearfix store-view-fluid">
    <div class="container store-view-con">
        <div class="page-caption m50">
            {foreach $categories as $key => $val}
                {if $val.id == $cat}
                    <h1>{$val.name}</h1>
                {/if}
            {/foreach}
        </div>
        <!-- / store-details-row -->
        <a class="nmobile-blayer1 filter-icon"></a>
        <div class="row store-content-row p35-15">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-3 sidebar obm-smenu mb-25">
                        <ul class="sidebar-menu">
                            <li>
                                <a class="maincat">
                                    <span class="catcap"><b>CATEGORIES</b></span></i>
                                </a>
                            </li>
                            <li>
                                <div class="maincat">
                                    <i class="icon flaticon-research-work"></i>
                                    <a href="{$config.url}/openbid/market/all"><span>All</span></a>
                                    <!-- <i class="fa fa-angle-left pull-right"></i> -->
                                </div>
                            </li>
                            <li>
                                {foreach $categories as $key => $val}

                                    {if $val.parent_id == 0 && $val.ob_market==1}

                                        {if $val.name == 'Flower'}
                                        <a class="maincat" href="#">
                                            <i class="icon flaticon-flower-with-leaves"></i>
                                            <span>Flower</span><i class="fa fa-angle-left pull-right"></i>
                                        </a>
                                        {elseif $val.name == 'Dry Concentrates'}
                                        <a class="maincat" href="#">
                                            <i class="icon flaticon-medicine-bottle"></i>
                                            <span>Dry Concentrates</span>
                                            <i class="fa fa-angle-left pull-right"></i>
                                        </a>
                                        {elseif $val.name == 'Oil Concentrates'}
                                        <a class="maincat" href="#">
                                            <i class="icon flaticon-oil-drum"></i>
                                            <span>Oil Concentrates</span>
                                            <i class="fa fa-angle-left pull-right"></i>
                                        </a>
                                        {elseif $val.name == 'Topicals'}
                                        <a class="maincat" href="#">
                                            <img src="{$config.url}/images/topicals.png" class="img-responsive" alt="">
                                            <span>Topicals</span>
                                            <i class="fa fa-angle-left pull-right"></i>
                                        </a>
                                    {elseif $val.name != 'Flower' && $val.name != 'Dry Concentrates' && $val.name != 'Oil Concentrates' && $val.name != 'Topicals'}
                                        <a class="maincat" href="#">
                                            <img src="{$config.url}/images/topicals.png" class="img-responsive" alt="">
                                            <span>{$val.name}</span>
                                            <i class="fa fa-angle-left pull-right"></i>
                                        </a>

                                        {/if}
                                    {/if}
                                <ul class="sidebar-submenu" style="display: none;">
                                    {foreach $categories as $key => $v}
                                        {if $v.parent_id == $val.id && $v.ob_market==1}
                                        <li>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <i class="fa fa-angle-double-right" aria-hidden="true"></i>
                                                    <a href="{$config.url}/openbid/market/{$v.id}/{$type}/{$sort_type}"> {$v.name} </a>
                                                </div>
                                            </div>
                                        </li>
                                        {/if}
                                    {/foreach}
                                </ul>
                                {/foreach}
                            </li>
                            <li>
                                <a class="maincat">
                                    <span class="catcap"><b>DATE AVAILABLE</b></span></i>
                                </a>
                            </li>
                        </ul> 
                        <ul class="sidebar-submenu2 p0">
                            <li>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" value="y" id="availablenow" name="availablenow">
                                                <span class="cr"><i class="cr-icon fa fa-check"></i></span> Available Now
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" value="y" id="futurebid" name="futurebid">
                                                <span class="cr"><i class="cr-icon fa fa-check"></i></span> Future Bid
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div id="loader">

                      <img src="{$config.url}/images/ripplez.gif" class="img-responsive" alt="ripplez.gif">

                    </div>
                    <div id="loadData" class="col-md-9 right-content" style="text-align : left">
                        <div class="row top-bar-row">
                            <div class="col-md-12 main-col border-0 black-b flex" style="margin-bottom: 0px;">
                                <div class="row">
                                <div class="col-xs-8 col-md-8">

                                    <select id="sort_types" class="p15 border-0 sort-2 black-b" name="sort_types" onchange="location = '{$config.url}/openbid/market/{$cat}/'+this.value">
                                        <option value="recent" {if $type =='recent'} selected {/if} >Most Recently Posted</option>
                                        <option value="availabledate" {if $type =='availabledate'} selected {/if}>Available date</option>
                                        <option value="buyoffers" {if $type =='buyoffers'} selected {/if}>Buy offers</option>
                                        <option value="selloffers" {if $type =='selloffers'} selected {/if}>Sell offers</option>
                                    </select>
                                </div>
                                <div class="col-xs-4 visible-sm visible-xs margin-auto text-right">    <a class="filter-icon"><i class="fa fa-filter"></i></a>
                                </div>
                                </div>
                            </div>
                        </div>
                    </div>
                        <input type=hidden value="{$cat}" name="cat_id">
                        <input type=hidden value="{$type}" name="search_type">
                        <input type=hidden value="{$page}" name="page">
                        <input type=hidden value="{$sort_type}" name="sort">

                        <div class="col-md-9 col-md-offset-3 right-content">
                            <button id="load_more" class="text-center btn btn-default btn-d-b green-b customized block" onclick="loadMore()">Show More</button>
                        </div>
                </div>
            </div>
        </div>

    </div>
</div>
<!-- / page content  -->
{include file="common/footer-1.tpl" nocache}
<!-- <script src="{$config['externaljs']}prodlist.js"></script> -->

<script>

$('#filecount').filestyle({
    input: true,
    buttonName: '',
    iconName: 'fa fa-pencil',
    buttonText: ''
});
</script>
<script type="text/javascript">
$('.filter-icon').click(function() {
    $('body').toggleClass('sn-open1');
});
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

var myVar;

  function myFunction() {
      myVar = setTimeout(showPage, 3000);
  }

  function showPage() {
    document.getElementById("loader").style.display = "none";
    document.getElementById("loadData").style.display = "block";
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
</script>
<script type="text/javascript">
    $.sidebarMenu($('.sidebar-menu'));

/*    function submitform(cur, id){
        // event.preventDefault();
            if($("#submit_form"+id).parsley().validate()){
                $("#submit_form"+id).submit();
            }
    }*/

    function placeBid(prodId){

       //console.log(prodId)
        if($("#submit_form"+prodId).parsley().validate()){
        $.ajax({
            type: 'POST',
            url: '/product/request/save',
            data: {
                id : prodId,
                offer_price : $('#submit_form'+prodId).find('#offer_price').val(),
                qty : $('#submit_form'+prodId).find('#qty').val()
            },
            dataType: 'json',
            success: function(data) {
                if(data.status == 1){
                     $('#submit_form'+prodId).find('#offer_price').val('');
                     if($('#submit_form'+prodId).find('#qty').attr('data-parsley-min') != undefined){
                        $('#submit_form'+prodId).find('#qty').val('');
                     }
                    $.toaster({ settings : { 'toaster' : { 'css' : { 'position' : 'fixed', 'top' : '10px','right' : '10px','max-width' : '600px', 'zIndex' : 50000 } }, 'timeout' : 15000} });

                    $.toaster({ message : 'Your bid has been successfully placed, and will be reviewed by the other transacting party. <a class="btn-link" href="{$config.url}/dashboard/myoffers">Review your pending orders here.</a>', title : '<i class="fa fa-info-circle" aria-hidden="true"></i> Info', priority : 'success'});
                   //console.log('bid placed');
                } else if(data.status == 0) {
                    // $.toaster.reset();
                    $.toaster({ message : data.msg });
                   //console.log('bid placed');
                   //console.log(data.msg);
                }
            }

        });
    }
}


$(document).ready(function() {

    window.ParsleyValidator.addValidator('equals',
    function (value, requirement) {
        return value == requirement;
    }, 32)
    .addMessage('en', 'equals', 'Please Enter the Total Quantity');


      if($("input[name=sort]").val() == 'availablenow'){
         $('#availablenow').prop("checked", true);
      }else if($("input[name=sort]").val() == 'futurebid'){
         $('#futurebid').prop("checked", true);
      }

      $('#availablenow').click(function(){
        if($(this). prop("checked") == true){
                $('#futurebid').prop("checked", false);
                window.location = '{$config.url}/openbid/market/{$cat}/{$type}/availablenow';
            } else {
            window.location = '{$config.url}/openbid/market/{$cat}/{$type}'
        }
      });
      $('#futurebid').click(function(){
        if($(this). prop("checked") == true){
                $('#availablenow').prop("checked", false);
                window.location = '{$config.url}/openbid/market/{$cat}/{$type}/futurebid';
            } else {
            window.location = '{$config.url}/openbid/market/{$cat}/{$type}'
        }
      });


    loadMore();

});


function loadMore() {
    //console.log("  111111111111111111111111111111 ")
    if ($("#finish_prod").val() != '0') {

        // alert(cat);
        //console.log("loadmore section");
        ////console.log('/get/openbid/products/'+cat+'/'+loadmore);z
        
        $.ajax({
            type: 'post',
            url: '/openbid/products',
            data: {
                cat: $("input[name=cat_id]").val(),
                type: $("input[name=search_type]").val(),
                page: loadmore,
                sortType: $("input[name=sort]").val()
            },
            dataType: 'json',
            success: function (data) {
                //console.log($(data.html).find("#finish_prod").val());
                $("#loadData").append(data.html);
                loadmore++;
            }
        });

    } else {
        $("#load_more").hide();
    }
}

</script>
<script>

  socket.on('closingStatus', function (data) {

   //console.log(data);
    if(data.close_status){
        $('#prod_'+data.product_id).hide();
    }
    ////console.log(data);

    // socket.emit('my other event', { my: 'data' });
  });

  socket.on('requestAccepted', function (data) {
    $prod = $('#prod_'+data.product_id);
   //console.log(data);

    if(data.rfilled_qty > 0){
        $prod.find('#qty').attr('data-parsley-max', data.rfilled_qty);
       // $prod.find('#rfilled_qty').text(data.rfilled_qty);
       $prod.find('#prod_qty').text(data.rfilled_qty);
    } else if(data.rfilled_qty <= 0){
        // $('#product_status').html('<h3>Closed</h3>');
        // $('#prod_'+data.product_id).hide();
    }
    // $('#submit_form').find('input').data('id').
    ////console.log(data);

    // socket.emit('my other event', { my: 'data' });
  });

</script>
</body>

</html>
