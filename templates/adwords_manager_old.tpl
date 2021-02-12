<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->

{include file="/common/header-1.tpl" nocache}
{if $error}
<div class="alert alert-success">
    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
     {$error}
</div>
{/if}
    <div class="col-md-12">
        <div class="daashbrd_cngpswd"><a href="/dashboard/my">{Dashboard}</a> &gt;&gt; {$phrase.adwords}</div>
        <div class="col-md-3 txtfun3 padlef0 mobile_view"> {include file="left-profile-nav.tpl" nocache} </div>
        <div class="col-md-9">
			<div class="row">
            <div class="col-md-8">
                <div class="iome3" style="padding-top: 0px;">{$phrase.advertisements}</div>
            </div>
            <div class="col-md-12">
                <div class="pull-left">{$phrase.available_funds}: <span class="curr_symbol">{$currency} </span> {$deposit_amount}[<span>{$phrase.deposit_funds}</span>] <a href="{$config.url}/adwords/add_deposit">Add Deposit</a> {if $deposit_amount <= 0}<br><br>{$phrase.please_deposit_funds_to_your_account} {/if}</div>
                <div class="pull-right">
                    <button class="btn btn-warning" onclick="location.href='/adwords/add_adwords'" {if $deposit_amount <= 0} disabled {/if}> {$phrase.new_campaign} </button>
                </div>
            </div>

            <div class="col-md-12 iome6">
                <table class="table">
                    <thead class="md_hide">
                    <tr class="iome2 ">
                        <th class="iome9">{$phrase.campaign_name}</th>
                        <th class="text-center iome9">{$phrase.status}</th>
                        <th class="text-center iome9">{$phrase.updated}</th>
                        <th class="text-center iome9">{$phrase.budget_day}</th>
                        <th class="text-center iome9">{$phrase.click}</th> 
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $adwords_details as $key => $val}
                    <tr>
                        <td data-label="Campaign Name" class="account_p_lbl iome7 iome8">
                            <div class="iome5"><a href="{$config.url}/adwords/edit/{$val.id}" class="iome5" > {$val.ad_title} </a></div>
                            <div>
                                <a class="iome5" href="{$config.url}/adwords/edit_adwords/{$val.status}/{$val.id}" > {if $val.status == 'active'} Pause {else $val.status == 'pause'} Resume {/if}</a>
                                | <a href="{$config.url}/adwords/edit_adwords/remove/{$val.id}" onclick="return confirmation()" class="iome5">Remove</a>
                            </div>
                        </td>
                        <td data-label="Status" class="account_p_lbl iome7" align="center">{if $val.status == 'active'} Active {else $val.status == 'psuse'} Pause {/if}  </td>
                        <td data-label="Updated" class="account_p_lbl iome7" align="center">{dateFormat($val.created_at, 'dd mmmm yyyy')}</td>
                        <td data-label="Budget/day" class="account_p_lbl iome7" align="center">{$val.budget_per_click}</td>
                        <td data-label="Click" class="account_p_lbl iome7" align="center">{$val.no_of_clicks}/{$val.budget_per_day}</td> 
                    </tr>
                   {/foreach}
                    </tbody>
                </table>
                {$pagination_html}
            </div>
</div>

        </div>

    </div>
<script>
    function confirmation() {
        var confirmed =  confirm("Are you sure, you want to delete ?");
        return confirmed;
    }
</script>
{include file="/common/footer-1.tpl" nocache}