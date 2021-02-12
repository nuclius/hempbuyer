{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
 <link rel="stylesheet" href="{$config.url}/css/mystyle.css" />

<!-- Page content -->

    <div class="container-fluid bgBannerFluid">
        <h1>Direct Buy Market</h1>
            {include file="common/common_navigation.tpl" nocache}
    </div>


    <div class="container storesCon m50 m-b-0">
<input type="hidden" class="hidpage" id="hidpage" value="">
      <!-- Search field -->
      <div class="row flex">
          <div class="col-md-3 margin-auto">
            <!-- <form action="{$config.url}/directbuy" method="post"> -->
              <input class="w80 p5-15 border1 input-radius search-input" placeholder="Search" type="text" name="name" value="{$name}" class="sname" id="sname">
              <button type="button" name="button" class="input-radius green-b b search-btn" onclick="dbtext();">
                  <i class="fa fa-search white" aria-hidden="true"></i>
              </button>
              <!-- </form> -->
          </div>
          <!-- {if $ads_page_show == 1}
            <a class="btn btn-success" href="{$config.url}/stores/current_campaigns/"><img src="{$config.url}/images/ads.png" alt="">Advertising</a>
        {/if} -->
      </div><!-- Search field -->

        <!-- Stores -->
        <div id="ajaxdbbuy"></div>

    </div>



    <div class="container-fluid  p0 m-b-0 m50 m-b-0 storesCon">
      <!-- <div class="stores-row" style="padding-bottom: 25px;">
              <h2 class="m30 m-t-0"><a href="{$config.url}/directbuy/virtualmall">Virtual Mall</a></h2>
      </div> -->


      <!-- Advertise slider  -->


      <div class="owl-carousel owl-theme" id="adOwl">
         {foreach $product_carousol as $key => $val}
        <div class="item pos-rel" data-merge="1">
          <img src="{$config.url}/uploads/ad_image/{$val.banner}" class="img-responsive" alt="">
          <div class="black-panel">
            <button  onclick="goto_ads({$val.id})" class="btn btn-default slider-btn" type="button" name="button">Shop Now  <i class="fa fa-angle-right icon" aria-hidden="true"></i></button>
          </div>
        </div>
        {/foreach}
    </div>

    </div>

    <div class="container-fluid trending-fluid" id="trending-id">
        <div class="container trending-con" >
            <div class="row">

                <div class="col-sm-4 col-xs-12 text-center trendind-col">
                    <div class="clearfix">
                        <div class="col-md-12 trending-caption green-b">
                            <h3><span class="icon"><img src="{$config.url}/images/movers.png" class="img-responsive" alt=""></span> Top Movers ( Last Month ) </h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                        <div class="white-bg style-1c">
                            <table class="table">
                                <tbody class="trending-body">
                                   {foreach $top_movers as $key => $val}
                                    <tr>
                                        <td><span class="sr-number">{$key+1} -  </span> {$val.name}</td>
                                        <td> <span class="percentage-change green-text">Percentage Change :</span> <i class="mov">{if $val.scount2==0}0{/if}{if $val.scount!=0}{(($val.scount*100) / $val.scount2)}{/if}</i> % </td>
                                    </tr>
                                    {/foreach}

                                </tbody>
                            </table>
                        </div>
                        </div>
                    </div>
                </div>

                 <div class="col-sm-4 col-xs-12 text-center trendind-col">
                    <div class="clearfix">
                        <div class="col-md-12 trending-caption green-b">
                            <h3><span class="icon"><img src="{$config.url}/images/sellers.png" class="img-responsive" alt=""></span> Top Sellers ( Last Month ) </h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12  ">
                        <div class="white-bg style-1c">
                            <table class="table">
                                <tbody class="trending-body">

                                  {foreach $top_sellers as $key => $val}
                                    <tr>
                                        <td><span class="sr-number">{$key+1} -  </span> {$val.name}</td>
                                        <td> <span class="percentage-change green-text">Unit Sold :</span> {$val.scount}</td>
                                    </tr>
                                    {/foreach}


                                </tbody>
                            </table>
                        </div>
                        </div>
                    </div>
                </div>


                 <div class="col-sm-4 col-xs-12 text-center trendind-col">
                    <div class="clearfix">
                        <div class="col-md-12 trending-caption green-b">
                            <h3><span class="icon"><img src="{$config.url}/images/trending.png" class="img-responsive" alt=""></span> Trending ( Last Month ) </h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12  ">
                        <div class="white-bg style-1c">
                            <table class="table">
                                <tbody class="trending-body">
                                  {foreach $trending as $key => $val}
                                    <tr>
                                        <td><span class="sr-number">{$key+1} -  </span> {$val.name}</td>
                                        <td> <span class="percentage-change green-text">Views</span> {$val.views}</td>
                                    </tr>
                                      {/foreach}


                                </tbody>
                            </table>
                        </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


<!--/ Page content -->

{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}
<script type="text/javascript">
  $(document).ready(function(){
    // setInterval(function(){   ajaxCall(); }, 12000);         
});

 function ajaxCall(){
 //console.log('running ajax');
  var hipage = $('.hidpage').val();
  var pageajax = Number(hipage) + Number(1);
  //alert(pageajax);

  if(pageajax == 5){
    pageajax = 1;
  }
  $('#hidpage').val(pageajax);
   $.ajax({
      type : 'POST',
      dataType : 'json',
      url : '/dbuystore',
      data : 'page='+pageajax,
      cache:false,
      async:false,
      success : function(data) {
        $('#ajaxdbbuy').html(data.html);
     $('span.stars').stars();
        //$('.hidpage').val(1);
        var owl = $('#feature-brands');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })
            var owl = $('#feature-accessories');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })


      }
    });
//alert("sdf");
 }
 function dbtext(){
var sname = $('#sname').val();
  $.ajax({
      type : 'POST',
      dataType : 'json',
      url : '/dbuystore',
      data : 'name='+sname,
      cache:false,
      async:false,
      success : function(data) {
        $('#ajaxdbbuy').html(data.html);
        $('.hidpage').val(1);
        var owl = $('#feature-brands');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })
            var owl = $('#feature-accessories');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })


      }
    });


 }
$(document).ready(function(){

    $.ajax({
      type : 'POST',
      dataType : 'json',
      url : '/dbuystore',
      data : 'ajax=1',
      cache:false,
      async:false,
      success : function(data) {
        $('#ajaxdbbuy').html(data.html);
        $('.hidpage').val(1);
        $('span.stars').stars();
        var owl = $('#feature-brands');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })
            var owl = $('#feature-accessories');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })


      }
    });

});
$(document).ready(function(){
     $('#fstore').owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
  $(document).ready(function(){
    $('#adOwl').owlCarousel({
    autoplay:true,
    items:5,
    loop:true,
    margin:0,
    merge:true,
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
            items:5,
        }
  }
});

  });
</script>
<script type="text/javascript">
    $(document).ready(function(){
        // $('#feature-brands').owlCarousel();


            var owl = $('#feature-brands');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })


    });
</script>

<script type="text/javascript">
    $(document).ready(function(){
        // $('#feature-accessories').owlCarousel();


            var owl = $('#feature-accessories');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true,
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
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })


    });
    $(function(){
    $('.mov').each(function()
    {

      $(this).html(format(parseFloat($(this).html()).toFixed(2),''));

    });
  })
  function format(n, currency) {

  var parts = n.toString().split(".");
    parts[0] = Number(parts[0]).toLocaleString('en');
  return parts[0]+'.'+parts[1];
}

$('span.stars').stars();

</script>
