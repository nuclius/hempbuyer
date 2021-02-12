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
<style>
    .title .title-name {
        font-size: 16px border : 1 px solid #000000;
        white-space: nowrap;
        overflow: hidden;
    }

    .pad0 {
        padding-right: 0px;
        padding-left: 0px;
    }
    .boldtxt
    {
        font-weight: bold;
    }
    .boldtxs
    {
              font-weight: bold;
                  font-size: 24px;
				      margin-bottom: 10px;
  
    }
	.jiva1w{
		border: 1px solid #ccc;
    border-radius: 10px;
    padding-left: 20px;
    padding-top: 20px;
    min-height: 295px;
    background-color: #EFEFEF;
	}
</style>
<link rel="stylesheet" type="text/css" href="{$config.url}/css/membershiptable.css"/>
<div class="main_container">
    <div class="row dashboard membership_select">

        <div class="col-lg-12">
            <div class="row">
                <div class="col-md-12" style="line-height:27px;">
                    <div class="row">
                        <div class="form-group col-md-6">
                        <div class="col-md-12 jiva1w">
                            <h1 class="boldtxs">{$phrase.current_plan_summary}</h1>
                            <p><span class="boldtxt">{$phrase.role_name} : </span>{$plandetails.rolename}</P>
                            <p><span class="boldtxt">{$phrase.plan_name} : </span>{$plandetails.plan_name}</P> 
                           <p> <span class="boldtxt">{$phrase.status} : </span>{$plandetails.status}</P> 
                           <p>  <span class="boldtxt">{$phrase.renewal_period}: </span>{$plandetails.renewal_date}</P>
                           <p>  <span class="boldtxt">{$phrase.total_product_allowed_to_post} : </span>{$project_limit}</P>
                           <p>  <span class="boldtxt">{$phrase.total_product_allowed_to_post_per_month} : </span>{$monthly_project_limit}</P>
                           <p>  <span class="boldtxt">{$phrase.total_bids_allowed_to_place} : </span>{$bid_limit}</P>
                           <p>  <span class="boldtxt">{$phrase.total_bids_allowed_to_place_per_month} : </span>{$monthly_bid_limit}</P>

                            <p>  <span class="boldtxt">{$phrase.total_buy_now_allowed_to_place} : </span>{$buynow_limit}</P>
                            <p>  <span class="boldtxt">{$phrase.total_buy_now_allowed_to_per_month} : </span>{$monthly_buynow_limit}</P>


                            <p>  <span class="boldtxt">{$phrase.total_attachment_limit} : </span>{if $used_attach == 'Unlimited'} Unlimited {else} {$allowed_attach_limit} MB {/if}</P>
</div>
                        </div>
                        <div class="form-group col-md-6">
                         <div class="col-md-12 jiva1w">
                            <h1 class="boldtxs">{$phrase.current_plan_usage_summary}</h1>
                            <p><span class="boldtxt">{$phrase.total_products_posted} : </span>{$productcountyear}</P>
                            <p><span class="boldtxt">{$phrase.total_products_posted_this_month} : </span>{$productcountmonth}</P> 
                            <span class="boldtxt">{$phrase.total_bids_placed} : </span>{$bidcountyear}</P> 
                            <span class="boldtxt">{$phrase.total_bids_placed_this_month} : </span>{$bidcountmonth}</P>

                             <span class="boldtxt">{$phrase.total_buy_now} : </span>{$buynowcountyear}</P>
                             <span class="boldtxt">{$phrase.total_buy_now_this_month} : </span>{$buynowcountmonth}</P>

                             <span class="boldtxt">{$phrase.total_used_space} : </span>{if $monthly_bid_limit == 'Unlimited'} Unlimited {else}{convertKbToMb($used_attach_space)}  MB {/if}</P>
</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                        </div>
                        <div class="col-md-6">
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
{include file="common/footer-1.tpl" nocache}