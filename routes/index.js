// #### load required Modules ##################################################

var express = require('express');
var reload = require('reload');
var sprintf = require('sprintf').sprintf;
var common = require('../module/common');
var register = require('../module/register');

var openBidProducts = require('../module/openbidproducts');
var async = require('async');
var app = express.Router();
var q = require('q');
var request = require('request');
var dateFormat = require('dateformat');
var cronJob = require('cron');
var faAPI = require('../module/forwardauction_api');
var stores = require('../module/stores');
var Template = require('../module/templates');
var _ = require('underscore')
var products = require('../module/products');

/* testing smple code logics here */

// var ab = "-123"
// console.log(ab);
// console.log(Math.abs(ab));


// var a1 = [{a:1,b:6},{a:2}];
// var a2 = [{a:1},{a:2, b:4}];
// var a3 = a1.concat(a2);
// console.log(a3);

//         var today = new Date();
//         today.setHours(today.getHours() + 72);

//         console.log(today);
//         console.log(dateFormat(today, 'yyyy-mm-dd HH:MM:ss'));

// console.log('urls', $arr.last_urls);
// var dateFormat = require('dateformat');
// console.log(dateFormat(new Date().setDate(new Date().getDate()-30),"yyyy-mm-dd HH:MM:ss"));
// console.log(new Date().setDate(new Date().getDate() - 30));
// var date1 = new Date("2010-12-20");
// var date2 = new Date("2010-12-25");
// var timeDiff = Math.abs(date2.getTime() - date1.getTime());
// var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
// console.log(diffDays);


// console.log(parseFloat(-25.48555));
// console.log(parseFloat(-25.48555) + parseFloat(10));

// 20.31378
// var f1 = 10.45689;
// var f2 = '10.689';
// var f3 = (f1 + parseFloat(f2));
// console.log((f3));
// console.log(common.changeDateFormat('12/02/2017'));

// %d/%m/%Y

// var d = '2017-09-20 12:16:00';
// var f = '20/09/2017';
// console.log(new Date(d));
// console.log(new Date(f));

// console.log(process.env.TZ);
// console.log(global.url + '/product/recurring/pay');

/* unverified recurring cronjob here */

/* Recuring execution cronjob here */

//
/*
Need to call the funcrions only without requests
*/

/* resetting advertisements */
var CronJob = cronJob.CronJob;
var job = new CronJob({
    cronTime: '00 00 23 * * *',
    onTick: function () {
        var adwords = require('../module/adwords');
        q.all(adwords.resetAdwordsDaysClick($arr.config.mysql, q)).then(function () {
            delete adwords;
        });
    },
    start: false
});

job.start();


setInterval(function(){
    var dateFormat = require('dateformat');
    io.sockets.emit('sliservertime', { dTime :  dateFormat(new Date(), "yyyy/mm/dd HH:MM:ss")} );
},1000);


var mem_cron = new CronJob({
    cronTime: '00 00 23 * * *',
    onTick: function () {
        var products = require('../module/products');
        q.all([products.getMemRenewalDate($arr.config.mysql, q, '', 1)]).then(function (results) {
            if (results[0][0].length > 0) {
                async.each(results[0][0], DeductAmt, function (err) {
                    if (err)
                        throw err
                    else
                        console.log("success")
                });
            }
        });
        var DeductAmt = function (del, cb) {
            var dateFormat = require('dateformat');
            var date = require('date-utils');
            var faAPI = require('../module/forwardauction_api');
            payments = require('../module/payment');
            var StartDateTime = dateFormat(new Date(del.deduct_date), "yyyy-mm-dd HH:MM:ss");
            var datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
            del.nextRenewalDate = dateFormat(del.nextdeductdate, "yyyy-mm-dd HH:MM:ss");
            if (Date.compare(StartDateTime, datenow) <= 0) {
                var req = { body: {} };
                try {
                    faAPI.userInfo(req, del.user_id, function (err, resp) {
                        var buyer = resp.user;
                        if (parseFloat(buyer.balance) >= parseFloat(del.amount)) {
                            req.body.buyer = {
                                balance: parseFloat(buyer.balance) - parseFloat(del.amount),
                                id: del.user_id
                            }
                            faAPI.updateUser(req, 'bought_product', function (err, resp) {
                                payments.sessionsdata = [];
                                payments.gateway = 'account';
                                payments.buyer = buyer;
                                payments.sessionsdata.email = buyer.email;
                                payments.sessionsdata.first_name = buyer.first_name;
                                payments.sessionsdata.last_name = buyer.last_name;
                                payments.temtype = 1;
                                payments.type = 'membership';
                                payments.amount = del.amount;
                                payments.payid = del.plan_id;
                                payments.buynow_id = 0;
                                payments.cart_id = 0;
                                payments.name = "Membership Amount";
                                q.all([products.getMemRenewalDate($arr.config.mysql, q, del, 2), payments.insertInvoice(req)]).then(function (results) {
                                    cb(null);
                                }).fail(function (err) {
                                    console.log(err.stack);
                                    throw err;
                                }).done();
                            });
                        } else {
                            console.log("low balance------------------" + del.user_id);
                            cb(null);
                        }
                    });
                } catch (e) {
                    cb(null);
                    console.log(e.stackTrace);
                }
            }
        }

    },
    start: false
});

mem_cron.start();



// var demoCron = cronJob.job('* */5 * * * *', function() {
//     console.log("demo ---- "+new Date());
// });
// demoCron.start();

// var demoCron2 = cronJob.job('* * */2 * * *', function() {
//     console.log(new Date());
// });
// demoCron2.start();

var clearCart = cronJob.job('00 * * * * *', function () {
    try {
        request({
            "rejectUnauthorized": false,
            "url": config.url + '/product/cart/clear',
            "method": "GET"
        }, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                // console.log('cart clear executed');
            } else {
                // console.log('no data in cart');
            }
        });
    } catch (e) {
        console.log(e);
    }
});

var recurringJobs = cronJob.job('1 * * * * *', function () {
    console.log('recurringJobs');
    try {
        request({
            "rejectUnauthorized": false,
            "url": config.url + '/product/recurring/pay',
            "method": "GET"
        }, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                // console.log('Recurrings executed...!');
            } else {
                // console.log('No more recurrings found...!');
            }
        });
    } catch (e) {
        console.log(e.stack);
    }
});

var checkBal = cronJob.job('00 00 23 * * *', function () {
    // var checkBal = cronJob.job('*/40 * * * * *', function() {
    try {
        request({
            "rejectUnauthorized": false,
            "url": config.url + '/check/balance',
            "method": "GET"
        }, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                console.log('Balance checking cron executed');
            } else {
                console.log('Checking for balance');
            }
        });
    } catch (e) {
        console.log(e);
    }
});

var checkRecBal = cronJob.job('00 00 23 * * *', function () {
    // var checkRecBal = cronJob.job('*/40 * * * * *', function() {
    try {
        request({
            "rejectUnauthorized": false,
            "url": config.url + '/check/recbalance',
            "method": "GET"
        }, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                console.log('Recurring balance checking cron executed...!');
            } else {
                console.log('Checking recurring balance');
            }
        });
    } catch (e) {
        console.log(e);
    }
});


//var checkMembership = cronJob.job('00 00 23 * * *', function() {
var checkMembership = cronJob.job('00 00 23 * * *', function () {
    // var checkMembership = cronJob.job('*/40 * * * * *', function() {
    try {
        request({
            "rejectUnauthorized": false,
            "url": config.url + '/check/membership',
            "method": "GET"
        }, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                console.log('Membership expiration executed...!');
            } else {
                console.log('No expired memberships...!');
            }
        });
    } catch (e) {
        console.log(e);
    }
});


var refundAdsAmount = cronJob.job('00 */10 * * * *', function () {
    // var refundAdsAmount = cronJob.job('00 00 23 * * *', function() {
    // var checkMembership = cronJob.job('*/40 * * * * *', function() {
    try {
        var adwords = require('../module/adwords');
        /* Getting expired adwords */
        q.all([
            adwords.getExpiredAdwords(config.mysql, q)
        ]).then(function (results) {

            if (results[0][0].length > 0) {

                // console.log(JSON.stringify(results));
                async.forEachSeries(results[0][0], function (ads, next) {
                    // ads_refund
                    // console.log(JSON.stringify(ads))

                    var req = { body: {} };
                    req.body.buyer = {
                        balance: parseFloat(ads.refund_amt).toFixed(2),
                        id: ads.user_id
                    }

                    payments = require('../module/payment');

                    // payments = require('../module/payment');
                    payments.transactionid = 0;
                    payments.gateway = 'account';
                    payments.sessionsdata = [];
                    payments.sessionsdata.title = 'ads';
                    payments.sessionsdata.email = ads.u_email;
                    payments.sessionsdata.url = $arr.config.url + '/stores/current_campaigns/'
                    payments.sessionsdata.userid = ads.user_id;
                    payments.sessionsdata.first_name = ads.u_first_name;
                    payments.sessionsdata.last_name = ads.u_last_name;
                    req.body.commission = 0;
                    payments.payid = ads.id;
                    payments.type = 'refund_ad_payment';
                    payments.name = 'ads';
                    payments.buynow_id = '0';
                    payments.cart_id = '0';
                    payments.amount = ads.refund_amt;
                    payments.buyer = { id: ads.user_id };
                    payments.seller = { id: '1' };
                    payments.qty = 0;

                    global.mysql.beginTransaction(function (err) {
                        if (err) {
                            console.log(err.stack);
                            global.mysql.rollback(function () {
                                console.log('------Transaction rollback 1------');
                                console.log(err.stack);
                                // res.send("updateTransaction3 rollback");
                                // throw err;
                            })
                        }

                        // console.log(JSON.stringify(resp));
                        q.all([payments.insertInvoice(req)]).then(function (invoice) {
                            console.log('invoice id' + invoice[0])
                            console.log('invoice id' + invoice[0].insertId)
                            console.log('invoice id' + invoice[0][0])
                            console.log('invoice id' + invoice[0][0].insertId)

                            q.all([
                                products.generateInvoiceID(req, invoice[0][0].insertId, config.mysql, q),
                                adwords.changeAdRefundStatus(ads.user_id, ads.id, invoice[0][0].insertId, config.mysql, q)
                            ]).then(function (invoices) {
                                faAPI.updateUser2(req, 'refund_ad_payment', function (err, resp) {
                                    if (err) {
                                        console.log(err)
                                        global.mysql.rollback(function () {
                                            console.log('------Transaction rollback 2------');
                                            console.log(err.stack);
                                            // res.send("updateTransaction3 rollback");
                                            // throw err;
                                        })
                                    } else if (resp.response.code == "D200") {

                                        global.mysql.commit(function (err) {
                                            if (err) {
                                                global.mysql.rollback(function () {
                                                    console.log('------Transaction rollback 3------');
                                                    console.log(err.stack);
                                                    // callback(null, { success: false, message: 'commit' });
                                                });
                                            } else {
                                                console.log('------transaction successfully commited------');
                                                delete adwords;
                                                next(null);
                                            }
                                        })

                                        console.log("update user" + resp)
                                    }

                                });
                                console.log('invoices', invoices);

                            }).fail(function (err) {
                                global.mysql.rollback(function () {
                                    console.log('------Transaction rollback 4------');
                                    console.log(err.stack);
                                    // res.send("updateTransaction3 rollback");
                                    // throw err;
                                })
                                console.log(err.stack);
                                // throw err;
                            }).done();
                        }).fail(function (err) {

                            global.mysql.rollback(function () {
                                console.log('------Transaction rollback 5------');
                                console.log(err.stack);
                                // res.send("updateTransaction3 rollback");
                                // throw err;
                            })

                            console.log(err.stack);
                            // throw err;
                        }).done();
                    })
                    // q.all(adwords.changeAdRefundStatus(ads.user_id, ads.id, 1212, config.mysql, q)).then(function(refundStatus) {
                    //     console.log('adwords refund status updated----->', refundStatus);
                    //     
                    // }).fail(function(err) {
                    //     //console.log(err.stack);
                    //     throw err;
                    // })    


                    // next()
                }, function (err) {
                    console.log('------------------ads refund -- successfull cron----------------');
                    // res.end();
                    return true;
                })
            } else {
                console.log("No any expired ads");
            }

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        });

    } catch (e) {
        console.log(e);
    }
});



/* execution point of cron jobs */
//Refunding remaining ads amount after ads has been removed
refundAdsAmount.start();
//to clear booked quantity
clearCart.start();
//to execute scheduled recurring jobs
recurringJobs.start();
//to check acc balance
checkBal.start();
//to check acc balance for recurring and sending the mail
checkRecBal.start();
//to check the membership and marking as expired after duration is over
checkMembership.start();

