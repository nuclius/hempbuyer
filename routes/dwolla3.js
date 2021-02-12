var express = require('express');
var dwolla = require('dwolla-v2');
var app = express.Router();
var mysqli = require('../module/mysqli');
var q = require('q');

console.log("--- testing dwolla ---");

/* temporary generated token for sandbox account */
var token = "2hXHBCDHaiybb82pt6EYfz6fDHhU6TntDdzhaQ7pv4FIk6vekA";

var client = new dwolla.Client({
    key: "cpBsA6sXvBD6TFxc7QGE1RRLXFImHkNmbNhIgtRuGYVwIwWLPs",
    secret: "3Q4UlqqcK7bML3rmc2Gae31LW5P8G6Mh1uOj2MZkWVqBX5kqHj",
    environment: 'sandbox',
    onGrant: function(token) {
        console.log(token);
        return new Promise(token); // here you can return a Promise that saves a token to your database 
    },
});

var appToken = new client.Token({
  access_token: "2hXHBCDHaiybb82pt6EYfz6fDHhU6TntDdzhaQ7pv4FIk6vekA",
  refresh_token: "refresh_token",
});

client.auth.client()
  .then(function(appToken) {
    return appToken.get('webhook-subscriptions');
  })
  .then(function(res) {
    console.log(JSON.stringify(res.body));
  });

console.log(appToken);
console.log(token);

// var accountToken = new client.Token({ access_token: "2hXHBCDHaiybb82pt6EYfz6fDHhU6TntDdzhaQ7pv4FIk6vekA", refresh_token: "sample_refresh_token_here" });

module.exports = app;