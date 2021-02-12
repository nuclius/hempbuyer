var express = require('express');
var common = require('../module/common');
var user = require('../module/hmb_user');
var app = express.Router();
var q = require('q');
var _ = require('underscore');
var localm = require('../module/localmail');
var message = require('../module/hmb_message');

/**
 *  Render Message Page
 */
app.get('/:action', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    arr_temp['action'] = req.body.action = req.param('action') ? req.param('action') : '';

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([message.getInboxOverallAndUnreadMessageCount(req, config.mysql, q, req.body.loggedUserId)]).then(function (result) {
            arr_temp['totalInboxMessageCount'] = result[0][0][0]['totalInboxMessageCount'];
            arr_temp['totalInboxUnreadMessageCount'] = result[0][0][0]['totalInboxUnreadMessageCount'];
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();

        if(arr_temp['action'] == '' || arr_temp['action'] == 'inbox' || arr_temp['action'] == 'all') {
            /*q.all([message.getInboxOverallAndUnreadMessageCount(req, config.mysql, q, req.body.loggedUserId)]).then(function (result) {
                arr_temp['totalInboxMessageCount'] = result[0][0][0]['totalInboxMessageCount'];
                arr_temp['totalInboxUnreadMessageCount'] = result[0][0][0]['totalInboxUnreadMessageCount'];

                common.tplFile('hmb_inbox_message.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, arr_temp);
            });*/
            common.tplFile('hmb_inbox_message.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        } else if(arr_temp['action'] != '' && arr_temp['action'] == 'sent') {
            common.tplFile('hmb_sent_message.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        } else if(arr_temp['action'] != '' && arr_temp['action'] == 'archive') {
            common.tplFile('hmb_archive_message.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        } else if(arr_temp['action'] != '' && arr_temp['action'] == 'trash') {
            common.tplFile('hmb_trash_message.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, arr_temp);
        }   else {
            res.writeHead(302, {
                'Location': '/signin'
            });
            res.end();
            return false;
        }
    } else {
        res.writeHead(302, {
            'Location': '/signin'
        });
        res.end();
        return false;
    }
});

/**
 *  Get User Message
 */
app.post('/userMessageInbox', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    var pagination = require('pagination');

    var bids = require('../module/bid');
    var data = bids.SearchPageNo(req, config.mysql, q);
    req.body.page = data.dspage;
    req.body.perlimit = 9;
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;

    arr_temp['action'] = req.body.action ? req.body.action : '';
    arr_temp['sessionId'] = req.body.loggedUserId;
    q.all([message.getUserMessagesByAction(req, config.mysql, q, 0), message.getUserMessagesByAction(req, config.mysql, q, 1)]).then(function (results) {
        arr_temp['messages'] = results[0][0];

        var url = require('url');
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        fquery = common.urlparameter(query, {
            page: ''
        });

        arr_temp['pagination'] = results[1][0][0]['totalCount'];
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationSearch',
            current: req.body.page ? req.body.page : 0,
            rowsPerPage: 9,
            totalResult: arr_temp['pagination'],
            ajax: true
        });

        arr_temp['pagination_html'] = paginator.render();

        if(arr_temp['action'] == '' || arr_temp['action'] == 'inbox' || arr_temp['action'] == 'all') {
            common.tplFile('hmb_inbox_message_template.tpl');
            common.headerSet(0);
            common.loadTemplateHeader(req, res, arr_temp);
        } else if(arr_temp['action'] != '' && arr_temp['action'] == 'sent') {
            common.tplFile('hmb_sent_message_template.tpl');
            common.headerSet(0);
            common.loadTemplateHeader(req, res, arr_temp);
        } else if(arr_temp['action'] != '' && arr_temp['action'] == 'archive') {
            common.tplFile('hmb_archive_message_template.tpl');
            common.headerSet(0);
            common.loadTemplateHeader(req, res, arr_temp);
        } else if(arr_temp['action'] != '' && ( arr_temp['action'] == 'trash' || arr_temp['action'] == 'delete' ) ) {
            common.tplFile('hmb_trash_message_template.tpl');
            common.headerSet(0);
            common.loadTemplateHeader(req, res, arr_temp);
        } /*else {
            common.tplFile('hmb_login.tpl');
            common.headerSet(0);
            common.loadTemplateHeader(req, res, arr_temp);
        }*/
    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

/**
 *  Trash Message
 */
app.post('/deleteInboxMessage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([message.deleteUserMessages(req, config.mysql, q)]).then(function (results) {
            var obj = {
                status: 'success',
                statusText: 'Message successfully moved to trash'
            };
            res.send(obj);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        var obj = {
            status: 'session_expired',
            statusText: 'Session Expired'
        };
        res.send(obj);
    }
});

/**
 *  Get Message Details Using Message Id
 */
app.post('/viewMessage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([message.viewUserMessages(req, config.mysql, q)]).then(function (results) {
            var obj = {
                status: 'success',
                data: results[0][0],
                sessionId: req.body.loggedUserId
            };
            res.send(obj);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        var obj = {
            status: 'session_expired',
            data: ''
        };
        res.send(obj);
    }
});

/**
 *  Update User Message Read Flag
 */
app.post('/updateAndViewMessage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([message.updateUserMessages(req, config.mysql, q)]).then(function (result) {
            q.all([message.viewUserMessages(req, config.mysql, q)]).then(function (results) {
                var obj = {
                    status: 'success',
                    data: results[0][0],
                    sessionId: req.body.loggedUserId
                };
                res.send(obj);
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        var obj = {
            status: 'session_expired',
            data: ''
        };
        res.send(obj);
    }
});

/**
 *  Archive Message
 */
app.post('/archiveInboxMessage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([message.archiveUserMessages(req, config.mysql, q)]).then(function (results) {
            var obj = {
                status: 'success',
                statusText: 'Message successfully moved to archive'
            };
            res.send(obj);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        var obj = {
            status: 'session_expired',
            statusText: 'Session Expired'
        };
        res.send(obj);
    }
});

