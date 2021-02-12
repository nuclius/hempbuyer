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
                            <h1 class="boldtxs">{$pharse.current_plan_summary}</h1>
                            <p><span class="boldtxt">{$pharse.role_name_:} </span>{$plandetails.rolename}</P>
                            <p><span class="boldtxt">{$pharse.plan_name_:} </span>{$plandetails.plan_name}</P> 
                           <p> <span class="boldtxt">{$pharse.status_:} </span>{$plandetails.status}</P> 
                           <p>  <span class="boldtxt">{$pharse.renewal_period:} </span>{$plandetails.renewal_date}</P>
                           <p>  <span class="boldtxt">{$pharse.total_product_allowed_to_post_:} </span>{$project_limit}</P>
                           <p>  <span class="boldtxt">{$pharse.total_product_allowed_to_post_per_month_:} </span>{$monthly_project_limit}</P>
                           <p>  <span class="boldtxt">{$pharse.total_bids_allowed_to_place_:} </span>{$bid_limit}</P>
                           <p>  <span class="boldtxt">{$pharse.total_bids_allowed_to_place_per_month_:} </span>{$monthly_bid_limit}</P>

                            <p>  <span class="boldtxt">{$pharse.total_buy_now_allowed_to_place_:} </span>{$buynow_limit}</P>
                            <p>  <span class="boldtxt">{$pharse.C} </span>{$monthly_buynow_limit}</P>


                            <p>  <span class="boldtxt">{$pharse.total_attachment_limit_:} </span>{if $used_attach == 'Unlimited'} {$pharse.unlimited}{else} {$allowed_attach_limit} {$pharse.mb} {/if}</P>
</div>
                        </div>
                        <div class="form-group col-md-6">
                         <div class="col-md-12 jiva1w">
                            <h1 class="boldtxs">{$pharse.current_plan_usage_summary}</h1>
                            <p><span class="boldtxt">{$pharse.total_products_posted_:} </span>{$productcountyear}</P>
                            <p><span class="boldtxt">{$pharse.total_products_posted_this_month_:} </span>{$productcountmonth}</P> 
                            <span class="boldtxt">{$pharse.total_bids_placed_:} </span>{$bidcountyear}</P> 
                            <span class="boldtxt">{$pharse.total_bids_placed_this_month_:} </span>{$bidcountmonth}</P>

                             <span class="boldtxt">{$pharse.total_buy_now_:} </span>{$buynowcountyear}</P>
                             <span class="boldtxt">{$pharse.total_buy_now_this_month_:} </span>{$buynowcountmonth}</P>

                             <span class="boldtxt">{$pharse.total_used_space_:} </span>{if $monthly_bid_limit == 'Unlimited'} {$pharse.unlimited} {else}{convertKbToMb($used_attach_space)}  {$pharse.mb} {/if}</P>
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