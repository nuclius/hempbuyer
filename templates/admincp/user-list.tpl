<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th width="30">No.</th>
                <th width="40">Select</th>
                <th>Username</th>
                <th>State</th>
                <th>User Type</th>
                <th>Membership Type</th>
                <th>Email Address</th>
                <th>Available Balance</th>
                <th>Status</th>
                <th width="100">Add Funds</th>
                <th width="100">Action</th>
            </tr>
        </thead>
        <tbody>
         {$usercount = 0}
         {foreach $users as $key => $val}
         {$usercount = 1}
            <tr>
                <td>{($users.length * ($page-1)) + ($key + 1)}</td>
                <td><input type="checkbox" name="checkUser" id="checkuser_{$val.id}" onchange="selectUsers({$val.id})"></td>
                <td>{$val.username}</td>
                <td>{$val.state}</td>
                <td>{$val.business_type}</td>
                <td>{$val.mplan_name}</td>
                <td>
                  <a class="w100 contact_modal" class="btn-link" data-toggle="modal" data-id="{$val.id}"
                  data-email="{$val.email}" data-target="#wireContact">{$val.email}</a>
                </td>
                <td>$<span  id="bal_{$val.id}">{$val.balance}</span></td>
                <!-- <td>${$val.status}</td> -->
                <td>
                <!-- 'active','unsubscribe','moderate','unverified','deactivate' -->
                <!-- {$val.status} -->
                  <div class="form-group">
                     <select  data-id="{$val.id}" data-status="{$val.status}" class="form-control status_{$val.id}" id="status" name="status">
                         {if $val.status=='unverified'}
                          <option value="unverified" {if $val.status=='unverified'} selected {/if}>Pending</option>
                          <option value="active"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Activate</a></option>
                          <option value="moderate"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Reject</a></option>
                         {/if}
                         {if $val.status=='active'}
                          <option value="active" selected>Activated</option>
                          <option value="deactivate"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Suspend</a></option>
                          <option value="delete"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Purge</a></option>
                         {/if}
                         {if $val.status=='deactivate'}
                          <option value="deactivate" selected>Suspended</option>
                          <option value="active"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Activate</a></option>
                          <option value="delete"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Purge</a></option>
                         {/if}
                         {if $val.status=='moderate'}
                          <option value="moderate" selected>Rejected</option>
                          <option value="active"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Activate</a></option>
                          <option value="delete"><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Purge</a></option>
                         {/if}
                                <!--   <option value="active" {if $val.status=='active'} disabled selected {/if}><a href="{$config.url}/{$loged.adminUrl}/update/status/{$val.id}">Activ{if $val.status=='active'}ated{else if $val.status=='modarate'}ate{/if}</a></option>
                                    <option value="deactivate" {if $val.status=='deactivate'}disabled selected {/if}>Suspend{if $val.status=='deactivate'}ed{/if}</option> -->
                        <!-- <option value="moderate" {if $val.status=='moderate'} selected {/if}>Reject{if $val.status=='moderate'}ed{/if}</option> -->
                        <!-- <option value="unverified" {if $val.status=='unverified'} selected {/if}>Unverified</option> -->
                     <!--    <option value="delete">Delete</option> -->
                      </select>
                  </div>
                </td>
                <td>
                    <div class="form-group baln-inpt">
                        <b><input type="text" name="inc_bal{$val.id}" id="inc_bal{$val.id}" /></b>
                    </div>
                </td>
                <td>
                    <a  title='View' href="{$config.url}/{$loged.adminUrl}/users/view/{$val.id}">View</a>
                    <!-- <a  title='Edit' href="{$config.url}/{$loged.adminUrl}/users/edit/{$val.id}">Edit</a> <br> -->
                    <!-- {if $val.status != 'deactivate'}
                      <a  title='Edit' href="{$config.url}/{$loged.adminUrl}/users/suspend/{$val.id}" onclick="return swal('Are you sure?')">Suspend</a> <br>
                    {/if} -->

                    <!-- {if $val.status == 'deactivate'}
                      <a  title='Delete' href="" style="color:red;cursor:none; ">Suspended</a> <br>
                      {if $val.del_status == 0}
                      <a  id="deleteUser" title='Delete' href="{$config.url}/{$loged.adminUrl}/users/expel/{$val.id}"  onclick="return swal('Are you sure?')">Delete</a> <br>
                      {/if}
                      {if $val.del_status > 0}
                      <a  title='Delete' href="" style="color:red;cursor:none; ">Deleted</a> <br>
                      {/if}
                    {/if} -->
                    <br>
<!--                       <a  title='Reset' style="cursor:pointer;" onclick="sendResetPwdLink({$val.id})">Reset Password</a> <br> -->
                      <button class="btn btn-success" id="inc_bal_btn" data-toggle="tooltip" title="Use minus(-) sign to deduct the balance." onclick="updateBalance({$val.id})">Submit</button>
<!--                   {if $val.status == 'active'}
                    <a onclick=tempLogin('{$val.email}',{$val.id}) style="cursor: pointer;">Switch User</a>
                  {/if} -->
                </td>

            </tr>
         {/foreach}
         {if $usercount == 0}
             <tr>
                 <td colspan="12">
                 No {$userstatus} Users Found !
                 </td>
             </tr>
         {/if}
        </tbody>
    </table>
</div>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Enter the message <small></small></h4>
        </div>
        <div class="modal-body">
            <textarea id="reject-message" name="rejectMessage" class="reject-message" style="width:100%"></textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="submitreject">Submit</button>  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    function deleteUser(sid){
      alert("sxdfsf")
      $('#deleteUser').click(function(){
        return confirm('Are you sure want to continue?');
      });
    };
  </script>
