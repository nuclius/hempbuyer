<input type="hidden" name="buyer_length" id="buyer_length" value="{$listData.length}">
{$datacount = 0}
{foreach $listData as $key => $val}
	{$datacount = 1}
	<a class="offer_buyer_item" id="buyerid_{$val.id}">
		<span style="float: left; width: 80%;">
			<span class="buyer_name">{$val.name}</span>
			<span class="buyer_email">{$val.email}</span>
		</span>
		{if $val.unread_count}<span class="unread_count" id="unread_buyer_count_{$val.id}">{$val.unread_count}</span>{/if}
	</a>
{/foreach}
{if $datacount == 0}
	<div>
			No buyer offer found!
	</div>
{/if}