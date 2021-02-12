{include file="common/header-1.tpl" nocache}

<!-- Page content -->

{include file="common/dashboard-navigation.tpl" nocache}


<!-- page content  -->
    <div class="container-fluid grey-bg p0">

        <!-- <div class="page-caption m50">
            <h1>Market Research</h1>
        </div> -->

        <div class="container market-research-con m20">

          <ul class="nav nav-pills">
            <li class="active"><a data-toggle="pill" href="#basic">My Herbee Market Activity</a></li>
            <li><a data-toggle="pill" href="#depth">Overall Market Activity</a></li>
          </ul>

          <div class="tab-content">

            <div id="basic" class="tab-pane fade in active">

              <div class="page-caption m50">
                <h1>My Herbee Market Activity</h1>
              </div>

              <div class="row store-content-row p35">
                <div class="col-md-12">

                  <div class="row">

                    <div class="col-md-12 white-bg shadow p35">

                    <div class="row flex">
                      <form enctype="multipart/form-data" class="admin_form" method="get" enctype="multipart/form-data" action="{$config.url}/dashboard/market/research">
                      <div class="col-md-4 margin-auto">
                        <label>Start Date</label>
                        <div class="input-group">
                            <input class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change" type="text" id="start_date1" placeholder="Start Date" name="start_date" data-parsley-required data-parsley-required-message="Please select date" value="{$search.start_date}">
                            <span class="input-group-addon" id="basic-addon2">
                              <i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
                        </div>
                      </div>
                      <div class="col-md-4 margin-auto">
                        <label>End Date</label>
                        <div class="input-group">
                            <input class="w100 p15 pb15 grey-bg border-0" data-parsley-trigger="change" type="text" id="start_date2" placeholder="End Date" name="end_date" data-parsley-required data-parsley-required-message="Please select date" value="{$search.end_date}">
                            <span class="input-group-addon" id="basic-addon2">
                              <i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
                        </div>
                      </div>
                      <div class="col-md-2 margin-auto">
                        <label></label>
                        <div class="input-group">
                              <button type="submit" class="btn btn-default btn-d-b green-b m0"> <i class="fa fa-search"></i> {$phrases.search}</button>
                        </div>
                      </div>
                    </form>
                      <div class="col-md-2">
                        <label></label>
                        <a href="{$config.url}/dashboard/market/research/report" class="btn btn-default btn-d-b green-b m0">Report</a>
                      </div>
                    </div>

                      <h3 class="caption green-text text-center m35">
                       <i class="icon flaticon-flower-with-leaves"></i> Flowers <br>
                        <span class="f14 grey-text lh-22"><b>Average Transaction Price</b></span>
                      </h3>

                      <canvas id="average-bar-chart" class="m-b-50"></canvas>
                      
                      <div class="row flex">
                        <div class="col-md-4 margin-auto">
                          <h4 class="text-center grey-text">Sativa Market Volume</h4>
                          <canvas id="sativa-pie-chart"></canvas>
                        </div>
                        <div class="col-md-4 margin-auto">
                          <h4 class="text-center grey-text">Indica Market Volume</h4>
                          <canvas id="indica-pie-chart"></canvas>
                        </div>
                        <div class="col-md-4 margin-auto">
                          <h4 class="text-center grey-text">Hybrid Market Volume</h4>
                          <canvas id="hybrid-pie-chart"></canvas>
                        </div>
                      </div>

                    </div>

                  </div>

                  <div class="row mt-30">

                    <div class="col-md-12 white-bg shadow p35">

                      <h3 class="caption green-text text-center m35">
                       <i class="icon flaticon-medicine-bottle"></i> Concentrates <br>
                        <span class="f14 grey-text lh-22"><b>Average Transaction Price</b></span>
                      </h3>

                      <canvas id="concentrates-bar-chart" class="m-b-50"></canvas>

                      <div class="row flex">
                        <div class="col-md-4 margin-auto">
                          <h4 class="text-center grey-text">Dry Concentrates Market Volume</h4>
                          <canvas id="dry-concentrates-pie-chart"></canvas>
                        </div>
                        <div class="col-md-4 margin-auto">
                          <h4 class="text-center grey-text">Oil Concentrates Market Volume</h4>
                          <canvas id="oil-concentrates-pie-chart"></canvas>
                        </div>
                      </div>

                    </div>

                  </div>

                  <div class="row mt-30">

                    <div class="col-md-12 white-bg shadow p35">

                      <h3 class="caption green-text text-center m35">
                       <i class="icon flaticon-muffin"></i> Edibles <br>
                        <span class="f14 grey-text lh-22"><b>Average Transaction Price</b></span>
                      </h3>

                      <canvas id="edibles-bar-chart" class="m-b-50"></canvas>

                      <div class="row flex">
                        <div class="col-md-4 margin-auto">
                          <h4 class="text-center grey-text">Edibles Market Volume</h4>
                          <canvas id="edibles-pie-chart"></canvas>
                        </div>
                      </div>

                    </div>

                  </div>

                </div>
              </div>


            </div>

            <div id="depth" class="tab-pane fade in">

              <div class="page-caption m50">
                <h1>Herbee Overall Market Activity</h1>
              </div>

              <div class="row store-content-row p35">

                  <div class="col-md-12 white-bg shadow p35">

                      <div class="row">
                        <div class="col-md-4">
                          <select class="w50 p15 pb15 grey-bg border-0 block mb-25 w100" name="search_cat" id="search_cat">
                              <option value="">Select Category</option>
                              <option value="sativa_p">Average Sativa Price </option>
                              <option value="indica_p">Average Indica Price</option>
                              <option value="hybrid_p">Average Hybrid Price</option>
                              <option value="concentrate_p">Average Concentrates Price</option>
                              <option value="edibles_p">Average Edibles Price</option>
                              <option value="sativa_v">Total Sativa Volume</option>
                              <option value="indica_v">Total Indica Volume</option>
                              <option value="hybrid_v">Total Hybrid Volume</option>
                              <option value="concentrate_v">Total Concentrates Volume</option>
                              <option value="edibles_v">Total Edibles Volume</option>
                          </select>
                        </div>

                      </div>

                      <canvas class="mt-15" id="overall_market_activity"></canvas>

                    </div>

              </div>

            </div>

          </div>

        </div>


    </div>

