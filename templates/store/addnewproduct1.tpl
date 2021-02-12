{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<div class="container-fluid store-head add-prdt">
    <div class="container">
        <div class="col-md-12">
            <div class="col-md-12 con">
                <h2>Create New Products</h2>
                <div class="col-md-12">
                    <h5>Choose Your Category </h5>
                    <div class="col-md-12 padboth">
                        <div class="col-md-12 padlr add-prdt1">
                            {foreach $allcategories as $avl => $val}
                            {if $val.parent_id == 0}
                            <div class="radio-inline">
                                <label>
                                    <input type="radio" class='cat_checkbox' name="tab" value="{$val.id}" />
                                    <span>{$val.name}</span>
                                </label>
                            </div>
                            {/if}
                            {/foreach}
                        </div>
                        <div class="col-md-12 padboth padlr">
                            <div >
                                <h5>Choose Sub  Category </h5>
                                {foreach $allcategories as $avl => $val}
                                {if $val.parent_id != 0}
                                <div class="radio subcat{$val.parent_id}">
                                    <label>
                                    <input type="radio" class="subcat_checkbox" name="Sub" value="{$val.id}" />{$val.name}</label>
                                </div>
                                {/if}
                                {/foreach}
                                <div class="col-md-12 padboth padlr">
                                    <button class="btn btn-default" onclick="addProduct()">Next</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $('.radio').css('display','none');
        $('body').on('click','.cat_checkbox',function () {
            $('.radio').css('display','none');
            $('.radio .subcat_checkbox').prop('checked',false);
            $('.subcat'+$(this).val()+'').css('display','block');
        });
    });
    function addProduct() {
        var cat_id = 0;
        var subcat_id = 0;
        $('.cat_checkbox').each(function () {
            if($(this).is(':checked') == true) {
                cat_id = $(this).val();
            }
        });
        $('.subcat_checkbox').each(function () {
            if($(this).is(':checked') == true) {
                subcat_id = $(this).val();
            }
        });
        if (cat_id > 0) {
            location.href="{$config.url}/stores/addnewproduct2/{$storeid}/"+cat_id+"/"+subcat_id+"";
        } else {
            alert('Please select category to add new product');
        }
    }
</script>
{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
