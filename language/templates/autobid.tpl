{include file="common/header-1.tpl" nocache}
<div class="main_container">
  <div class="row dashboard">
    <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
    <div class="col-md-9">
      <form name="setautobid" action="/dashboard/autobid" method="post" data-parsley-validate required>
        <h4 class="ds_brd">{$pharse.auto_bid}</h4>
        <div class="row"> 
          <!--<div class="form-group">
            <label for="inputEmail" class="col-md-4" >Auction Types* :</label>
            <div class="col-md-8">
              <select class="form-control">
                <option>Select Auction Type</option>
                <option>Penny Auction</option>
                <option>Peak Auction</option>
              </select>
            </div>
          </div>--> 
        </div>
        <div class="row">
          <div class="form-group">
            <label for="inputEmail" class="col-md-4" >{$pharse.product_name*} :</label>
            <div class="col-md-8">
              <select name="project_id" class="form-control" id="loadmake" required>
                <option value="">{$pharse.select_product}</option>
                
                
                                
                         {foreach $project as $val}
                
                
                
                <option value="{$val.id}">{$val.title}</option>
                
                
                
                         {/foreach}
              
              
              
              </select>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="form-group">
            <label for="inputEmail" class="col-md-4" >{$pharse.autobid_amount} :</label>
            <div class="col-md-8">
              <input type="text" id="autobid_amt" name="amount" placeholder="Enter your Amount" value="" maxlength="20" class="form-control" required>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="form-group">
            <label for="inputEmail" class="col-md-4" >{$pharse.autobid_start* }:</label>
            <div class="col-md-8">
              <input type="text" id="autobid_start_amount" name="start_amount" placeholder="Enter your Autobid start product price" value="" maxlength="20" class="form-control" required>
              <div class="abid_lbl">{$pharse.auto_bid_start_bid_when_reach_your_product_current_price}</div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-4"></div>
          <div class="col-md-8">
            <button class="btn save_btn" type="submit">{$pharse.set_autobid}</button>
            <!--<div class="abid_lbl">No Autobid products at the moment</div>-->
          </div>
        </div>
      </form>
      <div class="row mblue_box">
      <div class="col-md-3">{$pharse.image}</div>
      <div class="col-md-3">{$pharse.title}</div>
      <div class="col-md-2">{$pharse.end_time} </div>
      <div class="col-md-2">{$pharse.balance} </div>
      <div class="col-md-2"> {$pharse.options}</div>
    </div>
    {if $Autobids|count <=  0}
    <div class="col-md-12 text-center m-top-20 font-12">{$pharse.no_results_found}</div>
    {else}
    {foreach $Autobids as $key => $alist}
    <div class="row mblue_box1">
      <div class="col-md-3"><a href=""><img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" title="{$val.title}" width="65" height="65"></a></div>
      <div class="col-md-3"><a href="{$config['url']}/product/view/{$val.id}" title="{$val.ptitle}"> {$alist.title}</a></div>
      <div class="col-md-2">{$alist.closedon}</div>
      <div class="col-md-2">{$alist.balance}</div>
      <div class="col-md-2"><a title="View" href="{$config['url']}/product/view/{$alist.id}">{$pharses.view}</a></div>
    </div>
    {/foreach}
    {/if}
    </div>
     </div>
</div>
{include file="common/footer-1.tpl" nocache} 