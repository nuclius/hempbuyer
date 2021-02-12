{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-edit"></i> {$pharse.phrases} <i class="fa fa-hand-o-right"></i> <i class="fa fa-settings"></i> 
                                
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                <div class="row">
                       <div class="col-lg-12">
                            {$pharse.please} <a href="{$config.url}/admincp/language/export/download">{$pharse.click_here}</a> {$pharse.to_download} {$export_file} {$pharse.phrases_in_json_format}
                          
                            <p>
                                 { <br />
                                  &nbsp;&nbsp;"{$pharse.language}": { <br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.language}": "{$pharse.english}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.language-code}": "en-US",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.phrases}": { <br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.home}": "{$pharse.home}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.future}": "{$pharse.future}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.live}": "{$pharse.live}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.auction}": "{$pharse.auction}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.s}": "{$pharse.s}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.closed}": "{$pharse.closed}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.winner}": "{$pharse.winner}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.blog}": "{$pharse.blog}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.deposit}": "{$pharse.deposit}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.register}": "{$pharse.register}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.log_in}": "{$pharse.log_in}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.buy_now}": "{$pharse.buy_now}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.all_categories}": "{$pharse.all_categories}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.dashboard}": "{$pharse.dashboard}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.search}": "{$pharse.search}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.welcome}": "{$pharse.welcome}",<br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.all_categories}": "{$pharse.all_categories}", <br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"{$pharse.a}": "{$pharse.sadasd}" <br />
                                  &nbsp;&nbsp;&nbsp;&nbsp;} <br />
                                  &nbsp;&nbsp;} <br />
                                 } <br />

                             <p> 
                             
                        </div>
                        

                    

                </div>	
                

               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
