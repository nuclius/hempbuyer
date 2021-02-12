var fs = require('fs');
//config = configure.app();
var mysqli = require('./mysqli');
var dateFormat = require('dateformat');


// exports.save = function(obj,req,res)
// {  


//     var isupload = false;

// 	if(obj == 'product' && typeof(req.files.product_image) !== 'undefined')
// 	{	

// 	 var file = req.files.product_image;	
// 	 var path = config.path+'/uploads/'+file.name;
// 	 var dest = config.path+'/uploads/product/'+file.name;
// 	 var isupload = true;     
//     }
// 	file = '';
// 	if(typeof(req.files.product_image) !== 'undefined')
// 	{
// 	 var file = req.files.product_image;
// 	}
// 	if(typeof(req.files.profile_image) !== 'undefined')
// 	{
// 	 var file = req.files.profile_image;
// 	}	
// 	if(typeof(req.files.blog_image) !== 'undefined')
// 	{
// 	 var file = req.files.blog_image;
// 	}
// 	if(file != '')
// 	{	
// 		 var path = config.path+'/uploads/'+file.name;
// 		 var dest = config.path+'/public/uploads/'+obj+'/'+file.name;
// 		 var isupload = true; 
// 	    if(isupload)
// 	    {
// 	    	fs.rename(path,dest, function(err){

// 		    });
// 	    }
// 	}



// }

exports.saveTestresultss = function(req,fileObj, mysql, q, productId) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");


    //'insert into product_images (project_id, image, avatar, date_added) values {{imagesData}}';
    // console.log("uploading test results : "+productId);
    // console.log("uploading test results1 : "+req.files);


    var imagesData = "";

    if(fileObj.length > 0 && fileObj !== undefined){
        for (var i = 0; i < fileObj.length; i++) {
            // contacts[i].user_id = uid;
            if (i > 0) {
                imagesData = imagesData + ", (\"" + productId + "\", \"" + fileObj[i].name + "\", \"" + fileObj[i].name + "\", \"" + datge +  "\" , \"image\", \""+fileObj[i].fieldname+"\","+req.session.userid+")";
            } else {
                imagesData = imagesData + "(\"" + productId + "\", \"" + fileObj[i].name + "\", \"" + fileObj[i].name + "\", \"" + datge +  "\" ,\"image\", \""+fileObj[i].fieldname+"\","+req.session.userid+")";
            }
        }
    } else {
        imagesData = imagesData + "(\"" + productId + "\", \"" + fileObj.name + "\", \"" + fileObj.name + "\", \"" + datge +  "\", \"image\", \""+fileObj.fieldname+"\","+req.session.userid+" )";
    }

    console.log('imagesData ++++++++', imagesData);

    $mysqli = { imagesData : imagesData };
    strQuery = mysqli.mysqli($mysqli, 'add_test_results');

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log("-----------add test results------------",query.sql);
    query.on('error', function(err) {
        throw err;
    });

    return defered.promise;
}


exports.deleteTestresultss = function (req, mysql, q, pid, id, uid) {

    //'insert into product_images (project_id, image, avatar, date_added) values {{imagesData}}';

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'delete_fromextraimgs');

    var escape_data = [pid,uid,id]

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function (err) {
        throw err;
    });

    return defered.promise;

}

exports.saveTestresults = function (req, mysql, q, id) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    //'insert into product_images (project_id, image, avatar, date_added) values {{imagesData}}';

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'add_test_result2');

    var escape_data = [
        typeof (req.files.test_results.originalname) !== 'undefined' ? req.files.test_results.originalname : '',
        typeof (req.files.test_results.name) !== 'undefined' ? req.files.test_results.name : '',
        datge,
        id
    ]

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function (err) {
        throw err;
    });

    return defered.promise;

}

exports.saveTestresult = function (req, mysql, q, productId) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");

    //'insert into product_images (project_id, image, avatar, date_added) values {{imagesData}}';

    $mysqli = {};

    strQuery = mysqli.mysqli($mysqli, 'add_test_result');

    var escape_data = [
        typeof (req.files.test_results.originalname) !== 'undefined' ? req.files.test_results.originalname : '',
        typeof (req.files.test_results.name) !== 'undefined' ? req.files.test_results.name : '',
        datge,
        productId
    ]

    var defered = q.defer();

    query = mysql.query(strQuery, escape_data, defered.makeNodeResolver());

    console.log(query.sql);

    query.on('error', function (err) {
        throw err;
    });

    return defered.promise;

}

