{$usercount = 0}
{foreach $listData as $key => $val}
{$usercount = 1}
    <div class="col-sm-6 col-md-4 p-04">
        <div class="media">
            <div class="media-left">
                <img class="card-img-top" src="{$config.url}/uploads/classified/{$val.company_logo}" alt="6-DAY/7-NIGHT">
                <div class="pt-3">
                    <button class="btn btn-brown btn-lg" type="button" onclick="openContactPopup({$val.id})">
                        CONTACT
                    </button>
                </div>
            </div>
            <div class="media-body">
                <h4 class="ctitle">
                    {$val.name}
                    <!-- <a href="#"><i class="fa fa-edit"></i></a>
                    <a href="#"><i class="fa fa-trash"></i></a> -->
                </h4>
                <p class="mb-1 sp-txt"> {$val.title}</p>
                
                <p class="mb-1 tc-txt cf-descp"> {$val.short_description}</p>
                {if $val.is_special}
                <div class="clearfix upcoming">Hempbuyer Special Promo Listing</div>
                {/if}
            </div>
            <a href="#" class="vfcd-txt" data-toggle="modal" data-target="#vf-descp" onclick="viewClasifiedDetail('{$val.name}', '{$val.title}', '{$val.images}', '{$val.company_logo}', '{$val.description}', '{$val.website}', '{$val.city}', '{$val.state}')">VIEW FULL CLASSFIED DESCRIPTION</a>
        </div>
    </div>
{/foreach}
{if $usercount == 0}
        No Classifieds Found !
{/if}

<div id="pagination_html" data-total-record="{$totalData}" style="width:100%;"></div>

<script>
    paginationData.totalRecord = +'{$totalData}';
    paginationData.url = '/classifieds/all';
    paginationData.html_div = "list_div";
    paginationData.form_name = "classifieds_form";
$(document).ready(function(){

});
</script>