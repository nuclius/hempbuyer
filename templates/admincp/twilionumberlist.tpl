{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active" style=" text-transform: capitalize;">
                                <i class="fa fa-user"></i>{$action} Twilio
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                <div class="btn btn-success" onclick="window.location='{$config.url}/admincp/twilio/new'">New Number</div>
                <div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Number</th>
                <th>Date Added</th>
                <th>Allocated ID</th>
                <th>Allocated time</th>                
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
         {$usercount = 0}
         {$cmd};
         {foreach $list as $key => $val}	
         {$usercount = 1}
            <tr>
                <td>{$val.number}</td>
                <td>{$val.date_added}</td>
                <td>${$val.allocate_id}</td>
                <td>{$val.allocated_time}</td>
                <td>
                  {if $val.enable == 0}
<a  title='enable' onclick="return confirm('Are you sure ?')" href="{$config.url}/admincp/twilio/enable/{$val.id}">Enable</a>
 {/if}
 {if $val.enable == 1}
<a  title='disable' onclick="return confirm('Are you sure ?')" href="{$config.url}/admincp/twilio/disable/{$val.id}">Disable</a>
 {/if}
                </td>
            </tr>
         {/foreach}
         {if $usercount == 0}
             <tr>
                 <td colspan="5">
                 No Numbers found !
                 </td>
             </tr>
         {/if}
        </tbody>
    </table>
</div>

               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
