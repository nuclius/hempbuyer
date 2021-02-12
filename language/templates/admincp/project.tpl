{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->

                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">

                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="icon flaticon-flower-with-leaves"></i> {$pharse.products} <i class="fa fa-hand-o-right"></i> <i class="fa fa-search"></i> {$pharse.search}
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                   <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/projects/list">

                         <div class="col-lg-4">
                            <div class="form-group">
                                <label>{$pharse.title}</label>
                                <input class="form-control" name="title" value="{$search.title}">
                            </div>
                            <div class="form-group">
                                <label>{$pharse.product_id}</label>
                                <input class="form-control"  value="{$search.id}" name="id">
                            </div>
                          </div>

                          <div class="col-lg-4">
                            <div class="form-group">
                                <label>{$pharse.status}</label>
                                 <select class="form-control" name="status">
                                    <option value="" {if $search.status == ''} selected {/if}>{$pharse.all}</option>
                                    <option value="open"  {if $search.status == 'open'} selected {/if}>{$pharse.open}</option>
                                    <option value="closed"  {if $search.status == 'closed'} selected {/if}>{$pharse.closed}</option>
                                    <option value="sold"  {if $search.status == 'sold'} selected {/if}>{$pharse.sold}</option>
                                    <option value="future"  {if $search.status == 'future'} selected {/if}>{$pharse.future}</option>
                                     <option value="delete"  {if $search.status == 'delete'} selected {/if}>{$pharse.deleted}</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <br />
                              <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$pharse.search}</button>
                           </div>
                          </div>




                        </form>

                </div>

                {include file="/admincp/project-list.tpl" nocache}


                <!-- /.row -->
</div>

{include file="/admincp/footer.tpl" nocache}
