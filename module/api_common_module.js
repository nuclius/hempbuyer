var mysqli = require('./mysqli');
var dateFormat = require('dateformat');
var moment = require("moment-timezone");

var errorJson = require('../api_errors');

exports.getErrorState = function(errorCode){
    var error_state
    if(errorJson["critical"].indexOf(errorCode) > -1){
        error_state = "critical"
    }
    if(errorJson["minor"].indexOf(errorCode) > -1){
        error_state = "minor"
    }
    if(errorJson["major"].indexOf(errorCode) > -1){
        error_state = "major"
    }
    if(errorJson["issueless"].indexOf(errorCode) > -1){
        error_state = "no issues"
    }
    return error_state
}


exports.checkValidIncrement = function (value) {

    if(typeof(value) === 'undefined' || value == '' || isNaN(value) ||  (typeof(value) !== 'number') && (isNaN(value % 1))) {
        return false;
    }else{
        return true;
    }
}


exports.checkValidNumber = function (value) {

    if(typeof(value) === 'undefined' || value == '' || isNaN(value) || value <= 0 || (typeof(value) !== 'number') && (isNaN(value % 1))) {
        return false;
    }else{
       return true;
    }
}

exports.checkValidName = function (value) {
    if(typeof(value) === 'undefined' || value === '' || value.trim().length == 0) {
        return false;
    }else{
        return true;
    }
}

exports.checkValidDate = function (value) {
    if(typeof(value) === 'undefined' || value == '' ) {
        return false;
    }else{
        try{
            var validDate = dateFormat(new Date(value), "yyyy-mm-dd HH:MM:ss");
            return true;
        }catch(err){
            return false;
        }
    }
}

exports.fetch_minimum_bid = function(highest_proxy_amount,bid_increment){

    next_amount = parseFloat(highest_proxy_amount) + parseFloat(bid_increment);

    return next_amount;
}


exports.checkBidPlacedForItem = function(req,mysql,q)
{
    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name+'_bids';
    strQuery = mysqli.mysqli($mysqli,'check_bid_placed');
    var deferred = q.defer();
    var escape_data =  [req.body.item_id];
    query =  mysql.query(strQuery,escape_data,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.gettimezonedata = function(req,mysql,q)
{
    $mysqli =  {};
    strQuery = mysqli.mysqli($mysqli,'get_all_timezones');
    var deferred = q.defer();
    query =  mysql.query(strQuery,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.getUserBidDetailsForItem = function(req,mysql,q)
{
    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name+'_bids';
    strQuery = mysqli.mysqli($mysqli,'get_user_bid');
    var escape_data = [req.body.user_id,req.body.item_id];
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.getMaxBidPositionForItem = function(req,mysql,q)
{
    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name+'_bids';
    strQuery = mysqli.mysqli($mysqli,'bids_max_position_for_item');
    var escape_data = [req.body.item_id];
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.getProxyDetailsForItem = function(req,mysql,q,type){

    $mysqli =  {};
    $mysqli.table_name1 =  req.body.table_name+'_bids';
    $mysqli.table_name2 =  req.body.table_name+'_proxybid';
    if(type == 'get_highest_biduser'){
        $mysqli['where'] = ' WHERE pb.project_id = '+req.body.item_id +' ORDER BY pb.maxamount desc,pb.date_added asc LIMIT 0,1';
    }else if(type == 'second_highest_biduser'){
        $mysqli['where'] = ' WHERE pb.project_id = '+req.body.item_id +' ORDER BY pb.maxamount desc,pb.date_added asc LIMIT 1,1';
    }
    strQuery = mysqli.mysqli($mysqli,"get_proxy_details_for_item");
    var deferred = q.defer();
    query =  mysql.query(strQuery,deferred.makeNodeResolver());
    return deferred.promise;
}

exports.checkUserExistInBidProxyForItem = function(req,mysql,q){

    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name+'_proxybid';
    strQuery = mysqli.mysqli($mysqli,"user's_proxybid");
    var deferred = q.defer();
    var escape_data =  [req.body.item_id,req.body.user_id];
    query =  mysql.query(strQuery,escape_data,deferred.makeNodeResolver());
    return deferred.promise;
}


exports.insertProxyBid = function(req,mysql,q){

    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name+'_proxybid';
    strQuery = mysqli.mysqli($mysqli,"insert_user_proxybid");
    var defered = q.defer();
    // var jun = moment("2014-06-01T12:00:00Z");
    console.log("Prozy bid add time is"+moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss'));  // 5am PDT
    datge = moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss');
    var escape_data =  [req.body.item_id,req.body.user_id,req.body.proxyuseramt,datge];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw error;
        });
    });
    return defered.promise;
}

exports.updateProxyBid = function(req,mysql,q){

    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name+'_proxybid';
    strQuery = mysqli.mysqli($mysqli,"update_user_proxybid");
    var defered = q.defer();
    console.log("Prozy bid update time is"+moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss'));  // 5am PDT
    datge = moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss');
    // datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data =  [req.body.proxyuseramt,datge,req.body.item_id,req.body.user_id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw error;
        });
    });
    return defered.promise;
}

