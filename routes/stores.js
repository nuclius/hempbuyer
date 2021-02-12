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
var reload = require('reload');
var sprintf = require('sprintf').sprintf;
var common = require('../module/common');
var products = require('../module/products');
var stores = require('../module/stores');
var session = require('express-session');
var app = express.Router();
var cryptos = require('../module/crypto.js');
var mysqli = require('../module/mysqli');
var cookieParser = require('cookie-parser');
var adwords = require('../module/adwords');
var dashboard = require('../module/dashboard');
var q = require('q');
var braintree = require('braintree');
var faAPI = require('../module/forwardauction_api');
var async = require('async');

braintrees = braintree.connect({
    environment: braintree.Environment.Sandbox,
    merchantId: "9c2tgpsm3b2247wz",
    publicKey: "sj9ff8mydmdf3rnk",
    privateKey: "edeebab8d795fc9cd8bae939799cddd3"
});

app.use(function(req, res, next) {
    // common.checkLogin(req, res, 0);
    //req.session.userid = 1;
    if ($arr.config.stores.enable == 'no') {
        res.writeHead(302, {
            'Location': '/'
        });
        res.end();
        return false;
    }
    next();
});
app.post(['/message'], function(req, res) {
    var data = common.checkLoginJSON(req, res);
    q.all([stores.storeDetail(req, $arr.config.mysql, q)]).then(function(results) {
        data.warning = 'Invalid Access!';
        if (results[0][0].length == 0) {
            common.sendJSONOutput(req, res, data);
        }
        data.warning = '';
        var store = results[0][0][0];
        message = require('../module/message');
        req.body.fromid = req.session.userid;
        req.body.first_name = store.first_name;
        req.body.last_name = store.last_name;
        req.body.r_id = Date.parse(new Date()) / 1000;
        req.body.toemail = store.email;
        req.body.toid = store.user_id;
        req.body.pid = 0;
        req.body.subject = req.session.first_name + ' Sent a Message from ' + store.name + ' store';
        message.addmessages(req, config.mysql, q);
        console.log(data);
        common.sendJSONOutput(req, res, data);
    });
});

app.get(['/create'], function(req, res) {
    if (common.checkLogin(req, res, 0)) {

        var allow = common.checkPermission('monthly_bid_limit', req);

        if (!allow) {

            res.writeHead(302, {
                'Location': '/product/membership_reached'
            });
            res.end();

            return false;

        } else {

            q.all([stores.viewUserStores(req, $arr.config.mysql, q)]).then(function(results) {
                if (results[0][0].length == 0) {

                    var profile = require('../module/profile_settings');
                    /*new code*/
                    async.series({
                        getUserInfo: function(cb) {
                            // getting userInformations
                            var userDataCallback = function(err, response) {
                                cb(null, response);
                            }

                            faAPI.userInfo(req, req.session.userid, userDataCallback);
                        }
                    }, function(err, results) {
                        q.all([profile.shippingDetails(req, config.mysql, q, req.session.userid)]).then(function(results2) {
                            // results.getUserInfo.user.country2 = results2[0][0][0].country;
                            // results.getUserInfo.user.state2 = results2[0][0][0].state;
                            // results.getUserInfo.user.city2 = results2[0][0][0].city;
                            // results.getUserInfo.user.region2 = results2[0][0][0].region;
                            // results.getUserInfo.user.zipcode2 = results2[0][0][0].zipcode;
                            // results.getUserInfo.user.address3 = results2[0][0][0].address;
                            //$arr.state = typeof(req.session.state) === 'undefined' || req.session.state == null ? '' : req.session.state;
                            //$arr.zipcode = typeof(req.session.zipcode) === 'undefined' || req.session.zipcode == null ? '' : req.session.zipcode;
                            //$arr.city = typeof(req.session.city) === 'undefined' || req.session.city == null ? '' : req.session.city;
                            $arr['users'] = results.getUserInfo.user;
                            $arr['countries'] = config.countries;
                            for (i in $arr['users']) {
                                if ($arr['users'][i] == "null" || $arr['users'][i] == null) {
                                    $arr['users'][i] = '';
                                }
                            }
                            // common.checkLogin(req, res, 0);
                            if (req.session.storeid > 0) {
                                res.writeHead(302, {
                                    'Location': '/stores/view/' + req.session.storeid
                                });
                                res.end();
                                return false;
                            }
                            common.tplFile('store/create.tpl');
                            common.headerSet(1);
                            common.loadTemplateHeader(req, res, $arr);
                        })
                    })
                } else {
                    res.writeHead(302, {
                        'Location': '/stores/view/' + results[0][0][0].id
                    });
                    res.end();
                    return false;
                }
            })
        }
    }
});

app.get(['/reviews/:id'], function(req, res) {

    req.body.id = req.param('id');
    req.body.page = typeof(req.param('page')) == 'undefined' ? 1 : req.param('page');

    console.log(req.session);
    req.body.seller_id = req.session.userid;
    req.body.buyer_id = req.session.userid;

    if (common.checkLogin(req, res, 0)) {
        $arr['heading_common'] = "My Store Reviews";
        q.all([
            stores.getStoreReviews(req, $arr.config.mysql, q, 0),
            stores.getStoreReviews(req, $arr.config.mysql, q, 1),
            stores.getOverallSellerRatings(req, $arr.config.mysql, q),
            stores.getOverallBuyerRatings(req, $arr.config.mysql, q),
        ]).then(function(results) {

            $arr['pagination'] = results[1][0][0].total_reviews;
            $arr['reviews'] = results[0][0];

            $arr['seller_rating'] = results[2][0][0].seller_rating != null ? results[2][0][0].seller_rating : 0;
            $arr['buyer_rating'] = results[3][0][0].buyer_rating != null ? results[3][0][0].buyer_rating : 0;

            var url = require('url');
            var url_parts = url.parse(req.url, true);
            var query = url_parts.query;
            fquery = common.urlparameter(query, { page: '' });
            $arr['search'] = query;
            var pagination = require('pagination');
            var paginator = new pagination.SearchPaginator({
                prelink: '/stores/reviews/' + req.body.id + '/' + fquery,
                current: req.body.page,
                rowsPerPage: 10,
                totalResult: $arr['pagination'],
            });

            $arr['pagination_html'] = paginator.render();

            common.tplFile('store/store_reviews.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        })
    }
});

app.post(['/resize/banner/'], function(req, res) {
    var im = require('imagemagick');
    var easyimg = require('easyimage');

    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        //req.body.id = req.param('pid');
        if (results[0][0][0].user_id == req.session.userid) {
            var im = require('imagemagick');
            var easyimg = require('easyimage');
            easyimg.crop({
                src: $arr.config.paths.path + 'public/uploads/store/' + results[0][0][0].banner,
                dst: $arr.config.paths.path + 'public/uploads/store/banner_' + results[0][0][0].banner,
                cropwidth: req.body.w,
                cropheight: req.body.h,
                gravity: 'North',
                x: req.body.x,
                y: req.body.y
            }, function(err, stdout, stderr) {



                // foo

            });

            res.writeHead(302, {
                'Location': '/stores/resize/bannerorg/' + req.body.id
            });
            res.end();
            return false;


        }


    });


});
app.get(['/resize/bannerorg/:id'], function(req, res) {
    var im = require('imagemagick');

    req.body.id = req.param('id');

    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        //req.body.id = req.param('pid');
        if (results[0][0][0].user_id == req.session.userid) {
            var im = require('imagemagick');

            // foo
            im.crop({
                srcPath: $arr.config.paths.path + 'public/uploads/store/banner_' + results[0][0][0].banner,
                dstPath: $arr.config.paths.path + 'public/uploads/store/banner_' + results[0][0][0].banner,
                width: 1078,
                height: 192,
                quality: 1,
                gravity: "Center"
            }, function(err, stdout, stderr) {
                res.writeHead(302, {
                    'Location': '/stores/view/' + req.body.id
                });
                res.end();
                return false;
                // foo
            });





        }


    });


});


