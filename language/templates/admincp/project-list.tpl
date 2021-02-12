{if $deleted_project}
<div class="alert alert-success"> <strong>{$pharse.deleted!}</strong> </div>
{/if}
{if $undeleted_project}
<div class="alert alert-danger"> <strong>{$pharse.you_can't_delete_this.users_already_bidded!}</strong> </div>
{/if}
<div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>{$pharse.name}</th>
                                        <th>{$pharse.status}</th>
                                        <th>{$pharse.image}</th>                                        
                                        <th>{$pharse.date_added}</th>
                                        <th>{$pharse.date_closed}</th>                                        
                                        <th>{$pharse.posted_by}</th>
                                        <th>{$pharse.won_price}</th>
                                        <th>{$pharse.action}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {$item = 0}
                                 {foreach $projects as $key => $val}	
                                 {$item = 1}
                                    <tr>
                                        <td><a href="{$config.url}/product/view/{$val.id}">{$val.title}</a></td>
                                        <td>{$val.status}</td>
                                        <td><a href="#" title="{$val.title}"> <img src="{if $val.avatar == ''} {$config['imgpath']}no_img.png {else if $val.avatar != ''}{$config['imgpath']}product/{$val.avatar}{/if}" width="50" height="50" alt="1"></a></td>
                                        <td>{$val.stime}</td>
                                        <td>{$val.ctime}</td>
                                        <td>{$val.email}</td>
                                        <td>${$val.wprice}</td>
                                        <td>{if $val.sold == 0 and $val.sprice == $val.wprice and ($val.market_status == 'open' or $val.market_status == 'moderate')}<a href="{$config.url}/admincp/projects/edit/{$val.id}">Edit</a>{/if}
                                            {if $val.status != 'deleted'}

                                          <a  onclick="return confirm('Are you sure ?')" href="{$config.url}/admincp/projects/delete/{$val.id}">Delete</a>
                                          {/if}
                                               {if $val.status == 'deleted'}      deleted   {/if}
                                          {if $val.market_status == 'moderate'}<br />     

                                           <a href="{$config.url}/admincp/projects/approve/{$val.id}">{$pharse.approve}</a>
                                            


                                        {/if}
                                   		{if $val.market_status == 'open' and  $val.feature == 0}<br />                                            
                                           <a href="{$config.url}/admincp/projects/feature/{$val.id}">{$pharse.mark_as_feature}</a>
                                        {/if}
                                         {if $val.market_status == 'open' and  $val.feature == 1}<br />                                            
                                           <a href="{$config.url}/admincp/projects/unfeature/{$val.id}">{$pharse.remove_from_feature}</a>
                                        {/if}

                                    </td>
                                    </tr>
                                 {/foreach}
                                 {if $item == 0}
                                  	 <tr>
                                         <td colspan="8">
                                         No {$projectsstatus} {$pharse.products_found_!!!}
                                         </td>
                                     </tr>
                                 {/if}
                                </tbody>
                            </table>
                            {$pagination_html}
                        </div>