{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}
<link rel="stylesheet" href="{$config.url}/css/jquery.datetimepicker.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css">
<script src="{$config.url}/js/jquery.datetimepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
<style media="screen">
    .dropdown-menu {
        margin-left: 39px;
    }
</style>
<div class="container">
    <div class="h3 col-md-12 text-center">
        Subscriptions Settings
    </div>
    <div class="col-md-12">
        <div class="row">
            <label class="col-md-1 text-right" style="margin-top: 8px;">Store:</label>
            <div class="col-md-3 form-group">
                <select name="rangepast" id="allstores" multiple class="form-control" data-selected-text-format="count" data-live-search="true">
                    {foreach $store as $key => $val}
                        <option value="{$val.id}">{$val.name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-md-2 form-group pull-right">
                <button type="button" class='btn btn-success search_plan pull-right' name="submit">Search</button>
            </div>
        </div>
        <input type="hidden" id="storeid" class="form-control" value="">
        <table class="table table-bordered">
            <thead>
                <tr style="background:#ccc;">
                    <th>S.No</th>
                    <th>Store Name</th>
                    <th>Plan Name</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody class='get-data'>
                <tr><td colspan='5' class='text-center'>No data</td></tr>
            </tbody>
        </table>
    </div>
</div>
{include file="common/footer-1.tpl" nocache}
<script type="text/javascript">
$(function () {
    if($("#allstores").length > 0) {
        $('#allstores').selectpicker({
            noneSelectedText: '0 stores selected'
        });
        var allstoreid = [];
        $('#allstores option').each(function() {
            allstoreid.push($(this).attr('value'));
        });
        $('#allstores').selectpicker('val',allstoreid);
    }
    $('body').on('click','.search_plan', function() {
        if($("#allstores").length > 0) {
            var storeid  = $('#allstores').selectpicker('val');
            if (storeid != null) {
                storeid = storeid.toString();
            } else {
                alert('Please select atleast anyone store');
                return false;
            }
        } else {
            var storeid = $('#storeid').val();
        }
        var myKey = {
            'storeid'   : storeid
        };
        $.ajax({
            type    :"POST",
            url     :"/stores/selectStorePlan",
            data    :myKey,
            dataType:"json",
            success:function(data) {
                $(".get-data").html('');
                var ress2 = data.res;
                if(ress2.length > 0 ) {
                    for(j=0; j < ress2.length; j++) {
                        var html = '<tr>';
                            si = Number(j)+1;
                        html += "<td>"+si+"</td>";
                        html += "<td><b>"+ress2[j].storename+"</b></td>";
                        html += "<td>"+ress2[j].planname+"</td>";
                        html += "<td>"+ress2[j].date+"</td>";
                        html += "<td><a class='btn btn-danger btn-xs' href='/stores/";
                        if(ress2[j].status == 'success') {
                            html += "subauction/"+ress2[j].id+"/hold'><span class='fa fa-pause'></span>&nbsp;Pause";
                        } else {
                            html += "subauction/"+ress2[j].id+"/success'><span class='fa fa-play'></span>&nbsp;Resume";
                        }
                        html += '</a></td>';
                        $(".get-data").append(html+"</tr>");
                    }
                }
                if(Number(ress2.length) <= 0) {
                    $(".get-data").html("<tr><td colspan='5' class='text-center'>No data</td></tr>");
                }
            }
        });
    });
    $('.search_plan').trigger('click');
});

</script>
