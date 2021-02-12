{include file="/admincp/header.tpl" nocache}
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="{$config['externalcss']}/jquery.datetimepicker.css" />

<script>
$( document ).ready(function(e) {
  $('#reportslist').hide();
  $('#reports').on('change',function(){
    $('.tables').hide();
    var selected = $(':selected', this);
    var group = selected.closest('optgroup').attr('class');
    if(selected.val() == ''){
     
      $('.all_fields').hide();
      $('.defaults').show();
    }
    if(group == 'invoices'){
      $('.defaults').hide();
      $('.all_fields').hide();
      $('.ifields').show();
    }

    if(group == 'sold'){

      $('.defaults').hide();
      $('.all_fields').hide();
      $('.pfields').show();

      if(selected.val() == 'ssold'){
      $('#paid_field').html('<label><input type="checkbox" name="paid_date" id="paid_date" value="1" checked="checked"> Paid Date </label>');

      }
      else{

        $('#paid_field').html('');

      }

    }

    if(group == 'buy'){

      $('.defaults').hide();
      $('.all_fields').hide();
      $('.bfields').show();

    }

    if(group == 'commission'){

       $('.defaults').hide();
      $('.all_fields').hide();
      $('.cfields').show();

    }

   


  });

  $('#print').click(function(){

    $('form').hide();
    $('#reportslist').show();
    window.scrollTo(0, 0);

  });

  $('#within').click(function(){
    if($('#within').is(':checked')){
      $('#from_date').val('');
      $('#to_date').val('');
    }

  });

  $("#reports_form").submit(function(e){
    if($('#range').is(':checked')){ 
      if($('#from_date').val() != '' && $('#to_date').val() != '' ){

      }
      else{
         alert('Please select a Date Range');
         e.preventDefault();
      }

    }

    if($('#reports').val() === ''){
        e.preventDefault();
         alert('Please select a report') ;
    }


  });

 $('#rangepast').change(function(){

    $('#within').prop('checked', true);
    $('#range').prop('checked', false);
    

 });
  $('.days').change(function(){

    $('#range').prop('checked', true);
    $('#within').prop('checked', false);

 });

 
});

</script>

<style>
.all_fields{
  display:none;
}
</style>

