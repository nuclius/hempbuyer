{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active" style=" text-transform: capitalize;">
                                <i class="fa fa-user"></i>{$action} Twilio
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                <div class="btn btn-success" onclick="window.location='{$config.url}/admincp/twilio/new'">New Number</div>
                <form action="{$config.url}/admincp/twilio/post" method="get" id="pay_chk">
    <input type="hidden"  value="{$temp_details.id}" name="id" />
    <div class="form-group">
        <label>New Number</label>
        <input name="phone" data-parsley-group="block1" required id="number" />
    </div>
   


    <div class="form-group">
      <input type="submit" class="btn btn-success" value="Save" />
    </div>
  </form>

               
                <!-- /.row -->
</div>
           
{include file="/admincp/footer.tpl" nocache}
