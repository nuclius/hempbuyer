<div class="m-top-20">
               <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>{$phrases.title}</th>
                                        <th>{$phrases.messages}</th>
                                        <th>{$phrases.date}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {$messagescount = 0}
                                 {foreach $messages as $key => $val}   
                                 {$messagescount = 1}
                                    <tr>
                                        <td class="text-left"> <a href="{$config.url}/admincp/contact/msgs/view/{$val.id}"> {$key+1 + (($page-1) * 10)} </a> </td>
                                        <td class="text-left"> <a href="{$config.url}/admincp/contact/msgs/view/{$val.id}"> {$val.first_name} {$val.last_name}</a></td>
                                        <td class="text-left"> <a href="{$config.url}/admincp/contact/msgs/view/{$val.id}"> {$val.email} </a></td>
                                        <td class="text-left"> <a href="{$config.url}/admincp/contact/msgs/view/{$val.id}"> {$val.phone} </a></td>
                                        <td  class="text-left"><a href="{$config.url}/admincp/contact/msgs/view/{$val.id}"> {$val.subject}</a></td>
                                        <td class="text-left">{$val.message_short}...</td>
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