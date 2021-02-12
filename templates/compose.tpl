<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->

{include file="common/header-1.tpl" nocache}
<div class="main_container">
  <div class="row dashboard">
    <div class="col-md-3"> {include file="left-nav-dashboard.tpl" nocache} </div>
    <div class="col-md-9">
      <div class="row ds_brd">
        <div class="col-md-8">
          <h4>{$phrase.my_messages}</h4>
        </div>
        <div class="col-md-3">
          <button class="btn btn-blue">
          <a href="{$config.url}/dashboard/messages/compose">Compose</a>
          </button>
        </div>
      </div>
      <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" {if $action == ''} class="active" {/if}><a href="{$config.url}/dashboard/messages/" >{$phrase.all}</a></li>
        <li role="presentation" {if $action == 'inbox'} class="active" {/if}><a href="{$config.url}/dashboard/messages/inbox">{$phrase.inbox}</a></li>
        <li role="presentation" {if $action == 'sent'} class="active" {/if}><a href="{$config.url}/dashboard/messages/sent">{$phrase.sent}</a></li>
        <li role="presentation" {if $action == 'archive'} class="active" {/if}><a href="{$config.url}/dashboard/messages/archive">{$phrase.archive}</a></li>
        <li role="presentation" {if $action == 'delete'} class="active" {/if}><a href="{$config.url}/dashboard/messages/delete">{$phrase.delete}</a></li>
        <li role="presentation" {if $action == 'compose'} class="active" {/if}><a href="{$config.url}/dashboard/messages/compose">{$phrase.compose}</a></li>
      </ul>
      <div class="tab-content">
        <div class="compose_mbox">
         <form action="{$config.url}/dashboard/messages/save"  method="POST" enctype="multipart/form-data" class="admin_form" data-parsley-validate>
         <input type="hidden" value="0" name="r_id">
          <div class="row">
            <div class="col-md-1">{$phrase.to}</div>
            <div class="col-md-11">
              <input class="form-control searching" name="username" id="username" value="Admin" disabled="disabled" placeholder="User Name">
            </div>
            <div id="result"></div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <input class="form-control" name="subject" value="" placeholder="Subject" required>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <textarea class="form-control" name="message" data-parsley-group="block1" required data-parsley-maxlength="500" data-parsley-length="[100, 500]" value="" onkeyup="limitlengths(this, 500,'product_info_label')"  rows="5"></textarea>
            </div>
            <div class="row">
              <div class="col-md-3  m-top-10 padding-20">
                <input type="submit" name="submit" value="Send" class="btn btn-blue1">
              </div>
            </div>
          </div>
         </form> 
        </div>
      </div>
    </div>
  </div>
</div>
</div>
</div>
{include file="common/footer-1.tpl" nocache} 