exports.placeBidExtra = function(req,mysql,q,reserve)
{
    // datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    console.log("Bid add time is"+moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss'));  // 5am PDT
    datge = moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss');
    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name + '_bids';
    var defered = q.defer();
    userid = (typeof(req.body.user_id) !== 'undefined' )  ? req.body.user_id : '0';
    bidder_userid = (typeof(req.body.high_proxy_userid) === 'undefined') ? userid : req.body.high_proxy_userid;
    bidder_type = (typeof(req.body.bid_type) == 'undefined') ? '' : req.body.bid_type;
    var tiedtie = (typeof(req.body.tied_bidder) === 'undefined' || req.body.tied_bidder == '') ? 0 : req.body.tied_bidder;
    strQuery = mysqli.mysqli($mysqli,'insert_bids_45a');

    var escape_data =  [req.body.item_id,
        bidder_userid,
        datge,
        req.body.bid_amount,
        datge,
        req.body.bid_pos,
        bidder_type,
        tiedtie,
        req.body.bid_increment
    ];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("Place Bid 1",query.sql)
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw err;
        });
    });
    return defered.promise;
}

exports.fetch_last_bid = function(req,mysql,q,type){

    $mysqli =  {};
    $mysqli.table_name = req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,"get_last_bid_amount");

    var defered = q.defer();

    var escape_data =  [req.body.item_id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.insertBidsAsProxy = function(req,mysql,q,user_id){

    $mysqli =  {};
    $mysqli.table_name = req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,"insert_bid_as_proxy_for_item");
    var defered = q.defer();
    // datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    console.log("insertBidsAsProxy"+moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss'));  // 5am PDT
    datge = moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss');
    var escape_data =  [req.body.item_id,user_id,req.body.next_bid,datge,'bid_as_proxy', req.body.previ_bid_pos];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("Place Bid 4",query.sql)
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw err;
        });
    });
    return defered.promise;
}

exports.placeBid = function(req,mysql,q,reserve)
{
    console.log("placeBid"+moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss'));  // 5am PDT
    datge = moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss');
    // datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name + '_bids';
    var defered = q.defer();
    if(reserve) {
        strQuery = mysqli.mysqli($mysqli,'insert_bids_45');
        console.log("insert bid 1")
        var escape_data =  [req.body.item_id,
            (typeof(req.body.high_proxy_userid) !== 'undefined' )  ? req.body.high_proxy_userid : '0',
            datge,
            req.body.bid_amount,
            req.body.bid_type,
            datge,
            req.body.bid_pos
        ];
    } else {
        strQuery = mysqli.mysqli($mysqli,'insert_bids_20');
        console.log("insert bid 2")
        var escape_data =  [req.body.item_id,
            (typeof(req.body.user_id) !== 'undefined' )  ? req.body.user_id : '0',
            datge,
            req.body.bid_amount,
            req.body.bid_type
        ];
    }
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("Place Bid 2",query.sql)
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw error;
        });
    });
    return defered.promise;
}

exports.check_same_amount_duplicate = function(req,mysql,q){

    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,"amount_duplicate");
    var defered = q.defer();
    var escape_data =  [req.body.item_id,req.body.bid_amount];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.delete_max_amount_duplicate = function(req,mysql,q,buser){

    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name + '_proxybid';
    strQuery = mysqli.mysqli($mysqli,"delete_amount_duplicate");
    var deferred = q.defer();
    var escape_data =  [req.body.item_id,buser];
    query =  mysql.query(strQuery,escape_data,deferred.makeNodeResolver());
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw error;
        });
    });
    return deferred.promise;
}

exports.update_max_amount_duplicate = function(req,mysql,q,buser){
    console.log("update_max_amount_duplicate"+moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss'));  // 5am PDT
    datge = moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss');
    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name + '_proxybid';
    // var datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli,"update_max_amount_duplicate");
    var defered = q.defer();
    var escape_data =  [req.body.first_bidder_amount,req.body.item_id,buser];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw error;
        });
    });
    return defered.promise;
}

exports.update_samount_duplicate = function(req,mysql,q,bidid){

    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,"update_samount_duplicate");
    var defered = q.defer();
    var escape_data =  [bidid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw error;
        });
    });
    return defered.promise;
}

