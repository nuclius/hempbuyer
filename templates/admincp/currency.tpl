{include file="/admincp/header.tpl" nocache} 
<style>
.rate-size{
    width:55%;
}
.sym-left{

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


</style>
<br/><br/>

<div class="">
<h2>{$phrases.currency_management}</h2>

<div class="">
    	
    	<div class="panel with-nav-tabs panel-default">
                <div class="panel-heading">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab1default" data-toggle="tab">{$phrases.default}</a></li>
                            <!-- <li><a href="#tab2default" data-toggle="tab">Custom</a></li>
                            <li><a href="#tab3default" data-toggle="tab">Add New</a></li>
                            <li><a href="#tab4default" data-toggle="tab">Setting</a></li> -->
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
          {$phrases.currencies}
        </a>
      </h4>
    </div>
    <div class="col-md-12 curr-exchange"> {$phrases.default_currency_exchange_rates}</div>
    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
  <table class="table table-responsive">
    <thead>
      <tr>
        <th>{$phrases.currency}</th>
        <th>{$phrases.rate}</th>
        <th>{$phrases.abbreviation}</th>
        <th>{$phrases.symbol_left}</th>
        <!-- <th>Symbol Right</th>
        <th>Decimal Point</th>
        <th>Thousands Point</th> -->
      
        <th>{$phrases.action}</th>
      </tr>
    </thead>
    <tbody>
     
      {foreach $datas as $key => $val}  
        <tr>
           <td class="col-md-3"><input type="text" class="form-control" name="" value="{$val.currency}"></td>
           <td class="col-md-2"><input type="text" class="form-control" name="" value="{$val.rate}"></td>
           <td class="col-md-1"><input type="text" class="form-control" name="" value="{$val.abb}"></td>
           <td class="col-md-1"><input type="text" class="form-control" name="" value="{$val.symbol}"></td>
         <!--   <td class="col-md-1"><input type="text" class="form-control" name="" value="{$val.symbol_right}"></td>
           <td class="col-md-1"><input type="text" class="form-control" name="" value="{$val.decimal}"></td>
           <td class="col-md-1"><input type="text" class="form-control" name="" value="{$val.thousand}"></td> -->
           {if $val.status eq 0}
            <td class="col-md-1 text-center"><a href="{$config.url}/admincp/default_currency/activate/{$val.id}">Activate</a></td>
            {/if}
            {if $val.status == 1}
            <td> Activated</td>
            {/if}


        </tr>
      {/foreach}         
    </tbody>
  </table>
      </div>
    </div>
  </div>
</div>


                        </div>
                        <div class="tab-pane fade" id="tab2default">

                        	default2
                            
                        </div>
                        <div class="tab-pane fade" id="tab3default">Default 3</div>
                        <div class="tab-pane fade" id="tab4default">Default 4</div>
                        <div class="tab-pane fade" id="tab5default">Default 5</div>
                    </div>
                </div>

            </div>
        </div>

   </div>

</div>
{include file="/admincp/footer.tpl" nocache} 