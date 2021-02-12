{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <div class="row m20">
        <form enctype="multipart/form-data" class="admin_form m20" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/transaction/summery">
            <div class="col-lg-4">
                <div class="form-group">
                    <label>{$phrases.from_date}</label>
                    <input class="form-control" value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                </div>
                <div class="form-group">
                    <label>Country</label>
                    <select class="form-control" name="country" id="country_abbr">
                        <option value="{$search.country}">Select Country</option>
                    </select>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="form-group">
                    <label>{$phrases.to_date}</label>
                    <input class="form-control" value="{$search.end_date}" name="end_date" id="to_date" class="date_picker">
                </div>
                <div class="form-group">
                    <label>State</label>
                    <select class="form-control" name="state" id="state_abbr">
                        <option value="{$search.state}">Select State</option>
                    </select>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="form-group">
                    <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> Search</button>
                    <button type="button" class="btn btn-success" onclick="window.location='{$config.url}/admincp/transaction/list/'"> <i class="fa fa-list"></i> &nbsp; Go to transactions </button>
                </div>
            </div>
        </form>
    </div>
    <div class="row">
        <div class="tab-content">
            <div id="basic" class="tab-pane fade in active">
                <div class="page-caption m50">
                    <h1>Transactions Summary</h1>
                </div>
                <div class="row store-content-row p35">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12 white-bg shadow p35">
                                <h2 class="text-center grey-text">Herbee Market Activity</h2>
                                <div class="row flex">
                                    <div class="col-md-12 margin-auto">
                                        <canvas id="overall_market_activity" class="chartjs-render-monitor m-b-50"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row store-content-row p35">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12 white-bg shadow p35">
                                <h2 class="text-center grey-text">Direct Buy Market Summary</h2>
                                <div class="row flex">
                                    <div class="col-md-4 margin-auto">
                                        <b class="text-center">Total Transactions</b>
                                        <canvas id="db_total_transaction" class="m-b-50"></canvas>
                                    </div>
                                    <div class="col-md-4 margin-auto">
                                        <b class="text-center">Total Products Uploaded</b>
                                        <canvas id="db_total_products_uploaded" class="m-b-50"></canvas>
                                    </div>
                                    <div class="col-md-4 margin-auto">
                                        <b class="text-center">Total Volume available</b>
                                        <canvas id="db_total_avail_vol" class="m-b-50"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 white-bg shadow p35">
                                <div class="row flex">
                                    <div class="col-md-3 margin-auto">
                                        <b class="text-center">Flower Sales</b>
                                        <canvas id="db_flower_sales"></canvas>
                                    </div>
                                    <div class="col-md-3 margin-auto">
                                        <b class="text-center">Edible Sales</b>
                                        <canvas id="db_edible_sales"></canvas>
                                    </div>
                                    <div class="col-md-3 margin-auto">
                                        <b class="text-center">Concentrate Sales</b>
                                        <canvas id="db_concentrate_sales"></canvas>
                                    </div>
                                    <div class="col-md-3 margin-auto">
                                        <b class="text-center">Supply Sales</b>
                                        <canvas id="db_supply_sales"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row store-content-row p35">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12 white-bg shadow p35">
                                <h2 class="text-center grey-text">Open Bid Market Summary</h2>
                                <div class="row flex">
                                    <div class="col-md-4 margin-auto">
                                        <b class="text-center">Total Transactions</b>
                                        <canvas id="ob_total_transaction" class="m-b-50"></canvas>
                                    </div>
                                    <div class="col-md-4 margin-auto">
                                        <b class="text-center">Total Products Uploaded</b>
                                        <canvas id="ob_total_products_uploaded" class="m-b-50"></canvas>
                                    </div>
                                    <div class="col-md-4 margin-auto">
                                        <b class="text-center">Total Volume available</b>
                                        <canvas id="ob_total_avail_vol" class="m-b-50"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 white-bg shadow p35">
                                <div class="row flex">
                                    <div class="col-md-3 margin-auto">
                                        <b class="text-center">Flower Sales</b>
                                        <canvas id="ob_flower_sales"></canvas>
                                    </div>
                                    <div class="col-md-3 margin-auto">
                                        <b class="text-center">Edible Sales</b>
                                        <canvas id="ob_edible_sales"></canvas>
                                    </div>
                                    <div class="col-md-3 margin-auto">
                                        <b class="text-center">Concentrate Sales</b>
                                        <canvas id="ob_concentrate_sales"></canvas>
                                    </div>
                                    <div class="col-md-3 margin-auto">
                                        <b class="text-center">Supply Sales</b>
                                        <canvas id="ob_supply_sales"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- {include file="/admincp/transaction-list.tpl" nocache} -->
</div>
{include file="/admincp/footer.tpl" nocache}
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js" /></script>
<!-- <script src="{$config.url}/js/my-chart.js" type="text/javascript"> -->
<script type="text/javascript">
/* Direct buy bar charts */
var ctx = document.getElementById('db_total_transaction').getContext('2d');
var months = [];
var data = [];
{foreach $re_db_trans as $key => $val}
  months.push('{$val.day_month}/{$val.day_date}/{$val.day_year}');
  data.push({$val.total_transactions});
{/foreach}
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {

        labels: months,
        datasets: [{
            label: 'Total Transactions',
            backgroundColor: 'rgb(52, 152, 219)',
            data: data
        }]

    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }

    }


});

