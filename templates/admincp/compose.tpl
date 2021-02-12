{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
    <div class="m-top-20">
            <h4 class="messages-head">Messages</h5>
            <div role="tabpanel">
              <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" {if $action==''} class="active" {/if}>
                  <a href="{$config.url}/admincp/messages/">All</a>
                </li>
                <li role="presentation" {if $action=='inbox'} class="active" {/if}>
                  <a href="{$config.url}/admincp/messages/inbox">Inbox</a>
                </li>
                <li role="presentation" {if $action=='sent'} class="active" {/if}>
                  <a href="{$config.url}/admincp/messages/sent">Sent</a>
                </li>
                <li role="presentation" {if $action== 'archive'} class="active" {/if}>
                  <a href="{$config.url}/admincp/messages/archive">Archive</a>
                </li>
                <li role="presentation" {if $action== 'delete'} class="active" {/if}>
                  <a href="{$config.url}/admincp/messages/delete">Delete</a>
                </li>
                <li role="presentation" {if $action=='compose'} class="active" {/if}>
                  <a href="{$config.url}/admincp/messages/compose">Compose</a>
                </li>
              </ul>

              <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="home">
                  <div class="m-top-20">
                    <form action="{$config.url}/admincp/messages/save" method="POST" enctype="multipart/form-data" class="admin_form" id="compose_form" data-parsley-validate> 

                      <label>To : </label>
                      <div class="row">
                      <div class="col-xs-6 form-group">
                        <select name="users">{foreach $users as $key =>$val}
                                                                <option value="{$val.id}"> {$val.name}
                                                                    ( {$val.username} / {$val.email} ) {/foreach}
                                                            </select>
                      </div>
                      <div class="col-xs-6 form-group"> 
                        <input type="hidden" value="0" name="r_id">
                        <input type="text" class="form-control" value="" name="subject" placeholder="Subject" required>
                      </div>
                    </div>
                      <div class="form-group"> 
                        <textarea name="message" id="product_info" data-parsley-group="block1" required class="form-control" data-parsley-maxlength="500" placeholder="Message Body" value=""></textarea>
                      </div>
                      <input type="submit" value="Compose" name="btn_compose" class="btn btn-success"/> 
                    </form>
                                        </div>

                </div>
              </div>       
            </div>
</div>

<!-- /.row -->
</div>


{include file="/admincp/footer.tpl" nocache}

<script>
    $( "input[name='btn_compose']" ).click(function(e) {
        if(false === $('#compose_form').parsley().validate())
        {
            return false;
        }else {
            $('#compose_form').submit();
            $('input:submit').attr("disabled", true);
        }
    });
</script>

