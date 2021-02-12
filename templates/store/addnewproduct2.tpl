{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<script>
    $('.dropdown').hover(function () {
        $('.dropdown-toggle', this).trigger('click');
    });
    $(function() {
        $('.main_wrapper').each(function(){
            $(this).prev().remove();
            $(this).attr('class','');
            $(this).children().attr('class','');
        });
    });
</script>
<style type="text/css">
    .pad-left-right-0px {
        padding-left: 0px !important;
        padding-right: 0px !important;
    }
</style>
<style>
    .navigation22 ul li.active > ul {
        visibility: visible !important;
    }

    @media screen and (max-width:990px) {
        .navigation22 ul li.active > ul {
            visibility: hidden !important;
        }
    }
</style>
<!-- store section design -->
<div class="container-fluid store-head add-prdt add-prdt2">
    <div class="container">
        <div class="col-md-12">
            <div class="col-md-12 con">
                 <div class="col-sm-3 padboth1 padrig">
                    <div class="col-sm-12 padboth1 padtop">
                    <input type="text" class="form-control pro_title" placeholder="Title">
                    </div>
                     <div class="col-sm-12 img-wrap">
                         <img src="https://auctionsoftwaremarketplace.com:2002/uploads/product/no_imf.png" alt="No images" class="img-responsive"> <span class="btn btn-default btn-file">
                        Add Profile <input type="file" class='add_profile'>
                         </span>
                     </div>
                    <div class="col-sm-12 ">
                        <button class="btn btn-scom">Delete Product</button>
                    </div>

                     <div class="col-sm-12 ">
                    <button class="btn btn-scom">Upload Product</button> <br/>
                           <button class="btn btn-scom">Upload Serial Number File (.csv)</button>
                    </div>


                    <div class="col-sm-12 padboth5">
                    <div class="s-txt rd-txt">  Price: ($) </div> <input type="text" class="form-control s-input">
                    </div>
                        <div class="col-sm-12 padboth5">
                    <div class="s-txt rd-txt"> Commission: (%) </div> <input type="text" class="form-control s-input">
                    </div>
                    <div class="col-sm-12 padboth5">
                    <div class="rd-txt"> $0.00 </div>
                    </div>

                     <div class="col-sm-12 ftn600 padboth5">
                         Average Overall Rating:
                    </div>
                     <div class="col-sm-12 padboth5">
                        <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                           <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif"> (0)
                    </div>
                    <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">  Categories:  </div>

                        <select class="form-control s-input pro_category" >
                            {foreach $allcategories as $avl => $val}
                            {if $val.parent_id == 0}
                            <option value="{$val.id}" {if $val.id == $catid}selected='selected'{/if}>{$val.name}</option>
                            {/if}
                            {/foreach}
                    </div>
                     <div class="col-sm-12 padboth5">
                         <div class="s-txt ftn600">  Language:  </div> <select  class="form-control s-input" ><option></option></select>
                    </div>

                    <div class="col-sm-12 ftn600 padboth5">
                        Compatibility
                    </div>
                      <div class="col-sm-12 ftn600 padboth5">
                    <label class="checkbox-inline">
                        <input type="checkbox"  value="windows"> Windows
                          </label><label class="checkbox-inline">
                        <input type="checkbox"  value="mac"> Mac OS X
                          </label>
                          <label class="checkbox-inline">
                        <input type="checkbox"  value="linux"> Linux
                          </label>
                    </div>


                    <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">  Version:  </div> <input type="text" class="form-control s-input">
                    </div>
                    <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">  Publisher:  </div> <input type="text" class="form-control s-input">
                    </div>
                    <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">  Developer:  </div> <input type="text" class="form-control s-input">
                    </div>
                    <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">  Country:  </div>  <select  class="form-control s-input" ><option></option></select>
                    </div>
                    <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">  UPC/EAN Code:  </div> <input type="text" class="form-control s-input">
                    </div>
                    <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">  Copyright:  </div> <input type="text" class="form-control s-input">
                    </div>
                    <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">  Release Date:  </div> <input type="text" class="form-control s-input">
                    </div>
                      <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600"> Preview URL: (youtube or vimeo)  </div>
                            <div class="col-sm-12 padboth5 padlr">
                          <input type="text" class="form-control">
                          </div>
                    </div>
                       <div class="col-sm-12 padboth5">
                    <div class="s-txt ftn600">   File Size: </div>   <div class="s-txt">  0 bytes</div>
                    </div>
                       <div class="col-sm-12 padboth5">
                           <div class="s-txt ftn600">  File Format:    <div class="s-txt"> </div> </div>
                    </div>


                </div>

                 <div class="col-sm-9 padboth1">
                     <div class="col-sm-12 bt-info ">  <div class="btn-group" data-toggle="buttons">
                        <button type="button" class="btn btn-default">Cancel/Revert </button>
                        <button type="button" class="btn btn-default">Save as incomplete</button>
                        <button type="button" class="btn btn-default">Save as complete</button>
                      </div></div>


                    <div class="col-sm-12 img-wrap img-wrap1">
                        <img src="https://auctionsoftwaremarketplace.com:2002/uploads/product/no_imf.png"   class="img-responsive">
                        <span class="btn btn-default btn-file">
                        Add Cover <input type="file" class='cover_img' value=''>
                        </span>
                    </div>

                     <div class="col-sm-12 padboth5">
                     <div class="padboth5 ftn600"> Description  </div>
                         <textarea class="form-control pro_description" rows="3"></textarea>
                     </div>
                     <div class="col-sm-12 padboth5">
                     <div class="padboth5 ftn600"> System Requirements  </div>
                         <textarea class="form-control" rows="3"></textarea>
                     </div>
                     <div class="col-sm-12 padboth5">
                     <div class="padboth5 ftn600"> EULA (End UserLicense Agreement)  </div>
                         <textarea class="form-control" rows="3"></textarea>
                     </div>
                     <div class="col-sm-12 ftn600 padboth1">
                         Serial Keys
                    </div>
                     <div class="col-sm-12 ftn600 fnt16 padboth5">
                        Average Rating:
                    </div>

                      <div class="col-sm-12 padboth5 fnt16">
                        <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_off.gif">
                      <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_off.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_off.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_off.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_off.gif"> (0) Based on 0 ratings
                    </div>

                      <div class="col-sm-12 padboth5">
                        <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                      <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">  <img src="https://auctionsoftwaremarketplace.com:2002/html/images/slide.png"> (0/0)
                    </div>
                     <div class="col-sm-12 padboth5">
                        <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                      <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">  <img src="https://auctionsoftwaremarketplace.com:2002/html/images/slide.png"> (0/0)
                    </div>
                      <div class="col-sm-12 padboth5">
                        <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                      <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">  <img src="https://auctionsoftwaremarketplace.com:2002/html/images/slide.png"> (0/0)
                    </div>
                      <div class="col-sm-12 padboth5">
                        <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                      <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">  <img src="https://auctionsoftwaremarketplace.com:2002/html/images/slide.png"> (0/0)
                    </div>
                     <div class="col-sm-12 padboth5">
                        <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                      <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_full.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">
                         <img src="https://auctionsoftwaremarketplace.com:2002/html/images/star_empty.gif">  <img src="https://auctionsoftwaremarketplace.com:2002/html/images/slide.png"> (0/0)
                    </div>

                     <div class="col-sm-12 padboth1">
                         <textarea class="form-control" rows="4"></textarea>
                     </div>

                     <div class="col-sm-12 padboth5">
                         <button class="btn btn-scom pull-right">Report Item</button>
                     </div>

                          <div class="col-sm-12 padboth5">
                         <button class="btn green_btn">View 0 Comments</button>
                     </div>




                </div>


            </div>
        </div>
    </div>
</div>
{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
