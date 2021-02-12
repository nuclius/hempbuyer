// #### load required Modules ##################################################

var express = require('express');
var reload = require('reload');
var sprintf = require('sprintf').sprintf;
var common = require('../module/common');
var user = require('../module/hmb_user');
var pagination = require('pagination');

var openBidProducts = require('../module/openbidproducts');
var async = require('async');
var app = express.Router();
var q = require('q');
var request = require('request');
var dateFormat = require('dateformat');
var cronJob = require('cron');
var faAPI = require('../module/forwardauction_api');
var stores = require('../module/stores');
var Template = require('../module/templates');
var _ = require('underscore')
var product = require('../module/hmb_product');
var products = require('../module/products');
var admin = require('../module/admin');

var hmbLogin = require('../module/hmb_login');
var localm = require('../module/localmail');

var md5 = require('MD5');


app.post('/checkusername', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    q.all([user.checkusername(config.mysql, req)]).then(function (results) {
        var obj = {
            username: 'N'
        };
        if (results[0][0].length > 0) {
            obj.username = 'Y';
        }
        res.send(obj);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.post('/checkmail', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    q.all([user.checkemail(config.mysql, req)]).then(function (results) {
        var obj = {
            email: 'N'
        };
        if (results[0][0].length > 0) {
            obj.email = 'Y';
        }
        res.send(obj);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.post('/verify_referral', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    q.all([user.verify_referral(config.mysql, req)]).then(function (results) {
        var obj = {
            exist: 'N',
            userid: 0,
            created_at: ''
        };
        if (results[0][0].length > 0) {
            obj.exist = 'Y';
            obj.userid = results[0][0][0].id;
            obj.created_at = results[0][0][0].created_at;
        }
        res.send(obj);

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});

app.post('/signup', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);


    console.log("Sign Up Called", req.body)
    var request = require('request');


    if (req.body.user_type == 100) {
        
        var url = 'https://staging.ws.idms.lexisnexis.com/restws/identity/v3/accounts/56719/workflows/1luckydog.iid.fp.online/conversations';
        if(global.general.lexis_nexis_live == 'yes') {
            url = 'https://ws.idms.lexisnexis.com/restws/identity/v3/accounts/56719/workflows/1luckydog.iid.fp.online/conversations';
        }
        var options = {
            'method': 'POST',
            'url': url,
            'headers': {
                'Content-Type': 'application/json',
                'Authorization': 'Basic ' + global.general.lexis_nexis_key
            },
            body: JSON.stringify({
                "Type": "Initiate",
                "Settings": {
                    "Mode": "testing",
                    "Reference": "Reference1",
                    "Locale": "en_US",
                    "Venue": "online"
                },
                "Persons": [{
                    "Name": {
                        "FirstName": req.body.cg_name.toString().split(' ')[0],
                        "LastName": req.body.cg_name.toString().split(' ')[1]
                    },
                    "Addresses": [{
                        "StreetAddress1": req.body.cg_address,
                        "City": req.body.cg_city,
                        "State": req.body.cg_state,
                        "Zip5": req.body.cg_zipcode,
                        "Country": "US",
                        "Context": "primary"
                    }],
                    "SSN": {
                        "Number": req.body.cg_ssn.replace(/-/g, ''),
                        "Type": "ssn9"
                    },
                    "DateOfBirth": {
                        "Year": 1947,
                        "Month": 8,
                        "Day": 10
                    },
                    "Phones": [{
                        "Number": req.body.cg_phone.replace("+1", "").replace("(", "").replace(")", "").replace("-", "").replace(/ /g, ""),
                        "Context": "home"
                    }],
                    "Context": "primary"
                }]
            })
        };
    } else {
        var cg_ssn = '';
        if (req.body.user_type == 102)
            cg_ssn = req.body.cg_rep_ssn.replace(/-/g, '');
        else if (req.body.user_type == 101)
            cg_ssn = req.body.cg_ssn.replace(/-/g, '');

        var url = 'https://staging.ws.idms.lexisnexis.com/restws/identity/v3/accounts/56719/workflows/1luckydog.biid.fp.online/conversations';
        if(global.general.lexis_nexis_live == 'yes') {
            url = 'https://ws.idms.lexisnexis.com/restws/identity/v3/accounts/56719/workflows/1luckydog.biid.fp.online/conversations';
        }
        var options = {
            'method': 'POST',
            'url': url,
            'headers': {
                'Content-Type': 'application/json',
                'Authorization': 'Basic ' + global.general.lexis_nexis_key
            },
            body: JSON.stringify({
                "Type": "Initiate",
                "Settings": {
                    "Mode": "testing",
                    "Reference": "Reference1",
                    "Locale": "en_US",
                    "Venue": "online"
                },
                "Persons": [{
                    "Name": {
                        "FirstName": req.body.cg_name.toString().split(' ')[0],
                        "LastName": req.body.cg_name.toString().split(' ')[1]
                    },
                    "Addresses": [{
                        "StreetAddress1": req.body.cg_address,
                        "City": req.body.cg_city,
                        "State": req.body.cg_state,
                        "Zip5": req.body.cg_zipcode,
                        "Country": "US",
                        "Context": "primary"
                    }],
                    "SSN": {
                        "Number": cg_ssn,
                        "Type": "ssn9"
                    },
                    "DateOfBirth": {
                        "Year": 1947,
                        "Month": 8,
                        "Day": 10
                    },
                    "Phones": [{
                        "Number": req.body.cg_phone.replace("+1", "").replace("(", "").replace(")", "").replace("-", "").replace(/ /g, ""),
                        "Context": "home"
                    }],
                    "Context": "primary"
                }],

                "Businesses": [
                    {
                        "CompanyName": req.body.cg_rep_name,
                        "Fein": cg_ssn,
                        "Addresses": [
                            {
                                "StreetAddress1": "",//req.body.cg_rep_address,
                                "City": req.body.cg_rep_city,
                                "State": req.body.cg_rep_state,
                                "Zip5": req.body.cg_rep_zipcode,
                                "Country": "US",
                                "Context": "primary"
                            }
                        ],
                        "Phones": [
                            { 
                                "Number": req.body.cg_rep_phone.replace("+1", "").replace("(", "").replace(")", "").replace("-", "").replace(/ /g, ""),
                                "Context": "business"
                            }
                        ]
                    }
                ]
            })
        };
    }
    console.log("options", options)

    request(options, function (error, response) {
        if (error) {
            var obj = {
                status: 400
            };
            res.send(obj)
            throw new Error(error);
        }

        var Lexis_First_Resp = JSON.parse(response.body)
        console.log(response.body, "Lexis Response", Lexis_First_Resp.Status);

        if (Lexis_First_Resp.Status && Lexis_First_Resp.Status.TransactionStatus == 'passed') {

            console.log('Second Call');
            var url = 'https://staging.ws.idms.lexisnexis.com/restws/identity/v3/accounts/56719/workflows/1luckydog.otp.iidqa.online/conversations';
            if(global.general.lexis_nexis_live == 'yes') {
                url = 'https://ws.idms.lexisnexis.com/restws/identity/v3/accounts/56719/workflows/1luckydog.otp.iidqa.online/conversations';
            }
            options.url = url;


            request(options, function (error, secondResponse) {
                if (error) {
                    var obj = {
                        status: 400
                    };
                    res.send(obj)
                    throw new Error(error);
                }


                var Lexis_Second_Resp = JSON.parse(secondResponse.body);

                console.log('secondResponse', secondResponse)
                if (Lexis_Second_Resp && Lexis_Second_Resp.Status.TransactionStatus == 'pending') {


                    if (Lexis_Second_Resp.Status.ActionType == 'answers') {
                        var LexisRes = Lexis_Second_Resp.Products.filter(x => x.ExecutedStepName == 'IIDQA');
                        if (LexisRes && LexisRes.length > 0) {
                            LexisRes = LexisRes[0].QuestionSet;
                        }

                        var htmlTemplate = `<form name="lexisForm" id="lexisForm"> 
                        <input type="hidden" value=${LexisRes.QuestionSetId}  name="QuestionSetId" id="QuestionSetId"/>
                        <input type="hidden" value=${Lexis_Second_Resp.Status.ConversationId}  name="ConversationId" id="ConversationId"/>
                        <input type="hidden" value=${LexisRes.Questions.length}  name="TotalQues" id="TotalQues"/>
                        <input type="hidden" value=${Lexis_Second_Resp.Status.ActionType}  name="ActionType" id="ActionType"/>
                        
                        `

                        for (var i = 0; i < LexisRes.Questions.length; i++) {
                            htmlTemplate += `
                            <input type="hidden" value=${LexisRes.Questions[i].QuestionId}  name="QuestionId_${i}" />
                            <label style="font-weight:bold">${LexisRes.Questions[i].Text.Statement}</label><br>
                            `;

                            for (var j = 0; j < LexisRes.Questions[i].Choices.length; j++) {
                                htmlTemplate += `
                                <input type="radio" id="QuestionAns_${i}_${j}" style="position:unset" name="QuestionAns_${i}" value="${LexisRes.Questions[i].Choices[j].ChoiceId}">
                                <label for="QuestionAns_${i}_${j}">${LexisRes.Questions[i].Choices[j].Text.Statement}</label>
                                <br>
                                `
                            }
                        }

                        htmlTemplate += `
                        <button type="button" onclick="submitAuthentication()" value="Submit" class="btn btn-success btn-block" style="marting-top:25px">Submit</button>
                        </form>`;

                        var obj = {
                            status: 200,
                            info: htmlTemplate
                        };
                        res.send(obj)
                        return false;
                    }

                } else {
                    var obj = {
                        status: 400,
                        info: 'Please Try Again!'
                    };
                }
            });

        } else {
            var obj = {
                status: 400,
                info: 'Authentication Failed'//Lexis_First_Resp.Information[0].DetailDescription[0].Text
            };
            res.send(obj)
        }
    });





});

app.post('/signupAuthentication', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);


    var formDt = req.body.formDt;
    var queryString = req.body.lexisDt;
    if(queryString.indexOf('?') > -1){
        queryString = queryString.split('?')[1];
      }
      var pairs = queryString.split('&');
      var result = {};
      pairs.forEach(function(pair) {
        pair = pair.split('=');
        result[pair[0]] = decodeURIComponent(pair[1] || '');
      });
    req.body = result

    console.log("Sign Up Called", req.body)
    var request = require('request');

    var answerJson = ` { "QuestionSetId": ${req.body.QuestionSetId},
    "Questions": [ `;

    if (req.body.ActionType == 'answers') {
        for (var i = 0; i < +req.body.TotalQues; i++) {
            answerJson += `{"QuestionId" : ${req.body['QuestionId_' + i]}, 
            "Choices": [
                {
                  "Choice": ${req.body['QuestionAns_' + i]}
                }]}`

            if (i != ((+req.body.TotalQues) - 1)) {
                answerJson += `,`
            }
        }
    }

    answerJson += `]}`

    console.log("answerJson : ", answerJson);
    var url = 'https://staging.ws.idms.lexisnexis.com/restws/identity/v3/accounts/56719/workflows/1luckydog.iid.fp.online/conversations/' + req.body.ConversationId;
    if(global.general.lexis_nexis_live == 'yes') {
        url = 'https://ws.idms.lexisnexis.com/restws/identity/v3/accounts/56719/workflows/1luckydog.iid.fp.online/conversations/' + req.body.ConversationId;
    }
    var options = {
        'method': 'PUT',
        'url': url,
        'headers': {
            'Content-Type': 'application/json',
            'Authorization': 'Basic ' + global.general.lexis_nexis_key
        },
        body: JSON.stringify({
            "Type": "Continue",
            "Settings": {
                "Mode": "testing",
                "Locale": "en_US",

            },
            "Answers": JSON.parse(answerJson)
        })
    };

    // console.log("options", options)

    request(options, function (error, response) {
        if (error) {
            var obj = {
                status: 400
            };
            res.send(obj)
            throw new Error(error);
        }

        var Lexis_First_Resp = JSON.parse(response.body)
        console.log(response.body, "Lexis Response");

        if (Lexis_First_Resp.Status && Lexis_First_Resp.Status.TransactionStatus == 'passed') {
            console.log("Passed")
            req.body = formDt;
            q.all([
                user.saveUser(req, config.mysql, q)
            ]).then(function (results) {
                var activeurl = '<br/> <a href="' + $arr.config.spath + '/signin">click here to Login...</a>';

                if (global.emaillocal.status == 'yes') {
                    q.all([localm.mailtemps(req, config.mysql, q, 'register')]).then(function (results2) {
                        if (results2) {
                            var template = results2[0][0][0].template;
                            var subject_message = results2[0][0][0].subject;
                            var logo_url = $arr.config.spath + 'images/logo.png';

                            template = template.replace('{{event.sitename}}', config.title);
                            template = template.replace('{{event.url}}', activeurl);
                            template = template.replace('{{event.user}}', req.body.cg_name);
                            template = template.replace('{{event.siteurl}}', $arr.config.url);
                            template = template.replace('{{event.logo_url}}', logo_url);
                            // template = template.replace('{{event.user}}', req.body.first_name + ' ' + req.body.last_name);

                            localm.sendmail(template, subject_message, req.body.cg_email);

                        } else {
                            console.log("No Templates named register");
                        }

                    }).fail(function (err) {
                        console.log(err.stack);
                        throw err;
                    });
                }

                var obj = {
                    status: 200
                };
                res.send(obj)
            });
           



        } else {
            var obj = {
                status: 400,
                info: 'Authentication Failed from LexisNexis'//Lexis_First_Resp.Information[0].DetailDescription[0].Text
            };
            res.send(obj)
        }
    });

});

app.post('/subscribe', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    q.all([user.checkemail(config.mysql, req), user.checkSubscribe(config.mysql, req)]).then(function (resultsUser) {
        if (resultsUser[1][0].length) {
            var obj = {
                status: 400,
                success: false,
                message: 'You have already subscribed.'
            };
            res.send(obj);
        } else {
            req.body.existing_user = 0;
            req.body.user_id = 0;
            console.log('resultsUser[0][0].length', resultsUser[0][0].length);
            if (resultsUser[0][0].length) {
                req.body.existing_user = 1;
                req.body.user_id = resultsUser[0][0][0].id;
            }

            q.all([user.subscribe(config.mysql, req)]).then(function (results) {
                var obj = {
                    status: 200,
                    success: true
                };
                res.send(obj);
            }).fail(function (err) {
                console.log(err.stack);
                throw err;
            }).done();
        }

    }).fail(function (err) {
        console.log(err.stack);
        throw err;
    }).done();
});
app.post('/set_shipping_info', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);
    req.body.shipping_id = req.body.shipping_id != undefined ? req.body.shipping_id : 0;

    q.all([
        user.set_shipping_info(req, config.mysql, q)
    ]).then(function (results) {
        console.log('results', results[0][0]);
        var obj = {
            status: 200,
            success: true,
            result: results[0][0]
        };
        res.send(obj);
        return false;
    }).fail(function (err) {
        var obj = {
            status: 500,
            success: false,
            err: err
        };
        res.send(obj);
        return false;
    }).done();
});

app.post('/get_shipping_details', function (req, res) {
    var extend = require('util')._extend;
    var arr_temp = extend({}, $arr);

    q.all([
        user.get_shipping_details(req, config.mysql, q)
    ]).then(function (results) {
        var obj = {
            status: 200,
            success: true,
            result: results[0][0][0]
        };
        res.send(obj);
        return false;
    }).fail(function (err) {
        var obj = {
            status: 500,
            success: false,
            err: err
        };
        res.send(obj);
        return false;
    }).done();
});

module.exports = app;