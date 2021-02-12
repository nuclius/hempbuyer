{include file="/admincp/header.tpl" nocache}
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" /> -->
<style>
.all_fields {
    display: none;
}
</style>
<div class="container-fluid">
    <!-- Page Heading -->
    <div class="row controls">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    <!-- <i class="fa fa-sitemap"></i> -->{$phrases.report_management} </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12 reports1">
            {$phrases.report_management_gives_you_direct_access}
        </div>
        <form action="{$config.url}/admincp/reports_create" data-parsley-validate method="post" id="reports_form" class="form-horizontal">
            <div class="col-md-10">
                <input type="hidden" name="id" value="" />
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$phrases.action}</label>
                    <div class="col-sm-6">
                        <select class="form-control" name="type">
                            <!--  <option value="list">Show Report Listings in Table Format</option> -->
                            <option value="csv">Download Report as a CSV File</option>
                            <!-- <option value="dsp">Display Report</option> -->
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label"> {$phrases.report}</label>
                    <div class="col-sm-6">
                        <select class="form-control" name="reports" id="reports">
                            <option value="">Select report to generate:</option>
                            <optgroup label="User" class="user">
                                <option value="all">all</option>
                                <option value="pending">Pending</option>
                                <option value="active">Active</option>
                                <option value="suspended">Suspended</option>
                                <option value="deleted">Deleted</option>
                            </optgroup>
                            <optgroup label="Products" class="products">
                                <option value="allp">all items</option>
                                <option value="open">Opened items</option>
                                <option value="close">Closed item</option>
                                <option value="db">Direct buy items</option>
                                <option value="ob">Open bid items</option>
                            </optgroup>
                            <optgroup label="Ads" class="ads">
                                <option value="allads">All ads</option>
                            </optgroup>
                            <optgroup label="Risk Management" class="riskmgt">
                                <option value="allr">All</option>
                            </optgroup>
                            <optgroup label="Payments" class="payment">
                                <option value="allpayreq">All payments requests</option>
                            </optgroup>
                            <optgroup label="Relationship" class="relationship">
                                <option value="allrel">All</option>
                            </optgroup>
                            <optgroup label="Reviews" class="reviews">
                                <option value="allreviews">All reviews</option>
                            </optgroup>
                            <optgroup label="Transactions" class="transactions">
                                <option value="alltransactions">All transactions</option>
                            </optgroup>
                        </select>
                    </div>
                </div>
                <div class="col-md-12 reports2">
                    {$phrases.report_management}
                </div>
                <div class="defaults">{$phrases.please_select_a_report}</div>
                <!-- Fields for Risk Management -->

 
                <div class="riskmgt all_fields">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.fields}</label>
                        <div class="col-sm-8">

                           <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="rid" id="rid" value="1" checked="checked"> ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="user_id" id="user_id" value="1" checked="checked"> User name
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="project_id" id="project_id" value="1" checked="checked"> Product id
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="date_added" id="date_added" value="1" checked="checked"> Created date
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="frequency" id="frequency" value="1" checked="checked"> Frequency
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="count" id="count" value="1" checked="checked"> Frequency count
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="quantity" id="quantity" value="1" checked="checked"> Quantity
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="amount" id="amount" value="1" checked="checked"> Amount
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="sdate" id="sdate" value="1" checked="checked"> Start date
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="edate" id="edate" value="1" checked="checked"> End Date
                                    </label>
                                </div>
                            </div>
