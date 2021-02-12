{include file="common/header-1.tpl" nocache}
<!-- page content  -->
{include file="common/dashboard-navigation.tpl" nocache}



    <div class="container-fluid grey-bg p0">

        <div class="page-caption m50">
            <h1>Sent Messages</h1>
        </div>


        <div class="container business-pool-con m20">

          <div class="row store-content-row white-bg shadow p35">
            <div class="col-md-12">

            
              <div class="row">

                <div class="col-md-3 sidebar   mb-25">
  <ol class="breadcrumb bg-transparent p0">
                <li><a class="grey-text" href="{$config.url}/dashboard/relationship/inbox">Inbox</a></li>
                <li><a href="{$config.url}/dashboard/relationship/sent">Sent Message</a></li>
              </ol>

                  <ul class="sidebar-menu">
                          <li>
                              <a class="maincat">
                                  <span class="catcap"><b>Inbox</b></span>
                              </a>
                          </li>

                          <!-- <li> -->
                            <!-- <div class="maincat"> -->
                                <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                              <!-- <a class="" href="active-msg.html"><span>Active Messages</span></a> -->
                              <!-- <i class="fa fa-angle-left pull-right"></i> -->
                            <!-- </div> -->

                          <!-- </li> -->

                        <li>
                          <div class="maincat">
                              <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                            <a class="green-text" href="{$config.url}/dashboard/relationship/sent"><span>Sent Messages</span></a>
                            <!-- <i class="fa fa-angle-left pull-right"></i> -->
                          </div>

                        </li>


                        <!-- <li> -->
                          <!-- <div class="maincat"> -->
                              <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                            <!-- <a class="" href="responded-with-interest.html"><span>Responded with Interest</a> -->
                            <!-- <i class="fa fa-angle-left pull-right"></i> -->
                            <!-- </div> -->

                        <!-- </li> -->

                        <li>
                          <div class="maincat">
                              <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                            <a href="{$config.url}/dashboard/relationship/"><span>Collaborate by Location</a>
                            <!-- <i class="fa fa-angle-left pull-right"></i> -->
                            </div>

                        </li>



                  </ul>

                          <ul class="sidebar-menu">
                                  <li>
                                      <a class="maincat">
                                          <span class="catcap"><b>Collaboration by Type</b></span>
                                      </a>
                                  </li>
                                   {foreach $relationtype as $key => $val} 
                                <li>
                                  <div class="maincat">
                                      <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                                    <a ><span>All <span class="green-text">({$val.Total})</span></span></a>
                                    <!-- <i class="fa fa-angle-left pull-right"></i> -->
                                  </div>

                                </li>

                                <li>
                                  <div class="maincat">
                                      <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                                    <a href="#"><span>Grower <span class="green-text">({$val.grower})</span></a>
                                    <!-- <i class="fa fa-angle-left pull-right"></i> -->
                                    </div>

                                </li>

                                <li>
                                  <div class="maincat">
                                      <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                                    <a href="#"><span>Producer <span class="green-text">({$val.producer})</span></a>
                                    <!-- <i class="fa fa-angle-left pull-right"></i> -->
                                    </div>

                                </li>

                                <li>
                                  <div class="maincat">
                                      <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                                    <a href="#"><span>Dispensary <span class="green-text">({$val.dispensary})</span></a>
                                    <!-- <i class="fa fa-angle-left pull-right"></i> -->
                                    </div>

                                </li>

                                <li>
                                  <div class="maincat">
                                      <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                                    <a href="#"><span>Supplier <span class="green-text">({$val.supplier})</span></a>
                                    <!-- <i class="fa fa-angle-left pull-right"></i> -->
                                    </div>

                                </li>
                                 {/foreach}
                              </ul>

                      </div>

                <div class="col-md-9">

                  <div class="row pdtp20">
                    <div class="col-md-12 text-right  ">
                      <a class="" href="{$config.url}/dashboard/relationship/create"><i class="fa fa-plus icon"></i>Create New Message</a>
                    </div>
                  </div>

                  <div class="row">
                  {if $pagination < 1}
                                        <div class="row flex p15-0">
                                            <div class="col-sm-12 margin-auto p-r-0">
                                                <h2 class="text-center res-f12">No Records Found...!</h2>
                                            </div>
                                        </div>
                                    {/if}
                    {foreach $messages as $key => $val}
                    <div class="col-md-12 feed-col">
                      <h4 class="m0 black caption m10 m-t-0 green-text"><a >{$val.title}</a></h4>

                      <div class="">

                        <p class="description grey-text lh-22">
                          <i>{$val.message}</i>
                        </p>

                        <ul class="m0 p0 pull-right">
                          <li class="inline-block"><i class="fa fa-dot-circle-o green-text" aria-hidden="true"></i> <span class="green-text"><b> <span class="count">{$val.target_no} </span>Business Targeted </b></span> </li>
                          <!-- <li class="inline-block ml-15"><i class="fa fa-usd icon green-text" aria-hidden="true"></i> --> <span><b class="green-text">Cost of the Message $<span class="format">{$val.cost}</span></b> <span class="count grey-text"></span></span></li>
                        </ul>


                      </div>
<div class="clearfix"></div>
                    </div>
                    {/foreach}
                  </div>

                </div>

              </div>

            </div>
          </div>
          
                                    <div class="row m20">
                                    <div class="col-md-12">
                                  <div id="pagination">
                                    {$pagination_html}
                                </div> 
                                </div>
          </div>
         <!--  <div class="row m20">
              <div class="col-md-12">
                  <ul class="pagination-ul flex">
                      <a href="#"><li class="inactive"><span class="fa fa-angle-left"></span></li></a>
                      <a href="#"><li class="active">1</li></a>
                      <a href="#"><li>2</li></a>
                      <a href="#"><li>3</li></a>
                      <a href="#"><li>4</li></a>
                      <a href="#"><li><span class="fa fa-angle-right"></li></a>
                  </ul>
              </div>
          </div> -->



        </div>


    </div>

<!-- / page content  -->
{include file="common/footer-1.tpl" nocache}


<script type="text/javascript">
numberformat();
$('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
  $('#pagination').find('ul').removeClass('pagination');
  $('.howworks').click(function(){
   $('html, body').animate({
       scrollTop: $("#howworksSec").offset().top
   }, 1000);
  });
</script>
<script>

    $('#filecount').filestyle({
     input : true,
     buttonName : '',
     iconName : 'fa fa-pencil',
     buttonText: ''
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