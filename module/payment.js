var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var self = require('./payment');
var q = require('q');
var products = require('./products');
var dateFormat = require('dateformat');
//var configure = require('../configure');
var sessionsdata = [];
//default setters
/*config = configure.app();*/
var customerid = 0;
var paymentprofileid = 0;
var transactionid = 0;
var gateway = 'account';
var amount = 0.00;
var payid = 0;
var name = '';
var point = 0;
var buynow_id = 0;
var req = '';
var res = '';
var type = '';
var qty = '';
var cart_id = 0;
var buyer = [];
var seller = [];
var admin_user = [];
var rec_cancelseller_per = 0.00;
var rec_cancelseller_amt = 0.00;
var rec_canceladmin_per = 0.00;
var rec_canceladmin_amt = 0.00;
var rec_id = '';


exports.insertInvoice = function(req) {

    console.log('insertInvoice')

    $mysqli = {};
    mysql = config.mysql;

    status = 'debit';
    ustatus = 'paid';


    if (self.type == 'sold') {
        status = 'credit';
    }
    if(self.type=='refer_promo'){
        status = 'credit';   
    }
    if (self.type == 'manual_payment' || self.type == "refund_ad_payment") {
        if(parseFloat(self.amount) <= 0){
            self.amount = Math.abs(self.amount);
            status = 'debit';    
        } else status = 'credit';
    }
    if (self.type == 'rec_cancellation') {
        status = 'debit';
    }
    if (self.type == 'wire_payment' || self.type == 'check_payment') {
        status = 'credit';
    }
    if (self.type == 'refund_request') {
        status = 'debit';
    }
    if (self.type == 'holded' || self.type == 'declined') {
        status = self.type;
    }
    if (self.type == 'winner' || self.type == 'bought') {

        customerio = require('./customerio');

        ustatus = 'unpaid';

        localm = require('./localmail');
        q.all([products.checkmailnotify(req, config.mysql, q, 4), products.checksmsnotify(req, config.mysql, q, 4)]).then(function(results) {
            if (results[0][0].length > 0) {
                // if (global.emailcio.status == 'yes') {

                //     customerio.uid = self.sessionsdata.userid;
                //     customerio.inits();
                //     customerio.createCustomer({ email: self.sessionsdata.email, user: { firstName: self.sessionsdata.first_name, lastName: self.sessionsdata.last_name } });
                //     customerio.sendEmail({ event: 'won_product', content: { siteurl: config.url, user: self.sessionsdata.first_name + ' ' + self.sessionsdata.last_name, price: self.amount, title: self.sessionsdata.title, url: self.sessionsdata.url } });

                // } else
                if (global.emaillocal.status == 'yes') {

                    q.all([localm.mailtemps(req, config.mysql, q, 'won_product')]).then(function(results2) {

                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;

                        template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        template = template.replace('{{event.price}}', self.amount);
                        template = template.replace('{{event.title}}', self.sessionsdata.title);
                        template = template.replace('{{event.url}}', self.sessionsdata.url);
                        // console.log(template);
                        localm.sendmail(template, subject, self.sessionsdata.email);

                    });

                } else { console.log('No Mail Delivery method is selected'); }

            } else { console.log('Notification off'); }
        });



    }

    if (self.type == 'sold') {

        // delete customerio;
        // customerio = require('./customerio');
        localm = require('./localmail');

        q.all([products.checkmailnotify(req, config.mysql, q, 6), products.checksmsnotify(req, config.mysql, q, 13)]).then(function(results) {
            if (results[0][0].length > 0) {
                // if (global.emailcio.status == 'yes') {

                //     customerio = require('./customerio');
                //     customerio.uid = self.sessionsdata.userid;

                //     customerio.inits();
                //     customerio.createCustomer({ email: self.sessionsdata.email, user: { firstName: self.sessionsdata.first_name, lastName: self.sessionsdata.last_name } });
                //     customerio.sendEmail({ event: 'item_sold', content: { siteurl: config.url, user: self.sessionsdata.first_name + ' ' + self.sessionsdata.last_name, price: self.amount, title: self.sessionsdata.title, url: self.sessionsdata.url } });


                // } else 
                if (global.emaillocal.status == 'yes') {


                    q.all([localm.mailtemps(req, config.mysql, q, 'item_sold')]).then(function(results2) {

                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;

                        // template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        // template = template.replace('{{event.price}}', self.amount);
                        // template = template.replace('{{event.title}}', self.sessionsdata.title);
                        // template = template.replace('{{event.url}}', self.sessionsdata.url);
                        //  console.log(template);
                        template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        template = template.replace('{{event.price}}', self.amount);
                        template = template.replace('{{event.title}}', self.sessionsdata.title);
                        template = template.replace('{{event.url}}', self.sessionsdata.url);
                        template = template.replace('{{event.bname}}', self.buyer.first_name + ' ' + self.buyer.last_name);
                        template = template.replace('{{event.bemail}}', self.buyer.email);
                        template = template.replace('{{event.bphone}}', self.buyer.phone);
                        template = template.replace('{{event.qty}}', self.qty);

                        /*                Item  qty : {{event.qty}}
                        Buyer Name : {{event.bname}}
                        Buyer Email : {{event.bemail}}
                        Buyer Phone : {{event.bphone}}


                        */
                        // console.log(template);
                        localm.sendmail(template, subject, self.sessionsdata.email);


                    });

                } else { console.log('No Mail Delivery method is selected'); }
            } else { console.log('Notification off'); }

        });

    }

    if (self.type == 'package') {

        delete customerio;

        localm = require('./localmail');
        // customerio = require('./customerio');
        q.all([products.checkmailnotify(req, config.mysql, q, 7), products.checksmsnotify(req, config.mysql, q, 14)]).then(function(results) {
            if (results[0][0].length > 0) {
   
                if (global.emaillocal.status == 'yes') {


                    q.all([localm.mailtemps(req, config.mysql, q, 'package_bought')]).then(function(results2) {

                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;

                        template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        template = template.replace('{{event.pack_name}}', self.name);
                        template = template.replace('{{event.price}}', self.amount);
                        //  console.log(template);
                        localm.sendmail(template, subject, req.session.email);


                    });

                } else { console.log('No Mail Delivery method is selected'); }
            } else { console.log('Notification off'); }

       
        });

    }

    if (self.type == 'membership')  {
        console.log('membership here')
        console.log(JSON.stringify(self));
        delete customerio;
        if (self.temtype && self.temtype !=1 && self.temtype  !=''){
        localm = require('./localmail');
        // customerio = require('./customerio');
        q.all([products.checkmailnotify(req, config.mysql, q, 7), products.checksmsnotify(req, config.mysql, q, 14)]).then(function(results) {
            if (results[0][0].length > 0) {

                if (global.emaillocal.status == 'yes') {
                    q.all([localm.mailtemps(req, config.mysql, q, 'package_bought')]).then(function(results2) {

                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;
                        template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata.last_name);
                        template = template.replace('{{event.pack_name}}', self.name);
                        template = template.replace('{{event.price}}', self.amount);


                        localm.sendmail(template, subject, self.sessionsdata.email);

                    });

                } else { console.log('No Mail Delivery method is selected'); }
            } else { console.log('Notification off'); }

            if (global.smstwo.status == 'yes') {



            }
        });

    }
    }


    if (self.type == 'refund_reserve_amount') {

        // delete customerio;
        // customerio = require('./customerio');
        localm = require('./localmail');
        q.all([products.checkmailnotify(req, config.mysql, q, 6), products.checksmsnotify(req, config.mysql, q, 13)]).then(function(results) {
            if (results[0][0].length > 0) {


                if (global.emaillocal.status == 'yes') {


                    q.all([localm.mailtemps(req, config.mysql, q, 'item_sold')]).then(function(results2) {

                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;



                        // template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        // template = template.replace('{{event.price}}', self.amount);
                        // template = template.replace('{{event.title}}', self.sessionsdata.title);
                        // template = template.replace('{{event.url}}', self.sessionsdata.url);
                        //  console.log(template);
                        template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        template = template.replace('{{event.price}}', self.amount);
                        template = template.replace('{{event.title}}', self.sessionsdata.title);
                        template = template.replace('{{event.url}}', self.sessionsdata.url);
                        template = template.replace('{{event.bname}}', self.buyer.first_name + ' ' + self.buyer.last_name);
                        template = template.replace('{{event.bemail}}', self.buyer.email);
                        template = template.replace('{{event.bphone}}', self.buyer.phone);
                        template = template.replace('{{event.qty}}', self.qty);

                        /*                Item  qty : {{event.qty}}
                        Buyer Name : {{event.bname}}
                        Buyer Email : {{event.bemail}}
                        Buyer Phone : {{event.bphone}}


                        */
                        // console.log(template);
                        localm.sendmail(template, subject, self.sessionsdata.email);


                    });

                } else { console.log('No Mail Delivery method is selected'); }
            } else { console.log('Notification off'); }

          
        });

    }
    if (self.type == 'refund_ad_payment') {
        console.log('refund_ad_payment');

        localm = require('./localmail');
        // q.all([products.checkmailnotify(req, config.mysql, q, 6), products.checksmsnotify(req, config.mysql, q, 13)]).then(function(results) {
            console.log('refund_ad_payment -- under mail template');

                if (global.emaillocal.status == 'yes') {


                    q.all([localm.mailtemps(req, config.mysql, q, 'ads_refund')]).then(function(results2) {

                        
                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;
                        template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata.last_name);
                        template = template.replace('{{event.pack_name}}', self.name);
                        template = template.replace('{{event.price}}', self.amount);

                        localm.sendmail(template, subject, self.sessionsdata.email);

                    }).fail(function(err) {
                                console.log(err.stack);
                                // throw err;
                            }).done();

                } else { console.log('No Mail Delivery method is selected'); }

            console.log('refund_ad_payment ------ end email');

    }

    if (self.type == 'wire_payment') {

        delete customerio;
        // customerio = require('./customerio');
        localm = require('./localmail');
        q.all([products.checkmailnotify(req, config.mysql, q, 6), products.checksmsnotify(req, config.mysql, q, 13)]).then(function(results) {
            if (results[0][0].length > 0) {

                if (global.emaillocal.status == 'yes') {


                    q.all([localm.mailtemps(req, config.mysql, q, 'item_sold')]).then(function(results2) {

                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;

                        // template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        // template = template.replace('{{event.price}}', self.amount);
                        // template = template.replace('{{event.title}}', self.sessionsdata.title);
                        // template = template.replace('{{event.url}}', self.sessionsdata.url);
                        //  console.log(template);

                        template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        template = template.replace('{{event.price}}', self.amount);
                        template = template.replace('{{event.title}}', self.sessionsdata.title);
                        template = template.replace('{{event.url}}', self.sessionsdata.url);
                        template = template.replace('{{event.bname}}', self.buyer.first_name + ' ' + self.buyer.last_name);
                        template = template.replace('{{event.bemail}}', self.buyer.email);
                        template = template.replace('{{event.bphone}}', self.buyer.phone);
                        template = template.replace('{{event.qty}}', self.qty);

                        /*
                            Item  qty : {{event.qty}}
                            Buyer Name : {{event.bname}}
                            Buyer Email : {{event.bemail}}
                            Buyer Phone : {{event.bphone}}
                        */

                        // console.log(template);
                        localm.sendmail(template, subject, self.sessionsdata.email);

                    });

                } else { console.log('No Mail Delivery method is selected'); }
            } else { console.log('Notification off'); }

        });

    }

    if (self.type == 'check_payment') {

        delete customerio;
        // customerio = require('./customerio');
        localm = require('./localmail');
        q.all([products.checkmailnotify(req, config.mysql, q, 6), products.checksmsnotify(req, config.mysql, q, 13)]).then(function(results) {
            if (results[0][0].length > 0) {
                
                if (global.emaillocal.status == 'yes') {

                    q.all([localm.mailtemps(req, config.mysql, q, 'item_sold')]).then(function(results2) {

                        var template = results2[0][0][0].template;
                        var subject = results2[0][0][0].subject;

                        template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                        template = template.replace('{{event.price}}', self.amount);
                        template = template.replace('{{event.title}}', self.sessionsdata.title);
                        template = template.replace('{{event.url}}', self.sessionsdata.url);
                        template = template.replace('{{event.bname}}', self.buyer.first_name + ' ' + self.buyer.last_name);
                        template = template.replace('{{event.bemail}}', self.buyer.email);
                        template = template.replace('{{event.bphone}}', self.buyer.phone);
                        template = template.replace('{{event.qty}}', self.qty);

                        localm.sendmail(template, subject, self.sessionsdata.email);

                    });

                } else { console.log('No Mail Delivery method is selected'); }
            } else { console.log('Notification off'); }

        });

    }

    if (self.type == 'refund_request') {

        localm = require('./localmail');

       
        if (global.emaillocal.status == 'yes') {


            q.all([localm.mailtemps(req, config.mysql, q, 'refund_request')]).then(function(results2) {

                var template = results2[0][0][0].template;
                var subject = results2[0][0][0].subject;

               

                template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                template = template.replace('{{event.price}}', self.amount);
                template = template.replace('{{event.title}}', self.sessionsdata.title);
                template = template.replace('{{event.url}}', self.sessionsdata.url);
                template = template.replace('{{event.bname}}', self.buyer.first_name + ' ' + self.buyer.last_name);
                template = template.replace('{{event.bemail}}', self.buyer.email);
                template = template.replace('{{event.bphone}}', self.buyer.phone);
                template = template.replace('{{event.qty}}', self.qty);

                localm.sendmail(template, subject, self.sessionsdata.email);

            });

        } else { console.log('No Mail Delivery method is selected'); }

    }
    if (self.type == 'ad_payment') {

        // delete customerio;
        // customerio = require('./customerio');
        localm = require('./localmail');

        
        if (global.emaillocal.status == 'yes') {


            q.all([localm.mailtemps(req, config.mysql, q, 'ad_payment')]).then(function(results2) {

                var template = results2[0][0][0].template;
                var subject = results2[0][0][0].subject;

               

                template = template.replace('{{event.user}}', self.sessionsdata.first_name + ' ' + self.sessionsdata);
                template = template.replace('{{event.price}}', self.amount);
                template = template.replace('{{event.title}}', self.sessionsdata.title);
                template = template.replace('{{event.url}}', self.sessionsdata.url);
                template = template.replace('{{event.bname}}', self.buyer.first_name + ' ' + self.buyer.last_name);
                template = template.replace('{{event.bemail}}', self.buyer.email);
                template = template.replace('{{event.bphone}}', self.buyer.phone);
                template = template.replace('{{event.qty}}', self.qty);

              
                localm.sendmail(template, subject, self.sessionsdata.email);

            });

        } else { console.log('No Mail Delivery method is selected'); }

    }

    if (self.type == 'refund_reserve_amount') {
        console.log("-----------------------invoice section-----------------------")
        var defered = q.defer();
        strQuery = mysqli.mysqli($mysqli, '31_new');

        var escape_data = [
            self.gateway,
            dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"),
            self.buyer.id,
            self.payid,
            self.type,
            self.name,
            self.amount,
            ustatus,
            status,
            self.buynow_id,
            self.cart_id,
            self.rec_id,
            self.rec_cancellation,
            self.rec_cancelseller_per,
            self.rec_cancelseller_amt,
            self.rec_canceladmin_per,
            self.rec_canceladmin_amt
        ];

        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log("Insert invoice is " + query.sql);
        console.log("Escape is " + escape_data);
        query.on('error', function(err) {
            console.log(err.stack);
            throw err;
        })
        return defered.promise;
    }
    else {
        console.log("-----------------------invoice section-----------------------")
        var defered = q.defer();
        strQuery = mysqli.mysqli($mysqli, 31);
        var escape_data = [
            self.gateway,
            dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"),
            self.buyer.id != null ? self.buyer.id : 0,
            self.payid,
            self.type,
            self.name,
            self.amount,
            ustatus,
            status,
            self.buynow_id,
            self.cart_id
        ];
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log("Insert invoice is " + query.sql);
        console.log("Escape is " + escape_data);
        query.on('error', function(err) {
            console.log(err.stack);
            throw err;
        })
        return defered.promise;
    }

}

exports.getInvoice = function(mysql, q, id) {
    $mysqli = {};
    mysql = config.mysql;
    strQuery = mysqli.mysqli($mysqli, 58);
    var escape_data = [id];
    //console.log(escape_data);

    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    //console.log(1);
    return defered.promise;
}

exports.errorTrigger = function(error, page) {
    self.res.writeHead(302, {
        'Location': '/package/buy/' + self.payid + '/' + encodeURIComponent(error)
    });
    self.res.end();
    return false;
}