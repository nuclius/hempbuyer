{if $deleted_project}
<div class="alert alert-success"> <strong>Deleted!</strong> </div>
{/if}
{if $undeleted_project}
<div class="alert alert-danger"> <strong>You can't delete this.Users already bidded!</strong> </div>
{/if}

<style>
    .sortcol{
        cursor:pointer;

    }
</style>

<div class="white-bg shadow p0">
  <div class="table-responsive cus-table style-1c">
        <table class="table m-b-0">
            <thead class="green-b white p15">
                <tr>
                    <th>Select</th>
                    <th class="sortcol">Product Id</th>
                    <th class="sortcol sort_title" sort="title">Product Name</th>
                    <th class="sortcol">Product Category</th>
                    <th class="sortcol">Product SubCategory</th>
                    <th class="sortcol sort_status" sort="status">Market Status</th>
                    <th class="sortcol">Product Status</th>
                    <th class="sortcol sort_date_added" sort="date_added">{$phrases.date_added}</th>
                    <th class="sortcol">Email Address</th>
                    <th class="sortcol sort_rprice" sort="rprice">Transaction Price</th>

                    {if $action =='open' || $action =='future'}
                    <th class="sortcol">Units Available</th>
                    {/if}
                    
                    {if $action =='closed' || $action =='sold'}
                    <th class="sortcol">Units Sold</th>
                    {/if}
                    <!-- <th>{$phrases.image}</th>
                    <th class="sortcol sort_date_closed" sort="date_closed">{$phrases.date_closed}</th> -->
                    <th >{$phrases.action}</th>
                </tr>
            </thead>
            <tbody>
            {$item = 0}


             {foreach $projects as $key => $val}
             {$item = 1}
                <tr>
                    <td><input type="checkbox" name="checkUser" id="checkuser_{$val.id}" onchange="selectUsers('{$val.id}')"></td>
                    <td>{$val.id}</td>
                    <td><a href="{$config.url}/product/view/{$val.id}">{$val.title}</a></td>
                    <td>{$val.parent_category_name}</td>
                    <td>{$val.category_name}</td>

                    {if $val.auction == 0}
                    <td>Direct Market</td>
                    {/if}

                    {if $val.auction == 1}
                    <td>Open Market</td>
                    {/if}

                    {if $val.auction == 1 && $val.trading_type == 'buy'}
                    <td>Buy</td>
                    {/if}

                    {if $val.auction == 1 && $val.trading_type == 'sell'}
                    <td>Sell</td>
                    {/if}

                    {if $val.auction == 0}
                    <td>Sell</td>
                    {/if}

                    <td>{$val.stime}</td>
                    <td><a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.id}" data-email="{$val.email}" data-target="#wireContact">{$val.email}</a></td>
                    <td><span class="curr_symbol">{$currency}</span>{$val.unit_price}</td>

                    {if $action =='open' || $action =='future'}
                    <td>{$val.qty-$val.sold}</td>
                    {/if}

                    {if $action =='closed' || $action =='sold'}
                    <td>{$val.sold_qty}</td>
                    {/if}

                    <td>

                    {if $action == 'sold' || $action == 'closed'}
                          <a href="{$config.url}/dashboard/invoice/{$val.b_id}">View Receipt</a>
                    {/if}

                    {if $action =='open' || $action =='future' || $action =='list'}
                        {if $val.auction == 1}
                          <a href="{$config.url}/product/view/{$val.id}">View </a>
                        {/if}

                        {if $val.auction == 0}
                          <a href="{$config.url}/product/sview/{$val.id}">View </a>
                        {/if}

                        {if $val.sold == 0 and ($val.market_status == 'open' or $val.market_status == 'moderate')}
                          <a href="{$config.url}/admincp/projects/edit/{$val.id}">Edit</a>
                        {/if}
                        {if $val.status != 'deleted'}
                          <a  onclick="return confirm('Are you sure ?')" href="{$config.url}/admincp/projects/delete/{$val.id}">Delete</a>
                        {/if}
                        {if $val.status == 'deleted'}      
                            deleted   
                        {/if}
                        {if $val.market_status == 'moderate'}<br />
                          <a href="{$config.url}/admincp/projects/approve/{$val.id}">Approve</a>
                        {/if}
                    {/if}

                      </td>
                    <!-- <td><a href="#" title="{$val.title}"> <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" width="50" height="50" alt="1"></a></td>

                    <td>{$val.ctime}</td> -->
                </tr>
             {/foreach}
             {if $item == 0}
              	 <tr>
                     <td colspan="11">
                     No {$projectsstatus} Products Found !!!
                     </td>
                 </tr>
             {/if}
            </tbody>
        </table>

      <div class="col-md-12">

        <div class="col-lg-4">
            {if $item > 0}
            <div class="form-group">
                <button type="button" class="btn btn-danger" data-toggle="tooltip" title="Select multiple users and then click to delete" onclick="deleteUsers()"> <i class="fa fa-trash"></i> Delete </button>
            </div>
            {/if}
        </div>
      {$pagination_html}

          </div>
                          </div>
</div>




<!-- <div class="modal fade" id="wireContact" role="dialog">
        <div class="modal-dialog modal-sm" style="width:50% !important;">

            <div id="contact_form" class="modal-content">
                <div class="modal-header p0">
                    <div class="panel panel-success border-0">
                        <div class="panel-heading green-bg">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h3>Enter the message...!</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body form-horizontal">
                       <input type="hidden" value="0" name="r_id" id="r_id">
                     <div class="form-group">
                      <label class="col-sm-3 col-md-2 control-label">Email-ID* :</label>
                      <div class="col-sm-9 col-md-10">
                       <input type="email" name="users" id="to_email" disabled=""  class="form-control"/>
                      </div>
                    </div>
                      <div class="form-group">
                        <label class="col-sm-3 col-md-2 control-label">Subject : </label>
                        <div class="col-sm-9 col-md-10">
                       <input type="sub_msg" name="subject" id="sub_msg" data-parsley-required data-parsley-required-message = "Please enter subject"  class="form-control"/>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 col-md-2 control-label">Message : </label>
                        <div class="col-sm-9 col-md-10">
                      <textarea name="message" id="body_msg" rows="6" data-parsley-required-message = "Please enter message to proceed..."></textarea>
                        </div>
                      </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d-b green-b m0" type="button" onclick="sendMessage()">SEND</button>
                    <button class="btn btn-default btn-d-b green-b m0" type="button" data-dismiss="modal">CLOSE</button>
                </div>

            </div>
        </div>
    </div> -->
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
       //console.log("Action is {$action}")
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
