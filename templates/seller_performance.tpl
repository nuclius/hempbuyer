

{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<style type="text/css">
.star_selected
{
  background:url("{$config.url}/images/star.png");
}
.serr
{
  color: red;
}

.modal {
  text-align: center;
}

@media screen and (min-width: 768px) {
  .modal:before {
    display: inline-block;
    vertical-align: middle;
    content: " ";
    height: 100%;
  }
}

.modal-dialog {
  display: inline-block;
  text-align: center;
  vertical-align: middle;
  width: 50% !important;
}
.modal-header h3
{

  color: #fff !important;
      text-align: center;
}
</style>

<!-- page content  -->

    <div class="container-fluid grey-bg p0">

        <div class="page-caption m50">
            <!-- <h1>Seller Performance Review</h1> -->
        </div>

        <div class="col-md-12 flex">
          <div class="col-md-7 col-sm-10 white-bg p65 margin-auto shadow-bg m-b-50 padboth">

            <h3 class="caption fancy-title green-text text-center">Seller's Performance Review</h3>

            <p class="description grey-text m20 lh-22 text-center">
              Please answer the following brief questions.  When answering, rate the manufacturer by giving a rating between 1 and 5 with a 5 being the best performance and a 1 being the worst performance.
            </p>
              <form method="POST" enctype="multipart/form-data" class="admin_form" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/dashboard/seller_performance" onsubmit="return formvalidation()">
                <input   name="buy_id" value="{$buy_id}" type="hidden"  >
               <input   name="seller_id" value="{$id}" type="hidden"  >
                <input   name="store_id" value="{$store_id}" type="hidden"  >
                <input   name="product_id" value="{$product_id}" type="hidden"  >
                <input   name="last_url" value="{$last_url}" type="hidden"  >
            <ul class="seller-per-ul p0">
              <li class="border-b p15-0">
                <b class="inline-block w80">1. Was the product description accurate?</b>
                <div class="inline-block">
                  <span id="acc1" class="fa fa-star-o f16 icon  green-text acc" onclick="rate('acc',1)"></span>
                  <span id="acc2" class="fa fa-star-o f16 icon green-text acc" onclick="rate('acc',2)"></span>
                  <span id="acc3" class="fa fa-star-o f16 icon green-text acc" onclick="rate('acc',3)"></span>
                  <span id="acc4" class="fa fa-star-o f16 icon gray-text acc" onclick="rate('acc',4)"></span>
                  <span id="acc5" class="fa fa-star-o f16 green-text acc" onclick="rate('acc',5)"></span>
                  <input name="accurate" value="0" type="hidden" id="acc">
                   <div id="acc_err" class="serr"></div>
                </div>
              </li>
              <!-- <li class="border-b p15-0">
                <b class="inline-block w80">2.Did the product perform as expected?</b>
                <div class="inline-block">
                  <span id="per1" class="fa fa-star-o f16 icon green-text per" onclick="rate('per',1)"></span>
                  <span id="per2" class="fa fa-star-o f16 icon green-text per" onclick="rate('per',2)"></span>
                  <span id="per3" class="fa fa-star-o f16 icon green-text per" onclick="rate('per',3)"></span>
                  <span id="per4" class="fa fa-star-o f16 icon green-text per" onclick="rate('per',4)"></span>
                  <span id="per5" class="fa fa-star-o f16 green-text per" onclick="rate('per',5)"></span>
                  <input name="performance" required data-parsley-min="1" value="0" type="hidden" id="per">
                   <div id="per_err" class="serr"></div>
                </div>
              </li> -->
              <input name="performance" value="0" type="hidden" id="per">
              
              <li class="border-b p15-0">
                <b class="inline-block w80">2. Was the product delivered in a timely manner?  </b>
                <div class="inline-block">
                  <span id="del1" class="fa fa-star-o f16 icon green-text del" onclick="rate('del',1)"></span>
                  <span id="del2" class="fa fa-star-o f16 icon green-text del" onclick="rate('del',2)"></span>
                  <span id="del3" class="fa fa-star-o f16 icon green-text del" onclick="rate('del',3)"></span>
                  <span id="del4" class="fa fa-star-o f16 icon green-text del" onclick="rate('del',4)"></span>
                  <span id="del5" class="fa fa-star-o f16 green-text del" onclick="rate('del',5)"></span>
                  <input  name="delivery" value="0" type="hidden" id="del">
                  <div id="del_err" class="serr"></div>
                </div>
              </li>
              <li class="border-b p15-0">
                <b class="inline-block w80">3. Was the packaging compliant with state regulations?  </b>
                <div class="inline-block">
                  <span id="pac1" class="fa fa-star-o f16 icon green-text pac" onclick="rate('pac',1)"></span>
                  <span id="pac2" class="fa fa-star-o f16 icon green-text pac" onclick="rate('pac',2)"></span>
                  <span id="pac3" class="fa fa-star-o f16 icon green-text pac" onclick="rate('pac',3)"></span>
                  <span id="pac4"  class="fa fa-star-o f16 icon green-text pac" onclick="rate('pac',4)"></span>
                  <span id="pac5" class="fa fa-star-o f16 green-text pac" onclick="rate('pac',5)"></span>
                    <input  name="packing" value="0" type="hidden" id="pac">
                     <div id="pac_err" class="serr"></div>
                </div>
              </li>
              <!-- <li class="border-b p15-0">
                <b class="inline-block w80">5. Was the manufacturer responsive to any questions? <br> <span class="grey-text">(leave blank if you had no questions) </span></b>
                <div class="inline-block">
                  <span id="que1" class="fa fa-star-o f16 icon green-text  que" onclick="rate('que',1)" ></span>
                  <span id="que2" class="fa fa-star-o f16 icon green-text que"  onclick="rate('que',2)"></span>
                  <span id="que3" class="fa fa-star-o f16 icon green-text que"  onclick="rate('que',3)"></span>
                  <span id="que4" class="fa fa-star-o f16 icon green-text que"  onclick="rate('que',4)"></span>
                  <span id="que5" class="fa fa-star-o f16 green-text que"  onclick="rate('que',5)"></span>
                  <input  name="questions" value="0" type="hidden" id="que">
                </div>
              </li> -->
              <input  name="questions" value="0" type="hidden" id="que">

              <!-- <li class="border-b p15-0">
                <b class="inline-block w80">6. Was the manufacturer helpful in resolving your issues? <br> <span class="grey-text">(leave blank if you had no issues)</span> </b>
                <div class="inline-block">
                  <span id="res1" class="fa fa-star-o f16 icon green-text res" onclick="rate('res',1)"></span>
                  <span id="res2" class="fa fa-star-o f16 icon green-text res" onclick="rate('res',2)"></span>
                  <span id="res3" class="fa fa-star-o f16 icon green-text res" onclick="rate('res',3)"></span>
                  <span id="res4" class="fa fa-star-o f16 icon green-text res" onclick="rate('res',4)"></span>
                  <span id="res5" class="fa fa-star-o f16 green-text res" onclick="rate('res',5)"></span>
                  <input  name="resolving" value="0" type="hidden" id="res">
                </div>
              </li> -->
              <input  name="resolving" value="0" type="hidden" id="res">
              
              <li class="border-b p15-0">
                <b class="inline-block w80">4. Did the seller provide adequate customer service? </b>
                <div class="inline-block">
                  <span id="cus1" class="fa fa-star-o f16 icon green-text cus" onclick="rate('cus',1)"></span>
                  <span id="cus2" class="fa fa-star-o f16 icon green-text cus" onclick="rate('cus',2)"></span>
                  <span id="cus3" class="fa fa-star-o f16 icon green-text cus" onclick="rate('cus',3)"></span>
                  <span id="cus4" class="fa fa-star-o f16 icon green-text cus" onclick="rate('cus',4)"></span>
                  <span id="cus5" class="fa fa-star-o f16 green-text cus" onclick="rate('cus',5)"></span>
                  <input   name="customer_support" value="0" type="hidden" id="cus">
                   <div id="cus_err" class="serr"></div>
                </div>
              </li>
              <li class="border-b p15-0">
                <b class="inline-block w80">5. Are you satisfied? </b>
                <div class="inline-block">
                  <span id="sat1" class="fa fa-star-o f16 icon green-text sat" onclick="rate('sat',1)"></span>
                  <span id="sat2" class="fa fa-star-o f16 icon green-text sat"  onclick="rate('sat',2)"></span>
                  <span id="sat3" class="fa fa-star-o f16 icon green-text sat"  onclick="rate('sat',3)"></span>
                  <span id="sat4" class="fa fa-star-o f16 icon green-text sat"  onclick="rate('sat',4)"></span>
                  <span id="sat5" class="fa fa-star-o f16 green-text sat"  onclick="rate('sat',5)"></span>

                      <input   name="satisfaction" value="0" type="hidden" id="sat">
                       <div id="sat_err" class="serr"></div>
                </div>
              </li>
            </ul>

            <textarea class="w100 border1 p15 pb15 m20" required placeholder="Please provide additional comments about the seller and products you purchased here" name="comment" rows="6" cols="80"></textarea>
            <button   class="btn btn-default btn-d-b green-b m0" type="submit">POST</button>
   </form>
          </div>
        </div>

        <br/>  <br/>
    </div>

<!-- / page content  -->

{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}

<div class="  modal fade reccuring-modal in" id="cnx" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true"  data-backdrop="static" data-keyboard="false" data-parsley-required data-parsley-required-message="Please enter the comment.">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header  panel-heading green-bg"> <h3>Your Review has been successfully submitted </h3></div>
      <div class="modal-body info-data"  style="font-size: 25px;">  Your  submission will be shown on website after admin has reviewed </br>

       <a href="{$last_url}"> click here to continue shopping </a>
        </div>
    </div>
  </div>
</div>
</div>

<script type="text/javascript">

err_disp=0;
function rate(x,y) {
  $( "."+x ).removeClass( "star_selected" );
  $( "#"+x ).val(y);
  for (i = 1; i <= y; i++) {
    p="#"+x+i;
    $(p ).addClass( "star_selected" );
  }
  erb="#"+x+"_err";
  $(erb).html("");
}

$(function() {
  if( "{$err}"==1) {
    $('#cnx').modal('show');
  }
});
function formvalidation()
{
  a=0;
  $('.serr').html('');
  if($("#acc").val()<1) {
    $("#acc_err").html(" Required field");
    a++
  }
  /* if($("#per").val()<1) {
    $("#per_err").html(" Required field");
    a++
  } */
  if($("#del").val()<1) {
    $("#del_err").html(" Required field");
    a++
  }
  if($("#pac").val()<1) {
    $("#pac_err").html(" Required field");
    a++
  }
  if($("#sat").val()<1) {
    $("#sat_err").html(" Required field");
    a++
  }
  if($("#cus").val()<1) {
    $("#cus_err").html(" Required field");
    a++
  }

  if (a>0) {
    return false;
    err_disp=1;
  }
  return true;
}



</script>
