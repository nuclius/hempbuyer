

{include file="common/header-1.tpl" nocache}
<script src="{$config.url}/js/countdown.js"></script>


<script type="text/javascript">
    var clock = [];
    var targetDate = [];
    var clearvar = [];
    var timeProject = [];
    var clocks = [];
    var targetDates = [];
    var clearvars = [];
    var timeProjects = []; 
</script>


<style>
    .not_found{
        margin-top: 10%;
        height:1024px;
        font-weight: 600;
        font-size: 20px;
    }
	.maro1{
		    height: 17px !important;
    top: 7px !important;
    width: 20px;
	}

</style>
<div class="row">
 <button type="button" class="sflter navbar-toggle" data-toggle="collapse" data-target="#search_fltr">
			Search Filters <span class="pull-right"><i class="fa fa-chevron-down"></i></span>
</button>
	<div id="search_fltr" class="ds search_left col-md-3 navbar-collapse collapse">
   <form action="{$config.url}/search" method="post" >
    <input type="hidden" name="ajax" value="1">
    <div class="search_category">

     <h3>Auction </h3>
       <ul>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" name="type[]" value="4" {$isvideosearch}>
          <span class="checkbox"></span>Video
          </label>
         </li>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" name="type[]" value="1" {$isauctionsearch}>
          <span class="checkbox"></span>Bid Now
          </label>
         </li>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" name="type[]" value="2" {$isbuynowsearch}>
          <span class="checkbox"></span>
          Buy Now
          </label>
         </li>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" name="type[]" value="3" {$isfeaturedsearch}>
          <span class="checkbox"></span>
          Featured Items
          </label>
         </li>
      </ul>
    </div>
    <div class="search_category">
    <h3>{$phrase.categories}</h3>

     <input type="hidden" name="page" value="1">

     <input type="hidden" name="uid" value="{$uid}">
         <ul>
          {foreach $maincategory as $key => $val}
            

             <li>
              <label class="option srch_olbl"> 
               
              <input class="forward_v2" type="checkbox" name="cid[]" pid="{$val.parent_id}"  value="{$val.id}"  >
              <span class="checkbox"></span>{$val.name}           
              
              </label>
             </li>

             {foreach $subcategory as $key_sub => $val_sub}
              
              {if $val.id == $val_sub.parent_id}

            <li style="margin-left: 30px;">
              <label class="option srch_olbl"> 
               
              {for $foo=1 to {$val_sub.depth}} -- {/for} <input class="forward_v2" type="checkbox" name="cid[]" pid="{$val_sub.parent_id}"  value="{$val_sub.id}"  >
              <span class="checkbox maro1" ></span>{$val_sub.name}           
              
              </label>
             </li>
              {foreach $subcategory as $key_subw => $val_subw}
              
              {if $val_sub.id == $val_subw.parent_id}
                <li style="margin-left: 60px;">
              <label class="option srch_olbl"> 
               
              {for $foo=1 to {$val_subw.depth}} -- {/for} <input class="forward_v3" type="checkbox" name="cid[]" pid="{$val_subw.parent_id}"  value="{$val_subw.id}"  >
              <span class="checkbox maro1" ></span>{$val_subw.name}           
              
              </label>
             </li>
             {/if}
             {/foreach} 
              {/if}

              {/foreach} 

            
          {/foreach} 
         </ul>    
    </div>
                                                                                                                                                              
    <div class="search_category">
     <h3>{$phrase.auction} </h3>
       <ul>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" name="type[]" value="1" {$isauctionsearch}>
          <span class="checkbox"></span> {$phrase.bid_now}
          </label>
         </li>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" name="type[]" value="2" {$isbuynowsearch}>
          <span class="checkbox"></span>
          {$phrase.buy_now}
          </label>
         </li>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" name="type[]" value="3" {$isfeaturedsearch}>
          <span class="checkbox"></span>
           {$phrase.featured_items}
          </label>
         </li>
      </ul>
    </div>

    
    
    <div class="search_category">
     <h3> {$phrase.price_range} </h3>
     <div class="row">
      <div class="col-md-2">$</div>
      <div class="col-md-4"><input class="form-control floatpoint" name="toprice" type="text"></div>
      <div class="col-md-2">to</div>
      <div class="col-md-4"><input class="form-control floatpoint" name="fromprice" type="text"></div>
     </div>
    </div>
    <!--<div class="search_category">
     <h3>User Rating </h3>
     <div class="row user_rating">
      <div class="col-md-6 search_ratings"><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i></div>
      <div class="col-md-6"><input class="form-control"></div>
     </div>
    </div>-->
    <div class="search_category">
     <h3> {$phrase.options} </h3>
       <ul>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" class="image_search" name="pic_type[]" value="1">
          <span class="checkbox"></span> {$phrase.show_all}
          </label>
         </li>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" class="image_search" name="pic_type[]" value="2">
          <span class="checkbox"></span>
          {$phrase.show_only_with_pictures}
          </label>
         </li>
         <li>
          <label class="option srch_olbl"> 
          <input type="checkbox" class="image_search" name="pic_type[]" value="3">
          <span class="checkbox"></span>
          
          {$phrase.show_only_with_absence_of_pictures}
          </label>
         </li>
           <li>
               <label class="option srch_olbl">
                   <input type="checkbox" class="" name="local_pickup" value="Local pick up only">
                   <span class="checkbox"></span>
                   {$phrase.local_pickup}
               </label>
           </li>
      </ul>
    </div>

  </form>
  </div>
  <div class="col-md-9  search_pro">
  <div class="pull-right">
    <a href="javascript:void(0);" onclick="change_display('grid');" class="btn grid-view-btn">
          <span class="glyphicon glyphicon-th"></span>
    </a>
    <a href="javascript:void(0);" onclick="change_display('list');" class="btn list-view-btn">
          <span class="glyphicon glyphicon-th-list"></span>
    </a>
    <span data-item="grid" class="disp"></span>
  </div>

      <div class="clearfix"></div>
  <div class="row search_tbar">
  <div class="col-md-6 sbar_lbl">
    Search (<span class="numb"></span> Products)
    {if $uid > 0}  <span style="text-transform:capitalize;">{$projects.project[0]['uname']}</span> seller projects {/if}
  </div>
  <div class="col-md-2 sbar_lbl">
  Auction Status
  </div>
  <div class="col-md-4">
    <select class="form-control" id="orderby">
      <option value="1">Time Ending Soon</option>
      <option value="2">Recent Products</option>
      <option value="3">Price Low - High</option>
      <option value="4">Price High - Low</option>
    </select>
  </div>
  </div>
  <div class="col-md-12 svsh"><a href="#" data-toggle="modal" data-target="#myModal">Save this Search</a></div>
      <div class="text-center not_found" style="display:none;">No products found</div>
  
  <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title scon3" id="myModalLabel">Save Search</h4>
      </div>
      <div class="modal-body">
       <div class="col-md-12 scon1">You can now save this search into an organized folder letting you manage your results more easily.  Additionally, you can subscribe via email to receive daily email notifications when new listings meet your specific criteria.</div>
     
     <div class="col-md-12 scon2"><strong>Title of this saved search</strong></div>
     <div class="col-md-6"><input type="text" id="searchtitle" name="title" value="" class="form-control"></div><div class="col-md-6">&nbsp; <br /> &nbsp;</div>
     <div class="col-md-3 col-sm-3  text-left" style="padding-left:0; font-size:14px;"><button onclick="savesearch();"class="btn btn-black">Save</button></div><div class="col-md-9 col-sm-9"></div>
      </div>
    </div>
  </div>
