{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
   <!-- Page Heading -->

                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">

                        <ol class="breadcrumb">
                            <li class="active">
                                <!-- <i class="fa fa-laptop"></i> -->Ads Store
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

<form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/ads/store">
            <div class="row">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>{$phrases.from_date}</label>
                        <input class="form-control" value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                    </div>
                </div>
                <div class="col-lg-4">
                  <div class="form-group">
                      <label>{$phrases.to_date}</label>
                      <input class="form-control" value="{$search.to_date}" name="to_date" id="to_date" class="date_picker">
                  </div>
                </div>
              <div class="col-lg-4">
                             <div class="form-group">
                                <label>Country</label>
                                  <select class="form-control" name="country" id="country_abbr">
                                    <option value="{$search.country}">Select Country</option>
                                  </select>
                            </div>


              </div>
            </div>
            <div class="row">
                    <div class="col-lg-4">
                            <div class="form-group">
                                <label>State</label>
                                  <select class="form-control" name="state" id="state_abbr">
                                    <option value="{$search.state}">Select State</option>
                                  </select>
                            </div>
                    </div>
                    <div class="col-lg-4">
                            <label style="visibility: hidden;" for="">Height adjust</label>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                            </div>
                    </div>
            </div>
        </form>

                <div class="row">


                </div>

{if $success}
<div class="alert alert-success"> <strong>{$error}!</strong> </div>
{/if}
{if $failure}
<div class="alert alert-danger"> <strong>{$error}!</strong> </div>
{/if}
<form action="" method="post" id="pay_chk">
<div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Ads Name</th>
                                        <th>{$phrases.image}</th>
                                        <th>Total Clicks Requested</th>
                                        <th>Total Impressions Delivered</th>
                                        <th>Total Clicks Delivered</th>
                                        <th>Fees Charged</th>
                                        <th>{$phrases.enable}</th>
                                        <!-- <th>Edit</th> -->

                                        <!-- <th>{$phrases.action}</th> -->
                                    </tr>
                                </thead>
                                <tbody>
                                 {if $banner > 0}
                                 {foreach $banner as $key => $val}

                                    <tr>
                                        <td>{$val.username}</td>
                                        <td>{$val.ad_name}</td>
                                        <td><a href="{$config['imgpath']}ad_image/{$val.banner}" onclick="window.open(this.href); return false;"> <img src="{if $val.banner != ''}{$config['imgpath']}ad_image/{$val.banner}{/if}{if $val.existing_img != ''}{$config['imgpath']}store/{$val.existing_img}{/if}{if $val.banner == '' && $val.existing_img == ''}{$config['imgpath']}no_img.png{/if}" width="50" height="50" onError="this.src='{$config['url']}/images/no_imf.png"></a></td>
                                       <!-- <td><a href="#" title="{$val.image}"> <img src="{if $val.banner != ''}{$config['imgpath']}ad_image/{$val.banner}{/if}{if $val.existing_img != ''}{$config['imgpath']}store/{$val.existing_img}{/if}{if $val.banner == '' && $val.existing_img == ''} {$config['imgpath']}no_img.png{/if}  " width="50" height="50" alt="1"></a></td> -->
                                       <td>{$val.total_clicks_allowed}</td>
                                       <td>{$val.no_of_views}</td>

                                       <td>{$val.no_of_clicks}</td>
                                       <td>{$val.amount}</td>
                                        <td> <div class="f14 mb-5"><span class="grey-text"><b>OFF</b></span>/<span class="green-text"><b>ON</b></span></div>
                                          <label class="switch">
                                             <input type="checkbox" {if $val.status == 'active'} checked  {/if} class="chgestat" data-record-status="{$val.status}" data-record-id="{$val.id}">
                                            <span class="slider round"></span>  </td>
                                       <!--  <td><a href="{$config.url}/admincp/adsedit/storeedit/{$val.id}" title="{$val.image}">Edit</a><br /> <a href="{$config.url}/admincp/banner/delete?id={$val.id}" class="deletealert"onclick="return confirm('Are you sure ?') "  title="{$val.image}">Delete</a> </td> -->
                                       </tr>
                                 {/foreach}
                                 {else}
                                 <tr>
                                     <td colspan="10">
                                         No Banners Found !!!
                                     </td>
                                 </tr>
                                 {/if}
                                </tbody>
                            </table>


                            {$pagination_html}
                        </div>
                        </form>
                        <!--<input type="submit" class="btn btn-success" value="Create New Banner" onclick="window.location.href = '{$config.url}/admincp/banner/new'"  style="margin-bottom:2%; margin-top:2%;"/>-->


                <!-- /.row -->
</div>



{include file="/admincp/footer.tpl" nocache}

<script type="text/javascript">
$('.chgestat').click(function(){
  var status = $(this).attr('data-record-status');
  var id     = $(this).attr('data-record-id');
   $.ajax({
      type : 'GET',
      url :  '/adwords/edit_adwordsadmin/'+status+'/'+id,
      success : function(data) {

      }
    });
});


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