exports.saveAttachments = function (req, mysql, q, productId) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    console.log("uploading images : " + productId);

    //'insert into product_images (project_id, image, avatar, date_added) values {{imagesData}}';
    //console.log(strQuery);

    console.log(req.files);

    var imagesData = "";
    if (req.files.product_image.length > 0 && req.files.product_image !== undefined) {
        for (var i = 0; i < req.files.product_image.length; i++) {
            // contacts[i].user_id = uid;
            if (i > 0) {
                imagesData = imagesData + ", (\"" + productId + "\", \"" + req.files.product_image[i].originalname + "\", \"" + req.files.product_image[i].name + "\", \"" + datge + "\" )";
            } else {
                imagesData = imagesData + "(\"" + productId + "\", \"" + req.files.product_image[i].originalname + "\", \"" + req.files.product_image[i].name + "\", \"" + datge + "\" )";
            }

        }
    } else {
        imagesData = imagesData + "(\"" + productId + "\", \"" + req.files.product_image.originalname + "\", \"" + req.files.product_image.name + "\", \"" + datge + "\" )";
    }

    $mysqli = { imagesData: imagesData };
    strQuery = mysqli.mysqli($mysqli, 'add_product_images');

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    });

    return defered.promise;

}

exports.saveExtraAttachments = function (req, mysql, q, productId) {

    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    console.log("uploading images : " + productId);

    //'insert into product_images (project_id, image, avatar, date_added) values {{imagesData}}';
    //console.log(strQuery);

    console.log(req.files);

    var imagesData = "";
    if (req.files.product_image.length > 0 && req.files.product_image !== undefined) {
        for (var i = 0; i < req.files.product_image.length; i++) {
            // contacts[i].user_id = uid;
            if (i > 0) {
                imagesData = imagesData + ", (\"" + productId + "\", \"" + req.files.product_image[i].originalname + "\", \"" + req.files.product_image[i].name + "\", \"" + datge + "\" )";
            } else {
                imagesData = imagesData + "(\"" + productId + "\", \"" + req.files.product_image[i].originalname + "\", \"" + req.files.product_image[i].name + "\", \"" + datge + "\" )";
            }
        }
    } else {
        imagesData = imagesData + "(\"" + productId + "\", \"" + req.files.product_image.originalname + "\", \"" + req.files.product_image.name + "\", \"" + datge + "\" )";
    }

    $mysqli = { imagesData: imagesData };
    strQuery = mysqli.mysqli($mysqli, 'add_extra_attachments');

    var defered = q.defer();

    query = mysql.query(strQuery, defered.makeNodeResolver());
    console.log(query.sql);
    query.on('error', function (err) {
        throw err;
    });

    return defered.promise;

}

