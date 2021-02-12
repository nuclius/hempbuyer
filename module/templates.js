exports.loadTemplate = function(products, url, callback) {
    var template = '';
    var units = '';
    var qtyValidation = '';
    for (var i = 0; i < products.length; i++) {

        if (products[i].units == "ounces") {
            units = 'oz'
        } else if (products[i].units == "pounds") {
            units = 'lbs'
        } else if (products[i].units == "grams") {
            units = 'g'
        } else if (products[i].units == "units") {
            if (products[i].qty > 1)
                units = 'units';
            else
                units = 'unit';
        }


        if (products[i].order_type == "total") {
            qtyValidation = 'data-parsley-equalto="' + products[i].qty + '" data-parsley-equalto-message="please enter total Quantity requested"'
        } else if (products[i].order_type == "qty") {
            qtyValidation = 'data-parsley-max="' + products[i].qty + 'data-parsley-max-message="Quantity should be less than available quantity"'
        }

        if (products[i].trading_type == 'sell') {

            //{if $val.units == "ounces"} oz {/if} {if $val.units == "pounds"} lbs {/if} {if $val.units == "grams"} g {/if} {if $val.units == "units"} units {/if}


            template = template + '<div class="row open-bid-row border1">' +
                '                            <div class="col-md-12 padlr">' +
                '                                <div class="row">' +
                '                                    <div class="col-md-12 padlr">' +
                '                                        <div class="row">' +
                '                                            <div class="col-md-12 padlr">' +
                '                                            <form id="submit_form' + products[i].id + '" data-parsley-validate method="post" action="">' +
                '                                                <div class="row flex" style="padding: 4px 0px">' +
                '                                                    <div class="col-md-2 margin-auto">' +
                '                                                        <div class="orange w100 text-center"><b class="buy-text">BUY</b></div>' +
                '                                                        <div class="thumb">' +
                '                                                            <div class="hover-div orange-bg">' +
                '                                                                <div class="row flex">' +
                '                                                                    <div class="col-md-4">' +
                '                                                                        <img src="' + url + '/uploads/product/' + products[i].avatar + '" class="img-responsive margin-auto" alt="">' +
                '                                                                    </div>' +
                '                                                                    <div class="col-md-8 content margin-auto">' +
                '                                                                        <div class="row">' +
                '                                                                            <div class="order-type white m10">' +
                '                                                                                <span>Order Type :</span> ' + products[i].order_type + '' +
                '                                                                            </div>' +
                '                                                                            <div class="time white m10">' +
                '                                                                                <span>Time :</span> ' + products[i].start_date + '' +
                '                                                                            </div>' +
                '                                                                            <div class="view-result white">' +
                '                                                                                <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a>' +
                '                                                                            </div>' +
                '                                                                        </div>' +
                '                                                                    </div>' +
                '                                                                </div>' +
                '                                                            </div>' +
                '                                                            <img width="50px" src="' + url + '/uploads/product/' + products[i].avatar + '" class="img-responsiveSS">' +
                '                                                        </div>' +
                '                                                    </div>' +
                '                                                    <div class="col-md-5 col-sm-4 margin-auto">' +
                '                                                        <div class="open-bid-item"><span class="green-text">Product Name:</span> ' + products[i].title + '</div>' +
                '                                                        <div class="open-bid-item"><span class="green-text">Available Quantity :</span> ' + products[i].qty + ' ' + units +
                '                                                            <input class="" id="qty"  data-parsley-type="number" ' +
                '                                                            type="text" placeholder="Quantity Requested" ' +
                '                                                            name="qty" ' +
                '                                                            data-parsley-equalto-message="please enter total Quantity requested" ' +qtyValidation+
                '                                                            >' +
                '                                                            </input>' +
                '                                                        </div>' +
                '                                                    </div>' +
                '                                                    <div class="col-md-4 col-sm-4 margin-auto">' +
                '                                                        ' +
                '                                                        <span class="orange-available"> <b>Available Now</b></span>' +
                '                                                        <div class="open-bid-item"><span class="green-text">Buyer Rating:</span>' +
                '                                                            <div class="rating-stars">' +
                '                                                                <i class="fa fa-star" aria-hidden="true"></i>' +
                '                                                                <i class="fa fa-star" aria-hidden="true"></i>' +
                '                                                                <i class="fa fa-star" aria-hidden="true"></i>' +
                '                                                                <i class="fa fa-star" aria-hidden="true"></i>' +
                '                                                                <i class="fa fa-star-half-o" aria-hidden="true"></i>' +
                '                                                            </div>' +
                '                                                        </div>' +
                '                                                        <div class="open-bid-item"><span class="green-text">Target Price :</span> $' + products[i].sprice + '' +
                '                                                            <input class="" id="offer_price" type="text" placeholder="Price Offer" name="offer_price" data-parsley-required-message="please enter offer price." data-parsley-required required></input>' +
                '                                                        </div>' +
                '                                                    </div>' +
                '                                                    <div class="col-md-2 margin-auto">' +
                '                                                        <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="submitform(this, ' + products[i].id + ')">SUBMIT</button>' +
                '                                                        <a class="green-text ftn13 m5" href="#"><b>More Details</b></a>' +
                '                                                    </div>' +
                '                                                </div>' +
                '                                                </form>' +
                '                                            </div>' +
                '                                        </div>' +
                '                                    </div>' +
                '                                </div>' +
                '                            </div>' +
                '                        </div>';
        } else if (products[i].trading_type == 'buy') {
            //buy template

            template = template + '<div class="row open-bid-row border1">' +
                '                            <div class="col-md-12 padlr">' +
                '                                <div class="row">' +
                '                                    <div class="col-md-12 padlr">' +
                '                                        <div class="row">' +
                '                                            <div class="col-md-12 padlr">' +
                '                                            <form id="submit_form' + products[i].id + '" data-parsley-validate method="post" action="">' +
                '                                                <div class="row flex" style="padding: 4px 0px;">' +
                '                                                    <div class="col-md-2 margin-auto">' +
                '                                                        <div class="blue w100 text-center"><b class="buy-text">SELL</b></div>' +
                '                                                        <div class="thumb blue-border">' +
                '                                                            <div class="hover-div blue-bg">' +
                '                                                                <div class="row flex">' +
                '                                                                    <div class="col-md-4">' +
                '                                                                        <img src="' + url + '/uploads/product/' + products[i].avatar + '" class="img-responsive margin-auto" alt="">' +
                '                                                                    </div>' +
                '                                                                    <div class="col-md-8 content margin-auto">' +
                '                                                                        <div class="row">' +
                '                                                                            <div class="order-type white m10">' +
                '                                                                                <span>Order Type :</span> ' + products[i].order_type + '' +
                '                                                                            </div>' +
                '                                                                            <div class="time white m10">' +
                '                                                                                <span>Time :</span> ' + products[i].start_date + '' +
                '                                                                            </div>' +
                '                                                                            <div class="view-result white">' +
                '                                                                                <!-- <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a> -->' +
                '                                                                                <span> Upload Test Results<a class="white" href="#"> <i class="fa fa-upload" aria-hidden="true"></i></a></span>' +
                '                                                                            </div>' +
                '                                                                        </div>' +
                '                                                                    </div>' +
                '                                                                </div>' +
                '                                                            </div>' +
                '                                                            <img width="50px" src="' + url + '/uploads/product/' + products[i].avatar + '" class="img-responsiveSS">' +
                '                                                        </div>' +
                '                                                    </div>' +
                '                                                    <div class="col-md-5 col-sm-4 margin-auto">' +
                '                                                        <div class="open-bid-item"><span class="green-text">Product Name:</span> ' + products[i].title + ' </div>' +
                '                                                        <div class="open-bid-item"><span class="green-text">Quantity Requested :</span> ' + products[i].qty + ' ' + units +
                '                                                            <input class="" id="qty"  data-parsley-type="number" ' +
                '                                                            type="text" placeholder="Quantity Requested" ' +
                '                                                            name="qty" ' + qtyValidation + 
                '                                                            >' +
                '                                                            </input>' +
                '                                                        </div>' +
                '                                                    </div>' +
                '                                                    <div class="col-md-4 col-sm-4 margin-auto">' +
                '                                                        <span class="sky-blue"> <b>Future 10/15/17</b></span>' +
                '                                                        <div class="open-bid-item"><span class="green-text">Buyer Rating:</span>' +
                '                                                            <div class="rating-stars">' +
                '                                                                <i class="fa fa-star" aria-hidden="true"></i>' +
                '                                                                <i class="fa fa-star" aria-hidden="true"></i>' +
                '                                                                <i class="fa fa-star" aria-hidden="true"></i>' +
                '                                                                <i class="fa fa-star" aria-hidden="true"></i>' +
                '                                                                <i class="fa fa-star-half-o" aria-hidden="true"></i>' +
                '                                                            </div>' +
                '                                                        </div>' +
                '                                                        <div class="open-bid-item"><span class="green-text">Target Price :</span> $' + products[i].sprice + '' +
                '                                                            <input class="" id="offer_price" type="text" placeholder="Price Offer" name="offer_price" data-parsley-required-message="please enter offer price." data-parsley-required required></input>' +
                '                                                        </div>' +
                '                                                    </div>' +
                '                                                    <div class="col-md-2 margin-auto">' +
                '                                                        <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="submitform(this, ' + products[i].id + ')">SUBMIT</button>' +
                '                                                        <a class="green-text ftn13 m5" href="#"><b>More Details</b></a>' +
                '                                                    </div>' +
                '                                                </div>' +
                '                                                </form>' +
                '                                            </div>' +
                '                                        </div>' +
                '                                    </div>' +
                '                                </div>' +
                '                            </div>' +
                '                        </div>';
        }

    }
    callback(null, template);
}


