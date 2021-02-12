/**
 * Created by Raj on 9/28/2015.
 */

var fs = require('fs');
var mysqli = require('./mysqli');
var common = require('./common');
var dateFormat = require('dateformat');

/* Uypdating refund status for adwords after payment */
// q.all(adwords.changeAdRefundStatus(ads.user_id, ads.id, 1212,config.mysql, q)).then(function(refundStatus) {
exports.generateRandomInteger = function(min, max)  {
    return Math.floor(min + Math.random()*(max + 1 - min))
}

exports.changeAdRefundStatus = function(uId,adId,invId,mysql,q) {

    $mysqli = {}
    var defered = q.defer();
    // mysqli['update_ads_refund_status'] = 'update adwords set refund_status = 1, ref_inv_id = ? where id = ? and user_id = ?';
    strQuery = mysqli.mysqli($mysqli, "update_ads_refund_status");
    var escape_data = [invId,adId,uId];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("changing_refund status -------------------------- "+query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}
/* getting expired adwords with calculated daywise price per click and remaining clicks */
exports.getExpiredAdwords = function(mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, "get_expiredref_ads");
    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log("getting expired ads -------------------------- "+query.sql);
    query.on('error', function(err) {
        throw err;
    });
    return defered.promise;
}


exports.getAdvertiseDetails = function(req, mysql, q, count) {
    $mysqli = {}
    var defered = q.defer();
    var page = req.body.page;
    var perlimit = 5;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }
    $mysqli = { limit: limit };

    strQuery = mysqli.mysqli($mysqli, "get_adwords_details");
    var defered = q.defer();
    var escape_data = [req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}

exports.getAdvertiseDetails2 = function(req, mysql, q, count) {
    $mysqli = {}
    var defered = q.defer();
    var page = req.body.page;
    var sid = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : 0;
    var perlimit = 5;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {
        limit = "";
    }
    if (sid != 0) {
        where = ' AND store_id = ' + sid + '';
    } else {
        where = ' AND store_id != 0';
    }

    $mysqli = { limit: limit, where: where };

    strQuery = mysqli.mysqli($mysqli, "get_adwords_details2");
    var defered = q.defer();
    var escape_data = [req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}

exports.saveAdwords = function(req, mysql, q) {
    console.log('req.body.total_clicks', req.body.total_clicks);
    req.body.id = 0;
    $mysqli = {};
    req.body.target_section = (typeof(req.body.target_section) != 'undefined') ? req.body.target_section.toString() : '';
    req.body.days = (typeof(req.body.days) != 'undefined') ? req.body.days.toString() : '';
    req.body.end_date = (typeof(req.body.end_date) != 'undefined') ? common.changeDateFormat2(req.body.end_date) : '0000-00-00';
    req.body.start_date = (typeof(req.body.start_date) != 'undefined') ? common.changeDateFormat2(req.body.start_date) : '0000-00-00';
    req.body.featured = (typeof(req.body.featured) != 'undefined') ? req.body.featured : 1;
    req.body.product_id = (typeof(req.body.product_id) != 'undefined') ? req.body.product_id : 0;
    req.body.brand_name = (typeof(req.body.brand_name) != 'undefined') ? req.body.brand_name : "";
    req.body.total_clicks = (typeof(req.body.total_clicks) != 'undefined') ? req.body.total_clicks : 0;
    req.body.totalamount = (typeof(req.body.totalamount) != 'undefined') ? req.body.totalamount : 0;
  /*  if (req.body.exist_img) {
        img = '';
        img2 = req.body.exist_img;
    } else {
        img = req.files.ad_image.name;
        img2 = '';
    }*/
   if (typeof(req.files.ad_image) !== 'undefined') {
        fs.unlink(global.path + "/public/uploads/" + req.body.pre_image, function(err) {
            if (!err)
                console.log('successfully deleted ' + req.body.pre_image);
        });
        img = ''
        if(req.files.ad_image.length){
            for(var i =0; i < req.files.ad_image.length; i++){
                if(i == 0){
                    img = img +  req.files.ad_image[i].name
                }else{
                    img = img + "," +  req.files.ad_image[i].name
                }
            }
        }else{
            img = req.files.ad_image.name
        }
        
        console.log(" =============imgimgimg==================== ", img)
        var img2 = '';

    } else {

        var img = '';
        var img2 = req.body.exist_img;
    }
    /*if(req.files.ad_image.name){
      img = req.files.ad_image.name; 
      img2 = ''; 
    }
    else{
         img = ''; 
         img2 = req.body.exist_img;  
    }*/
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    // if(req.session.business_type == 'supplier'){
    //   var adtype = 'supplier';
    // }
    // else{
    var adtype = req.body.ad_type;
    // }
    var defered = q.defer();
    cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    if (req.body.id <= 0) {
        strQuery = mysqli.mysqli($mysqli, "insert_adwords");
        var escape_data = [req.body.ad_name,
            req.body.ad_title,
            req.body.ad_content,
            req.body.ad_url,
            img,
            req.body.show_campaign,
            req.body.days,
            req.body.target_section,
            req.body.keywords,
            global.ads.clickamount,
            req.body.per_day_amount,
            req.session.userid,
            cdate,
            req.body.end_date,
            req.body.storeid,
            req.body.featured,
            adtype,
            req.body.product_id,
            req.body.brand_name,
            img2,
            req.body.start_date,
            req.body.total_clicks,
            req.body.totalamount
        ];

    }

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("saveAdwords "+query.sql);
    query.on('error', function(err) {

        throw err;
    });

    return defered.promise;
};
exports.updatestoreads = function(req, mysql, q, ids) {
   
    var ad_name = (typeof(req.body.sname) != 'undefined') ? req.body.sname : "";
    var ad_title = (typeof(req.body.sname) != 'undefined') ? req.body.sname : "";
    var ad_content = (typeof(req.body.description) != 'undefined') ? req.body.description : "";
    $mysqli = {};
    var defered = q.defer();

    cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, "updatestoreads");
    var escape_data = [ad_name,ad_title,ad_content,ids];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}
