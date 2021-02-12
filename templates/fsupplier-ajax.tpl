 <div class="row stores-row m35" id="feature-supplier">
{$cnt=0}
{foreach $stores as $key => $val}
{$cnt=1}
                <div class="col-md-3 col-sm-6  shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" width="275px" height="183px" src="{$config.url}/uploads/ad_image/{$val.banner}" alt="">
                            <div class="title white green-b  input-radius">
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
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
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
 {if $cnt== 0} <h4 style ="color:red ; margin:20px auto; width :100%; text-align:center;">  Matching data not found !</h4>{/if}

            </div>
              {$pagination_html}