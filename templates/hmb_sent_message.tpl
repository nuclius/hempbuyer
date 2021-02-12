{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    SENT
                </h3>
            </div>
            <!-- <div class="col-sm-6">
                <div class="form-inline wt-wrap">
                    <button class="btn btn-prev del-btn deleteInboxMessage">DELETE</button>
                </div>
            </div> -->
        </div>
        <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href='/inbox/all' class="">Inbox</a></li>
                    <li><a href='/inbox/sent' class="active">Sent</a></li>
                    <li><a href='/inbox/archive' class="">Archive</a></li>
                    <li><a href='/inbox/trash' class="">Trash</a></li> 
                </ul>
            </div>
            <div class="db-right-con messages-con-wrap">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <!-- <th>
                                <div class="cus-check">
                                    <input type="checkbox" name="check_all" class="checkAll">
                                    <span class="checkmark"></span>
                                </div>
                            </th> -->
                            <th>
                                TO
                            </th>
                            <th>
                                SUBJECT
                            </th>
                            <th>
                                ACTION
                            </th> 
                        </tr>
                    </thead>
                    <form action="{$config.url}/inbox/sent" method="post">
                        <tbody id="userSentMessageSection">
                            {include file="hmb_sent_message_template.tpl" nocache}
                        </tbody>
                    </form>
                </table>
            </div>
        </div>
    </div>
</section> 
<!-- </div> -->
<input type="hidden" name="page" value="{$currentPage}" id="page">

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        searchMessage();
    });

    function searchMessage() {
        $('#userSentMessageSection').html('');
        $.ajax({
            type : 'POST',
            url  : '/inbox/userMessageInbox',
            data :  { page : $('#page').val(), action : "sent" },
            dataType : 'json',
            success  : function(data) {
                $('input[name="page"]').val(1);
                $('#userSentMessageSection').html(data.html);
            }
        });
    }
</script>