exports.updateAdwords = function(req, mysql, q) {
    req.body.end_date = (typeof(req.body.end_date) != 'undefined') ? common.changeDateFormat2(req.body.end_date) : '0000-00-00';
    req.body.start_date = (typeof(req.body.start_date) != 'undefined') ? common.changeDateFormat2(req.body.start_date) : '0000-00-00';
    req.body.target_section = (typeof(req.body.target_section) != 'undefined') ? req.body.target_section.toString() : '';
    req.body.days = (typeof(req.body.days) != 'undefined') ? req.body.days.toString() : '';
    req.body.brand_name = (typeof(req.body.brand_name) != 'undefined') ? req.body.brand_name : "";
    $mysqli = {};
    if (typeof(req.files.ad_image) !== 'undefined') {

        fs.unlink(global.path + "/public/uploads/" + req.body.pre_image, function(err) {
            if (!err)
                console.log('successfully deleted ' + req.body.pre_image);
        });
        img = req.files.ad_image.name;

    } else {

        var img = req.body.exist_img;
    }

    //req.body.end_date = (req.body.show_campaign == 0 ? '' : dateFormat(req.body.end_date,'yyyy-mm-dd') )
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    //req.body.end_date = ;
    var defered = q.defer();

    cdate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, "update_adwords");
    var escape_data = [req.body.ad_name,
        req.body.ad_title,
        req.body.ad_content,
        req.body.ad_url,
        img,
        req.body.show_campaign,
        req.body.days,
        req.body.target_section,
        req.body.keywords,
        req.body.per_click_amount,
        req.body.per_day_amount,
        req.session.userid,
        cdate,
        req.body.end_date,
        req.body.start_date,
        req.body.product_id,
        req.body.brand_name,
        req.body.id
    ];


    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
        query.on('error', function(err) {

        throw err;
    });

    return defered.promise;
}

