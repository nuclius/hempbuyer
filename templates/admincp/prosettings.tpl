{include file="/admincp/header.tpl" nocache}
<div class="container-fluid" style="min-height:588px;">
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active"> <i class="fa fa-sitemap"></i>Product Settings</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="">
                <div class="col-lg-8 col-lg-offset-2 form-horizontal">
                    <form id="productSettings" method="post">
                        <div class="form-group">
                            <div class="col-lg-5 text-right">
                                <label>Weight in: </label>
                            </div>
                            <div class="col-lg-3">
                                <select type="text" class="form-control" name="weight">
                                    <option value="lbs" {if $config.productsetting.weight == 'lbs'}selected='selected'{/if}>Pounds (lbs)</option>
                                    <option value="kg" {if $config.productsetting.weight == 'kg'}selected='selected'{/if}>Kilogram (kg)</option>
                                </select>
                                <span class="err err_type"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-5 text-right">
                                <label>Height / Width in: </label>
                            </div>
                            <div class="col-lg-3">
                                <select type="text" class="form-control" name="length">
                                    <option value="inch" {if $config.productsetting.length == 'inch'}selected='selected'{/if}>Inch</option>
                                    <option value="cm" {if $config.productsetting.length == 'cm'}selected='selected'{/if}>Centimeter</option>
                                </select>
                                <span class="err err_status"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-5 text-right">
                                <label>Currency in: </label>
                            </div>
                            <div class="col-lg-3">
                                <select type="text" class="form-control" name="currency" named='{$config.productsetting.currency}'>
                                    <option value="dollar" {if $config.productsetting.currency == 'dollar'}selected='selected'{/if}>Dollars</option>
                                    <option value="rupee" {if $config.productsetting.currency == 'rupee'}selected='selected'{/if}>Rupees</option>
                                </select>
                                <span class="err err_status"></span>
                            </div>
                        </div>
                        <div class="col-lg-10 text-center">
                            <button type="button" class="btn btn-default btn_cancel" disabled='disabled' onclick="location.href='{$config.url}/admincp/pro_settings'">Cancel</button>
                            <button type="button" class="btn btn-success save_btn" disabled='disabled'>Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
<style media="screen">
.form-horizontal label{
    margin-top: 7px;
}
</style>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript">
    $(function() {
        $('body').on('click', '.save_btn', function() {
            var param = $('#productSettings').serialize();
            $.ajax({
                url : '/admincp/saveProductSettings',
                type: 'POST',
                data: param,
                dataType: 'json',
                success: function(response) {
                    if(response.status == 'success') {
                        location.href='{$config.url}/admincp/pro_settings';
                    }
                }
            });
        }).on('change','select',function() {
            $('.btn_cancel,.save_btn').prop('disabled',false);
        });
    });
</script>
