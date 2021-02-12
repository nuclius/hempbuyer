var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');



exports.saveRequests = function(req, res, mysql, q) {
    //var qs = require('qs');
    //req.body = qs.parse(req.body);
    var behalf_cc_id = 0;

    console.log(req.body);
    //'insert into product_requests (product_id, user_id, qty, amount, created_at) values (?,?,?,?,?)';
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'insert_product_request');

    var defered = q.defer();
  
    if (req.body.currency_type == 'dollar') {
        var offer_price = (typeof(req.param('offer_price')) != 'undefined') ? Number(common.currencyConverter(req.param('offer_price')))*req.session.currencyrate : 0;
        var unit_price = (typeof(req.param('offer_price')) != 'undefined') ? Number(common.currencyConverter(req.param('offer_price')/req.param('qty')))*req.session.currencyrate : 0;
        } else {
        var offer_price = common.currencyConverter(req.param('offer_price'));
        var unit_price = (common.currencyConverter(req.param('offer_price')/req.param('qty')));
    }

    var escape_data = [
        req.body.id,
        req.session.userid,
        req.body.qty,
        offer_price,
        unit_price, 
        req.body.units,
        req.body.trading_type,
        datge,
        behalf_cc_id
        // (typeof(req.param('save')) === undefined) ? 'draft' : prostatus
    ];

    console.log(escape_data);

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}
