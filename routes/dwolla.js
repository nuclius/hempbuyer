var express = require('express');
var dwolla = require('dwolla-v2');
var app = express.Router();
var mysqli = require('../module/mysqli');
var q = require('q');

// console.log("--- testing dwolla ---");

// // var token = "z54o0s5KowfFf8dSTSWaMdzNwBiNh99v36zvZkdKZLEmMu49hd";

// var client = new dwolla.Client({
//     key: "cpBsA6sXvBD6TFxc7QGE1RRLXFImHkNmbNhIgtRuGYVwIwWLPs",
//     secret: "3Q4UlqqcK7bML3rmc2Gae31LW5P8G6Mh1uOj2MZkWVqBX5kqHj",
//     environment: 'sandbox'
//     //     onGrant: function(token) {
//     //   return new Promise(); // here you can return a Promise that saves a token to your database 
//     // },
// });


// var token = new client.Token({
//     access_token: "z54o0s5KowfFf8dSTSWaMdzNwBiNh99v36zvZkdKZLEmMu49hd",
//     refresh_token: "0pIA6PFT31mkJd6URu6m2IbQQfX9TdA",
//     expires_in: 123,
//     scope: "ManageCustomers",
//     account_id: "2190f654-faea-4cc3-863e-862515ef56dc"
// });

// console.log(token);

// /* Creating customers */
// var requestBody = {
//     firstName: "Johnw",
//     lastName: "Doew",
//     email: "johndoe123@dwolla.com",
//     ipAddress: "10.10.10.11",
//     type: "personal",
//     address1: "221 Corrected Address St.",
//     address2: "Fl 8",
//     city: "Ridgewood",
//     state: "NY",
//     postalCode: "11385",
//     dateOfBirth: "1990-07-11",
//     ssn: "202-99-1515"
// };

// // client.auth.client()
// //   .then(function(appToken) {
// //     console.log(appToken);
// //     return appToken.post('customers', requestBody)
// //   })
// //   .then(function(res) {
// //     console.log(JSON.stringify(res.body));
// //   });


// token.post('customers', requestBody).then(function(res) {
//     console.log("res here : " + res.status);
// }, function(error) {
//     console.log(error);
//     // when the server return a status >= 400 
// });

// /* Getting list of customers */
// token.get('customers', { limit: 10 }).then(function(res) {
//     console.log("res here : " + res)
// }, function(error) {
//     console.log(error);
//     throw error;
// });


// /* Getting specific customer */
// var customerUrl = 'https://api-sandbox.dwolla.com/customers/07D59716-EF22-4FE6-98E8-F3190233DFB8';

// token.get(customerUrl).then(function(res) {
//     console.log("res here : " + res)
// }, function(error) {
//     throw error;
// });

module.exports = app;