/*
    Monthly membership expirations
*/
app.get('/check/membership', function (req, res) {

    q.all([
        common.getExpiredMemberships(config.mysql)
    ]).then(function (results) {
        var user_ids = _.pluck(results[0][0], 'user_id');

        var membership_ids = _.pluck(results[0][0], 'id');
        // console.log('s1');
        if (membership_ids.length > 0) {
            faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name,balance', user_ids, results[0][0], 'user_id', function (apiErr, musers) {
                // console.log('s2');

                q.all([
                    common.changeMembershipStatus(config.mysql, membership_ids), products.checkmailnotify(req, config.mysql, q, 45), products.checksmsnotify(req, config.mysql, q, 45)
                ]).then(function (results) {
                    // console.log('s3');
                    // console.log('status changed : ' + JSON.stringify(results));
                    async.forEachSeries(musers, function (usr, callback_s1) {
                        // console.log('s4');
                        // res.send(usr);
                        /* email module */
                        var activeurl = '<br/> <a href="' + $arr.config.spath + 'dbmarket/rejectorder">Click Here</a>';
                        email = require('../module/email');
                        localm = require('../module/localmail');
                        if (results[1][0].length > 0) {
                            // if (global.emailcio.status == 'yes') {
                            //     customerio = require('../module/customerio');
                            //     customerio.uid = result.userId;
                            // } else 
                            if (global.emaillocal.status == 'yes') {
                                q.all([localm.mailtemps(req, config.mysql, q, 'messages')]).then(function (results2) {

                                    if (results2) {

                                        var template = results2[0][0][0].template;
                                        // var subject_message = results2[0][0][0].subject;
                                        var subject_message = 'Membership expired';

                                        template = template.replace('{{event.sitename}}', config.title);
                                        template = template.replace('{{event.activeurl}}', activeurl);
                                        template = template.replace('{{event.user}}', usr.first_name + ' ' + usr.last_name);
                                        template = template.replace('{{event.subject}}', subject_message);
                                        // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                                        localm.sendmail(template, subject_message, usr.email);

                                    } else {
                                        console.log("No Templates named register");
                                    }

                                }).fail(function (err) {
                                    console.log(err.stack);
                                    throw err;
                                });

                            } else { console.log('No Mail Delivery method is selected'); }
                        } else { console.log('Notification off'); }
                        callback_s1();
                    });

                })
            })
        } else {
            console.log('no membership found...');
            res.send('no membership found...')
        }
    })

});

/*
    Checking users acc bal daily
*/

app.get('/check/balance', function (req, res) {

    async.series({
        getBuyerSeller: function (cb) {

            // getting userInformations
            var userDataCallback = function (err, response) {
                cb(err, response);
                // console.log("getting userinfo");
            }

            faAPI.callUserQuery('no_type', 'id, first_name, last_name, email, phone, balance', 'where balance < 250', userDataCallback)
        }
    },
        function (apiSeUsersErr, apiSeUsersRes) {
            var usrs = apiSeUsersRes.getBuyerSeller.results
            if (usrs.length > 0) {

                async.forEachSeries(usrs, function (usr, callback_s1) {
                    // if ((usr.email == 'test959569@gmail.com') || (usr.email == 'mohit@auctionsoftware.com')) {

                    // var a2 = [10,11,12,13,14];
                    /* email module */
                    var activeurl = '<br/> <a href="' + $arr.config.spath + 'payment/wirefund">Click Here</a>';
                    email = require('../module/email');
                    localm = require('../module/localmail');
                    q.all([products.checkmailnotify(req, config.mysql, q, 49), products.checksmsnotify(req, config.mysql, q, 49)]).then(function (results) {
                        if (results[0][0].length > 0) {
                            // if (global.emailcio.status == 'yes') {
                            //     customerio = require('../module/customerio');
                            //     customerio.uid = result.userId;
                            // } else 
                            if (global.emaillocal.status == 'yes') {
                                q.all([localm.mailtemps(req, config.mysql, q, 'insufficient_funds')]).then(function (results2) {

                                    if (results2) {

                                        var template = results2[0][0][0].template;
                                        var subject_message = results2[0][0][0].subject;

                                        template = template.replace('{{event.sitename}}', config.title);
                                        template = template.replace('{{event.activeurl}}', activeurl);
                                        template = template.replace('{{event.user}}', usr.first_name + ' ' + usr.last_name);
                                        template = template.replace('{{event.subject}}', 'Insufficient funds');
                                        // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                                        localm.sendmail(template, subject_message, usr.email);

                                    } else {
                                        // console.log("No Templates named register");
                                    }

                                }).fail(function (err) {
                                    console.log(err.stack);
                                    throw err;
                                });

                            } else {
                                // console.log('No Mail Delivery method is selected'); 
                            }
                        } else { console.log('Notification off'); }
                    });
                    /* email module ends here */
                    // }
                    callback_s1();
                });

            }
            // res.json(JSON.stringify(apiSeUsersRes.getBuyerSeller.results));
            // res.end();
        })
});

app.get('/check/recbalance', function (req, res) {
    var prodRequests = require('../module/prod_requests');

    var cart = require('../module/cart');
    // console.log('recurring here');
    // var buyuserdetails = [];
    // var prouserdetails = [];
    q.all([
        prodRequests.getFutureRecurrings(config.mysql, q), products.checkmailnotify(req, config.mysql, q, 47), products.checksmsnotify(req, config.mysql, q, 47)
    ]).then(function (results) {
        var count = 0;
        var user_ids = _.pluck(results[0][0], 'user_id');
        faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name,balance', user_ids, results[0][0], 'user_id', function (apiErr, recs) {
            if (apiErr) {
                console.log(apiErr);
            } else {
                // console.log(JSON.stringify(recs));

                async.forEachSeries(recs, function (usr, callback_s1) {

                    /* calculate total amount to check total balance from user end*/
                    var prdtPrice = usr.rp_amount;
                    var taxAmt = (parseFloat(usr.stax) / 100) * parseFloat(prdtPrice);
                    var commissionAmt = (parseFloat(config.general.commission_fee) / 100 * parseFloat(prdtPrice));
                    usr.rp_amount = parseFloat(parseFloat(usr.rp_amount) + taxAmt + commissionAmt).toFixed(2);
                    /* usr.rp_amount is total rec amount */

                    if (parseFloat(usr.rp_amount) > parseFloat(usr.balance)) {
                        // if ((usr.email == 'test959569@gmail.com') || (usr.email == 'mohit@auctionsoftware.com')) {
                        // console.log(usr);
                        // console.log(usr.email);
                        // var a2 = [10,11,12,13,14];
                        /* email module */
                        var activeurl = '<br/> <a href="' + $arr.config.spath + 'dbmarket/rejectorder">Click Here</a>';
                        email = require('../module/email');
                        localm = require('../module/localmail');
                        if (results[1][0].length > 0) {
                            // if (global.emailcio.status == 'yes') {
                            //     customerio = require('../module/customerio');
                            //     customerio.uid = result.userId;
                            // } else 
                            if (global.emaillocal.status == 'yes') {
                                q.all([localm.mailtemps(req, config.mysql, q, 'risk_management')]).then(function (results2) {

                                    if (results2) {

                                        var template = results2[0][0][0].template;
                                        var subject_message = results2[0][0][0].subject;
                                        // var subject_message = 'Please increase fund balance for continue the recurring..';

                                        template = template.replace('{{event.sitename}}', config.title);
                                        template = template.replace('{{event.activeurl}}', activeurl);
                                        template = template.replace('{{event.user}}', usr.first_name + ' ' + usr.last_name);
                                        template = template.replace('{{event.subject}}', subject_message);

                                        localm.sendmail(template, subject_message, usr.email);

                                    } else {
                                        // console.log("No Templates named register");
                                    }

                                }).fail(function (err) {
                                    console.log(err.stack);
                                    throw err;
                                });

                            } else {
                                // console.log('No Mail Delivery method is selected'); 
                            }
                        } else { console.log('Notification Off'); }
                        count++;
                        /* email module ends here */
                        // }
                    }

                    callback_s1();

                }, function () {
                    console.log(count + " emails sent");
                })
                res.send('success');
            }

        });

    })
});

// recurringJobs.start();

app.get('/calc', function (req, res) {
    console.log("calc");

    var tax = '4.56';
    var sprice = '1954'

    var stax = (typeof (tax) == 'undefined') ? 0 : tax
    if (stax > 0) {
        var stax_amount = parseFloat(sprice) * (parseFloat(stax) / 100);
    } else
        var stax_amount = 0;

    // console.log("stax_amount : " + stax_amount + "\n stax : " + stax);
    res.send("stax_amount : " + stax_amount + "\n stax : " + stax);
});



app.get('/registertemp', function (req, res) {
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
    common.tplFile('register.tpl');
});


app.get('/clearlog', function (req, res) {
    var fs = require('fs')
    path = $arr.config.path + '/public/images/herbee.log';
    // console.log("Path is " + path);
    fs.truncate(path, 0, function (err) {
        if (err) {
            console.error(err);
            res.end(err.message);
        }
        console.log("File truncated successfully");

        res.end('File truncated successfully');
        return false;
    })
});
app.get('/clearcgilog', function (req, res) {
    var fs = require('fs')
    path = $arr.config.path + '/public/images/herbee.log';
    fs.truncate(path, 0, function(err) {
        if (err) {
            console.log(err.stack);
        }
        res.send('File truncated successfully');
        res.end();
        return false;
    });
});

app.get('/imager', function (req, res) {
    var fs = require('fs');
    var im = require('imagemagick');
    //console.log(fs.readFileSync($arr.config.paths.path+'public/uploads/product/1d96ff2a3aa239fc80f928570bdd9a30.jpeg', 'binary'));
    im.resize({
        srcData: fs.readFileSync($arr.config.paths.path + 'public/uploads/product/c82b3b26727bef8a0acbb7575d28e620.jpg', 'binary'),
        width: 100
    }, function (err, stdout, stderr) {
        if (err) console.log(err);
        //console.log(2);
        //console.log(stdout);
        fs.writeFileSync($arr.config.paths.path + 'public/uploads/product/test3.jpg', stdout, 'binary');
        // console.log('resized kittens.jpg to fit within 256x256px')
    });
});
app.get('/wowza', function (req, res) {
    res.header('Content-Type', 'text/html').send("<div id='wowza_player'></div><script id='player_embed' src='https://player.cloud.wowza.com/hosted/" + req.param('wowza') + "/wowza.js' type='text/javascript'></script>");
    res.end();
    return false;
});
app.post('/srini', function (req, res) {
    users = require('../module/userdata');
    q.all([users.userdeals(req, $arr.config.mysql, q)]).then(function (results) {

        $arr.deals = results[0][0];
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
        res.writeHead(302, {
            'Location': '/srini'
        });
        res.end();
        return false;

    });
});