// Reset No of clicks daily
exports.resetAdwordsDaysClick = function(mysql, q) {
    $mysqli = {};

    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, "reset_no_of_clicks");

    query = mysql.query(strQuery, defered.makeNodeResolver());

    return defered.promise;

}
exports.adwords_op = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, "adwords_delete_pause");

    if (req.body.type == 'active') {
        var escape_data = ['pause', req.body.id, req.session.userid]
    } else if (req.body.type == 'pause') {
        var escape_data = ['active', req.body.id, req.session.userid]
    } else if (req.body.type == 'remove') {
        var escape_data = ['remove', req.body.id, req.session.userid]
    }

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}

exports.getAdwordsById = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, "get_adwords_by_id");

    var escape_data = [req.body.id]

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}

exports.update_deposit = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, "update_deposit");

    var escape_data = [req.body.amount, req.session.userid]

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}


exports.update_deposit_onclick = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    // reduce_deposit = mysqli.mysqli($mysqli, "reduce_deposit");

    // var escape_data = [req.body.budget_per_click, req.body.userid]

    // query = mysql.query(reduce_deposit, escape_data, defered.makeNodeResolver());

    update_ads_clicks = mysqli.mysqli($mysqli, "update_ads_clicks");

    var escape_data = [req.body.id]

    query = mysql.query(update_ads_clicks, escape_data, defered.makeNodeResolver());

    return defered.promise;

}

exports.update_deposit_onclick_day = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    var dateFormat = require('dateformat');

    cur_date = dateFormat(new Date(), 'yyyy-mm-dd');
    var escape_data = [req.body.id, 0, 1, cur_date];
    update_ads_clicks = mysqli.mysqli($mysqli, "insert_ads_clicks_day");
    if (req.body.tid > 0) {
        update_ads_clicks = mysqli.mysqli($mysqli, "update_ads_clicks_day");
        var escape_data = [req.body.tid];
    }



    query = mysql.query(update_ads_clicks, escape_data, defered.makeNodeResolver());

    return defered.promise;

}
exports.get_ads_track = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    var dateFormat = require('dateformat');
    req.body.cur_date = dateFormat(new Date(), 'yyyy-mm-dd');
    strQuery = mysqli.mysqli($mysqli, 'get_ads_track');
    var escape_data = [req.body.cur_date, req.body.id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}
exports.getDeposit = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 25);

    var escape_data = ["deposit_amount", req.session.userid]

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}

exports.show_ads = function(req, mysql, q, type) {
    // Type = Page name ex : dashboard, post_page
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'show_ads');

    var escape_data = [type];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}



