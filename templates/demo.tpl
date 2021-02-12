
                        <div class="row open-bid-row border1">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                            <form id="submit_form{$val.id}" data-parsley-validate method="post" action="">
                                                <div class="row flex" style="padding: 4px 0px">
                                                  <span class="orange-available"> <b>Available Now</b></span>
                                                    <div class="col-md-2 margin-auto res-mtb">
                                                        <div class="orange w100 text-center"><b class="buy-text">BUY</b></div>
                                                        <div class="thumb">
                                                            <div class="hover-div orange-bg hidden-xs">
                                                                <div class="row flex">
                                                                    <div class="col-md-4 margin-auto">
                                                                        <img src="{$config.url}/uploads/product/{$val.avatar}" class="img-responsive margin-auto" alt="">
                                                                    </div>
                                                                    <div class="col-md-8 content margin-auto">
                                                                        <div class="row">
                                                                            <div class="order-type white m10">
                                                                                <span>Order Type :</span> {$val.order_type}
                                                                            </div>
                                                                            <div class="time white m10">
                                                                                <span>Time :</span> {$val.date_added}
                                                                            </div>
                                                                            <div class="view-result white">
                                                                                <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <img width="50px" src="{$config.url}/uploads/product/{$val.avatar}" class="img-responsiveSS">
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-12 visible-xs">
                                                      <div class="hover-div orange-bg visible-xs">
                                                          <div class="row flex p35">
                                                              <div class="col-md-4 margin-auto">
                                                                  <img src="{$config.url}/uploads/product/{$val.avatar}" class="img-responsive margin-auto" alt="">
                                                              </div>
                                                              <div class="col-md-8 content margin-auto">
                                                                  <div class="row">
                                                                      <div class="order-type white m10">
                                                                          <span>Order Type :</span> {$val.order_type}
                                                                      </div>
                                                                      <div class="time white m10">
                                                                          <span>Time :</span> {$val.date_added}
                                                                      </div>
                                                                      <div class="view-result white">
                                                                          <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a>
                                                                      </div>
                                                                  </div>
                                                              </div>
                                                          </div>
                                                      </div>
                                                    </div>
                                                    <div class="col-md-5 col-xs-12 margin-auto">
                                                        <div class="open-bid-item"><span class="green-text">Product Name:</span> {$val.title}</div>
                                                        <div class="open-bid-item"><span class="green-text">Available Quantity :</span> {$val.qty} {if $val.units == "ounces"} oz {/if} {if $val.units == "pounds"} lbs {/if} {if $val.units == "grams"} g {/if} {if $val.units == "units"} units {/if}
                                                            <input class="res-width" id="qty"  data-parsley-type="number"
                                                            type="text" placeholder="Quantity Requested"
                                                            name="qty"
                                                            {if $val.order_type == "total"} data-parsley-equalto="{$val.qty}"
                                                            data-parsley-equalto-message="please enter total Quantity requested"
                                                            {elseif $val.order_type == "partial"}
                                                            data-parsley-max="{$val.qty}"
                                                            data-parsley-max-message="Quantity should be less than available quantity"
                                                            {/if}>
                                                            </input>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 margin-auto">


                                                        <div class="open-bid-item"><span class="green-text">Buyer Rating:</span>
                                                            <div class="rating-stars">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-half-o" aria-hidden="true"></i>
                                                            </div>
                                                        </div>
                                                        <div class="open-bid-item"><span class="green-text">Target Price :</span> ${$val.sprice}

                                                            <input class="" id="offer_price" type="text" placeholder="Price Offer" name="offer_price" data-parsley-required-message="please enter offer price." data-parsley-required required></input>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2 margin-auto">
                                                        <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="submitform(this, {$val.id})">SUBMIT</button>
                                                        <a class="green-text m5" href="#"><b>More Details</b></a>
                                                    </div>
                                                </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row open-bid-row border1">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="row flex" style="padding: 4px 0px;">
                                                    <div class="col-md-2 margin-auto res-mtb">
                                                        <div class="blue w100 text-center"><b class="buy-text">SELL</b></div>
                                                        <div class="thumb blue-border">
                                                            <div class="hover-div blue-bg hidden-xs">
                                                                <div class="row flex">
                                                                    <div class="col-md-4">
                                                                        <img src="{$config.url}/uploads/product/{$val.avatar}" class="img-responsive margin-auto" alt="">
                                                                    </div>
                                                                    <div class="col-md-8 content margin-auto">
                                                                        <div class="row">
                                                                            <div class="order-type white m10">
                                                                                <span>Order Type :</span> {$val.order_type}
                                                                            </div>
                                                                            <div class="time white m10">
                                                                                <span>Time :</span> {$val.date_added}
                                                                            </div>
                                                                            <div class="view-result white">
                                                                                <!-- <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a> -->
                                                                                <span> Upload Test Results<a class="white" href="#"> <i class="fa fa-upload" aria-hidden="true"></i></a></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <img width="50px" src="{$config.url}/uploads/product/{$val.avatar}" class="img-responsiveSS">
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-12 visible-xs">
                                                      <div class="blue-bg visible-xs">
                                                          <div class="row flex p35">
                                                              <div class="col-md-4">
                                                                  <img src="{$config.url}/uploads/product/{$val.avatar}" class="img-responsive margin-auto" alt="">
                                                              </div>
                                                              <div class="col-md-8 content margin-auto">
                                                                  <div class="row">
                                                                      <div class="order-type white m10">
                                                                          <span>Order Type :</span> {$val.order_type}
                                                                      </div>
                                                                      <div class="time white m10">
                                                                          <span>Time :</span> {$val.date_added}
                                                                      </div>
                                                                      <div class="view-result white">
                                                                          <!-- <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a> -->
                                                                          <span> Upload Test Results<a class="white" href="#"> <i class="fa fa-upload" aria-hidden="true"></i></a></span>
                                                                      </div>
                                                                  </div>
                                                              </div>
                                                          </div>
                                                      </div>
                                                    </div>
                                                    <div class="col-xs-12 visible-xs">
                                                      <div class="blue-bg visible-xs">
                                                          <div class="row flex">
                                                              <div class="col-md-4">
                                                                  <img src="{$config.url}/uploads/product/{$val.avatar}" class="img-responsive margin-auto" alt="">
                                                              </div>
                                                              <div class="col-md-8 content margin-auto">
                                                                  <div class="row">
                                                                      <div class="order-type white m10">
                                                                          <span>Order Type :</span> {$val.order_type}
                                                                      </div>
                                                                      <div class="time white m10">
                                                                          <span>Time :</span> {$val.date_added}
                                                                      </div>
                                                                      <div class="view-result white">
                                                                          <!-- <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a> -->
                                                                          <span> Upload Test Results<a class="white" href="#"> <i class="fa fa-upload" aria-hidden="true"></i></a></span>
                                                                      </div>
                                                                  </div>
                                                              </div>
                                                          </div>
                                                      </div>
                                                    </div>
                                                    <div class="col-md-5 margin-auto">
                                                        <div class="open-bid-item"><span class="green-text">Product Name:</span> {$val.title} </div>
                                                        <div class="open-bid-item"><span class="green-text">Quantity Requested :</span> {$val.qty} {if $val.units == "ounces"} oz {/if} {if $val.units == "pounds"} lbs {/if} {if $val.units == "grams"} g {/if} {if $val.units == "units"} units {/if}
                                                            <input class="" id="qty"  data-parsley-type="number"
                                                            type="text" placeholder="Quantity Requested"
                                                            name="qty"
                                                            {if $val.order_type == "total"} data-parsley-equalto="{$val.qty}"
                                                            data-parsley-equalto-message="please enter total Quantity requested"
                                                            {elseif $val.order_type == "partial"}
                                                            data-parsley-max="{$val.qty}"
                                                            data-parsley-max-message="Quantity should be less than total quantity"
                                                            {/if}>
                                                            </input>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 margin-auto">
                                                        <span class="sky-blue"> <b>Future 10/15/17</b></span>
                                                        <div class="open-bid-item"><span class="green-text">Buyer Rating:</span>
                                                            <div class="rating-stars">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-half-o" aria-hidden="true"></i>
                                                            </div>
                                                        </div>
                                                        <div class="open-bid-item"><span class="green-text">Target Price :</span> ${$val.sprice}
                                                            <input class="" type="text" placeholder="Price offer"></input>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2 margin-auto">
                                                        <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="submitform(this, {$val.id})">SUBMIT</button>
                                                        <a class="green-text m5" href="#"><b>More Details</b></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
