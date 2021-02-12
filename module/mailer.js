const nodemailer = require('nodemailer');
var mysqli = require('./mysqli');
var q = require('q');

exports.sendmail = function(msubject,toemail,tempId, params){
    // using SendGrid's v3 Node.js Library
    var helper = require('sendgrid').mail;
    var moment = require('moment');
    from_email = new helper.Email("support@auctionsoftware.com");
    to_email = new helper.Email(toemail);
    subject = msubject;
    content = new helper.Content("text/html", " ");
    mail = new helper.Mail(from_email, subject, to_email, content);

    //Replacing the template variables. 
    //Use same paramname in both sendgrid template and params JSON.
    Object.keys(params).forEach(function(key,index) {
        //Replace the variable in sendgrid template with the param key.
        mail.personalizations[0].addSubstitution(new helper.Substitution('-'+key+'-', ""+params[key]+""));
    });
    mail.personalizations[0].addSubstitution(new helper.Substitution('|CURRENT_YEAR|', ""+moment().year()+""));
    mail.personalizations[0].addSubstitution(new helper.Substitution('|LIST:COMPANY|', "Auctionsoftware.com"));
    mail.personalizations[0].addSubstitution(new helper.Substitution('|mail_address|', "support@auctionsoftware.com"));
    //Load template from sendgrid here
    mail.setTemplateId(tempId);

    //Sendgrid invoke with API key.
    var sg = require('sendgrid')("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");

    var request = sg.emptyRequest({
        method: 'POST',
        path: '/v3/mail/send',
        body: mail.toJSON()
    });

    sg.API(request, function(error, response) {
        console.log(response.statusCode);
        console.log(response.body);
        console.log(response.headers);
    });
}

exports.getemail = function(req,mysql,q, template_name){
    $mysqli =  {};
    strQuery = mysqli.mysqli($mysqli,'findemail');
    var defered = q.defer();
    var escape_data =  [template_name]
    query =  mysql.query(strQuery,escape_data,defered.makeNodeResolver());
    console.log(query.sql);
    return defered.promise;
}


exports.sendmaillocalm = function(data,subject,toemail){ 
    console.log(toemail);
    var dateFormat = require('dateformat');
    var date = require('date-utils');
    
    data = data.replace('*|CURRENT_YEAR|*', dateFormat(new Date(), "yyyy"))
    data = data.replace('*|LIST:COMPANY|*', "AuctionSoftware");

    var transporter = nodemailer.createTransport({
    
    service: global.emaillocal.service,
        auth: {
            user: global.emaillocal.user,
            pass: global.emaillocal.pwd,
            secure: 'true'
        }
    });
    
    var mailOptions = {
        from: 'Auction Software <support@auctionsoftware.com>', // sender address 
        to: toemail, // list of receivers 
        subject: subject, // Subject line 
        html: data // html body 
    };
    transporter.sendMail(mailOptions, function(error, info){
    if(error){
        return console.log(error);
    }
    console.log('Message sent: ' + info.response);
});

}