app.post(['/create'], function(req, res) {
    if (common.checkLogin(req, res, 0)) {

        var storeide = req.body.storeid;
        if(req.files.store_image){
            if(req.files.store_image.length) {
                req.body.store_imaged =req.files.store_image[0].name;
            }
        }
        if (storeide) {
            q.all([stores.storeupdate(req, $arr.config.mysql, q)]).then(function(results) {
                q.all([adwords.selectstoreadsid(req, $arr.config.mysql, q)]).then(function(result) {
                    if (result[0][0][0] !== undefined && result[0][0][0] !== '') {
                        // var ids = [];
                        for (var i = result[0][0].length - 1; i >= 0; i--) {
                            // ids.push[result[0][0][i].id];
                            (adwords.updatestoreads(req, $arr.config.mysql, q, result[0][0][i].id));
                        }
                    }
                });
                
                req.body.store_id = storeide;
                if(req.files.store_image){
                    if(req.files.store_image.length) {
                        for (var index = 0; index < req.files.store_image.length; index++) {
                            const element = req.files.store_image[index];
                            stores.insertStoreImage(req, $arr.config.mysql, q, element);
                        }
                    }
                }
                res.writeHead(302, {
                    'Location': '/stores/view/' + storeide
                });
                res.end();
                return false;
            }).fail(function(err) {
                console.log(err.stack);
                throw err;
            }).done();

        } else {
            q.all([stores.create(req, $arr.config.mysql, q)]).then(function(results) {

                /* if(typeof(req.files.store_banner_image) !== 'undefined')
                {
                    var fs = require('fs');
                    //console.log($arr.config.paths.path+'public/uploads/stores/'+req.files.store_banner_image.name);
                    //console.log(fs.readFileSync($arr.config.paths.path+'public/uploads/store/'+req.files.store_banner_image.name, 'binary'));

                var im = require('imagemagick');
                    im.crop({
                          srcPath: $arr.config.paths.path+'public/uploads/store/'+req.files.store_banner_image.name,
                          dstPath: $arr.config.paths.path+'public/uploads/store/banner_'+req.files.store_banner_image.name,
                          width: 1078,
                          height: 192,
                          quality: 1,
                          gravity: "Center"
                        }, function(err, stdout, stderr){
                          // foo
                        });
                }*/

                var m = results[0][0].insertId;

                req.body.store_id = m;
                if(req.files.store_image.length) {
                    for (var index = 0; index < req.files.store_image.length; index++) {
                        const element = req.files.store_image[index];
                        stores.insertStoreImage(req, $arr.config.mysql, q, element);
                    }
                }

                req.session.storeid = results[0][0].insertId
                res.writeHead(302, {
                    'Location': '/stores/view/' + m
                });
                res.end();
                return false;
            }).fail(function(err) {
                console.log(err.stack);
                throw err;
            }).done();
        }
    }
});
app.get(['/view/ajax/:id'], function(req, res) {

    q.all([stores.viewStoreProducts(req, $arr.config.mysql, q, 1), stores.viewStoreProducts(req, $arr.config.mysql, q, 0), stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        $arr.nulldata = null;
        $arr.storeProducts = results[0][0];
        $arr.paginations = results[1][0];
        $arr.store = results[2][0][0];
        //$arr['pagination'] = products.shortDescribe(results[1][0]).length;
        var pagination = require('pagination');
        var paginator = new pagination.SearchPaginator({
            prelink: 'javascript:paginationStore',
            current: req.body.page,
            rowsPerPage: 15,
            totalResult: $arr.paginations.length,
            ajax: true
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('store/storeproducts.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.get(['/add/:id', '/add/:id/:cids', '/add/:id/:cids/:txt'], function(req, res) {
    q.all([stores.viewUserStores(req, $arr.config.mysql, q)]).then(function(results2) {
        var resultarr = results2[0][0];
        var storeid = [];
        for (var i = 0; i < resultarr.length; i++) {
            storeid.push(resultarr[i].id);
        }
        storeid = storeid.toString();
        q.all([stores.notStoreProducts(req, $arr.config.mysql, q, storeid)]).then(function(results) {
            $arr.id = req.param('id');
            $arr.nulldata = null;
            $arr.storeProducts = results[0][0];
            $arr.file = 'store/addproducts.tpl';
            common.tplFile($arr.file);
            common.headerSet(0);
            common.loadTemplateHeader(req, res, $arr);
        });
    });

});
app.get(['/feature/:id'], function(req, res) {

    q.all([stores.viewStoreFeaturedProducts(req, $arr.config.mysql, q)]).then(function(results) {
        $arr.id = req.param('id');
        $arr.nulldata = null;
        $arr.storeFProducts = results[0][0];

        $arr.file = 'store/storefproducts.tpl';
        common.tplFile($arr.file);
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.get(['/addproduct/:pid/:sid'], function(req, res) {
    req.body.id = req.param('sid');
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        req.body.id = req.param('pid');
        if (results[0][0][0].user_id == req.session.userid) {
            stores.addStoreProducts(req, $arr.config.mysql, q);
            res.send(JSON.stringify([]));
            res.end();
            return false;
        }
    });
});
app.post(['/addproduct_store'], function(req, res) {
    if (req.body.cnt > 1) {
        var pids_arr = req.body.pids;
        pids_arr = pids_arr.split(',')
        for (i in pids_arr) {
            pid = pids_arr[i];
            checkpr(pid);
        }
    } else {
        checkpr(req.body.pids);
    }

    function checkpr(id) {
        q.all([stores.checkproduct(req, $arr.config.mysql, q, id)]).then(function(results) {
            if (results[0][0].length > 0) {
                stores.addStorepdts(req, $arr.config.mysql, q, id);
            } else {
                stores.addstorepdtnew(req, $arr.config.mysql, q, id);
            }
        });
    }
    res.json({ 'result': 'success' });
    res.end();
    return false;
});

app.get(['/remove/:pid/:sid'], function(req, res) {
    req.body.id = req.param('sid');
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        req.body.id = req.param('pid');
        if (results[0][0][0].user_id == req.session.userid) {
            stores.removeProducts(req, $arr.config.mysql, q);

        }
        res.writeHead(302, {
            'Location': '/stores/view/' + req.param('sid')
        });
        res.end();
        return false;
    });

});
app.get(['/category/:id'], function(req, res) {
    q.all([stores.viewStoreCategories(req, $arr.config.mysql, q)]).then(function(results) {
        $arr.id = req.param('id');
        $arr.nulldata = null;
        $arr.storeCategories = results[0][0];
        console.log($arr.storeCategories);
        common.tplFile('store/storecategory.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});
app.post(['/update/'], function(req, res) {
    common.checkLogin(req, res, 0);
    req.body.id = req.param('sid');
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        req.body.logo = results[0][0][0].logo;
        req.body.banner = results[0][0][0].banner;
        if (typeof(req.files.store_banner_image) !== 'undefined') {
            var fs = require('fs');
            var im = require('imagemagick');
            im.crop({
                srcPath: $arr.config.paths.path + 'public/uploads/store/' + req.files.store_banner_image.name,
                dstPath: $arr.config.paths.path + 'public/uploads/store/banner_' + req.files.store_banner_image.name,
                width: 1078,
                height: 192,
                quality: 1,
                gravity: "Center"
            }, function(err, stdout, stderr) {
                // foo

            });

            stores.updateStores(req, $arr.config.mysql, q);
            res.writeHead(302, {
                'Location': '/stores/view/' + req.param('sid')
            });
            res.end();
            return false;
        } else {
            stores.updateStores(req, $arr.config.mysql, q);
            res.writeHead(302, {
                'Location': '/stores/view/' + req.param('sid')
            });
            res.end();
            return false;
        }

    });
});
app.get(['/edit/:id'], function(req, res) {
    var admin = require('../module/admin');
    common.checkLogin(req, res, 0);
    q.all([
        stores.view(req, $arr.config.mysql, q),
        stores.viewStoreFeaturedProducts(req, $arr.config.mysql, q),
        admin.getAllCategory(req, $arr.config.mysql, q),
        admin.selectMaxStoreCategory(req, $arr.config.mysql, q),
        stores.viewStoreProducts(req, $arr.config.mysql, q, 0),
        stores.selectStoreProductOrder(req, $arr.config.mysql, q)
    ]).then(function(results) {
        var newdata = results[4][0];
        newdata.sort(function(a, b) {
            if (Number(a.category_id) > Number(b.category_id)) {
                return 1;
            } else if (Number(a.category_id) < Number(b.category_id)) {
                return -1;
            }
            return 0;
        });

        $arr.id = req.param('id');
        $arr.nulldata = null;
        $arr.store = results[0][0][0];
        $arr.storeFProducts = results[1][0];
        $arr.allStoreCategory = results[2][0];
        $arr.selecteStoreCategory = results[3][0];
        $arr.storeAllCategory = newdata;
        if (results[5][0].length > 0 && results[5].length > 0) {
            $arr.selectStoreAllOrder = results[5][0];
        } else {
            $arr.selectStoreAllOrder = [];
        }
        common.tplFile('store/storeedit.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function(err) {
        console.log(err.stack);
        throw err;
    }).done();
});


app.get(['/view/:id'], function(req, res) {
    // var extend = require('util')._extend;
    // // var arr_temp = extend({}, $arr);
    // // console.log(arr_temp)
    if (common.checkLogin(req, res, 0)) {
        var admin = require('../module/admin');
        $arr['heading_common'] = "Store View";
        console.log("store");
        q.all([admin.selectMaxStoreCategory(req, $arr.config.mysql, q)]).then(function(results1) {
            console.log("store2");
            q.all([
                stores.view(req, $arr.config.mysql, q),
                stores.viewStoreProducts(req, $arr.config.mysql, q, 1),
                stores.viewStoreCategories(req, $arr.config.mysql, q),
                stores.viewStoreFeaturedProducts(req, $arr.config.mysql, q),
                stores.viewStoreProducts(req, $arr.config.mysql, q, 0),
                admin.getAllCategory(req, $arr.config.mysql, q),
                stores.selectStoreProductOrder(req, $arr.config.mysql, q)
            ]).then(function(results) {

                // console.log(JSON.stringify(results[0][0][0]));
                // console.log(results[0][0][0].state);
                // console.log(req.session.state);
                // console.log(results[0][0][0].state != req.session.state);
                // console.log(req.session.userid != results[0][0][0].user_id);


                if (results[0][0][0].u_business_type != 'supplier') {

                    if ((results[0][0][0].state != req.session.state) && (req.session.userid != results[0][0][0].user_id)) {

                        res.writeHead(302, {
                            'Location': '/directbuy'
                        });
                        res.end();
                        return false;
                    }

                }

                // console.log("store3", results[1][0]);
                if (results[0][0].length == 0) {
                    res.writeHead(302, {
                        'Location': '/'
                    });
                    res.end();
                    return false;
                }
                // console.log("store4");
                var newdata = results[4][0];
                newdata.sort(function(a, b) {
                    if (Number(a.category_id) > Number(b.category_id)) {
                        return 1;
                    } else if (Number(a.category_id) < Number(b.category_id)) {
                        return -1;
                    }
                    return 0;
                });
                // console.log('newdata');
                // console.log(results[5][0]);

                console.log(results[0][0][0].user_id)
                console.log(req.session.user_id)

                if (results[0][0][0].user_id != req.session.userid) {
                    stores.updatestoreviewc(req, $arr.config.mysql, q);
                }

                $arr.nulldata = null;
                $arr.store = results[0][0][0];
                $arr.storeProducts = results[1][0];
                $arr.storeCategories = results[2][0];
                $arr.storeFProducts = results[3][0];
                $arr.paginations = results[4][0];
                $arr.allStoreCategory = results[5][0];
                $arr.selecteStoreCategory = results1[0][0];
                $arr.storeAllCategory = newdata;
                if (results[6][0].length > 0 && results[6].length > 0) {
                    $arr.selectStoreAllOrder = results[6][0];
                } else {
                    $arr.selectStoreAllOrder = [];
                }
                var pagination = require('pagination');
                var paginator = new pagination.SearchPaginator({
                    prelink: 'javascript:paginationStore',
                    current: req.body.page,
                    rowsPerPage: 12,
                    totalResult: $arr.paginations.length,
                    ajax: true
                });
                $arr['pagination_html'] = paginator.render();

                var categry = results[0][0][0].selected_category;
                if (categry.trim() != '') {
                    common.tplFile('store/view.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                } else {
                    cat_ids = results1[0][0][0].storecategory_ids;
                    cat_ids = cat_ids.split(',');
                    if (cat_ids.length > 0) {
                        cat_ids = cat_ids.splice(5);
                        cat_ids = cat_ids.toString();
                    } else {
                        cat_ids = cat_ids.toString();
                    }
                    req.body.default_ids = cat_ids;
                    req.body.id = results[0][0][0].id;
                    q.all(stores.updateCatgeoryInStore(req, $arr.config.mysql, q)).then(function(results2) {

                        // var admin = require('../module/admin');
                        // req.param('id') = 4;
                        q.all([admin.showstaticContent2(req, res, config.mysql, q, 4)]).then(function(resul) {
                            $arr['terms'] = resul[0][0][0].content;
                        })

                        $arr.store.selected_category = req.body.default_ids;

                        common.tplFile('store/view.tpl');
                        common.headerSet(1);
                        common.loadTemplateHeader(req, res, $arr);
                    });
                }
            });
        });
    }

});
app.get(['/dashboard/:id'], function(req, res) {
    common.checkLogin(req, res, 0);
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        $arr.store = results[0][0][0];
        $arr.singlestore = 'true';
        common.tplFile('store/dashboard.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.get(['/allreports'], function(req, res) {
    common.checkLogin(req, res, 0);
    req.body.loguid = req.session.userid;
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        $arr.store = results[0][0];
        $arr.singlestore = 'false';
        common.tplFile('store/dashboard.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.get(['/dashboard', '/mystore/:type'], function(req, res) {
    var userid = (typeof(req.session.userid) !== 'undefined') ? Number(req.session.userid) : 0;
    req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
    if (typeof(req.param('type')) !== 'undefined') {
        req.body.loguserid = userid;
        if (req.body.loguserid <= 0) {
            res.writeHead(302, {
                'Location': '/login'
            });
            res.end();
            return false;
        }
    } else {
        req.body.loguserid = 0;
    }
    q.all([
        stores.getAllStores(req, $arr.config.mysql, q, 0),
        stores.getAllStores(req, $arr.config.mysql, q, 1),
        stores.storeCategoryDetails(req, $arr.config.mysql, q)
    ]).then(function(results) {
        var pagination = require('pagination');
        $arr['stores'] = results[0][0];
        $arr['reviews'] = results[1][0].length;
        $arr['storeCategories'] = results[2][0];
        $arr['countries'] = config.countries;
        $arr['loguserid'] = req.body.loguserid;
        var paginator = new pagination.SearchPaginator({
            prelink: '/stores/dashboard',
            current: req.body.page,
            rowsPerPage: 12,
            totalResult: $arr['reviews']
        });
        $arr['pagination_html'] = paginator.render();

        common.tplFile('store/storedashboard.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});
app.post(['/storename'], function(req, res) {
    stores.updateStoresname(req, $arr.config.mysql, q);
    res.json({ 'result': 'success' });
    res.end();
    return false;

});
app.post(['/storedesc'], function(req, res) {
    stores.updateStoresdesc(req, $arr.config.mysql, q);
    res.json({ 'result': 'success' });
    res.end();
    return false;

});
app.post(['/storelogo'], function(req, res) {


    if (req.files.store_image.name) {
        stores.updateStoreslogo(req, $arr.config.mysql, q);
        res.json({ 'result': 'success' });
        res.end();
        return false;
    } else {
        res.json({ 'result': 'fail' });
        res.end();
        return false;
    }
    //console.log(req.files.store_image.originalname);
});

app.post(['/storebanner'], function(req, res) {


    if (req.files.store_banner_image.name) {
        stores.updateStoresbanner(req, $arr.config.mysql, q);
        res.json({ 'result': 'success' });
        res.end();
        return false;
    } else {
        res.json({ 'result': 'fail' });
        res.end();
        return false;
    }
    //console.log(req.files.store_banner_image.originalname);
});


app.post(['/storesocial'], function(req, res) {
    stores.updateStoressocial(req, $arr.config.mysql, q);
    res.json({ 'result': 'success', 'url': req.body.urlname });
    res.end();
    return false;

    //console.log(req.files.store_image.originalname);
});
app.post(['/storesocialremove'], function(req, res) {
    stores.updateStoressocialrem(req, $arr.config.mysql, q);
    res.json({ 'result': 'success', 'url': req.body.urlname });
    res.end();
    return false;

    //console.log(req.files.store_image.originalname);
});
app.post(['/storebannerremove'], function(req, res) {
    stores.updateStoresbannerrem(req, $arr.config.mysql, q);
    res.json({ 'result': 'success' });
    res.end();
    return false;

    //console.log(req.files.store_image.originalname);
});
app.post(['/storebannerposition'], function(req, res) {
    stores.updateStoresbannerpos(req, $arr.config.mysql, q);
    res.json({ 'result': 'success' });
    res.end();
    return false;

    //console.log(req.files.store_image.originalname);
});
app.post(['/storehomename'], function(req, res) {
    stores.updateStoreshomepage(req, $arr.config.mysql, q);
    res.json({ 'result': 'success' });
    res.end();
    return false;

    //console.log(req.files.store_image.originalname);
});
app.post(['/storeaboutus'], function(req, res) {
    stores.updateStoresaboutus(req, $arr.config.mysql, q);
    res.json({ 'result': 'success' });
    res.end();
    return false;

    //console.log(req.files.store_image.originalname);
});

app.post(['/reports_create'], function(req, res) {
    var csv = require('csv');
    var csvdata;
    var lbreak = "\n";
    var headings = [];
    var details = [];
    var all_details = [];
    q.all(stores.csvInvoicesRep(req, config.mysql, q)).then(function(results) {
        //console.log(results[0]);
        var dd = results[0];
        res.json({ 'result': 'success', 'res': dd });
        res.end();
        return false;

    });
});
app.get(['/reports_createcsv'], function(req, res) {
    var csv = require('csv');
    var csvdata;
    var lbreak = "\n";
    var headings = [];
    var details = [];
    var all_details = [];
    req.body.storeid = req.param('storeid');
    req.body.from_date = req.param('from_date');
    req.body.to_date = req.param('to_date');
    req.body.within = req.param('within');
    req.body.method = req.param('method');
    q.all(stores.csvInvoicesRep(req, config.mysql, q)).then(function(results) {

        var counts = results[0].length;

        csvdata = "Transaction Date/Time,";
        csvdata += "Name / Title,";
        csvdata += "Total Sale,";
        csvdata += lbreak;
        for (var i = 0; i < counts; i++) {
            csvdata += results[0][i].date_added + ',';
            csvdata += results[0][i].title + ',';
            csvdata += results[0][i].amount + ',';
            csvdata += lbreak;
        }

        if (counts == 0) {
            csvdata += "No results found";
        }
        res.setHeader('Content-disposition', 'attachment; filename=sellerreports.csv');
        res.set('Content-Type', 'application/octet-stream');
        res.send(csvdata);
        res.end();
        return false;

    });
});

app.get(['/show_adwords', '/show_adwords/:id'], function(req, res) {
    common.checkLogin(req, res, 0);
    req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
    $arr.storeid = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : '';
    $arr.error = (typeof(req.param('error')) != 'undefined') ? req.param('error') : 0;
    req.body.loguid = req.session.userid;
    q.all([
        adwords.getAdvertiseDetails2(req, $arr.config.mysql, q, 0),
        adwords.getAdvertiseDetails2(req, $arr.config.mysql, q, 1),
        adwords.getDeposit(req, $arr.config.mysql, q),
        stores.view(req, $arr.config.mysql, q),
    ]).then(function(results) {
        var pagination = require('pagination');
        $arr['pagination'] = results[1][0].length;
        $arr['adwords_details'] = results[0][0];
        $arr.deposit_amount = req.session.deposit_amount;
        $arr.store = results[3][0];
        if ($arr.storeid != 0) {
            var link = '/stores/show_adwords/' + $arr.storeid + '';
        } else {
            var link = '/stores/show_adwords/';
        }
        var paginator = new pagination.SearchPaginator({ prelink: link, current: req.body.page, rowsPerPage: 5, totalResult: $arr['pagination'] });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('store/dashboard-ads.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    }).fail(function(err) {
        console.log(err.stack);
        throw err;
    }).done();
});


app.get(['/current_campaigns', '/current_campaigns/:id'], function(req, res) {

    if (global.ads_page_show == 0) {
        console.log('running');
        res.writeHead(302, {
            'Location': '/market/selection/ads_err'
        });
        res.end();
        return false;
    } else {

        if (common.checkLogin(req, res, 0)) {

            var allow = common.checkPermission('project_limit', req);

            if (!allow) {

                res.writeHead(302, {
                    'Location': '/product/membership_reached'
                });
                res.end();

                return false;

            } else {

                $arr['adsmenu'] = [];
                $arr['adsmenu']['camp'] = 'active';
                req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
                $arr.storeid = (typeof(req.param('id')) !== 'undefined') ? req.param('id') : '';
                req.body.day_diff = (typeof(req.param('day_diff')) !== 'undefined') ? req.param('day_diff') : 7;
                $arr.error = (typeof(req.param('error')) != 'undefined') ? req.param('error') : 0;
                req.body.loguid = req.session.userid;
                q.all([
                    adwords.getAdvertiseDetails2(req, $arr.config.mysql, q, 0),
                    adwords.getAdvertiseDetails2(req, $arr.config.mysql, q, 1),
                    adwords.getDeposit(req, $arr.config.mysql, q),
                    stores.view(req, $arr.config.mysql, q),
                    adwords.current_campaigns(req, $arr.config.mysql, q),
                    adwords.ads_graphdata(req, $arr.config.mysql, q),
                    adwords.selectstoreads(req, $arr.config.mysql, q, req.session.storeid),
                    products.totalSoldPrdtByUser(req, $arr.config.mysql, q, req.session.storeid),
                    adwords.ads_graphdata2(req, $arr.config.mysql, q),

                ]).then(function(results) {
                    // console.log(JSON.stringify(results[6][0]))
                    var pagination = require('pagination');
                    // console.log(results[6][0].length + "qqqqqqqqqqqqqqq");
                    // 
                    if (results[6][0].length > 0) {
                        $arr['alreadyads'] = 1;
                        $arr['alreadyadid'] = results[6][0][0].id;
                        $arr['alreadyadsid'] = results[6][0][0].store_id;
                    } else {
                        $arr['alreadyads'] = 0;
                    }

                    $arr['pagination'] = results[1][0].length;
                    $arr['adwords_details'] = results[0][0];
                    $arr['campaign_data'] = results[7][0][0];

                    console.log(results[7][0][0]);
                    console.log("console.log($arr['campaign_data']);------------------------------" + JSON.stringify(results[4][0][0]));
                    $arr.deposit_amount = req.session.deposit_amount;
                    $arr.store = results[3][0];
                    $arr.current_campaigns = results[4][0][0];
                    console.log('graph', results[5][0]);
                    graphdata = results[5][0];
                    graphdata2 = results[8][0];
                    $arr['adsSpend'] = 0;
                    if ($arr['current_campaigns'].total_clicks > 0) {
                        $arr['adsSpend'] = parseFloat(results[4][0][0].ads_spend).toFixed(2);
                    }
                    $arr['ROI'] = 0;
                    if ($arr['campaign_data'].total_sold_price > 0 && results[4][0][0].ads_spend > 0) {
                        $arr['ROI'] = parseFloat($arr['campaign_data'].total_sold_price / $arr['adsSpend']).toFixed(2);
                    }
                    $arr['clicksbyimpressions'] = 0;
                    if (($arr['current_campaigns'].total_clicks / $arr['current_campaigns'].views) > 0) {
                        $arr['clicksbyimpressions'] = parseFloat($arr['current_campaigns'].total_clicks / $arr['current_campaigns'].views).toFixed(2);
                    }

                    var dateFormat = require('dateformat');
                    var today = new Date();
                    today.setHours(today.getHours() - 720);
                    var date1 = '';
                    /*  for (var i = 0; i < 30; i++) {
                          today.setHours(today.getHours() + 24);
                          date1 = date1 + '"' + dateFormat(today, 'mm-dd-yyyy') + '"';
                          date1 += ',';
                      }*/

                    $arr.date_arr3 = date1;
                    var direct_m_sales = '';
                    var impressions = '';
                    var clicks = '';
                    var sold = '';
                    var date_arr = '';
                    var total_ads_spend = '';
                    var date_arr2 = '';
                    for (i = 0; i < graphdata.length; i++) {
                        var dms = -1;
                        for (var j = 0; j < graphdata2.length; j++) {
                            var graph_month = graphdata[i].date_added.getMonth();
                            var graph_d = graphdata[i].date_added.getDate();
                            var graph_month2 = graphdata2[j].date_added.getMonth();
                            var graph_d2 = graphdata2[j].date_added.getDate();

                            graph_month = Number(graph_month);
                            graph_month2 = Number(graph_month2);
                            graph_d = Number(graph_d);
                            graph_d2 = Number(graph_d2);

                            if (graph_month == graph_month2 && graph_d == graph_d2) {
                                dms = j;
                                /*direct_m_sales += graphdata2[j].direct_m_sales*graphdata2[j].qty;
                                direct_m_sales += ',';
                                console.log('direct_m_sales1');*/
                            }
                            /*else{
                                direct_m_sales += 0;
                                direct_m_sales += ',';
                                console.log('direct_m_sales2');
                            }*/

                        }

                        if (dms >= 0) {
                            direct_m_sales += graphdata2[dms].direct_m_sales * graphdata2[dms].qty;
                            direct_m_sales += ',';
                            console.log('direct_m_sales1');
                        } else {
                            direct_m_sales += 0;
                            direct_m_sales += ',';
                            console.log('direct_m_sales2');
                        }


                        clicks += graphdata[i].total_clicks;
                        sold += graphdata[i].s_click;
                        date_arr = date_arr + '"' + dateFormat(graphdata[i].date_added, 'mm-dd-yyyy') + '"';
                        impressions += graphdata[i].total_impressions;
                        total_ads_spend += graphdata[i].total_ads_spend;
                        clicks += ',';
                        sold += ',';
                        date_arr += ',';
                        impressions += ',';
                        total_ads_spend += ',';
                    }

                    $arr.clicks = clicks;
                    $arr.sold = sold;
                    $arr.date_arr = date_arr;
                    $arr.impressions = impressions;
                    $arr.total_ads_spend = total_ads_spend;
                    $arr.direct_m_sales = direct_m_sales;
                    $arr.date_arr2 = date_arr2;
                    console.log('clicks--------' + $arr.clicks + '------------sold' + $arr.sold + 'date----' + $arr.date_arr + '--------------impressions---------' + $arr.impressions + '--------ads spend-----' + $arr.total_ads_spend + '--------direct_m_sales------' + $arr.direct_m_sales);


                    if ($arr.storeid != 0) {
                        var link = '/stores/current_campaigns/' + $arr.storeid + '';
                    } else {
                        var link = '/stores/current_campaigns/';
                    }

                    var paginator = new pagination.SearchPaginator({ prelink: link, current: req.body.page, rowsPerPage: 5, totalResult: $arr['pagination'] });

                    $arr['pagination_html'] = paginator.render();

                    common.tplFile('store/current_campaigns.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);

                }).fail(function(err) {
                    console.log(err.stack);
                    throw err;
                }).done();
            }
        } else { return false }
    }

});

app.post(['/ads_graphdata'], function(req, res) {


    q.all([adwords.ads_graphdata(req, $arr.config.mysql, q)]).then(function(results) {
        $arr.current_campaigns = results[0][0];
        graphdata = results[0][0];
        var impressions = '';
        var clicks = '';
        var sold = '';
        var date_arr = '';
        for (i = 0; i < graphdata.length; i++) {
            clicks += graphdata[i].totclicks;
            sold += '0';
            date_arr = date_arr + graphdata[i].fday;
            impressions += graphdata[i].totviews;

            clicks += ',';
            sold += ',';
            date_arr += ',';
            impressions += ',';

        }
        $arr.clicks = clicks;
        $arr.sold = sold;
        $arr.date_arr = date_arr;
        $arr.impressions = impressions;

        res.json({ 'result': 'success', 'clicks': clicks, 'date_arr': date_arr, 'impressions': impressions, 'sold': sold });
        res.end();
        return false;
    });

});

app.get(['/editcategory/:id'], function(req, res) {
    var admin = require('../module/admin');

    q.all([admin.getAllStoreCategory(req, $arr.config.mysql, q)]).then(function(results) {
        $arr['allcategories'] = results[0][0];
        common.tplFile('store/editcategory.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });

});
app.get(['/addnewproduct1/:id'], function(req, res) {
    var admin = require('../module/admin');
    q.all([admin.getAllStoreCategory(req, $arr.config.mysql, q)]).then(function(results) {
        $arr['allcategories'] = results[0][0];
        $arr['storeid'] = req.param('id');
        common.tplFile('store/addnewproduct1.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/addnewproduct2/:id/:catid/:subcatid'], function(req, res) {
    var admin = require('../module/admin');
    q.all([admin.getAllStoreCategory(req, $arr.config.mysql, q)]).then(function(results) {
        $arr['subcatid'] = req.param('subcatid');
        $arr['allcategories'] = results[0][0];
        $arr['catid'] = req.param('catid');
        common.tplFile('store/addnewproduct2.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post(['/updateStoreCatEdit'], function(req, res) {
    q.all(stores.updateCatgeoryInStore(req, $arr.config.mysql, q)).then(function(results2) {
        res.json({ 'result': 'success' });
        res.end();
        return false;
    });
});
app.post(['/updateFeature'], function(req, res) {
    q.all(stores.updateFeatureProject(req, $arr.config.mysql, q)).then(function(results2) {
        res.json({ 'result': 'success' });
        res.end();
        return false;
    });
});
app.post(['/updateUnstock'], function(req, res) {
    q.all(stores.updateUnstockProject(req, $arr.config.mysql, q)).then(function(results2) {
        res.json({ 'result': 'success' });
        res.end();
        return false;
    });
});
app.post(['/updateOrder'], function(req, res) {
    q.all(stores.selectProductOrder(req, $arr.config.mysql, q)).then(function(results1) {
        if (results1[0].length > 0) {
            q.all(stores.updateProductOrder(req, $arr.config.mysql, q, 1)).then(function(results2) {
                res.json({ 'result': 'success' });
                res.end();
                return false;
            });
        } else {
            q.all(stores.updateProductOrder(req, $arr.config.mysql, q, 2)).then(function(results2) {
                res.json({ 'result': 'success' });
                res.end();
                return false;
            });
        }
    });
});
app.get(['/addcat/:type/:id'], function(req, res) {
    if (typeof(req.session.userid) != 'undefined' && req.session.userid > 0) {
        $arr['pagetype'] = (typeof(req.param('type')) == 'undefined') ? '' : req.param('type');
        $arr['storeid'] = (typeof(req.param('id')) == 'undefined') ? '' : req.param('id');
        var admin = require('../module/admin');
        q.all([
            admin.selectMaxStoreCategory(req, $arr.config.mysql, q),
            stores.view(req, $arr.config.mysql, q),
            stores.getStorePlanlist(req, $arr.config.mysql, q)
        ]).then(function(results) {
            if (results[0][0].length > 0) {
                $arr.selected_category = results[0][0][0].storecategory_ids;
            } else {
                $arr.selected_category = [];
            }
            $arr['subcat'] = results[1][0][0].selected_category;
            if (results[2][0].length > 0) {
                $arr['store_plans'] = results[2][0];
            } else {
                $arr['store_plans'] = [];
            }
            common.tplFile('store/payforcategory.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    } else {
        res.writeHead(302, {
            'Location': '/login'
        });
        res.end();
        return false;
    }
});

app.post(['/addcat/:type'], function(req, res) {
    $arr['pagetype'] = (typeof(req.param('type')) == 'undefined') ? '' : req.param('type');
    var plan_id = (typeof(req.body.plan_val) == 'undefined') ? 0 : req.body.plan_val;
    q.all([stores.getStorePlanlist(req, $arr.config.mysql, q)]).then(function(results) {
        if (results[0][0].length > 0) {
            var totalcount = (typeof(req.body.totalcount) == 'undefined') ? 0 : req.body.totalcount;
            req.body.amount = (typeof(results[0][0][0].amount) == 'undefined') ? 0 : results[0][0][0].amount;
            req.body.counts = totalcount;
            q.all([stores.saveStorePlan(req, $arr.config.mysql, q)]).then(function(results2) {
                var payment_id = "storepay_" + results2[0][0].insertId;
                var amount = Number(req.body.amount) * Number(totalcount);
                console.log(amount);
                console.log(results2[0][0].insertId);
                console.log('------------------>3<------------------');
                var paypalarray = [];
                paypalarray.push({
                    email: config.paypal.address,
                    amount: amount
                });
                var paypaladaptive = require('../module/paypal-adaptive');
                paypaladaptive.paymentStorePaypal(req, amount, payment_id, paypalarray, templateCallback);

                function templateCallback(err, response) {
                    console.log("Paypal Response")
                    console.log(response);
                    var braintree = require("braintree");
                    var gateway = global.bgateway;
                    $arr.clientToken = '';
                    $arr.failedpament = '1';
                    $arr.clientToken = '';
                    if (err) {
                        $arr.failedpament = '0';
                        $arr.paypalerr = err;
                    } else {
                        $arr.clientToken = response.payKey;
                        $arr.paypalurltopay = (config.paypal.sandbox == 'yes') ? 'https://www.sandbox.paypal.com/webapps/adaptivepayment/flow/pay' : 'https://www.paypal.com/webapps/adaptivepayment/flow/pay'
                    }
                    console.log(response.payKey);
                    console.log('<------------||||||||||||---------|||||||||||-------------->');
                    $arr.clientTokens = response.payKey;
                    common.tplFile('store/payforcategory.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                }
            });
        }
    });
});

app.get(['/payforstore/:type/:id'], function(req, res) {
    if (typeof(req.session.userid) != 'undefined' && req.session.userid > 0) {
        $arr['pagetype'] = (typeof(req.param('type')) == 'undefined') ? '' : req.param('type');
        $arr['storeid'] = (typeof(req.param('id')) == 'undefined') ? '' : req.param('id');
        q.all([stores.getStorePlanlist(req, $arr.config.mysql, q)]).then(function(results) {
            $arr['store_plans'] = results[0][0];
            common.tplFile('store/payforstoreproducts.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);
        });
    } else {
        res.writeHead(302, {
            'Location': '/login'
        });
        res.end();
        return false;
    }
});

app.post(['/payforstore/:type'], function(req, res) {
    $arr['pagetype'] = (typeof(req.param('type')) == 'undefined') ? '' : req.param('type');
    var plan_id = (typeof(req.body.plan_val) == 'undefined') ? 0 : req.body.plan_val;
    // var storeid = (typeof(req.body.storeid) == 'undefined') ? 0 : req.body.storeid;
    q.all([stores.getStorePlanlist(req, $arr.config.mysql, q)]).then(function(results) {
        if (results[0][0].length > 0) {
            req.body.amount = (typeof(results[0][0][0].amount) == 'undefined') ? 0 : results[0][0][0].amount;
            req.body.counts = (typeof(results[0][0][0].counts) == 'undefined') ? 0 : results[0][0][0].counts;
            q.all([stores.saveStorePlan(req, $arr.config.mysql, q)]).then(function(results2) {
                var payment_id = "storepay_" + results2[0][0].insertId;
                var amount = req.body.amount;
                console.log(results2[0][0].insertId);
                console.log('------------------>2<------------------');
                var paypalarray = [];
                paypalarray.push({
                    email: config.paypal.address,
                    amount: amount
                });
                var paypaladaptive = require('../module/paypal-adaptive');
                paypaladaptive.paymentStorePaypal(req, amount, payment_id, paypalarray, templateCallback);

                function templateCallback(err, response) {
                    console.log("Paypal Response")
                    console.log(response);
                    var braintree = require("braintree");
                    var gateway = global.bgateway;
                    $arr.clientToken = '';
                    $arr.failedpament = '1';
                    $arr.clientToken = '';
                    if (err) {
                        $arr.failedpament = '0';
                        $arr.paypalerr = err;
                    } else {
                        $arr.clientToken = response.payKey;
                        $arr.paypalurltopay = (config.paypal.sandbox == 'yes') ? 'https://www.sandbox.paypal.com/webapps/adaptivepayment/flow/pay' : 'https://www.paypal.com/webapps/adaptivepayment/flow/pay'
                    }
                    console.log(response.payKey);
                    console.log('<------------|||||||||||||||||||||||||-------------->');
                    $arr.clientTokens = response.payKey;
                    common.tplFile('store/payforstoreproducts.tpl');
                    common.headerSet(1);
                    common.loadTemplateHeader(req, res, $arr);
                }
            });
        }
    });

});

app.get(['/paycancel/:pid'], function(req, res) {
    console.log(req.param('pid'));
    var plan_id = (typeof(req.param('pid')) == 'undefined') ? '' : req.param('pid');
    req.body.plan_id = plan_id.replace('storepay_', '');
    q.all([stores.deleteStorePlan(req, $arr.config.mysql, q)]).then(function(results) {
        common.tplFile('store/dummyplan.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.post(['/paysuccess/:pid'], function(req, res) {
    console.log(req.param('pid'));
    var plan_id = (typeof(req.param('pid')) == 'undefined') ? '' : req.param('pid');
    req.body.plan_id = plan_id.replace('storepay_', '');
    req.body.transaction_id = '';
    q.all([stores.updateStorePlan(req, $arr.config.mysql, q)]).then(function(results) {
        common.tplFile('store/dummyplan.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});

app.get(['/payreturnsuccess/:pid'], function(req, res) {
    console.log(req.param('pid'));
    var plan_id = (typeof(req.param('pid')) == 'undefined') ? '' : req.param('pid');
    req.body.plan_id = plan_id.replace('storepay_', '');
    req.body.transaction_id = '';
    q.all([stores.updateStorePlan(req, $arr.config.mysql, q)]).then(function(results) {
        common.tplFile('store/dummyplan.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.post(['/getsubcount'], function(req, res) {
    q.all([stores.getSubscriptionCount(req, $arr.config.mysql, q)]).then(function(results) {
        var store = (typeof(results[0][0][0].store) == 'undefined') ? 0 : results[0][0][0].store;
        var category = (typeof(results[0][0][0].category) == 'undefined') ? 0 : results[0][0][0].category;
        var product = (typeof(results[0][0][0].product) == 'undefined') ? 0 : results[0][0][0].product;
        res.json({
            'result': 'success',
            'store': store,
            'category': category,
            'product': product
        });
        res.end();
        return false;
    });
});

app.post(['/storedashboardfilter'], function(req, res) {
    req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
    req.body.loguserid = (typeof(req.param('type')) !== 'undefined') ? req.session.userid : 0;
    q.all([
        stores.storeDashboardFilter(req, $arr.config.mysql, q, 0),
        stores.storeDashboardFilter(req, $arr.config.mysql, q, 1)
    ]).then(function(results) {
        var pagination = require('pagination');
        $arr['stores'] = results[0][0];
        $arr['reviews'] = results[1][0].length;
        var paginator = new pagination.SearchPaginator({
            prelink: '/stores/dashboard',
            current: req.body.page,
            rowsPerPage: 12,
            totalResult: $arr['reviews']
        });
        $arr['pagination_html'] = paginator.render();
        common.tplFile('store/storedashboarddiv.tpl');
        common.headerSet(0);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.get(['/transaction'], function(req, res) {
    common.checkLogin(req, res, 0);
    req.body.loguid = req.session.userid;
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        $arr.store = results[0][0];
        $arr.singlestore = 'true';
        common.tplFile('store/transaction.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.post(['/transactiondata'], function(req, res) {
    q.all(stores.csvInvoicesRep(req, config.mysql, q)).then(function(results) {
        q.all(stores.selectAdStores(req, config.mysql, q)).then(function(results2) {
            var dd = results[0];
            var dd2 = results2[0];
            res.json({ 'result': 'success', 'res': dd, 'res2': dd2 });
            res.end();
            return false;
        });
    });
});
app.post(['/incomesummary'], function(req, res) {
    req.body.method = 'fixed';
    req.body.gettype = 'income';

    q.all([
        stores.selectAdStores(req, config.mysql, q),
        stores.csvInvoicesRep(req, config.mysql, q)
    ]).then(function(results) {
        var totalamout = (typeof(results[0][0][0].totalamount) != 'undefined') ? results[0][0][0].totalamount : 0;
        var totalamout2 = (typeof(results[0][1][0].totalamount) != 'undefined') ? results[0][1][0].totalamount : 0;
        res.json({ 'result': 'success', 'res': totalamout, 'res2': totalamout2 });
        res.end();
        return false;
    });
});
app.get(['/subscriptionsetting'], function(req, res) {
    common.checkLogin(req, res, 0);
    req.body.loguid = req.session.userid;
    q.all([stores.view(req, $arr.config.mysql, q)]).then(function(results) {
        $arr.store = results[0][0];
        common.tplFile('store/subscriptionsetting.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);
    });
});
app.post(['/selectStorePlan'], function(req, res) {
    q.all(stores.selectStorePlan(req, config.mysql, q)).then(function(results) {
        var dd = results[0];
        res.json({ 'result': 'success', 'res': dd });
        res.end();
        return false;
    });
});

app.get(['/subauction/:id/:status'], function(req, res) {
    q.all([stores.updateStoreStatus(req, $arr.config.mysql, q)]).then(function(results) {
        res.writeHead(302, {
            'Location': '/stores/subscriptionsetting'
        });
        res.end();
        return false;
    });
});
app.post(['/recurringpaymentcancel'], function(req, res) {
    braintrees.webhookNotification.parse(
        req.body.bt_signature,
        req.body.bt_payload,
        function(err, webhookNotification) {
            var result = webhookNotification;
            if (result.subscription.id) {
                req.body.sub_id = result.subscription.id;
                req.body.nextBillingDate = result.subscription.nextBillingDate;
                req.body.paystatus = 'hold';
                q.all([stores.getStorePlan(req, $arr.config.mysql, q)]).then(function(results) {
                    if (results[0][0].length > 0) {
                        q.all([stores.updateStorePlan(req, $arr.config.mysql, q)]).then(function(results2) {
                            res.status(200).send();
                        });
                    } else {
                        res.status(200).send();
                    }
                });
            } else {
                res.status(200).send();
            }
        }
    );
    res.status(200).send();
});

app.post(['/recurringpaymentunsuccess'], function(req, res) {
    braintrees.webhookNotification.parse(
        req.body.bt_signature,
        req.body.bt_payload,
        function(err, webhookNotification) {
            var result = webhookNotification;
            if (result.subscription.id) {
                req.body.sub_id = result.subscription.id;
                req.body.nextBillingDate = result.subscription.nextBillingDate;
                req.body.paystatus = 'success';
                q.all([stores.getStorePlan(req, $arr.config.mysql, q)]).then(function(results) {
                    if (results[0][0].length > 0) {
                        q.all([stores.updateStorePlan(req, $arr.config.mysql, q)]).then(function(results2) {
                            res.status(200).send();
                        });
                    } else {
                        res.status(200).send();
                    }
                });
            } else {
                res.status(200).send();
            }
        }
    );
});
app.post(['/recurringpaymentsuccess'], function(req, res) {
    braintrees.webhookNotification.parse(
        req.body.bt_signature,
        req.body.bt_payload,
        function(err, webhookNotification) {
            var result = webhookNotification;
            if (result.subscription.id) {
                req.body.sub_id = result.subscription.id;
                req.body.nextBillingDate = result.subscription.nextBillingDate;
                if (result.success) {
                    req.body.paystatus = 'success';
                } else {
                    req.body.paystatus = 'success';
                }
                q.all([stores.getStorePlan(req, $arr.config.mysql, q)]).then(function(results) {
                    if (results[0][0].length > 0) {
                        q.all([stores.updateStorePlan(req, $arr.config.mysql, q)]).then(function(results2) {
                            res.status(200).send();
                        });
                    } else {
                        res.status(200).send();
                    }
                });
            } else {
                res.status(200).send();
            }
        });
});

app.post(['/makepayment'], function(req, res) {
    var nonce = req.body.payment_method_nonce;
    q.all([stores.getStorePlanlist(req, $arr.config.mysql, q)]).then(function(results) {
        if (results[0][0].length > 0) {
            req.body.amount = (typeof(results[0][0][0].amount) == 'undefined') ? 0 : results[0][0][0].amount;
            req.body.braintreepid = (typeof(results[0][0][0].plan_id) == 'undefined') ? 0 : results[0][0][0].plan_id;
            var plan = req.body.braintreepid;

            function callback(result) {
                console.log('<------------------------Payment responds------------------------->');
                console.log(result);
                console.log('<------------------------Payment responds------------------------->');
                if (result.success) {
                    req.body.sub_id = result.subscription.id;
                    req.body.nextBillingDate = result.subscription.nextBillingDate;
                    req.body.paystatus = 'success';
                    q.all([stores.getStorePlan(req, $arr.config.mysql, q)]).then(function(results1) {
                        if (results1[0][0].length > 0) {
                            res.writeHead(302, {
                                'Location': '/stores/mystore/dashboard'
                            });
                            res.end();
                            return false;
                        } else {
                            q.all([stores.saveStorePlan(req, $arr.config.mysql, q)]).then(function(results2) {
                                res.writeHead(302, {
                                    'Location': '/stores/mystore/dashboard'
                                });
                                res.end();
                                return false;
                            });
                        }
                    });
                } else {
                    res.writeHead(302, {
                        'Location': '/stores/dashboard'
                    });
                    res.end();
                    return false;
                }
            }
            braintrees.customer.create({
                paymentMethodNonce: nonce
            }, function(err, result) {
                if (result.success) {
                    var token = result.customer.paymentMethods[0].token;
                    braintrees.subscription.create({
                        paymentMethodToken: token,
                        planId: plan
                    }, function(err, result) {
                        callback(result);
                    });
                } else {
                    callback(undefined);
                }
            });
        }
    });
});
app.get(['/recurringpayment/:id'], function(req, res) {
    common.checkLogin(req, res, 0);
    var storeid = (typeof(req.param('id')) == 'undefined') ? 0 : Number(req.param('id'));
    if (storeid >= 0) {
        // var paytype = (typeof(req.param('paytype')) == 'undefined') ? '' : req.param('paytype');
        var controller = {
            getClientToken: function(callback) {
                braintrees.clientToken.generate({}, function(err, response) {
                    if (typeof callback == 'function') {
                        callback(response.clientToken);
                    } else {
                        return response.clientToken;
                    }
                    return this;
                });
            }
            // ,
            // getPlansAvailable: function(callback2,clienttkn) {
            //  braintrees.plan.all(function(err, response) {
            //         if(typeof callback2 == 'function') {
            //             callback2(response.plans,clienttkn);
            //         } else {
            //             return response.plans;
            //         }
            //         return this;
            //  });
            // }
        };
        // var callback2 = function(plans,clientToken) {
        //
        // }

        var callback = function(response) {
            // controller.getPlansAvailable(callback2,response);
            $arr.clientToken = response;
            q.all([stores.getStorePlanlist(req, $arr.config.mysql, q)]).then(function(results) {
                $arr.plans = results[0][0];
                $arr.storeid = storeid;
                common.tplFile('store/payment.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);
            });
        };
        controller.getClientToken(callback);
    } else {
        res.writeHead(302, {
            'Location': '/'
        });
        res.end();
        return false;
    }
});
app.post(['/cancelsubscription/:id'], function(req, res) {
    req.body.sub_id = req.param('id');
    q.all([stores.getStorePlan(req, $arr.config.mysql, q)]).then(function(results1) {
        if (results1[0][0].length > 0) {
            braintrees.subscription.cancel(req.body.sub_id, function(err, result) {
                if (result.success) {
                    req.body.paystatus = 'hold';
                    q.all([stores.updateStorePlan(req, $arr.config.mysql, q)]).then(function(results2) {
                        res.json({ 'result': 'success' });
                        res.end();
                        return false;
                    });
                } else {
                    res.json({ 'result': 'failed' });
                    res.end();
                    return false;
                }
            });
        } else {
            res.json({ 'result': 'failed' });
            res.end();
            return false;
        }
    });
});


app.get(['/ads'], function(req, res) {

    if (common.checkLogin(req, res, 0)) {
        q.all([
            stores.viewUserStores(req, $arr.config.mysql, q),
            adwords.selectstoreads(req, $arr.config.mysql, q, req.session.storeid)
        ]).then(function(results) {
            // console.log(JSON.stringify(results));

            if (results[0][0].length > 0) {
                $arr['alreadyadid'] = results[0][0][0].id;
                $arr['alreadyadsid'] = results[0][0][0].store_id;
            } else {
                $arr['alreadyads'] = 0;
            }

            if (results[0][0].length > 0) {

                $arr['adsmenu'] = [];
                $arr['adsmenu']['store'] = 'active';

                $arr.storeid = results[0][0][0].id;
                $arr.storedata = results[0][0][0];

                $arr.blserr = (typeof(req.param('blserr')) != 'undefined') ? req.param('blserr') : 0;

                common.tplFile('store/ads_store.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);

            } else {
                res.writeHead(302, {
                    'Location': '/stores/create',
                });
                res.end();
                return false;
            }
        });
    }
});


app.get(['/product/ads'], function(req, res) {
    product = require('../module/products');
    q.all([
        product.myproducts(req, $arr.config.mysql, q, 1),
        stores.viewUserStores(req, $arr.config.mysql, q),
        adwords.selectstoreads(req, $arr.config.mysql, q, req.session.storeid)
    ]).then(function(results) {

        if (results[2][0].length > 0) {
            $arr['alreadyads'] = 1;
            $arr['alreadyadid'] = results[2][0][0].id;
            $arr['alreadyadsid'] = results[2][0][0].store_id;
        } else {
            $arr['alreadyads'] = 0;
        }

        $arr.storeid = 0;
        $arr.prod_list = '';
        $arr.product_count = 0;
        if (results[0][0].length > 0) {
            $arr.product_count = results[0][0].length;
            $arr.proid = results[0][0][0].id;
            $arr.prod_list = results[0][0];
        }
        if (results[0][0].length > 0) {
            $arr.storeid = results[1][0][0].id;
        }
        // $arr['countries'] = config.countries;
        $arr['adsmenu'] = [];
        $arr['adsmenu']['product'] = 'active';
        common.checkLogin(req, res, 0);
        $arr.blserr = (typeof(req.param('blserr')) != 'undefined') ? req.param('blserr') : 0;
        $arr.error = (typeof(req.param('error')) != 'undefined') && req.param('error') ? req.param('error') : 0;
        common.tplFile('store/ads_product.tpl');
        common.headerSet(1);
        common.loadTemplateHeader(req, res, $arr);

    });
});

app.get(['/brands/ads'], function(req, res) {
    if (common.checkLogin(req, res, 0)) {
        product = require('../module/products');
        q.all([product.myproducts(req, $arr.config.mysql, q, 1),
            stores.viewUserStores(req, $arr.config.mysql, q),
            product.myproductsbrand(req, $arr.config.mysql, q, 1),
            adwords.selectstorebrandnew(req, $arr.config.mysql, q, req.session.storeid),
            adwords.selectstoreads(req, $arr.config.mysql, q, req.session.storeid)
        ]).then(function(results) {

            if (results[4][0].length > 0) {
                $arr['alreadyads'] = 1;
                $arr['alreadyadid'] = results[4][0][0].id;
                $arr['alreadyadsid'] = results[4][0][0].store_id;
            } else {
                $arr['alreadyads'] = 0;
            }

            $arr.storeid = 0;
            $arr.prod_list = '';
            $arr.product_count = 0;

            if (results[0][0].length > 0) {
                $arr.product_count = results[0][0].length;
                $arr.proid = results[0][0][0].id;
                $arr.prod_list = results[0][0];
                $arr.brand_list = results[2][0];
            }

            if (results[0][0].length > 0) {
                $arr.storeid = results[1][0][0].id;
            }

            if (results[3][0].length > 0) {

                $arr.brandaddlist = results[3][0];
            }

            $arr.blserr = (typeof(req.param('blserr')) != 'undefined') ? req.param('blserr') : 0;
            $arr['adsmenu'] = [];
            $arr['adsmenu']['brand'] = 'active';

            common.tplFile('store/ads_brand.tpl');
            common.headerSet(1);
            common.loadTemplateHeader(req, res, $arr);

        });
    }

});

app.get(['/pro_detail/:id'], function(req, res) {
    products = require('../module/products');
    q.all([stores.productDetail(req, config.mysql, q)]).then(function(results) {
        pro_detail = results[0][0][0];
        $arr['pid'] = req.param('id');
        console.log(pro_detail);
        obj = { "success": "yes", "pro_detail": pro_detail, "test": "1" };

        console.log(JSON.stringify(obj));
        aj_val = JSON.stringify(obj);
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(aj_val);

        console.log(16666);

    });

});

app.post(['/pro_detail/:id'], function(req, res) {
    products = require('../module/products');
    q.all([stores.productDetail(req, config.mysql, q)]).then(function(results) {
        pro_detail = results[0][0][0];
        $arr['pid'] = req.param('id');
        console.log(pro_detail);
        var data = {};
        data['success'] = true;
        data['pro_detail'] = pro_detail;
        console.log(1);
        console.log(JSON.stringify(data));
        aj_val = JSON.stringify(data);
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(aj_val);

        console.log(16666);
    });

});


app.get(['/sales/:action'], function(req, res) {
    if (common.checkLogin(req, res, 0)) {

        $arr.externalcss = ['jquery.datetimepicker'];
        $arr.externaljs = ['jquery.datetimepicker'];
        $arr['heading_common'] = "Stores Sales Report";
        //req.body.start_date = ((typeof(req.param('start_date')) === 'undefined') || req.param('start_date') == '') ? '' : common.changeDateFormat(req.param('start_date'));
        //req.body.end_date = ((typeof(req.param('end_date')) === 'undefined') || req.param('end_date') == '') ? '' : common.changeDateFormat(req.param('end_date'));
        req.body.page = (typeof(req.param('page')) !== 'undefined') ? req.param('page') : 1;
        req.body.sdate = (typeof(req.param('start_date')) !== 'undefined') ? req.param('start_date') : '';
        req.body.edate = (typeof(req.param('end_date')) !== 'undefined') ? req.param('end_date') : '';
        req.body.categoryId = (typeof(req.param('category')) !== 'undefined') ? req.param('category') : 0;
        $arr.start_date = req.body.sdate;
        $arr.end_date = req.body.edate;
        $arr.categoryId = req.body.categoryId;
        if (req.param('action') == 'report') {
            req.body.limit = 10;
            q.all([
                stores.getSalesReport(req, config.mysql, q, 0),
                stores.getSalesReport(req, config.mysql, q, 1),
                products.getResearchDataFlower(req, config.mysql, q, 0)
            ]).then(function(results) {

                //console.log(JSON.stringify(results));
                $arr['pagination'] = 100;
                $arr['list'] = products.shortDescribe(results[0][0]);
                $arr['research_data'] = results[2][0][0];
                console.log('research data', $arr['research_data'])
                var pagination = require('pagination');
                var url = require('url');
                var url_parts = url.parse(req.url, true);
                var query = url_parts.query;
                $arr['search'] = query;
                fquery = common.urlparameter(query, { page: '' });
                var paginator = new pagination.SearchPaginator({
                    prelink: '/stores/sales/report?' + fquery,
                    current: req.body.page,
                    rowsPerPage: 10,
                    totalResult: results[1][0][0].total_inv
                });

                $arr['pagination_html'] = paginator.render();

                common.tplFile('stores_sales_report.tpl');
                common.headerSet(1);
                common.loadTemplateHeader(req, res, $arr);

            }).fail(function(err) {
                console.log(err.stack);
                throw err;
            }).done();
        } else if (req.param('action') == 'download') {
            q.all([
                stores.getSalesReport(req, config.mysql, q, 2),
                products.getResearchDataFlower(req, config.mysql, q, 0)
            ]).then(function(result) {
                var k = result[0][0].length;
                // console.log('k---------------', k);
                resultk = products.shortDescribe(result[0][0]);
                mk = result[1][0][0];
                var j = 0;
                arr = [];

                data2 = [
                    'Product Purchased',
                    'Category',
                    'Sub Category',
                    'My Avg Transaction Price / lb',
                    'Market Avg Transaction Price',
                    'My Price VS Mkt',
                    'My Volume',
                    'Market Volume',
                    'My Mkt Share Volume',
                    'Unit of Measure'
                ];
                arr.push(data2);
                for (i in resultk) {
                    // console.log('i------------', i);
                    // console.log('j------------', j);
                    j++;
                    var mk_price = 0;
                    var mk_vol = 0;
                    if (resultk[i].parent_cat_name == 'Flower') {
                        mk_price = (parseFloat(mk.avg_flower_amt)).toFixed(2);
                        mk_vol = mk.total_flower_qty;
                    } else if (resultk[i].parent_cat_name == 'Dry Concentrates') {
                        mk_price = (parseFloat(mk.avg_dryc_amt)).toFixed(2);
                        mk_vol = mk.total_dryc_qty;
                    } else if (resultk[i].parent_cat_name == 'Oil Concentrates') {
                        mk_price = (parseFloat(mk.avg_oilc_amt)).toFixed(2);
                        mk_vol = mk.total_oilc_qty;
                    } else if (resultk[i].parent_cat_name == 'Edibles') {
                        mk_price = (parseFloat(mk.avg_edible_amt)).toFixed(2);
                        mk_vol = mk.total_edible_qty;
                    }else if (resultk[i].parent_cat_name == 'Topicals') {
                        mk_price = (parseFloat(mk.avg_topical_amt)).toFixed(2);
                        mk_vol = mk.total_topical_qty;
                    }

                    data2 = [
                        resultk[i]['p_title'],
                        resultk[i]['parent_cat_name'],
                        resultk[i]['cat_name'] + '(' + resultk[i]['pid'] + ')',
                        resultk[i]['p_unit_price'] + '/' + resultk[i]['short_unit'],
                        mk_price + '/' + resultk[i]['short_unit'],
                        (parseFloat(mk_price) - parseFloat(resultk[i]['p_unit_price'])).toFixed(2),
                        resultk[i]['i_qty'],
                        mk_vol,
                        parseFloat((resultk[i].i_qty / mk_vol) * 100).toFixed(2) + '%',
                        resultk[i]['units']
                    ];

                    // console.log(data2)
                    arr.push(data2);
                }
                res.setHeader('Content-disposition', 'attachment; filename=report.csv');
                res.csv(arr);
            }).fail(function(err) {
                console.log(err.stack);
                throw err;
            }).done();
        }
    }

});


module.exports = app;