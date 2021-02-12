
{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}

 

 {include file="common/dashboard-navigation.tpl" nocache}

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row"> 
      
      <!-- common sidebar here -->
      <div class="col-md-3 sidebar  mb-25  mb-25"> 
        <div class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Referrals <i class="fa fa-angle-down"></i></a>
          {include file="common/dashboard_settings_menu.tpl" nocache}
        </div>
      </div> 
      <!-- / Sidebar -->

      <div class="col-md-9 content-area">

        <div class="row">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Referrals</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 shadow">

            <div class="row">

              
<div class="col-md-12 text-center refer2"><h3>Refer and earn bonus points </h3></div>
    <div class="col-md-12 text-center refer3">
      <span class='st_facebook_large' st_url='{$config.url}/register?ref=HERBEE{$loged.userid}&med=fb' displayText='Facebook'></span>
      <span class='st_twitter_large' st_url='{$config.url}/register?ref=HERBEE{$loged.userid}&med=twi' displayText='Tweet' st_title="{$title}"></span>
      <span class='st_linkedin_large' st_url='{$config.url}/register?ref=HERBEE{$loged.userid}&med=in' displayText='LinkedIn'></span>
      <span class='st_pinterest_large' st_url='{$config.url}/register?ref=HERBEE{$loged.userid}&med=pin' displayText='Pinterest'></span>
      <span class='st_email_large' st_url='{$config.url}/register?ref=HERBEE{$loged.userid}&med=mail' displayText='Email'></span>
      <!-- <span class='st_sharethis_large' st_url='{$config.url}/?ref=HERBEE{$loged.userid}&med=share' displayText='ShareThis'></span> -->
      
    </div>
       
            
            <div class="col-md-8">
                <!-- <ul class="p0">
                  <li class="block">Available Funds: <span class="count"> $500</span></li>
                  <li class="block"><a href="#deposit" data-toggle="modal" data-target="#deposit">Add Deposit</a></li>
                </ul> -->
                <h4>You Have  <span style="color:red">{{$bonus}}</span>  Bonus points remaining </h4>
              </div> 

               <div class="col-md-4">Referral Code : HERBEE{$loged.userid} </div> 

            </div>

            <div class="row">

              <div class="col-xs-12 notifications">

                <div class="row">

                  <div class="col-md-12">

                    <div class="table-responsive">

                      <table class="table">

                        <thead>
                          <tr>
                            
                            <!-- <th class="f700">Image</th> -->
                             <th class="f700">Name</th>
                            <th class="f700">Email</th>
                            <th class="f700">Date Joined </th>
                            <th class="f700">Source</th>
                          </tr>
                        </thead>

                        <tbody>
                         {$reviewcount = 0}
  {foreach $refers as $key => $val}   
  {$reviewcount = 1}
  <tr class="account_p_lbl">
    <!-- <td data-label="Image" class="account_p_lbl"><a href=""><img width="50" height="50" src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['url']}/uploads/profile/{$val.avatar}{/if}" title="" alt="" align="center"></a></td> -->
    <td data-label="Name" class="account_p_lbl">{$val.first_name}</td>
    <td data-label="Email" class="account_p_lbl">{$val.email}</td>
    <td data-label="Joined" class="account_p_lbl">{$val.date_added}</td>
    <td data-label="Source" class="account_p_lbl">{$val.source}</td>
  </tr>
{/foreach}
                          

                        </tbody>

                      </table>
                      {if $reviewcount ==0}
   <div  class="account_p_lbl text-center">
         {$phrase.no_referrals_found} !
  </div>
{/if}
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
<script type="text/javascript" src="{$config['externaljs']}share.js"></script>
<script type="text/javascript">
   stLight.options({
                publisher:'6f0428f3-831e-4577-8e5c-e1fdc2d3292d',
        });
   </script>
{include file="store/store-js.tpl" nocache}

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog refer10" role="document">
    <div class="modal-content refer7">
      <div class="modal-header refer5">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" class="refer6">{$phrase.close}</span></button>
        <h4 class="modal-title " id="myModalLabel">{$phrase.select_your_email_service}</h4>
      </div>
      <div class="modal-body">
       <div class="col-md-12 refer4">
       <a href="#"><img src="{$config.url}/images/gm.png" /></a>
       <a href="#"><img src="{$config.url}/images/ym.jpg" /></a>
       <a href="#"><img src="{$config.url}/images/ot.jpg" /></a>
       <a href="#"><img src="{$config.url}/images/em.jpg" /></a>
       </div>
     
     <div class="col-md-12 refer4"><img src="{$config.url}/images/home/logo.png" alt="Auctionsoftware"></div>
     <!--<div class="col-md-6 refer8">{$phrase.powered_by} <a href="#"><img src="{$config.url}/images/sh.jpg" /> <span>Share This</span></a></div>-->
     <div class="col-md-6 refer9"><a href=""#>Sign in</a> <span> | </span><a href="#"> Do not track</a></div>

      </div>
    </div>
  </div>
</div>