var ctx1 = document.getElementById('db_total_products_uploaded').getContext('2d');
var months1 = [];
var data1 = [];
{foreach $re_db_prdts as $key => $val}
  months1.push('{$val.day_month}/{$val.day_date}/{$val.day_year}');
  data1.push({$val.total_prdts});
{/foreach}
var chart = new Chart(ctx1, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: months1,
        datasets: [{
            label: 'Total Products Uploaded',
            backgroundColor: 'rgb(52, 152, 219)',
            data: data1
        }]

    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }

    }


});

var ctx2 = document.getElementById('db_total_avail_vol').getContext('2d');
var months2 = [];
var data2 = [];
{foreach $re_db_vol as $key => $val}
  months2.push('{$val.day_month}/{$val.day_date}/{$val.day_year}');
  data2.push({$val.total_avail_vol});
{/foreach}
var chart = new Chart(ctx2, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: months2,
        datasets: [{
            label: 'Total Volume Available',
            backgroundColor: 'rgb(52, 152, 219)',
            data: data2
        }]

    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }

    }


});

/* Direct buy pie charts */
var ctx3 = document.getElementById('db_flower_sales').getContext('2d');
var chart = new Chart(ctx3, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["Sativas", "Indicas", "Hybrids"],
        datasets: [{
            backgroundColor: [
            'rgb(52, 152, 219)', 
            'rgb(239, 126, 49)', 
            'rgb(186, 186, 186)'
            ],
            data: [
            {$pie_db.sativa_flowers}, 
            {$pie_db.indica_flowers}, 
            {$pie_db.hybrid_flowers}
            ],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        tooltips: {
                mode: 'label',
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' %';
                    }
                }
            },
        legend: {
            position: 'right',
        }
    }

});
var ctx4 = document.getElementById('db_edible_sales').getContext('2d');
var chart = new Chart(ctx4, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["Sweet", "Savory", "Beverages"],
        datasets: [{
            backgroundColor: [
            'rgb(52, 152, 219)', 
            'rgb(239, 126, 49)', 
            'rgb(186, 186, 186)'
            ],
            data: [
                {$pie_db.sweet_edibles}, 
                {$pie_db.savory_edibles}, 
                {$pie_db.beverages_edibles}
            ],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        tooltips: {
                mode: 'label',
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' %';
                    }
                }
            },
        legend: {
            position: 'right',
        }
    }

});
var ctx5 = document.getElementById('db_concentrate_sales').getContext('2d');
var chart = new Chart(ctx5, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["Keif", "Hash", "CO2 Oil", "Rosin", "Wax", "Tincture", "Shatter"],
        datasets: [{
            backgroundColor: [
            'rgb(52, 152, 219)', 
            'rgb(239, 126, 49)', 
            'rgb(186, 186, 186)', 
            'rgb(255, 192, 0)', 
            'rgb(91, 155, 213)', 
            'rgb(112, 173, 71)', 
            'rgb(38, 68, 120)'
            ],
            data: [
                {$pie_db.keif_concentrates}, 
                {$pie_db.hash_concentrates}, 
                {$pie_db.co2oil_concentrates},
                {$pie_db.rosin_concentrates},
                {$pie_db.wax_concentrates},
                {$pie_db.tincture_concentrates},
                {$pie_db.shatter_concentrates}
            ],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        tooltips: {
                mode: 'label',
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' %';
                    }
                }
            },
        legend: {
            position: 'right',
        }
    }

});

