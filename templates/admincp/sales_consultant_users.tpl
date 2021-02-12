{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <style>
        .open-bid-row {
            background: #ffffff;
            margin-bottom: 10px;
            /* box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23); */
        }
    </style>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Sales Consultant
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    Working
</div>

{include file="/admincp/footer.tpl" nocache}

<script>
$.fn.stars = function () {
    return $(this).each(function () {
        // Get the value
        var val = parseFloat($(this).html());
        // Make sure that the value is in 0 - 5 range, multiply to get width
        var size = Math.max(0, (Math.min(5, val))) * 16;
        // Create stars holder
        var $span = $('<span />').width(size);
        // Replace the numerical value with stars
        $(this).html($span);
    });
}

$(document).ready(function() {
    loadMore();
    var loadmore = 0;

    function loadMore(){
        $("#loading").show();
        if($("#finish_prod").val() != '0'){
            loadmore++;
            $.ajax({
                type: 'post',
                url: '/openbid/products',
                data : {
                    cat : 'all',
                    type : 'recent',
                    page : loadmore,
                    sortType : 'undefined'
                },
                dataType: 'json',
                success: function(data) {
                    $("#loading").hide();
                    $("#loadData").show();

                    $("#loadData").append(data.html);
                }
            });

        } else {
            $("#load_more").hide();
        }
    }
});

function placeBid(prodId){

    $("#submit_form123").parsley().validate()
    if($("#submit_form"+prodId).parsley().validate() && $("#submit_form123").parsley().validate()){
        var values = $('#behalf_user').val().split('_');
        var cc_id = values[0];
        var user_id = values[1];
        var qty = $('#submit_form'+prodId).find('#qty').val();
        $.ajax({
            type: 'POST',
            url: '/product/request/save',
            data: {
                id : prodId,
                offer_price : $('#submit_form'+prodId).find('#offer_price').val(),
                qty : qty,
                behalf_cc_id: cc_id,
                behalf_user_id: user_id,
                is_on_behalf: 1
            },
            dataType: 'json',
            success: function(data) {
                if(data.status == 1){
                    /* $("#accept_form").remove();
                    $('<form id="accept_form" method="post" action="{$config.url}/product/request/accept/'+prodId+'"><input type="hidden" name="req_id" value="'+data.data.insertId+'" /></form>').appendTo('body').submit(); */

                    $.ajax({
                        type: 'POST',
                        url: '/product/request/accept/'+prodId,
                        data: {
                            req_id : data.data.insertId
                        },
                        dataType: 'json',
                        success: function(data) {
                            
                        }
                    });
                    
                        
                    $('#submit_form'+prodId).find('#offer_price').val('');
                    if($('#submit_form'+prodId).find('#qty').attr('data-parsley-min') != undefined){
                        $('#submit_form'+prodId).find('#qty').val('');
                        var old_qty = $('#submit_form'+prodId).find('#prod_qty').html().trim();
                        $('#submit_form'+prodId).find('#prod_qty').html(old_qty - qty);
                    }
                    $.toaster({ settings : { 'toaster' : { 'css' : { 'position' : 'fixed', 'top' : '10px','right' : '10px','max-width' : '600px', 'zIndex' : 50000 } }, 'timeout' : 15000} });

                    $.toaster({ message : 'Your order has been successfully purchased.', title : '<i class="fa fa-info-circle" aria-hidden="true"></i> Info', priority : 'success'});
                } else if(data.status == 0) {
                    $.toaster({ message : data.msg });
                }
            }
        });
    }
}
</script>