</div>



  <div class="row products_row">
    
   {include file="search-ajax.tpl" nocache}
  </div>
</div>

</div>
</div>

<script type="text/javascript">
    function savesearch()
    {
        search_title = $("#searchtitle").val();
        if(search_title=='')
        {
            alert("Please Enter The Search Title");
        }
        else
        {
            request={
                encrypt:$('.search_left form').serialize()+'&ajax=1&orderby='+$('#orderby').val(),
                title:$('#searchtitle').val(),
                searchtext:$('#search').val()


            }
            $.ajax({
                type : 'POST',
                url  : '/savesearch',
                data : request,
                dataType : 'json',
                success  : function(data)
                {
                    if(data==0)
                    {
                        window.location.href='/login';
                    }
                    else
                    {
                        window.location.href='/dashboard/searchitems';

                    }


                }
            });

        }

    }
    /*  function setIntreval(id,market_status)
     {
     //console.log(timeProject[id]);
     clearvar[id] =  setInterval(function(){


     timeProject[id] = new Date(timeProject[id].getTime() + 1000*1);

     if(targetDate[id] >= timeProject[id])
     {
     clock[id].innerHTML = countdown(targetDate[id]).toString();
     }
     else
     {

     clock[id].innerHTML = 'Closed';
     }

     }, 1000);
     }*/
