

{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<style type="text/css">
.star_selected
{
  background:url("{$config.url}/images/star.png");    font-size: 17px !important;
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

    <div class="container-fluid grey-bg p0 ">

        <div class="page-caption m50">
            <!-- <h1>Buyer Performance Review</h1> -->
        </div>

        <div class="col-md-12 padboth flex">
          <div class="col-md-7 col-sm-10 padboth white-bg p65 margin-auto shadow-bg m-b-50">

            <h3 class="caption padboth fancy-title green-text text-center">Buyer's Performance Review</h3>

            <p class="description grey-text m20 lh-22 text-center">
              Please answer the following brief questions.  When answering, rate the buyer by giving a rating between 1 and 5 with a 5 being the best performance and a 1 being the worst performance.
            </p>
              <form method="POST" enctype="multipart/form-data" class="admin_form" data-parsley-validate name="add-product" id="add-product" action="{$config.url}/dashboard/buyer_performance" onsubmit="return formvalidation()">
                <input   name="buy_id" value="{$buy_id}" type="hidden"  >
               <input   name="buyer_id" value="{$id}" type="hidden"  >
                <input   name="store_id" value="{$store_id}" type="hidden"  >
                <input   name="last_url" value="{$last_url}" type="hidden"  >
            <ul class="buyer-per-ul p0">
              <li class="border-b p15-0">
                <b class="inline-block w80">1. Delivery space was separate from retail space and was a safe environment</b>
                <div class="inline-block">
                  <span id="del1" class="fa fa-star-o f16 icon  green-text del" onclick="rate('del',1)"></span>
                  <span id="del2" class="fa fa-star-o f16 icon green-text del" onclick="rate('del',2)"></span>
                  <span id="del3" class="fa fa-star-o f16 icon green-text del" onclick="rate('del',3)"></span>
                  <span id="del4" class="fa fa-star-o f16 icon gray-text del" onclick="rate('del',4)"></span>
                  <span id="del5" class="fa fa-star-o f16 green-text del" onclick="rate('del',5)"></span>
                  <input name="delivery" value="0" type="hidden" id="del">
                   <div id="del_err" class="serr"></div>
                </div>
              </li>
              <li class="border-b p15-0">
                <b class="inline-block w80">2. There person receiving delivery was informed about the delivery</b>
                <div class="inline-block">
                  <span id="dinf1" class="fa fa-star-o f16 icon green-text dinf" onclick="rate('dinf',1)"></span>
                  <span id="dinf2" class="fa fa-star-o f16 icon green-text dinf" onclick="rate('dinf',2)"></span>
                  <span id="dinf3" class="fa fa-star-o f16 icon green-text dinf" onclick="rate('dinf',3)"></span>
                  <span id="dinf4" class="fa fa-star-o f16 icon green-text dinf" onclick="rate('dinf',4)"></span>
                  <span id="dinf5" class="fa fa-star-o f16 green-text dinf" onclick="rate('dinf',5)"></span>
                  <input name="deliveryinfo" required data-parsley-min="1" value="0" type="hidden" id="dinf">
                   <div id="dinf_err" class="serr"></div>
                </div>
              </li>
              <li class="border-b p15-0">
                <b class="inline-block w80">3. The buyer properly inspected and assessed product delivered
  </b>
                <div class="inline-block">
                  <span id="pin1" class="fa fa-star-o f16 icon green-text pin" onclick="rate('pin',1)"></span>
                  <span id="pin2" class="fa fa-star-o f16 icon green-text pin" onclick="rate('pin',2)"></span>
                  <span id="pin3" class="fa fa-star-o f16 icon green-text pin" onclick="rate('pin',3)"></span>
                  <span id="pin4" class="fa fa-star-o f16 icon green-text pin" onclick="rate('pin',4)"></span>
                  <span id="pin5" class="fa fa-star-o f16 green-text pin" onclick="rate('pin',5)"></span>
                  <input  name="prodinspect" value="0" type="hidden" id="pin">
                  <div id="pin_err" class="serr"></div>
                </div>
              </li>
              <li class="border-b p15-0">
                <b class="inline-block w80">4. A delivery receipt notice and all other needed paperwork was provided  </b>
                <div class="inline-block">
                  <span id="dlr1" class="fa fa-star-o f16 icon green-text dlr" onclick="rate('dlr',1)"></span>
                  <span id="dlr2" class="fa fa-star-o f16 icon green-text dlr" onclick="rate('dlr',2)"></span>
                  <span id="dlr3" class="fa fa-star-o f16 icon green-text dlr" onclick="rate('dlr',3)"></span>
                  <span id="dlr4"  class="fa fa-star-o f16 icon green-text dlr" onclick="rate('dlr',4)"></span>
                  <span id="dlr5" class="fa fa-star-o f16 green-text dlr" onclick="rate('dlr',5)"></span>
                    <input  name="delreceipt" value="0" type="hidden" id="dlr">
                     <div id="dlr_err" class="serr"></div>
                </div>
              </li>
              <li class="border-b p15-0">
                <b class="inline-block w80">5. The buyer’s personnel were professional, cordial, and good to work with </b>
                <div class="inline-block">
                  <span id="per1" class="fa fa-star-o f16 icon green-text  per" onclick="rate('per',1)" ></span>
                  <span id="per2" class="fa fa-star-o f16 icon green-text per"  onclick="rate('per',2)"></span>
                  <span id="per3" class="fa fa-star-o f16 icon green-text per"  onclick="rate('per',3)"></span>
                  <span id="per4" class="fa fa-star-o f16 icon green-text per"  onclick="rate('per',4)"></span>
                  <span id="per5" class="fa fa-star-o f16 green-text per"  onclick="rate('per',5)"></span>
                  <input  name="personnel" value="0" type="hidden" id="per">
                  <div id="per_err" class="serr"></div>
                </div>
              </li>
              <li class="border-b p15-0">
                <b class="inline-block w80">6. Buyer provided timely payment for goods and services</b>
                <div class="inline-block">
                  <span id="tpay1" class="fa fa-star-o f16 icon green-text  tpay" onclick="rate('tpay',1)" ></span>
                  <span id="tpay2" class="fa fa-star-o f16 icon green-text tpay"  onclick="rate('tpay',2)"></span>
                  <span id="tpay3" class="fa fa-star-o f16 icon green-text tpay"  onclick="rate('tpay',3)"></span>
                  <span id="tpay4" class="fa fa-star-o f16 icon green-text tpay"  onclick="rate('tpay',4)"></span>
                  <span id="tpay5" class="fa fa-star-o f16 green-text tpay"  onclick="rate('tpay',5)"></span>
                  <input  name="tpayment" value="0" type="hidden" id="tpay">
                  <div id="tpay_err" class="serr"></div>
                </div>
              </li>
            </ul>

            <textarea class="w100 border1 p15 pb15 m20" placeholder="Post additional comments about the buyer performance here" name="comment" rows="6" cols="80"></textarea>
            <button class="btn btn-default btn-d-b green-b m0" type="submit">POST</button>
            </form>
          </div>
        </div>
<br/><br/>
    </div>

<!-- / page content  -->

{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}

<!-- <<<<<<< HEAD
<div class="modal fade reccuring-modal in" id="cnx" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true"  data-backdrop="static" data-keyboard="false">
 -->
<div class="  modal fade reccuring-modal rwv-modal in" id="cnx" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true"  data-backdrop="static" data-keyboard="false">
<!-- >>>>>>> 206ca260315356618d9f54588910d0ea53f381b8 -->
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header  panel-heading green-bg">

          <h3>Your Review has been successfully submitted </h3>
      </div>
      <div class="modal-body info-data" style="font-size: 25px;"> Your submission will be shown on website after admin has reviewed </br>

       <a href="{$last_url}"> click here to continue shopping </a>
        </div>
    </div>
  </div>
</div>
</div>

<script type="text/javascript">

err_disp=0;
function rate(x,y)
{
$( "."+x ).removeClass( "star_selected" );
$( "#"+x ).val(y);
for (i = 1; i <= y; i++) {
  p="#"+x+i;
  $(p ).addClass( "star_selected" );

}

erb="#"+x+"_err";
 $(erb).html("");
}


$(function()
     {
      if( "{$err}"==1)
      {
        $('#cnx').modal('show');
      }
     });
function formvalidation()
{
  a=0;

  $('.serr').html('');

  if($("#del").val()<1)
  {
    $("#del_err").html(" Required field");
    a++
  }

  if($("#dinf").val()<1)
  {
    $("#dinf_err").html(" Required field");
    a++
  }

  if($("#pin").val()<1)
  {
    $("#pin_err").html(" Required field");
    a++
  }

  if($("#dlr").val()<1)
  {
    $("#dlr_err").html(" Required field");
    a++
  }

  if($("#per").val()<1)
  {
    $("#per_err").html(" Required field");
    a++
  }
  if($("#tpay").val()<1)
  {
    $("#tpay_err").html(" Required field");
    a++
  }

if (a>0)
{return false;
err_disp=1;
 }
return true;
}

</script>
