var mysqli = require('./mysqli');
var products = require('./products');
var q = require('q');
var topHTMLtext = '';
//var configure = require('../configure');
//var config = configure.app();

/*$arr = {
  config : config
}*/

exports.updateDeleteBooked = function(req, mysql, q, pdt) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'timer3');
    var defered = q.defer();
    var escape_data = [pdt['qty'], pdt['project_id']];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    strQuery = mysqli.mysqli($mysqli, 'timer9');
    var defered = q.defer();
    var escape_data = [pdt['id']];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
                   
    return defered.promise;
}
exports.deleterecurring = function(req, mysql, q, pdt) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'deleterecurringcde');
    var defered = q.defer();
    var escape_data = [pdt['project_id'], req.session.userid, req.session.temp_cart_id];
    console.log('escape_data--------------');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}

exports.cartPaidPrdt = function(req, mysql, q, id, cart_id, qty_add) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer10');
    var defered = q.defer();
    var escape_data = [id, cart_id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    strQuery = mysqli.mysqli($mysqli, 'timer3');
    var defered = q.defer();
    var escape_data = [qty_add, id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on("error", function(err) {
        console.log(err.stack);
        throw err;

    })
    return defered.promise;

}
exports.minusReduceCart = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'timer11');
    query = mysql.query(strQuery, defered.makeNodeResolver());
    return defered.promise;

}
exports.tempCartDetails = function(req, mysql, q) {
    $mysqli = {};
    var defered = q.defer();
    var escape_data = [req.session.userid];
    strQuery = mysqli.mysqli($mysqli, 'timer13');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}
exports.clearAllCart = function(req, mysql, q, sec) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer7');
    //strQuery = mysqli.mysqli($mysqli,'timer7new');
    var defered = q.defer();
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //var escape_data =  [req.session.userid];
    var escape_data = [datenow, sec];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}

