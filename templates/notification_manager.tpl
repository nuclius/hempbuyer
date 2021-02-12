 {include file="common/header-1.tpl" nocache}
<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}
<div class="container-fluid grey-bg xs-pdlr">
    <div class="container dashboard-settings-con m50">
        <div class="row">
            <!-- common sidebar here -->
            <div class="col-md-3 sidebar  mb-25  mb-25">
              <div class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown">Notifications <i class="fa fa-angle-down"></i></a>
                {include file="common/dashboard_settings_menu.tpl" nocache}
              </div>
            </div>
            <!-- / Sidebar -->
            <!-- Content Area -->
            <div class="col-md-9 content-area">
                <div class="row">
                    <div class="panel panel-success m5 m-t-0">
                        <div class="panel-heading green-bg">
                            <h3>Dashboard - Notifications</h3>
                        </div>
                    </div>
                    <div class="col-md-12 white-bg-2 p35 shadow">
                        <div class="row">
                            <div class="col-xs-12 notifications  xs-pdlr">
                                <div class="table-responsive">
                                    <table class="table" border="0">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th class="text-center">Email</th>
                                             <!--    <th class="text-center">SMS</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach $buyer_titles as $key => $val}
                                            <tr>
                                                <td class="w100">{$val.subject}</td>
                                                <td class="text-center">
                                                    <div class="checkbox">
                                                        <label class="">
                                                            <input class="bemail settings"  value="{$val.id}" type="checkbox"
                                                            {foreach $email_items as $keys => $valids}
                                                            {if $val.id == $valids} checked=true {/if}
                                                            {/foreach}>
                                                            <span class="cr"><i class="cr-icon fa fa-check" ></i></span>
                                                        </label>
                                                    </div>
                                                </td>
                                               <!--  <td class="text-center">
                                                    <div class="checkbox">
                                                        <label class="">
                                                           <input class="bsms settings"  value="{$val.id}" type="checkbox"
                                                           {foreach $sms_items as $keys => $valids}
                                                           {if $val.id == $valids} checked=true {/if} {if $verified neq 1} disabled {/if}
                                                           {/foreach} >
                                                            <span class="cr"><i class="cr-icon fa fa-check"></i></span>
                                                        </label>
                                                    </div>
                                                </td> -->
                                            </tr>
                                            {/foreach}

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 notifications">
                              <form action="{$config.url}/dashboard/save_notification" method="post">
                                  <input type="hidden" name="notify_id" id="notify_id" value="{$notify_id}">

                                  <input type="hidden" name="email_settings" id="email_settings">
                                  <input type="hidden" name="sms_settings" id="sms_settings">

                                  <button type="submit" id="notified" class="btn btn-default btn-d-b green-b m0 centering f14">{$phrase.save}</button>
                                  <!-- <button type="button" class="btn btn-default">{$phrase.cancel}</button> -->
                              </form>
                            </div>
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

{literal}

<script type="text/javascript">

$(document).ready(function(){

    var addemids = $("input.bemail:checked").map(function(){
        return this.value;
    }).toArray();

    var addsmids = $("input.bsms:checked").map(function(){
        return this.value;
    }).toArray();
    $('#email_settings').val(addemids);
    $('#sms_settings').val(addsmids);

  $(".settings").click(function(){

    var addemids = $("input.bemail:checked").map(function(){
        return this.value;
    }).toArray();

    $('#email_settings').val(addemids);

    var addsmids = $("input.bsms:checked").map(function(){
        return this.value;
    }).toArray();

     $('#sms_settings').val(addsmids);


  })
  // $("#verifybtn").click(function(){

  //   var ph_no = $('#mobile-number').val();
  //   ph_no = ph_no.replace('+','');
  //   var request = $.ajax({
  //     url: "/verifyno?p="+ph_no,
  //     type: "GET",
  //   });
  //   request.done(function(msg) {
  //     $(".verification").html(msg);
  //     if(msg == 'Phone number is already verified.'){ $(".textdesc").html(''); }
  //     $("#verifyinfo").modal('show');

  //   });

  // });
  // $('#notified').click(function(){
  //   alert("Your Settings Are Saved");
  //   return true;

  // });

});
</script>
{/literal}

</body>

</html>
