{include file="/admincp/header.tpl" nocache}
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}jquery.datetimepicker.css" />
<style>
    
</style>
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Referral Banners
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <form id="referral_banners_form" enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data">
    <input type="hidden" name="limit" id="limit" value="10">
        <div class="row">
            <div class="col-xs-4 col-sm-3">
                <div class="form-group">
                    <label>Banner Size of 250px X 250px</label>
                    <input type="file" class="form-control banner_file" name="banner" id="banner_1" accept=".jpg,.jpeg,.png,.gif">
                </div>
            </div>
            <div class="col-xs-8 col-sm-3">
                <div class="form-group">
                    <img src="{$config.url}/images/{$banner_data.banner1}" width="250" height="250" id="image_banner_1" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-4 col-sm-3">
                <div class="form-group">
                    <label>Banner Size of 728px X 90px</label>
                    <input type="file" class="form-control banner_file" name="banner" id="banner_2" accept=".jpg,.jpeg,.png,.gif">
                </div>
            </div>
            <div class="col-xs-8 col-sm-3">
                <div class="form-group">
                    <img src="{$config.url}/images/{$banner_data.banner2}" width="728" height="90" id="image_banner_2" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6 col-sm-3">
                <div class="form-group">
                    <label>Banner Size of 300px X 600px</label>
                    <input type="file" class="form-control banner_file" name="banner" id="banner_3" accept=".jpg,.jpeg,.png,.gif">
                </div>
            </div>
            <div class="col-xs-8 col-sm-3">
                <div class="form-group">
                    <img src="{$config.url}/images/{$banner_data.banner3}" width="300" height="600" id="image_banner_3" />
                </div>
            </div>
        </div>
        {* <div class="row">
            <div class="col-xs-6 col-sm-3">
            <label style="visibility: hidden;">Height adjust</label>
                <div class="form-group">
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </div>
        </div> *}
    </form>
     
</div>
</div>
{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>

<script language="javascript" type="text/javascript">

$(document).ready(function() {
    $(document).on('change', '.banner_file', function() {
        

        var id = $(this).attr('id').split('_')[1];
        var files = $(this)[0].files;
        console.log('files', files);
        var ext = files[0].name.split('.').pop().toLowerCase();
        if($.inArray(ext, ['png', 'jpg', 'jpeg', 'gif']) == -1) {
            alert('Please upload png extension file only');
            return true;
        }

        var formData = new FormData();
        for (let index = 0; index < files.length; index++) {
            const element = files[index];
            formData.append('banner', element);
        }
        formData.append('banner_id', id);

        // $("#certificateDocumentLoader").show();
        console.log('formData', formData);
        $.ajax({
            url : '/admincp/uploadBannerFile',
            type : 'POST',
            xhr: function() {
                var myXhr = $.ajaxSettings.xhr();
                return myXhr;
            },
            data : formData,
            processData: false,
            contentType: false,
            success : function(response) {
                if(response.file_name) {
                    // createCertificateHtml(response.certificates);
                    var fullpath = '{$config.url}/images/' + response.file_name;
                    console.log('fullpath', fullpath);
                    $("#image_banner_"+id).attr('src', fullpath+"?timestamp=" + new Date().getTime());
                }
                console.log('response', response);
            },
            error: function(e)
            {
                console.log(e);
            },
        }).done(function() {
        });
    });
});

</script>
