{include file="/admincp/header.tpl" nocache} 
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}select2.css" />
<script src="{$config['externaljs']}select2.js"></script>
<script>
  $(function(){

    $( ".phrase_filters" ).on('change',function() {
      var phraseid =  $('#phrase_list').val();
      var langid =  $('#lang_list').val();
      $('#phrase_value').val('');
        $.ajax({
             type:'POST',
             url:'{$config.url}/admincp/phrase_text',
             data : { phraseid : phraseid,langid : langid },
             success: function (data)
             {
                $('#phrase_value').val(data);

              }

        });


  });


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
        {if $phrases.language_manager == ''} Language Manager {/if}
        {if $phrases.language_manager != ''} {$phrases.language_manager} {/if}
</h2>
<div class="">
    	
    	<div class="panel with-nav-tabs panel-default">
                <div class="panel-heading">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab1default" data-toggle="tab">
                      {if $phrases.language_manager == ''} Phrase {/if}
                      {if $phrases.language_manager != ''} {$phrases.phrase} {/if}
                            </a></li>
                            <li><a href="#tab2default" data-toggle="tab">
                      {if $phrases.language_manager == ''} Language {/if}
                      {if $phrases.language_manager != ''} {$phrases.language} {/if}
                            </a></li>
                            <li><a href="#tab3default" data-toggle="tab">
                      {if $phrases.language_manager == ''} Groups {/if}
                      {if $phrases.language_manager != ''} {$phrases.groups} {/if}        

                            </a></li>
                            <li><a href="#tab4default" data-toggle="tab">
                      {if $phrases.activate_language == ''} Activate Language {/if}
                      {if $phrases.activate_language != ''} {$phrases.activate_language} {/if}        

                            </a></li>
                            <li><a href="#tab5default" data-toggle="tab">
                               CSV Import       

                            </a></li>
                            <li><a href="#tab6default" data-toggle="tab">{$phrases.edit_phrase}</a></li>
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
        {if $phrases.create_new_language_phrase == ''}
           Create a New Language Phrase
        {/if}
        {if $phrases.create_new_language_phrase != ''}
          {$phrases.create_new_language_phrase}
        {/if}
        </a>
      </h4>
    </div>
    <div class="col-md-12 curr-exchange"> 
    {if $phrases.phrase_message == ''}
           You can create new language phrases and call them as (variables) from your html templates below 
        {/if}
        {if $phrases.phrase_message != ''}
          {$phrases.phrase_message}
        {/if}
    </div>
    {if $phrase_exist == 1}
    <div class="alert alert-danger"> <strong>Exist</strong> </div>
    {/if}
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
      <form method="post" action="{$config.url}/admincp/addphrase" data-parsley-validate>
        <table class="table table-responsive">
    <!--<thead>
      <tr>
        <th>Currency</th>
        <th>Rate</th>
        
      </tr>
    </thead>-->

    <tbody>
     
        <tr>
          <td class="col-md-6">1.{if $phrases.create_new_language_phrase == ''}
           Create a New Language Phrase
        {/if}
        {if $phrases.create_new_language_phrase != ''}
          {$phrases.create_new_language_phrase}
        {/if}
        </td>
          <td class="col-md-6">
            <select class="form-control" id="sel-lang" name="sellang" required>
            
              {foreach $languages as $key => $val}
                
                <option value="{$val.values}">{$val.language}</option>
              
              {/foreach}
             </select>
          </td>
          
        </tr>
      <tr>
        <td class="col-md-6">2.{if $phrases.create_new_language_phrase == ''}
           Create a New Language Phrase
        {/if}
        {if $phrases.create_new_language_phrase != ''}
          {$phrases.create_new_language_phrase}
        {/if}
        </td>
        <td class="col-md-6">
          <select class="form-control" id="sel-phrase" name="selgroup" required>
            <!--<option>Please Select</option>-->
            {foreach $groups as $key => $val}
              <option value="{$val.id}">{$val.groupname}</option>
            {/foreach}
          </select>
        </td>
        
      </tr>
      <tr>
        <td class="col-md-6">3.{if $phrases.create_new_phrase == ''}
           Create new phrase
        {/if}
        {if $phrases.create_new_phrase != ''}
          {$phrases.create_new_phrase}
        {/if}</td>
        <td class="col-md-6"><textarea class="form-control" name="phrase" rows="3" id="phrase" placeholder="" required></textarea></td>
        
      </tr>
      <tr>
        <td class="col-md-6">4.{if $phrases.convert_into_template_variable == ''}
           Convert into template variable
        {/if}
        {if $phrases.convert_into_template_variable != ''}
          {$phrases.convert_into_template_variable}
        {/if}</td>
        <td class="col-md-6"><button type="button" id="converter" class="btn btn-warning" name="" required>{if $phrases.convert_into_template_variable == ''}
           Convert into template variable
        {/if}
        {if $phrases.convert_into_template_variable != ''}
          {$phrases.convert_into_template_variable}
        {/if}</button></td>
        
      </tr>
      <tr>
        <td class="col-md-6">5.{if $phrases.template_variable == ''}
           Template variable
        {/if}
        {if $phrases.template_variable != ''}
          {$phrases.template_variable}
        {/if}</td>
        <td class="col-md-6"><input type="text" id="temp_var" class="form-control" name="temp_var" value="" required></td>
        
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

                        <form method="post" action="{$config.url}/admincp/addlanguage" data-parsley-validate>
                          <div class="col-md-12 padding_200">
                           <label>
                           {if $phrases.language_name == ''} Language Name {/if}
                      {if $phrases.language_name != ''} {$phrases.language_name} {/if} : </label><input type="text" class="form-control col-md-4" name="lang_name" id="gname" required/>
                          </div><br /><br />
                          <div class="col-md-6 padding_200">
                          <label>
                          {if $phrases.direction == ''} Direction {/if}
                          {if $phrases.direction != ''} {$phrases.direction} {/if}
                           : </label>
                          <select class="form-control col-md-4" id="direction" name="direction" required>
                            <option value="ltl">Left to Right (Default)</option>
                            <option value="rtl">Right to Left</option>
                          </select>
                          </div>
                          <div class="col-md-12 padding_200">
                          <label>
                          {if $phrases.locale == ''} Locale {/if}
                          {if $phrases.locale != ''} {$phrases.locale} {/if} : </label><input type="text" class="form-control col-md-4" name="locale" id="locale" required/>
                          </div>
                          
                          <div class="col-md-6 padding_200"><br /><br />
                          <input type="submit" class="btn btn-success" name="add_group" id="add_group"  required/>
                          </div>

                        </form>
                            
                        </div>
                        <div class="tab-pane fade" id="tab3default">
                        

                        <form method="post" action="{$config.url}/admincp/addlang_group" data-parsley-validate>
                          <div class="col-md-12 padding_200">
                            <label>{if $phrases.group_name == ''} Group name {/if}
                              {if $phrases.group_name != ''} {$phrases.group_name} {/if}  : </label><input type="text" class="form-control col-md-4" name="group_name" id="gname" required/>
                            </div><br /><br />
                            <div class="col-md-6 padding_200">
                              <label>{if $phrases.description == ''} Description {/if}
                              {if $phrases.description != ''} {$phrases.description} {/if} : </label><textarea name="group_desc" class="form-control col-md-4" id="g_desc" required></textarea>
                              <div class="col-md-6 padding_200"><br /><br />
                                <input type="submit" class="btn btn-success" name="add_group" id="add_group" />
                              </div>
                            </div>
                        </form>


                         </div>



                         <div class="tab-pane fade" id="tab3default">
                        

                        <form method="post" action="{$config.url}/admincp/addlang_group" data-parsley-validate>
                          <div class="col-md-12 padding_200">
                            <label>{if $phrases.group_name == ''} Group name {/if}
                              {if $phrases.group_name != ''} {$phrases.group_name} {/if}  : </label><input type="text" class="form-control col-md-4" name="group_name" id="gname" required/>
                            </div><br /><br />
                            <div class="col-md-6 padding_200">
                              <label>{if $phrases.description == ''} Description {/if}
                              {if $phrases.description != ''} {$phrases.description} {/if} : </label><textarea name="group_desc" class="form-control col-md-4" id="g_desc" required></textarea>
                              <div class="col-md-6 padding_200"><br /><br />
                                <input type="submit" class="btn btn-success" name="add_group" id="add_group" />
                              </div>
                            </div>
                        </form>


                         </div>

                         <div class="tab-pane fade" id="tab4default">
                        

                        <form method="post" action="{$config.url}/admincp/activate_language" data-parsley-validate>
                          <div class="col-md-12 padding_200">
                           <label>{if $phrases.language_name == ''} Language Name {/if}
                      {if $phrases.language_name != ''} {$phrases.language_name} {/if}  : </label>
                          
                            <select id="activate" class="form-control col-md-4" name="active_lang">

                              {foreach $languages as $key => $val}
                                {if $used_language == $val.language_slug}
                                  <option value="{$val.language_slug}" selected>{$val.language}</option>
                                {/if}    

                                {if $used_language != $val.language_slug}
                                <option value="{$val.language_slug}">{$val.language}</option>
                                {/if}
                              {/foreach}
                              
                            </select>
                          </div>
                          <div class="col-md-6 padding_200"><br /><br />
                          <input type="submit" class="btn btn-success" name="add_group" id="add_group" />
                          </div>

                        </form>


                         </div>

                         <div class="tab-pane fade" id="tab5default">
                        

                        <form action="{$config.url}/admincp/languagephrase/import" enctype="multipart/form-data" method="post" id="pay_chk" >
                          <div class="form-group">
                            <label>Select Language to Import</label>
                            <select id="activate" class="form-control col-md-4"  name="active_lang" required>
                              <option  disabled="disabled" hidden selected="selected" value="">Please select a language</option>

                              {foreach $languages as $key => $val}
                                <option value="{$val.language_slug}">{$val.language}</option>
                              {/foreach}
                              
                            </select>
                          </div>

                          <div class="form-group">
                            <label>Upload the CSV File</label>
                            <input name="csvs" data-parsley-group="block1" required id="csvs" accept=".csv" maxlength="99" type="file" class="form-control">
                          </div>
                          <div>&nbsp;</div>


                          
                          <div class="form-group col-sm-1">
                            <input type="submit" class="btn btn-success" value="Save" />
                          </div>
                            <div class="col-sm-1">
                              <a href="{$config.url}/admincp/pharselist" class="btn btn-default" style="background:#fff; border:1px solid #ccc; color:#000;" >Download Phrase List</a>
                            </div>
                        </form>

                        <br />
                        <br />

                        <div class="note" style="float: left">
                        <h4>Instructions</h4>
                          <li>Download the language phrase List.</li>
                          <li>Add a new column for the language phrases you want to add in the format, language name in small letter preceded by `<i>for_</i>`(no inverted commas). <br />For Eg: If you want to add Spanish, add a column named <i>for_spanish</i> in your csv.</li>
                          <li>Add respective language phrase to the phrase words in the left column.</li>
                          <li>Save CSV.</li>
                          <li>Select the language from the list.</li>
                          <li>Upload CSV.</li>
                          <li>Click Save.</li>



                        </div>
                           
                         </div>

                          <div class="tab-pane fade" id="tab6default">
                        

                        <form method="post" action="{$config.url}/admincp/updatephrase" data-parsley-validate>
                          <div class="col-md-12 padding_200">
                            <label>{$phrases.select_a_phrase} :</label>
                            <select id="phrase_list" class="form-control col-md-4 phrase_filters" name="phrase_list" required>
                              {foreach $all_phrases as $key => $val}
                                <option value="{$val.id}">{$val.phrase}  ({$val.groupname})</option>
                              {/foreach}
                            </select>
                            </div><br /><br />
                            <div class="col-md-12 padding_200">
                            <label>{$phrases.language_name} :</label>
                            <select id="lang_list" class="form-control col-md-4 phrase_filters"  name="lang_list" required>
                              
                              {foreach $languages as $key => $val}
                                <option value="{$val.language_slug}">{$val.language}</option>
                              {/foreach}
                              
                            </select>
                            </div><br /><br />

                            <div class="col-md-6 padding_200">
                              <label> {$phrases.current_phrase}: </label><textarea name="phrase_value" class="form-control col-md-4" id="phrase_value" required></textarea>
                              <div class="col-md-6 padding_200"><br /><br />
                                <input type="submit" class="btn btn-success" name="add_group" id="add_group" />
                              </div>
                            </div>
                        </form>


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