</script>
{include file="common/footer-1.tpl" nocache}

<script type="text/javascript"> 


function meee2(id,dateee,price)
  {  
 // id = '126';
  
    clearInterval(clearvar[id]);
    clock[id] = document.getElementById('mys'+id)
    , targetDate[id] = new Date(dateee); // Jan 1, 2050;
 
    /*clock[id].innerHTML = countdown(targetDate[id]).toString();
     setIntreval(id);*/
    
  }

function meee(id,dateee,price)
  {  
 // id = '126';
  
    clearInterval(clearvar[id]);
    clock[id] = document.getElementById('my'+id)
    , targetDate[id] = new Date(dateee); // Jan 1, 2050;
 
    clock[id].innerHTML = countdown(targetDate[id]).toString();
     setIntreval(id);
    
  }
  
  function timermee(id,dateee)
  {  

   clearInterval(clearvar[id]);
    clock[id] = document.getElementById('my'+id)
    , targetDate[id] = new Date(dateee); // Jan 1, 2050;
 
  clock[id].innerHTML = countdown(targetDate[id],'hours').toString();
  clearvar[id] =  setInterval(function(){
  
  if(targetDate[id]>new Date())
    clock[id].innerHTML = countdown(targetDate[id],'hours').toString();
  else
  clock[id].innerHTML = 'Closed';  
    }, 1000);
    
  }
  function timermee2(id,dateee)
  {  

   clearInterval(clearvar[id]);
    clock[id] = document.getElementById('mys'+id)
    , targetDate[id] = new Date(dateee); // Jan 1, 2050;
 
  clock[id].innerHTML = countdown(targetDate[id],'hours').toString();
  clearvar[id] =  setInterval(function(){
  
  if(targetDate[id]>new Date())
    clock[id].innerHTML = countdown(targetDate[id],'hours').toString();
  else
  clock[id].innerHTML = 'Closed';  
    }, 1000);
    
  }
     
     socket.on('bidAddtime', function(msg){   
     meee(msg.id,msg.date,msg.price);

     });
