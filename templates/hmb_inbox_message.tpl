{include file="/common/header-1.tpl" nocache}

<!-- <div class="clearfix auth-container" style="padding-top: 100px !important;"> -->
<section class="db-wrapper db-iwrap">
    {include file="/common/header-2.tpl" nocache}
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <h3 class="acc-head">
                    INBOX
                </h3>
            </div>
            <div class="col-sm-6">
                <div class="form-inline wt-wrap">
                    <button class="btn btn-prev del-btn archiveInboxMessage">ARCHIVE</button>
                    <button class="btn btn-prev del-btn deleteInboxMessage">TRASH</button>
                </div>
            </div>
        </div>
        <div class="db-content">
            <div class="db-menu">
                <ul class="">
                    <li><a href='/inbox/all' class="active">Inbox</a></li>
                    <li><a href='/inbox/sent' class="">Sent</a></li>
                    <li><a href='/inbox/archive' class="">Archive</a></li>
                    <li><a href='/inbox/trash' class="">Trash</a></li> 
                </ul>
            </div>
            <div class="db-right-con messages-con-wrap">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>
                                <div class="cus-check">
                                    <input type="checkbox" name="check_all" class="checkAll">
                                    <span class="checkmark"></span>
                                </div>
                            </th>
                            <th>
                                FROM
                            </th>
                            <th>
                                SUBJECT
                            </th>
                            <th>
                                ACTION
                            </th> 
                        </tr>
                    </thead>
                    <form action="{$config.url}/inbox/all" method="post">
                        <tbody id="userInboxMessageSection">
                            {include file="hmb_inbox_message_template.tpl" nocache}
                        </tbody>
                    </form>
                </table>
            </div>
        </div>
    </div>
</section> 
<!-- </div> -->
<input type="hidden" name="page" value="{$currentPage}" id="page">

<!-- Success Message Popup - Starts -->
<div class="modal fade hb-modal" id="inbox-success" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close inbox-message-redirect" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">  
                <h4 class="text-center">MESSAGE SUCCESSFULLY MOVED TO TRASH</h4> 
                <div class="lsc-msg">
                    <img src="/images/user-icon.png" alt="user">
                </div>
                <div class="ss-txt">
                </div>
                <button class="btn btn-prev inbox-message-redirect">
                    OK
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Success Message Popup - Ends -->

{include file="/common/footer-1.tpl" nocache}

<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        showHideDeleteAllButton();
        searchMessage();
    });

    function searchMessage() {
        $('#userInboxMessageSection').html('');
        $.ajax({
            type : 'POST',
            url  : '/inbox/userMessageInbox',
            data :  { page : $('#page').val(), action : "all" },
            dataType : 'json',
            success  : function(data) {
                $('input[name="page"]').val(1);
                $('#userInboxMessageSection').html(data.html);
            }
        });
    }

    /*** Select All Checkbox Checked Prop set to All Rows Checkbox ***/
    $('body').on('click', '.checkAll', function() {
        $(this).prop('checked', $(this).prop('checked'));
        $('body .checkOne').prop('checked', $(this).prop('checked'));
        showHideDeleteAllButton();
    });
    
    /*** Single Checkbox Checked Prop set to Corresponding Checkbox ***/
    $('body').on('click', '.checkOne', function() {
        $(this).prop('checked', $(this).prop('checked'));
        checkOneCheckedCount();
        showHideDeleteAllButton();
    });
    
    /*** Unchecked Single Checkbox then Uncheck the Select All Checkbox Logic ***/
    function checkOneCheckedCount() {
        var totalCheckBox = $('body .checkOne').length;
        var totalCheckBoxChecked = $('body .checkOne:checked').length;
        if(totalCheckBox == totalCheckBoxChecked)
            $('body .checkAll').prop('checked', true);
        else
            $('body .checkAll').prop('checked', false);
    }
    
    /*** Show or Hide Delete Button Using Checkbox Checked Count ***/
    function showHideDeleteAllButton() {
        $("body .checkOne:checked").length > 0 ? $('body .deleteInboxMessage, .archiveInboxMessage').show() : $('body .deleteInboxMessage, .archiveInboxMessage').hide();
    }

    var selectedMessageId = [];
    var selectedMessageRid = [];
    /*** Delete Inbox Message ***/
    $('body').on('click', '.deleteInboxMessage', function(e) {
        e.preventDefault();
        var totalAmount = 0.00;
        var vendorName = '';
        selectedMessageId = [];
        selectedMessageRid = [];
        if( $("body .checkOne:checked").length > 0 ) {
            $("body .checkOne:checked").each(function(i, v) {
                //selectedMessageId.push($(this).attr('data-id'));
                selectedMessageRid.push($(this).attr('data-r_id'));
            });
            /*if(selectedMessageId.length > 0) {
                selectedMessageId = selectedMessageId.join(',');*/
            if(selectedMessageRid.length > 0) {
                selectedMessageRid = selectedMessageRid.join(',');
                $.ajax({
                    type : 'POST',
                    url  : '/inbox/deleteInboxMessage',
                    //data : { messageIds : selectedMessageId },
                    data : { messageIds : selectedMessageId, rIds : selectedMessageRid },
                    dataType : 'json',
                    success  : function(data) {
                        if(data.status == 'success') {
                            $('body #inbox-success .modal-title').html('MESSAGE SUCCESSFULLY MOVED TO TRASH');
                            $('body #inbox-success').modal('show');
                        } else if(data.status == 'failed') 
                            window.location.reload();
                        else if(data.status == 'session_expired')
                            window.location.href = '/signin';
                    }
                });
            } else
                alert('No Message Select to Delete');
        }
    });

    /*** Archive Inbox Message ***/
    $('body').on('click', '.archiveInboxMessage', function(e) {
        e.preventDefault();
        var totalAmount = 0.00;
        var vendorName = '';
        selectedMessageId = [];
        selectedMessageRid = [];
        if( $("body .checkOne:checked").length > 0 ) {
            $("body .checkOne:checked").each(function(i, v) {
                //selectedMessageId.push($(this).attr('data-id'));
                selectedMessageRid.push($(this).attr('data-r_id'));
            });
            /*if(selectedMessageId.length > 0) {
                selectedMessageId = selectedMessageId.join(',');*/
            if(selectedMessageRid.length > 0) {
                selectedMessageRid = selectedMessageRid.join(',');
                $.ajax({
                    type : 'POST',
                    url  : '/inbox/archiveInboxMessage',
                    //data : { messageIds : selectedMessageId },
                    data : { messageIds : selectedMessageId, rIds : selectedMessageRid },
                    dataType : 'json',
                    success  : function(data) {
                        if(data.status == 'success') {
                            $('body #inbox-success .modal-title').html('MESSAGE SUCCESSFULLY MOVED TO ARCHIVE');
                            $('body #inbox-success').modal('show');
                        } else if(data.status == 'failed')
                            window.location.reload();
                        else if(data.status == 'session_expired')
                            window.location.href = '/signin';
                    }
                });
            } else
                alert('No Message Select to Archive');
        }
    });

    $('body').on('click', '.inbox-message-redirect', function() {
        window.location.reload();
    });
</script>