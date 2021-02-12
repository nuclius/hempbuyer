{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}


<!-- Page content -->
<div class="container-fluid bgBannerFluid">
    <h1>{$heading_common}</h1> {include file="common/common_navigation.tpl" nocache}
</div>
           <!-- Stores -->

        <div class="container storesCon m50 m-b-0">

      <ol class="breadcrumb">
      <li><a class="grey-text" href="{$config.url}/directbuy">Direct Buy Market</a></li>
      <li><a >Featured Suppliers</a></li>
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
          <div  id="feature-supplier1">
            <div class="row stores-row m35" id="feature-supplier">

                <!-- <p>Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus elit.</p> -->
                {foreach $featured_store as $key => $val}
                <div class="col-md-3  col-sm-6 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                           <div class="image-setup"> 
                              {if $val.existing_img != ''}
                              <img class="" src="{$config.url}/uploads/store/{$val.existing_img}" alt="" class="img responsive">
                              {/if}
                              {if $val.banner != ''}
                              <img class="" src="{$config.url}/uploads/ad_image/{$val.banner}" alt="" class="img responsive">
                              {/if}
                           </div>
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>{$val.ad_name}</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                               {$val.ad_content}
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <div class="rating text-center">
                                <!-- <a href="#"> -->
                                  Store's Ratings
                                    <span class="stars" align="center">{$val.store_rating}</span>
                                    <!-- <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span> -->
                                <!-- </a> -->
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button  onclick="window.location.href='{$config.url}/stores/view/{$val.store_id}'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
              {/foreach}
            </div>
             {$pagination_html}

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
                url  : '/featuredSupplierajax',
                data : request,
                dataType : 'json',
                success  : function(data)
                {

                $('#feature-supplier1').html(data.html);

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
