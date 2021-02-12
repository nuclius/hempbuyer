{include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row nd-mg">
            <div class="col-xs-12 padlr content-area">
                 <div class="row nd-mg">
                <div class="row flex ">
                    <form enctype="multipart/form-data" class="admin_form" method="get" enctype="multipart/form-data" action="{$config.url}/dashboard/market/research/report">
                        <div class="col-sm-3 margin-auto padboth">
                            <div class="input-group w100">
                                <input class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change" type="text" id="start_date1" placeholder="Date Requested" readonly="readonly" name="start_date" data-parsley-required data-parsley-required-message="Please select date" value="{$start_date}">
                                <span class="input-group-addon" id="basic-addon2">
                              <i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
                            </div>
                        </div>
                        <div class="col-sm-3 margin-auto padboth">
                            <div class="input-group w100">
                                <input class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change" type="text" id="start_date2" placeholder="Date Requested" readonly="readonly" name="end_date" data-parsley-required data-parsley-required-message="Please select date" value="{$end_date}">
                                <span class="input-group-addon" id="basic-addon2">
                              <i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
                            </div>
                        </div>
                        <div class="col-sm-3 margin-auto padboth">
                            <div class="input-group w100">
                                <select class="w100 p15 pb15 border-0" name="sortby">
                                    <option value="">Sort By</option>
                                    <option {if $sortby == 'Flower'} selected {/if} value="Flower">Flower</option>
                                    <option {if $sortby == 'Edible'} selected {/if} value="Edible">Edible</option>
                                    <option {if $sortby == 'Concentrate'} selected {/if} value="Concentrate">Concentrate</option>
                                    <option {if $sortby == 'Hybrid'} selected {/if} value="Hybrid">Hybrid</option>
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
                                <a href="{$config.url}/dashboard/market/research/download" class="btn btn-default btn-d-b green-b m0"> <i class="fa fa-download"></i></a>
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
                                        <th>Product Purchased</th>
                                        <th>Category</th>
                                        <th>Sub Category</th>
                                        <th>My Avg Transaction Price / lb<sup>(1)</sup></th>
                                        <th>Market Avg Transaction Price</th>
                                        <th>My Price VS Mkt</th>
                                        <th>My Volume<sup>(2)</sup></th>
                                        <th>Market Volume</th>
                                        <th>My Mkt Share Volume</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $list as $key => $val}
                                    <tr>
                                        <!-- {$val.id} -->
                                        <td>{$val.p_title}</td>
                                        <td>{$val.parent_cat_name}</td>
                                        <td>{$val.cat_name}</td>
                                        <td>{$val.p_unit_price}/{$val.short_unit}</td>

                                        {if $val.parent_cat_name == 'Flower'}
                                                {$val.mk_price = $research_data.avg_flower_amt}
                                                {$mk_vol = $research_data.total_flower_qty}
                                                <!-- <td>{$val.mk_price}/{$val.short_unit}</td> -->
                                                <td>{$research_data.avg_flower_amt}/{$val.short_unit}</td>
                                        {/if}

                                        {if $val.parent_cat_name == 'Dry Concentrates'}
                                                {$val.mk_price = $research_data.avg_dryc_amt}
                                                {$mk_vol = $research_data.total_dryc_qty}
                                                <td>{$research_data.avg_dryc_amt}/{$val.short_unit}</td>
                                        {/if}

                                        {if $val.parent_cat_name == 'Oil Concentrates'}
                                            {$val.mk_price = $research_data.avg_oilc_amt}
                                            {$mk_vol = $research_data.total_oilc_qty}
                                            <td>{$research_data.avg_oilc_amt}/{$val.short_unit}</td>
                                        {/if}

                                        {if $val.parent_cat_name == 'Edibles'}
                                            {$val.mk_price =$research_data.avg_edible_amt}
                                            {$mk_vol = $research_data.total_edible_qty}
                                            <td>{$research_data.avg_edible_amt}/{$val.short_unit}</td>
                                        {/if}

                                        <td>
                                            <span id="{$key}_{$val.i_id}"></span>
                                            <script>
                                            $('#{$key}_{$val.i_id}').text(parseFloat({($val.mk_price - $val.p_unit_price)}).toFixed(2))
                                        </script>
                                        </td>
                                        <td>{$val.i_qty}</td>
                                        <td>{$mk_vol}</td>
                                        <td>
                                        <span id="qty_{$key}_{$val.i_id}"></span>%
                                        <script>
                                            $('#qty_{$key}_{$val.i_id}').text(parseFloat({($val.i_qty / $mk_vol) * 100}).toFixed(2))
                                        </script>
                                        </td>
                                    </tr>
                                    {/foreach}
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
$("#start_date1").datetimepicker({
    timepicker: false,
    format: 'm/d/Y',
    step: 5,
    maxDate: 0,
    // minTime: 0,

});
$("#start_date2").datetimepicker({
    ttimepicker: false,
    format: 'm/d/Y',
    step: 5,
    maxDate: 0,
});
</script>
</body>

</html>