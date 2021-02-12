<div class="row">
  <style type="text/css">
  #dvPreview
  {
    width:150px;
    height:150px;
        margin: 0 auto;
  }
  #dvPreview img
  {
    width:150px;
    height:150px;
    margin: 0px auto;
  }
  </style>
    <div class="col-xs-6 col-sm-8 col-md-9">
        <div class="row">
            <div class="col-md-12 xx5">
                <div class="col-md-6 xx6"> {$phrase.store_name}</div>
                <div class="col-md-6">
                    <input type="text" class="form-control" value="{$store.name}" data-parsley-required required placeholder="" name="name">
                </div>
            </div>
            <div class="col-md-12 xx5">
                <div class="col-md-6 xx6"> {$phrase.location}</div>
                <div class="col-md-6">
                    <select class="form-control" data-parsley-required required placeholder=""  name="location">
                        <option value="">--Select location--</option>
                        {foreach $countries as $key => $val}
                            {if $val.parent_id == 0}
                                <option value="{$val.name}" {if $store.location == $val.name}selected='selected'{/if}>{$val.name}</option>
                            {/if}
                        {/foreach}
                    </select>
                    <!-- <input type="text" class="form-control" value="{$store.location}" data-parsley-required required placeholder=""  name="location"> -->
                </div>
            </div>
            <div class="col-md-12 xx5">
                <div class="col-md-6 xx6"> {$phrase.member_since}</div>
                <div class="col-md-6">
                    <input type="text" data-date-format="MM d, yyyy" class="form-control date-picker" value="{$store.dated_started}" id="date_started"  placeholder="" data-parsley-required required name="date_started">
                </div>
            </div>
            <div class="col-md-12 xx5">
                <div class="col-md-6 xx6">{$phrase.company_website}</div>
                <div class="col-md-6">
                    <input type="text" class="form-control" data-parsley-required required value="{$store.website}"  placeholder="" name="website">
                </div>
            </div>
            <div class="col-md-12 xx5">
                <div class="col-md-6 xx6"> {$phrase.description} </div>
                <div class="col-md-6">
                    <textarea class="form-control" rows="3" value="{$store.description}"  data-parsley-required required  name="description">{$store.description}</textarea>
                </div>
            </div>
        </div>
        <div class="row store_btns ai3">
            <div class="form-group col-xs-4 col-sm-4 col-md-4">
            </div>
            <div class="form-group col-xs-4 col-sm-4 col-md-4">
                <button type="submit" class="btn  btn-danger" style="width:100%;">
                <!-- {$phrase.submit} -->Submit
                </button>
            </div>
            <div class="form-group col-xs-4 col-sm-4 col-md-4">
                <a type="button" class="btn btn-default"  style="width:100%;" href="{$config.url}">{$phrase.cancel}</a>
            </div>
        </div>
    </div>
    <div class="col-xs-6 col-sm-4 col-md-3">
        <div class="ah1" style="margin:0 0 10px 0;">
            <div id="dvPreview" >
                {if $store.id > 0 and $store.logo != ''}
                <img src="{$config.url}/uploads/store/{$store.logo}" id='preview1'>
                {else}
                <img src="{$config.url}/images/no_imf.png" id='preview1'>
                {/if}
            </div>
            <div class="preview_name" style="margin-left: 24px;"></div>
            <div class="text-danger" style="font-size:12px;margin-left: 24px;">{$phrase.to_get_better_logo}</div>
            <div style="margin-left: 24px;">
                <input name="store_image" class="input file-upload" type="file" style="opacity:0;width:0px !important;height:0px !important;" onchange="preview(this)">
                <button type="button" class="btn btn-default" onclick="triggerfile()">{$phrase.upload_logo}</button>
            </div>
        </div>
        <div class="ah3">
            <div id="dvPreview">
                {if $store.id > 0 and $store.banner != ''}
                <img src="{$config.url}/uploads/store/{$store.banner}" id='preview2'>
                {else}
                <img src="{$config.url}/images/no_imf.png" id='preview2'>
                {/if}
            </div>
            <div class="preview_name" style="margin-left: 24px;"></div>
            <div class="text-danger" style="font-size:12px;margin-left: 24px;">{$phrase.to_get_better_banner}</div>
            <div style="margin-left: 24px;">
                <span>
                    <input name="store_banner_image" id='store_banner_image' class="input file-upload" type="file" style="opacity:0;width:0px !important;height:0px !important" >
                </span>
                <button type="button" class="btn btn-default" onclick="triggerfile2()">{$phrase.upload_banner}</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
function preview(ths) {
    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
    if (regex.test($(ths).val().toLowerCase())) {
        document.getElementById('preview1').src =window.URL.createObjectURL(ths.files[0]);
    } else {
        alert("Please upload a valid logo image file.");
    }
}


</script>
