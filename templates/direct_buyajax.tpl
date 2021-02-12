<div class="row stores-row" id="feature-store">
    <h2 class="m30"><a href="{$config.url}/directbuy/virtualmall">Go to Virtual Mall of Stores</a></h2>
    <!-- {foreach $virtual_mall as $key => $val}
        <div class="col-md-3  col-sm-6 shadow">

            <div class="row">
                <div class="col-md-12 thumb p0">
                    <div class="image-setup">
                        <img class="" src="{$config.url}/uploads/store/{$val.logo}" alt="" class="img responsive">
                    </div>
                    <div class="title white green-b input-radius">
                        <h3>
                                <span class="flaticon-shopping-cart"></span> <b>{$val.name}</b>
                            </h3>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <p class="description m30">
                        {$val.description}
                    </p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="rating text-center">
                        
                            <div class="rating text-center green-text">
                                Seller Rating: <span class="stars" align="left">{$val.store_rating}</span>
                            </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <button onclick="window.location.href='{$config.url}/stores/view/{$val.id}'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                </div>
            </div>
        </div>
    {/foreach} -->
</div>

<div class="row stores-row" id="feature-store">
                <h2 class="m30"><a href="{$config.url}/featuredStores">Featured Stores</a></h2>
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
                            <div class="rating">
                                <!-- <a href="#"> -->
                                  Seller Rating:
                                    <span class="stars" align="left">{$val.store_rating}</span>
                                    <!-- <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span> -->
                                <!-- </a> -->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button  onclick="goto_ads({$val.id})" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                {/foreach}


            </div>


            <div class="container-fluid feature-brandsFluid">
                <div class="storesCon m50 m-b-0" id="feature-brand">
                    <div class="row stores-row">
                <h2 class="m30 m-t-0"><a href="{$config.url}/featuredBrands">Featured Cannabis Brands</a></h2>
                        <!-- <p>Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus elit.</p> -->
                    <div class="col-md-12">


                        <div id="feature-brands" class="owl-carousel owl-theme">
                            {foreach $brand as $key => $val}

                              <div class="border1 feature-item">

                                  <div class="row">
                                      <div class="col-md-12 test  ">
                                          <div class=" ">
                                      <div class="col-md-12 padlr">
                                          <div class="product-thumb alter-200">
                                            <a href="{$config.url}/product/view/{$val.product_id}">
                        <img class="" src="{$config.url}/uploads/ad_image/{$val.banner}" alt=""></a>
                                          </div>
                                      </div>
                                      <div class="col-md-12 text-panel">
                                          <div class="row flex">
                                              <div class="col-md-8">
                                                  <a href="{$config.url}/product/view/{$val.product_id}"><b class="green-text">{$val.brand_name}</b> </a><br>
                                                  <span>${$val.price}</span>
                                              </div>
                                              <div class="col-md-4 margin-auto">
                                                  <h4 class="fancy-title green-text">Featured </h4>
                                              </div>
                                          </div>

                                          <div class="row">
                                           <div class="col-md-12">
                                            <button onclick="goto_ads({$val.id})" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                                           </div>
                                          </div>

                                      </div>
                                  </div>
                                      </div>
                                  </div>

                              </div>
                              {/foreach}

                        </div>
                    </div>
                </div>
                </div>
            </div>

            <!-- <div class="row stores-row m50 m-b-0" id="feature-suppliers">
                <h2 class="m30 m-t-0"><a href="{$config.url}/featuredsuppliers">Featured Suppliers</a></h2>
                 {foreach $featured_suppliers as $key => $val}
                <div class="col-md-3  col-sm-6 shadow"> 

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <div class="image-setup">
                             {if $val.existing_img != ''}
                              <img class="" src="{$config.url}/uploads/store/{$val.existing_img}" alt="">
                              {/if}
                              {if $val.banner != ''}
                              <img class="" src="{$config.url}/uploads/ad_image/{$val.banner}" alt="">
                              {/if}
                            </div>
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
                            <div class="rating">
                                Store's Ratings
                                <span class="stars" align="center">{$val.store_rating}</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button  onclick="goto_ads({$val.id})"  class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                 {/foreach}
            </div> -->

            <div class="container-fluid feature-brandsFluid">
                <div class="storesCon m50 m-b-0" id="feature-brands">
                    <div class="row stores-row">
                <h2 class="m30 m-t-0"><a href="{$config.url}/featuredaccessories">Featured Products & Accessories</a></h2>
                        <!-- <p>Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus elit.</p> -->
                    <div class="col-md-12 ">
                        <div id="feature-accessories" class="owl-carousel owl-theme">
                              {foreach $featured_accessories as $key => $val}
                              <div class="border1 feature-item">

                                  <div class="row">
                                      <div class="col-md-12 test  ">
                                          <div class=" ">
                                      <div class="col-md-12 padlr">
                                          <div class="product-thumb alter-200">
          <img class="" src="{$config.url}/uploads/ad_image/{$val.banner}" alt="{$val.ad_title}">
                                          </div>
                                      </div>
                                      <div class="col-md-12 text-panel">
                                          <div class="row flex">
                                              <div class="col-md-8 txt-lmt">
                                                  <b class="green-text">{$val.ad_title}</b> <br>
                                                  <span>${$val.price}</span>
                                              </div>
                                              <div class="col-md-4 margin-auto">
                                                  <h4 class="fancy-title green-text">Featured</h4>
                                              </div>
                                          </div>

                                          <div class="row">
                                           <div class="col-md-12">
                                            <button  onclick="goto_ads({$val.id})" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                                           </div>
                                          </div>

                                      </div>
                                  </div>
                                      </div>
                                  </div>

                              </div>
                             {/foreach}

                        </div>
                    </div>
                </div>
                </div>
            </div>
            