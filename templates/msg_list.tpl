<!--============================================================================*\
|| ########################################################################## ||
|| # Auction Software Marketplace[*]version[*] Build [*]build[*]
|| # ---------------------------------------------------------------------- # ||
|| # Customer License # [*]license[*]
|| # ---------------------------------------------------------------------- # ||
|| # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
|| # This file may not be redistributed in whole or significant part.       # ||
|| # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
|| # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
|| # ---------------------------------------------------------------------- # ||
|| ########################################################################## ||
\*============================================================================ -->

{if $sellers == 1}
{include file="common/seller-head.tpl" nocache}
{else}
{include file="common/buyer-head.tpl" nocache}
{/if}
<h3>Messages</h3>
          
          <ul class="arrowTabs">
               <li class="mailgroup all"><a href="{$config.url}/dashboard/newmessages">All</a></li>
               <li class="mailgroup inbox"><a href="{$config.url}/dashboard/newmessages/inbox">Inbox</a></li>
               <li class="mailgroup sent"><a href="{$config.url}/dashboard/newmessages/sent">Sent</a></li>
               
          </ul>
          
          <div class="darkgray-form clearfix">
            <div class="search-dashboard">
              <div id="validationsummary_frmMessage"></div><form method="get" action="{$config.url}/dashboard/newmessages/search" name="frmMessage" id="frmMessage" rel="search"><table width="100%"><tbody><tr>
<td></td>
<td><input type="text" name="keyword" id="keyword" name="search_keyword" value="{$keywords}" placeholder="Search Here" title=""></td>
<td></td>
<td><input type="submit" name="btn_submit" title="" value="Search"></td>
</tr></tbody></table></form> </div>
          </div>
                    <div class="tbl-email">
        <table>
        <tbody>
          {$reviewcount = 0}      
          {foreach $messages as $key => $val}
          {$reviewcount = 1}
        <tr class="" onclick="window.location='{$config.url}/dashboard/messages/view/{$val.r_id}'">
            <td width="10%">
              <div class="avatar">
            {if $loged.userid == $val.from_id}

                            <img class="mail2 img-responsive img-circle"
                                 src="{if $val.tavatar == ''} {$config['imgpath']}no_img.png {else if $val.tavatar != ''}{$config['url']}/uploads/profile/{$val.tavatar}{/if}"
                                 title="No Photo" alt="no_img"/>
                           
                            {else if $loged.userid != $val.from_id}
                            <img class="mail2 img-responsive img-circle"
                                 src="{if $val.favatar == ''} {$config['imgpath']}no_img.png {else if $val.favatar != ''}{$config['url']}/uploads/profile/{$val.favatar}{/if}"
                                 title="No Photo" alt="no_img"/>
                            {/if}
                
                    
                </div>
            </td>
            <td width="23%">
              {if $loged.userid == $val.from_id}
                <strong>{$val.tname}</strong>
              {else if $loged.userid != $val.from_id}
                <strong>{$val.fname}</strong>
              {/if}
                <br>
                   
                </td>
                <td width="59%">
                    <div class="email-txt">
                        <span>{$val.subject}</span>
                    </div>
                </td>
                <td width="8%">
                    <div class="actions">
                        <a href="{$config.url}/dashboard/messages/view/{$val.r_id}">
                            <img src="{$config['url']}/images/reply.png" alt="">
                        </a>
                        </div>
                    </td>
                </tr>
              {/foreach}
              {if $reviewcount ==0}
                 <tr>
                     <td colspan="4">
                       No messages
                     </td>
                 </tr>
             {/if}
                </tbody>
            </table>
                        <div class="pager">
               <div class="col-md-6 text-right">{$pagination_html}</div>
            </div>
                      </div>
                    
        </div>
        
      </div>
    </div>
    </div>
    </div>

    <script>
      $(document).ready(function () {
          var loc = window.location.href;
                   
          if (loc.indexOf("inbox") > -1) {
            $('.inbox').addClass("active");
          }
          else if (loc.indexOf("sent") > -1) {
            $('.sent').addClass("active");
          }
          else{
             $('.all').addClass("active");
          }
         
 
       
      });

    </script>