var nodemailer = require('nodemailer');
var common = require('./common');
var dateFormat = require('dateformat');
var mysqli = require('./mysqli');
var q = require('q');

exports.sendmail = function(template, subject_message, to_email) {
    var helper = require('sendgrid').mail;
    var fromemail = global.general.contactus;
    if (!fromemail) {
        var from_email = new helper.Email("support@hempbuyer.com", "HempBuyer");
    } else {
        var from_email = new helper.Email(fromemail, "HempBuyer");
    }

    var to_email = new helper.Email(to_email);
    var content = new helper.Content('text/html', template);
    var mail = new helper.Mail(from_email, subject_message, to_email, content);
    // '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'
    //SG.kohlhG95Tzifl2W1vnl4kQ.PmJqiI1lxMgw76f0DeTzUlvEnGaphRifAmpJSIfU9gY-w
    //SG.dr_gXxyhRLqJ9iPvA-uIsw.i7ke3AHP8h1NRR53_eSL8nTvO4AC3U69kSBMOcEQfh0-t
    var api_key = global.emaillocal.api;
    // var api_key = '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';
    var sg = require('sendgrid')(api_key);
    var request = sg.emptyRequest({
        method: 'POST',
        path: '/v3/mail/send',
        body: mail.toJSON(),
    });
    sg.API(request, function(error, response) {
        if(error) {
            console.log('sendgrid - error :- ', error);
        }
        console.log('sendgrid - status code :- ', response.statusCode);
        // console.log('body', response.body);
        // console.log('headers', response.headers);
    });
}

exports.sendmail_old = function(data, subject, toemail) {
    var transporter = nodemailer.createTransport({

        service: global.emaillocal.service,
        auth: {

            user: global.emaillocal.user,
            pass: global.emaillocal.pwd,
            secure: 'true'
        }
    });

    var mailOptions = {
        // from: 'Herbee Pro <gmalik.burnett@gmail.com>', // sender address 
        from: global.general.contactus, // sender address 
        to: toemail, // list of receivers 
        subject: subject, // Subject line 
        html: data // html body 
    };
    console.log('sending to detaisl : ' + subject + '---' + toemail);
    transporter.sendMail(mailOptions, function(error, info) {
        if (error) {
            return console.log(error);
        }
        console.log('Message sent: ' + info.response);

    });
}

exports.mailtemps = function(req, mysql, q, event) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 'get_mail_template');
    var defered = q.defer();
    var escape_data = [event];
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    // console.log('query', query.sql);
    query.on("error", function(err) {
        throw err;
    })
    return defered.promise;
}

exports.mailmethods = function(req, mysql, q) {

    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, '841');
    var defered = q.defer();
    var escape_data = [];
    console.log('escape_data' + escape_data);
    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());
    return defered.promise;

}