<input type="hidden" name="product_length" id="product_length" value="{$product.length}">
{$datacount = 0}
{foreach $product as $key => $val}
	{$datacount = 1}
	<a class="offer_product_item" id="productid_{$val.id}">
		<span class="product_title">{$val.title}</span>
		{if $val.unread_count}<span class="unread_count" id="unread_product_count_{$val.id}">{$val.unread_count}</span>{/if}
	</a>
{/foreach}
{if $datacount == 0}
	<div>
			No offer product found!
	</div>
{/if}