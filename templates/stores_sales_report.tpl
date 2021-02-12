{include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row nd-mg">
            <div class="col-xs-12 padlr content-area">
                 <div class="row nd-mg">
                <div class="row flex  ">
                    <!-- <form enctype="multipart/form-data" class="admin_form" method="get" enctype="multipart/form-data" action="{$config.url}/dashboard/market/research/report"> -->
                    <form enctype="multipart/form-data" class="admin_form" method="get" enctype="multipart/form-data" action="{$config.url}/stores/sales/report">
                        <div class="col-sm-3 margin-auto padboth">
                            <div class="input-group w100">
                                <div class="inner-addon right-addon">
                                    <i class="glyphicon glyphicon-calendar"></i>
                                    <input class="w100 p15 pb15 border1" data-parsley-trigger="change" type="text" id="start_date1" placeholder="Start Date" readonly="readonly" name="start_date" data-parsley-required data-parsley-required-message="Please select date" value="{$start_date}">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 margin-auto padboth">
                            <div class="input-group w100">
                                <div class="inner-addon right-addon">
                                    <i class="glyphicon glyphicon-calendar"></i>
                                    <input class="w100 p15 pb15 border1" data-parsley-trigger="change" type="text" id="start_date2" placeholder="End Date" readonly="readonly" name="end_date" data-parsley-required data-parsley-required-message="Please select date" value="{$end_date}">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 margin-auto padboth">
                            <div class="input-group w100">
                                <select class="w100 p15 pb15 border-0" name="category">
                                    <option value="">Sort by</option>
                                    {foreach $category as $key => $val}
                                        {if $val.parent_id == 0}
                                    <option {if $categoryId==$val.id}selected{/if} value="{$val.id}">{$val.name}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-2 padboth13">
                            <div class="input-group">
                                <button type="submit" class="btn btn-default btn-d-b green-b m0"> <i class="fa fa-search"></i> {$phrases.search}</button>
                            </div>
                        </div>
                        <div class="col-sm-1 padboth13">
                            <div class="input-group">
                                <a href="{$config.url}/stores/sales/download" class="btn btn-default btn-d-b green-b m0"> <i class="fa fa-download"></i></a>
                            </div>
                        </div>
                    </form>
                </div>
                     </div>
                <div class="row">
                    <div class="col-md-12 white-bg shadow p0">
                        <div class="table-responsive cus-table style-1c">
                            <table class="table m-b-0">
                                <thead class="green-b white p15">
                                    <tr>
                                        <th>Product Sold({$list.length})</th>
                                        <th>Category</th>
                                        <th>Sub Category</th>
                                        <th>Purchase Type</th>
                                        <th>My Avg Transaction Price / lb<sup>(1)</sup></th>
                                        <th>Market Avg Transaction Price</th>
                                        <th>My Price VS Mkt</th>
                                        <th>My Volume<sup>(2)</sup></th>
                                        <th>Market Volume</th>
                                        <th>My Mkt Share Volume</th>
                                        <th>Paid Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {$listcount =0}

                                <tr colspan="11"></tr>
                                    {foreach $list as $key => $val}
                                {$listcount =1}
                                    <tr>
                                        <!-- {$val.id} -->
                                        <td>{$val.p_title}</td>
                                        <td>{$val.parent_cat_name}</td>
                                        <td>{$val.cat_name}</td>
                                        <td>{if $val.recurring_id>0} Recurring {/if} {if $val.recurring_id==0}Single {/if}</td>
                                        <td>{($val.p_unit_price)|round:2}/{$val.short_unit}</td>

                                        <td>
                                         {$val.mk_price = 0.00}   
                                         {$val.$mk_vol = 0.00}   

                                        {if $val.parent_cat_name == 'Flower'}
                                            {$research_data.avg_flower_amt}/{$val.short_unit}
                                            {$val.mk_price = $research_data.avg_flower_amt}
                                            {$mk_vol = $research_data.total_flower_qty}
                                        {/if}

                                        {if $val.parent_cat_name == 'Dry Concentrates'}
                                            {$research_data.avg_dryc_amt}/{$val.short_unit}
                                            {$val.mk_price = $research_data.avg_dryc_amt}
                                            {$mk_vol = $research_data.total_dryc_qty}
                                        {/if}

                                        <!-- new -->
                                       {if $val.parent_cat_name == 'Oil Concentrates'}
                                            {$research_data.avg_oilc_amt}/{$val.short_unit}
                                            {$val.mk_price = $research_data.avg_oilc_amt}
                                            {$mk_vol = $research_data.total_oilc_qty}
                                        {/if}

                                        {if $val.parent_cat_name == 'Edibles'}
                                            {$research_data.avg_edible_amt}/{$val.short_unit}
                                            {$val.mk_price = $research_data.avg_edible_amt}
                                            {$mk_vol = $research_data.total_edible_qty}
                                        {/if}
                                        {if $val.parent_cat_name == 'Topicals'}
                                            {$research_data.avg_topical_amt}/{$val.short_unit}
                                            {$val.mk_price = $research_data.avg_topical_amt}
                                            {$mk_vol = $research_data.total_topical_qty}
                                        {/if}
                                        </td>
                                        <td>{parseFloat(($val.mk_price - $val.p_unit_price).toFixed(2)}/{$val.short_unit}</td>
                                        <td>{$val.i_qty}</td>
                                        <td>{$mk_vol} {$val.short_unit}</td>
                                        <td> {parseFloat(($val.i_qty / $mk_vol) * 100).toFixed(2)}%;</td>
                                        <td>{$val.paid_date}</td>
                                    </tr>
                                    {/foreach}
                                {if $listcount == 0}
                                <tr>
                                    <td colspan="10">
                                        No Search Results Found !
                                    </td>
                                </tr>
                                {/if}

                                    <!-- <tr>
                                        <td>Sour Diesel</td>
                                        <td>Flower</td>
                                        <td>Hybrid</td>
                                        <td>4530</td>
                                        <td>4510</td>
                                        <td>-80</td>
                                        <td>2</td>
                                        <td>4</td>
                                        <td>5%</td>
                                    </tr>
                                    <tr>
                                        <td>Sour Diesel</td>
                                        <td>Flower</td>
                                        <td>Hybrid</td>
                                        <td>4530</td>
                                        <td>4510</td>
                                        <td>-80</td>
                                        <td>2</td>
                                        <td>4</td>
                                        <td>5%</td>
                                    </tr>
                                    <tr>
                                        <td>Sour Diesel</td>
                                        <td>Flower</td>
                                        <td>Hybrid</td>
                                        <td>4530</td>
                                        <td>4510</td>
                                        <td>-80</td>
                                        <td>2</td>
                                        <td>4</td>
                                        <td>5%</td>
                                    </tr>
                                    <tr>
                                        <td>Sour Diesel</td>
                                        <td>Flower</td>
                                        <td>Hybrid</td>
                                        <td>4530</td>
                                        <td>4510</td>
                                        <td>-80</td>
                                        <td>2</td>
                                        <td>4</td>
                                        <td>5%</td>
                                    </tr>
                                    <tr>
                                        <td>Sour Diesel</td>
                                        <td>Flower</td>
                                        <td>Hybrid</td>
                                        <td>4530</td>
                                        <td>4510</td>
                                        <td>-80</td>
                                        <td>2</td>
                                        <td>4</td>
                                        <td>5%</td>
                                    </tr> -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="pagination">
                        {$pagination_html}
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
{include file="common/footer-1.tpl" nocache}
<script type="text/javascript">
$('#pagination').find('ul').addClass('pagination-ul flex m50 m-b-0');
$('#pagination').find('ul').removeClass('pagination');
</script>
<script type="text/javascript">

    var dt = '{$serverdate}';


    var logic1 = function( currentDateTime ){
        var  begD  = new Date(currentDateTime)
        var  endD = new Date($("#start_date2").val());
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#start_date2").val('');
        }else if (endD !='Invalid Date' && begD > endD) {
            alert('Start Date Must Be less Than End date');
            $("#start_date1").val('');
        }
    };
    $("#start_date1").datetimepicker({
        inline:false,
        step:01,
        onChangeMonth:logic1,
        onSelectDate:logic1,
        maxDate:dt,

    });
    var logic = function( currentDateTime ){
        var  begD  = new Date($("#start_date1").val());
        var  endD = new Date(currentDateTime);
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#start_date2").val('');
        }else if (begD > endD) {
            alert('End Date Must Be Greater Than Start date');
            $("#start_date2").val('');
        }
    };
    $("#start_date2").datetimepicker({
        step:01,
        onChangeMonth:logic,
        onSelectDate:logic,
        showHeader:2,
        maxDate:dt,
    });


/*

$("#start_date1").datetimepicker({
    timepicker: true,
    format: 'd/m/Y h:i',
    step: 5,
    maxDate: 0,
    onChangeMonth:logic,
    onSelectDate:logic,
    // minTime: 0,

});





$("#start_date2").datetimepicker({
    timepicker: true,
    format: 'd/m/Y h:i',
    step: 5,
    minDateTime: 0,
});*/
</script>
</body>

</html>
