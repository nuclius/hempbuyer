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
        <div class="col-md-6 xx6"> {$pharse.store_name}</div>
        <div class="col-md-6">
          <input type="text" class="form-control" value="{$store.name}" data-parsley-required required placeholder="" name="name">
        </div>
      </div>
      <div class="col-md-12 xx5">
        <div class="col-md-6 xx6">{$pharse.location}</div>
        <div class="col-md-6">
          <input type="text" class="form-control" value="{$store.location}" data-parsley-required required placeholder=""  name="location">
        </div>
      </div>
      <div class="col-md-12 xx5">
        <div class="col-md-6 xx6"> {$pharse.member_since}</div>
        <div class="col-md-6">
          <input type="text" data-date-format="MM d, yyyy" class="form-control date-picker" value="{$store.dated_started}" id="date_started"  placeholder="" data-parsley-required required name="date_started">
        </div>
      </div>
      <div class="col-md-12 xx5">
        <div class="col-md-6 xx6">{$pharse.company_website}</div>
        <div class="col-md-6">
          <input type="text" class="form-control" data-parsley-required required value="{$store.website}"  placeholder="" name="website">
        </div>
      </div>
      <div class="col-md-12 xx5">
        <div class="col-md-6 xx6"> {$pharse.description} </div>
        <div class="col-md-6">
          <textarea class="form-control" rows="3" value="{$store.description}"  data-parsley-required required  name="description">{$store.description}</textarea>
        </div>
      </div>
    </div>
    <div class="row store_btns ai3"> 
    <div class="form-group col-xs-6 col-sm-6 col-md-6">
      <button type="submit" class="btn  btn-danger" style="width:100%">{$pharse.submit}</button>
    </div>
    <div class="form-group col-xs-6 col-sm-6 col-md-6">
      <button type="button" class="btn btn-default ai2">{$pharse.cancel}</button>
    </div> 
  </div>
  
  </div>
  <div class="col-xs-6 col-sm-4 col-md-3">
    <div class="ah1" style="margin:0 0 10px 0;">
      <div id="dvPreview" >{if $store.id > 0 and $store.logo != ''}<img src="{$config.url}/uploads/store/{$store.logo}" >{else}<img src="{$config.url}/images/no_imf.png" >{/if}</div>
      <div class="preview_name"></div>
      <div class="text-danger">{$pharse.to_get_better_logo,its_size_should_be_145px*180px}</div>
      <div>
        <input name="store_image" class="input file-upload" type="file" style="opacity:0">
        <button type="button" class="btn btn-default" onclick="triggerfile()">{$pharse.upload_logo}</button>
      </div>
    </div>
    <div class="ah3">
      <div id="dvPreview" >{if $store.id > 0 and $store.banner != ''}<img src="{$config.url}/uploads/store/{$store.banner}" >{else}<img src="{$config.url}/images/no_imf.png" >{/if}</div>
      <div class="preview_name"></div>
      <div class="text-danger">{$pharse.to_get_better_banner,its_size_should_be_1078px*180px}</div>
      <div style="margin-left: 24px;">
        <input name="store_banner_image" class="input file-upload" type="file" style="opacity:0">
        <button type="button" class="btn btn-default" onclick="triggerfile2()">{$pharse.upload_banner}</button>
      </div>
    </div>
  </div>
  
</div>
