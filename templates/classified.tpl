{include file="/common/header-1.tpl" nocache}
<style> 
    .spl-wrap .media {
    margin-bottom: 35px;
    font-family: "Segoe UI";
    font-weight: normal;
    font-size: 12px;
    line-height: 17px;
    text-align: left;
    color: #212121;
    width: 100%;
    padding:20px 10px 25px;
    border-radius: 5px;
    background: #fff;
    border: 1px solid #fff;
    box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.16);
    position: relative;
    height:168px;
}

.search-content-wrap .sf-menu.cf-menu {
    width: 225px;
    margin: 0 25px 30px 0;
}

.spl-wrap .media-left {
    margin-right: 12px;
}

.spl-wrap .media-left .card-img-top {
    width: 75px;
    height: 75px;
    border-radius: 50%;
}

.spl-wrap .media-left .btn-brown {
    width:75px;
    padding:5px;
    font-size:12px;
}

.ctitle {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 5px;
}

.cf-descp {
    max-height: 52px;
    overflow: hidden;
    text-overflow: ellipsis;
}

.vfcd-txt,
.vfcd-txt:focus,
.vfcd-txt:hover {
    position: absolute;
    bottom:28px;
    font-size: 12px;
    display: inline-block;
    right: 0; 
    margin: auto;
    padding: 0 5px;
    text-align: center;
    color: #5e9836;
    font-weight:600;
    text-decoration:none;
}

.search-content-wrap .media .upcoming {
    width:200px;
    height: 28px;
    padding: 5px;
    background: #DBAB1A;
    border: 1px solid #DBAB1A;
    position: absolute;
    font-weight: bold;
    font-size:10px;
    line-height: 15px;
    text-align: center;
    color: #fff;
    text-transform: uppercase;
    top: -14px;
    right: 5px;
    letter-spacing:0.5px;
}

.media .upcoming:after {
    width: 0;
    height: 0;
    border-top: 7px solid transparent;
    border-left: 7px solid transparent;
    border-bottom: 7px solid #DBAB1A;
    border-right: 7px solid #DBAB1A;
    position: absolute;
    top: -2px;
    left: -14px;
}

.ctitle a {
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    color: #5E9836;
    float: right;
    padding: 2px 5px;
    margin-left: 2px;
}

.cf-links a {
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    color: #5E9836; 
    padding:2px 0; 
    text-decoration:none;
    font-weight:600;
}

.cf-links a.cc-link {
    color:#DBAB1A
}

.cf-links .col-md-4 {
    padding:0 6px;
}

a.cc-link .fa {
    display:inline-block;
    padding:4px 5px;
    border:1px solid #DBAB1A;
    border-radius:50%;
    width:24px;
    height:24px;
    line-height:1;
    cursor:pointer;
    margin-right:5px;
    vertical-align:middle;
}

.cmedia {
    width: 100%;
    text-align: left;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
}

.cmedia .btn-brown {
    font-size: 12px;
    width: 90px;
    padding: 5px;
}

.cmedia .card-img-top {
    width:60px;
    height:60px;
    border-radius:50%;
    margin-right:12px;
}

.cmedia .media {
    flex:1;
}

.cmedia .media p {
    font-size:14px;
}

.cf-imgs img {
    width:180px;
    height:180px;
    object-fit:cover;
    object-position:center;
}

.cf-imgs-wrap {
    justify-content:center;
    align-items:center;
}

.cf-imgs-wrap > div {
    padding:0 10px;
}

.cfd-wrap .ppf-title {
    margin-bottom:15px;
}

.btn-primary:not(:disabled):not(.disabled).active, 
.btn-primary:not(:disabled):not(.disabled):active, 
.show>.btn-primary.dropdown-toggle {
    color: #5e9836 !important;
    background: #fff;
    border: 1px solid #5e9836 !important;
}
 
#vf-descp .modal-dialog {
    top:2% !important;
}

.icon-input .icon-box img.globe-img { 
    max-height: 25px;
}



