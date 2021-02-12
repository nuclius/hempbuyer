{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    <!-- <i class="icon flaticon-flower-with-leaves"></i> --> Invoices <i class="fa fa-angle-double-right"></i> <!-- <i class="fa fa-search"></i> --> Search
                </li>
            </ol>
        </div>
    </div>

    <div class="row">
        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/distributoradmin/product_invoices/{$action}">

            <div class="col-lg-5">
                <div class="form-group">
                    <label>Title</label>
                    <input class="form-control" name="title" value="{$search.title}">
                </div>
                <div class="form-group">
                    <label>Product ID</label>
                    <input class="form-control"  value="{$search.id}" name="id">
                </div>
            </div>
            <div class="col-lg-5">
                <div class="form-group">
                    <label>{$phrases.from_date}</label>
                    <input class="form-control" value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                </div>

                <div class="form-group">
                    <label>{$phrases.to_date}</label>
                    <input class="form-control" value="{$search.to_date}" name="to_date" id="to_date" class="date_picker">
                </div>
            </div>
            <!-- <div class="col-lg-3">
                    <div class="form-group">
                    <label>Country</label>
                        <select class="form-control" name="country" id="country_abbr">
                        <option value="">Select Country</option>
                        </select>
                </div>

                <div class="form-group">
                    <label>State</label>
                        <select class="form-control" name="state" id="state_abbr">
                        <option value="{$state}">Select State</option>
                        </select>
                </div>
            </div> -->
            <div class="col-lg-2">
                <div class="form-group">
                    <label></label>
                </div>

                <div class="form-group btn-mrg2" style="margin-top: 40px;">
                <button type="submit" class="btn btn btn-default admin_search"> <i class="fa fa-search"></i> Search</button>
                </div>
            </div>
        </form>
    </div>
    <div class="row">
        <div class="col-lg-4">
            <div class="form-group">
                <br>
                {if $limit > $projects.length}
                    {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $projects.length} of {$pagination} results showing
                {/if}
                {if $limit == $projects.length}
                    {(($page - 1) * $limit) +1} - {((($page - 1) * $limit)) + $limit} of {$pagination} results showing
                {/if}
            </div>
        </div>
    </div>

    <div class="white-bg shadow p0">
        <div class="project_list">
            <div class="table-responsive cus-table style-1c">
                <table class="table m-b-0">
                    <thead class="green-b white p15">
                        <tr>
                            <th class="sortcol">Product Id</th>
                            <th class="sortcol sort_title" sort="title">Product Name</th>
                            <th class="sortcol">Product Category</th>
                            <th class="sortcol">Product SubCategory</th>
                            <th class="sortcol sort_date_added" sort="date_added">{$phrases.date_added}</th>
                            <th class="sortcol sort_rprice" sort="rprice">Payment Price</th>
                            <th class="sortcol sort_rprice" sort="rprice">Paayment Status</th>
                            <th >{$phrases.action}</th>
                        </tr>
                    </thead>
                    <tbody>
                    {$item = 0}
                        {foreach $projects as $key => $val}
                        {$item = 1}
                        <tr>
                            <td>{$val.id}</td>
                            <td><a href="{$config.url}/product/view/{$val.id}">{$val.title}</a></td>
                            <td>{$val.parent_category_name}</td>
                            <td>{$val.category_name}</td>
        
                            <td>{$val.stime}</td>
                            <td><span class="curr_symbol">{$currency}</span>{$val.unit_price}</td>
                            <td><b>{if $val.d_payment_status==1}<span class="text-success">Success</span>{/if}{if $val.d_payment_status==0}<span class="text-danger">Pending</span>{/if}</b></td>
                            <td>
                                <a href="{$config.url}/distributoradmin/product_invoices/detail/{$val.id}">View </a>
                            </td>
                        </tr>
                        {/foreach}
                        {if $item == 0}
                            <tr>
                                <td colspan="11">No {$projectsstatus} Products Found !!!</td>
                            </tr>
                        {/if}
                    </tbody>
                </table>
        
                <div class="col-md-12">
                    {$pagination_html}
                </div>
            </div>
        </div>
    </div>
  
</div>

<Script>
$(document).on("click", ".contact_modal", function () {
     var uid = $(this).data('id');
     var to_email = $(this).data('email');
     $(".modal-body #uid").val(uid);
     $(".modal-body #to_email").val(to_email);
     $(".modal-body #sub_msg").val('');
     $(".modal-body #body_msg").val('');
});

function sendMessage(){
        $.ajax({
            type: 'POST',
            url: '{$config.url}/admincp/payment/sendmsg',
            data: {
                r_id : $('#contact_form').find('#r_id').val(),
                id : $('#contact_form').find('#uid').val(),
                users: $('#contact_form').find('#to_email').val(),
                subject: $('#contact_form').find('#sub_msg').val(),
                message: $('#contact_form').find('#body_msg').val()
            },
            dataType: 'json',
            success: function(data) {
                if (data.data==1) {
                  alert('Message Sent');
                }else{
                  alert('Message Failed');
                }
            }
        });
   $('#wireContact').modal('hide');
}


$(function () {
    if ('{$action}' == 'list') {
        $('.sortcol').css('background-image', 'url("../../images/sort_desc.png")');
        $('.sortcol').css('background-repeat', 'no-repeat');
        $('.sortcol').css('background-position', 'right');
    }
    $('.admin_search').click(function () {

    });
    $('.sortcol').click(function () {

        if ($('#sort_order').val() == 'asc') {
            $('#sort_order').val('desc');
        } else {
            $('#sort_order').val('asc');
        }
        //console.log("Order iss " + $(this).attr('sort'));
        $('#sorting_column').val($(this).attr('sort'));

        showingProd();

    })
})

function showingProd(){
    $('#search_val').val("search");
    sort_col = $('#sorting_column').val();

    form_data = $('.admin_form').serialize();
    $.ajax({
        datatype: 'json',
        type: "get",
        url: '/admincp/projects/list',
        data: form_data,
        success: function (data) {

    //console.log('running');
            $('.project_list').html(data.html);

            $('.sortcol').css('background-image', 'url("../../images/sort_desc.png")');
            $('.sortcol').css('background-repeat', 'no-repeat');
            $('.sortcol').css('background-position', 'right');

            if ($('#sort_order').val() == 'asc') {
                $('.sort_' + sort_col).css('background-image', 'url("../../images/sort_asc.png")');

            } else {
                $('.sort_' + sort_col).css('background-image', 'url("../../images/sort_desc.png")');

            }
        }

    })
}

function productPagination(page){
    $('input[name="page"]').val(page);
    showingProd();
}

$('.admin_search').click(function(){
    if(false === $('.admin_form').parsley().validate())
    {
        return false;
    }
    showingProd();
});



$(function() {
    Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'mm/dd/yyyy';


    var dt = '{$serverdate}';


    var logic1 = function( currentDateTime ){
        var  begD  = new Date(currentDateTime)
        var  endD = new Date($("#to_date").val());
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#to_date").val('');
        }else if (endD !='Invalid Date' && begD > endD) {
            alert('Start Date Must Be less Than End date');
            $("#from_date").val('');
        }
    };
    $("#from_date").datetimepicker({
        inline:false,
        step:01,
        onChangeMonth:logic1,
        onSelectDate:logic1,
        maxDate:dt,
        timepicker:false,
        format:'m/d/Y',

    });
    var logic = function( currentDateTime ){
        var  begD  = new Date($("#from_date").val());
        var  endD = new Date(currentDateTime);
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#to_date").val('');
        }else if (begD > endD) {
            alert('End Date Must Be Greater Than Start date');
            $("#to_date").val('');
        }

    };
    $("#to_date").datetimepicker({
        step:01,
        onChangeMonth:logic,
        onSelectDate:logic,
        showHeader:2,
        maxDate:dt,
        timepicker:false,
        format:'m/d/Y',
    });
});


</Script>
