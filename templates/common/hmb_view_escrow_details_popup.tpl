
<!--  data-backdrop="static" data-keyboard="false" -->
<div class="modal fade hb-modal" id="escrow_details_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                
                <button type="button" class="close closeMessagePopup" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center">Contact Details of Agent</h4>
                <form method="post" class="pp-form" id="message_form" data-parsley-validate novalidate>
                    <div class="row">
                        <label class="col-sm-4 font-weight-bold">Full Name:</label>
                        <span class="col-sm-8" id="es_user_name"></span>
                    </div>
                    <div class="row">
                        <label class="col-sm-4 font-weight-bold">Email:</label>
                        <span class="col-sm-8" id="es_user_email"></span>
                    </div>
                    <div class="row">
                        <label class="col-sm-4 font-weight-bold">Phone:</label>
                        <span class="col-sm-8" id="es_user_phone"></span>
                    </div>
                    <div class="row">&nbsp;</div>
                    <div class="row">
                        <div class="col-sm-12">
                            <button class="btn btn-primary float-right" data-dismiss="modal" aria-hidden="true">Close</button>
                        </div>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function openEscrowDetailsPopup(user_name, user_company, user_email, user_phone, bank_name, account_name, account_number, routing_number) {
        $("#es_user_name").html(user_name);
        $("#es_user_email").html(user_email);
        $("#es_user_phone").html(user_phone);
        $("#escrow_details_popup").modal();
    }
</script>