exports.paidBuynowlocal = function(req, mysql, q, id, escrow) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'update_local_pickup_cart');
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    var release = 1;
    var r_date = datenow;
    if (escrow == 0) {
        release = 0;
        r_date = '0000-00-00 00:00:00'
    }
    var escape_data = [id, datenow, release, r_date, escrow, req.param('id')];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    query.on('error', function(error) {
        console.log(error.stack)
        throw error;
    })
    return defered.promise;

}
exports.paidBuynow = function(req, mysql, q, id, escrow) {
    $mysqli = {};
    // mysqli['cnx230'] = 'update buynow set `paid` = 1,cart_id = ?,`paid_date` = ?,`release` = ?,r_date = ?,escrow = ?,active = 0 where id = ? limit 1';
    // mysqli['cnx230'] = 'update buynow set `paid` = 1,`paid_date` = ?,`release` = ?,r_date = ?,escrow = ?,active = 0 where id = ? limit 1';
    strQuery = mysqli.mysqli($mysqli, 'cnx230');
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    var release = 1;
    var r_date = datenow;
    if (escrow == 0) {
        release = 0;
        r_date = '0000-00-00 00:00:00'
    }
    var escape_data = [datenow, release, r_date, escrow, id];
    // console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
exports.paidBid = function(req, mysql, q, id, trans_id) {
    $mysqli = {};
    // mysqli[208] = 'update invoices set status = "paid",paid_date = ?,gateway = ? where primary_id = ? AND type="winner" ';
    strQuery = mysqli.mysqli($mysqli, '208');
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    var release = 1;
    var r_date = datenow;
    console.log('work5')
    // var escape_data = [r_date, req.body.trans_gateway, id];
    var escape_data = [r_date, id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    // console.log('aaa'+query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;

}

exports.releaseBuynow = function(req, mysql, q, buynowid, m) {
    $mysqli = {};
    mysqli['cnx243'] = 'update buynow set admin=? where id=?';
    strQuery = mysqli.mysqli($mysqli, 'cnx243');
    var escape_data = [m, buynowid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    // console.log('aaa'+query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

exports.insertBidnow = function(req, mysql, q, pay) {
    $mysqli = {};
    req.body.local_pick = (typeof(req.body.local_pick) == 'undefined') ? 0 : req.body.local_pick;
    strQuery = mysqli.mysqli($mysqli, 'cnx212');
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var sold = 1;
    var amt = pay.amount;
    //var amt = req.session.products[d]['qty_add']*(req.session.products[d]['bprice']+req.session.products[d]['shipping_price']);
    commission = parseFloat((amt) * (req.body.commission / 100)).toFixed(2)

    /* if(req.body.local_pick == 1){
         amt = 0;
         commission = 0;
     }*/
    var escape_data = [pay.payid, pay.sessionsdata.userid, amt, datenow, 1, 0, 1, 0, 1, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, commission, req.body.local_pick, 0];

    console.log(escape_data)
    var defered = q.defer();
    //var escape_data =  [req.param('id')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}


exports.getCartDetailscart = function(req, mysql, q, cartid) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx218');

    var defered = q.defer();
    var escape_data = [cartid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Get cart details query is " + query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}


exports.getCartDetails = function(req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx218');

    var defered = q.defer();
    var escape_data = [req.param('id')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}
exports.updateInvoiceBuy = function(req, mysql, q, id, cid, pid) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx251');

    var defered = q.defer();
    var escape_data = [id, cid, pid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("**************** Invoice update query is " + query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}

exports.getBuynowCartDetails = function(req, mysql, q) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx219');

    var defered = q.defer();
    var escape_data = [req.param('id')];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Get buynow details " + query.sql);
    query.on("error", function(err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;
}

exports.getBuynowCartDetailsById = function(req, mysql, q, id) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx219');

    var defered = q.defer();
    var escape_data = [id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Get buynow details " + query.sql);
    query.on("error", function(err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;
}

exports.getbuyerdetails = function(req, mysql, q, buyerid) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'yab20');
    //console.log(strQuery);
    var defered = q.defer();
    var escape_data = [buyerid];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Get buyer details query is " + query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}

exports.cartPaidPrdtsel = function(req, mysql, q, id, cart_id, qty_add) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'yab21');
    var defered = q.defer();
    var escape_data = [req.session.userid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.cartinsertBuyItemInvoices = function(req, mysql, q, c_id, prouserdetails, buyerdetails, prdt, quantity, trans_id, total_amt) {
    console.log("prouserdetails detils is " + JSON.stringify(prouserdetails));
    console.log("buyerdetails detils is " + JSON.stringify(buyerdetails));
    
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx216');

    var defered = q.defer();
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var amt = total_amt;

    // var escape_data =  [trans_id,'braintree',datenow,req.session.userid,prdt['id'],'sold',prdt['title'],amt,'paid','debit',datenow,quantity,c_id];
    var escape_data = [
        trans_id,
        (req.session.cod!=undefined && req.session.cod==1 ? 'cod' : 'account'),
        datenow,
        buyerdetails.id,
        prdt.id,
        'bought',
        prdt.title,
        amt,
        (req.session.cod!=undefined && req.session.cod==1 ? 'unpaid' : 'paid'),
        'debit',
        datenow,
        quantity,
        c_id
    ];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Insert Invoice " + query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    var selleremail = prouserdetails['email'];
    var first_name = prouserdetails['first_name'];
    var last_name = prouserdetails['last_name'];
    var saled = prdt['saled'];
    var title = prdt['title'];
    var sellerphone = prouserdetails['phone']
    var url = global.url + '/product/view/' + prdt['id'];

    var buyeremail = buyerdetails['email'];
    var buyer_first_name = buyerdetails['first_name'];

    delete customerio;

    customerio = require('./customerio');
    customerio.uid = prouserdetails['user_id'];

   q.all([products.checkmailnotify(req, config.mysql, q, 40), products.checksmsnotify(req, config.mysql, q, 40)]).then(function(results) {

        localm = require('../module/localmail');
        // console.log(results[1][0]);

       

    //var price  = parseFloat(parseInt()*(parseFloat(prouserdetails['bprice']) + parseFloat(prouserdetails['shipping_price']))).toFixed(2);
    var price = (quantity * common.sumFloat(prdt.bprice, prdt.shipping_price)).toFixed(2);;

    // console.log('consoleconsoleconsoleconsoleconsoleconsole' + price);
    var activeurl = '<br/> <a href="' + $arr.config.spath + 'dashboard/seller/sold">Click Here</a>';
    var activeurl_buyer = '<br/> <a href="' + $arr.config.spath + 'dashboard/dbmarket/">Click Here</a>';

 if (results[0][0].length > 0) {
    if (global.emailcio.status == 'yes') {
        console.log("********** If emailcio status yess With qty  " + quantity + "*************");
        customerio.inits();
        customerio.createCustomer({ email: prouserdetails['email'], user: { firstName: prouserdetails['first_name'], lastName: prouserdetails['last_name'] } });
        customerio.sendEmail({ event: 'item_sold', content: { user: prouserdetails['first_name'] + ' ' + prouserdetails['last_name'], bname: buyerdetails['first_name'] + ' ' + buyerdetails['last_name'], bphone: buyerdetails['phone'], bemail: buyerdetails['email'], qty: quantity, price: price.toFixed(2), title: prouserdetails['title'], url: global.url + '/product/view/' + prouserdetails['id'], sitename: 'AuctionSoftware.com' } });
    } else if (global.emaillocal.status == 'yes') {

        console.log("********** If emaillocal status yess *************");

        q.all([localm.mailtemps(req, config.mysql, q, 'product_sold'), localm.mailtemps(req, config.mysql, q, 'prouct_bought')]).then(function(results2) {

            var price2 = parseFloat(parseInt(quantity) * (parseFloat(prdt['bprice']) + parseFloat(prdt['shipping_price'])));

            if (results2) {

                var template = results2[0][0][0].template;
                var subject_message = results2[0][0][0].subject;

                var template1 = results2[1][0][0].template;
                var subject_message1 = results2[1][0][0].subject;

                // template = template.replace('{{event.user}}', prouserdetails['first_name'] + ' ' + prouserdetails['last_name']);
                template = template.replace('{{event.user}}', prouserdetails['first_name']);
                template = template.replace('{{event.subject}}', 'You have a new sale on Herbee');
                template = template.replace('{{event.activeurl}}', activeurl);

                template1 = template1.replace('{{event.user}}', buyer_first_name);
                template1 = template1.replace('{{event.subject}}', 'Your Herbee purchase');
                template1 = template1.replace('{{event.activeurl}}', activeurl_buyer);

                localm.sendmail(template, subject_message, selleremail);
                localm.sendmail(template1, subject_message1, buyeremail);
                
            } else {

                console.log("No template named item_sold");
            }

        }).fail(function(err) {
            console.log(err.stack);
            throw err;
        }).done();

    } else { console.log('No Mail Delivery method is selected'); }
}else{ console.log("Notification off"); }


    console.log('***********************************');

    if (global.smstwo.status == 'yes') {

        console.log("********** If smstwo status yess *************");

        twillio = require('./twillio');

        q.all([twillio.smstemps(req, config.mysql, q, 'item_sold')]).then(function(results3) {

            if (results3) {
                var price3 = parseFloat(parseInt(prdt['saled']) * (parseFloat(prdt['bprice']) + parseFloat(prouserdetails['shipping_price'])));
                var template = results3[0][0][0].template;

                template = template.replace('{{event.user}}', prouserdetails['first_name'] + ' ' + prouserdetails['last_name']);
                template = template.replace('{{event.qty}}', quantity);
                template = template.replace('{{event.bname}}', buyerdetails['first_name']);
                template = template.replace('{{event.bphone}}', buyerdetails['phone']);
                template = template.replace('{{event.bemail}}', buyerdetails['email']);
                template = template.replace('{{event.price}}', price3.toFixed(2));
                template = template.replace('{{event.title}}', title);
                template = template.replace('{{event.url}}', url);
                template = template.replace('{{event.sitename}}', 'AuctionSoftware.com');

                twillio.sendsms(template, sellerphone);

            } else {

                console.log('No template name bid_submitted')
            }


        }).fail(function(err) {
            console.log(err.stack);
            throw err;
        }).done();

    }
});
    return defered.promise;
}



exports.insertBuyItemInvoices = function(req, mysql, q, d, c_id, trans_id) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'cnx216');

    var defered = q.defer();
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var amt = (req.session.products[d]['saled'] * common.sumFloat(req.session.products[d]['bprice'], req.session.products[d]['shipping_price'])).toFixed(2);

    var escape_data = [trans_id, req.body.trans_gateway, datenow, req.session.userid, req.session.products[d]['id'], 'sold', req.session.products[d]['title'], amt, 'paid', 'debit', datenow, req.session.products[d]['saled'], c_id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    });
    var selleremail = req.session.products[d]['email'];
    var first_name = req.session.products[d]['first_name'];
    var last_name = req.session.products[d]['last_name'];
    var saled = req.session.products[d]['saled'];
    var title = req.session.products[d]['title'];
    var sellerphone = req.session.products[d]['phone']
    var url = global.url + '/product/view/' + req.session.products[d]['id'];

    delete customerio;

    customerio = require('./customerio');
    customerio.uid = req.session.products[d]['user_id'];

    localm = require('./localmail');

    var price = parseFloat(parseInt(req.session.products[d]['saled']) * (parseFloat(req.session.products[d]['bprice']) + parseFloat(req.session.products[d]['shipping_price'])));

    if (global.emailcio.status == 'yes') {

        customerio.inits();

        customerio.createCustomer({ email: req.session.products[d]['email'], user: { firstName: req.session.products[d]['first_name'], lastName: req.session.products[d]['last_name'] } });
        customerio.sendEmail({ event: 'item_sold', content: { user: req.session.products[d]['first_name'] + ' ' + req.session.products[d]['last_name'], bname: req.param('f_name'), bphone: req.param('phone'), bemail: req.param('email'), qty: req.session.products[d]['saled'], price: price.toFixed(2), title: req.session.products[d]['title'], url: global.url + '/product/view/' + req.session.products[d]['id'], sitename: 'AuctionSoftware.com' } });
    } else if (global.emaillocal.status == 'yes') {

        q.all([localm.mailtemps(req, config.mysql, q, 'item_sold')]).then(function(results2) {

            //var price2  = parseFloat(parseInt(req.session.products[d]['saled'])*(parseFloat(req.session.products[d]['bprice']) + parseFloat(req.session.products[d]['shipping_price'])));
            if (results2) {

                var template = results2[0][0][0].template;
                var subject_message = results2[0][0][0].subject;

                template = template.replace('{{event.user}}', first_name + ' ' + last_name);
                template = template.replace('{{event.qty}}', saled);
                template = template.replace('{{event.bname}}', req.param('f_name'));
                template = template.replace('{{event.bphone}}', req.param('phone'));
                template = template.replace('{{event.bemail}}', req.param('email'));
                template = template.replace('{{event.price}}', price.toFixed(2));
                template = template.replace('{{event.title}}', title);
                template = template.replace('{{event.url}}', url);
                template = template.replace('{{event.sitename}}', 'AuctionSoftware.com');

                localm.sendmail(template, subject_message, selleremail);

            } else {

                console.log("No template named item_sold");
            }

        });

    } else { console.log('No Mail Delivery method is selected'); }

    console.log('***********************************');
    if (global.smstwo.status == 'yes') {

        twillio = require('./twillio');

        q.all([twillio.smstemps(req, config.mysql, q, 'item_sold')]).then(function(results3) {

            if (results3) {

                var template = results3[0][0][0].template;

                template = template.replace('{{event.user}}', first_name + ' ' + last_name);
                template = template.replace('{{event.qty}}', saled);
                template = template.replace('{{event.bname}}', req.param('f_name'));
                template = template.replace('{{event.bphone}}', req.param('phone'));
                template = template.replace('{{event.bemail}}', req.param('email'));
                template = template.replace('{{event.price}}', price.toFixed(2));
                template = template.replace('{{event.title}}', title);
                template = template.replace('{{event.url}}', url);
                template = template.replace('{{event.sitename}}', 'AuctionSoftware.com');

                twillio.sendsms(template, sellerphone);

            } else {

                console.log('No template name bid_submitted')
            }

        });

    }

    return defered.promise;
}

exports.updateSold = function(req, mysql, q, id, sold) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx214');

    var defered = q.defer();

    var escape_data = [sold, id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("UPDATE sold query " + query.sql);
    query.on('error', function(err) {
        console.log(err.stack);
        throw err;
    })
    return defered.promise;
}

exports.closeProduct = function(req, mysql, q, id) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx215');

    var defered = q.defer();

    var escape_data = [id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    query.on('error', function(err) {
        throw err;
        console.log(err.stack);
    })
    return defered.promise;
}

exports.checkout = function(req, mysql, q, id) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx210');

    var defered = q.defer();

    var escape_data = [id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.selectCartItems = function(req, mysql, q, fq) {

    fq = (req.session.pid instanceof Array) ? req.session.pid.join(',') : req.session.pid;
    $mysqli = { where: fq };
    strQuery = mysqli.mysqli($mysqli, 'cnx213');
    var defered = q.defer();
    var escape_data = [];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}

/* ===================== start change by divyesh (changes) ===================== */
exports.insertBuynowpaypal = function(req, mysql, q, cid, quantity, onlinepayment, shipprice, buynowprice, proid, buyerid) {
    console.log('yab22');
    console.log(cid);
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'yab22');
    // mysqli['yab22'] = 'insert into buynow (user_id,project_id,qty,amount,
    // commission,accept, date_added, total_amount, commission_per, stax_status, stax_per, stax_amt, cart_id) values(?,?,?,?,?,?,?,?,?,?,?,?)';
    var stax_amt = parseFloat(req.session.stax_per / 100 * (quantity * buynowprice));
    //console.log(req.session.products[d]);
    if (shipprice > 0) {
        local_pick = 1
        var amt = quantity * (buynowprice + shipprice) + stax_amt;

        if (onlinepayment == 1) {
            paids = 1
        } else {
            paids = 2
        }
    } else {
        var amt = quantity * (buynowprice + shipprice) + stax_amt;
        local_pick = 0
        paids = 1
    }

    var defered = q.defer();
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //console.log(datenow);
    var sold = quantity;
    var release = 1;
    var r_date = datenow;
    //commission = parseFloat((amt-req.session.products[d]['refund'])*(req.body.commission/100)).toFixed(2);
    commission = (parseFloat(config.general.commission_fee) / 100 * amt).toFixed(2);

    // mysqli['yab22'] = 'insert into buynow (
    //user_id,project_id,qty,amount,commission,accept, date_added, 
    //total_amount, commission_per, stax_status, stax_per, stax_amt) values(?,?,?,?,?,?,?,?,?,?,?,?)';

    var consultant_fee = 0;
    var consultant_fee_amount = 0;

    var escape_data = [
        buyerid,
        proid,
        quantity, buynowprice, commission, 0, datenow, amt, config.general.commission_fee, req.session.stax, req.session.stax_per, stax_amt, consultant_fee, consultant_fee_amount, cid
    ];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Insert INTO bounow table " + query.sql);

    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}
// cart.insertBuynowCron(config.mysql, q, 0, i.rp_quantity, 2, i.shipping_price, i.bprice, i.id, prouserdetails.id, buyuserdetails.id, i.stax, reserveAmount, i.rp_cancellation, i.rp_id, cancel_ins_per, cancel_ins_amt),
exports.insertBuynowCron = function(mysql, q, cid, prddt, c_name, quantity, onlinepayment, shipprice, buynowprice, commission_price, commission_per, proid, seller_id, buyerid, stax_per, consultant_fee, res_amount, cancel_ins_status, rp_id, cancel_ins_per, cancel_ins_amt, total_amt, insertId, rs_id, cod) {
    console.log('yab22');
    console.log('c_name ----------------- here------------',c_name);
    console.log(cid);
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'yab22');
    var stax_amt = parseFloat(stax_per / 100 * (quantity * buynowprice));
    if (stax_amt > 0) {
        var stax_status = 'y'
    } else {
        var stax_status = 'n'
    }

    var prdtPrice = (parseFloat(quantity) * parseFloat(buynowprice))

    /* distribution and excise tax calculations here for recurring */
    /* Distribution tax amount */

    var excise_markup_per = 0;
    var excise_markup_value = 0;
    var excise_tax_per = 0;
    var excise_tax = 0;


// if(global.general.excise_tax_status == 'yes' && prddt.default_distributor == 'y' && gmoneyObj.rbuisness_type == 'dispensary' &&( escape(c_name).toLowerCase() == 'flower' || escape(c_name).toLowerCase() == 'edibles' )){
    if(global.general.excise_tax_status == 'yes'){

        /* calculating excise markup value and percentage */
        excise_markup_per = parseFloat(global.general.excise_tax_markup);
        excise_markup_value = parseFloat(parseFloat(prdtPrice) * (parseFloat(global.general.excise_tax_markup)/100)).toFixed(2);
        console.log("excise_tax markeup value --- "+excise_tax);
        console.log("total amount --- "+parseFloat(prdtPrice));

        /* calculating excise tax percentage and value */
        excise_tax_per = parseFloat(global.general.excise_tax)
        excise_tax = parseFloat((parseFloat(prdtPrice) + parseFloat(excise_markup_value)) * (parseFloat(global.general.excise_tax)/100)).toFixed(2);

        console.log("excise_tax --- "+excise_tax);

    }

    /* calculating distribution tax percentage - will be deducted from seller side */
    var distribution_tax = 0;
    var distribution_tax_per = 0;

    /*  && escape(prddt.default_distributor).toLowerCase() == 'y' */
    console.log('global.general.distribution_rate_status', global.general.distribution_rate_status);
    console.log('global.general.distribution_rate', global.general.distribution_rate);
    if(global.general.distribution_rate_status == 'yes'){
        distribution_tax_per = parseFloat(global.general.distribution_rate);
        distribution_tax = parseFloat(prdtPrice) * parseFloat(global.general.distribution_rate)/100
        
        if(distribution_tax < parseFloat(global.general.distribution_default_rate)){
            distribution_tax = parseFloat(global.general.distribution_default_rate)
        }
    }

    /* to calculate cultivation tax here - will be deducted from seller side */
    var cultivation_tax = 0;
    var cultivation_tax_per = 0;

    if(escape(c_name).toLowerCase() == 'flower'){
        if(global.general.cultivation_tax_status == 'yes'){
            cultivation_tax = global.general.cultivation_tax;
            if(prddt.units.toLowerCase() == 'pounds') {
                cultivation_tax = cultivation_tax * 16;
            }
            cultivation_tax = parseFloat(cultivation_tax) * parseFloat(quantity);
            cultivation_tax_per = parseFloat(cultivation_tax);
        }
    } else if(escape(c_name).toLowerCase() == escape('Trim/Cannabis Leaves').toLowerCase()){
        var trim_tax = global.general.trim_tax;
        if(global.general.trim_tax_status == 'yes'){
            if(prddt.units.toLowerCase() == 'pounds') {
                trim_tax = trim_tax * 16;
            }
            cultivation_tax = parseFloat(trim_tax) * parseFloat(quantity);
            cultivation_tax_per = parseFloat(trim_tax);
        }
    } else {
         cultivation_tax = 0;
         cultivation_tax_per = 0;
    }

    // console.log(excise_tax);
    // total_amt = parseFloat(total_amt) + parseFloat(excise_tax)/* + parseFloat(cultivation_tax)*/;

// (typeof(obj.excise_markup_per) == 'undefined') ? 0 : obj.excise_markup_per,
// (typeof(obj.excise_markup_value) == 'undefined') ? 0 : obj.excise_markup_value,
// (typeof(obj.excise_tax_per) == 'undefined') ? 0 : obj.excise_tax_per,
// (typeof(obj.excise_tax) == 'undefined') ? 0 : obj.excise_tax,
// (typeof(obj.distribution_tax_per) == 'undefined') ? 0 : obj.distribution_tax_per,
// (typeof(obj.distribution_tax) == 'undefined') ? 0 : obj.distribution_tax,
// (typeof(obj.cultivation_tax) == 'undefined') ? 0 : obj.cultivation_tax,
// (typeof(obj.cultivation_tax_per) == 'undefined') ? 0 : obj.cultivation_tax_per,
    
    var consultant_fee_amount = parseFloat(consultant_fee / 100 * (quantity * buynowprice));

    // if (shipprice > 0) {
    //     local_pick = 1
    //     var amt = quantity * (buynowprice + shipprice) + stax_amt + res_amount;

    //     if (onlinepayment == 1) {
    //         paids = 1
    //     } else {
    //         paids = 2
    //     }
    // } else {
    //     var amt = quantity * (buynowprice + shipprice) + stax_amt + res_amount;
    //     local_pick = 0
    //     paids = 1
    // }

    var defered = q.defer();
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //console.log(datenow);
    var sold = quantity;
    var release = 1;
    var r_date = datenow;
    //commission = parseFloat((amt-req.session.products[d]['refund'])*(req.body.commission/100)).toFixed(2);
    // commission = (parseFloat(config.general.commission_fee) / 100 * amt).toFixed(2);

    // mysqli['yab22'] = 'insert into buynow (
    //user_id,project_id,qty,amount,commission,accept, date_added, 
    //total_amount, commission_per, stax_status, stax_per, stax_amt, 
    //recurring, rec_purchase_id, cancel_ins_status, cancel_ins_per, cancel_ins_amt) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

    var escape_data = [
        buyerid,
        proid,
        quantity,
        buynowprice,
        commission_price,
        '0',
        datenow,
        total_amt,
        commission_per,
        stax_status,
        stax_per,
        stax_amt,
        consultant_fee,
        consultant_fee_amount,
        cid,
        '1', //recurring or not == 1
        rp_id, // recurring purchase id
        rs_id,  // recurring schedule id
        (cancel_ins_status == 1) ? '1' : '0', //cancellation insurance status
        (cancel_ins_status == 1) ? cancel_ins_per : '0', // if cancellation insurance status ==1 then add insurance percentage entry
        cancel_ins_amt, // add insurance amount
        seller_id, // seller id as request_userid
        res_amount, // reserve amt for first recurring
        typeof(excise_markup_per) != 'undefined' ? excise_markup_per : 0,
        typeof(excise_markup_value) != 'undefined' ? excise_markup_value : 0,
        typeof(excise_tax_per) != 'undefined' ? excise_tax_per : 0,
        typeof(excise_tax) != 'undefined' ? excise_tax : 0,
        typeof(distribution_tax_per) != 'undefined' ? distribution_tax_per : 0,
        typeof(distribution_tax) != 'undefined' ? distribution_tax : 0,
        typeof(cultivation_tax) != 'undefined' ? cultivation_tax : 0,
        typeof(cultivation_tax_per) != 'undefined' ? cultivation_tax_per : 0,
        (cod!=undefined && cod==1 ? 1 : 0)
    ];
    console.log('cod', cod);

    // , cancel_ins_status, rp_id, cancel_ins_per, cancel_ins_amt

    console.log("----- escape data from --- insertBuynowCron ",escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Insert INTO bounow table ---- " + query.sql);

    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}
/* ===================== end change by divyesh (changes) ===================== */

exports.insertBuynow = function(req, mysql, q, d, cid, escrow) {

    try {
        $mysqli = {};
        //req.body.local_pick = (typeof(req.body.local_pick) == 'undefined') ? 0 : req.body.local_pick;

        req.body.local_pick = 1;
        strQuery = mysqli.mysqli($mysqli, 'cnx212');
        //console.log(req.session.products[d]);
        var defered = q.defer();
        var dateFormat = require('dateformat');
        var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
        //console.log(datenow);
        var sold = req.session.products[d]['saled'];
        var release = 1;
        var r_date = datenow;
        if (escrow == 0) {
            release = 0;
            r_date = '0000-00-00 00:00:00'
        }

        var amt = (req.session.products[d]['qty_add'] * parseFloat(req.session.products[d]['bprice']) + parseFloat(req.session.products[d]['shipping_price'])).toFixed(2);
        commission = parseFloat((amt - req.session.products[d]['refund']) * (req.body.commission / 100)).toFixed(2)

        var escape_data = [
        req.session.products[d]['id'], 
        req.session.userid, 
        amt, 
        datenow, 
        req.session.products[d]['qty_add'], 
        cid, sold, req.session.products[d]['refund'], 
        0, 
        1, 
        datenow, 
        release, 
        r_date, 
        escrow, 
        commission, 
        req.body.local_pick, 
        0
        ];

        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

        query.on('error', function(err) {
            console.log(err.stack);
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in Inset by now " + e);
    }

}
exports.removeitemInRec = function(req,res,mysql, recid) {
console.log("fffffffffffffffffgggggggggg ",recid)
    $mysqli = { };
    strQuery = mysqli.mysqli($mysqli, 'recidRemove');
    var defered = q.defer();
    var escape_data = [recid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("recidRemove "+query.sql)
    return defered.promise;

}
exports.removeitem = function(id, req, res, mysql) {

    req.body.id = id;
    var self = this;
    var cmn = require('./common');
    if (typeof(req.session.userid) === 'undefined') {
        var data = { success: false, error: '', redirect: true };
        cmn.renderJson(res, data);
    } else {
        q.all([products.cartitemDetail(req, mysql, q)]).then(function(results) {

            var prdt = results[0][0][0];
            // console.log(prdt);
            // console.log('pgfhgfhgfhgfhgfhrdt');
            prdt['qty'] = parseInt(prdt['qty']);
            //console.log(prdt['qty'] );

            var cart = require('./cart');

            if (typeof(req.session.products) !== 'undefined') {
                    // console.log('pid ----- ', req.session.pid);
                    // console.log('pid index in sission pid ====== ', req.session.pid.indexOf(prdt.project_id));
                       
                if (req.session.pid.indexOf(prdt.project_id) >= 0) {
                    var mn_req_id = req.session.pid.indexOf(prdt.project_id);
                     q.all([cart.removeTempItem(req,mysql,q,id,prdt.qty, prdt.r_id)]).then(function(results) {

                        delete req.session.pid[mn_req_id];
                        delete req.session.products[mn_req_id];
                      
                        // console.log('pid',req.session.pid);
                        // console.log('req.session.pid[mn_req_id]',req.session.pid[mn_req_id]);

                        req.session.pid = req.session.pid.filter(function(n) { return n != undefined });
                        req.session.products = req.session.products.filter(function(n) { return n != undefined });

                        if (req.session.pid.length == 0) {
                            delete req.session.temp_cart_id;
                            delete req.session.temp_time_id;
                            delete req.session.pid;
                            delete req.session.products;
                            delete req.session.timer;
                        }
                        var data = { success: true, error: '', add: 0 };
                        cmn.renderJson(res, data);

                     }).fail(function(err) {
                        console.log(err.stack);
                    })

                } else {
                    var data = { success: true, error: '', add: 0 };
                    cmn.renderJson(res, data);
                }
            }

        }).fail(function(err) {
            console.log(err.stack);

        })
    }

}

exports.addItem = function(id, req, res, mysql) {
    console.log(req.session);
    membership_status = true;
    req.body.id = id;
    var self = this;
    var cmn = require('./common');

    if (typeof(req.session.userid) === 'undefined') {
        var data = { success: false, error: '', redirect: true };
        cmn.renderJson(res, data);
    }
    if (typeof(req.session.userid) === 'undefined') {
        var data = { success: false, error: '', redirect: true };
        cmn.renderJson(res, data);
    }

    q.all([products.productDetail(req, mysql, q)]).then(function(results) {
        try {
            var prdt = products.shortDescribe(results[0][0]);
            prdt = prdt[0];
            //console.log(prdt);console.log("uiuiuiuiuiu");
            //prdt.qty_add = 1;
            var dateFormat = require('dateformat');
            // console.log("a1");
            var date = require('date-utils');
            // console.log("b1");
            // console.log(req.param('qty'));
            prdt['qty_add'] = (typeof(req.param('qty')) !== 'undefined') ? req.param('qty') : 1;
            // console.log("c1");
            // console.log(prdt['qty_add']);

            /* Update payment details here */
            var freq = prdt['frequency'];
            // console.log("-----------------prdt id -------------> : " + prdt['id']);

            var end = new Date(prdt['edate']);
            var start = new Date(prdt['sdate']);
            var duration = prdt['count'];

            var calfee = parseFloat(prdt['bprice']) * parseFloat(global.general.cancel_insurance_fee) / 100;
            // console.log("-------" + global.general.cancel_insurance_fee + "----------calfee-------------> : " + calfee);

            // console.log("-----------------prdt['qty_add']-------------> : " + prdt['qty_add']);

            var herbeefee = parseFloat(prdt['bprice']) * parseFloat(global.general.commission_fee) / 100;
            // console.log("--------" + global.general.commission_fee + "---------herbeefee-------------> : " + herbeefee);

            var stax = parseFloat(prdt['bprice']) * parseFloat(prdt['stax']) / 100;

            var consultant_fee_amount = parseFloat(prdt['consultant_fee_amount']);
            // console.log("--------" + prdt['stax'] + "---------tax-------------> : " + stax);

            /* calculating distribution tax percentage - will be deducted from seller side */
            var prdtTotalAmount = (parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add']));
            var distribution_tax = 0;
            var distribution_tax_per = 0;


            /*  && escape(prdt.default_distributor).toLowerCase() == 'y' */
            if(global.general.distribution_rate_status == 'yes'){
                distribution_tax_per = parseFloat(global.general.distribution_rate);
                distribution_tax = parseFloat(prdtTotalAmount) * parseFloat(global.general.distribution_rate)/100
                if(distribution_tax < parseFloat(global.general.distribution_default_rate)){
                    distribution_tax = parseFloat(global.general.distribution_default_rate)
                }
            } 


            /* Calculating excise tax */
            var excise_tax_markup = 0
            var excise_markup_per = 0
            var excise_tax = 0
            var excise_tax_per = 0


            /* calculating excise markup value and percentage */
/*  
    excise_tax_status == yes and If 
    default_distributor == 'y' and 
    buisness_type == 'dispensary' and
    product type is flower or edibles 
    then excise tax should be charge 
*/
console.log("-------------excise tax changes here----------------");
console.log(global.general.excise_tax_status)
console.log(escape(prdt.default_distributor).toLowerCase())
console.log(req.session.business_type)
console.log(escape(prdt.pc_name).toLowerCase())
console.log("-------------excise tax changes here----------------");
console.log("-------------Calculate excise tax ----------------",(global.general.excise_tax_status == 'yes' && escape(prdt.default_distributor).toLowerCase() == 'y' && req.session.buisness_type == 'dispensary' &&(escape(prdt.pc_name).toLowerCase() == 'flower' || escape(prdt.pc_name).toLowerCase() == 'edibles')));


            /* if(global.general.excise_tax_status == 'yes' && escape(prdt.default_distributor).toLowerCase() == 'y' && req.session.business_type == 'dispensary' &&(escape(prdt.pc_name).toLowerCase() == 'flower' || escape(prdt.pc_name).toLowerCase() == 'edibles')){
                excise_markup_per = parseFloat(global.general.excise_tax_markup);
                excise_tax_markup = parseFloat(parseFloat(prdtTotalAmount) * (parseFloat(global.general.excise_tax_markup)/100)).toFixed(2);
                excise_tax_per = parseFloat(global.general.excise_tax);
                excise_tax = parseFloat((parseFloat(prdtTotalAmount) + parseFloat(excise_tax_markup)) * (parseFloat(global.general.excise_tax)/100)).toFixed(2);
            } else {
                excise_markup_per = 0;
                excise_tax_markup = 0;
                excise_tax_per = 0;
                excise_tax = 0;
            } */

            if(global.general.excise_tax_status == 'yes' && req.session.business_type == 'dispensary'){
                excise_markup_per = parseFloat(global.general.excise_tax_markup);
                excise_tax_markup = parseFloat(parseFloat(prdtTotalAmount) * (parseFloat(global.general.excise_tax_markup)/100)).toFixed(2);
                excise_tax_per = parseFloat(global.general.excise_tax);
                excise_tax = parseFloat((parseFloat(prdtTotalAmount) + parseFloat(excise_tax_markup)) * (parseFloat(global.general.excise_tax)/100)).toFixed(2);
            } else {
                excise_markup_per = 0;
                excise_tax_markup = 0;
                excise_tax_per = 0;
                excise_tax = 0;
            }

            /* calculating cultivation tax */
            var cultivation_tax = 0
            var cultivation_tax_per = 0
            /* calculating cultivation tax percentage  - will be deducted from seller side */
            if(escape(prdt.cultivation_tax_status).toLowerCase() == 'n'){
                if(escape(prdt.pc_name).toLowerCase() == 'flower'){
                    if(global.general.cultivation_tax_status == 'yes'){
                        cultivation_tax = parseFloat(global.general.cultivation_tax) * parseFloat(prdt['qty_add']);
                        cultivation_tax_per = parseFloat(global.general.cultivation_tax);
                    }
                } else if(escape(prdt.pc_name).toLowerCase() == escape('Trim/Cannabis Leaves').toLowerCase()){
                    if(global.general.trim_tax_status == 'yes'){
                        cultivation_tax = parseFloat(global.general.trim_tax) * parseFloat(prdt['qty_add']);
                        cultivation_tax_per = parseFloat(global.general.trim_tax);
                    }
                }
            }

            // console.log("--------" + prdt['stax'] + "---------tax-------------> : " + stax);
            var totalAmount = (parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add'])) 
                            + (parseFloat(prdt['qty_add']) * parseFloat(herbeefee)) 
                            // + (parseFloat(prdt['qty_add']) * parseFloat(stax)) 
                            // + (parseFloat(prdt['qty_add']) * parseFloat(consultant_fee_amount)) 
                            + parseFloat(excise_tax);
            
            // console.log("---" + (parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add'])) + "-----" + (parseFloat(prdt['qty_add']) * herbeefee) + "-----" + (parseFloat(prdt['qty_add']) * stax) + "----totalAmount-------------> : " + totalAmount);
            if (prdt.rec_cancel_ins == 1) {
                totalAmount = totalAmount + (parseFloat(prdt['qty_add']) * calfee);
            }

            if (typeof(req.param('recupur')) !== 'undefined') {

                prdt.rec_purchase = req.param('recupur');
                prdt.rec_cancel_ins = req.param('insurance');
                prdt.rec_frequency = req.param('frequency');
                prdt.rec_count = req.param('edate');
                prdt.rec_purchase_id = req.body.rec_id;

                if (prdt.rec_cancel_ins == 1) {
                    prdt.rec_reserve_price = 0;
                    // prdt.rec_reserve_price = ((((parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add'])) * parseFloat(prdt.rec_count))) / 2);
                    // totalAmount = totalAmount + (parseFloat(prdt['qty_add']) * calfee);
                } else {
                    // prdt.rec_reserve_price = ((((parseFloat(prdt['bprice']) * parseFloat(prdt['qty_add'])) * parseFloat(prdt.rec_count))));
                    prdt.rec_reserve_price = 0;
                }

                /* (15 * 2 * 2 ) -  */
                totalAmount = parseFloat(totalAmount) + parseFloat(prdt.rec_reserve_price);
                prdt.rec_start_date = req.body.rec_start_date;
                prdt.rec_end_date = req.body.rec_end_date;
                prdt.rec_user_id = req.body.rec_user_id;
                prdt.rec_date_added = req.body.rec_date_added;
                prdt.rec_paid = req.body.rec_paid;
                prdt.rec_active = req.body.rec_active;

            }

            var cart = require('./cart');

            console.log('totalAmount', totalAmount);
            prdt['prdt_stax'] = stax;
            prdt['prdt_total_amount'] = totalAmount;
            prdt['prdt_total_amountr'] = prdtTotalAmount;
            prdt['prdt_herbee_fee'] = herbeefee;
            prdt['pdt_cancel_fee'] = calfee;
            console.log('prdt', prdt);

            prdt['distribution_tax'] = distribution_tax;
            prdt['distribution_tax_per'] = distribution_tax_per;

            prdt['excise_tax_markup'] = excise_tax_markup;
            prdt['excise_markup_per'] = excise_markup_per;
            prdt['excise_tax'] = excise_tax;
            prdt['excise_tax_per'] = excise_tax_per;

            prdt['cultivation_tax'] = cultivation_tax;
            prdt['cultivation_tax_per'] = cultivation_tax_per;
            /* End */

            prdt['qty'] = parseInt(prdt['qty']);
            prdt['booked'] = parseInt(prdt['booked']);
            prdt['sold'] = parseInt(prdt['sold']);
            prdt['qty_add'] = parseInt(prdt['qty_add']);

            prdt['shipping_price'] = common.currencyConverter(prdt['shipping_price']);
            prdt['bprice'] = common.currencyConverter(prdt['bprice']);
            // console.log("d1");
            var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

            // console.log("e1");
            // console.log(cart);
            var closeddate = dateFormat(new Date(prdt['date_closed']), "yyyy-mm-dd HH:MM:ss");
            var k_l = false;
            // console.log("f1");
            if (typeof(req.session.pid) !== 'undefined') {

                if (req.session.pid.indexOf(prdt.id) >= 0) {
                    var k_l = true;
                }
            }
            // console.log("g1");
            //prdt['m_qty_add'] = prdt['qty_add'];
            if (typeof(req.session.pid) !== 'undefined') {
                if (req.session.pid.indexOf(prdt.id) >= 0) {

                    prdt['booked'] = prdt['booked'] - parseInt(req.session.products[req.session.pid.indexOf(prdt.id)]['qty_add']);

                }
            }
            // console.log("h1");
            if (prdt['market_status'] == 'closed') {
                var data = { success: false, error: 'Project Ended!' };
                cmn.renderJson(res, data);
            }

            if ((Date.compare(closeddate, datenow) <= 0 ) && prdt['market_status'] == 'open' && !k_l) {
                var data = {success: false, error: 'Project Ended!'};
                cmn.renderJson(res, data);
            }
            else if (prdt['qty'] - prdt['sold'] - prdt['booked'] <= 0 && !k_l) {
                var data = {success: false, error: 'Project Sold!'};
                cmn.renderJson(res, data);
            }
            else if (prdt['qty'] - prdt['sold'] - prdt['booked'] - prdt['qty_add'] < 0 && !k_l) {
                var data = {
                    success: false,
                    error: parseInt(prdt['qty'] - prdt['sold'] - prdt['booked']) + ' Only Available !'
                };
                cmn.renderJson(res, data);
            }
            else {
                // console.log("i1");
                req.session.buynowcountyear = parseInt(req.session.buynowcountyear) + parseInt(prdt['qty_add']);
                req.session.buynowcountmonth = parseInt(req.session.buynowcountmonth) + parseInt(prdt['qty_add']);
                //membership_status =  common.checkLimitReached('monthly_buynow_limit',req);
                membership_status = true;
                // console.log("k1");
                if (membership_status) {
                    // console.log("l1");
                    if (typeof(req.session.pid) !== 'undefined') {
                        // console.log("m1");
                        if (req.session.pid.indexOf(prdt.id) >= 0) {
                            var mn_req_id = req.session.pid.indexOf(prdt.id);

                             cart.removeTempItem(req, mysql, q, id, req.session.products[mn_req_id]['qty_add']);
                             delete req.session.pid[mn_req_id];
                             delete req.session.products[mn_req_id];

                             req.session.pid = req.session.pid.filter(function (n) {
                                 return n != undefined
                             });
                             req.session.products = req.session.products.filter(function (n) {
                                 return n != undefined
                             });
                            // console.log(prdt);
                            // console.log("*********FFFFFFFFFFFFF***************");
                            // console.log(req.session);


                             if (req.session.pid.length == 0) {
                                 delete req.session.temp_cart_id;
                                 delete req.session.temp_time_id;
                                 delete req.session.pid;
                                 delete req.session.products;
                                 delete req.session.timer;
                                 req.session.pid = [];
                                 req.session.products = [];
                             }

                            cart.addTempItem(req, mysql, q, id, prdt['qty_add'], prdt);
                            req.session.pid.push(prdt.id);
                            req.session.products.push(prdt);

                        } else {
                            cart.addTempItem(req, mysql, q, id, prdt['qty_add'], prdt);
                            req.session.pid.push(prdt.id);
                            req.session.products.push(prdt);
                        }

                    } else {
                        // console.log("tyyyyyyyyyyyyyyyyyelseigyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
                        // console.log(req.body);
                        // console.log("n1");
                        //req.session.temp_cart_id = Date.parse(new Date()) / 1000;
                        req.session.temp_cart_id = req.session.ntemp_cart_id;
                        //console.log(req.session);
                        var dateFormat = require('dateformat');
                        req.session.temp_time_id = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
                        cart.addTempItem(req, mysql, q, id, prdt['qty_add'], prdt);
                        req.session.pid = [];
                        req.session.products = [];
                        req.session.pid.push(prdt.id);
                        req.session.products.push(prdt);
                    }
                } else {
                    console.log("o1");
                    req.session.buynowcountyear = parseInt(req.session.buynowcountyear) - parseInt(prdt['qty_add']);
                    req.session.buynowcountmonth = parseInt(req.session.buynowcountmonth) - parseInt(prdt['qty_add']);
                }

                var data = { success: true, error: '', add: 1, membership_status: membership_status };
                cmn.renderJson(res, data);

            }
        } catch (e) {
            console.log("Add or removing cart error " + e.stack);
        }

    }).fail(function(error) {
        console.log(error.stack);
        throw error;
    }).done();

}

exports.addrecurring = function(req, res, mysql) {

    console.log("exports.addrecurring : " + req.body.cancellation_per);

    var cmn = require('./common');
    var dateMath = require('date-arithmetic');

    /* months week and year management here using 'weekly'-1,'biweekly'-2,'monthly'-1,'quaterly'-3,'bianually'-6,'anually'-12*/
    var obj = cmn.validateDates(req.param('frequency'));

    var start_date = new Date(req.param('sdate'));
    console.log(start_date);
    var end_date = dateMath.add(new Date(start_date), ((parseInt(req.param('edate')) * parseInt(obj.count)) - 1), obj.str);
    console.log(end_date);

    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    if (typeof(req.session.userid) === 'undefined') {
        var data = { success: false, error: '', redirect: true };
        cmn.renderJson(res, data);
    }
    if (typeof(req.session.userid) === 'undefined') {
        var data = { success: false, error: '', redirect: true };
        cmn.renderJson(res, data);
    }


    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'addrecurre');

    var defered = q.defer();

    var escape_data = [
        req.session.userid,
        req.param('project_id'),
        datenow,
        req.param('frequency'), //frequencies
        req.param('rqty'),
        dateFormat(start_date, "yyyy-mm-dd HH:MM:ss"),
        req.param('edate'), //count
        dateFormat(end_date, "yyyy-mm-dd HH:MM:ss"),
        req.param('insurance'),
        req.session.ntemp_cart_id,
        req.body.cancellation_per
    ];

    // console.log("addrecurring6");
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;

}

function getrec(id, res, mysql) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'get_rec_byid');

    var defered = q.defer();

    var escape_data = [
        id
    ];

    // console.log("addrecurring6");
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}

exports.getrecurring = function(id, res, mysql) {


    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'get_rec_byid');

    var defered = q.defer();

    var escape_data = [
        id
    ];

    // console.log("addrecurring6");
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}


// exports.addContacts = function(mysql, req, res, uid) {

//     console.log(req.body.contacts);
//     var contacts = req.body.contacts;
//     datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

//     var contactsString = "";
//     for (var i = 0; i < contacts.length; i++) {
//         // contacts[i].user_id = uid;

//         if (i > 0) {
//             contactsString = contactsString + ", (\"" + contacts[i].fname + "\", \"" + contacts[i].lname + "\", \"" + contacts[i].phone + "\", \"" + contacts[i].email + "\", \"" + datge + "\", 0, \"" + uid + "\" )";
//         } else {
//             contactsString = contactsString + "(\"" + contacts[i].fname + "\", \"" + contacts[i].lname + "\", \"" + contacts[i].phone + "\", \"" + contacts[i].email + "\", \"" + datge + "\", 0, \"" + uid + "\" )";
//         }

//     }

//     $mysqli = {
//         contactsData: contactsString
//     };

//     strQuery = mysqli.mysqli($mysqli, "add_contacts");

//     var defered = q.defer();
//     query = mysql.query(strQuery, defered.makeNodeResolver());
//     console.log(query.sql);
//     query.on('error', function(err) {
//         throw err;
//     });

//     return defered.promise;
// }


exports.updateRPAmount = function(req, mysql, rpAmount, rpId) {

    console.log(q_str);

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'update_rec_amount');

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })

    return defered.promise;

}

exports.addRecurringSchedules = function(req, res, mysql, data) {

    console.log("----------------------addRecurringSchedules------------" + JSON.stringify(data));

    // var start_date = new Date(req.param('sdate'));
    // var end_date = dateMath.add(new Date(start_date), req.param('edate') * obj.count, obj.str);

    // var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    // if (typeof(req.session.userid) === 'undefined') {
    //     var data = { success: false, error: '', redirect: true };
    //     cmn.renderJson(res, data);
    // }
    // if (typeof(req.session.userid) === 'undefined') {
    //     var data = { success: false, error: '', redirect: true };
    //     cmn.renderJson(res, data);
    // }
    /*mysqli['insert_rec_schedule'] = 'insert into recurring_schedule (
    amount, recur_purchase_id, user_id, seller_id, qty, product_id, product_title, created_at) values {{rec_data}}';*/

    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    var q_str = '';

    for (var i = 0; i < data.mid_date.length; i++) {
        console.log('data.position cart ', data.position);
        q_str = q_str + '(' +
            data.product.bprice + ', ' +
            data.rec_purchase_id + ', ' +
            data.user_id + ', ' +
            data.seller_id + ', ' +
            data.qty + ', ' +
            data.product.id + ', "' +
            data.product.title + '", "' +
            dateFormat(new Date(data.mid_date[i]), "yyyy-mm-dd HH:MM:ss") + '", "' +
            datenow + '", "' +
            data.position[i] + '")';

        if ((data.mid_date.length > 1) && (i < data.mid_date.length - 1)) {
            q_str = q_str + ', '
        }
    }

    console.log(q_str);

    $mysqli = {
        rec_data: q_str
    };

    strQuery = mysqli.mysqli($mysqli, 'insert_rec_schedule');

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })

    return defered.promise;

}


exports.upDateItemBooked = function(req, mysql, q, id, qty, nqty) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer6');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [nqty, req.session.temp_cart_id, id, req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer3');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [qty, id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    strQuery = mysqli.mysqli($mysqli, 'timer2');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [nqty, id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}
exports.removeBookedQty = function(req, mysql, q, id, qty) {
  
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer3');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [qty, id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    
    return defered.promise;
}
exports.removeTempItem = function(req, mysql, q, id, qty, r_id) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer4');
    req.session.buynowcountyear = parseInt(req.session.buynowcountyear) - parseFloat(qty);
    req.session.buynowcountmonth = parseInt(req.session.buynowcountmonth) - parseFloat(qty);


    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [r_id, id, req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })

    
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer3');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [qty, id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })
    return defered.promise;
}
exports.addTempItem = function(req, mysql, q, id, qty, prdt) {
    $mysqli = {};
    console.log('qty', qty);

    strQuery = mysqli.mysqli($mysqli, 'timer1');
    console.log(2);
    var defered = q.defer();
    //var date = require('date-utils');
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [id, datenow, req.session.temp_cart_id, qty, 0, 0, req.session.userid, JSON.stringify(prdt)];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("f4f4f4f4f");
    console.log(query.sql);
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'timer2');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [qty, id];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })
    return defered.promise;
}
exports.updateCartRefund = function(req, mysql, q, amt, id, cid) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx217');

    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [amt, id, cid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.insertCartDetails = function(req, mysql, q, d, price) {
    try {
        $mysqli = {};

        strQuery = mysqli.mysqli($mysqli, 'cnx211');

        var delivery_instruction = req.param('delivery_instruction');
        if(req.param('delivery_instruction') == undefined) {
            delivery_instruction = '';
        }

        var defered = q.defer();
        var dateFormat = require('dateformat');
        //var date = require('date-utils');
        var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
        var escape_data = [datenow, req.param('f_name'), req.param('l_name'), req.param('email'), req.param('phone'), req.param('address'), delivery_instruction, req.param('country'), req.param('state'), req.param('city'), req.param('zipcode'), req.session.userid, datenow, 1, d, price];


        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        query.on('error', function(err) {
            console.log(error.stack);
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in insert cart details" + e.stack);
    }

}

exports.insertCartDetailsRec = function(req, mysql, q, d, price, buyerDetails) {
    try {
        $mysqli = {};

        strQuery = mysqli.mysqli($mysqli, 'cnx211');
        console.log('buyerDetails.cod', buyerDetails.cod);

        var defered = q.defer();
        var dateFormat = require('dateformat');
        //var date = require('date-utils');
        var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
        var escape_data = [
            datenow, 
            typeof(buyerDetails.first_name) !=='undefined' ? buyerDetails.first_name : '',
            typeof(buyerDetails.last_name) !=='undefined' ? buyerDetails.last_name : '',
            typeof(buyerDetails.email) !=='undefined' ? buyerDetails.email : '',
            typeof(buyerDetails.phone) !=='undefined' ? buyerDetails.phone : '',
            typeof(buyerDetails.address1) !=='undefined' ? buyerDetails.address1 : '',
            typeof(buyerDetails.delivery_instruction) !=='undefined' ? buyerDetails.delivery_instruction : '',
            typeof(buyerDetails.country) !=='undefined' ? buyerDetails.country : '',
            typeof(buyerDetails.state) !=='undefined' ? buyerDetails.state : '',
            typeof(buyerDetails.city) !=='undefined' ? buyerDetails.city : '',
            typeof(buyerDetails.zip) !=='undefined' ? buyerDetails.zip : '',
            buyerDetails.id, 
            datenow, 
            (buyerDetails.cod!=undefined && buyerDetails.cod==1 ? 0 : 1), 
            d, 
            price
        ];

        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

        query.on('error', function(err) {
            console.log(error.stack);
            throw err;
        })

        return defered.promise;

    } catch (e) {
        console.log("Error in insert cart details" + e.stack);
    }

}

exports.insertCartDetailslocal = function(req, mysql, q, d, price) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx211');
    var delivery_instruction = req.param('delivery_instruction');
    if(req.param('delivery_instruction') == undefined) {
        delivery_instruction = '';
    }

    var defered = q.defer();
    var dateFormat = require('dateformat');
    //var date = require('date-utils');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [datenow, req.param('f_name'), req.param('l_name'), req.param('email'), req.param('phone'), req.param('address'), delivery_instruction, req.param('country'), req.param('state'), req.param('city'), req.param('zipcode'), req.session.userid, datenow, 2, d, price];
    console.log("******************************* " + escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}



exports.insertBuynowlocal = function(req, mysql, q, d, cid, escrow) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx212');
    //console.log(req.session.products[d]);

    local_pick = 1;
    paids = 2;
    var defered = q.defer();
    var dateFormat = require('dateformat');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //console.log(datenow);
    var sold = req.session.products[d]['saled'];
    var release = 1;
    var r_date = datenow;
    if (escrow == 0) {
        release = 0;
        r_date = '0000-00-00 00:00:00'
    }

    var amt = (req.session.products[d]['qty_add'] * parseFloat(req.session.products[d]['bprice']) + parseFloat(req.session.products[d]['shipping_price'])).toFixed(2);
    /*var amt = req.session.products[d]['qty_add']*(req.session.products[d]['bprice']+req.session.products[d]['shipping_price']);*/
    //commission = parseFloat((amt-req.session.products[d]['refund'])*(req.body.commission/100)).toFixed(2);
    commission = 0;
    var escape_data = [req.session.products[d]['id'], req.session.userid, amt, datenow, req.session.products[d]['qty_add'], cid, sold, req.session.products[d]['refund'], 0, paids, datenow, release, r_date, escrow, commission, local_pick];


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    query.on('error', function(err) {
        throw err;
        console.log(err.stack);
    })
    return defered.promise;

}




exports.productDetailItems = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'timer5');
    //console.log(strQuery);
    var defered = q.defer();
    //var escape_data = [req.body.sid];
    var escape_data = [req.session.pid];
    //  console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;
}
exports.getrecurringDetails = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'recurringdetailsnew');
    //console.log(strQuery);
    var defered = q.defer();
    //var escape_data = [req.body.sid];
    var escape_data = [req.session.userid, req.session.pid];
    //  console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.updateItem = function(req, mysql, q) {

    for (i in req.session.products) {

        req.session.products[i]['qty_add'] = req.body['pid[' + req.session.products[i]['id'] + ']'];
    }
}
exports.InsertItemInCart = function(req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 53);

    var defered = q.defer();

    var escape_data = [req.param('id'), req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.updateCartDetails = function(req, mysql, q, cart_id, trans_id) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'update_cart_details');
    //console.log(strQuery);

    var defered = q.defer();
    var dateFormat = require('dateformat');
    //var date = require('date-utils');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var paid = (req.session.cod!=undefined && req.session.cod==1) ? 0 : 1;
    var escape_data = [paid, datenow, trans_id, cart_id];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("Update checkout is " + query.sql);
    query.on('error', function(err) {

        throw err;
    });
    return defered.promise;

}