{include file="common/footer-1.tpl" nocache}
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js" /></script>
<!-- <script src="{$config.url}/js/my-chart.js" type="text/javascript"> -->

<script type="text/javascript">
    // Chart for research page

// Flowers-bar-chart

var ctx = document.getElementById('average-bar-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: ["Sativa", "Indicas", "Hybrids"],
        datasets: [{
                label: 'My Transactions $',
                backgroundColor: 'rgb(52, 152, 219)',
                data: [{$re_flower_user.avg_sativa_amt},{$re_flower_user.avg_indica_amt},{$re_flower_user.avg_hybrid_amt}]
            },
            {
                label: 'Market Transactions $',
                backgroundColor: 'rgb(231, 76, 60)',
                data: [{$re_flower.avg_sativa_amt},{$re_flower.avg_indica_amt},{$re_flower.avg_hybrid_amt}]
            }
        ]
    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'top',
        },
        scales: {
          yAxes: [{
              ticks: {
                  beginAtZero: true,
                  callback: function(value, index, values) {
                    if(parseInt(value) >= 1000){
                      return '$ ' + (parseFloat(value).toFixed(2)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    } else {
                      return '$ ' + parseFloat(value).toFixed(2);
                    }
                  }
              },
              scaleLabel: {
                display: true,
                labelString: 'Transaction price in dollar($)'
              }
          }],
          xAxes : [{
            scaleLabel: {
                display: true,
                labelString: 'Categories'
              }
          }]
        }
    }
});

// Flowers-pie-chart
//sativa market volume
var ctx = document.getElementById('sativa-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',
    // The data for our dataset
    data: {
        labels: ["My Volume", "Market Volume"],
        datasets: [{
            backgroundColor: ['rgb(52, 152, 219)', 'rgb(231, 76, 60)'],
            data: [{$re_flower_user.total_sativa_qty}, {$re_flower.total_sativa_qty}],
        }]
    },
    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        }
    }
});

//indica pie chart
var ctx = document.getElementById('indica-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["My Volume", "Market Volume"],
        datasets: [{
            backgroundColor: ['rgb(52, 152, 219)', 'rgb(231, 76, 60)'],
            data: [{$re_flower_user.total_indica_qty}, {$re_flower.total_indica_qty}],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        }
    }

});

var ctx = document.getElementById('hybrid-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',

    // The data for our dataset
    data: {
        labels: ["My Volume", "Market Volume"],
        datasets: [{
            backgroundColor: ['rgb(52, 152, 219)', 'rgb(231, 76, 60)'],
            data: [ {$re_flower_user.total_hybrid_qty}, {$re_flower.total_hybrid_qty}],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        }
    }

});


// Concentrates-bar-chart

