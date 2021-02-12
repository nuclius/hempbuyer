var express = require('express');
// var dwolla = require('dwolla-v2');

var app = express.Router();
var mysqli = require('../module/mysqli');
var q = require('q');

// Instantiate a Dwolla API client 
var Dwolla = require('dwolla-node')(['{CLIENT_ID}', '{CLIENT_SECRET}']);
 
// Set a user's OAuth token 
Dwolla.setToken('[TOKEN]');
 
// Use the Sandbox API environment, instead of production 
Dwolla.sandbox = true;
 
// Send money to a Dwolla ID: 812-626-8794 
Dwolla.send('[PIN]', '812-626-8794', 1.00, function(error, transactionId) {
    if(error) { console.log('Error: ' + error); }
 
    console.log('Transaction ID: ' + transactionId);
});





/*
var client = new dwolla.Client({
    key: '3I0dFvJ75A1uzSdeJGwSdmqQibHlHKpKsCnyMtCcXSpLWOHDmL',
    secret: 'eYWCNKxnLAZzXtj7fhjR7Ys9I2nrmiI6ToXNI8zDNzwJLVk4YW',
    environment: 'sandbox'
});

app.get('/check/callback', function(req, res) {

    client.auth.client()
        .then(function(appToken) {
            return appToken.get('webhook-subscriptions');
        })
        .then(function(res) {
            console.log(JSON.stringify(res.body));
            console.log("checking callback");
            console.log("checked");
            res.json({ msg: "success" });
        });

});*/


module.exports = app;