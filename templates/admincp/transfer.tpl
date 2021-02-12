{include file="/admincp/header.tpl" nocache}

<script type="text/javascript">
$(function()
{
                  
    $("#submit_id").click(function(e){
      e.preventDefault();
      var mailid =  $('#transfer_mail').val(); 

                  $.ajax({
                     type:'POST',
                     url:'{$config.url}/dashboard/check_if_exist',
                     data : { bid : mailid },
                     success: function ( response )
                     {

                        if( response == "exist" ){
                          
                          $('#transfer_product').submit();
                        }
                        else{
                          alert("User Email does not exist");
                        }
                     }

                  });
                  
              
                
               //$('#vpcheckout').submit();
            
           
    });

  $( "#transfer_mail" ).keydown(function() {
      var mailid =  $('#transfer_mail').val();
      $('.dropdown').removeClass('open');
       $.ajax({
             type:'POST',
             url:'{$config.url}/dashboard/getmailids',
             data : { bid : mailid },
             success: function (data)
             {

                  $('.dropdown').addClass('open');
                  $('.dropdown-menus').html('');
                  $('.dropdown-menus').html( data );

              }

        });


  });

  $(".dropdown-menus").on('click',"li a",function(e){
      $('#transfer_mail').val( $(this).html() );
      $('.dropdown').removeClass('open');
  });





});
</script>
<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-user"></i> Transfer Ownership  <i class="fa fa-angle-double-right"></i> <i class="fa fa-settings"></i> 
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                <div class="row">
                       <div class="col-lg-12">
                          {if $error == 'saved'}
                                <div class="alert alert-success"> <strong>Saved!</strong> Phrases was successfully changed. </div>
                          {elseif $error != ''}
                          <div class="alert alert-danger"> <strong>{$error}</strong> </div>
                          {/if}
                        </div>
                        <form enctype="multipart/form-data" id="transfer_product" data-parsley-validate method="post"  action="{$config.url}/admincp/transfer_ownership">  
                                 <!--div class="row">
                                 <div class="col-lg-12">
                                  <div class="col-lg-4">Phrases Identifier</div>
                                  <div class="col-lg-4">Phrases Text</div>
                                   
                                 </div>  
                                 </div-->  
                                                       
                               	  
                                                           
                                       <div class="col-lg-12">
                                        <div class="col-lg-4" style="margin-bottom:2%">

                                         <div class="col-lg-12" style="margin-bottom:2%">Email</div>
                                        <div class="col-lg-12">
                                        <div class="dropdown">
                                        <input type="email" class="form-control" name="transfer_mail" id="transfer_mail" placeholder="Email Id" required autocomplete="off">
                                          <ul class="dropdown-menu dropdown-menus col-md-12" role="menu" aria-labelledby="menu1">
        
                                          </ul>
                                          </div>

                                          </div></div>

                                        <div class="col-lg-4" style="margin-bottom:2%">
                                        <!-- <div class="col-lg-12" style="margin-bottom:2%">Phrases Text</div> -->
                                          <div class="col-lg-12"> <input type="hidden" class="form-control" name="product_id" id="product_id" value="{$trans}" required></div>
                                        </div>
                                       </div>
                                     
                                  
                         
                          <div class="col-lg-12" style="margin-bottom:2%">
                          <div class="col-lg-12">
                          <div class="col-lg-12">     
                             <input type="submit" value="Submit" id="submit_id" class="btn-success btn" />
                             </div>
                          </div>    
                           </div>    
                           

                          
                        </form>

                    

                </div>	
                

               
                <!-- /.row -->
</div>


           
{include file="/admincp/footer.tpl" nocache}
