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
var common = require('../../module/common');
var app = express.Router();
var admin = require('../../module/admin');
var pagination = require('pagination');
var async = require('async');
var faAPI = require('../../module/forwardauction_api');
var login = require('../../module/hmb_login');

var q = require('q');
// var q = require('q');
//required js


app.get(['/login', '/login/:error'], function(req, res) {
    // common.admincheckLogin(req, res, 1);
    $arr.redirect_url = req.query.redirect ? req.query.redirect : '';

    req.body.error = $arr['error'] = (typeof(req.param('error')) === 'undefined') ? '' : req.param('error');
    common.tplFile('admincp/hmb_login.tpl');
    common.headerSet(1);
    common.loadTemplateHeader(req, res, $arr);

});

app.post(['/login/save'], function(req, res) {

    if (typeof(req.body.autologin) == 'undefined')
        common.checkLogin(req, res, 1);
    else
        req.session.autologin = req.body.autologinoption;

    function processObject(row) {
        if (row.length > 0) {
            if (row[0].role == 0) {
                delete req.session.userid;
                delete req.session.email;
                delete session;
                req.session.admin = 1;
                req.session.email = row[0].email;
                req.session.userid = row[0].id;
                req.session.role = row[0].role;
                req.session.name = row[0].name;
                req.session.tpermission = 'no';
                $arr.loged = req.session;

                if(req.body.redirect_url) {
                    res.writeHead(302, {
                        // 'Location': req.body.redirect_url
                        'Location': '/admincp/dashboard'
                    });
                    res.end();
                } else {
                    res.writeHead(302, {
                        'Location': '/admincp/dashboard'
                    });
                    res.end();
                }
            } else {
                res.writeHead(302, {
                    'Location': '/admincp/login/Invalid login'
                });
                res.end();
            }
        } else {
            res.writeHead(302, {
                'Location': '/admin/login/Invalid login'
            });
            res.end();
        }
    }
    var userprocess = login.process(req, config.mysql, processObject);
    
});

module.exports = app;