<div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="cancellation" id="cancellation" value="1" checked="checked"> Cancellation Insurance
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="cancelled" id="cancelled" value="1" checked="checked"> Cancel status
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="paid" id="paid" value="1" checked="checked"> Payment status
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="status" id="status" value="1" checked="checked"> Active status
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="store_id" id="store_id" value="1" checked="checked"> Checkout ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="product_id" id="product_id" value="1" checked="checked"> Status
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="cancellation_per" id="cancellation_per" value="1" checked="checked"> Cancellation percentage
                                    </label>
                                </div>
                                <!-- <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="cancelreq" id="cancelreq" value="1" checked="checked"> Buyer cancel request
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="sapprove_status" id="sapprove_status" value="1" checked="checked"> seller cancel request
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="end_date" id="end_date" value="1" checked="checked"> Seller approval
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="end_date" id="end_date" value="1" checked="checked"> Seller approved date
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="end_date" id="end_date" value="1" checked="checked"> Admin approval
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="end_date" id="end_date" value="1" checked="checked"> Admin approved date
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="end_date" id="end_date" value="1" checked="checked"> Canceled status
                                    </label>
                                </div> -->

                                <div id="paid_field" class="checkbox">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.tools}</label>
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sell_name" id="sell_name" value="1"> {$phrases.if_you_would_like_to_convert}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <!---Fields for sellers-->
                <div class="ufields all_fields">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.fields}</label>
                        <div class="col-sm-8">
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="user_id" id="user_id" value="1" checked="checked"> User ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="first_name" id="first_name" value="1" checked="checked"> First name
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="last_name" id="last_name" value="1" checked="checked"> Last name
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="username" id="username" value="1" checked="checked"> Username
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="email" id="email" value="1" checked="checked"> Email ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="create_date" id="create_date" value="1" checked="checked"> Date of Joined
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="updated_date" id="updated_date" value="1" checked="checked"> Last updated date
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="phone" id="phone" value="1" checked="checked"> Phone
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="address" id="address" value="1" checked="checked"> Address
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="country" id="country" value="1" checked="checked"> Country
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="state" id="state" value="1" checked="checked"> State
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="city" id="city" value="1" checked="checked"> City
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="region" id="region" value="1" checked="checked"> Region
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="zipcode" id="zipcode" value="1" checked="checked"> Zipcode
                                    </label>
                                </div>
                                <div id="paid_field" class="checkbox">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.tools}</label>
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sell_name" id="sell_name" value="1"> {$phrases.if_you_would_like_to_convert}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Fields for ads -->
                <div class="adsfields all_fields">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.fields}</label>
                        <div class="col-sm-8">

                           <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="adid" id="adid" value="1" checked="checked"> ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="ad_name" id="ad_name" value="1" checked="checked"> Ad name
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="ad_title" id="ad_title" value="1" checked="checked"> Ad title
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="ad_content" id="ad_content" value="1" checked="checked"> Content
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="ad_url" id="ad_url" value="1" checked="checked"> Ad url
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="featured" id="featured" value="1" checked="checked"> Featured
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="budget_per_click" id="budget_per_click" value="1" checked="checked"> Budget per click
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="budget_per_day" id="budget_per_day" value="1" checked="checked"> Budget per day
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="user_id" id="user_id" value="1" checked="checked"> User ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="created_at" id="created_at" value="1" checked="checked"> Created Date
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="updated_at" id="updated_at" value="1" checked="checked"> Updated Date
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="status" id="status" value="1" checked="checked"> Ad Status
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="no_of_clicks" id="no_of_clicks" value="1" checked="checked"> Number of Clicks
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="no_of_views" id="no_of_views" value="1" checked="checked"> Number of Views
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="store_id" id="store_id" value="1" checked="checked"> Store ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="product_id" id="product_id" value="1" checked="checked"> Product ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="start_day" id="start_day" value="1" checked="checked"> Start Day
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="end_date" id="end_date" value="1" checked="checked"> End Day
                                    </label>
                                </div>

                                <div id="paid_field" class="checkbox">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.tools}</label>
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sell_name" id="sell_name" value="1"> {$phrases.if_you_would_like_to_convert}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="pfields all_fields">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.fields}</label>
                        <div class="col-sm-8">
                            <div class="col-md-4 col-sm-4">
