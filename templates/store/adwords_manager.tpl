{include file="/common/header-1.tpl" nocache}
<link rel="shortcut icon" href="https://auctionsoftwaremarketplace.com:2002/images/logo.ic.png">
<!-- Google fonts
================================================== -->
<link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,600,700,800,300' rel='stylesheet' type='text/css' />
<!-- bootstrap v3.0.2
================================================== -->
<link rel="stylesheet" href="https://auctionsoftwaremarketplace.com:2002/css/bootstrap.css">
<!--font-awesome
================================================== -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" type="text/css">
<!-- CSS Custom
================================================== -->
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/reset-min.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/common.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/style.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/theme0.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/forward_home.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/owl.carousel.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/common_responsive.css" />
<link rel="stylesheet" type="text/css" href="https://auctionsoftwaremarketplace.com:2002/css/common_responsive1.css" /> </head>

<div class="container str-info">
    <div class="col-md-12">
        <h2>Store Advertisements</h2>
    </div>
    <div class="col-md-12 custyle">
        <table class="table table-striped custab">
            <thead>
                <span class="pull-left fnt16 ftn600">Available Funds:
                    <span class="curr_symbol">{$currency} </span> {$deposit_amount}
                    [Deposit Funds]
                    <a onclick="$('#redirecttype').val('deposit');$('#selectstore').modal('show');" class="btn btn-default ">
                        <b>+</b> Add Deposit
                    </a>
                </span>
                <a onclick="$('#redirecttype').val('campaigns');$('#selectstore').modal('show');" class="btn btn-default pull-right">
                    <b>+</b> Add  new campaign
                </a>
                <input type="hidden" id="redirecttype" value="">
                <tr>
                    <th class="text-left"> Campaign Name</th>
                    <th>Status</th>
                    <th>Updated</th>
                    <th>Budget/day</th>
                    <th>Click</th>
                    <th class="text-center">Action</th>
                </tr>
            </thead>
            {foreach $adwords_details as $key => $val}
                <tr>
                    <td class="text-left">{$val.ad_title}</td>
                    <td class="txt-pause">
                        {if $val.status == 'active'}
                            Active
                        {else if $val.status == 'pause'}
                            Pause
                        {/if}
                    </td>
                    <td>{if $val.cdate} {$val.cdate} {else if $val.cdate1} {$val.cdate1} {/if}</td>
                    <td>{$val.budget_per_day}</td>
                    <td>{$val.no_of_clicks}/{$val.budget_per_day}</td>
                    <td class="text-center">
                        <a class='btn btn-default btn-xs' href="{$config.url}/adwords/edit/{$val.id}/{$val.store_id}">
                            <span class="fa fa-edit"></span>Edit
                        </a>
                        {if $val.status == 'active'}
                            <a class='btn btn-danger btn-xs' href="{$config.url}/adwords/edit_adwords/{$val.status}/{$val.id}">
                                <span class="fa fa-pause"></span>Pause
                            </a>
                        {else $val.status == 'pause'}
                            <a class='btn btn-danger btn-xs' href="{$config.url}/adwords/edit_adwords/{$val.status}/{$val.id}">
                                <span class="fa fa-play"></span>Resume
                            </a>
                        {/if}
                        <a href="{$config.url}/adwords/edit_adwords/remove/{$val.id}" onclick="return confirmation()" class="btn btn-rmv btn-xs">
                            <span class="fa fa-remove"></span> Remove
                        </a>
                    </td>
                </tr>
            {/foreach}
            {if $adwords_details.length <= 0}
                <tr>
                    <td colspan="6">No Campaign</td>
                </tr>
            {/if}
        </table>
        {$pagination_html}
    </div>
</div>
<div class="modal" id="selectstore">
    <div class="modal-content col-md-2  col-md-offset-5" style="margin-top:12%;max-height:200px">
        <div class="modal-header h4 text-center">
            Select Store
        </div>
        <div class="modal-body">
            <select class="redirectstore form-control">
                {foreach $store as $key => $val}
                <option value="{$val.id}">{$val.name}</option>
                {/foreach}
            </select>
            <div style="margin-top: 20px;">
                <button type="button" class='btn btn-sm btn-default' data-dismiss="modal">Cancel</button>
                <button type="button" class='btn btn-sm btn-success continue pull-right'>Continue</button>
            </div>
        </div>
    </div>
</div>
<script>
    function confirmation() {
        var confirmed =  confirm("Are you sure, you want to delete ?");
        return confirmed;
    }
    $(function () {
        $('body').on('click','.continue',function() {
            var type = $('#redirecttype').val();
            var store = $('.redirectstore').val();
            if(type == 'deposit') {
                location.href="{$config.url}/adwords/add_deposit/"+store+"";
            } else if(type == 'campaigns') {
                location.href="{$config.url}/adwords/add_adwords/"+store+"";
            }
        });
    });
</script>
{include file="/common/footer-1.tpl" nocache}