exports.insert_samount_duplicate = function(req,mysql,q,buser){
    console.log("update_max_amount_duplicate"+moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss'));  // 5am PDT
    datge = moment().tz(req.body.timezone).format('YYYY-MM-DD HH:mm:ss');
    $mysqli =  {};
    // var datge = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");

    strQuery = mysqli.mysqli($mysqli,"insert_samount_duplicate");
    var defered = q.defer();
    var escape_data =  [datge,buser,req.body.bid_amount,req.body.item_id];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    query.on('error',function(err){
        return mysql.rollback(function() {
            throw error;
        });
    });
    return defered.promise;
}

exports.itemBidCommonDetails = function(req,mysql,q,pid)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name+'_bids';
    sql = 'item_bid_information';
    var escape_data =  [pid];
    strQuery = mysqli.mysqli($mysqli,sql);
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
   console.log("Bid Common Details")
   console.log(query.sql)
    return defered.promise;
}

exports.APIUserEdit = function(req,mysql,q)
{
    $mysqli =  {};
    var escape_data =  [req.param('id')];
    sql = 'api_user_get_query';
    strQuery = mysqli.mysqli($mysqli,sql);
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.bidHistory = function(req,mysql,q,id)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name +'_bids';
    sql = 'bid_history_of_item';
    if(id == 1)
    {
        sql = 33;
    }
    var escape_data =  [req.param('item_id')];
    strQuery = mysqli.mysqli($mysqli,sql);
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("Bid History Details")
   console.log(query.sql)
    return defered.promise;
}

exports.selectAwardBid = function(req,mysql,q,pid)
{
    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,'get_award_bid');
    var defered = q.defer();
    var escape_data =  [pid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.selectAwardBidForReaward = function(req,mysql,q,pid)
{
    $mysqli =  {};
    $mysqli.table_name =  req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,'get_award_bid_reaward');
    var defered = q.defer();
    var escape_data =  [pid];
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("Select query for reaward"+ query.sql)
    return defered.promise;
}

exports.makeAwardBid = function(req,mysql,q,id)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,'make_award_bid');
    var defered = q.defer();
    var dateFormat = require('dateformat');
    datenow = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data =  [datenow,id]
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.declineAwardedBid = function(req,mysql,q,id)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,'decline_awarded_bid');
    var defered = q.defer();
    var dateFormat = require('dateformat');
    datenow = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data =  [datenow,id]
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("DECLINE AWARD")
    console.log(query.sql)
    return defered.promise;
}


exports.manualAwardBid = function(req,mysql,q,id)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,'reaward_bid');
    var defered = q.defer();
    var dateFormat = require('dateformat');
    datenow = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data =  [datenow,req.param('user_id'),id]
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("MANUAL AWARD")
    console.log(query.sql)
    return defered.promise;
}


exports.lastBiddersForItem = function(req,mysql,q,id)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name + '_bids';
    strQuery = mysqli.mysqli($mysqli,'last_bidders');

    var defered = q.defer();
    var dateFormat = require('dateformat');
    datenow = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data =  [id,id]
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.BidRecordsForUser = function(req,mysql,q,id,type,cnt)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name + '_bids';

    var page = (req.body.page - 1) * req.body.per_page;
    var perPage = req.body.per_page;
    var order_by = ''
    var queryName = ''

    if(cnt == 1){
        order_by =  " limit " + page + "," + perPage
    }

    if(type == 'won'){
        queryName = 'users_winning_bid'
    }else if(type == 'active'){
        queryName = 'users_active_bid'
    }else if(type == 'lost'){
        queryName = 'users_lost_bid'
    }
    $mysqli.order_by  = order_by
    strQuery = mysqli.mysqli($mysqli,queryName);

    var defered = q.defer();
    var dateFormat = require('dateformat');
    datenow = dateFormat(new Date(),"yyyy-mm-dd HH:MM:ss");
    var escape_data =  [id,id]
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("DASHBOARD QUERY")
    console.log(query.sql)
    return defered.promise;
}


exports.itemBidCommonDetailsMultiple = function(req,mysql,q,pid)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name+'_bids';
    sql = 'multiple_item_bid_information';
    var escape_data =  [pid];
    strQuery = mysqli.mysqli($mysqli,sql);
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.itemBidForUser = function(req,mysql,q,pid)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name+'_bids';
    sql = 'user_exists_in_bids';
    var escape_data =  [req.query.user_id,pid];
    strQuery = mysqli.mysqli($mysqli,sql);
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    return defered.promise;
}

exports.getAllBiddersMaxamount = function(req,mysql,q,pid)
{
    $mysqli =  {};
    $mysqli.table_name = req.body.table_name+'_bids';
    sql = 'get_all_user_maxamount';
    var escape_data =  [pid, pid];
    strQuery = mysqli.mysqli($mysqli,sql);
    var defered = q.defer();
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log("get_all_user_maxamount")
    console.log(query.sql)
    return defered.promise;
}
