
{include file="/common/header-1.tpl" nocache}
<style>
  
  .card-body {
    max-height: 620px;
    overflow: auto;
  }
  .card-title {
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
  }
  #clear_test_search {
    position: relative;
    color: #321f11;
  }
  #clear_test_search i {
    position: absolute;
    right: 12px;
    top: -18px;
    padding: 10px;
    border-left: 1px solid #321f1138;
  }
  </style>

<div class="search-container">
    <div class="container">
      <form action="{$config.url}/searchMarket" method="post">
        <div class="search-list-box">
            <label class="sl-lbl">Search List <a class="search-filter"><i class="fa fa-filter"></i> Filter</a></label>
            <input type="text" class="form-control sa-input" placeholder="Search Auction" value="{$keywordSeachHome}" id="keywordSeach" name="keywordSeach" onblur="searchForm()" id="keywordSeach" />
            <a id="clear_test_search" href="javascript:void(0)" style="display: none;">
              <i class="fa fa-times"></i>
            </a>
            <select class="form-control" name="filter_type" id="filter_type" style="width: 25%;">
              <option value="" selected>All</option>
              <option value="auction">Auction Only</option>
              <option value="fixed">Buy Now Only</option>
              <option value="offer">Offer Only</option>
          </select>
            <select class="form-control" name="sort_by" id="sort_by" style="width: 25%;">
              <option value="" selected>Sort By</option>
              <option value="price_asc">Price: Low - High</option>
              <option value="price_desc">Price: High - Low</option>
              <option value="startdate_asc">Start Date: Asc - Desc</option>
              <option value="startdate_desc">Start Date: Desc - Asc</option>
              <option value="enddate_asc">End Date: Asc - Desc</option>
              <option value="enddate_desc">End Date: Desc - Asc</option>
              <option value="id_asc">Oldest</option>
              <option value="id_desc">Newest</option>
          </select>
        </div>
        <div class="search-content-wrap clearfix">
           <div class="sf-menu" id="accordion">
              <h4 class="sf-thead">
                Search Filters 
                <a class="search-fclose"><i class="fa fa-times"></i></a>
              </h4>
              <div class="card">
                <div class="card-header">
                  <a data-toggle="collapse" data-target="#category">Category <i class="fa fa-minus"></i></a>
                </div>
                <div class="card-body collapse show" id="category">
                  <div class="clear_search_div cus-check p-0" style="display: none;">
                      <a href="javascript:void(0)" class="clear_search text-success font-weight-bold float-right">Clear</a>
                  </div>
                  {foreach $categoryList as $key => $val} 
                    <div class="cus-check font-weight-bold" style="padding-right: 0;">
                        <input type="checkbox" data-toggle="collapse" data-target="#cat_{$val.id}"  name="categorySelected" value="{$val.id}" id ="{$val.id}" onclick='mainCategoryChanged("{$val.id}")'/>
                        <span class="checkmark"></span> {$val.name}

                        <div class="collapse show" id="#cat_{$val.id}" style="padding:10px;padding-right: 0;margin-top: 10px;">
                          {foreach $subCategoryList as $key1 => $val1} 
                          {if $val1.parent_id == $val.id && $val1.name != 'All'}
                            <div class="cus-check" style="margin-left:10px;">
                                <input type="checkbox" name="subCategorySelected" value="{$val1.id}" id="{$val1.id}" class="{$val.id}" onclick='subCategoryChanged("{$val.id}", "{$val1.id}")' />
                                <span class="checkmark"></span> {$val1.name}
                            </div> 
                          {/if}
                        {/foreach}
                        </div>
                    </div> 

                    
                  {/foreach}
                </div> 
              </div> 
              {if $loged.userid}
              <div class="card">
                <div class="card-header">
                  <a data-toggle="collapse" data-target="#pricing">Pricing <i class="fa fa-minus"></i></a>
                </div>
                <div class="card-body collapse show" id="pricing">
                     <div class="row">
                       <div class="col-5">
                         <input class="form-control" placeholder="Min" onkeypress='return isNumberKey(event)' id="start_price" name="start_price" maxlength="5">
                       </div>
                       <div class="col-5">
                        <input class="form-control" placeholder="Max" onkeypress='return isNumberKey(event)' id="end_price" name="end_price" maxlength="5">
                       </div>
                       <div class="col-2" id="searchPrice" style="border: 1px solid #dedad9; cursor: pointer;">
                        <i class="fa fa-search" style="padding-top: 13px;"></i>
                       </div>
                     </div> 
                </div>
              </div>
              {/if}
              <div class="card">
                <div class="card-header">
                  <a data-toggle="collapse" data-target="#attributes">Attributes <i class="fa fa-minus"></i></a>
                </div>
                <div class="card-body collapse show" id="attributes">
                  <div class="clear_search_div cus-check p-0" style="display: none;">
                      <a href="javascript:void(0)" class="clear_search text-success font-weight-bold float-right">Clear</a>
                  </div>
                  {foreach $attributes as $key => $val}
                  <div class="cus-check">
                      <input type="checkbox" name="attributeSelected" value="'{$val.value}'" />
                      <span class="checkmark"></span> {$val.text}
                  </div>
                  {/foreach}
                </div>
              </div>
              <div class="card">
                <div class="card-header">
                  <a data-toggle="collapse" data-target="#screening">Certificate of Analysis <i class="fa fa-minus"></i></a>
                </div>
                <div class="card-body collapse show" id="screening">
                  <div class="clear_search_div cus-check p-0" style="display: none;">
                      <a href="javascript:void(0)" class="clear_search text-success font-weight-bold float-right">Clear</a>
                  </div>
                  {foreach $screening as $key => $val}
                  <div class="cus-check">
                      <input type="checkbox" name="screeningSelected" value="'{$val.value}'" />
                      <span class="checkmark"></span> {$val.text}
                  </div>
                  {/foreach}
                </div>
              </div>
              <div class="card">
                <div class="card-header">
                  <a data-toggle="collapse" data-target="#location">Location <i class="fa fa-minus"></i></a>
                </div>
                <div class="card-body collapse show" id="location">
                  <div class="clear_search_div cus-check p-0" style="display: none;">
                      <a href="javascript:void(0)" class="clear_search text-success font-weight-bold float-right">Clear</a>
                  </div>
                  {foreach $stateList as $key => $val}
                  <div class="cus-check">
                      <input type="checkbox" name="stateSelected" value="'{$val.abbrev}'" />
                      <span class="checkmark"></span> {$val.name}
                  </div> 
                  {/foreach}
                    
                 </div> 
                </div> 

              </div>
            

            <div class="spl-wrap" id="productSection">
              
             {include file="hmb_market_product.tpl" nocache}
            </div>
           </div>
          </form>
    </div> 
