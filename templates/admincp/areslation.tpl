{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
<!-- Page Heading -->

                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">

                        <ol class="breadcrumb">
                            <li class="active">
                                <!-- <i class="fa fa-laptop"></i> --> Relationship Details
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/relationship">
            <div class="row">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label>{$phrases.from_date}</label>
                        <input class="form-control" value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                    </div>

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

                            <div class="form-group">
                                <label>State</label>
                                  <select class="form-control" name="state" id="state_abbr">
                                    <option value="{$search.state}">Select State</option>
                                  </select>
                            </div>
              </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="form-group">
                        <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search}</button>
                    </div>
                </div>
            </div>
        </form>
                <div class="row">
                  <div class="col-lg-12 m-top-20">
               <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th colspan="4">{$phrases.messages}</th>




                                    </tr>
                                </thead>
                                <tbody>

                                    <tr>
                                        <td colspan="4">

                                        <div role="tabpanel">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" {if $action == ''} class="active" {/if}><a href="{$config.url}/admincp/messages/" >ALL</a></li>

  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home">
     <div class="col-lg-12 m-top-20" style="padding-left:0; padding-right:0;">
               <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Date Added</th>
                                        <th>Message Title</th>
                                        <th>Username</th>
                                        <th>Message</th>
                                        <th>Pool Targeted</th>
                                        <th>Interested User Count</th>
                                        <th>User Details</th>
                                        <th>Cost</th>
                                        <th>Interested Users Details</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {$messagescount = 0}
                                 {if $pagination != 0}
                                 {foreach $messages as $key => $val}
                                    <tr>
                                        <td>{$val.date_add}</td>
                                        <td>{$val.title}</td>
                                        <td>{$val.username}</td>
                                        <td>{$val.message_short}</td>
                                        <td>{$val.target_no}</td>
                                        <td>{$val.total_requests}</td>
                                        <td><a class="text-blue" href="{$config.url}/admincp/pollsentdetails/{$val.id}"> User Details</a></td>
                                        <td class="format">{$val.cost}</td>
                                        <td><a class="text-blue" href="{$config.url}/admincp/rinterestdetails/{$val.id}">Intersted User Details</a></td>
                                        <td><a onclick="return ajaxDelStatus()" class="text-blue" href="{$config.url}/admincp/relationship/delete/{$val.id}">Delete</a> / <a class="text-blue" href="{$config.url}/admincp/relationshipdownload/{$val.id}">Download</a></td>

                                    </tr>
                                 {/foreach}
                                 {else}
                                     <tr>
                                         <td colspan="12">
                                           No {$messagesstatus} messages found!
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
                                      </td>


                                    </tr>

                                </tbody>
                            </table>
                        </div>
 </div>
                </div>

                <!-- /.row -->
</div>

{include file="/admincp/footer.tpl" nocache}
<script type="text/javascript">
  numberformat();
</script>
<script language="javascript" type="text/javascript">
function ajaxDelStatus(){
    if (confirm("Are You Sure ?") == true) {
      return true
    } else {
      return false
    }
}
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