app.get('/srini', function (req, res) {
    users = require('../module/userdata');
    common.tplFile('userdata.tpl');
    q.all([users.getdata(req, $arr.config.mysql, q)]).then(function (results) {

        $arr.getrecord = results[0][0];
        common.tplFile('userdata.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });
});
app.get('/config_s', function (req, res) {
    var fs = require('fs'),
        ini = require('ini');
    var configed = fs.readFileSync('./config.ini', 'utf-8');
    /*res.send(configed);
    res.end();
    return false;*/
});
app.get('/phonecheckup', function (req, res) {
    $arr.phonecheckup = 1;
    if (req.session.keysuccess) {
        $arr.phonecheckup = 0;
    }
    $arr.register_error = '';
    $arr.register_fail = 0;
    $arr.login_error = '';
    $arr.login_fail = 0;
    $arr['registerdata'] = req.cookies;
    if (typeof (req.session.keyadded) !== 'undefined') {
        var dateFormat = require('dateformat');
        datge = new Date();
        var dateFormat = require('dateformat');
        dump = new Date(req.session.keyadded);
        var difference = dump.getTime() - datge.getTime();
        var daysDifference = Math.floor(difference / 1000 / 60 / 60 / 24);
        difference -= daysDifference * 1000 * 60 * 60 * 24
        var hoursDifference = Math.floor(difference / 1000 / 60 / 60);
        difference -= hoursDifference * 1000 * 60 * 60
        var minutesDifference = Math.floor(difference / 1000 / 60);
        difference -= minutesDifference * 1000 * 60;
        if (difference > 1) {
            delete req.session.keyadded;
        }
    }
    if (req.cookies.cookieemail) {
        $arr['cookieemail'] = req.cookies.cookieemail;
        $arr['cookiepassword'] = req.cookies.cookiepassword;
    }
    res.clearCookie('email');
    res.clearCookie('first_name');
    res.clearCookie('last_name');
    res.clearCookie('password');
    if (typeof (req.param('error')) !== 'undefined') {
        $arr.register_error = req.param('error');
        $arr.register_fail = 1;
    }
    if (typeof (req.param('lerror')) !== 'undefined') {
        $arr.login_error = req.param('lerror');
        $arr.login_fail = 1;
    }
    var module = require('../module');

    $arr.pagetitle = 'home';
    $arr.ptitle = 'index';
    var products = require('../module/products');
    q.all([products.dealsProducts(req, $arr.config.mysql, q), products.bestSellersProducts(req, $arr.config.mysql, q), products.productCategoryItems(req, $arr.config.mysql, q, 1), products.productCategoryItems(req, $arr.config.mysql, q, 3)]).then(function (results) {

        var fs = require('fs'),
            ini = require('ini');

        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
        var mode = configed['section']['mode']['Maintenance_mode'];
        var msg = configed['section']['mode']['message'];
        $arr.deals = results[0][0];
        $arr.sellers = results[1][0];
        $arr.cat1 = results[2][0];
        $arr.cat2 = results[3][0];
        $arr.mode = mode;
        $arr.msg = msg;
        if (mode == 'yes') {
            common.tplFile('maintenance.tpl');
        } else {
            common.tplFile('home.tpl');
        }
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post('/phone_setup_code', function (req, res) {

    if (req.session.key == req.param('key')) {
        req.session.keysuccess = true;
        var dateFormat = require('dateformat');
        datge = new Date();
        req.session.keyadded = datge;
        res.send(JSON.stringify({ 'error': false }));
    } else {
        res.send(JSON.stringify({ 'error': true }));
    }
    res.end();
    return false;
});

app.post('/phone_setup', function (req, res) {

    var accountsSid = global.smstwo.sid;
    var authsToken = global.smstwo.token;
    var accountSid = accountsSid;
    var authToken = authsToken;

    //require the Twilio module and create a REST client

    var client = require('twilio')(accountSid, authToken);
    common.demoFormSubmit(req, config.mysql, q);
    var key = req.session.key = Math.floor(Math.random() * 90000) + 10000;

    client.calls.create({
        to: req.param('address'),
        from: "+12144777038",
        url: "http://auctionsoftwaremarketplace.com:2001/product/digitalcode?key=" + key,
        method: "GET",
        fallbackMethod: "GET",
        statusCallbackMethod: "GET",
        record: "false"
    }, function (err, call) {
        if (err === null) {
            res.send(JSON.stringify({ 'error': false }));
            res.end();
            return false;
        } else {
            res.send(JSON.stringify({ 'error': true, 'message': err.message }));
            res.end();
            return false;
        }
    });
});

app.get('/servertime', function (req, res) {
    var dateFormat = require('dateformat');
    datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    res.send(datenow);
    res.end();
    return false;

});

app.post('/paypal/pay/', function (req, res) {
    if (typeof (req.body.secretkey) !== 'undefined' && req.body.secretkey == 'YTMNSRXYZ#$%%RMNOP') {
        req.body.success = true;
        var admin = require('../module/admin');
        var m = JSON.parse(req.body.payer);
        var k = [];
        for (i in m) {
            k.push(m[i]['id']);
            admin.updatePaid(res, config.mysql, q, m[i]['id']);
        }
        var ks = k.join(',');
        res.end();
        return false;
    } else {
        res.end();
        return false;
    }
});

app.post('/paypal/pkey/', function (req, res) {
    if (typeof (req.body.secretkey) !== 'undefined' && req.body.secretkey == 'YTMNSRXYZ#$%%RMNOP') {
        var fs = require('fs'),
            ini = require('ini');

        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
        configed['section']['paypal']['preapproval_key'] = req.body.key;
        fs.writeFileSync('./config.ini', ini.stringify(configed));
        /*configure = require('../../configure');
         config = configure.app();
         $arr = {
         config : config
         }*/
    }
});

app.get('/location/:type/:val', function (req, res) {
    if (req.param('type') == 'country') {
        q.all([common.fetchStates(config.mysql, req.param('val'))]).then(function (results) {
            var states = results[0][0];
            res.send(JSON.stringify(states));
            res.end();
        });
    }
    if (req.param('type') == 'state') {
        q.all([common.fetchStates(config.mysql, req.param('val'))]).then(function (results) {
            var cities = results[0][0];
            res.send(JSON.stringify(cities));
            res.end();
        });
    }
});

app.get('/home', function (req, res) {
    $arr.register_error = '';
    $arr.register_fail = 0;
    $arr.login_error = '';
    $arr.login_fail = 0;
    $arr['registerdata'] = req.cookies;
    if (req.cookies.cookieemail) {
        $arr['cookieemail'] = req.cookies.cookieemail;
        $arr['cookiepassword'] = req.cookies.cookiepassword;
    }
    res.clearCookie('email');
    res.clearCookie('first_name');
    res.clearCookie('last_name');
    res.clearCookie('password');
    if (typeof (req.param('error')) !== 'undefined') {
        $arr.register_error = req.param('error');
        $arr.register_fail = 1;
    }
    if (typeof (req.param('lerror')) !== 'undefined') {
        $arr.login_error = req.param('lerror');
        $arr.login_fail = 1;
    }
    var module = require('../module');
    $arr.pagetitle = 'home';
    $arr.ptitle = 'index';

    function processIndex(row) {
        common.processIndex(row, req, res, $arr);
    }

    $arr.projects = module.projects(config.mysql, processIndex);
});

app.get('/customer', function (req, res) {
    customerio = require('../module/customerio');
    req.body.email = 'kkr@gmail.com';
    req.body.first_name = 'as';
    req.body.last_name = 'bs';
    customerio.uid = '12';
    customerio.inits();
    customerio.createCustomer({
        email: req.body.email,
        user: { firstName: req.body.first_name, lastName: req.body.last_name }
    });
    customerio.sendEmail({ event: 'Signed Up', content: { user: req.body.first_name + ' ' + req.body.last_name } });
});

app.get(['/bidhistory/:id'], function (req, res) {
    bids = require('../module/bid');
    q.all([bids.bidHistory(req, config.mysql, q, 0)]).then(function (results) {
        $arr.bids = results[0][0];
        common.tplFile('bidhistory.tpl');
        common.headerSet(0);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/activate/:id'], function (req, res) {

    console.log("id here : " + req.params.id);
    // var index = require('../module');

    faAPI.activateUser(req, function (err, resp) {
        if (err) {
            res.send(err);
            return false;
        } else {
            res.writeHead(302, {
                'Location': '/login/?error=4'
            });
            res.end();
            return false;
        }
    });

});

app.post('/asy1', function (req, res) {
    console.log("0")
    async = require("async");
    bid = require('../module/bid');
    var products = require('../module/products');

    if (global.general.proxy_bidding) {
        q.all(bid.checkUserExistInBidProxy(req, $arr.config.mysql, q)).then(function (proxy_user_exist) {
            console.log(proxy_user_exist[0]);
            if (proxy_user_exist[0].length > 0) {
                q.all(bid.updateProxyBid(req, $arr.config.mysql, q)).then(function (proxy_user_exist) {

                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            } else {
                q.all(bid.insertProxyBid(req, $arr.config.mysql, q)).then(function (proxy_user_exist) {

                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    }




});

app.post('/asy', function (req, res) {

    async = require("async");
    bid = require('../module/bid');
    var products = require('../module/products');
    async.waterfall([

        function (callback) {
            console.log("First fun");
            if (global.general.proxy_bidding) {
                // Get the highest bidding details from proxy table
                q.all(bid.getProxyDetails(req, $arr.config.mysql, q, 'get_highest_biduser')).then(function (highest_proxybid_details) {
                    // Get the highest biided user from proxy table

                    req.body.highest_proxy_userid = 0;
                    req.body.highest_proxy_amount = 0

                    if (highest_proxybid_details[0].length > 0) {

                        req.body.highest_proxy_userid = highest_proxybid_details[0][0].user_id;
                        req.body.highest_proxy_amount = highest_proxybid_details[0][0].maxamount;
                    }
                    // If bidder amount to the proxy bid value
                    if (req.session.userid != req.body.highest_proxy_userid && req.body.highest_proxy_amount == req.body.wsprice) {
                        increment_amount = global.general.proxy_bid_amount;

                        req.body.wsprice = req.body.wsprice - increment_amount;
                    }
                    callback(null, 'done');

                }).fail(function (err) {
                    console.log(err.stack);
                    callback(err, 'done');
                }).done();
            }

        },
        function (arg1, callback) {
            console.log("second fun");
            // Get the last bidded infromation of bidder
            if (parseInt(global.general.proxy_bidding) > 0) {
                q.all(bid.checkUserExistInBidProxy(req, $arr.config.mysql, q)).then(function (proxy_user_exist) {

                    //If user is already exist in proxybid table

                    if (proxy_user_exist[0].length > 0) {

                        if (proxy_user_exist[0][0].maxamount < req.body.wsprice) {
                            q.all([bid.updateProxyBid(req, $arr.config.mysql, q), bid.getProxyDetails(req, $arr.config.mysql, q, 'get_highest_biduser'), bid.getProxyDetails(req, $arr.config.mysql, q, 'second_highest_biduser')]).then(function (proxy_user_exist) {
                                latest_proxy_bid_details = proxy_user_exist[1][0][0];
                                second_highest_proxy_bid_details = proxy_user_exist[2][0][0];
                                console.log("If update " + JSON.stringify(latest_proxy_bid_details));
                                callback(null, latest_proxy_bid_details, second_highest_proxy_bid_details);

                            }).fail(function (err) {
                                console.log(err.stack);

                            });
                        } else {
                            res.writeHead(302, {
                                'Location': '/product/view/' + req.param('id') + '/cannot bid lower than original proxy amount'
                            });
                            res.end();
                            return false;
                        }


                    } else {

                        q.all([bid.insertProxyBid(req, $arr.config.mysql, q), bid.getProxyDetails(req, $arr.config.mysql, q, 'get_highest_biduser'), bid.getProxyDetails(req, $arr.config.mysql, q, 'second_highest_biduser')]).then(function (proxy_user_exist) { //If user is not exist in proxybid table
                            latest_proxy_bid_details = proxy_user_exist[1][0][0];
                            second_highest_proxy_bid_details = proxy_user_exist[2][0][0];
                            callback(null, latest_proxy_bid_details, second_highest_proxy_bid_details); // Pass the last proxy bidding details

                        }).fail(function (err) {
                            console.log(err.stack);

                        });
                    }


                }).fail(function (err) {
                    //console.log(err.stack);
                    callback(err, 'done');
                }).done();
            } else {
                callback(null, 'done');
            }


        },
        function (latest_proxy_bid_details, second_highest_proxy_bid_details, callback) {
            console.log("Third fun");
            //Check current bid is greater then highest proxy bid
            if (parseInt(global.general.proxy_bidding) > 0) {

                if (req.body.highest_proxy_userid != req.session.userid) {

                    if (req.body.highest_proxy_amount < req.body.wsprice && parseFloat(req.body.highest_proxy_amount) != 0) {

                        req.body.wsprice = bid.fetch_minimum_bid(req.body.highest_proxy_amount, global.general.proxy_bid_amount);
                    }

                    q.all(bid.placeBid(req, config.mysql, q, 1)).then(function (resbid) {

                        q.all([bid.fetch_last_bid(req, $arr.config.mysql, q)]).then(function (bid_details) {

                            last_bid_details = bid_details[0][0][0];
                            if (last_bid_details.user_id != latest_proxy_bid_details.user_id) {

                                if (latest_proxy_bid_details.maxamount >= last_bid_details.proposed_amount) {
                                    // Proxy bid amount being placed: req.body.wsprice is greater than highest proxy: highest_proxy_amount", 'NOTICE');
                                    req.body.next_bid = bid.fetch_minimum_bid(last_bid_details.proposed_amount, global.general.proxy_bid_amount);
                                    q.all(bid.insertBidsAsProxy(req, config.mysql, q)).then(function (resbid) {
                                        req.body.wsprice = req.body.next_bid;
                                        bid.updateBid(req, config.mysql, q);
                                        callback(null, 'done');

                                    }).fail(function (err) {
                                        console.log(err.stack);
                                        callback(err, 'done');
                                    }).done();
                                } else if (latest_proxy_bid_details.maxamount == last_bid_details.proposed_amount)
                                    q.all(bid.insertBidsAsProxy(req, config.mysql, q)).then(function (resbid) {
                                        bid.updateBid(req, config.mysql, q);
                                        callback(null, 'done');

                                    }).fail(function (err) {
                                        console.log(err.stack);
                                        callback(err, 'done');
                                    }).done();
                                else if (latest_proxy_bid_details.maxamount < last_bid_details.proposed_amount)
                                    q.all(bid.insertBidsAsProxy(req, config.mysql, q)).then(function (resbid) {
                                        bid.updateBid(req, config.mysql, q);
                                        callback(null, 'done');

                                    }).fail(function (err) {
                                        console.log(err.stack);
                                        callback(err, 'done');
                                    }).done();
                            } else {
                                //Same as orginal bidded amount
                                bid.updateBid(req, config.mysql, q);
                                proxy_bid_status = false;
                                callback(null, 'done');
                            }

                        }).fail(function (err) {
                            console.log(err.stack);
                            callback(err, 'done'); //fetch_last_bid
                        }).done();

                    }).fail(function (err) {
                        //console.log(err.stack);
                        callback(err, 'done');
                    }).done(); //Placebid End
                } else {

                    callback(null, 'done');
                }
            } else {
                bid.updateBid(req, config.mysql, q);
                callback(null, 'done');
            }


        }

    ], function (err, result) {
        // result now equals 'done';
        console.log(err);
        res.writeHead(302, {
            'Location': '/product/view/' + req.param('id')
        });
        res.end();
        return false;
    });
});

app.get(['/', '/reg/:error', '/log/:lerror', '/reg/', '/log/', '/unsub_success/:success'], function (req, res) {



    q.all([products.getOpenProducts(req,config.mysql, q)]).then(function (productData) {
        console.log("productData", productData[0][0]);
        $arr['products'] = productData[0][0];
        common.tplFile('home.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
 
    });

   

});

app.get('/language', function (req, res) {
    var module = require('../module');
    $arr.ptitle = 'index';
    $arr.pagetitle = 'Live Auctions';

    function processIndex(row) { 
        common.processIndex(row, req, res, $arr);
    }

    $arr.projects = module.live(config.mysql, processIndex);
});

app.get('/live', function (req, res) {
    var module = require('../module');
    $arr.ptitle = 'index';
    $arr.pagetitle = 'Live Auctions';

    function processIndex(row) {
        common.processIndex(row, req, res, $arr);
    }

    $arr.projects = module.live(config.mysql, processIndex);
});


app.get('/privacy', function (req, res) {

    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;;
    }
    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();

    admin = require('../module/admin');
    req.body.id = 5;
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr.externalcss = ['home_1'];
        $arr['content'] = results[0][0][0];
        common.tplFile('static_pages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get('/termcondition', function (req, res) {
    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;
    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;
    }
    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();

    req.body.id = 4;
    admin = require('../module/admin');
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr['heading_common'] = "Terms &amp; Conditions";
        $arr['content'] = results[0][0][0].content;
        common.tplFile('termcondition.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});
app.get('/distribution', function(req, res) {
    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;
    } else {
        var referals = (typeof(req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof(req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;
    }
    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();

    req.body.id = 4;
    admin = require('../module/admin');
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function(results) {
        $arr['heading_common'] = "distribution";
        $arr['content'] = results[0][0][0].content;
        common.tplFile('distribution.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.get(['/search', '/search/cid/:cid', '/search/cid/:cid/:title'], function (req, res) {
    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }

    $arr['externalcss'] = ['ds-forms'];
    var dateFormat = require('dateformat');
    $arr.ajaxurl = (typeof (req.param('ajaxurl')) !== 'undefined') ? req.param('ajaxurl') : '';
    Recaptcha = require('recaptcha').Recaptcha;

    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;

    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();


    var module = require('../module');
    $arr.pagetitle = 'Search Projects';
    $arr.ptitle = 'search';
    $arr.cid_search = (typeof (req.param('cid')) !== 'undefined') ? req.param('cid') : 0;
    $arr.search_search = (typeof (req.param('search')) !== 'undefined') ? req.param('search') : '';
    $arr.pid_search = (typeof (req.param('projectid')) !== 'undefined') ? req.param('projectid') : 0;
    $arr.images_search = (typeof (req.param('images')) !== 'undefined') ? 'checked="checked"' : '';
    $arr.freeshipping = (typeof (req.param('freeshipping')) !== 'undefined') ? 'checked="checked"' : '';
    $arr.titlesonly = (typeof (req.param('titlesonly')) !== 'undefined') ? 'checked="checked"' : '';
    $arr.uid = (typeof (req.param('uid')) !== 'undefined') ? req.param('uid') : 0;
    req.body.limit = 12;

    var data = module.searcherViaUrl(req, config.mysql, q);

    data.perlimit = req.body.limit;
    var products = require('../module/products');


    q.all([products.searchProducts(config.mysql, q, data, 1), products.searchProducts(config.mysql, q, data, 0)]).then(function (results) {

        $arr['projects'] = [];

        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: data.spage,
            rowsPerPage: req.body.limit,
            totalResult: results[1][0].length,
            ajax: true
        });

        $arr.isbuynowsearch = $arr.isfeaturedsearch = $arr.isauctionsearch = $arr.isvideosearch = '';
        if (req.param('type') == '1') {
            $arr.isauctionsearch = 'checked';
        }
        if (req.param('type') == '2') {
            $arr.isbuynowsearch = 'checked';
        }
        if (req.param('type') == '3') {
            $arr.isfeaturedsearch = 'checked';
        }
        if (req.param('type') == '4') {
            $arr.isvideosearch = 'checked';
        }

        $arr['pagination_html'] = paginator.render();
        $arr['projects']['project'] = products.shortDescribe(results[0][0]);

        common.tplFile('search.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (error) {
        console.log(error.stack);
        throw error;

    }).done();

});

app.post('/savesearch', function (req, res) {
    data = req.param;

    var uid = (typeof (req.session.userid) !== 'undefined') ? req.session.userid : 0;

    if (uid === 0) {
        res.json(0);
        return false;
    } else {
        var products = require('../module/products');
        req.body.title = req.param('title');
        q.all([products.savesearch(req, config.mysql, q)]).then(function (results) {
            res.json(1);
            return false;
        });
    }
});


app.post('/search', function (req, res) {

    $arr['externalcss'] = ['ds-forms'];
    var dateFormat = require('dateformat');
    var module = require('../module');

    $arr.pagetitle = 'Search Projects';
    $arr.ptitle = 'search';
    $arr.cid_search = (typeof (req.param('cid')) !== 'undefined') ? req.param('cid') : '';
    $arr.search_search = (typeof (req.param('search')) !== 'undefined') ? req.param('search') : '';
    $arr.pid_search = (typeof (req.param('projectid')) !== 'undefined') ? req.param('projectid') : 0;
    $arr.images_search = (typeof (req.param('images')) !== 'undefined') ? 'checked="checked"' : '';
    $arr.freeshipping = (typeof (req.param('freeshipping')) !== 'undefined') ? 'checked="checked"' : '';
    $arr.titlesonly = (typeof (req.param('titlesonly')) !== 'undefined') ? 'checked="checked"' : '';
    $arr.uid = (typeof (req.param('uid')) !== 'undefined') ? req.param('uid') : 0;
    $arr.local_pickup = (typeof (req.param('local_pickup')) !== 'undefined') ? 'checked="checked"' : '';
    req.body.limit = 12;
    var data = module.searcherViaUrl(req, config.mysql, q);
    data.perlimit = req.body.limit;
    var products = require('../module/products');
    q.all([products.searchProducts(config.mysql, q, data, 1), products.searchProducts(config.mysql, q, data, 0)]).then(function (results) {
        $arr['projects'] = [];
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: data.spage,
            rowsPerPage: req.body.limit,
            totalResult: results[1][0].length,
            ajax: true
        });

        $arr['pagination_html'] = paginator.render();
        $arr['projects']['project'] = products.shortDescribe(results[0][0]);
        if (typeof (req.param('ajax')) === 'undefined') {
            common.tplFile('search.tpl');
            common.headerSet(1);
        } else {
            common.tplFile('search-ajax.tpl');
            common.headerSet(0);
        }
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post('/searchstorepdts', function (req, res) {

    $arr['externalcss'] = ['ds-forms'];
    var dateFormat = require('dateformat');
    var module = require('../module');

    $arr.pagetitle = 'Search Projects';
    $arr.ptitle = 'search';
    $arr.cid_search = (typeof (req.param('cid')) !== 'undefined') ? req.param('cid') : '';
    req.body.cid = (typeof (req.param('cid')) !== 'undefined') ? req.param('cid') : '';
    req.body.limit = 12;
    var data = module.searcherViaUrl(req, config.mysql, q);
    console.log('data', data);
    data.perlimit = req.body.limit;
    var products = require('../module/stores');
    q.all([
        products.viewStoreProductsnew(config.mysql, q, req, 1),
        products.viewStoreProductsnew(config.mysql, q, req, 0)
    ]).then(function (results) {
        $arr['projects'] = [];
        //console.log(results[0][0]);
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: data.spage,
            rowsPerPage: req.body.limit,
            totalResult: results[1][0].length,
            ajax: true
        });

        $arr['pagination_html'] = paginator.render();
        //$arr['projects']['project'] = products.shortDescribe(results[0][0]);
        $arr['projects']['project'] = results[0][0];
        if (typeof (req.param('ajax')) === 'undefined') {
            common.tplFile('search.tpl');
            common.headerSet(1);
        } else {
            common.tplFile('search-ajaxstore.tpl');
            common.headerSet(0);
        }
        common.loadTemplateHeader(req, res, $arr);
    });
});

/*------------------------------- Getting welcome page ---------------------------*/
app.get(['/market/selection', '/market/selection/:error'], function (req, res) {

    $arr.error = typeof (req.param('error')) !== undefined ? req.param('error') : 0;
    console.log('running2');
    if (common.checkLogin(req, res, 0)) {
        q.all([stores.getstoreid(req, config.mysql, q)]).then(function (result) {

            if (result[0][0].length > 0) {
                $arr['storeid'] = result[0][0][0].id;
                req.session.storeid = result[0][0][0].id;
            } else {
                $arr['storeid'] = 0;
            }

            common.tplFile('market-selection.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        });
    } else {
        return false;
    }

});


/* ------------------------------- Getting open bid market page - can sort out based on category and type ------------------------------- */
/* -------------------------------------------- Ajax call used for getting products dynamically ----------------------------------------- */
/* -------------------refer ---------------- 1) app.post('/openbid/products', function(req, res) { ---Getting products list dynamically-- */
/* -------------------refer ---------------- 2) app.post('/request/save', function(req, res) { -------Dynamic Bidding ------------------- */
app.get(['/openbid/market', '/openbid/market/:cat', '/openbid/market/:cat/:type', '/openbid/market/:cat/:type/:sort'], function (req, res) {

    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {
        $arr.socketio = 1;
        var allow = common.checkPermission('bid_limit', req);

        if (!allow) {

            res.writeHead(302, {
                'Location': '/product/membership_reached'
            });
            res.end();

            return false;

        } else {

            $arr['externaljs'] = ['jquery.toaster'];
            // console.log(req.params.type);

            // console.log(req.body);
            // console.log(req.params);
            //for loader only
            $arr['openbid'] = 1;
            $arr['logged_user'] = req.session.userid;

            if (typeof (req.params.type) !== 'undefined' && (req.params.type == 'recent' || req.params.type == 'availabledate' || req.params.type == 'selloffers' || req.params.type == 'buyoffers')) {
                $arr.type = req.params.type;
                req.body.type = req.params.type;
            } else {
                $arr.type = 'recent';
                req.body.type = 'recent';
            }

            $arr['sort_type'] = (req.params.sort !== 'undefined') ? req.params.sort : '';
            req.body.sortType = (req.params.sort !== 'undefined') ? req.params.sort : '';

            // console.log("$arr here : " + $arr.sort_type);
            // console.log("$arr here : " + req.body.sortType);


            if (typeof (req.param('cat')) == 'undefined' || req.param('cat') == '') {
                $arr['cat'] = 'all';
                req.body.cat = 'all'
            } else {
                $arr['cat'] = req.params.cat;
                req.body.cat = req.params.cat;
            }

            // console.log('cat');
            // console.log($arr.cat);
            q.all([openBidProducts.getOpenBidProducts(req, config.mysql, q, 1), openBidProducts.getCategories(req, config.mysql, q)]).then(function (result) {
                // console.log('/openbid/market/:cat');
                // console.log(result[0][0]);
                // $arr['products'] = result[0][0];
                $arr['totalProducts'] = result[0][0][0].productsCount;
                $arr['categories'] = result[1][0];
                $arr['availablenow'] = false;
                $arr['future'] = false;

                console.log("logged user here" + $arr['logged_user']);
                common.tplFile('open-bid-market.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });

        }
    } else {
        return false;
    }
});


/*------------------------- --------------------------------------------------------------
        AJAX call to getting products dynamically on openbid market page 
------------------------------------------------------------------------------------------*/
app.post('/openbid/products', function (req, res) {

    // common.checkLogin(req, res, 0);
    if (common.checkLogin(req, res, 0)) {

        var allow = common.checkPermission('allow_to_bid', req);

        if (!allow) {

            res.writeHead(302, {
                'Location': '/product/membership_reached'
            });
            res.end();

            return false;

        } else {
            // console.log($arr.cat);
            var page = typeof (req.param('page')) !== 'undefined' ? req.param('page') : '0';
            var cat = typeof (req.param('cat')) !== 'undefined' ? req.param('cat') : 'all';
            var type = typeof (req.param('type')) !== 'undefined' ? req.param('type') : 'recent';
            var sortType = typeof (req.param('sortType')) !== 'undefined' ? req.param('sortType') : '';
            $arr['logged_user'] = req.session.userid;
            // console.log('user id', + $arr['logged_user']);
            var products = require('../module/products');
            q.all([openBidProducts.getOpenBidProducts(req, config.mysql, q, 0)]).then(function (result) {
                var productss = products.shortDescribe(result[0][0]); //result[0][0];

                /*start*/

                for (var i = 0; i < productss.length; i++) {
                    // productss[i]

                    var hours = 60 * 60 * 1000;
                    // console.log("day : "+hours);

                    var firstDate = new Date(productss[i].date_added); //date of start auction
                    var curDate = new Date(Date.now()); //current date
                    var start_date = new Date(productss[i].start_date); //formated start date
                    var secondDate = new Date(productss[i].checkAvail); //date_added - 72 hours

                    var diffHours = Math.round((secondDate.getTime() - curDate.getTime()) / (hours));

                    // console.log("date_added : "+firstDate);
                    // console.log("available Date : "+secondDate);
                    // console.log("diff : "+diffHours);

                    if (diffHours < 0) {
                        productss[i].available = true;
                    } else if (diffHours > 0) {
                        productss[i].available = false;
                        productss[i].future_date = (firstDate.getMonth() + 1) + '/' + firstDate.getDate() + '/' + (firstDate.getFullYear() - 2000);
                        // console.log("future_date "+productss[i].future_date);
                    } else {
                        productss[i].future_date = (firstDate.getMonth() + 1) + '/' + firstDate.getDate() + '/' + (firstDate.getFullYear() - 2000);
                    }

                    // console.log(productss[i].hours);
                }


                console.log('productss', productss);
                $arr['products'] = productss;
                $arr['countProducts'] = productss.length;
                // $arr['categories'] = result[2][0];

                common.tplFile('product_list.tpl');
                common.headerSet(0);
                common.loadTemplateHeader(req, res, $arr);

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }

    } else {
        return false;
    }

});

app.get('/winner', function (req, res) {

    var module = require('../module');

    $arr['externalcss'] = ['penny'];

    function processIndex(row) {
        $arr['projects'] = row['projects'];
        common.tplFile('winner.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }

    $arr.projects = module.winnerProducts(req, config.mysql, processIndex);

});

app.post('/search', function (req, res) {

    var module = require('../module');

    function processIndex(row) {
        common.processIndexajax(row, req, res, $arr);
    }

    $arr.projects = module.searcher(req, config.mysql, processIndex);

});

app.get('/future', function (req, res) {
    $arr.pagetitle = 'Future Auctions';
    $arr.ptitle = 'future';
    var module = require('../module');

    function processIndex(row) {
        common.processIndex(row, req, res, $arr);
    }

    $arr.projects = module.future(config.mysql, processIndex);
});

app.get('/closed', function (req, res) {
    $arr.pagetitle = 'Closed Auctions';
    $arr.ptitle = 'closed';
    var module = require('../module');

    function processIndex(row) {
        common.processIndex(row, req, res, $arr);
    }

    $arr.projects = module.closed(config.mysql, processIndex);
});

app.get('/shop', function (req, res) {
    $arr.ptitle = 'shop';
    $arr.pagetitle = 'Buy Now Auctions';
    $arr['buy_this'] = true;
    var module = require('../module');

    function processIndex(row) {
        common.processIndex(row, req, res, $arr);
    }

    $arr.projects = module.shop(config.mysql, processIndex);
});

app.get(['/reviews'], function (req, res) {

    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : '';
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }
    var q = require('q');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    var admin = require('../module/admin');
    var pagination = require('pagination');
    $arr['externalcss'] = ['star-rating',];
    $arr['externaljs'] = ['star-rating'];
    $arr['reviewaction'] = false;

    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();

    q.all([admin.allreviews(req, config.mysql, q, 0), admin.allreviews(req, config.mysql, q, 1)]).then(function (result) {
        $arr['review'] = result[0][0];
        $arr['reviews'] = result[1][0].length;
        var paginator = new pagination.SearchPaginator({
            prelink: '/reviews/',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['reviews']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('reviews.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/how_it'], function (req, res) {

    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }
    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();

    admin = require('../module/admin');
    req.body.id = 6;
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr.externalcss = ['home_1'];
        $arr['content'] = results[0][0][0];
        common.tplFile('static_pages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post(['/dispute'], function (req, res) {

    common.checkLogin(req, res, 0);
    var dispute = require('../module/dispute');
    var q = require('q');

    q.all([dispute.addDispute(req, config.mysql, q)]).then(function (results) {
        res.writeHead(302, {
            'Location': '/dispute/submitted'
        });
        res.end();
        return false;
    });
});

app.get(['/dispute', '/dispute/:action'], function (req, res) {
    var q = require('q');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    var admin = require('../module/admin');
    var pagination = require('pagination');
    $arr['action_sent'] = (typeof (req.param('action')) === 'undefined') ? false : true;
    $arr['externalcss'] = ['star-rating',];
    $arr['externaljs'] = ['star-rating'];
    $arr['reviewaction'] = false;

    q.all([admin.reviews_dispute(req, config.mysql, q, 0), admin.reviews_dispute(req, config.mysql, q, 1)]).then(function (result) {
        $arr['review'] = result[0][0];
        $arr['reviews'] = result[1][0].length;
        common.tplFile('dispute.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });

});

app.get(['/terms'], function (req, res) {

    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }
    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();
    admin = require('../module/admin');
    req.body.id = 4;
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr.externalcss = ['home_1'];
        $arr['heading_common'] = "Terms &amp; Conditions";
        $arr['content'] = results[0][0][0].content;
        common.tplFile('static_pages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });


});
app.get(['/policies'], function (req, res) {

    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }
    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();
    admin = require('../module/admin');
    req.body.id = 4;
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr.externalcss = ['home_1'];
        $arr['heading_common'] = "Policies";
        $arr['content'] = results[0][0][0].content;
        common.tplFile('static_pages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });


});

app.get(['/about'], function (req, res) {

    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }
    $arr['heading_common'] = "About Us";

    admin = require('../module/admin');
    req.body.id = 1;
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr.externalcss = ['home_1'];
        $arr['content'] = results[0][0][0].content;
        common.tplFile('static_pages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/about/buyers'], function (req, res) {
    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }
    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();

    admin = require('../module/admin');
    req.body.id = 3;
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr.externalcss = ['home_1'];
        $arr['content'] = results[0][0][0];
        common.tplFile('static_pages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.get('/sublevelcategory/:id', function (req, res) {
    var products = require('../module/products');
    q.all([products.getCategory(req, $arr.config.mysql, q)]).then(function (results) {
        q.all([products.subLevelCategory(req, $arr.config.mysql, q, results[0][0][0]['lft'], results[0][0][0]['rgt'])]).then(function (results) {
            res.send(JSON.stringify(results[0][0]));
            res.end();
            return false;
        });
    });
});
app.get('/subcategory/:id', function (req, res) {
    var products = require('../module/products');
    q.all([products.subCategory(req, $arr.config.mysql, q)]).then(function (results) {

        if (results[0][0].length > 0) {
            $arr.level = results[0][0][0]['depth'];
            $arr.categories = results[0][0];
            common.tplFile('category-box.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        } else {
            res.send('-');
            res.end();
            return false;
        }
    });
});
app.post(['/contact'], function (req, res) {

    var ctype = $arr.ctype = typeof(req.param('type')) != 'undefined' ? req.param('type') : ''; 

    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }

    var fs = require('fs'),
        ini = require('ini');

    // var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    // var contact_email = 
    // var contact_email = configed['section']['general'][''];

    message = require('../module/message');
    q = require('q');
    $arr['heading_common'] = "Contact Us";

    var dat = require('date-util');
    //req.body.toemail = result[0][0][0]['email'];
    console.log(req.body);
    req.body.toemail = global.general.contactus;
    req.body.fromemail = global.general.adminemail;

    // req.body.pid = 1;
    req.body.contactus = true;
    req.body.r_id = Date.parse(new Date()) / 1000;
    // message.addmessages(req, config.mysql, q);
    message.addContactMessage(req, config.mysql, q);
    $arr.message = 'Your message has been submitted to the admin!';
    $arr.externalcss = ['home_1'];
    $arr.externaljs = ['jquery.mask.min'];

    res.writeHead(302, {
        'Location': '/contact'
    });
    res.end();
    return false;

    // common.tplFile('contactus.tpl');
    // common.headerSet(1);
    // common.loadTemplateHeader(req, res, $arr);

});

app.get(['/about/contacts', '/contact'], function (req, res) {

    var ctype = $arr.ctype = typeof(req.param('type')) != 'undefined' ? req.param('type') : '';
    console.log("$arr.ctype ---------- " + $arr.ctype) ;

    if (req.session.ref && req.session.media) {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    } else {
        var referals = (typeof (req.param('ref')) !== 'undefined') ? req.param('ref') : 0;
        var media = (typeof (req.param('med')) !== 'undefined') ? req.param('med') : '';
        req.session.ref = referals;
        req.session.media = media;

        $arr.refers = req.session.ref;
        $arr.med = req.session.media;

    }
    $arr['heading_common'] = "Contact Us";

    $arr.externaljs = ['jquery.mask.min'];
    $arr.externalcss = ['home_1'];
    common.tplFile('contactus.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.get(['/sellers'], function (req, res) {
    if (req.session.ref != 0 && req.session.media != '') {
        $arr.refers = req.session.ref;
        $arr.med = req.session.media;
    } else {
        $arr.refers = 0;
        $arr.med = '';
    }
    Recaptcha = require('recaptcha').Recaptcha;
    //  var PUBLIC_KEY  = config.captachapublickey,
    //  PRIVATE_KEY = config.captachaprivatekey;
    var PUBLIC_KEY = '6LdmdRgUAAAAAMWqOfgkwVwyLg_XUNM1hJMf8gXC',
        PRIVATE_KEY = '6LdmdRgUAAAAAK8FBx02XmX2zq95dEvjAxs7Qkff';


    var recaptcha = new Recaptcha(PUBLIC_KEY, PRIVATE_KEY);
    $arr.captchahtml = recaptcha.toHTML();

    admin = require('../module/admin');
    req.body.id = 2;
    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr.externalcss = ['home_1'];
        $arr['content'] = results[0][0][0];
        common.tplFile('static_pages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/blog/', '/blog/:id'], function (req, res) {
    $arr.ptitle = 'Blogs';
    req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    $arr.pagetitle = 'Site Blogs';
    var module = require('../module');
    var common = require('../module/common');
    var pagination = require('pagination');

    req.body.limit = 10;

    function processIndex(row) {
        if (req.body.id > 0) {
            $arr.blog = row[0][0];
            $arr.rblog = row[1];
            common.tplFile('showblog.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        } else {
            try {
                $arr.blog = row[0];
                $arr.rblog = row[1];

                $arr['pagination'] = row[2].length;

                var paginator = new pagination.SearchPaginator({
                    prelink: '/blog',
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();
                common.tplFile('bloglist.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            } catch (e) {
                console.log("Error in blog " + e.stack);
            }
        }
    }

    if (req.body.id > 0) {
        module.showblog(req, config.mysql, processIndex);
    } else {
        module.blog(req, config.mysql, processIndex);
    }
});


app.post('/changetheme', function (req, res) {
    if (typeof (req.session.themeno) !== 'undefined') {
        delete req.session.themeno;
        req.session.themeno = req.body.themeno;
    } else {
        req.session.themeno = req.body.themeno;
    }
    res.writeHead(302, {
        'Location': req.body.gopage
    });
    res.end();
    return false;
});

app.get('/updatecurrencyRate', function (req, res) {
    //cron to update currency rate
    var oxr = require('open-exchange-rates'),
        fx = require('money');
    oxr.set({ app_id: 'cd897a1fc5c44799babb7cb9d145edb1' });
    var admin = require('../module/admin');
    q.all([admin.getDefaultCurrency(req, config.mysql, q)]).then(function (results) {
        console.log(results[0][0][1].abb);

        oxr.latest(function () {
            var rate = 0;
            fx.base = "USD";
            fx.rates = oxr.rates;
            if (results[0][0].length > 0) {
                for (var i = 0; i < results[0][0].length; i++) {
                    rate = fx.convert(1.00, { from: "USD", to: results[0][0][i].abb })
                    admin.updateCurrencyrate(req, config.mysql, q, results[0][0][i].id, rate);
                }

            }

        });
    });
    res.end();
    return false;

});

app.get('/checkbidtime', function (req, res) {

    req.body.cnt = 0;
    req.body.cnt2 = 0;
    unpaid = require('../module/unpaid');
    message = require('../module/message');

    /*Unlist Memebers */

    q.all([unpaid.unlistmembers(req, config.mysql, q, 0)]).then(function (resultsx) {
        for (var j = 0; j < resultsx[0][0].length; j++) {
            notpaid = resultsx[0][0][j];

            //console.log(notpaid);

            req.body.projectid = resultsx[0][0][j].project_id;
            req.body.userid = resultsx[0][0][j].user_id;
            req.body.bidid = resultsx[0][0][j].id;
            unpaid.extendtime(req, config.mysql, q);
            unpaid.declinebid(req, config.mysql, q);
            unpaid.debuynow(req, config.mysql, q);
            unpaid.deinvoice(req, config.mysql, q);
            unpaid.deproxy(req, mysql, q);
            //console.log(req.body.projectid+'-'+resultsx[0][0][j].user_id+'-'+resultsx[0][0][j].id);
        }

    });

    q.all([unpaid.unlistmembers(req, config.mysql, q, 1)]).then(function (resultsx) {

        for (var k = 0; k < resultsx[0][0].length; k++) {

            outdated = resultsx[0][0][k];
            req.body.projectid = resultsx[0][0][k].project_id;
            req.body.userid = resultsx[0][0][k].user_id;
            unpaid.declinebid(req, config.mysql, q);
            unpaid.debuynow(req, config.mysql, q);
            unpaid.deinvoice(req, config.mysql, q);
            unpaid.deproxy(req, mysql, q);
        }

    });

    res.end();
    return false;


});

app.get('/directbuy', function (req, res) {

    if (common.checkLogin(req, res, 0)) {
        adwords = require('../module/adwords');
        req.body.name = (typeof (req.body.name) !== 'undefined') ? req.body.name : '';
        q.all([
            stores.getstoreid(req, config.mysql, q),
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'product_carousol'),
            adwords.directbuy_box(req, config.mysql, q, 'top_seller'),
            adwords.directbuy_box(req, config.mysql, q, 'trending'),
            adwords.directbuy_box(req, config.mysql, q, 'movers')
        ]).then(function (result) {
            if (result[0][0].length > 0) {
                $arr['storeid'] = result[0][0][0].id;
            } else {
                $arr['storeid'] = 0;
            }
           
            $arr['name'] = '';
            $arr['product_carousol'] = result[1][0];

            for(var f= 0; f < $arr['product_carousol'].length; f++){
                var allBanner = $arr['product_carousol'][f].banner.split(','); 
                var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                $arr['product_carousol'][f].banner = allBanner[index]
            }


            $arr['products'] = result[1][0];
            $arr['top_sellers'] = result[2][0];
            $arr['trending'] = result[3][0];
            $arr['top_movers'] = result[4][0];
            common.tplFile('direct_buy.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});

app.post('/directbuy', function (req, res) {

    if (common.checkLogin(req, res, 0)) {
        adwords = require('../module/adwords');
        req.body.name = (typeof (req.body.name) !== 'undefined') ? req.body.name : '';
        q.all([
            stores.getstoreid(req, config.mysql, q),
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'featured'),
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'brand'),
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'suppliers'), //replce stores with suppliers
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'product'),
            adwords.directbuy_box(req, config.mysql, q, 'top_seller'),
            adwords.directbuy_box(req, config.mysql, q, 'trending'),
            adwords.directbuy_box(req, config.mysql, q, 'movers')
        ]).then(function (result) {
            console.log('len', result[1][0].length);
            if (result[0][0].length > 0) {
                $arr['storeid'] = result[0][0][0].id;
            } else {
                $arr['storeid'] = 0;
            }
            $arr['name'] = (typeof (req.body.name) !== 'undefined') ? req.body.name : '';
            $arr['featured_store'] = result[1][0];
            

            $arr['brand'] = result[2][0];
            $arr['featured_suppliers'] = result[3][0];
            $arr['featured_accessories'] = result[4][0];
            $arr['top_sellers'] = result[5][0];
            $arr['trending'] = result[6][0];
            $arr['top_movers'] = result[7][0];
            common.tplFile('direct_buy.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }

});


app.get('/featuredStores', function (req, res) {
    if (common.checkLogin(req, res, 0)) {

        $arr['heading_common'] = "Featured Stores";
        req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
        req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';

        adwords = require('../module/adwords');
        req.body.title = (typeof (req.body.name) !== 'undefined') ? req.body.title : '';
        q.all([
            adwords.featuredStores(req, config.mysql, q, 0),
            adwords.featuredStores(req, config.mysql, q, 1)
        ]).then(function (result) {
            console.log(1);
            $arr['name'] = '';
            $arr['featured_store'] = result[0][0];
            $arr['pagination'] = result[1][0].length;
            console.log(3);
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: 'javascript:paginationSearch',
                current: req.body.page,
                rowsPerPage: 12,
                totalResult: result[1][0].length,
                ajax: true
            });
            $arr['pagination_html'] = paginator.render();

            common.tplFile('featuredstores.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });

    }
});

app.post('/featuredStoresajax', function (req, res) {

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';
    //common.checkLogin(req, res, 0);
    console.log(1);
    adwords = require('../module/adwords');
    q.all([
        stores.getstoreid(req, config.mysql, q),
        adwords.featuredStores(req, config.mysql, q, 0),
        adwords.featuredStores(req, config.mysql, q, 1)
    ]).then(function (result) {
        $arr.stores = result[1][0];

        console.log(2);
        $arr['pagination'] = result[2][0].length;
        console.log(3);
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page,
            rowsPerPage: 12,
            totalResult: result[2][0].length,
            ajax: true
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('fstore-ajax.tpl');
        common.headerSet(0);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get('/directbuy/virtualmall', function (req, res) {
    //common.checkLogin(req, res, 0);
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    if (common.checkLogin(req, res, 0)) {
        req.body.db_virtualmall = true;
        q.all([
            stores.viewAllStores(req, config.mysql, q, 0),
            stores.viewAllStores(req, config.mysql, q, 1)
        ]).then(function (results) {
            $arr.stores = results[0][0];
            console.log('$arr.stores', $arr.stores);

            // console.log(2);
            $arr['pagination'] = results[1][0].length;
            // console.log(3);
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: 'javascript:paginationSearch',
                current: req.body.page,
                rowsPerPage: 12,
                totalResult: results[1][0].length,
                ajax: true
            });
            $arr['pagination_html'] = paginator.render();
            $arr['heading_common'] = "virtual mall";
            // console.log(4);
            common.tplFile('virtualmall.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
            // console.log(5);
        });
    }
    // console.log(1);

});

app.post('/virtualMallajax', function (req, res) {

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    //common.checkLogin(req, res, 0);
    console.log(1);
    q.all([stores.viewAllStores(req, config.mysql, q, 0), stores.viewAllStores(req, config.mysql, q, 1)]).then(function (results) {
        $arr.stores = results[0][0];

        console.log(2);
        $arr['pagination'] = results[1][0].length;
        console.log(3);
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page,
            rowsPerPage: 12,
            totalResult: results[1][0].length,
            ajax: true
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('virtual_mall-ajax.tpl');
        common.headerSet(0);
        common.loadTemplateHeader(req, res, $arr);
    });
});



app.get('/logclear', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var fs = require('fs')
    path = arr_temp.config.path + '/public/images/herbiespro.log'; // Path for your log file

    fs.truncate(path, 0, function (err) {
        if (err) {
            console.error(err);
        }
        console.log("File truncated successfully");
        res.end('File truncated successfully');
        return false;

    })
});

app.get('/remainder', function (req, res) {

    req.body.cnt = 0;
    req.body.cnt2 = 0;
    unpaid = require('../module/unpaid');
    message = require('../module/message');


    /*Unlist Memebers */

    q.all([unpaid.unlistmembers(req, config.mysql, q, 0)]).then(function (resultsx) {
        for (var j = 0; j < resultsx[0][0].length; j++) {
            notpaid = resultsx[0][0][j];

            //console.log(notpaid);

            req.body.projectid = resultsx[0][0][j].project_id;
            req.body.userid = resultsx[0][0][j].user_id;
            req.body.bidid = resultsx[0][0][j].id;
            unpaid.extendtime(req, config.mysql, q);
            unpaid.declinebid(req, config.mysql, q);
            unpaid.debuynow(req, config.mysql, q);
            unpaid.deinvoice(req, config.mysql, q);
            unpaid.deproxy(req, config.mysql, q);
            //console.log(req.body.projectid+'-'+resultsx[0][0][j].user_id+'-'+resultsx[0][0][j].id);

        }

    });

    q.all([unpaid.unlistmembers(req, config.mysql, q, 1)]).then(function (resultsx) {

        for (var k = 0; k < resultsx[0][0].length; k++) {

            outdated = resultsx[0][0][k];

            req.body.projectid = resultsx[0][0][k].project_id;
            req.body.userid = resultsx[0][0][k].user_id;
            unpaid.declinebid(req, config.mysql, q);
            unpaid.debuynow(req, config.mysql, q);
            unpaid.deinvoice(req, config.mysql, q);
            unpaid.deproxy(req, config.mysql, q);


        }


    });

    q.all([unpaid.listmembers(req, config.mysql, q)]).then(function (results) {
        products = require('../module/products');
        if (results[0][0].length > 0) {
            for (var i = 0; i <= results[0][0].length; i++) {

                details = results[0][0][i];
                req.body.details = details;
                req.body.first_name = details.first_name;

                delete customerio;
                localm = require('../module/localmail');
                twillio = require('../module/twillio');

                console.log(details.first_name);

                q.all([products.usermailnotify(req, config.mysql, q, details.user_id, 16), products.usersmsnotify(req, config.mysql, q, details.user_id, 19), unpaid.listmembersbyid(req, config.mysql, q, details.user_id, details.project_id), localm.mailtemps(req, config.mysql, q, 'winner_remainder'), twillio.smstemps(req, config.mysql, q, 'winner_remainder')]).then(function (checking) {

                    //console.log(checking[2][0][0]);
                    details2 = checking[2][0][0];
                    if (checking[0][0].length > 0) {

                        // if (global.emailcio.status == 'yes') {



                        //     console.log(details2);
                        //     customerio = require('../module/customerio');
                        //     customerio.uid = details2.user_id;
                        //     customerio.inits();
                        //     customerio.createCustomer({ email: details2.email, user: { firstName: details2.first_name, lastName: details2.last_name } });
                        //     customerio.sendEmail({ event: 'winner_remainder', content: { siteurl: config.url, user: details2.first_name + ' ' + details2.last_name, title: details2.title, price: 1 * (details2.proposed_amount + details2.shipping_price), url: global.url + '/product/payment/' + details2.project_id } });




                        // } else 
                        if (global.emaillocal.status == 'yes') {





                            if (checking[3][0][0]) {



                                var template = checking[3][0][0].template;
                                var subject = checking[3][0][0].subject;
                                console.log('details2.title');
                                console.log(details2.title);

                                template = template.replace('{{event.title}}', details2.title);
                                template = template.replace('{{event.siteurl}}', config.url);
                                template = template.replace('{{event.user}}', details2.first_name + ' ' + details2.last_name);
                                template = template.replace('{{event.price}}', 1 * (details2.proposed_amount + details2.shipping_price));
                                template = template.replace('{{event.url}}', global.url + '/product/payment/' + details2.project_id);
                                template = template.replace('{{event.title}}', details2.title);

                                localm.sendmail(template, subject, details2.email);

                            } else {

                                console.log("No template named winner_remainder");
                            }




                        } else { console.log('No Mail Delivery method is selected'); }
                    } else {

                        console.log('Email method is not selected for Bid Remainder' + details2.email);
                    }

                    if (checking[1][0].length > 0) {

                        console.log('*************************************************');
                        if (global.smstwo.status == 'yes') {





                            if (checking[4][0].length > 0) {


                                var template = checking[4][0][0].template;
                                console.log(template);
                                template = template.replace('{{event.siteurl}}', config.url);
                                template = template.replace('{{event.user}}', details2.first_name + ' ' + details2.last_name);
                                template = template.replace('{{event.title}}', details2.title);
                                template = template.replace('{{event.price}}', 1 * (details2.proposed_amount + details2.shipping_price));
                                template = template.replace('{{event.title}}', details2.title);

                                twillio.sendsms(template, details2.phone);

                            } else {

                                console.log('No template name winner_remainder')
                            }

                        }
                    } else {

                        console.log('SMS template not selected for winner_remainder' + details2.email)
                    }

                });

            }
        }




    });

    res.end();
    return false;

});


app.get(['/ajaxquestions/:cid/:pid', '/ajaxquestions/:cid'], function (req, res) {
    var q = require('q');
    req.body.pid = (typeof (req.param('pid')) === 'undefined') ? 0 : req.param('pid');

    q.all([common.categoriesAllQuestion(req, config.mysql, q), common.productQuestion(req, config.mysql, q)]).then(function (results) {

        $arr.questions = results[0][0];
        $arr.answers = results[1][0];

        for (i in $arr.questions) {
            $arr.questions[i]['multiple'] = $arr.questions[i]['value'].split('|');
            $arr.questions[i]['values'] = [$arr.questions[i]['default']];

            if ($arr.answers.length > 0) {
                for (j in $arr.answers) {
                    if ($arr.questions[i]['id'] == $arr.answers[j]['question_id']) {
                        $arr.questions[i]['values'] = $arr.answers[j]['value'].split(',');
                    }
                }
            }

        }

        common.tplFile('aquestions.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.get('/verifyno', function (req, res) {
    var dashboard = require('../module/dashboard');
    var accountSid = global.smstwo.sid;
    var authToken = global.smstwo.token;

    //require the Twilio module and create a REST client
    var client = require('twilio')(accountSid, authToken);
    req.body.phno = (typeof (req.param('p')) === 'undefined') ? 0 : req.param('p');
    client.outgoingCallerIds.create({
        friendlyName: req.session.first_name,
        phoneNumber: req.body.phno,
        statusCallback: global.url + "/events?id=" + req.session.userid,

    }, function (err, callerId) {

        if (err) {

            if (err.code == 21450) {
                req.body.Called = req.body.phno;
                req.body.uid = req.session.userid;
                dashboard.verified_phone(req, config.mysql, q);
                console.log(err);
                res.send(err.message);
            } else {
                console.log(err);
                res.send(err.message);
            }
            return false;
        } else {

            console.log(callerId);
            res.send(callerId.validation_code);
            return false;

        }


    });


    console.log('message sent')

});

app.post('/events', function (req, res) {
    var dashboard = require('../module/dashboard');

    console.log('*********************' + req.body.VerificationStatus + req.param('id') + req.body.FriendlyName);
    if (req.body.VerificationStatus == 'success') {
        req.body.phno = req.body.Called;
        req.body.uid = req.param('id');
        dashboard.verified_phone(req, config.mysql, q);
        res.writeHead(302, {
            'Location': '/dashboard/notification_manager'
        });

    } else {

        res.writeHead(302, {
            'Location': '/dashboard/notification_manager'
        });

    }
    res.end();
    return false;

});

/*app.get('/',function(req,res){

 });*/

app.get('/load_state/:country_id', function (req, res) {
    var q = require('q');
    req.body.cid = (typeof (req.param('country_id')) === 'undefined') ? 0 : req.param('country_id');

    q.all(common.getState(req, config.mysql, q)).then(function (results) {
        $arrState = results[0];
        var str = '';
        //console.log($arrState);
        str = '<select class="form-control" name="state" id="state" data-parsley-required-message="Please select state">';
        str += '<option value="" selected>Select State </option>'
        try {
            for (i in $arrState) {
                //console.log("Res is " + JSON.stringify($arrState[i]['state']));
                str += '<option value="' + $arrState[i]['state'] + '">' + $arrState[i]['state'] + '</option>';
            }
            str += '</option>'
            res.send(str);
        } catch (e) {
            console.log("Error in getting state" + e);
        }
    });

});
app.get('/unsubscribe_email/:user_id', function (req, res) {
    var user = require('../module/user');
    req.body.user_id = (typeof (req.param('user_id')) == 'undefined') ? 0 : req.param('user_id');
    if (req.body.user_id > 0) {
        q.all(user.unsub_user(req, config.mysql, q)).then(function (results) {
            res.writeHead(302, {
                'Location': '/unsub_success/success'
            });
            res.end();
            return false;
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        res.writeHead(302, {
            'Location': '/'
        });
        res.end();
        return false;
    }
});

app.get('/carurl', function (req, res) {
    //res.jsonp(req.param('callback')+'('+JSON.stringify(+{'url':$arr.config.common.url})+');');
    res.send(req.param('callback') + "(" + JSON.stringify({ 'url': $arr.config.common.url }) + ");");
    res.end();
    return false;
});
app.get('/test_paypal', function (req, res) {
    var Paypal = require('paypal-adaptive');
    var paypalSdk = new Paypal({
        appId: config.paypal.paypal_api,
        userId: config.paypal.paypal_username,
        password: config.paypal.paypal_password,
        signature: config.paypal.paypal_signature,
        sandbox: (config.paypal.sandbox == 'yes') ? true : false
    });
    var params = {
        transactionId: '5C124053M1672983B'
    };
    var tid = '5C124053M1672983B';
    var payload = {
        requestEnvelope: {
            errorLanguage: 'en_US',
            detailLevel: 'ReturnAll'
        },

        currencyCode: 'USD',

        cancelUrl: config.url + '/paypal/cancelbulkurl',
        returnUrl: config.url + '/paypal/successbulkurl',
        ipnNotificationUrl: config.url + '/paypal/successrefund/' + tid,
        transactionId: tid
    };


    paypalSdk.refund(payload, function (err, response) {
        if (err) {
            //callback(err, response);
            console.log(err);
            console.log(response);

        } else {
            //callback(err, response);
            console.log(err);

            console.log(response.refundInfoList);

            console.log(response.refundInfoList.refundInfo);
            console.log(response);
        }
    });



    /*paypalSdk.refund(params, function (err, response) {
        if (err) {
            console.log(err);
            console.log(response);
        } else {
            // payments details for this payKey, transactionId or trackingId
            console.log("******************** In payment details *********************");
            console.log(response);

            console.log("******************** 22222222 *********************");
            console.log(response.refundInfoList);

            console.log("******************** 333333333 *********************");
            console.log(response.refundInfoList.refundInfo);
        }
    });*/
});

app.get('/test_sp', function (req, res) {

    var upsAPI = require('shipping-ups');
    ups.pickup({
        rate_pickup_indicator: 'Y',
        shipper_account: 'ABC123',
        pickup_date: '20141223',
        eariest_time_ready: '0800',
        latest_time_ready: '1200',
        pickup_address: {
            company_name: 'Pat Stewart',
            contact_name: 'Pat Stewart',
            address_line_1: '2311 York Road',
            city: 'Timonium',
            state_code: 'MD',
            postal_code: '21093',
            country_code: 'US',
            phone_number: '5555555555'
        },
        weight: 5.5,
        pickup_piece: [{
            service_code: '003',
            quantity: 1,
            container_code: '01'
        }],
        payment_method: '01'
    }, function (err, res) {
        if (err) {
            return console.log(util.inspect(err, { depth: null }));
        }

        console.log(util.inspect(res, { depth: null }));
    });

});

app.post('/bidplace', function (req, res) {
    if (common.checkLogin(req, res, 0)) {

        var allow = common.checkPermission('bid_limit', req);

        if (!allow) {
            res.json({ 'error': true, 'success': 0, membership_status: false, bid_counts: 0 });
            res.end();
            return false;
        }

        /* need to add condition to check whether negotiable is placed before or not */

        bids = require('../module/bid');
        q.all([bids.checkbidplace(req, config.mysql, q)]).then(function (bidsPlaced) {
            console.log('bids placed status');
            // console.log(JSON.stringify(bidsPlaced));
            console.log(JSON.stringify(bidsPlaced[0][0].length));
            if (bidsPlaced[0][0].length == 0) {
                q.all([bids.bidplace(req, config.mysql, q)]).then(function (results) {
                    $bidid = results[0][0].insertId;
                    if ($bidid) {
                        localm = require('../module/localmail');

                        /* req.body.product_id = req.body.pdtid;
                        q.all([bids.getProductAndSellerDetail(req, config.mysql, q), localm.mailtemps(req, config.mysql, q, 'place_bid_negotiable')]).then(function (results2) {
                            if (results2) {
                                var template = results2[1][0][0].template;
                                console.log('template', template);
                                var subject_message = results2[1][0][0].subject;
                                console.log('subject_message', subject_message);
                                console.log('results2[0][0][0]', results2[0][0][0]);
                                var activeurl = '<a href="' + $arr.config.spath + 'dashboard/seller/negotiation">Click Here</a>';

                                template = template.replace('{{event.sitename}}', config.title);
                                template = template.replace('{{event.activeurl}}', activeurl);
                                template = template.replace('{{event.subject}}', subject_message);
                                template = template.replace('{{event.user}}', results2[0][0][0].first_name + ' ' + results2[0][0][0].last_name);
                                localm.sendmail(template, subject_message, 'divesh@auctionsoftware.com');
                            } else {
                                console.log("No Templates named register");
                            }
                        }).fail(function (err) {
                            console.log(err.stack);
                            throw err;
                        }); */

                        res.json({ 'error': false, 'success': 1, membership_status: true, bid_counts: bidsPlaced[0][0].length });
                    } else {
                        res.json({ 'error': true, 'success': 0, membership_status: true, bid_counts: bidsPlaced[0][0].length });
                    }
                    res.end();
                    return false;
                });
            } else {
                res.json({ 'error': true, 'success': 0, membership_status: true, bid_counts: bidsPlaced[0][0].length });
                return false;
            }

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        })

    }
});

app.post('/getchildcat', function (req, res) {
    admin = require('../module/admin');
    var id = req.body.catid;
    if (id == '') { id = "-1"; }
    q.all([admin.getChildCategory(req, config.mysql, q, id)]).then(function (results) {
        var crdt = results[0][0];
        if (crdt.length > 0) {
            res.send(JSON.stringify({ 'error': false, 'subcat': crdt }));
        } else {
            res.send(JSON.stringify({ 'error': true, 'subcat': '' }));
        }
        res.end();
        return false;
    });
});

app.post('/btncheckrecur', function (req, res) {
    var prodRequests = require('../module/prod_requests');
    var rid = req.body.rid;
    q.all([prodRequests.btncheckrecurup(req, config.mysql, q, rid)]).then(function (results) {
        var crdt = results[0][0].affectedRows;
        if (crdt.length > 0) {
            res.send(JSON.stringify({ 'error': false, 'success': 1 }));
        } else {
            res.send(JSON.stringify({ 'error': false, 'success': 0 }));
        }
        res.end();
        return false;
    });
});

app.post('/btnacceptnego', function (req, res) {
    var prodRequests = require('../module/prod_requests');
    var bid = req.body.bid;
    var pid = req.body.pid;
    var qty = req.body.qty;
    // mysqli['checprocount'] = 'select qty from projects where id = ?';
    q.all([
        prodRequests.checprocount(req, config.mysql, q, pid)
    ]).then(function (result) {

        console.log("product details :--- ", JSON.stringify(result[0][0]));

        /* checking quantity here */
        var count = result[0][0][0].qty - result[0][0][0].sold - result[0][0][0].booked;
        req.body.remain_qty = count - qty;
        console.log("counttttttttt" + count);
        var gmoney = require('../module/greenmoney');
        if (count >= qty) {
            // mysqli['btnacceptnegomd'] = 'UPDATE negotiable SET awarded = 1 WHERE id = ?';
            // mysqli['negoamt'] = 'SELECT * from negotiable   where id=?';
            q.all([
                prodRequests.btnacceptnegom(req, config.mysql, q, bid),
                prodRequests.getnegoamt(req, config.mysql, q, bid)
            ]).then(function (results) {

                var crdt = results[0][0].affectedRows;
                var bamt = results[1][0][0].proposed_amount;
                var negoData = results[1][0];
                var prdt = result[0][0];
                console.log("products details here -------------- : " + JSON.stringify(prdt));
                console.log("products details here -------------- : " + JSON.stringify(negoData));
                // prodRequests.makeBoughtnego(req, config.mysql, q, pid, bamt, qty);
                if (crdt > 0) {

                    var gmoneyObj = [];
                    req.body.qty = prdt[0].qty;
                    req.body.amount = negoData[0].amount;
                    req.body.unit_price = negoData[0].amount;


                    if (prdt[0].stax > 0) {
                        gmoneyObj.stax_status = 'y';
                    } else {
                        gmoneyObj.stax_status = 'n';
                    }

                    gmoneyObj.stax_per = prdt[0].stax;

                    /* for buynow updation */
                    gmoneyObj.qty = negoData[0].qty_request;
                    gmoneyObj.amount = negoData[0].proposed_amount;

                    /* commission percentage  */
                    gmoneyObj.commission = parseFloat(global.general.commission_fee);
                    /* total amount qty * amt */
                    gmoneyObj.total_amount = parseFloat(gmoneyObj.amount) * parseFloat(gmoneyObj.qty)
                    /* calculating stax amt using stax percentage */
                    gmoneyObj.stax_amt = gmoneyObj.total_amount * (parseFloat(gmoneyObj.stax_per) / 100);

                    /* ===================== start change by divyesh (changes) ===================== */
                    /* calculating sales consultant fee amt using sales consultant fee percentage */
                    gmoneyObj.consultant_fee = prdt[0].consultant_fee;
                    gmoneyObj.consultant_fee_amount = gmoneyObj.total_amount * (parseFloat(gmoneyObj.consultant_fee) / 100);

                    /* calculating commission amount */
                    gmoneyObj.commission_amt = gmoneyObj.total_amount * (parseFloat(global.general.commission_fee) / 100);
                    /* Calculating final total amount */
                    gmoneyObj.total_amount = parseFloat(gmoneyObj.total_amount + gmoneyObj.commission_amt + gmoneyObj.stax_amt + gmoneyObj.consultant_fee_amount);
                    /* ===================== end change by divyesh (changes) ===================== */

                    gmoneyObj.project_id = negoData[0].project_id;
                    gmoneyObj.accept = 1;
                    gmoneyObj.request_id = negoData[0].id;

                    gmoneyObj.user_id = negoData[0].user_id;
                    gmoneyObj.request_userid = req.session.userid;
                    /* for Negotiable request gmoneyObj.negotiable must be 1 otherwise 0*/
                    gmoneyObj.negotiable = 1;

                    // [Tue Nov 14 2017 16:31:34] [LOG]   [102912000] insert into buynow (user_id,project_id,qty,amount,com
                    // mission_per,accept, request_id, date_added, total_amount, commission, stax_status, stax_per, stax_am
                    // t,paid,request_userid ) values(28,23,NULL,10,1.5,1,23,'2017-11-14 16:31:34',NaN,NaN,12,NaN,NaN,0,27)
                    // in buynow table for negotiable cart should be 0 for now we can update when payment is over
                    // mysqli['insert_buynow'] = 'insert into buynow (user_id,project_id,qty,amount,commission_per,accept, request_id, date_added, total_amount, commission, stax_status, stax_per, stax_amt,paid,request_userid {{cart_id}}) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?{{cart_id_value}})';
                    // mysqli['btnaccept_declinemax'] = 'UPDATE negotiable SET declined = 1 WHERE qty_request > ? and project_id=?';

                    q.all([
                        gmoney.insertBuynow(req, config.mysql, q, gmoneyObj),
                        prodRequests.declineRemainMax(req, config.mysql, q)
                    ]).then(function (decStatus) {

                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    })

                    /* updating sold quantity (adding requested quantity to sold if payment is not done in certain time limit then 
                    request should canceled and sold product should add to qty again) */

                    prodRequests.updateprojectqty(req, config.mysql, q, pid, qty);

                    // mysqli['checprocount'] = 'select qty from projects where id = ?';
                    // mysqli['getprobid'] = 'SELECT * from negotiable   where project_id = ? and awarded!=1';
                    q.all([prodRequests.checprocount(req, config.mysql, q, pid),
                    prodRequests.getprobid(req, config.mysql, q, pid)
                    ]).then(function (result) {
                        var ncount = result[0][0][0].qty;
                        var prdct = result[1][0][0];
                        for (i in prdct) {
                            bcunt = prdct['qty_request'];
                            if (bcunt > ncount) {
                                // mysqli['updatebidstatus'] ='UPDATE negotiable SET declined = 1 WHERE id = ?';
                                prodRequests.updatebidstatus(req, config.mysql, q, prdct['id']);
                            }
                        }
                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    })

                    console.log("qqqqqqqqqqqqqqqqqq" + crdt);

                }
                if (crdt > 0) {

                    console.log("wwwwwwwwwwwwwwwwww" + crdt);
                    res.send(JSON.stringify({ 'error': false, 'success': 1 }));

                } else {

                    console.log("eeeeeeeeeeeeee" + crdt);
                    res.send(JSON.stringify({ 'error': false, 'success': 0 }));

                }

                res.end();
                return false;

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            })
        } else {

            console.log("sdfsdfsdfdsf" + count);
            res.send(JSON.stringify({ 'error': false, 'success': 0, 'count': count }));

        }

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    })
});

// app.post('/btnacceptnego', function(req, res) {
//     var prodRequests = require('../module/prod_requests');
//     var bid = req.body.bid;
//     var pid = req.body.pid;
//     var qty = req.body.qty;
//     q.all([prodRequests.checprocount(req, config.mysql, q, pid)]).then(function(result) {
//         var count = result[0][0][0].qty;
//         console.log("counttttttttt" + count);
//         if (count >= qty) {
//             q.all([prodRequests.btnacceptnegom(req, config.mysql, q, bid)]).then(function(results) {
//                 var crdt = results[0][0].affectedRows;
//                 if (crdt > 0) {

//                     q.all([prodRequests.declineRemainMax(req, config.mysql, q)]).then(function(decStatus) {
//                         console.log('declined another' + JSON.stringify(decStatus));
//                     }).fail(function(err) {
//                         console.log(err.stack);
//                         throw err;
//                     })

//                     prodRequests.updateprojectqty(req, config.mysql, q, pid, qty);

//                     q.all([prodRequests.checprocount(req, config.mysql, q, pid), prodRequests.getprobid(req, config.mysql, q, pid)]).then(function(result) {
//                         var ncount = result[0][0][0].qty;
//                         var prdct = result[1][0][0];
//                         for (i in prdct) {
//                             bcunt = prdct['qty_request'];
//                             if (bcunt > ncount) {
//                                 prodRequests.updatebidstatus(req, config.mysql, q, prdct['id']);
//                             }
//                         }
//                     });
//                     console.log("qqqqqqqqqqqqqqqqqq" + crdt);

//                 }
//                 if (crdt > 0) {
//                     console.log("wwwwwwwwwwwwwwwwww" + crdt);
//                     res.send(JSON.stringify({ 'error': false, 'success': 1 }));
//                 } else {
//                     console.log("eeeeeeeeeeeeee" + crdt);
//                     res.send(JSON.stringify({ 'error': false, 'success': 0 }));
//                 }
//                 res.end();
//                 return false;
//             });
//         } else {
//             console.log("sdfsdfsdfdsf" + count);
//             res.send(JSON.stringify({ 'error': false, 'success': 0, 'count': count }));
//         }

//     });
// });

app.post('/btnrejectnego', function (req, res) {
    var prodRequests = require('../module/prod_requests');
    bids = require('../module/bid');

    var bid = req.body.bid;
    req.body.negotiable_id = bid;
    q.all([prodRequests.btnrejectnegom(req, config.mysql, q, bid), bids.getNegotiableAndBuyerDetail(req, config.mysql, q)]).then(function (results) {
        var crdt = results[0][0].affectedRows;
        var buyer_data = results[1][0][0];
        if (crdt > 0) {

            /* var activeurl = '<a href="' + $arr.config.spath + 'dashboard/dbmarket/rejectorder">Click Here</a>';
            localm = require('../module/localmail');

            if (global.emaillocal.status == 'yes') {
                q.all([localm.mailtemps(req, config.mysql, q, 'reject_bid_negotiable')]).then(function(results2) {
                    console.log('results2', results2);
                    if (results2) {
                        var template = results2[0][0][0].template;
                        var subject_message = results2[0][0][0].subject;

                        template = template.replace('{{event.activeurl}}', activeurl);
                        template = template.replace('{{event.user}}', buyer_data.first_name+' '+buyer_data.last_name);
                        template = template.replace('{{event.subject}}', subject_message);
                        localm.sendmail(template, subject_message, buyer_data.email);
                    } else {
                        console.log("No Templates named reject_bid_negotiable");
                    }

                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                });

            } else { console.log('No Mail Delivery method is selected'); } */
            
            res.send(JSON.stringify({ 'error': false, 'success': 1 }));
        } else {
            res.send(JSON.stringify({ 'error': false, 'success': 0 }));
        }
        res.end();
        return false;
    });
});
app.post('/btnrejectnegomesg', function (req, res) {
    var prodRequests = require('../module/prod_requests');
    var bid = req.body.bid;
    req.body.negotiable_id = bid;
    var rmesg = req.body.rmesg;
    q.all([prodRequests.btnrejectnegomesgm(req, config.mysql, q, bid), bids.getNegotiableAndBuyerDetail(req, config.mysql, q)]).then(function (results) {
        var crdt = results[0][0].affectedRows;
        var buyer_data = results[1][0][0];
        if (crdt > 0) {

            /* var activeurl = '<a href="' + $arr.config.spath + 'dashboard/dbmarket/rejectorder">Click Here</a>';
            localm = require('../module/localmail');

            if (global.emaillocal.status == 'yes') {
                q.all([localm.mailtemps(req, config.mysql, q, 'reject_bid_negotiable')]).then(function(results2) {
                    console.log('results2', results2);
                    if (results2) {
                        var template = results2[0][0][0].template;
                        var subject_message = results2[0][0][0].subject;

                        template = template.replace('{{event.activeurl}}', activeurl);
                        template = template.replace('{{event.user}}', buyer_data.first_name+' '+buyer_data.last_name);
                        template = template.replace('{{event.subject}}', subject_message);
                        localm.sendmail(template, subject_message, buyer_data.email);
                    } else {
                        console.log("No Templates named reject_bid_negotiable");
                    }

                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                });

            } else { console.log('No Mail Delivery method is selected'); } */

            res.send(JSON.stringify({ 'error': false, 'success': 1 }));
        } else {
            res.send(JSON.stringify({ 'error': false, 'success': 0 }));
        }
        res.end();
        return false;
    });
});
app.get('/newsfeed', function (req, res) {
    //common.checkLogin(req, res, 0);
    var feed = require("feed-read");
    var feed2 = require("feed-read");
    feed("https://www.cannabisbusinessexecutive.com/feed/", function (err, articles) {
        if (err) throw err;
        var k = [];
        var art = [];
        for (i in articles) {
            //console.log(articles[i]);
            //k[i] = articles[i].title;
            k.push(articles[i]);
        }
        feed2("https://mjbizdaily.com/feed/", function (err, articles) {
            if (err) throw err;
            var k2 = [];
            var art2 = [];
            for (i in articles) {
                //console.log(articles[i]);
                //k[i] = articles[i].title;
                k2.push(articles[i]);
            }
            // Each article has the following properties:
            //
            //   * "title"     - The article title (String).
            //   * "author"    - The author's name (String).
            //   * "link"      - The original article link (String).
            //   * "content"   - The HTML content of the article (String).
            //   * "published" - The date that the article was published (Date).
            //   * "feed"      - {name, source, link}
            //
            $arr['news'] = k;
            $arr['news2'] = k2;
            common.tplFile('news.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
            console.log(5);
        });
    });


});
app.post('/relationinterest', function (req, res) {
    var message = require('../module/message');
    var inbid = req.body.inbid;
    q.all([message.relationinterestc(req, config.mysql, q, inbid)]).then(function (results) {
        var crdt = results[0][0].affectedRows;
        if (crdt.length > 0) {
            res.send(JSON.stringify({ 'error': false, 'success': 1 }));
        } else {
            res.send(JSON.stringify({ 'error': false, 'success': 0 }));
        }
        res.end();
        return false;
    });
});
app.post('/relationntinterest', function (req, res) {
    var message = require('../module/message');
    var inbid = req.body.inbid;
    q.all([message.relationntinterestc(req, config.mysql, q, inbid)]).then(function (results) {
        var crdt = results[0][0].affectedRows;
        if (crdt.length > 0) {
            res.send(JSON.stringify({ 'error': false, 'success': 1 }));
        } else {
            res.send(JSON.stringify({ 'error': false, 'success': 0 }));
        }
        res.end();
        return false;
    });
});
app.post('/bustargetcount', function (req, res) {
    var message = require('../module/message');
    //var inbid = req.body.inbid;
    q.all([message.bustargetcount(req, config.mysql, q)]).then(function (results) {
        console.log('target', results[0][0]);
        var crdt = results[0][0][0].countuser;
        if (crdt > 0) {
            res.send(JSON.stringify({ 'countuser': crdt, 'success': 1 }));
        } else {
            res.send(JSON.stringify({ 'countuser': crdt, 'success': 0 }));
        }
        res.end();
        return false;
    });
});


app.get('/featuredBrands', function (req, res) {
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';
    //common.checkLogin(req, res, 0);
    adwords = require('../module/adwords');
    req.body.title = (typeof (req.body.name) !== 'undefined') ? req.body.title : '';
    q.all([adwords.featuredBrands(req, config.mysql, q, 0), adwords.featuredBrands(req, config.mysql, q, 1)]).then(function (result) {
        console.log(1);
        $arr['name'] = '';
        $arr['featured_store'] = result[0][0];
        $arr['pagination'] = result[1][0].length;
        console.log(3);
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page,
            rowsPerPage: 12,
            totalResult: result[1][0].length,
            ajax: true
        });
        $arr['pagination_html'] = paginator.render();

        common.tplFile('featuredbrand.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get('/featuredsuppliers', function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
        req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';

        adwords = require('../module/adwords');
        req.body.title = (typeof (req.body.name) !== 'undefined') ? req.body.title : '';
        q.all([
            adwords.featuredsupplier(req, config.mysql, q, 0),
            adwords.featuredsupplier(req, config.mysql, q, 1)
        ]).then(function (result) {
            console.log(1);
            $arr['name'] = '';
            $arr['featured_store'] = result[0][0];
            $arr['pagination'] = result[1][0].length;
            $arr['heading_common'] = "Featured Suppliers";
            console.log(3);
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: 'javascript:paginationSearch',
                current: req.body.page,
                rowsPerPage: 12,
                totalResult: result[1][0].length,
                ajax: true
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('featuredsupp.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});

app.get('/featuredaccessories', function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
        req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';
        //common.checkLogin(req, res, 0);
        adwords = require('../module/adwords');
        req.body.title = (typeof (req.body.name) !== 'undefined') ? req.body.title : '';
        q.all([adwords.featuredaccessories(req, config.mysql, q, 0), adwords.featuredaccessories(req, config.mysql, q, 1)]).then(function (result) {
            console.log(1);
            $arr['name'] = '';
            $arr['featured_store'] = result[0][0];
            $arr['pagination'] = result[1][0].length;
            $arr['heading_common'] = "Featured Products &amp; Accessories";
            console.log(3);
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: 'javascript:paginationSearch',
                current: req.body.page,
                rowsPerPage: 12,
                totalResult: result[1][0].length,
                ajax: true
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('featuredaccess.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});
app.post('/featuredBrandajax', function (req, res) {

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';
    //common.checkLogin(req, res, 0);
    console.log(1);
    adwords = require('../module/adwords');
    q.all([stores.getstoreid(req, config.mysql, q), adwords.featuredBrands(req, config.mysql, q, 0), adwords.featuredBrands(req, config.mysql, q, 1)]).then(function (result) {
        $arr.stores = result[1][0];

        console.log(2);
        $arr['pagination'] = result[2][0].length;
        console.log(3);
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page,
            rowsPerPage: 12,
            totalResult: result[2][0].length,
            ajax: true
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('fbrand-ajax.tpl');
        common.headerSet(0);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.post('/featuredSupplierajax', function (req, res) {

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';
    //common.checkLogin(req, res, 0);
    console.log(1);
    adwords = require('../module/adwords');
    q.all([stores.getstoreid(req, config.mysql, q), adwords.featuredsupplier(req, config.mysql, q, 0), adwords.featuredsupplier(req, config.mysql, q, 1)]).then(function (result) {
        $arr.stores = result[1][0];

        console.log(2);
        $arr['pagination'] = result[2][0].length;
        console.log(3);
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page,
            rowsPerPage: 12,
            totalResult: result[2][0].length,
            ajax: true
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('fsupplier-ajax.tpl');
        common.headerSet(0);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.post('/featuredaccessajax', function (req, res) {

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';
    //common.checkLogin(req, res, 0);
    console.log(1);
    adwords = require('../module/adwords');
    q.all([stores.getstoreid(req, config.mysql, q), adwords.featuredaccessories(req, config.mysql, q, 0), adwords.featuredaccessories(req, config.mysql, q, 1)]).then(function (result) {
        $arr.stores = result[1][0];

        console.log(2);
        $arr['pagination'] = result[2][0].length;
        console.log(3);
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page,
            rowsPerPage: 12,
            totalResult: result[2][0].length,
            ajax: true
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('faccess-ajax.tpl');
        common.headerSet(0);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.post('/dbuystore', function (req, res) {
    if (common.checkLogin(req, res, 0)) {
        var adwords = require('../module/adwords');
        req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
        req.body.title = (typeof (req.body.title) !== 'undefined') ? req.body.title : '';
        adwords = require('../module/adwords');
        req.body.name = (typeof (req.body.name) !== 'undefined') ? req.body.name : '';


        function updateview(id) {
            q.all([adwords.get_ads_track_impree(req, $arr.config.mysql, q, id)]).then(function (result2) {

                req.body.tid = 0;
                if (result2[0][0].length > 0) {
                    req.body.tid = result2[0][0][0].id;
                }
                adwords.updateimpreesadsclick(req, $arr.config.mysql, q, id);
            });
        }

        req.body.db_virtualmall = true;
        q.all([
            stores.getstoreid(req, config.mysql, q),
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'featured'),
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'brand'),
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'suppliers'),
            adwords.directbuy_ads(req, config.mysql, q, 'Direct_Buy_Market', 'product'),
            adwords.directbuy_box(req, config.mysql, q, 'top_seller'),
            adwords.directbuy_box(req, config.mysql, q, 'trending'),
            adwords.directbuy_box(req, config.mysql, q, 'movers'),
            stores.viewAllStores(req, config.mysql, q, 1)
        ]).then(function (result) {

            if (result[0][0].length > 0) {
                $arr['storeid'] = result[0][0][0].id;
            } else {
                $arr['storeid'] = 0;
            }

            if (req.body.ajax == 1) {
                var resultssss1 = _.pluck(result[1][0], 'id');
                var resultssss2 = _.pluck(result[2][0], 'id');
                var resultssss3 = _.pluck(result[3][0], 'id');
                var resultssss4 = _.pluck(result[4][0], 'id');
                var finalresult = resultssss1.concat(resultssss2, resultssss3, resultssss4);
                adwords.updateimpreesclick(req, $arr.config.mysql, q, finalresult);
                //adwords.updateimpreesclick(req, $arr.config.mysql, q, resultssss2);
                //adwords.updateimpreesclick(req, $arr.config.mysql, q, resultssss3);
                //adwords.updateimpreesclick(req, $arr.config.mysql, q, resultssss4);
                for (i in finalresult) {
                    // console.log("hjhj");
                    // console.log(finalresult[i]);
                    updateview(finalresult[i]);
                }
            }

            $arr['name'] = (typeof (req.body.name) !== 'undefined') ? req.body.name : '';
            $arr['featured_store'] = result[1][0];
            $arr['brand'] = result[2][0];
            $arr['featured_suppliers'] = result[3][0];
            $arr['featured_accessories'] = result[4][0];
            $arr['products'] = result[4][0];
            $arr['top_sellers'] = result[5][0];
            $arr['trending'] = result[6][0];
            $arr['top_movers'] = result[7][0];
            $arr['virtual_mall'] = result[8][0];

            for(var s= 0; s < $arr['featured_store'].length; s++){
                var allBanner = $arr['featured_store'][s].banner.split(','); 
                var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                $arr['featured_store'][s].banner = allBanner[index]
            }
            for(var b= 0; b < $arr['brand'].length; b++){
                var allBanner = $arr['brand'][b].banner.split(','); 
                var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                $arr['brand'][b].banner = allBanner[index]
            }
            for(var p= 0; p < $arr['products'].length; p++){
                var allBanner = $arr['products'][p].banner.split(','); 
                var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                $arr['products'][p].banner = allBanner[index]
            }

            for(var f= 0; f < $arr['featured_accessories'].length; f++){
                var allBanner = $arr['featured_accessories'][f].banner.split(','); 
                var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                $arr['featured_accessories'][f].banner = allBanner[index]
            }

            common.tplFile('direct_buyajax.tpl');
            common.headerSet(0);
            common.loadTemplateHeader(req, res, $arr);

        });
    }
});

app.post('/deletestorepdts', function (req, res) {
    var message = require('../module/message');
    //var inbid = req.body.inbid;
    q.all([stores.storedeletepdt(req, config.mysql, q)]).then(function (results) {
        var arow = results[0][0].affectedRows;
        if (arow > 0) {
            res.send(JSON.stringify({ 'success': 1 }));
        } else {
            res.send(JSON.stringify({ 'success': 0 }));
        }
        res.end();
        return false;
    });
});

module.exports = app;