exports.updateBuynowCartId = function(req, mysql, q, checkoutId) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'update_buynow_checkout');

    var defered = q.defer();
    var escape_data = [
        checkoutId,
        req.body.id,
    ];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;

}

exports.insertbuynowCartDetails = function(req, mysql, q, d, price) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'cnx211');
    var delivery_instruction = req.param('delivery_instruction');
    if(req.param('delivery_instruction') == undefined) {
        delivery_instruction = '';
    }

    var defered = q.defer();
    var dateFormat = require('dateformat');
    //var date = require('date-utils');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [
        datenow,
        req.param('f_name'),
        req.param('l_name'),
        req.param('email'),
        req.param('phone'),
        req.param('address'),
        delivery_instruction,
        req.param('country'),
        req.param('state'),
        req.param('city'),
        req.param('zipcode'),
        req.session.userid,
        datenow,
        0,
        d,
        price
    ];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;

}


exports.cartproductdetails = function(req, mysql, q, id, details) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'yab6');

    var defered = q.defer();

    var escape_data = [details, id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
}

exports.updateReservePrice = function(mysql, q, id, reservePrice, totalAmount) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'update_reserve_price');

    var defered = q.defer();

    var escape_data = [reservePrice, totalAmount, id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}

exports.recurUpdateCheckoutID = function(mysql, q, id, checkoutId) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'rp_update_chkid');

    var defered = q.defer();

    var escape_data = [id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}

