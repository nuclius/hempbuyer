{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> {$pharse.users} <i class="fa fa-hand-o-right"></i> <i class="fa fa-edit"></i> {$pharse.blog}
                            </li>
                        </ol>

                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                  <div class="col-lg-12" style="margin-bottom:2%;">
                    <a href="{$config.url}/admincp/blog/new" class="btn btn-success">{$pharse.add}</a>
                  </div>
                </div>    
                <div class="row">
                  <div class="col-lg-12 m-top-20">
               <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>{$pharse.title}</th>
                                        <th>{$pharse.message}</th>
                                        <th>{$pharse.status}</th>
                                        <th>{$pharse.date_added}</th>
                                        <th colspan="2">{pharse.action}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                 {$blogcount = 0}
                                 {foreach $blog as $key => $val}
                                 {$blogcount = 1}   
                                    <tr>
                                        <td>{$val.title}</td>
                                        <td>{$val.description_short}..</td>
                                        <td>{$val.status}</td>
                                        <td>{$val.date_add}</td>
                                        <td><a href="{$config.url}/admincp/blog/edit/{$val.id}"><i class="fa fa-edit"></i>{$pharse.edit}</a></td>
                                        <td>{if $val.status == 'open'}<a href="{$config.url}/admincp/blog/unpublish/{$val.id}"><i class="fa fa-edit"></i>Un Publish</a>{else if $val.status != 'open'}<a href="{$config.url}/admincp/blog/publish/{$val.id}"><i class="fa fa-edit"></i>Publish</a>{/if}</td>
                                    </tr>
                                 {/foreach}
                                 {if $blogcount == 0}
                                 <tr>
                                     <td colspan="6">
                                         {$pharse.no_records_found_!!!}
                                     </td>
                                 </tr>
                                 {/if}
                                </tbody>
                            </table>
                            {$pagination_html}
                        </div>
 </div>
                </div>
               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
