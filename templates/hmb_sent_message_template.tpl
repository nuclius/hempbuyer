{foreach $messages as $key => $val}
    <tr>
        <!-- <td>
            <div class="cus-check">
                <input type="checkbox" name="check_msg" data-id="{$val.id}" class="checkOne">
                <span class="checkmark"></span>
            </div>
        </td> -->
        <td>
            <div class="media msg-media">
                <div class="media-left">
                    <img src="/no_user_image.png" class="img-responsive" alt="No Image Available" onerror="this.onerror=null;this.src='/no_user_image.png';">
                </div>
                <div class="media-body">
                    {if $val.trole == 0}
                        Admin
                    {else/}
                        {if $sessionId==$val.from_id} {$val.toName} 
                        {elseif $sessionId==$val.to_id\} {$val.fromName} {/if}
                    {/if}
                </div>
            </div>
        </td>
        <td>
           {$val.subject}
        </td>
        <td class="viewMessage" style="cursor: pointer;" data-product_id="{$val.project_id}" data-r_id="{$val.r_id}" data-message_id="{$val.id}" data-type="sent">
            <i class="fa fa-eye"></i>
        </td>
    </tr>
{/foreach}

{if $messages.length==0}
    <tr class="text-center not_found"><td colspan="3" class="text-center not_found">No Messages Found! </td></tr>
{/if}

<nav class="text-right">
     {$pagination_html}
</nav>