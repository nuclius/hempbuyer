{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->

                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">

                        <ol class="breadcrumb">
                            <li class="active">
                                <!-- <i class="icon flaticon-flower-with-leaves"></i> --> Products <i class="fa fa-angle-double-right"></i> <!-- <i class="fa fa-search"></i> --> Search
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                   <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/projects/{$action}">

                         <div class="col-lg-3">
                            <div class="form-group">
                                <label>Title</label>
                                <input class="form-control" name="title" value="{$search.title}">
                            </div>
                            <div class="form-group">
                                <label>Product ID</label>
                                <input class="form-control"  value="{$search.id}" name="id">
                            </div>
                          </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>{$phrases.from_date}</label>
                                <input class="form-control" value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                            </div>

                            <div class="form-group">
                                <label>{$phrases.to_date}</label>
                                <input class="form-control" value="{$search.to_date}" name="to_date" id="to_date" class="date_picker">
                            </div>
                        </div>
                        <div class="col-lg-3">
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
                        </div>
                          <div class="col-lg-3">
                            <div class="form-group">
                                <label>Status</label>
                                <select class="form-control" name="market">
                                    <option value="" {if $search.status == ''} selected {/if}>All</option>
                                    <option value="openmarket"  {if $search.market == 'openmarket'} selected {/if}>Open Market</option>
                                    <option value="directmarket"  {if $search.market == 'directmarket'} selected {/if}>Direct By Market</option>
                                </select>
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
                <div class="project_list">
                {include file="/admincp/project-list.tpl" nocache}
                </div>


                <!-- /.row -->
</div>

{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript">

/* Select multiple products */
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
                url: '/admincp/projects/delete/multiple',
                data: {
                    ids: urr,
                },
                dataType: 'json',
                success: function(data) {
                    if (data.success == true) {
                        swal(
                            'Deleted!',
                            'Selected user has been deleted.',
                            'success'
                        )
                    }
                    window.location = '{$config.url}/admincp/projects/list';
                }

            });
    }
});

}
}


$(document).ready(function() {
    $('#country_abbr').val('{$search.country}').change();
    if($('#country_abbr').val() != ''){
        $('#state_abbr').val('{$search.state}').change();
    }

})

/* delete section end here*/
</script>
