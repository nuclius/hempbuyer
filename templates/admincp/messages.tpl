{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <div class="row">
      <div class="col-lg-12 m-top-20">
        <h4 class="messages-head">Messages</h5>
        <div role="tabpanel"> 
          <!-- Nav tabs -->
          <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" {if $action == ''} class="active" {/if}><a href="{$config.url}/admincp/messages/" >{$phrases.all}</a></li>
            <li role="presentation" {if $action == 'inbox'} class="active" {/if}><a href="{$config.url}/admincp/messages/inbox">{$phrases.inbox}</a></li>
            <li role="presentation" {if $action == 'sent'} class="active" {/if}><a href="{$config.url}/admincp/messages/sent">{$phrases.sent}</a></li>
            <li role="presentation" {if $action == 'archive'} class="active" {/if}><a href="{$config.url}/admincp/messages/archive">{$phrases.archive}</a></li>
            <li role="presentation" {if $action == 'delete'} class="active" {/if}><a href="{$config.url}/admincp/messages/delete">{$phrases.delete}</a></li>
            <li role="presentation" {if $action == 'compose'} class="active" {/if}><a href="{$config.url}/admincp/messages/compose">{$phrases.compose}</a></li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="home">
             {include file="admincp/message-list.tpl" nocache} 
            </div>
            
          </div>

        </div>
               
      </div>
    </div>    <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
