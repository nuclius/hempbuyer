{include file="/admincp/header.tpl" nocache} 
<style>
.inbox-full-width{
margin-left: 0;
 padding: 5px;
height:auto;
background-color:#000;
border-radius:0px;
border:2px solid #000;
width: 100%;
}

.guest-page-inbox-bg{
    margin-left: 0;
 padding: 5px;
height:auto;
color:#09c !important;
background-color:#f5f5f5;
border-radius:0px;
border:2px solid #EFEFEF;
width: 100%;
}

.msg-page-inbox-bg{
color:#09c;
}
.msg-page-heading{
color: #FFF;
text-align:center;
}
.tbody-background{

background-color:#EFEFEF;
}
</style>

<div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12" style="margin-top:2%;">
                        
                        <ol class="breadcrumb">
                            <li class="active" style=" text-transform: capitalize;">
                                <i class="fa fa-user"></i> {$phrases.connection_marketplace_activity}
                            </li>
                        </ol>
                    </div>
                </div>
              <div class="col-md-12">

 {$phrases.an_overview_of_a_web_visitors_and_guests}

              </div>

<div style="clear:both;"></div>
<div style="clear:both;"><br/></div>



<div class="row inbox-full-width">
        
         <div class="col-md-12 msg-page-inbox-bg">
        {$phrases.logged_users}
    </div>
                               
        </div>

        
         <div class="table-responsive">          
  <table class="table table-condensed" style="border:2px solid #ddd;">
    <thead class="thead-background">
        <tr style="background-color:#ddd;height:30px;">
         <td></td>
         <td></td>
         <td></td>
         <td></td>
         <td></td>
         <td></td>
         <td></td>
         <td></td>
         <td></td>
      </tr>

      <tr class="">
        
        <th class="">{$phrases.ip_address}</th>
        <th class="">{$phrases.exact_location}</th>
        <th class="">{$phrases.name}</th>
        <th class="">{$phrases.browser}</th>
        <th class="">{$phrases.os}</th>
        <th class="">{$phrases.last_click}</th>
        <th class="">{$phrases.duration}</th>
        
        
      </tr>
    </thead>

    <tbody>
      {$reviewcount = 0}
          {foreach $users as $key => $val}   
      {$reviewcount = 1}     
        <tr>
          <td>{$val.ip_address}</td>
          <td>{$val.location}</td>    
          <td>{$val.first_name} {$val.last_name}</td>        
          <td>{$val.browser}</td>
          <td>{$val.os}</td>
          <td>{$val.date_visited}</td>
          <td>{$val.difference}</td>
          
        <!--   <td> <input type="checkbox" value=""></td> -->
        </tr>
      {/foreach}
      {if $reviewcount ==0}
          
           <tr>
               <td colspan="7">
                 {$phrases.no_users_are_added}
               </td>
           </tr>
      {/if}
    </tbody>

    </table>
    </div>
            



                <!-- /.row -->
                
                

               
                <!-- /.row -->
</div>

{include file="/admincp/footer.tpl" nocache} 