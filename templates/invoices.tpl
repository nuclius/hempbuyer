<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->

{include file="common/header-1.tpl" nocache}
{include file="common/dashboard-navigation.tpl" nocache}

<div class="container-fluid grey-bg xs-pdlr">
  <div class="container">

    <div class="row">
      <div class="col-md-9">
        <button class="btn btn-default btn-d-b green-b" onClick="window.location='{$config.url}/dashboard/dbmarket/'">Back</button>
      </div>
      </div>
      <div class="row flex">
      <div class="col-md-9 col-sm-9 col-xs-12 white-bg m35 p35" style="padding:15px 35px;">
        <div class="row p15">
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>Checkout id :</b></div>
              <div class="col-md-7">{$transaction[0].id}</div>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>Checkout amount :</b></div>
              <div class="col-md-7">{$transaction_amount}</div>
            </div>
          </div>
        </div>
        <div class="row p15">
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>Name :</b></div>
              <div class="col-md-7">{$transaction[0].first_name} {$transaction[0].last_name}</div>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>Address :</b></div>
              <div class="col-md-7">{$transaction[0].address}</div>
            </div>
          </div>
        </div>
        <div class="row p15">
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>Country :</b></div>
              <div class="col-md-7">{$transaction[0].country}</div>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>State :</b></div>
              <div class="col-md-7">{$transaction[0].state}</div>
            </div>
          </div>
        </div>
        <div class="row p15">
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>City :</b></div>
              <div class="col-md-7">{$transaction[0].city}</div>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>Zip code :</b></div>
              <div class="col-md-7">{$transaction[0].zipcode}</div>
            </div>
          </div>
        </div>
        <div class="row p15">
          <div class="col-sm-6">
            <div class="row">
              <div class="col-md-5"><b>Total items :</b></div>
              <div class="col-md-7">{$transaction.length}</div>
            </div>
          </div>
          <div class="col-sm-6"></div>
        </div>
          {foreach $transaction as $key => $val}
          <div class="row mt-15">
            <div class="col-sm-12">
              <div class="or-circle margin-auto block res-float-none">
                {$key+1}
              </div>
            </div>
            <div class="col-sm-12 mt-15">
              <div class="row p15 border-b1">
                <div class="col-sm-5"><b>Product Name :</b></div>
                <div class="col-sm-7">{$val.p_title}</div>
              </div>
              <div class="row p15 border-b1">
                <div class="col-sm-5"><b>Invoice ID :</b></div>
                <div class="col-sm-7">{$val.i_id}</div>
              </div>
              <div class="row p15 border-b1">
                <div class="col-sm-5"><b>Product price :</b></div>
                <div class="col-sm-7">{$val.p_unit_price}</div>
              </div>
              <!-- <div class="row p15 border-b1">
                <div class="col-sm-5">{$val.p_unit_price}</div>
                <div class="col-sm-7">{$val.p_units}</div>
              </div> -->
              <div class="row p15 border-b1">
                <div class="col-sm-5"><b>Ordered Quantity :</b></div>
                <div class="col-sm-7">{$val.b_qty} {$val.p_units}</div>
              </div>
            </div>
          </div>
        {/foreach}
      </div>
    </div>

  </div>
</div>

{include file="common/footer-1.tpl" nocache}
<script language="javascript" type="text/javascript">
          $(function() { $('.wu').addClass('act_class'); } );
     </script>
<script type="text/javascript">
$(function()
{
  projectLoad();
});</script>
