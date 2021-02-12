var util = require('util');
var customerio = require('./customerio');
var localm = require('./localmail');
var q = require('q');
var products = require('./products');
var dateFormat = require('dateformat');
var common = require('./common');
var url = require('url');
var mysqli = require('./mysqli');

exports.addWithoutmessages = function(req, mysql, q) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 156);
    req.body.fromid = (typeof(req.body.fromid) === 'undefined') ? req.session.userid : req.body.fromid;
    var escape_data = [req.body.fromid, req.body.toid, req.body.subject, req.body.message, datge, req.body.r_id, 'open', 'open', req.body.pid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.usersmessages = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 159);
    var escape_data = [];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.addContactMessage = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'add_contactus_msg');
    var uid = typeof(req.session.user_id) !== 'undefined' ? req.session.user_id : '';
    var escape_data = [
        req.body.subject,
        req.body.message,
        req.body.first_name,
        req.body.last_name,
        req.body.email,
        req.body.phone,
        req.body.type,
        uid
    ];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    if (global.emaillocal.status == 'yes') {
        q.all([localm.mailtemps(req, mysql, q, 'message_sent')]).then(function(results2) {
            if (results2[0][0].length > 0) {
                var template = results2[0][0][0].template;
                var subject = req.body.subject;
                var msg = "Name : "+req.body.first_name + ' ' + req.body.last_name+"<br>Email-ID : "+req.body.email+" <br>Phone : "+req.body.phone
                if(req.body.type != 'other' && req.body.type !==''){
                    template = template.replace('{{event.subject}}', 'Service Request -'+subject);
                } else {
                    template = template.replace('{{event.subject}}', subject);
                }
                template = template.replace('{{event.message}}', "You have got new message from user,<br><br>" + msg + "<br><br><b>Message from user :- </b><br> "+req.body.message);
                template = template.replace('{{event.user}}', ' ');
                template = template.replace('{{event.url}}', config.url);
                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');

                localm.sendmail(template, subject, req.body.toemail);
                return defered.promise;
            }
        });
        q.all([localm.mailtemps(req, mysql, q, 'message_sent')]).then(function(results2) {
            if (results2[0][0].length > 0) {
                var template = results2[0][0][0].template;
                var subject = req.body.subject;
                var msg = "Name : "+req.body.first_name + ' ' + req.body.last_name+"<br>Email-ID : "+req.body.email+" <br>Phone : "+req.body.phone
                if(req.body.type != 'other' && req.body.type !=='')
                    template = template.replace('{{event.subject}}', 'Service Request -'+subject);
                else
                    template = template.replace('{{event.subject}}', subject);
                template = template.replace('{{event.message}}', "Thank you for your request.  We have received your information.  The proper person with our organization is being identified.  You will be contacted within 24 hours with a response and next steps.");
                template = template.replace('{{event.user}}', ' ');
                template = template.replace('{{event.url}}', config.url);
                template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');

                localm.sendmail(template, subject, req.body.email);
                return defered.promise;
            }
        });
    } else {
        return defered.promise;
    }
}

exports.addmessages = function(req, mysql, q) {
    console.log('hmb addmessages');
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 156);
    delete customerio;
    req.body.fromid = (typeof(req.body.fromid) === 'undefined') ? req.session.userid : req.body.fromid;
    req.body.pid = (typeof(req.body.pid) === 'undefined') ? 0 : req.body.pid;
    var toid = req.body.toid;
    var toemail = req.body.toemail;
    //var tophone = req.body.tophone;
    var fname = req.body.first_name;
    var lname = req.body.last_name;
    req.body.view_url = req.body.view_url ? req.body.view_url : config.url;
    // var email = req.body.email;
    // var phone = req.body.phone;
    var toemail = req.body.toemail;
    //var tophone = req.body.tophone;
    var messages = req.body.message;
    var subjects = req.body.subject;
    var fromid = req.body.fromid;
    var pid = req.body.pid;
    var rid = req.body.r_id;
    console.log('req.session', req.session);
    var fromName = 'Admin';
    if(req.session.role == 1 || req.session.role == 2 || req.session.role == 3) {
        fromName = req.session.name;
    }
    var escape_data = [fromid, toid, subjects, messages, datge, rid, 'open', 'open', pid];
    //console.log(escape_data);
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    });
    // q.all([
    //     products.checkmailnotify(req, config.mysql, q, 8),
    //     products.checksmsnotify(req, config.mysql, q, 8)
    // ]).then(function(results) {
        // if (results[0][0].length > 0 || req.session.admin == 1) {
            q.all([
                localm.mailtemps(req, mysql, q, 'message_sent'),
                localm.mailtemps(req, mysql, q, 'message_received')
            ]).then(function(results2) {
                if (results2[0][0].length > 0) {
                    var template = results2[0][0][0].template;
                    var subject = results2[0][0][0].subject;
                    template = template.replace('{{event.subject}}', subject);
                    template = template.replace('{{event.user}}', req.session.name);
                    template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                    localm.sendmail(template, subject, req.session.email);
                }
                if (results2[1][0].length > 0) {
                    var template = results2[1][0][0].template;
                    var subject = results2[1][0][0].subject;
                    template = template.replace('{{event.subject}}', subjects);
                    template = template.replace('{{event.message}}', messages);
                    template = template.replace('{{event.user}}', fname);
                    template = template.replace('{{event.fromName}}', fromName);
                    template = template.replace('{{event.url}}', req.body.view_url);
                    template = template.replace('{{event.logo_url}}', config.url+'/images/logo.png');
                    localm.sendmail(template, subjects, toemail);
                }
                return defered.promise;
            });
        // } else { console.log('Notification off'); }
    // });
}

