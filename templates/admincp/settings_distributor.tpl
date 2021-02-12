{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">

                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i>
                                <i class="fa fa-angle-double-right"></i>
                                <i class="fa fa-settings"></i>
                                {$heading}
                                <span style="text-transform: uppercase;"></span> 
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                <div class="row">
                       <div class="col-lg-12">
                        {if $error == 'saved'}
                         <div class="alert alert-success">
                               <strong>Saved!</strong> Settings updated successfully.
                           </div>
                        {elseif $error != ''}
                          <div class="alert alert-danger">
                               <strong>{$error}</strong>
                           </div>
                        {/if}
                        </div>
                </div>

                        <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="post" enctype="multipart/form-data" action="{$config.url}/admincp/settings/{$action}/distributor">

                          {foreach $settings as $key => $val}
                            {if $key == 'distribution_rate' || $key == 'distribution_rate_status'}
                            <div class="row">
                              <div class="col-lg-4">
                                <div class="form-group">
                                    <label>{$questions[$key]}</label>
                                </div>
                              </div>
                              <div class="col-lg-4">
                                <div class="form-group">

                                  {if $type[$key] == 'radio'}
                                    {foreach $value[$key] as $key2 => $val2}
                                        <input class="test" type="radio"  name="{$action}[{$key}]" value="{$key2}" {if $val == $key2}checked{/if}   data-parsley-group="block1" >{$val2}
                                    {/foreach}
                                  {elseif $type[$key] == 'text'}

                                    <input type="text" class="form-control" name="{$action}[{$key}]" value="{$val}" data-parsley-group="block1"  required>
                                  {elseif $type[$key] == 'hidden'}
                                    <input type="hidden" class="form-control" name="{$action}[{$key}]" value="{$val}" data-parsley-group="block1"  required>
                                  {elseif $type[$key] == 'textarea'}
                                    <textarea rows="15" col="20" class="form-control" name="{$action}[{$key}]" data-parsley-group="block1"  required>{$val}</textarea>
                                  {elseif $type[$key] == 'url'}
                                    <input type="url" class="form-control" name="{$action}[{$key}]" value="{$val}" data-parsley-group="block1"  required>
                                  {elseif $type[$key] == 'select'}
                                    <select name="{$action}[{$key}]" class="form-control" required>
                                        {foreach $value[$key] as $key2 => $val2}
                                        <option value="{$key2}" {if $val == $key2} selected{/if}  data-parsley-group="block1" >{$val2}</option>
                                        {/foreach}

                                    </select>
                                  {/if}
                                </div>
                              </div>
                            </div>
                            {elseif $type[$key] != ''}
                              <input type="hidden" class="form-control" name="{$action}[{$key}]" value="{$val}" data-parsley-group="block1"  required>
                            {/if}
                          {/foreach}
                          <div class="row form-group">
                            <div class="col-lg-12">
                               <input type="submit" value="Submit" name="id" class="btn-success btn centering" />
                            </div>
                          </div> 
                        </form> 
                </div>



                <!-- /.row -->
</div>

{include file="/admincp/footer.tpl" nocache}