/* ===================== start change by divyesh (changes) ===================== */
exports.save = function (obj, req, res) {

    var isupload = false,
        file = '',
        path = "",
        dest = "",
        old_path = '';
    /*if(obj == 'product' && typeof(req.files.product_image) !== 'undefined')
     {

     var file = req.files.product_image;
     var path = config.path+'/uploads/'+file.name;
     var dest = config.path+'/uploads/product/'+file.name;
     var isupload = true;
     }*/
    if (typeof (req.files.test_results) !== 'undefined') {
        file = req.files.test_results;
    } else if (typeof (req.files.wirefund_receipt) !== 'undefined') {
        file = req.files.wirefund_receipt;
    } else if (typeof (req.files.product_image) !== 'undefined') {
        file = req.files.product_image;
    } else if (typeof (req.files.profile_image) !== 'undefined') {
        file = req.files.profile_image;
    } else if (typeof (req.files.blog_image) !== 'undefined') {
        file = req.files.blog_image;
    } else if (typeof (req.files.bulk_import) !== 'undefined') {
        file = req.files.bulk_import;
        console.log('pandi');
        console.log(file);
    } else if (typeof(req.files.cert_analysis_img) !== 'undefined') {
        file = req.files.cert_analysis_img;
    }
    console.log('obj--------------', obj);

    if (obj == 'business') {

        if (typeof (req.files.licenses) !== 'undefined') {
            file[0] = req.files.licenses;
            console.log('req.files.licenses', req.files.licenses);
        }
        if (typeof (req.files.certificates) !== 'undefined') {
            file[1] = req.files.certificates;
            console.log('req.files.certificates', req.files.certificates);
        }
        console.log('business file', file);
        /* if (req.body.helpgrow.toString() === '0' && req.body.HerbeeSalesConsultant.toString() === '1') {
            if (typeof (req.files.cagreement) !== 'undefined') {
                file[2] = req.files.cagreement;
            }
        } */

        if (file !== '') {
            for (var i = 0; i < file.length; i++) { // Iterate through each image and save it in appropriate folder
                if (file[i] != '') {
                    path = config.path + 'public/uploads/' + file[i].fieldname + '/' + file[i].name;
                    dest = config.path + 'public/uploads/' + file[i].fieldname + '/' + file[i].name;
                    isupload = true;
                    if (isupload) {
                        fs.rename(path, dest, function (err) {
                            fs.unlink(path, function (err) { });
                        });
                    }
                }
            }
        }

    } else if (obj == 'cagreementInsert') {

        if (typeof (req.files.cagreement) !== 'undefined' && req.files.cagreement.name != undefined) {
            var dir = config.path + 'public/uploads/cagreement';
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            console.log('cagreementInsert req.files.cagreement ', req.files.cagreement);
            path = config.path + 'public/uploads/certificates/' + req.files.cagreement.name;
            dest = config.path + 'public/uploads/' + req.files.cagreement.fieldname + '/' + req.files.cagreement.name;
            fs.rename(path, dest, function (err) {
                fs.unlink(path, function (err) { });
            });
        }

    } else if (obj == 'cagreement') {

        if (typeof (req.files.cagreement) !== 'undefined' && typeof (req.files.cagreement.name) !== 'undefined') {
            var dir = config.path + 'public/uploads/cagreement';
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            console.log('req.files.cagreement', req.files.cagreement);
            path = config.path + 'public/uploads/' + req.files.cagreement.name;
            dest = config.path + 'public/uploads/' + req.files.cagreement.fieldname + '/' + req.files.cagreement.name;
            // old_path = config.path + 'public/uploads/' + req.files.cagreement.name;
            fs.rename(path, dest, function (err) {
                fs.unlink(path, function (err) { });
                // fs.unlink(path, function (err) { });
                if (req.body.old_consultant_agreement !== undefined) {
                    old_path = config.path + 'public/uploads/' + req.files.cagreement.fieldname + '/' + req.body.old_consultant_agreement;
                    fs.unlink(old_path, function (err) { });
                }
            });
        }

    } else if (obj == 'distributor_service_invoice') {

        if (typeof (req.files.d_invoice) !== 'undefined' && typeof (req.files.d_invoice.name) !== 'undefined') {
            var dir = config.path + 'public/uploads/d_invoice';
            console.log('fs.existsSync(dir)', fs.existsSync(dir));
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            console.log('req.files.d_invoice', req.files.d_invoice);
            path = config.path + 'public/uploads/' + req.files.d_invoice.name;
            dest = config.path + 'public/uploads/' + req.files.d_invoice.fieldname + '/' + req.files.d_invoice.name;
            // old_path = config.path + 'public/uploads/' + req.files.d_invoice.name;
            fs.rename(path, dest, function (err) {
                fs.unlink(path, function (err) { });
                // fs.unlink(path, function (err) { });
                if (req.body.old_consultant_agreement !== undefined) {
                    old_path = config.path + 'public/uploads/' + req.files.d_invoice.fieldname + '/' + req.body.old_consultant_agreement;
                    fs.unlink(old_path, function (err) { });
                }
            });
        }

    } else {
        if (file !== '') { // Only if files are available then continue to move the image file

            if (typeof (file[0]) == "undefined") { // Single file upload
                if (file != '') {
                    path = config.path + 'public/uploads/' + file.name;
                    dest = config.path + 'public/uploads/' + obj + '/' + file.name;
                    isupload = true;
                    if (isupload) {
                        fs.rename(path, dest, function (err) {
                            fs.unlink(path, function (err) { });
                        });
                    }
                }
            } else { // Multi dimensional array
                for (var i = 0; i < file.length; i++) { // Iterate through each image and save it in appropriate folder
                    if (file[i] != '') {
                        path = config.path + 'public/uploads/' + file[i].name;
                        dest = config.path + 'public/uploads/' + obj + '/' + file[i].name;
                        isupload = true;
                        if (isupload) {
                            fs.rename(path, dest, function (err) {
                                fs.unlink(path, function (err) { });
                            });
                        }
                    }
                }

            }
        }
    }

}
/* ===================== end change by divyesh (changes) ===================== */

exports.showProducts = function (req, mysql, q) {
    $mysqli = {};
    strQuery = mysqli.mysqli($mysqli, 164);
    //console.log(strQuery);
    var defered = q.defer();
    var escape_string = [req.param('id')];

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());

    return defered.promise;
}

exports.addProductAttachmentchange = function (m1, mysql, q, pro_id) {
    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, "insert_img");
    //console.log(strQuery);
    var defered = q.defer();
    m = m1;

    var escape_string = [m.originalName, m.name, datge, pro_id];

    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("query addProductAttachmentchange" + query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
    })
    return defered.promise;
}

exports.updateproductimage = function (m1, mysql, q, id) {
    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, "update_projectid_in_imgtable");
    //console.log(strQuery);
    var defered = q.defer();
    //m = m1;
    //console.log(m);
    var escape_string = [id, m1];
    console.log(escape_string);
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("Query issssss " + query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
    })

    return defered.promise;
}

exports.deleteProductAttachment = function (m1, mysql, q) {
    $mysqli = {};
    datge = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss");
    strQuery = mysqli.mysqli($mysqli, 'delete_images');
    //console.log(strQuery);
    var defered = q.defer();
    m = m1;
    console.log(m);
    var escape_string = [m];
    console.log(escape_string);
    query = mysql.query(strQuery, escape_string, defered.makeNodeResolver());
    console.log("Query issssssssssss " + query.sql);
    query.on('error', function (err) {
        console.log(err.stack);
        throw err;
    });
    return defered.promise;
}
