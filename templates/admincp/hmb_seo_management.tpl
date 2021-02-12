{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<style>
    .fa-pause-circle, .fa-play-circle, .fa-times-circle {
        font-size: 25px;
    }
    .mt-1 {
        margin-top: 1em;
    }
</style>
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    SEO Management
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <form id="search_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="post" enctype="multipart/form-data" action="/admincp/transactions">
        <input type="hidden" name="page" id="page" value="1">
        <input type="hidden" name="action" id="action" value="{$action}">
        <input type="hidden" name="limit" id="limit" value="10">
        <input type="hidden" name="is_report" id="is_report" value="0">
        <div class="row">
            <div class="col-xs-6 col-sm-3">
                <div class="form-group">
                    <label>Product Title</label>
                    <input class="form-control" value="" placeholder="Enter Product Title" name="tr_title" id="tr_title" class="" autocomplete="off">
                </div>
            </div>
            <div class="col-xs-6 col-sm-3">
                <div class="form-group">
                    <label>From Date</label>
                    <input class="form-control" value="" placeholder="Enter From Date" name="tr_from_date" id="tr_from_date" class="" autocomplete="off">
                </div>
            </div>
            <div class="col-xs-6 col-sm-3">
                <div class="form-group">
                    <label>To Date</label>
                    <input class="form-control" value="" placeholder="Enter To Date" name="tr_to_date" id="tr_to_date" class="" autocomplete="off">
                </div>
            </div>
            <div class="col-xs-6 col-sm-3">
            <label style="visibility: hidden;">Height adjust</label>
                <div class="form-group">
                    <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                    {* <button onclick="generate_report()" class="btn btn-success pull-right"> <i class="fa fa-download"></i> Export</button> *}
                </div>
            </div>
        </div>
    </form>
    <br>
    <br>
     
    {if $error != ''}
    <div class="alert alert-danger"><strong>{$error}</strong></div>
    {/if}
    <div id="list_div" class=""></div> 
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script language="javascript" type="text/javascript">

$(document).ready(function() {
    $('#tr_from_date').datetimepicker({
        timepicker:false,
        format:'Y-m-d'
    });
    $('#tr_to_date').datetimepicker({
        timepicker:false,
        format:'Y-m-d'
    });

    get_list();
    $(document).on('submit', '#search_form', function(e) {
        paginationData.currentPage = 1;
        $("#page").val(1);
        if(is_report == 1) {
            is_report = 0;
            setTimeout(function() {
                $("#is_report").val(0);
            }, 1000);
        } else {
            e.preventDefault();
            get_list();
        }
    });

});
var is_report = 0;
function generate_report() {
    is_report = 1;
    $("#is_report").val(1);
    $('#search_form').trigger('submit');
}
function get_list() {
    var formArray = $("#search_form").serializeArray();
    var Obj = {};
    var productData = formArray ? formArray : [];
    if(productData.length) {
        for (var index = 0; index < productData.length; index++) {
            const element = productData[index];
            Obj[productData[index].name] = productData[index].value;
        }
    }
    Obj.is_report = is_report;
    console.log('Obj', Obj);

    $.ajax({
        type: 'POST',
        url: '/admincp/seo_management',
        data: Obj,
        // dataType: 'json',
        success: function(data) {
            // console.log('data', data);
            if(!is_report) {
                $("#list_div").html(data);
                paginationData.recordPerPage = $("#limit").val();
                $("#pagination_html").html(pagination(paginationData));
            }
            is_report = 0;
        }

    });
}
function update_medata(id) {
    console.log('id', id);
    var meta_title = $("#meta_title__"+id).val();
    var meta_key = $("#meta_key__"+id).val();
    var meta_description = $("#meta_description__"+id).val();
    var Obj = {
        meta_title: meta_title,
        meta_key: meta_key,
        meta_description: meta_description,
        id: id
    };
    $.ajax({
        type: 'POST',
        url: '/admincp/update_medata',
        data: Obj,
        // dataType: 'json',
        success: function(data) {
            console.log('data', data);
            if(data.success) {
                swal({
                    title: "Updated success",
                    type: "success"
                }, function () {
                    get_list();
                });
            } else {
                swal("Error", data.error);
                swal({
                    title: data.error,
                    type: "warning"
                });
            }
        }
    });
}
</script>