/**
 *  Delete Message
 */
app.post('/deleteTrashMessage', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.body.loggedUserId = req.session.userid ? req.session.userid : 0;
    if(req.body.loggedUserId != "" && req.body.loggedUserId != 0) {
        q.all([message.deleteUserTrashMessages(req, config.mysql, q)]).then(function (results) {
            var obj = {
                status: 'success',
                statusText: 'Message successfully deleted'
            };
            res.send(obj);
        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    } else {
        var obj = {
            status: 'session_expired',
            statusText: 'Session Expired'
        };
        res.send(obj);
    }
});

/**
 *  Save Reply Message
 */
app.post('/saveMessage', function (req, res) {
    req.body.pid = req.body.product_id;
    req.body.fromid = req.session.userid;
    req.body.toid = req.body.from_id;
    req.body.userid = req.body.from_id;
    req.body.toemail = '';
    req.body.first_name = '';
    req.body.view_url = config.url+'/inbox/all';
    req.body.subject = req.body.subject;
    req.body.message = req.body.message;
    req.body.r_id = req.body.r_id;
    /*q.all([
        message.getUserMessagesAlreadyExists(req, config.mysql, q)
    ]).then(function (results) {
        if(results[0][0].length > 0) {
            req.body.r_id = results[0][0][0]['r_id'];
            req.body.subject = results[0][0][0]['subject'];
        }*/

        q.all([user.getUserDetail(req, config.mysql, q)]).then(function (results) {
            var userData = results[0][0][0];
            req.body.first_name = userData.name;
            req.body.toemail = userData.email;

            q.all([
                message.addmessages(req, config.mysql, q)
            ]).then(function (result) {
                res.json({
                    status: 200,
                    success: true
                })
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();

        }).fail(function (err) {
            console.log(err.stack);
            throw err;
        }).done();
    /*}).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();*/
});

module.exports = app;