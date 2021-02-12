{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12 m-top-20">
            <h4 class="messages-head">Messages</h5>
            <div role="tabpanel">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li role="presentation" {if $action==''} class="active" {/if}><a href="{$config.url}/admincp/messages/">All</a></li>
                                        <li role="presentation" {if $action=='inbox'} class="active" {/if}><a href="{$config.url}/admincp/messages/inbox">Inbox</a></li>
                                        <li role="presentation" {if $action=='sent'} class="active" {/if}><a href="{$config.url}/admincp/messages/sent">Sent</a></li>
                                        <li role="presentation" {if $action=='archive'} class="active" {/if}><a href="{$config.url}/admincp/messages/archive">Archive</a></li>
                                        <li role="presentation" {if $action=='delete'} class="active" {/if}><a href="{$config.url}/admincp/messages/delete">Delete</a></li>
                                        <li role="presentation" {if $action=='compose'} class="active" {/if}><a href="{$config.url}/admincp/messages/compose">Compose</a></li>
                                    </ul>
                                    <!-- Tab panes -->
                                    <div class="tab-content">
                                        <div role="tabpanel" class="tab-pane active" id="home">
                                            <div class="panel panel-success">
                                             {foreach $messages as $key => $val}
                                                
                                                {if $key == 0}
                                                    <div class="panel-heading">
                                                        <div class="clearfix">
                                                            <h3 class="panel-title pull-left">
                                                                {$val.subject}
                                                            </h3>
                                                            <div class="pull-right">
                                                                {if ($val.from_id == $loged.userid and $val.from_status == 'archive') or ($val.to_id == $loged.userid and $val.to_status == 'archive')}
                                                                    <a href="{$config.url}/admincp/messages/unarchive/{$r_id}">UnArchive</a> {else if($val.from_id != $loged.userid or $val.from_status != 'archive') or ($val.to_id != $loged.userid or $val.to_status != 'archive'}
                                                                    <a href="{$config.url}/admincp/messages/archive/{$r_id}">Move to Archive</a> {/if} {if ($val.from_id == $loged.userid and $val.from_status == 'delete') or ($val.to_id == $loged.userid and $val.to_status == 'delete')}
                                                                    <a href="{$config.url}/admincp/messages/undelete/{$r_id}">Undelete</a> {else if($val.from_id != $loged.userid or $val.from_status != 'delete') or ($val.to_id != $loged.userid or $val.to_status != 'delete'}
                                                                    <a href="{$config.url}/admincp/messages/delete/{$r_id}">Delete</a> 
                                                                {/if}
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                {/if}
                                                {/foreach}
                                                <div class="panel-body">
                                                        {foreach $messages as $key => $val}
                                                            {if $val.to_id == $loged.userid}
                                                                <div class="messages-right">
                                                                    <p>
                                                                        {$val.message}

                                                                        {if $val.read == 0 and $val.to_id == $loged.userid} 
                                                                            <span class="orange text text-danger">(New)</span>
                                                                        {/if}
                                                                    </p>
                                                                    <div class="clearfix">
                                                                        <div class="pull-left">{$val.fname}</div>
                                                                        <div class="pull-right">
                                                                            {$val.date_add}
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            {else if $val.from_id == $loged.userid/}

                                                                <div class="messages-left">
                                                                    <p>
                                                                        {$val.message}

                                                                        {if $val.read == 0 and $val.to_id == $loged.userid} 
                                                                            <span class="orange text text-danger">(New)</span>
                                                                        {/if}
                                                                    </p>
                                                                    <div class="clearfix">
                                                                        <div class="pull-left">{$val.fname}</div>
                                                                        <div class="pull-right">
                                                                            {$val.date_add}
                                                                        </div>
                                                                    </div>
                                                                </div>                                             
                                                            {/if}
                                                        {/foreach}
                                                </div>
                                            </div>
                                                

                                                <form action="{$config.url}/admincp/messages/save" method="POST" enctype="multipart/form-data" class="admin_form" data-parsley-validate>
                                                    <input type="hidden" value="{$r_id}" name="r_id">
                                                    <div class="form-group"> 
                                                        <textarea name="message" id="product_info" data-parsley-group="block1" required class="form-control" data-parsley-maxlength="500" value=""></textarea>
                                                    </div>
                                                    <input type="submit" value="Reply" class="btn btn-success" /> 
                                                </form>
                                        </div>
                                    </div>
                                </div> 
        </div>
    </div>
</div>
<!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}