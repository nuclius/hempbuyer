<!--  data-backdrop="static" data-keyboard="false" -->
<div class="modal fade hb-modal" id="view_feedback_popup" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"> 
                <img src="{$config.url}/images/logo.png" class="m-auto" />
                
                <button type="button" class="close closeMessagePopup" data-dismiss="modal" aria-hidden="true">
                    <i class="fa fa-times-circle"></i>
                </button>
            </div>
            <div class="modal-body">
                <h4 class="text-center">View Feedback</h4>
                <div class="row">
                    <div class="col-sm-2">
                        <label>Rate:</label>
                    </div>
                    <div class="col-sm-10" id="rate_div">
                        <div class="rateit" data-rateit-value="3" data-rateit-resetable="true" data-rateit-ispreset="true" data-rateit-mode="font" id="resett" data-rateit-readonly="true"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-2">
                        <label>Review:</label>
                    </div>
                    <div class="col-sm-10" id="comment_div">
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

    });

    function viewFeedback(feedback_id) {
        console.log('feedback_id', feedback_id);
        if(+feedback_id > 0) {
            $.ajax({
                type : 'POST',
                url  : '/get_feedback',
                data :  { feedback_id: feedback_id },
                dataType : 'json',
                success  : function(data) {
                    // $('#rate_div').html(data.result.rate);
                    var comment = data.result.comment.replace(/\n/g, "<br />");
                    $('#comment_div').html(comment);
                    setTimeout(() => {
                        $('#resett').rateit('reset')
                        $('#resett').rateit('value', data.result.rate)
                    }, 200);
                }
            });
        } else {
            $("#view_feedback_popup").modal('hide');
        }
    }
</script>