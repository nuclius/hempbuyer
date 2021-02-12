{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> {$pharse.transactions} <i class="fa fa-hand-o-right"></i> <i class="fa fa-search"></i> {$pharse.search}
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
               

                <div class="row m-top-20">
                   <form enctype="multipart/form-data" class="admin_form" data-parsley-validate method="get" enctype="multipart/form-data" action="{$config.url}/admincp/transaction/list">
                        
                         <div class="col-lg-4"> 

                            <div class="form-group">
                                <label>{$pharse.user_id}</label>
                                <input class="form-control" name="userid" value="{$search.userid}">
                               
                            </div>
                             <div class="form-group">
                                <label>{$pharse.status}</label>
                                <select class="form-control" name="status">
                                    <option value="" {if $search.status == ''} selected {/if}>{$pharse.all}</option>
                                    <option value="bid"  {if $search.status == 'bid'} selected {/if}>{$pharse.bid}</option>
                                    <option value="buynow"  {if $search.status == 'buynow'} selected {/if}>{$pharse.buy_now}</option>
                                    <option value="winner"  {if $search.status == 'winner'} selected {/if}>{$pharse.winner}</option>
                                    <option value="sold"  {if $search.status == 'sold'} selected {/if}>{$pharse.sold}</option>
                                </select>
                            </div>
                         </div>   
                          <div class="col-lg-4">   
                            <div class="form-group">
                                <label>{$pharse.product_id}</label>
                                <input class="form-control"  value="{$search.projectid}" name="projectid">
                            </div>

                         
                          
                           
                            <div class="form-group">
                                <label>{$pharse.transaction_id}</label>
                                <input class="form-control"  value="{$search.transactionid}" name="trans_id">
                            </div>

                           

                          
                          </div>   
                          <div class="col-lg-4">    
                            <div class="form-group">
                                <label>{$pharse.from_date}</label>
                                <input class="form-control"  value="{$search.from_date}" name="from_date" id="from_date" class="date_picker">
                            </div>

                         

                           </div>   
                          <div class="col-lg-4">
                            <div class="form-group">
                                <label>{$pharse.to_date}</label>
                                <input class="form-control"  value="{$search.to_date}" name="to_date" id="to_date" class="date_picker">
                            </div>

                           

                          </div>   
                          <div class="col-lg-4">   
                            <br />
                            <div class="form-group">
                              <button type="submit" class="btn btn-success"> <i class="fa fa-search"></i> {$pharse.search}</button>

                           </div>

                         </div>
                           

                             
                        </form>
                       
                </div>    
                 <div class="row">
                  <div class="col-md-6"><label>{$pharse.net_revenue}</label> : ${$total}</div>
                  <div class="col-md-6" style="margin-bottom:2%; margin-top:2%;"><a href="{$config.url}{$dlink}" class="text-blue">{$pharse.download_report}</a></div>
                 </div>
                {include file="/admincp/transaction-list.tpl" nocache}

                  <a href="/admincp/transaction/download?{$fquery}" class="btn btn-success btn-right" style="margin-bottom:2%;"> {$pharse.download_report} </a>
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
<script language="javascript" type="text/javascript">

$(function()
{
   Date.dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    Date.format = 'mm/dd/yyyy';
    $("#from_date").datePicker({ clickInput: false, 
        createButton: false, 
        showYearNavigation: false, 
        showHeader:2
    }).bind(
        'focus click keydown',
        function()
        {
          $("#from_date").dpRerenderCalendar();
          $("#from_date").dpSetStartDate('01/02/2012');
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