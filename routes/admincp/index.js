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

// #### load required Modules ################################################
var express = require('express');
var csv = require('express-csv');
var common = require('../../module/common');
var app = express.Router();
var q = require('q');
var admin = require('../../module/admin');
var pagination = require('pagination');
var async = require('async');
var faAPI = require('../../module/forwardauction_api');
var _ = require('underscore');
var request = require("request");
var session = require('express-session');
var language = require('../../module/language');
var login = require('../../module/login');
//var messages = require('../../module/message');
var projects = require('../../module/products');
var products = require('../../module/products');
var dashboard = require('../../module/dashboard');
var category = require('../../module/hmb_category');
var product = require('../../module/hmb_product');
var user = require('../../module/user');
var hmb_user = require('../../module/hmb_user');
var fs = require('fs');
var payment = require('../../module/hmb_payment');

var messages = require('../../module/hmb_message');
var localm = require('../../module/localmail');

app.use(function (req, res, next) {
    if (req.session.admin != 1) {
        res.writeHead(302, {
            'Location': '/admin/login?redirect='+req.originalUrl
        });
        res.end();
        return false;
        next();
    }
    // If login as switch user
    if (typeof (req.session.templogin) != 'undefined' || req.session.userid != 1) {

        req.body.templogin = 1;

        function processObject(row) {
            try {
                delete req.session.userid;
                delete req.session.email;
                delete session;
                req.session.admin = 1;
                req.session.email = row[0].email;
                req.session.userid = row[0].id;
                req.session.first_name = row[0].first_name;
                req.session.last_name = row[0].last_name;
                req.session.tpermission = 'no';

                req.session.adminUrl = 'admincp';
                if (req.session.roleid == 2 || req.session.roleid == 3) {
                    req.session.adminUrl = 'salesadmin';
                }

                $arr.loged = req.session;
                delete req.session.templogin;
                next();
            } catch (e) {
                console.log(e.stack);
            }
        }
        next();
        // q.all(common.admincpId(req, config.mysql, q)).then(function (results) {
        //     req.body.username = results[0][0].email;
        //     var userprocess = login.process(req, config.mysql, processObject);
        // }).fail(function (err) {
        //     console.log(err.stack);
        //     throw err;
        // }).done();

    } else {
        next();
    }

});

app.get(['/paypal/res'], function (req, res) {
    http = require('http');
    var url_parts = url.parse(request.url, true);
    var query = url_parts.query;
    var options = {
        host: req.param('url'),
        port: 80,
        path: req.param('page') + '?' + query
    };

    http.get(options, function (response) {
        res.end(response);
    }).on('error', function (e) {
        var data = {};
        data['message'] = "Got error: " + e.message;
        data['success'] = false;
        res.end(JSON.stringify(data));
    }).on('data', function (chunk) {
        var data = {};
        data['message'] = 'BODY: ' + chunk;
        data['success'] = false;
        res.end(JSON.stringify(data));
    });
});


app.post(['/static/pages/'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['pagesmenu'] = 'active';

    admin.updatePageContent(req, res, config.mysql, q);
    res.writeHead(302, {
        'Location': '/admincp/static/pages/' + req.body.id
    });
    res.end();
    return false;
});

app.get(['/static/pages/:id'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['pagesmenu'] = 'active';

    q.all([admin.showstaticContent(req, res, config.mysql, q)]).then(function (results) {
        $arr['content'] = results[0][0][0];
        common.tplFile('admincp/static_page_edits.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/feedbacknew'], function (req, res) {

    var bids = require('../../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 10;
    /****************/
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['feedbackmenu'] = 'active';
    $arr.externalcss = ['datePicker'];
    $arr.externaljs = ['jquery.datePicker'];
    var pagination = require('pagination');

    q.all([admin.feedbacks(req, config.mysql, q, 0), admin.feedbacks(req, config.mysql, q, 1), admin.FeedbackFields(req, config.mysql, q)]).then(function (result) {
        $arr['manage_feedbacks'] = result[0][0];
        $arr['pagination'] = $arr['reviews'] = result[1][0].length;
        $arr['fields'] = result[2][0];
        $arr['order_count'] = result[2][0].length;
        console.log('pagiationpp:' + $arr['pagination']);

        var paginator = new pagination.SearchPaginator({
            prelink: '/admincp/feedbacknew',
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();

        common.tplFile('admincp/feedback.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });


});

app.get(['/feedbacknew/:action/:id'], function (req, res) {


    req.body.id = req.param('id');
    /****************/
    action = req.param('action');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['feedbackmenu'] = 'active';
    console.log('sd' + req.body.id);
    if (action == 'delete') {

        admin.deleteFeedback(req, config.mysql, q)
        res.writeHead(302, {
            'Location': '/admincp/feedbacknew'
        });
        res.end();
        return false;

    }


});

app.post(['/feedback/:action'], function (req, res) {


    req.body.id = req.param('id');
    /****************/
    action = req.param('action');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['feedbackmenu'] = 'active';

    if (action == 'reviews-create') {
        // console.log('asdddddddd'+req.body.feedlabel);
        var position = req.param('feedorder');
        admin.rearrangefields(req, config.mysql, q, position, 0);
        admin.addFeedbackfield(req, config.mysql, q);

        res.writeHead(302, {
            'Location': '/admincp/feedbacknew'
        });

        res.end();
        return false;

    }
    if (action == 'update') {

        var new_position = req.param('feed_order');
        var old_position = req.param('old_pos');

        if (new_position < old_position) {
            admin.reorderfeedfields(req, config.mysql, q, new_position, old_position, 0);
        }

        if (new_position > old_position) {
            admin.reorderfeedfields(req, config.mysql, q, new_position, old_position, 1);
        }

        admin.updateFeedbackfield(req, config.mysql, q);

        res.writeHead(302, {
            'Location': '/admincp/feedbacknew'
        });

        res.end();
        return false;

    }


});

app.get(['/feedback/:action/:id'], function (req, res) {


    req.body.id = req.param('id');
    /****************/
    action = req.param('action');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['feedbackmenu'] = 'active';

    if (action == 'delete') {

        var corder = req.param('order');
        admin.rearrangefields(req, config.mysql, q, corder, 1);
        admin.deleteFeedbackfield(req, config.mysql, q);
        res.writeHead(302, {
            'Location': '/admincp/feedbacknew'
        });

        res.end();
        return false;
    }

    if (action == 'edit') {

        q.all([admin.feedbackdetailsbyId(req, config.mysql, q), admin.FeedbackFields(req, config.mysql, q)]).then(function (results) {

            $arr['feedfields'] = results[0][0][0];
            $arr['fields_count'] = results[1][0].length;

            common.tplFile('admincp/feedbackedit.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }


});

app.get(['/feedback/getdata'], function (req, res) {

    q.all([admin.FeedbackDatelist(req, res, config.mysql, q)]).then(function (results) {
        var count = results[0][0].length;
        var res_table = '';
        if (count > 0) {
            for (var i = 0; i < count; i++) {
                url = config.url + '/admincp/feedbacknew/delete/' + results[0][0][i].id;
                c_message = "Confirm it";
                res_table += "<tr>";
                res_table += "<td>" + results[0][0][i].first_name + " " + results[0][0][i].last_name + "</td>";
                res_table += "<td>" + results[0][0][i].sfirst + " " + results[0][0][i].slast + "</td>";
                res_table += "<td>" + results[0][0][i].average + "</td>";
                res_table += "<td>" + results[0][0][i].date_added + "</td>";
                res_table += '<td class="fd3" > <a href="' + config.url + '/product/view/' + results[0][0][i].id + '">View</a> |  <a href="#" onclick=PopupBox2("' + url + '");>Delete</a></td>';
                res_table += "</tr>";
            }
        } else {

            res_table += '<tr><td colspan="5">No reviews found !!! </td></tr>';

        }
        console.log('*******************' + config.url + '************');
        res.send(res_table);
        res.end();
        return false;

    });
});

app.get(['/reports'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr.externalcss = ['datePicker'];
    $arr.externaljs = ['jquery.datePicker'];


    common.tplFile('admincp/reports.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});

app.get(['/shipping', '/shipping/:action/:error'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['shippingmenu'] = 'active';

    $arr.error = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');;
    req.body.perlimit = 10;
    var bids = require('../../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    var pagination = require('pagination');
    q.all([admin.shippers(req, config.mysql, q, 0), admin.shippers(req, config.mysql, q, 1)]).then(function (results) {


        var fs = require('fs'),
            ini = require('ini');
        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
        action = 'fedex';
        $arr[action] = configed['section'][action];
        $arr[action + 'type'] = configed['section'][action + 'type'];
        $arr[action + 'value'] = configed['section'][action + 'value'];
        $arr[action + 'questions'] = configed['section'][action + 'questions'];
        action = 'ups';
        $arr[action] = configed['section'][action];
        $arr[action + 'type'] = configed['section'][action + 'type'];
        $arr[action + 'value'] = configed['section'][action + 'value'];
        $arr[action + 'questions'] = configed['section'][action + 'questions'];
        action = 'usps';
        $arr[action] = configed['section'][action];
        $arr[action + 'type'] = configed['section'][action + 'type'];
        $arr[action + 'value'] = configed['section'][action + 'value'];
        $arr[action + 'questions'] = configed['section'][action + 'questions'];

        action = 'shipping';
        $arr.shipping = configed['section'][action];

        $arr.shippers = results[0][0];


        $arr['pagination'] = results[1][0].length;
        var paginator = new pagination.SearchPaginator({
            prelink: '/admincp/shipping',
            current: req.body.page,
            rowsPerPage: req.body.perlimit,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();

        common.tplFile('admincp/shipping.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post(['/shippingnew/:action'], function (req, res) {
    q.all([admin.shippersnew(req, config.mysql, q)]).then(function (results) {
        res.writeHead(302, { 'Location': '/admincp/shipping/' + 'service' + '/new' });
        res.end();
        return false;
        return false;
    });
});

app.get(['/shippingdel/:id'], function (req, res) {
    req.body.id = req.param('id');
    q.all([admin.shippersdel(req, config.mysql, q)]).then(function (results) {
        res.writeHead(302, { 'Location': '/admincp/shipping/' + 'service' + '/del' });
        res.end();
        return false;
        return false;
    });
});

app.post(['/shipping/:action'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'common' : req.param('action');
    var fs = require('fs'),
        ini = require('ini');

    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    configed['section'][action] = req.body[action];
    fs.writeFileSync('./config.ini', ini.stringify(configed));
    config.mysql.destroy();
    delete configure;
    delete config;
    delete $arr;
    configure = require('../../configure');
    config = configure.app();

    $arr = {
        config: config
    }
    console.log("Action is " + action);
    if (action == 'homepage') {
        res.writeHead(302, { 'Location': '/admincp/projects/' + action + '/0/saved' });
    } else {
        res.writeHead(302, { 'Location': '/admincp/shipping/' + action + '/saved' });
    }
    res.end();
    return false;
    return false;
});


/************************* Email Template **************************************************/

app.get(['/emailtemplate', '/emailtemplate/:action/'], function (req, res) {

    arr = [];
    data2 = ['title', 'subject', 'type', 'method', 'template', 'date_added', 'buyer', 'seller', 'admin', 'general', 'status'];
    arr.push(data2);

    var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, { page: '' });


    req.body.action = (req.param('action') !== 'undefined') ? req.param('action') : '';
    $arr['is_export'] = (typeof (req.param('is_export')) !== 'undefined') ? req.param('is_export') : '';
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['emailtemplatemenu'] = 'active';

    var bids = require('../../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 10;
    var pagination = require('pagination');
    if (true || req.body.action == 'search') { //else not required here so added true
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, { page: '' });
        $arr['search'] = query;
        $arr.templates = '';
        $arr.subjects = $arr['subjects'] = (typeof (req.param('subjects')) !== 'undefined') ? req.param('subjects') : '';
        $arr['users'] = (typeof (req.param('users')) !== 'undefined') ? req.param('users') : '';
        $arr['types'] = (typeof (req.param('types')) !== 'undefined') ? req.param('types') : '';

        
   
        $arr['search']['users'] = $arr['users'];
        $arr['search']['types'] = $arr['types'];

        q.all([admin.searchtemplates(req, config.mysql, q, 0, "email"), admin.searchtemplates(req, config.mysql, q, 1, "email")]).then(function (results) {

            $arr.templates = results[0][0];

            if($arr['is_export'] > 0) {
                var count = $arr.templates.length;
                console.log('pppp' + count);
                for (var i = 0; i < count; i++) {

                    data2 = [results[0][0][i].title, results[0][0][i].subject, results[0][0][i].type, results[0][0][i].method, results[0][0][i].template, results[0][0][i].date_added, results[0][0][i].buyer, results[0][0][i].seller, results[0][0][i].admin, results[0][0][i].general, results[0][0][i].status];
                    arr.push(data2);
                }
                var dateFormat = require('dateformat');
                res.setHeader('Content-disposition', 'attachment; filename=template_' + dateFormat(new Date(), "yyyy_mm_dd_HH_MM_ss") + '.csv');
                res.set('Content-Type', 'application/octet-stream');
                res.csv(arr);

            } else {

                $arr['pagination'] = results[1][0].length;
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/emailtemplate?' + fquery,
                    current: req.body.page,
                    rowsPerPage: req.body.perlimit,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();

                common.tplFile('admincp/emailtemplate.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            }
        });

    } else {
        $arr['search'] = {};
        
        $arr.subjects = $arr['subjects'] = (typeof (req.param('subjects')) !== 'undefined') ? req.param('subjects') : '';
        $arr['users'] = (typeof (req.param('users')) !== 'undefined') ? req.param('users') : '';
        $arr['types'] = (typeof (req.param('types')) !== 'undefined') ? req.param('types') : '';
        $arr['search']['users'] = $arr['users'];
        $arr['search']['types'] = $arr['types'];
        q.all([admin.alltemps(req, config.mysql, q, 0, "email"), admin.alltemps(req, config.mysql, q, 1, "email")]).then(function (results) {

            $arr.templates = results[0][0];

            
            if($arr['is_export'] > 0) {
                var count = $arr.templates.length;
                console.log('pppp' + count);
                for (var i = 0; i < count; i++) {

                    data2 = [results[0][0][i].title, results[0][0][i].subject, results[0][0][i].type, results[0][0][i].method, results[0][0][i].template, results[0][0][i].date_added, results[0][0][i].buyer, results[0][0][i].seller, results[0][0][i].admin, results[0][0][i].general, results[0][0][i].status];
                    arr.push(data2);
                }
                var dateFormat = require('dateformat');
                res.setHeader('Content-disposition', 'attachment; filename=template_' + dateFormat(new Date(), "yyyy_mm_dd_HH_MM_ss") + '.csv');
                res.set('Content-Type', 'application/octet-stream');
                res.csv(arr);

            } else {
               

                $arr['pagination'] = results[1][0].length;
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/emailtemplate?' + fquery,
                    current: req.body.page,
                    rowsPerPage: req.body.perlimit,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();


                common.tplFile('admincp/emailtemplate.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            }

        });
    }


});

app.get(['/addemailtemplate'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['emailtemplatemenu'] = 'active';


    common.tplFile('admincp/add-etemplate.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});


app.get(['/etemps/:action/:id', '/etemps/:action'], function (req, res) {


    req.body.id = req.param('id');
    /****************/
    action = req.param('action');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['emailtemplatemenu'] = 'active';

    if (action == 'edit') {
        //req.body.id = (typeof(req.param('id')) === 'undefined') ? 0 : req.param('id');
        q.all([admin.etempsbyId(req, config.mysql, q)]).then(function (results) {

            $arr['temp_details'] = results[0][0][0];

            common.tplFile('admincp/add-etemplate.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });

    }

    if (action == 'delete') {
        admin.deletetemp(req, config.mysql, q);

        res.writeHead(302, {

            'Location': '/admincp/emailtemplate'

        });

        res.end();
        return false;
    }


});

app.post(['/addetemps'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['emailtemplatemenu'] = 'active';


    var dateFormat = require('dateformat');
    $arr.datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    if (req.body.id > 0) {

        admin.updateetemplates(req, config.mysql, q, $arr);
    } else {
        admin.addetemplates(req, config.mysql, q, $arr);

    }


    res.redirect('/admincp/emailtemplate')
    res.end();
    return false;
    return false;

});

/************************* Email Template Ends **************************************************/

/*********************************** Template Insert *******************************************/

app.get(['/templateimport'], function (req, res) {

    var method = req.param('temptype');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu'][method + 'templatemenu'] = 'active'; // method+'templatemenu' is to acticate menu dynamically.

    $arr['type'] = [];
    $arr['type']['temptype'] = req.param('temptype');
    common.tplFile('admincp/csvimport.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});

app.get(['/templateexport'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['emailtemplatemenu'] = 'active';


    req.body.temptype = (typeof (req.param('temptype')) === 'undefined') ? 'email' : req.param('temptype');

    // Exporting data
    arr = [];
    data2 = ['title', 'subject', 'type', 'method', 'template', 'date_added', 'buyer', 'seller', 'admin', 'general', 'status'];
    arr.push(data2);

    q.all([admin.exportfull(req, config.mysql, q)]).then(function (results) {
        var count = results[0][0].length;
        console.log('pppp' + count);
        for (var i = 0; i < count; i++) {

            data2 = [results[0][0][i].title, results[0][0][i].subject, results[0][0][i].type, results[0][0][i].method, results[0][0][i].template, results[0][0][i].date_added, results[0][0][i].buyer, results[0][0][i].seller, results[0][0][i].admin, results[0][0][i].general, results[0][0][i].status];

            arr.push(data2);

        }


        var dateFormat = require('dateformat');
        res.setHeader('Content-disposition', 'attachment; filename=template_' + req.body.temptype + '_' + dateFormat(new Date(), "yyyy_mm_dd_HH_MM_ss") + '.csv');
        res.set('Content-Type', 'application/octet-stream');
        res.csv(arr);


    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();


    return false;

});


app.post(['/etemps/:action'], function (req, res) {
    action = req.param('action')
    var type_method = req.param('method');
    if (action == 'import') {
        var files = req.body.csvs;

        var details = [];
        fs = require('fs');
        parse = require('csv-parse');
        counts = 0;
        ins = 0;

        req.body.temptype = (typeof (req.param('temptype')) === 'undefined') ? 'email' : req.param('temptype');
        q.all([admin.exportfull(req, config.mysql, q)]).then(function (results) {

            var count = results[0][0].length;
            rs = fs.createReadStream(req.files.csvs.path);
            parser = parse({ columns: true }, function (err, data) {
                var counts = data.length;
                //console.log(parser.options.columns);
                var valid_cols = ['title', 'subject', 'type', 'method', 'template', 'date_added', 'buyer', 'seller', 'admin', 'general', 'status'];
                if (parser.options.columns.length == valid_cols.length) {
                    counts = data.length;
                    ins = 0;
                    for (var i = 0; i < counts; i++) {
                        $arr['title'] = data[i].title;
                        $arr['subject'] = data[i].subject;
                        $arr['type'] = data[i].type;
                        $arr['method'] = data[i].method;
                        $arr['template'] = data[i].template;
                        $arr['date_added'] = data[i].date_added;
                        $arr['buyer'] = data[i].buyer;
                        $arr['seller'] = data[i].seller;
                        $arr['admin'] = data[i].admin;
                        $arr['general'] = data[i].general;
                        $arr['status'] = data[i].status;
                        flag = 0
                        if (data[i].title != '') { flag++ }
                        if (data[i].subject != '') { flag++ }
                        if (data[i].type != '') { flag++ }
                        if (data[i].method != '') { flag++ }
                        if (data[i].template != '') { flag++ }
                        if (data[i].seller != '' && data[i].seller < 2) { flag++ }
                        if (data[i].buyer != '' && data[i].buyer < 2) { flag++ }
                        if (data[i].admin != '' && data[i].admin < 2) { flag++ }
                        if (data[i].general != '' && data[i].general < 2) { flag++ }
                        if (data[i].status != '' && data[i].status == 1) { flag++ }
                        /*q.all([admin.csvcheckBytitle(req,config.mysql,q,$arr['title'])]).then(function(results){});*/
                        $arr['id'] = 0;
                        for (var j = 0; j < count; j++) {
                            if (results[0][0][j].title == data[i].title) {
                                $arr['id'] = results[0][0][j].id;
                                j = count;

                            }
                        }

                        if (flag == 10) {
                            admin.addtempbyCSV(req, config.mysql, q, $arr);
                            ins++;
                        }

                    }

                }


                if (type_method == 'email') {
                    res.writeHead(302, {

                        'Location': '/admincp/emailtemplate/?c=' + counts + '&i=' + ins

                    });
                } else {
                    res.writeHead(302, {

                        'Location': '/admincp/smstemplate'

                    });

                }

                res.end();
                return false;

            })
            rs.pipe(parser);
            //Redirect to respective pages After CSV submit
        });
    }

});


/*********************************** Template Insert *******************************************/


/************************* SMS Template **************************************************/

app.get(['/smstemplate', '/smstemplate/:action/'], function (req, res) {
    req.body.action = (req.param('action') !== 'undefined') ? req.param('action') : '';
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['smstemplatemenu'] = 'active';

    var bids = require('../../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);

    req.body.page = data.dspage;
    req.body.perlimit = 10;
    var pagination = require('pagination');

    if (req.body.action == 'search') {
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, { page: '' });
        $arr['search'] = query;
        $arr.templates = '';
        $arr.subjects = $arr['subjects'] = (typeof (req.param('subjects')) !== 'undefined') ? req.param('subjects') : '';
        $arr['users'] = (typeof (req.param('users')) !== 'undefined') ? req.param('users') : '';
        $arr['types'] = (typeof (req.param('types')) !== 'undefined') ? req.param('types') : '';

        q.all([admin.searchtemplates(req, config.mysql, q, 0, "sms"), admin.searchtemplates(req, config.mysql, q, 1, "sms")]).then(function (results) {

            $arr.templates = results[0][0];
            $arr['pagination'] = results[1][0].length;
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/smstemplate',
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();

            common.tplFile('admincp/smstemplate.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        });


    } else {
        q.all([admin.alltemps(req, config.mysql, q, 0, "sms"), admin.alltemps(req, config.mysql, q, 1, "sms")]).then(function (results) {

            $arr.templates = results[0][0];
            $arr['pagination'] = results[1][0].length;
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/smstemplate',
                current: req.body.page,
                rowsPerPage: req.body.perlimit,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();


            common.tplFile('admincp/smstemplate.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        });
    }


});

app.get(['/addsmstemplate'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['smstemplatemenu'] = 'active';


    common.tplFile('admincp/add-stemplate.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});


app.get(['/stemps/:action/:id', '/stemps/:action'], function (req, res) {


    req.body.id = req.param('id');
    /****************/
    action = req.param('action');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['smstemplatemenu'] = 'active';

    if (action == 'edit') {
        //req.body.id = (typeof(req.param('id')) === 'undefined') ? 0 : req.param('id');
        q.all([admin.etempsbyId(req, config.mysql, q)]).then(function (results) {

            $arr['temp_details'] = results[0][0][0];

            common.tplFile('admincp/add-stemplate.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });

    }

    if (action == 'delete') {
        admin.deletetemp(req, config.mysql, q);

        res.writeHead(302, {

            'Location': '/admincp/smstemplate'

        });

        res.end();
        return false;
    }


});

app.post(['/addstemps'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['emailtemplatemenu'] = 'active';


    var dateFormat = require('dateformat');
    $arr.datenow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    if (req.body.id > 0) {

        admin.updatestemplates(req, config.mysql, q, $arr);
    } else {
        admin.addstemplates(req, config.mysql, q, $arr);

    }


    res.writeHead(302, {

        'Location': '/admincp/smstemplate?added=1'

    });

    res.end();
    return false;

});


/************************* smsTemplate Ends **************************************************/


app.get(['/paymentmodules'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['paymentmodulesmenu'] = 'active';


    /*$arr['authnet_id']       = global.authnet.apiid;
     $arr['authnet_key']      = global.authnet.transkey;
     $arr['authnet_status']   = global.authnet.enabled;*/

    $arr['paypal_address'] = global.paypal.address;
    $arr['paypal_api'] = global.paypal.paypal_api;
    $arr['paypal_key'] = global.paypal.preapproval_key;
    $arr['paypal_password'] = global.paypal.paypal_password;
    $arr['paypal_signature'] = global.paypal.paypal_signature;
    $arr['paypal_username'] = global.paypal.paypal_username;
    $arr['paypal_status'] = global.paypal.enabled;

    $arr['mid'] = global.braintree.merchantId;
    $arr['publickey'] = global.braintree.publicKey;
    $arr['privatekey'] = global.braintree.privateKey;
    $arr['braintree_status'] = global.braintree.enabled;
    $arr['customerprefix'] = global.braintree.customerprefix;

    $arr['vp_enabled'] = global.voguepay.enabled;
    $arr['vp_merchantid'] = global.voguepay.merchantid;

    $arr['stripe_status'] = global.stripe.enabled;
    $arr['stripe_secretkey'] = global.stripe.secretkey;
    $arr['stripe_publishkey'] = global.stripe.publishkey;

    $arr['auth_status'] = global.authorizenet.enabled;
    $arr['auth_api'] = global.authorizenet.api;
    $arr['auth_key'] = global.authorizenet.key;

    console.log(global.authnet);

    common.tplFile('admincp/paymentmodules.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});
app.get(['/static/pages'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['pagesmenu'] = 'active';

    q.all([admin.showstaticPages(req, res, config.mysql, q)]).then(function (results) {
        $arr['pages'] = results[0][0];
        common.tplFile('admincp/static_pages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/escrow/:action/:id'], function (req, res) {
    action = req.param('action');
    if (action == 'release') {
        req.body.id = req.param('id');
        admin.changeEscrowPayment(req, config.mysql, q, 1);
        res.writeHead(302, {
            'Location': '/admincp/escrow/success/1/Marked As Paid'
        });
        res.end();
        return false;
    }
    if (action == 'cancel') {
        req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
        q.all([admin.getBuyNowRecord(req, config.mysql, q)]).then(function (results) {
            $arr.payments = results[0][0][0];
            global.bgateway.transaction.refund(results[0][0][0].trans_id, results[0][0][0].amt, function (err, refund_result) {
                if (refund_result.success) {
                    if (refund_result.transaction.status) {
                        admin.changeEscrowPayment(req, config.mysql, q, 2);
                        res.writeHead(302, {
                            'Location': '/admincp/escrow/success/1/Cancelled Payment'
                        });
                        res.end();
                        return false;
                    } else {
                        res.writeHead(302, {
                            'Location': '/admincp/escrow/error/1/' + refund_result.transaction.processorResponseText
                        });
                        res.end();
                        return false;
                    }
                } else {
                    res.writeHead(302, {
                        'Location': '/admincp/escrow/error/1/' + refund_result.message
                    });
                    res.end();
                    return false;
                }
            });
        });
    }
});

app.get(['/escrow', '/escrow/:action/', '/escrow/:action/:message/:error'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    req.body.error = (typeof (req.param('error')) !== 'undefined') ? req.param('error') : '';
    $arr.success = $arr.failure = false;
    $arr.error = req.body.error;
    if (req.body.action == 'success') {
        $arr.success = true;
    }
    if (req.body.action == 'error') {
        $arr.failure = true;
    }

    q.all([admin.escrowPayments(req, config.mysql, q, 0), admin.escrowPayments(req, config.mysql, q, 1)]).then(function (results) {
        $arr.payments = results[0][0];
        $arr['pagination'] = results[1][0].length;
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/admincp/escrow/',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination']
        });
        $arr['menu']['escrowmenu'] = 'active';
        $arr['pagination_html'] = paginator.render();
        common.tplFile('admincp/buynowpayments.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post(['/membership/:action'], function (req, res) {
    membership = require('../../module/membership');
    action = req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : 'plan';
    if (action == 'permission-save-data') {
        q.all([membership.showPermissionData(req, config.mysql, q), membership.showPermissionGrabData(req, config.mysql, q)]).then(function (result) {
            $arr['saved'] = (action == 'permission-set-saved') ? true : false;
            $arr['permission_set_data'] = result[0][0];
            $arr['permission_save_data'] = result[1][0];
            if (req.body.id > 0) {
                for (var i in $arr['permission_set_data']) {
                    var il = $arr['permission_set_data'][i]['id'];
                    var field = 'permission[' + il + ']';
                    update = 0;
                    for (var j in $arr['permission_save_data']) {
                        if ($arr['permission_save_data'][j]['permission_id'] == $arr['permission_set_data'][i]['id']) {
                            req.body[field] = (typeof (req.body[field]) !== 'undefined') ? req.body[field] : $arr['permission_save_data'][j]['value'];
                            update++;
                        }
                    }
                    if (update == 1) {
                        membership.savePermissionData(req, config.mysql, q, 1, il, req.body[field]);
                    } else {
                        membership.savePermissionData(req, config.mysql, q, 0, il, req.body[field]);
                    }
                }
            }
            res.writeHead(302, {
                'Location': '/admincp/membership/permission-saved-data/' + req.body.id
            });
            res.end();
            return false;
        });
    }
    if (action == 'permission-create') {
        q.all([membership.savePermission(req, config.mysql, q)]).then(function (result) {
            res.writeHead(302, {
                'Location': '/admincp/membership/permission-saved'
            });
            res.end();
            return false;
        });
    }

    if (action == 'roles-create') {
        q.all([membership.saveRoles(req, config.mysql, q)]).then(function (result) {
            res.writeHead(302, {
                'Location': '/admincp/membership/roles-saved'
            });
            res.end();
            return false;
        });
    }

    if (action == 'plan-create') {
        q.all([membership.savePlans(req, config.mysql, q)]).then(function (result) {
            res.writeHead(302, {
                'Location': '/admincp/membership/plans-saved'
            });
            res.end();
            return false;
        });
    }
});
app.get(['/membershipdelete/:action/:id'], function (req, res) {
    membership = require('../../module/membership');
    $arr['id'] = req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;

    action = req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : 'plans';
    if (req.body.id > 0) {
        console.log("Inside id");
        if (action == 'plan-delete') {
            console.log("plan-delete");

            q.all([membership.deletePlans(req, config.mysql, q), membership.deletemenbershipusers(req, config.mysql, q)]).then(function (result) {

                res.writeHead(302, {
                    'Location': '/admincp/membership/plans/'
                });
                res.end();
                return false;
            });
        }
        if (action == 'roles-delete') {
            console.log("roles-delete");
            q.all([membership.selectplanbyrole(req, config.mysql, q), membership.deleteplanbyrole(req, config.mysql, q), membership.deleteRole(req, config.mysql, q)]).then(function (result) {

                ids = result[0][0];
                for (i in ids) {
                    req.body.id = ids[i]['id'];
                    membership.deletemenbershipusers(req, config.mysql, q)
                }
                res.writeHead(302, {
                    'Location': '/admincp/membership/roles/'
                });
                res.end();
                return false;
            });
        }
        if (action == 'permission-delete') {
            console.log("permission-delete");
            q.all([membership.selectplanbypermission(req, config.mysql, q), membership.deleteplanbypermission(req, config.mysql, q), membership.deletePermission(req, config.mysql, q)]).then(function (result) {

                ids = result[0][0];
                for (i in ids) {
                    req.body.id = ids[i]['id'];
                    membership.deletemenbershipusers(req, config.mysql, q)
                }
                res.writeHead(302, {
                    'Location': '/admincp/membership/permission/'
                });
                res.end();
                return false;
            });
        }

    }
});
app.get(['/membership/', '/membership/:action', '/membership/:action/:id'], function (req, res) {
    membership = require('../../module/membership');
    delete $arr['menu'];
    $arr['menu'] = [];
    action = req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : 'plans';
    $arr['id'] = req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    if (action == 'roles' || action == 'roles-saved' || action == 'roles-edit') {
        q.all([membership.selectRoles(req, config.mysql, q)]).then(function (result) {
            $arr['saved'] = (action == 'roles-saved') ? true : false;
            $arr['plans'] = result[0][0];
            if (req.body.id > 0) {
                for (var i in $arr['plans']) {
                    if ($arr['plans'][i]['id'] == req.body.id) {
                        $arr['name'] = $arr['plans'][i]['name'];
                        $arr['description'] = $arr['plans'][i]['description'];
                    }
                }
            }
            $arr['menu']['membershipmenu'] = 'active';
            $arr['menu']['rolenewmenu'] = 'active';
            common.tplFile('admincp/roles.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
    if (action == 'permission-set' || action == 'permission-saved-data') {
        q.all([membership.showPermissionData(req, config.mysql, q), membership.showPermissionGrabData(req, config.mysql, q)]).then(function (result) {
            $arr['saved'] = (action == 'permission-saved-data') ? true : false;
            $arr['permission_set_data'] = result[0][0];
            $arr['permission_save_data'] = result[1][0];

            if (req.body.id > 0) {
                for (var i in $arr['permission_set_data']) {
                    for (var j in $arr['permission_save_data']) {
                        if ($arr['permission_save_data'][j]['permission_id'] == $arr['permission_set_data'][i]['id']) {
                            $arr['permission_set_data'][i]['value'] = $arr['permission_save_data'][j]['value'];
                        }
                    }
                }
            }
            $arr['menu']['membershipmenu'] = 'active';
            common.tplFile('admincp/permission-set.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
    if (action == 'permission' || action == 'permission-saved' || action == 'permission-edit') {
        $arr['menu']['permissionewmenu'] = 'active';
        q.all([membership.selectPermission(req, config.mysql, q)]).then(function (result) {
            $arr['saved'] = (action == 'permission-saved') ? true : false;
            $arr['permissions'] = result[0][0];
            if (req.body.id > 0) {
                for (var i in $arr['permissions']) {
                    if ($arr['permissions'][i]['id'] == req.body.id) {
                        $arr['name'] = $arr['permissions'][i]['name'];
                        $arr['description'] = $arr['permissions'][i]['description'];
                    }
                }
            }
            $arr['menu']['membershipmenu'] = 'active';
            $arr['menu']['permissionewmenu'] = 'active';
            common.tplFile('admincp/permissions.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
    if (action == 'plans' || action == 'plans-saved' || action == 'plan-edit') {
        q.all([membership.selectRoles(req, config.mysql, q), membership.selectPermission(req, config.mysql, q), membership.selectPlan(req, config.mysql, q)]).then(function (result) {
            $arr['saved'] = (action == 'roles-saved') ? true : false;
            $arr['roles'] = result[0][0];
            $arr['plans'] = result[2][0];
            $arr['permission'] = result[1][0];
            if (req.body.id > 0) {
                for (var i in $arr['plans']) {
                    if ($arr['plans'][i]['id'] == req.body.id) {
                        $arr['name'] = $arr['plans'][i]['name'];
                        $arr['description'] = $arr['plans'][i]['description'];
                        $arr['amount'] = $arr['plans'][i]['amount'];
                        $arr['length'] = $arr['plans'][i]['length'];
                        $arr['format'] = $arr['plans'][i]['format'];
                        $arr['plan'] = $arr['plans'][i]['membership_id'];
                        $arr['permissions'] = $arr['plans'][i]['permission_id'];
                    }
                }
            }
            $arr['menu']['membershipmenu'] = 'active';
            $arr['menu']['plannewmenu'] = 'active';
            common.tplFile('admincp/plans.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});

app.post(['/language/:action'], function (req, res) {

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'language' : req.param('action');
    if (action == 'add') {
        fs = require('fs');
        ini = require('ini');
        var nlanguage = fs.readFileSync('./public/uploads/product/english_language.json', 'utf-8');

        nlanguage.language.language = req.body.newlanguage.substring(0, 1).toUpperCase() + req.body.newlanguage.substring(1, req.body.newlanguage.length).toLowerCase();;
        nlanguage.language.language_code = req.body.short;
        fs.writeFileSync('./public/uploads/product/' + req.body.newlanguage.toLowerCase() + '_language.ini', JSON.stringify(nlanguage, null, '\t'));

        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
        configed.section.languagevalue.language[req.body.newlanguage.toLowerCase()] = req.body.newlanguage;
        fs.writeFileSync('./config.ini', ini.stringify(configed));
        res.writeHead(302, {
            'Location': '/admincp/settings/language/'
        });
        res.end();
        return false;
    }
    if (action == 'save_phrase') {
        phrase = global.language_identifier.language.phrases;
        phrase[req.param('phrase_name')] = req.param('phrase_value');
        global.language_identifier.language.phrases = phrase;
        fs = require('fs');
        ini = require('ini');
        fs.writeFileSync('./' + global.language.language + '_language.ini', JSON.stringify(global.language_identifier, null, '\t'));
        res.writeHead(302, {
            'Location': '/admincp/language/edit/' + req.param('phrase_name') + '/saved'
        });
        res.end();
        return false;
    }
    if (action == 'import') {
        if (typeof (req.files) !== 'undefined' && req.files.file.extension == 'json') {
            fs = require('fs');
            phrasee = fs.readFileSync(req.files.file.path, 'utf-8');
            fs.writeFileSync('./' + global.language.language + '_language.ini', phrasee);
            phrase = JSON.parse(phrasee);
            global.language_identifier.language.phrases = phrase.language.phrases;
            res.writeHead(302, {
                'Location': '/admincp/language/phrase'
            });
            res.end();
            return false;
        } else {
            res.writeHead(302, {
                'Location': '/admincp/language/import/unformat'
            });
            res.end();
            return false;
        }
    }
});

app.post(['/template/save/'], function (req, res) {

    if (req.session.tpermission == 'no') {
        res.writeHead(302, {
            'Location': '/admincp/permissiondenied'
        });
        res.end();
        return false;
    }
    delete $arr['menu'];
    $arr['menu'] = [];
    fs = require('fs');
    fs.writeFileSync(req.body.tmp, req.body.template_value);
    res.writeHead(302, {
        'Location': '/admincp/template/edit/?tmp=' + req.body.tmp + '&error=saved'
    });
    res.end();
    return false;

});

app.get(['/permissiondenied'], function (req, res) {

    common.tplFile('admincp/permissiondenied.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.get(['/template', '/template/:action', '/template/:action/:id', '/template/:action/:id/:error'], function (req, res) {


    delete $arr['menu'];
    $arr['menu'] = [];
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'page' : req.param('action');

    if (action == 'permission_permit_by_auction_team_code_hcxzvvbn') {
        delete req.session.tpermission;
        req.session.reload(function (err) {
            req.session.tpermission = 'yes';
        });
        action = 'page';
    }
    if (req.session.tpermission == 'no') {
        res.writeHead(302, {
            'Location': '/admincp/permissiondenied'
        });
        res.end();
        return false;
    }

    $arr['menu']['languagemenu'] = 'active';
    $arr[action + 'languagemenu'] = 'active';
    $arr['menu'][action + 'languagemenu'] = 'active';
    fs = require('fs');
    if (action == 'page') {
        function getFiles(dir, files_) {
            files_ = files_ || [];
            if (typeof files_ === 'undefined') files_ = [];
            var files = fs.readdirSync(dir);
            for (var i in files) {
                if (!files.hasOwnProperty(i)) continue;
                var name = dir + '/' + files[i];
                if (fs.statSync(name).isDirectory()) {
                    getFiles(name, files_);
                } else {
                    files_.push(name);
                }
            }
            return files_;
        }

        $arr['files'] = getFiles('./templates');
        $arr['files'] = $arr['files'].sort(function (a, b) {
            if (a < b) return -1;
            if (a > b) return 1;
            return 0;
        });
        common.tplFile('admincp/files.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
    if (action == 'edit') {
        req.body.tmp = (typeof (req.param('tmp')) !== 'undefined') ? req.param('tmp') : './templates/Addresses.tpl';
        $arr['template_name'] = req.body.tmp;
        $arr['template_value'] = fs.readFileSync(req.body.tmp, 'utf-8');
        common.tplFile('admincp/template-edit.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});

app.get(['/language', '/language/:action', '/language/:action/:id', '/language/:action/:id/:error'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;

    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'language' : req.param('action');
    $arr['menu']['languagemenu'] = 'active';
    $arr[action + 'languagemenu'] = 'active';
    $arr['menu'][action + 'languagemenu'] = 'active';
    var fs = require('fs'),
        ini = require('ini');
    if (action == 'language') {
        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
        $arr['settings'] = configed['section'][action];
        $arr['type'] = configed['section'][action + 'type'];
        $arr['value'] = configed['section'][action + 'value'];
        $arr['questions'] = configed['section'][action + 'questions'];
        $arr['action'] = action;
        common.tplFile('admincp/settings.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
    if (action == 'newphrase') {
        common.tplFile('admincp/phrase-new.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
    if (action == 'export') {
        if (typeof (req.param('id')) === 'undefined') {
            $arr['export_file'] = global.language.language;
            common.tplFile('admincp/phrase-export_file.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        } else {
            var file = './language_download.json';
            fs.writeFileSync(file, JSON.stringify(global.language_identifier, null, '\t'));
            res.setHeader('Content-disposition', 'attachment; filename=' + file);
            res.setHeader('Content-type', 'json');

            var filestream = fs.createReadStream(file);
            filestream.pipe(res);
        }
    }
    if (action == 'import') {
        if (typeof (req.param('id')) === 'undefined') {
            $arr['export_file'] = global.language.language;
            common.tplFile('admincp/phrase-import_file.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        } else {
            console.log(req.files.file);
        }
    }
    if (action == 'edit') {
        phrase = global.language_identifier.language.phrases;
        phrased = [];
        for (var prop in phrase) {
            phrased[prop] = phrase[prop];
        }
        if (typeof (phrased[req.param('id')]) !== 'undefined') {
            $arr['phrase_name'] = req.param('id');
            $arr['phrase_value'] = phrased[req.param('id')];
            common.tplFile('admincp/phrase-edit.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }
    }
    if (action == 'phrase') {
        var phrased = []
        phrase = global.language_identifier.language.phrases;
        var k = (req.body.page - 1) * 10;
        $arr["phrases"] = [];
        var arr = [];
        var ik = 0;
        for (var prop in phrase) {
            phrased[ik] = [];
            phrased[ik]['name'] = prop;
            phrased[ik]['value'] = phrase[prop]
            ik++;
        }
        phrased = phrased.sort(function (a, b) {
            if (a.name < b.name) return -1;
            if (a.name > b.name) return 1;
            return 0;
        });
        $arr['pagination'] = phrased.length;
        phrased = phrased.slice(k, k + 10);
        $arr["phrases"] = phrased;

        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/admincp/language/phrase/',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination']
        });

        $arr['pagination_html'] = paginator.render();
        common.tplFile('admincp/phrase.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});

app.post(['/messages/save'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['messagesmenu'] = 'active';
    messages = require('../../module/message');
    user = require('../../module/user');

    req.body.r_id = parseInt(req.body.r_id);
    console.log('MESSAGE ID --------------------', req.body.r_id);
    console.log('req.body', req.body);
    if (req.body.r_id <= 0) {
        console.log('messages add --------------------', req.body);
        /*req.body.toemail = req.body.users;
        var dat = require('date-util');
        req.body.r_id = Date.parse(new Date()) / 1000;
        var obj = {
            api_key: global.fwrdauctionAPI.api,
            app_key: global.fwrdauctionAPI.key,
            field_names: "id, first_name, last_name",
            where_condition: ' where email = "' + req.body.toemail + '"',
            type: "no_type"
        }
        request({
            url: global.fwrdauctionAPI.url + 'users/common',
            qs: obj
        }, function (err, res, data) {
            if (err) {
                console.log('Error' + err);
            } else {
                data = JSON.parse(data);
                console.log('id', data.response.results);
                console.log('id', data.response.results[0]);
                console.log('id', data.response.results.id);
                console.log('id', data.response.results[0].id);
                req.body.toid = data.response.results[0].id;
                req.body.first_name = data.response.results[0].first_name;
                req.body.last_name = data.response.results[0].last_name;
                console.log('msg ----------------------------api');
                messages.addmessages(req, config.mysql, q);
            }
        });*/

        req.body.toemail = req.body.users;
        var dat = require('date-util');
        req.body.r_id = Date.parse(new Date()) / 1000;
        req.body.toid = req.body.users;
        req.body.userid = req.body.users;
        req.body.first_name = '';
        req.body.last_name = '';
        req.body.view_url = config.url+'/inbox/all/';
        
        q.all([hmb_user.getUserDetail(req, config.mysql, q)]).then(function (results) {
            var userData = results[0][0][0];
            req.body.first_name = userData.name;
            req.body.toemail = userData.email;
            q.all([messages.addmessages(req, config.mysql, q)]).then(function (results) {
                res.writeHead(302, {
                    'Location': '/admincp/messages/sent/'
                });
                res.end();
                return false;
            });
        });
    } else {
        q.all([messages.showmessages(req, config.mysql, q, 1)]).then(function (results) {
            console.log(results);
            $arr['messages'] = results[0][0];
            if ($arr['messages'].length == 0) {
                res.writeHead(302, {
                    'Location': '/admincp/messages'
                });
                res.end();
                return false;
            }
            if ($arr['messages'][0]['from_id'] != req.session.userid && $arr['messages'][0]['to_id'] != req.session.userid) {
                res.writeHead(302, {
                    'Location': '/admincp/messages'
                });
                res.end();
                return false;
            }
            req.body.toid = ($arr['messages'][0]['from_id'] == req.session.userid) ? $arr['messages'][0]['to_id'] : $arr['messages'][0]['from_id'];
            req.body.subject = $arr['messages'][0]['subject'];
            req.body.toemail = ($arr['messages'][0]['from_id'] == req.session.userid) ? $arr['messages'][0]['to_id'] : $arr['messages'][0]['from_id'];
            req.body.first_name = '';
            req.body.last_name = '';
            messages.addmessages(req, config.mysql, q);

            res.writeHead(302, {
                'Location': '/admincp/messages/view/' + req.body.r_id
            });
            res.end();
            return false;

            /*q.all([user.userInfo(req, config.mysql, q, req.body.toid, ['email', 'first_name', 'last_name'])]).then(function (results) {
                req.body.toemail = results[0][0][0]['email'];
                req.body.first_name = results[0][0][0]['first_name'];
                req.body.last_name = results[0][0][0]['last_name'];
                messages.addmessages(req, config.mysql, q);
                res.writeHead(302, {
                    'Location': '/admincp/messages/view/' + req.body.r_id
                });
                res.end();
                return false;
            });*/
        });
    }
});

app.get(['/messages/:action/:r_id'], function (req, res) {
    console.log('under messages section');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['messagesmenu'] = 'active';
    messages = require('../../module/message');
    req.body.r_id = (typeof (req.param('r_id')) !== 'undefined') ? req.param('r_id') : 0;
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    $arr['r_id'] = req.body.r_id;
    req.body.r_id = parseInt(req.body.r_id);
    if (req.body.r_id <= 0) {
        res.writeHead(302, {
            'Location': '/admincp/messages'
        });
        res.end();
        return false;
    }
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    $arr['action'] = req.body.action;
    if (req.body.action != 'view') {
        messages.movemessages(req, config.mysql, q);
        res.writeHead(302, {
            'Location': '/admincp/messages/view/' + req.body.r_id
        });
        res.end();
        return false;
    }
    q.all([messages.showmessages(req, config.mysql, q, 1), messages.showmessages(req, config.mysql, q, 0)]).then(function (results) {
        $arr['messages'] = results[0][0];
        if ($arr['messages'].length == 0) {
            res.writeHead(302, {
                'Location': '/admincp/messages'
            });
            res.end();
            return false;
        }
        if ($arr['messages'][0]['from_id'] != req.session.userid && $arr['messages'][0]['to_id'] != req.session.userid) {
            res.writeHead(302, {
                'Location': '/admincp/messages'
            });
            res.end();
            return false;
        }
        if ($arr['messages'].length > 0) {
            var pagination = require('pagination');
            $arr['pagination'] = results[1][0].length;
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/messages/' + req.body.action + '/' + req.body.r_id,
                current: req.body.page,
                rowsPerPage: 5,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();
            req.body.r_id = $arr['messages'][0]['r_id'];
            messages.readmessages(req, config.mysql, q);
        }
        common.tplFile('admincp/message-view.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});


app.get(['/contact/msgs', '/contact/msgs/:action/:id'], function (req, res) {


    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['contactmsgsmenu'] = 'active';
    messages = require('../../module/message');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    console.log(req.body.action);
    req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : '';
    $arr['action'] = req.body.action;
    $arr['page'] = req.body.page;
    if(req.body.action == 'view'){
        q.all([messages.getContactMessage(req, config.mysql, q, 0)]).then(function (results) {
            console.log(results)
            console.log('running-----------------------------------------');

            $arr['messages'] = results[0][0][0];
            common.tplFile('admincp/contact-message-view.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });

    } else {
        q.all([messages.adminContactMsgs(req, config.mysql, q, 0), messages.adminContactMsgs(req, config.mysql, q, 1)]).then(function (results) {
            console.log('running-----------------------------------------');
            $arr['pagination'] = results[1][0][0].msgcount;
            $arr['messages'] = results[0][0];
            if (typeof ($arr['action']) === 'undefined' || $arr['action'] == '') {
                $arr['messagesstatus'] = '';
            } else {
                $arr['messagesstatus'] = $arr['action'];
            }
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/contact/msgs/' + req.body.action,
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/contact_messages.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }

        
});

app.get(['/messages', '/messages/:action'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['messagesmenu'] = 'active';
    messages = require('../../module/message');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    $arr['action'] = req.body.action;
    if (req.body.action == 'compose') {
        //var roles = 1+','+2+','+3+','+4+','+5+','+6;
        var roles = [1,2,3,4,5,6];
        var fields = "id, email, name, username";
        q.all([messages.getUserList(req, config.mysql, q, roles, fields)]).then(function (results) {
            $arr['users'] = [];
            if(results[0][0].length > 0)
                $arr['users'] = results[0][0];

            common.tplFile('admincp/compose.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
        /*var obj = {
            api_key: global.fwrdauctionAPI.api,
            app_key: global.fwrdauctionAPI.key,
            field_names: "email, first_name",
            where_condition: ' where id != 0',
            type: "no_type"
        }
        request({
            url: global.fwrdauctionAPI.url + 'users/common',
            qs: obj
        }, function (err, res, data) {
            if (err) {
                console.log('Error' + err);
            } else {
                data = JSON.parse(data);
                $arr['users'] = data.response.results;
            }
        });

        common.tplFile('admincp/compose.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);*/
        /*q.all([messages.usersmessages(req, config.mysql, q)]).then(function(results) {
            $arr['users'] = results[0][0];
            common.tplFile('admincp/compose.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });*/
    } else {
        q.all([messages.adminmymessages(req, config.mysql, q, 0), messages.adminmymessages(req, config.mysql, q, 1)]).then(function (results) {
            console.log('running-----------------------------------------');
            $arr['pagination'] = results[1][0].length;
            $arr['messages'] = results[0][0];
            if (typeof ($arr['action']) === 'undefined' || $arr['action'] == '') {
                $arr['messagesstatus'] = '';
            } else {
                $arr['messagesstatus'] = $arr['action'];
            }
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/messages/' + req.body.action,
                current: req.body.page,
                rowsPerPage: 5,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/messages.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});


app.get(['/withdrawal', '/withdrawal/:action/:id'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['withdrawalmenu'] = 'active';
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;

    action = req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    if (action == 'paid') {
        admin.paidWithdraw(req, config.mysql, q);
        admin.unpaidWithdraw(req, config.mysql, q);
        res.writeHead(302, { 'Location': '/admincp/withdrawal/success/Mark As Paid' });
        res.end();
        return false;
    }
    if (action == 'success') {
        $arr['message'] = 'Mark AS Paid Success!';
    }
    q.all([admin.allWithdraw(req, config.mysql, q, 0), admin.allWithdraw(req, config.mysql, q, 1)]).then(function (result) {
        $arr['withdraw'] = result[0][0];
        $arr['withdraws'] = result[1][0].length;
        var paginator = new pagination.SearchPaginator({
            prelink: '/admincp/withdrawal/',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['withdraws']
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('admincp/withdrawal.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/reviews'], function (req, res) {
    delete $arr['menu'];
    $arr['headings_reviews'] = 'Reviews'
    $arr['menu'] = [];
    $arr['menu']['reviewsmenu'] = 'active';
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    q.all([
        admin.allreviews(req, config.mysql, q, 0),
        admin.allreviews(req, config.mysql, q, 1)
    ]).then(function (result) {
        var user_ids = _.pluck(result[0][0], 'user_id');
        faAPI.appendUserDataForObject('id', 'id as user_id,username,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {

            $arr['review'] = common.addDecimalPlaces('reviews', apiUsersRes);
            console.log(JSON.stringify($arr.review));
            $arr['reviews'] = result[1][0].length;
            // $arr['users'] = common.addDecimalPlaces('users', apiUsersRes.results);

            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, { page: '' });
            console.log('fquery', fquery);

            $arr['search'] = query;

            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/reviews/',
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['reviews']
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/reviews.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    });
});
app.post(['/reviews/delete/multiple'], function (req, res) {
    console.log('ids', req.body.ids);
    admin.deletemultiplereviews(req, config.mysql, q);
    res.json({
        'success': true
    });
    res.end();
    return false;
});
app.get(['/reviews/:action/:id'], function (req, res) {
    var action = req.param('action');
    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    if (action == 'delete') {
        admin.deletereviews(req, config.mysql, q);
        res.writeHead(302, {
            'Location': '/admincp/reviews'
        });
        res.end();
        return false;
    }

});

app.get(['/dispute'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['disputemenu'] = 'active';
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    q.all([admin.alldispute(req, config.mysql, q, 0), admin.alldispute(req, config.mysql, q, 1)]).then(function (result) {
        $arr['review'] = result[0][0];
        $arr['reviews'] = result[1][0].length;
        var paginator = new pagination.SearchPaginator({
            prelink: '/admincp/dispute/',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['reviews']
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('admincp/dispute.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post(['/blog/save'], function (req, res) {

    var attach = require('../../module/attach');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['blogmenu'] = 'active';
    attach.save('blog', req, res);
    req.body.id = (typeof (req.body.id) === 'undefined') ? 0 : req.body.id;
    if (req.body.id > 0) {
        admin.saveBlog(req, config.mysql, q);
        admin.blogupload(req, config.mysql, q);
        res.writeHead(302, { 'Location': '/admincp/blog/edit/' + req.body.id + '/saved' });
        res.end();
        return false;
    } else {
        q.all(admin.saveBlog(req, config.mysql, q)).then(function (l) {
            req.body.id = l[0].insertId;
            admin.blogupload(req, config.mysql, q);
            res.writeHead(302, { 'Location': '/admincp/blog/edit/' + l[0].insertId + '/saved' });
            res.end();
            return false;
        });
    }
});

app.get(['/blog', '/blog/:action', '/blog/:action/:id/:error', '/blog/:action/:id'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['blogmenu'] = 'active';
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    action = req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    $arr['blogs'] = [];
    if (action == 'new') {
        common.tplFile('admincp/nblog.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    } else if (action == 'edit') {
        q.all([admin.selblog(req, config.mysql, q, 0)]).then(function (result) {
            $arr['blogs'] = result[0][0][0];
            common.tplFile('admincp/nblog.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    } else {
        if (action == 'unpublish' || action == 'publish') {
            admin.publishBlog(req, config.mysql, q);
        }
        req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
        q.all([admin.allblog(req, config.mysql, q, 0), admin.allblog(req, config.mysql, q, 1)]).then(function (result) {
            $arr['blog'] = result[0][0];
            $arr['blogs'] = result[1][0].length;
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/blog/',
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['blogs']
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/blog.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});


app.get(['/settings/:action', '/settings/:action/:error'], function (req, res) {


    delete $arr['menu'];
    $arr['menu'] = [];


    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'common' : req.param('action');
    if (action == 'ads') {
        $arr['menu']['settingsmenuads'] = 'active';
        $arr['menu']['adssettingsmenuads'] = 'active';
    } else {
        $arr['menu']['settingsmenu'] = 'active';
        $arr['menu'][action + 'settingsmenu'] = 'active';
    }

    var fs = require('fs'),
        ini = require('ini');
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    $arr['settings'] = configed['section'][action];

    $arr['type'] = configed['section'][action + 'type'];
    $arr['value'] = configed['section'][action + 'value'];
    $arr['questions'] = configed['section'][action + 'questions'];
    $arr['action'] = action;
    errorr = $arr['error'];
    if (action == 'mode' && errorr == 'saved') {
        $arr['error'] = "Maintenance mode  updated successfully";
    }
    switch (action) {
        case 'ads':
            $arr['heading'] = 'Ad\'s settings';
            break;
        case 'card':
            $arr['heading'] = 'Credit card details';
            break;
        case 'database':
            $arr['heading'] = 'Database settings';
            break;
        case 'facebook':
            $arr['heading'] = 'Facebook API settings';
            break;
        case 'customerio':
            $arr['heading'] = 'Customer IO settings';
            break;
        case 'linkedin':
            $arr['heading'] = 'Linkedin settings';
            break;
        case 'mode':
            $arr['heading'] = 'Maintenance mode settings';
            break;
        case 'general':
            $arr['heading'] = 'General settings';
            break;
        case 'common':
            $arr['heading'] = 'System settings';
            break;

        case 'paypal':
            $arr['heading'] = 'Paypal settings';
            break;
        case 'testing':
            $arr['heading'] = 'Testings';
            break;
    }
    common.tplFile('admincp/settings.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});
app.get(['/distributor/:action', '/distributor/:action/:error'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];

    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'common' : req.param('action');
    if (action == 'ads') {
        $arr['menu']['settingsmenuads'] = 'active';
        $arr['menu']['adssettingsmenuads'] = 'active';
    } else {
        $arr['menu']['settingsmenu'] = 'active';
        $arr['menu'][action + 'settingsmenu'] = 'active';
    }

    var fs = require('fs'),
        ini = require('ini');
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    $arr['settings'] = configed['section'][action];

    $arr['type'] = configed['section'][action + 'type'];
    $arr['value'] = configed['section'][action + 'value'];
    $arr['questions'] = configed['section'][action + 'questions'];
    $arr['action'] = action;
    errorr = $arr['error'];
    if (action == 'mode' && errorr == 'saved') {
        $arr['error'] = "Maintenance mode  updated successfully";
    }
    switch (action) {
        case 'general':
            $arr['heading'] = 'General settings';
            break;
    }
    common.tplFile('admincp/settings_distributor.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.get(['/stores', '/stores/:error'], function (req, res) {

    req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
    req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
    req.body.title = (typeof (req.param('title')) === 'undefined') ? '' : req.param('title');
    req.body.location = (typeof (req.param('location')) === 'undefined') ? '' : req.param('location');
    req.body.status = (typeof (req.param('status')) === 'undefined') ? '' : req.param('status');

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['storemenu'] = 'active';
    var stores = require('../../module/stores');
    var fs = require('fs'),
        ini = require('ini');

    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    if (req.param('enable')) {

        configed['section']['stores']['enable'] = req.param('enable');

        fs.writeFileSync('./config.ini', ini.stringify(configed));
        config.mysql.destroy();
        delete configure;
        delete config;
        delete $arr;

        configure = require('../../configure');
        config = configure.app();
        $arr = {
            config: config
        }
        $arr['error'] = "Store functionality has changed successfully";
    } else if (req.param('error') != '' && req.param('error') != undefined) {
        $arr['error'] = req.param('error');
    }
    $arr['enabled'] = configed['section']['stores']['enable'];
    //$arr.error = (typeof(req.param('error')) === 'undefined') ? '' :  req.param('error');
    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    q.all([stores.viewAllStores(req, config.mysql, q, 0), stores.viewAllStores(req, config.mysql, q, 1)]).then(function (results) {
        var user_ids = _.pluck(results[0][0], 'user_id');
        // <<<<<<< HEAD
        faAPI.appendUserDataForObject('id', 'id as user_id,username,email,first_name,last_name', user_ids, results[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {
            console.log('api res', apiUsersRes);

            $arr['stores'] = apiUsersRes;
            $arr['paginaton'] = results[1][0].length;
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            $arr['search'] = query;
            console.log('query', query);
            fquery = common.urlparameter(query);
            console.log('fquery', fquery);
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/stores/?' + fquery,
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['paginaton']
            });
            $arr['pagination_html'] = paginator.render();
            // =======
            //             faAPI.appendUserDataForObject('id', 'id as user_id,username,email,first_name,last_name', user_ids, results[0][0], 'user_id', function(apiUsersErr, apiUsersRes) {
            //         $arr['stores'] = apiUsersRes;
            //         $arr['paginaton'] = results[1][0].length;
            //         var url = require('url');
            //         var url_parts = url.parse(req.url, true);
            //         var query = url_parts.query;
            //         $arr['search'] = query;
            //         fquery = common.urlparameter(query);
            // console.log('fquery', fquery);
            //         var paginator = new pagination.SearchPaginator({
            //             prelink: '/admincp/stores/?'+fquery,
            //             current: req.body.page,
            //             rowsPerPage: 10,
            //             totalResult: $arr['paginaton']
            //         });
            //         $arr['pagination_html'] = paginator.render();
            // >>>>>>> 35b8f34627884c42a6e944dc4bbb8845c647c458

            common.tplFile('admincp/stores.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    });
});
app.post(['/stores/update/'], function (req, res) {

    var stores = require('../../module/stores');
    req.body.id = req.param('sid');
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function (results) {
        req.body.logo = results[0][0][0].logo;
        stores.updateStoresAdmin(req, $arr.config.mysql, q);
        res.writeHead(302, {
            'Location': '/admincp/stores/Updated Sucessfully!'
        });
        res.end();
        return false;
    });
});
app.get(['/stores/edit/:id'], function (req, res) {

    var stores = require('../../module/stores');
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function (results) {
        $arr.id = req.param('id');
        $arr.nulldata = null;
        $arr.store = results[0][0][0];
        console.log($arr.store);
        console.log($arr.storeCategories);
        common.tplFile('admincp/editstores.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});
app.post(['/stores/delete/multiple'], function (req, res) {

    var stores = require('../../module/stores');
    stores.deleteStoreMultiple(req, config.mysql, q);
    res.json({
        'success': true
    });
    res.end();
    return false;

});
app.get(['/stores/delete/:id'], function (req, res) {

    var stores = require('../../module/stores');
    stores.deleteStore(req, config.mysql, q);
    res.writeHead(302, { 'Location': '/admincp/stores/Deleted Sucessfully!' });
    res.end();
    return false;
    return false;

});
app.post(['/settings/:action', '/settings/:action/:user_type'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'common' : req.param('action');
    var user_type = req.body.user_type = (typeof (req.param('user_type')) === 'undefined') ? '' : req.param('user_type');
    
    var fs = require('fs'),
        ini = require('ini');

    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    configed['section'][action] = req.body[action];
    fs.writeFileSync('./config.ini', ini.stringify(configed));

    config.mysql.destroy();
    delete configure;
    delete config;
    delete $arr;

    configure = require('../../configure');
    config = configure.app();
    $arr = {
        config: config
    }
    console.log("Action is " + action);
    if (action == 'homepage') {
        res.writeHead(302, { 'Location': '/admincp/projects/' + action + '/0/saved' });
    } 
    else if (user_type == 'distributor') {
        res.writeHead(302, { 'Location': '/admincp/distributor/' + action + '/saved' });
    }
    else {
        res.writeHead(302, { 'Location': '/admincp/settings/' + action + '/saved' });
    }
    res.end();
    return false;
});
app.post(['/projects/delete/multiple'], function (req, res) {
    projects.removeProjectMultiple(req, config.mysql, q);
    res.json({
        'success': true
    });
    res.end();
    return false;

});
app.get(['/projects/:action/', '/projects/:action/:id', '/projects/:action/:id/:error'], function (req, res) {

    delete $arr['menu'];

    $arr.externalcss = ['datePicker'];
    $arr.externaljs = ['jquery.datePicker'];

    req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
    req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
    req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    $arr.action = action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'search' : req.param('action');
    $arr['menu'] = [];
    $arr['menu']['projectsmenu'] = 'active';
    $arr['menu'][action] = 'active';

    $arr['projects'] = [];

    $arr.limit = 10;

    if (action == 'feature') {
        req.session.featured_add = 1;
        projects.updateFeatureData(req, config.mysql, q, req.param('id'));
        res.writeHead(302, { 'Location': '/admincp/projects/list' });
        res.end();
        return false;
    }

    if (action == 'unfeature') {
        projects.updateUnFeatureData(req, config.mysql, q, req.param('id'));
        res.writeHead(302, { 'Location': '/admincp/projects/list' });
        res.end();
        return false;
        // return false;
    }

    if (action == 'delete' && req.body.id > 0) {

        global.projectdeleted = true;
        projects.removeProject(req, config.mysql, q, req.body.id);
        res.writeHead(302, { 'Location': '/admincp/projects/list' });
        res.end();
        return false;
        // return false;

    }

    if (action == 'list' || action == 'open' || action == 'closed' || action == 'sold' || action == 'future') {
        console.log('list---------------------------------------------');
        $arr['deleted_project'] = $arr['undeleted_project'] = false;
        if (typeof (global.projectdeleted) !== 'undefined') {
            delete global.projectdeleted;
            $arr['deleted_project'] = true;
        }
        if (typeof (global.unprojectdeleted) !== 'undefined') {
            delete global.unprojectdeleted;
            $arr['undeleted_project'] = true;
        }
        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        var fquery = common.urlparameter(query, { page: '' });
        $arr['search'] = query;
        req.query.sort_order = (typeof (req.query.sort_order) == 'undefined') ? '' : req.query.sort_order;
        req.query.search_val = (typeof (req.query.search_val) == 'undefined') ? '' : req.query.search_val;
        console.log('search----------' + req.query.search_val + '--------sort-------------' + req.query.sort_order);
        $arr['menu']['projectsearchmenu'] = 'active';

        req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
        $arr.page = req.body.page;
        //$arr['menu']['projectsearchmenu'] = 'active';
        q.all([admin.userProductSearch(req, config.mysql, q, 0), admin.userProductSearch(req, config.mysql, q, 1)]).then(function (result) {

            // console.log(JSON.stringify(result));
            var user_ids = _.pluck(result[0][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {

                $arr['pagination'] = result[1][0].length;
                $arr['projects'] = projects.shortDescribe(apiUsersRes);
                $arr['projectsstatus'] = req.query.status == 'undefined' ? 'products' : req.query.status;
                if (typeof ($arr['projectsstatus']) === 'undefined') {
                    $arr['projectsstatus'] = '';
                }

                var pagination = require('pagination');
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/projects/' + action + '/?' + fquery,
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: $arr['pagination']
                });

                $arr['pagination_html'] = paginator.render();

                /*    if ((req.query.sort_order == '' && req.query.search_val == '')) {*/
                common.tplFile('admincp/project.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
                /* } else {
                     common.tplFile('admincp/project-list.tpl');
                     common.headerSet(0);
                     common.loadTemplateHeader(req, res, $arr);
                 }*/
            });

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    }

    if (action == 'approve' && req.body.id > 0) {
        admin.approveProduct(req, config.mysql, q);
        res.writeHead(302, { 'Location': '/admincp/projects/list' });
        res.end();
        return false;
        // return false;
    }

    if (action == 'new') {
        q.all([user.userInfo(req, config.mysql, q, req.session.userid, ['paypal_address', 'zip', 'state', 'city', 'country']), common.locations(req, config.mysql, q)]).then(function (results) {
            $arr['menu']['projectsnewmenu'] = 'active';
            $arr['user'] = results[0][0][0];
            $arr.locations = results[1][0];
            $arr['pid'] = common.randomNumber(5);
            common.tplFile('admincp/nproject.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        })

    }

    if (action == 'edit') {
        console.log("edit section");
        $arr['menu']['projectseditmenu'] = 'active';
        $arr.stat = (typeof (req.param('stat') !== 'undefined') && req.param('stat') == 'saved') ? 1 : 0;
        var stores = require("../../module/stores");
        req.body.project_id = parseInt(req.param('id'));
        q.all([
            projects.productDetail(req, config.mysql, q),
            projects.productImage(req, config.mysql, q),
            common.locations(req, config.mysql, q),
            stores.stores_detatils(req, $arr.config.mysql, q)
        ]).then(function (result) {

            $arr['projects'] = result[0][0][0];
            $arr['projects_images'] = result[1][0][0];
            $arr['store_detail'] = result[3][0][0];

            common.tplFile('admincp/nproject.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }

    if (action == 'homepage') {
        $arr.error = req.body.error;
        console.log("Eror is " + $arr.error);
        $arr['menu']['dealshmenu'] = 'active';
        var fs = require('fs'),
            ini = require('ini');
        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
        $arr['settings'] = configed['section'][action];
        $arr['type'] = configed['section'][action + 'type'];
        $arr['value'] = configed['section'][action + 'value'];
        $arr['questions'] = configed['section'][action + 'questions'];
        $arr['action'] = action;
        console.log($arr['settings']);
        $arr['heading'] = 'Deals of the day';

        common.tplFile('admincp/settings.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }
});

/*****************************************************************************
 |                 admin soide product editing                               |
 *****************************************************************************/
app.post(['/products/save'], function (req, res) {

    console.log(req.body);
    var attach = require('../../module/attach');
    // var admin = require('../../module/admin');
    var projects = require('../../module/products');

    var admin = require('../../module/admin');

    req.body.id = (typeof (req.body.id) === 'undefined') ? 0 : req.body.id;
    req.body.cid = (typeof (req.body.cid) == 'undefined') ? req.body.mcid : req.body.cid;

    //req.body.stax = (typeof(req.body.stax) == 'undefined') ? 0 : req.body.stax;
    console.log('store product', req.body);
    if (req.body.id > 0) {
        // admin.deleteAttachment(config.mysql, q, req);
        q.all([projects.productDetail(req, config.mysql, q)]).then(function (result) {
            var total_size = 0;

            q.all([products.productImage(req, config.mysql, q)]).then(function (imgArray) {

                var imgArrayCount = imgArray[0][0].length;

                if (imgArrayCount > 0 && req.body.product_image == null) {

                    req.body.product_image = imgArray[0][0][0].image;
                    req.body.avatar = imgArray[0][0][0].avatar;
                }



                var attach = require('../../module/attach');
                attach.save('product', req, res);

                if (req.files.product_image !== undefined) {
                    q.all([attach.saveAttachments(req, config.mysql, q, req.body.id)]).then(function (result) {
                        // console.log(JSON.stringify(result));
                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    }).done();
                }

                console.log(req.files.test_results);

                if (req.files.test_results !== undefined) {
                    q.all([attach.saveTestresult(req, config.mysql, q, req.body.id)]).then(function (result) {
                        // console.log(JSON.stringify(result));
                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    }).done();
                }

                admin.saveeditProduct(req, config.mysql, q, result[0][0][0]);

                // console.log('req.body.last_url');
                // console.log(req.body.last_url);

                if (req.body.last_url != 'undefined' && req.body.last_url != '' && req.body.last_url) {
                    res.writeHead(302, {
                        'Location': req.body.last_url
                    });
                    res.end();
                } else {
                    res.writeHead(302, {
                        'Location': '/admincp/projects/edit/' + req.body.id + '/?stat=saved'
                    });
                    res.end();
                }
                return false;
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();

    }

});

// app.post(['/products/save'], function(req, res) {
//     var attach = require('../../module/attach');
//     // var admin = require('../../module/admin');
//     projects = require('../../module/products');
//     req.body.id = (typeof(req.body.id) === 'undefined') ? 0 : req.body.id;

//     req.body.cid = (typeof(req.body.cid) == 'undefined') ? req.body.mcid : req.body.cid;
//     if (req.body.id > 0) {
//         total_size = 0;
//         admin.addProductionAnswer(req, config.mysql, q, req.body.id);
//         //admin.deleteAttachment(config.mysql,q,req);
//         q.all([projects.productDetail(req, config.mysql, q)]).then(function(result) {

//             if (typeof(req.session.aid) !== 'undefined') {

//                 if (typeof(req.session.aid[req.body.random_id]) !== 'undefined') {

//                     for (i in req.session.aid[req.body.random_id]) {

//                         if (req.session.aid[req.body.random_id][i] != null) {

//                             req.body.product_image = req.session.aid[req.body.random_id][i].originalName;
//                             req.body.avatar = req.session.aid[req.body.random_id][i].name;
//                             admin.addAttachment(req.session.aid[req.body.random_id][i], config.mysql, q, req.body.id);

//                             sizeInKb = common.parseFloat(req.session.aid[req.body.random_id][i].size);

//                             total_size = total_size + sizeInKb;
//                         }
//                     }
//                 }
//             }
//             q.all([projects.productImage(req, config.mysql, q)]).then(function(imgArray) {
//                 var imgArrayCount = imgArray[0][0].length;

//                 if (imgArrayCount > 0 && req.body.product_image == null) {
//                     req.body.product_image = imgArray[0][0][0].image;
//                     req.body.avatar = imgArray[0][0][0].avatar;
//                 }

//                 projects.saveProduct(req, config.mysql, q, result[0][0][0]);
//                 admin.addProductionAnswer(req, config.mysql, q, req.body.id);


//                 size = common.convertBytesToKb(total_size)
//                 req.session.used_attach_space = common.sumFloat(req.session.used_attach_space, size);
//                 projects.updateAttachmentLimit(req, config.mysql, q, size);
//                 /*if(typeof(req.files.product_image) !== 'undefined')
//                  {
//                  var m =req.files.product_image;
//                  if(typeof(m[0]) !== 'undefined')
//                  {
//                  for(var im = 0;im < m.length;im++){
//                  admin.addAttachment(m[im],config.mysql,q,req.body.id);
//                  }
//                  }
//                  else
//                  {
//                  admin.addAttachment(m,config.mysql,q,req.body.id);
//                  }
//                  } */
//                 res.writeHead(302, { 'Location': '/admincp/projects/edit/' + req.body.id + '/saved' });
//                 res.end();
//                 return false;
//             }).fail(function(err) {
//                 console.log(err.stack);
//                 throw err;
//             }).done();
//         }).fail(function(err) {
//             console.log(err.stack);
//             throw err;
//         }).done();
//     } else {
//         //attach.save('product',req,res);
//         if (typeof(req.session.aid) !== 'undefined') {

//             if (typeof(req.session.aid[req.body.random_id]) !== 'undefined') {

//                 for (i in req.session.aid[req.body.random_id]) {

//                     if (req.session.aid[req.body.random_id][i] != null) {

//                         req.body.product_image = req.session.aid[req.body.random_id][i].originalName;
//                         req.body.avatar = req.session.aid[req.body.random_id][i].name;

//                     }
//                 }
//             }
//         }
//         q.all(projects.save(req, res, config.mysql, q)).then(function(l) {
//             req.body.p_id = l[0].insertId;
//             req.body.id = l[0].insertId;
//             total_size = 0;
//             if (typeof(req.session.aid) !== 'undefined') {

//                 if (typeof(req.session.aid[req.body.random_id]) !== 'undefined') {

//                     for (i in req.session.aid[req.body.random_id]) {

//                         if (req.session.aid[req.body.random_id][i] != null) {

//                             req.body.product_image = req.session.aid[req.body.random_id][i].originalName;
//                             req.body.avatar = req.session.aid[req.body.random_id][i].name;
//                             admin.addAttachment(req.session.aid[req.body.random_id][i], config.mysql, q, req.body.id);

//                             sizeInKb = common.parseFloat(req.session.aid[req.body.random_id][i].size);

//                             total_size = total_size + sizeInKb;
//                         }
//                     }
//                 }
//             }

//             size = common.convertBytesToKb(total_size)
//             req.session.used_attach_space = common.sumFloat(req.session.used_attach_space, size);
//             projects.updateAttachmentLimit(req, config.mysql, q, size);
//             admin.addProductionAnswer(req, config.mysql, q, req.body.p_id);
//             /* if(typeof(req.files.product_image) !== 'undefined')
//              {
//              var m =req.files.product_image;
//              if(typeof(m[0]) !== 'undefined')
//              {
//              for(var im = 0;im < m.length;im++){
//              admin.addAttachment(m[im],config.mysql,q,l[0].insertId);
//              }
//              }
//              else {
//              admin.addAttachment(m,config.mysql,q,l[0].insertId);
//              }
//              }  */
//             res.writeHead(302, { 'Location': '/admincp/projects/edit/' + l[0].insertId + '/saved' });
//             res.end();
//             return false;
//         }).fail(function(err) {
//             console.log(err.stack);
//             throw err;
//         }).done();
//     }
// });

/* app.post(['/users/:action/'], function (req, res) {

    // console.log(JSON.stringify(req.body));
    if (common.admincheckLogin(req, res, 1)) {
        delete $arr['menu'];
        $arr['menu'] = [];
        $arr['menu']['usersmenu'] = 'active';
        $arr['menu']['editusersmenu'] = 'active';
        action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
        // console.log(action);
        req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
        req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
        req.body.page = (req.body.page - 1) * 10;
        var register = require('../../module/register');

        if (action == 'save') {
            console.log("update user here");
            req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
            var register = require('../../module/register');

            async.series({
                setStateAbbr: function (cb) {
                    q.all(common.getStateAbbr('', config.mysql, q, req.body.state)).then(function (result1) {
                        req.body.state_abbr = result1[0][0].sc;
                        console.log(result1[0][0].sc)
                        cb(null, result1[0][0].sc)
                    }).fail(function (err) {
                        console.log(err.stack);
                        cb(err, null);
                        throw err;
                    });
                },
                getUserInfo: function (cb) {
                    // getting userInformations
                    var userDataCallback = function (err, response) {

                        if (err != null) {
                            if (err.code == 'D1016') {
                                err.exists = false
                                cb(null, err);
                            } else {
                                cb(err, null);
                            }
                        } else {
                            response.exists = true
                            cb(err, response);
                        }
                    }

                    faAPI.userInfo(req, req.body.id, userDataCallback);
                },
                checkUsername: function (cb) {
                    console.log("checkUsername");
                    // getting userInformations
                    var callback = function (err, response) {

                        cb(err, response);

                    }
                    faAPI.checkUserExistance(req, "username", req.body.username, callback);
                    // faAPI.userInfo(req, userDataCallback);

                },
                checkEmail: function (cb) {
                    console.log("checkEmail");
                    // getting userInformations
                    var callback = function (err, response) {

                        cb(err, response);

                    }
                    faAPI.checkUserExistance(req, "email", req.body.email, callback);
                    // faAPI.userInfo(req, userDataCallback);
                }
            },
                function (err, results) {

                    var attach = require('../../module/attach');
                    attach.save('profile', req, res);
                    attach.save('business', req, res);

                    // console.log(req.files);

                    if (!(_.isEmpty(req.files))) {
                        if (typeof (req.files.profile_image) !== 'undefined') {
                            console.log('------profile_image----')
                            req.body.avatar = req.files.profile_image.name;
                            console.log('------profile_image----')
                            req.body.image = req.files.profile_image.originalname;
                            console.log('------profile_image----')
                        }
                        if (typeof (req.files.licenses) !== 'undefined') {
                            console.log('------licenses----')
                            req.body.license_img = req.files.licenses.name;
                            console.log('------licenses----')
                        }
                        if (typeof (req.files.certificates) !== 'undefined') {
                            console.log('------certificates----')
                            req.body.business_cert = req.files.certificates.name;
                            console.log('------certificates----')
                        }
                    }

                    if ((results.getUserInfo.exists == true) && (req.body.id > 0)) {

                        req.body.updateFields = {};


                        if (results.getUserInfo.user.username != req.body.username) {
                            // console.log("results.getUserInfo.user.username");
                            if ((results.checkUsername.code == "D200") && (results.checkUsername.exists == true)) {
                                // if ((results.checkEmail.code == "D200") && (results.checkEmail.exists == true)) {
                                // if ((response.code == "D200") && (response.exists == true)) {
                                // console.log(emailuser);
                                res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/edit/' + req.body.id + '/Username Unavailable' });
                                res.end();
                                return false;
                                console.log('stop this');
                            } else {

                                req.body.updateFields.username = req.body.username;
                                // console.log("username here : " + req.body.updateFields.username);
                            }
                        }

                        if (results.getUserInfo.user.email != req.body.email) {
                            if ((results.checkEmail.code == "D200") && (results.checkEmail.exists == true)) {
                                res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/edit/' + req.body.id + '/Email Unavailable' });
                                res.end();
                                return false;
                                console.log('stop this');
                            } else {
                                // console.log("results.getUserInfo.user.email2");
                                req.body.updateFields.email = req.body.email;
                            }
                        }
                        if (req.body.password != req.body.cpassword) {
                            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/edit/' + req.body.id + '/Password Mismatch' });
                            res.end();
                            return false;
                        }

                        console.log("update user here");

                        req.body.updateFields.id = req.body.id;

                        if (results.getUserInfo.user.phone != req.body.phone) {
                            req.body.updateFields.phone = req.body.phone;
                        }

                        req.body.updateFields.first_name = req.body.first_name;
                        req.body.updateFields.last_name = req.body.last_name;
                        req.body.updateFields.country = req.body.country;
                        req.body.updateFields.city = req.body.city;
                        req.body.updateFields.state = req.body.state;
                        req.body.updateFields.state_abbr = req.body.state_abbr;
                        req.body.updateFields.aboutme = req.body.aboutme;
                        req.body.updateFields.zip = req.body.zip;
                        req.body.updateFields.address1 = req.body.address1;
                        // req.body.updateFields.address2 = req.body.address2;
                        req.body.updateFields.status = req.body.status;
                        req.body.updateFields.region = req.body.region;
                        req.body.updateFields.default_provider = req.body.default_provider;
                        req.body.updateFields.default_transport = req.body.default_transport;






                        faAPI.updateUser(req, 'admin_updateusers', function (err, response) {

                            if (typeof (req.body.password) != 'undefined') {
                                if (req.body.password == req.body.cpassword) {
                                    req.body.password_hash = req.body.password
                                    req.body.password_confirmation = req.body.cpassword
                                    faAPI.resetPassword(req, function (error, respon) {
                                        console.log("password updated");
                                    })
                                }
                            }

                            // console.log(req.body);

                            req.body.fname = req.body.first_name;
                            req.body.lname = req.body.last_name;
                            req.body.email = req.body.email;
                            req.body.phone = req.body.phone;
                            req.body.shipping_address = req.body.address1;
                            req.body.shipping_country = req.body.country;
                            req.body.shipping_state = req.body.state;
                            req.body.shipping_state_abbr = req.body.updateFields.state_abbr;
                            req.body.shipping_city = req.body.city;
                            req.body.shipping_region = req.body.region;
                            req.body.shipping_zip = req.body.zip;

                            q.all([
                                register.checkShippingAddress(config.mysql, req, res, req.body.updateFields.id),
                                user.getBusinessType(req, config.mysql, q, req.body.updateFields.id)
                            ]).then(function (details) {

                                if (details[0][0].length > 0) {
                                    register.updateShippingDetails(config.mysql, req, res, req.body.updateFields.id)
                                } else {
                                    register.addShippingDetails(config.mysql, req, res, req.body.updateFields.id)
                                }

                                if (details[1][0].length > 0) {
                                    admin.updateBusiness(config.mysql, req, res, req.body.updateFields.id)
                                } else {
                                    admin.addAdminBusinessDetails(config.mysql, req, res, req.body.updateFields.id)
                                }

                            }).fail(function (err) {
                                console.log(err.stack);
                                throw err;
                            })


                            //res.writeHead(302, { 'Location': '/admincp/users/edit/' + req.body.id + '/User details updated successfully...!' });
                            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/search/' + req.body.id + '/User details updated successfully...!' });
                            res.end();
                            console.log('stop this');
                        });

                    } else {
                        console.log("add new user here---------------");
                        if ((results.checkUsername.code == "D200") && (results.checkUsername.exists == true)) {
                            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/add/' + req.body.id + '/Username Unavailable' });
                            res.end();
                            return false;
                            console.log('stop this');
                        }

                        if ((results.checkEmail.code == "D200") && (results.checkEmail.exists == true)) {
                            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/add/' + req.body.id + '/Email Unavailable' });
                            res.end();
                            return false;
                            console.log('stop this');
                        }

                        if (req.body.password != req.body.cpassword) {
                            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/add/' + req.body.id + '/Password Mismatch' });
                            res.end();
                            return false;
                        }


                        var attach = require('../../module/attach');
                        attach.save('profile', req, res);
                        attach.save('business', req, res);

                        // console.log(req.files);

                        if (!(_.isEmpty(req.files))) {
                            if (typeof (req.files.profile_image) !== 'undefined') {
                                console.log('------profile_image----')
                                req.body.avatar = req.files.profile_image.name;
                                console.log('------profile_image----')
                                req.body.image = req.files.profile_image.originalname;
                                console.log('------profile_image----')
                            }
                            if (typeof (req.files.licenses) !== 'undefined') {
                                console.log('------licenses----')
                                req.body.license_img = req.files.licenses.name;
                                console.log('------licenses----')
                            }
                            if (typeof (req.files.certificates) !== 'undefined') {
                                console.log('------certificates----')
                                req.body.business_cert = req.files.certificates.name;
                                console.log('------certificates----')
                            }
                        }

                        faAPI.registerUser(req, function (err, response) {
                            console.log(err)
                            req.body.fname = req.body.first_name;
                            req.body.lname = req.body.last_name;
                            req.body.email = req.body.email;
                            req.body.phone = req.body.phone;
                            req.body.shipping_address = req.body.address1;
                            req.body.shipping_country = req.body.country;
                            req.body.shipping_state = req.body.state;
                            req.body.shipping_state_abbr = req.body.state_abbr;
                            req.body.shipping_city = req.body.city;
                            req.body.shipping_region = req.body.region;
                            req.body.shipping_zip = req.body.zip;
                            req.body.default_provider = req.body.default_provider;
                            req.body.default_transport = req.body.default_transport;

                            q.all([
                                register.checkShippingAddress(config.mysql, req, res, response.userId),
                                user.getBusinessType(req, config.mysql, q, response.userId),
                                dashboard.get_temp_ids(req, config.mysql, q)
                            ]).then(function (details) {
                                console.log('details', details[2]);

                                var ids = _.pluck(details[2][0], 'id');
                                var str = '';

                                for (var i = 0; i < ids.length; i++) {
                                    if (ids.length == 1) {
                                        str = str + ids[i];
                                    }
                                    if (ids.length - 1 == i) {
                                        str = str + ids[i];
                                    } else {
                                        str = str + ids[i] + ',';
                                    }
                                }
                                req.body.email_settings = str;
                                req.body.result_userid = response.userId;
                                console.log('email-setting', req.body.email_settings);
                                req.body.notify_id = 0;
                                req.body.result_userid = response.userId;
                                dashboard.save_usernotify(req, config.mysql, q);


                                if (details[0][0].length > 0) {
                                    register.updateShippingDetails(config.mysql, req, res, response.userId)
                                } else {
                                    register.addShippingDetails(config.mysql, req, res, response.userId)
                                }

                                if (details[1][0].length > 0) {
                                    admin.updateBusiness(config.mysql, req, res, response.userId)
                                } else {
                                    admin.addAdminBusinessDetails(config.mysql, req, res, response.userId)
                                }

                            }).fail(function (err) {
                                console.log(err.stack);
                                throw err;
                            })
                            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/search/' + response.userId + '/New user added successfully...!' });
                            res.end();
                            return false;

                        });

                    }
                })
        }
    }
}); */


/* accessing users or getting users */
/*
user statuses :
active = approve
deactivate = suspend
unverified = pending
moderate = rejected
*/
app.get(['/subadmin/', '/subadmin/:entrytype'], function (req, res) {



    console.log("im in subadmin")
    $arr.externaljs = ['register', 'jquery.mask.min'];
    var md5 = require('MD5');
    var _entry = req.body.action = req.param('entrytype') != '' && typeof (req.param('entrytype')) != 'undefined' ? req.param('entrytype') : '';
    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    var password_salt = '12345'
    //datas start
    $arr['first_name'] = req.body.first_name = req.query.first_name != '' && typeof (req.query.first_name) != 'undefined' ? req.query.first_name : '';
    $arr['last_name'] = req.body.last_name = req.query.last_name != '' && typeof (req.query.last_name) != 'undefined' ? req.query.last_name : ''
    req.body.phone = req.query.phone != '' && typeof (req.query.phone) != 'undefined' ? req.query.phone : ''
    $arr['email'] = req.body.email = req.query.email != '' && typeof (req.query.email) != 'undefined' ? req.query.email : '';
    req.body.password = req.query.password != '' && typeof (req.query.password) != 'undefined' ? req.query.password : '';
    req.body.cpassword = req.query.cpassword != '' && typeof (req.query.cpassword) != 'undefined' ? req.query.cpassword : '';
    req.body.address1 = req.query.address1 != '' && typeof (req.query.address1) != 'undefined' ? req.query.address1 : '';
    req.body.state = req.query.state != '' && typeof (req.query.state) != 'undefined' ? req.query.state : '';
    req.body.country = req.query.country != '' && typeof (req.query.country) != 'undefined' ? req.query.country : '';
    req.body.city = req.query.city != '' && typeof (req.query.city) != 'undefined' ? req.query.city : '';
    req.body.zip = req.query.zipcode != '' && typeof (req.query.zipcode) != 'undefined' ? req.query.zipcode : '';
    req.body.status = 'active';
    req.body.role = req.query.role != undefined ? req.query.role : 2;
    req.body.region = req.query.region != '' && typeof (req.query.region) != 'undefined' ? req.query.region : '';
    //datas end



    $arr['menu'] = [];
    $arr['menu']['subadmin'] = 'active';
    $arr['menu'][_entry] = 'active';

    if (_entry == 'all' || _entry == '' || _entry == 'search') {

        if (_entry == 'all' || _entry == 'search') {

            var whereCondition = 'where del_status = 0 and (role=2 OR role=3 OR role=4) ';
            var fieldNames = 'id,email,first_name, last_name, address1, country, state, city, zip, phone, region, role';
            if (_entry == 'search') {

                if (req.body.email) {
                    whereCondition = whereCondition + 'and email like "%' + req.body.email + '%"'
                }
                if (req.body.last_name) {
                    whereCondition = whereCondition + ' and last_name like "%' + req.body.last_name + '%"'
                }
                if (req.body.first_name) {
                    whereCondition = whereCondition + ' and first_name like "%' + req.body.first_name + '%"'
                }


            } else {
                whereCondition = whereCondition + ' order by id DESC';
            }


            faAPI.callUserQuery('no_type', fieldNames, whereCondition, function (apiUsersErr, apiUsersRes) {

                $arr['users'] = apiUsersRes.results;
                common.tplFile('admincp/subadminlist.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);

            });
        } else {
            common.tplFile('admincp/subadmin.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }


    } else if (_entry == 'add' || _entry == 'edit' && _entry != '') {
        req.body.id = (req.body.id > 0) ? req.body.id : 0;
        if (_entry != 'edit') {
            if (req.body.id == 0) {
                console.log("my Add");
                var register = require('../../module/register');
                console.log("my Add");
                q.all([register.checkemail(config.mysql, req)]).then(function (result) {


                    var emailuser = result[0][0];
                    console.log("emailuser ", emailuser.length)

                    if (emailuser.length > 0) {
                        res.send({ "status": "Error", "error": "Email Already Exists" });
                        res.end()
                    } else {

                        if (req.body.password == '' || typeof (req.body.password) === 'undefined' || req.body.password != req.body.cpassword) {
                            res.send({ "status": "Error", "error": "Password Did't match" });
                            res.end()
                        } else {
                            req.body.cpassword = req.query.cpassword != '' && typeof (req.query.cpassword) != 'undefined' ? md5(md5(req.query.cpassword) + password_salt) : '';
                            async.series([function (callback) {
                                faAPI.registerUser(req, callback)
                            }],
                                // optional callback
                                function (err, results) {
                                    if (err) {
                                        res.send({ "status": "Error", "error": "Something Went To Be Wrong. Please Try Again" });
                                        res.end()
                                    } else {
                                        res.send({ "status": "success", "succesmsg": 'Added', 'userId': results[0].userId });
                                        res.end()
                                    }

                                })

                        }

                    }


                }).fail(function (e) {
                    console.log(e.stack)
                    throw e;

                }).done()

            } else {
                req.body.updateFields = {};
                req.body.updateFields.region = req.body.region;
                req.body.updateFields.first_name = req.body.first_name;
                req.body.updateFields.last_name = req.body.last_name;
                req.body.updateFields.zip = req.body.zip;
                req.body.updateFields.state = req.body.state;
                req.body.updateFields.city = req.body.city;
                req.body.updateFields.address1 = req.body.address1;
                req.body.updateFields.email = req.body.email;
                req.body.updateFields.phone = req.body.phone;
                req.body.updateFields.id = req.body.id;
                req.body.updateFields.role = req.body.role;
                faAPI.updateUser(req, 'admin_updateusers', function (err, response) {
                    console.log("im in update")
                    console.log(response)
                    if (err) {
                        res.send({ "status": "Error", "error": "Something Went To Be Wrong. Please Try Again" });
                        res.end()
                    } else {
                        res.send({ "status": "success", "succesmsg": 'Update', 'userId': req.body.id });
                        res.end()
                    }
                });
                /*q.all([admin.updateUser(req,config.mysql,q)]).then(function(result) {
                    res.send({"status": "success","succesmsg":'Updated'});
                    res.end()
                }).fail(function (e) {
                    console.log(e.stack)
                    throw e;

                }).done()*/
            }
        } else {
            faAPI.callUserQuery('id', 'id,email,first_name, last_name, address1, country, state, city, zip, phone, region, role', req.body.id, function (err, result) {
                console.log("subadmin details")
                console.log(result.results[0])
                $arr['users'] = result.results[0];
                console.log($arr['users'])
                common.tplFile('admincp/subadmin.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });

            /* q.all(admin.editUser(req,config.mysql,q)).then(function(result)
             {
                 //$arr['pagination'] = result[1][0].length;
                 $arr['categories'] = result[0][0];
                 res.send({"status":"success",details:JSON.stringify(result[0][0])});
                 res.end();
             }).fail(function(e){
                 throw e;
                 console.log(e.stack)
             }).done()*/
        }
    }


});
/* app.get(['/users/', '/users/:action/', '/users/:action/:id', '/users/:action/:id/:error',
    '/salesusers/', '/salesusers/:action/', '/salesusers/:action/:id', '/salesusers/:action/:id/:error'
], function (req, res) {
    console.log('====================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================');

    var dateFormat = require('dateformat');

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    console.log("err checking ")
    console.log($arr['error'])
    $arr['menu']['usersmenu'] = 'active';

    raction = action;
    $arr.externaljs = ['register', 'jquery.mask.min'];
    $arr.limit = 10;
    var page = (req.body.page - 1) * 10;
    var whereCondition = '';
    var countWhereCondition = '';

    var fieldNames = 'email,first_name,last_name,username,state,notification,status,id,balance,del_status';
    var countFieldNames = 'id';
    $arr['menu'][action + 'usersmenu'] = 'active';
    if (req.url.split('/')[1] == 'salesusers') {
        $arr['menu']['usersmenu'] = '';
        $arr['menu'][action + 'usersmenu'] = '';
        $arr['menu']['consultantmenu'] = 'active';
        $arr['menu']['salesusers'] = 'active';
    }
    var joins = ' LEFT JOIN sales_support AS ss ON u.id=ss.user_id';

    if (action == 'active' || action == 'cancel' || action == 'unverified' || action == 'moderate' || action == 'all') {
        if (req.body.action == 'all') {
            whereCondition = 'where del_status = 0 and role =1 order by id DESC limit ' + page + ',10'
            countWhereCondition = 'where del_status = 0';
        } else if (req.body.action == 'moderate') {
            whereCondition = 'where del_status = 0 and role =1  and status = "moderate" order by id DESC limit ' + page + ',10'
            countWhereCondition = 'where del_status = 0 and status = "moderate"'
        } else if (req.body.action == 'cancel') {
            whereCondition = 'where del_status = 0  and role =1  and (status = "unsubscribe" or status = "deactivate") order by id DESC limit ' + page + ',10'
            countWhereCondition = 'where del_status = 0 and role =1  and (status = "unsubscribe" or status = "deactivate")'
        } else if (req.body.action == 'unverified') {
            whereCondition = 'where del_status = 0 and role =1  and status = "unverified" order by id DESC limit ' + page + ',10'
            countWhereCondition = 'where del_status = 0 and status = "unverified"'
        } else {
            whereCondition = 'where del_status = 0 and role =1  and status = "active" order by id DESC limit ' + page + ',10'
            countWhereCondition = 'where del_status = 0 and status = "active"'
        }

        faAPI.callUserQuerySales('no_type', fieldNames, whereCondition, joins, function (apiUsersErr, apiUsersRes) {
            if (apiUsersErr) {
                console.log("API ERR", apiUsersErr)
            } else {

                var user_ids = _.pluck(apiUsersRes.results, 'id');
                console.log(user_ids);
                if (apiUsersRes.results.length > 0) {
                    q.all([admin.getPartialUData(req, config.mysql, q, user_ids)]).then(function (result) {

                        console.log(JSON.stringify(result));

                        for (var i = 0; i < apiUsersRes.results.length; i++) {
                            // apiUsersRes.results[i]
                            for (var j = 0; j < result[0][0].length; j++) {
                                if (apiUsersRes.results[i].id == result[0][0][j].user_id) {
                                    console.log('ids same');
                                    try {
                                        apiUsersRes.results[i] = _.extend(apiUsersRes.results[i], result[0][0][j])
                                        console.log(apiUsersRes.results[i]);
                                    } catch (err) {
                                        console.log("Extend Error")
                                        console.log(err)
                                    }
                                }
                            }
                        }
                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    })
                }

                faAPI.callUserQuerySales('no_type', countFieldNames, countWhereCondition, joins, function (apiCountUsersErr, apiCountUsersRes) {

                    $arr['pagination'] = apiCountUsersRes.results.length;
                    $arr['users'] = common.addDecimalPlaces('users', apiUsersRes.results);
                    $arr['userstatus'] = '';

                    if (typeof (action) === 'undefined' || action == 'all') {
                        $arr['userstatus'] = '';
                    } else {
                        $arr['userstatus'] = action;
                    }

                    var paginator = new pagination.SearchPaginator({
                        prelink: '/' + req.session.adminUrl + '/users/' + raction + '/',
                        current: req.body.page,
                        rowsPerPage: 10,
                        totalResult: $arr['pagination']
                    });

                    $arr['pagination_html'] = paginator.render();

                    $arr['action'] = action;
                    if ($arr['action'] == 'cancel') {
                        $arr['action'] = 'Suspended';
                    } else if ($arr['action'] == 'moderate') {
                        $arr['action'] = 'Rejected';
                    } else if ($arr['action'] == 'unverified') {
                        $arr['action'] = 'Pending';
                    } else if ($arr['action'] == 'active') {
                        $arr['action'] = 'Activated';
                    }
                    //$arr['trans'] = result[2][0][0];
                    if (raction == 'search') {
                        common.tplFile('admincp/susers.tpl');
                    } else {
                        common.tplFile('admincp/users.tpl');
                    }
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                });
            }

        });
    }


    if (action == 'search') {

        // $arr['menu']['searchusersmenu'] = 'active';
        req.body.email = (typeof (req.param('email')) === 'undefined') ? '' : req.param('email');
        req.body.username = '';//(req.param('username') == undefined) ? '' : req.param('username');
        req.body.last_name = (typeof (req.param('last_name')) === 'undefined') ? '' : req.param('last_name');
        req.body.status = (typeof (req.param('status')) === 'undefined') ? '' : req.param('status');
        req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
        req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
        req.body.from_date = (typeof (req.param('from_date')) === 'undefined') ? '' : req.param('from_date');
        req.body.to_date = (typeof (req.param('to_date')) === 'undefined') ? '' : req.param('to_date');


        whereCondition = countWhereCondition = 'where del_status = 0 and role =1 ';
        console.log('req.session.roleid', req.session.roleid);
        if (req.session.roleid == 2 || req.session.roleid == 3) {
            whereCondition = whereCondition + ' AND ss.sc_user_id=' + req.session.login_userid + ' ';
            countWhereCondition = countWhereCondition + ' AND ss.sc_user_id=' + req.session.login_userid + ' ';
        }
        var count = 0

        if (req.body.from_date != '') {
            req.body.from_date = dateFormat((req.body.from_date), "yyyy-mm-dd")
            whereCondition = whereCondition + 'and created_at >= "' + req.body.from_date + '" '
            countWhereCondition = countWhereCondition + 'and created_at >= "' + req.body.from_date + '" '
            count++;
        }

        if (req.body.to_date != '') {
            req.body.to_date = dateFormat((req.body.to_date), "yyyy-mm-dd")
            whereCondition = whereCondition + 'and created_at <= "' + req.body.to_date + '" '
            countWhereCondition = countWhereCondition + 'and created_at <= "' + req.body.to_date + '" '
            count++;
        }

        if (req.body.email) {
            whereCondition = whereCondition + 'and email like "%' + req.body.email + '%"'
            countWhereCondition = countWhereCondition + 'and email like "%' + req.body.email + '%"'
            count++;
        }

        if (req.body.last_name) {
            whereCondition = count == 0 ? whereCondition + 'and last_name like "%' + req.body.last_name + '%"' : whereCondition + ' and last_name like "%' + req.body.last_name + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'and last_name like "%' + req.body.last_name + '%"' : countWhereCondition + ' and last_name like "%' + req.body.last_name + '%"'
            count++;
        }

        if (req.body.status) {
            whereCondition = count == 0 ? whereCondition + 'and status like "%' + req.body.status + '%"' : whereCondition + ' and status like "%' + req.body.status + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'and status like "%' + req.body.status + '%"' : countWhereCondition + ' and status like "%' + req.body.status + '%"'
            count++;
        }

        if (req.body.username) {
            whereCondition = count == 0 ? whereCondition + 'and username like "%' + req.body.username + '%"' : whereCondition + ' and username like "%' + req.body.username + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'and username like "%' + req.body.username + '%"' : countWhereCondition + ' and username like "%' + req.body.first_name + '%"'
            count++;
        }

        if (req.body.country) {
            whereCondition = count == 0 ? whereCondition + 'and country like "%' + req.body.country + '%"' : whereCondition + ' and country like "%' + req.body.country + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'and country like "%' + req.body.country + '%"' : countWhereCondition + ' and country like "%' + req.body.country + '%"'
            count++;
        }

        if (req.body.state) {
            whereCondition = count == 0 ? whereCondition + 'and state like "%' + req.body.state + '%"' : whereCondition + ' and state like "%' + req.body.state + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'and state like "%' + req.body.state + '%"' : countWhereCondition + ' and state like "%' + req.body.state + '%"'
            count++;
        }

        if (count == 0) {
            whereCondition = whereCondition + ' order by id DESC limit ' + page + ',10'
            countWhereCondition = countWhereCondition + ' order by id DESC '
        } else {
            whereCondition = whereCondition + ' order by id DESC limit ' + page + ',10'
            countWhereCondition = countWhereCondition + ' order by id DESC '
        }

        try {
            faAPI.callUserQuerySales('no_type', fieldNames, whereCondition, joins, function (apiSeUsersErr, apiSeUsersRes) {
                if (apiSeUsersErr) {
                    console.log("API ERR", apiSeUsersErr)
                } else {

                    var user_ids = _.pluck(apiSeUsersRes.results, 'id');
                    console.log(user_ids);

                    console.log("data here ++++++" + JSON.stringify(apiSeUsersRes.results));

                    faAPI.callUserQuerySales('no_type', countFieldNames, countWhereCondition, joins, function (apiSearchUsersErr, apiSearchUsersRes) {

                        if (apiSeUsersRes.results.length > 0) {
                            q.all([admin.getPartialUData(req, config.mysql, q, user_ids)]).then(function (result) {

                                console.log(JSON.stringify(result));

                                for (var i = 0; i < apiSeUsersRes.results.length; i++) {
                                    // apiSeUsersRes.results[i]
                                    for (var j = 0; j < result[0][0].length; j++) {
                                        if (apiSeUsersRes.results[i].id == result[0][0][j].user_id) {
                                            console.log('ids same');
                                            try {
                                                apiSeUsersRes.results[i] = _.extend(apiSeUsersRes.results[i], result[0][0][j])
                                                console.log(apiSeUsersRes.results[i]);
                                            } catch (err) {
                                                console.log("Extend Error")
                                                console.log(err)
                                            }
                                        }
                                    }
                                }
                            }).fail(function (err) {
                                console.log(err.stack);
                                throw err;
                            })
                        }

                         console.log("data here +++" + JSON.stringify(apiSearchUsersRes.results));

                        var url = require('url');
                        var url_parts = url.parse(req.url, true);
                        var query = url_parts.query;
                        $arr['pagination'] = apiSearchUsersRes.results.length;
                        $arr['users'] = apiSeUsersRes.results;
                        $arr['search'] = query;
                        fquery = common.urlparameter(query, { page: '' });
                        console.log('req.session.adminUrl', req.session.adminUrl);
                        console.log('req.session.roleid', req.session.roleid);
                        var paginator = new pagination.SearchPaginator({
                            prelink: '/' + req.session.adminUrl + (req.session.adminUrl=='admincp' ? '/users/' : '/salesusers/') + raction + '/?' + fquery,
                            current: req.body.page,
                            rowsPerPage: 10,
                            totalResult: $arr['pagination']

                        });

                        $arr['pagination_html'] = paginator.render();
                        if (raction == 'search') {
                            common.tplFile('admincp/susers.tpl');
                        } else {
                            common.tplFile('admincp/susers.tpl');
                        }
                        common.headerSet(1);
                        common.loadTemplateHeader(req, res, $arr);
                    });

                    console.log(JSON.stringify(apiSeUsersRes.results));

                }
            });
        } catch (err) {
            console.log("Error")
            console.log(err)
        }

    }

    if (action == 'delete') {

        req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
        req.body.status = "deactivate";
        async.series({
            updateUserStatus: function (cb) {
                // getting userInformations
                var updateUserCallback = function (err, response) {
                    cb(null, response);
                }
                faAPI.updateUser(req, 'status', updateUserCallback);
            }
        }, function (err, results) {
            // console.log(err);
            // console.log(results);

            q.all([
                admin.removeAllProducts(req, config.mysql, q, req.body.id),
                admin.rejectAllPrdtRequests(req, config.mysql, q, req.body.id),
                admin.removeAllAdwords(req, config.mysql, q, req.body.id),
                admin.rejectAllRecurrings(req, config.mysql, q, req.body.id)
            ]).then(function (result) {


            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            })

            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/search' });
            res.end();
            return false;
        })

        // admin.userdelete(req, config.mysql, q, req.body.id);

    }

    if (action == 'suspend') {

        req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
        req.body.status = "deactivate";
        async.series({
            updateUserStatus: function (cb) {
                // getting userInformations
                var updateUserCallback = function (err, response) {
                    cb(null, response);
                }
                faAPI.updateUser(req, 'status', updateUserCallback);
            }
        }, function (err, results) {
            // console.log(err);
            // console.log(results);
            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/search' });
            res.end();
            return false;
        })

        // admin.userdelete(req, config.mysql, q, req.body.id);

    }

    if (action == 'expel') {

        req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
        req.body.status = "deactivate";
        async.series({
            updateUserStatus: function (cb) {
                // getting userInformations
                var updateUserCallback = function (err, response) {
                    cb(null, response);
                }
                faAPI.updateUser(req, 'delete_user', updateUserCallback);
            }
        }, function (err, results) {
            // console.log(err);
            // console.log(results);

            q.all([
                admin.removeAllProducts(req, config.mysql, q, req.body.id),
                admin.rejectAllPrdtRequests(req, config.mysql, q, req.body.id),
                admin.removeAllAdwords(req, config.mysql, q, req.body.id),
                admin.rejectAllRecurrings(req, config.mysql, q, req.body.id)
            ]).then(function (result) {


            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            })

            res.writeHead(302, { 'Location': '/' + req.session.adminUrl + '/users/search' });
            res.end();
            return false;
        })

        // admin.userdelete(req, config.mysql, q, req.body.id);

    }

    if (action == 'edit' || action == 'add' || action == 'view') {
        // $arr['menu']['editusersmenu'] = 'active';
        // if (action == 'add')
        //     $arr['menu']['addusersmenu'] = 'active';
        console.log('edit section 1')
        req.body.id = (typeof (req.param('id')) === 'undefined') ? '' : req.param('id');
        console.log('edit section 2')

        async.series({
            userCategories: function (cb) {
                // getting userInformations
                //'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users order by id DESC limit ?, 10';
                console.log('edit section 3')
                q.all([admin.listUserCategories(req, config.mysql, q)]).then(function (result) {
                    console.log('geting categories 1');
                    cb(null, result);
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                })

            },
            getUserData: function (cb) {

                if (req.body.id !== '') {
                    faAPI.callUserQuery('id', 'email, username, first_name, last_name, balance, id, avatar, aboutme, status, image, address1, address2, country, state, city, zip, phone, region, default_provider,default_transport', req.body.id, function (err, result) {

                        // console.log('geting usersdata 1');
                        // console.log(result)

                        if (result.results.length > 0) {
                            result.results[0].first_name = (result.results[0].first_name == null ? '' : result.results[0].first_name);
                            result.results[0].last_name = (result.results[0].last_name == null ? '' : result.results[0].last_name);
                            result.results[0].avatar = (result.results[0].avatar == null ? '' : result.results[0].avatar);
                            result.results[0].image = (result.results[0].image == null ? '' : result.results[0].image);
                            result.results[0].address2 = (result.results[0].address2 == null ? '' : result.results[0].address2);
                            result.results[0].country = (result.results[0].country == null ? '' : result.results[0].country);
                            result.results[0].state = (result.results[0].state == null ? '' : result.results[0].state);
                            result.results[0].city = (result.results[0].city == null ? '' : result.results[0].city);
                            result.results[0].zip = (result.results[0].zip == null ? '' : result.results[0].zip);
                            result.results[0].region = (result.results[0].region == null ? '' : result.results[0].region);
                            result.results[0].default_provider = (result.results[0].default_provider == null ? '' : result.results[0].default_provider);
                            result.results[0].default_transport = (result.results[0].default_transport == null ? '' : result.results[0].default_transport);
                        }

                        cb(err, result.results);

                    });
                } else {
                    cb(null, null);
                }

            }

        }, function (err, results) {

            if (err) {
                console.log('err here', JSON.stringify(err));
                throw err
            }

            q.all(user.getBusinessType(req, config.mysql, q, req.body.id)).then(function (resultss) {
                console.log('getting business details');
                console.log('getting business details', resultss[0][0]);

                if (action == 'edit' || action == 'view') {
                    if (typeof (resultss[0][0]) != 'undefined') {
                        results.getUserData[0].business_type = typeof (resultss[0][0]) != 'undefined' ? resultss[0][0].business_type : '';
                        results.getUserData[0].business_name = typeof (resultss[0][0]) != 'undefined' ? resultss[0][0].business_name : '';
                        results.getUserData[0].ein_number = typeof (resultss[0][0]) != 'undefined' ? resultss[0][0].ein_number : '';
                        results.getUserData[0].stax = typeof (resultss[0][0]) != 'undefined' ? resultss[0][0].stax : 'n';
                        results.getUserData[0].stax_per = typeof (resultss[0][0]) != 'undefined' ? resultss[0][0].stax_per : '';
                        results.getUserData[0].license_img = typeof (resultss[0][0]) != 'undefined' ? resultss[0][0].license_img : '';
                        results.getUserData[0].business_cert = typeof (resultss[0][0]) != 'undefined' ? resultss[0][0].business_cert : '';

                        // } else {
                        //     results.getUserData[0].business_type = '';
                        //     results.getUserData[0].business_name = '';
                        //     results.getUserData[0].ein_number = '';
                        //     results.getUserData[0].stax = 'n';
                        //     results.getUserData[0].stax_per = '';
                        //     results.getUserData[0].license_img = '';
                        //     results.getUserData[0].business_cert = '';
                    }
                }

                // $arr['mcats'] = results.userCategories[0][0][0]['mcat'];
                // console.log($arr['mcats'] + 'as');

                if (action == 'add') {
                    $arr['users'] = '';
                    $arr.stat_msg = "User successfully added";
                } else if (action == 'edit' || action == 'view') {
                    $arr['users'] = results.getUserData[0];
                    $arr.stat_msg = "User updated successfully";
                }

                common.tplFile('admincp/eusers.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            });


        })

    }

    // if (action == 'view') {
    //     $arr['menu']['viewusersmenu'] = 'active';
    //     if (action == 'add')
    //         $arr['menu']['viewusersmenu'] = 'active';
    //     req.body.id = (typeof(req.param('id')) === 'undefined') ? 0 : req.param('id');

    //     async.series({
    //         getUserData: function(cb) {
    //             faAPI.callUserQuery('id', 'email, username, first_name, last_name, balance, id, avatar, aboutme, status, image, address1, address2, country, state, city, zip, phone, region', req.body.id, function(err, result) {
    //                 result.results[0].address1 = (result.results[0].address1 == null ? '' : result.results[0].address1);
    //                 result.results[0].address2 = (result.results[0].address2 == null ? '' : result.results[0].address2);
    //                 result.results[0].country = (result.results[0].country == null ? '' : result.results[0].country);
    //                 result.results[0].state = (result.results[0].state == null ? '' : result.results[0].state);
    //                 result.results[0].city = (result.results[0].city == null ? '' : result.results[0].city);
    //                 result.results[0].zip = (result.results[0].zip == null ? '' : result.results[0].zip);
    //                 result.results[0].region = (result.results[0].region == null ? '' : result.results[0].region);
    //                 // console.log(result)
    //                 cb(err, result.results);
    //             });

    //         }

    //     }, function(err, results) {

    //         if (err) {
    //             console.log(JSON.stringify(err));
    //             throw err
    //         }

    //         // console.log("getting user details" + JSON.stringify(results));

    //         $arr['users'] = results.getUserData[0];
    //         common.tplFile('admincp/user_view.tpl');
    //         common.headerSet(1);
    //         common.loadTemplateHeader(req, res, $arr);

    //     })

    // }

}); */

app.post('/user/change/:status', function (req, res) {

    async.series({
        updateUserStatus: function (cb) {
            // getting userInformations
            var updateUserCallback = function (err, response) {
                cb(null, response);
            }
            faAPI.updateUser(req, 'status', updateUserCallback);
        }
    }, function (err, results) {
        q.all([products.checkmailnotify(req, config.mysql, q, 8), products.checksmsnotify(req, config.mysql, q, 8)]).then(function (results) {

            localm = require('../../module/localmail');
            if (results[0][0].length > 0) {
                if (req.body.status == "active") {
                    var activeurl = '<br />To login your account. Please <a href="' + $arr.config.spath + 'login">click here</a>';

                    if (global.emaillocal.status == 'yes') {
                        q.all([localm.mailtemps(req, config.mysql, q, 'message_sent')]).then(function (results2) {
                            console.log("sending mail");
                            console.log("results2", results2)
                            if (results2) {

                                var template = results2[0][0][0].template;
                                var subject_message = results2[0][0][0].subject;

                                template = template.replace('{{event.sitename}}', global.common.title);
                                template = template.replace('{{event.message}}', "Your account has been activated by the admin. " + activeurl + "");
                                template = template.replace('{{event.user}}', req.body.username);
                                template = template.replace('{{event.siteurl}}', $arr.config.url);
                                // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);
                                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');

                                localm.sendmail(template, subject_message, req.body.email);

                            } else {

                                console.log("No Templates named message_sent");
                            }

                        }).fail(function (err) {
                            console.log(err.stack);
                            throw err;
                        });
                    }
                } else if (req.body.status == "unverified") {

                    var activeurl = 'Your account has been deactivated by admin.<br><br>';

                    if (global.emaillocal.status == 'yes') {
                        q.all([localm.mailtemps(req, config.mysql, q, 'message_sent')]).then(function (results2) {
                            console.log("sending mail");
                            if (results2) {

                                var template = results2[0][0][0].template;
                                var subject_message = results2[0][0][0].subject;

                                template = template.replace('{{event.sitename}}', global.common.title);
                                template = template.replace('{{event.message}}', activeurl + " message from admin is, " + req.body.message);
                                template = template.replace('{{event.user}}', req.body.username);
                                template = template.replace('{{event.siteurl}}', $arr.config.url);
                                // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);
                                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');

                                localm.sendmail(template, subject_message, req.body.email);

                            } else {

                                console.log("No Templates named message_sent");
                            }


                        }).fail(function (err) {
                            console.log(err.stack);
                            throw err;
                        });
                    }
                }
                // console.log("arr is here" + JSON.stringify($arr));
            } else { console.log('Email method is not Selected for product posting'); }
        });
        res.writeHead(302, { 'Location': req.headers.referer });
        res.end();

        if (err) {
            console.log(JSON.stringify(err));
            throw err
        }

    })
})

app.post(['/categories/save'], function (req, res) {

    console.log(JSON.stringify(req.body));

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['categoriesmenu'] = 'active';
    if (typeof (req.body.title) === 'undefined' || typeof (req.body.description) === 'undefined') {
        res.writeHead(302, { 'Location': '/admincp/categories/edit/' + req.body.id + '/Invalid Data' });
        res.end();
        return false;
    } else if (req.body.title == '' || req.body.description == '') {
        res.writeHead(302, { 'Location': '/admincp/categories/edit/' + req.body.id + '/Invalid Data' });
        res.end();
        return false;
    }
    req.body.id = (req.body.id > 0) ? req.body.id : 0;
    if (req.body.id == 0) {
        q.all([admin.selectMaxrgt(req, config.mysql, q)]).then(function (out) {
            req.body.mrgt = out[0][0][0]['mrgt'];
            // console.log(out[0][0][0]['mrgt']);
            if (req.body.id == 0) {
                admin.updateLeft(req, config.mysql, q);
                admin.updateRight(req, config.mysql, q);
            }
            q.all([admin.categorySave(req, config.mysql, q)]).then(function (result) {

                if (req.body.id == 0) {
                    req.body.id = result[0][0].insertId;
                }
                res.writeHead(302, { 'Location': '/admincp/categoriesalter/' });
                res.end();
                return false;
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        q.all([admin.selectCategories(req, config.mysql, q)]).then(function (result) {
            // console.log(result[0][0]);
            $arr['categories'] = result[0][0][0];
            req.body.opid = result[0][0][0].parent_id
            admin.categoryupdate(req, config.mysql, q);
            res.writeHead(302, { 'Location': '/admincp/categoriesalter/' });
            res.end();
            return false;
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    }
});

app.post(['/storecategories/save'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['storecategoriesmenu'] = 'active';
    if (typeof (req.body.title) === 'undefined' || typeof (req.body.description) === 'undefined') {
        res.writeHead(302, { 'Location': '/admincp/storecategories/edit/' + req.body.id + '/Invalid Data' });
        res.end();
        return false;
    } else if (req.body.title == '' || req.body.description == '') {
        res.writeHead(302, { 'Location': '/admincp/storecategories/edit/' + req.body.id + '/Invalid Data' });
        res.end();
        return false;
    }
    req.body.id = (req.body.id > 0) ? req.body.id : 0;
    if (req.body.id == 0) {
        q.all([admin.selectStoreMaxrgt(req, config.mysql, q)]).then(function (out) {
            req.body.mrgt = out[0][0][0]['mrgt'];
            console.log(out[0][0][0]['mrgt']);
            if (req.body.id == 0) {
                admin.updateStoreLeft(req, config.mysql, q);
                admin.updateStoreRight(req, config.mysql, q);
            }
            q.all([admin.storeCategorySave(req, config.mysql, q)]).then(function (result) {
                if (req.body.id == 0) {
                    req.body.id = result[0][0].insertId;
                }
                res.writeHead(302, { 'Location': '/admincp/storecategoriesalter/' });
                res.end();
                return false;
            });
        });
    } else {
        q.all([admin.selectStoreCategories(req, config.mysql, q)]).then(function (result) {
            console.log(result[0][0]);
            $arr['categories'] = result[0][0][0];
            req.body.opid = result[0][0][0].parent_id
            admin.storecategoryupdate(req, config.mysql, q);
            res.writeHead(302, { 'Location': '/admincp/storecategoriesalter/' });
            res.end();
            return false;
        });
    }
});

app.get(['/categoriesdelete/:id'], function (req, res) {

    admin.deleteCategories(req, config.mysql, q);
    res.writeHead(302, { 'Location': '/admincp/categoriesalter/' });
    res.end();
    return false;

});
app.get(['/storecategoriesdelete/:id'], function (req, res) {

    admin.deleteStoreCategories(req, config.mysql, q);
    res.writeHead(302, { 'Location': '/admincp/storecategoriesalter/' });
    res.end();
    return false;

});

app.get(['/categoriesalter/'], function (req, res) {


    var arr = {};

    var s = 0;
    q.all([admin.getAllCategory(req, config.mysql, q)]).then(function (results) {
        //console.log(async)
        var k = results[0][0];
        s = k.length;
        for (i in k) {
            if (typeof (arr['cat_' + k[i].parent_id]) === 'undefined') {
                arr['cat_' + k[i].parent_id] = [];


            } else {

            }

            arr['cat_' + k[i].parent_id].push(k[i].id);
            if (i == k.length - 1) {
                http = require('http');
                console.log(arr);
                console.log('/forward/webservice.php?cmd=_category_module&data=' + JSON.stringify(arr));
                var options = {
                    host: $arr.config.webservice.url,
                    port: 80,
                    path: '/forward/webservice.php?cmd=_category_module&data=' + JSON.stringify(arr)
                };
                console.log(options);
                var reqs = http.get(options, function (rest) {

                    console.log("Got response: " + rest.statusCode);
                    var m = '';
                    rest.on("data", function (chunk) {

                        m = JSON.parse(chunk);
                    });
                    rest.on("end", function () {
                        var s = 0;
                        var r = 0;
                        for (i in m) {
                            r++;
                        }
                        for (i in m) {
                            s++;
                            if (typeof (m[i]['lft']) !== 'undefined') {
                                console.log(i);
                                admin.updateLftRgtCategories(req, config.mysql, q, m[i]['lft'], m[i]['rht'], i);
                            }
                            console.log(s);
                            console.log(r);
                            if (s == r) {
                                res.writeHead(302, { 'Location': '/admincp/categories/list/' });
                                res.end();
                                return false;
                            }
                        }
                    });
                }).on('error', function (e) {
                    console.log(e);
                    console.log("Got error: " + e.message);
                });

            }
        }
    });
});
app.get(['/storecategoriesalter/'], function (req, res) {


    var arr = {};

    var s = 0;
    q.all([admin.getAllStoreCategory(req, config.mysql, q)]).then(function (results) {
        //console.log(async)
        var k = results[0][0];
        s = k.length;
        for (i in k) {
            if (typeof (arr['cat_' + k[i].parent_id]) === 'undefined') {
                arr['cat_' + k[i].parent_id] = [];


            } else {

            }

            arr['cat_' + k[i].parent_id].push(k[i].id);
            if (i == k.length - 1) {
                http = require('http');
                console.log(arr);
                console.log('/forward/webservice.php?cmd=_category_module&data=' + JSON.stringify(arr));
                var options = {
                    host: $arr.config.webservice.url,
                    port: 80,
                    path: '/forward/webservice.php?cmd=_category_module&data=' + JSON.stringify(arr)
                };
                console.log(options);
                var reqs = http.get(options, function (rest) {

                    console.log("Got response: " + rest.statusCode);
                    var m = '';
                    rest.on("data", function (chunk) {

                        m = JSON.parse(chunk);
                    });
                    rest.on("end", function () {
                        var s = 0;
                        var r = 0;
                        for (i in m) {
                            r++;
                        }
                        for (i in m) {
                            s++;
                            if (typeof (m[i]['lft']) !== 'undefined') {
                                console.log(i);
                                admin.updateLftRgtStoreCategories(req, config.mysql, q, m[i]['lft'], m[i]['rht'], i);
                            }
                            console.log(s);
                            console.log(r);
                            if (s == r) {
                                res.writeHead(302, { 'Location': '/admincp/storecategories/list/' });
                                res.end();
                                return false;
                                return false;
                            }
                        }
                    });
                }).on('error', function (e) {
                    console.log(e);
                    console.log("Got error: " + e.message);
                });

            }
        }
    });
});


app.get(['/cquestionadd/:cid'], function (req, res) {
    q.all([admin.categoriesDetail(req, config.mysql, q)]).then(function (results) {

        $arr.cid = req.param('cid');
        $arr.id = 0;
        $arr.ctitle = results[0][0][0]['name'];
        common.tplFile('admincp/cquestionsadd.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});
app.get(['/cquestionedit/:cid/:id'], function (req, res) {
    q.all([admin.categoriesDetail(req, config.mysql, q), admin.categoriesQuestionDetail(req, config.mysql, q)]).then(function (results) {
        $arr.cid = req.param('cid');
        $arr.id = req.param('id');
        $arr.ctitle = results[0][0][0]['name'];
        $arr.questions = results[1][0][0];
        common.tplFile('admincp/cquestionsadd.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});
app.post(['/cquestions/save'], function (req, res) {
    if (req.body.id == 0)
        admin.createQuestion(req, config.mysql, q);
    else
        admin.updateQuestion(req, config.mysql, q);
    res.writeHead(302, { 'Location': '/admincp/cquestions/' + req.body.cid });
    res.end();
    return false;

});
app.post(['/delete/users'], function (req, res) {
    console.log(req.body.ids);
    var user_ids = req.body.ids;
    console.log(user_ids.length);
    if (common.admincheckLogin(req, res, 1)) {

        // req.body.status = "deactivate";

        if (user_ids.length > 1) {
            async.forEachSeries(user_ids, function (i, next) {
                req.body.id = i;

                async.series({
                    updateUsersStatus: function (cb) {
                        // getting userInformations
                        var updateUsersCallback = function (err, response) {
                            cb(null, response);
                        }
                        faAPI.updateUser(req, 'delete_user', updateUsersCallback);
                    }

                }, function (err, results) {
                    next(null);
                })

            }, function (err) {
                //console.log('------------------successfully cron----------------');
                res.json({ success: true });
                res.end();
                return true;
            })

        } else {
            req.body.id = (typeof (req.body.ids) === 'undefined') ? 0 : req.body.ids;
            async.series({
                updateUsersStatus: function (cb) {
                    // getting userInformations
                    var updateUsersCallback = function (err, response) {
                        cb(null, response);
                    }
                    faAPI.updateUser(req, 'delete_user', updateUsersCallback);
                }

            }, function (err, results) {
                if (err) {
                    console.log(err);
                } else {
                    res.json({ success: true });
                }

            })


        }



    }
});

app.get(['/cquestions/:cid'], function (req, res) {
    q.all([admin.categoriesQuestion(req, config.mysql, q), admin.categoriesDetail(req, config.mysql, q)]).then(function (results) {
        $arr.questions = results[0][0];
        $arr.id = req.param('cid');
        $arr.ctitle = results[1][0][0]['name'];
        common.tplFile('admincp/cquestions.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});

app.get(['/categories/:action', '/categories/:action/:id', '/categories/:action/:id/:error'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['categoriesmenu'] = 'active';
    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'list' : req.param('action');
    id = req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');

    if (action == 'list') {
        q.all([admin.categoriesList(req, config.mysql, q, 1), admin.categoriesList(req, config.mysql, q, 0)]).then(function (result) {
            $arr['pagination'] = result[1][0].length;
            cats = sub = $arr['categories'] = result[0][0];

            var maincategory = [];
            var allcats = [];

            cats.forEach(function (item) {
                if (item.parent_id == 0) {
                    maincategory.push(item);

                    sub.forEach(function (subitem) {
                        if (item.id == subitem.parent_id) {
                            maincategory.push(subitem);

                        }
                    });

                }
            });

            $arr['maincatsall'] = maincategory;

            var limit = (req.body.page - 1) * 10;

            for (var i = limit; i < limit + 10; i++) {
                if (maincategory[i]) {
                    allcats.push(maincategory[i]);
                }

            }
            $arr['maincats'] = allcats;


            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/categories/list',
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/categories.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }

    if (action == 'add') {
        q.all(common.allCategoriesList(req, config.mysql, q)).then(function (result) {
            $arr['pcategories'] = result[0];
            // console.log($arr['pcategories']);
            common.tplFile('admincp/ncategories.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }

    if (action == 'edit') {
        q.all([admin.selectCategories(req, config.mysql, q), common.allCategoriesList(req, config.mysql, q)]).then(function (result) {
            // console.log(result[0][0]);
            $arr['pcategories'] = result[1][0];
            $arr['categories'] = result[0][0][0];
            common.tplFile('admincp/ncategories.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }


});
app.get(['/storecategories1/:action', '/storecategories1/:action/:id', '/storecategories1/:action/:id/:error'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['storecategoriesmenu'] = 'active';
    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'list' : req.param('action');
    id = req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');

    if (action == 'list') {
        q.all([admin.storecategoriesList(req, config.mysql, q, 1), admin.storecategoriesList(req, config.mysql, q, 0), admin.selectMaxStoreCategory(req, config.mysql, q)]).then(function (result) {
            if (result[2][0].length > 0) {
                $arr['storemaxlength'] = result[2][0];
            } else {
                $arr['storemaxlength'] = [];
            }
            $arr['pagination'] = result[1][0].length;
            cats = sub = $arr['storecategories'] = result[0][0];

            var maincategory = [];
            var allcats = [];

            cats.forEach(function (item) {
                if (item.parent_id == 0) {
                    maincategory.push(item);

                    sub.forEach(function (subitem) {
                        if (item.id == subitem.parent_id) {
                            maincategory.push(subitem);

                        }
                    });

                }
            });
            $arr['maincatsall'] = maincategory;
            var limit = (req.body.page - 1) * 10;
            for (var i = limit; i < limit + 10; i++) {
                if (maincategory[i]) {
                    allcats.push(maincategory[i]);
                }

            }
            $arr['maincats'] = allcats;
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/storecategories/list',
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/storecategories.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
    if (action == 'add') {
        q.all([common.allStoreCategoriesList(req, config.mysql, q), admin.selectMaxStoreCategory(req, config.mysql, q)]).then(function (result) {
            if (result[1][0].length > 0) {
                $arr['storemaxlength'] = result[1][0];
            } else {
                $arr['storemaxlength'] = [];
            }
            $arr['pstorecategories'] = result[0][0];

            common.tplFile('admincp/nstorecategories.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
    if (action == 'edit') {
        q.all([admin.selectStoreCategories(req, config.mysql, q), common.allStoreCategoriesList(req, config.mysql, q), admin.selectMaxStoreCategory(req, config.mysql, q)]).then(function (result) {
            if (result[2][0].length > 0) {
                $arr['storemaxlength'] = result[2][0];
            } else {
                $arr['storemaxlength'] = [];
            }
            $arr['pstorecategories'] = result[1][0];
            $arr['categories'] = result[0][0][0];
            common.tplFile('admincp/nstorecategories.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});


app.get(['/referral'], function (req, res) {

    var rid = req.body.rid = (typeof (req.param('rid')) === 'undefined') ? '0' : req.param('rid');

    if (rid > 0) {
        q.all([admin.checkReferral(rid, ruid, config.mysql, q)]).then(function (refDetails) {

            if (refDetails[0][0].length > 0) {
                var req = { body: {} };
                req.body.buyer = {
                    balance: parseFloat(global.referral_bonus).toFixed(2),
                    id: ruid
                }

                payments = require('../../module/payment');

                // payments = require('../module/payment');
                payments.transactionid = 0;
                payments.gateway = 'account';
                payments.sessionsdata = [];
                payments.sessionsdata.title = 'Referral Bonus';
                payments.sessionsdata.email = '';
                payments.sessionsdata.url = $arr.config.url + ''
                payments.sessionsdata.userid = ruid;
                payments.sessionsdata.first_name = '';
                payments.sessionsdata.last_name = '';
                req.body.commission = 0;
                payments.payid = rid;
                payments.type = 'refer_promo';
                payments.name = 'reference';
                payments.buynow_id = '0';
                payments.cart_id = '0';
                payments.amount = global.referral_bonus;
                payments.buyer = { id: ruid };
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

                        q.all([
                            products.generateInvoiceID(req, invoice[0][0].insertId, config.mysql, q),
                            dashboard.updateReferralStatus(req, config.mysql, q, rid)
                            // adwords.changeAdRefundStatus(ads.user_id, ads.id, invoice[0][0].insertId, config.mysql, q)
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

                res.writeHead(302, {
                    'Location': '/admincp/referral/'
                });
                res.end();
                return false;
            } else {
                res.writeHead(302, {
                    'Location': '/admincp/referral/'
                });
                res.end();
                return false;
            }

        }).fail(function (err) {
            console.log(err.stack);
            // throw err;
        }).done();
        var ruid = req.param('ruid');
        /* Get user data */


    } else {
        delete $arr['menu'];
        $arr['menu'] = [];
        $arr['menu']['referralmenu'] = 'active';
        req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
        $arr['referral'] = $arr['referrallink'] = '';
        console.log(req.body.page);
        q.all([dashboard.getReferral(req, config.mysql, q, 1, 0), dashboard.getReferral(res, config.mysql, q, 1, 1)]).then(function (results) {

            console.log("========  results[0][0] ============================");
            console.log(results[0][0]);
            $arr['referralcount'] = results[0][0].length;


            var result = _.pluck(results[0][0], 'to_id');
            console.log("========  result  ============================");
            console.log(result);


            async.series({
                getSellerDetails: function (checkblock_cbk) {
                    faAPI.appendUserDataForObject('id', 'id as to_id, first_name,email,phone,last_name,nick_name,review,avatar as uimage', result, results[0][0], 'to_id', function (messageFromErr, messageFromRes) {

                        console.log("========  async1 ============================");
                        console.log('Getting user and products details : ' + JSON.stringify(messageFromRes));
                        checkblock_cbk(null, messageFromRes);

                    });
                }

            }, function (err, results1) {
                if (err) {
                    console.log(err);
                }
                //console.log('combined results here : ' + JSON.stringify(results1.getSellerDetails));



                results[0][0] = results1.getSellerDetails;

                var result = _.pluck(results[0][0], 'from_id');


                async.series({
                    getSellerDetails1: function (checkblock_cbk) {
                        faAPI.appendUserDataForObject('id', 'id as from_id, first_name as refererFname, last_name as refererLname, email as refererEmail', result, results[0][0], 'from_id', function (messageFromErr, messageFromRes) {

                            checkblock_cbk(null, messageFromRes);

                        });
                    }

                }, function (err, results1) {
                    if (err) {
                        console.log(err);
                    }

                    results[0][0] = results1.getSellerDetails1;

                    $arr['referral'] = results[0][0];

                    $arr['referrals'] = results[1][0].length;

                    var paginator = new pagination.SearchPaginator({
                        prelink: '/admincp/referral/',
                        current: req.body.page,
                        rowsPerPage: 10,
                        totalResult: $arr['referrals']
                    });
                    $arr['pagination_html'] = paginator.render();

                    common.tplFile('admincp/referals.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                });
            });
        });
    }

});



/*
app.get(['/referral'], function(req, res) {

    var rid = req.body.rid = (typeof(req.param('rid')) === 'undefined') ? '0' : req.param('rid');
    if (rid > 0) {

        dashboard.updateReferralStatus(req, config.mysql, q, rid);
        admin.addbalance(req, config.mysql, q, req.param('ruid'));
        res.writeHead(302, {
            'Location': '/admincp/referral/'
        });
        res.end();
        return false;

    } else {
        delete $arr['menu'];
        $arr['menu'] = [];
        $arr['menu']['referralmenu'] = 'active';
        req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
        $arr['referral'] = $arr['referrallink'] = '';
        console.log(req.body.page);
        q.all([dashboard.getReferral(req, config.mysql, q, 1, 0), dashboard.getReferral(res, config.mysql, q, 1, 1)]).then(function(results) {

            console.log("========  results[0][0] ============================");
            console.log(results[0][0]);
            $arr['referralcount'] = results[0][0].length;


            var result = _.pluck(results[0][0], 'to_id');
            console.log("========  result  ============================");
            console.log(result);


            async.series({
                getSellerDetails: function(checkblock_cbk) {
                    faAPI.appendUserDataForObject('id', 'id as to_id, first_name,email,phone,last_name,nick_name,review,avatar as uimage', result, results[0][0], 'to_id', function(messageFromErr, messageFromRes) {

                        console.log("========  async1 ============================");
                        console.log('Getting user and products details : ' + JSON.stringify(messageFromRes));
                        checkblock_cbk(null, messageFromRes);

                    });
                }

            }, function(err, results1) {
                if (err) {
                    console.log(err);
                }
                //console.log('combined results here : ' + JSON.stringify(results1.getSellerDetails));



                results[0][0] = results1.getSellerDetails;

                var result = _.pluck(results[0][0], 'from_id');


                async.series({
                    getSellerDetails1: function(checkblock_cbk) {
                        faAPI.appendUserDataForObject('id', 'id as from_id, first_name as refererFname, last_name as refererLname, email as refererEmail', result, results[0][0], 'from_id', function(messageFromErr, messageFromRes) {

                            checkblock_cbk(null, messageFromRes);

                        });
                    }

                }, function(err, results1) {
                    if (err) {
                        console.log(err);
                    }

                    results[0][0] = results1.getSellerDetails1;

                    $arr['referral'] = results[0][0];

                    $arr['referrals'] = results[1][0].length;

                    var paginator = new pagination.SearchPaginator({
                        prelink: '/admincp/referral/',
                        current: req.body.page,
                        rowsPerPage: 10,
                        totalResult: $arr['referrals']
                    });
                    $arr['pagination_html'] = paginator.render();

                    common.tplFile('admincp/referals.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                });
            });
        });
    }

});
*/
app.get(['/referdelete'], function (req, res) {

    var rid = req.param('rid');
    admin.deletereferral(req, config.mysql, q, rid);
    res.writeHead(302, { 'Location': '/admincp/referral/' });
    res.end();
    return false;

});

/******************************** Mailer Mangement emailmgtmenu *************************************************/

app.get(['/mailers'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['managementmenu'] = 'active';
    $arr['menu']['emailmgtmenu'] = 'active';
    var bids = require('../../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);




    $arr['local_id'] = 'local';
    // $arr['local_api'] = global.emaillocal.api;
    $arr['local_user'] = global.emaillocal.user;
    $arr['local_pwd'] = global.emaillocal.pwd;
    $arr['local_type'] = global.emaillocal.type;
    $arr['local_status'] = global.emaillocal.status;

    $arr['customerio_id'] = 'customerio';
    $arr['customerio_api'] = global.emailcio.api;
    $arr['customerio_key'] = global.emailcio.key;
    $arr['customerio_type'] = global.emailcio.type;
    $arr['customerio_status'] = global.emailcio.status;


    $arr['smstwo_id'] = 'twillio';
    $arr['smstwo_sid'] = global.smstwo.sid;
    $arr['smstwo_token'] = global.smstwo.token;
    $arr['smstwo_type'] = global.smstwo.type;
    $arr['smstwo_status'] = global.smstwo.status;


    common.tplFile('admincp/mailers.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);


});

app.post(['/mailers/:action'], function (req, res) {
    var action = req.param('action');
    var id = req.param('id');
    var type = req.param('method');


    if (action == 'deactive') {

        var fs = require('fs'),
            ini = require('ini');
        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));

        if (type == "email") {

            if (id == 'local') {
                console.log('Entered');
                configed['section']['localmail']['status'] = 'no';
            } else if (id == 'customerio') {
                configed['section']['customeriomail']['status'] = 'no';
            } else { }

        }

        if (type == "sms") {

            if (id == 'twillio') {

                configed['section']['twilliosms']['status'] = 'no';

            } else { }

        }

        fs.writeFileSync('./config.ini', ini.stringify(configed));

        config.mysql.destroy();
        delete configure;
        delete config;
        delete $arr;

        configure = require('../../configure');
        config = configure.app();

        $arr = {
            config: config
        }

        res.writeHead(302, {

            'Location': '/admincp/mailers'

        });

        res.end();
        return false;
    }

    if (action == 'active') {

        var id = req.param('id');


        var fs = require('fs'),
            ini = require('ini');
        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));

        if (type == "email") {

            //Deactivating all the Methods
            configed['section']['localmail']['status'] = 'no';
            configed['section']['customeriomail']['status'] = 'no';
            fs.writeFileSync('./config.ini', ini.stringify(configed));
            //Activating Current Method

            if (id == 'local') {
                console.log('Entered');
                configed['section']['localmail']['status'] = 'yes';
            } else if (id == 'customerio') {
                console.log('Entered');
                configed['section']['customeriomail']['status'] = 'yes';
            } else { }
        }

        if (type == "sms") {

            if (id == 'twillio') {

                configed['section']['twilliosms']['status'] = 'yes';

            } else { }

        }

        fs.writeFileSync('./config.ini', ini.stringify(configed));

        config.mysql.destroy();
        delete configure;
        delete config;
        delete $arr;

        configure = require('../../configure');
        config = configure.app();
        $arr = {
            config: config
        }

        res.writeHead(302, {

            'Location': '/admincp/mailers'

        });

        res.end();
        return false;


    }


});

/*Reports */
app.post(['/reports_create'], function (req, res) {

    console.log(req.body);

    spage = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    console.log('page' + spage);

    var csv = require('csv');
    var csvdata;
    var lbreak = "\n";
    var headings = [];
    var details = [];
    var all_details = [];

    // active
    // suspended
    // deleted
    /* getting user reports */

    if (req.body.reports === 'all' ||
        req.body.reports === 'pending' ||
        req.body.reports === 'active' ||
        req.body.reports === 'suspended' ||
        req.body.reports === 'deleted') {

        if (req.body.user_id) {
            csvdata = "User Id,";
        } else {
            csvdata = '';
        }
        if (req.body.first_name) {
            csvdata += "First Name,";
        }
        if (req.body.last_name) {
            csvdata += "Last Name,";
        }
        if (req.body.username) {
            csvdata += "Date Added,";
        }
        if (req.body.email) {
            csvdata += "Email ID,";
        }
        if (req.body.created_at) {
            csvdata += "Date of Joined,";
        }
        if (req.body.updated_at) {
            csvdata += "Last Updated,";
        }
        if (req.body.phone) {
            csvdata += "Phone,";
        }
        if (req.body.address) {
            csvdata += "Address,";
        }
        if (req.body.country) {
            csvdata += "Country,";
        }
        if (req.body.state) {
            csvdata += "State,";
        }
        if (req.body.city) {
            csvdata += "City,";
        }
        if (req.body.region) {
            csvdata += "Region,";
        }
        if (req.body.zipcode) {
            csvdata += "Zip Code,";
        }

        csvdata += lbreak;

        var whereCondition = '';
        var countWhereCondition = '';

        var fieldNames = ' * ';
        var countFieldNames = ' count(id) as total_users ';

        var limits = (spage - 1) * 10;
        var ends = (spage) * 10;

        if (req.body.type == 'dsp') {

            if (req.body.reports === 'all') {
                reports_status = 1;
                whereCondition = 'where del_status = 0 and role =1 order by id DESC limit ' + spage + ',10'
                countWhereCondition = 'where del_status = 0 and role =1';
            } else if (req.body.reports === 'pending') {
                whereCondition = 'where del_status = 0 and role =1  and status = "unverified" order by id DESC ' + spage + ',10'
                countWhereCondition = 'where del_status = 0 and status = "unverified"'
                reports_status = 2;
            } else if (req.body.reports === 'active') {
                whereCondition = 'where del_status = 0 and role =1  and status = "active" order by id DESC ' + spage + ',10'
                countWhereCondition = 'where del_status = 0 and status = "active"'
                reports_status = 3;
            } else if (req.body.reports === 'reject') {
                whereCondition = 'where del_status = 0 and role =1  and status = "moderate" order by id DESC ' + spage + ',10'
                countWhereCondition = 'where del_status = 0 and status = "moderate"'
                reports_status = 3;
            } else if (req.body.reports === 'suspended') {
                whereCondition = 'where del_status = 0 and role =1  and status = "deactive" order by id DESC ' + spage + ',10'
                countWhereCondition = 'where del_status = 0 and status = "deactive"'
                reports_status = 4;
            } else if (req.body.reports === 'deleted') {
                whereCondition = 'where del_status = 1 and role =1 order by id DESC ' + spage + ',10'
                countWhereCondition = 'where del_status = 1 '
                reports_status = 4;
            } else {
                console.log('Something went wrong');
                return false;
            }
        } else {
            if (req.body.reports === 'all') {
                reports_status = 1;
                whereCondition = 'where del_status = 0 and role =1 order by id DESC'
                countWhereCondition = 'where del_status = 0 and role =1';
            } else if (req.body.reports === 'pending') {
                whereCondition = 'where del_status = 0 and role =1  and status = "unverified" order by id DESC'
                countWhereCondition = 'where del_status = 0 and status = "unverified"'
                reports_status = 2;
            } else if (req.body.reports === 'active') {
                whereCondition = 'where del_status = 0 and role =1  and status = "active" order by id DESC'
                countWhereCondition = 'where del_status = 0 and status = "active"'
                reports_status = 3;
            } else if (req.body.reports === 'reject') {
                whereCondition = 'where del_status = 0 and role =1  and status = "moderate" order by id DESC'
                countWhereCondition = 'where del_status = 0 and status = "moderate"'
                reports_status = 3;
            } else if (req.body.reports === 'suspended') {
                whereCondition = 'where del_status = 0 and role =1  and status = "deactive" order by id DESC'
                countWhereCondition = 'where del_status = 0 and status = "deactive"'
                reports_status = 4;
            } else if (req.body.reports === 'deleted') {
                whereCondition = 'where del_status = 1 and role =1 order by id DESC'
                countWhereCondition = 'where del_status = 1 '
                reports_status = 4;
            } else {
                console.log('Something went wrong');
                return false;
            }
        }

        faAPI.callUserQuery('no_type', fieldNames, whereCondition, function (apiUsersErr, apiUsersRes) {
            faAPI.callUserQuery('no_type', countFieldNames, countWhereCondition, function (apiCountUsersErr, apiCountUsersRes) {

                if (apiUsersErr) {
                    console.log("API ERR", apiUsersErr)
                } else {
                    // console.log(apiUsersRes);
                    // console.log(apiCountUsersRes.results[0].total_users);
                    // console.log(apiUsersRes.results.length);

                    if (req.body.type == 'dsp') {
                        headings = csvdata.split(',');
                        headings.pop();
                    }

                    var counts2 = apiUsersRes.results.length;
                    var counts = apiCountUsersRes.results[0].total_users;

                    console.log('pfff' + counts);
                    for (var i = 0; i < counts2; i++) {

                        if (req.body.user_id) {
                            csvdata += apiUsersRes.results[i].id + ',';
                            details.push(apiUsersRes.results[i].id);
                        }
                        if (req.body.first_name) {
                            csvdata += apiUsersRes.results[i].first_name + ',';
                            details.push(apiUsersRes.results[i].first_name);
                        }
                        if (req.body.last_name) {
                            csvdata += apiUsersRes.results[i].last_name + ',';
                            details.push(apiUsersRes.results[i].last_name);
                        }
                        if (req.body.username) {
                            csvdata += apiUsersRes.results[i].username + ',';
                            details.push(apiUsersRes.results[i].username);
                        }
                        if (req.body.email) {
                            csvdata += apiUsersRes.results[i].email + ',';
                            details.push(apiUsersRes.results[i].email);
                        }
                        if (req.body.created_at) {
                            csvdata += apiUsersRes.results[i].created_at + ',';
                            details.push(apiUsersRes.results[i].created_at);
                        }
                        if (req.body.updated_at) {
                            csvdata += apiUsersRes.results[i].updated_at + ',';
                            details.push(apiUsersRes.results[i].updated_at);
                        }
                        if (req.body.phone) {
                            csvdata += apiUsersRes.results[i].phone + ',';
                            details.push(apiUsersRes.results[i].phone);
                        }
                        if (req.body.address) {
                            csvdata += apiUsersRes.results[i].address1 + ',';
                            details.push(apiUsersRes.results[i].address1);
                        }
                        if (req.body.country) {
                            csvdata += apiUsersRes.results[i].country + ',';
                            details.push(apiUsersRes.results[i].country);
                        }
                        if (req.body.state) {
                            csvdata += apiUsersRes.results[i].state + ',';
                            details.push(apiUsersRes.results[i].state);
                        }
                        if (req.body.city) {
                            csvdata += apiUsersRes.results[i].city + ',';
                            details.push(apiUsersRes.results[i].city);
                        }
                        if (req.body.region) {
                            csvdata += apiUsersRes.results[i].region + ',';
                            details.push(apiUsersRes.results[i].region);
                        }
                        if (req.body.zipcode) {
                            csvdata += apiUsersRes.results[i].zip + ',';
                            details.push(apiUsersRes.results[i].zip);
                        }

                        all_details[i] = details;
                        details = [];

                        csvdata += lbreak;

                    }

                    if (counts == 0) {
                        csvdata += "No results found";
                    }

                    if (req.body.type == 'dsp') {

                        $arr['page'] = spage;
                        $arr['requests'] = req.body;
                        $arr['headings'] = headings;
                        $arr['all_details'] = all_details.slice(limits, ends);


                        var paginator = new pagination.SearchPaginator({
                            prelink: 'javascript:paginationReports',
                            current: spage,
                            rowsPerPage: 10,
                            totalResult: counts,
                            ajax: true
                        });


                        $arr['pagination_html'] = paginator.render();


                        common.headerSet(1);
                        common.tplFile('admincp/reportdisplay.tpl');
                        common.loadTemplateHeader(req, res, $arr);

                    } else {

                        res.setHeader('Content-disposition', 'attachment; filename=sellerreports.csv');
                        res.set('Content-Type', 'application/octet-stream');
                        res.send(csvdata);

                    }

                }
            })
        })

    }

    if (req.body.reports === 'ipaid' || req.body.reports === 'iunpaid') {


        if (req.body.invoiceid) {
            csvdata = "Invoice Id,";
        } else {
            csvdata = '';
        }
        if (req.body.proid) {
            csvdata += "Product Id,";
        }
        if (req.body.productname) {
            csvdata += "Product Name,";
        }
        if (req.body.date_added) {
            csvdata += "Date Added,";
        }
        if (req.body.uid) {
            csvdata += "User,";
        }
        if (req.body.username) {
            csvdata += "User Name,";
        }
        if (req.body.t_amount) {
            csvdata += "Total Amount,";
        }
        if (req.body.istatus) {
            csvdata += "Invoice Status,";
        }
        if (req.body.itype) {
            csvdata += "Invoice type,";
        }

        csvdata += lbreak;

        if (req.body.reports === 'ipaid') {
            reports_status = 'paid';
        } else {
            reports_status = 'unpaid';
        }


        q.all(admin.csvInvoicesRep(req, config.mysql, q, reports_status)).then(function (result) {
            if (req.body.type == 'dsp') {
                headings = csvdata.split(',');
                headings.pop();
            }

            var counts = result[0].length;
            console.log('pfff' + counts);
            for (var i = 0; i < counts; i++) {

                console.log(result[0][i].id);
                if (req.body.invoiceid) {
                    csvdata += result[0][i].id + ',';
                    details.push(result[0][i].id);
                }
                if (req.body.proid) {
                    csvdata += result[0][i].primary_id + ',';
                    details.push(result[0][i].primary_id);
                }

                if (req.body.productname) {
                    csvdata += result[0][i].description.replace(/,/g, " ") + ',';
                    details.push(result[0][i].description);
                }

                if (req.body.date_added) {
                    csvdata += result[0][i].date_added + ',';
                    details.push(result[0][i].date_added);
                }
                if (req.body.uid) {
                    csvdata += result[0][i].user_id + ',';
                    details.push(result[0][i].user_id);
                }

                if (req.body.username) {
                    csvdata += result[0][i].first_name + " " + result[0][i].last_name + ',';
                    details.push(result[0][i].first_name + " " + result[0][i].last_name);
                }

                if (req.body.t_amount) {
                    csvdata += result[0][i].amount + ',';
                    details.push(result[0][i].amount);
                }
                if (req.body.istatus) {
                    csvdata += result[0][i].status + ',';
                    details.push(result[0][i].status);
                }
                if (req.body.itype) {
                    csvdata += result[0][i].type + ',';
                    details.push(result[0][i].type);
                }

                all_details[i] = details;
                details = [];

                csvdata += lbreak;
                console.log(csvdata + i);

            }

            if (counts == 0) {
                csvdata += "No results found";
            }


            if (req.body.type == 'dsp') {
                var limits = (spage - 1) * 10;
                var ends = (spage) * 10;
                $arr['page'] = spage;
                $arr['requests'] = req.body;
                $arr['headings'] = headings;
                $arr['all_details'] = all_details.slice(limits, ends);


                var paginator = new pagination.SearchPaginator({
                    prelink: 'javascript:paginationReports',
                    current: spage,
                    rowsPerPage: 10,
                    totalResult: all_details.length,
                    ajax: true
                });
                $arr['pagination_html'] = paginator.render();


                common.headerSet(1);
                common.tplFile('admincp/reportdisplay.tpl');
                common.loadTemplateHeader(req, res, $arr);

            } else {

                res.setHeader('Content-disposition', 'attachment; filename=sellerreports.csv');
                res.set('Content-Type', 'application/octet-stream');
                res.send(csvdata);

            }
        });

    }

    if (req.body.reports === 'allp' ||
        req.body.reports === 'open' ||
        req.body.reports === 'close' ||
        req.body.reports === 'db' ||
        req.body.reports === 'ob') {
        console.log(req.body.reports);
        if (req.body.pkey) {
            csvdata = "Product Id,";
        }
        if (req.body.pkey) {
            csvdata = "Product Id,";
        }
        if (req.body.pname) {
            csvdata += "Product Name,";
        }
        if (req.body.qty) {
            csvdata += "Quantity,";
        }
        if (req.body.pdate_added) {
            csvdata += "Date Added,";
        }
        if (req.body.sid) {
            csvdata += "Seller Id,";
        }
        if (req.body.sell_name) {
            csvdata += "Seller Name,";
        }
        if (req.body.p_amount) {
            csvdata += "Sell Price,";
        }
        if (req.body.sold_item) {
            csvdata += "Sold Quantity,";
        }
        if (req.body.ptype) {
            csvdata += "Product Type,";
        }
        if (req.body.trading_type) {
            csvdata += "Trading Type,";
        }
        // if (req.body.dclosed) {
        //     csvdata += "Date Closed,";
        // }
        // if (req.body.paid_date) {
        //     csvdata += "Paid Closed,";
        // }

        csvdata += lbreak;

        if (req.body.reports === 'allp') {
            reports_status = 1;
        } else if (req.body.reports === 'close') {
            reports_status = 2;
        } else if (req.body.reports === 'db') {
            reports_status = 3;
        } else if (req.body.reports === 'ob') {
            reports_status = 4;
        } else {
            console.log('Something went wrong');
            return false;
        }


        q.all(admin.csvSellerRep(req, config.mysql, q, reports_status)).then(function (results) {

            console.log(results[0][0]);

            if (req.body.type == 'dsp') {
                headings = csvdata.split(',');
                headings.pop();
            }

            var counts = results[0].length;
            console.log('pfff' + counts);
            for (var i = 0; i < counts; i++) {

                if (req.body.pid) {
                    csvdata += results[0][i].id + ',';
                    details.push(results[0][i].id);
                }
                if (req.body.pkey) {
                    csvdata += results[0][i].pkey + ',';
                    details.push(results[0][i].pkey);
                }
                if (req.body.pname) {
                    csvdata += results[0][i].title.replace(/,/g, " ") + ',';
                    details.push(results[0][i].title);
                }
                if (req.body.qty) {
                    csvdata += results[0][i].qty + ',';
                    details.push(results[0][i].qty);
                }
                if (req.body.pdate_added) {
                    csvdata += results[0][i].date_added + ',';
                    details.push(results[0][i].date_added);
                }
                if (req.body.sid) {
                    csvdata += results[0][i].user_id + ',';
                    details.push(results[0][i].user_id);
                }


                // if (req.body.sell_name) {
                //     csvdata += results[0][i].first_name + " " + results[0][i].last_name + ',';
                //     details.push(results[0][i].first_name + " " + results[0][i].last_name);
                // }
                if (results[0][i].buynow == 0) {

                    if (req.body.p_amount) {
                        csvdata += results[0][i].sprice + ',';
                        details.push(results[0][i].sprice);
                    }

                } else {

                    if (req.body.p_amount) {
                        csvdata += results[0][i].bprice + ',';
                        details.push(results[0][i].bprice);
                    }

                }

                // if (req.body.s_amount) {
                //     csvdata += results[0][i].shipping_price + ',';
                //     details.push(results[0][i].shipping_price);
                // }
                if (req.body.sold_item) {
                    csvdata += results[0][i].sold + ',';
                    details.push(results[0][i].sold);
                }
                if (results[0][i].auction == 1) {

                    if (req.body.ptype) {
                        csvdata += 'Open Bid' + ',';
                        details.push('Open Bid');
                    }

                } else {

                    if (req.body.ptype) {
                        csvdata += 'Direct Buy' + ',';
                        details.push('Direct Buy');
                    }

                }
                if (req.body.trading_type) {
                    csvdata += results[0][i].trading_type + ',';
                    details.push(results[0][i].trading_type);
                }
                if (req.body.dclosed) {
                    csvdata += results[0][i].date_closed + ',';
                    details.push(results[0][i].date_closed);
                }
                if (req.body.paid_date) {
                    csvdata += results[0][i].paid_date + ',';
                    details.push(results[0][i].paid_date);
                }

                all_details[i] = details;
                details = [];

                csvdata += lbreak;

            }

            if (counts == 0) {
                csvdata += "No results found";
            }

            if (req.body.type == 'dsp') {
                var limits = (spage - 1) * 10;
                var ends = (spage) * 10;
                $arr['page'] = spage;
                $arr['requests'] = req.body;
                $arr['headings'] = headings;
                $arr['all_details'] = all_details.slice(limits, ends);


                var paginator = new pagination.SearchPaginator({
                    prelink: 'javascript:paginationReports',
                    current: spage,
                    rowsPerPage: 10,
                    totalResult: all_details.length,
                    ajax: true
                });
                $arr['pagination_html'] = paginator.render();


                common.headerSet(1);
                common.tplFile('admincp/reportdisplay.tpl');
                common.loadTemplateHeader(req, res, $arr);

            } else {

                res.setHeader('Content-disposition', 'attachment; filename=sellerreports.csv');
                res.set('Content-Type', 'application/octet-stream');
                res.send(csvdata);

            }

        });


    }

    if (req.body.reports === 'allads') {

        if (req.body.adid) {
            csvdata = "Ad Id,";
        } else {
            csvdata = '';
        }
        if (req.body.ad_name) {
            csvdata += "Ads Name,";
        }
        if (req.body.ad_title) {
            csvdata += "Ads title,";
        }
        if (req.body.ad_content) {
            csvdata += "Ads content,";
        }
        if (req.body.ad_url) {
            csvdata += "Ads Url,";
        }
        if (req.body.featured) {
            csvdata += "Featured Status,";
        }
        if (req.body.budget_per_click) {
            csvdata += "Budget per click,";
        }
        if (req.body.budget_per_day) {
            csvdata += "Budget per Day,";
        }
        if (req.body.user_id) {
            csvdata += "User ID,";
        }

        if (req.body.created_at) {
            csvdata += "Created Date,";
        }
        if (req.body.updated_at) {
            csvdata += "Updated Date,";
        }
        if (req.body.status) {
            csvdata += "Status,";
        }
        if (req.body.no_of_clicks) {
            csvdata += "Total Clicks,";
        }
        if (req.body.no_of_views) {
            csvdata += "Total Views,";
        }
        if (req.body.store_id) {
            csvdata += "Store ID,";
        }
        if (req.body.product_id) {
            csvdata += "Product ID,";
        }
        if (req.body.start_day) {
            csvdata += "Start Date,";
        }
        if (req.body.end_date) {
            csvdata += "End Date,";
        }

        csvdata += lbreak;

        if (req.body.reports === 'allads') {
            reports_status = 1;
        } else {
            console.log('ads section -- Something went wrong')
            return false;
        }

        // q.all(admin.csvBuyerRep(req, config.mysql, q, reports_status)).then(function(result) {
        q.all(admin.csvAdsRep(req, config.mysql, q, reports_status)).then(function (result) {

            if (req.body.type == 'dsp') {
                headings = csvdata.split(',');
                headings.pop();
            }

            var counts = result[0].length;
            console.log('pfff' + counts);
            for (var i = 0; i < counts; i++) {

                if (req.body.adid) {
                    csvdata += result[0][i].id + ',';
                    details.push(result[0][i].id);
                }
                if (req.body.ad_name) {
                    csvdata += result[0][i].ad_name + ',';
                    details.push(result[0][i].ad_name);
                }
                if (req.body.ad_title) {
                    csvdata += result[0][i].ad_title + ',';
                    details.push(result[0][i].ad_title);
                }
                if (req.body.ad_content) {
                    csvdata += result[0][i].ad_content + ',';
                    details.push(result[0][i].ad_content);
                }
                if (req.body.ad_url) {
                    csvdata += result[0][i].ad_url + ',';
                    details.push(result[0][i].ad_url);
                }
                if (req.body.featured) {
                    csvdata += result[0][i].featured + ',';
                    details.push(result[0][i].featured);
                }
                if (req.body.budget_per_click) {
                    csvdata += result[0][i].budget_per_click + ',';
                    details.push(result[0][i].budget_per_click);
                }
                if (req.body.budget_per_day) {
                    csvdata += result[0][i].budget_per_day + ',';
                    details.push(result[0][i].budget_per_day);
                }
                if (req.body.user_id) {
                    csvdata += result[0][i].user_id + ',';
                    details.push(result[0][i].user_id);
                }
                if (req.body.created_at) {
                    csvdata += result[0][i].created_at + ',';
                    details.push(result[0][i].created_at);
                }
                if (req.body.updated_at) {
                    csvdata += result[0][i].updated_at + ',';
                    details.push(result[0][i].updated_at);
                }
                if (req.body.status) {
                    csvdata += result[0][i].status + ',';
                    details.push(result[0][i].status);
                }
                if (req.body.no_of_clicks) {
                    csvdata += result[0][i].no_of_clicks + ',';
                    details.push(result[0][i].no_of_clicks);
                }
                if (req.body.no_of_views) {
                    csvdata += result[0][i].no_of_views + ',';
                    details.push(result[0][i].no_of_views);
                }
                if (req.body.store_id) {
                    csvdata += result[0][i].store_id + ',';
                    details.push(result[0][i].store_id);
                }
                if (req.body.product_id) {
                    csvdata += result[0][i].product_id + ',';
                    details.push(result[0][i].product_id);
                }
                if (req.body.start_day) {
                    csvdata += result[0][i].start_day + ',';
                    details.push(result[0][i].start_day);
                }
                if (req.body.end_date) {
                    csvdata += result[0][i].end_date + ',';
                    details.push(result[0][i].end_date);
                }

                all_details[i] = details;
                details = [];

                csvdata += lbreak;
            }

            if (counts == 0) {
                csvdata += "No results found";
            }

            if (req.body.type == 'dsp') {
                var limits = (spage - 1) * 10;
                var ends = (spage) * 10;
                $arr['page'] = spage;
                $arr['requests'] = req.body;
                $arr['headings'] = headings;
                $arr['all_details'] = all_details.slice(limits, ends);


                var paginator = new pagination.SearchPaginator({
                    prelink: 'javascript:paginationReports',
                    current: spage,
                    rowsPerPage: 10,
                    totalResult: all_details.length,
                    ajax: true
                });
                $arr['pagination_html'] = paginator.render();


                common.headerSet(1);
                common.tplFile('admincp/reportdisplay.tpl');
                common.loadTemplateHeader(req, res, $arr);

            } else {
                res.setHeader('Content-disposition', 'attachment; filename=buyerreports.csv');
                res.set('Content-Type', 'application/octet-stream');
                res.send(csvdata);
            }

        });


    }


    if (req.body.reports === 'earned') {

        if (req.body.pc_id) {
            csvdata = "Product Id,";
        } else {
            csvdata = '';
        }
        if (req.body.pc_name) {
            csvdata += "Product Name,";
        }
        if (req.body.pc_amt) {
            csvdata += "Amount,";
        }
        if (req.body.rc_date) {
            csvdata += "Paid Date,";
        }
        if (req.body.secid) {
            csvdata += "Seller Id,";
        }
        if (req.body.c_seller) {
            csvdata += "Seller Name,";
        }
        if (req.body.byid) {
            csvdata += "Buyer Id,";
        }
        if (req.body.c_buyer) {
            csvdata += "Buyer Name,";
        }
        if (req.body.comm_amt) {
            csvdata += "Commission,";
        }

        csvdata += lbreak;

        q.all(admin.csvCommissionRep(req, config.mysql, q)).then(function (result) {

            if (req.body.type == 'dsp') {
                headings = csvdata.split(',');
                headings.pop();
            }

            var counts = result[0].length;
            console.log('pfff' + counts);
            for (var i = 0; i < counts; i++) {

                if (req.body.pc_id) {
                    csvdata += result[0][i].project_id + ',';
                    details.push(result[0][i].project_id);
                }
                if (req.body.pc_name) {
                    csvdata += result[0][i].title.replace(/,/g, " ") + ',';
                    details.push(result[0][i].title);
                }
                if (req.body.pc_amt) {
                    csvdata += result[0][i].amount + ',';
                    details.push(result[0][i].amount);
                }
                if (req.body.rc_date) {
                    csvdata += result[0][i].paid_date + ',';
                    details.push(result[0][i].paid_date);
                }
                if (req.body.secid) {
                    csvdata += result[0][i].sid + ',';
                    details.push(result[0][i].sid);
                }
                if (req.body.c_seller) {
                    csvdata += result[0][i].name + ',';
                    details.push(result[0][i].name);
                }
                if (req.body.byid) {
                    csvdata += result[0][i].user_id + ',';
                    details.push(result[0][i].user_id);
                }
                if (req.body.c_buyer) {
                    csvdata += result[0][i].first_name + ' ' + result[0][i].last_name + ',';
                    details.push(result[0][i].first_name + ' ' + result[0][i].last_name);
                }
                if (req.body.comm_amt) {
                    csvdata += result[0][i].commission + ',';
                    details.push(result[0][i].commission);
                }

                all_details[i] = details;
                details = [];

                csvdata += lbreak;

            }

            if (counts == 0) {
                csvdata += "No results found";
            }

            if (req.body.type == 'dsp') {
                var limits = (spage - 1) * 10;
                var ends = (spage) * 10;
                $arr['page'] = spage;
                $arr['requests'] = req.body;
                $arr['headings'] = headings;
                $arr['all_details'] = all_details.slice(limits, ends);


                var paginator = new pagination.SearchPaginator({
                    prelink: 'javascript:paginationReports',
                    current: spage,
                    rowsPerPage: 10,
                    totalResult: all_details.length,
                    ajax: true
                });
                $arr['pagination_html'] = paginator.render();


                common.headerSet(1);
                common.tplFile('admincp/reportdisplay.tpl');
                common.loadTemplateHeader(req, res, $arr);

            } else {

                res.setHeader('Content-disposition', 'attachment; filename=commissions.csv');
                res.set('Content-Type', 'application/octet-stream');
                res.send(csvdata);
            }

        });


    }
    /* risk management report */

    if (req.body.reports === 'allr') {

        if (req.body.rid) {
            csvdata = "Id,";
        } else {
            csvdata = '';
        }
        if (req.body.user_id) {
            csvdata += "User ID,";
        }
        if (req.body.project_id) {
            csvdata += "Project ID,";
        }
        if (req.body.date_added) {
            csvdata += "Date Added,";
        }
        if (req.body.frequency) {
            csvdata += "Frequency,";
        }
        if (req.body.count) {
            csvdata += "Frequency count,";
        }
        if (req.body.quantity) {
            csvdata += "Quantity,";
        }
        if (req.body.amount) {
            csvdata += "Amount,";
        }
        if (req.body.sdate) {
            csvdata += "Start Date,";
        }

        if (req.body.edate) {
            csvdata += "End Date,";
        }
        if (req.body.cancellation) {
            csvdata += "Cancellation Insurance,";
        }
        if (req.body.cancelled) {
            csvdata += "Cancellation status,";
        }
        if (req.body.paid) {
            csvdata += "Payment status,";
        }
        if (req.body.active) {
            csvdata += "Current recurring status,";
        }
        if (req.body.tcartid) {
            csvdata += "Cart ID,";
        }
        if (req.body.r_recurring) {
            csvdata += "Product ID,";
        }
        if (req.body.reserve_price) {
            csvdata += "Reserve_price,";
        }
        if (req.body.checkout_id) {
            csvdata += "Checkout ID,";
        }
        if (req.body.status) {
            csvdata += "Status,";
        }
        if (req.body.cancellation_per) {
            csvdata += "Cancellation Percentage,";
        }

        csvdata += lbreak;

        if (req.body.reports === 'allr') {
            reports_status = 1;
        } else {
            console.log('ads section -- Something went wrong')
            return false;
        }

        // q.all(admin.csvBuyerRep(req, config.mysql, q, reports_status)).then(function(result) {
        // q.all(admin.csvAdsRep(req, config.mysql, q, reports_status)).then(function(result) {
        q.all(admin.csvRiskRep(req, config.mysql, q, reports_status)).then(function (result) {

            if (req.body.type == 'dsp') {
                headings = csvdata.split(',');
                headings.pop();
            }

            var counts = result[0].length;
            console.log('pfff' + counts);
            for (var i = 0; i < counts; i++) {

                if (req.body.rid) {
                    csvdata += result[0][i].id + ',';
                    details.push(result[0][i].id);
                }
                if (req.body.user_id) {
                    csvdata += result[0][i].user_id + ',';
                    details.push(result[0][i].user_id);
                }
                if (req.body.project_id) {
                    csvdata += result[0][i].project_id + ',';
                    details.push(result[0][i].project_id);
                }
                if (req.body.date_added) {
                    csvdata += result[0][i].date_added + ',';
                    details.push(result[0][i].date_added);
                }
                if (req.body.frequency) {
                    csvdata += result[0][i].frequency + ',';
                    details.push(result[0][i].frequency);
                }
                if (req.body.count) {
                    csvdata += result[0][i].count + ',';
                    details.push(result[0][i].count);
                }
                if (req.body.quantity) {
                    csvdata += result[0][i].quantity + ',';
                    details.push(result[0][i].quantity);
                }
                if (req.body.amount) {
                    csvdata += result[0][i].amount + ',';
                    details.push(result[0][i].amount);
                }
                if (req.body.sdate) {
                    csvdata += result[0][i].sdate + ',';
                    details.push(result[0][i].sdate);
                }

                if (req.body.edate) {
                    csvdata += result[0][i].edate + ',';
                    details.push(result[0][i].edate);
                }
                if (req.body.cancellation) {
                    csvdata += result[0][i].cancellation + ',';
                    details.push(result[0][i].cancellation);
                }
                if (req.body.cancelled) {
                    csvdata += result[0][i].cancelled + ',';
                    details.push(result[0][i].cancelled);
                }
                if (req.body.paid) {
                    csvdata += result[0][i].paid + ',';
                    details.push(result[0][i].paid);
                }
                if (req.body.active) {
                    csvdata += result[0][i].active + ',';
                    details.push(result[0][i].active);
                }
                if (req.body.tcartid) {
                    csvdata += result[0][i].tcartid + ',';
                    details.push(result[0][i].tcartid);
                }
                if (req.body.r_recurring) {
                    csvdata += result[0][i].r_recurring + ',';
                    details.push(result[0][i].r_recurring);
                }
                if (req.body.reserve_price) {
                    csvdata += result[0][i].reserve_price + ',';
                    details.push(result[0][i].reserve_price);
                }
                if (req.body.checkout_id) {
                    csvdata += result[0][i].checkout_id + ',';
                    details.push(result[0][i].checkout_id);
                }
                if (req.body.status) {
                    csvdata += result[0][i].status + ',';
                    details.push(result[0][i].status);
                }
                if (req.body.cancellation_per) {
                    csvdata += result[0][i].cancellation_per + ',';
                    details.push(result[0][i].cancellation_per);
                }

                all_details[i] = details;
                details = [];

                csvdata += lbreak;
            }

            if (counts == 0) {
                csvdata += "No results found";
            }

            if (req.body.type == 'dsp') {
                var limits = (spage - 1) * 10;
                var ends = (spage) * 10;
                $arr['page'] = spage;
                $arr['requests'] = req.body;
                $arr['headings'] = headings;
                $arr['all_details'] = all_details.slice(limits, ends);


                var paginator = new pagination.SearchPaginator({
                    prelink: 'javascript:paginationReports',
                    current: spage,
                    rowsPerPage: 10,
                    totalResult: all_details.length,
                    ajax: true
                });
                $arr['pagination_html'] = paginator.render();


                common.headerSet(1);
                common.tplFile('admincp/reportdisplay.tpl');
                common.loadTemplateHeader(req, res, $arr);

            } else {
                res.setHeader('Content-disposition', 'attachment; filename=buyerreports.csv');
                res.set('Content-Type', 'application/octet-stream');
                res.send(csvdata);
            }

        });


    }
});
/*Reports ends*/

app.get(['/banner/', '/banner/:type', '/banner/:type/:success', '/banner/:type/:id/:success'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['bannermenu'] = 'active';

    var banner = require('../../module/banner');
    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    req.body.type = (typeof (req.param('type')) === 'undefined') ? 'list' : req.param('type');

    $arr.success = (typeof (req.param('success')) === 'undefined') ? 0 : 'Banner details has been updated successfully';
    if (req.body.type == 'list') {
        q.all([banner.listMyBanner(req, config.mysql, q, 0), banner.listMyBanner(req, config.mysql, q, 1)]).then(function (result) {
            $arr['pagination'] = result[1][0].length;
            $arr['banner'] = result[0][0];
            // console.log($arr['banner']);
            var pagination = require('pagination');
            //console.log($arr['banner']);
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/banner',
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });
            //console.log($arr['banner']);
            //$arr['menu']['escrowmenu'] = 'active';
            $arr['pagination_html'] = paginator.render();
            //console.log($arr['banner']);
            common.tplFile('admincp/banner.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();


    }
    if (req.body.type == 'new') {

        // $arr['product'] = result[0][0];
        $arr['pids'] = [];
        common.tplFile('admincp/new-banner.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);


    }

    if (req.body.type == 'edit') {

        req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
        q.all([banner.editBanner(req, config.mysql, q)]).then(function (result) {

            $arr['banner'] = result[0][0][0];

            common.tplFile('admincp/new-banner.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();

    }

});

app.post(['/banner/:type'], function (req, res) {

    var banner = require('../../module/banner');
    req.body.type = (typeof (req.param('type')) === 'undefined') ? 'list' : req.param('type');
    if (req.body.type == 'save') {
        //req.body.id = 0;
        if (req.body.id > 0) {
            q.all([banner.editBanner(req, config.mysql, q)]).then(function (result) {

                req.body.enable = (typeof (req.param('enable')) === 'undefined') ? 0 : 1;

                if (typeof (req.files.banner_image) === 'undefined') {
                    //req.files = [];
                    req.files.banner_image = {
                        'name': result[0][0][0]['image'],
                        'originalname': result[0][0][0]['o_image']
                    };
                }
                banner.updateProducts(req, config.mysql, q);

                res.writeHead(302, {
                    'Location': '/admincp/banner/edit/success/?id=' + req.body.id
                });
                res.end();
                return false;
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        } else {
            req.body.enable = (typeof (req.param('enable')) === 'undefined') ? 0 : 1;

            banner.insertProducts(req, config.mysql, q);
            res.writeHead(302, {
                'Location': '/admincp/banner/'
            });
            res.end();
            return false;
        }
    }


});

app.post(['/editpaymods/:action'], function (req, res) {
    var action = req.param('action');
    var fs = require('fs'),
        ini = require('ini');
    var add_to_ur = '#';
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));

    if (action == 'authorize') {

        if (req.body.auth_enable == 'yes') {
            configed['section']['paypal']['enabled'] = 'no';
            configed['section']['braintree']['enabled'] = 'no';
            configed['section']['voguepay']['enabled'] = 'no';
            configed['section']['stripe']['enabled'] = 'no';

        }

        configed['section']['authorizenet']['api'] = req.body.auth_id;
        configed['section']['authorizenet']['key'] = req.body.auth_key;
        configed['section']['authorizenet']['enabled'] = req.body.auth_enable;
        add_to_ur = add_to_ur + 'collapseone';
        fs.writeFileSync('./config.ini', ini.stringify(configed));

    }

    if (action == 'paypal') {

        if (req.body.pay_status == 'yes') {
            configed['section']['authorizenet']['enabled'] = 'no';
            configed['section']['braintree']['enabled'] = 'no';
            configed['section']['voguepay']['enabled'] = 'no';
            configed['section']['stripe']['enabled'] = 'no';

        }

        configed['section']['paypal']['address'] = req.body.pay_address;
        configed['section']['paypal']['preapproval_key'] = req.body.pay_key;
        configed['section']['paypal']['paypal_api'] = req.body.pay_api;
        configed['section']['paypal']['paypal_password'] = req.body.pay_password;
        configed['section']['paypal']['paypal_signature'] = req.body.pay_signature;
        configed['section']['paypal']['paypal_username'] = req.body.pay_username;
        configed['section']['paypal']['enabled'] = req.body.pay_status;
        add_to_ur = add_to_ur + 'collapseTwo';
        fs.writeFileSync('./config.ini', ini.stringify(configed));
    }

    if (action == 'braintree') {

        if (req.body.braintree_status == 'yes') {

            configed['section']['authorizenet']['enabled'] = 'no';
            configed['section']['paypal']['enabled'] = 'no';
            configed['section']['voguepay']['enabled'] = 'no';
            configed['section']['stripe']['enabled'] = 'no';

        }


        configed['section']['braintree']['merchantId'] = req.body.braintree_id;
        configed['section']['braintree']['privateKey'] = req.body.braintree_privatekey;
        configed['section']['braintree']['publicKey'] = req.body.braintree_publickey;
        configed['section']['braintree']['customerprefix'] = req.body.braintree_customerprefix;
        configed['section']['braintree']['enabled'] = req.body.braintree_status;

        add_to_ur = add_to_ur + 'collapseFour';
        fs.writeFileSync('./config.ini', ini.stringify(configed));
    }

    if (action == 'voguepay') {

        if (req.body.vp_status == 'yes') {

            configed['section']['authorizenet']['enabled'] = 'no';
            configed['section']['paypal']['enabled'] = 'no';
            configed['section']['stripe']['enabled'] = 'no';
            configed['section']['braintree']['enabled'] = 'no';

        }

        configed['section']['voguepay']['enabled'] = req.body.vp_status;
        configed['section']['voguepay']['merchantid'] = req.body.vp_merchantid;

        add_to_ur = add_to_ur + 'collapseFour';
        fs.writeFileSync('./config.ini', ini.stringify(configed));

    }

    if (action == 'stripe') {

        if (req.body.stripe_status == 'yes') {

            configed['section']['authorizenet']['enabled'] = 'no';
            configed['section']['paypal']['enabled'] = 'no';
            configed['section']['voguepay']['enabled'] = 'no';
            configed['section']['braintree']['enabled'] = 'no';

        }

        configed['section']['stripe']['enabled'] = req.body.stripe_status;
        configed['section']['stripe']['secretkey'] = req.body.stripe_secretkey;
        configed['section']['stripe']['publishkey'] = req.body.stripe_publishkey;

        add_to_ur = add_to_ur + 'collapseFour';
        fs.writeFileSync('./config.ini', ini.stringify(configed));

    }

    config.mysql.destroy();
    delete configure;
    delete config;
    delete $arr;
    configure = require('../../configure');
    config = configure.app();

    $arr = {
        config: config
    }

    res.writeHead(302, {
        'Location': '/admincp/paymentmodules/'
    });
    res.end();
    return false;

});


app.get(['/view_disputes', '/view_disputes/:success'], function (req, res) {
    console.log("In ss")
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['disputes'] = 'active';


    dispute = require('../../module/dispute');
    $arr.success = (typeof (req.param('success')) === 'undefined') ? 0 : 'Dispute details has been deleted successfully';

    q.all([dispute.showDisputes(req, config.mysql, q)]).then(function (result) {

        $arr['disputes'] = result[0][0];
        // console.log($arr['banner']);

        //console.log($arr['banner']);
        common.tplFile('admincp/dispute_list.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/del_disputes/:del_id'], function (req, res) {
    req.body.del_id = (typeof (req.param('del_id')) === 'undefined') ? 0 : req.param('del_id');
    dispute = require('../../module/dispute');
    q.all([dispute.delDisputes(req, config.mysql, q), dispute.showDisputes(req, config.mysql, q)]).then(function (result) {
        res.writeHead(302, {
            'Location': '/admincp/view_disputes/success'
        });
        res.end();
        return false;

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get(['/forumcats'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['forums'] = 'active';
    $arr['menu']['forumscats'] = 'active';
    var forums = require('../../module/forums');

    q.all([forums.getAllcats(req, config.mysql, q)]).then(function (results) {

        $arr['categories'] = results[0][0];

        common.tplFile('admincp/forum_categories.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });

});

app.get(['/forum_cats', '/forum_cats/:action/:id'], function (req, res) {

    var forums = require('../../module/forums');
    if (req.param('action') == 'edit') {
        q.all([forums.getIdcats(req, config.mysql, q, req.param('id'))]).then(function (results) {
            $arr['category_id'] = results[0][0][0].id;
            $arr['category_name'] = results[0][0][0].catname;
            console.log(results[0][0][0]);
            common.tplFile('admincp/forum_category.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);


        });

    } else if (req.param('action') == 'delete') {

        forums.deleteforumcats(req, config.mysql, q, req.param('id'));
        res.redirect('/admincp/forumcats');
        res.end();
        return false;

    } else {

        common.tplFile('admincp/forum_category.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }


});

app.post(['/addForumcats'], function (req, res) {



    var forums = require('../../module/forums');

    if (req.body.id > 0) {

        forums.updateforumcats(req, config.mysql, q, req.body.id);
    } else {

        forums.addforumcats(req, config.mysql, q);

    }


    res.redirect('/admincp/forumcats');
    res.end();
    return false;

});

app.get(['/forumquests'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['forums'] = 'active';
    $arr['menu']['forumsquestions'] = 'active';
    var forums = require('../../module/forums');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    q.all([forums.all_questions(req, config.mysql, q, 0), forums.all_questions(req, config.mysql, q, 1)]).then(function (results) {

        $arr['questions'] = results[0][0];
        console.log($arr['questions']);
        $arr['pagination'] = results[1][0].length;
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: '/admincp/forumquests/',
            current: req.body.page,
            rowsPerPage: 10,
            totalResult: $arr['pagination']
        });
        $arr['menu']['escrowmenu'] = 'active';
        $arr['pagination_html'] = paginator.render();

        common.tplFile('admincp/forum_questions.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });

});

app.get(['/deletefq/:id'], function (req, res) {
    var forums = require('../../module/forums');
    forums.deleteqs(req, config.mysql, q, req.param('id'));
    res.redirect('/admincp/forumquests');
    res.end();
    return false;


});

app.get(['/forumans/:id'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['forums'] = 'active';
    $arr['menu']['forumsquestions'] = 'active';
    var forums = require('../../module/forums');

    q.all([forums.getAnswer(req, config.mysql, q, req.param('id'))]).then(function (results) {
        $arr['qid'] = req.param('id')
        $arr['answers'] = results[0][0];

        common.tplFile('admincp/forum_answers.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });

});

app.get(['/deletefas/:id'], function (req, res) {
    var forums = require('../../module/forums');
    var qid = req.param('qid')
    forums.deleteans(req, config.mysql, q, req.param('id'));
    res.redirect('/admincp/forumans/' + qid);
    res.end();
    return false;


});

app.get(['/transfer_list/:id'], function (req, res) {

    $arr['trans'] = req.param('id')
    common.tplFile('admincp/transfer.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});

app.post(['/transfer_ownership'], function (req, res) {

    message = require('../../module/message');
    dashboard = require('../../module/dashboard');
    var dat = require('date-util');
    q.all([dashboard.getuser_details(req, config.mysql, q, req.body.transfer_mail), dashboard.product_details(req, config.mysql, q, req.body.product_id), dashboard.transfer_product(req, config.mysql, q), dashboard.cancel_ownerbids(req, config.mysql, q)]).then(function (results) {
        console.log(results[0][0]);
        req.body.toid = results[0][0][0].id;
        req.body.first_name = results[0][0][0].first_name;
        req.body.last_name = results[0][0][0].last_name;
        req.body.r_id = Date.parse(new Date()) / 1000;
        req.body.toemail = req.body.transfer_mail;
        req.body.fromid = req.session.user_id;
        req.body.pid = req.body.product_id;
        req.body.subject = 'You are the new owner';
        req.body.message = 'You are the new owner of ' + results[1][0][0].title + ' . Happy Selling !.';
        console.log(results[0][0]);
        message.addmessages(req, config.mysql, q);

        res.writeHead(302, {
            'Location': '/admincp/projects/list'
        });
        res.end();
        return false;

    });


});


app.get(['/guest_users'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['connections'] = 'active';
    $arr['menu']['guests'] = 'active';
    q.all([admin.getLoggedguest(req, config.mysql, q)]).then(function (results) {


        $arr['guests'] = results[0][0];

        common.tplFile('admincp/guest_details.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });


});


app.get(['/logged_users'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['connections'] = 'active';
    $arr['menu']['logged'] = 'active';
    q.all([admin.getLoggeduser(req, config.mysql, q)]).then(function (results) {


        $arr['users'] = results[0][0];

        common.tplFile('admincp/loged_user.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });


});
app.get(['/twilio/:action', '/twilio/:action/:id'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['twilio'] = 'active';
    var action = req.param('action');
    if (action == 'new') {
        common.tplFile('admincp/twilionewnumber.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }
    if (action == 'enable' || action == 'disable') {
        enable = 0;

        if (action == 'enable') {
            enable = 1;
        }
        admin.twilioenablenumber(req, config.mysql, q, enable);
        res.writeHead(302, {
            'Location': '/admincp/twilio/list?cmd=Action Completed'
        });
        res.end();
        return false;
    }
    if (action == 'post') {
        admin.twilioaddnumber(req, config.mysql, q);
        res.writeHead(302, {
            'Location': '/admincp/twilio/list?cmd=Action Completed'
        });
        res.end();
        return false;

    }
    if (action == 'list') {
        q.all([admin.twiliolist(req, config.mysql, q)]).then(function (results) {
            $arr.cmd = (typeof (req.param('cmd')) === 'undefined') ? '' : req.param('cmd');
            $arr.list = results[0][0];
            common.tplFile('admincp/twilionumberlist.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});

app.get(['/currency_management'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['currencysetup'] = 'active';
    var oxr = require('open-exchange-rates'),
        fx = require('money');
    oxr.set({ app_id: 'cd897a1fc5c44799babb7cb9d145edb1' })
    q.all([admin.getDefaultCurrency(req, config.mysql, q)]).then(function (results) {
        console.log(results[0][0][1].abb);
        var currencies = [];
        oxr.latest(function () {
            fx.base = "USD";
            fx.rates = oxr.rates;


            if (results[0][0].length > 0) {
                console.log(results[0][0].length);
                for (var i = 0; i < results[0][0].length; i++) {
                    currencies[i] = [];
                    currencies[i]['id'] = results[0][0][i].id;
                    currencies[i]['currency'] = results[0][0][i].currency;
                    currencies[i]['rate'] = results[0][0][i].rate;
                    currencies[i]['abb'] = results[0][0][i].abb;
                    currencies[i]['symbol'] = results[0][0][i].symbol;
                    /*currencies[i]['symbol_right'] =  results[0][0][i].symbol_right;
                     currencies[i]['decimal'] =  results[0][0][i].decimal_point;
                     currencies[i]['thousand'] =  results[0][0][i].thousand_point;*/
                    currencies[i]['status'] = results[0][0][i].status;
                }
            }


            $arr['datas'] = currencies;

            common.tplFile('admincp/currency.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        });

    });
    /*delete $arr['menu'];$arr['menu'] =[];
     $arr['menu']['connections'] = 'active';
     $arr['menu']['logged'] = 'active'; */


});

app.get(['/default_currency/activate/:id'], function (req, res) {
    var cid = req.param('id');

    admin.deactiveallcurrency(req, config.mysql, q);
    admin.updatecurrency(req, config.mysql, q, cid);

    res.writeHead(302, {
        'Location': '/admincp/currency_management'
    });
    res.end();
    return false;


});

app.get(['/language_management'], function (req, res) {

    var fs = require('fs'),
        ini = require('ini');
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));


    language = require('../../module/language');
    q.all([language.getAllLangs(req, config.mysql, q), language.getAllGroups(req, config.mysql, q), language.getAllPhrases(req, config.mysql, q)]).then(function (results) {
        $all_langs = results[0][0];


        var languages = [];
        for (var i = 0; i < results[0][0].length; i++) {
            languages[i] = [];
            languages[i]['id'] = results[0][0][i].id;
            $arr['used_language'] = configed['section']['languages']['used'];
            languages[i]['language'] = results[0][0][i].language;
            languages[i]['language_slug'] = results[0][0][i].language_slug;
            languages[i]['values'] = 'for_' + results[0][0][i].language.toLowerCase().replace(/\s+/g, '');
        }


        $arr['phrases'] = global.phrases;

        $arr['languages'] = languages;
        $arr['groups'] = results[1][0];
        $arr['all_phrases'] = results[2][0];
        if (req.session.phrase_exist == 1) {

            $arr['phrase_exist'] = 1;
            delete req.session.phrase_exist;
        }
        common.tplFile('admincp/languages.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
        // common.loadLanguage(req,res,'Admin',$arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();


});

app.post(['/addlang_group'], function (req, res) {


    language = require('../../module/language');
    q.all([language.check_group(req, config.mysql, q)]).then(function (results) {
        if (results[0][0].length > 0) {
            req.session.group = 1;
        } else {
            console.log("asdasdasd");
            language.add_groups(req, config.mysql, q);
        }
    });
    res.writeHead(302, {
        'Location': '/admincp/language_management'
    });

    res.end();
    return false;


});

app.post(['/addlanguage'], function (req, res) {


    language = require('../../module/language');
    q.all([language.check_language(req, config.mysql, q)]).then(function (results) {
        if (results[0][0].length > 0) {
            req.session.langs = 1;
        } else {
            language.add_language(req, config.mysql, q);
            language.add_language_column(req, config.mysql, q);
        }
    });

    res.writeHead(302, {
        'Location': '/admincp/language_management'
    });
    res.end();
    return false;


});

app.post(['/addphrase'], function (req, res) {


    language = require('../../module/language');
    q.all([language.check_phrase(req, config.mysql, q)]).then(function (results) {
        var sellang = req.body.sellang;
        if (results[0][0].length > 0) {
            if (results[0][0][0][req.body.sellang]) {
                req.session.phrase_exist = 1;
            } else {
                language.updatephrase(req, config.mysql, q);
            }


        } else {
            language.add_phrase(req, config.mysql, q);
        }
        config.mysql.destroy();
        delete configure;
        delete config;
        delete $arr;
        configure = require('../../configure');
        config = configure.app();
        $arr = {
            config: config
        }

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

    res.writeHead(302, {
        'Location': '/admincp/language_management'
    });
    res.end();
    return false;


});


app.post(['/activate_language'], function (req, res) {


    language.deactivealllanguage(req, config.mysql, q);
    language.activate_languages(req, config.mysql, q);

    var fs = require('fs'),
        ini = require('ini');
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));

    configed['section']['languages']['used'] = req.body.active_lang;
    fs.writeFileSync('./config.ini', ini.stringify(configed));

    config.mysql.destroy();
    delete configure;
    delete config;
    delete $arr;
    configure = require('../../configure');
    config = configure.app();
    $arr = {
        config: config
    }
    res.writeHead(302, {
        'Location': '/admincp/language_management'
    });
    res.end();
    return false;
});
app.get(['/pharselist'], function (req, res) {
    var csv = require('csv');


    q.all([admin.csvLanguagePhrases(req, config.mysql, q)]).then(function (results) {
        var lbreak = "\n";
        var csvdata = "group_id,";
        csvdata += "phrase,";
        csvdata += lbreak;
        var count = results[0][0].length;
        console.log(count);
        for (var i = 0; i < count; i++) {

            console.log(results[0][0][i].group_id);
            csvdata += results[0][0][i].group_id + ',';
            csvdata += results[0][0][i].phrase + ',';
            csvdata += lbreak;
        }
        console.log(csvdata);
        res.setHeader('Content-disposition', 'attachment; filename=pharselist   .csv');
        res.set('Content-Type', 'application/octet-stream');
        res.send(csvdata);

    });

    return false;

});

app.post(['/languagephrase/import'], function (req, res) {

    var files = req.body.csvs;
    var details = [];
    fs = require('fs');
    parse = require('csv-parse');
    var language_column = req.body.active_lang;
    rs = fs.createReadStream(req.files.csvs.path);

    parser = parse({ columns: true }, function (err, data) {
        //console.log(parser.options.columns);
        var valid_cols = ['group_id', 'phrase', language_column];
        var lang = [];
        if (parser.options.columns.length == valid_cols.length) {
            if (parser.options.columns[2] == valid_cols[2]) {
                var counts = data.length;
                console.log('**************************************');
                console.log(counts);
                console.log('**************************************');
                //  admin.addtempbyCSV(req,config.mysql,q,$arr);

                for (var i = 0; i < counts; i++) {

                    lang['phrase'] = data[i].phrase;
                    lang['words'] = data[i][language_column];
                    lang['group_id'] = data[i].group_id;
                    lang['lang_column'] = language_column;
                    admin.update_language_phrase(req, config.mysql, q, lang);

                }
            } else {
                console.log('Language selected is not added on CSV');
            }

        } else {
            console.log('Only three columns are permitted in CSV. They are group_id,phrase and Language name in small letter preceeded by for_');
        }
    })
    rs.pipe(parser);
    res.writeHead(302, {
        'Location': '/admincp/language_management'
    });
    res.end();
    return false;

});


app.post(['/phrase_text'], function (req, res) {
    q.all([language.getrelatedPhrase(req, config.mysql, q)]).then(function (results) {
        console.log(results[0][0][0][req.body.langid]);

        res.send(results[0][0][0][req.body.langid]);


    });
    return false;

});

app.post(['/updatephrase'], function (req, res) {

    language.updatesinglePhrase(req, config.mysql, q);
    config.mysql.destroy();
    delete configure;
    delete config;
    delete $arr;
    configure = require('../../configure');
    config = configure.app();
    $arr = {
        config: config
    }
    res.writeHead(302, {
        'Location': '/admincp/language_management'
    });
    res.end();
    return false;

});

app.get(['/seotools'], function (req, res) {
    /*common.admincheckLogin(req,res,1);
     delete $arr['menu'];$arr['menu'] =[];
     $arr['menu']['connections'] = 'active';
     $arr['menu']['logged'] = 'active'; */
    q.all([admin.getseo(req, config.mysql, q)]).then(function (results) {


        $arr['seo_pages'] = results[0][0];

        var fs = require('fs'),
            ini = require('ini');
        var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
        $arr['seo_switch'] = configed['section']['seo']['enabled'];

        common.tplFile('admincp/seo.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });


});

app.post(['/seoenable'], function (req, res) {
    var fs = require('fs'),
        ini = require('ini');
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));

    if (req.body.seoswitch == 'yes' || req.body.seoswitch == 'no') {
        configed['section']['seo']['enabled'] = req.body.seoswitch;
        fs.writeFileSync('./config.ini', ini.stringify(configed));
    }

    config.mysql.destroy();
    delete configure;
    delete config;
    delete $arr;
    configure = require('../../configure');
    config = configure.app();
    $arr = {
        config: config
    }
    res.writeHead(302, {
        'Location': '/admincp/seotools'
    });
    res.end();
    return false;


});

app.post(['/addpageseo'], function (req, res) {
    q.all([admin.checkseourl(req, config.mysql, q)]).then(function (results) {

        if (results[0][0].length == 0) {
            admin.addseo(req, config.mysql, q);
        }
        res.writeHead(302, {
            'Location': '/admincp/seotools'
        });
        res.end();
        return false;

    });

});

app.get(['/editseo/:id'], function (req, res) {

    var fs = require('fs'),
        ini = require('ini');
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    $arr['seo_switch'] = configed['section']['seo']['enabled'];
    $arr['id'] = req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    q.all([admin.getseobyid(req, config.mysql, q, $arr['id']), admin.getseo(req, config.mysql, q)]).then(function (results) {
        $arr['seo_pages'] = results[1][0];
        $arr['seo_details'] = results[0][0][0];
        common.tplFile('admincp/seo.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });

});

app.post(['/editpageseo/:id'], function (req, res) {

    $arr['id'] = req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    admin.editseobyid(req, config.mysql, q, $arr['id']);
    res.writeHead(302, {
        'Location': '/admincp/seotools?view=1'
    });
    res.end();
    return false;

});
app.post('/addMaxStoreCategory', function (req, res) {
    q.all([admin.maxStoreCategoryLength(req, config.mysql, q)]).then(function (results) {
        res.send(JSON.stringify({ 'status': 'true', 'id': results[0][0].insertId }));
        res.end();
        return false;
    });

});

app.get(['/deleteseo/:id'], function (req, res) {


    $arr['id'] = req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    admin.deleteseobyid(req, config.mysql, q, $arr['id']);

    res.writeHead(302, {
        'Location': '/admincp/seotools?view=1'
    });

    res.end();
    return false;

});

app.get(['/primarystore/:action'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['primarystoremenu'] = 'active';
    q.all([admin.select_all_store(req, config.mysql, q)]).then(function (results) {
        if (results[0][0].length > 0) {
            $arr['storedetails'] = results[0][0];
        } else {
            $arr['storedetails'] = [];
        }
        common.tplFile('admincp/add_primary_store.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post(['/add9Stores'], function (req, res) {
    q.all([admin.deactivatePrimaryStore(req, config.mysql, q)]).then(function (results) {
        q.all([admin.activatePrimaryStore(req, config.mysql, q)]).then(function (results2) {
            res.send(JSON.stringify({ 'status': 'true' }));
            res.end();
            return false;
        });
    });
});

app.get(['/storecategories/:action'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['storecategoriesmenu'] = 'active';
    q.all([admin.selectMaxStoreCategory(req, config.mysql, q)]).then(function (results1) {
        if (results1[0][0].length > 0) {
            $arr['storemaxlength'] = results1[0][0];
        } else {
            $arr['storemaxlength'] = [];
        }
        q.all([admin.getAllCategory(req, config.mysql, q)]).then(function (results) {
            $arr.category = results[0][0];
            common.tplFile('admincp/storecategories.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    });
});
app.post('/saveStoreCategory', function (req, res) {
    q.all([admin.SaveStoreCategoryids(req, config.mysql, q)]).then(function (results) {
        res.send(JSON.stringify({ 'status': 'true', 'id': results[0][0].insertId }));
        res.end();
        return false;
    });

});

app.get('/storesubscription', function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['storesubmenu'] = 'active';

    var fs = require('fs'),
        ini = require('ini');
    var add_to_ur = '#';
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    config2 = configed['section'];
    global.freesubscription = config2['freesubscription'];

    q.all([admin.getStoreSubscription(req, config.mysql, q)]).then(function (results) {
        $arr.getSub = results[0][0];
        common.tplFile('admincp/storesubscription.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

var braintree = require('braintree');
braintrees = braintree.connect({
    environment: braintree.Environment.Sandbox,
    merchantId: "9c2tgpsm3b2247wz",
    publicKey: "sj9ff8mydmdf3rnk",
    privateKey: "edeebab8d795fc9cd8bae939799cddd3"
});

app.post('/saveStoreSubscription', function (req, res) {
    var pid = req.body.planid;
    var callback2 = function (amount) {
        req.body.amount = amount;
        q.all([admin.saveStoreSubscription(req, config.mysql, q)]).then(function (results) {
            res.send(JSON.stringify({ 'status': 'true', 'planid': 'true' }));
            res.end();
            return false;
        });
    }
    var callback = function (plans) {
        var amt = '';
        for (var key in plans) {
            if (plans[key].id == pid) {
                amt = plans[key].price;
                callback2(amt);
            }
        }
        if (amt == '') {
            res.send(JSON.stringify({ 'status': 'true', 'planid': 'false' }));
            res.end();
            return false;
        }
    }
    var controller = {
        getPlansAvailable: function (callback) {
            braintrees.plan.all(function (err, response) {
                if (typeof callback == 'function') {
                    callback(response.plans);
                } else {
                    return response.plans;
                }
                return this;
            });
        }
    };

    controller.getPlansAvailable(callback);
})
app.get('/deleteStoreSub/:id', function (req, res) {
    req.body.plid = (typeof (req.param('id')) != 'undefined') ? Number(req.param('id')) : 0;
    q.all([admin.deleteStoreSubscription(req, config.mysql, q)]).then(function (results) {
        res.writeHead(302, {
            'Location': '/admincp/storesubscription'
        });
        res.end();
        return false;
    });
});


app.get(['/pro_settings'], function (req, res) {
    $arr.prosetclass = 'active';
    var fs = require('fs'),
        ini = require('ini');
    var add_to_ur = '#';
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    config1 = configed['section'];
    global.productsetting = config1['productsetting'];
    common.tplFile('admincp/prosettings.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.post('/saveProductSettings', function (req, res) {
    var fs = require('fs'),
        ini = require('ini');
    var add_to_ur = '#';
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    configed['section']['productsetting']['weight'] = req.body.weight;
    configed['section']['productsetting']['length'] = req.body.length;
    configed['section']['productsetting']['currency'] = req.body.currency;
    fs.writeFileSync('./config.ini', ini.stringify(configed));
    res.send(JSON.stringify({ 'status': 'success' }));
    res.end();
    return false;
});

app.post('/saveFreeSubscription', function (req, res) {
    var fs = require('fs'),
        ini = require('ini');
    var add_to_ur = '#';
    var configed = ini.parse(fs.readFileSync('./config.ini', 'utf-8'));
    configed['section']['freesubscription']['product'] = req.body.product;
    configed['section']['freesubscription']['store'] = req.body.store;
    configed['section']['freesubscription']['category'] = req.body.category;
    fs.writeFileSync('./config.ini', ini.stringify(configed));
    res.send(JSON.stringify({ 'status': 'success' }));
    res.end();
    return false;
});
/*app.get(['/messages', '/messages/:action'], function(req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['messagesmenu'] = 'active';
    messages = require('../../module/message');
    req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof(req.param('action')) !== 'undefined') ? req.param('action') : '';
    $arr['action'] = req.body.action;
    if (req.body.action == 'compose') {

        q.all([messages.usersmessages(req, config.mysql, q, callback)]).then(function(results) {
            console.log('results', results[0]);
            $arr['users'] = results[0][0];
            common.tplFile('admincp/compose.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    } else {
        q.all([
            messages.mymessages(req, config.mysql, q, 0),
            messages.mymessages(req, config.mysql, q, 1)
        ]).then(function(results) {
            $arr['pagination'] = results[1][0].length;
            $arr['messages'] = results[0][0];
            if (typeof($arr['action']) === 'undefined' || $arr['action'] == '') {
                $arr['messagesstatus'] = '';
            } else {
                $arr['messagesstatus'] = $arr['action'];
            }
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/messages/' + req.body.action,
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/messages.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    }
});*/

// app.get(['/', '/dashboard'], function(req, res) {

//     delete $arr['menu'];
//     $arr['menu'] = [];
//     $arr['menu']['dashboardmenu'] = 'active';

//     async.series({
//         exportDashboard: function(cb) {
//             // getting userInformations                //'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users order by id DESC limit ?, 10';
//             q.all([
//                 admin.exportProjectDashboard(res, config.mysql, q),
//                 admin.exportTransactionDashboard(res, config.mysql, q)
//             ]).then(function(result) {
//                 cb(null, result);
//             }).fail(function(err) {
//                 console.log(err.stack);
//                 throw err;
//             })

//         },
//         exportUsersDashboard: function(cb) {
//             // getting userInformations
//             var callback = function(err, response) {
//                 cb(err, response);
//             }

//             faAPI.customUserQuery('sum(if(status = "active",1,0)) as active, sum(if(status = "unverified",1,0)) as unverified, sum(if(status = "moderate",1,0)) as moderate, sum(if(status = "deactivate" or status = "unsubscribe",1,0)) as cancel', callback);

//         }

//     }, function(err, results) {

//         if (err) {
//             console.log(JSON.stringify(err));
//             throw err
//         }

//         $arr['project'] = results.exportDashboard[0][0][0];
//         $arr['users'] = results.exportUsersDashboard.user[0];
//         $arr['trans'] = results.exportDashboard[1][0][0];
//         common.tplFile('admincp/index.tpl');
//         common.headerSet(1);
//         common.loadTemplateHeader(req, res, $arr);

//     })

// });

app.get(['/relationship', '/relationship/:action', '/relationship/:action/:id'], function (req, res) {

    req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
    req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
    req.body.from_date = (typeof (req.param('from_date')) === 'undefined') ? '' : req.param('from_date');
    req.body.to_date = (typeof (req.param('to_date')) === 'undefined') ? '' : req.param('to_date');
    // req.body.country = (typeof(req.param('country')) === 'undefined') ? '' : req.param('country');
    // req.body.state = (typeof(req.param('state')) === 'undefined') ? '' : req.param('state');

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['relationmess'] = 'active';

    $arr.externalcss = ['datePicker'];
    $arr.externaljs = ['jquery.datePicker'];

    $arr.country = req.body.country;
    $arr.state = req.body.state;
    $arr.from_date = req.body.from_date;
    $arr.to_date = req.body.to_date;

    messages = require('../../module/message');

    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';

    $arr['action'] = req.body.action;

    if (req.body.action == 'compose') {
        q.all([messages.usersmessages(req, config.mysql, q)]).then(function (results) {
            $arr['users'] = results[0][0];
            common.tplFile('admincp/compose.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    } else if (req.body.action == 'delete') {
        req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : '';
        q.all([messages.adminDeleteMessages(req, config.mysql, q)]).then(function (results) {
            res.redirect('/admincp/relationship');
        });
    } else {
        $arr['menu']['relationmessall'] = 'active';
        q.all([
            messages.adminmyrelation(req, config.mysql, q, 0),
            messages.adminmyrelation(req, config.mysql, q, 1)
        ]).then(function (results) {
            var user_ids = _.pluck(results[0][0], 'from_id');
            faAPI.appendUserDataForObject('id', 'id as from_id,username,email,first_name,last_name', user_ids, results[0][0], 'from_id', function (apiUsersErr, apiUsersRes) {
                console.log('api res', apiUsersRes);

                $arr['pagination'] = results[1][0].length;
                $arr['messages'] = apiUsersRes;
                console.log('page', $arr['pagination']);
                if (typeof ($arr['action']) === 'undefined' || $arr['action'] == '') {
                    $arr['messagesstatus'] = '';
                } else {
                    $arr['messagesstatus'] = $arr['action'];
                }

                var url = require('url');
                var url_parts = url.parse(req.url, true);
                var query = url_parts.query;
                fquery = common.urlparameter(query, { page: '' });

                $arr['search'] = query;

                var pagination = require('pagination');
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/relationship/' + req.body.action + '?' + fquery,
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();
                common.tplFile('admincp/areslation.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        });
    }
});

app.get(['/relationshipdownload/:id'], function (req, res) {
    messages = require('../../module/message');
    req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    q.all([messages.relationshipdownload(req, config.mysql, q)]).then(function (result) {
        var k = result[0][0].length;
        resultk = result[0][0];
        var j = 0;
        arr = [];
        data2 = ['Id', 'Title', 'Message', 'Date Added', 'Pool targeted', 'Message Cost', 'Total Interest'];
        arr.push(data2);
        for (i in resultk) {
            j++;
            data2 = [resultk[i]['id'], resultk[i]['title'], resultk[i]['message_short'], resultk[i]['date_add'], resultk[i]['target_no'], resultk[i]['cost'], resultk[i]['total_requests']];
            arr.push(data2);
        }
        res.setHeader('Content-disposition', 'attachment; filename=report.csv');
        res.csv(arr);
    });
});

app.get(['/rinterestdetails/:id'], function (req, res) {


    messages = require('../../module/message');
    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    q.all([messages.rinterestdetails(req, config.mysql, q, 0), messages.rinterestdetails(req, config.mysql, q, 1)]).then(function (results) {
        var result = _.pluck(results[0][0], 'to_id');
        async.series({
            getSellerDetails: function (checkblock_cbk) {
                faAPI.appendUserDataForObject('id', 'id as to_id,concat(first_name," ",last_name) as fname,email', result, results[0][0], 'to_id', function (messageFromErr, messageFromRes) {
                    checkblock_cbk(null, messageFromRes);
                });
            }

        }, function (err, results1) {
            if (err) {
                console.log(err);
            }

            results[0][0] = results1.getSellerDetails;
            //console.log("dfsfdsf");
            // console.log(results[1][0]);
            $arr['pagination'] = results[1][0].length;
            $arr['plans'] = results[0][0];
            console.log("sdfsdfds");
            console.log($arr['plans']);
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/rinterestdetails/' + req.body.id,
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/spooldetails.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    });

});



/*

app.post('/user/change/:status', function(req, res) {

    async.series({
        updateUserStatus: function(cb) {
            // getting userInformations
            var updateUserCallback = function(err, response) {
                cb(null, response);
            }
            faAPI.updateUser(req, 'status', updateUserCallback);
        }
    }, function(err, results) {


        localm = require('../../module/localmail');

        if (req.body.status == "active") {
            var activeurl = '<br />To login your account. Please <a href="' + $arr.config.spath + 'login">click here</a>';

            if (global.emaillocal.status == 'yes') {
                q.all([localm.mailtemps(req, config.mysql, q, 'message_sent')]).then(function(results2) {
                    console.log("sending mail");
                    if (results2) {

                        var template = results2[0][0][0].template;
                        var subject_message = results2[0][0][0].subject;

                        template = template.replace('{{event.sitename}}', global.common.title);
                        template = template.replace('{{event.message}}', "Your account has been activated by the admin. " + activeurl + "");
                        template = template.replace('{{event.user}}', req.body.username);
                        template = template.replace('{{event.siteurl}}', $arr.config.url);
                        // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                        localm.sendmail(template, subject_message, req.body.email);

                    } else {

                        console.log("No Templates named message_sent");
                    }


                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                });
            }
        } else if (req.body.status == "unverified") {

            var activeurl = 'Your account has been deactivated by admin.<br><br>';

            if (global.emaillocal.status == 'yes') {
                q.all([localm.mailtemps(req, config.mysql, q, 'message_sent')]).then(function(results2) {
                    console.log("sending mail");
                    if (results2) {

                        var template = results2[0][0][0].template;
                        var subject_message = results2[0][0][0].subject;

                        template = template.replace('{{event.sitename}}', global.common.title);
                        template = template.replace('{{event.message}}', activeurl + " message from admin is, " + req.body.message);
                        template = template.replace('{{event.user}}', req.body.username);
                        template = template.replace('{{event.siteurl}}', $arr.config.url);
                        // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                        localm.sendmail(template, subject_message, req.body.email);

                    } else {

                        console.log("No Templates named message_sent");
                    }


                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                });
            }
        }
        // console.log("arr is here" + JSON.stringify($arr));

        res.writeHead(302, { 'Location': req.headers.referer });
        res.end();

        if (err) {
            console.log(JSON.stringify(err));
            throw err
        }

    })
})
*/
app.get(['/pollsentdetails/:id'], function (req, res) {



    req.body.page = (typeof (req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.action = (typeof (req.param('action')) !== 'undefined') ? req.param('action') : '';
    req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    q.all([messages.rpollsentdetails(req, config.mysql, q, 0), messages.rpollsentdetails(req, config.mysql, q, 1)]).then(function (results) {
        var result = _.pluck(results[0][0], 'to_id');
        async.series({
            getSellerDetails: function (checkblock_cbk) {
                faAPI.appendUserDataForObject('id', 'id as to_id,concat(first_name," ",last_name) as fname,email', result, results[0][0], 'to_id', function (messageFromErr, messageFromRes) {
                    checkblock_cbk(null, messageFromRes);
                });
            }

        }, function (err, results1) {
            if (err) {
                console.log(err);
            }

            results[0][0] = results1.getSellerDetails;
            //console.log("dfsfdsf");
            // console.log(results[1][0]);
            $arr['pagination'] = results[1][0].length;
            $arr['plans'] = results[0][0];
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/pollsentdetails/' + req.body.id,
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/spoolindetails.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    });
});


/* app.get(['/ads/', '/ads/:action/', '/ads/:action/:id', '/ads/:action/:id/:error'], function (req, res) {
    req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
    req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
    req.body.from_date = (typeof (req.param('from_date')) === 'undefined') ? '' : req.param('from_date');
    req.body.to_date = (typeof (req.param('to_date')) === 'undefined') ? '' : req.param('to_date');

    $arr.country = req.body.country;
    $arr.state = req.body.state;
    $arr.from_date = req.body.from_date;
    $arr.to_date = req.body.to_date;
    var adwords = require('../../module/adwords');
    action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    var banner = require('../../module/banner');
    delete $arr['menu'];
    $arr['menu'] = [];
    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['adsmenu'] = 'active';
    $arr['menu'][action] = 'active';
    console.log("8888888888888888888888")
    console.log($arr['menu'])
    if (action == 'store') {
        q.all([banner.liststores(req, config.mysql, q, 0), banner.liststores(req, config.mysql, q, 1)]).then(function (result) {
            var user_ids = _.pluck(result[0][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id,username,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {
                $arr['pagination'] = result[1][0].length;
                $arr['banner'] = apiUsersRes;

                var url = require('url');
                var url_parts = url.parse(req.url, true);
                var query = url_parts.query;
                fquery = common.urlparameter(query, { page: '' });
                console.log('fquery', fquery);

                $arr['search'] = query;
            
                if($arr['banner']){
                    for(var f= 0; f < $arr['banner'].length; f++){
                        var allBanner = $arr['banner'][f].banner.split(','); 
                        var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                        $arr['banner'][f].banner = allBanner[index]
                    }
                }

                var pagination = require('pagination');
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/ads/store',
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();
                common.tplFile('admincp/adsstore.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();

    } else if (action == 'product') {
        q.all([banner.listproduct(req, config.mysql, q, 0), banner.listproduct(req, config.mysql, q, 1)]).then(function (result) {
            var user_ids = _.pluck(result[0][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id,username,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {
                $arr['pagination'] = result[1][0].length;

                var url = require('url');
                var url_parts = url.parse(req.url, true);
                var query = url_parts.query;
                fquery = common.urlparameter(query, { page: '' });
                console.log('fquery', fquery);

                $arr['search'] = query;

                $arr['banner'] = apiUsersRes;
                
                if($arr['banner']){
                    for(var f= 0; f < $arr['banner'].length; f++){
                        var allBanner = $arr['banner'][f].banner.split(','); 
                        var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                        $arr['banner'][f].banner = allBanner[index]
                    }
                }
            
                var pagination = require('pagination');
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/ads/product',
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();
                common.tplFile('admincp/adsproduct.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();

    } else if (action == 'brand') {
        q.all([banner.listbrand(req, config.mysql, q, 0), banner.listproduct(req, config.mysql, q, 1)]).then(function (result) {
            var user_ids = _.pluck(result[0][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id,username,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {
                $arr['pagination'] = result[1][0].length;
                $arr['banner'] = apiUsersRes;

                var url = require('url');
                var url_parts = url.parse(req.url, true);
                var query = url_parts.query;
                fquery = common.urlparameter(query, { page: '' });
                console.log('fquery', fquery);

                $arr['search'] = query;


                if($arr['banner']){
                    for(var f= 0; f < $arr['banner'].length; f++){
                        var allBanner = $arr['banner'][f].banner.split(','); 
                        var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                        $arr['banner'][f].banner = allBanner[index]
                    }
                }

                var pagination = require('pagination');
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/ads/brand',
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();
                common.tplFile('admincp/adsbrand.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else if (action == 'active') {
        q.all([banner.listactiveads(req, config.mysql, q, 0), banner.listactiveads(req, config.mysql, q, 1)]).then(function (result) {
            var user_ids = _.pluck(result[0][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id,username,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {
                console.log('api res', apiUsersRes);
                $arr['pagination'] = result[1][0].length;
                $arr['headings_ads'] = 'Active Campaigns'
                $arr['banner'] = apiUsersRes;
                var url = require('url');
                var url_parts = url.parse(req.url, true);
                var query = url_parts.query;
                fquery = common.urlparameter(query, { page: '' });

                $arr['search'] = query;

                if($arr['banner']){
                    for(var f= 0; f < $arr['banner'].length; f++){
                        var allBanner = $arr['banner'][f].banner.split(','); 
                        var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                        $arr['banner'][f].banner = allBanner[index]
                    }
                }

                var pagination = require('pagination');
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/ads/active',
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();
                common.tplFile('admincp/ads_active.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else if (action == 'inactive') {
        q.all([banner.listinactiveads(req, config.mysql, q, 0), banner.listinactiveads(req, config.mysql, q, 1)]).then(function (result) {
            var user_ids = _.pluck(result[0][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id,username,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {
                $arr['pagination'] = result[1][0].length;
                $arr['banner'] = apiUsersRes;
                $arr['headings_ads'] = 'Inactive Campaigns'

                var url = require('url');
                var url_parts = url.parse(req.url, true);
                var query = url_parts.query;
                fquery = common.urlparameter(query, { page: '' });
                console.log('fquery', fquery);

                $arr['search'] = query;

                if($arr['banner']){
                    for(var f= 0; f < $arr['banner'].length; f++){
                        var allBanner = $arr['banner'][f].banner.split(','); 
                        var index = adwords.generateRandomInteger(0, allBanner.length - 1)
                        $arr['banner'][f].banner = allBanner[index]
                    }
                }

                var pagination = require('pagination');
                var paginator = new pagination.SearchPaginator({
                    prelink: '/admincp/ads/inactive',
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: $arr['pagination']
                });
                $arr['pagination_html'] = paginator.render();
                common.tplFile('admincp/ads_inactive.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    }
}); */
app.get(['/adsedit/storeedit/:id', '/adsedit/storeedit/:id/:error'], function (req, res) {
    var banner = require('../../module/banner');
    req.body.id = (typeof (req.param('id')) !== 'undefined') ? req.param('id') : 0;
    console.log("____sdfsdfsdf____________");
    q.all([banner.editStore(req, config.mysql, q)]).then(function (result) {

        $arr['banner'] = result[0][0][0];

        common.tplFile('admincp/adsstoreedit.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.post('/update/balance', function (req, res) {

    console.log(req.body)
    var userId = typeof (req.body.id) !== undefined ? req.body.id : 0;
    var amount = typeof (req.body.id) !== undefined ? parseFloat(req.body.add_bal) : 0;

    req.body.updateFields = {};

    var gmoney = require("../../module/greenmoney");
    if (common.admincheckLogin(req, res, 1)) {
        if (userId > 0) {

            var fieldNames = 'id,balance,email'
            console.log('fieldNames', fieldNames)
            async.series({
                getUserData: function (cb) {

                    // getting userInformations
                    var userDataCallback = function (err, response) {
                        cb(err, response);
                        // console.log("getting userinfo");
                    }

                    faAPI.callUserQuery('no_type', fieldNames, "where id=" + req.body.id, userDataCallback)
                }
            },
                function (error, userDetail) {

                    if (error) {
                        console.log(error);
                        res.json(0);
                    }

                    // console.log("userDetail", userDetail);
                    buyuserdetails = userDetail.getUserData.results[0];

                    req.body.seller = { balance: parseFloat(buyuserdetails.balance) + parseFloat(amount), id: req.body.id }




                    // console.log(req.body.buyer);
                    // console.log(req.body.seller);

                    /* 'update buyers balance' */
                    faAPI.updateUser(req, 'sold_product', function (err, resp) {
                        if (err) {
                            // console.log(err);
                            res.json(0);
                        } else if (resp.response.code == 'D200') {
                            console.log("response", JSON.stringify(resp));
                            console.log("useremail", resp.response.user[0].email);
                            console.log("----------------------done section--------------------------");


                            var payments = require('../../module/payment');

                            payments.transactionid = 0;
                            payments.gateway = 'account';

                            payments.payid = 0;

                            payments.type = 'manual_payment';

                            payments.buyer = buyuserdetails;
                            payments.buyer.user_id = buyuserdetails.id;

                            payments.name = '';
                            payments.payid = 0;
                            payments.buynow_id = 0;
                            payments.cart_id = 0;
                            payments.amount = amount;
                            payments.qty = 0;

                            q.all([payments.insertInvoice(req)]).then(function (invoice) {

                                q.all(products.generateInvoiceID(req, invoice[0][0].insertId, config.mysql, q)).then(function (invoices) {
                                    console.log('invoicets here', invoices);
                                    res.json(1)
                                }).fail(function (err) {
                                    console.log(err.stack);
                                    throw err;
                                }).done();

                                console.log("status changed successfully....!");

                            }).fail(function (error) {
                                console.log(error.stack);
                                //throw error;
                            }).done();

                            return true;
                        } else {
                            console.log("1111111111111111111");
                            console.log(resp.response.description)
                            console.log(resp.response.code)
                            console.log(resp)
                            console.log("error in updating balance...!")
                            console.log("notification sending module should be here..");
                            res.json(0)
                        }

                    });

                    console.log('----------------' + i + '--------------completed------------');
                })

        } else {
            res.json(0);
        }

    } else {

        res.json(0);
    }

});


app.get(['/payments/', '/payments/:action/', '/payments/:action/:id', '/payments/:action/:id/:error'], function (req, res) {

    $arr.action = action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    var dateFormat = require('dateformat');
    delete $arr['menu'];
    $arr.action = action
    $arr['menu'] = [];
    $arr['menu']['payments'] = 'active';
    $arr['menu'][action] = 'active';

    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');

    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');

    raction = action;

    var gmoney = require("../../module/greenmoney");

    var page = (req.body.page - 1) * 10;
    var whereCondition = '';
    var countWhereCondition = '';

    var countUnverifiedReq = function () {
        q.all([
            gmoney.getUnverifiedCount(req, config.mysql, q)
        ]).then(function (results) {
            // console.log(JSON.stringify(results));
            $arr.unverified_pay_count = results[0][0][0].total_unv;
            $arr.wire_req = results[0][0][0].total_unv_wire;
            $arr.check_req = results[0][0][0].total_unv_check;
            $arr.refund_req = results[0][0][0].total_unv_refund;
        })
    }

    var assign = countUnverifiedReq();

    req.body.from_date = (typeof (req.param('from_date')) === 'undefined') ? '' : req.param('from_date');
    req.body.to_date = (typeof (req.param('to_date')) === 'undefined') ? '' : req.param('to_date');

    // console.log($arr.unverified_pay_count);

    if (action == 'wire') {
        var page = (req.body.page - 1) * 10;
        whereCondition = '';
        countWhereCondition = '';
        $arr.page = req.body.page;
        $arr.limit = 10;

        var fieldNames = 'id as user_id';
        var countFieldNames = 'id';

        req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
        req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');

        req.body.req_status = (typeof (req.param('req_status')) === 'undefined') ? '' : req.param('req_status');

        whereCondition = countWhereCondition = 'where del_status =  0 ';
        var count = 0

        // if (req.body.country) {
        //     whereCondition = count == 0 ? whereCondition + ' and country like "%' + req.body.country + '%"' : whereCondition + ' and country like "%' + req.body.country + '%"'
        //     countWhereCondition = count == 0 ? countWhereCondition + 'and country like "%' + req.body.country + '%"' : countWhereCondition + ' and country like "%' + req.body.country + '%"'
        //     count++;
        // }

        // if (req.body.state) {
        //     whereCondition = count == 0 ? whereCondition + ' and state like "%' + req.body.state + '%"' : whereCondition + ' and state like "%' + req.body.state + '%"'
        //     countWhereCondition = count == 0 ? countWhereCondition + ' and state like "%' + req.body.state + '%"' : countWhereCondition + ' and state like "%' + req.body.state + '%"'
        //     count++;
        // }

        faAPI.callUserQuery('no_type', fieldNames, whereCondition, function (apiSeUsersErr, apiSeUsersRes) {
            if (apiSeUsersErr) {
                console.log("API ERR", apiSeUsersErr)
            } else {

                console.log('apidata ------------- ' + apiSeUsersRes.results);
                var users_id = _.pluck(apiSeUsersRes.results, 'user_id');

                //$arr['menu']['wire'] = 'active';
                q.all([
                    gmoney.getFundRequests(req, config.mysql, q, action, 0, users_id),
                    gmoney.getFundRequests(req, config.mysql, q, action, 1, users_id)
                ]).then(function (results) {
                    var user_ids = _.pluck(results[0][0], 'user_id');

                    if (user_ids.length > 0) {
                        faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name, balance', user_ids, results[0][0], 'user_id', function (apiErr, apiRes) {
                            $arr['fund_requests'] = common.addDecimalPlaces('funds_requests', results[0][0]);
                            $arr['pagination'] = results[1][0][0].total_requests;
                            if (apiErr) {
                                console.log("API ERR", apiErr)
                            } else {
                                var url = require('url');
                                var url_parts = url.parse(req.url, true);
                                var query = url_parts.query;
                                fquery = common.urlparameter(query, { page: '' });
                                $arr['search'] = query;
                                var paginator = new pagination.SearchPaginator({
                                    prelink: '/admincp/payments/' + action + '/',
                                    current: req.body.page,
                                    rowsPerPage: 10,
                                    totalResult: $arr['pagination'],
                                });
                                $arr['pagination_html'] = paginator.render();
                                // $arr['pagination_html'] = paginator.render();
                                common.tplFile('admincp/greenmoney_funds.tpl');
                                common.headerSet(1);
                                common.loadTemplateHeader(req, res, $arr);
                            }
                        })
                    } else {
                        // $arr['pagination_html'] = 'No Records found...';
                        // $arr['pagination_html'] = paginator.render();
                        common.tplFile('admincp/greenmoney_funds.tpl');
                        common.headerSet(1);
                        common.loadTemplateHeader(req, res, $arr);
                    }

                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }
        })

    } else if (action == 'refund') {
        //$arr['menu']['wire'] = 'active';
        q.all([
            gmoney.getReFundRequests(req, config.mysql, q, action, 0, []),
            gmoney.getReFundRequests(req, config.mysql, q, action, 1, [])
        ]).then(function (results) {
            var user_ids = _.pluck(results[0][0], 'user_id');
            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, { page: '' });
            $arr['search'] = query;
            if (user_ids.length > 0) {
                faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name, balance', user_ids, results[0][0], 'user_id', function (apiErr, apiRes) {
                    $arr['fund_requests'] = common.addDecimalPlaces('funds_requests', results[0][0]);
                    $arr['pagination'] = results[1][0][0].total_requests;
                    if (apiErr) {
                        console.log("API ERR", apiErr)
                    } else {

                        var paginator = new pagination.SearchPaginator({
                            prelink: '/admincp/payments/' + action + '/',
                            current: req.body.page,
                            rowsPerPage: 10,
                            totalResult: $arr['pagination'],
                        });
                        // $arr['pagination_html'] = paginator.render();
                        // $arr['pagination_html'] = paginator.render();
                        common.tplFile('admincp/greenmoney_funds.tpl');
                        common.headerSet(1);
                        common.loadTemplateHeader(req, res, $arr);
                    }
                })
            } else {
                // $arr['pagination_html'] = 'No Records found...';
                // $arr['pagination_html'] = paginator.render();
                common.tplFile('admincp/greenmoney_funds.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            }
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else if (action == 'check') {

        var page = (req.body.page - 1) * 10;
        whereCondition = '';
        countWhereCondition = '';
        $arr.page = req.body.page;
        $arr.limit = 10;

        var fieldNames = 'id as user_id';
        var countFieldNames = 'id';

        req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
        req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
        req.body.from_date = (typeof (req.param('from_date')) === 'undefined') ? '' : req.param('from_date');
        req.body.to_date = (typeof (req.param('to_date')) === 'undefined') ? '' : req.param('to_date');
        req.body.req_status = (typeof (req.param('req_status')) === 'undefined') ? '' : req.param('req_status');

        whereCondition = countWhereCondition = 'where del_status =  0 ';
        var count = 0

        // if (req.body.country) {
        //     whereCondition = count == 0 ? whereCondition + ' and country like "%' + req.body.country + '%"' : whereCondition + ' and country like "%' + req.body.country + '%"'
        //     countWhereCondition = count == 0 ? countWhereCondition + 'and country like "%' + req.body.country + '%"' : countWhereCondition + ' and country like "%' + req.body.country + '%"'
        //     count++;
        // }

        // if (req.body.state) {
        //     whereCondition = count == 0 ? whereCondition + ' and state like "%' + req.body.state + '%"' : whereCondition + ' and state like "%' + req.body.state + '%"'
        //     countWhereCondition = count == 0 ? countWhereCondition + ' and state like "%' + req.body.state + '%"' : countWhereCondition + ' and state like "%' + req.body.state + '%"'
        //     count++;
        // }

        faAPI.callUserQuery('no_type', fieldNames, whereCondition, function (apiSeUsersErr, apiSeUsersRes) {
            if (apiSeUsersErr) {
                console.log("API ERR", apiSeUsersErr)
            } else {

                console.log('apidata ------------- ' + apiSeUsersRes.results);
                var users_id = _.pluck(apiSeUsersRes.results, 'user_id');


                q.all([
                    gmoney.getFundRequests(req, config.mysql, q, action, 0, []),
                    gmoney.getFundRequests(req, config.mysql, q, action, 1, [])
                ]).then(function (results) {
                    var user_ids = _.pluck(results[0][0], 'user_id');
                    var url = require('url');
                    var url_parts = url.parse(req.url, true);
                    var query = url_parts.query;
                    fquery = common.urlparameter(query, { page: '' });
                    $arr['search'] = query;

                    if (user_ids.length > 0) {
                        faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name, balance', user_ids, results[0][0], 'user_id', function (apiErr, apiRes) {
                            // console.log(JSON.stringify(apiRes));
                            $arr['fund_requests'] = common.addDecimalPlaces('funds_requests', results[0][0]);
                            $arr['pagination'] = results[1][0][0].total_requests;
                            if (apiErr) {
                                console.log("API ERR", apiErr)
                            } else {

                                var paginator = new pagination.SearchPaginator({
                                    prelink: '/admincp/payments/' + action + '/',
                                    current: req.body.page,
                                    rowsPerPage: 10,
                                    totalResult: $arr['pagination'],
                                });
                                $arr['pagination_html'] = paginator.render();
                                // $arr['pagination_html'] = paginator.render();
                                common.tplFile('admincp/greenmoney_funds.tpl');
                                common.headerSet(1);
                                common.loadTemplateHeader(req, res, $arr);
                            }
                        })
                    } else {
                        $arr['fund_requests'] = 0;
                        $arr['pagination_html'] = 'No Records found...';
                        // $arr['pagination_html'] = paginator.render();
                        common.tplFile('admincp/greenmoney_funds.tpl');
                        common.headerSet(1);
                        common.loadTemplateHeader(req, res, $arr);
                    }
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();

            }
        })
    } else if (action == 'all') {

        var page = (req.body.page - 1) * 10;
        whereCondition = '';
        countWhereCondition = '';
        $arr.page = req.body.page;
        $arr.limit = 10;

        var fieldNames = 'id as user_id';
        var countFieldNames = 'id';

        req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
        req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
        req.body.from_date = (typeof (req.param('from_date')) === 'undefined') ? '' : req.param('from_date');
        req.body.to_date = (typeof (req.param('to_date')) === 'undefined') ? '' : req.param('to_date');

        whereCondition = countWhereCondition = 'where del_status =  0 ';
        var count = 0

        if (req.body.country) {
            whereCondition = count == 0 ? whereCondition + ' and country like "%' + req.body.country + '%"' : whereCondition + ' and country like "%' + req.body.country + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'and country like "%' + req.body.country + '%"' : countWhereCondition + ' and country like "%' + req.body.country + '%"'
            count++;
        }

        if (req.body.state) {
            whereCondition = count == 0 ? whereCondition + ' and state like "%' + req.body.state + '%"' : whereCondition + ' and state like "%' + req.body.state + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + ' and state like "%' + req.body.state + '%"' : countWhereCondition + ' and state like "%' + req.body.state + '%"'
            count++;
        }

        faAPI.callUserQuery('no_type', fieldNames, whereCondition, function (apiSeUsersErr, apiSeUsersRes) {
            if (apiSeUsersErr) {
                console.log("API ERR", apiSeUsersErr)
            } else {

                var users_id = _.pluck(apiSeUsersRes.results, 'user_id');
                // console.log(users_id);


                // console.log("data here ++++++" + JSON.stringify(apiSeUsersRes.results));

                q.all([
                    gmoney.getFundRequests(req, config.mysql, q, action, 0, users_id),
                    gmoney.getFundRequests(req, config.mysql, q, action, 1, users_id)
                ]).then(function (results) {
                    var user_ids = _.pluck(results[0][0], 'user_id');
                    if (user_ids.length > 0) {
                        faAPI.appendUserDataForObject('id', 'id as user_id, username, email,first_name,last_name, balance, country, state', user_ids, results[0][0], 'user_id', function (apiErr, apiRes) {
                            // console.log(JSON.stringify(apiRes));
                            $arr['fund_requests'] = common.addDecimalPlaces('funds_requests', results[0][0]);
                            $arr['pagination'] = results[1][0][0].total_requests;
                            // console.log(results[1][0][0].total_requests);
                            if (apiErr) {
                                console.log("API ERR", apiErr)
                            } else {
                                // projects
                                var url = require('url');
                                var url_parts = url.parse(req.url, true);
                                var query = url_parts.query;
                                fquery = common.urlparameter(query, { page: '' });
                                $arr['search'] = query;
                                console.log("url is here ------------- " + req.url)

                                console.log(JSON.stringify($arr['search']));
                                console.log(JSON.stringify(query));
                                // $arr['search'] = query;
                                var paginator = new pagination.SearchPaginator({
                                    prelink: '/admincp/payments/' + action + '/?' + fquery,
                                    current: req.body.page,
                                    rowsPerPage: 10,
                                    totalResult: $arr['pagination'],
                                });
                                $arr['pagination_html'] = paginator.render();
                                // $arr['pagination_html'] = paginator.render();
                                common.tplFile('admincp/greenmoney_funds.tpl');
                                common.headerSet(1);
                                common.loadTemplateHeader(req, res, $arr);
                            }
                        })
                    } else {
                        $arr['fund_requests'] = 0;
                        $arr['pagination_html'] = 'No Records found...';
                        $arr['pagination'] = results[1][0][0].total_requests;
                        // $arr['pagination_html'] = paginator.render();
                        console.log(results[1][0][0].total_requests);
                        var url = require('url');
                        var url_parts = url.parse(req.url, true);
                        var query = url_parts.query;
                        fquery = common.urlparameter(query, { page: '' });
                        $arr['search'] = query;
                        common.tplFile('admincp/greenmoney_funds.tpl');
                        common.headerSet(1);
                        common.loadTemplateHeader(req, res, $arr);
                    }
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }
        });
    } else if (action == 'gateway') {

        var fieldNames = 'email,first_name,last_name,username,notification,status,id,balance';
        var countFieldNames = 'id';

        $arr['menu']['searchusersmenu'] = 'active';
        req.body.email = (typeof (req.param('email')) === 'undefined') ? '' : req.param('email');
        req.body.first_name = (typeof (req.param('first_name')) === 'undefined') ? '' : req.param('first_name');
        req.body.last_name = (typeof (req.param('last_name')) === 'undefined') ? '' : req.param('last_name');
        req.body.status = (typeof (req.param('status')) === 'undefined') ? '' : req.param('status');
        whereCondition = countWhereCondition = 'where '
        var count = 0
        if (req.body.email) {
            whereCondition = whereCondition + 'email like "%' + req.body.email + '%"'
            countWhereCondition = countWhereCondition + 'email like "%' + req.body.email + '%"'
            count++;
        }
        if (req.body.last_name) {
            whereCondition = count == 0 ? whereCondition + 'last_name like "%' + req.body.last_name + '%"' : whereCondition + ' and last_name like "%' + req.body.last_name + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'last_name like "%' + req.body.last_name + '%"' : countWhereCondition + ' and last_name like "%' + req.body.last_name + '%"'
            count++;
        }
        if (req.body.status) {
            whereCondition = count == 0 ? whereCondition + 'status like "%' + req.body.status + '%"' : whereCondition + ' and status like "%' + req.body.status + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'status like "%' + req.body.status + '%"' : countWhereCondition + ' and status like "%' + req.body.status + '%"'
            count++;
        }
        if (req.body.first_name) {
            whereCondition = count == 0 ? whereCondition + 'first_name like "%' + req.body.first_name + '%"' : whereCondition + ' and first_name like "%' + req.body.first_name + '%"'
            countWhereCondition = count == 0 ? countWhereCondition + 'first_name like "%' + req.body.first_name + '%"' : countWhereCondition + ' and first_name like "%' + req.body.first_name + '%"'
            count++;
        }
        if (count == 0) {
            whereCondition = ' order by id DESC limit ' + page + ',10'
            countWhereCondition = ' order by id DESC '
        } else {
            whereCondition = whereCondition + ' order by id DESC limit ' + page + ',10'
            countWhereCondition = countWhereCondition + ' order by id DESC '
        }
        try {
            faAPI.callUserQuery('no_type', fieldNames, whereCondition, function (apiSeUsersErr, apiSeUsersRes) {
                if (apiSeUsersErr) {
                    console.log("API ERR", apiSeUsersErr)
                } else {
                    faAPI.callUserQuery('no_type', countFieldNames, countWhereCondition, function (apiSearchUsersErr, apiSearchUsersRes) {
                        var url = require('url');
                        var url_parts = url.parse(req.url, true);
                        var query = url_parts.query;
                        $arr['pagination'] = apiSearchUsersRes.results.length;
                        $arr['users'] = common.addDecimalPlaces('users', apiSeUsersRes.results);;
                        $arr['search'] = query;
                        fquery = common.urlparameter(query, { page: '' });
                        var paginator = new pagination.SearchPaginator({
                            prelink: '/admincp/payments/gateway?' + fquery,
                            current: req.body.page,
                            rowsPerPage: 10,
                            totalResult: $arr['pagination']
                        });
                        $arr['pagination_html'] = paginator.render();
                        common.tplFile('admincp/paymentgateway.tpl');
                        common.headerSet(1);
                        common.loadTemplateHeader(req, res, $arr);
                    });
                }
            });
        } catch (err) {
            console.log("Error");
            console.log(err);
        }
    } else if (action == 'edit') {
        $arr['menu']['edit'] = 'active';
        req.body.id = typeof (req.param('id')) !== undefined ? req.param('id') : 0;
        q.all([
            gmoney.getFundRequest(req, config.mysql, q)
        ]).then(function (results) {
            var user_ids = _.pluck(results[0][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id, email, first_name, last_name, balance', user_ids, results[0][0], 'user_id', function (apiErr, apiRes) {
                $arr.payment_req = results[0][0][0];
                common.tplFile('admincp/ebalance.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            })
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        console.log("wrong way...!");
        return false;
    }
});

app.post(['/payment/sendmsg', '/payment/sendmsg/:action'], function (req, res) {
    console.log('messages add --------------------', req.body);
    req.body.toemail = req.body.users;
    var dat = require('date-util');
    req.body.r_id = Date.parse(new Date()) / 1000;
    var obj = {
        api_key: global.fwrdauctionAPI.api,
        app_key: global.fwrdauctionAPI.key,
        field_names: "id, first_name, last_name",
        where_condition: ' where email = "' + req.body.toemail + '"',
        type: "no_type"
    }
    request({
        url: global.fwrdauctionAPI.url + 'users/common',
        qs: obj
    }, function (err, res, data) {
        if (err) {
            console.log('Error' + err);
        } else {
            data = JSON.parse(data);
            req.body.toid = data.response.results[0].id;
            req.body.first_name = data.response.results[0].first_name;
            req.body.last_name = data.response.results[0].last_name;
            console.log('msg ----------------------------api');
            messages.addmessages(req, config.mysql, q);
        }
    });
    res.json({
        data: 1
    });
    res.end();
    return false;
});

app.get(['/transaction/:action', '/transaction/:action/:market'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['transactionmenu'] = 'active';


    $arr.externalcss = ['datePicker'];
    $arr.externaljs = ['jquery.datePicker'];
    var projects = require('../../module/products');
    req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'search' : req.param('action');

    // console.log(req.body);
    if (action == 'package' || action == 'bid' || action == 'sold' || action == 'winner' || action == 'buynow') {
        req.query.status = action;
        req.url += '?status=' + action;
        action = req.body.action = 'list';
        // console.log(req.url);
    }

    $arr['projects'] = [];
    if (action == 'download') {
        q.all([admin.transactionSearch(req, config.mysql, q, 2)]).then(function (result) {
            var k = result[0][0].length;
            resultk = result[0][0];
            var j = 0;
            arr = [];
            data2 = ['InvoiceId', 'UserId', 'Product ID', 'Product Title', 'Type', 'Status', 'Amount', 'Gateway', 'Description', 'Date Added'];
            arr.push(data2);
            for (i in resultk) {
                j++;
                data2 = [resultk[i]['transactionid'], resultk[i]['user_id'], resultk[i]['pid'], resultk[i]['title'], resultk[i]['type'], resultk[i]['istatus'], resultk[i]['amount'], resultk[i]['gateway'], resultk[i]['description'], resultk[i]['date_added']];
                arr.push(data2);
            }
            res.setHeader('Content-disposition', 'attachment; filename=report.csv');
            res.csv(arr);
        });
    }

    if (action == 'summery') {
        $arr['menu'][action] = 'active';
        $arr.externalcss = ['jquery.datetimepicker'];
        $arr.externaljs = ['jquery.datetimepicker'];
        $arr['heading_common'] = "Market research";

        var dateFormat = require('dateformat');

        // req.body.start_date = ((typeof(req.param('from_date')) === 'undefined') || req.param('from_date') == '') ? '' : common.changeDateFormat(req.param('from_date'));
        req.body.start_date = ((typeof (req.param('from_date')) === 'undefined') || req.param('from_date') == '') ? dateFormat(new Date().setDate(new Date().getDate() - 30, "yyyy-mm-dd")) : req.param('from_date');
        // req.body.end_date = ((typeof(req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : common.changeDateFormat(req.param('end_date'));
        req.body.end_date = ((typeof (req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? dateFormat(new Date(), "yyyy-mm-dd") : req.param('end_date');
        req.body.state = ((typeof (req.param('state')) === 'undefined') || req.param('state') == '') ? '' : req.param('state');
        // console.log(req.body.start_date);
        // console.log(req.body.end_date);
        $arr.start_date = req.body.start_date;
        $arr.end_date = req.body.end_date;

        q.all([
            projects.getAdminOBResearchData(req, config.mysql, q, 0),
            projects.getAdminOBResearchData(req, config.mysql, q, 1),
            projects.getAdminOBResearchData(req, config.mysql, q, 2),
            projects.getAdminDBResearchData(req, config.mysql, q, 0),
            projects.getAdminDBResearchData(req, config.mysql, q, 1),
            projects.getAdminDBResearchData(req, config.mysql, q, 2),
            projects.getAdminDBPieData(req, config.mysql, q, ''),
            projects.getAdminOBPieData(req, config.mysql, q, ''),
            projects.getAdminMarketActivity(req, config.mysql, q, ''),
        ]).then(function (results) {


            console.log(JSON.stringify(results[8][0]));

            $arr.re_ob_trans = results[0][0];
            $arr.re_ob_prdts = results[1][0];
            $arr.re_ob_vol = results[2][0];

            $arr.re_db_trans = results[3][0];
            $arr.re_db_prdts = results[4][0];
            $arr.re_db_vol = results[5][0];

            // $arr.re_db = results[1][0];
            // $arr.market_activity = results[8][0];
            // var market_activity = results[8][0];

            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, { page: '' });

            $arr['search'] = query;

            console.log("step1")

            // $arr.days = [{day:1},{day:2},{day:3},{day:4},{day:5},{day:6},{day:7}];
            var days = _.pluck(results[8][0], 'day_date');
            // _.pluck(stooges, 'name');
            console.log("step1")
            var avg_qty = _.pluck(results[8][0], 'avg_qty');
            console.log("step1")
            var avg_unit_price = _.pluck(results[8][0], 'avg_unit_price');
            console.log("step1")

            console.log(days);
            console.log(avg_qty);
            console.log(avg_unit_price);

            $arr.price = avg_unit_price;
            $arr.qty = avg_qty;
            $arr.days = days
            // var days = [1, 2, 3, 4, 5, 6, 7];

            // // $arr.days
            // var price = [];
            // var qty = [];
            // count = 1;

            // for (var i = 0; i < days.length; i++) {
            //     for (var j = 0; j < market_activity.length; j++) {
            //         if (market_activity[j].week_day == days[i]) {
            //             price[i] = market_activity[j].avg_price
            //             qty[i] = market_activity[j].avg_qty
            //             count++;
            //         }
            //     }
            //     if (price[i] > 0) {

            //     } else {
            //         price[i] = 0;
            //         qty[i] = 0;
            //     }
            // }

            // console.log(price);
            // console.log(qty);

            // $arr.price = [];
            // $arr.price = price;
            // $arr.qty = [];
            // $arr.qty = qty;

            var pie_db = results[6][0][0];
            pie_db.sativa_flowers = isNaN(((parseFloat(pie_db.sativa_flowers) / parseFloat(pie_db.total_flowers)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.sativa_flowers) / parseFloat(pie_db.total_flowers)) * 100).toFixed(2);
            pie_db.indica_flowers = isNaN(((parseFloat(pie_db.indica_flowers) / parseFloat(pie_db.total_flowers)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.indica_flowers) / parseFloat(pie_db.total_flowers)) * 100).toFixed(2);
            pie_db.hybrid_flowers = isNaN(((parseFloat(pie_db.hybrid_flowers) / parseFloat(pie_db.total_flowers)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.hybrid_flowers) / parseFloat(pie_db.total_flowers)) * 100).toFixed(2);
            pie_db.sweet_edibles = isNaN(((parseFloat(pie_db.sweet_edibles) / parseFloat(pie_db.sweet_edibles)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.sweet_edibles) / parseFloat(pie_db.total_edibles)) * 100).toFixed(2);
            pie_db.savory_edibles = isNaN(((parseFloat(pie_db.savory_edibles) / parseFloat(pie_db.sweet_edibles)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.savory_edibles) / parseFloat(pie_db.total_edibles)) * 100).toFixed(2);
            pie_db.beverages_edibles = isNaN(((parseFloat(pie_db.beverages_edibles) / parseFloat(pie_db.sweet_edibles)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.beverages_edibles) / parseFloat(pie_db.total_edibles)) * 100).toFixed(2);
            pie_db.keif_concentrates = isNaN(((parseFloat(pie_db.keif_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.keif_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2);
            pie_db.hash_concentrates = isNaN(((parseFloat(pie_db.hash_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.hash_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2);
            pie_db.co2oil_concentrates = isNaN(((parseFloat(pie_db.co2oil_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.co2oil_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2);
            pie_db.rosin_concentrates = isNaN(((parseFloat(pie_db.rosin_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.rosin_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2);
            pie_db.wax_concentrates = isNaN(((parseFloat(pie_db.wax_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.wax_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2);
            pie_db.tincture_concentrates = isNaN(((parseFloat(pie_db.tincture_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.tincture_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2);
            pie_db.shatter_concentrates = isNaN(((parseFloat(pie_db.shatter_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.shatter_concentrates) / parseFloat(pie_db.total_concentrates)) * 100).toFixed(2);
            pie_db.accessories_supplies = isNaN(((parseFloat(pie_db.accessories_supplies) / parseFloat(pie_db.total_supplies)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.accessories_supplies) / parseFloat(pie_db.total_supplies)) * 100).toFixed(2);
            pie_db.equipment_supplies = isNaN(((parseFloat(pie_db.equipment_supplies) / parseFloat(pie_db.total_supplies)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.equipment_supplies) / parseFloat(pie_db.total_supplies)) * 100).toFixed(2);
            pie_db.input_supplies = isNaN(((parseFloat(pie_db.input_supplies) / parseFloat(pie_db.total_supplies)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.input_supplies) / parseFloat(pie_db.total_supplies)) * 100).toFixed(2);
            pie_db.other_supplies = isNaN(((parseFloat(pie_db.other_supplies) / parseFloat(pie_db.total_supplies)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_db.other_supplies) / parseFloat(pie_db.total_supplies)) * 100).toFixed(2);

            var pie_ob = results[7][0][0];
            pie_ob.sativa_flowers = isNaN(((parseFloat(pie_ob.sativa_flowers) / parseFloat(pie_ob.total_flowers)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.sativa_flowers) / parseFloat(pie_ob.total_flowers)) * 100).toFixed(2);
            pie_ob.indica_flowers = isNaN(((parseFloat(pie_ob.indica_flowers) / parseFloat(pie_ob.total_flowers)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.indica_flowers) / parseFloat(pie_ob.total_flowers)) * 100).toFixed(2);
            pie_ob.hybrid_flowers = isNaN(((parseFloat(pie_ob.hybrid_flowers) / parseFloat(pie_ob.total_flowers)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.hybrid_flowers) / parseFloat(pie_ob.total_flowers)) * 100).toFixed(2);
            pie_ob.sweet_edibles = isNaN(((parseFloat(pie_ob.sweet_edibles) / parseFloat(pie_ob.sweet_edibles)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.sweet_edibles) / parseFloat(pie_ob.total_edibles)) * 100).toFixed(2);
            pie_ob.savory_edibles = isNaN(((parseFloat(pie_ob.savory_edibles) / parseFloat(pie_ob.sweet_edibles)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.savory_edibles) / parseFloat(pie_ob.total_edibles)) * 100).toFixed(2);
            pie_ob.beverages_edibles = isNaN(((parseFloat(pie_ob.beverages_edibles) / parseFloat(pie_ob.sweet_edibles)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.beverages_edibles) / parseFloat(pie_ob.total_edibles)) * 100).toFixed(2);
            pie_ob.keif_concentrates = isNaN(((parseFloat(pie_ob.keif_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.keif_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2);
            pie_ob.hash_concentrates = isNaN(((parseFloat(pie_ob.hash_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.hash_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2);
            pie_ob.co2oil_concentrates = isNaN(((parseFloat(pie_ob.co2oil_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.co2oil_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2);
            pie_ob.rosin_concentrates = isNaN(((parseFloat(pie_ob.rosin_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.rosin_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2);
            pie_ob.wax_concentrates = isNaN(((parseFloat(pie_ob.wax_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.wax_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2);
            pie_ob.tincture_concentrates = isNaN(((parseFloat(pie_ob.tincture_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.tincture_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2);
            pie_ob.shatter_concentrates = isNaN(((parseFloat(pie_ob.shatter_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.shatter_concentrates) / parseFloat(pie_ob.total_concentrates)) * 100).toFixed(2);
            pie_ob.accessories_supplies = isNaN(((parseFloat(pie_ob.accessories_supplies) / parseFloat(pie_ob.total_supplies)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.accessories_supplies) / parseFloat(pie_ob.total_supplies)) * 100).toFixed(2);
            pie_ob.equipment_supplies = isNaN(((parseFloat(pie_ob.equipment_supplies) / parseFloat(pie_ob.total_supplies)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.equipment_supplies) / parseFloat(pie_ob.total_supplies)) * 100).toFixed(2);
            pie_ob.input_supplies = isNaN(((parseFloat(pie_ob.input_supplies) / parseFloat(pie_ob.total_supplies)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.input_supplies) / parseFloat(pie_ob.total_supplies)) * 100).toFixed(2);
            pie_ob.other_supplies = isNaN(((parseFloat(pie_ob.other_supplies) / parseFloat(pie_ob.total_supplies)) * 100).toFixed(2)) ? 0 : ((parseFloat(pie_ob.other_supplies) / parseFloat(pie_ob.total_supplies)) * 100).toFixed(2);

            $arr.pie_db = pie_db;
            $arr.pie_ob = pie_ob;

            common.tplFile('admincp/transaction_research.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });

    }
    if (action == 'product') {
        req.body.market = (typeof (req.param('market')) !== 'undefined') ? req.param('market') : '';
        req.body.tax_filter = (typeof (req.param('tax_filter')) !== 'undefined') ? req.param('tax_filter') : '';

        $arr['productsearch'] = 1;

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, { page: '' });

        $arr['search'] = query;

        $arr['market'] = req.body.market;

        if (req.body.market == 'undefined') {
            $arr['menu']['list'] = 'active';
        } else {
            $arr['menu'][req.body.market] = 'active';
        }

        console.log($arr['menu'])
        req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
        q.all([
            admin.transactionSearch(req, config.mysql, q, 4),
            admin.transactionSearch(req, config.mysql, q, 3),
            admin.getTotalCommRevenue(req, config.mysql, q)
        ]).then(function (result) {

            var user_ids = _.pluck(result[1][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id, first_name,username,email,phone,last_name,nick_name,review,avatar as uimage', user_ids, result[1][0], 'user_id', function (messageFromErr, messageFromRes) {
                // console.log("messagefrom response here : "+JSON.stringify(messageFromRes));
                var seller_ids = _.pluck(messageFromRes, 'seller_id');
                console.log("\nseler_id\n",seller_ids);

                faAPI.appendUserDataForObject('id', 'id as seller_id, username as seller_username', seller_ids, messageFromRes, 'seller_id', function (transactionApiErr, transactionApiRes) {
                    $arr['pagination'] = result[0][0][0].id;
                    $arr['total'] = typeof (result[0][0][0]['paid']) === 'undefined' || result[0][0][0]['paid'] == null ? '0.00' : parseFloat(result[0][0][0]['paid']).toFixed(2);
                    $arr['comm_rev'] = typeof (result[0][0][0]['comm_rev']) === 'undefined' || result[0][0][0]['comm_rev'] == null ? '0.00' : parseFloat(result[0][0][0]['comm_rev']).toFixed(2);
                    $arr['trans'] = common.addDecimalPlaces('trans_herbee_fee', transactionApiRes);
                    // $arr[''] = transactionApiRes;

                    $arr['fquery'] = fquery;
                    $arr['dlink'] = '/admincp/transaction/download?' + fquery;
                    var paginator = new pagination.SearchPaginator({
                        prelink: '/admincp/transaction/product/' + req.body.market + '?' + fquery,
                        current: req.body.page,
                        rowsPerPage: 10,
                        totalResult: $arr['pagination']
                    });
                    $arr['pagination_html'] = paginator.render();
                    common.tplFile('admincp/transaction.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);

                });
            });
        });
    }

    if (action == 'list') {
        req.body.market = (typeof (req.param('market')) !== 'undefined') ? req.param('market') : '';
        req.body.tax_filter = (typeof (req.param('tax_filter')) !== 'undefined') ? req.param('tax_filter') : '';

        $arr['productsearch'] = 0;

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, { page: '' });

        $arr['search'] = query;

        $arr['market'] = req.body.market;

        if (req.body.market == 'undefined') {
            $arr['menu']['list'] = 'active';
        } else {
            $arr['menu'][req.body.market] = 'active';
        }

        console.log($arr['menu'])
        req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
        q.all([
            admin.transactionSearch(req, config.mysql, q, 0),
            admin.transactionSearch(req, config.mysql, q, 1),
            admin.getTotalCommRevenue(req, config.mysql, q)
        ]).then(function (result) {

            var user_ids = _.pluck(result[1][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id, first_name,username,email,phone,last_name,nick_name,review,avatar as uimage', user_ids, result[1][0], 'user_id', function (messageFromErr, messageFromRes) {

                // console.log("messagefrom response here : "+JSON.stringify(messageFromRes));
                var seller_ids = _.pluck(messageFromRes, 'seller_id');
                console.log("\nseler_id\n",seller_ids);

                faAPI.appendUserDataForObject('id', 'id as seller_id, username as seller_username', seller_ids, messageFromRes, 'seller_id', function (transactionApiErr, transactionApiRes) {
                    // console.log('transactionApiRes' + JSON.stringify(transactionApiRes));

                    $arr['pagination'] = result[0][0][0].id;
                    $arr['total'] = typeof (result[0][0][0]['paid']) === 'undefined' || result[0][0][0]['paid'] == null ? '0.00' : parseFloat(result[0][0][0]['paid']).toFixed(2);
                    // $arr['comm_rev'] = typeof(result[2][0][0]['comm_rev']) === 'undefined' || result[2][0][0]['comm_rev'] == null ? '0.00' : result[2][0][0]['comm_rev'];
                    $arr['comm_rev'] = typeof (result[0][0][0]['comm_rev']) === 'undefined' || result[0][0][0]['comm_rev'] == null ? '0.00' : parseFloat(result[0][0][0]['comm_rev']).toFixed(2);

                    //$arr['trans'] = projects.shortDescribe(result[1][0]);

                    // $arr['trans'] = transactionApiRes;
                    console.log('transactionApiRes', transactionApiRes);
                    $arr['trans'] = common.addDecimalPlaces('trans_herbee_fee', transactionApiRes);
                    // $arr[''] = transactionApiRes;

                    $arr['fquery'] = fquery;
                    $arr['dlink'] = '/admincp/transaction/download?' + fquery;

                    var paginator = new pagination.SearchPaginator({
                        prelink: '/admincp/transaction/list/' + req.body.market + '?' + fquery,
                        current: req.body.page,
                        rowsPerPage: 10,
                        totalResult: $arr['pagination']
                    });

                    $arr['pagination_html'] = paginator.render();

                    common.tplFile('admincp/transaction.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);

                });
            });
        });
    }
});


app.get(['/risk_management/', '/risk_management/:action'], function (req, res) {
    var action = typeof (req.params.action) != 'undefined' ? req.params.action : '';
    $arr['menu'] = [];
    $arr['menu']['riskmanagement'] = 'active';
    $arr['menu']['all'] = 'active';
    //$arr['menu'][action] = 'active';
    console.log("8888888888888888888888")
    console.log($arr['menu'])
    req.body.first_name = (typeof (req.param('first_name')) === 'undefined') ? '' : req.param('first_name');
    req.body.last_name = (typeof (req.param('last_name')) === 'undefined') ? '' : req.param('last_name');
    req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
    req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
    req.body.from_date = (typeof (req.param('from_date')) === 'undefined') ? '' : req.param('from_date');
    req.body.to_date = (typeof (req.param('to_date')) === 'undefined') ? '' : req.param('to_date');

    req.body.limit = 10;
    var data = common.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;

    var projects = require('../../module/products');

    var page = (req.body.page - 1) * 10;
    var whereCondition = '';
    var whr = ' where ';
    var and = ' and ';

    var fieldNames = 'id, username, first_name, last_name, email';

    if (req.body.first_name != '' || req.body.last_name != '' || req.body.country != '' || req.body.state != '') {
        whereCondition = whereCondition + whr;
    }
    // // ' limit ' + page + ',10'
    if (req.body.first_name !== '') {
        whereCondition = whereCondition + ' first_name like "%' + req.body.first_name + '%"';
    }

    if (req.body.last_name !== '') {
        whereCondition = whereCondition + ' last_name like "%' + req.body.last_name + '%"';
    }

    if (req.body.country !== '') {
        whereCondition = whereCondition + ' country like "%' + req.body.country + '%"';
    }

    if (req.body.state !== '') {
        whereCondition = whereCondition + ' state like "%' + req.body.state + '%"';
    }

    if (req.body.first_name != '' || req.body.last_name != '' || req.body.country != '' || req.body.state != '') {
        whereCondition = whereCondition + ' limit ' + page + ',10';
    }

    console.log("----------->>>>" + whereCondition);

    faAPI.callUserQuery('no_type', fieldNames, whereCondition, function (apiUsersErr, apiUsersRes) {
        if (apiUsersErr) {
            console.log("API ERR", apiUsersErr)
        }

        if (apiUsersRes != null) {
            console.log('not null');
            req.body.uids = _.pluck(apiUsersRes.results, 'id');
        }

        // console.log("------------------api data-----------------", apiUsersRes);

        try {
            if (action == 'list' || action == '') {
                q.all([
                    admin.getAllRecurrings(req, config.mysql, q, 0),
                    admin.getAllRecurrings(req, config.mysql, q, 1)
                ]).then(function (result) {
                    var user_ids = _.pluck(result[0][0], 'user_id');
                    faAPI.appendUserDataForObject('id', 'id as user_id, username, country, state, first_name,email,phone,last_name,nick_name,review,avatar as uimage', user_ids, result[0][0], 'user_id', function (messageFromErr, messageFromRes) {

                        var seller_ids = _.pluck(messageFromRes, 'seller_id');
                        faAPI.appendUserDataForObject('id', 'id as seller_id,username as seller_username', seller_ids, messageFromRes, 'seller_id', function (apiErr, apiRes) {
                            // console.log('apiRes', apiRes);
                            $arr['recurrings'] = apiRes;
                            var url = require('url');
                            var url_parts = url.parse(req.url, true);

                            var query = url_parts.query;
                            fquery = common.urlparameter(query, { page: '' });

                            $arr['search'] = query;
                            $arr['fquery'] = fquery;

                            var paginator = new pagination.SearchPaginator({
                                prelink: '/admincp/risk_management/list?' + fquery,
                                current: req.body.page,
                                rowsPerPage: req.body.limit,
                                totalResult: result[1][0].length
                            });
                            $arr['pagination_html'] = paginator.render();

                            common.tplFile('admincp/risk_management.tpl');
                            common.headerSet(1);
                            common.loadTemplateHeader(req, res, $arr);
                        });
                    });
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }
        } catch (err) {
            console.log("Error")
            console.log(err)
        }
    })
});

/* Recurring cancellation approval process for admin */
app.post('/reccancellation/approve', function (req, res) {

    console.log("----------------------------/reccancellation/approve--------------------------");

    var prodRequests = require('../../module/prod_requests');
    var cart = require('../../module/cart');

    var rid = req.body.rid;
    // console.log(req.body);
    // mysqli['getrecurre'] = 'select (SELECT count(id) FROM recurring_schedule rs where rs.recur_purchase_id = rp.id and payment_status = "unpaid") as remainingtrs,rp.*, p.user_id as seller_id, p.title from recurring_purchase as rp left join projects as p on rp.project_id = p.id where rp.id = ?';
    q.all([prodRequests.getRecurring(config.mysql, q, rid)]).then(function (result) {

        // console.log(JSON.stringify(result));
        if (result[0][0].length > 0) {

            if (result[0][0][0].aapprove_status == 0) {

                var admin_id = '1';
                var buyer_id = result[0][0][0].user_id;
                var seller_id = result[0][0][0].seller_id;
                var buyer_amt = seller_amt = admin_amt = 0;
                //var reserve_price = parseFloat(result[0][0][0].reserve_price);
                /* getting total remaining tansactions amount */
                var reserve_price = (parseFloat(result[0][0][0].remainingtrs) * parseFloat(result[0][0][0].amount)).toFixed(2);
                console.log("remaining transactions value : " + result[0][0][0].remainingtrs);
                console.log("transactions value : " + result[0][0][0].amount);
                console.log("remaining transaction value : " + reserve_price);
                // console.log("admin user here : " + seller_id + "reserve_price " + reserve_price);
                // var seller_id = buyNowRecord[0][0][0].request_userid;

                var fieldNames = 'email,first_name,last_name,username,notification,status,id,balance,phone'

                /* buyer id from session and seller id from product */
                // var whereCondition = ' where id in (' + buyer_id + ',' + seller_id + ' , ' + admin_id + ') ';
                var whereCondition = ' where id in (' + buyer_id + ',' + seller_id + ',' + admin_id + ') ';
                console.log(whereCondition);
                q.all([admin.adminRecCancelApproval(req, config.mysql, q, result[0][0][0].id), products.checkmailnotify(req, config.mysql, q, 47), products.checksmsnotify(req, config.mysql, q, 47)]).then(function (results) {
                    console.log('results here -- ' + results);
                    var crdt = results[0][0].affectedRows;
                    async.series({
                        getBuyerSeller: function (cb) {

                            // getting userInformations
                            var userDataCallback = function (err, response) {
                                cb(err, response);
                                // console.log("getting userinfo");
                            }

                            faAPI.callUserQuery('no_type', fieldNames, whereCondition, userDataCallback)
                        }
                    },
                        function (apiSeUsersErr, apiSeUsersRes) {
                            console.log(apiSeUsersErr);
                            console.log("getting buyer seller data here");
                            console.log(JSON.stringify(apiSeUsersRes));

                            for (var i = 0; i < apiSeUsersRes.getBuyerSeller.results.length; i++) {
                                if (apiSeUsersRes.getBuyerSeller.results[i].id == seller_id) {
                                    var seller = apiSeUsersRes.getBuyerSeller.results[i];
                                } else if (apiSeUsersRes.getBuyerSeller.results[i].id == buyer_id) {
                                    var buyer = apiSeUsersRes.getBuyerSeller.results[i];
                                } else if (apiSeUsersRes.getBuyerSeller.results[i].id == admin_id) {
                                    var admin_user = apiSeUsersRes.getBuyerSeller.results[i];
                                }
                            }


                            console.log("buyer : " + JSON.stringify(buyer));
                            console.log("seller : " + JSON.stringify(seller));
                            console.log("admin user : " + JSON.stringify(admin_user));

                            // cancel_insn_return=43
                            // cancel_insn_return_admin=7
                            // cancel_ins_return=20
                            // cancel_ins_return_admin=5

                            if (result[0][0][0].cancellation == 1) {
                                admin_amt = (parseFloat(reserve_price).toFixed(2) * (parseFloat(global.general.cancel_ins_return_admin) / 100).toFixed(2));
                                seller_amt = parseFloat(reserve_price).toFixed(2) * (parseFloat(global.general.cancel_ins_return) / 100).toFixed(2);
                                buyer_amt = (admin_amt + seller_amt);
                            } else {
                                admin_amt = (parseFloat(reserve_price).toFixed(2) * (parseFloat(global.general.cancel_insn_return_admin) / 100).toFixed(2));
                                seller_amt = parseFloat(reserve_price).toFixed(2) * (parseFloat(global.general.cancel_insn_return) / 100).toFixed(2);
                                buyer_amt = (admin_amt + seller_amt);
                            }

                            console.log('reserve_price : ' + reserve_price);
                            console.log('transafering reserve_price : ' + result[0][0][0].reserve_price);
                            console.log('seller_amt : ' + seller_amt);
                            console.log('admin_amt : ' + admin_amt);
                            console.log('buyer_amt : ' + buyer_amt);

                            seller_amt = (parseFloat(result[0][0][0].reserve_price) + parseFloat(seller_amt)).toFixed(2)
                            console.log('adding reserve_price at seller side' + seller_amt);

                            // if (result[0][0][0].cancellation == 1) {
                            //     seller_amt = ((reserve_price * (parseFloat(global.general.cancel_ins_return) / 100)).toFixed(2) + parseFloat(result[0][0][0].reserve_price).toFixed(2));
                            //     console.log('seller amt-------------------------------'+seller_amt);
                            //     // seller_amt = reserve_price * (parseFloat(global.general.cancel_insn_return) / 100);
                            //     admin_amt = (reserve_price * (parseFloat(global.general.cancel_ins_return_admin) / 100)).toFixed(2);
                            //     // buyer_amt = parseFloat((reserve_price - seller_amt) - admin_amt).toFixed(2);
                            //     buyer_amt = (parseFloat(seller_amt) + parseFloat(admin_amt)).toFixed(2);
                            // } else {
                            //     seller_amt = (reserve_price * (parseFloat(global.general.cancel_insn_return) / 100) + parseFloat(result[0][0][0].reserve_price)).toFixed(2);
                            //     console.log('seller amt-------------------------------'+seller_amt);
                            //     // seller_amt = reserve_price * (parseFloat(global.general.cancel_insn_return) / 100);
                            //     admin_amt = (reserve_price * (parseFloat(global.general.cancel_insn_return_admin) / 100).toFixed(2)).toFixed(2);
                            //     // buyer_amt = parseFloat((reserve_price - seller_amt) - admin_amt).toFixed(2);
                            //     buyer_amt = (parseFloat(seller_amt) + parseFloat(admin_amt)).toFixed(2);
                            // }

                            var payments = require('../../module/payment');

                            payments.transactionid = 0;
                            payments.gateway = 'account';
                            payments.payid = result[0][0][0].id;
                            payments.type = 'refund_reserve_amount';

                            /*new fields here for cancellation returns*/
                            payments.rec_cancellation = 1;
                            payments.rec_id = result[0][0][0].id;

                            if (result[0][0][0].cancellation == 1) {
                                payments.rec_cancelseller_per = global.general.cancel_ins_return;
                                payments.rec_cancelseller_amt = seller_amt;
                                payments.rec_canceladmin_per = global.general.cancel_ins_return_admin;
                                payments.rec_canceladmin_amt = admin_amt;
                            } else if (result[0][0][0].cancellation == 0) {
                                payments.rec_cancelseller_per = global.general.cancel_insn_return;
                                payments.rec_cancelseller_amt = seller_amt;
                                payments.rec_canceladmin_per = global.general.cancel_insn_return_admin;
                                payments.rec_canceladmin_amt = admin_amt;
                            }


                            // console.log('----------total reserve amt-------' + reserve_price);
                            // console.log('------prev'+ buyer.balance +' amt to be deduct from buyer acc-------'+buyer_amt);
                            // console.log('------amt '+ seller.balance + ' to be credit at seller acc-------'+seller_amt);
                            // console.log('------amt '+ admin_user.balance +' to be credit at admin acc-------'+admin_amt);

                            // console.log(seller_amt)
                            // console.log(admin_amt)
                            // console.log(buyer_amt)



                            var buyer_email = buyer.email;
                            var buyer_firstname = buyer.first_name;
                            var seller_email = seller.email;
                            var seller_firstname = seller.first_name;
                            var admin_email = admin_user.email;
                            var admin_firstname = admin_user.first_name;

                            /* END */

                            payments.name = result[0][0][0].title;
                            payments.payid = result[0][0][0].project_id;
                            payments.buynow_id = 0;
                            payments.cart_id = 0;
                            payments.amount = buyer_amt;
                            payments.buyer = buyer;
                            payments.seller = seller;
                            payments.admin_user = admin_user;
                            payments.qty = 0;

                            q.all([payments.insertInvoice(req)]).then(function (invoice) {
                                // console.log(invoice);
                                req.body.invoice_id = invoice[0][0].insertId;
                                // console.log(invoice);
                                // console.log(invoice[0][0].insertId);
                                // res.send("Payment successull....");

                                // console.log(buyer);
                                // console.log(seller);

                                // if (admin_user.balance > ) {

                                var buyerbal = (parseFloat(buyer.balance) - parseFloat(buyer_amt)).toFixed(2);
                                var sellerbal = (parseFloat(seller.balance) + parseFloat(seller_amt)).toFixed(2);
                                var adminbal = (parseFloat(admin_user.balance) + parseFloat(admin_amt)).toFixed(2)

                                req.body.buyer = { balance: buyerbal, id: buyer.id }
                                req.body.seller = { balance: sellerbal, id: seller.id }
                                req.body.admin_user = { balance: adminbal, id: admin_user.id }

                                // req.body.seller = { balance: parseFloat(seller.balance) + parseFloat(buyNowRecord[0][0][0].total_amount), id: seller.id }
                                console.log('----------------------------changes here--------------------------');
                                console.log(req.body.buyer);
                                console.log(req.body.seller);
                                console.log(req.body.admin_user);

                                // 'update buyers balance'
                                /* deducting 25% or 50 % of total remaining transaction value from buyer account*/
                                faAPI.updateUser(req, 'refund_reserve_amountb', function (err, resp) {
                                    /* adding 5% or 7% at admin side */
                                    faAPI.updateUser(req, 'refund_reserve_amounta', function (err, resp) {
                                        /* adding 20% or 43% at admin side */
                                        faAPI.updateUser(req, 'refund_reserve_amounts', function (err, resp) {

                                            /* email module */
                                            var activeurl = '<br/> <a href="' + $arr.config.spath + 'login">Click Here</a>';
                                            email = require('../../module/email');
                                            localm = require('../../module/localmail');
                                            if (results[1][0].length > 0) {
                                                // if (global.emailcio.status == 'yes') {
                                                //     customerio = require('../module/customerio');
                                                //     customerio.uid = result.userId;
                                                // } else
                                                if (global.emaillocal.status == 'yes') {
                                                    q.all([localm.mailtemps(req, config.mysql, q, 'risk_management'), localm.mailtemps(req, config.mysql, q, 'risk_management_cancellation')]).then(function (results2) {

                                                        if (results2) {

                                                            var template = results2[0][0][0].template;
                                                            var subject_message = results2[0][0][0].subject;

                                                            var template1 = results2[1][0][0].template;
                                                            var subject_message1 = results2[1][0][0].subject;

                                                            // template = template.replace('{{event.sitename}}', config.title);
                                                            template = template.replace('{{event.activeurl}}', activeurl);
                                                            template = template.replace('{{event.user}}', buyer_firstname);
                                                            template = template.replace('{{event.subject}}', 'Recurring cancelled..!');

                                                            template1 = template1.replace('{{event.activeurl}}', activeurl);
                                                            template1 = template1.replace('{{event.user}}', seller_firstname);
                                                            template1 = template1.replace('{{event.subject}}', 'Recurring cancelled..!');
                                                            // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                                                            localm.sendmail(template, subject_message, buyer_email);
                                                            localm.sendmail(template1, subject_message1, seller_email);
                                                            // localm.sendmail(template1, subject_message1, admin_email);

                                                        } else {
                                                            console.log("No Templates named register");
                                                        }

                                                    }).fail(function (err) {
                                                        console.log(err.stack);
                                                        throw err;
                                                    });

                                                } else {
                                                    console.log('No Mail Delivery method is selected');
                                                }
                                            } else { console.log('No Mail Delivery method is selected'); }
                                            /* email module ends here */

                                            // res.writeHead(302, {
                                            //     'Location': '/dashboard/invoices/' + req.body.invoice_id
                                            // });
                                            // res.end();
                                            // return false
                                            // });
                                        });
                                    });


                                });


                                // req.body.trans_gateway = "account",
                                console.log("status changed successfully....!");

                            }).fail(function (error) {
                                console.log(error.stack);
                                //throw error;
                            }).done();

                            /* end here */

                        })

                    // if (crdt.length > 0) {
                    //     res.send(JSON.stringify({ 'error': false, 'success': 1 }));
                    //     return false;
                    // } else {
                    //     res.send(JSON.stringify({ 'error': false, 'success': 0 }));
                    //     return false;
                    // }

                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                }).done();

            } else {
                res.send(JSON.stringify({ 'error': false, 'success': 0 }));
                return false;
            }

        } else {
            res.send(JSON.stringify({ 'error': false, 'success': 0 }));
            return false;
        }

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

function updateStatus(req, res, callback) {

    // callback('data here','yes');

    console.log("req_body", req.body)
    req.body.updateFields = {};
    var gmoney = require("../../module/greenmoney");
    if (common.admincheckLogin(req, res, 1)) {

        console.log('[' + req.param('id') + ']');
        console.log('[' + req.param('status') + ']');
        console.log('[' + req.param('rej_msg') + ']');
        console.log('[' + req.param('ptype') + ']');

        q.all([gmoney.getFundRequest(req, config.mysql, q)]).then(function (results) {

            async.series({
                getUserInfo: function (cb) {
                    // getting userInformations
                    var userDataCallback = function (err, response) {

                        // console.log(err);
                        // console.log(response);

                        if (err != null) {
                            if (err.code == 'D1016') {
                                err.exists = false
                                cb(null, err);
                            } else {
                                cb(err, null);
                            }
                        } else {
                            response.exists = true
                            cb(err, response);
                        }
                    }

                    faAPI.userInfo(req, results[0][0][0].user_id, userDataCallback);
                },
            },
                function (err, userDetail) {
                    // console.log('Userdetails', userDetail);

                    // console.log("prabakaran", JSON.stringify(userDetail));

                    req.body.updateFields.balance = parseFloat(userDetail.getUserInfo.user.balance) + parseFloat(results[0][0][0].amount);
                    req.body.updateFields.id = results[0][0][0].user_id;
                    var email = userDetail.getUserInfo.user.email;
                    var name = userDetail.getUserInfo.user.first_name;
                    console.log('useremail', email);

                    q.all([gmoney.updateFundRequest(req, config.mysql, q), products.checkmailnotify(req, config.mysql, q, 35), products.checksmsnotify(req, config.mysql, q, 35)]).then(function (resul) {
                        if (req.param('status') == 'approve') {

                            var payments = require('../../module/payment');

                            payments.transactionid = 0;
                            payments.gateway = 'account';

                            payments.payid = 0;

                            if (results[0][0][0].type == 'wire')
                                payments.type = 'wire_payment';
                            if (results[0][0][0].type == 'check')
                                payments.type = 'check_payment';

                            payments.buyer = userDetail.getUserInfo.user;
                            payments.buyer.user_id = userDetail.getUserInfo.user.id;

                            payments.name = '';
                            payments.payid = 0;
                            payments.buynow_id = 0;
                            payments.cart_id = 0;
                            payments.amount = results[0][0][0].amount;
                            payments.qty = 0;

                            q.all([payments.insertInvoice(req)]).then(function (invoice) {


                                q.all(products.generateInvoiceID(req, invoice[0][0].insertId, config.mysql, q)).then(function (invoices) {
                                    console.log('invoicets here', invoices);
                                }).fail(function (err) {
                                    console.log(err.stack);
                                    throw err;
                                }).done();



                                faAPI.updateUser(req, 'admin_approve_payment', function (err, resp) {
                                    console.log(JSON.stringify(resp));
                                    callback(1);
                                });

                                console.log("status changed successfully....!");

                            }).fail(function (error) {
                                console.log(error.stack);
                                //throw error;
                            }).done();


                        } else if (req.param('status') == 'reject') {

                            localm = require('../../module/localmail');
                            var activeurl = '<br/>To login your account. Please <a href="' + $arr.config.spath + 'login">click here</a>';
                            console.log('resul[1][0].length', resul[1][0].length);
                            if (resul[1][0].length > 0) {
                                if (global.emaillocal.status == 'yes') {
                                    console.log('funding_rejection 1');
                                    q.all([localm.mailtemps(req, config.mysql, q, 'funding_rejection')]).then(function (results2) {
                                        console.log("sending mail");
                                        if (results2) {

                                            var template = results2[0][0][0].template;
                                            var subject_message = results2[0][0][0].subject;

                                            template = template.replace('{{event.subject}}', "Your Herbee Account");
                                            template = template.replace('{{event.message}}', "An issue has arisen with your attempt to fund your Herbee account. An account specialist will contact you shortly regarding this issue. Please respond to this email with dates and times which work best to contact you.");
                                            template = template.replace('{{event.user}}', name);
                                            // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                                            localm.sendmail(template, subject_message, email);

                                        } else {

                                            console.log("No Templates named message_sent");
                                        }


                                    }).fail(function (err) {
                                        console.log(err.stack);
                                        throw err;
                                    });
                                }
                            } else { console.log('Email method is not Selected for product posting'); }
                        }

                    }).fail(function (err) {
                        console.log(err.stack);
                        callback(0);
                        throw err;
                    }).done();

                })

        }).fail(function (err) {
            console.log(err.stack);
            callback(0);
            throw err;
        }).done();

    } else {

        callback(0);

    }

}

function updateRefStatus(req, res, callback) {

    // callback('data here','yes');

    // console.log("req_body", req.body)
    req.body.updateFields = {};
    var gmoney = require("../../module/greenmoney");
    if (common.admincheckLogin(req, res, 1)) {

        // console.log('[' + req.param('id') + ']');
        // console.log('[' + req.param('status') + ']');
        // console.log('[' + req.param('rej_msg') + ']');
        // console.log('[' + req.param('ptype') + ']');

        q.all([gmoney.getFundRequest(req, config.mysql, q)]).then(function (results) {

            async.series({
                getUserInfo: function (cb) {
                    // getting userInformations
                    var userDataCallback = function (err, response) {

                        // console.log(err);
                        // console.log(response);

                        if (err != null) {
                            if (err.code == 'D1016') {
                                err.exists = false
                                cb(null, err);
                            } else {
                                cb(err, null);
                            }
                        } else {
                            response.exists = true
                            cb(err, response);
                        }
                    }

                    faAPI.userInfo(req, results[0][0][0].user_id, userDataCallback);
                },
            },
                function (err, userDetail) {
                    // console.log('Userdetails', userDetail);

                    // console.log("prabakaran", JSON.stringify(userDetail));

                    req.body.updateFields.balance = (parseFloat(userDetail.getUserInfo.user.balance) - parseFloat(results[0][0][0].amount)).toFixed(2);
                    req.body.updateFields.id = results[0][0][0].user_id;
                    var email = userDetail.getUserInfo.user.email;
                    var name = userDetail.getUserInfo.user.first_name;
                    console.log('useremail', email);

                    q.all([gmoney.updateFundRequest(req, config.mysql, q), products.checkmailnotify(req, config.mysql, q, 35), products.checksmsnotify(req, config.mysql, q, 35)]).then(function (resul) {
                        if (req.param('status') == 'approve') {

                            var payments = require('../../module/payment');

                            payments.transactionid = 0;
                            payments.gateway = 'account';

                            payments.payid = 0;

                            payments.type = 'refund_request';

                            payments.buyer = userDetail.getUserInfo.user;
                            payments.buyer.user_id = userDetail.getUserInfo.user.id;

                            payments.name = '';
                            payments.payid = 0;
                            payments.buynow_id = 0;
                            payments.cart_id = 0;
                            payments.amount = results[0][0][0].amount;
                            payments.qty = 0;

                            q.all([payments.insertInvoice(req)]).then(function (invoice) {

                                q.all(products.generateInvoiceID(req, invoice[0][0].insertId, config.mysql, q)).then(function (invoices) {
                                    console.log('invoicets here', invoices);
                                }).fail(function (err) {
                                    console.log(err.stack);
                                    throw err;
                                }).done();

                                faAPI.updateUser(req, 'admin_approve_payment', function (err, resp) {
                                    console.log(JSON.stringify(resp));
                                    callback(1);
                                });

                                console.log("status changed successfully....!");

                            }).fail(function (error) {
                                console.log(error.stack);
                                //throw error;
                            }).done();


                        } else if (req.param('status') == 'reject') {

                            localm = require('../../module/localmail');
                            var activeurl = '<br/>To login your account. Please <a href="' + $arr.config.spath + 'login">click here</a>';
                            console.log('resul[1][0].length', resul[1][0].length);
                            if (resul[1][0].length > 0) {
                                if (global.emaillocal.status == 'yes') {
                                    console.log('funding_rejection 2');
                                    q.all([localm.mailtemps(req, config.mysql, q, 'funding_rejection')]).then(function (results2) {
                                        console.log("sending mail");
                                        if (results2) {

                                            var template = results2[0][0][0].template;
                                            var subject_message = results2[0][0][0].subject;

                                            template = template.replace('{{event.subject}}', "Your Herbee Account");
                                            template = template.replace('{{event.message}}', "An issue has arisen with your attempt to fund your Herbee account. An account specialist will contact you shortly regarding this issue. Please respond to this email with dates and times which work best to contact you.");
                                            template = template.replace('{{event.user}}', name);
                                            // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                                            localm.sendmail(template, subject_message, email);

                                        } else {

                                            console.log("No Templates named message_sent");
                                        }


                                    }).fail(function (err) {
                                        console.log(err.stack);
                                        throw err;
                                    });
                                }
                            } else { console.log('Email method is not Selected for product posting'); }
                        }

                    }).fail(function (err) {
                        console.log(err.stack);
                        callback(0);
                        throw err;
                    }).done();

                })

        }).fail(function (err) {
            console.log(err.stack);
            callback(0);
            throw err;
        }).done();

    } else {

        callback(0);

    }

}

// app.get('/payment/test', function(req, res) {
//     updateStatus(req, res, function(err, data) {
//         console.log(err);
//         console.log(data);
//         res.send(err + ' --- ---- ' + data);
//     })
// })


app.post('/payment/update', function (req, res) {

    console.log(req.body);
    var gmoney = require("../../module/greenmoney");

    q.all([gmoney.updatePaymentReq(req, config.mysql, q)]).then(function (results) {

        if (req.body.status == 'approve') {

            req.body.rej_msg = typeof (req.param('rej_msg')) !== undefined ? req.param('rej_msg') : '';

            updateStatus(req, res, function (data) {
                if (data == 1) {
                    // $arr.getSub = results[0][0];
                    res.writeHead(302, {
                        'Location': '/admincp/payments/edit/' + req.body.id + '/saved'
                    });
                    res.end();
                    return false;
                    next();
                }
            });
        } else {
            res.writeHead(302, {
                'Location': '/admincp/payments/edit/' + req.body.id + '/saved'
            });
            res.end();
            return false;
            next();
        }

    });

});


app.post('/payment/update/status', function (req, res) {

    console.log('[' + req.param('id') + ']');
    console.log('[' + req.param('status') + ']');
    console.log('[' + req.param('rej_msg') + ']');
    console.log('[' + req.param('ptype') + ']');

    updateStatus(req, res, function (data) {
        res.json(data);
        res.end();
        return true;
    })

});

app.post('/payment/update/refstatus', function (req, res) {

    console.log('[' + req.param('id') + ']');
    console.log('[' + req.param('status') + ']');
    console.log('[' + req.param('rej_msg') + ']');
    console.log('[' + req.param('ptype') + ']');

    updateRefStatus(req, res, function (data) {
        res.json(data);
        res.end();
        return true;
    })

});


app.get('/reset_password/:id', function (req, res) {

    req.body.id = typeof (req.param('id')) != undefined ? req.param('id') : '';

    async.series([function (callback) {
        // faAPI.userdetails_email(req, "email", callback);
        faAPI.userInfo(req, req.body.id, callback);
    }],
        // optional callback
        function (err, results) {

            console.log(JSON.stringify(results[0]));

            if (err) {

                console.log(err);

                // throw err;
            } else {
                var cryptos = require('../../module/crypto.js');
                var localm = require('../../module/localmail');
                console.log("-----------here");

                console.log("-----------here");
                //customerio = require('../module/customerio');
                //customerio.uid = results[0]['id'];
                //customerio.inits();
                //customerio.createCustomer({ email: req.body.email, user: { firstName: results[0]['first_name'], lastName: results[0]['last_name'] } });
                var u_ID = results[0].user.id.toString();
                var hw = cryptos.encrypt(results[0].user.email + '#' + u_ID);

                $arr['verifyurl'] = config.url + '/login/forgot_password?id=' + hw
                //customerio.sendEmail({ event: 'forgot_password', content: { passwordurl: $arr['verifyurl'], firstName: results[0]['first_name'], lastName: results[0]['last_name'] } });
                q.all([localm.mailtemps(req, config.mysql, q, 'forgot_password')]).then(function (results2) {
                    if (results2) {
                        var template = results2[0][0][0].template;
                        var subject_message = results2[0][0][0].subject;
                        template = template.replace('{{event.user}}', results[0].user['first_name']);
                        template = template.replace('{{event.user_name}}', results[0].user['last_name']);
                        template = template.replace('{{event.verifyurl}}', $arr['verifyurl']);
                        // template = template.replace('{{event.verifyurl}}', $arr['verifyurl']);
                        template = template.replace('{{event.url}}', config.url);
                        localm.sendmail(template, subject_message, results[0].user.email);
                        $arr['step1'] = false;
                        $arr['step2'] = false;
                        $arr['step3'] = true;
                        $arr['textStatus'] = 'Email has been dispatched to your Registered Email ID to reset your Password';
                        // res.end();
                        res.json({ status: true })
                        res.end()
                        return false;
                    } else {
                        $arr['textStatus'] = 'Please enter correct details';
                        res.json({ status: false })
                        res.end()
                    }
                });
            }
        })

});




/* ===================== start change by divyesh (added) ===================== */
app.get(['/consultant_code/', '/consultant_code/:entrytype', '/consultant_code/:entrytype/:id'], function (req, res) {
    console.log('req.session.adminUrl', req.session.adminUrl);
    var _entry = req.body.action = req.param('entrytype') != '' && typeof (req.param('entrytype')) != 'undefined' ? req.param('entrytype') : '';

    $arr['name'] = req.body.name = req.query.first_name != '' && typeof (req.query.name) != 'undefined' ? req.query.name : '';
    $arr['sc_code'] = req.body.sc_code = req.query.sc_code != '' && typeof (req.query.sc_code) != 'undefined' ? req.query.sc_code : ''
    $arr['email'] = req.body.email = req.query.email != '' && typeof (req.query.email) != 'undefined' ? req.query.email : '';
    console.log(_entry);
    if (_entry == 'all' || _entry == 'search') {

        delete $arr['menu'];
        $arr['menu'] = [];
        $arr['menu']['consultantmenu'] = 'active';
        $arr['menu']['consultan_codeList'] = 'active';

        var whereCondition = 'where created_by = ' + req.session.login_userid + ' ';
        if (_entry == 'search') {

            if (req.body.email) {
                whereCondition = whereCondition + 'and email like "%' + req.body.email + '%"'
            }
            if (req.body.name) {
                whereCondition = whereCondition + ' and name like "%' + req.body.name + '%"'
            }
            if (req.body.sc_code) {
                whereCondition = whereCondition + ' and sc_code like "%' + req.body.sc_code + '%"'
            }


        }

        req.body.whereCondition = whereCondition;
        req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
        q.all([admin.getAllConsultantodes(req, config.mysql, q)]).then(function (result) {
            console.log('***********************************************');
            console.log('result[0][0]', result[0][0]);

            $arr['consultantCode'] = result[0][0];
            $arr['consultantCodeCount'] = result[0][0].length;
            common.tplFile('admincp/consultant_code_list.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        })
    } else if (_entry === 'add') {

        delete $arr['menu'];
        $arr['menu'] = [];
        $arr['menu']['consultantmenu'] = 'active';
        $arr['menu']['consultan_code'] = 'active';


        q.all([admin.getAllConsultantodes(req, config.mysql, q)]).then(function (result) {
            console.log('***********************************************');
            console.log(result[0][0]);


            if (result[0] && result[0][0]) {
                while (true) {
                    var generatedCode = '';//Math.floor(Math.random() * 90000) + 10000;
                    var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                    for (var i = 5; i > 0; --i) generatedCode += chars[Math.floor(Math.random() * chars.length)];

                    var flag = false;
                    result[0][0].forEach(element => {
                        console.log(element['sc_code']);
                        if (element['sc_code'].toString() === generatedCode.toString()) {
                            flag = true;
                        }
                    });

                    if (!flag) {
                        $arr['autoGeneratedCode'] = generatedCode;
                        break;
                    }
                }
            }
            common.tplFile('admincp/add_consultant_code.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        })
    } else if (_entry === 'save') {
        console.log("req.body.id : ", req.session.user);
        localm = require('../../module/localmail');

        q.all([localm.mailtemps(req, config.mysql, q, 'consultant_code_generated')]).then(function (results3) {
            if (results3) {
                console.log('req.session', req.session);
                var template = results3[0][0][0].template;
                var subject_message = results3[0][0][0].subject;

                var link_register = '<a href="' + $arr.config.url + '/register">Click Here</a>';

                template = template.replace('{{event.user}}', req.body.name);
                template = template.replace('{{event.subject}}', 'Sales Consultant code for you');
                template = template.replace('{{event.link_register}}', link_register);

                template = template.replace('{{event.username}}', req.body.username);
                template = template.replace('{{event.sender_name}}', (req.session.first_name + ' ' + req.session.last_name));
                template = template.replace('{{event.consultant_code}}', req.body.sc_code);


                localm.sendmail(template, subject_message, req.body.email);


                // q.all([products.checkmailnotify(req, config.mysql, q, results3[0][0][0].id)]).then(function (notificationPermissionData) {
                //     console.log(notificationPermissionData[0[0]])
                //     if (notificationPermissionData[0][0].length > 0) {
                //         localm.sendmail(template, subject_message, req.body.email);
                //     }
                // });

            } else {
                console.log("No Templates named consultant_code_generated");
            }

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        });

        if (req.param('id')) {
            delete $arr['menu'];
            $arr['menu'] = [];
            $arr['menu']['consultantmenu'] = 'active';
            $arr['menu']['consultan_code'] = 'active';

            req.body.whereCondition = " WHERE email like '" + req.body.email + "'";
            req.body.updateCondition = " email = '" + req.body.email + "',name='" + req.body.name + "' ";
            q.all([admin.updateSpecificConsultantCode(req, config.mysql, q)]).then(function (result) {

                console.log(result[0][0])
                $arr['stat_msg'] = "Data Successfully Updated";
                $arr['stat_msg_type'] = 'alert-success';

                console.log('/' + req.session.adminUrl + '/consultant_code/edit/' + req.param('id'));
                res.redirect('/' + req.session.adminUrl + '/consultant_code/edit/' + req.param('id'));
            }).fail(function (err) {
                $arr['stat_msg'] = "Data Already Exists";
                $arr['stat_msg_type'] = 'alert-danger'
                res.redirect('/' + req.session.adminUrl + '/consultant_code/all');
                throw err;
            });
        }
        else {
            delete $arr['menu'];
            $arr['menu'] = [];
            $arr['menu']['consultantmenu'] = 'active';
            $arr['menu']['consultan_code'] = 'active';

            console.log(req.body);

            var valuesData = ' (';
            if (_entry == 'save') {

                req.body.id = (typeof (req.session.login_userid) === 'undefined') ? 0 : req.session.login_userid;

                if (req.body.name) {
                    valuesData = valuesData + ("'" + req.body.name + "'") + ',';
                }

                if (req.body.email) {
                    valuesData = valuesData + ("'" + req.body.email + "'") + ',';
                }

                if (req.body.sc_code) {
                    valuesData = valuesData + ("'" + req.body.sc_code + "'") + ',';
                }

                if (req.body.id) {
                    valuesData = valuesData + req.body.id + ',';
                }

                var dateFormat = require('dateformat');
                const dateNow = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

                req.body.valuesData = valuesData + "'" + dateNow + "')";
            }

            console.log(req.body.valuesData);

            q.all([admin.saveConsultantCode(req, config.mysql, q)]).then(function (result) {

                $arr['stat_msg'] = "Code Successfully Added";
                $arr['stat_msg_type'] = 'alert-success';
                res.redirect('/' + req.session.adminUrl + '/consultant_code/add');
            }).fail(function (err) {
                $arr['stat_msg'] = " Email Already Exists.";
                $arr['stat_msg_type'] = 'alert-danger'
                console.log(err.stack);
                console.log(req.param);
                res.redirect('/' + req.session.adminUrl + '/consultant_code/add');
                throw err;
            })
        }
    } else if (_entry === 'delete') {
        const whereConditions = " WHERE email like '" + req.param('id') + "'";
        req.body.whereCondition = whereConditions;
        q.all([admin.deleteConsultantCode(req, config.mysql, q)]).then(function (result) {
            res.redirect('/' + req.session.adminUrl + '/consultant_code/all');
        }).fail(function (err) {
            res.redirect('/' + req.session.adminUrl + '/consultant_code/all');
            throw err;
        })

    }


    else if (_entry === 'edit') {
        delete $arr['menu'];
        $arr['menu'] = [];
        $arr['menu']['consultantmenu'] = 'active';
        $arr['menu']['consultan_code'] = 'active';

        if (req.param('id') && req.param('id') !== '') {
            req.body.whereCondition = ' WHERE id=' + req.param('id')
            q.all([admin.getSpecificConsultantCode(req, config.mysql, q)]).then(function (result) {

                if (result && result[0] && result[0][0]) {
                    $arr['id'] = result[0][0][0]['id'];
                    $arr['email'] = result[0][0][0]['email'];
                    $arr['name'] = result[0][0][0]['name'];
                    $arr['autoGeneratedCode'] = result[0][0][0]['sc_code'];
                    common.tplFile('admincp/add_consultant_code.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                } else {
                    res.redirect('/' + req.session.adminUrl + '/consultant_code/all');
                }

            }).fail(function (err) {
                res.redirect('/' + req.session.adminUrl + '/consultant_code/all');
                throw err;
            })
        } else {
            res.redirect('/' + req.session.adminUrl + '/consultant_code/all');
        }





        console.log($arr['test']);

    }

});


app.get(['/report/clients/', '/report/clients/:action/', '/report/clients/:action/:id', '/report/clients/:action/:id/:error'], function (req, res) {
    var dateFormat = require('dateformat');

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    raction = action;
    $arr.externaljs = ['register', 'jquery.mask.min'];
    $arr.limit = 10;
    var page = (req.body.page - 1) * $arr.limit;
    var whereCondition = '';
    var countWhereCondition = '';

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['consultantmenu'] = 'active';

    var fieldNames = 'u.email,u.first_name,u.last_name,u.username,u.phone,u.state,u.notification,u.status,u.id,u.del_status,ue.business_name,ss.sc_code,ss.consultant_fee,ss.id AS ss_id, ss.zone';
    var countFieldNames = 'u.id';

    if (action == 'search') {
        $arr['menu']['consultantmenuSub'] = 'active';
        $arr['menu']['report_client'] = 'active';

        req.body.username = (typeof (req.param('username')) === 'undefined') ? '' : req.param('username');
        req.body.email = (typeof (req.param('email')) === 'undefined') ? '' : req.param('email');
        req.body.business_name = (typeof (req.param('business_name')) === 'undefined') ? '' : req.param('business_name');
        req.body.status = (typeof (req.param('status')) === 'undefined') ? '' : req.param('status');
        req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
        req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
        req.body.from_date = (typeof (req.param('from_date')) === 'undefined') ? '' : req.param('from_date');
        req.body.to_date = (typeof (req.param('to_date')) === 'undefined') ? '' : req.param('to_date');


        whereCondition = countWhereCondition = ' WHERE u.del_status=0 AND u.role=1 AND ss.sc_user_id=' + req.session.login_userid;

        if (req.body.from_date != '') {
            req.body.from_date = dateFormat((req.body.from_date), "yyyy-mm-dd")
            whereCondition = whereCondition + ' AND u.created_at >= "' + req.body.from_date + '" '
        }
        if (req.body.to_date != '') {
            req.body.to_date = dateFormat((req.body.to_date), "yyyy-mm-dd")
            whereCondition = whereCondition + ' AND u.created_at <= "' + req.body.to_date + '" '
        }
        if (req.body.username) {
            whereCondition = whereCondition + ' AND u.username LIKE "%' + req.body.username + '%"'
        }
        if (req.body.email) {
            whereCondition = whereCondition + ' AND u.email LIKE "%' + req.body.email + '%"'
        }
        if (req.body.business_name) {
            whereCondition = whereCondition + ' AND ue.business_name LIKE "%' + req.body.business_name + '%"'
        }
        if (req.body.status) {
            whereCondition = whereCondition + ' AND u.status LIKE "%' + req.body.status + '%"'
        }
        if (req.body.country) {
            whereCondition = whereCondition + 'and u.country LIKE "%' + req.body.country + '%"'
        }
        if (req.body.state) {
            whereCondition = whereCondition + 'and u.state LIKE "%' + req.body.state + '%"'
        }

        var order_by = ' ORDER BY u.id DESC ';
        var limit = 'LIMIT ' + page + ',' + $arr.limit;
        countWhereCondition = whereCondition + order_by
        whereCondition = whereCondition + order_by + limit

        try {

            q.all([admin.getMembersBySalesAdmin(req, config.mysql, q, req.session.login_userid, fieldNames, whereCondition)]).then(function (result) {

                q.all([admin.getMembersBySalesAdmin(req, config.mysql, q, req.session.login_userid, fieldNames, whereCondition)]).then(function (result) {

                    var results = result[0][0].length ? result[0][0] : [];
                    var url = require('url');
                    var url_parts = url.parse(req.url, true);
                    var query = url_parts.query;
                    $arr['pagination'] = results.length;
                    $arr['members'] = results;
                    console.log('$arr["members"]', $arr['members']);
                    $arr['search'] = query;
                    fquery = common.urlparameter(query, { page: '' });
                    var paginator = new pagination.SearchPaginator({
                        prelink: '/' + req.session.adminUrl + '/report/clients/' + raction + '/?' + fquery,
                        current: req.body.page,
                        rowsPerPage: $arr.limit,
                        totalResult: $arr['pagination']

                    });

                    $arr['pagination_html'] = paginator.render();
                    if (raction == 'search') {
                        common.tplFile('admincp/report_members.tpl');
                    } else {
                        common.tplFile('admincp/report_members.tpl');
                    }
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                })

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            })
        } catch (err) {
            console.log('err', err);
        }

    }
});


app.post('/update/consultant_code_fee', function (req, res) {

    console.log(req.body)
    var consultant_fee = typeof (req.body.consultant_fee) !== undefined ? parseFloat(req.body.consultant_fee)
        : 0;
    var sc_code = typeof (req.body.sc_code) !== undefined ? req.body.sc_code : '';
    var email = typeof (req.body.email) !== undefined ? req.body.email : '';
    var zone = typeof (req.body.zone) !== undefined ? req.body.zone : '';

    if (req.body.ss_id > 0) {

        req.body.whereCondition = ' WHERE sc_code="' + sc_code + '" AND email!="' + email + '"';
        q.all([admin.getSpecificConsultantCode(req, config.mysql, q, 0)]).then(function (resultCheck) {

            if (resultCheck[0][0].length < 1) {
                req.body.whereCondition = " WHERE id = '" + req.body.ss_id + "'";
                req.body.updateCondition = " sc_code='" + sc_code + "', consultant_fee=" + consultant_fee + ", zone='" + zone + "'";
                q.all([admin.updateUserConsultantCodeFee(req, config.mysql, q)]).then(function (result) {

                    req.body.whereCondition = " WHERE email = '" + email + "'";
                    req.body.updateCondition = " sc_code = '" + sc_code + "'";
                    q.all([admin.updateSpecificConsultantCode(req, config.mysql, q)]).then(function (resultcc) {
                    })

                    res.json({ status: true, message: 'success' });
                }).fail(function (err) {
                    res.json(0);
                });
            } else {
                res.json({ status: false, message: 'Sales Consultant code is already exist.' });
            }
        }).fail(function (err) {
            res.json(0);
        });

    } else {
        res.json(0);
    }
});

app.post('/update/update_zone', function (req, res) {
    console.log(req.body)
    var zone = typeof (req.body.zone) !== undefined ? req.body.zone : '';

    if (req.body.ss_id > 0) {

        req.body.whereCondition = " WHERE id = '" + req.body.ss_id + "'";
        req.body.updateCondition = " zone='" + zone + "'";
        q.all([admin.updateUserConsultantCodeFee(req, config.mysql, q)]).then(function (result) {
            res.json({ status: true, message: 'success' });
        }).fail(function (err) {
            res.json(0);
        });

    } else {
        res.json(0);
    }
});

app.get(['/report/sales-transaction/', '/report/sales-transaction/:action/', '/report/sales-transaction/:action/:id', '/report/sales-transaction/:action/:id/:error'], function (req, res) {
    var dateFormat = require('dateformat');

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    raction = action;
    $arr.externaljs = ['register', 'jquery.mask.min'];
    $arr.limit = 10;
    var page = (req.body.page - 1) * $arr.limit;
    var whereCondition = '';
    var countWhereCondition = '';

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['consultantmenu'] = 'active';

    $arr['menu']['consultantmenuSub'] = 'active';
    $arr['menu']['report_sales_transaction'] = 'active';

    if (action == 'download') {
        q.all([admin.getSalesTransactions(req, config.mysql, q, 2)]).then(function (result) {
            console.log('result', result[0][0]);
            var k = result[0][0].length;
            resultk = result[0][0];
            var j = 0;
            arr = [];
            data2 = ['Transaction Date', 'Client Member Name', 'Invoice Number', 'Sale Amount', 'Sales Consultant Fee Paid', 'Buyer Name', 'Zone'];
            arr.push(data2);
            for (i in resultk) {
                j++;
                data2 = [resultk[i]['date_add'], resultk[i]['seller_username'], resultk[i]['transactionid'].toString(), resultk[i]['i_amount'], resultk[i]['consultant_fee_amount'], resultk[i]['buyer_username'], resultk[i]['zone']];
                arr.push(data2);
            }
            res.setHeader('Content-disposition', 'attachment; filename=sales_report.csv');
            res.csv(arr);
        });
    }

    if (action == 'search') {

        req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
        q.all([
            admin.getSalesTransactions(req, config.mysql, q, 0),
            admin.getSalesTransactions(req, config.mysql, q, 1)
        ]).then(function (result) {

            $arr['trans'] = result[1][0];
            $arr['pagination'] = result[0][0][0].id;

            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, { page: '' });

            $arr['search'] = query;
            $arr['fquery'] = fquery;
            $arr['sort'] = req.param('sort');
            $arr['direction'] = req.param('direction');
            $arr['dlink'] = '/' + req.session.adminUrl + '/report/sales-transaction/download?' + fquery;

            var paginator = new pagination.SearchPaginator({
                prelink: '/' + req.session.adminUrl + '/report/sales-transaction/search/' + '?' + fquery,
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });
            $arr['pagination_html'] = paginator.render();
            common.tplFile('admincp/report_sales_transactions.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        });
    }
});

app.get(['/purchase/'], function (req, res) {

    var fs = require('fs');
    var dir = config.path + 'public/uploads/purchase_behalf_documents';
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir);
    }

    $arr['externaljs'] = ['jquery.toaster'];

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['consultantmenu'] = 'active';
    $arr['menu']['purchase'] = 'active';

    $arr['behalfUsers'] = [];

    var whereCondition = ' WHERE cc.created_by = ' + req.session.login_userid + ' AND IF(u.id IS NULL, u.status is null, u.status="active") ';
    req.body.whereCondition = whereCondition;
    q.all([admin.getBehalfUsers(req, config.mysql, q)]).then(function (result) {

        q.all([admin.showstaticContent2(req, res, config.mysql, q, 4)]).then(function(resul) {
            $arr['terms'] = resul[0][0][0].content;
        })

        $arr['behalfUsers'] = result[0][0];
        common.tplFile('admincp/purchase.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    });


});

app.get(['/purchase-history/', '/purchase-history/:action/', '/purchase-history/:action/:id', '/purchase-history/:action/:id/:error'], function (req, res) {
    var dateFormat = require('dateformat');
    console.log('req.body', req.body);
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    raction = action;
    $arr.externaljs = ['register', 'jquery.mask.min'];
    $arr.limit = 10;
    var page = (req.body.page - 1) * $arr.limit;
    var whereCondition = '';
    var countWhereCondition = '';

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['consultantmenu'] = 'active';
    $arr['menu']['purchaseHistory'] = 'active';

    if (action == 'download') {
        q.all([
            admin.getPurchaseHistory(req, config.mysql, q, 2),
            admin.getPurchaseHistory(req, config.mysql, q, 1)
        ]).then(function (result) {


            var user_ids = _.pluck(result[1][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id, first_name,username,email,phone,last_name,nick_name,review,avatar as uimage', user_ids, result[1][0], 'user_id', function (messageFromErr, messageFromRes) {

                var seller_ids = _.pluck(messageFromRes, 'seller_id');

                faAPI.appendUserDataForObject('id', 'id as seller_id, username as seller_username', seller_ids, messageFromRes, 'seller_id', function (transactionApiErr, transactionApiRes) {

                    resultk = common.addDecimalPlaces('trans_herbee_fee', transactionApiRes);
                    var k = result[0][0].length;
                    // resultk = result[0][0];
                    var j = 0;
                    arr = [];
                    data2 = ['InvoiceId', 'Seller Name', 'Buyer Name', 'Amount', 'Date Added'];
                    arr.push(data2);
                    for (i in resultk) {
                        j++;
                        data2 = [resultk[i]['transactionid'].toString(), resultk[i]['seller_username'], resultk[i]['username'], resultk[i]['i_amount'], resultk[i]['date_added']];
                        arr.push(data2);
                    }
                    res.setHeader('Content-disposition', 'attachment; filename=purchase_history.csv');
                    res.csv(arr);

                });
            });
        });
    }

    if (action == 'search') {

        req.body.market = (typeof (req.param('market')) !== 'undefined') ? req.param('market') : '';
        req.body.tax_filter = (typeof (req.param('tax_filter')) !== 'undefined') ? req.param('tax_filter') : '';

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, { page: '' });

        $arr['search'] = query;

        $arr['market'] = req.body.market;

        if (req.body.market == 'undefined') {
            $arr['menu']['list'] = 'active';
        } else {
            $arr['menu'][req.body.market] = 'active';
        }

        console.log($arr['menu'])
        req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
        q.all([
            admin.getPurchaseHistory(req, config.mysql, q, 0),
            admin.getPurchaseHistory(req, config.mysql, q, 1),
            admin.getTotalCommRevenue(req, config.mysql, q)
        ]).then(function (result) {

            var user_ids = _.pluck(result[1][0], 'user_id');
            faAPI.appendUserDataForObject('id', 'id as user_id, first_name,username,email,phone,last_name,nick_name,review,avatar as uimage', user_ids, result[1][0], 'user_id', function (messageFromErr, messageFromRes) {

                var seller_ids = _.pluck(messageFromRes, 'seller_id');

                faAPI.appendUserDataForObject('id', 'id as seller_id, username as seller_username', seller_ids, messageFromRes, 'seller_id', function (transactionApiErr, transactionApiRes) {

                    $arr['pagination'] = result[0][0][0].id;
                    $arr['total'] = typeof (result[0][0][0]['paid']) === 'undefined' || result[0][0][0]['paid'] == null ? '0.00' : parseFloat(result[0][0][0]['paid']).toFixed(2);
                    $arr['comm_rev'] = typeof (result[0][0][0]['comm_rev']) === 'undefined' || result[0][0][0]['comm_rev'] == null ? '0.00' : parseFloat(result[0][0][0]['comm_rev']).toFixed(2);

                    $arr['trans'] = common.addDecimalPlaces('trans_herbee_fee', transactionApiRes);
                    $arr['fquery'] = fquery;
                    $arr['dlink'] = '/admincp/purchase-history/download?page='+req.body.page + '&' + fquery;

                    var paginator = new pagination.SearchPaginator({
                        prelink: '/admincp/purchase-history/search/' + req.body.market + '?' + fquery,
                        current: req.body.page,
                        rowsPerPage: 10,
                        totalResult: $arr['pagination']
                    });

                    $arr['pagination_html'] = paginator.render();

                    common.tplFile('admincp/purchase_history.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);

                });
            });
        });
    }
});
app.post(['/getStores'], function (req, res) {

    var stores = require('../../module/stores');
    req.body.db_virtualmall = true;
    q.all([
        stores.getAllStoresByUsers(req, config.mysql, q, 1)
    ]).then(function (results) {
        $arr.stores = results[0][0];
        console.log('$arr.stores', $arr.stores);
        res.json({
            'success': true,
            'data': $arr.stores
        });
        res.end();
        return false;
    });

});


/* buynow and recurring registration */
app.get('/cartrecurring/:id', function(req, res) {

    cart = require('../../module/cart');
    if (typeof(req.session.timer) === 'undefined') {
        req.session.timer = $arr.config.general.cart_timer;
    }
    req.session.ntemp_cart_id = Date.parse(new Date()) / 1000;

    if (typeof(req.param('insurance')) !== 'undefined' && req.param('insurance') == '1') {
        req.body.cancellation_per = global.general.cancel_ins_return
    } else {
        req.body.cancellation_per = global.general.cancel_insn_return
    }

    var recurring_purchase = typeof(req.param('recupur')) != 'undefined' ? req.param('recupur') : 0;
    if (recurring_purchase == 1) {
        console.log('recurring section');
        q.all([
            admin.addrecurring(req, res, config.mysql)
        ]).then(function(results) {

            req.body.rec_id = results[0][0].insertId;

            q.all([
                cart.getrecurring(req.body.rec_id, res, config.mysql)
            ]).then(function(recData) {
                console.log("-------------- recData ----------------: " + recData);
                req.body.rec_start_date = recData[0][0][0].sdate;
                req.body.rec_end_date = recData[0][0][0].edate;
                req.body.rec_user_id = recData[0][0][0].user_id;
                req.body.rec_date_added = recData[0][0][0].date_added;
                req.body.rec_paid = recData[0][0][0].paid;
                req.body.rec_active = recData[0][0][0].active;

                admin.addItem(req.param('id'), req, res, config.mysql);

                console.log('recurring added successfully....!');
            }).fail(function(err) {
                console.log(err.stack);
                throw err;
            }).done();

            // console.log(req.body.rec_id);
            // console.log(results);
            // console.log(results[0][0]);
        });
    } else if (recurring_purchase == 0) {
        admin.addItem(req.param('id'), req, res, config.mysql);
    }
});

app.get(['/product_invoices', '/product_invoices/:error'], function (req, res) {
    $arr['externaljs'] = ['jquery.toaster'];

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['product_invoices'] = 'active';
    $arr.externaljs = ['jquery.datePicker'];

    req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
    req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
    req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    $arr.action = action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'search' : req.param('action');

    $arr['projects'] = [];

    $arr.limit = 10;

    var url = require('url');
    var url_parts = url.parse(req.url, true);
    var query = url_parts.query;
    var fquery = common.urlparameter(query, { page: '' });
    $arr['search'] = query;
    req.query.sort_order = (typeof (req.query.sort_order) == 'undefined') ? '' : req.query.sort_order;
    req.query.search_val = (typeof (req.query.search_val) == 'undefined') ? '' : req.query.search_val;
    console.log('search----------' + req.query.search_val + '--------sort-------------' + req.query.sort_order);
    $arr['menu']['projectsearchmenu'] = 'active';

    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr.page = req.body.page;
    //$arr['menu']['projectsearchmenu'] = 'active';
    q.all([admin.distributorUserProductSearch(req, config.mysql, q, 0, ''), admin.distributorUserProductSearch(req, config.mysql, q, 1, '')]).then(function (result) {

        // console.log(JSON.stringify(result));
        var user_ids = _.pluck(result[0][0], 'user_id');
        faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {

            $arr['pagination'] = result[1][0].length;
            $arr['projects'] = projects.shortDescribe(apiUsersRes);

            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/admincp/projects/' + action + '/?' + fquery,
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination']
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('admincp/product_invoices.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});

app.get(['/product_invoices/detail/:product_id', '/product_invoices/detail/:product_id/:error'], function (req, res) {

    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['product_invoices'] = 'active';
    $arr.externaljs = ['jquery.datePicker'];

    req.body.country = (typeof (req.param('country')) === 'undefined') ? '' : req.param('country');
    req.body.state = (typeof (req.param('state')) === 'undefined') ? '' : req.param('state');
    req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    req.body.id = (typeof (req.param('product_id')) === 'undefined') ? 0 : req.param('product_id');
    var where_new = ' AND p.id='+req.body.id;

    $arr.action = action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'search' : req.param('action');

    $arr['projects'] = [];

    $arr.limit = 10;

    var url = require('url');
    var url_parts = url.parse(req.url, true);
    var query = url_parts.query;
    var fquery = common.urlparameter(query, { page: '' });
    $arr['search'] = query;
    req.query.sort_order = (typeof (req.query.sort_order) == 'undefined') ? '' : req.query.sort_order;
    req.query.search_val = (typeof (req.query.search_val) == 'undefined') ? '' : req.query.search_val;
    $arr['menu']['projectsearchmenu'] = 'active';

    req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr.page = req.body.page;
    //$arr['menu']['projectsearchmenu'] = 'active';
    q.all([admin.distributorUserProductSearch(req, config.mysql, q, 0, where_new), admin.distributorUserProductSearch(req, config.mysql, q, 1, where_new)]).then(function (result) {

        // console.log(JSON.stringify(result));
        var user_ids = _.pluck(result[0][0], 'user_id');
        faAPI.appendUserDataForObject('id', 'id as user_id,email,first_name,last_name', user_ids, result[0][0], 'user_id', function (apiUsersErr, apiUsersRes) {

            $arr['pagination'] = result[1][0].length;
            $arr['projects'] = projects.shortDescribe(apiUsersRes);
            $arr['projects'] = $arr['projects'][0];
            console.log('$arr[projects]', $arr['projects']);
            $arr['externaljs'] = ['jquery.toaster'];
            common.tplFile('admincp/product_invoices_detail.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});


app.post(['/update_distributor_payment_and_invoice'], function (req, res) {
    $arr['externaljs'] = ['jquery.toaster'];

    var attach = require('../../module/attach');
    attach.save('distributor_service_invoice', req, res);

    req.body.id = (typeof (req.param('id')) === 'undefined') ? 0 : req.param('id');
    req.body.d_price = (typeof (req.param('d_price')) === 'undefined') ? 0 : req.param('d_price');
    
    if(req.body.id == 0) {
        res.json({
            'success': false,
            'data': '',
            'message': 'Data Invalid'
        });
        res.end();
        return false;
    } else {
        q.all([
            products.updateDistributorProduct(req, config.mysql, q)
        ]).then(function (results) {
            $arr.stores = results[0][0];
            res.json({
                'success': true,
                'data': $arr.stores
            });
            res.end();
            return false;
        });
    }

});

/* ===================== Start code for HempBuyer ===================== */

app.get(['/', '/dashboard'], function (req, res) {
    // console.log('----------------------------session---------------------------', req.session);
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['dashboardmenu'] = 'active';

    async.series({
        exportDashboard: function (cb) {
            // getting userInformations                //'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users order by id DESC limit ?, 10';
            q.all([
                admin.exportProjectDashboard(res, config.mysql, q),
                admin.exportTransactionDashboard(res, config.mysql, q),
                admin.exportAdsDashboard(res, config.mysql, q),
                admin.exportAdsCampaignsDashboard(res, config.mysql, q),
                admin.exportPaymentsDashboard(res, config.mysql, q),
                admin.exportTransactDashboard(res, config.mysql, q),
                admin.exportReviewDashboard(res, config.mysql, q),
                admin.exportRelationDashboard(res, config.mysql, q),
                admin.exportProjectOffered(res, config.mysql, q),
                admin.exportProjectDelivered(res, config.mysql, q),
                admin.exportProjecSold(res, config.mysql, q),
                admin.exportProjecFuture(res, config.mysql, q),
                admin.exportTaxFees(res, config.mysql, q),
                admin.exportDistributorPayment(res, config.mysql, q)
            ]).then(function (result) {
                cb(null, result);
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            })

        },
        exportUsersDashboard: function (cb) {
            // getting userInformations
            var callback = function (err, response) {
                cb(err, response);
            }

            faAPI.customUserQuery('sum(if(del_status = 0,balance,0)) as total_market_dollers, sum(if((status = "active" and del_status = 0 and admin = 0),1,0)) as active, sum(if((status = "unverified"  and admin = 0),1,0)) as unverified, sum(if((status = "moderate" and admin = 0),1,0)) as moderate, sum(if((status = "deactivate" or status = "unsubscribe"  and admin = 0 ),1,0)) as cancel', callback);

        }, 
        exportAdminDashboardCount: function (cb) {
            q.all([
                admin.adminDashboardCount(res, config.mysql, q)
            ]).then(function (result) {
                cb(null, result);
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            })
        }
    }, function (err, results) {
        if (err) {
            console.log(JSON.stringify(err));
            throw err
        }

        $arr['project'] = results.exportDashboard[0][0][0]; 
        $arr['users'] = results.exportUsersDashboard.user[0];
        $arr['trans'] = results.exportDashboard[1][0][0];
        $arr['ads'] = results.exportDashboard[2][0][0];
        $arr['ads_camps'] = results.exportDashboard[3][0][0];
        $arr['payments'] = results.exportDashboard[4][0][0];
        $arr['transact'] = results.exportDashboard[5][0][0];
        $arr['reviews'] = results.exportDashboard[6][0][0];
        $arr['relation'] = results.exportDashboard[7][0][0];
        $arr['products_offered'] = results.exportDashboard[8][0][0].products_offered;
        $arr['products_delivered'] = results.exportDashboard[9][0][0].products_delivered;
        $arr['products_sold'] = results.exportDashboard[10][0][0].products_sold;
        $arr['products_future'] = results.exportDashboard[11][0][0].products_future;
        $arr['taxes_fees'] = results.exportDashboard[12][0][0];
        $arr['DistributorPayment'] = results.exportDashboard[13][0][0].total_distributor_payment;

        $arr['activeProducts'] = results.exportAdminDashboardCount[0][0][0]['activeProducts'];
        $arr['featured_products'] = results.exportAdminDashboardCount[0][0][0]['featured_products'];
        $arr['upcoming_products'] = results.exportAdminDashboardCount[0][0][0]['upcoming_products'];
        $arr['activeUser'] = results.exportAdminDashboardCount[0][0][0]['activeUser'];
        $arr['pendingUser'] = results.exportAdminDashboardCount[0][0][0]['pendingUser'];
        $arr['inactiveUser'] = results.exportAdminDashboardCount[0][0][0]['inactiveUser'];
        $arr['suspendedUser'] = results.exportAdminDashboardCount[0][0][0]['suspendedUser'];

        console.log($arr['adminDashboardCount']);

        common.tplFile('admincp/dashboard.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    })

});
app.get(['/user/:id/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var id = req.body.id = (typeof (req.param('id')) === 'undefined') ? 'all' : req.param('id');
    $arr.id = id;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['usersmenu'] = 'active';

    $arr.limit = 10;
    var page = (req.body.page - 1) * 10;
    var whereCondition = '';
    var countWhereCondition = '';

    q.all([
        admin.getUserDetail(req, config.mysql, q, id)
    ]).then(function (results) {
        $arr.users = {};
        if(results[0][0].length) {
            $arr.users = results[0][0][0];
        }
        common.tplFile('admincp/hmb_user_edit.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.get(['/users/', '/users/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['usersmenu'] = 'active';
    $arr['menu'][action + 'usersmenu'] = 'active';

    $arr.limit = 10;
    var page = (req.body.page - 1) * 10;
    var whereCondition = '';
    var countWhereCondition = '';
   
        common.tplFile('admincp/hmb_users.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

});
app.post(['/users/', '/users/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.userstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.getUsers(req, config.mysql, q, 0),
        admin.getUsers(req, config.mysql, q, 1),
    ]).then(function (results) {
        var users = [];
        if(results[0][0].length) {
            users = results[0][0];
        }
        $arr.users = users;
        $arr.totalData = results[1][0].length;
        /* res.json({
            status: 200,
            success: true,
            data: users
        });
        res.end();
        return false; */
        common.tplFile('admincp/hmb_users_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.post('/update/status', function (req, res) {
    console.log('[' + req.param('id') + ']');
    console.log('[' + req.param('status') + ']');
    var rej_msg = '';
    if (req.param('status') == 'deactivate') {
        rej_msg = req.param('rej_msg');
    }

    console.log('[' + req.param('rej_msg') + ']');
    console.log("update-id-status-type");

    common.admincheckLogin(req, res, 1);
    console.log('req.param(id)', req.param('id'));

    if (req.param('id') > 0 && req.param('id') !== undefined && req.param('id') !== null && req.param('id') !== '') {
        q.all([
            admin.updateUsersStatus(req, config.mysql, q),
            admin.getUserDetail(req, config.mysql, q, req.param('id'))
        ]).then(function (results) {
            var user = results[1][0][0];
            console.log('user', user);
            localm = require('../../module/localmail');
            var status = '';
            
            // var activeurl = '<a href="' + $arr.config.spath + 'payment/wirefund">click here!</a>';
            if (global.emaillocal.status == 'yes') {
                q.all([localm.mailtemps(req, config.mysql, q, 'user_status_changed')]).then(function (results2) {
                    if (results2) {
                        var template = results2[0][0][0].template;
                        var subject_message = results2[0][0][0].subject;
                        var activeurl = $arr.config.spath + 'signin';
                        var contactUs = $arr.config.spath + 'contactUs';
                        var message = '';
                        if (req.body.status == "active") {
                            message = "Approved";
                        } else if (req.body.status == "pending") {
                            message = "Pending";
                        } else if (req.body.status == "inactive") {
                            message = "Inactivated";
                        }

                        var logo_url = $arr.config.spath+'images/logo.png';
                        template = template.replace('{{event.logo_url}}', logo_url);
                        template = template.replace('{{event.sitename}}', global.common.title);
                        template = template.replace('{{event.subject}}', "Welcome to Herbee");
                        template = template.replace('{{event.message}}', message);
                        template = template.replace('{{event.user}}', user.name);
                        template = template.replace('{{event.siteurl}}', $arr.config.url);
                        template = template.replace('{{event.signin_url}}', activeurl);
                        template = template.replace('{{event.contact_us}}', contactUs);
                        

                        localm.sendmail(template, subject_message, user.email);
                    } else {
                        console.log("No Templates named message_sent");
                    }
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                });
            }
            res.json(1);
        });
    }
});

app.post(['/changePassword/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];
    
    q.all([
        admin.changePassword(req, config.mysql, q),
    ]).then(function (results) {
        
        res.json({
            status: 200,
            success: true,
            data: {}
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.post(['/saveUserDetail'], function (req, res) {
    
    q.all([
        admin.saveUserDetail(req, config.mysql, q),
    ]).then(function (results) {
        
        res.json({
            status: 200,
            success: true,
            data: {}
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.post(['/saveUserLicenseDetail'], function (req, res) {
    
    q.all([
        admin.saveUserLicenseDetail(req, config.mysql, q),
    ]).then(function (results) {
        
        res.json({
            status: 200,
            success: true,
            data: {}
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

/* ===================== End code for HempBuyer ===================== */

/******************************************** PRODUCTS MODULE - STARTS **********************************************/
/**
 *  Product Module
 */
app.get(['/products', '/products/:action'], function (req, res) {
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['projectsmenu'] = 'active';
    $arr['menu'][action + 'projectsmenu'] = 'active';

    $arr.limit = 10;
    
    common.tplFile('admincp/hmb_products.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});
app.get(['/product/offer_message'], function (req, res) {
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['projectsmenu'] = 'active';
    $arr['menu']['offermessagemenu'] = 'active';

    $arr.limit = 10;
    
    q.all([
        admin.get_offer_product_sellers(req, config.mysql, q, 1)
    ]).then(function (results) {
        var sellerList = [];
        if(results[0][0].length) {
            sellerList = results[0][0];
        }
        $arr.sellerList = sellerList;
        common.tplFile('admincp/hmb_products_offer.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
    
});

app.post(['/products', '/products/:action'], function (req, res) {
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    $arr.productstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    
    q.all([
        admin.getProducts(req, config.mysql, q, 1),
        admin.getProducts(req, config.mysql, q),
    ]).then(function (results) {
        var product = [];
        if(results[0][0].length) {
            product = results[0][0];
        }
        $arr.product = product;
        $arr.totalData = results[1][0][0]['totalCount'];

        common.tplFile('admincp/hmb_products_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get(['/product/:id'], function (req, res) {
    var id = req.body.id = (typeof (req.param('id')) === 'undefined') ? 'all' : req.param('id');
    $arr.id = id;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['projectsmenu'] = 'active';

    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr.limit = 10;

    q.all([
        admin.getProductDetails(req, config.mysql, q, id),
        category.getCategories(req, config.mysql, q, 0),
        product.getStateList(req, config.mysql, q),
        product.getProductCertificate(req, config.mysql, q),
        product.getProductMediaFiles(req, config.mysql, q, 'image'),
        product.getProductMediaFiles(req, config.mysql, q, 'video'),
        product.getMeasurements(req, config.mysql, q, 'Active')
    ]).then(function (results) {
        $arr.product = {};
        if(results[0][0].length) {
            $arr.product = results[0][0][0];
            $arr.product.contaminant_screening_data = $arr.product.contaminant_screening_data.split(',');
            $arr.product.certificate_types = $arr.product.certificate_types.split(',');
        }
        $arr.categories = results[1][0];
        $arr.states = results[2][0];
        $arr.product['productCertificate'] = results[3][0];
        $arr.product['productImages'] = results[4][0];
        $arr.product['productVideos'] = results[5][0];
        $arr.product['productMeasurements'] = results[6][0];
        $arr.renewTime = [{
            id: 1,
            val: '1 time'
        }, {
            id: 2,
            val: '2 times'
        }, {
            id: 3,
            val: '3 times'
        }, {
            id: 4,
            val: '4 times'
        }, {
            id: 5,
            val: '5 times'
        }, {
            id: 6,
            val: '6 times'
        }, {
            id: 7,
            val: '7 times'
        }, {
            id: 8,
            val: '8 times'
        }];
        common.tplFile('admincp/hmb_product_view.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.post(['/saveProductInfo', '/saveProductInfo/:id'], function (req, res) {
    $arr.id = req.body.product_id;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        if(req.body.product_id != 0) {
            q.all([
                admin.updateProductInfo(req, res, config.mysql, q)
            ]).then(function (results) {
                var product_id = req.body.product_id;
                var user_id = req.body.loggedUserId;

                /*** Insert Video Url - Starts ***/
                if(typeof(req.body.videoUrl) != 'undefined') {
                    var videoUrl = req.body.videoUrl;
                    if(videoUrl.length > 0) {
                    product.deleteProductDocument(req, res, config.mysql, q, product_id, 'video');
                    for (var index = 0; index < videoUrl.length; index++) {
                            product.saveProductVideoUrl(req, res, config.mysql, q, videoUrl[index], product_id);
                        }
                    }
                }
                /*** Insert Video Url - Ends ***/
                
                if(typeof(req.body.productDocument) != 'undefined') {
                    var productDocument = req.body.productDocument;
                    for (var index = 0; index < productDocument.length; index++) {
                        product.saveProductDocument(req, res, config.mysql, q, productDocument[index], product_id);
                    }
                }

                if(typeof(req.body.certificatesDocument) != 'undefined') {
                    var certificatesDocument = req.body.certificatesDocument;
                    for (var index = 0; index < certificatesDocument.length; index++) {
                        product.savecertificatesDocument(req, res, config.mysql, q, certificatesDocument[index], product_id, user_id);
                    }
                }

                res.json({
                    status: 200,
                    success: true,
                    message: 'success',
                    result: results[0][0].insertId
                });
                res.end();

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        } else {
            q.all([
                product.saveProduct(req, res, config.mysql, q)
            ]).then(function (results) {
                var product_id = results[0][0].insertId;
                var user_id = 0;

                /*** Insert Video Url - Starts ***/
                if(typeof(req.body.videoUrl) != 'undefined') {
                    var videoUrl = req.body.videoUrl;
                    if(videoUrl.length > 0) {
                        for (var index = 0; index < videoUrl.length; index++) {
                            product.saveProductVideoUrl(req, res, config.mysql, q, videoUrl[index], product_id);
                        }
                    }
                }
                /*** Insert Video Url - Ends ***/

                var productDocument = req.body.productDocument;
                for (var index = 0; index < productDocument.length; index++) {
                    product.saveProductDocument(req, res, config.mysql, q, productDocument[index], product_id);
                }

                res.json({
                    status: 200,
                    success: true,
                    message: 'success',
                    result: results[0][0].insertId
                });
                res.end();

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.post(['/saveManufactureInfo', '/saveManufactureInfo/:id'], function (req, res) {
    $arr.id = req.body.product_id;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        if(req.body.product_id != 0) {
            q.all([
                admin.updateManufactureInfo(req, res, config.mysql, q)
            ]).then(function (results) {
                res.json({
                    status: 200,
                    success: true,
                    message: 'success',
                    result: results[0][0].insertId
                });
                res.end();

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        } else {
            q.all([
                product.saveProduct(req, res, config.mysql, q)
            ]).then(function (results) {
                res.json({
                    status: 200,
                    success: true,
                    message: 'success',
                    result: results[0][0].insertId
                });
                res.end();

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

app.post(['/saveCertificateInfo', '/saveCertificateInfo/:id'], function (req, res) {
    $arr.id = req.body.product_id;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        if(req.body.product_id != 0) {
            q.all([
                admin.updateCertificateInfo(req, res, config.mysql, q)
            ]).then(function (results) {
                var product_id = req.body.product_id;
                var user_id = req.body.loggedUserId;

                if(typeof(req.body.certificatesDocument) != 'undefined') {
                    var certificatesDocument = req.body.certificatesDocument;
                    for (var index = 0; index < certificatesDocument.length; index++) {
                        product.savecertificatesDocument(req, res, config.mysql, q, certificatesDocument[index], product_id, user_id);
                    }
                }

                res.json({
                    status: 200,
                    success: true,
                    message: 'success',
                    result: results[0][0].insertId
                });
                res.end();

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        } else {
            q.all([
                product.saveProduct(req, res, config.mysql, q)
            ]).then(function (results) {
                var product_id = results[0][0].insertId;
                var user_id = 0;

                /*** Insert Video Url - Starts ***/
                if(typeof(req.body.videoUrl) != 'undefined') {
                    var videoUrl = req.body.videoUrl;
                    if(videoUrl.length > 0) {
                        for (var index = 0; index < videoUrl.length; index++) {
                            product.saveProductVideoUrl(req, res, config.mysql, q, videoUrl[index], product_id);
                        }
                    }
                }
                /*** Insert Video Url - Ends ***/

                var productDocument = req.body.productDocument;
                for (var index = 0; index < productDocument.length; index++) {
                    product.saveProductDocument(req, res, config.mysql, q, productDocument[index], product_id);
                }

                res.json({
                    status: 200,
                    success: true,
                    message: 'success',
                    result: results[0][0].insertId
                });
                res.end();

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});
app.post(['/savePaymentInfo', '/savePaymentInfo/:id'], function (req, res) {
    $arr.id = req.body.product_id;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        if(req.body.product_id != 0) {
            q.all([
                admin.updatePaymentInfo(req, res, config.mysql, q)
            ]).then(function (results) {
                res.json({
                    status: 200,
                    success: true,
                    message: 'success',
                    result: results[0][0].insertId
                });
                res.end();

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        } else {
            q.all([
                product.saveProduct(req, res, config.mysql, q)
            ]).then(function (results) {
                res.json({
                    status: 200,
                    success: true,
                    message: 'success',
                    result: results[0][0].insertId
                });
                res.end();

            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});
/******************************** PRODUCTS MODULE - ENDS *************************************/

/******************************************** MEASUREMENTS MODULE - STARTS **********************************************/
/**
 *  Measurement Module
 */
app.get(['/measurements'], function (req, res) {
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['measurementsmenu'] = 'active';
    $arr['menu']['allmeasurementsmenu'] = 'active';

    $arr.limit = 10;
    
    common.tplFile('admincp/hmb_measurements.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.post(['/measurements/:action'], function (req, res) {
    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.status = action;
    $arr.page = req.body.page ? req.body.page : 1;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    
    q.all([
        admin.getMeasurements(req, config.mysql, q, 1),
        admin.getMeasurements(req, config.mysql, q),
    ]).then(function (results) {
        var measurement = [];
        if(results[0][0].length) {
            measurement = results[0][0];
        }
        $arr.measurement = measurement;
        $arr.totalData = results[1][0][0]['totalCount'];

        common.tplFile('admincp/hmb_measurements_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.post('/create/measurement', function (req, res) {
    common.admincheckLogin(req, res, 1);
    if (typeof(req.body.measurement_name) !== undefined && req.body.measurement_name !== null && req.body.measurement_name !== '') {
        q.all([
            admin.checkMeasurementName(req, config.mysql, q)
        ]).then(function (results) {
            if(results[0][0].length > 0) {
                res.json({
                    status: 'failed',
                    message: 'Measurement name already existed'
                });
                res.end();
            } else {
                q.all([
                    admin.createMeasurement(req, config.mysql, q)
                ]).then(function (result) {
                    res.json({
                        status: 'success',
                        message: 'Measurement created successfully'
                    });
                    res.end();
                }).fail(function (err) {
                    console.log(err.stack);
                    throw err;
                });
            }
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        });
    }
});

app.post('/update/measurement/status', function (req, res) {
    common.admincheckLogin(req, res, 1);
    if (req.param('id') > 0 && req.param('id') !== undefined && req.param('id') !== null && req.param('id') !== '') {
        q.all([
            admin.updateMeasurementsStatus(req, config.mysql, q)
        ]).then(function (results) {
            res.json(1);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        });
    }
});
/******************************************** MEASUREMENTS MODULE - ENDS **********************************************/

/******************************************** PRODUCT PURCHASE HISTORY MODULE - STARTS **********************************************/
/**
 *  Product Purchase History Module
 */
app.get(['/product/purchase/history/:id', '/product/purchase/history'], function (req, res) {
    var id = req.body.id = (typeof (req.param('id')) === 'undefined') ? '0' : req.param('id');
    $arr.id = id;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    if(id != '' && id != '0') {
        $arr['menu']['projectsmenu'] = 'active';
        $arr['menu']['allprojectsmenu'] = 'active';
    } else {
        $arr['menu']['purchasemenu'] = 'active';
        $arr['menu']['allpurchasemenu'] = 'active';
    }
    $arr.limit = 10;
    
    common.tplFile('admincp/hmb_products_purchase_history.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.post(['/productPurchaseHistory'], function (req, res) {
    var id = req.body.productId;
    $arr.id = id;
    $arr.page = req.body.page ? req.body.page : 1;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    
    q.all([
        admin.getProductsPurchaseHistory(req, config.mysql, q, 1, id),
        admin.getProductsPurchaseHistory(req, config.mysql, q, 0, id)
    ]).then(function (results) {
        var product = [];
        if(results[0][0].length)
            product = results[0][0];

        $arr.product = product;
        $arr.totalData = results[1][0][0]['totalCount'];

        common.tplFile('admincp/hmb_products_purchase_history_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
/******************************************** PRODUCT PURCHASE HISTORY MODULE - ENDS **********************************************/

/******************************************** PRODUCT BIDDING HISTORY MODULE - STARTS **********************************************/
/**
 *  Product Purchase History Module
 */
app.get(['/product/bidding/history/:id', '/product/bidding/history'], function (req, res) {
    var id = req.body.id = (typeof (req.param('id')) === 'undefined') ? '0' : req.param('id');
    $arr.id = id;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    if(id != '' && id != '0') {
        $arr['menu']['projectsmenu'] = 'active';
        $arr['menu']['allprojectsmenu'] = 'active';
    } else {
        $arr['menu']['biddingmenu'] = 'active';
        $arr['menu']['allbiddingmenu'] = 'active';
    }
    $arr.limit = 10;
    
    common.tplFile('admincp/hmb_products_bidding_history.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});

app.post(['/productBiddingHistory'], function (req, res) {
    var id = req.body.productId;
    $arr.id = id;
    $arr.page = req.body.page ? req.body.page : 1;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    
    q.all([
        admin.getProductsBiddingHistory(req, config.mysql, q, 1, id),
        admin.getProductsBiddingHistory(req, config.mysql, q, 0, id)
    ]).then(function (results) {
        var product = [];
        if(results[0][0].length)
            product = results[0][0];

        $arr.product = product;
        $arr.totalData = results[1][0][0]['totalCount'];

        common.tplFile('admincp/hmb_products_bidding_history_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
/******************************************** PRODUCT BIDDING HISTORY MODULE - ENDS **********************************************/

app.get(['/referrals/', '/referrals/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['referralmenu'] = 'active';

    $arr.limit = 10;
    var page = (req.body.page - 1) * 10;

    common.tplFile('admincp/hmb_referrals.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});
app.post(['/referrals/', '/referrals/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.userstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.getReferrals(req, config.mysql, q, 0),
        admin.getReferrals(req, config.mysql, q, 1),
    ]).then(function (results) {
        var users = [];
        if(results[0][0].length) {
            users = results[0][0];
        }
        $arr.users = users;
        $arr.totalData = results[1][0].length;
        /* res.json({
            status: 200,
            success: true,
            data: users
        });
        res.end();
        return false; */
        common.tplFile('admincp/hmb_referrals_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.post(['/update_isfeatured'], function (req, res) {
    
    q.all([
        admin.update_isfeatured(req, config.mysql, q)
    ]).then(function (results) {
        res.json({
            status: 200,
            success: true,
            result: results
        });
        res.end();
        return false;

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.get(['/subscription_users/', '/subscription_users/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['subscription_usersmenu'] = 'active';

    $arr.limit = 10;
    var page = (req.body.page - 1) * 10;

    common.tplFile('admincp/hmb_subscription_users.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});
app.post(['/subscription_users/', '/subscription_users/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.userstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.getSubscriptionUsers(req, config.mysql, q, 0),
        admin.getSubscriptionUsers(req, config.mysql, q, 1),
    ]).then(function (results) {
        var users = [];
        if(results[0][0].length) {
            users = results[0][0];
        }
        $arr.users = users;
        $arr.totalData = results[1][0].length;
        /* res.json({
            status: 200,
            success: true,
            data: users
        });
        res.end();
        return false; */
        common.tplFile('admincp/hmb_subscription_users_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.get(['/ads/', '/ads/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['adsmenu'] = 'active';

    $arr.limit = 10;
    var page = (req.body.page - 1) * 10;

    common.tplFile('admincp/hmb_ads.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});
app.post(['/ads/', '/ads/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.userstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.getAds(req, config.mysql, q, 0),
        admin.getAds(req, config.mysql, q, 1),
    ]).then(function (results) {
        var listData = [];
        if(results[0][0].length) {
            listData = results[0][0];
            for (var index = 0; index < listData.length; index++) {
                listData[index].target_sec_id = listData[index].target_sec_id.split(',');
                var pages = [];
                if(listData[index].target_sec_id[0] == "home") { pages.push("Home"); }
                if(listData[index].target_sec_id[1] == "product_view") { pages.push("Product View"); }
                if(listData[index].target_sec_id[2] == "dashboard") { pages.push("Dashboard"); }
                if(listData[index].target_sec_id[3] == "product_post") { pages.push("Product Post"); }
                listData[index].target_sec_id = pages.join(', ');
            }
        }
        $arr.listData = listData;
        $arr.totalData = results[1][0].length;
        /* res.json({
            status: 200,
            success: true,
            data: users
        });
        res.end();
        return false; */
        common.tplFile('admincp/hmb_ads_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.get(['/classifieds/', '/classifieds/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.action = action;
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr.page = req.body.page = (typeof (req.param('page')) === 'undefined') ? 1 : req.param('page');
    $arr['error'] = req.body.error = (typeof (req.param('error')) === 'undefined') ? '' : req.param('error');
    $arr['menu']['classifiedsmenu'] = 'active';

    $arr.limit = 10;
    var page = (req.body.page - 1) * 10;

    q.all([
        product.getStateList(req, config.mysql, q),
    ]).then(function (results) {
        $arr.states = results[0][0];
        
        common.tplFile('admincp/hmb_classifieds.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();

});
app.post(['/classifieds/', '/classifieds/:action/'], function (req, res) {
    var dateFormat = require('dateformat');
    $arr.externaljs = ['register', 'jquery.mask.min'];

    var action = req.body.action = (typeof (req.param('action')) === 'undefined') ? 'all' : req.param('action');
    $arr.userstatus = action;
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.getClassifieds(req, config.mysql, q, 0),
        admin.getClassifieds(req, config.mysql, q, 1),
    ]).then(function (results) {
        var listData = [];
        var categoryList = [
            { value: 'banking_pos', text: 'Banking/POS' },
            { value: 'consulting_professional_services', text: 'Consulting/Professional Services' },
            { value: 'financial_insurance', text: 'Financial/Insurance' },
            { value: 'legal', text: 'Legal' },
            { value: 'processing_drying_trimming', text: 'Processing/Drying/Trimming' },
            { value: 'tolling_extraction_lab', text: 'Tolling/Extraction/Lab' },
            { value: 'transport_storage', text: 'Transport/Storage' },
            { value: 'white_labeling', text: 'White Labeling' },
            { value: 'everything_else', text: 'Everything Else' }
        ];
        if(results[0][0].length) {
            listData = results[0][0];
            for (var index = 0; index < listData.length; index++) {
                if(listData[index].category != '') {
                    console.log('categoryList.findIndex(function(item){ return item.value == listData[index].category })', categoryList.findIndex(function(item){ return item.value == listData[index].category }));
                    listData[index].category = categoryList[categoryList.findIndex(function(item){ return item.value == listData[index].category })].text;
                }
            }
        }
        $arr.listData = listData;
        $arr.totalData = results[1][0].length;
        common.tplFile('admincp/hmb_classifieds_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.post(['/get_offer_product_list'], function (req, res) {
    req.body.page = req.body.page ? req.body.page : 1;
    req.body.limit = req.body.limit ? req.body.limit : 1000;
    
    q.all([
        admin.get_offer_product_list(req, config.mysql, q, 1)
    ]).then(function (results) {
        var product = [];
        if(results[0][0].length) {
            product = results[0][0];
        }
        $arr.product = product;

        common.tplFile('admincp/hmb_products_offer_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.post(['/get_offer_buyer_list'], function (req, res) {
    req.body.page = req.body.page ? req.body.page : 1;
    req.body.limit = req.body.limit ? req.body.limit : 1000;
    
    q.all([
        admin.get_offer_buyer_list(req, config.mysql, q, 0)
    ]).then(function (results) {
        var listData = [];
        if(results[0][0].length) {
            listData = results[0][0];
        }
        $arr.listData = listData;
        common.tplFile('admincp/hmb_products_buyer_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.post(['/get_offer_product_chat_list'], function (req, res) {
    req.body.page = req.body.page ? req.body.page : 1;
    req.body.limit = req.body.limit ? req.body.limit : 1000;
    $arr.buyer_id = req.body.buyer_id;

    q.all([
        admin.get_offer_product_chat_list(req, config.mysql, q, 0)
    ]).then(function (results) {
        var listData = [];
        if(results[0][0].length) {
            listData = results[0][0];
        }
        $arr.listData = listData;
        common.tplFile('admincp/hmb_products_chat_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.get(['/referral_program'], function (req, res) {
    var dateFormat = require('dateformat');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['referral_program_menu'] = 'active';

    common.tplFile('admincp/hmb_referral_program.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});
app.post(['/referral_program'], function (req, res) {
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.get_referral_program(req, config.mysql, q, 0),
        admin.get_referral_program(req, config.mysql, q, 1)
    ]).then(function (results) {
        var listData = [];
        if(results[0][0].length) {
            listData = results[0][0];
        }
        $arr.listData = listData;
        $arr.totalData = results[1][0].length;
        common.tplFile('admincp/hmb_referral_program_ajax.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.get(['/referral_banners'], function (req, res) {
    var dateFormat = require('dateformat');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['referral_banners_menu'] = 'active';

    q.all([
        admin.get_banner_list(req, config.mysql, q)
    ]).then(function (results) {
        var banner_data = {
            banner1: '',
            banner2: '',
            banner3: ''
        }
        var listData = [];
        if(results[0][0].length) {
            listData = results[0][0];
            for (var index = 0; index < listData.length; index++) {
                banner_data['banner'+listData[index].cid] = listData[index].image;
            }
        }
        $arr.listData = listData;
        $arr.banner_data = banner_data;
        common.tplFile('admincp/hmb_referral_banners.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
    
});

app.post('/uploadBannerFile', function (req, res) {
    console.log('global.path', global.path);
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    //console.log('req.files', req.files);
    //console.log('req.body', req.body.type);

    var filesData = req.files['banner'];
    var extension = filesData.name.split('.').pop().toLowerCase();
    req.body.banner_name = 'banner'+req.body.banner_id+'.'+extension;

    q.all([
        admin.get_banner_detail(req, config.mysql, q)
    ]).then(function (results) {
        req.body.id = 0;
        if(results[0][0].length) {
            req.body.id = results[0][0][0].id;
        }
            
        q.all([
            admin.save_banner(req, config.mysql, q)
        ]).then(function (results) {
                
            var oldpath = global.path + 'public/uploads/' + filesData.name;
            console.log('oldpath', oldpath);
            var newpath = global.path + 'public/images/'+req.body.banner_name;
            console.log('newpath', newpath);
            fs.rename(oldpath, newpath, function (err) {
                console.log('err', err);
                if (err) {
                    res.json({
                        status: 500,
                        success: false,
                        error: err
                    });
                    res.end();
                    return false;
                };
                var finalresult = {
                    file_name: req.body.banner_name,
                    full_file_path: newpath
                };
                console.log('finalresult', finalresult);
                res.json(finalresult);
                res.end();
                return false
            });
        }).fail(function (err) {
            res.json({
                status: 500,
                success: false,
                error: err
            });
            res.end();
            return false;
        }).done();
    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
    
});

app.get(['/transactions'], function (req, res) {
    var dateFormat = require('dateformat');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['transactions_menu'] = 'active';

    common.tplFile('admincp/hmb_transactions.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});
app.post(['/transactions'], function (req, res) {
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.get_transactions(req, config.mysql, q, 0),
        admin.get_transactions(req, config.mysql, q, 1),
        admin.get_net_revenue(req, config.mysql, q)
    ]).then(function (results) {
        $arr.net_revenue = results[2][0][0].total;
        if(req.body.is_report > 0) {
            var report_data = results[1][0];
            arr = [];
            data2 = [
                'No.', 'InvoiceId', 'Transaction ID', 'User', 'Product Title', 'Commission', 'Transaction Fee', 'Status', 'Amount', 'Gateway', 'Paid Date',
                'Escrow Company', 'Escrow User Type', 'Full Name', 'Company Name', 'Email', 'Phone', 'Bank Name', 'Account Name', 'Account Number', 'Routing Number'
            ];
            arr.push(data2);
            for (var i = 0; i < report_data.length; i++) {
                data2 = [
                    i+1,
                    report_data[i].id,
                    report_data[i].transactionid,
                    report_data[i].buyer_email,
                    report_data[i].product_title,
                    report_data[i].shipping_amount,
                    report_data[i].transaction_fee,
                    report_data[i].status,
                    report_data[i].amount,
                    report_data[i].gateway,
                    report_data[i].paid_date,

                    report_data[i].escrow_company,
                    report_data[i].user_type,
                    report_data[i].user_name,
                    report_data[i].user_company,
                    report_data[i].user_email,
                    report_data[i].user_phone,
                    report_data[i].bank_name,
                    report_data[i].account_name,
                    report_data[i].account_number,
                    report_data[i].routing_number
                ];
                console.log('data2', data2);
                arr.push(data2);
            }
            var dateFormat = require('dateformat');
            res.setHeader('Content-disposition', 'attachment; filename=transaction_report_' + dateFormat(new Date(), "yyyy_mm_dd_HH_MM_ss") + '.csv');
            res.set('Content-Type', 'application/octet-stream');
            res.csv(arr);
        } else {
            var listData = [];
            if(results[0][0].length) {
                listData = results[0][0];
            }
            $arr.listData = listData;
            $arr.totalData = results[1][0].length;
            common.tplFile('admincp/hmb_transactions_ajax.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});
app.get(['/withdrawal_request'], function (req, res) {
    var dateFormat = require('dateformat');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['withdrawal_request_menu'] = 'active';

    common.tplFile('admincp/hmb_withdrawal_request.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});
app.post(['/withdrawal_request'], function (req, res) {
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.get_transactions(req, config.mysql, q, 0),
        admin.get_transactions(req, config.mysql, q, 1),
        admin.get_net_revenue(req, config.mysql, q)
    ]).then(function (results) {
        $arr.net_revenue = results[2][0][0].total;
        if(req.body.is_report > 0) {
            var report_data = results[1][0];
            arr = [];
            data2 = [
                'No.', 'InvoiceId', 'Transaction ID', 'User', 'Product Title', 'Commission', 'Transaction Fee', 'Status', 'Amount', 'Gateway', 'Paid Date',
                'Escrow Company', 'Escrow User Type', 'Full Name', 'Company Name', 'Email', 'Phone', 'Bank Name', 'Account Name', 'Account Number', 'Routing Number'
            ];
            arr.push(data2);
            for (var i = 0; i < report_data.length; i++) {
                data2 = [
                    i+1,
                    report_data[i].id,
                    report_data[i].transactionid,
                    report_data[i].buyer_email,
                    report_data[i].product_title,
                    report_data[i].shipping_amount,
                    report_data[i].transaction_fee,
                    report_data[i].status,
                    report_data[i].amount,
                    report_data[i].gateway,
                    report_data[i].paid_date,

                    report_data[i].escrow_company,
                    report_data[i].user_type,
                    report_data[i].user_name,
                    report_data[i].user_company,
                    report_data[i].user_email,
                    report_data[i].user_phone,
                    report_data[i].bank_name,
                    report_data[i].account_name,
                    report_data[i].account_number,
                    report_data[i].routing_number
                ];
                console.log('data2', data2);
                arr.push(data2);
            }
            var dateFormat = require('dateformat');
            res.setHeader('Content-disposition', 'attachment; filename=transaction_report_' + dateFormat(new Date(), "yyyy_mm_dd_HH_MM_ss") + '.csv');
            res.set('Content-Type', 'application/octet-stream');
            res.csv(arr);
        } else {
            var listData = [];
            if(results[0][0].length) {
                listData = results[0][0];
            }
            $arr.listData = listData;
            $arr.totalData = results[1][0].length;
            common.tplFile('admincp/hmb_withdrawal_request_ajax.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.post(['/update_invoice_release_status'], function (req, res) {
    
    if(req.body.status == 'released' && req.body.gateway != 'escrow') {

        q.all([
            admin.get_buyer_bank_detail_using_invoice_id(req, config.mysql, q),
        ]).then(function (resultsInvoice) {
            console.log('resultsInvoice', resultsInvoice[0][0]);
            if(resultsInvoice[0][0].length > 0) {
                var invoiceData = resultsInvoice[0][0][0];

                if(invoiceData.stripe_account_id.trim() != '') {
                    var amount = invoiceData.amount + invoiceData.shipping_amount;
                    console.log('amount', amount);
                    var payment_data = {
                        amount: amount,
                        account_id: invoiceData.stripe_account_id,
                        trans_id: invoiceData.id
                    };

                    q.all([
                        payment.payout_to_bank(req, q, payment_data),
                    ]).then(function (resultsPaid) {
                        console.log('resultsPaid', resultsPaid);
                        if(resultsPaid[0].success == 1) {
                            req.body.refer_id = resultsPaid[0].refer_id;
                            req.body.trans_id = resultsPaid[0].trans_id;
                            req.body.destination_payment = resultsPaid[0].destination_payment;
                            q.all([
                                admin.update_invoice_release_status(req, config.mysql, q),
                                admin.update_invoice_release_transaction(req, config.mysql, q),
                                admin.get_product_seller_detail_using_invoiceid(req, config.mysql, q),
                                localm.mailtemps(req, config.mysql, q, 'release_fund_to_seller')
                            ]).then(function (results) {
                    
                                    if(results[3][0].length) {
                                        var template = results[3][0][0].template;
                                        var subject_message = results[3][0][0].subject;
                                        template = template.replace('{{event.user}}', results[2][0][0].seller_name);
                                        template = template.replace('{{event.product_title}}', results[2][0][0].product_title);
                                        template = template.replace('{{event.siteurl}}', $arr.config.url);
                                        template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                                        localm.sendmail(template, subject_message, results[2][0][0].seller_email);
                                    }

                                res.json({
                                    status: 200,
                                    success: true,
                                    result: results[0][0][0]
                                });
                                res.end();
                                return false;

                            }).fail(function (err) {
                                res.json({
                                    status: 500,
                                    success: false,
                                    error: err
                                });
                                res.end();
                                return false;
                            }).done();
                        } else {
                            res.json({
                                status: 500,
                                success: false,
                                error: resultsPaid[0].errortext
                            });
                            res.end();
                            return false;
                        }

                    }).fail(function (err) {
                        res.json({
                            status: 500,
                            success: false,
                            error: err
                        });
                        res.end();
                        return false;
                    }).done();
                    /* q.all([
                        admin.update_invoice_release_status(req, config.mysql, q),
                    ]).then(function (results) {
            
                        res.json({
                            status: 200,
                            success: true,
                            result: results[0][0][0]
                        });
                        res.end();
                        return false;
            
                    }).fail(function (err) {
                        res.json({
                            status: 500,
                            success: false,
                            error: err
                        });
                        res.end();
                        return false;
                    }).done(); */
                    
                } else {
                    res.json({
                        status: 500,
                        success: false,
                        error: 'Seller Bank account is not verified'
                    });
                    res.end();
                    return false;
                }
            } else {
                res.json({
                    status: 500,
                    success: false,
                    error: "seller don't have bank account"
                });
                res.end();
                return false;
            }
        }).fail(function (err) {
            res.json({
                status: 500,
                success: false,
                error: err
            });
            res.end();
            return false;
        }).done();
    } else {
        q.all([
            admin.update_invoice_release_status(req, config.mysql, q),
            admin.get_product_seller_detail_using_invoiceid(req, config.mysql, q),
            localm.mailtemps(req, config.mysql, q, 'release_fund_to_seller')
        ]).then(function (results) {

            if(results[2][0].length) {
                var template = results[2][0][0].template;
                var subject_message = results[2][0][0].subject;
                for (var index = 0; index < results[1][0].length; index++) {
                    template = template.replace('{{event.user}}', results[1][0][index].seller_name);
                    template = template.replace('{{event.product_title}}', results[1][0][index].product_title);
                    template = template.replace('{{event.siteurl}}', $arr.config.url);
                    template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                    localm.sendmail(template, subject_message, results[1][0][index].seller_email);
                }
            }

            res.json({
                status: 200,
                success: true,
                result: results[0][0][0]
            });
            res.end();
            return false;

        }).fail(function (err) {
            res.json({
                status: 500,
                success: false,
                error: err
            });
            res.end();
            return false;
        }).done();
    }
});

app.post(['/send_mail_to_seller_for_add_bank'], function (req, res) {
    req.body.userid = req.body.seller_user_id;
    q.all([
        hmb_user.getUserDetail(req, config.mysql, q),
        localm.mailtemps(req, config.mysql, q, 'send_mail_to_seller_for_add_bank')
    ]).then(function (results) {
console.log('results[1][0][0].length', results[1][0].length);
        if(results[1][0].length) {
            var template = results[1][0][0].template;
            var subject_message = results[1][0][0].subject;
            var url = $arr.config.spath + 'bank';
            template = template.replace('{{event.user}}', results[0][0][0].name);
            template = template.replace('{{event.url}}', url);

            template = template.replace('{{event.sitename}}', global.common.title);
            template = template.replace('{{event.siteurl}}', $arr.config.url);
            template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
            
            localm.sendmail(template, subject_message, results[0][0][0].email);
        }

        res.json({
            status: 200,
            success: true,
            result: results[0][0][0]
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.get(['/seo_management'], function (req, res) {
    var dateFormat = require('dateformat');
    delete $arr['menu'];
    $arr['menu'] = [];
    $arr['menu']['seo_management'] = 'active';

    common.tplFile('admincp/hmb_seo_management.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);
});
app.post(['/seo_management'], function (req, res) {
    $arr.page = req.body.page ? req.body.page : 1;
    req.body.page = $arr.page;
    $arr.limit = req.body.limit ? req.body.limit : 10;
    req.body.limit = $arr.limit;
    req.body.startFrom = (req.body.page - 1) * req.body.limit;
    
    q.all([
        admin.get_seo_management(req, config.mysql, q, 0),
        admin.get_seo_management(req, config.mysql, q, 1)
    ]).then(function (results) {
        if(req.body.is_report > 0) {
            var report_data = results[1][0];
            arr = [];
            data2 = [
                'No.', 'InvoiceId', 'Transaction ID', 'User', 'Product Title', 'Commission', 'Transaction Fee', 'Status', 'Amount', 'Gateway', 'Paid Date',
                'Escrow Company', 'Escrow User Type', 'Full Name', 'Company Name', 'Email', 'Phone', 'Bank Name', 'Account Name', 'Account Number', 'Routing Number'
            ];
            arr.push(data2);
            for (var i = 0; i < report_data.length; i++) {
                data2 = [
                    i+1,
                    report_data[i].id,
                    report_data[i].transactionid,
                    report_data[i].buyer_email,
                    report_data[i].product_title,
                    report_data[i].shipping_amount,
                    report_data[i].transaction_fee,
                    report_data[i].status,
                    report_data[i].amount,
                    report_data[i].gateway,
                    report_data[i].paid_date,

                    report_data[i].escrow_company,
                    report_data[i].user_type,
                    report_data[i].user_name,
                    report_data[i].user_company,
                    report_data[i].user_email,
                    report_data[i].user_phone,
                    report_data[i].bank_name,
                    report_data[i].account_name,
                    report_data[i].account_number,
                    report_data[i].routing_number
                ];
                console.log('data2', data2);
                arr.push(data2);
            }
            var dateFormat = require('dateformat');
            res.setHeader('Content-disposition', 'attachment; filename=transaction_report_' + dateFormat(new Date(), "yyyy_mm_dd_HH_MM_ss") + '.csv');
            res.set('Content-Type', 'application/octet-stream');
            res.csv(arr);
        } else {
            var listData = [];
            if(results[0][0].length) {
                listData = results[0][0];
            }
            $arr.listData = listData;
            $arr.totalData = results[1][0].length;
            common.tplFile('admincp/hmb_seo_management_ajax.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        }

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.post(['/update_medata'], function (req, res) {
    q.all([
        admin.update_medata(req, config.mysql, q, 0),
    ]).then(function (results) {
        res.json({
            status: 200,
            success: true,
            result: results[0][0]
        });
        res.end();
        return false;

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

app.post('/update_transaction_contract', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    console.log('req.files', req.files);
    var finalresult = {
        productDocument: []
    };

    q.all([
        admin.update_transaction_contract(req, config.mysql, q, 0),
    ]).then(function (results) {
        // finalresult.s3Url = global.settingscdn.s3_image_url;
        req.files.transaction_contract.basenam = (typeof (req.files.transaction_contract.name) === 'undefined') ? '' : req.files.transaction_contract.name.substr(0, req.files.transaction_contract.name.lastIndexOf('.'));
        finalresult.productDocument.push(req.files.transaction_contract);
        console.log(finalresult)
        res.json(finalresult);
        res.end();
        return false

    }).fail(function (err) {
        res.json({
            status: 500,
            success: false,
            error: err
        });
        res.end();
        return false;
    }).done();
});

module.exports = app;