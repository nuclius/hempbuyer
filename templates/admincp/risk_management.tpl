{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->

                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">

                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> Risk Management
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row m-top-20">
                   <form enctype="multipart/form-data" class="admin_form" method="get" enctype="multipart/form-data" action="{$config.url}/admincp/risk_management/list">

                         <!-- <div class="col-lg-4">


                            <div class="form-group">
                                <label>{$phrases.first_name}</label>
                                <input type="text" class="form-control" name="first_name" value="{$search.first_name}">
                            </div>
                            <div class="form-group">
                                <label>{$phrases.last_name}</label>
                                <input type="text" class="form-control" name="last_name" value="{$search.last_name}">
                            </div>
                         </div> -->
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
                                    <option value="">Select Country</option>
                                  </select>
                            </div>

                            <div class="form-group">
                                <label>State</label>
                                  <select class="form-control" name="state" id="state_abbr">
                                    <option value="">Select State</option>
                                  </select>
                            </div>
              </div>

                          <div class="col-lg-4">
                            <label style="visibility:hidden;" for="">Hidden label</label>
                            <div class="form-group">
                              <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> Search</button>
                           </div>
                         </div>
                  </form>

                </div>

                {include file="/admincp/risk_management_list.tpl" nocache}

</div>

{include file="/admincp/footer.tpl" nocache}
<script language="javascript" type="text/javascript">

function cancellation(id){
  $.ajax({
    type : 'POST',
    dataType : 'json',
    url : '/admincp/reccancellation/approve',
    data : 'recur=1&rid='+id,
    success : function(data) {
     //console.log(data);
      window.location.reload();
    }
  });
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
