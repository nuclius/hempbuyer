           {include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">
<script src="{$config['externaljs']}jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
<div class="container-fluid" style="min-height:601px;">
  <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active"> <i class="fa fa-sitemap"></i>Primary Store</li>
            </ol>
        </div>
    </div>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <h4>Select Primary Store to add:<h4>
            <div class=" col-lg-6">
                <select id="selectpicker" class="form-control" data-max-options='9' multiple data-selected-text-format="count" data-live-search="true">
                    {foreach $storedetails as $key => $val}
                    <option value="{$val.id}">{$val.name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-lg-6">
                <button type="button" class="btn btn-success" onclick="addPrimaryStore()">Save</button>
            </div><br><br><br>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h4>Added Primary Store</h4>
            <!-- {$count = ''} -->
            {foreach $storedetails as $key => $val}
                {if $val.show_homepage == 1}
                <div class="col-lg-2"  style="margin-bottom:20px">
                    {if $val.logo != '' && $val.logo != 'null'}
                    <img src="{$config.url}/uploads/store/{$val.logo}" class="img_primarystore" alt="">
                    {/if}
                    {if $val.logo == '' || $val.logo == null}
                    <img src="{$config.url}/uploads/product/no_imf.png" class="img_primarystore" alt="">
                    {/if}
                    <div class="input-group" style="padding-bottom:5px;">
                        <span class="input-group-addon">
                            <input type="checkbox" class='selected_stores' value="{$val.id}" checked="checked">
                        </span>
                        <span class="form-control">{$val.name}<span>
                    </div>
                </div>
                {/if}
            {/foreach}
        </div>
    </div>
</div>
<script type="text/javascript">
console.log(jQ);

    function addPrimaryStore() {
        if(
            $('#selectpicker').val() != ''
            &&  $('#selectpicker').val() != 'NULL'
            && $('#selectpicker').val() != 'null'
            && $('#selectpicker').val() != undefined
        ) {
            if($('#selectpicker').val().length == 9) {
                var param = 'selected_ids='+$('#selectpicker').val()+'';
                $.ajax({
                    url: '/admincp/add9Stores',
                    type: 'POST',
                    data: param,
                    dataType:'json',
                    success:function(response) {
                        if(response.status == 'true') {
                            location.href="{$config.url}/admincp/primarystore/list";
                        }
                    }
                });
            } else {
                alert('Please select 9 stores to add');
            }

        } else {
            alert('Please select stores to add');
        }
    }
    function getSelectedValue() {
        var id_array = [];
        $('.selected_stores').each(function() {
            if($(this).is(':checked') == true) {
                id_array.push($(this).val());
            }
        });
        return id_array;
    }

    (function($) {
        $('#selectpicker').selectpicker({
            noneSelectedText: '0 item selected',
        });
        $('#selectpicker').selectpicker('val', getSelectedValue());

        $('body').on('click','.selected_stores', function() {
            var id_array = getSelectedValue();
            console.log(id_array);
            $('#selectpicker').selectpicker('val', id_array);
            $('#selectpicker').selectpicker('refresh');
        });
    })(jQ);

    /*$('#selectpicker').selectpicker('val', getSelectedValue());
    $('body').on('click','.selected_stores', function() {
        var id_array = getSelectedValue();
        // $('.selectpicker').selectpicker('val',id_array);
        $('#selectpicker').selectpicker();
    });*/
</script>
<style media="screen">
    .img_primarystore {
        height: 149px;
        width: 149px;
        border-top: 1px solid #ccc;
        border-right: 1px solid #ccc;
        border-left: 1px solid #ccc;
        border-radius: 3px;
    }
    .input-group .form-control {
        /*font-size: 12px;*/
    }
</style>
{include file="/admincp/footer.tpl" nocache}
