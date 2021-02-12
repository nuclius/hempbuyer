<input type="hidden" id="chat_length" name="chat_length" value="{$listData.length}">
{if $listData.length}
    {foreach $listData as $key => $val}
        <div class="chat_item">
            <div class="{if $val.sender_id==$buyer_id}sent{else /}received{/if}">
				<span class="msg">{$val.message}</span>
				<div style="display: inline-block;width: 100%;float: left;padding: 0px; margin-top: 5px;">
					<span class="text-secondary float-left font-italic">{$val.sender_email}</span>
					<span class="text-secondary float-right font-italic" style="margin-left: 20px;">{$val.created_date}</span>
				</div>
            </div>
        </div>
    {/foreach}
{else /}
<div class="chat_other_div">Start chat...</div>
{/if}