<div class="container-fluid"> 
  
  <!-- Page Heading -->
  <div class="row controls">
    <div class="col-lg-12" style="margin-top:2%;">
      <ol class="breadcrumb">
        <li class="active"> <i class="fa fa-sitemap"></i> {$pharse.report_management} </li>
      </ol>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
   <div class="col-lg-12 reports1">  
    
     {$pharse.report_management_gives_you_direct_access_of_accounting_overview_based_on_the_reporting_you_wish_to_formulate}
  
   </div> 
   <form action="{$config.url}/admincp/reports_create" data-parsley-validate method="post" id="reports_form" class="form-horizontal">    
    <div class="col-md-10">
      <input type="hidden" name="id" value="" /> 
      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.action}</label>
        <div class="col-sm-6">
         <select class="form-control" name="type">
         <!--  <option value="list">Show Report Listings in Table Format</option> -->
          <option value="csv">{$pharse.download_report_as_a_csv_file}</option>
          <option value="dsp">{$pharse.display_report}</option>
        </select>  
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.report}</label>
        <div class="col-sm-6">
         <select class="form-control" name="reports" id="reports">
          <option value="">{$pharse.select_report_to_generate:}</option>
						<optgroup label="Sold" class="sold">
                        		
								<option value="sopened">{$pharse.opened_items}</option>
								<option value="sclosed">{$pharse.closed_item}</option>
                <option value="ssold">{$pharse.sold_items}</option>
                <option value="sending">{$pharse.ending_soon_items}</option>
								                                
								
            </optgroup>

            <optgroup label="Buy" class="buy">
                            
                <option value="buyout">{$pharse.products_sold_out_in_buy_now}</option>
                <option value="bidout">{$pharse.products_sold_out_in_bidding}</option>
                
            </optgroup>

            <optgroup label="Commission" class="commission">
               <option value="earned">{$pharse.commission_earned_by_admin}</option>
            </optgroup>

						<optgroup label="Invoices" class="invoices">
                        		
								<option value="ipaid">{$pharse.invoice_paid_status} </option>
								<option value="iunpaid">{$pharse.invoice_unpaid_status} </option>
								
            </optgroup>

										
        </select>  
        </div>
      </div>
      
      
      <div class="col-md-12 reports2">{$pharse.customize_your_report_by_viewing_only_desired_transaction_columns}</div>


  <div class="defaults">{$pharse.please_select_a_report}</div>
 <!---Fields for sellers-->
  <div class="pfields all_fields">
      
    <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.fields}</label>
        <div class="col-sm-8">
      <div class="col-md-4 col-sm-4">
        <div class="checkbox">
          <label>
          <input type="checkbox" name="pid" id="pid" value="1" checked="checked">
          {$pharse.product_id}
          </label>
        </div>
        <div class="checkbox">
          <label>
          <input type="checkbox" name="pname" id="pname" value="1" checked="checked">
          {$pharse.product_name}
          </label>
        </div>
        <div class="checkbox">
          <label>
          <input type="checkbox" name="qty" id="qty" value="1" checked="checked">
          {$pharse.quantity}
          </label>
        </div>
          <div class="checkbox">
        <label>
        <input type="checkbox" name="pdate_added" id="pdate_added" value="1" checked="checked">
        {$pharse.create_date}
        </label>
      </div>
        </div>
           <div class="col-md-4 col-sm-4">
           <div class="checkbox">
        <label>
        <input type="checkbox" name="sid" id="sid" value="1" checked="checked">
        {$pharse.seller_id}
        </label>
      </div>
          <div class="checkbox">
        <label>
        <input type="checkbox"  name="p_amount" id="p_amount" value="1" checked="checked">
        {$pharse.total_amount} 
        </label>
      </div>
          <div class="checkbox">
        <label>
        <input type="checkbox" name="s_amount" id="s_amount" value="1" checked="checked">
        {$pharse.shipping_amount}
        </label>
      </div>
       <div class="checkbox">
        <label>
        <input type="checkbox" name="sold_item" id="sold_item"  value="1" checked="checked">
        Sold
        </label>
      </div>
       </div>
           <div class="col-md-4 col-sm-4">
          
        <div class="checkbox">
        <label>
        <input type="checkbox" name="ptype" id="ptype"  value="1" checked="checked">
       {$pharse.product_type}
        </label>
      </div>
        <div class="checkbox">
        <label>
        <input type="checkbox" name="dclosed" id="dclosed" value="1" checked="checked">
        {$pharse.date_closed}
        </label>
        </div>
        <div id="paid_field" class="checkbox">
        
        </div>
           </div>
          </div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.tools}</label>
        <div class="col-sm-10">
          <div class="checkbox">
            <label>
            <input type="checkbox" name="sell_name" id="sell_name" value="1" >
            {$pharse.if_you_would_like_to_convert_the_seller_id_field_into_the_actual_username_please_tick_this_checkbox}
            </label>
          </div>
        </div>
      </div>
  </div>
   <!---Fields for sellers Ends-->
  <!---Fields for buyers-->
  <div class="bfields all_fields">
      
      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.fields}</label>
        <div class="col-sm-8">
         <div class="col-md-4 col-sm-4">
         <div class="checkbox">
      <label>
      <input type="checkbox" name="p_id" id="p_id" value="1" checked="checked">
      {$pharse.product_id}
      </label>
    </div>
        <div class="checkbox">
      <label>
      <input type="checkbox" name="p_name" id="p_name" value="1" checked="checked">
      {$pharse.product_name}
      </label>
    </div>
        <div class="checkbox">
      <label>
      <input type="checkbox" name="amt" id="amt" value="1" checked="checked">
      {$phare.amount}
      </label>
    </div>
     <div class="checkbox">
        <label>
        <input type="checkbox" name="r_date" id="r_date" value="1" checked="checked">
        {$pharse.release_date}
        </label>
      </div>
       
      </div>
         <div class="col-md-4 col-sm-4">
           
         <div class="checkbox">
      <label>
      <input type="checkbox" name="bid" id="bid" value="1" checked="checked">
      {$pharse.buyer_id}
      </label>
    </div>
        <div class="checkbox">
      <label>
      <input type="checkbox" name="slid" id="slid"  value="1" checked="checked">
      {$pharse.seller_Id}
      </label>
    </div>
      <div class="checkbox">
      <label>
      <input type="checkbox" name="p_type" id="p_type" value="1" checked="checked">
      {$pharse.product_type}
      </label>
      </div>
     </div>
        
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.tools}</label>
        <div class="col-sm-10">
          <div class="checkbox">
            <label>
            <input type="checkbox" name="seller" id="seller" value="1" >
            {$pharse.if_you_would_like_to_add_the_seller_username_field_please_tick_this_checkbox}
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" name="buyer" id="buyer" value="1" >
             {$pharse.if_you_would_like_to_add_the_buyer_username_field_please_tick_this_checkbox}
            </label>
          </div>
        </div>
      </div>

  </div>
  <!---Fields for buyers ends-->
   <!---Fields for commsiion-->
  <div class="cfields all_fields">
      
      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.fields}</label>
        <div class="col-sm-8">
         <div class="col-md-4 col-sm-4">
         <div class="checkbox">
      <label>
      <input type="checkbox" name="pc_id" id="p_id" value="1" checked="checked">
     {$pharse.product_id}
      </label>
    </div>
        <div class="checkbox">
      <label>
      <input type="checkbox" name="pc_name" id="pc_name" value="1" checked="checked">
     {$pharse.product_name}
      </label>
    </div>
        <div class="checkbox">
      <label>
      <input type="checkbox" name="pc_amt" id="pc_amt" value="1" checked="checked">
       {$phare.amount}
      </label>
    </div>
        <div class="checkbox">
      <label>
      <input type="checkbox" name="rc_date" id="rc_date" value="1" checked="checked">
      {$pharse.release_date}
      </label>
    </div>
      </div>
         <div class="col-md-4 col-sm-4">
         <div class="checkbox">
      <label>
      <input type="checkbox" name="secid" id="secid" value="1" checked="checked">
      {$pharse.seller_Id}
      </label>
    </div>
        <div class="checkbox">
      <label>
      <input type="checkbox" name="byid" id="byid"  value="1" checked="checked">
      {$pharse.buyer_id}
      </label>
    </div>
     <div class="checkbox">
      <label>
      <input type="checkbox" name="comm_amt" id="comm_amt" value="1" checked="checked">
        {$pharse.commission}
      </label>
    </div>
     
     </div>
        
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.tools}</label>
        <div class="col-sm-10">
          <div class="checkbox">
            <label>
            <input type="checkbox" name="c_seller" id="c_seller" value="1" >
            {$pharse.if_you_would_like_to_add_the_seller_username_field_please_tick_this_checkbox}
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" name="c_buyer" id="c_buyer" value="1" >
              {$pharse.if_you_would_like_to_add_the_buyer_username_field_please_tick_this_checkbox}
            </label>
          </div>
        </div>
      </div>

  </div>
  <!---Fields for commisiion ends-->

  <!---Fields for invoices ends-->
  <div class="ifields all_fields">
      
      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.fields}</label>
        <div class="col-sm-8">
         <div class="col-md-4 col-sm-4">
         <div class="checkbox">
  		<label>
    	<input type="checkbox" name="invoiceid" id="invoiceid" value="1" checked="checked">
    	{$pharse.invoice_id}
  		</label>
		</div>
        <div class="checkbox">
  		<label>
    	<input type="checkbox" name="invoiceamt" id="invoiceamt" value="1" checked="checked">
    	{$pharse.invoice_amount}
  		</label>
		</div>
        <div class="checkbox">
  		<label>
    	<input type="checkbox" name="proid" id="proid" value="1" checked="checked">
    	{$pharse.product_id}
  		</label>
		</div>
        <div class="checkbox">
  		<label>
    	<input type="checkbox" name="date_added" id="date_added" value="1" checked="checked">
    	{$pharse.create_date}
  		</label>
		</div>
     
         </div>
         <div class="col-md-4 col-sm-4">
         <div class="checkbox">
  		<label>
    	<input type="checkbox" name="uid" id="uid" value="1" checked="checked">
    	{$pharse.user_id}
  		</label>
		</div>
        <div class="checkbox">
  		<label>
    	<input type="checkbox"  name="t_amount" id="t_amount" value="1" checked="checked">
    	{$pharse.total_amount} 
  		</label>
		</div>
        <div class="checkbox">
  		<label>
    	<input type="checkbox" name="istatus" id="istatus" value="1" checked="checked">
    	{$pharse.invoice_status}
  		</label>
		</div>
     
        <div class="checkbox">
  		<label>
    	<input type="checkbox" name="transid" id="transid" value="1">
    	{$pharse.transaction_id}
  		</label>
		</div>
         </div>
         <div class="col-md-4 col-sm-4">
         <div class="checkbox">
  		<label>
    	<input type="checkbox" name="desc" id="desc" value="1" checked="checked">
    	{$pharse.description}
  		</label>
		</div>
     
        <div class="checkbox">
  		<label>
    	<input type="checkbox" name="itype" id="itype"  value="1" checked="checked">
    	{$pharse.invoice_type}
  		</label>
		</div>
   
      <div class="checkbox">
  		<label>
    	<input type="checkbox" name="amtpaid" id="amtpaid" value="1" checked="checked">
    	{$pharse.amount_paid}
  		</label>
		  </div>
         </div>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.tools}</label>
        <div class="col-sm-10">
         <div class="checkbox">
      <label>
      <input type="checkbox" id="username" name="username" value="1" >
      {$pharse.if_you_would_like_to_add_the_user_id_field_into_the_actual_username_please_tick_this_checkbox}
      </label>
    </div>
        <div class="checkbox">
      <label>
      <input type="checkbox" id="productname" name="productname" value="" >
       {$pharse.if_you_would_like_to_add_the_product_id_field_into_the_actual_listing_title_please_tick_this_checkbox}
      </label>
    </div>
        </div>
        </div>

   </div>
      
        
          <div class="col-md-12 reports2">{$pharse.customize_your_report_using_a_wide_variety_of_date_range_options}</div>
          
           <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.within}</label>
        <div class="col-sm-10">
         <div class="radio">
  		<label>
    	<input type="radio" id="within" name="optionsRadios" value="fixed">
    	<select name="rangepast" id="rangepast" class="form-control" style="margin-left:23px;">
        <option value="day">{$pharse.the_past_day}</option>
        <option value="week">{$pharse.the_past_week}</option>
        <option value="month">{$pharse.the_past_month}</option>
        <option value="year">{$pharse.the_past_year}</option>
        </select>
  		</label>
		</div>
        </div>
        </div>
        
        <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.from_range}</label>
        <div class="col-sm-10">
        <div class="col-sm-1 reports4" style="padding-left:0;">
          <input type="radio" id="range" name="optionsRadios" checked>
         </div>
       
         <div class="col-sm-2 reports3">
         <input type="text" id="from_date" name="fromdate" class="form-control days date-picker" placeholder="2015-01-01" style="background-color: #fff !important;" readonly='true'>
         </div>
         
         
         <div class="col-sm-1 reports4">
         <span>To</span>
         </div>
         <div class="col-sm-2 reports3">
         <input type="text" id="to_date" name="todate" class="form-control days date-picker" style="background-color: #fff !important;" placeholder="2015-01-01" readonly='true'>
         </div>
         
        </div>
        </div>
        
        <div class="col-md-12 reports2">{$pharse.order_your_results_based_on_ascending_or_descending_below}</div>
      
      <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.order_results}</label>
        <div class="col-sm-10">
        <label class="radio-inline">
  <input type="radio" name="orderradio" id="inlineRadio1" value="asc" checked="checked"> {$pharse.ascending}
