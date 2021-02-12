
{if $user_list.length}
    <input type="hidden" id="offer_buyer_id" value="{$user_list[0].offer_buyer_id}">
    {foreach $user_list as $key => $val}
        <div class="user_item" >
            <a href="javascript:void(0)" onclick="getUserChat({$val.sender_id}, '{$val.sender_username}')" class="user_item_a" id="chat_user__{$val.sender_id}">{$val.sender_username} {if $val.unread_count}<span class="unread_count_buyer" id="unread_count__{$val.sender_id}">{$val.unread_count}</span>{/if}</a>
        </div>
    {/foreach}
{/if}