<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>

                <th>Select</th>
                <th>Username</th>
                <th>Email</th>
<!--                 <th>Request type</th> -->
                <th>Available Balance</th>
                <th>Requested Funds</th>
                <th>Funds receipt</th>
                <th>Add Funds</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
         {if $pagination > 0}
         {foreach $fund_requests as $key => $val}

            <tr>

                <td> checkbox</td>
                <td>{$val.username}</td>
                <td><a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.user_id}" data-email="{$val.email}" data-target="#wireContact">{$val.email}</a></td>

                <!-- <td>{$val.type}</td> -->
                <td>$<span  class="bal_{$val.user_id}" id="bal_{$val.user_id}">{$val.balance}</span></td>
                <td id="amt_{$val.id}">$<span>{$val.amount}</span></td>
                <td>
                  <a href="{$config.imgpath}wirefund_receipt/{$val.wirefund_receipt}" onclick="window.open(this.href); return false;">

                      <img src="{if $val.wirefund_receipt == ''} {$config['url']}/images/no_img.png {else if $val.wirefund_receipt != ''}{$config['imgpath']}wirefund_receipt/{$val.wirefund_receipt}{/if}" width="50" height="50" onError="this.src='{$config['url']}/images/no_imf.png"></a>
                </td>
                <td>
                    <div class="form-group baln-inpt">
                        <input type="text" name="inc_bal{$val.id}" id="inc_bal{$val.user_id}" />
                    </div>
                </td>


                <!-- <td>${$val.status}</td> -->
                <!-- <td> -->
                <!-- 'active','unsubscribe','moderate','unverified','deactivate' -->
                  <!-- <div class="form-group"> -->
                <!-- 'active','unsubscribe','moderate','unverified','deactivate' -->
                      <!-- <div class="form-group">
                          <select  data-id="{$val.id}" class="form-control status_{$val.id}" id="status" name="status"
                          {if $val.status=='approve'} disabled data-toggle="tooltip" title="Payment approved. Cannot change again." {/if}
                          {if $val.status!='approve'} style="cursor: pointer"{/if}>
                              <option value="unverified" {if $val.status=='unverified'} selected {/if}>Unverified</option>
                              <option value="approve" {if $val.status=='approve'} selected {/if}>Approve{if $val.status=='approve'}d{/if}</a></option>
                              <option value="reject" {if $val.status=='reject'} selected {/if}>Reject{if $val.status=='reject'}ed{/if}</option>
                          </select>
                      </div> -->
<!--                   </div>
                </td> -->
                <td>
                   <button class="btn btn-success" id="inc_bal_btn" data-toggle="tooltip" title="Use minus(-) sign to deduct the balance." onclick="updateBalance({$val.user_id})">Submit</button><br>
                  <!-- {if $val.status=='reject'}
                   <a style="cursor: pointer;" class="w100" class="btn-link"
                    onclick="viewMessage('{$val.reject_msg}')"> View Message</a>
                  {/if} -->
                  <!-- &nbsp; -->
                  <a class="w100" class="btn-link" href="{$config.url}/admincp/payments/edit/{$val.id}">View</a>
                 <!--  <a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.id}" data-email="{$val.email}" data-target="#wireContact">Contact</a>  -->

                </td>
            </tr>
         {/foreach}
         {/if}
         {if $pagination == 0}
             <tr>
                 <td colspan="5"> 
                 <!-- No transaction requests found...! -->
                 </td>
             </tr>
          {/if}
        </tbody>
    </table>
    {if $pagination > 0}
    {$pagination_html}
    {/if}
</div>


  <!-- Modal -->
<!--
<div class="modal fade" id="wireContact" role="dialog">
        <div class="modal-dialog modal-sm" style="width:50% !important;">

            <div id="contact_form" class="modal-content">
                <div class="modal-header p0">
                    <div class="panel panel-success border-0">
                        <div class="panel-heading green-bg">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h3>Enter the message...!</h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body form-horizontal">
       <input type="hidden" value="0" name="r_id" id="r_id">
     <div class="form-group">
    <label class="col-sm-3 col-md-2 control-label">Email-ID* :</label>
    <div class="col-sm-9 col-md-10">
     <input type="email" name="users" id="to_email" disabled=""  class="form-control"/>
    </div>
  </div>
      <div class="form-group">
    <label class="col-sm-3 col-md-2 control-label">Subject : </label>
    <div class="col-sm-9 col-md-10">
   <input type="sub_msg" name="subject" id="sub_msg" data-parsley-required data-parsley-required-message = "Please enter subject"  class="form-control"/>
    </div>
  </div>
      <div class="form-group">
    <label class="col-sm-3 col-md-2 control-label">Message : </label>
    <div class="col-sm-9 col-md-10">
  <textarea name="message" id="body_msg" rows="6" data-parsley-required-message = "Please enter message to proceed..."></textarea>
    </div>
  </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default btn-d-b green-b m0" type="button" onclick="sendMessage()">SEND</button>
                    <button class="btn btn-default btn-d-b green-b m0" type="button" data-dismiss="modal">CLOSE</button>
                </div>

            </div>
        </div>
    </div> -->
</div>


  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Enter the message <small></small></h4>
        </div>
        <div class="modal-body">
            <textarea placeholder="Please enter message" id="reject-message" name="rejectMessage" class="reject-message" style="width:100%"></textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="submitreject">Submit</button> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <script type="text/javascript">
$(document).on("click", ".contact_modal", function () {
     var uid = $(this).data('id');
     var to_email = $(this).data('email');
     $(".modal-body #uid").val(uid);
     $(".modal-body #to_email").val(to_email);
     $(".modal-body #sub_msg").val('');
     $(".modal-body #body_msg").val('');
});

function sendMessage(){
        $.ajax({
            type: 'POST',
            url: '{$config.url}/admincp/payment/sendmsg',
            data: {
                r_id : $('#contact_form').find('#r_id').val(),
                id : $('#contact_form').find('#uid').val(),
                users: $('#contact_form').find('#to_email').val(),
                subject: $('#contact_form').find('#sub_msg').val(),
                message: $('#contact_form').find('#body_msg').val()
            },
            dataType: 'json',
            success: function(data) {
                if (data.data==1) {
                  alert('Message Sent');
                }else{
                  alert('Message Failed');
                }
            }
        });
   $('#wireContact').modal('hide');
    }


</script>
