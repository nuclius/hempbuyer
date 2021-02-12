
{include file="common/header-1.tpl" nocache}
{include file="store/css-store.tpl" nocache}

<!-- Page content -->
{include file="common/dashboard-navigation.tpl" nocache}

    <div class="container storesCon m50 m-b-0">

      <ol class="breadcrumb">
      <li><a class="grey-text" href="{$config.url}/directbuy">Direct Buy Market</a></li>
      <li><a >Featured Stores</a></li>
    </ol>

      <!-- Search field -->
      <div class="row flex">
          <div class="col-md-3 margin-auto">
              <input class="w80 p5-15 border1 input-radius search-input" placeholder="Search" id="title"  type="text" name="" value="">
              <button type="button" name="button" class="input-radius green-b b search-btn" onclick="$('#page').val(1);searchForm()">
                  <i class="fa fa-search white" aria-hidden="true"></i>
              </button>
          </div>
      </div><!-- Search field -->

        <!-- Stores -->
     <div  id="feature-store1">
            <div class="row stores-row m35" id="feature-store">

                <!-- <p>Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus elit.</p> -->
                {foreach $featured_store as $key => $val}
                <div class="col-md-3  col-sm-6 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                          <div class="image-setup">
                             {if $val.existing_img != ''}
                              <img class="" src="{$config.url}/uploads/store/{$val.existing_img}" alt="" class="img responsive">
                              {/if}
                              {if $val.banner != ''}
                              <img class="" src="{$config.url}/uploads/ad_image/{$val.banner}" alt="" class="img responsive">
                              {/if}
                            </div>
                           <!--  <img class="img-responsive w100" src="{$config.url}/uploads/ad_image/{$val.banner}" alt=""> -->
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>{$val.ad_title}</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                               {$val.ad_content}
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <div class="rating text-center">
                                <!-- <a href="#"> -->
                                  Seller Rating
                                    <span class="stars" align="left">{$val.store_rating}</span>
                                    <!-- <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span> -->
                                <!-- </a> -->
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='{$config.url}/stores/view/{$val.store_id}'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>

                {/foreach}
                

            </div>
               {$pagination_html}
</div>

    </div>
<input name="page" type ="hidden"value ="1" id="page">

<!--/ Page content -->

{include file="common/footer-1.tpl" nocache}
{include file="store/store-js.tpl" nocache}

<script type="text/javascript"> 

    function  searchForm(p)
    {
       
            request={
                 
               page:$('#page').val(),
               title:$('#title').val()
                 


            }
            $.ajax({
                type : 'POST',
                url  : '/featuredStoresajax',
                data : request,
                dataType : 'json',
                success  : function(data)
                {
                    
                $('#feature-store1').html(data.html);

                }
            });

        

    }
    
</script>





