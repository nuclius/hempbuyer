{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

    <style type="text/css">

        span.w-100 {
            /* width: 140px;*/
            float: left;
            height: 48px;
        }

        .pro_image {
            border-radius: 3px;
            background-color: #FFF;
            box-shadow: 0px 0px 2px #ccc;
            text-align: center;
            line-height: 0;
            margin: 0px auto 0px;
            background-position: center center;
            background-size: cover;
            display: inline-block;
            width: auto;
            padding: 10px;
            height: auto;
        }

        .addresscity {
            color: #F00;
        }
    </style>
    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li class="active">Payments
                    <i class="fa fa-angle-double-right"></i>
                    {if $payment_req.id == 0 or $payment_req.id == ''} Add {else} Edit {/if} Payment 
                </li>
            </ol>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-8">
        {if $error == 'saved'}
            <div class="alert alert-success"><strong>Saved!</strong>
            {if $stat_msg !=''}
                {$stat_msg}
            {else}
                Payment edited successfully changed.
            {/if}
            </div>
        {elseif $error != ''}
            <div class="alert alert-danger"><strong>{$error}</strong></div>
        {/if}
            <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="registration-form" method="post" enctype="multipart/form-data" action="{$config.url}/admincp/payment/update">
            <!-- <form enctype="multipart/form-data" class="admin_form" data-parsley-validate id="admin_form" method="post" enctype="multipart/form-data" action="{$config.url}/admincp/users/save"> -->
                <input type="hidden" value="{$payment_req.id}" name="id"/>

                <div class="form-group">
                    {if $payment_req.type == 'wire'}
                        <label>Fund Receipt :</label><br/>

                        <div class="pro_image">
                        <img id="pro_image" src="{if $payment_req.avatar == ''} {$config.url}/images/no_img.png {else if $payment_req.avatar != ''}{$config['imgpath']}wirefund_receipt/{$payment_req.avatar}{/if}" width="82" title="{$payment_req.first_name}" height="83" alt="{$val.title}"></a> </div> <br>
                        <div class="fileUpload btn btn-primary redbg5"><span>Browse</span>
                            <input id="uploadBtn" type="file" class="upload" name="profile_image">
                        </div>
                    {/if}

                    <!--input type="file" name="profile_image"-->
                </div>
                <div class="form-group">
                    <label>Name :</label>
                    <input class="form-control" data-parsley-trigger="change focusout" value="{$payment_req.first_name} {$payment_req.last_name}" disabled="true">
                </div>
                <div class="form-group">
                    <label>Email-ID :</label>
                    <input class="form-control" data-parsley-trigger="change focusout" value="{$payment_req.email}" disabled="true">
                </div>
                <div class="form-group">
                    <label>Current User Balance :</label>
                    <input class="form-control" value="{$payment_req.balance}"
                           id="balance" name="balance" disabled="true">
                           <span id="balance-check-err" class="err-message"></span>
                </div>
                <div class="form-group">
                    <label>Requested Funds* :</label>
                    <input class="form-control" data-parsley-trigger="change focusout" placeholder="Enter First Name" value="{$payment_req.amount}"
                           id="amount" name="amount" data-parsley-group="block1" data-parsley-type="number" data-parsley-required required>
                           <span id="amount-check-err" class="err-message"></span>
                </div>
                    <div class="form-group">
                     <select  data-id="{$payment_req.id}" class="form-control status_{$payment_req.id}" id="status" name="status">
                        <option value="approve" {if $payment_req.status=='approve'} selected {/if}>Approve{if $payment_req.status=='active'}d{/if}</option>
                        <option value="reject" {if $payment_req.status=='reject'} selected {/if}>Reject
                        {if $payment_req.status=='reject'}ed{/if}</option>
                        <option value="unverified" {if $payment_req.status=='unverified'} selected {/if}>Unverified</option>
                      </select>
                  </div>

                <input id="adminsub_button" type="submit" class="btn btn-success submit_form" value="submit">

        </form>
        </div>
    </div>

    <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}
</body>
</html>