.btn-primary:not(:disabled):not(.disabled).active, 
.btn-primary:not(:disabled):not(.disabled):active, 
.show>.btn-primary.dropdown-toggle {
    color: #5e9836 !important;
    background: #fff;
    border: 1px solid #5e9836 !important;
}

.cfd-wrap .btn {
    line-height: 16px;
}

#vf-descp .modal-dialog {
    top:2% !important;
}
 
@media(max-width:767px) {
    .cf-imgs-wrap > div {
        padding: 0 5px 15px;
    }

    .cf-imgs img {
        width: 125px;
        height: 125px; 
    } 
    .search-content-wrap .sf-menu.cf-menu {
        width:100%;
    }
}
@media(min-width:576px) and (max-width:767px) {
    .vfcd-txt, .vfcd-txt:focus, .vfcd-txt:hover {
        max-width: calc(100% - 90px);
        bottom: 18px;
    }
}
</style>

<div class="search-container">
    <div class="container">
        <div class="search-content-wrap clearfix">
            <form action="{$config.url}/searchMarket" method="post" id="classifieds_form">
                <input type="hidden" name="page" id="page" value="1">
                <input type="hidden" name="action" id="action" value="all">
                <input type="hidden" name="limit" id="limit" value="9">
                <input type="hidden" name="status" id="status" value="active">
                <div class="sf-menu cf-menu" id="accordion">
                    <h4 class="sf-thead">
                        Classifieds Filters
                        <a class="search-fclose"><i class="fa fa-times"></i></a>
                    </h4>
                    <div class="card">
                        <div class="card-header">
                            <a data-toggle="collapse" data-target="#city_collapse">City <i class="fa fa-minus"></i></a>
                        </div>
                        <div class="card-body collapse show" id="city_collapse">
                            <div class="row">
                                <div class="col-10 pr-0 pl-1">
                                    <input class="form-control" placeholder="Search City" id="city" name="city" style="border-radius: 0px;">
                                </div>
                                <div class="col-2" id="searchPrice" style="cursor: pointer; padding: 2px 12px; background: #dbab1a; color: #ffffff; border-radius: 0px 3px 3px 0px; margin-left: -1px;" onclick='searchCity(event)'>
                                    <i class="fa fa-search" style="padding-top: 13px;"></i>
                                </div>
                            </div> 
                        </div> 
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <a data-toggle="collapse" data-target="#category">Category <i class="fa fa-minus"></i></a>
                        </div>
                        <div class="card-body collapse show" id="category" style="max-height: 500px; overflow: auto;">
                            {foreach $categoryList as $key => $val}
                                <div class="cus-check">
                                    <input type="checkbox" name="category" value="'{$val.value}'" />
                                    <span class="checkmark"></span> {$val.text}
                                </div> 
                            {/foreach}
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <a data-toggle="collapse" data-target="#location">Location <i class="fa fa-minus"></i></a>
                        </div>
                        <div class="card-body collapse show" id="location" style="max-height: 500px; overflow: auto;">
                            {foreach $stateList as $key => $val}
                                <div class="cus-check">
                                    <input type="checkbox" name="state" value="'{$val.abbrev}'" />
                                    <span class="checkmark"></span> {$val.name}
                                </div> 
                            {/foreach}
                        </div>
                    </div>
                
                </div>
            </form>
            <div class="spl-wrap">
                <div class="row mb-4 cf-links">
                    <div class="col-sm-6 col-md-4 form-group">
                        <a href="">CLASSIFIED FAQ</a>
                    </div>
                    <div class="col-sm-6 col-md-4 text-center form-group">
                        <a class="cc-link" href="/classified/add"><i class="fa fa-plus"></i> CREATE YOUR CLASSIFIED LISTING</a>
                    </div>
                    <div class="col-sm-6 col-md-4 d-lg-none">
                        <a class="search-filter"><i class="fa fa-filter"></i> Filter</a>
                    </div>
                </div>
                <div class="row pt-2" id="list_div">
                    {foreach $data as $key => $val}
                    <div class="col-sm-6 col-md-4">
                        <div class="media">
                            <div class="media-left">
                                <img class="card-img-top" src="{$config.url}/uploads/classified/{$val.company_logo}" alt="6-DAY/7-NIGHT">
                                <div class="pt-3">
                                    <button class="btn btn-brown btn-lg" type="button">
                                        CONTACT
                                    </button>
                                </div>
                            </div>
                            <div class="media-body">
                                <h4 class="ctitle">
                                    {$val.name} 
                                </h4>
                                <p class="mb-1 sp-txt"> {$val.title}</p>
                                
                                <p class="mb-1 tc-txt cf-descp"> {$val.short_description}</p>
                                {if $val.is_special}
                                <div class="clearfix upcoming">Hempbuyer Special Promo Listing</div>
                                {/if}
                            </div>
                            <a href="#" class="vfcd-txt" data-toggle="modal" data-target="#vf-descp" onclick="viewClasifiedDetail('{$val.name}', '{$val.title}', '{$val.images}', '{$val.company_logo}', '{$val.description}', '{$val.website}', '{$val.city}', '{$val.state}', '{$val.id}')">VIEW FULL CLASSFIED DESCRIPTION</a>
                        </div>
                    </div>
                    {/foreach}
                
                </div> 
            </div>
        </div>
    </div>