/* Buy template */
// template = template + '<div class="row open-bid-row border1">'+
// '                            <div class="col-md-12">'+
// '                                <div class="row">'+
// '                                    <div class="col-md-12">'+
// '                                        <div class="row">'+
// '                                            <div class="col-md-12">'+
// '                                                <div class="row flex" style="padding: 4px 0px;">'+
// '                                                    <div class="col-md-2 margin-auto">'+
// '                                                        <div class="blue w100 text-center"><b class="buy-text">SELL</b></div>'+
// '                                                        <div class="thumb blue-border">'+
// '                                                            <div class="hover-div blue-bg">'+
// '                                                                <div class="row flex">'+
// '                                                                    <div class="col-md-4">'+
// '                                                                        <img src="'+url+'/uploads/product/'+products[0].avatar+'" class="img-responsive margin-auto" alt="">'+
// '                                                                    </div>'+
// '                                                                    <div class="col-md-8 content margin-auto">'+
// '                                                                        <div class="row">'+
// '                                                                            <div class="order-type white m10">'+
// '                                                                                <span>Order Type :</span> '+products[0].order_type+''+
// '                                                                            </div>'+
// '                                                                            <div class="time white m10">'+
// '                                                                                <span>Time :</span> '+products[0].start_date+''+
// '                                                                            </div>'+
// '                                                                            <div class="view-result white">'+
// '                                                                                <!-- <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a> -->'+
// '                                                                                <span> Upload Test Results<a class="white" href="#"> <i class="fa fa-upload" aria-hidden="true"></i></a></span>'+
// '                                                                            </div>'+
// '                                                                        </div>'+
// '                                                                    </div>'+
// '                                                                </div>'+
// '                                                            </div>'+
// '                                                            <img width="50px" src="'+url+'/uploads/product/'+products[0].avatar+'" class="img-responsiveSS">'+
// '                                                        </div>'+
// '                                                    </div>'+
// '                                                    <div class="col-md-5 margin-auto">'+
// '                                                        <div class="open-bid-item"><span class="green-text">Product Name:</span> '+products[0].title+' </div>'+
// '                                                        <div class="open-bid-item"><span class="green-text">Quantity Requested :</span> '+products[0].qty+' '+
// '                                                            <input class="" id="qty"  data-parsley-type="number" '+
// '                                                            type="text" placeholder="Quantity Requested" '+
// '                                                            name="qty" '+
// '                                                            >'+
// '                                                            </input>'+
// '                                                        </div>'+
// '                                                    </div>'+
// '                                                    <div class="col-md-4 margin-auto">'+
// '                                                        <span class="sky-blue"> <b>Future 10/15/17</b></span>'+
// '                                                        <div class="open-bid-item"><span class="green-text">Buyer Rating:</span>'+
// '                                                            <div class="rating-stars">'+
// '                                                                <i class="fa fa-star" aria-hidden="true"></i>'+
// '                                                                <i class="fa fa-star" aria-hidden="true"></i>'+
// '                                                                <i class="fa fa-star" aria-hidden="true"></i>'+
// '                                                                <i class="fa fa-star" aria-hidden="true"></i>'+
// '                                                                <i class="fa fa-star-half-o" aria-hidden="true"></i>'+
// '                                                            </div>'+
// '                                                        </div>'+
// '                                                        <div class="open-bid-item"><span class="green-text">Target Price :</span> $'+products[0].sprice+''+
// '                                                            <input class="" type="text" placeholder="Price offer"></input>'+
// '                                                        </div>'+
// '                                                    </div>'+
// '                                                    <div class="col-md-2 margin-auto">'+
// '                                                        <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="submitform(this, '+products[0].id+')">SUBMIT</button>'+
// '                                                        <a class="green-text m5" href="#"><b>More Details</b></a>'+
// '                                                    </div>'+
// '                                                </div>'+
// '                                            </div>'+
// '                                        </div>'+
// '                                    </div>'+
// '                                </div>'+
// '                            </div>'+
// '                        </div>';