$(function()
{
  
  $('input[name="cid[]"]').each(function(){
    $(this).on('change',function(){
       var pid = $(this).attr('pid');
       var vid = $(this).attr('value');
       if(pid > 0)
       {
          if(!$(this).is(':checked'))
          {
            $('input[name="cid[]"][value="'+pid+'"]').attr('checked',false);
          }
      
       }
       else
       {
        if($(this).is(':checked'))
         {
          $('input[name="cid[]"][pid="'+vid+'"]').each(function()
          {
             $(this).attr('checked',false);
             $(this).click();
          });
            

         }
         else
         {
           $('input[name="cid[]"][pid="'+vid+'"]').each(function()
          {
            
             $(this).attr('checked',false);
           });
         } 
       } 
    });
  });
  $('.numb').html($('.pagination').attr('total'));
    $('.search_left form input[type="checkbox"]').on('click',function()
    {
      $('input[name="page"]').val(1);
        $('input.image_search').not(this).prop('checked', false);
        searchForm();
       
    });
    $('.search_left form input[type="text"]').on('blur',function()
    {
      $('input[name="page"]').val(1);
      searchForm();
       
    });
    $('.search_left form select').on('change',function()
    {
      $('input[name="page"]').val(1);
      searchForm();
       
    });
    $('#orderby').on('change',function()
    {
      $('input[name="page"]').val(1);
      searchForm();
       
    });

  
 $('input.image_search').on('change', function() {
    $('input.image_search').not(this).prop('checked', false);  
});
    $('input[name="cid[]"][value="{$cid_search}"]').prop("checked", true);

});
function searchForm()
{      //  alert($('.search_left form').serialize()+'&ajax=1&orderby='+$('#orderby').val());
          var ht = '';
          $.ajax({
            type : 'POST',
            url  : '/search',
            data : $('.search_left form').serialize()+'&ajax=1&orderby='+$('#orderby').val(),
            dataType : 'json',
            success  : function(data)
            {
                   $('input[name="page"]').val(1);
                    ht = data.html;
                   if( $('.grid').hasClass('hide') ){ 
                      
                        ht = ht.replace('grid', 'grid hide');
                        ht = ht.replace('div class="list hide"', 'div class="list"');
                        $('.products_row').html(ht);

                        $('input.pages_titletimer').each(function() { timermee2($(this).val(),$("#tim"+$(this).val()).val());
                           window.scrollTo(0,0);
                        });
                   }
                   else{
                    $('.products_row').html(data.html);

                    $('input.pages_titletimer').each(function() { timermee($(this).val(),$("#tim"+$(this).val()).val());
                       window.scrollTo(0,0);
                    });

                   }
                   
                   
                   $('.numb').html($('.pagination').attr('total'));

                   
			numberformat();
                search_status();

           
            }
          });
}

    // If search return 0 then show message
    function search_status(){
        var total = ($('.pagination').attr('total'));
        if(parseInt(total) == 0){
            $('.not_found').show();
        } else{
            $('.not_found').hide();
        }
    }

    function change_display(type){
        if(type == 'grid'){
            $('.grid').removeClass('hide');
            $('.list').addClass('hide');
           
            $('input.pages_titletimer').each(function() { timermee($(this).val(),$("#tim"+$(this).val()).val());
                       window.scrollTo(0,0);
            });

        }
        else{
          $('.list').removeClass('hide');
            $('.grid').addClass('hide');
            $('span.disp').data( "item", 'list' );
            
            $('input.pages_titletimer').each(function() { timermee2($(this).val(),$("#tim"+$(this).val()).val());
                       window.scrollTo(0,0);
            });

        }
    }

</script> 
<script> 
$( document ).ready(function() {
   $.urlParam = function(name){
   qs = window.location.href;
   var params = [];
   var tokens;
   var re = /[?&]?([^=]+)=([^&]*)/g;
   while (tokens = re.exec(qs))
   { 
       if ((tokens[1]) == name)
       params.push((tokens[2]));
   }
   return params;    
}
  if($.urlParam('tt')==1)
  {
    frompriceurl = $.urlParam('fromprice');
topriceurl = $.urlParam('toprice');
ordebyurl = $.urlParam('orderby');
cidarray =$.urlParam('cid%5B%5D');
typearray =$.urlParam('type%5B%5D');
searchtext =$.urlParam('search');

$.each(cidarray, function(i, val){

   $("input[value='" + val + "'][name='cid[]']").prop('checked', true);

});
$.each(typearray, function(i, val){

   $("input[value='" + val + "'][name='type[]']").prop('checked', true);

});

$('#orderby option[value="' + ordebyurl + '"]').attr('selected','selected');
$('input[name="toprice"]').val(topriceurl);
$('input[name="fromprice"]').val(frompriceurl);
$('#search').val(searchtext);


if(cidarray!=''||frompriceurl!=''||topriceurl!=''||typearray!='')
{

  searchForm();

}
}
    search_status();
          
});





</script>

