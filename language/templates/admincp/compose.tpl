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
                                    <li role="presentation" {if $action==
                                    ''} class="active" {/if}><a href="{$config.url}/admincp/messages/">{$pharse.all}</a></li>
                                    <li role="presentation" {if $action==
                                    'inbox'} class="active" {/if}><a
                                        href="{$config.url}/admincp/messages/inbox">{$pharse.inbox}</a></li>
                                    <li role="presentation" {if $action==
                                    'sent'} class="active" {/if}><a
                                        href="{$config.url}/admincp/messages/sent">{$pharse.sent}</a></li>
                                    <li role="presentation" {if $action==
                                    'archive'} class="active" {/if}><a href="{$config.url}/admincp/messages/archive">{$pharse.archive}</a></li>
                                    <li role="presentation" {if $action==
                                    'delete'} class="active" {/if}><a href="{$config.url}/admincp/messages/delete">{$pharse.delete}</a></li>
                                    <li role="presentation" {if $action==
                                    'compose'} class="active" {/if}><a href="{$config.url}/admincp/messages/compose">{$pharse.compose}</a></li>
                                </ul>

                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane active" id="home">
                                        <div class="col-lg-12 m-top-20" style="padding-left:0; padding-right:0;">
                                            <form action="{$config.url}/admincp/messages/save" method="POST"
                                                  enctype="multipart/form-data" class="admin_form" id="compose_form"
                                                  data-parsley-validate>
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover">

                                                        <tbody>

                                                        <tr>
                                                            <td>To : <select name="users">{foreach $users as $key =>
                                                                $val}
                                                                <option value="{$val.id}"> {$val.first_name}
                                                                    {$val.last_name} ({$val.email}) {/foreach}
                                                            </select></td>

                                                        </tr>


                                                        <tr>
                                                            <td colspan="3">


                                                                <input type="hidden" value="0" name="r_id">

                                                                <h2><input type="text" class="form-control" value=""
                                                                           name="subject" placeholder="Subject"
                                                                           required></h2>

                                                                <h2>
                                                                    <!--<textarea name="message" id="product_info" data-parsley-group="block1" required class="form-control" data-parsley-maxlength="500" data-parsley-length="[100, 500]" value="" onkeyup="limitlengths(this, 500,'product_info_label')"></textarea>-->
                                                                    <textarea name="message" id="product_info"
                                                                              data-parsley-group="block1" required
                                                                              class="form-control"
                                                                              data-parsley-maxlength="500"
                                                                              placeholder="Message Body"
                                                                              value=""></textarea>
                                                                </h2>
                                                                <input type="submit" value="Compose" name="btn_compose"
                                                                       class="btn btn-success"/>


                                                            </td>
                                                        </tr>
                                                        </tbody>

                                                    </table>
                                                </div>
                                        </div>
                                    </div>
                                    </form>
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

