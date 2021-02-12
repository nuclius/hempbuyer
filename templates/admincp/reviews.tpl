{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <div class="row">
                  <!-- Page Heading -->
               
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> Users <i class="fa fa-angle-double-right"></i> <i class="fa fa-edit"></i> reviews
                            </li>
                        </ol>
                    </div>
                </div>
             
            <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/reviews">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label>{$phrases.from_date}</label>
                            <input class="form-control" value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label>{$phrases.to_date}</label>
                            <input class="form-control" value="{$search.to_date}" name="to_date" id="to_date" class="date_picker">
                        </div>
                    </div>
                    {* <div class="col-lg-4"> 
                            <div class="form-group">
                            <label>Country</label>
                                <select class="form-control" name="country" id="country_abbr">
                                <option value="{$search.country}">Select Country</option>
                                </select>
                        </div>

                        <div class="form-group">
                            <label>State</label>
                                <select class="form-control" name="state" id="state_abbr">
                                <option value="{$search.state}">Select State</option>
                                </select>
                        </div>
                    </div>
                </div>
                <div class="row"> *}
                    <div class="col-lg-4">
                        <div class="form-group">
                            <div>&nbsp;</div>
                            <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                        </div>
                    </div>
                </div>
            </form>
               
                <!-- /.row -->

                <div class="row">
                  
                 
                </div>    
                
               <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Select</th>
                                        <th>{$phrases.date_added}</th>
                                        <th>Product Title</th>
                                        <th>Username</th>
                                       <!-- <th>Trasaction Id</th>
                                         <th>{$phrases.subject}</th> -->
                                        <th>Review</th>
                                        <th>{$phrases.rating}</th>
                                        <th>{$phrases.action}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {if $reviews !=0}
                                {foreach $review as $key => $val}   
                                    <tr>
                                        <td><input type="checkbox" name="checkUser" id="checkuser_{$val.id}" onchange="selectUsers({$val.id})"></td>
                                        <td>{$val.created_at}</td>
                                        <td>{$val.product_title}</td>
                                        <td>{$val.sender_name}</td>
                                        
                                        <!-- <td>{$val.subject}</td> -->
                                        <td>{$val.comment}</td>
                                        <td>{$val.rate}</td>
                                         <td><a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/reviews/delete/{$val.id}');">Delete</a></td>
                                    </tr>
                                 {/foreach}
                                 {else}
                                  	 <tr>
                                         <td colspan="5">
                                        	 No reviews found !!!
                                         </td>
                                     </tr>
                                 {/if}
                                </tbody>
                            </table>
                            {$pagination_html}
                            <div class="row">
        <div class="col-lg-4">
            <div class="form-group">
                <button type="button" class="btn btn-danger" data-toggle="tooltip" title="Select multiple users and then click to delete" onclick="deleteUsers()"> <i class="fa fa-trash"></i> Delete </button>
            </div>
        </div>
    </div>
                        </div>
 
               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}

<script>

var urr = [];

function selectUsers(sid) {
    if ($('#checkuser_' + sid).prop("checked") == true) {
        urr.push(sid);
    } else {
        urr.splice(urr.indexOf(sid), 1);
       //console.log(urr.indexOf(sid));
    }
   //console.log(urr);
};
/* end here */

/* to Delete the selected users*/
function deleteUsers() {
if (urr.length<1) {
  swal({
        text: "Please Select Reviews......",
        type: 'warning',
        confirmButtonColor: 'green',
    });
}else{
    swal({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: 'green',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }, function(result) {
           //console.log(result);
            if (result) {
                $.ajax({
                type: 'POST',
                url: '/admincp/reviews/delete/multiple',
                data: {
                    ids: urr,
                },
                dataType: 'json',
                success: function(data) {
                    if (data.success == true) {
                        swal(
                            'Deleted!',
                            'Selected user review has been deleted.',
                            'success'
                        )
                    }
                    window.location = '{$config.url}/admincp/reviews';    
                }

            });
    }
});

}
}

/* delete section end here*/



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

$(document).ready(function() {
    $('#country_abbr').val('{$search.country}').change();
    if($('#country_abbr').val() != ''){
        $('#state_abbr').val('{$search.state}').change();  
    }
    
})
</script>