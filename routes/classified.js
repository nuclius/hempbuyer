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

var express = require('express');
var common = require('../module/common');
var app = express.Router();
var q = require('q');
var products = require('../module/products');
var hmb_product = require('../module/hmb_product');
var classified = require('../module/classified');
var localm = require('../module/localmail');


app.use(function (req, res, next) {
    // common.checkLogin(req, res, 0);
    // classified = require('../module/classified');
    //req.session.userid = 1;
    next();

});
app.post('/contact', function (req, res) {
    //common.checkLogin(req,res,0);
    message = require('../module/message');
    q.all([classified.classifiedDetail(req, config.mysql, q)]).then(function (results) {
        var dat = require('date-util');
        var pid = results[0][0][0]

        req.body.fromid = req.session.userid;
        req.body.first_name = pid.first_name;
        req.body.last_name = pid.last_name;
        req.body.r_id = Date.parse(new Date()) / 1000;
        req.body.toemail = pid.email;
        req.body.toid = pid.user_id;
        req.body.pid = 0;
        req.body.classified_id = pid.id;
        req.body.subject = 'Buyer Sent a Message Regards ' + pid.title;
        req.session.placedcontract = true;
        message.addmessages(req, config.mysql, q);
        res.writeHead(302, {
            'Location': '/classified/view?id=' + req.body.id
        });
        res.end();
        return false;
    });
});
app.post(['/post/'], function (req, res) {
    var admin = require('../module/admin');
    q.all(classified.addClassified(req, $arr.config.mysql, q)).then(function (l) {
        req.body.id = l[0].insertId;
        if (typeof (req.body.files) !== 'undefined') {



            for (var im = 0; im < req.body.files.length; im++) {

                if (req.body.old[im] == 0) {
                    s = [];
                    s.name = req.body.files[im];
                    s.originalname = req.body.fnames[im];
                    classified.caddAttachment(s, config.mysql, q, req.body.id);
                }
            }

        }
        common.tplFile('classified/post.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});



app.get(['/'], function (req, res) {
    // res.redirect('/comingsoon');

    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

/*    common.tplFile('coming_soon.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, arr_temp);*/
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    /*return;*/

    q.all([
        classified.getClassified(req, arr_temp.config.mysql, q),
        products.getStateListUnique(req, config.mysql, q)
    ]).then(function (results2) {
        for (var index = 0; index < results2[0][0].length; index++) {
            results2[0][0][index].images = results2[0][0][index].images.split(',');
        }
        arr_temp['stateList'] = results2[1][0];
        arr_temp['categoryList'] = [
            { value: 'banking_pos', text: 'Banking/POS' },
            { value: 'consulting_professional_services', text: 'Consulting/ Professional Services' },
            { value: 'financial_insurance', text: 'Financial/Insurance' },
            { value: 'legal', text: 'Legal' },
            { value: 'processing_drying_trimming', text: 'Processing/Drying/ Trimming' },
            { value: 'tolling_extraction_lab', text: 'Tolling/Extraction/ Lab' },
            { value: 'transport_storage', text: 'Transport/Storage' },
            { value: 'white_labeling', text: 'White Labeling' },
            { value: 'everything_else', text: 'Everything Else' }
        ];

        console.log('results2[0][0]', results2[0][0]);
        arr_temp['data'] = results2[0][0];
        common.headerSet(1);
        common.tplFile('classified.tpl');
        common.loadTemplateHeader(req, res, arr_temp);
    });

});


app.get(['/add'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    q.all([
        products.getStateListUnique(req, config.mysql, q)
    ]).then(function (results2) {
        arr_temp['stateList'] = results2[0][0];
        arr_temp['categoryList'] = [
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

        common.headerSet(1);
        common.tplFile('classified-form.tpl');
        common.loadTemplateHeader(req, res, arr_temp);
    });

});

app.post(['/add'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);


    q.all([classified.addNewClassified(req, $arr.config.mysql, q)]).then(function (results2) {
        res.json({status : 'success'});
        res.end();
        return false;
    });

});


app.post('/addImage/:cntfle', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    console.log('req.files', req.files);
    var finalresult = {
        document: []
    };

    if (req.param('cntfle') > 1) {
        for (l in req.files.classified) {
            req.files.classified[l].basenam = (typeof (req.files.classified[l].name) === 'undefined') ? '' : req.files.classified[l].name.substr(0, req.files.classified[l].name.lastIndexOf('.'));
        }
        finalresult.document = req.files.classified;
    } else {
        req.files.classified.basenam = (typeof (req.files.classified.name) === 'undefined') ? '' : req.files.classified.name.substr(0, req.files.classified.name.lastIndexOf('.'));
        finalresult.document.push(req.files.classified);
    }
    // finalresult.s3Url = global.settingscdn.s3_image_url;
    console.log(finalresult)
    res.json(finalresult);
    res.end();
    return false
});



app.post(['/deleteImage'], function (req, res) {

    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    if (req.body.certificate_id > 0) {
        // q.all([product.deletecertificate(req, res, config.mysql, q)]).then(function (results) {
        res.json(1);
        res.end();
        return false;
        // }).fail(function (err) {
        //     console.log(err.stack);
        //     throw err;
        // }).done();
    } else {
        fs.unlink(global.path + "/public/uploads/classified/" + req.body.name, function (err) {
            if (!err) {
                console.log('successfully deleted ' + req.body.name);
            }
            product.deleteProductDocumentByName(req, config.mysql, q, req.body.name);
        });
        res.json(1);
        res.end();
        return false;
    }
});

app.post(['/contact_seller'], function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    q.all([
        hmb_product.getClassifiedDetail(req, config.mysql, q),
        localm.mailtemps(req, config.mysql, q, 'classified_contact'),
        localm.mailtemps(req, config.mysql, q, 'contact_us_response')
    ]).then(function (results2) {
        console.log('results2[0][0][0]', results2[0][0]);
        var classifiedData = results2[0][0][0];
        console.log('classifiedData', classifiedData);

        var template = results2[1][0][0].template;
        var subject_message = results2[1][0][0].subject;
        var logo_url = $arr.config.spath + 'images/logo.png';

        template = template.replace('{{event.sitename}}', config.title);
        template = template.replace('{{event.url}}', $arr.config.spath);
        template = template.replace('{{event.user}}', classifiedData['seller_name']);
        template = template.replace('{{event.siteurl}}', $arr.config.url);
        template = template.replace('{{event.logo_url}}', logo_url);
        template = template.replace('{{event.full_name}}', req.body.full_name);
        template = template.replace('{{event.email}}', req.body.email);
        template = template.replace('{{event.message}}', req.body.message);
        localm.sendmail(template, subject_message, classifiedData['seller_email']);

        console.log('contact_us_response');
        var template = results2[2][0][0].template;
        var subject = results2[2][0][0].subject;
        var logo_url = $arr.config.spath + 'images/logo.png';
        template = template.replace('{{event.user}}', req.body.full_name);
        template = template.replace('{{event.sitename}}', config.title);
        template = template.replace('{{event.logo_url}}', logo_url);
        localm.sendmail(template, subject, req.body.email);
        console.log('req.body.email', req.body.email);

        res.json({
            status: 200,
            success: true,
            retult: results2[0][0][0]
        });
        res.end();
        return false;
    });

});
module.exports = app;
