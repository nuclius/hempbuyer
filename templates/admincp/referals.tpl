{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

  <!-- Page Heading -->

  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-user"></i> {$phrases.users_referral} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->

  <div class="row"> </div>
  <div class="table-responsive">
    <table class="table table-bordered table-hover">
      <thead>
        <tr>
          <!--<th>{$phrases.image}</th>-->
          <th>{$phrases.name_email}</th>
          <th>{$phrases.referrer_name_email}</th>
          <th>{$phrases.joined}</th>
          <th>{$phrases.action}</th>
        </tr>
      </thead>
      <tbody>

      {if $referralcount > 0}
        {foreach $referral as $refer}
        <tr>
         <!-- <td><a href=""><img width="50" height="50" src="{if $refer.avatar == ''} {$config['imgpath']}no_img.png {else if $refer.avatar != ''}{$config['url']}/uploads/profile/{$refer.avatar}{/if}" title="" alt="" align="center"></a></td> -->
          <td>{$refer.first_name} {$refer.last_name} {if $refer.email}/ {$refer.email}{/if}/</td>
          <td>{$refer.refererFname} {$refer.refererLname} {if $refer.refererEmail}/ {$refer.refererEmail}{/if}</td>
          <td>{$refer.added}</td>
          <td>{if $refer.status == 1}
               Approved
               {elseif $refer.status == 0}
                <a href="{$config.url}/admincp/referral?rid={$refer.id}&ruid={$refer.from_id}" > Approve </a>
               {/if} |  <a href="#" onclick="PopupBox2('{$config.url}/admincp/referdelete?rid={$refer.id}&ruid={$refer.from_id}');"> Delete </a>
          </td>
        </tr>
        {/foreach}
      {/if}
      {if $referralcount == 0}
         <tr>
             <td colspan="5">
                 No Referrals Found !
             </td>
         </tr>
      {/if}
        </tbody>

    </table>
    {$pagination_html} </div>

  <!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}