/*  Sell template - */
// 			template = template + '<div class="row open-bid-row border1">'+
// '                            <div class="col-md-12">'+
// '                                <div class="row">'+
// '                                    <div class="col-md-12">'+
// '                                        <div class="row">'+
// '                                            <div class="col-md-12">'+
// '                                            <form id="submit_form'+products[0].id+'" data-parsley-validate method="post" action="">'+
// '                                                <div class="row flex" style="padding: 4px 0px">'+
// '                                                    <div class="col-md-2 margin-auto">'+
// '                                                        <div class="orange w100 text-center"><b class="buy-text">BUY</b></div>'+
// '                                                        <div class="thumb">'+
// '                                                            <div class="hover-div orange-bg">'+
// '                                                                <div class="row flex">'+
// '                                                                    <div class="col-md-4">'+
// '                                                                        <img src="'+url+'/uploads/product/'+products[0].avatar+'" class="img-responsive margin-auto" alt="">'+
// '                                                                    </div>'+
// '                                                                    <div class="col-md-8 content margin-auto">'+
// '                                                                        <div class="row">'+
// '                                                                            <div class="order-type white m10">'+
// '                                                                                <span>Order Type :</span> '+products[0].order_type+''+
// '                                                                            </div>'+
// '                                                                            <div class="time white m10">'+
// '                                                                                <span>Time :</span> '+products[0].start_date+''+
// '                                                                            </div>'+
// '                                                                            <div class="view-result white">'+
// '                                                                                <span>View Test Results </span> <a class="white" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i></a>'+
// '                                                                            </div>'+
// '                                                                        </div>'+
// '                                                                    </div>'+
// '                                                                </div>'+
// '                                                            </div>'+
// '                                                            <img width="50px" src="'+url+'/uploads/product/'+products[0].avatar+'" class="img-responsiveSS">'+
// '                                                        </div>'+
// '                                                    </div>'+
// '                                                    <div class="col-md-5 margin-auto">'+
// '                                                        <div class="open-bid-item"><span class="green-text">Product Name:</span> '+products[0].title+'</div>'+
// '                                                        <div class="open-bid-item"><span class="green-text">Available Quantity :</span> '+products[0].qty+' '+
// '                                                            <input class="" id="qty"  data-parsley-type="number" '+
// '                                                            type="text" placeholder="Quantity Requested" '+
// '                                                            name="qty" '+
// '                                                            data-parsley-equalto-message="please enter total Quantity requested"'+
// '                                                            >'+
// '                                                            </input>'+
// '                                                        </div>'+
// '                                                    </div>'+
// '                                                    <div class="col-md-4 margin-auto">'+
// '                                                        '+
// '                                                        <span class="orange-available"> <b>Available Now</b></span>'+
// '                                                        <div class="open-bid-item"><span class="green-text">Buyer Rating:</span>'+
// '                                                            <div class="rating-stars">'+
// '                                                                <i class="fa fa-star" aria-hidden="true"></i>'+
// '                                                                <i class="fa fa-star" aria-hidden="true"></i>'+
// '                                                                <i class="fa fa-star" aria-hidden="true"></i>'+
// '                                                                <i class="fa fa-star" aria-hidden="true"></i>'+
// '                                                                <i class="fa fa-star-half-o" aria-hidden="true"></i>'+
// '                                                            </div>'+
// '                                                        </div>'+
// '                                                        <div class="open-bid-item"><span class="green-text">Target Price :</span> $'+products[0].sprice+''+
// ''+
// '                                                            <input class="" id="offer_price" type="text" placeholder="Price Offer" name="offer_price" data-parsley-required-message="please enter offer price." data-parsley-required required></input>'+
// '                                                        </div>'+
// '                                                    </div>'+
// '                                                    <div class="col-md-2 margin-auto">'+
// '                                                        <button class="btn btn-default btn-d-b green-b customized" style="padding: 5px !important;" onclick="submitform(this, '+products[0].id+')">SUBMIT</button>'+
// '                                                        <a class="green-text m5" href="#"><b>More Details</b></a>'+
// '                                                    </div>'+
// '                                                </div>'+
// '                                                </form>'+
// '                                            </div>'+
// '                                        </div>'+
// '                                    </div>'+
// '                                </div>'+
// '                            </div>'+
// '                        </div>'
