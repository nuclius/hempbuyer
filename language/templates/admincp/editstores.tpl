{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <div class="col-md-9 col-sm-8 col-xs-12">
        <style type="text/css">
  #dvPreview
  {
	  width:150px;
	  height:150px;
  }
  #dvPreview img
  {
	  width:150px;
	  height:150px;
  }
  </style>
   <form action="{$config.url}/admincp/stores/update" method="post" enctype="multipart/form-data">
   <input type="hidden" name="sid" value="{$store.id}" />
        <div class="col-md-9">
        <div class="row">
       
          <div class="form-group">
            <label>{$pharse.store_name}</label>
            <input type="text" class="form-control" value="{$store.name}" placeholder="" name="name">
          </div>
          <div class="form-group">
            <label>{$pharse.location}</label>
            <input type="text" class="form-control" value="{$store.location}" placeholder=""  name="location">
          </div>
          <div class="form-group">
            <label> {$pharse.member_since}</label>
            <input type="text" class="form-control" value="{$store.date_started}"  placeholder="" name="date_started">
          </div>
          <div class="form-group">
            <label>{$pharse.company_website}</label>
            <input type="text" class="form-control" value="{$store.website}"  placeholder="" name="website">
          </div>
          <div class="form-group">
            <label> {$pharse.description} </label>
            <textarea class="form-control" rows="3" value="{$store.description}"   name="description">{$store.description}</textarea>
          </div>
          </div>
          </div>
          <div class="col-md-3 ah1">
            <div id="dvPreview" >{if $store.id > 0}<img src="{$config.url}/uploads/store/{$store.logo}" >{else}<img src="{$config.url}/uploads/store/{$store.logo}" >{/if}</div>
            <div class="preview_name"></div>
            <div>
              <input name="store_image" class="input file-upload" type="file" style="opacity:0">
              <button type="button" class="btn btn-default" onclick="triggerfile()">{$pharse.upload}</button>
            </div>
          </div>
          <div class="col-md-12 ai3">
            <div class="col-md-4"></div>
            <div class="col-md-2">
              <button type="submit" class="btn btn-warning" style="width:100%">{$pharse.submit}</button>
            </div>
            <div class="col-md-2">
              <button type="button" class="btn btn-default ai2">{$pharse.cancel}</button>
            </div>
            <div class="col-md-4"></div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- /.row --> 
  
</div>
{include file="/admincp/footer.tpl" nocache} 
<script type="text/javascript">
function triggerfile()
    {
    $("input[type='file']").trigger('click'); 
    }
	function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#imageupload').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
       }
    jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();
    $("input[type='file']").change(function(){
        //$("#dvPreview").html("");
        var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
        if (regex.test($(this).val().toLowerCase())) {
            if ($.browser.msie && parseFloat(jQuery.browser.version) <= 9.0) {
                //$("#dvPreview").show();
                $("#dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();
                 $("#dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").sizingMethod = 'scale';
                $("#dvPreview img").hide();
            }
            else {
                if (typeof (FileReader) != "undefined") {
                    //$("#dvPreview").append("<img />");
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#dvPreview img").attr("src", e.target.result);
                    }
                    reader.readAsDataURL($(this)[0].files[0]);
                } else {
                   
                }
            }
            var filename = $(this).val();
             var k = /C:\\fakepath\\/g;
   var s = filename.split("/").pop().replace(k,'');
            $('.preview_name').html(s);
        } else {
            alert("Please upload a valid image file.");
        }
    });
</script>