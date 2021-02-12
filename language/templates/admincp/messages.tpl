{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                   
                <div class="row">
                  <div class="col-lg-12 m-top-20">
               <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th colspan="4">{$pharse.messages}</th>
                                       
                                       
                                      
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                   
                                    <tr>
                                        <td colspan="4">

                                        <div role="tabpanel">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" {if $action == ''} class="active" {/if}><a href="{$config.url}/admincp/messages/" >{$pharse.all}</a></li>
    <li role="presentation" {if $action == 'inbox'} class="active" {/if}><a href="{$config.url}/admincp/messages/inbox">{$pharse.inbox}</a></li>
    <li role="presentation" {if $action == 'sent'} class="active" {/if}><a href="{$config.url}/admincp/messages/sent">{$pharse.sent}</a></li>
    <li role="presentation" {if $action == 'archive'} class="active" {/if}><a href="{$config.url}/admincp/messages/archive">{$pharse.archive}</a></li>
    <li role="presentation" {if $action == 'delete'} class="active" {/if}><a href="{$config.url}/admincp/messages/delete">{$pharse.delete}</a></li>
    <li role="presentation" {if $action == 'compose'} class="active" {/if}><a href="{$config.url}/admincp/messages/compose">{$pharse.compose}</a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home">
     {include file="admincp/message-list.tpl" nocache}

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
