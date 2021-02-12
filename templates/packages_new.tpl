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

<!-- page content  -->

<!-- {if $loged.business_type}
  {if $loged.business_type != 'supplier'}
    {$show = 'true'}
  {/if}
  {if $supplier}
    {$show = 'false'}
  {/if}
{/if} -->

{if $loged.userid}
{if $loged.business_type != 'supplier'}
{$supplier = 'false'}
{$nsupplier = 'true'}
{/if}
{if $loged.business_type == 'supplier'}
{$supplier = 'true'}
{$nsupplier = 'false'}
{/if}
{/if}
{if !$loged.userid}
{$supplier = 'true'}
{$nsupplier = 'true'}
{/if}

<div class="container-fluid grey-bg p0">

  <div class="page-caption m50">
    <h1>Membership Plans</h1>
  </div>

  <div class="container-fluid membership-con m50">
    <div class="table-responsive white-bg shadow overflow-enable">
      <table class="table" border="0" cellpadding="0" cellspacing="0">
        <thead>

          <tr>

            <th class="text-center plan-feature black-b"><span class="t-super-main-heading">PLAN FEATURES</span></th>
            {if $nsupplier == 'true'}
            <th class="plan-headings">
              <div class="t-main-heading">BASIC MEMBERSHIP</div>
              <div class=" ">
                <div class="col-md-12 plan-price">
                  <h3>$200/ <span>Month</span></h3>
                </div>
              </div>
              <div class="row t-flex">
                <div class="col-md-5 members-col">Dispensaries </div>
                <div class="col-md-3 members-col">Growers</div>
                <div class="col-md-4 members-col">Producers</div>
              </div>
            </th>

            <th class="plan-headings" style="background-color: #f7814d;"><span class="t-main-heading">PREMIUM
                MEMBERSHIP</span>
              <div class=" ">
                <div class="col-md-12 plan-price" style="background-color: #e87745">
                  <h3>$500/ <span>Month</span></h3>
                </div>
              </div>
              <div class="row t-flex">
                <div class="col-md-5 members-col">Dispensaries </div>
                <div class="col-md-3 members-col">Growers</div>
                <div class="col-md-4 members-col">Producers</div>
              </div>
            </th>
            {/if}
            {if $supplier == 'true'}
            <th class="plan-headings" style="background-color: #9ad572;"><span class="t-main-heading">SUPPLIERS</span>
              <div class=" ">
                <div class="col-md-12 plan-price" style="background-color: #8bc762;">
                  <h3>$75/ <span>Month</span></h3>
                </div>
              </div>

              <div class="row t-flex">
                <div class="col-md-12 members-col">Accessory Providers <br></div>
                <div class="col-md-12 members-col">Service Providers</div>
              </div>
            </th>
            {/if}
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>Access to Herbee's Direct Buy marketplace to buy cannabis products</td>
            {if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            {/if}
            {if $supplier == 'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>
            {/if}
          </tr>

          <tr>
            <td>Access to input products, accessory suppliers, and wholesalers to buy the products you need</td>{if
            $nsupplier == 'true'}

            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}

            {if $supplier == 'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if}

          </tr>

          <tr>
            <td>Buy and sell products on the open market at the best price</td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>

          <tr>
            <td>Create your own store front to sell products to businesses </td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon green">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>

          <tr>
            <td> Readily create B2B ad/marketing campaigns </td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon green">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>

          <tr>
            <td> Access to peer reviews of member business and suppliers </td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon green">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>

          <tr>
            <td> Access to general market research by state </td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <!-- <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                    <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                    <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div> -->
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <!-- <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                    <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                    <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div> -->
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon green">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>

                <!-- <div class="col-md-6"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-check" aria-hidden="true"></i></div> -->
              </div>
            </td>{/if}
          </tr>

          <tr>
            <!-- 
                  <td> Access to in depth market research by region
                      (pricing, volume, trend)  </td> -->
            <td> Access to quarterly in depth market research by region (pricing, volume, trend) </td>{if $nsupplier ==
            'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>

                <!-- <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                    <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                    <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div> -->
              </div>
            </td>{/if}
            {if $supplier == 'true'} <td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>

          <tr>
            <td> Obtain comparative market analytics for your
              business </td>{if $nsupplier == 'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
            {if $supplier == 'true'} <td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>

          <tr>
            <td> Access to relationship building tools </td>{if $nsupplier == 'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>

          <tr>
            <td> Forward contracting capability </td>
            {if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            {/if}
            {if $supplier == 'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>
            {/if}
          </tr>
          <tr>
            <td> Digitize Cash </td>
            {if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
              </div>
              <!-- <button onclick="window.location.href=''" class="btn btn-default btn-d-b green-b shadow-btn" type="button" name="button">BUY NOW</button> -->
            </td>
            {/if}
            {if $supplier == 'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>
            {/if}
          </tr>
          <tr>
            <td class="algn-td"> Access to research of the forward market </td>
            {if $nsupplier == 'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-4"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">

                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <!-- <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                    <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div>
                    <div class="col-md-4"><i class="fa fa-check" aria-hidden="true"></i></div> -->
              </div>
            </td>
            {/if}
            {if $supplier == 'true'}
            <td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>
            {/if}
          </tr>

          <tr>
            <td> Track Inventory in by market </td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>



          <tr>
            <td> Request marketing and sales support for your products </td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>


          <tr>
            <td> Request Packaging Support for your products </td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
              </div>
            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
              </div>
            </td>{/if}
            {if $supplier == 'true'}<td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if}
          </tr>



          <tr>
            <td> Access to low cost Distribution services </td>{if $nsupplier == 'true'}
            <td class="icon blue">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
              </div>

            </td>
            <td class="icon orange">
              <div class="row t-flex">
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
                <div class="col-md-4">COMING SOON</div>
              </div>


              <!-- <button onclick="window.location.href='{$config.url}/membership/setup'" class="btn btn-default btn-d-b green-b shadow-btn" type="button" name="button">BUY NOW</button> -->
            </td>{/if}
            {if $supplier == 'true'}<td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>

            </td>{/if}
            <!-- {if $supplier == 'true'}<td class="icon">
              <div class="row t-flex">
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="col-md-6"><i class="fa fa-times" aria-hidden="true"></i></div>
              </div>
            </td>{/if} -->
          </tr>

          <tr>
            <td></td>
            <td class="icon">
              <form required="" data-parsley-validate="" method="post" action="{$config.url}/membership/package"
                id="setautobid" onsubmit="return checkPlan(this)" name="setautobid" novalidate="">
                <input type="hidden" name="plan" value="36" />
                <input type="hidden" name="membership" value="8" />
                <input type="hidden" name="mem_plan_type" value="1" />
                {if $plan_id == 36 && $status == 'active'}
                <button class="btn btn-default btn-d-b green-b shadow-btn" type="button" disabled name="button">Current
                  Plan</button>
                {/if}
                {if $plan_id == 36 && $status == 'expired'}
                <button type="submit" class="btn btn-default btn-d-b green-b shadow-btn" type="button" name="button">BUY
                  NOW</button>
                {/if}
                {if $plan_id != 36 && $status == 'active'}
                <button type="submit" class="btn btn-default btn-d-b green-b shadow-btn" type="button" name="button">BUY
                  NOW</button>
                {/if}
                {if $plan_id != 36 && $status != 'active'}
                <button type="submit" class="btn btn-default btn-d-b green-b shadow-btn" type="button" name="button">BUY
                  NOW</button>
                {/if}

            
              </form>
            </td>
            {if $nsupplier == 'true'}
            <td class="icon">
              <form required="" data-parsley-validate="" method="post" action="{$config.url}/membership/package"
                id="setautobid" name="setautobid" novalidate="">
            
                <input type="hidden" name="plan" value="39" />
                <input type="hidden" name="membership" value="8" />
                <input type="hidden" name="mem_plan_type" value="2" />
                {if $plan_id == 39 && $status == 'active'}
                <button class="btn btn-default btn-d-b green-b shadow-btn" type="button" disabled name="button">Current
                  Plan</button>
                {/if}
                {if $plan_id == 39 && $status == 'expired'}
                <button type="submit" class="btn btn-default btn-d-b green-b shadow-btn" type="button" name="button">BUY
                  NOW</button>
                {/if}
                {if $plan_id != 39 && $status == 'active'}
                <button type="submit" class="btn btn-default btn-d-b green-b shadow-btn" type="button" name="button">BUY
                  NOW</button>
                {/if}
                {if $plan_id != 39 && $status != 'active'}
                <button type="submit" class="btn btn-default btn-d-b green-b shadow-btn" type="button" name="button">BUY
                  NOW</button>
                {/if}
              </form>
            </td>
            {/if}
          </tr>

        </tbody>
      </table>
    </div>
  </div>

</div>

<!-- / page content  -->


{include file="common/footer-1.tpl" nocache}

</body>

</html>