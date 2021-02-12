<script type="text/javascript">
function triggerfile()
    {
       //console.log("sdfsfs");
    $(".ah1 input[type='file']").trigger('click');
    }
	function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.ah1 #imageupload2').attr('src', e.target.result);
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
    $(".weww").change(function(){
       //console.log("chage");
        //$("#dvPreview").html("");
        var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
        if (regex.test($(this).val().toLowerCase())) {
            if ($.browser.msie && parseFloat(jQuery.browser.version) <= 9.0) {
                //$("#dvPreview").show();
                $(".ah1 #dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();
                 $(".ah1 #dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").sizingMethod = 'scale';
                $(".ah1 #dvPreview img").hide();
            }
            else {
                if (typeof (FileReader) != "undefined") {
                    //$("#dvPreview").append("<img />");
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(".ah1 #dvPreview img").attr("src", e.target.result);
                        console.log('$( #store_image )[0].files[0]', $( '#store_image' )[0].files[0]);
                        var myFormData = new FormData();
                         myFormData.append( 'store_image', $( '#store_image' )[0].files[0] );
                         myFormData.append( 'storeid', $('#storeid').val() );
                         $.ajax({
                            url: '/stores/storelogo',
                            data: myFormData,
                            type: 'POST',
                            contentType: false,
                            processData: false,
                        });

                    }
                    reader.readAsDataURL($(this)[0].files[0]);
                } else {

                }
            }
            var filename = $(this).val();
             var k = /C:\\fakepath\\/g;
   var s = filename.split("/").pop().replace(k,'');
            $('.ah1 .preview_name').html(s);
        } else {
            alert("Please upload a valid image file.");
        }
    });

    $("body").on('change', ".ah3 input[type='file']", function() {
        var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
        if (regex.test($(this).val().toLowerCase())) {
            if ($.browser.msie && parseFloat(jQuery.browser.version) <= 9.0) {
                $("#dvPreview2")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();
                 $("#dvPreview2")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").sizingMethod = 'scale';
                $("#dvPreview2 img").hide();
            }
            else {
                if(typeof (FileReader) != "undefined") {
                    var reader2 = new FileReader();
                    reader2.onload = function (e) {
                        // var image = new Image();
                        //Set the Base64 string return from FileReader as source.
                        // image.src    = e.target.result;
                        // image.onload = function () {
                            // var height  = this.height;
                            // var width   = this.width;
                            // if (height != 180 || width != 1078) {
                                // if($('#storeid').val() == undefined || $('#storeid').val() <= 0) {
                                    // $('.ah3 span').html($('.ah3 span').html());
                                // }
                                // alert("Please upload 1078x180 dimension image only.");
                                // return false;
                            // } else {
                                $(".banimg").attr("src", e.target.result);
                                 var myFormData = new FormData();
                                 myFormData.append( 'store_banner_image', $('#store_banner_image')[0].files[0] );
                                 myFormData.append( 'storeid', $('#storeid').val());
                                 $.ajax({
                                    url: '/stores/storebanner',
                                    data: myFormData,
                                    type: 'POST',
                                    contentType: false,
                                    processData: false,
                                    success:function(data)
                                    {
                                        $('.bannerli').show();
                                        if($('#storeid').val() != undefined && $('#storeid').val() > 0) {
                                            location.reload();
                                        }
                                    }
                                });
                                if($('#storeid').val() == undefined || $('#storeid').val() <= 0) {
                                    var filename = $('#store_banner_image').val();
                                    var k = /C:\\fakepath\\/g;
                                    var s = filename.split("/").pop().replace(k,'');
                                    $('.ah3 .preview_name').html(s);
                                    document.getElementById('preview2').src = window.URL.createObjectURL($('#store_banner_image')[0].files[0]);
                                }
                            // }
                        // }
                    }
                    reader2.readAsDataURL($(this)[0].files[0]);
                } else {

                }
            }

        } else {
            alert("Please upload a valid banner image file.");
        }
    });
    function triggerfile2()
    {
        $(".bannerdrop").toggle();
        $(".ah3 input[type='file']").trigger('click');
    }
    function readURL2(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.ah3 #imageupload').attr('src', e.target.result);
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

	$(function()
	{
		Date.format = 'mm/dd/yyyy';
		$("#date_started").datetimepicker({
		 formatDate:'mm/dd/yyyy'
	    });
	});
</script>

 <script src="{$config.url}/js/jquery.datePicker.js"  type="text/javascript"></script>
  <script src="{$config.url}/js/jquery.datetimepicker.js"  type="text/javascript"></script>
