
<!--  data-backdrop="static" data-keyboard="false" -->
<div class="modal fade hb-modal" id="send_feedback_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                <button type="button" class="close closeMessagePopup" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                
                <h4 class="text-center">Give Feedback</h4>
                <form method="post" class="pp-form" id="feedback_form" data-parsley-validate novalidate>
                    <input type="hidden" name="f_product_id" id="f_product_id" value="">
                    <input type="hidden" name="f_invoice_id" id="f_invoice_id" value="">
                    <input type="hidden" name="f_rate" id="f_rate" value="1">
                    <!-- <input type="hidden" name="dis" id="dis" value="">
                    <span name="dis" id="dis"></span> -->
                    <div class="row">
                        <div class="col-sm-12">
                            <label class="float-left">Rate: &nbsp;</label>
                            <div class="rateit" data-rateit-value="0" data-rateit-step="1" data-rateit-resetable="false" data-rateit-mode="font" id="give_rate"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <label>Write your review:</label>
                            <textarea class="form-control" id="f_comment" name="f_comment" required></textarea>
                        </div>
                    </div>
                    <div class="row">&nbsp;</div>
                    <div class="row">
                        <div class="col-sm-12">
                            <button class="btn btn-primary float-right">Send</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

        $(document).on('submit', '#feedback_form', function(e) {
            e.preventDefault();
            var rate = $('#give_rate').rateit('value');
            if ($('#feedback_form').parsley().validate()) {
                if(rate > 0) {
                    $("#f_rate").val(rate);
                    var formArr = $(this).serializeArray();
                    var obj = {};
                    if (formArr.length) {
                        for (var index = 0; index < formArr.length; index++) {
                            const element = formArr[index];
                            obj[formArr[index].name] = formArr[index].value;
                        }
                    }
                    

                    var invoice_id = $("#f_invoice_id").val();
                    $.ajax({
                        type : 'POST',
                        url  : '/sendFeedback',
                        data :  obj,
                        dataType : 'json',
                        success  : function(data) {
                            $("#send_feedback_popup").modal('hide');
                            $("#feedbackbtn_"+invoice_id).remove();
                            swal({
                                title: "Feedback added successfully",
                            }, function (result) {
                                window.location.reload();
                            });
                        }
                    });
                } else {
                    alert("Give minimum 1 rating");
                }
            }
        });
    });

    function openFeedbackPopup(product_id, invoice_id, thiss) {
        $("#f_product_id").val(product_id);
        $("#f_invoice_id").val(invoice_id);
        $("#f_comment").val("");
        setTimeout(() => {
            $('#give_rate').rateit('reset');
            $('#give_rate').rateit('value', 1);
        }, 200);
    }
</script>