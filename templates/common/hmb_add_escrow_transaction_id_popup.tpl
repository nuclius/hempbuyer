
<!--  data-backdrop="static" data-keyboard="false" -->
<div class="modal fade hb-modal" id="add_escrow_transaction_id_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close closeMessagePopup" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center">Add Escrow Transaction ID</h4>
                <form method="post" class="pp-form" id="add_escrow_transaction_id_form" data-parsley-validate novalidate>
                    <input type="hidden" name="tr_invoice_id" id="tr_invoice_id" value="">
                    <input type="hidden" name="tr_escrow_id" id="tr_escrow_id" value="">
                    <div class="row">
                        <div class="col-sm-12">
                            <label>Transaction ID</label>
                            <input type="text" class="form-control" id="tr_transaction_id" name="tr_transaction_id" required placeholder="Transaction ID">
                        </div>
                    </div>
                    <div class="row">&nbsp;</div>
                    <div class="row">
                        <div class="col-sm-12">
                            <button class="btn btn-primary float-right">Add</button>
                        </div>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    
    function openAddTransactionIdPopup(escrow_id, buynow_id) {
        $("#tr_invoice_id").val(buynow_id);
        $("#tr_escrow_id").val(escrow_id);
        $("#add_escrow_transaction_id_popup").modal();
    }
    $(document).on('submit', '#add_escrow_transaction_id_form', function(e) {
        e.preventDefault();
        if ($('#add_escrow_transaction_id_form').parsley().validate()) {
            var formArr = $(this).serializeArray();
            var obj = {};
            if (formArr.length) {
                for (var index = 0; index < formArr.length; index++) {
                    obj[formArr[index].name] = formArr[index].value;
                }
            }
            $.ajax({
                type: 'POST',
                url: '/add_escrow_transaction_id',
                data: obj,
                dataType: 'json',
                success: function (data) {
                    if(data.success) {
                        swal('Transaction ID added successfully');
                        searchForm();
                        $("#add_escrow_transaction_id_popup").modal('hide');
                    } else {
                        swal(data.error);
                    }
                }
            });
        }
    });
</script>