exports.readmessages = function(req, mysql, q) {
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 155);
    var escape_data = [datge, req.body.r_id, req.session.userid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.movemessages = function(req, mysql, q) {
    status = 'open';
    if (req.body.action == 'archive')
        status = 'archive'
    else if (req.body.action == 'delete')
        status = 'delete'
    strQuery = mysqli.mysqli($mysqli, 157);
    var escape_data = [status, req.body.r_id, req.session.userid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    strQuery = mysqli.mysqli($mysqli, 158);
    var escape_data = [status, req.body.r_id, req.session.userid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.movemessages1 = function(req, mysql, q) {
    status = 'open';
    if (req.body.action == 'archive')
        status = 'archive'
    else if (req.body.action == 'delete')
        status = 'delete'
    strQuery = mysqli.mysqli($mysqli, 158);
    var escape_data = [status, req.body.r_id, req.session.userid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.showmessages = function(req, mysql, q, count) {
    try {
        req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
        $mysqli = { where: 'and p.r_id = "' + req.body.r_id + '"' };
        if (count == 1) {
            //strQuery = mysqli.mysqli($mysqli, 154);
            // strQuery = mysqli.mysqli($mysqli, '154_new');
            strQuery = mysqli.mysqli($mysqli, 'viewMessage');
            page = (req.body.page - 1) * 5;
            var escape_data = [req.session.userid, req.session.userid, page];
        } else {
            //strQuery = mysqli.mysqli($mysqli, 'view_msg_by_id');
            // strQuery = mysqli.mysqli($mysqli, 'view_msg_by_id_new');
            strQuery = mysqli.mysqli($mysqli, 'viewMessageById');
            var escape_data = [req.session.userid, req.session.userid];
        }
        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in getting message details " + e.stack);
    }
}

exports.mymessages = function(req, mysql, q, count) {
    $mysqli = { where: '', where1: '' };
    if (req.body.action == 'inbox' || req.body.action == '') {
        $mysqli = { where: ' and p.to_status != "delete" AND p.to_status !="archive"  and p.to_id = "' + req.session.userid + '" and p.visible = 1' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '" and m.visible = 1';
    } else if (req.body.action == 'sent') {
        $mysqli = { where: ' and p.from_status != "delete" AND p.from_status !="archive" and p.from_id = "' + req.session.userid + '" and p.visible = 1' };
        $mysqli['where1'] = ' and m.from_status != "delete" and m.from_id = "' + req.session.userid + '" and m.visible = 1';
    } else if (req.body.action == 'archive') {
        $mysqli = { where: ' and ((p.from_status = "archive" and p.from_id = "' + req.session.userid + '") or (p.to_status = "archive" and p.to_id = "' + req.session.userid + '")) and p.visible = 1' };
        $mysqli['where1'] = 'and ((m.from_status = "archive" and m.from_id = "' + req.session.userid + '") or (m.to_status = "archive" and m.to_id = "' + req.session.userid + '")) and m.visible = 1';
    } else if (req.body.action == 'delete') {
        $mysqli = { where: ' and ((p.from_status = "delete" and p.from_id = "' + req.session.userid + '") or (p.to_status = "delete" and p.to_id = "' + req.session.userid + '")) and p.visible = 1' };
        $mysqli['where1'] = 'and ((m.from_status = "delete" and m.from_id = "' + req.session.userid + '") or (m.to_status = "delete" and m.to_id = "' + req.session.userid + '")) and p.visible = 1';
    } else if (req.body.action == 'search') {
        $mysqli = { where: ' and (p.subject like "%' + req.query.keyword + '%")' }
        $mysqli['where1'] = 'and (p.subject like "%' + req.query.keyword + '%")';
    }
    if (count == 2) {
        $mysqli = { where: ' and p.to_status != "delete" and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    }

    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'd153');
        var escape_data = [req.session.userid, req.session.userid];
    } else if (count == 2) {
        strQuery = mysqli.mysqli($mysqli, 'dmsgunread');
        var escape_data = [req.session.userid, req.session.userid];
    } else if(count == 3) {
        strQuery = mysqli.mysqli($mysqli, 'd153');
        var escape_data = [req.session.userid, req.session.userid];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'd152');
        page = (req.body.page - 1) * 5;
        var escape_data = [req.session.userid, page];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.getContactMessage = function(req, mysql, q, count) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_contactus_msg_view');
    var escape_data = [req.body.id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.adminContactMsgs = function(req, mysql, q, count) {
    $mysqli = { where: '', where1: '' };
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'get_contactus_msgs_cnt');
        var escape_data = [];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'get_contactus_msgs');
        page = (req.body.page - 1) * 10;
        var escape_data = [page,10];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.adminmymessages = function(req, mysql, q, count) {
    $mysqli = { where: '', where1: '' };
    if (req.body.action == 'inbox' || req.body.action == '') {
        $mysqli = { where: 'where p.to_id = "' + req.session.userid + '" and p.to_status != "delete" AND p.to_status !="archive"  and p.to_id = "' + req.session.userid + '" and p.visible = 1' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '" and m.visible = 1';
    } else if (req.body.action == 'sent') {
        $mysqli = { where: 'where p.from_id = "' + req.session.userid + '" and p.from_status != "delete" AND p.from_status !="archive" and p.from_id = "' + req.session.userid + '" and p.visible = 1' };
        $mysqli['where1'] = ' and m.from_status != "delete" and m.from_id = "' + req.session.userid + '" and m.visible = 1';
    } else if (req.body.action == 'archive') {
        $mysqli = { where: ' where ((p.from_status = "archive" and p.from_id = "' + req.session.userid + '") or (p.to_status = "archive" and p.to_id = "' + req.session.userid + '")) and p.visible = 1' };
        $mysqli['where1'] = 'and ((m.from_status = "archive" and m.from_id = "' + req.session.userid + '") or (m.to_status = "archive" and m.to_id = "' + req.session.userid + '")) and m.visible = 1';
    } else if (req.body.action == 'delete') {
        $mysqli = { where: ' where ((p.from_status = "delete" and p.from_id = "' + req.session.userid + '") or (p.to_status = "delete" and p.to_id = "' + req.session.userid + '")) and p.visible = 1' };
        $mysqli['where1'] = 'and ((m.from_status = "delete" and m.from_id = "' + req.session.userid + '") or (m.to_status = "delete" and m.to_id = "' + req.session.userid + '")) and m.visible = 1';
    } else if (req.body.action == 'search') {
        $mysqli = { where: ' and (p.subject like "%' + req.query.keyword + '%")' }
        $mysqli['where1'] = 'and (p.subject like "%' + req.query.keyword + '%")';
    }
    if (count == 2) {
        $mysqli = { where: ' and p.to_status != "delete" and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    }
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'A153');
        var escape_data = [req.session.userid];
    } else if (count == 2) {
        strQuery = mysqli.mysqli($mysqli, 'Amsgunread');
        var escape_data = [req.session.userid, req.session.userid];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'A152');
        page = (req.body.page - 1) * 5;
        var escape_data = [page];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.relationship = function(req, mysql, q, count) {
    $mysqli = { where: '', where1: '' };
    if (req.body.action == 'inbox' || req.body.action == '') {
        $mysqli = { where: ' and p.to_status != "delete" AND p.to_status !="archive"  and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    } else if (req.body.action == 'sent') {
        $mysqli = { where: ' and p.from_status != "delete" AND p.from_status !="archive" and p.from_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = ' and m.from_status != "delete" and m.from_id = "' + req.session.userid + '"';
    } else if (req.body.action == 'archive') {
        $mysqli = { where: ' and ((p.from_status = "archive" and p.from_id = "' + req.session.userid + '") or (p.to_status = "archive" and p.to_id = "' + req.session.userid + '"))' };
        $mysqli['where1'] = 'and ((m.from_status = "archive" and m.from_id = "' + req.session.userid + '") or (m.to_status = "archive" and m.to_id = "' + req.session.userid + '"))';
    } else if (req.body.action == 'delete') {
        $mysqli = { where: ' and ((p.from_status = "delete" and p.from_id = "' + req.session.userid + '") or (p.to_status = "delete" and p.to_id = "' + req.session.userid + '"))' };
        $mysqli['where1'] = 'and ((m.from_status = "delete" and m.from_id = "' + req.session.userid + '") or (m.to_status = "delete" and m.to_id = "' + req.session.userid + '"))';
    } else if (req.body.action == 'search') {
        $mysqli = { where: ' and (p.subject like "%' + req.query.keyword + '%")' }
        $mysqli['where1'] = 'and (p.subject like "%' + req.query.keyword + '%")';
    }
    if (count == 2) {
        $mysqli = { where: ' and p.to_status != "delete" and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    }
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'relationc');
        var escape_data = [req.session.userid];
    } else if (count == 2) {
        strQuery = mysqli.mysqli($mysqli, 'msgunread');
        var escape_data = [req.session.userid, req.session.userid];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'relation');
        page = (req.body.page - 1) * 5;
        var escape_data = [req.session.userid, page];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.relationshipsent = function(req, mysql, q, count) {
    $mysqli = { where: '', where1: '' };
    if (req.body.action == 'inbox' || req.body.action == '') {
        $mysqli = { where: ' and p.to_status != "delete" AND p.to_status !="archive"  and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    } else if (req.body.action == 'sent') {
        $mysqli = { where: ' and p.from_status != "delete" AND p.from_status !="archive" and p.from_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = ' and m.from_status != "delete" and m.from_id = "' + req.session.userid + '"';
    } else if (req.body.action == 'archive') {
        $mysqli = { where: ' and ((p.from_status = "archive" and p.from_id = "' + req.session.userid + '") or (p.to_status = "archive" and p.to_id = "' + req.session.userid + '"))' };
        $mysqli['where1'] = 'and ((m.from_status = "archive" and m.from_id = "' + req.session.userid + '") or (m.to_status = "archive" and m.to_id = "' + req.session.userid + '"))';
    } else if (req.body.action == 'delete') {
        $mysqli = { where: ' and ((p.from_status = "delete" and p.from_id = "' + req.session.userid + '") or (p.to_status = "delete" and p.to_id = "' + req.session.userid + '"))' };
        $mysqli['where1'] = 'and ((m.from_status = "delete" and m.from_id = "' + req.session.userid + '") or (m.to_status = "delete" and m.to_id = "' + req.session.userid + '"))';
    } else if (req.body.action == 'search') {
        $mysqli = { where: ' and (p.subject like "%' + req.query.keyword + '%")' }
        $mysqli['where1'] = 'and (p.subject like "%' + req.query.keyword + '%")';
    }
    if (count == 2) {
        $mysqli = { where: ' and p.to_status != "delete" and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    }
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'relationsentc');
        var escape_data = [req.session.userid];
    } else if (count == 2) {
        strQuery = mysqli.mysqli($mysqli, 'msgunread');
        var escape_data = [req.session.userid, req.session.userid];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'relationsent');
        page = (req.body.page - 1) * 5;
        var escape_data = [req.session.userid, page];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.relationshipcenter = function(req, mysql, q, count) {
    $mysqli = { where: '', where1: '' };
    if (req.body.action == 'inbox' || req.body.action == '') {
        $mysqli = { where: ' and p.to_status != "delete" AND p.to_status !="archive"  and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    } else if (req.body.action == 'sent') {
        $mysqli = { where: ' and p.from_status != "delete" AND p.from_status !="archive" and p.from_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = ' and m.from_status != "delete" and m.from_id = "' + req.session.userid + '"';
    } else if (req.body.action == 'archive') {
        $mysqli = { where: ' and ((p.from_status = "archive" and p.from_id = "' + req.session.userid + '") or (p.to_status = "archive" and p.to_id = "' + req.session.userid + '"))' };
        $mysqli['where1'] = 'and ((m.from_status = "archive" and m.from_id = "' + req.session.userid + '") or (m.to_status = "archive" and m.to_id = "' + req.session.userid + '"))';
    } else if (req.body.action == 'delete') {
        $mysqli = { where: ' and ((p.from_status = "delete" and p.from_id = "' + req.session.userid + '") or (p.to_status = "delete" and p.to_id = "' + req.session.userid + '"))' };
        $mysqli['where1'] = 'and ((m.from_status = "delete" and m.from_id = "' + req.session.userid + '") or (m.to_status = "delete" and m.to_id = "' + req.session.userid + '"))';
    } else if (req.body.action == 'search') {
        $mysqli = { where: ' and (p.subject like "%' + req.query.keyword + '%")' }
        $mysqli['where1'] = 'and (p.subject like "%' + req.query.keyword + '%")';
    }
    if (count == 2) {
        $mysqli = { where: ' and p.to_status != "delete" and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    }
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'relationcenterc');
        var escape_data = [req.session.userid, req.session.userid];
    } else if (count == 2) {
        strQuery = mysqli.mysqli($mysqli, 'msgunread');
        var escape_data = [req.session.userid, req.session.userid];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'relationcenter');
        page = (req.body.page - 1) * 5;
        var escape_data = [req.session.userid, req.session.userid, page];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.adminDeleteMessages = function(req, mysql, q) {
    try {
        var defered = q.defer();
        strQuery = mysqli.mysqli($mysqli, 'adminmsgdelete');
        var escape_data = [req.body.id];
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        query.on('error', function(err) {
            throw err;
        });
        return defered.promise;
    } catch (e) {
        console.log("Error in deleting messages " + e);
    }
}

exports.deleteMessages = function(req, mysql, q) {
    try {
        var defered = q.defer();
        var del_id = (typeof(req.body['del[]']) !== 'undefined') ? ((req.body['del[]'] instanceof Array) ? req.body['del[]'].join(',') : req.body['del[]']) : 0;
        $mysqli = { del_id: del_id };
        if (req.body.action == 'sent') {
            strQuery = mysqli.mysqli($mysqli, 'sentboxDelete');
        } else if (req.body.action == 'inbox' || req.body.action == 'archive') {
            strQuery = mysqli.mysqli($mysqli, 'inboxDelete');
        }
        var escape_data = ['delete'];
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        query.on('error', function(err) {
            throw err;
        });
        return defered.promise;
    } catch (e) {
        console.log("Error in deleting messages " + e);
    }
}

exports.unDeleteMessages = function(req, mysql, q) {
    try {
        var defered = q.defer();
        var del_id = (typeof(req.body['del[]']) !== 'undefined') ? ((req.body['del[]'] instanceof Array) ? req.body['del[]'].join(',') : req.body['del[]']) : 0;
        $mysqli = { del_id: del_id };
        strQuery = mysqli.mysqli($mysqli, 'inboxDelete');
        var escape_data = ['open'];
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        query.on('error', function(err) {
            throw err;
        });

        strSentQuery = mysqli.mysqli($mysqli, 'sentboxDelete');
        inquery = mysql.query(strSentQuery, escape_data, defered.makeNodeResolver());
        inquery.on('error', function(err) {
            throw err;
        });
        return defered.promise;
    } catch (e) {
        console.log("Error in undeleting messages " + e);
    }
}

exports.updateviewed = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'notified_msgs');
    var escape_data = [req.session.userid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.dashmessages = function(req, mysql, q) {
    $mysqli = {};
    $mysqli = { where: '', where1: '' };
    $mysqli = { where: ' and p.to_status != "delete" AND p.to_status !="archive"  and p.to_id = "' + req.session.userid + '"' };
    $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    strQuery = mysqli.mysqli($mysqli, 'dash_msg');
    var escape_data = [req.session.userid, req.session.userid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.btyperelation = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'rebustype');
    var escape_data = [];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.relationinterestc = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'relationinterestd');
    var escape_data = [req.body.inbid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.relationntinterestc = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'relationntinterestd');
    var escape_data = [req.body.inbid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.checksendDetails = function(req, mysql, q) {
    var where = '';
    if (typeof(req.body.shipping_city) !== 'undefined' && req.body.shipping_city != '')
        where += " and  s.city = '" + req.body.shipping_city + "'";
    if (typeof(req.body.region) !== 'undefined' && req.body.region != '')
        where += " and  s.region = '" + req.body.region + "'";
    $mysqli = { where: where };
    strQuery = mysqli.mysqli($mysqli, 'checksendDetailsdb');
    var escape_data = [req.body.busstype, req.body.shipping_country, req.body.shipping_state];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.addpolldetails = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'addpolldetailsdb');
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var escape_data = [req.body.tittle, req.body.message, req.body.user_id, req.body.busstype, req.body.shipping_country, req.body.shipping_state, req.body.shipping_city, req.body.region, req.body.tarhidmem, req.body.tarhidprice, datge];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.insertpolldetailspmb = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'insertpollpmbdb');
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    var r_id = (new Date()).getTime() + Math.floor(Math.random() * (100 - 10 + 1)) + 10; //generate random number
    var escape_data = [req.body.user_id, req.body.toid, req.body.tittle, req.body.message, datge, req.body.rpool_id, r_id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.adminmyrelation = function(req, mysql, q, count) {
    var searchStr = ' where m.del_status = 0 ';
    var stateSrch = '';
    if (req.body.country !== '' && req.body.state !== '')
        stateSrch = stateSrch + ' and from_id in (select user_id from user_extras where state = "' + req.body.state + '")  ';
    
    if (req.body.to_date !== '' && req.body.from_date == '')
        searchStr = searchStr + ' and  DATE( m.date_added ) <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") + '" ';
    else if (req.body.from_date !== '' && req.body.to_date == '')
        searchStr = searchStr + ' and  DATE( m.date_added )  >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") + '" ';
    else if (req.body.from_date !== '' && req.body.to_date !== '')
        searchStr = searchStr + ' and  DATE( m.date_added )  >= "' + dateFormat(new Date(req.body.from_date), "yyyy-mm-dd") + '" and  DATE( m.date_added )  <= "' + dateFormat(new Date(req.body.to_date), "yyyy-mm-dd") + '" ';

    $mysqli = { where2: '', where: '', where1: '', whr: '' };
    if (req.body.action == 'inbox' || req.body.action == '') {
        $mysqli = { where: ' and p.to_status != "delete" AND p.to_status !="archive"  and p.to_id = "' + req.session.userid + '" and p.visible = 1' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '" and m.visible = 1';
    } else if (req.body.action == 'sent') {
        $mysqli = { where: ' and p.from_status != "delete" AND p.from_status !="archive" and p.from_id = "' + req.session.userid + '" and p.visible = 1' };
        $mysqli['where1'] = ' and m.from_status != "delete" and m.from_id = "' + req.session.userid + '" and m.visible = 1';
    } else if (req.body.action == 'archive') {
        $mysqli = { where: ' and ((p.from_status = "archive" and p.from_id = "' + req.session.userid + '") or (p.to_status = "archive" and p.to_id = "' + req.session.userid + '")) and p.visible = 1' };
        $mysqli['where1'] = 'and ((m.from_status = "archive" and m.from_id = "' + req.session.userid + '") or (m.to_status = "archive" and m.to_id = "' + req.session.userid + '")) and m.visible = 1';
    } else if (req.body.action == 'delete') {
        $mysqli = { where: ' and ((p.from_status = "delete" and p.from_id = "' + req.session.userid + '") or (p.to_status = "delete" and p.to_id = "' + req.session.userid + '")) and p.visible = 1' };
        $mysqli['where1'] = 'and ((m.from_status = "delete" and m.from_id = "' + req.session.userid + '") or (m.to_status = "delete" and m.to_id = "' + req.session.userid + '")) and m.visible = 1';
    } else if (req.body.action == 'search') {
        $mysqli = { where: ' and (p.subject like "%' + req.query.keyword + '%")' }
        $mysqli['where1'] = 'and (p.subject like "%' + req.query.keyword + '%")';
    }
    if (count == 2) {
        $mysqli = { where: ' and p.to_status != "delete" and p.to_id = "' + req.session.userid + '"' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '"';
    }
    $mysqli.whr = searchStr;
    $mysqli.where2 = stateSrch;
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'adminmyrelationdbc');
        var escape_data = [];
    } else if (count == 2) {
        strQuery = mysqli.mysqli($mysqli, 'msgunread');
        var escape_data = [req.session.userid, req.session.userid];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'adminmyrelationdb');
        page = (req.body.page - 1) * 10;
        var escape_data = [page];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.relationshipdownload = function(req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'relationshipdownloaddb');
    var escape_data = [req.body.id];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.rinterestdetails = function(req, mysql, q, count) {
    $mysqli = { where: '', where1: '' };
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'rinterestdetailsdb');
        var escape_data = [req.body.id];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'rinterestdetailsdbc');
        page = (req.body.page - 1) * 10;
        var escape_data = [req.body.id, page];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

exports.bustargetcount = function(req, mysql, q) {
    var where = '';
    if (typeof(req.body.city) !== 'undefined' && req.body.city != '')
        where += " and  s.city = '" + req.body.city + "'";
    if (typeof(req.body.region) !== 'undefined' && req.body.region != '')
        where += " and  s.region = '" + req.body.region + "'";
    $mysqli = { where: where };
    strQuery = mysqli.mysqli($mysqli, 'bustargetcountd');
    var escape_data = [req.body.btype, req.body.tcount, req.body.tstate, req.session.userid];
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;
}

exports.rpollsentdetails = function(req, mysql, q, count) {
    $mysqli = { where: '', where1: '' };
    if (count == 1) {
        strQuery = mysqli.mysqli($mysqli, 'rpollsentdetails');
        var escape_data = [req.body.id];
    } else {
        strQuery = mysqli.mysqli($mysqli, 'rpollsentdetailsc');
        page = (req.body.page - 1) * 10;
        var escape_data = [req.body.id, page];
    }
    var defered = q.defer();
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    query.on('error', function(err) {
        throw err;
    })
    return defered.promise;
}

/**
 *  Get All Users
 */
exports.getUserList = function(req, mysql, q, role_ids, fields) {
    try {
        var whereCond = ' id != 0 ';
        /*if(role_ids != "")
            whereCond += ' and role IN ( ' + role_ids.toString() + ' ) ';*/

        if(role_ids.length > 0)
            whereCond += ' and role IN ( 1,2,3,4,5,6 ) ';

        var fieldName = '*';
        if(fields)
                fieldName = fields;

        var orderBy = ' ORDER BY role ASC ';
        $mysqli = { whereCond : whereCond, orderBy : orderBy, fieldName : fieldName };
        strQuery = mysqli.mysqli($mysqli, 'getUserList');
        var escape_data = [];
        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in getting user details " + e.stack);
    }
}

/**
 *  Get Unread Message / Overall Message Count
 */
exports.getInboxOverallAndUnreadMessageCount = function(req, mysql, q, id) {
    try {
        $mysqli = { where : '' };
        strQuery = mysqli.mysqli($mysqli, 'getInboxOverallAndUnreadMessageCount');
        var escape_data = [id, id];
        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql);
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in overall and unread message count details " + e.stack);
    }
}

/**
 *  Get Messages List
 */
exports.getUserMessagesByAction = function(req, mysql, q, count) {
    try {
        $mysqli = { where: '', where1: '' };
        $mysqli['where1'] = 'and m.to_status != "delete" and m.to_id = "' + req.session.userid + '" and m.visible = 1';
        $mysqli['groupBy'] = ' GROUP BY p.r_id ';
        if (req.body.action == 'inbox' || req.body.action == 'all' || req.body.action == '') {
            $mysqli = { where: ' WHERE p.id != 0 and p.to_status != "delete" AND p.to_status !="archive" and p.to_id = "' + req.session.userid + '" and p.visible = 1' };
            $mysqli['where1'] = ' WHERE p.id != 0 and m.to_status != "delete" and m.to_id = "' + req.session.userid + '" and m.visible = 1';
            $mysqli['groupBy'] = ' GROUP BY p.r_id ';
        } else if (req.body.action == 'sent') {
            $mysqli = { where: ' WHERE p.id != 0 and p.from_status != "delete" AND p.from_status !="archive" and p.from_id = "' + req.session.userid + '" and p.visible = 1' };
            $mysqli['where1'] = ' WHERE p.id != 0 and m.from_status != "delete" and m.from_id = "' + req.session.userid + '" and m.visible = 1';
            $mysqli['groupBy'] = ' ';
        } else if (req.body.action == 'archive') {
            $mysqli = { where: ' WHERE p.id != 0 and ((p.from_status = "archive" and p.from_id = "' + req.session.userid + '") or (p.to_status = "archive" and p.to_id = "' + req.session.userid + '")) and p.visible = 1' };
            $mysqli['where1'] = ' WHERE p.id != 0 and ((m.from_status = "archive" and m.from_id = "' + req.session.userid + '") or (m.to_status = "archive" and m.to_id = "' + req.session.userid + '")) and m.visible = 1';
            $mysqli['groupBy'] = ' GROUP BY p.r_id ';
        } else if (req.body.action == 'delete') {
            $mysqli = { where: ' WHERE p.id != 0 and ((p.from_status = "delete" and p.from_id = "' + req.session.userid + '") or (p.to_status = "delete" and p.to_id = "' + req.session.userid + '")) and p.visible = 1' };
            $mysqli['where1'] = ' WHERE p.id != 0 and ((m.from_status = "delete" and m.from_id = "' + req.session.userid + '") or (m.to_status = "delete" and m.to_id = "' + req.session.userid + '")) and m.visible = 1';
            $mysqli['groupBy'] = ' GROUP BY p.r_id ';
        } else if (req.body.action == 'search') {
            $mysqli = { where: ' WHERE p.id != 0 and (p.subject like "%' + req.query.keyword + '%")' }
            $mysqli['where1'] = ' WHERE p.id != 0 and (p.subject like "%' + req.query.keyword + '%")';
            $mysqli['groupBy'] = ' GROUP BY p.r_id ';
        }

        if (count == 1) {
            strQuery = mysqli.mysqli($mysqli, 'getUserMessagesByActionCount');
            //var escape_data = [req.session.userid, req.session.userid];
            var escape_data = [];
        } else {
            strQuery = mysqli.mysqli($mysqli, 'getUserMessagesByActionLimit');
            var page = req.body.page;
            var perlimit = req.body.perlimit;
            page = (page > 0) ? (page - 1) * perlimit : 0;
            //var escape_data = [req.session.userid, page, perlimit];
            var escape_data = [page, perlimit];
        }

        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql);
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in getting user message details " + e.stack);
    }
}

/**
 *  Delete User Messages
 */
exports.deleteUserMessages = function(req, mysql, q) {
    try {
        var whereCond = 'to_id = ' + req.session.userid + ' AND to_status != "delete" ';
        /*if(req.body.messageIds && req.body.messageIds != "")
            whereCond += ' AND id IN (' + req.body.messageIds + ') ';*/

        if(req.body.rIds && req.body.rIds != "")
            whereCond += ' AND r_id IN (' + req.body.rIds + ') ';

        $mysqli = { whereCond : whereCond };
        strQuery = mysqli.mysqli($mysqli, 'deleteUserMessages');
        var defered = q.defer();
        query = mysql.query(strQuery, [], defered.makeNodeResolver());
        console.log(query.sql);
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in deleting message details " + e.stack);
    }
}

/**
 *  View User Messages
 */
exports.viewUserMessages = function(req, mysql, q) {
    try {
        //$mysqli = { where: ' and p.id = "' + req.body.messageId + '"' };
        if(req.body.type == 'sent')
            $mysqli = { where: ' and p.id = "' + req.body.messageId + '"' };
        else
            $mysqli = { where: ' and p.r_id = "' + req.body.rId + '"' };

        strQuery = mysqli.mysqli($mysqli, 'viewMessage');
        var escape_data = [req.session.userid, req.session.userid];
        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql);
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in getting message details " + e.stack);
    }
}

/**
 *  Update User Message Read Flag
 */
exports.updateUserMessages = function(req, mysql, q) {
    try {
        var currentDate = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
        strQuery = mysqli.mysqli($mysqli, 'updateUserMessageReadFlag');
        //var escape_data = [currentDate, req.body.messageId, req.session.userid];
        var escape_data = [currentDate, req.body.rId, req.session.userid];
        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql);
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in updating message read flag " + e.stack);
    }
}

/**
 *  Find Buyer Product Message Already Exists
 */
exports.getUserMessagesAlreadyExists = function(req, mysql, q) {
    try {
        strQuery = mysqli.mysqli($mysqli, 'getUserMessagesAlreadyExists');
        var escape_data = [req.session.userid, req.session.userid, req.body.pid];
        var defered = q.defer();
        query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
        console.log(query.sql);
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in getting user message already exists or not " + e.stack);
    }
}

/**
 *  Archive User Messages
 */
exports.archiveUserMessages = function(req, mysql, q) {
    try {
        var whereCond = 'to_id = ' + req.session.userid + ' AND to_status != "archive" ';
        /*if(req.body.messageIds && req.body.messageIds != "")
            whereCond += ' AND id IN (' + req.body.messageIds + ') ';*/

        if(req.body.rIds && req.body.rIds != "")
            whereCond += ' AND r_id IN (' + req.body.rIds + ') ';

        $mysqli = { whereCond : whereCond };
        strQuery = mysqli.mysqli($mysqli, 'archiveUserMessages');
        var defered = q.defer();
        query = mysql.query(strQuery, [], defered.makeNodeResolver());
        console.log(query.sql);
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in archiving message details " + e.stack);
    }
}

/**
 *  Delete User Trash Messages
 */
exports.deleteUserTrashMessages = function(req, mysql, q) {
    try {
        var whereCond = 'to_id = ' + req.session.userid + ' AND to_status = "delete" ';
        /*if(req.body.messageIds && req.body.messageIds != "")
            whereCond += ' AND id IN (' + req.body.messageIds + ') ';*/

        if(req.body.rIds && req.body.rIds != "")
            whereCond += ' AND r_id IN (' + req.body.rIds + ') ';

        $mysqli = { whereCond : whereCond };
        strQuery = mysqli.mysqli($mysqli, 'deleteUserTrashMessages');
        var defered = q.defer();
        query = mysql.query(strQuery, [], defered.makeNodeResolver());
        console.log(query.sql);
        query.on('error', function(err) {
            throw err;
        })
        return defered.promise;
    } catch (e) {
        console.log("Error in deleting user trash message details " + e.stack);
    }
}