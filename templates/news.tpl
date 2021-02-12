<style type="text/css">
  .feedEkList li {
    border-bottom: 1px solid #d3cad7;
    padding: 5px;
}
.itemDate {
    color: #aaaaaa;
    font-size: 11px;
}
.itemTitle{
 color:  #377522;
 cursor: pointer;
}
.itedes {
    height: 400px;
    overflow-y: auto;
}
</style>
{include file="common/header-1.tpl" nocache}
<!-- Page content -->

    <div class="container-fluid bgBannerFluid">
        <h1>News</h1>
            <div class="row">
              <div class="col-sm-12 confLinkCol">





                  <ul class="">



                   <a href="{$config.url}/market/selection"><li>
                     <!-- <span class="icon flaticon-auction"></span> -->
                     <i class="fa fa-home" aria-hidden="true"></i>
                     Welcome Page</li></a>
                     {if $loged.storeid > 0}  <a href="{$config.url}/product/post/{$loged.storeid}"><li><i class="flaticon-business"></i>Post an item</li></a> {/if}
                        {if $loged.storeid == 0}  <a href="{$config.url}/stores/create"><li><i class="flaticon-business"></i>Create New Store</li></a> {/if}

                     <a href="{$config.url}/dashboard/relationship/inbox"><li>
                       <!-- <span class="icon flaticon-auction"></span> -->
                       <i class="fa fa-thumbs-up" aria-hidden="true"></i>
                       Relationships</li></a>

                     <a href="#"><li><span class="icon flaticon-research-work"></span>Research</li></a>

                     <li style="position:relative">
                       <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"><i class="flaticon-settings"></i>Settings
                       <span class="caret"></span></button>
                       <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">

                       <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/profile_settings">Profile</a></li>
                       <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Messages</a></li>
                       <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Payments</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Contact information</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/dashboard/password">Password changes</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="{$config.url}/profile_settings/shipping">Shipping address changes</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Billing and Account information</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Notifications</a></li>
                        <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Open Bid Market</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Direct Buy Market</a></li> -->

                       </ul>
                     </li>

                    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">

                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Profile</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Membership</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Payments</a></li>
                     <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Open Bid Market</a></li>
                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Direct Buy Market</a></li> -->

                    </ul>

                  </ul>
              </div>
            </div>
    </div>


    <div class="container" style="margin:50px auto;">

      <div class="row">
        <div class="col-md-12">
          <ul class="nav nav-pills">
            <li class="active"><a data-toggle="pill" href="#home">Cannabis Business Executive</a></li>
            <li><a data-toggle="pill" href="#menu2">Marijuana Business Daily</a></li>

          </ul>
        </div>
      </div>
  <div class="row">
    <div class="col-md-12">
      <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
          <div class="border1 p15">
          <div class="row">
            <div class="col-md-12 rss-col">
                {foreach $news as $key => $val}
                <div class="col-md-12">
                    <div id="divRss"><ul class="feedEkList">
                    <li>
                    <div class="itemTitle"><a class="w100" href="#viewMessage" data-toggle="modal" data-target="#viewMessage"  data-record-title="{$val.title}" data-record-mess='{$val.content|strip_tags}'>{$val.title}</a></div><div class="itemDate">{$val.published}</div>
                    <div class="itemContent">{$val.content|strip_tags}</div>
                    </li>
                    </div>
                </div>
                 {/foreach}
            </div>
          </div>
              </div>
        </div>

        <div id="menu2" class="tab-pane fade">

          <div class="border1 p15">
            <div class="row">
            <div class="col-md-12 rss-col">
                {foreach $news2 as $key => $val}
                <div class="col-md-12">
                    <div id="divRss"><ul class="feedEkList">
                    <li>
                    <div class="itemTitle"><a class="w100" href="#viewMessage" data-toggle="modal" data-target="#viewMessage"  data-record-title="{$val.title}" data-record-mess='{$val.content|strip_tags}'>{$val.title}</a></div><div class="itemDate">{$val.published}</div>
                    <div class="itemContent">{$val.content|strip_tags}</div>
                    </li>
                    </div>
                </div>
                 {/foreach}
            </div>
          </div>
          </div>

        </div>

      </div>
    </div>
  </div>


      <!-- <div class="row">

        <div class="col-md-12">
          <h3>Cannabis Business Executive</h3>
          <iframe src="https://www.cannabisbusinessexecutive.com/" width="100%" height="500px"></iframe>
        </div>

      </div>

      <div class="row">
        <div class="col-md-12 m50 ">
          <h3>Marijuana Business Daily</h3>
          <iframe src="https://mjbizdaily.com/" width="100%" height="500px"></iframe>
        </div>
      </div> -->

    </div>



<!--/ Page content -->
{include file="common/footer-1.tpl" nocache}
<div class="container">

  <!-- Modal -->
  <div class="modal fade" id="viewMessage" role="dialog">
    <div class="modal-dialog modal-sm wd50" >

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header p0">

          <div class="panel panel-success border-0">
            <div class="panel-heading green-bg">
                <h3 class="messtt123"></h3>
            </div>
          </div>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-md-offset-1 col-md-10 itedes">
              <p id="rej_msg" class="description mess123">

              </p>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-default btn-d-b green-b m0" type="button" data-dismiss="modal">CLOSE</button>
        </div>
      </div>

    </div>
  </div>

</div>
<script type="text/javascript">
    $(document).ready(function(){

      $('#viewMessage').on('show.bs.modal', function(e) {
            var data = $(e.relatedTarget).data();
             $('.messtt123', this).html(data.recordTitle);
             $('.mess123', this).html(data.recordMess);

        });
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