var ctx = document.getElementById('concentrates-bar-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: ["Dry Concentrates", "Oil Concentrates"],
        datasets: [{
                label: 'My Transactions $',
                backgroundColor: 'rgb(52, 152, 219)',
                data: [{$re_flower_user.avg_dryc_amt},{$re_flower_user.avg_oilc_amt}]
            },
            {
                label: 'Market Transactions $',
                backgroundColor: 'rgb(231, 76, 60)',
                data: [{$re_flower.avg_dryc_amt},{$re_flower.avg_oilc_amt}]
            }
        ]
    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'top',
        },
            scales: {
        yAxes: [{
            ticks: {
                beginAtZero: true,
                  callback: function(value, index, values) {
                    if(parseInt(value) >= 1000){
                      return '$ ' + (parseFloat(value).toFixed(2)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    } else {
                      return '$ ' + parseFloat(value).toFixed(2);
                    }
                  }
            },
              scaleLabel: {
                display: true,
                labelString: 'Transaction price in dollar($)'
              }
        }],
          xAxes : [{
            scaleLabel: {
                display: true,
                labelString: 'Categories'
              }
          }]
    }
    }

});



//  Concentrates-pie-chart
var ctx = document.getElementById('dry-concentrates-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["My Volume", "Market Volume"],
        datasets: [{
            backgroundColor: ['rgb(52, 152, 219)', 'rgb(231, 76, 60)'],
            data: [{$re_flower_user.total_dryc_qty},{$re_flower.total_dryc_qty}],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        }
    }

});

var ctx = document.getElementById('oil-concentrates-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',


    // The data for our dataset
    data: {
        labels: ["My Volume", "Market Volume"],
        datasets: [{
            backgroundColor: ['rgb(52, 152, 219)', 'rgb(231, 76, 60)'],
            data: [{$re_flower_user.total_oilc_qty},{$re_flower.total_oilc_qty}],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        legend: {
            position: 'bottom',
        }
    }

});

// Edibles-bar-chart

var ctx = document.getElementById('edibles-bar-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: ["Edibles"],
        datasets: [{
                label: 'My Transactions $',
                backgroundColor: 'rgb(52, 152, 219)',
                data: [{$re_flower_user.avg_edible_amt}]
            },
            {
                label: 'Market Transactions $',
                backgroundColor: 'rgb(231, 76, 60)',
                data: [{$re_flower.avg_edible_amt}]
            }
        ]
    },

    // Configuration options go here
    options: {
        responsive: true,
        legend: {
            position: 'top',
        },
            scales: {
        yAxes: [{
            ticks: {
                beginAtZero: true,
                  callback: function(value, index, values) {
                    if(parseInt(value) >= 1000){
                      return '$ ' + (parseFloat(value).toFixed(2)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    } else {
                      return '$ ' + parseFloat(value).toFixed(2);
                    }
                  }
            },
              scaleLabel: {
                display: true,
                labelString: 'Transaction price in dollar($)'
              }
        }],
          xAxes : [{
            scaleLabel: {
                display: true,
                labelString: 'Categories'
              }
          }]
    }
    }

});



//  Edibles-pie-chart

var ctx = document.getElementById('edibles-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',

    // The data for our dataset
    data: {
        labels: ["My Volume", "Market Volume"],
        datasets: [{
            backgroundColor: ['rgb(52, 152, 219)', 'rgb(231, 76, 60)'],
            data: [{$re_flower_user.total_edible_qty}, {$re_flower.total_edible_qty}],
        }]
    },

    // Configuration options go here

    options: {
        responsive: true,
        legend: {
            position: 'bottom',
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
                position: 'top',
            },
            hoverMode: 'index',
            stacked: false,
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
                    },
                    scaleLabel: {
                      display: true,
                      labelString: 'Average Market price in dollar($)'
                    }
                }, {
                    type: "linear",
                    display: true,
                    position: "right",
                    id: "y-axis-2",
                    ticks: {
                      beginAtZero: true
                    },
                    scaleLabel: {
                      display: true,
                      labelString: 'Average Market Volume'
                    },
                    gridLines: {
                        drawOnChartArea: false, // only want the grid lines for one axis to show up
                    },
                }],
                xAxes : [{
                  scaleLabel: {
                      display: true,
                      labelString: 'Day(s)'
                    }
                }]
            }
        }
    });
  

</script>
<script type="text/javascript">
  $("#start_date1").datetimepicker({
    timepicker:false,
    format:'m/d/Y',
    step: 5,
    maxDate: 0,
    // minTime: 0,

});
$("#start_date2").datetimepicker({
    timepicker:false,
    format:'m/d/Y',
    step: 5,
    maxDate: 0,
});
</script>
</body>
</html>