var ctx6 = document.getElementById('db_supply_sales').getContext('2d');
var chart = new Chart(ctx6, {
    // The type of chart we want to create
    type: 'pie',

    // The data for our dataset
    data: {
        labels: ["Accessories", "Equipment", "Input", "Other"],
        datasets: [{
            backgroundColor: [
                'rgb(52, 152, 219)', 
                'rgb(239, 126, 49)', 
                'rgb(186, 186, 186)', 
                'rgb(255, 192, 0)'
            ],
            data: [
                {$pie_db.accessories_supplies}, 
                {$pie_db.equipment_supplies},
                {$pie_db.input_supplies}, 
                {$pie_db.other_supplies}
            ],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        tooltips: {
                mode: 'label',
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' %';
                    }
                }
            },
        legend: {
            position: 'right',
        }
    }

});

/* Open bid bar charts */
var ctx7 = document.getElementById('ob_total_transaction').getContext('2d');
var months7 = [];
var data7 = [];
{foreach $re_ob_trans as $key => $val}
  months7.push('{$val.day_month}/{$val.day_date}/{$val.day_year}');
  data7.push({$val.total_transactions});
{/foreach}
var chart = new Chart(ctx7, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: months7,
        datasets: [{
            label: 'Total Transactions',
            backgroundColor: 'rgb(52, 152, 219)',
            data: data7
        }]

    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }

    }


});

var ctx8 = document.getElementById('ob_total_products_uploaded').getContext('2d');
var months8 = [];
var data8 = [];
{foreach $re_ob_prdts as $key => $val}
  months8.push('{$val.day_month}/{$val.day_date}/{$val.day_year}');
  data8.push({$val.total_prdts});
{/foreach}
var chart = new Chart(ctx8, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: months8,
        datasets: [{
            label: 'Total Products Uploaded',
            backgroundColor: 'rgb(52, 152, 219)',
            data: data8
        }]

    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }

    }


});

var ctx9 = document.getElementById('ob_total_avail_vol').getContext('2d');
var months9 = [];
var data9 = [];
{foreach $re_ob_vol as $key => $val}
  months9.push('{$val.day_month}/{$val.day_date}/{$val.day_year}');
  data9.push({$val.total_avail_vol});
{/foreach}
var chart = new Chart(ctx9, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: months9,
        datasets: [{
            label: 'Total Volume Available',
            backgroundColor: 'rgb(52, 152, 219)',
            data: data9
        }]

    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }

    }


});

/* Open bid pie charts */
var ctx10 = document.getElementById('ob_flower_sales').getContext('2d');
var chart = new Chart(ctx10, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["Sativas", "Indicas", "Hybrids"],
        datasets: [{
            label: '',
            backgroundColor: [
            'rgb(52, 152, 219)', 
            'rgb(239, 126, 49)', 
            'rgb(186, 186, 186)'
            ],
            data: [
            {$pie_ob.sativa_flowers}, 
            {$pie_ob.indica_flowers}, 
            {$pie_ob.hybrid_flowers}
            ],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        tooltips: {
                mode: 'label',
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' %';
                    }
                }
            },
        legend: {
            position: 'right',
        }
    }

});
var ctx11 = document.getElementById('ob_edible_sales').getContext('2d');
var chart = new Chart(ctx11, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["Sweet", "Savory", "Beverages"],
        datasets: [{
            backgroundColor: [
            'rgb(52, 152, 219)', 
            'rgb(239, 126, 49)', 
            'rgb(186, 186, 186)'
            ],
            data: [
                {$pie_ob.sweet_edibles}, 
                {$pie_ob.savory_edibles}, 
                {$pie_ob.beverages_edibles}
            ],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        tooltips: {
                mode: 'label',
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' %';
                    }
                }
            },
        legend: {
            position: 'right',
        }
    }

});
var ctx12 = document.getElementById('ob_concentrate_sales').getContext('2d');
var chart = new Chart(ctx12, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["Keif", "Hash", "CO2 Oil", "Rosin", "Wax", "Tincture", "Shatter"],
        datasets: [{
            backgroundColor: [
            'rgb(52, 152, 219)', 
            'rgb(239, 126, 49)', 
            'rgb(186, 186, 186)', 
            'rgb(255, 192, 0)', 
            'rgb(91, 155, 213)', 
            'rgb(112, 173, 71)', 
            'rgb(38, 68, 120)'
            ],
            data: [
                {$pie_ob.keif_concentrates}, 
                {$pie_ob.hash_concentrates}, 
                {$pie_ob.co2oil_concentrates},
                {$pie_ob.rosin_concentrates},
                {$pie_ob.wax_concentrates},
                {$pie_ob.tincture_concentrates},
                {$pie_ob.shatter_concentrates}
            ],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        tooltips: {
                mode: 'label',
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' %';
                    }
                }
            },
        legend: {
           position: 'right',
        }
    }

});