</div>
<div class="modal fade hb-modal" id="vf-descp">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title cmedia">
                    <div class="media">
                        <div class="media-left">
                            <img class="card-img-top" id="cl_company_logo2" src="./images/pro1.png" />
                            <!-- <img class="card-img-top" src="./images/pro1.png" /> -->
                        </div>
                        <div class="media-body">
                            <h4 class="ctitle" id="cl_company_name">Company Name</h4>
                            <p id="cl_city_state" class="float-left">Denver, CO</p>
                        </div>
                    </div>
                    <div class="mlf-72">
                        <a class="btn btn-brown btn-lg" href="" target="_blank" id="cl_website_link">
                            VIEW WEBSITE
                        </a> 
                    </div>
                </div>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="    padding-top: 3px;">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body cfd-wrap">
                <h3 class="ppf-title" id="cl_title">Classified Title</h3>
                <div class="mb-3 clearfix text-center">
                    <img id="cl_banner" src="images/banner.jpg" alt="" class="rounded img-fluid" />
                </div>
                <div id="cl_description" style="margin-bottom: 10px;">
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magnam doloribus nostrum quos facilis, illo consequuntur odio eaque delectus ipsam tempora totam maxime hic, atque perferendis sunt, laborum ullam alias rem.</p>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magnam doloribus nostrum quos facilis, illo consequuntur odio eaque delectus ipsam tempora totam maxime hic, atque perferendis sunt, laborum ullam alias rem.</p>
                </div>
                <div class="d-flex cf-imgs-wrap" id="cl_images">
                    <div class="cf-imgs">
                        <img src="images/pro1.png" alt="" class="rounded img-fluid" />
                    </div>
                    <div class="cf-imgs">
                        <img src="images/pro-pic.png" alt="" class="rounded img-fluid" />
                    </div>
                </div>
                <div class="pp-btns-wrap">
                    <a class="btn btn-primary" href="javascript:void(0)" onclick="openContactPopup1()">CONTACT</a>
                     {* data-toggle="modal" data-target="#cf-contact" *}
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade hb-modal" id="cf-contact">
    <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="    padding-top: 3px;">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body cfd-wrap">
                <h4 class="text-center" id="cl_company_name">Contact</h4>
                <form class="pp-form" id="contact_form" name="contact_form" method="POST"  data-parsley-validate novalidate>
                    <div class="row">
                        <div class="col-12 form-group">
                            <label class="sf-label">Full Name</label>
                            <div class="clearfix">
                                <input class="form-control" placeholder="Full Name" id="full_name" name="full_name" required data-parsley-trigger="change focusout" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 form-group">
                            <label class="sf-label">Email</label>
                            <div class="clearfix">
                                <input class="form-control" placeholder="Email" id="email" name="email" type="email" required data-parsley-trigger="change focusout" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 form-group">
                            <label class="sf-label">Message</label>
                            <div class="clearfix">
                                <textarea class="form-control" placeholder="Message" id="message" name="message" required data-parsley-trigger="change focusout"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 form-group">
                            <div class="clearfix">
                                <button type="submit" class="btn btn-brown float-right">Send</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
 
