/*============================================================================*\
 || ########################################################################## ||
 || # Auction Software Marketplace[*]version[*] Build [*]build[*]
 || # ---------------------------------------------------------------------- # ||
 || # Customer License # [*]license[*]
 || # ---------------------------------------------------------------------- # ||
 || # Copyright ©2014–[*]year[*] Develop Scripts LLC. All Rights Reserved    # ||
 || # This file may not be redistributed in whole or significant part.       # ||
 || # ------------- AUCTION SOFTWARE IS NOT FREE SOFTWARE ------------------ # ||
 || # http://www.auctionsoftwaremarketplace.com|support@auctionsoftware.com  # ||
 || # ---------------------------------------------------------------------- # ||
 || ########################################################################## ||
 \*============================================================================*/

// #### load required Modules ##################################################
var http = require('http');
var net = require('net');
var https = require('https');
var express = require('express');
var fs = require('fs');
var path = require('path');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var multer = require('multer');
var cookieSession = require('express-session');
var helmet = require('helmet');
var compression = require('compression');

//Todo Custom Log
var dateFormat = require('dateformat');
const output = fs.createWriteStream('./stdout.log');
const errorOutput = fs.createWriteStream('./stderr.log');
/* global.logger = new console.Console(output, errorOutput);
console.log = function() { return false;}
global.customLog = logger.log;
logger.log = function(){

        customLog.apply(logger, [dateFormat(new Date(), "yyyy/mm/dd, hh:MM:ss TT")].concat(JSON.stringify(arguments)));
}
require( "console-stamp" )(logger, {

        formatter: function () {
                return ("[" + process.memoryUsage().rss + "]");
        },
        colors: {
                stamp: "yellow",
                label: "white",
                metadata: "green"
        }
} ); */
require("console-stamp")(console, {
    metadata: function() {
        return ("[" + process.memoryUsage().rss + "]");
    },
    colors: {
        stamp: "yellow",
        label: "white",
        metadata: "green"
    }
});
//Todo Custom Log Ends

process.env.TZ = 'America/New_York';

//require runner
var app = express();

console.log(new Date());

var _0xfb82=['545zxBttN','45wFccWb','static','An\x20error\x20occurred\x20:','35293GxuTcV','/auctionsoftwareUtilUpdate','urlencoded','use','error','./module/common','json','163390xNKGrX','3dNyyVN','auctionsoftwareUtilUpdate','headerSet','61171hRiNNM','3yObYZj','jquery-file-upload-middleware','loadTemplateHeader','express-domain-middleware','1352857XdlsWH','/auctionsoftwareapiupdate','./auctionsoftware/index','3184XcEozw','1VJbZJd','public','send','30125RKKwmC','100mb','auctionsoftware','798zyJRQL','join'];var _0x582b=function(_0x3dcafa,_0x29201f){_0x3dcafa=_0x3dcafa-0x14e;var _0xfb8241=_0xfb82[_0x3dcafa];return _0xfb8241;};var _0x197c47=_0x582b;(function(_0x5a7a60,_0x345e45){var _0x17624c=_0x582b;while(!![]){try{var _0x4c51a8=-parseInt(_0x17624c(0x15c))+-parseInt(_0x17624c(0x165))*parseInt(_0x17624c(0x151))+parseInt(_0x17624c(0x16d))*-parseInt(_0x17624c(0x16b))+parseInt(_0x17624c(0x14e))*-parseInt(_0x17624c(0x164))+-parseInt(_0x17624c(0x168))*-parseInt(_0x17624c(0x159))+parseInt(_0x17624c(0x15d))*-parseInt(_0x17624c(0x158))+parseInt(_0x17624c(0x161));if(_0x4c51a8===_0x345e45)break;else _0x5a7a60['push'](_0x5a7a60['shift']());}catch(_0x33d047){_0x5a7a60['push'](_0x5a7a60['shift']());}}}(_0xfb82,0x43f88),app['use'](helmet()),app[_0x197c47(0x154)](require(_0x197c47(0x160))),app[_0x197c47(0x154)](bodyParser[_0x197c47(0x157)]({'limit':_0x197c47(0x169)})),app[_0x197c47(0x154)](bodyParser[_0x197c47(0x153)]({'limit':_0x197c47(0x169)})),app[_0x197c47(0x154)](cookieParser('cookiecnx')),app[_0x197c47(0x154)](cookieSession({'secret':'123asd4567890QWERTY','cookie':{'maxAge':0x3938700}})),app['use'](express[_0x197c47(0x14f)](path[_0x197c47(0x16c)](__dirname,_0x197c47(0x166)))),app[_0x197c47(0x154)](compression()));var upload=require(_0x197c47(0x15e)),auctionsoftware=require(_0x197c47(0x163));app[_0x197c47(0x154)](auctionsoftware[_0x197c47(0x16a)]()),app[_0x197c47(0x154)](_0x197c47(0x152),auctionsoftware[_0x197c47(0x15a)]),app[_0x197c47(0x154)](_0x197c47(0x162),auctionsoftware['auctionsoftwareapiupdate']),app['use'](function(_0x3732e2,_0xcf6d54,_0x4d2113,_0x2b29e3){var _0x10e4b8=_0x197c47;console[_0x10e4b8(0x155)](_0x10e4b8(0x150),_0x3732e2['message']);var _0x22affb=require(_0x10e4b8(0x156));_0x22affb['tplFile']('error.tpl'),_0x22affb[_0x10e4b8(0x15b)](0x1),_0x22affb[_0x10e4b8(0x15f)](_0xcf6d54,_0x4d2113,$arr),_0x4d2113[_0x10e4b8(0x167)](0x1f4);});