exports.current_campaigns = function(req, mysql, q) {
    // Type = Page name ex : dashboard, post_page
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'current_campaigns');

    var escape_data = [req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    query.on('error', function(err) {

        throw err;
    });
    return defered.promise;

}
exports.ads_graphdata2 = function(req, mysql, q) {
    var dateFormat = require('dateformat');
        var predate = new Date();
        predate.setHours(predate.getHours() - 720);
        date1 = dateFormat(predate, 'yyyy-mm-dd HH:MM:ss');
        console.log('date1', date1);
        var todaydate = new Date();
        date2 = dateFormat(todaydate, 'yyyy-mm-dd HH:MM:ss');
        console.log('date2', date2);

    var where= ' and b.date_added BETWEEN "'+date1+'" and "'+date2+'" ';
    $mysqli = {where:where}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'ads_graphdata2');

    var escape_data = [req.session.userid];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);
    query.on('error', function(err) {

        throw err;
    });
    return defered.promise;

}
exports.ads_graphdata = function(req, mysql, q) {
    // Type = Page name ex : dashboard, post_page
    
    var dateFormat = require('dateformat');
        var predate = new Date();
        predate.setHours(predate.getHours() - 720);
        date1 = dateFormat(predate, 'yyyy-mm-dd HH:MM:ss');
        console.log('date1', date1);
        var todaydate = new Date();
        date2 = dateFormat(todaydate, 'yyyy-mm-dd HH:MM:ss');
        console.log('date2', date2);
    var where= ' and at1.date_added BETWEEN "'+date1+'" and "'+date2+'" ';
    cur_date = dateFormat(new Date(), 'yyyy-mm-dd');
    cur_date = (typeof(req.body.end_date) !== 'undefined' && req.body.end_date != "") ? req.body.end_date : cur_date;
    console.log("end_date" + req.body.end_date);
    var d = new Date();
    d.setDate(d.getDate() - req.body.day_diff);
    fdate = dateFormat(d, 'yyyy-mm-dd');
    fdate = (typeof(req.body.start_date) !== 'undefined' && req.body.start_date != "") ? req.body.start_date : fdate;
    $mysqli = {where:where}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'ads_graphdata');

    var escape_data = [req.session.userid, fdate, cur_date];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log("ADS GRAPH DATA -------------"+query.sql);
    query.on('error', function(err) {

        throw err;
    });
    return defered.promise;

}
exports.directbuy_ads = function(req, mysql, q, type, cat) {
    // Type = Page name ex : dashboard, post_page

    where = "";
    inner = "";
    limit = "";

    if (cat == "featured") {
        where = 'and a.type = "store" ';
        limit = "LIMIT 0,4";
        condition = '(ue.business_type!="supplier" and ue.state = ?)'
        //and a.featured=1
    }
    if (cat == "suppliers") {
        where = 'and a.type = "store"   ';
        limit = "LIMIT 0,4";
        condition = '(ue.business_type="supplier")'
    }
    if (cat == "brand") {
        where = 'and a.brand_name != ""   ';
        limit = "LIMIT 0,20";
        inner = ", (SELECT p.unit_price FROM  projects as p where p.id = a.product_id) as price";
        condition = '(ue.business_type="supplier" or ue.state = ?)'
    }

    if (cat == "product") {
        where = 'and a.type ="product" and a.brand_name = ""';
        limit = "LIMIT 0,4";
        inner = ", (SELECT p.unit_price FROM  projects as p where p.id = a.product_id) as price";
        condition = '(ue.business_type="supplier")'
        //and a.featured=1  
    }
    if (cat == "product_carousol") {
        where = 'and a.type ="product" and a.brand_name = ""';
        limit = "LIMIT 0,4";
        inner = ", (SELECT p.unit_price FROM  projects as p where p.id = a.product_id) as price";
        condition = '(ue.business_type!="supplier" and ue.state = ?)'
        //and a.featured=1  
    }
    if (req.body.name != '') {
        where += 'and    a.ad_title like "%' + req.body.name + '%"  or a.brand_name like "%' + req.body.name + '%"  ';
    }

    
    /* if(req.session.business_type != 'producer' && req.session.business_type != 'grower') {
        where += " AND budget_per_day DIV budget_per_click >= no_of_clicks ";
    } */

    $mysqli = {
        where: where,
        innerq: inner,
        limit: limit,
        condition : condition
    }
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'directbuy_ads');

    var escape_data = [type, req.session.state];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log("----------------"+cat);
    console.log(query.sql);
    query.on('error', function(err) {

        throw err;
    });
    return defered.promise;

}

