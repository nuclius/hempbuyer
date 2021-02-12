
{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">
<script src="{$config['externaljs']}jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
<div class="container-fluid" style="min-height:601px;">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active"> <!-- <i class="fa fa-sitemap"></i> -->Store {$phrases.categories_list} </li>
            </ol>
        </div>
    </div>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <h4>Maximum Store Category:</h4>
            <div class="col-lg-6">
                <input type="text" class="form-control col-md-5 max_category" value='{if $storemaxlength[0].max_length > 0}{$storemaxlength[0].max_length}{else}0{/if}' onkeypress='isNumber(event)' {if $storemaxlength[0].max_length > 0} attr-max-id='{$storemaxlength[0].id}' readonly='readonly'{/if} placeholder="Maximum Store Category Length">
                <span class='err-mx' style='font-size:12px;color:red;'></span>
            </div>
            <div class="col-lg-6">
                    <button type="button" class='btn btn-success save_max' style="display:none" onclick="saveMaxCategoryBtn()">Save</button>
                    <button type="button" class='btn btn-danger cancel_max' attr-default-id='{if $storemaxlength[0].max_length > 0}{$storemaxlength[0].max_length}{else}0{/if}' style="display:none" onclick="toggleBtn();defaultVal();">Cancel</button>
                    <button type="button" class='btn btn-success edit_max' onclick="toggleBtn()">Edit</button><br /><br /><br />
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h4>Select Store Category:<h4>
            <div class=" col-lg-6">
                <select id="selectpicker" class="form-control" multiple data-selected-text-format="count" data-live-search="true" attr-selected-cat='{if $storemaxlength[0].storecategory_ids> 0}{$storemaxlength[0].storecategory_ids}{else}{/if}'>
                    {foreach $category as $key => $val}
                    {if $val.parent_id == 0}
                    <option value="{$val.id}">{$val.name}</option>
                    {/if}
                    {/foreach}
                </select>
            </div>
            <div class="col-lg-6">
                <button type="button" class="btn btn-success" onclick="addStoreCategory()">Save</button>
            </div>
            <br><br><br>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h4>Added Store Category:</h4>
            <div class="added_categories">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

function toggleBtn() {
    $(".save_max,.cancel_max,.edit_max").toggle();
    $('.cancel_max').each(function() {
        if($(this).is(':visible') == true)
            $('.max_category').prop('readonly',false);
        else
            $('.max_category').prop('readonly',true);
    });
}
function saveMaxCategoryBtn() {
    $('.err-mx').text('');
    var length = Number($('.max_category').val());
    if(length > 0) {
        // if($('.store-cat-length').length >= length) {
        //     $('.err-mx').text('Already you added '+$('.store-cat-length').length+' Store Categories. So please give maximum store category length more than '+$('.store-cat-length').length+' or delete some categories to change');
        //     return false;
        // }
        var id = 0;
        if($('[attr-max-id]').length > 0) {
            id = $('.max_category').attr('attr-max-id');
        }
        var param   = 'length='+length+'&id='+id+'';

        $.ajax({
            url:'/admincp/addMaxStoreCategory',
            type:'POST',
            data: param,
            dataType:'json',
            success:function(response) {
                if(response.status == 'true') {
                    // $(".save_max,.cancel_max,.edit_max").toggle();
                    // $('.max_category').prop('readonly',true);
                    // $('.cancel_max').attr('attr-default-id',length);
                    // if(Number(response.id) > 0) {
                    //     $('.max_category').attr('attr-max-id', response.id);
                    // }
                    location.href="{$config.url}/admincp/storecategories/list/";
                } else {
                    $('.err-mx').text('Some unknown error on saving maximum store category length');
                }
            }
        });
    }
}
function isNumber(event) {
     if(event.which != 8 && isNaN(String.fromCharCode(event.which))){
         $('.err-mx').text('Please enter number only');
         event.preventDefault(); //stop character from entering input
     } else {
         $('.err-mx').text('');
     }
}
function defaultVal() {
    $('.max_category').val($('.cancel_max').attr('attr-default-id'));
    $('.err-mx').text('');
}

</script>
<script type="text/javascript">
console.log(jQ);

    function addStoreCategory() {
        if(
            $('#selectpicker').val() != ''
            &&  $('#selectpicker').val() != 'NULL'
            && $('#selectpicker').val() != 'null'
            && $('#selectpicker').val() != undefined
        ) {
            var length = Number($('.max_category').val());

            if($('#selectpicker').val().length == length) {
                var id = 0;
                if($('[attr-max-id]').length > 0) {
                    id = $('.max_category').attr('attr-max-id');
                }
                var param = 'storeids='+$('#selectpicker').val()+'&id='+id+'';
                $.ajax({
                    url: '/admincp/saveStoreCategory',
                    type: 'POST',
                    data: param,
                    dataType:'json',
                    success:function(response) {
                        if(response.status == 'true') {
                            location.href="{$config.url}/admincp/storecategories/list/";
                        }
                    }
                });
            } else {
                alert('Please select '+length+' categories to add');
            }

        } else {
            alert('Please select category to add');
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
            maxOptions: $('.max_category').val()
        });
        if($('[attr-selected-cat]').length > 0) {
            var selected_ids = $('[attr-selected-cat]').attr('attr-selected-cat');
            selected_ids = selected_ids.split(",");
            $('#selectpicker').selectpicker('val', selected_ids);
            if(selected_ids.length > 0) {
                var html = ''
                $('#selectpicker option:selected').each(function() {
                    html += '<div class="col-lg-3">\
                        <div class="input-group" style="padding-bottom:5px;">\
                            <span class="input-group-addon">\
                                <input type="checkbox" class="selected_stores" value="'+$(this).val()+'" checked="checked">\
                            </span>\
                            <span class="form-control">'+$(this).html()+'<span>\
                        </div>\
                    </div>';
                });
                $('.added_categories').html(html);
            }
        }

        $('body').on('click','.selected_stores', function() {
            var id_array = getSelectedValue();
            $('#selectpicker').selectpicker('val', id_array);
            $('#selectpicker').selectpicker('refresh');
        });
    })(jQ);
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
