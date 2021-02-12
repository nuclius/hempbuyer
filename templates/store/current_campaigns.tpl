{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
 <link rel="stylesheet" href="{$config.url}/css/mystyle.css" />
   <link rel="stylesheet" href="{$config['externalcss']}jquery.datetimepicker.css" type="text/css" />
<!-- Page content -->

<div class="container-fluid bgBannerFluid">
    <h1>Market Activity Dashboard</h1>
              {include file="common/common_navigation.tpl" nocache}
</div>

<div class="container-fluid grey-bg xs-pdlr">

  <div class="container dashboard-settings-con m50">

    <div class="row">

      <div class="col-md-3 sidebar  mb-25  mb-25"> 
    <div class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Current Campaigns <i class="fa fa-angle-down"></i></a>
          {include file="common/ads_settings_menu.tpl" nocache}
    </div>
</div> 
      <!-- / Sddebar -->

      <div class="col-md-9 content-area">

        <div class="row m-b-50">
          <div class="panel panel-success m5 m-t-0">

              <div class="panel-heading green-bg">
                  <h3>Current Campaigns</h3>
              </div>

          </div>
          <div class="col-md-12 white-bg-2 p0 shadow">
 
            <div class="sub-tab-content new-link-style">
              <ul class="nav nav-pills super-sub-link border-b">
               <!-- data-toggle="pill" href="#spend" -->
                  <li><a class="white-bg">
                    Total Ad spend<br>
                  <span class="green-text">
                    <h4>{if $adsSpend > 0}{$adsSpend}{else}0{/if}</h4>
                    <!-- <h4>{$current_campaigns.total_ad}</h4> -->
                  </span></a>
                  </li>
                  <li ><a class="white-bg"> Total Impressions <span class="green-text">
                    <h4>{if $current_campaigns.views > 0}{$current_campaigns.views}{else}0{/if}</h4>
                  </span></a></li>
                  <li class=""><a class="white-bg">Total Clicks
                    <span class="green-text">
                      <h4>{if $current_campaigns.total_clicks > 0}{$current_campaigns.total_clicks}{else}0{/if}</h4>
                    </span>
                  </a></li>
                  <li class=""><a class="white-bg">Total Clicks leading to purchase
                    <span class="green-text">
                      <h4>{if $current_campaigns.total_s_clicks > 0}{$current_campaigns.total_s_clicks}{else}0{/if}</h4>
                    </span>
                   </a></li>
                  <li>
                    <a class="white-bg">Campaign Direct Market Revenue
                    <span class="green-text">
                      <h4>$ {if $campaign_data.total_sold_price > 0}{$campaign_data.total_sold_price}{else}0{/if}</h4>
                    </span>
                  </a>
                </li>
                  <li>
                    <a class="" data-toggle="pill" href="#noclicks">Number of Clicks/ Number of Impressions
                    <span class="green-text">
                      <h4 class="mov">
                        {if $clicksbyimpressions > 0}{$clicksbyimpressions}{else}0{/if}
                      </h4>
                    </span>
                  </a>
                </li>
                  <li class=""><a class="" data-toggle="pill" href="#investment"><!-- Return on Investment -->
                  <!-- Return on Investment = Direct Market Sales/Ad Spend -->
                  Return on Investment = Campaign Direct Market Revenue/Ad Spend
                    <span class="green-text">
                      <h4>{if $ROI > 0}{$ROI}{else}0{/if}</h4>
                    </span>
                  </a>
                </li>
             </ul>
            </div>

            <div class="tab-content p35">
              <div id="spend" class="tab-pane fade in active">
                <div class="row flex">
                  <div class="col-md-12 margin-auto">
                    <h4 class="grey-text text-center m35"><b>Total Ad Spend</b></h4>
                    <canvas id="spend-chart" width="400" height="400"></canvas>
                  </div>
                </div>
              </div>
              <!-- /Total Ad spend  -->

              <div id="impressions"  class="tab-pane fade in">
                <h4 class="grey-text text-center m35"><b>Impressions</b></h4>
                <div class="row flex">
                  <div class="col-md-12 margin-auto">
                <canvas id="spend-chart" width="400" height="400"></canvas>
              </div>
              </div>
              </div>
              <!-- /impressions  -->

              <div id="clicks" class="tab-pane fade in">
                <h4 class="grey-text text-center m35"><b>Total Clicks</b></h4>
                <canvas id="spend-chart" width="400" height="400"></canvas>
              </div>
              <!-- /clicks  -->

              <div id="purchase" class="tab-pane fade in">
                <h4 class="grey-text text-center m35"><b>Total Clicks leading to purchase</b></h4>
                <canvas id="spend-chart" width="400" height="400"></canvas>
              </div> 
              <!-- /Total Clicks leading to purchase  -->

              <div id="revenue" class="tab-pane fade in">
                <h4 class="grey-text text-center m35"><b>Total Revenue</b></h4>
                <canvas id="spend-chart" width="400" height="400"></canvas>
              </div>
              <!-- /Total Clicks leading to purchase  -->

              <div id="noclicks" class="tab-pane fade in">
                <h4 class="grey-text text-center m35"><b>Number of Clicks/ Number of Impressions</b></h4>

                <div class="row flex">
                  <!-- <div class="col-sm-4 margin-auto"> -->
                      <!-- <label style="margin-bottom:2px;" for="">Transactions</label> -->
                    <!--   <div class="input-group">
                          <input type="text" id="start_date2" class="" class="form-control w100 grey-bg  " placeholder="From">
                          <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                      </div>
                  </div> -->
                  <!-- <div class="col-sm-4 margin-auto"> -->
                      <!-- <label for="" style="opacity:0;margin-bottom:2px;">Transactions</label> -->
                      <!-- <div class="input-group">
                          <input type="text" class="form-control w100 grey-bg  " placeholder="To" id="end_date2" class="">
                          <span class="input-group-addon" id="basic-addon2"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                      </div> -->
                  <!-- </div> -->
                  <!-- <div class="col-sm-4 margin-auto">
                    <select class="w100 p15 pb15 grey-bg pb15nw" id="day_diff" name="" onchange="graph_update()">
                      <option value="">Last 1 Week</option>
                      <option value="">Last 15 Days</option>
                      <option value="">Last 31 Days</option>
                      <option value="">Last 1 Year</option>
                    </select>
                  </div> -->
                </div>
                <div class="row flex">
                  <div class="col-md-12 margin-auto">
                    <!-- <h4 class="grey-text text-center m35"><b>Total Ad Spend</b></h4> -->
                     <canvas id="spend-chart2" width="400" height="400"></canvas>
                  </div>
                </div>
              </div>

              <!-- /Total Clicks leading to purchase  -->

              <div id="investment" class="tab-pane fade in">
                <h4 class="grey-text text-center m35"><b>Return on Investment</b></h4>
                <canvas id="spend-chart3" width="400" height="400"></canvas>
              </div>
              <!-- /Total Clicks leading to purchase  -->

            </div>

          </div>

        </div>

        <div class="row">
          <!-- <div class="panel panel-success m0">

              <div class="panel-heading green-bg">
                  <h3>Current Campaigns</h3>
              </div>

          </div> -->
          <div class="col-md-12 white-bg shadow p0">
            <div class="table-responsive cus-table">
              <table class="table">
                <thead class="green-b white p15">
                  <th>Name</th>
                  <th>Status</th>
                  <th>Start</th>
                  <th>End</th>
                  <th>Listing</th>
                  <!-- <th>Sold</th> -->
                  <th>Ad fees</th>
                  <!-- <th>Sales</th> -->
                  <th>Action</th>
                </thead>
                <tbody>
                   {foreach $adwords_details as $key => $val}
                  <tr>
                    <td><b class="caption">
                                {$val.ad_title} </b></td>
                    <td> <div class="f14 mb-5"><span class="grey-text"><b>OFF</b></span>/<span class="green-text"><b>ON</b></span></div>
                      <label class="switch">
                        <a href="{$config.url}/adwords/edit_adwords/{$val.status}/{$val.id}"><input type="checkbox" id="status_value" onclick="change_status()" {if $val.status == 'active'} checked  {/if} >
                        <span class="slider round"></span> </a> </td>
                    <td>{dateFormat($val.start_day, 'dd mmmm yyyy')}</td>
                    <td>{if $val.end_date !="0000-00-00"}{dateFormat($val.end_date, 'dd mmmm yyyy')}{/if} {if $val.end_date =="0000-00-00"} No end date {/if} </td>
                    <td>{$val.no_of_views}</td>
                    <!-- <td>n/a</td> -->
                    <td> ${$val.budget_per_day}</td>
                    <!-- <td>n/a</td> -->
                    <td> 
                      <!-- <a href="{$config.url}/adwords/edit/{$val.id}/{$val.store_id}" class="black"><i class="fa fa-pencil icon f12"></i></a> -->
                      <a href="{$config.url}/adwords/edit_adwords/{$val.status}/{$val.id}">
                                {if $val.status == 'active'} Pause {else $val.status == 'pause'} Resume {/if} <span class="slash">|</span>
                              </a>
                         <a href="{$config.url}/adwords/edit_adwords/remove/{$val.id}" onclick="return confirmation()" class="red">
                                Remove
                              </a>
                            </td>
                  </tr>
                  {/foreach}
                </tbody>
              </table>
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
{include file="store/store-js.tpl" nocache}
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js" /></script>
<script type="text/javascript">
  $(function(){
    $('.mov').each(function()
    {

      $(this).html(format(parseFloat($(this).html()).toFixed(2),''));

    });
  })
  function format(n, currency) {

  var parts = n.toString().split(".");
    parts[0] = Number(parts[0]).toLocaleString('en');
  return parts[0]+'.'+parts[1];
}
</script>
<script type="text/javascript">

  var ctx = document.getElementById('spend-chart').getContext('2d');
  var chart = new Chart(ctx, {
  // The type of chart we want to create

  type: 'line',
  // The data for our dataset
  data: {
      labels:
        [{$date_arr}],
      datasets:
        [{
          label:'Total Impression',
          fill: false,
          backgroundColor: ['rgb(70, 137, 102)'],
          borderColor: ['rgb(70, 137, 102)'],
          data: [{$impressions}]
        },
        {
          label:'Total Clicks',
          fill: false,
          backgroundColor: ['rgb(255, 176, 59)'],
          borderColor: ['rgb(255, 176, 59)'],
          data: [{$clicks}]
        },
        {
          label:'Total Sold',
          fill: false,
          backgroundColor: ['rgb(142, 40, 0)'],
          borderColor: ['rgb(142, 40, 0)'],
          data: [{$sold}]
        }
      ],
  },


  // Configuration options go here
   options: {
    scales: {
          yAxes: [{
              scaleLabel: {
                display: true,
                labelString: 'Impressions/Clicks/Sold Total counts'
              }
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
   var ctx = document.getElementById('spend-chart2').getContext('2d');
  var chart = new Chart(ctx, {
  // The type of chart we want to create
  type: 'line',
  // The data for our dataset
  data: {
      labels:
        [{$date_arr}],
      datasets:
        [{
          label:'Total Impression',
          fill: false,
          backgroundColor: ['rgb(70, 137, 102)'],
          borderColor: ['rgb(70, 137, 102)'],
          data: [{$impressions}],
        },
        {
          label:'Total Clicks',
          fill: false,
          backgroundColor: ['rgb(255, 176, 59)'],
          borderColor: ['rgb(255, 176, 59)'],
          data: [{$clicks}],
        },
        /*{
          label:'Sold',
          fill: false,
          backgroundColor: ['rgb(142, 40, 0)'],
          borderColor: ['rgb(142, 40, 0)'],
          data: [{$sold}],
        }*/
      ],
  },


  // Configuration options go here
  options: {
    scales: {
          yAxes: [{
              scaleLabel: {
                display: true,
                labelString: 'Impressions/Clicks Total counts'
              }
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
  var ctx = document.getElementById('spend-chart3').getContext('2d');
  var chart = new Chart(ctx, {
  // The type of chart we want to create
  type: 'line',
  // The data for our dataset
  data: {
      labels:
        [{$date_arr}],
      datasets:
        [{
          label:'Direct Market Sales',
          fill: false,
          backgroundColor: ['rgb(70, 137, 102)'],
          borderColor: ['rgb(70, 137, 102)'],
          data: [{$direct_m_sales}],
        }
        // ,
        // {
        //   label:'Total Ads Spend',
        //   fill: false,
        //   backgroundColor: ['rgb(255, 176, 59)'],
        //   borderColor: ['rgb(255, 176, 59)'],
        //   data: [{$total_ads_spend}],
        // }
      ],
  },


  // Configuration options go here
    options: {
    scales: {
          yAxes: [{
              scaleLabel: {
                display: true,
                labelString: 'Total ROI'
              }
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

<script>
/* jquery datepicker - Date available */
    $("#start_date").datetimepicker({
    timepicker:false,
    format:'d/m/Y',
    step: 5,
    maxDate:0,
    maxTime:0
  });
    $("#end_date").datetimepicker({
    timepicker:false,
   format:'d/m/Y',
    step: 5,
    maxDate:0,
    maxTime:0
  });
      $("#start_date2").datetimepicker({
    timepicker:false,
    format:'d/m/Y',
    step: 5,
    maxDate:0,
    maxTime:0
  });
    $("#end_date2").datetimepicker({
    timepicker:false,
   format:'d/m/Y',
    step: 5,
    maxDate:0,
    maxTime:0
  });
    
</script>


<!-- <script type="text/javascript">

function graph_update()
   {
    day_diff=$('#day_diff').val();
    start_date=$('#start_date').val();
    end_date=$('#end_date').val();
   params="day_diff="+day_diff+"&start_date="+start_date+"&end_date="+end_date;
     $.ajax({
      type : 'POST',
      url : '/stores/ads_graphdata',
      dataType : 'JSON',
       data: params,
      success : function(data) {
       //console.log(data);
      
      //addData(chart, 'Clicks', data.clicks);
      var ar =data.clicks;
     //console.log("sss"+data.clicks);
     //console.log ('ar'+ar);
       var arr = ar.split(",");
 
    var imp=data.impressions;
    imp = imp.split(",");
    
      var sl=data.sold;
      sl = sl.split(",");
    var dar=data.date_arr;
        dar= dar.split(",");
      chart.data.labels=dar;
       chart.data.datasets[0].data=imp;
       chart.data.datasets[1].data=arr;
       chart.data.datasets[2].data=sl;
     
     chart.update();
        
      }
    });
   }

function graph_update2()
   {
    day_diff=$('#day_diff').val();
    start_date=$('#start_date2').val();
    end_date=$('#end_date2').val();
   params="day_diff="+day_diff+"&start_date="+start_date+"&end_date="+end_date;
     $.ajax({
      type : 'POST',
      url : '/stores/ads_graphdata',
      dataType : 'JSON',
       data: params,
      success : function(data) {
       //console.log(data);
      
      //addData(chart, 'Clicks', data.clicks);
      var ar =data.clicks;
     //console.log("sss"+data.clicks);
     //console.log ('ar'+ar);
       var arr = ar.split(",");
 
    var imp=data.impressions;
    imp = imp.split(",");
    
      var sl=data.sold;
      sl = sl.split(",");
    var dar=data.date_arr;
        dar= dar.split(",");
      chart.data.labels=dar;
       chart.data.datasets[0].data=imp;
       chart.data.datasets[1].data=arr;
       chart.data.datasets[2].data=sl;
     
     chart.update();
        
      }
    });
   }
</script>

<script type="text/javascript">
 


$('#end_date').change(function() { 
    graph_update()
});
$('#start_date').change(function() { 
    graph_update()
});

$('#end_date2').change(function() { 
    graph_update2()
});
$('#start_date2').change(function() { 
    graph_update2()
});

</script> -->