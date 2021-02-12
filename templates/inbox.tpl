{include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<!-- page content  -->

<div class="container">


  <!-- Modal -->
  <div class="modal reccuring-modal fade in" id="confirm" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header border-0">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
          <div class="panel panel-success m0">
            <div class="panel-heading green-bg">
                <h3>Are you sure ?</h3>
            </div>
          </div>
        </div>
        <div class="modal-body">

          <h3 class="text-center grey-text m20">You will be charged <span class="green-text">$10</span></h3>

          <div class="row">

            <div class="col-md-10 col-md-offset-1">

              <div class="row">

                <div class="col-md-12 pslr0 text-left mr-cklab mrbt10 scall">
                    <div class="scrl" id="style-1">
                    	Please note that it is a violation of the terms of use policy to send any message soliciting the sale of any product also appearing on the Herbal Electronic Exchange in an effort to circumvent any protections, services, taxes, or fees.  Users may be subject to sanction, suspension or expulsion if found violating this policy
                    </div>
                </div>

              </div>

              <div class="row">

                <div class="col-md-12">

                  <div class="checkbox">
                    <label class="p0">
                      <input type="checkbox" value="">
                      <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                      I have accepted the <a target="_blank" href="{$config.url}/terms">terms and conditions</a>
                    </label>
                  </div>

                </div>

              </div>

            </div>

          </div>

        </div>
        <div class="modal-footer">

          <div class="row">
            <div class="col-md-10 col-md-offset-1">
              <div class="row">
                <div class="col-md-12">
                  <button class="btn btn-default btn-d black-g" type="button" name="button" data-toggle="modal" data-target="#negotiable">Confirm </button>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>

    <div class="container-fluid grey-bg p0">

        <div class="page-caption m50">
            <h1>Inbox</h1>
        </div>


        <div class="container business-pool-con m20">
<div><p class="green-txt">Find potential partnerships by reaching out to operators by type or by location. Each message costs ${$config.general.relationship_charge} per user reached.</p></div>
          <div class="row store-content-row white-bg shadow p35">
            <div class="col-md-12">


              <div class="row">

                <div class="col-md-3 sidebar  mb-25">
  <ol class="breadcrumb bg-transparent p0">
                <li><a class="green-text" href="{$config.url}/dashboard/relationship/inbox">Inbox</a></li>
                <!-- <li><a href="product-view-ob.html">Product Name</a></li> -->
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
                              <!-- <a class="green-text" href="active-msg.html"><span>Active Messages</span></a> -->
                              <!-- <i class="fa fa-angle-left pull-right"></i> -->
                            <!-- </div> -->

                          <!-- </li> -->
                        <li>
                          <div class="maincat">
                              <!-- <i class="fa fa-user icon green-text" aria-hidden="true"></i> -->
                            <a class="" href="{$config.url}/dashboard/relationship/sent"><span>Sent Messages</span></a>
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
                            <a href="{$config.url}/dashboard/relationship"><span>Collaborate by Location</a>
                            <!-- <i class="fa fa-angle-left pull-right"></i> -->
                            </div>

                        </li>



                  </ul>

                          <ul class="sidebar-menu">
                                  <li>
                                      <a class="maincat">
                                          <span class="catcap"><b>Collaborate by Type</b></span>
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
                      {if $pagination > 0}
                  	 {foreach $messages as $key => $val}
                     {if $val.interest != 1}
                    <div class="col-md-12 feed-col">

                      <div class="">

                        <h4 class="m0 black caption m10 m-t-0 green-text"><a>{$val.subject}</a></h4>

                        <p class="description grey-text lh-22">
                          <i>{shorten($val.message_short,500)}</i>
                        </p>

                        <ul class="m0 p0 pull-right">
                        {if $val.interest == 0}

                          <li class="inline-block"><a class="interest" id="{$val.id}"><i class="fa fa-thumbs-up icon green-text" aria-hidden="true"></i> <span class="green-text"><b>Interested?</b></span></a> </li>
                          <li class="inline-block"><a class="ntinterest" id="{$val.id}"><i class="fa fa-thumbs-down icon green-text" aria-hidden="true"></i> <span class="green-text"><b>Not Interested? </b></span></a></li>
                           {/if}
                            {if $val.interest == 1}

                          <li class="inline-block"><a ><i class="fa fa-thumbs-up icon  green-text" aria-hidden="true"></i> <span class=" green-text"><b>Interested</b></span></a> </li>
                           <!-- <li class="inline-block ml-15"><a class="ntinterest" id="{$val.id}"><i class="fa fa-thumbs-down icon green-text" aria-hidden="true"></i> <span><b class="green-text">Not Interested? </b></span></a></li> -->
                           {/if}


                        </ul>


                      </div>
<div class="clearfix"></div>
                    </div>
                      {/if}
                     {/foreach}
                     {/if}
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
          <!-- <div class="row m20">
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

$(document).ready(function () {
	$('.interest').click(function(){
	var inbid =this.id;
	 $.ajax({
      type : 'POST',
       dataType : 'json',
      url : ASBASE + '/relationinterest',
      data : 'inbid='+inbid,
      success : function(data) {
        window.location.reload();
        //changeSubCategory

      }
    });
	});

	$('.ntinterest').click(function(){
	var inbid =this.id;
	 $.ajax({
      type : 'POST',
       dataType : 'json',
      url : ASBASE + '/relationntinterest',
      data : 'inbid='+inbid,
      success : function(data) {
        window.location.reload();
        //changeSubCategory

      }
    });
	});
});
</script>

<script type="text/javascript">
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