{include file="/common/footer-1.tpl" nocache}
<script>
    var config_url = '{$config.url}';
    paginationData.recordPerPage = $("#limit").val();
    $(document).ready(function() {
        $('#classifieds_form input[type="checkbox"]').on('click', function() {
            searchForm();
        });
        $(document).on('submit', '#classifieds_form', function(e) {
            e.preventDefault();
            searchForm();
        });        
        $(document).on('submit', '#contact_form', function(e) {
            e.preventDefault();
            var formArray = $("#contact_form").serializeArray();
            var Obj = {};
            var productData = formArray ? formArray : [];
            if(productData.length) {
                for (var index = 0; index < productData.length; index++) {
                    const element = productData[index];
                    Obj[productData[index].name] = productData[index].value;
                }
            }
            Obj['id'] = classified_id;
            console.log('Obj', Obj);
            
            $.ajax({
                type: 'POST',
                url: '/classified/contact_seller',
                data: Obj,
                // dataType: 'json',
                success: function(data) {
                    $("#cf-contact").modal('hide');
                    swal("SUCCESS", "Contact details sent");
                    $("#full_name").val("");
                    $("#email").val("");
                    $("#message").val("");
                }
            });
        });
        
        searchForm();
    });
    function searchCity(e) {
        searchForm();
    }

    function searchForm() {
        $("#page").val(1);
        paginationData.currentPage = 1;
        var formArray = $("#classifieds_form").serializeArray();
        var Obj = {};
        var productData = formArray ? formArray : [];
        if(productData.length) {
            for (var index = 0; index < productData.length; index++) {
                const element = productData[index];
                Obj[productData[index].name] = productData[index].value;
            }
        }
        var Obj = $('#classifieds_form').serialize();
        console.log('Obj', Obj);
        
        $.ajax({
            type: 'POST',
            url: '/classifieds/all',
            data: Obj,
            // dataType: 'json',
            success: function(data) {
                // console.log('data', data);
                $("#list_div").html(data);
                console.log('paginationData1111', paginationData);
                console.log('pagination(paginationData)', pagination(paginationData));
                $("#pagination_html").html(pagination(paginationData));
            }
        });
    }

    var classified_id = '';
    function openDetailPopup(id) {
        classified_id = id;
    }
    function openContactPopup(id) {
        classified_id = id;
        $("#vf-descp").modal('hide');
        $("#full_name").val("");
        $("#email").val("");
        $("#message").val("");
        $("#cf-contact").modal();
    }
    function openContactPopup1() {
        $("#vf-descp").modal('hide');
        $(".modal-backdrop").remove();
        $("#full_name").val("");
        $("#email").val("");
        $("#message").val("");
        
        setTimeout(function() {
            $("#cf-contact").modal();
        }, 500);
    }
    
    function viewClasifiedDetail(name, title, images, company_logo, description, cl_website_link, city, state, id) {
        classified_id = id;
        console.log('name, title, images, description', name, title, images, description);
        images = images.split(',');
        $("#cl_company_name").html(name);
        $("#cl_title").html(title);
        $("#cl_description").html(description);
        $("#cl_website_link").attr('href', cl_website_link);
        $("#cl_city_state").html(city+', '+state);
        $("#cl_company_logo2").attr('src', config_url+`/uploads/classified/`+company_logo);
        // $("#cl_banner").attr('src', config_url+`/uploads/classified/`+company_logo);
        $("#cl_banner").attr('src', config_url+`/uploads/classified/`+images[0]);
        
        var html = '';
        for (var index = 0; index < images.length; index++) {
            html += `<div class="cf-imgs">
                <img src="`+config_url+`/uploads/classified/`+images[index]+`" alt="" class="rounded img-fluid">
                </div>`;
        }
        $("#cl_images").html(html);
    }

    $('.search-filter, .search-fclose').click(function(){
          $('body').toggleClass('ss-filter');
      });

</script>