app.use(function (req, res, next) {
    // console.log(req.session, "req.session.dev")
    if((config.url.includes('localhost:2099') || config.url.includes('auctionsoftwaremarketplace.com:2099') || config.url.includes('hempbuyerauction.com')) && req.session.isDev != true){
        // console.log(req.originalUrl, "req.originalUrl")
        if(req.url != '/setAccess' && req.url != '/checkAccess') {
            req.session.redirect_url = req.url;
        }
        //brNotify
//        if(!req.originalUrl.includes('/dailyremainder') && !req.originalUrl.includes('/changeOpenProductStatus') && !req.originalUrl.includes('/removeFromFeaturedAuction') && !req.originalUrl.includes('/product/cart/clear') && req.originalUrl != '/product/recurring/pay' && req.originalUrl != '/check/balance' && !req.originalUrl.includes('/check/recbalance') && !req.originalUrl.includes('/check/membership') && !req.originalUrl.includes('/checkAccess') && !req.originalUrl.includes('/setAccess') && !req.originalUrl.includes('/api/v1/user/details/userid'))
if(!req.originalUrl.includes('/api/v1/user/customquery') && !req.originalUrl.includes('/dailyremainder') && !req.originalUrl.includes('/changeOpenProductStatus') && !req.originalUrl.includes('/removeFromFeaturedAuction') && !req.originalUrl.includes('/product/cart/clear') && req.originalUrl != '/product/recurring/pay' && req.originalUrl != '/check/balance' && !req.originalUrl.includes('/check/recbalance') && !req.originalUrl.includes('/check/membership') && !req.originalUrl.includes('/checkAccess') && !req.originalUrl.includes('/setAccess') && !req.originalUrl.includes('/api/v1/user/details/userid'))
          res.redirect('/checkAccess');
    }
    next();
});

configure = require('./configure');
config = configure.app();
$arr = {
    config: config
};

app.use(function(req, res, next) {
    var requestIp = require("request-ip");

    function getIP(req) {
        var ip = requestIp.getClientIp(req);
        if (ip !== null) {
            ip = ip.split(":");
            ip = ip[ip.length - 1];
        }
        return ip;
    }
    var ip = getIP(req);
    if (req.url.toString() != '/changeOpenProductStatus' && req.url.toString() != '/removeFromFeaturedAuction') {
        console.log("REQ URL : >>>>>>>>>>> ", req.url.toString(), "IP : ", ip);
    }


    connection = $arr.config.mysql;
    next();
});

//require('./module/hmb_cron')

var login = require('./routes/login'),
    uploads = require('./routes/uploads'),
    product = require('./routes/product'),
    packages = require('./routes/packages'),
    dashboard = require('./routes/dashboard'),
    profile_settings = require('./routes/profile_settings'),
    admincp = require('./routes/admincp/index'),
    // facebook = require('./routes/facebook'),
    // twitter = require('./routes/twitter'),
    // linked = require('./routes/linked'),
    membership = require('./routes/membership'),
    admincplogin = require('./routes/admincp/login'),
    stores = require('./routes/stores'),
    adwords = require('./routes/adwords'),
    classified = require('./routes/classified'),
    paypal = require('./routes/paypal'),
    forum = require('./routes/forum'),
    greenmoney = require('./routes/greenmoney'),
    api = require('./routes/api');

var index = require('./routes/hmb_index'),
    hmb_product = require('./routes/hmb_product'),
    hmb_message = require('./routes/hmb_message'),
    user = require('./routes/hmb_user');
//var cron = require('./routes/cron');

app.use('/uploads', uploads);

app.use(multer({ dest: __dirname + "/public/uploads/" }));
cameraId = [];
allocatedNumbers = [];
cameraContent = [];

app.use('/', index);

app.use('/index', index);
app.use('/product', hmb_product),
    app.use('/user', user);
app.use('/inbox', hmb_message);


app.use('/login', login);
// app.use('/product', product);
app.use('/package', packages);
app.use('/dashboard', dashboard);
app.use('/profile_settings', profile_settings);
app.use('/profile', profile_settings);
// app.use('/facebook', facebook);
// app.use('/twitter', twitter);
// app.use('/linked', linked);
app.use('/stores', stores);
app.use('/admincp', admincp);
app.use('/salesadmin', admincp);
app.use('/distributoradmin', admincp);
app.use('/distributoradmin', admincp);
app.use('/membership', membership);
app.use('/admin', admincplogin);
app.use('/classified', classified);
app.use('/adwords', adwords);
app.use('/paypal', paypal);
app.use('/forum', forum);
app.use('/payment', greenmoney);
app.use('/api/v1', api);
// app.use('/forwardindex', formobileindex);
// app.use('/forwardapimobile', forwardapimobile);
// app.use('/formobiledashboard', formobiledashboard);
// app.use('/formobileproduct', formobileproduct);

// index router
// error handlers
// development error handler
// will print stacktrace

// This line is from the Node.js HTTPS documentation.

roomIds = [];
roomPeoples = [];
roomIndex = [];
topbidders = [];
var underscore = require('underscore');
// var options = {
//    key: fs.readFileSync('ssl/auction_new.pem'),
//     cert: fs.readFileSync('ssl/auctionsoftwaremarketplace.crt')
// };

// module.exports = app;
// var server = http.createServer(app).listen(2099);
var server = http.createServer(app);
server.listen(config.port, function() {
    console.log(`??Server ready at ${config.url}/`)
});

// use socket.io
io = require('socket.io').listen(server);
//turn off debug
io.set('log level', 1);

io.sockets.on('connection', function(socket) {

    setInterval(function() {
        io.sockets.emit('kva_server_time', new Date().getTime());
    }, 1000);
    socket.on('kva_server_time', function(msg) {
        io.sockets.emit('kva_server_time', msg);
    });
    module.exports = app;
});
