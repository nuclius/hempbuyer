 <div class="storesCon m50 m-b-0" id="feature-brand">
                <div class="row stores-row">
            <h2 class="m30 m-t-0"><a>Featured Cannabis Brands</a></h2>
                    <!-- <p>Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus elit.</p> -->
                <div class="col-md-12 ">
                {$cnt=0}
                {foreach $stores as $key => $val}
                {$cnt=1}
                {if $key%4 == 0}
                    <div id="feature-brands" class="owl-carousel owl-theme feature-brands">
                      {/if}
                          <div class="border1 feature-item">

                              <div class="row">
                                  <div class="col-md-12 test">
                                      <div class="row">
                                  <div class="col-md-12">
                                      <div class="product-thumb alter-200">
                                          <img class="img-responsive w100" src="{$config.url}/uploads/ad_image/{$val.banner}" alt="">
                                      </div>
                                  </div>
                                  <div class="col-md-12 text-panel">
                                      <div class="row flex">
                                          <div class="col-md-8">
                                              <b class="green-text">{$val.brand_name}</b> <br>
                                              <span>${$val.price}</span>
                                          </div>
                                          <div class="col-md-4 margin-auto">
                                              <h4 class="fancy-title green-text">Featured</h4>
                                          </div>
                                      </div>

                                      <div class="row">
                                       <div class="col-md-12">
                                        <button class="btn btn-default btn-d black-b" type="button" name="button"  onclick="window.location.href='{$config.url}/stores/view/{$val.store_id}'">VIEW STORE</button>
                                       </div>
                                      </div>

                                  </div>
                              </div>
                                  </div>
                              </div>

                          </div>


                    {if $key%4 == 3}</div>{/if}
                     {/foreach}
                     {if $key%4 < 3}</div>{/if}
                     {if $cnt== 0} <h4 style ="color:red ; margin:20px auto; width :100%; text-align:center;">  Matching data not found !</h4>{/if}

                </div>
                 {$pagination_html}
            </div>