<!--                                 <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="pid" id="pid" value="1" checked="checked"> {$phrases.product_id}
                                    </label>
                                </div> -->
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="pkey" id="pkey" value="1" checked="checked"> Product ID
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="pname" id="pname" value="1" checked="checked"> {$phrases.product_name}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="qty" id="qty" value="1" checked="checked"> {$phrases.quantity}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="pdate_added" id="pdate_added" value="1" checked="checked"> {$phrases.create_date}
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="sid" id="sid" value="1" checked="checked"> {$phrases.seller_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="p_amount" id="p_amount" value="1" checked="checked"> {$phrases.total_amount}
                                    </label>
                                </div>
                                <!-- <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="s_amount" id="s_amount" value="1" checked="checked"> {$phrases.shipping_amount}
                                    </label>
                                </div> -->
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="sold_item" id="sold_item" value="1" checked="checked"> {$phrases.sold}
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="ptype" id="ptype" value="1" checked="checked"> {$phrases.product_type}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="trading_type" id="trading_type" value="1" checked="checked"> Trading Type </label>
                                </div>
                                <!-- <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="dclosed" id="dclosed" value="1" checked="checked"> {$phrases.date_closed}
                                    </label>
                                </div> -->
                                <div id="paid_field" class="checkbox">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.tools}</label>
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sell_name" id="sell_name" value="1"> {$phrases.if_you_would_like_to_convert}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <!---Fields for sellers Ends-->
                <!---Fields for buyers-->
                <div class="bfields all_fields">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.fields}</label>
                        <div class="col-sm-8">
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="p_id" id="p_id" value="1" checked="checked"> {$phrases.product_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="p_name" id="p_name" value="1" checked="checked"> {$phrases.product_name}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="amt" id="amt" value="1" checked="checked"> {$phrases.amount}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="r_date" id="r_date" value="1" checked="checked"> {$phrases.release_date}
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="bid" id="bid" value="1" checked="checked"> {$phrases.buyer_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="slid" id="slid" value="1" checked="checked"> {$phrases.seller_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="p_type" id="p_type" value="1" checked="checked"> {$phrases.product_type}
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.tools}</label>
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="seller" id="seller" value="1"> {$phrases.if_you_would_like_to_add_the_seller_username}
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="buyer" id="buyer" value="1"> {$phrases.if_you_would_like_to_add_the_buyer_username}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <!---Fields for buyers ends-->
                <!---Fields for commsiion-->
                <div class="cfields all_fields">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.fields}</label>
                        <div class="col-sm-8">
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="pc_id" id="p_id" value="1" checked="checked"> {$phrases.product_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="pc_name" id="pc_name" value="1" checked="checked"> {$phrases.product_name}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="pc_amt" id="pc_amt" value="1" checked="checked"> {$phrases.amount}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="rc_date" id="rc_date" value="1" checked="checked"> {$phrases.release_date}
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="secid" id="secid" value="1" checked="checked"> {$phrases.seller_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="byid" id="byid" value="1" checked="checked"> {$phrases.buyer_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="comm_amt" id="comm_amt" value="1" checked="checked"> {$phrases.commission}
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.tools}</label>
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="c_seller" id="c_seller" value="1"> {$phrases.if_you_would_like_to_add_the_seller_username}
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="c_buyer" id="c_buyer" value="1"> {$phrases.if_you_would_like_to_add_the_buyer_username}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <!---Fields for commisiion ends-->
                <!---Fields for invoices ends-->
                <div class="ifields all_fields">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.fields}</label>
                        <div class="col-sm-8">
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="invoiceid" id="invoiceid" value="1" checked="checked"> {$phrases.invoice_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="invoiceamt" id="invoiceamt" value="1" checked="checked"> {$phrases.invoice_amount}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="proid" id="proid" value="1" checked="checked"> {$phrases.product_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="date_added" id="date_added" value="1" checked="checked"> {$phrases.create_date}
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="uid" id="uid" value="1" checked="checked"> {$phrases.user_id}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="t_amount" id="t_amount" value="1" checked="checked"> {$phrases.total_amount}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="istatus" id="istatus" value="1" checked="checked"> {$phrases.invoice_status}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="transid" id="transid" value="1"> {$phrases.transaction_id}
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="desc" id="desc" value="1" checked="checked"> {$phrases.description}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="itype" id="itype" value="1" checked="checked"> {$phrases.invoice_type}
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="amtpaid" id="amtpaid" value="1" checked="checked"> {$phrases.amount_paid}
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">{$phrases.tools}</label>
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" id="username" name="username" value="1"> {$phrases.if_you_would_like_to_add_the_user_id_field}
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" id="productname" name="productname" value=""> {$phrases.if_you_would_like_to_add_the_product_id_field}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 reports2">{$phrases.customize_your_report_using_a_wide_variety}</div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$phrases.within}</label>
                    <div class="col-sm-10">
                        <div class="radio">
                            <label>
                                <input type="radio" id="within" name="optionsRadios" value="fixed">
                                <select name="rangepast" id="rangepast" class="form-control" style="margin-left:23px;">
                                    <option value="day">The Past Day</option>
                                    <option value="week">The Past Week</option>
                                    <option value="month">The Past Month</option>
                                    <option value="year">The Past Year</option>
                                </select>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-10">
                        <div class="col-sm-1 reports4" style="padding-left:0;">
                            <input type="radio" id="range" name="optionsRadios" checked>
                        </div>
                        <div class="col-sm-2 reports3">
                            <input type="text" id="from_date" name="fromdate" class="form-control days date-picker" placeholder="2015-01-01" style="background-color: #fff !important;" readonly='true'>
                        </div>
                        <div class="col-sm-1 reports4">
                            <span>{$phrases.to}</span>
                        </div>
                        <div class="col-sm-2 reports3">
                            <input type="text" id="to_date" name="todate" class="form-control days date-picker" style="background-color: #fff !important;" placeholder="2015-01-01" readonly='true'>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 reports2">{$phrases.order_your_results_based_on_ascending}</div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$phrases.order_results}</label>
                    <div class="col-sm-10">
                        <label class="radio-inline">
                            <input type="radio" name="orderradio" id="inlineRadio1" value="asc" checked="checked"> {$phrases.ascending}
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="orderradio" id="inlineRadio2" value="desc"> {$phrases.descending}
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-2">
                        <input type="text" name="limit_results" id="limit_results" placeholder="100" class="form-control" />
                    </div>
                </div>
                <div class="col-md-12 form-group">
                    <button name="submit" class="btn btn-success">{$phrases.create_report}</button>
                </div>
            </div>
        </form>
    </div>
</div>
{include file="/admincp/footer.tpl" nocache}
<script>
$(document).ready(function(e) {
    $('#reportslist').hide();
    $('#reports').on('change', function() {
        $('.tables').hide();
        var selected = $(':selected', this);
        var group = selected.closest('optgroup').attr('class');

        // <optgroup label="Ads" class="ads">
        //                         <option value="allads">All ads</option>
        //                     </optgroup>
        //                     <optgroup label="Risk Management" class="riskmgt">
        //                         <option value="allr">All</option>
        //                     </optgroup>
        //                     <optgroup label="Payments" class="payment">
        //                         <option value="allpayreq">All payments requests</option>
        //                     </optgroup>
        //                     <optgroup label="Relationship" class="relationship">
        //                         <option value="allrel">All</option>
        //                     </optgroup>
        //                     <optgroup label="Reviews" class="reviews">
        //                         <option value="allreviews">All reviews</option>
        //                     </optgroup>
        //                     <optgroup label="Transactions" class="transactions">
        //                         <option value="alltransactions">All transactions</option>
        //                     </optgroup>
        // <optgroup label="Products" class="products">
        //                         <option value="allp">all items</option>
        //                         <option value="open">Opened items</option>
        //                         <option value="close">Closed item</option>
        //                         <option value="db">Direct buy items</option>
        //                         <option value="ob">Open bid items</option>
        //                     </optgroup>

        if (group == 'ads') {

            $('.defaults').hide();
            $('.all_fields').hide();
            $('.adsfields').show();
        }

        if (group == 'user') {

            $('.defaults').hide();
            $('.all_fields').hide();
            $('.ufields').show();
        }

        if (group == 'products') {

            $('.defaults').hide();
            $('.all_fields').hide();
            $('.pfields').show();
        }

        if (group == 'invoices') {
            $('.defaults').hide();
            $('.all_fields').hide();
            $('.ifields').show();
        }
        if (selected.val() == '') {

            $('.all_fields').hide();
            $('.defaults').show();
        }
        if (group == 'invoices') {
            $('.defaults').hide();
            $('.all_fields').hide();
            $('.ifields').show();
        }

        

        if (group == 'sold') {

            $('.defaults').hide();
            $('.all_fields').hide();
            $('.pfields').show();

            if (selected.val() == 'ssold') {
                $('#paid_field').html('<label><input type="checkbox" name="paid_date" id="paid_date" value="1" checked="checked"> Paid Date </label>');

            } else {

                $('#paid_field').html('');

            }
        }

        if (group == 'buy') {

            $('.defaults').hide();
            $('.all_fields').hide();
            $('.bfields').show();
        }

        if (group == 'commission') {

            $('.defaults').hide();
            $('.all_fields').hide();
            $('.cfields').show();
        }
    });

    $('#print').click(function() {

        $('form').hide();
        $('#reportslist').show();
        window.scrollTo(0, 0);

    });

    $('#within').click(function() {
        if ($('#within').is(':checked')) {
            $('#from_date').val('');
            $('#to_date').val('');
        }

    });

    $("#reports_form").submit(function(e) {
        if ($('#range').is(':checked')) {
            if ($('#from_date').val() != '' && $('#to_date').val() != '') {

            } else {
                alert('Please select a Date Range');
                e.preventDefault();
            }
        }
        if ($('#reports').val() === '') {
            e.preventDefault();
            alert('Please select a report');
        }
    });

    $('#rangepast').change(function() {

        $('#within').prop('checked', true);
        $('#range').prop('checked', false);
    });
    $('.days').change(function() {

        $('#range').prop('checked', true);
        $('#within').prop('checked', false);

    });


});
</script>
<script language="javascript" type="text/javascript">
$(function() {
    Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'yyyy-mm-dd';
    $("#from_date").datePicker({
        clickInput: false,
        createButton: false,
        showYearNavigation: false,
        showHeader: 2
    }).bind(
        'focus click keydown',
        function() {
            $("#from_date").dpRerenderCalendar();
            $("#from_date").dpSetStartDate('2012-02-01');
            //$(obj).dpSetStartDate($("#funddater_"+curid).val());
            $("#from_date").dpDisplay();
        }
    );

    $("#to_date").datePicker({
        clickInput: false,
        createButton: false,
        showYearNavigation: false,
        showHeader: 2
    }).bind(
        'focus click keydown',
        function() {
            $("#to_date").dpRerenderCalendar();
            $("#to_date").dpSetStartDate($("#from_date").val());
            //$(obj).dpSetStartDate($("#funddater_"+curid).val());
            $("#to_date").dpDisplay();
        }
    );

});
</script>