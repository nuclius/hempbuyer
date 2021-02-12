var q = require('q');
var CronJob = require('cron').CronJob;
var request = require('request')

//close all
/*new CronJob('* * * * * *', function () {
    // console.log('called')
    request({
        rejectUnauthorized: false,
        url: global.url + "/closeProduct"
    }, function (error, response, body) {
            if (!error && response.statusCode == 200) {
                // console.log('Successfull closeall cron every Minute');

            } else {

                console.log('Failed closeall cron');
                console.log(error);
            }
    })
}, null, true, "America/Los_Angeles");*/

/* Start Cron for Check & Change Open Product Status to Closed Once End Date Met */
// EVERY 1 MINUTE CRON RUN
new CronJob('* * * * * *', function() {
    request({
        rejectUnauthorized: false,
        url: global.url + '/changeOpenProductStatus'
    }, function(error, response, body) {
        if (!error && response.statusCode == 200) {
            
        } else {
            console.log('Failed daily status cron');
            console.log(error);
        }
    })
}, null, true);
/* End Cron for Check & Change Open Product Status to Closed Once End Date Met */