exports.featuredStores = function(req, mysql, q, type) {
    // Type = Page name ex : dashboard, post_page
    // and a.featured=1
    cat = "featuredStores";
    where = "";
    inner = "";
    limit = "";
    page = (req.body.page - 1) * 12;
    where = 'and a.type = "store" ';
    if (type == 0) {

        limit = "LIMIT " + page + ",12";
    }
    if (req.body.title != '') {
        where += 'and    a.ad_title like "%' + req.body.title + '%"  ';
    }
    $mysqli = {
        where: where,
        innerq: inner,
        limit: limit
    }
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'featuredStores');

    var escape_data = [req.session.state];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('featuredStores ', query.sql);
    return defered.promise;

}
exports.directbuy_box = function(req, mysql, q, type) {
    cat = 2;
    qr = 'directbuy_top_sellers';
    if (type == 'movers') {
        qr = 'directbuy_top_movers';
    }
    if (type == 'trending') {
        qr = 'directbuy_trending';
    }
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, qr);
    var escape_data = [];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('=====' + type + '=====' + cat + '=====');
    console.log(query.sql);
    console.log('=====' + type + '== end===' + cat + '=====');
    return defered.promise;
}
exports.addPurchaseClickAds = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    var dateFormat = require('dateformat');
    var predate = new Date();
    var date1 = dateFormat(predate, 'yyyy-mm-dd');    
    strQuery = mysqli.mysqli($mysqli, "purchaseclickads");
    var defered = q.defer();
    var escape_data = [req.session.ads_id, date1];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;

}
exports.addPurchaseClick = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, "purchaseclick");
    var defered = q.defer();
    var escape_data = [req.session.ads_id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;

}
exports.adwords_details = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, "adwords_details");
    var defered = q.defer();
    var escape_data = [req.session.ads_id];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('query', query.sql);
    return defered.promise;

}
exports.getAllAdvertiseDetails = function(req, mysql, q, count) {
    $mysqli = {}
    var defered = q.defer();
    var page = req.body.page;
    var perlimit = 12;
    page = (page > 0) ? (page - 1) * perlimit : 0;
    if (count == 0) {
        var limit = 'limit ' + page + ',' + perlimit;
    } else {

        limit = "";
    }
    $mysqli = { limit: limit };

    strQuery = mysqli.mysqli($mysqli, "get_all_adwords_details");
    var defered = q.defer();
    var escape_data = [req.body.type];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}
exports.featuredBrands = function(req, mysql, q, type) {
    // Type = Page name ex : dashboard, post_page
    // and a.featured=1
    cat = "featuredBrands";
    where = "";
    inner = ", (SELECT p.unit_price FROM  projects as p where p.id = a.product_id) as price";
    limit = "";
    page = (req.body.page - 1) * 12;
    where = 'and a.type = "product" and a.brand_name!=""';
    if (type == 0) {

        limit = "LIMIT " + page + ",12";
    }
    console.log("jhjhjhj");
    console.log(req.body.title);
    if (req.body.title != '') {
        where += 'and    a.brand_name like "%' + req.body.title + '%"  ';
    }
    $mysqli = {
        where: where,
        innerq: inner,
        limit: limit
    }
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'featuredBrands');

    var escape_data = [];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('=====' + type + '=====' + cat + '=====');
    console.log(query.sql);
    console.log('=====' + type + '== end===' + cat + '=====');
    return defered.promise;

}
exports.featuredsupplier = function(req, mysql, q, type) {
    // Type = Page name ex : dashboard, post_page
    // and a.featured=1
    cat = "featuredsupplier";
    where = "";
    inner = "";
    limit = "";
    page = (req.body.page - 1) * 12;
    where = 'and a.type = "store" and a.featured="1"';
    if (type == 0) {

        limit = "LIMIT " + page + ",12";
    }
    if (req.body.title != '') {
        where += 'and  a.ad_title like "%' + req.body.title + '%"  ';
    }
    $mysqli = {
        where: where,
        innerq: inner,
        limit: limit
    }
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'featuredsupplier');

    var escape_data = [];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log('=====' + type + '=====' + cat + '=====');
    console.log(query.sql);
    console.log('=====' + type + '== end===' + cat + '=====');
    return defered.promise;

}
exports.featuredaccessories = function(req, mysql, q, type) {
    // Type = Page name ex : dashboard, post_page
    // and a.featured=1
    cat = "featuredaccessories";
    where = "";
    inner = ", (SELECT p.unit_price FROM  projects as p where p.id = a.product_id) as price";
    limit = "";
    page = (req.body.page - 1) * 12;
    where = 'and a.type = "product" and a.featured="1"';
    if (type == 0) {

        limit = "LIMIT " + page + ",12";
    }
    if (req.body.title != '') {
        where += 'and    a.ad_title like "%' + req.body.title + '%"  ';
    }
    $mysqli = {
        where: where,
        innerq: inner,
        limit: limit
    }
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, 'featuredaccessories');

    var escape_data = [];

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
        query.on('error', function(err) {

        throw err;
    });

    return defered.promise;

}
exports.updateimpreesclick = function(req, mysql, q, ids) {
    $mysqli = {}
    var defered = q.defer();
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, "updateimpressclick");
    var defered = q.defer();
    var escape_data = [ids];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.get_ads_track_impree = function(req, mysql, q, id) {
    $mysqli = {}
    var defered = q.defer();
    var dateFormat = require('dateformat');
    req.body.cur_date = dateFormat(new Date(), 'yyyy-mm-dd');
    strQuery = mysqli.mysqli($mysqli, 'get_ads_track_impree');
    var escape_data = [req.body.cur_date, id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}
exports.updateimpreesadsclick = function(req, mysql, q, id) {
    $mysqli = {}
    var defered = q.defer();
    var dateFormat = require('dateformat');
    cur_date = dateFormat(new Date(), 'yyyy-mm-dd');
    var escape_data = [id, 1, 0, cur_date];
    update_ads_clicks = mysqli.mysqli($mysqli, "updateimpreesadsclick_insert");
    if (req.body.tid > 0) {
        update_ads_clicks = mysqli.mysqli($mysqli, "updateimpreesadsclick_update");
        var escape_data = [req.body.tid];
    }
    query = mysql.query(update_ads_clicks, escape_data, defered.makeNodeResolver());
    return defered.promise;

}
exports.selectstoreadsid = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();
    strQuery = mysqli.mysqli($mysqli, 'selectstoreadsid');
    var escape_data = [req.body.storeid];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}
