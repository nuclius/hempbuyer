var CronJob = require('cron').CronJob;
var request = require('request');

/* Start Cron for Reminders */
// new CronJob('*/5 * * * * *', function() {
new CronJob('00 01 00 * * *', function() {

    request({
        rejectUnauthorized: false,
        url: global.url + '/dailyremainder'
    }, function(error, response, body) {
        if (!error && response.statusCode == 200) {
            console.log('Successfull daily cron');
            // console.log(body) // Show the HTML for the Google homepage.
        } /*else {
            console.log('Failed daily cron');
            console.log(error);
        }*/
    })
}, null, true);
/* End Cron for Reminders */

/* Start Cron for Check & Change Open Product Status to Closed Once End Date Met */
// EVERY 1 MINUTE CRON RUN
new CronJob('*/10 * * * * *', function() {
    request({
        rejectUnauthorized: false,
        url: global.url + '/changeOpenProductStatus'
    }, function(error, response, body) {
        if (!error && response.statusCode == 200) {
            // console.log('Successfully product status cron');
        } /*else {
            console.log('Failed daily status cron');
            console.log(error);
        }*/
    })
}, null, true);
/* End Cron for Check & Change Open Product Status to Closed Once End Date Met */

/* Start Cron for remove from featured */
new CronJob('*/15 * * * * *', function() {
    request({
        rejectUnauthorized: false,
        url: global.url + '/removeFromFeaturedAuction'
    }, function(error, response, body) {
        if (!error && response.statusCode == 200) {
            // console.log('Successfully product status cron');
        } /*else {
            console.log('Failed daily status cron');
            console.log(error);
        }*/
    })
}, null, true);
/* End Cron for remove from featured */

/* Start Cron for Check unread offer message */
// EVERY 1 MINUTE CRON RUN
// new CronJob('*/59 * * * * *', function() {
//     request({
//         rejectUnauthorized: false,
//         url: global.url + '/send_mail_to_unread_chat_offer'
//     }, function(error, response, body) {
//         if (!error && response.statusCode == 200) {
//             // console.log('Successfully product status cron');
//         } /*else {
//             console.log('Failed daily status cron');
//             console.log(error);
//         }*/
//     })
// }, null, true);
/* End Cron for Check unread offer message */