var ctx13 = document.getElementById('ob_supply_sales').getContext('2d');
var chart = new Chart(ctx13, {
    // The type of chart we want to create
    type: 'pie',

    // The data for our dataset
    data: {
        labels: ["Accessories", "Equipment", "Input", "Other"],
        datasets: [{
            backgroundColor: [
                'rgb(52, 152, 219)', 
                'rgb(239, 126, 49)', 
                'rgb(186, 186, 186)', 
                'rgb(255, 192, 0)'
            ],
            data: [
                {$pie_ob.accessories_supplies}, 
                {$pie_ob.equipment_supplies},
                {$pie_ob.input_supplies}, 
                {$pie_ob.other_supplies}
            ],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        tooltips: {
                mode: 'label',
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data['datasets'][0]['data'][tooltipItem['index']] + ' %';
                    }
                }
            },
        legend: {
            position: 'right',
        }
    }

});
</script>
<script type="text/javascript">

var ctx14 = document.getElementById('overall_market_activity').getContext('2d');
var chart = new Chart(ctx14, {
    // The type of chart we want to create
    type: 'line',
    // The data for our dataset
    data: {
        labels: [{$days}],
        datasets: [{
                label: 'Average Market Price $',
                fill: false,
                backgroundColor: ['rgb(52, 152, 219)'],
                borderColor: ['rgb(52, 152, 219'],
                data: [{$price}] ,
                yAxisID: "y-axis-1"
            },
            {
                label: 'Average Market Volume',
                fill: false,
                backgroundColor: ['rgb(231, 76, 60)'],
                borderColor: ['rgb(231, 76, 60)'],
                data: [{$qty}],
                yAxisID: "y-axis-2"
            }
        ],
    },


    // Configuration options go here
    options: {
            responsive: true,
            legend: {
                position: 'bottom',
            },
            hoverMode: 'index',
            stacked: false,
            // scales: {
            // yAxes: [{
            //     ticks: {
            //         beginAtZero: true
            //     }
            // }]
            scales: {
                yAxes: [{
                    type: "linear",
                    display: true,
                    position: "left",
                    id: "y-axis-1",
                    ticks: {
                      beginAtZero: true,
                      callback: function(value, index, values) {
                          if(parseInt(value) >= 1000){
                            return '$ ' + (parseFloat(value).toFixed(2)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                          } else {
                            return '$ ' + parseFloat(value).toFixed(2);
                          }
                        }
                    }
                }, {
                    type: "linear",
                    display: true,
                    position: "right",
                    id: "y-axis-2",
                    ticks: {
                      beginAtZero: true
                    },
                    gridLines: {
                        drawOnChartArea: false, // only want the grid lines for one axis to show up
                    },
                }],
            }
        }
    });
    
</script>
<script type="text/javascript">
 $(function() {
    Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'mm/dd/yyyy';


    var dt = '{$serverdate}';


    var logic1 = function( currentDateTime ){
        var  begD  = new Date(currentDateTime)
        var  endD = new Date($("#to_date").val());
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#to_date").val('');
        }else if (endD !='Invalid Date' && begD > endD) {
            alert('Start Date Must Be less Than End date');
            $("#from_date").val('');
        }
    };
    $("#from_date").datetimepicker({
        inline:false,
        step:01,
        onChangeMonth:logic1,
        onSelectDate:logic1,
        maxDate:dt,
        timepicker:false,
        format:'m/d/Y',

    });
    var logic = function( currentDateTime ){
        var  begD  = new Date($("#from_date").val());
        var  endD = new Date(currentDateTime);
        if(begD =='Invalid Date'){
            alert('Please Select Start Date');
            $("#to_date").val('');
        }else if (begD > endD) {
            alert('End Date Must Be Greater Than Start date');
            $("#to_date").val('');
        }

    };
    $("#to_date").datetimepicker({
        step:01,
        onChangeMonth:logic,
        onSelectDate:logic,
        showHeader:2,
        maxDate:dt,
        timepicker:false,
        format:'m/d/Y',
    });
});

$(document).ready(function() {
    $('#country_abbr').val('{$search.country}').change();
    if($('#country_abbr').val() != ''){
        $('#state_abbr').val('{$search.state}').change();  
    }
    
})
</script>
