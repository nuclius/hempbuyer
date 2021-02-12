{$productcount = 0}
{foreach $transaction_list as $key => $val}
{$productcount = 1}
<div class="bhis-box" style="height: max-content;line-height: 40px;">
    <div class="row">
        <div class="col-3 product_title" title="{$val.title}">
            {$val.title}
        </div>
        <div class="col-2 text-capitalize">
            {if $val.gateway}{$val.gateway}{else/}-{/if}
        </div>
        <div class="col-2">
            ${numberWithCommas($val.total_amount)}
        </div>
        <div class="col-2">
            {if $val.status=='paid'}Paid{else/}Not Paid{/if}
        </div>
        <div class="col-3">
            <a class="btn btn-prev float-left" href="/invoice/{$val.id}" style="width: 156px !important;">REVIEW TRANSACTION DOC</a>
            {if $val.transaction_contract}<a class="btn btn-info mt-1 float-right" target="_blank" href="/uploads/{$val.transaction_contract}" style="width: 156px !important;">TRANSACTION CONTRACT</a>{/if}
        </div>
    </div>
</div>
{/foreach}
{if $productcount == 0}
<div class="text-center">
    No Transaction Found !
</div>
{/if}
<div id="pagination_html" data-total-record="{$totalData}" class="mb-4"></div>
<script>
    var action = '';
    paginationData.totalRecord = +'{$totalData}';
    paginationData.url = '/transaction_list/' + action;
    paginationData.html_div = "list_div";
    paginationData.form_name = "transaction_list_form";
    $(document).ready(function () {
    });
</script>