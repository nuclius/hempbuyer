<input type="hidden" id="chat_length" name="chat_length" value="{$chat_list.length}">
{if $chat_list.length}
    {foreach $chat_list as $key => $val}
        <div class="chat_item">
            <div class="{if $val.sender_id==$loged.userid}sent{else /}received{/if}">{$val.message}
            <span class="text-secondary float-right font-italic mt-2">{$val.created_date}</span>
            </div>
        </div>
    {/foreach}
{else /}
<div class="chat_other_div">Start chat...</div>
{/if}