exports.selectstoreads = function(req, mysql, q, id) {
    $mysqli = {}
    var defered = q.defer();
    var dateFormat = require('dateformat');
    req.body.cur_date = dateFormat(new Date(), 'yyyy-mm-dd');
    strQuery = mysqli.mysqli($mysqli, 'selectstoreads');
    var escape_data = [id];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql + "555555555555555555");
    return defered.promise;

}

exports.selectstorebrand = function(req, mysql, q, id) {
    $mysqli = {}
    var defered = q.defer();
    var dateFormat = require('dateformat');
    req.body.cur_date = dateFormat(new Date(), 'yyyy-mm-dd');
    strQuery = mysqli.mysqli($mysqli, 'selectstorebrand');
    var escape_data = [id, req.body.cur_date];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;

}
exports.selectstorebrandnew = function(req, mysql, q, id) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var defered = q.defer();
    req.body.cur_date = dateFormat(new Date(), 'yyyy-mm-dd');
    //status = 'open';
    where = ' and date_closed >= "' + datge + '" and (market_status = "open" or market_status = "moderate")';
    mys = 15;
    mys = 18;
    if (req.param('cmd') == 'sold') {
        where = ' and (market_status = "sold" or sold > 0)';
    }
    if (req.param('cmd') == 'draft') {
        where = ' and market_status = "draft"';
    }
    if (req.param('cmd') == 'closed') {
        where = '  and market_status NOT IN ("draft","sold")   and ((market_status = "closed")  or date_closed < "' + datge + '")';
    }
    /*if (cnt == 0 && Number(req.body.pids) != 0) {
        where += ' and p.id NOT IN (' + req.body.pids + ')';
    }*/
    $mysqli = { where: where };

    var page = req.body.page;
    var perlimit = req.body.perlimit;
    ////console.log($mysqli);

    $mysqli = { where: where };
    strQuery = mysqli.mysqli($mysqli, 'selectstorebrandnew');
    escape_fields = [req.session.userid, id, req.body.cur_date]

    ////console.log(escape_fields);

    query = mysql.query(strQuery, escape_fields, defered.makeNodeResolver());
    console.log(query.sql);
    console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

    query.on('error', function(err) {

        throw err;
    });

    return defered.promise;
}
exports.adwords_op2 = function(req, mysql, q) {
    $mysqli = {}
    var defered = q.defer();

    strQuery = mysqli.mysqli($mysqli, "adwords_delete_pause2");

    if (req.body.type == 'active') {
        var escape_data = ['pause', req.body.id]
    } else if (req.body.type == 'pause') {
        var escape_data = ['active', req.body.id]
    } else if (req.body.type == 'remove') {
        var escape_data = ['remove', req.body.id]
    }

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    return defered.promise;

}