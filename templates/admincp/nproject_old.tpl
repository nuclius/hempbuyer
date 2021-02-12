{include file="/admincp/header.tpl" nocache} {$projects.cid = $projects.category_id} {if $projects.id == ''} {$projects.id = 0} {/if}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" />
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active"> <i class="fa fa-edit"></i> {if $projects.id == 0 or $projects.id == ''} Add {else} Edit {/if} Product <i class="fa fa-angle-double-right"></i> {$projects.title} </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12"> 
            {if $error == 'saved'}
                <div class="alert alert-success"> <strong>Saved!</strong> {$users.first_name} profile was successfully changed. </div>
            {elseif $error != ''}
                <div class="alert alert-danger"> <strong>{$error}</strong> </div>
            {/if}
        </div>
        <form method="POST" enctype="multipart/form-data" class="admin_form" data-parsley-validate name="add-product" id="add-product" 
        action="/admincp/products/save">
            <div class="col-md-12">
                <input type="hidden" value="{$projects.id}" name="id" />
                <input type="hidden" name="sid" id="sid" value="{$sid}" />
                <div class="selft26 newadmclr" style="padding-bottom:10px;">Select category</div>
                <div class="row">
                    <div class="col-md-12 padlef sub_level_category">
                        {$level = 0} 
                        {$categories = $category} 
                        {include file="category-box.tpl" nocache}
                        <input type="hidden" name="cid" id="cid" value="{$projects.cid}" required>
                    </div>
                    <span id="pcat"></span>
                    <div class="col-md-3 padlef">
                        <input type="hidden" name="pid" id="pid" value="{$projects.id}" />
                        <input type="hidden" name="sid" id="sid" value="{$sid}" />
                        <input type="hidden" id="random_id" name="random_id" value="{$pid}" />
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <input type="hidden" value="{$projects.id}" name="id" />
                <input type="hidden" name="sid" id="sid" value="{$sid}" />
                <div class="selft26 newadmclr" style="padding-bottom:10px;">Select category</div>
                <div class="row">
                    <div class="col-md-3">
                        <label>Product title : </label>
                        <input type="text" name="title" id="title" value="{$projects.title}"/>
                    </div>
                    <div class="col-md-3">
                        <label>Price per unit : </label>
                        <input type="text" name="unit_price" id="price" value="{$projects.unit_price}"/>
                    </div>
                    <div class="col-md-3">
                        <label>Quantity available : </label>
                        <input type="text" name="qty" id="qty" value="{$projects.qty}"/>
                    </div>
                    <div class="col-md-3">
                        <label>Select Unit : </label>
                        <select class="w100 p15 pb15 grey-bg border-0" name="units" id="units" data-parsley-required="" data-parsley-required-message="Please select units">
                           <option {if $projects.units=""} value="" {/if}>Units of Measure</option>
                           <option {if $projects.units="ounces"} value="ounces" {/if}>Ounces</option>
                           <option {if $projects.units="pounds"} value="pounds" {/if}>Pounds</option>
                           <option {if $projects.units="grams"} value="grams" {/if}>Grams</option>
                           <option {if $projects.units="units"} value="units" {/if}>Units</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label>Quantity available : </label>
                        <input type="text" name="qty" id="qty" value="{$projects.qty}"/>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script type="text/javascript">
$("#start_date1").datetimepicker({
    // timepicker:false,
    format:'m/d/Y H:m',
    step: 5,
    minDate: 0,
    minTime: 0
});
$("#start_date2").datetimepicker({
    // ttimepicker:false,
    format:'m/d/Y H:m',
    step: 5,
    minDate: 0,
    minTime: 0
});
</script>
