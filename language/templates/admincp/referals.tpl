{include file="/admincp/header.tpl" nocache}
<div class="container-fluid"> 
  
  <!-- Page Heading -->
  
  <div class="row">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-user"></i> {$pharse.users} <i class="fa fa-hand-o-right"></i> <i class="fa fa-edit"></i> {$pharse.referral} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  
  <div class="row"> </div>
  <div class="table-responsive">
    <table class="table table-bordered table-hover">
      <thead>
        <tr>
          <th>{$pharse.image}</th>
          <th>{$pharse.name_/_email}</th>
          <th>{$pharse.referrer_name_/_email}</th>
          <th>{$pharse.joined}</th>
          <th>{$pharse.action}</th>
        </tr>
      </thead>
      <tbody>
      {$referralcount = 0}
      {foreach $referral as $refer}
      {$referralcount = 1}
      <tr>
        <td><a href=""><img width="50" height="50" src="{if $refer.avatar == ''} {$config['imgpath']}no_img.png {else if $refer.avatar != ''}{$config['url']}/uploads/profile/{$refer.avatar}{/if}" title="" alt="" align="center"></a></td>
        <td>{$refer.first_name} {$refer.last_name} / {$refer.email}</td>
        <td>{$refer.refererFname} {$refer.refererLname} / {$refer.refererEmail}</td>
        <td>{$refer.added}</td>
        <td>{if $refer.status == 1} 
             Approved  
             {elseif $refer.status == 0}
              <a href="{$config.url}/admincp/referral?rid={$refer.id}&ruid={$refer.from_id}" > {$pharse.approve} </a>  
             {/if}
                |  <a href="#" 
                onclick="PopupBox2('{$config.url}/admincp/referdelete?rid={$refer.id}&ruid={$refer.from_id}');"> {$pharse.delete} </a>
        </td>
      </tr>
      {/foreach}
      {if $referralcount ==0}
         <tr>
             <td colspan="5">
                 {$pharse.no_referrals_found_!}
             </td>
         </tr>
      {/if}
        </tbody>
      
    </table>
    {$pagination_html} </div>
  
  <!-- /.row --> 
</div>
{include file="/admincp/footer.tpl" nocache} 