</div>
<input type="hidden" name="page" value="{$currentPage}" id="page">

{include file="/common/footer-1.tpl" nocache}

{foreach $allProducts as $key => $val}
{include file="time-loader.tpl" nocache}
{/foreach}

<script>

  function subCategoryChanged(cat, subCat){
    if($('#'+subCat).prop("checked") == true){
      ;//$("#"+cat).prop( "checked", true );
    }else{
      $("#"+cat).prop( "checked", false );

      // console.log($('.'+cat).filter(':checked').length)
      // if($('.'+cat).filter(':checked').length <= 0){
      //   $("#"+cat).prop( "checked", false );
      // }
    }

  }
  function mainCategoryChanged(cat){
    if($('#'+cat).prop("checked") == true){
      $("."+cat).prop( "checked", true );
      console.log('checked')
    }else{
      console.log('notchecked')
      $("."+cat).prop( "checked", false );
    }
  }

  $('.search-filter, .search-fclose').click(function(){
      $('body').toggleClass('ss-filter');
  });


  $('.container form input[type="checkbox"]').on('click', function() {
    console.log('type', $(this).attr('name'));
    if($(this).closest('.card-body').find('input[type="checkbox"]:checked').length) {
      $(this).closest('.card-body').find('.clear_search_div').show();
    } else {
      $(this).closest('.card-body').find('.clear_search_div').hide();
    }
    searchForm();
  });

  function searchForm() {
      // $('input[name="categorySelected"]:checked').each(function(){
      // console.log("categorySelected", $(this).val())
      // });
    $.ajax({
      type : 'POST',
      url  : '/searchMarket',
      data :  $('.container form').serialize()+'&page='+$('#page').val(),
      dataType : 'json',
      success  : function(data)
      {
        $('#sort_by').val($('#sort_by').val());
        $('input[name="page"]').val(1);
        $('#productSection').html(data.html);
      }
    });
  }

  function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
      return false;
    return true;
  }

  $('body').on('change', '#sort_by', function() {
    searchForm();
  });
  $('body').on('change', '#filter_type', function() {
    searchForm();
  });
  $('body').on('keyup', '#keywordSeach', function(event) {
    if($(this).val().trim() == '') {
      $("#clear_test_search").hide();
    } else {
      $("#clear_test_search").show();
    }
    var keycode = (event.keyCode ? event.keyCode : event.which);
    if(keycode == '13'){
      event.preventDefault();
      searchForm();
    }
  });
  $(document).on("click", "#clear_test_search", function() {
    $("#keywordSeach").val("");
    $("#clear_test_search").hide();
    searchForm();
  });

  $('body').on('click', '#searchPrice', function() {
    searchForm();
    /*var start_price = $('#start_price').val();
    var end_price = $('#end_price').val();
    if((start_price && start_price != '0') || (end_price && end_price != '0'))
      searchForm();*/
  });

  searchForm();

  $(document).on("click", ".clear_search", function() {
    // $("#clear_category_div").hide();
    // $("input[name='categorySelected']").prop('checked', false);
    $(this).closest('.card-body').find('.clear_search_div').hide();
    $(this).closest('.card-body').find('input[type="checkbox"]').prop('checked', false);
    searchForm();
  });
</script>