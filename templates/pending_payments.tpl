 {include file="common/header-1.tpl" nocache}
<link rel="stylesheet" href="{$config['externalcss']}jquery.datetimepicker.css" type="text/css" />
<style media="screen">
.loader_div .loader {
    height: 63px;
    margin-top: 20%;
    margin-left: 47%;
}

.loader_div {
    background: rgb(0, 0, 0);
    background: transparent;
    background: rgba(0, 0, 0, 0.5);
    /* FF3+,Saf3+,Opera 10.10+,Chrome,IE9*/
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#7f000000, endColorstr=#7f000000);
    /*IE 5.5-7*/
    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#7f000000,endColorstr=#7f000000)";
    /*IE8*/
    zoom: 1;
    width: 100%;
    height: 100%;
    z-index: 104;
    position: fixed;
    display: block;
    top: 0;
    left: 0;
}

.category-heading img {
    display: inline-block;
    margin-right: 6px;
}

.activecat {
    font-weight: bold;
}

.tqtytext {
    color: red;
}
</style>
<!--  <div class="loader_div">
     <img src="{$config.url}/images/ajaxloader.gif" alt="" class='loader'>
 </div> -->
{include file="store/css-store.tpl" nocache}
<style>
.img-info {
    left: 0;
    position: absolute;
    top: 10%;
}

.bck-img {
    height: auto;
    width: 100%;
}

.carousel-control.right {
    background-image: none;
    top: 165px;
    right: -100px;
}

.carousel-control.left {
    background-image: none;
    top: 165px;
    left: -95px;
    ;
}

.gry_but span {
    background: rgba(0, 0, 0, 0) url("/images/home/textbutton.png") no-repeat scroll 0 -96px;
    color: #5d5f62;
    display: block;
    font-family: Arial, Helvetica, sans-serif !important;
    font-size: 11px !important;
    font-weight: bold;
    margin-right: 7px;
    padding: 8px 3px 9px 10px;
    text-align: center;
}

#fac_id {
    float: left;
    margin-top: 0;
    display: none;
}

#twi_id {
    float: left;
    margin-top: 0;
    display: none;
}

#goo_id {
    float: left;
    margin-top: 0;
    display: none;
}

#web_id {
    display: none;
    float: left;
    margin-top: 0;
}

.dropup {
    float: right;
}

.store-head .bt-info .btn-group .btn:focus {
    box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
    border: 2px solid #ccc;
    background: #f9f8f8;
}

.store-head .bt-info .btn-group .btn.active:focus {
    background: #e5e5e5;
    box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
    border: 2px solid rgba(85, 85, 85, 0.55);
}

.right {
    margin: 10px 0;
    float: right;
    cursor: pointer;
    display: inline-block;
}
</style>
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row">
            <div class="col-md-3 sidebar  mb-25  mb-25">
                <div class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown">Sales Support <i class="fa fa-angle-down"></i></a>
                    {include file="common/dashboard_settings_menu.tpl" nocache}
                </div>
            </div>
            <div class="col-md-9 content-area">
                <div class="row">
                    <div class="panel panel-success m5 m-t-0">
                        <div class="panel-heading green-bg">
                            <h3>Pending Payments</h3>
                        </div>
                    </div>
                    <div class=" white-bg-2 shadow">
                        <div class="table-responsive">
                            <table class="table table-bordered1 table-hover">
                                <thead>
                                    <tr>
                                        <th>Product ID</th>
                                        <th>Product Name</th>
                                        <th>Payment Price</th>
                                        <th>Payment Status</th>
                                        <th>Invoice</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $payments as $key => $val}
                                    <tr>
                                        <td>
                                            <a target="_blank" href="{$config.url}/product/view/{$val.id}">{$val.id}</a>
                                        </td>
                                        <td>
                                            {$val.title}
                                        </td>
                                        <td>
                                            {$val.d_price}
                                        </td>
                                        <td>
                                            <b>
                                                {if $val.d_payment_status==1}<span class="text-success">Success</span>{/if}
                                                {if $val.d_payment_status==0}<span class="text-danger">Pending</span>{/if}
                                            </b>
                                        </td>
                                        <td>
                                            <a target="_blank" href="{$config['url']}/uploads/d_invoice/{$val.d_invoice}">{$val.d_invoice}</a>
                                        </td>
                                        <td>
                                            {if $val.d_price > 0 && $val.d_payment_status==0}
                                                <a name="paybtn" class="btn btn-success" href="{$config.url}/profile_settings/pay_pending_payment/{$val.id}/{$val.d_price}">Pay</a>
                                            {/if}
                                        </td>
                                    </tr>
                                    {/foreach} 
                                    {if $payments.length == 0}
                                    <tr>
                                        <td colspan="5">
                                            No payments found !
                                        </td>
                                    </tr>
                                    {/if}
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
{include file="common/footer-1.tpl" nocache}
</body>

</html>
<script type="text/javascript" src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script src="{$config.url}/js/mtree.js"></script>
<script src="{$config.url}/js/jcrop.js"></script>
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jcrop.css" />
<script type="text/javascript" src="{$config.url}/js/owl.carousel.js"></script>
<!-- <script src="https://auctionsoftwaremarketplace.com:2002/js/owl.carousel.js"></script> -->