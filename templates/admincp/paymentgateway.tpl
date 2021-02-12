{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <style type="text/css">
    .jkm {
        padding-top: 9%;
    }

    @media screen and (max-width:1200px) {
        .jkm {
            padding-top: 0%;
        }
    }
    </style>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">
            <ol class="breadcrumb">
                <li class="active">
                    Payment Gateway
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/payments/gateway">
            <div class="col-lg-4">
                <div class="form-group">
                    <label>{$phrases.email}</label>
                    <input class="form-control" name="email" value="{$search.email}">
                </div>
            </div>
            <div class="col-lg-3">
                <div class="form-group">
                    <label>{$phrases.first_name}</label>
                    <input class="form-control" placeholder="Enter First Name" value="{$search.first_name}" name="first_name">
                </div>
            </div>
             <div class="col-lg-3">
                    <div class="form-group">
                    <label>{$phrases.last_name}</label>
                    <input class="form-control" placeholder="Enter Last Name" value="{$search.last_name}" name="last_name">
                </div>
            </div>
            <div class="col-lg-2">
                <div class="form-group btn-mrg">
                    <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$phrases.search} </button>
                </div>
            </div>
        </form>
    </div>
    {include file="/admincp/payments-list.tpl" nocache}
    <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}
<script language="javascript" type="text/javascript">
function updateBalance(userid) {
  var bal = $('#inc_bal'+userid).val();
    $.ajax({
        type: 'POST',
        url: '/admincp/update/balance',
        data: {
            id: userid,
            add_bal: $('#inc_bal'+userid).val()
        },
        dataType: 'json',
        success: function(data) {
            if (data == 1) {
              $('#bal_'+userid).text(parseFloat($('#bal_'+userid).text()) + parseFloat($('#inc_bal'+userid).val()))
              $('#inc_bal'+userid).val('');
              // alert(1);
            } else {
              // alert(0);
             //console.log('err occured...!');
            }
        }

    });
}
</script>
</body>

</html>