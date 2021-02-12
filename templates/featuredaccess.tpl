{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}

{include file="common/dashboard-navigation.tpl" nocache}



<!-- Page content -->

           <!-- Stores -->

        <div class="container storesCon m50 m-b-0">

      <ol class="breadcrumb">
      <li><a class="grey-text" href="{$config.url}/directbuy">Direct Buy Market</a></li>
      <li><a>Feature Accessories</a></li>
    </ol>

      <!-- Search field -->
      <div class="row flex">
          <div class="col-md-3 margin-auto">
              <input class="w80 p5-15 border1 input-radius search-input" placeholder="Search" type="text" id="title" name="" value="">
              <button type="button" name="button" class="input-radius green-b b search-btn" onclick="$('#page').val(1);searchForm()">
                  <i class="fa fa-search white" aria-hidden="true"></i>
              </button>
          </div>
      </div><!-- Search field -->

        <!-- Stores -->

        <div class="container-fluid feature-brandsFluid" id="feature-access1">
            <div class="storesCon m50 m-b-0" id="feature-brand">
                <div class="row stores-row">
            <h2 class="m30 m-t-0"><a >Feature Accessories</a></h2>
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
                                              <b class="green-text">{$val.ad_name}</b> <br>
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
                url  : '/featuredaccessajax',
                data : request,
                dataType : 'json',
                success  : function(data)
                {

                $('#feature-access1').html(data.html);
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
</body>
</html>
