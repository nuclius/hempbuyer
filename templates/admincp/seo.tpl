{include file="/admincp/header.tpl" nocache} 
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}select2.css" />
<script src="{$config['externaljs']}select2.js"></script>
<script>
  $(function(){

    var url = window.location.href;
   

    if (url.indexOf("editseo").length != -1) {
      $('ul.tab-items>li').removeClass('active');
      $('.nav-tabs a[href="#tab2default"]').tab('show');
    }

    





  });
</script>
<style>
#sel-lang{
    width:50%;
}
#sel-phrase{

    width:50%;
}
.abbre{

    width:50%;

}

.panel-default > .curr-title{

background-color: #FF0;
text-decoration: none;
color:#000;
}
.curr-exchange{

   background-color: #FAF5CE;
text-decoration: none;
height: 30px;
padding:5px;
color:#000; 
}
.note li{
  text-indent: -1em;
  padding-left: 1em;
  margin: 0 0 5px 0;
}

@media screen and (max-width:767px){

  #sel-lang{
    width:100% !important;
}
 #sel-phrase{

    width:100% !important;
  }
}


</style>
<script>
$(function(){
  $("#converter").click(function () {
      var textValue = $('#phrase').val();
      textValue = textValue.trim();
      textValue = textValue.toLowerCase().replace(/ /g,"_");
      $('#temp_var').val(textValue);
  });
});



</script>

<div class="">
<h2>
        SEO Tools
</h2>
<div class="">
    	
    	<div class="panel with-nav-tabs panel-default">
                <div class="panel-heading">
                        <ul class="nav nav-tabs tab-items">
                            <li class="active"><a href="#tab1default" data-toggle="tab">
                              Enable/Disable SEO
                            </a></li>
                            <li id="add_seo"><a href="#tab2default" data-toggle="tab">
                              Add Page SEO
                            </a></li>
                            <li id="view_seo"><a href="#tab3default" data-toggle="tab">
                              View Page SEO

                            </a></li>
                            
                            <!--<li><a href="#tab4default" data-toggle="tab">Setting</a></li>-->
                        </ul>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="tab1default">
                           <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading curr-title" role="tab" id="headingOne">
      <h4 class="panel-title curr-title">
        <a style="cursor:default;text-decoration:none;" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOnetwo" aria-expanded="true" aria-controls="collapseOne">
        Enable/Disable SEO
        </a>
      </h4>
    </div>
    
    
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
      <form method="post" action="{$config.url}/admincp/seoenable" data-parsley-validate>
        <table class="table table-responsive">
    <!--<thead>
      <tr>
        <th>Currency</th>
        <th>Rate</th>
        
      </tr>
    </thead>-->

    <tbody>
     
        <tr>
          <td class="col-md-4">
          Enable or Disable SEO
        </td>
          <td class="col-md-3">

            <input class="seo_switch" name="seoswitch" type="radio" value="yes" {if $seo_switch == 'yes'}checked{/if}> Enable
            <span>&nbsp;&nbsp;</span>
            <input class="seo_switch" name="seoswitch" type="radio" value="no" {if $seo_switch == 'no'}checked{/if}> Disable
          </td>
          
          
        </tr>
      
          </tbody>
        </table>
  <div class="col-md-6 padding_200"><br /><br />
      <input type="submit" class="btn btn-success" name="add_group" id="add_group" />
      </form>
      </div>
      </div>
    </div>
  </div>
</div>


                        </div>
                        <div class="tab-pane fade" id="tab2default">

                        <form method="post" {if $seo_details.id}action="{$config.url}/admincp/editpageseo/{$seo_details.id}"{else}action="{$config.url}/admincp/addpageseo"{/if} data-parsley-validate>
                          <div class="col-md-12 padding_200">
                           <label>
                          Page Title : </label><input type="text" class="form-control col-md-4" name="page_name" id="page_name" required value="{$seo_details.title}"/>
                          </div><br /><br />
                          <div class="col-md-6 padding_200">
                          <label>
                          Page URL : </label>
                            <input type="text" class="form-control col-md-4" name="page_url" id="page_url" required value="{$seo_details.url}"/>
                          </div>
                          <div class="col-md-12 padding_200">
                          <label>
                          Meta Title : </label><input type="text" class="form-control col-md-4" name="meta_title" id="meta_title" required value="{$seo_details.meta_title}"/>
                          </div>
                           <div class="col-md-12 padding_200">
                          <label>
                          Meta Description : </label><textarea class="form-control col-md-4" name="meta_desc" id="meta_desc" required>{$seo_details.meta_desc}</textarea>
                          </div>

                          
                          <div class="col-md-6 padding_200"><br /><br />
                          <input type="submit" class="btn btn-success" name="add_group" id="add_group"  required/>
                          </div>

                        </form>
                            
                        </div>
                        <div class="tab-pane fade" id="tab3default">
                        
                          <div class="col-md-12 padding_200">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                       
                                        <th>Page Title</th>
                                        <th>Page URL</th>
                                        <th>Meta keyword</th>
                                        <th>Meta Descritption</th>
                                        <th colspan="2">Action</th>
                                          
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                  {$reviewcount = 0}
                                    {foreach $seo_pages as $key => $val}   
                                  {$reviewcount = 1}
                                    <tr>
                                       
                                        <td>{$val.title}</td>
                                        <td>{$val.url}</td>
                                        <td>{$val.meta_title}</td>
                                        <td>{$val.meta_desc}</td>
                                        <td>
                                          <a href="{$config.url}/admincp/editseo/{$val.id}">Edit </a><span>&nbsp;</span>|<span>&nbsp;</span>
                                          <a href="javascript:void(0);" onclick="PopupBox2('{$config.url}/admincp/deleteseo/{$val.id}');"> Delete</a>
                                        </td>
                                          
                                        
                                    </tr>
                                  {/foreach}  

                                </tbody>
                            </table>

                          </div>
                        


                         </div>



                       

                        </div>
                        <!--<div class="tab-pane fade" id="tab4default">Default 4</div>
                        <div class="tab-pane fade" id="tab5default">Default 5</div>-->
                    </div>
                </div>

            </div>
        </div>

   </div>
{include file="/admincp/footer.tpl" nocache} 
