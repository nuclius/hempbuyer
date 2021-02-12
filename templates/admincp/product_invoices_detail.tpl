{include file="/admincp/header.tpl" nocache}
<style>
    table tr td {
        text-align: left;
    }
    table tr td:first-child {
        width: 200px;
    }
</style>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    <!-- <i class="icon flaticon-flower-with-leaves"></i> --> Invoices <i class="fa fa-angle-double-right"></i> <!-- <i class="fa fa-search"></i> --> Details
                </li>
            </ol>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-12 m-top-20">
        <div class="white-bg shadow p0">
            <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th colspan="2">Invoice Details</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><b>Product Id:</b></td>
                        <td>{$projects.id}</td>
                    </tr>
                    <tr>
                        <td><b>Product Name:</b></td>
                        <td>{$projects.title}</td>
                    </tr>
                    <tr>
                        <td><b>Product Category:</b></td>
                        <td>{$projects.parent_category_name}</td>
                    </tr>
                    <tr>
                        <td><b>Product SubCategory:</b></td>
                        <td>{$projects.category_name}</td>
                    </tr>
                    <tr>
                        <td><b>Date Added:</b></td>
                        <td>{$projects.stime}</td>
                    </tr>
                    <tr>
                        <td><b>Transaction Price:</b></td>
                        <td><span class="curr_symbol">{$currency}</span>{$projects.unit_price}</td>
                    </tr>
                    <tr>
                        <td><b>Distribution Payment Status:</b></td>
                        <td><b>{if $projects.d_payment_status==1}<span class="text-success">Success</span>{else}<span class="text-danger">Pending</span>{/if}</b></td>
                    </tr>
                    <tr>
                        <td><b>Distribution Price:</b></td>
                        <td>
                            <input type="text" name="d_price" id="d_price" class="form-control" style="width: 200px !important;" value="{$projects.d_price}" {if $projects.d_payment_status==1}disabled readonly{/if}>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Distribution Invoice:</b></td>
                        <td>
                            {if $projects.d_payment_status==0}
                            <div class="open-bid-item" style="width: 100px; float: left;">
                                <div class="bootstrap-filestyle input-group" style="margin-bottom: -35px;"><span class="group-span-filestyle " tabindex="0"><label for="filecount5" class="btn btn btn-default btn-d-b btn-d-g m5 w100 "><span class="icon-span-filestyle "></span> <span class="buttonText">UPLOAD</span></label></span></div>

                                <input type="file" data-parsley-trigger="change" id="d_invoice" name="d_invoice" class="d_invoice" style="opacity: 0; width: 100% !important;" accept="image/png, image/jpeg, image/jpg">
                            </div>
                            {/if}
                            <span id="d_invoice_name" style="float: left; padding: 12px;"><a target="_blank" href="{$config['url']}/uploads/d_invoice/{$projects.d_invoice}">{$projects.d_invoice}</a></span>
                        </td>
                    </tr>
                    {if $projects.d_payment_status==0}
                    <tr>
                        <td><b></b></td>
                        <td>
                            <button type="button" id="save_distribution_btn" class="btn btn-success" onclick="save_distribution_btn('{$projects.id}')">Save</button>
                        </td>
                    </tr>
                    {/if}
                </tbody>
            </table>
        </div>
        </div>
    </div>
</div>
<!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}

<script>

$('.d_invoice').change(function(e){
    var fileName = e.target.files[0].name;
    $('#d_invoice_name').html(fileName);
    
});

function save_distribution_btn(prodId){

    var myFormData = new FormData();
    myFormData.append( 'd_invoice', $('#d_invoice')[0].files[0] );
    myFormData.append( 'id', prodId );
    myFormData.append( 'd_price', $('#d_price').val() );

    $('#save_distribution_btn').attr('disabled', true);
    $.ajax({
        url: '/distributoradmin/update_distributor_payment_and_invoice',
        data: myFormData,
        type: 'POST',
        contentType: false,
        processData: false,
        success: function(data) {
            if(data.success == true){
                $.toaster({ message : 'distribution detail saved.', title : '<i class="fa fa-info-circle" aria-hidden="true"></i> Info', priority : 'success'});
            }
            $('#save_distribution_btn').attr('disabled', false);
        }
    });
}
</script>