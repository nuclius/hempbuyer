<div class="m-top-20">
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
                <tr> 
                    <th>{$phrases.subject}</th>
                    <th>{$phrases.messages}</th>
                    <th>{$phrases.date}</th>
                </tr>
            </thead>
            <tbody>
                {$messagescount = 0}
                    {foreach $messages as $key => $val}   
                        {$messagescount = 1}
                        <tr> 
                            <td>
                                <a href="{$config.url}/admincp/messages/view/{$val.r_id}">
                                    {$val.subject}
                                </a>
                            </td>
                            <td><a href="{$config.url}/admincp/messages/view/{$val.r_id}">{$val.message_short}..</a></td>
                            <td>{$val.date_add}</td>
                        </tr>
                {/foreach}
                {if $messagescount == 0}
                    <tr>
                        <td colspan="3">
                            No {$messagesstatus} messages found!
                        </td>
                    </tr>
                {/if}
            </tbody>
        </table>            
    </div>
    {$pagination_html}
 </div>
</div>