exports.getprouserdetails = function(req, mysql, q, proid) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'yab19');
    //console.log(strQuery);
    var defered = q.defer();
    var escape_data = [proid];
    //console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("getprouserdetails " + query.sql);
    return defered.promise;
}

exports.deleteshipbuynow = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'yab3');
    var defered = q.defer();
    var escape_data = [req.param('buynowid')];
    console.log(escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        console.log(err.stack);
    });
    return defered.promise;

}

exports.insertshipbuynow = function(req, mysql, q) {

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'yab2');
    var defered = q.defer();
    var dateFormat = require('dateformat');
    //var date = require('date-utils');
    var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [datenow, req.param('f_name'), req.param('l_name'), req.param('phone'), req.param('email'), req.param('address'), req.param('country'), req.param('state'), req.param('city'), req.param('zipcode'), req.session.userid, req.param('buynowid'), req.param('pay_amount')];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;

}
exports.removeTempCartByUser = function(req, mysql, q) {
    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'delete_temp_cart_by_user');
    
    var defered = q.defer();
    //var date = require('date-utils');
    var escape_data = [req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(error) {
        throw error;
    })
    return defered.promise;
}
exports.payment_received = function(req,res,mysql, buynow_id) {
    var dateFormat = require('dateformat');
    var paid_date = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = { };
    var defered = q.defer();
    var escape_data = [paid_date, buynow_id];

    strQuery = mysqli.mysqli($mysqli, 'paid_buynow');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("paid_buynow "+query.sql);

    strQuery = mysqli.mysqli($mysqli, 'paid_invoice');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("paid_invoice "+query.sql);

    strQuery = mysqli.mysqli($mysqli, 'paid_checkout');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("paid_checkout "+query.sql);
    
    var escape_data = [buynow_id];
    strQuery = mysqli.mysqli($mysqli, 'paid_recurring_schedule');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("paid_checkout "+query.sql);

    query.on('error', function(error) {
        throw error;
    })
    return defered.promise;

}
exports.updateCodOnRecurringPurchase = function(req, mysql, q) {
    var dateFormat = require('dateformat');
    var paid_date = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    $mysqli = { };
    var defered = q.defer();
    var escape_data = [req.body.cod, req.body.rec_purchase_id];

    strQuery = mysqli.mysqli($mysqli, 'updateCodOnRecurringPurchase');
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("paid_checkout "+query.sql);
    
    query.on('error', function(error) {
        throw error;
    })
    return defered.promise;

}