
{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<!-- deposit -->
<div class="modal reccuring-modal fade" id="deposit" role="dialog">
  <div class="modal-dialog modal-sm" style="width: 35% !important;">
    <div class="modal-content">
      <div class="modal-header border-0">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div class="panel panel-success">
          <div class="panel-heading green-bg">
              <h3>Deposite </h3>
          </div>
        </div>
      </div>
      <div class="modal-body">
        <!-- <h3 class="primary-blue text-center m20">Suggested Price:<span class="green-text">$20/Unit</span></h3> -->

        <div class="form-group">
          <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="Deposite" name="email">

        </div>

        <div class="form-group">
          <select class="w100 p15 pb15 grey-bg border-0" name="">
            <option value="">Please Select Payment Method</option>
            <option value="">Add New PayPal</option>
            <option selected id="add-card-details" value="add-details">Add New Credit Card</option>
          </select>
        </div>

        <div class="row">
          <div class="col-md-12 ml-15 card-details-fields">

            <div class="form-group">
              <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="Card Name" name="email">
            </div>

            <div class="form-group">
              <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="Card Number" name="email">
            </div>

            <div class="form-group">
              <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="CVV" name="email">
            </div>

            <div class="form-group">
              <input class="w100 p15 pb15 grey-bg border-0" type="email" id="email" placeholder="Expiry Date - MM/YYYY" name="email">
            </div>

            <div class="checkbox">

              <label class="p0">
                <input type="checkbox" value="">
                <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                Save for future payment
              </label>

            </div>

          </div>
        </div>

      </div>
      <div class="modal-footer">
        <button class="btn btn-default btn-d black-g" type="button" name="button" data-toggle="modal" data-target="#negotiable">Pay </button>

      </div>
    </div>
  </div>
</div>

<!-- Page content -->

<div class="container-fluid bgBannerFluid">
    <h1>Dashboard</h1>
         {include file="common/common_navigation.tpl" nocache}
</div>

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">

      <div class="col-md-3 sidebar   mb-25">

        <ul class="sidebar-menu links-wrapper">
          <li class="maincat p0"><a href="dashboard.html">Dashboard</a></li>
          <li class="maincat p0"><a href="dashboard-profile.html">Profile</a></li>
          <li class="maincat"><a href="#">Messages</a></li>
          <li class="maincat"><a href="dashboard-payments.html">Payments</a></li>
          <li class="maincat"><a href="#">Contact information</a></li>
          <li class="maincat"><a href="dashboard-change-password.html">Change Password</a></li>
          <li class="maincat"><a href="dashboard-shipping.html">Shipping address changes</a></li>
          <li class="maincat"><a href="dashboard-account.html">Billing and Account Information</a></li>
          <li class="maincat"><a href="dashboard-notifications.html">Notifications</a></li>
          <li class="maincat active"><a href="{$config.url}/stores/show_adwords">Advertisement</a></li>

        </ul>

      </div>
      <!-- / Sddebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Advertisement</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p35 shadow">

            <div class="row">

              <div class="col-md-4">
                <!-- <ul class="p0">
                  <li class="block">Available Funds: <span class="count"> $500</span></li>
                  <li class="block"><a href="#deposit" data-toggle="modal" data-target="#deposit">Add Deposit</a></li>
                </ul> -->
              </div>

              <div class="col-md-8 text-right">

                <button onclick="window.location.href='{$config.url}/stores/product/ads'" class="btn btn-default btn-d-b green-b m0 text-transform-inherit" type="button">Ads My Product</button>
                 <button onclick="window.location.href='{$config.url}/stores/brands/ads'" class="btn btn-default btn-d-b green-b m0 text-transform-inherit" type="button">Ads My Brands</button>
                <button onclick="window.location.href='{$config.url}/stores/ads'" class="btn btn-default btn-d-b green-b m0 text-transform-inherit" type="button">Ads My Store</button>

              </div>

            </div>

            <div class="row">

              <div class="col-xs-12 notifications">

                <div class="row">

                  <div class="col-md-12">

                    <div class="table-responsive">

                      <table class="table">

                        <thead>
                          <tr>
                            <td class="f700">Ads Name</td>
                            <td class="f700">Status</td>
                            <td class="f700">Updated</td>
                            <td class="f700">Budget/Day</td>
                            <td class="f700">Budget/Click</td>
                          </tr>
                        </thead>

                        <tbody>
                         {foreach $adwords_details as $key => $val}
                          <tr>
                            <td>
                              <h4><b class="caption">
                                {$val.ad_title} </b> <a href="{$config.url}/adwords/edit/{$val.id}/{$val.store_id}" class="black"><i class="fa fa-pencil icon f12"></i></a>
                              </h4>

                              <a href="{$config.url}/adwords/edit_adwords/{$val.status}/{$val.id}">
                                {if $val.status == 'active'} Pause {else $val.status == 'pause'} Resume {/if} <span class="slash">|</span>
                              </a>

                              <a href="{$config.url}/adwords/edit_adwords/remove/{$val.id}" onclick="return confirmation()" class="red">
                                Remove
                              </a>
                            </td>
                            <td>{if $val.status == 'active'} Active {else $val.status == 'psuse'} Pause {/if}</td>
                            <td>{dateFormat($val.created_at, 'dd mmmm yyyy')}</td>
                           
                            <td class="text-center">{$val.budget_per_day}</td>
                             <td class="text-center">{$val.budget_per_click}</td>
                          </tr>
                          {/foreach}
                          
                        
                          

                        </tbody>

                      </table>
                       {$pagination_html}
                    </div>

                  </div>

                </div>

              </div>

              </div>

            </div>




          </div>

        </div>

      </div>
      <!-- / Content Area -->


    </div>
    <!-- Parent Row -->

  </div>
  <!-- dashboard-settings-con -->

</div>



<!--/ Page content -->

<script>
    function confirmation() {
        var confirmed =  confirm("Are you sure, you want to delete ?");
        return confirmed;
    }
</script>



{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}