</label>
<label class="radio-inline">
  <input type="radio" name="orderradio" id="inlineRadio2" value="desc"> {$pharse.descending}
</label>
        </div>
        </div>
        
        <div class="form-group">
        <label class="col-sm-2 control-label">{$pharse.limit_results}</label>
        <div class="col-sm-2">
        <input type="text" name="limit_results" id="limit_results" placeholder="100" class="form-control" />
        </div>
        </div>
      
      
      <div class="col-md-12 form-group">
       <button name="submit" class="btn btn-success">{$pharse.create_report}</button>
      
      </div>  
    </div>
   </form>  
  </div> 

   
</div> 


{include file="/admincp/footer.tpl" nocache} 
<script language="javascript" type="text/javascript">

$(function()
{
   Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'yyyy-mm-dd';
    $("#from_date").datePicker({ clickInput: false, 
        createButton: false, 
        showYearNavigation: false, 
        showHeader:2
    }).bind(
        'focus click keydown',
        function()
        {
          $("#from_date").dpRerenderCalendar();
          $("#from_date").dpSetStartDate('2012-02-01');
            //$(obj).dpSetStartDate($("#funddater_"+curid).val());
            $("#from_date").dpDisplay();
      }
   );
   
    $("#to_date").datePicker({ clickInput: false, 
        createButton: false, 
        showYearNavigation: false, 
        showHeader:2
    }).bind(
        'focus click keydown',
        function()
        {
          $("#to_date").dpRerenderCalendar();
          $("#to_date").dpSetStartDate($("#from_date").val());
            //$(obj).dpSetStartDate($("#funddater_"+curid).val());
            $("#to_date").dpDisplay();
      }
   );
   
});

</script>