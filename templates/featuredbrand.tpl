{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}


<!-- Page content -->

    <div class="container-fluid bgBannerFluid">
        <h1>Featured Stores</h1>
            <div class="row posCode">
                <div class="col-md-12 confLinkCol">
                    <ul>
                      <a href="{$config.url}/market/selection"><li>
                        <!-- <span class="icon flaticon-auction"></span> -->
                        <i class="fa fa-home" aria-hidden="true"></i>
                        Welcome Page</li></a>
                        {if $loged.storeid >0} <a href="{$config.url}/stores/view/{$loged.storeid}"><li><img src="images/manage.png" alt="">Manage Store</li></a>{/if}
                       {if $loged.storeid <= 0} <a href="{$config.url}/stores/create"><li><i class="flaticon-business"></i>Create New Store</li></a>{/if}
                        <a href="{$config.url}/stores/show_adwords"><li><img src="images/ads.png" alt="">Manage Ads</li></a>
                        <a href="#"><li><img src="images/transaction.png" alt="">Recent Sales</li></a>

                        <a href="#"><li><img src="images/reports.png" alt="">Reports</li></a>
                        <li style="position:relative">
                          <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"><i class="flaticon-settings"></i>Settings
                          <span class="caret"></span></button>
                          <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">

                          <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-profile.html">Profile</a></li>
                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Messages</a></li>
                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Payments</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Contact information</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Change Password</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Shipping address changes</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Billing and Account Information</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Notifications</a></li>
                           <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Open Bid Market</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Direct Buy Market</a></li> -->

                          </ul>
                        </li>

                    </ul>
                </div>
            </div>
    </div>


    <div class="container storesCon m50 m-b-0">

      <ol class="breadcrumb">
      <li><a class="grey-text" href="{$config.url}/directbuy">Direct Buy Market</a></li>
      <li><a >Featured Cannabis Brands</a></li>
    </ol>

      <!-- Search field -->
      <div class="row flex">
          <div class="col-md-3 margin-auto">
              <input class="w80 p5-15 border1 input-radius search-input" placeholder="Search" id="title" type="text" name="" value="">
              <button type="button" name="button" class="input-radius green-b b search-btn" onclick="$('#page').val(1);searchForm()">
                  <i class="fa fa-search white" aria-hidden="true"></i>
              </button>
          </div>
      </div><!-- Search field -->

        <!-- Stores -->

        <div class="container-fluid feature-brandsFluid" id="feature-brand1">
            <div class="storesCon m50 m-b-0" id="feature-brand">
                <div class="row stores-row">
            <h2 class="m30 m-t-0"><a>Featured Cannabis Brands</a></h2>
                    <!-- <p>Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus elit.</p> -->
                <div class="col-md-12 ">
                {foreach $featured_store as $key => $val}
                {if $key%4 == 0}
                    <div id="feature-brands" class="owl-carousel owl-theme feature-brands">
                      {/if}
                          <div class="border1 feature-item">

                              <div class="row">
                                  <div class="col-md-12 test">
                                      <div class="row">
                                  <div class="col-md-12">
                                      <div class="product-thumb alter-200">
                                          <img class="img-responsive w100" src="{$config.url}/uploads/ad_image/{$val.banner}" alt="">
                                      </div>
                                  </div>
                                  <div class="col-md-12 text-panel">
                                      <div class="row flex">
                                          <div class="col-md-8">
                                              <b class="green-text">{$val.brand_name}</b> <br>
                                              <span>${$val.price}</span>
                                          </div>
                                          <div class="col-md-4 margin-auto">
                                              <h4 class="fancy-title green-text">Featured</h4>
                                          </div>
                                      </div>

                                      <div class="row">
                                       <div class="col-md-12">
                                        <button class="btn btn-default btn-d black-b" type="button" name="button"  onclick="window.location.href='{$config.url}/stores/view/{$val.store_id}'">VIEW STORE</button>
                                       </div>
                                      </div>

                                  </div>
                              </div>
                                  </div>
                              </div>

                          </div>


                    {if $key%4 == 3}</div>{/if}
                     {/foreach}
                     {if $key%4 < 3}</div>{/if}


                </div>
                 {$pagination_html}
            </div>
            </div>
        </div>
<input name="page" type ="hidden"value ="1" id="page">

    </div>


<!--/ Page content -->





{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}

<script type="text/javascript">

    function  searchForm(p)
    {

            request={

               page:$('#page').val(),
               title:$('#title').val()



            }
            $.ajax({
                type : 'POST',
                url  : '/featuredBrandajax',
                data : request,
                dataType : 'json',
                success  : function(data)
                {

                $('#feature-brand1').html(data.html);
                 var owl = $('.feature-brands');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:false,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
                mouseDrag:false,
                dots:false,
                responsiveClass:true,
                responsive:{
                    0:{
                        items:1,
                    },
                    600:{
                        items:3,
                    },
                    1000:{
                        items:4,
                    }
              }
            });
                }
            });



    }

</script>

<script type="text/javascript">
    $(document).ready(function(){
        // $('.feature-brands').owlCarousel();


            var owl = $('.feature-brands');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:false,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
                mouseDrag:false,
                dots:false,
                responsiveClass:true,
                responsive:{
                    0:{
                        items:1,
                    },
                    600:{
                        items:3,
                    },
                    1000:{
                        items:4,
                    }
              }
            });

    });
</script>
<script>
   AOS.init({
      offset: 200,
      duration: 600,
      easing: 'ease-in-sine',
      delay: 100,
    });
</script>
<script type="text/javascript">
//On scroll call the draw function
$(window).scroll(function() {
drawLines();
});

//If you have more than one SVG per page this will pick it up
function drawLines(){
$.each($("path"), function(i, val){
  var line = val;
  drawLine($(this), line);
});
}

//draw the line
    function drawLine(container, line){
var length = 1;
var pathLength = line.getTotalLength();
var distanceFromTop = container.offset().top - $(window).scrollTop();
var percentDone = 1 - (distanceFromTop / $(window).height());
length = percentDone * pathLength;
line.style.strokeDasharray = [length,pathLength].join(' ');
console.log("strokeDasharray: "+[length,pathLength].join(' '));
}
</script>
</body>
</html>
