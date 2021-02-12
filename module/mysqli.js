exports.mysqli = function(data,row)
{
     k = mysqli[row];
     for(var i in data)
     {
         k = k.replace(new RegExp('{{'+i+'}}', 'g'), data[i]);
     }
     return k;
}
/* for adding 72 hours to date in the field date_added */
// DATE_SUB(date_added, INTERVAL 72 hour) as checkAvail
var mysqli = [];

/* ========================= Start for HempBuyer */
mysqli['getProduct'] = 'SELECT p.*, IFNULL(p.keywords,"") as keywords, date_format(p.start_date,"%m-%d-%Y %H:%i:%s") AS start_date, date_format(p.end_date,"%m-%d-%Y %H:%i:%s") AS end_date, date_format(p.manufacture_date,"%m-%d-%Y") AS manufacture_date, date_format(p.certificate_date,"%m-%d-%Y") AS certificate_date, seller.name AS seller_name, seller.email AS seller_email FROM products AS p INNER JOIN hmb_users AS seller ON seller.id=p.user_id WHERE p.id = ?'
mysqli['getAllCategories'] = 'SELECT * FROM categories WHERE 1=1 {{where}}'
mysqli['getCategories'] = 'SELECT * FROM categories WHERE parent_id=?'
mysqli['deletecertificate'] = 'update user_certificates set is_delete = 1 where id = ? limit 1';
mysqli['insertProduct'] = 'INSERT INTO products(user_id, title, start_date, end_date, category_id, subcategory_id, type, auction_active, is_buynow, start_price, reserve_price, buynow_price, buynow_qty, fixed_price, fixed_qty, offer_price, offer_qty, description, packaging_description, unit_of_measurement, manufacture_date, certificate_types, certificate_date, contaminant_screening, contaminant_screening_data, sops, payment_method, payment_method_other, product_image, market_status, amount_sold, moq, product_place, renew, qty_available, keywords, lots_available) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ?, ?, ?, ?, ?, ?, ?, ?)';

mysqli['saveProductDocument'] = 'INSERT INTO product_images(project_id, image, avatar, date_added, classified_id, type) VALUES(?,?,?,?,?,?)';
mysqli['deleteProductDocument'] = 'DELETE FROM product_images WHERE type=? AND project_id=?';
mysqli['savecertificatesDocument'] = 'INSERT INTO product_certificates(user_id, product_id, certificate_name, type, status, created_at) VALUES(?,?,?,?,?,?)';
mysqli['deleteProductDocumentByName'] = 'DELETE FROM product_images WHERE image=?';
mysqli['deleteCertificateByName'] = 'DELETE FROM product_certificates WHERE certificate_name=?';



/* ========================= End for HempBuyer */

//Order API Query
mysqli['last_login_update'] = 'UPDATE `herbes_local_users` SET `last_login`= ? WHERE id = ?';
mysqli['select_order_status'] = 'SELECT id, delivery_status, shipping_status, order_status FROM `buynow` WHERE id = ?'

mysqli['update_order_status'] = 'UPDATE `buynow` SET `shipping_status`= ? ,`delivery_status`= ? ,`order_status`= ? WHERE id = ?'

mysqli['order_api_req'] = 'select b.qty AS req_qty, b.id AS order_id, b.recurring as b_recurring_status, p.pkey AS sku, p.units AS units, p.description AS product_description, p.date_closed AS auction_end, b.seller_paid_amt as b_seller_paid_amt, b.total_amount as b_total_amount, b.excise_tax_amt as b_excise_tax_amt,b.cultivation_tax as b_cultivation_tax,b.distribution_tax as b_distribution_tax, date_format(buyuser.last_login,"%m/%d/%Y %h:%i:%s") AS buyer_last_login, b.user_id as buserid,bid.from_hour AS buyer_ship_from, bid.to_hour AS buyer_ship_to,bid.first_name AS buyer_first_name, bid.last_name AS buyer_last_name, bid.phone AS buyer_phone,bid.email AS buyer_email,bext.ein_number AS buyer_ein,bext.business_type AS buyer_business_type, bext.permit_expires AS buyer_permit_expires,bid.address AS buyer_address, bid.zipcode AS buyer_zip, bid.city AS buyer_city, bid.state AS buyer_state, date_format(seluser.last_login,"%m/%d/%Y %h:%i:%s") AS seller_last_login, b.request_userid as suserid, sid.from_hour AS seller_ship_from, sid.to_hour AS seller_ship_to, sid.first_name AS seller_first_name, sid.last_name AS seller_last_name, sid.phone AS seller_phone, sid.email AS seller_email, sext.ein_number AS seller_ein,sext.business_type AS seller_business_type, sext.permit_expires AS seller_permit_expires, sid.address AS seller_address, sid.zipcode AS seller_zip,sid.city AS seller_city, sid.state AS seller_state from buynow as b left join projects as p on p.id = b.project_id left join checkout c on b.cart_id = c.id left join shipping sid on b.request_userid = sid.user_id left join shipping bid on b.user_id = bid.user_id left join herbes_local_users seluser on b.request_userid = seluser.id left join herbes_local_users buyuser on b.user_id = buyuser.id left join invoices i on i.cart_id = c.id left join user_extras sext on b.request_userid = sext.user_id left join user_extras bext on b.user_id = bext.user_id where b.id = ?';



mysqli['product_api_req'] = 'SELECT p.id, p.pkey AS sku, p.qty AS req_qty, p.units AS req_units, b.address AS seller_address, b.zipcode AS seller_zip, b.city AS seller_city, b.state AS seller_state, b.from_hour AS seller_ship_from, b.to_hour AS seller_ship_to FROM projects AS p left join shipping AS b on p.user_id = b.user_id WHERE p.id = ?';

mysqli['warehouseSkuONProduct'] = 'UPDATE `projects` SET `warehouseSku`= ? WHERE id = ?'


// added by mohit
// and adt.date_added >="2017-11-20" and adt.date_added <= "2017-11-30"
/* Getting expired ads with refund amount for daily cron to refund remaining ads amount */
mysqli['update_user_bal'] = 'update herbes_local_users set balance = balance + ? where id = ?';
mysqli['update_ads_refund_status'] = 'update adwords set refund_status = 1, ref_inv_id = ? where id = ? and user_id = ?';
mysqli['get_expiredref_ads'] = 'select IFNULL(sum(adt.s_click),0) as adt_s_click, IFNULL(sum(adt.clicks),0) as adt_clicks, IFNULL((ad.total_clicks_allowed - IFNULL(sum(adt.clicks),0)),0) as remain_clicks, IFNULL((IFNULL((ad.total_clicks_allowed - IFNULL(sum(adt.clicks),0)),0) * ad.budget_per_click),0) as refund_amt, ad.* from adwords ad left join ads_track adt on ad.id = adt.ads_id where ad.status = "remove"  and ad.refund_status = 0 group by ad.id';
mysqli['get_campaign_data'] = 'select adt.date_added as adt_date_added, sum(adt.views) as daily_views, sum(adt.clicks) as daily_clicks from adwords a left join ads_track adt on a.id = adt.ads_id where a.id in (select id from adwords where user_id = ?) group by adt.date_added desc';

mysqli['get_business_settings'] = 'select * from business_settings';
/* mysqli['totalsoldbyuser'] ='select sum(sold * unit_price) as total_sold_price, sum(sold) as sold, (sum(unit_price)/count(id)) as avg_unit_price from projects where user_id = ?'; */
mysqli['totalsoldbyuser'] ='select sum(sold * unit_price) as total_sold_price, sum(sold) as sold, (sum(unit_price)/count(id)) as avg_unit_price from projects where auction=0 and user_id = ? ';
mysqli['ads_graphdata2']= 'SELECT b.date_added, b.amount as direct_m_sales, sum(b.qty) as qty FROM `buynow` as b INNER JOIN projects as p on p.id= b.project_id WHERE request_userid = ? {{where}} GROUP by date(b.date_added)';

mysqli['update_bpay_status'] ='update buynow set paid = ?, paid_date = ? where id = ? and paid = 0 and user_id = ?';
mysqli['update_bpay_status_by_id'] ='update buynow set paid = 1, paid_date = ? where id = ? and paid = 0';
mysqli['update_spay_status'] ='update buynow set seller_paid_status = "1", seller_paid_at = ?, commission_s_per = ?,commission_s = ?, seller_paid_amt = ? where id = ? and paid = 1 and seller_paid_status = "0" and request_userid = ?';
mysqli['update_apay_status'] ='update buynow set admin_paid_status = "1", admin_paid_at = ?, admin_paid_amt = ? where id = ? and paid = 1';

/* User balance updation */
// mysqli['update_balance'] ='update herbee_local_user set balance = balance + ? where id = ?';

/* get users partial data from user_extras*/
// mysqli['get_partial_udata'] = 'select ue.user_id, ue.business_type from user_extras as ue  where ueuser_id in {{ids}}';
mysqli['get_partial_udata'] = 'select ue.user_id, ue.business_type, IFNULL(mu.user_id,"NA") as mu_user_id, IFNULL(mu.plan_id,"NA") as mplan_id, IFNULL(mp.name,"NA") as mplan_name, IFNULL(mp.description,"NA") as mplan_description from user_extras as ue left join  membership_user as mu on ue.user_id = mu.user_id left join membership_plan as mp on mu.plan_id = mp.id {{ids}}';

/* Store ratings */
mysqli['get_store_reviews'] = 'select s.*, IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = s.store_id),0) as overall_rating from seller_performance as s where s.store_id = ? and s.seller_id = ? {{limit}}';
mysqli['get_store_reviews_cnt'] = 'select count(s.id) as total_reviews from seller_performance as s where s.store_id = ? and s.seller_id = ?';

mysqli['getSellerReviews'] = 'select s.*, IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = s.store_id),0) as overall_rating from seller_performance as s where s.seller_id = ? {{limit}}';
mysqli['getSellerReviews_cnt'] = 'select count(s.id) as total_reviews from seller_performance as s where s.seller_id = ?';

mysqli['getBuyerReviews'] = 'select s.*, ROUND((s.avg_rating + s.tpayment)/2) AS avg_rating, IFNULL((select ROUND((sum(avg_rating)/count(id) + sum(tpayment)/count(id) )/2) from buyer_performance where store_id = s.store_id),0) as overall_rating from buyer_performance as s where s.buyer_id = ? {{limit}}';
mysqli['getBuyerReviews_cnt'] = 'select count(s.id) as total_reviews from buyer_performance as s where s.buyer_id = ?';

mysqli['getOverallSellerRatings'] = 'select ROUND(sum(avg_rating)/count(id)) AS seller_rating from seller_performance where seller_id = ?';
mysqli['getOverallBuyerRatings'] = 'select ROUND((sum(avg_rating)/count(id) + sum(tpayment)/count(id) )/2) AS buyer_rating from buyer_performance where buyer_id = ?';


/* Membership */
mysqli['get_expired_memberships'] = 'select * from membership_user where DATE(renewal_date) < CURDATE() and status = "active"';
mysqli['change_membership_status'] = 'update membership_user set renewal_date=DATE_ADD(renewal_date, INTERVAL 1 YEAR),status="expired",mem_status=0 where id in ({{ids}})';

/* Gathering research data */
mysqli['get_aresearch_data'] = 'select SUM(case when units = "pounds" then 1 else 0 end) as "total_pounds", SUM(case when units = "pounds" then unit_price else 0 end) as "total_pounds_price", SUM(case when units = "units" then 1 else 0 end) as "total_units" , SUM(case when units = "units" then unit_price else 0 end) as "total_units_price",SUM(case when units = "ounces" then 1 else 0 end) as "total_ounces" , SUM(case when units = "ounces" then unit_price else 0 end) as "total_ounces_price", SUM(case when units = "grams" then 1 else 0 end) as "total_grams", SUM(case when units = "grams" then unit_price else 0 end) as "total_grams_price", sum(unit_price) total_price, sum(qty) total_qty, sum(sold + filled_qty) total_sold, sum(qty - (sold + filled_qty)) total_price from projects where auction = 0 {{whr}}';
mysqli['get_research_data'] = 'select SUM(case when units = "pounds" then 1 else 0 end) as "total_pounds", SUM(case when units = "pounds" then qty else 0 end) as "ttotal_pounds", SUM(case when units = "pounds" then unit_price else 0 end) as "total_pounds_price", SUM(case when units = "pounds" then (unit_price * qty) else 0 end) as "ttotal_pounds_price",SUM(case when units = "units" then 1 else 0 end) as "total_units" , SUM(case when units = "units" then qty else 0 end) as "ttotal_units" , SUM(case when units = "units" then unit_price else 0 end) as "total_units_price",SUM(case when units = "units" then (unit_price * qty) else 0 end) as "ttotal_units_price",SUM(case when units = "ounces" then 1 else 0 end) as "total_ounces" , SUM(case when units = "ounces" then qty else 0 end) as "ttotal_ounces" , SUM(case when units = "ounces" then unit_price else 0 end) as "total_ounces_price", SUM(case when units = "ounces" then (unit_price * qty) else 0 end) as "ttotal_ounces_price", SUM(case when units = "grams" then 1 else 0 end) as "total_grams", SUM(case when units = "grams" then qty else 0 end) as "ttotal_grams", SUM(case when units = "grams" then unit_price else 0 end) as "total_grams_price", SUM(case when units = "grams" then (unit_price * qty) else 0 end) as "ttotal_grams_price", sum(unit_price) total_price, sum(qty) total_qty, sum(sold + filled_qty) total_sold, sum(qty - (sold + filled_qty)) total_price from projects {{whr}}';
/* transactionwise reserch data */
// mysqli['get_research_flower'] = 'select ROUND(AVG(b.amount),2) as avg_amt,ROUND(SUM(case when sc.name like "%hybrid%" then b.amount else 0 end)) as "avg_hybrid_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure sativa%" then b.amount else 0 end)/SUM(case when sc.name like "%pure sativa%" then 1 else 0 end), 2),0) as "avg_sativa_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure indica%" then b.amount else 0 end)/SUM(case when sc.name like "%pure indica%" then 1 else 0 end), 2), 0) as "avg_indica_amt",IFNULL(ROUND(SUM(case when sc.name like "%hybrid%" then b.amount else 0 end)/SUM(case when sc.name like "%hybrid%" then 1 else 0 end), 2), 0) as "avg_hybrid_amt",IFNULL(SUM(case when sc.name like "%pure sativa%" then b.qty else 0 end), 0) as "total_sativa_qty", IFNULL(SUM(case when sc.name like "%pure indica%" then b.qty else 0 end), 0) as "total_indica_qty", IFNULL(SUM(case when sc.name like "%hybrid%" then b.qty else 0 end), 0) as "total_hybrid_qty", ROUND(AVG(b.qty),2) as avg_qty,sc.name as sub_cat, pc.name as parent_cat, b.id as buynow_id, c.id as cart_id, p.id product_id, i.* from invoices i left join checkout c on c.id = i.cart_id left join buynow b on b.cart_id = c.id left join projects p on i.primary_id = p.id left join categories sc on p.category_id = sc.id left join categories pc on p.parent_category_id=pc.id where i.type = "bought" {{whr}}';
// mysqli['get_research_flower'] = 'select IFNULL(ROUND(AVG(b.amount),2),0) as avg_amt, IFNULL(ROUND(SUM(case when (sc.name like "%hybrid%" or pc.name like "%hybrid%") then b.amount else 0 end)),0) as "avg_hybrid_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure sativa%" then b.amount else 0 end)/SUM(case when sc.name like "%pure sativa%" then 1 else 0 end), 2),0) as "avg_sativa_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure sativa%" then b.amount else 0 end)/SUM(case when sc.name like "%pure sativa%" then 1 else 0 end), 2),0) as "avg_sativa_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure indica%" then b.amount else 0 end)/SUM(case when sc.name like "%pure indica%" then 1 else 0 end), 2), 0) as "avg_indica_amt",IFNULL(ROUND(SUM(case when sc.name like "%hybrid%" then b.amount else 0 end)/SUM(case when sc.name like "%hybrid%" then 1 else 0 end), 2), 0) as "avg_hybrid_amt",IFNULL(ROUND(SUM(case when pc.name like "%dry concentrate%" then b.amount else 0 end)/SUM(case when pc.name like "%dry concentrate%" then 1 else 0 end), 2), 0) as "avg_dryc_amt",IFNULL(ROUND(SUM(case when pc.name like "%oil concentrate%" then b.amount else 0 end)/SUM(case when pc.name like "%oil concentrate%" then 1 else 0 end), 2), 0) as "avg_oilc_amt",IFNULL(ROUND(SUM(case when pc.name like "%edible%" then b.amount else 0 end)/SUM(case when pc.name like "%edible%" then 1 else 0 end), 2), 0) as "avg_edible_amt",IFNULL(SUM(case when sc.name like "%pure sativa%" then b.qty else 0 end), 0) as "total_sativa_qty", IFNULL(SUM(case when sc.name like "%pure indica%" then b.qty else 0 end), 0) as "total_indica_qty", IFNULL(SUM(case when sc.name like "%hybrid%" then b.qty else 0 end), 0) as "total_hybrid_qty", IFNULL(SUM(case when pc.name like "%dry concentrate%" then b.qty else 0 end), 0) as "total_dryc_qty", IFNULL(SUM(case when pc.name like "%oil concentrate%" then b.qty else 0 end), 0) as "total_oilc_qty", IFNULL(SUM(case when pc.name like "%edible%" then b.qty else 0 end), 0) as "total_edible_qty",ROUND(AVG(b.qty),2) as avg_qty,sc.name as sub_cat, pc.name as parent_cat, b.id as buynow_id, c.id as cart_id, p.id product_id, i.* from invoices i left join checkout c on c.id = i.cart_id left join buynow b on b.cart_id = c.id left join projects p on i.primary_id = p.id left join user_extras ue on ue.user_id = p.user_id left join categories sc on p.category_id = sc.id left join categories pc on p.parent_category_id=pc.id where i.type = "bought" {{whr}}';

/* getting buyerside research data */
// mysqli['get_research_flower'] = 'select IFNULL(ROUND(SUM(case when pc.name like "%topical%" then b.amount else 0 end)/SUM(case when pc.name like "%topical%" then 1 else 0 end), 2),0) as "avg_topical_amt", IFNULL(SUM(case when pc.name like "%topical%" then b.qty else 0 end), 0) as "total_topical_qty", IFNULL(ROUND(SUM(case when pc.name like "%flower%" then b.amount else 0 end)/SUM(case when pc.name like "%flower%" then 1 else 0 end), 2),0) as "avg_flower_amt", IFNULL(SUM(case when pc.name like "%flower%" then b.qty else 0 end), 0) as "total_flower_qty", IFNULL(ROUND(AVG(b.amount),2),0) as avg_amt, IFNULL(ROUND(SUM(case when sc.name like "%pure sativa%" then b.amount else 0 end)/SUM(case when sc.name like "%pure sativa%" then 1 else 0 end), 2),0) as "avg_sativa_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure sativa%" then b.amount else 0 end)/SUM(case when sc.name like "%pure sativa%" then 1 else 0 end), 2),0) as "avg_sativa_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure indica%" then b.amount else 0 end)/SUM(case when sc.name like "%pure indica%" then 1 else 0 end), 2), 0) as "avg_indica_amt",IFNULL(ROUND(SUM(case when sc.name like "%hybrid%" then b.amount else 0 end)/SUM(case when sc.name like "%hybrid%" then 1 else 0 end), 2), 0) as "avg_hybrid_amt",IFNULL(ROUND(SUM(case when pc.name like "%dry concentrate%" then b.amount else 0 end)/SUM(case when pc.name like "%dry concentrate%" then 1 else 0 end), 2), 0) as "avg_dryc_amt",IFNULL(ROUND(SUM(case when pc.name like "%oil concentrate%" then b.amount else 0 end)/SUM(case when pc.name like "%oil concentrate%" then 1 else 0 end), 2), 0) as "avg_oilc_amt",IFNULL(ROUND(SUM(case when pc.name like "%edible%" then b.amount else 0 end)/SUM(case when pc.name like "%edible%" then 1 else 0 end), 2), 0) as "avg_edible_amt",IFNULL(SUM(case when sc.name like "%pure sativa%" then b.qty else 0 end), 0) as "total_sativa_qty", IFNULL(SUM(case when sc.name like "%pure indica%" then b.qty else 0 end), 0) as "total_indica_qty", IFNULL(SUM(case when sc.name like "%hybrid%" then b.qty else 0 end), 0) as "total_hybrid_qty", IFNULL(SUM(case when pc.name like "%dry concentrate%" then b.qty else 0 end), 0) as "total_dryc_qty", IFNULL(SUM(case when pc.name like "%oil concentrate%" then b.qty else 0 end), 0) as "total_oilc_qty", IFNULL(SUM(case when pc.name like "%edible%" then b.qty else 0 end), 0) as "total_edible_qty",ROUND(AVG(b.qty),2) as avg_qty,sc.name as sub_cat, pc.name as parent_cat, b.id as buynow_id, c.id as cart_id, p.id as product_id, i.* from invoices i left join checkout c on c.id = i.cart_id left join buynow b on b.cart_id = c.id left join projects p on i.primary_id = p.id left join user_extras ue on ue.user_id = p.user_id left join categories sc on p.category_id = sc.id left join categories pc on p.parent_category_id=pc.id where i.type = "bought" {{whr}}';

/* getting buyer and sellerside research data */
mysqli['get_research_flower'] = 'select IFNULL(ROUND(SUM(case when pc.name like "%topical%" then b.amount else 0 end)/SUM(case when pc.name like "%topical%" then 1 else 0 end), 2),0) as "avg_topical_amt", IFNULL(SUM(case when pc.name like "%topical%" then b.qty else 0 end), 0) as "total_topical_qty", IFNULL(ROUND(SUM(case when pc.name like "%flower%" then b.amount else 0 end)/SUM(case when pc.name like "%flower%" then 1 else 0 end), 2),0) as "avg_flower_amt", IFNULL(SUM(case when pc.name like "%flower%" then b.qty else 0 end), 0) as "total_flower_qty", IFNULL(ROUND(AVG(b.amount),2),0) as avg_amt, IFNULL(ROUND(SUM(case when sc.name like "%pure sativa%" then b.amount else 0 end)/SUM(case when sc.name like "%pure sativa%" then 1 else 0 end), 2),0) as "avg_sativa_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure sativa%" then b.amount else 0 end)/SUM(case when sc.name like "%pure sativa%" then 1 else 0 end), 2),0) as "avg_sativa_amt",IFNULL(ROUND(SUM(case when sc.name like "%pure indica%" then b.amount else 0 end)/SUM(case when sc.name like "%pure indica%" then 1 else 0 end), 2), 0) as "avg_indica_amt",IFNULL(ROUND(SUM(case when sc.name like "%hybrid%" then b.amount else 0 end)/SUM(case when sc.name like "%hybrid%" then 1 else 0 end), 2), 0) as "avg_hybrid_amt",IFNULL(ROUND(SUM(case when pc.name like "%dry concentrate%" then b.amount else 0 end)/SUM(case when pc.name like "%dry concentrate%" then 1 else 0 end), 2), 0) as "avg_dryc_amt",IFNULL(ROUND(SUM(case when pc.name like "%oil concentrate%" then b.amount else 0 end)/SUM(case when pc.name like "%oil concentrate%" then 1 else 0 end), 2), 0) as "avg_oilc_amt",IFNULL(ROUND(SUM(case when pc.name like "%edible%" then b.amount else 0 end)/SUM(case when pc.name like "%edible%" then 1 else 0 end), 2), 0) as "avg_edible_amt",IFNULL(SUM(case when sc.name like "%pure sativa%" then b.qty else 0 end), 0) as "total_sativa_qty", IFNULL(SUM(case when sc.name like "%pure indica%" then b.qty else 0 end), 0) as "total_indica_qty", IFNULL(SUM(case when sc.name like "%hybrid%" then b.qty else 0 end), 0) as "total_hybrid_qty", IFNULL(SUM(case when pc.name like "%dry concentrate%" then b.qty else 0 end), 0) as "total_dryc_qty", IFNULL(SUM(case when pc.name like "%oil concentrate%" then b.qty else 0 end), 0) as "total_oilc_qty", IFNULL(SUM(case when pc.name like "%edible%" then b.qty else 0 end), 0) as "total_edible_qty",ROUND(AVG(b.qty),2) as avg_qty,sc.name as sub_cat, pc.name as parent_cat, b.id as buynow_id, c.id as cart_id, p.id as product_id, i.* from buynow b  left join checkout c on c.id = b.cart_id left join invoices i on i.cart_id = c.id left join projects p on i.primary_id= p.id left join user_extras ue on ue.user_id = p.user_id left join categories sc on p.category_id = sc.id left join categories pc on p.parent_category_id=pc.id where i.type = "bought" {{whr}}';


/* product wise research data */
// mysqli['get_research_flower'] = 'select (SUM(case when c.name = "Indica- Hybrid" then p.qty else 0 end) + SUM(case when c.name = "Sativa- Hybrid" then p.qty else 0 end)) as total_hybrids_vol, SUM(case when c.name = "Pure Indica" then p.qty else 0 end) as total_indica_vol,SUM(case when c.name = "Pure Sativa" then p.qty  else 0 end) as total_sativa_vol, SUM(case when cp.name = "Dry Concentrates" then p.qty else 0 end) as total_dry_c_vol, SUM(case when cp.name = "Oil Concentrates" then p.qty else 0 end)as total_oil_c_vol, SUM(case when cp.name = "Edibles" then p.qty  else 0 end) as total_edibles_vol, (SUM(case when c.name = "Indica- Hybrid" then p.unit_price else 0 end)+SUM(case when c.name = "Sativa- Hybrid" then p.unit_price else 0 end)) as hybrids_price, SUM(case when c.name = "Pure Indica" then p.unit_price else 0 end) as indica_price, SUM(case when c.name = "Pure Sativa" then p.unit_price  else 0 end) as sativa_price, ( SUM(case when c.name = "Indica- Hybrid" then 1 else 0 end)+ SUM(case when c.name = "Sativa- Hybrid" then 1 else 0 end)) as hybrids_vol, SUM(case when c.name = "Pure Indica" then 1 else 0 end) as indica_vol,SUM(case when c.name = "Pure Sativa" then 1  else 0 end) as sativa_vol, SUM(case when cp.name = "Dry Concentrates" then 1 else 0 end) as dry_c_vol, SUM(case when cp.name = "Oil Concentrates" then 1 else 0 end) as oil_c_vol, SUM(case when cp.name = "Edibles" then 1  else 0 end) as edibles_vol, SUM(case when cp.name = "Dry Concentrates" then p.unit_price else 0 end) as dry_c_price, SUM(case when cp.name = "Oil Concentrates" then p.unit_price else 0 end) as oil_c_price, SUM(case when cp.name = "Edibles" then p.unit_price else 0 end) as edibles_price, SUM(case when cp.name = "Flower" then p.unit_price else 0 end) as flower_price,SUM(case when cp.name = "Flower" then 1 else 0 end) as flower_vol from projects p left join categories c on p.category_id = c.id left join categories cp on c.parent_id = cp.id {{whr}}';

/* Gathering adminside research data */
/* getting open bid total transactions day month year wise */
// mysqli['get_obar_data'] = 'SELECT (select count(id) as total_prdt from projects where auction = 1) as total_prdts, DATE_FORMAT(b.paid_date, "%b") AS month, count(b.id) as total_transactions, SUM(b.amount) as total_unit_amt, sum(p.filled_qty) as total_avail_vol, sum(p.qty - b.qty) as total_bdbvol, SUM(b.total_amount) as total_amt FROM buynow b inner join projects p on b.project_id = p.id WHERE p.auction = 1 and b.paid = 1 and b.paid_date <= NOW() and b.paid_date >= Date_add(Now(),interval - 12 month) GROUP BY DATE_FORMAT(b.paid_date, "%m-%Y")';
mysqli['get_obar_data'] = 'select (select count(id) as total_prdt from projects where auction = 1) as total_prdts, day(i.paid_date) as day_date, DATE_FORMAT(i.paid_date, "%m") AS day_month, DATE_FORMAT(i.paid_date, "%b") AS day_month_str, DATE_FORMAT(i.paid_date, "%Y") AS day_year, count(i.id) as total_transactions from invoices i left join projects as p on p.id = i.primary_id where auction = 1 and i.type = "bought" and month(i.paid_date) = month(NOW()) and year(i.paid_date) = year(NOW()) group by day(i.paid_date)';
/* getting openbid total uploaded peoducts  day month year wise data */
mysqli['get_obar1_data'] = 'select day(p.date_added) as day_date, DATE_FORMAT(p.date_added, "%m") AS day_month, DATE_FORMAT(p.date_added, "%b") AS day_month_str, DATE_FORMAT(p.date_added, "%Y") AS day_year, count(p.id) as total_prdts from projects as p where auction = 1 and month(p.date_added) = month(NOW()) and year(p.date_added) = year(NOW()) group by day(p.date_added)';
/* getting openbid total available volume peoducts  day month year wise data */
// mysqli['get_obar2_data'] = 'select day(p.date_added) as day_date, (IFNULL((select sum(qty) from projects where auction = 1 and date_added <= p.date_added),0) - IFNULL((select sum(bb.qty) from buynow as bb left join projects as pp on bb.project_id = pp.id where pp.auction = 1 and pp.date_added <= p.date_added),0)) as total_avail_vol, DATE_FORMAT(p.date_added, "%m") AS day_month, DATE_FORMAT(p.date_added, "%Y") AS day_year from projects as p where auction = 1 and month(p.date_added) = month(NOW()) and year(p.date_added) = year(NOW()) group by day(p.date_added)';
mysqli['get_obar2_data'] = 'select day(p.date_added) as day_date, (IFNULL((select sum(qty) from projects where auction = 1),0) - IFNULL((select sum(bb.qty) from buynow as bb left join projects as pp on bb.project_id = pp.id where pp.auction = 1),0)) as total_avail_vol, DATE_FORMAT(p.date_added, "%m") AS day_month, DATE_FORMAT(p.date_added, "%Y") AS day_year from projects as p where auction = 1 and month(p.date_added) = month(NOW()) and year(p.date_added) = year(NOW()) group by day(p.date_added)';

/* getting direct buy total transactions day month year wise */
// mysqli['get_dbar_data'] = 'SELECT (select count(id) as total_prdt from projects where auction = 0) as total_prdts, DATE_FORMAT(b.paid_date, "%b") AS month, count(b.id) as total_transactions, SUM(b.amount) as total_unit_amt, sum(p.qty - b.qty) as total_avail_vol, sum(p.qty - b.qty) as total_bdbvol, SUM(b.total_amount) as total_amt FROM buynow b inner join projects p on b.project_id = p.id WHERE p.auction = 0 and b.paid = 1 and b.paid_date <= NOW() and b.paid_date >= Date_add(Now(),interval - 12 month) GROUP BY DATE_FORMAT(b.paid_date, "%m-%Y")';
mysqli['get_dbar_data'] = 'select (select count(id) as total_prdt from projects where auction = 0) as total_prdts, day(i.paid_date) as day_date, DATE_FORMAT(i.paid_date, "%m") AS day_month, DATE_FORMAT(i.paid_date, "%b") AS day_month_str, DATE_FORMAT(i.paid_date, "%Y") AS day_year, count(i.id) as total_transactions from invoices i left join projects as p on p.id = i.primary_id where auction = 0 and i.type = "bought" and month(i.paid_date) = month(NOW()) and year(i.paid_date) = year(NOW()) group by day(i.paid_date)';
/* getting direct buy total uploaded peoducts  day month year wise data */
mysqli['get_dbar1_data'] = 'select day(p.date_added) as day_date, DATE_FORMAT(p.date_added, "%m") AS day_month, DATE_FORMAT(p.date_added, "%b") AS day_month_str, DATE_FORMAT(p.date_added, "%Y") AS day_year, count(p.id) as total_prdts from projects as p where auction = 0 and month(p.date_added) = month(NOW()) and year(p.date_added) = year(NOW()) group by day(p.date_added)';
/* getting direct buy total available volumes day month year wise data */
// mysqli['get_dbar2_data'] = 'select day(p.date_added) as day_date, (IFNULL((select sum(qty) from projects where auction = 0 and date_added <= p.date_added),0) - IFNULL((select sum(bb.qty) from buynow as bb left join projects as pp on bb.project_id = pp.id where pp.auction = 0 and pp.date_added <= p.date_added),0)) as total_avail_vol, DATE_FORMAT(p.date_added, "%m") AS day_month, DATE_FORMAT(p.date_added, "%Y") AS day_year from projects as p where auction = 0 and month(p.date_added) = month(NOW()) and year(p.date_added) = year(NOW()) group by day(p.date_added)';
mysqli['get_dbar2_data'] = 'select day(p.date_added) as day_date, (IFNULL((select sum(qty) from projects where auction = 0),0) - IFNULL((select sum(bb.qty) from buynow as bb left join projects as pp on bb.project_id = pp.id where pp.auction = 0),0)) as total_avail_vol, DATE_FORMAT(p.date_added, "%m") AS day_month, DATE_FORMAT(p.date_added, "%Y") AS day_year from projects as p where auction = 0 and month(p.date_added) = month(NOW()) and year(p.date_added) = year(NOW()) group by day(p.date_added)';

mysqli['get_ob_pie_data'] = 'select IFNULL(sum(sold) + sum(filled_qty),0) as total_sales,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%flower%" and p.auction = 1) as  total_flowers, (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%flower%"  and cc.name like "%pure sativa%"  and p.auction = 1) as  sativa_flowers, (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%flower%" and cc.name like "%pure indica%"  and p.auction = 1) as  indica_flowers,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%flower%" and cc.name like "%hybrid%"  and p.auction =1) as  hybrid_flowers,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%edible%"  and p.auction = 1) as  total_edibles,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%edible%" and cc.name like "%sweet%"  and p.auction = 1) as  sweet_edibles,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%edible%" and cc.name like "%savory%"  and p.auction = 1) as  savory_edibles,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%edible%" and cc.name like "%beverage%"  and p.auction = 1) as  beverages_edibles,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%"  and p.auction = 1) as  total_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%keif%"  and p.auction = 1) as  keif_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%hash%"  and p.auction = 1) as  hash_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%CO2%"  and p.auction = 1) as  co2oil_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%rosin%"  and p.auction = 1) as  rosin_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%wax%"  and p.auction = 1) as  wax_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%tincture%"  and p.auction = 1) as  tincture_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%shatter%"  and p.auction = 1) as  shatter_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%"  and p.auction = 1) as  total_supplies,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%" and cc.name like "%accessories%"  and p.auction = 1) as  accessories_supplies,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%" and cc.name like "%equipment%"  and p.auction = 1) as  equipment_supplies,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%" and cc.name like "%input%"  and p.auction = 1) as  input_supplies,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%" and cc.name like "%other%"  and p.auction = 1) as  other_supplies from projects where auction = 1';
mysqli['get_db_pie_data'] = 'select IFNULL(sum(sold) + sum(filled_qty),0) as total_sales,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%flower%" and p.auction = 0) as  total_flowers, (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%flower%"  and cc.name like "%pure sativa%"  and p.auction = 0) as  sativa_flowers,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%flower%" and cc.name like "%pure indica%"  and p.auction = 0) as  indica_flowers,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%flower%" and cc.name like "%hybrid%"  and p.auction =1) as  hybrid_flowers,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%edible%"  and p.auction = 0) as  total_edibles,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%edible%" and cc.name like "%sweet%"  and p.auction = 0) as  sweet_edibles,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%edible%" and cc.name like "%savory%"  and p.auction = 0) as  savory_edibles,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%edible%" and cc.name like "%beverage%"  and p.auction = 0) as  beverages_edibles,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%"  and p.auction = 0) as  total_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%keif%"  and p.auction = 0) as  keif_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%hash%"  and p.auction = 0) as  hash_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%CO2%"  and p.auction = 0) as  co2oil_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%rosin%"  and p.auction = 0) as  rosin_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%wax%"  and p.auction = 0) as  wax_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%tincture%"  and p.auction = 0) as  tincture_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%concentrate%" and cc.name like "%shatter%"  and p.auction = 0) as  shatter_concentrates,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%"  and p.auction = 0) as  total_supplies,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%" and cc.name like "%accessories%"  and p.auction = 0) as  accessories_supplies,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%" and cc.name like "%equipment%"  and p.auction = 0) as  equipment_supplies,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%" and cc.name like "%input%"  and p.auction = 0) as  input_supplies,  (select IFNULL(sum(sold) + sum(filled_qty),0) from projects p  left join categories c on p.parent_category_id = c.id  left join categories cc on p.category_id = cc.id  where c.name like "%supplie%" and cc.name like "%other%"  and p.auction = 0) as  other_supplies from projects where auction = 0';
mysqli['get_db_pie_data2'] = 'select avg(qty) as avg_qty, avg(unit_price) as avg_price from projects';
// mysqli['get_admin_mactivity'] = 'SELECT DAYOFWEEK(date_added) as week_day, avg(qty) as avg_qty, avg(unit_price) as avg_price FROM projects p left join categories c on p.parent_category_id = c.id left join categories cc on p.category_id = cc.id WHERE date_added >= (adddate("{{datge}}", INTERVAL 1-DAYOFWEEK("{{datge}}") DAY))  and date_added <= (adddate("{{datge}}", INTERVAL 7-DAYOFWEEK("{{datge}}") DAY)) GROUP BY DATE(date_added)';
// mysqli['get_admin_mactivity'] = 'select day(p.date_added) as day_date, DATE_FORMAT(p.date_added, "%m") AS day_month, DATE_FORMAT(p.date_added, "%b") AS day_month_str, DATE_FORMAT(p.date_added, "%Y") AS day_year,ROUND(avg(p.qty),2) as avg_qty, ROUND(avg(p.unit_price),2) as avg_unit_price, p.qty from projects as p left join categories c on p.category_id = c.id left join categories pc on p.parent_category_id = c.id where month(p.date_added) = month(?) and year(p.date_added) = year(?) and DATE(p.date_added) >= DATE(?) and DATE(p.date_added) <= DATE(?) GROUP BY DATE(date_added)';
mysqli['get_admin_mactivity'] = 'select day(p.date_added) as day_date, DATE_FORMAT(p.date_added, "%m") AS day_month, DATE_FORMAT(p.date_added, "%b") AS day_month_str, DATE_FORMAT(p.date_added, "%Y") AS day_year,ROUND(avg(p.qty),2) as avg_qty, ROUND(avg(p.unit_price),2) as avg_unit_price, p.qty from projects as p left join user_extras ue on p.user_id = ue.user_id left join categories c on p.category_id = c.id left join categories pc on p.parent_category_id = c.id where DATE(p.date_added) >= DATE(?) and DATE(p.date_added) <= DATE(?) {{whr}} GROUP BY DATE(date_added)';

/* Research report here */
mysqli['get_research_report'] = 'select c.name as cat_name, cat.name as parent_cat_name, i.id as i_id, i.amount as i_amount, i.qty as i_qty, p.id as p_id, p.title as p_title, p.qty as p_total_qty, p.unit_price as p_unit_price, p.* from invoices i left join projects p on i.primary_id = p.id left join categories c on p.category_id = c.id left join categories cat on p.parent_category_id = cat.id and c.parent_id = cat.id where i.user_id = ? and i.type = "bought" {{whr}} limit ?, ?';
mysqli['get_research_reportc'] = 'select count(i.id) as total_inv from invoices i left join projects p on i.primary_id = p.id left join categories c on p.category_id = c.id left join categories cat on p.parent_category_id = cat.id and c.parent_id = cat.id where i.user_id = ? and i.type = "bought" {{whr}}';
mysqli['get_research_reportcd'] = 'select c.name as cat_name, cat.name as parent_cat_name, i.id as i_id, i.amount as i_amount, i.qty as i_qty, p.id as p_id, p.title as p_title, p.qty as p_total_qty, p.unit_price as p_unit_price, p.* from invoices i left join projects p on i.primary_id = p.id left join categories c on p.category_id = c.id left join categories cat on p.parent_category_id = cat.id and c.parent_id = cat.id where i.user_id = ? and i.type = "bought" {{whr}}';
mysqli['get_sales_report'] = 'select c.name as cat_name, cat.name as parent_cat_name, i.id as i_id, i.recurring_id, i.amount as i_amount, DATE_FORMAT(i.paid_date,"%m/%d/%Y %H:%i") as paid_date, i.qty as i_qty, p.id as p_id, p.title as p_title, p.qty as p_total_qty, p.unit_price as p_unit_price, p.* from projects p  left join invoices i  on i.primary_id = p.id  join categories c on p.category_id = c.id left join categories cat on c.parent_id = cat.id   where  p.user_id = ? and i.type = "bought" {{whr}} {{where}} limit ?, ?';
/*mysqli['get_sales_report'] = 'select c.name as cat_name, cat.name as parent_cat_name, i.id as i_id, i.amount as i_amount, i.qty as i_qty, p.id as p_id, p.title as p_title, p.qty as p_total_qty, p.unit_price as p_unit_price, p.* from invoices i left join projects p on i.primary_id = p.id left join categories c on p.category_id = c.id left join categories cat on p.parent_category_id = cat.id and c.parent_id = cat.id where i.user_id = ? and p.user_id = ? and i.type = "bought" limit ?, ?';*/
//mysqli['get_sales_reportc'] = 'select count(i.id) as total_inv from invoices i left join projects p on i.primary_id = p.id left join categories c on p.category_id = c.id left join categories cat on p.parent_category_id = cat.id and c.parent_id = cat.id where i.user_id = ? and p.user_id = ? and i.type = "bought" {{where}}';
mysqli['get_sales_reportc'] = 'select count(i.id) as total_inv from projects p  left join invoices i  on i.primary_id = p.id  join categories c on p.category_id = c.id  join categories cat on p.parent_category_id = cat.id and c.parent_id = cat.id  where p.user_id = ? and i.type = "bought" {{where}}';
// mysqli['get_sales_reportcd'] = 'select c.name as cat_name, cat.name as parent_cat_name, i.id as i_id, i.recurring_id, i.amount as i_amount, DATE_FORMAT(i.paid_date,"%d/%m/%Y") as paid_date, i.qty as i_qty, p.id as p_id, p.title as p_title, p.qty as p_total_qty, p.unit_price as p_unit_price, p.* from invoices i left join projects p on i.primary_id = p.id left join categories c on p.category_id = c.id left join categories cat on c.parent_id = cat.id where i.user_id = ? or p.user_id = ? and i.status="paid" and i.type = "bought" {{where}}';
mysqli['get_sales_reportcd'] = 'select c.name as cat_name, cat.name as parent_cat_name, i.id as i_id, i.recurring_id, i.amount as i_amount, DATE_FORMAT(i.paid_date,"%m/%d/%Y") as paid_date, i.qty as i_qty, p.id as p_id, p.title as p_title, p.qty as p_total_qty, p.unit_price as p_unit_price, p.* from invoices i left join projects p on i.primary_id = p.id left join categories c on p.category_id = c.id left join categories cat on c.parent_id = cat.id where p.user_id = ? and i.status="paid" and i.type = "bought" {{where}}';

/* Shipping and delivery module */
// mysqli['update_delivery'] = 'update invoices set delivery_status = ?, delivered_date = ? where id = ?';
// mysqli['update_shipping'] = 'update invoices set shipping_status = ?, shipping_edate = ? where id = ?';
mysqli['update_delivery'] = 'update buynow set delivery_status = ?, delivered_at = ? where id = ?';
mysqli['update_shipping'] = 'update buynow set shipping_status = ?, shipped_at = ? where id = ?';

/* recurring schedule */
mysqli['get_rec_byid'] = 'select rp.frequency, rp.reserve_price, rp.amount as rp_amount, rp.count, rp.quantity as rp_qty, DATE_FORMAT(rp.sdate,"%m/%d/%Y @ %H:%i") as rp_sdate, DATE_FORMAT(rp.edate,"%m/%d/%Y @ %H:%i") as rp_edate, rp.sdate,rp.edate,rp.cancellation, rp.cancelled, rp.paid, rp.active, p.id, p.title, p.user_id as seller_id, p.qty as product_qty, p.bprice, p.sold, p.units from recurring_purchase as rp left join projects as p on p.id = rp.project_id where rp.id =  ?';
mysqli['insert_rec_schedule'] = 'insert into recurring_schedule (amount, recur_purchase_id, user_id, seller_id, qty, product_id, product_title, recurring_at, created_at, position) values {{rec_data}}';
mysqli['get_rec_schedules'] = 'select * from recurring_schedule where recur_purchase_id = ?';
mysqli['count_paid_schedule'] = 'select count(id) as paid_rsch from recurring_schedule where recur_purchase_id = ? and payment_status = "paid"';
mysqli['getrecurre'] = 'select (SELECT count(id) FROM recurring_schedule rs where rs.recur_purchase_id = rp.id and payment_status = "unpaid") as remainingtrs,rp.*, p.user_id as seller_id, p.title from recurring_purchase as rp left join projects as p on rp.project_id = p.id where rp.id = ?';
mysqli['update_reserve_price'] = 'update recurring_purchase set reserve_price = ?, amount = ? where id = ?';
mysqli['update_reserve_price2'] = 'update recurring_purchase set reserve_price = ? where id = ?';
mysqli['change_recur_status'] = 'update recurring_purchase set status = ?, aapprove_at = ? where id = ?';
mysqli['reduce_reserve_amt'] = 'update recurring_purchase set reserve_price = (reserve_price - ?) where id = ?';
mysqli['buyerid_recurring'] = 'select user_id FROM recurring_purchase where id = ?';

/* Admin side recurrings */
/*mysqli['get_recur_list'] = 'select rp.*, p.title, p.qty, p.market_status, p.units from recurring_purchase rp left join projects as p on rp.project_id = p.id {{whr}} order by sapprove_at DESC limit ?, ?';*/
mysqli['get_recur_list'] = 'select rp.*, p.user_id as seller_id, p.title, p.qty, p.market_status, p.units, (select count(id) from recurring_schedule where payment_status = "unpaid" and rp.id = recur_purchase_id) as remaining from recurring_purchase rp inner join recurring_schedule as rs on rs.recur_purchase_id = rp.id left join projects as p on rp.project_id = p.id where rp.user_id != p.user_id  {{whr}} {{whr1}} {{where}} group by rp.id DESC limit ?, ?';
mysqli['get_recur_list_count'] = 'select rp.id, p.user_id as seller_id, (select count(id) from recurring_schedule where payment_status = "unpaid" and rp.id = recur_purchase_id) as remaining from recurring_purchase rp inner join recurring_schedule as rs on rs.recur_purchase_id = rp.id left join projects as p on rp.project_id = p.id where rp.user_id != p.user_id  {{whr}} {{whr1}} {{where}} group by rp.id';

/* recurring payment cronjob */
mysqli['get_unpaid_recurrings']='select (SELECT business_type FROM user_extras WHERE user_id=rp.user_id) AS buyer_business_type, (case when rs.recurring_at = rp.sdate then 1 else 0 end) as first_rec, p.*,pc.name as pc_name, rs.id as rs_id, DATE_FORMAT(rs.recurring_at,"%m/%d/%Y") as recurring_date, rp.cod, rp.id as rp_id, rp.reserve_price as rp_reserve_price, rp.user_id as rp_buyer_id, p.user_id as seller_id, rp.date_added as rp_date_added, rp.count as rp_count, rp.frequency as rp_frequency,  rp.quantity as rp_quantity, rp.sdate as rp_sdate, rp.edate as rp_edate, rp.cancellation as rp_cancellation, rp.cancelled as rp_cancelled, rp.paid as rp_paid, rp.amount as rp_amount  from recurring_purchase as rp left join recurring_schedule rs on rp.id = rs.recur_purchase_id left join projects as p on p.id = rp.project_id left join categories as c on c.id = p.category_id left join categories as pc on pc.id = c.parent_id where rs.buy_started=0 AND rp.paid = 0 and rs.payment_status = "unpaid" and rp.status = "approve" and (rs.recurring_at) <= NOW() and rp.inf_fund_at <= NOW() order by rs.recurring_at asc';

mysqli['get_future_recurrings']='select (case when rs.recurring_at = rp.sdate then 1 else 0 end) as first_rec, p.*,pc.name as pc_name, rs.id as rs_id, DATE_FORMAT(rs.recurring_at,"%m/%d/%Y") as recurring_date , rp.id as rp_id, rp.reserve_price as rp_reserve_price, rp.user_id as rp_buyer_id, p.user_id as seller_id, rp.date_added as rp_date_added, rp.count as rp_count, rp.frequency as rp_frequency,  rp.quantity as rp_quantity, rp.sdate as rp_sdate, rp.edate as rp_edate, rp.cancellation as rp_cancellation, rp.cancelled as rp_cancelled, rp.paid as rp_paid, rp.amount as rp_amount  from recurring_purchase as rp left join recurring_schedule rs on rp.id = rs.recur_purchase_id left join projects as p on p.id = rp.project_id left join categories as c on c.id = p.category_id left join categories as pc on pc.id = c.parent_id where rp.paid = 0 and rs.payment_status = "unpaid" and rp.status = "approve"  and (DATE(rs.recurring_at) > DATE_ADD(CURDATE(), interval 12 hour) and DATE(rs.recurring_at) < DATE_ADD(CURDATE(), INTERVAL 72 hour)) order by rs.recurring_at asc';
mysqli['change_rschpay_status']='update recurring_schedule set payment_status = ? where id = ? and recur_purchase_id = ?';
mysqli['update_inf_fund_at']='update recurring_purchase set inf_fund_at = ? where id = ?';

/* payment module */
mysqli['check_buynow'] = 'select * from buynow where request_id = ? and user_id = ? and project_id = ?';
// mysqli['insert_buynow'] = 'insert into buynow (user_id,project_id,qty,amount,commission_per,accept, request_id, date_added, total_amount, commission, stax_status, stax_per, stax_amt,paid,paid_date,request_userid {{cart_id}}) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?{{cart_id_value}})';
// mysqli['insert_buynow'] = 'insert into buynow (user_id,project_id,qty,amount,commission_per,accept, request_id, date_added, total_amount, commission, stax_status, stax_per, stax_amt,paid,request_userid {{cart_id}}) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?{{cart_id_value}})';
// mysqli['insert_buynow'] = 'insert into buynow (user_id,project_id,qty,amount,commission_per,accept, request_id, date_added, total_amount, commission, stax_status, stax_per, stax_amt,paid,request_userid,negotiable {{cart_id}}) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?{{cart_id_value}})';

/* ===================== start change by divyesh (changes) ===================== */
mysqli['insert_buynow'] = 'insert into buynow (user_id,project_id,qty,amount,commission_per,accept, request_id, date_added, total_amount, commission, stax_status, stax_per, stax_amt, consultant_fee, consultant_fee_amount,excise_markup_per,excise_markup_amt,excise_tax_per,excise_tax_amt,distribution_tax_per,distribution_tax,cultivation_tax,cultivation_tax_per,paid,paid_date,request_userid,negotiable,cod {{cart_id}}) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?{{cart_id_value}})';
/* ===================== end change by divyesh (changes) ===================== */

mysqli['fund_request'] = 'insert into transaction_request (user_id, amount, created_at, wirefund_receipt, wirefund_receipt_img, type) values (?,?,?,?,?, "wire")';
mysqli['wire_fund'] = 'select amount from transaction_request where id=?';
mysqli['check_request'] = 'insert into transaction_request (user_id, amount, created_at, type) values (?,?,?,"check")';
mysqli['refund_request'] = 'insert into transaction_request (user_id, amount, created_at, type) values (?,?,?,"refund")';
mysqli['get_fund_request'] = 'select id, created_at, amount, user_id, type, wirefund_receipt, wirefund_receipt_img, status from transaction_request where id=?';
mysqli['get_fund_requests'] = 'select id, created_at, amount, user_id, wirefund_receipt, wirefund_receipt_img, status, type, reject_msg from transaction_request {{whr}} order by created_at DESC limit ?,?';
mysqli['get_fund_requests_count'] = 'select count(id) as total_requests from transaction_request {{whr}}';
mysqli['get_unverified_count'] = 'select (select count(id) from transaction_request where status = "unverified" and (type = "wire" or type = "check")) as total_unv, (select count(id) from transaction_request where status = "unverified" and type = "refund") as total_unv_refund, (select count(id) from transaction_request where status = "unverified" and type = "check") as total_unv_check, (select count(id) from transaction_request where status = "unverified" and type = "wire") as total_unv_wire, count(id) as total_requests from transaction_request';
mysqli['update_fund_request'] = 'update transaction_request SET status=?, reject_msg=? where id=?';
mysqli['update_buynow_checkout'] = 'update buynow SET cart_id=? where id = ?';
mysqli['update_payrequest'] = 'update transaction_request SET status = ?, amount = ? where id = ?';

/* accept and reject requests */
mysqli['get_all_prodNames'] = 'select title from projects where user_id = ?';
mysqli['accept_request'] = 'update product_requests set accepted = ?, accepted_date = ? where id = ? and product_id = ?';
mysqli['reject_request'] = 'update product_requests set rejected = ?, rejected_date = ?, rejected_msg = ? where id = ? and product_id = ?';
mysqli['reject_requests'] = 'update product_requests set rejected = ?, rejected_date = ? where qty > ? and accepted = 0 and product_id = ?';
mysqli['change_prodstatus'] = 'update projects set filled_qty = ?, rfilled_qty=?, market_status=? {{closed_date}} where id = ?';
// mysqli['get_request_detail'] = 'select * from product_requests where id=? and product_id = ?';
mysqli['get_request_detail'] = 'select pr.*, ue.business_name, ue.business_type from product_requests pr left join user_extras ue on ue.user_id = pr.user_id  where pr.id=? and pr.product_id = ?';
mysqli['get_users_requests'] = 'select *, date_format(created_at,"%m/%d/%Y")as req_date, date_format(accepted_date,"%m/%d/%Y @ %H:%i")as acc_date, date_format(rejected_date,"%m/%d/%Y @ %H:%i")as rej_date from product_requests where product_id=? and user_id = ? order by created_at DESC ';
mysqli['get_business_type'] = 'select business_type, business_name, license_img, business_cert, stax, stax_per, ein_number,license_img,business_cert from user_extras where user_id = ?';
/* getting buyerid from openbid */
mysqli['buyerid'] = 'select user_id FROM product_requests where id = ? and product_id = ?';
/* getting buyer id fro mnegotiation */
mysqli['nego_buyerid'] = 'select user_id FROM negotiable where id = ? and project_id = ?';

/* registration and login */
mysqli['add_contacts'] = 'insert into contacts (fname, lname, phone, email, created_at, del_status, user_id) values {{contactsData}}';
// mysqli['add_bank_details'] = 'update user_extras set name=?, bank_name=?, account_number=?, account_type=?, routing_number=?, address=?, country=?, state=?, city=?, zip=?, updated_at=? where user_id = ?';
mysqli['add_business_details'] = 'insert into user_extras (business_name, business_type, license_img, business_cert, ein_number,permit_expires, ref_code, notification_type, product_offers, sell_offers, stax, stax_per, address, country, state, city, zip, region, state_abbr, created_at, user_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['update_business_details'] = 'update user_extras set business_name = ?, business_type = ?, license_img = ?, business_cert = ?, ein_number = ?,permit_expires = ?, stax=?, stax_per=?, address=?, country=?, state=?, city=?, zip=?, region=?, state_abbr=?,updated_at = ? where user_id = ?';
mysqli['add_business_details_admin'] = 'insert into user_extras (business_name, business_type, license_img, business_cert, ein_number, stax, stax_per, address, country, state, city, zip, region, state_abbr,created_at, user_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['add_buis_name'] = 'insert into user_extras (business_name, license_img, business_cert, ref_code, notification_type, product_offers, sell_offers, user_id, created_at) values (?,?,?,?,?,?,?,?,?)';
mysqli['get_user'] = 'select email, first_name, last_name, phone from users where id=?';
/* ===================== start change by divyesh (changes) ===================== */
mysqli['insert_openbid_products'] = 'insert into projects (pkey,title,metrc_id, description,avatar,image,parent_category_id,category_id,user_id,created_at,sprice,rprice,wprice,date_added,date_closed,status,auction,qty,rfilled_qty, trading_type, cannabis_type, order_type, units, market_status, unit_price, stax, stax_amount, consultant_fee, consultant_fee_amount, country, state, state_abbr,store_prdt,store_prdt_msg,interim_testing_status,interim_testing_status_msg,cert_analysis,cert_analysis_img,default_distributor,additional_service,additional_service_type,cultivation_tax_status,test_result_types,herbee_facility_status,distributor_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['update_openbid_products'] = 'update projects set pkey = ?,title = ?,metrc_id = ?,description = ?,parent_category_id = ?,category_id = ?,created_at = ?,sprice = ?,rprice = ?,wprice = ?,date_added = ?,date_closed = ?,status = ?,auction = ?,qty = ?,rfilled_qty = ?,trading_type = ?,cannabis_type = ?,order_type = ?,units = ?,market_status = ?,unit_price = ?,stax = ?,stax_amount = ?,consultant_fee = ?,consultant_fee_amount = ?, country = ?, state = ?, state_abbr = ?,store_prdt=?,store_prdt_msg=?,interim_testing_status=?,interim_testing_status_msg=?,cert_analysis=?,cert_analysis_img=?,default_distributor=?,additional_service=?,additional_service_type=?,cultivation_tax_status=?,test_result_types=?,herbee_facility_status=? {{image}} where id = ? and user_id = ? limit 1';
/* ===================== end change by divyesh (changes) ===================== */
mysqli['insert_store_products'] = 'insert into projects  (pkey,title,metrc_id,description,avatar,image,category_id,parent_category_id,user_id,created_at,updated_at,date_closed,sprice,rprice,wprice,bprice,date_added,status,buynow,negotiable,qty,cannabis_type,units, market_status, unit_price,stax, stax_amount, consultant_fee, consultant_fee_amount,brand,country, state, state_abbr,store_prdt,store_prdt_msg,interim_testing_status,interim_testing_status_msg,cert_analysis,cert_analysis_img,default_distributor,additional_service,additional_service_type,cultivation_tax_status,test_result_types,herbee_facility_status,cod) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

mysqli['get_openbid_products'] = 'select id, title, description, sprice, qty, filled_qty, rfilled_qty, market_status, user_id, trading_type, order_type, unit_price, units, date_format(created_at,"%m/%d/%Y @ %H:%i")as postedDate, date_format(date_added,"%m/%d/%Y @ %H:%i")as start_date,  DATE_SUB(date_added, INTERVAL 72 hour) as checkAvail, date_added, created_at, updated_at, avatar, image, IFNULL((SELECT image FROM product_extraimages WHERE project_id=p.id ORDER BY id DESC LIMIT 0,1), 0) AS test_result, test_result_types, cannabis_type, IFNULL((select sum(avg_rating)/count(id) from seller_performance where seller_id=user_id),"0") as srating,IFNULL((select ROUND((sum(avg_rating)/count(id) + sum(tpayment)/count(id) )/2) from buyer_performance where buyer_id=user_id), "0") as brating  from projects AS p where (auction =1 OR (buynow = 1 AND (qty != sold))) {{whr}} and user_id !=? and market_status="open" {{search_type}} {{limit}}';

mysqli['count_openbid_products'] = 'select count(id) as productsCount from projects where auction=1 and user_id !=? and market_status = "open" {{whr}}';
mysqli['get_closed_products'] = 'select id, title, description, sprice, qty, filled_qty, rfilled_qty, market_status, user_id, trading_type, order_type, unit_price, units, date_format(created_at,"%m/%d/%Y @ %H:%i")as postedDate, date_format(date_added,"%m/%d/%Y @ %H:%i")as start_date,  DATE_SUB(date_added, INTERVAL 72 hour) as checkAvail, date_added, created_at, updated_at, avatar, image, test_result, cannabis_type from projects where auction =1 and market_status="closed" and user_id =? {{whr}} order by date_closed desc limit ?, ?';
mysqli['count_closed_products'] = 'select count(id) as productsCount from projects where auction =1 and market_status="closed" and user_id =?';
mysqli['get_categories'] = 'select * from categories';
mysqli['add_product_images'] = 'insert into product_images (project_id, image, avatar, date_added) values {{imagesData}}';
mysqli['add_test_results'] = 'insert into product_extraimages (project_id, image, avatar, date_added, type, img_type, user_id) values {{imagesData}}';
mysqli['add_test_result'] = 'update projects set test_result_img = ?, test_result = ?, updated_at = ? where id = ?';
mysqli['get_testr_images'] = 'select * from  product_extraimages where project_id = ?  and type = "image" and img_type="test_results" and del_status = "0"';
mysqli['get_certs'] = 'select * from  product_extraimages where project_id = ?  and type = "image" and img_type="cert_analysis_img" and del_status = "0"';
mysqli['delete_fromextraimgs'] = 'update product_extraimages set del_status = "1" where project_id = ? and user_id=? and id=? and del_status = "0"';

/* update or add business details under profile settings */
mysqli['update_user_details'] = 'update user_extras set address=?, country=?, state=?, city=?, zip=?, region=?, state_abbr=?, updated_at=? where user_id = ?';
// mysqli['add_business_details_user'] = 'insert into user_extras (business_name, business_type, license_img, business_cert, ein_number, stax, stax_per, address, country, state, city, zip, region, state_abbr,created_at, user_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
/* product requests module */
mysqli['user_id'] = 'select user_id from projects where id = ?';
mysqli['insert_product_request'] = 'insert into product_requests (product_id, user_id, qty, amount, unit_price, units, trading_type, created_at, behalf_cc_id, behalf_documents) values (?,?,?,?,?,?,?,?,?,?)';
mysqli['add_test_result2'] = 'update product_requests set test_result_img = ?, test_result = ?, updated_at = ? where id = ?';

/*usr dashboard - getting buyers products details*/
mysqli['get_ob_products'] = 'select (select count(id) from product_requests where p.id = product_id) as total_requests, (select count(id) from product_requests where p.id = product_id and accepted = 1 and rejected = 0) as accepted_requests, (select count(id) from product_requests where p.id = product_id  and rejected = 1 and accepted = 0) as rejected_requests,p.*, date_format(p.date_added,"%m/%d/%Y @ %H:%i")as start_date,  DATE_SUB(p.date_added, INTERVAL 72 hour) as checkAvail from projects as p where p.auction = 1 and p.user_id = ? and market_status = "open" {{whr}} order by p.created_at DESC limit ?,?';
mysqli['count_ob_products'] = 'select count(id) as productsCount from projects where auction = 1 and user_id = ? and market_status = "open" ';

/* Getting all accepted requests - buy and sell products */
mysqli['get_requests'] = 'select IFNULL((select ROUND((sum(avg_rating)/count(id) + sum(tpayment)/count(id) )/2) from buyer_performance where buyer_id=pr.user_id), 0) as buyer_rating, IFNULL((select ROUND(sum(avg_rating)/count(id)) from seller_performance where seller_id = p.user_id),0) as seller_rating, ue.stax as ue_stax, ue.stax_per as ue_stax_per, pr.id as req_id, p.*, pr.user_id as req_user_id, pr.qty as req_qty, date_format(pr.created_at,"%m/%d/%Y @ %H:%i") as req_date, pr.amount as req_amount, pr.unit_price as req_unit_price, pr.accepted as req_accepted, pr.`status` as req_status, pr.awarded as req_awarded, pr.awarded_date as req_awarded_date, pr.accepted_date as req_accepted_date, pr.test_result as req_test_result from product_requests as pr left join projects as p on p.id = pr.product_id left join user_extras as ue on ue.user_id = pr.user_id where p.user_id=? and p.auction = 1 and p.qty > p.filled_qty and pr.accepted = 0 and pr.rejected = 0 {{whr}} group by pr.id order by pr.created_at DESC limit ?, ?';
mysqli['count_requests'] = 'select count(pr.id) as req_count from product_requests as pr left join projects as p on p.id = pr.product_id where p.user_id=? and p.auction = 1 and p.qty > p.filled_qty  and pr.accepted = 0 and pr.rejected = 0 {{whr}}';

mysqli['get_my_requests'] = 'select IFNULL((select ROUND(sum(avg_rating)/count(id)) from seller_performance where seller_id = p.user_id),0) as seller_rating, ue.stax as ue_stax, ue.stax_per as ue_stax_per, pr.id as req_id, p.*, pr.user_id as req_user_id, pr.qty as req_qty, date_format(pr.created_at,"%m/%d/%Y @ %H:%i") as req_date, pr.amount as req_amount, pr.unit_price as req_unit_price, pr.accepted as req_accepted,pr.rejected as req_rejected, pr.rejected_msg as req_rejected_msg, pr.`status` as req_status, pr.awarded as req_awarded, pr.awarded_date as req_awarded_date, pr.accepted_date as req_accepted_date , pr.rejected_date as req_rejected_date, pr.test_result as req_test_result from product_requests as pr left join projects as p on p.id = pr.product_id left join user_extras as ue on ue.user_id = pr.user_id where pr.user_id=? and p.auction = 1 {{whr}} group by pr.id order by pr.created_at DESC limit ?, ?';
mysqli['count_my_requests'] = 'select count(pr.id) as req_count from product_requests as pr left join projects as p on p.id = pr.product_id where pr.user_id=? and p.auction = 1 {{whr}}';

/* Getting all accepted requests - buy and sell products  along with bidders requests*/
// mysqli['get_conf_offers'] = 'select  bn.user_id as seller_id,bn.request_userid as buyer_id, i.paid_date as i_paid_date, DATE_ADD(i.paid_date, INTERVAL 72 hour) as i_timer, i.id as i_id, i.shipping_status as i_shipping_status, i.delivery_status as i_delivery_status,bn.id as buynow_id, bn.paid as paid_status, ue.stax as ue_stax, ue.stax_per as ue_stax_per, pr.id as req_id, p.*, p.trading_type as p_trading_type, pr.user_id as req_user_id, pr.qty as req_qty, date_format(pr.created_at,"%m/%d/%Y @ %H:%i") as req_date, pr.amount as req_amount, pr.unit_price as req_unit_price, pr.accepted as req_accepted, pr.`status` as req_status, pr.awarded as req_awarded, pr.awarded_date as req_awarded_date,  date_format(pr.accepted_date,"%m/%d/%Y @ %H:%i") as req_accepted_date  from product_requests as pr left join projects as p on p.id = pr.product_id left join user_extras as ue on ue.user_id = pr.user_id left join buynow as bn on bn.request_id = pr.id left join invoices as i on i.buynow_id = bn.id left join checkout as ck on ck.id = i.cart_id where ((p.user_id = ? and p.trading_type="{{ptrading_type}}") or (pr.user_id = ? and pr.trading_type="{{prtrading_type}}")) {{productid}}  and p.auction = 1 and (pr.accepted =1 and pr.rejected=0) {{whr}} group by pr.id order by pr.accepted_date DESC limit ?, ?';
mysqli['get_conf_offers'] = 'select IFNULL((select ROUND(sum(avg_rating)/count(id)) from seller_performance where seller_id = p.user_id),0) as seller_rating, bn.user_id as seller_id,bn.request_userid as buyer_id, i.paid_date as i_paid_date, DATE_ADD(i.paid_date, INTERVAL 72 hour) as i_timer, i.id as i_id, bn.shipping_status as i_shipping_status, bn.order_status, bn.delivery_status as i_delivery_status, DATE_ADD(bn.shipped_at, INTERVAL 72 hour) as bn_del_timer, DATE_ADD(bn.date_added, INTERVAL 72 hour) as confirmed_timer, bn.id as buynow_id, bn.paid as paid_status, ue.stax as ue_stax, ue.stax_per as ue_stax_per, pr.id as req_id, p.*, p.trading_type as p_trading_type, pr.user_id as req_user_id, pr.qty as req_qty, date_format(pr.created_at,"%m/%d/%Y @ %H:%i") as req_date, pr.amount as req_amount, pr.unit_price as req_unit_price, pr.accepted as req_accepted, pr.`status` as req_status, pr.awarded as req_awarded, pr.awarded_date as req_awarded_date,  date_format(pr.accepted_date,"%m/%d/%Y @ %H:%i") as req_accepted_date, pr.behalf_cc_id  from product_requests as pr left join projects as p on p.id = pr.product_id left join user_extras as ue on ue.user_id = pr.user_id left join buynow as bn on bn.request_id = pr.id left join invoices as i on i.buynow_id = bn.id left join checkout as ck on ck.id = i.cart_id where ((p.user_id = ? and p.trading_type="{{ptrading_type}}") or (pr.user_id = ? and pr.trading_type="{{prtrading_type}}")) {{productid}}  and p.auction = 1 and (pr.accepted =1 and pr.rejected=0) {{whr}} group by pr.id order by pr.accepted_date DESC limit ?, ?';
mysqli['count_conf_offers'] = 'select count(pr.id) as req_count from product_requests as pr left join projects as p on p.id = pr.product_id where ((p.user_id = ? and p.trading_type="{{ptrading_type}}") or (pr.user_id = ? and pr.trading_type="{{prtrading_type}}")) {{productid}} {{whr}} and p.auction = 1 and (pr.accepted =1 and pr.rejected=0)';

mysqli['get_rejected_offers'] = 'select IFNULL((select ROUND(sum(avg_rating)/count(id)) from seller_performance where seller_id = p.user_id),0) as seller_rating, ue.stax as ue_stax, ue.stax_per as ue_stax_per, pr.id as req_id, p.*, p.trading_type as p_trading_type, pr.user_id as req_user_id, pr.rejected_msg as rej_msg, pr.qty as req_qty, date_format(pr.created_at,"%m/%d/%Y @ %H:%i") as req_date, pr.amount as req_amount, pr.unit_price as req_unit_price, pr.rejected as req_rejected, pr.`status` as req_status, pr.awarded as req_awarded, pr.awarded_date as req_awarded_date,  date_format(pr.rejected_date,"%m/%d/%Y @ %H:%i") as req_rejected_date  from product_requests as pr left join projects as p on p.id = pr.product_id  left join user_extras as ue on ue.user_id = pr.user_id where ((p.user_id = ? and p.trading_type="{{ptrading_type}}") or (pr.user_id = ? and pr.trading_type="{{prtrading_type}}")) {{productid}}  and p.auction = 1 and (pr.rejected=1 and pr.accepted =0) {{whr}} group by pr.id order by pr.rejected_date DESC limit ?, ?';
mysqli['count_rejected_offers'] = 'select count(pr.id) as req_count from product_requests as pr left join projects as p on p.id = pr.product_id where ((p.user_id = ? and p.trading_type="{{ptrading_type}}") or (pr.user_id = ? and pr.trading_type="{{prtrading_type}}")) {{productid}}  and p.auction = 1 and (pr.rejected=1 and pr.accepted =0) {{whr}}';

/* getting all billing details - profile_settings/billing page */
mysqli['get_billing_details'] = 'select id, user_id, bank_name, routing_number, name, account_number,account_type from user_extras where user_id = ?';

/* insert bank details */
mysqli['insert_bank_details'] = 'insert into user_extras (user_id,name,bank_name,routing_number,account_number) values (?,?,?,?,?)';
/* update bank details */
mysqli['update_bank_details'] = 'update user_extras set name = ?,bank_name = ?,account_number = ?,routing_number=? where user_id = ?';
//end

/* user profile stax settings */
mysqli['get_stax_details'] = 'select stax, stax_per, business_type from user_extras where user_id = ?';
mysqli['update_stax_details'] = 'update user_extras set stax = ?,stax_per = ? where user_id = ?';
/* end */

mysqli['cntbid'] = ',(select count(distinct bid.user_id) as bid from bids as bid where bid.project_id = p.id and bid.declined = 0) as bids';
mysqli['check_username'] = 'select * from users where nick_name = ?';

mysqli[0]  = 'select email,id,password_salt,password_hash,first_name,last_name,admin,status,zip,country,phone,used_image_space from users where email = "{{username}}" Limit 1';
mysqli[1] = 'select p.*'+mysqli['cntbid']+' from projects as p inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt   and date_added <= "{{datge}}" and date_closed >= "{{datge}}" and market_status = "open" group by p.id order by p.id desc';
mysqli[2] = 'select p.*'+mysqli['cntbid']+' from projects as p inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt   and date_added <= "{{datge}}" and date_closed >= "{{datge}}" and market_status = "open" and p.feature = 1 group by p.id order by p.id desc';
mysqli[3] = 'select *'+mysqli['cntbid']+' from projects  where date_added >= "{{datge}}" and feature = 1 and market_status = "open"  order by id desc LIMIT 10';
mysqli[4] = 'select *'+mysqli['cntbid']+' from projects  where date_closed <= "{{datge}}" and market_status != "removed" order by id desc limit 10';
mysqli[5] = 'select c.id,c.name,c.parent_id,c.lft,c.rgt, (COUNT(parent.id) - 1),c.ob_market, c.db_market AS depth, c.db_market from categories as c, categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt  group by c.id   order by c.lft asc';
mysqli[6] = 'select p.*'+mysqli['cntbid']+',c.name from projects AS p  where date_added <= "{{datge}}" and date_closed >= "{{datge}}" and buynow = 1 and market_status = "open"';
mysqli[7] = 'select SUBSTRING(CONCAT(u.first_name," ",SUBSTRING(u.last_name,1,1)),1,20) AS uname,CASE WHEN p.auction =0 THEN p.bprice ELSE p.wprice END AS sea_price,p.*'+mysqli['cntbid']+',c.name from projects AS p inner join users as u on u.id = p.user_id inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt and date_added <= "{{datge}}" and market_status = "open" and date_closed >= "{{datge}}"   {{cid}}  {{search}} {{where}} group by p.id order by p.id desc {{limit}}';
mysqli[8] = 'select p.*'+mysqli['cntbid']+',c.name from projects AS p inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt and date_added >= "{{datge}}" and market_status = "open"  {{cid}}  {{search}} group by p.id order by p.id desc';
mysqli[9] = 'select p.*'+mysqli['cntbid']+',c.name from projects AS p inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt  and date_closed <= "{{datge}}" and market_status != "removed"  {{cid}}  {{search}} group by p.id order by p.id desc ';
mysqli[10] = 'select p.*'+mysqli['cntbid']+',c.name from projects AS p inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt  and date_added <= "{{datge}}" and market_status = "open" and date_closed >= "{{datge}}" {{cid}}    {{search}} and buynow = 1';
mysqli[11] = 'insert into users (first_name, last_name, email,role,password_hash,password_salt,created_at,balance,status,nick_name, phone,username) values ("{{first_name}}","","{{email}}","{{role}}","{{password_hash}}","{{password_salt}}","{{created_at}}",0,"unverified","{{nick_name}}", "{{phone}}","{{username}}")';
// mysqli[11] = 'insert into users (email,role,first_name,last_name,password_hash,password_salt,created_at,balance,status,country,state,nick_name) values ("{{email}}","{{role}}",?,?,"{{password_hash}}","{{password_salt}}","{{created_at}}",0,"unverified","{{country}}","{{state}}","{{nick_name}}")';
mysqli[12] = 'select id,email,first_name,last_name from users  where email = "{{email}}" order by id desc';
mysqli['cid'] = ' and p.category_id IN (select c.id from categories as s WHERE c.lft between s.lft and s.rgt and s.id IN ({{cid}}))';
mysqli['search'] = ' and (p.title like "%{{search}}%" or p.description like "%{{search}}%"  or p.tags like "%{{search}}%") ' ;
mysqli['title'] = ' and p.title like "%{{search}}%"';
mysqli['avatar'] = ' and avatar IS NOT NULL';
mysqli['noshipping'] = ' and shipping_price = 0 ';
mysqli['pid'] = ' and p.id = {{pid}}';
mysqli[13] = 'select SUBSTRING(CONCAT(u.first_name," ",SUBSTRING(u.last_name,1,1)),1,20) AS uname,CASE WHEN p.auction =0 THEN p.bprice ELSE p.wprice END AS sea_price,p.*'+mysqli['cntbid']+' from projects AS p inner join users as u on u.id = p.user_id  inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt and p.id > 0 {{cid}}  {{search}} {{where}} group by p.id order by {{order}}';
mysqli[14] = 'insert into projects  (title,description,avatar,image,category_id,tags,user_id,shipping_price,shipping_description,created_at,updated_at,buynow,feature,sprice,rprice,date_added,date_closed,status,bprice,mprice,iprice,wprice,auction,is_same_location,document,work_loc,qty,paypal_address,duration,duration_type,`time`,time_level,future,market_status,country,state,city,sell_location,is_digital,vauction,parent_category_id,weight,width,height,store_prdt,store_prdt_msg,interim_testing_status,interim_testing_status_msg,cert_analysis,cert_analysis_img,default_distributor,additional_service,additional_service_type) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
// mysqli[15] = 'select p.*,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0 AND b.declined = 0) as bids from projects AS p where p.user_id = ? and p.market_status !="removed" {{where}} order by updated_at desc limit ?,?';
mysqli[15] = 'select p.*,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0 AND b.declined = 0) as bids from projects AS p where p.user_id = ? and p.market_status ="open" {{where}} order by updated_at desc limit ?,?';
// mysqli['search15'] = 'select p.*,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0 AND b.declined = 0) as bids from projects AS p where p.user_id = ? and p.market_status !="removed" {{where}} order by updated_at desc';
mysqli['search15'] = 'select p.*,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0 AND b.declined = 0) as bids from projects AS p where p.user_id = ? and p.market_status ="open" {{where}} order by updated_at desc';
mysqli[16] = 'select *'+mysqli['cntbid']+' from projects where date_added <= "{{datge}}" and date_closed >= "{{datge}}" and market_status = "open" order by id desc';
mysqli[17] = 'select *'+mysqli['cntbid']+' from projects  where date_added >= "{{datge}}"  order by id desc';
mysqli[18] = 'select user_id ,id,title from projects where user_id = ?  {{where}} order by id desc';
// mysqli[19] = 'select p.*,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id and b.declined = 0) as bids,date_format(p.date_added,"%m/%d/%Y") as date_add,date_format(p.date_closed,"%m/%d/%Y") as date_close,u.first_name,u.email,u.phone,u.last_name,u.nick_name,c.name,u.review,u.avatar as uimage from projects as p left join categories as c on c.id = p.category_id left join users as u on u.id = p.user_id where p.id = ? limit 1';
// mysqli[19] = 'select p.*,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id and b.declined = 0) as bids,date_format(p.date_added,"%m/%d/%Y @ %H:%i") as date_add,date_format(p.date_closed,"%m/%d/%Y @ %H:%i") as date_close, c.name from projects as p left join categories as c on c.id = p.category_id where p.id = ? limit 1'
mysqli[19] = 'select p.*,(select count(distinct pr.user_id) as bidder from product_requests as pr where p.id = pr.product_id) as bidders, (select count(distinct pr.id) as bid from product_requests as pr where p.id = pr.product_id) as bids,date_format(p.date_added,"%m/%d/%Y @ %H:%i") as date_add,date_format(p.date_closed,"%m/%d/%Y @ %H:%i") as date_close, c.name from projects as p left join categories as c on c.id = p.category_id where p.id = ? limit 1'
// mysqli[19] = 'select p.*,date_format(p.date_added,"%m/%d/%Y") as date_add,date_format(p.date_closed,"%m/%d/%Y") as date_close from projects as p left join categories as c on c.id = p.category_id where p.id = ? limit 1';
mysqli[20] = 'insert into bids  (project_id,user_id,created_at,proposed_amount) values (?,?,?,?)';
mysqli[2033] = 'insert into negotiable  (project_id,user_id,created_at,proposed_amount,qty_request) values (?,?,?,?,?)';
mysqli['checkbidplace'] = 'select * from negotiable where user_id = ? and project_id = ?';
mysqli[21] = 'update projects set wprice = ? where id =  ? limit 1';
mysqli[22] = 'select user_id,proposed_amount from bids where project_id =  ? and user_id = ? and declined = 0 ORDER BY proposed_amount DESC limit 1';
mysqli[23] = 'update bids set proposed_amount = ? where project_id =  ? and user_id = ? limit 1';
// mysqli[24] = 'select b.user_id,CONCAT(u.first_name," ",u.last_name) AS name,u.nick_name,u.email,b.proposed_amount,u.state,date_format(b.created_at,"%m/%d/%Y %H:%i:%s %p") as date_add from bids AS b inner join users as u on u.id = b.user_id where b.project_id =  ? and b.declined = 0 order by proposed_amount desc limit 100';
mysqli[24] = 'select b.user_id, b.proposed_amount,date_format(b.created_at,"%m/%d/%Y %H:%i:%s %p") as date_add from bids AS b where b.project_id =  ? and b.declined = 0 order by proposed_amount desc limit 100';
mysqli[25] = 'select ?? from users where id = ? Limit 1';
mysqli[26] = 'select * from packages';
mysqli[27] = 'update users set customerid = ?, paymentid = ?, paymethod = ? where id =  ? limit 1';
mysqli[28] = 'update users set balance = balance+? where id =  ? limit 1';
mysqli[29] = 'select * from packages where id =  ? limit 1';
mysqli[30] = 'update users set balance = balance-? where id =  ? limit 1';

// mysqli[31] = 'INSERT INTO invoices (id, transactionid, gateway, date_added, user_id, primary_id, type, description, amount,status,istatus) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
mysqli['31_new'] = 'INSERT INTO invoices (gateway, date_added, user_id, primary_id, type, description, amount,status,istatus, buynow_id, cart_id, recurring_id, rec_cancellation, rec_cancelseller_per, rec_cancelseller_amt, rec_canceladmin_per, rec_canceladmin_amt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
mysqli[31] = 'INSERT INTO invoices (gateway, date_added, user_id, primary_id, type, description, amount,status,istatus, buynow_id, cart_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';

mysqli[32] = 'select b.id,b.proposed_amount,b.user_id,u.first_name,u.email,u.phone,u.last_name,b.project_id from bids as b inner join users as u on u.id = b.user_id where b.project_id = ? and b.declined = 0 order by b.proposed_amount desc limit 1';
mysqli[34] = 'update projects set market_status = ? where id =  ? and market_status = "open" limit 1';
mysqli['soldStatus'] = 'update projects set market_status = "sold" where  qty = sold and market_status = "open"';
// mysqli[33] = 'select count(distinct b.user_id) as bid from bids AS b inner join users as u on u.id = b.user_id where b.project_id =  ? and b.declined = 0 order by proposed_amount desc';
mysqli[33] = 'select count(distinct b.user_id) as bid from bids AS b inner join users as u on u.id = b.user_id where b.project_id =  ? and b.declined = 0 order by proposed_amount desc';

mysqli[35] = 'update bids set awarded = 1,awarded_date = ? where id =  ? and awarded = 0 and declined = 0 limit 1';
mysqli[36] = 'select p.*,b.user_id,SUBSTRING(CONCAT(u.first_name," ",u.last_name),1,20) AS name,u.state,u.country,u.avatar AS uavatar,b.proposed_amount from bids AS b inner join users as u on u.id = b.user_id and b.awarded = 1 inner join projects as p on p.id = b.project_id order by p.date_closed desc';
mysqli[37] = 'select p.title,p.description,b.user_id,p.is_digital,b.proposed_amount,date_format(b.awarded_date,"%m/%d/%Y") as adate,b.awarded,p.status,p.avatar,p.date_closed,p.id,(select count(bp.id) as id from bids AS bp where bp.user_id = b.user_id and bp.project_id = p.id) as bids from bids AS b inner join projects as p on p.id = b.project_id and b.user_id = ? {{where}}  group by p.id order by b.id desc {{limit}}';
mysqli['searchactivebids'] = 'select p.title,p.description,b.user_id,p.is_digital,b.proposed_amount,date_format(b.awarded_date,"%m/%d/%Y") as adate,b.awarded,p.status,p.avatar,p.date_closed,p.id,(select count(bp.id) as id from bids AS bp where bp.user_id = b.user_id and bp.project_id = p.id) as bids from bids AS b inner join projects as p on p.id = b.project_id and b.user_id = ? {{where}}  group by p.id order by b.id desc';
mysqli[38] = 'select p.id  from bids AS b inner join projects as p on p.id = b.project_id and b.user_id = ?  {{where}} group by p.id order by b.id desc';
mysqli[39] = 'select p.title,p.id,b.user_id,b.proposed_amount,p.status,p.avatar,p.date_closed,(select count(bp.id) as id from bids AS bp where bp.user_id = b.user_id and bp.project_id = p.id) as bids,b.id as b_id from bids AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.awarded = 1 order by b.id desc limit ?, 10';
mysqli[40] = 'select p.id  from bids AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.awarded = 1 order by b.id desc';
mysqli[41] = 'select * from invoices where user_id = ? order by id desc limit ?, 10';
mysqli[42] = 'select id from invoices where user_id = ? order by id desc';
mysqli[43] = 'select id from invoices where id = ? order by id desc';
mysqli[44] = 'update users set reserve_amount = reserve_amount+? where id = ? limit 1';
mysqli[47] = 'update users set reserve_amount = reserve_amount-? where id = ? limit 1';
mysqli[45] = 'insert into bids  (project_id,user_id,created_at,proposed_amount,reserved,reserved_date) values (?,?,?,?,1,?)';
mysqli[46] = 'select user_id,proposed_amount AS amt,id from bids where project_id =  ? order by proposed_amount desc limit 1';
mysqli[48] = 'update users set reserve_amount = reserve_amount-?,balance=balance-? where id = ? limit 1';
mysqli[49] = 'select id from watchlists where user_id = ? and project_id = ? limit 1';
mysqli[50] = 'INSERT INTO watchlists (id,project_id,user_id,date_added) VALUES (NULL, ?, ?, ?)';
mysqli[51] = 'select p.title,b.user_id,p.status,p.avatar,p.date_closed,p.id from watchlists AS b inner join projects as p on p.id = b.project_id and b.user_id = ? order by b.id desc limit ?, 10';
mysqli[52] = 'select p.id  from watchlists AS b inner join projects as p on p.id = b.project_id and b.user_id = ? order by b.id desc';
mysqli[53] = 'delete from watchlists where project_id = ? and user_id = ? limit 1';
mysqli[54] = 'update users set email = ?, first_name = ?, last_name = ?,nick_name = ?,aboutme = ?,avatar = ?,  image = ?, address1 = ?, address2 = ?, country    = ?, state = ?, city = ?, zip = ?, phone = ?,profile_url =?,paypal_address = ?  where id =  ? limit 1';
mysqli['newphone'] = 'update users set email = ?, first_name = ?, last_name = ?,nick_name = ?,aboutme = ?,avatar = ?,  image = ?, address1 = ?, address2 = ?, country    = ?, state = ?, city = ?, zip = ?, phone = ?,profile_url =?,paypal_address = ?,verifyphone = 0  where id =  ? limit 1';
mysqli[55]  = 'select ?? from projects where id = ? Limit 1';
mysqli[56] = 'update projects set market_status = "removed", status = 0 where id =  ?  limit 1';
mysqli['product_delete_multiple'] = 'update projects set market_status = "removed", status = 0 where id in (?)';
mysqli[57] = 'update users set password_hash = ?, password_salt = ? where email = ?  limit 1';
mysqli[58] = 'select transactionid from invoices where transactionid = ? limit 1';

/* Ads */
mysqli['products_data'] = 'select sum(sold) as total_revenue from adwords';
mysqli['ads_data'] = 'select sum(DATEDIFF(end_date, start_day) * budget_per_day) as total_revenue, sum(if(status = "active",1,0)) as active_camp, sum(if(status = "remove" or status = "pause",1,0)) as inactive_camp, sum(no_of_clicks) as total_clicks from adwords where (created_at <= SYSDATE( ) and created_at >= DATE_SUB( SYSDATE( ) , INTERVAL 2 DAY ))';
mysqli['total_ads_campaigns'] = 'select sum(if(status = "active",1,0)) as active_camp, sum(if(status = "remove" or status = "pause",1,0)) as inactive_camp from adwords';
mysqli['all_payments_data'] = 'select sum(if(type != "refund", amount, 0)) as funds from transaction_request';
// mysqli['all_taxes_data'] = 'select cast(sum(distribution_tax) as CHAR) as total_distribution_tax, CAST(sum(excise_tax_amt) as CHAR) as total_exise_tax, CAST(sum(cultivation_tax) as CHAR) as total_cultivation_tax from buynow where seller_paid_status = 1 and admin_paid_status = 1';
mysqli['all_taxes_data'] = 'select cast(sum(distribution_tax) as CHAR) as total_distribution_tax, CAST(sum(excise_tax_amt) as CHAR) as total_exise_tax, CAST(sum(cultivation_tax) as CHAR) as total_cultivation_tax from buynow where paid > 0';
mysqli['transact_data'] = 'SELECT sold_amount.*,membership_amount.*, refund_req_amount.* FROM (SELECT IFNULL(sum( amount ),0) as sold_amount FROM invoices WHERE type IN ("bought") and status="paid" and paid_date >= DATE_SUB( SYSDATE() , INTERVAL 2 DAY )) as sold_amount, (SELECT IFNULL(sum( amount ),0) as membership_amount FROM invoices WHERE type IN ("membership") and paid_date >= DATE_SUB( SYSDATE() , INTERVAL 2 DAY )) as membership_amount, (SELECT IFNULL(sum( amount ),0) as refund_req_amount FROM invoices WHERE type IN ("refund_request") and paid_date >= DATE_SUB( SYSDATE() , INTERVAL 2 DAY )) as refund_req_amount';
mysqli['total_reviews'] = 'SELECT count(id) as total_reviews from hmb_feedback';
mysqli['relationships'] = 'SELECT ifnull(count(id),0) as total_msgs, ifnull(sum(cost), 0) as total_revenue from pmb_pool where date_added >= DATE_SUB( SYSDATE() , INTERVAL 2 DAY )';

/* Admincp dashboard queries */
mysqli['products_offered'] = 'select IFNULL(count(p.id),0) as products_offered FROM projects as p left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join user_extras as ue on ue.user_id = p.user_id  where p.id > 0 and p.market_status != "removed"  and p.date_added <= DATE_ADD(SYSDATE(), INTERVAL 3 DAY) and p.date_closed >= SYSDATE() and p.market_status = "open"'
mysqli['products_delivered']='select IFNULL(count(p.id),0) as products_delivered FROM projects as p left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join user_extras as ue on ue.user_id = p.user_id  left join buynow as b on b.project_id = p.id  where p.id > 0 and p.market_status != "removed"  and b.shipping_status = "1" and b.delivery_status = "0"'
mysqli['products_sold']='select IFNULL(count(p.id),0) as products_sold FROM projects as p left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join user_extras as ue on ue.user_id = p.user_id  left join buynow as b on b.project_id = p.id  where p.id > 0 and p.market_status != "removed"  and b.paid = 1 and b.shipping_status = "1" and b.delivery_status = "1" '
mysqli['products_future']='select IFNULL(count(p.id),0) as products_future FROM projects as p left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join user_extras as ue on ue.user_id = p.user_id  where p.id > 0 and p.market_status != "removed"  and p.date_added > DATE_ADD(SYSDATE(), INTERVAL 3 DAY) and  p.date_closed > SYSDATE()'
// mysqli[59] = 'select sum(if(date_added <= ? and  date_closed >= ? and market_status = "open",1,0)) as open, sum(if(date_added <= ? and date_closed <= ? and market_status = "closed",1,0)) as closed, sum(if(date_added >= ? and  date_closed >= ?,1,0)) as future, sum(if(market_status = "sold",1,0)) as sold from projects';
mysqli[59] = 'select sum(if(date_added <= curdate() and market_status = "open",1,0)) as open, sum(if(date_closed <= curdate() and (market_status = "closed" or market_status = "sold"),1,0)) as closed, sum(if(date_added >= DATE_ADD(curdate(), INTERVAL 72 hour),1,0)) as future, sum(if(market_status = "sold",1,0)) as sold from projects';
// mysqli[340] = 'SELECT sold.*,bid.*,buynow.*,winner.* FROM (SELECT COUNT( id ) as sold FROM invoices WHERE type IN ("sold",  "winner") and status="paid") as sold,(SELECT COUNT( id ) as bid FROM invoices WHERE type IN ("winner") ) as bid,(SELECT COUNT( id ) as winner FROM invoices WHERE type IN ("winner") and status = "paid" ) as winner ,(SELECT COUNT( id ) as buynow FROM invoices WHERE type IN ("sold") ) as buynow';
//Getting  lst 48 hours date here
//SELECT sold.*,bid.*,buynow.*,winner.* from (SELECT COUNT( b.id ) as recurring FROM buynow b left join projects p on b.project_id = p.id WHERE p.auction = 0 and b.recurring = "1" and paid_date >= DATE_SUB(SYSDATE(), interval 48 hour)) as sold,(SELECT COUNT( b.id ) as bid FROM buynow b left join projects p on b.project_id = p.id WHERE p.auction = 1 and paid_date >= DATE_SUB(SYSDATE(), interval 48 hour)) as bid,(SELECT COUNT( b.id ) as buy FROM buynow b left join projects p on b.project_id = p.id WHERE p.auction = 0 and paid_date >= DATE_SUB(SYSDATE(), interval 48 hour)) as buynow,(SELECT COUNT( b.id ) as winner FROM buynow b left join projects p on b.project_id = p.id WHERE p.auction = 0 and b.recurring = "1" and paid_date >= DATE_SUB(SYSDATE(), interval 48 hour)) as winner
mysqli[340] = 'SELECT sold.*,bid.*,buynow.*,winner.* from (SELECT COUNT( b.id ) as recurring FROM buynow b left join projects p on b.project_id = p.id WHERE p.auction = 0 and b.recurring = "1") as sold,(SELECT COUNT( b.id ) as bid FROM buynow b left join projects p on b.project_id = p.id WHERE p.auction = 1) as bid,(SELECT COUNT( b.id ) as buy FROM buynow b left join projects p on b.project_id = p.id WHERE p.auction = 0) as buynow,(SELECT COUNT( b.id ) as winner FROM buynow b left join projects p on b.project_id = p.id WHERE p.auction = 0 and b.recurring = "1") as winner';

mysqli[60] = 'select sum(if(status = "active",1,0)) as active, sum(if(status = "unverified",1,0)) as unverified, sum(if(status = "moderate",1,0)) as moderate, sum(if(status = "deactivate" or status = "unsubscribe",1,0)) as cancel  from users';
mysqli[61] = 'select sum(if(type = "package",1,0)) as package,sum(if(type = "winner",1,0)) as winner,sum(if(type = "bid",1,0)) as bid,sum(if(type = "sold",1,0)) as sold from invoices';
mysqli[62] = 'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users where status = ? order by id DESC limit ?, 10 ';
mysqli[63] = 'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users where (status = ? or status = ?) order by id DESC limit ?, 10';
mysqli[64] = 'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users order by id DESC limit ?, 10';
mysqli[65] = 'select id from users where status = ?';
mysqli[66] = 'select id from users where (status = ? or status = ?)';
mysqli[67] = 'select id from users';
mysqli[68] = 'update bids set reserve = 0  where id = ? limit 1';

mysqli[69] = 'update users set status = ?  where id = ? limit 1';
mysqli[70] = 'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users where email like "%{{email}}%" and last_name like "%{{last_name}}%" and status like "%{{status}}%" and first_name like "%{{first_name}}%" order by id DESC limit ?, 10';
mysqli[71] = 'select email,first_name,last_name,balance,status,date_format(created_at,"%d %M, %Y") as cdate,id from users where email like "%{{email}}%" and last_name like "%{{last_name}}%" and status like "%{{status}}%" and first_name like "%{{first_name}}%" order by id DESC';
mysqli[72] = 'update projects  set title = ?,description = ?,avatar = ?,image = ?,category_id = ?,tags = ?,shipping_price = ?,shipping_description = ?,buynow = ?,feature = ?,sprice = ?,rprice = ?,bprice = ?,mprice = ?,auction = ?,is_same_location = ?,document = ?,work_loc = ?,qty = ?+sold,paypal_address = ?,market_status = ?,vauction = ?  where id = ? limit 1';

// mysqli[73] = 'select p.*,date_format(p.date_added,"%m/%d/%Y") as date_add,date_format(p.date_closed,"%m/%d/%Y") as date_close,u.first_name,u.email,u.last_name from projects as p left join users as u on u.id = p.user_id where p.id > 0 {{where}}   limit ?, 10';
/*mysqli[73] = 'select p.*,date_format(p.date_added,"%m/%d/%Y") as date_add,date_format(p.date_closed,"%m/%d/%Y") as date_close from projects as p where p.id > 0 {{where}} {{whr}} order by p.id desc limit ?, 10';*/
/*mysqli[73] = 'select p.*,date_format(p.date_added,"%m/%d/%Y %H:%i") as date_add,date_format(p.date_closed,"%m/%d/%Y") as date_close, c.name as category_name, cp.name as parent_category_name FROM projects as p inner join categories as c on c.id = p.category_id INNER join categories as cp on cp.id = c.parent_id where p.id > 0 and p.market_status != "removed" {{where}} {{whr}} order by p.id desc limit ?, 10';*/
mysqli[73] = 'select p.*,date_format(p.date_added,"%m/%d/%Y %H:%i") as date_add,date_format(p.date_closed,"%m/%d/%Y") as date_close, c.name as category_name, cp.name as parent_category_name {{cols}}  FROM projects as p left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join user_extras as ue on ue.user_id = p.user_id {{where1}} where p.id > 0 and p.market_status != "removed" {{where}} {{whr}} order by p.id desc limit ?, 10';
// mysqli[74] = 'select p.id from projects as p left join users as u on u.id = p.user_id where p.id > 0 {{where}} ';
/*mysqli[74] = 'select p.id, p.user_id from projects as p where p.id > 0 and p.market_status != "removed" {{where}} {{whr}} order by p.id desc';*/
mysqli[74] = 'select p.id, p.user_id, p.distributor_id, p.d_payment_status, p.d_price, p.d_invoice from projects as p left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join user_extras as ue on ue.user_id = p.user_id {{where1}} where p.id > 0 and p.market_status != "removed" {{where}} {{whr}} order by p.id desc';

mysqli[75] = 'select c.*, (COUNT(parent.id) - 1) AS depth from categories as c, categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt group by c.id order by c.lft asc limit ?,10';
mysqli[76] = 'select c.*, (COUNT(parent.id) - 1) AS depth from categories as c, categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt group by c.id order by c.lft asc';
mysqli[77] = 'select c.* from categories as c where c.id = ?';
mysqli[78] = 'insert into categories (name,description,created_at,updated_at,type,lft,rgt,parent_id, ob_market, db_market) values(?,?,?,?,"product",?,?,?,?,?)';
mysqli[79] = 'update categories set  name = ?,description = ?,updated_at = ? where id = ?';
/*mysqli[80] = 'select i.*,date_format(i.date_added,"%m/%d/%Y") as date_add,p.title,p.id as pid from invoices as i left join projects as p on p.id = i.primary_id  where i.id > 0 {{where}} order by i.id desc  limit ?, 10';*/
// mysqli[80] = 'select IFNULL(ROUND(b.admin_paid_amt,2),"0.00") as herbee_fee, IFNULL(ROUND(i.amount,2),"0.00") as i_amount,IFNULL(b.request_userid,0) as seller_id, IFNULL(b.user_id,0) as buyer_id, b.id as b_id,ck.id as ckid,i.*, date_format(i.date_added,"%m/%d/%Y") as date_add, IFNULL(p.title,"NA") as title, IFNULL(p.id,"NA") as pid, IFNULL(c.name, "NA") as category_name, IFNULL(cp.name,"NA") as parent_category_name from invoices as i left join buynow as b on b.id = i.buynow_id left join checkout as ck on i.cart_id = ck.id left join projects as p on p.id = b.project_id left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id where i.id > 0 {{where}} order by i.id desc  limit ?, 10';
mysqli[80] = 'select IFNULL(p.state, "") AS state, IFNULL(b.commission, 0) AS commission, CAST(round((IFNULL(b.commission, 0) + CAST(round(IFNULL(b.excise_tax_amt,0),2) as CHAR)),2) as CHAR) AS tax_paid, CAST(round(IFNULL(b.distribution_tax,0),2) as CHAR) as b_distribution_tax, CAST(round(IFNULL(b.cultivation_tax,0),2) as CHAR) as b_cultivation_tax ,CAST(round(IFNULL(b.excise_tax_amt,0),2) as CHAR) as b_excise_tax_amt,CAST(round(IFNULL(b.excise_markup_amt,0),2) as CHAR) as b_excise_markup_amt, IFNULL(ad.ad_name,"") as ad_name, b.cancel_ins_status as b_cancel_ins_status, IFNULL(b.recurring,0) as b_recurring, round(IFNULL(b.cancel_ins_amt,0),2) as b_cancel_ins_amt, round(IFNULL(b.cancel_ins_per,0),2) as b_cancel_ins_per, ROUND((if(i.type != "bought" and i.istatus !="credit", i.amount, IFNULL(b.admin_paid_amt,"0.00")) + IFNULL(b.cancel_ins_amt, 0.00)),2) as herbee_fee, IFNULL(ROUND(i.amount,2),"0.00") as i_amount,IFNULL(b.request_userid,0) as seller_id, IFNULL(b.user_id,0) as buyer_id, b.id as b_id,ck.id as ckid,i.*, date_format(i.date_added,"%m/%d/%Y") as date_add, IFNULL(p.title,"NA") as title, IFNULL(p.id,"NA") as pid, IFNULL(c.name, "NA") as category_name, IFNULL(cp.name,"NA") as parent_category_name from invoices as i left join buynow as b on b.id = i.buynow_id left join checkout as ck on i.cart_id = ck.id left join projects as p on p.id = b.project_id left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join adwords as ad on ad.id = i.primary_id and (i.type = "ad_payment" or i.type = "refund_ad_payment") where i.id > 0 {{where}} order by i.id desc  limit ?, 10';
//mysqli["80_n"] = 'select CAST(round(IFNULL(b.distribution_tax,0),2) as CHAR) as b_distribution_tax, CAST(round(IFNULL(b.cultivation_tax,0),2) as CHAR) as b_cultivation_tax ,CAST(round(IFNULL(b.excise_tax_amt,0),2) as CHAR) as b_excise_tax_amt,CAST(round(IFNULL(b.excise_markup_amt,0),2) as CHAR) as b_excise_markup_amt, IFNULL(ad.ad_name,"") as ad_name, b.cancel_ins_status as b_cancel_ins_status, IFNULL(b.recurring,0) as b_recurring, round(IFNULL(b.cancel_ins_amt,0),2) as b_cancel_ins_amt, round(IFNULL(b.cancel_ins_per,0),2) as b_cancel_ins_per, ROUND((if(i.type != "bought" and i.istatus !="credit", i.amount, IFNULL(b.admin_paid_amt,"0.00")) + IFNULL(b.cancel_ins_amt, 0.00)),2) as herbee_fee, IFNULL(ROUND(i.amount,2),"0.00") as i_amount,IFNULL(b.request_userid,0) as seller_id, IFNULL(b.user_id,0) as buyer_id, b.id as b_id,ck.id as ckid,i.*, date_format(i.date_added,"%m/%d/%Y") as date_add, IFNULL(p.title,"NA") as title, IFNULL(p.id,"NA") as pid, IFNULL(c.name, "NA") as category_name, IFNULL(cp.name,"NA") as parent_category_name from invoices as i left join buynow as b on b.id = i.buynow_id left join checkout as ck on i.cart_id = ck.id left join projects as p on p.id = b.project_id left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join adwords as ad on ad.id = i.primary_id and (i.type = "ad_payment" or i.type = "refund_ad_payment") where i.id > 0 {{where}} order by i.id desc  limit ?, 10';
mysqli['get_comm_rev'] = 'select sum(b.commission) as comm_rev from invoices as i left join buynow as b on b.id = i.buynow_id where i.id > 0';
mysqli[81] = 'select count(i.id) AS id,sum(i.amount) AS paid, ROUND(sum(if(i.type != "bought" and i.istatus !="credit", i.amount, IFNULL(b.admin_paid_amt,"0.00")) + IFNULL(b.cancel_ins_amt, 0.00)),2) as comm_rev from invoices as i left join buynow as b on b.id = i.buynow_id left join checkout as ck on i.cart_id = ck.id left join projects as p on p.id = b.project_id left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id where i.id > 0 {{where}}';
mysqli[82] = 'select i.*,date_format(i.date_added,"%m/%d/%Y") as date_add,p.title,p.id as pid from invoices as i left join projects as p on p.id = i.primary_id  where i.id > 0 {{where}} order by i.id desc ';
// mysqli[80] = 'select i.*,date_format(i.date_added,"%m/%d/%Y") as date_add,u.first_name,u.email,u.last_name,p.title,p.id as pid from invoices as i left join projects as p on ((p.id = i.primary_id and i.type in ("sold","winner","holded","declined","Feature Listing Fee","Home Page Listing Fee","Feature & Home Page Listing Fee","Membership Fee","commission")) or (i.type = "bid" and p.id in (select b.project_id from bids as b where b.id = i.primary_id))) left join users as u on u.id = i.user_id where i.id > 0 {{where}} order by i.id desc  limit ?, 10';
// mysqli[81] = 'select count(i.id) AS id,sum(i.amount) AS paid from invoices as i left join projects as p on p.id = i.primary_id and i.type in ("sold","winner","holded","declined","Feature Listing Fee","Home Page Listing Fee","Feature & Home Page Listing Fee","Membership Fee","commission")) or (i.type = "bid" and p.id in (select b.project_id from bids as b where b.id = i.primary_id))) left join users as u on u.id = i.user_id where i.id > 0 {{where}}';
// mysqli[82] = 'select i.*,date_format(i.date_added,"%m/%d/%Y") as date_add,u.first_name,u.email,u.last_name,p.title,p.id as pid from invoices as i left join projects as p on ((p.id = i.primary_id and i.type in ("sold","winner","holded","declined","Feature Listing Fee","Home Page Listing Fee","Feature & Home Page Listing Fee","Membership Fee","commission")) or (i.type = "bid" and p.id in (select b.project_id from bids as b where b.id = i.primary_id))) left join users as u on u.id = i.user_id where i.id > 0 {{where}} order by i.id desc ';
mysqli[83] = 'insert into buynow (project_id,user_id,amount,date_added) values(?,?,?,?)';
mysqli[84] = 'update users set balance=balance-? where id = ? limit 1';
mysqli[85] = 'select p.title,b.release,b.r_date,b.feedback,p.id,b.user_id,b.id as b_id,b.amount,b.amount as proposed_amount,b.qty,p.status,p.avatar,date_format(b.date_added,"%d %M, %Y") AS adate,1 as awarded,1 as buynow  from buynow AS b inner join projects as p on p.id = b.project_id and b.user_id = ?  order by b.id desc limit ?, 10';
mysqli[86] = 'select p.id from buynow AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and win = 0';
mysqli[87] = 'update users set fb_id = ?, fb_json = ? where id =  ? limit 1';
mysqli[88] = 'select * from users where fb_id =  ? limit 1';
mysqli[89] = 'update users set li_id = ?, li_json = ? where id =  ? limit 1';
mysqli[90] = 'select * from users where li_id =  ? limit 1';
mysqli[91] = 'insert into reviews (user_id,date_added,subject,message,rating,dispute) values(?,?,?,?,?,?)';
mysqli['review_insert'] = 'insert into reviews (user_id, buy_now_id, date_added, subject, message, rating, dispute, buyer_p_id, seller_p_id) values(?,?,?,?,?,?,?,?,?)';
/*mysqli[92] = 'select p.*,date_format(p.date_added,"%m/%d/%Y") as date_add,u.first_name,u.email,u.last_name from reviews as p left join users as u on u.id = p.user_id where p.id > 0 and p.dispute = 0   order by p.id desc  limit ?, 10';*/ 
mysqli[92] = 'select p.*, sender.username AS sender_name, pr.title AS product_title, date_format(p.created_at,"%m/%d/%Y: %H:%i") as created_at, i.transactionid from hmb_feedback as p INNER JOIN hmb_users AS sender ON sender.id=p.user_id INNER JOIN products AS pr ON pr.id=p.product_id left join invoices as i on i.primary_id = p.product_id where 1=1 {{where}} group by p.id  order by p.id desc  {{limit}}';
/*mysqli[92] = 'select i.id, sp.comment, sp.avg_rating, sp.buyer_id, bp.comment, bp.avg_rating, bp.seller_id, date_format(i.date_added,"%m/%d/%Y: %H:%i") as date_add from invoices as i inner join seller_performance as sp where p.id > 0 and p.dispute = 0  {{where}} order by p.id desc  limit ?, 10';*/
/*mysqli[93] = 'select u.last_name from reviews as p left join users as u on u.id = p.user_id where p.id > 0  and p.dispute = 0  order by p.id desc';*/
mysqli[94] = 'select p.*,date_format(p.date_added,"%m/%d/%Y") as date_add,u.first_name,u.email,u.last_name,SUBSTR(p.description,1,50) as description_short from blogs as p left join users as u on u.id = p.user_id where p.id > 0   order by p.id desc  limit ?, 10';
mysqli[95] = 'select u.last_name from blogs as p left join users as u on u.id = p.user_id where p.id > 0   order by p.id desc';
mysqli[96] = 'insert into blogs (title,description,date_added,user_id,status) values (?,?,?,?,?)';
mysqli[97] = 'select p.*,u.first_name,SUBSTR(p.description,1,50) as description_short,date_format(p.date_added,"%m/%d/%Y") as date_add from blogs as p left join users as u on u.id = p.user_id   where p.id = ?';
mysqli[98] = 'update blogs set title = ? ,description = ? where id = ?';
mysqli[99] = 'update blogs set image = ? ,avatar = ? where id = ?';
mysqli[100] = 'update blogs set status = ?  where id = ?';

mysqli[101] = 'insert into user_addresses  (name,address1,address2,country,state,city,zipcode,phone,user_id,type) values (?,?,?,?,?,?,?,?,?,?)';
mysqli[102] = 'select * from user_addresses where user_id = ? and  type = ?  order by id asc limit 1';
mysqli[103] = 'update user_addresses set name = ?,address1 = ?,address2 = ?,country = ?,state = ?,city = ?,zipcode=?,phone=? where user_id = ? and  type = ?  order by id asc limit 1';
mysqli[104] = 'insert into referral (from_id,to_id,date_added,source,points,status) values (?,?,?,?,?,?)';
mysqli[105] = 'select u.email,u.first_name,u.last_name,u.avatar,date_format(r.date_added,"%d %M, %Y") as added,r.id,r.status from referral as r left join users as u on r.to_id = u.id  where r.from_id = ?   order by id asc';
mysqli[106] = 'select p.id,p.title from projects p where p.date_added <= "{{datge}}" and p.date_closed >= "{{datge}}" and p.market_status not in ("sold","closed") and p.id not in(select a.project_id from projects_autobid a where a.project_id = p.id and user_id =  ?) ';
mysqli[107] = 'insert into projects_autobid  (user_id,project_id,start_amount,amount,balance,date_added) values (?,?,?,?,?,?)';
mysqli[108] = 'update projects_autobid  set balance=balance-? ,bids = bids +1,date_updated = ? where user_id = ? and  project_id = ? ';
mysqli[109] = 'select id from projects_autobid where user_id = ? and  project_id = ?   order by id asc';
mysqli[110] = 'select p.id,p.title,p.avatar,date_format(p.date_closed,"%d %M, %Y") as closedon ,a.balance from projects_autobid a inner join projects p on p.id = a.project_id where a.user_id = ? and  p.market_status = "open" and p.status = 1   order by id asc';
mysqli[111] = 'select user_id,amount,balance from projects_autobid where project_id = ? and balance >= ?+0.01 and status !="closed"   order by balance desc limit 1';
mysqli[112] = 'select user_id,amount,balance from projects_autobid where project_id = ? and balance >= ?+0.01  and status !="closed"  order by balance desc limit 1,1';
mysqli[113] = 'update projects_autobid  set status="closed" , date_updated = ?   where  project_id = ? and user_id not in(?) and status!="closed"';

mysqli[151] = 'select p.*,SUBSTR(p.description,1,100) as description_short,date_format(p.date_added,"%m/%d/%Y") as date_add,u.first_name,u.email,u.last_name from blogs as p left join users as u on u.id = p.user_id where p.id > 0  and p.status = "open"  and (p.title like "{{search}}%" or p.description like "{{search}}%") order by p.id desc  limit ?, 10';

mysqli['blogcnt'] = 'select p.id from blogs as p left join users as u on u.id = p.user_id where p.id > 0  and p.status = "open"  and (p.title like "{{search}}%" or p.description like "{{search}}%") order by p.id desc';
mysqli['A152'] = 'select p.*,SUBSTR(p.message,1,50) as message_short,DATE_FORMAT(p.date_sent,"%m/%d/%Y %H:%i") as date_add from pmb as p {{where}} group by p.r_id  order by p.id desc  limit ?, 5';
mysqli['d152'] = 'select p.*,SUBSTR(p.message,1,50) as message_short,DATE_FORMAT(p.date_sent,"%m/%d/%Y %H:%i") as date_add from pmb as p where p.to_id = ? {{where}} group by p.r_id  order by p.id desc  limit ?, 5';
mysqli[152] = 'select p.*,SUBSTR(p.message,1,50) as message_short,DATE_FORMAT(p.date_sent,"%m/%d/%Y %H:%i") as date_add,concat(f.first_name," ",f.last_name) as fname,concat(t.first_name," ",t.last_name) as tname,f.avatar as favatar,t.avatar as tavatar from pmb as p inner join users as f on f.id = p.from_id inner join users as t on t.id = p.to_id and p.id = (select m.id from pmb as m where m.r_id = p.r_id {{where1}} order by m.id desc limit 1) where (p.from_id = ? or p.to_id = ?) {{where}} group by p.r_id  order by p.id desc  limit ?, 5';
mysqli['dash_msg'] = 'select p.*,SUBSTR(p.message,1,50) as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add,concat(f.first_name," ",f.last_name) as fname,concat(t.first_name," ",t.last_name) as tname,f.avatar as favatar,t.avatar as tavatar from pmb as p inner join users as f on f.id = p.from_id inner join users as t on t.id = p.to_id and p.id = (select m.id from pmb as m where m.r_id = p.r_id {{where1}} order by m.id desc limit 1) where (p.from_id = ? or p.to_id = ?) {{where}} group by p.r_id  order by p.id desc  limit 0, 10';
mysqli['A153'] = 'select p.id from pmb as p {{where}} group by p.r_id order by p.id desc';
mysqli['d153'] = 'select p.id from pmb as p where (p.from_id = ?  or p.to_id = ?) {{where}} group by p.r_id order by p.id desc';
mysqli[153] = 'select p.id from pmb as p inner join users as f on f.id = p.from_id inner join users as t on t.id = p.to_id where (p.from_id = ?  or p.to_id = ?) {{where}} group by p.r_id order by p.id desc ';
mysqli['dmsgunread'] = 'select p.id from pmb as p where `read` = 0 AND (p.from_id = ?  or p.to_id = ?) {{where}} group by p.r_id order by p.id desc ';
mysqli['msgunread'] = 'select p.id from pmb as p inner join users as f on f.id = p.from_id inner join users as t on t.id = p.to_id where `read` = 0 AND (p.from_id = ?  or p.to_id = ?) {{where}} group by p.r_id order by p.id desc ';
mysqli[154] = 'select p.*,SUBSTR(p.message,1,50) as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add,concat(f.first_name," ",f.last_name) as fname,concat(t.first_name," ",t.last_name) as tname from pmb as p inner join herbes_local_users as f on f.id = p.from_id inner join herbes_local_users as t on t.id = p.to_id where (p.from_id = ?  or p.to_id = ?) {{where}} order by p.id asc ';
mysqli['154_new'] = 'select p.*,SUBSTR(p.message,1,50) as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add,concat(f.first_name," ",f.last_name) as fname,concat(t.first_name," ",t.last_name) as tname from pmb as p inner join herbes_local_users as f on f.id = p.from_id inner join herbes_local_users as t on t.id = p.to_id where {{where}} order by p.id asc ';
mysqli['notify_msg_counter'] = "select count(id) as msgs from pmb where visible = 0 and to_id = ?";
mysqli['notified_msgs'] = "update pmb set visible = 1 where to_id = ?";
mysqli['view_msg_by_id'] = 'select p.id from pmb as p inner join herbes_local_users as f on f.id = p.from_id inner join herbes_local_users as t on t.id = p.to_id where (p.from_id = ?  or p.to_id = ?) {{where}} order by p.id asc';
mysqli['view_msg_by_id_new'] = 'select p.id from pmb as p inner join herbes_local_users as f on f.id = p.from_id inner join herbes_local_users as t on t.id = p.to_id where {{where}} order by p.id asc';
mysqli[155] = 'update pmb set `read` = 1,date_read = ? where r_id = ? and to_id = ? ';
mysqli[156] = 'insert into pmb (from_id,to_id,`read`,subject,message,date_sent,date_read,r_id,from_status,to_status,project_id,visible) values (?,?,0,?,?,?,"0000-00-00 00:00:00",?,?,?,?,1)';
mysqli[157] = 'update pmb set to_status = ? where r_id = ? and to_id = ? ';
mysqli[158] = 'update pmb set from_status = ? where r_id = ? and from_id = ? ';
mysqli[159] = 'select id,email,first_name,last_name,admin from users ORDER BY first_name ASC';
mysqli[160] = 'select id from bids where user_id = ? and project_id = ? and awarded = 1';
mysqli[161] = 'select id from buynow where user_id = ? and project_id = ? ';
mysqli[162] = 'select p.*,date_format(p.date_added,"%m/%d/%Y") as date_add,date_format(p.date_closed,"%m/%d/%Y") as date_close,u.first_name,u.email,u.last_name from projects as p left join users as u on u.id = p.user_id where p.market_status = "open" and p.date_closed < ? group by id order by id desc';
mysqli[163] = 'insert into product_images (avatar,image,date_added,project_id) values (?,?,?,?) ';
mysqli[164] = 'select * from  product_images where project_id = ?  and type = "image"';
mysqli[165] = 'delete from  product_images where  id NOT IN ({{delete}}) and project_id = ? and type = "image"';
mysqli[166] = 'select ?? from users where  admin = 1 limit 1';
mysqli[167] = 'select p.*,u.first_name,SUBSTR(p.description,1,50) as description_short,date_format(p.date_added,"%m/%d/%Y") as date_add from blogs as p left join users as u on u.id = p.user_id WHERE p.status = "open" order by p.id desc limit 5';
mysqli[168] = 'select p.*,date_format(p.date_added,"%m/%d/%Y") as date_add,u.first_name,u.email,u.last_name from reviews as p left join users as u on u.id = p.user_id where p.id > 0 and p.dispute = 1   order by p.id desc  limit ?, 10';
mysqli[169] = 'select u.last_name from reviews as p left join users as u on u.id = p.user_id where p.id > 0  and p.dispute = 1  order by p.id desc';
mysqli[170] = 'select * from withdrawals where user_id = ?';
mysqli[171] = 'insert into withdrawals (user_id,amount,date_added,details,method,paid) values(?,?,?,?,?,0) ';
mysqli[172] = 'select w.*,CONCAT(u.first_name," ",u.last_name) AS name from withdrawals as w inner join users as u on u.id = w.user_id order by w.id desc limit ?,10';
mysqli[173] = 'update  withdrawals set paid = 1,paid_date = ? where id = ? and paid = 0 limit 1';
mysqli[174] = 'select id from withdrawals order by id desc';
mysqli[175] = 'select c.*, (COUNT(parent.id) - 1) AS depth from categories as c, categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt  group by c.id order by c.lft asc';
mysqli[176] = 'select max(rgt) as mrgt from categories ';
mysqli[177] = 'update categories set rgt = rgt + 2 where rgt > ?';
mysqli[178] = 'update categories set lft = lft + 2 where lft > ?';
mysqli[179] = 'select max(lft) as mrgt from categories where id = ?';
mysqli[180] = 'select lft,rgt, (rgt - lft + 1) as myw FROM categories where id = ?';
mysqli[181] = 'delete FROM categories where lft between ? AND ?';
mysqli[182] = 'update categories set rgt = rgt - ? where rgt > ?';
mysqli[183] = 'update categories set lft = lft - ? where lft > ?';

mysqli[184] = 'select * from  membership order by id desc';
mysqli[185] = 'select * from  membership_plan order by id desc';
mysqli[186] = 'select * from  membership_permission order by id desc';
mysqli[187] = 'select mp.*,m.name as rolename,mpe.name as permissionname from  membership_plan as mp left join membership as m on mp.membership_id = m.id  left join membership_permission As mpe on mp.permission_id = mpe.id order by mp.id desc';
mysqli[188] = 'select * from  membership_permission order by id desc';
mysqli[189] = 'insert into  membership values ("",?,?)';
mysqli[190] = 'update  membership set name = ?, description = ? where id = ?';
mysqli[191] = 'insert into  membership_plan (name,description,amount,length,format,membership_id,permission_id) values (?,?,?,?,?,?,?)';
mysqli[192] = 'update  membership_plan set name = ?, description = ?,amount = ?,length = ?,format = ?,membership_id = ?,permission_id = ? where id = ?';
mysqli[193] = 'insert into  membership_permission values ("",?,?)';
mysqli[194] = 'select * from membership_permission_default';
mysqli[195] = 'select * from membership_permission_detail where plan_id = ?';
mysqli[196] = 'insert into membership_permission_detail values ("",?,?,?)';
mysqli[197] = 'update membership_permission_detail set value = ? where plan_id = ? and permission_id = ?';
//mysqli[199] = 'select mpd.*,mpde.varname from  membership_permission_detail as mpd inner join membership_permission_default as mpde on mpde.id = mpd.permission_id inner join membership_permission as mp on mp.id = mpd.plan_id inner join membership_plan as mpl on mpl.permission_id = mp.id inner join membership_user as mu on mu.plan_id = mpl.id where mu.status ="active" and mu.user_id = ?';
mysqli[199] = 'select mpd.*,mpde.varname, mu.status as membership_status from  membership_permission_detail as mpd inner join membership_permission_default as mpde on mpde.id = mpd.permission_id inner join membership_permission as mp on mp.id = mpd.plan_id inner join membership_plan as mpl on mpl.permission_id = mp.id inner join membership_user as mu on mu.plan_id = mpl.id where  mu.user_id = ? and mu.status = "active"';
mysqli[200] = 'select id,parentid,lft,rgt from categories where parent_id = ? order by id asc';
mysqli[201] = 'update categories set rgt = rgt + ?,lft = lft + ? where cid = ?';
mysqli[202] = 'select * from membership_user where user_id = ?';
mysqli[203] = 'insert into membership_user (plan_id,user_id,status,date_paid,paid,added_date,renewal_date,recurring,tran_id,mem_status,deduct_date) values (?,?,?,?,?,?,?,?,?,?,?)';
//mysqli[204] = 'update membership_user set plan_id = ?,status = ?,date_paid = ?,paid = ?,renewal_date = ?,recurring = ?,tran_id = ?,mem_status=? where user_id = ?';
mysqli[204] = 'update membership_user set plan_id = ?,status = ?,date_paid = ?,paid = ?,recurring = ?,tran_id = ?,mem_status=? where user_id = ?';
//mysqli[204] = 'update membership_user set plan_id = ?,status = ?,date_paid = ?,paid = ?,added_date = ?,renewal_date = ?,recurring = ?,tran_id = ?,mem_status=? where user_id = ?';
mysqli[205] = 'select * from membership_user where user_id = ?';
mysqli['UpdateMemRenewalDetails'] = 'UPDATE  membership_user set deduct_date = ? where user_id = ?';
mysqli['getMemRenewalDetails'] = 'select DATE_ADD(deduct_date, INTERVAL 1 MONTH) as nextdeductdate,mu.*,mp.amount from membership_user mu JOIN membership_plan mp on(mu.plan_id = mp.id) and mu.status="active"';
mysqli[206] = 'select sum(if(year(p.created_at) = ? and p.created_at>mu.added_date  and p.user_id = ?,1,0)) as ycnt,sum(if(month(p.created_at) = ? and year(p.created_at) = ? and  p.created_at>mu.added_date and p.user_id = ?,1,0)) as mcnt,sum(if(year(p.created_at) = ? and p.date_added>mu.added_date  and p.user_id = ?,p.used_image_space,0)) as used_image_space from projects as p left join membership_user as mu on mu.user_id=p.user_id';
mysqli[207] = 'select sum(if(year(b.created_at) = ?  and b.created_at > mu.added_date and b.user_id = ?,1,0)) as ycnt,sum(if(month(b.created_at) = ? and year(b.created_at) = ? and b.created_at > mu.added_date  and b.user_id = ?,1,0)) as mcnt from bids as b left join membership_user as mu on mu.user_id = b.user_id';

mysqli["total_buy_now"] = 'select sum(if(year(p.date_added) = ? and p.date_added>mu.added_date  and p.user_id = ?,1,0)) as ycnt,sum(if(month(p.date_added) = ? and year(p.date_added) = ? and  p.date_added>mu.added_date and p.user_id = ?,1,0)) as mcnt from buynow as p left join membership_user as mu on mu.user_id=p.user_id';

/* changed by mohit for transaction id*/
// mysqli[208] = 'update invoices set status = "paid",paid_date = ?,transactionid = ?,gateway = ? where primary_id = ? AND type="winner" ';
// mysqli[208] = 'update invoices set status = "paid", paid_date = ?, gateway = ? where id = ?';
mysqli[208] = 'update invoices set status = "paid", paid_date = ? where id = ?';
mysqli[209] = 'select id from invoices where type = "sold" and primary_id = ?  order by id desc';
mysqli[210] = 'select mp.*,mu.user_id,mu.recurring,mu.tran_id from membership_user as mu inner join membership_plan as mp on mp.id = mu.plan_id where mu.user_id = ?';
mysqli[211] = 'select mpd.*,mp.name,mp.type from membership_permission_detail as mpd inner join membership_permission_default as mp on mp.id = mpd.permission_id order by mp.name asc';
mysqli[212] = 'update membership_user set status = ?,plan_id=?,added_date=?,date_paid = ?,paid = ?,renewal_date = ? where user_id = ?';
mysqli['cnx210'] = 'select * from checkout where user_id = ? order by id desc limit 1';
mysqli['cnx211'] = 'insert into checkout (date_added,first_name,last_name,email,phone,address,delivery_instruction,country,state,city,zipcode,user_id,paid_date,paid,trans_id,amount) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['cnx212'] = 'insert into buynow (project_id,user_id,amount,date_added,ordered,cart_id,qty,refund,win,paid,paid_date,`release`,r_date,`escrow`,commission,local_pick,active) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

mysqli['cnx213'] = 'select * from projects where id IN ({{where}})';
mysqli['cnx214'] = 'update projects set sold = sold + ? where id = ?';
mysqli['cnx215'] = 'update projects set market_status = "sold" where id = ?';
// mysqli['cnx216'] = 'INSERT INTO invoices (id, transactionid, gateway, date_added, user_id, primary_id, type, description, amount,status,istatus,paid_date,qty,cart_id) VALUES (null,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?)';
mysqli['cnx216'] = 'INSERT INTO invoices (transactionid, gateway, date_added, user_id, primary_id, type, description, amount,status,istatus,paid_date,qty,cart_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?)';
mysqli['cnx217'] = 'update checkout set refund = ?,r_trans_id = ? where id = ?';
mysqli['cnx218'] = 'select c.*, b.id as b_id, b.qty as  b_qty, i.id i_id, i.istatus, i .status, p.id as p_id, p.title as p_title, p.unit_price as p_unit_price, p.units from checkout c left join buynow b on b.cart_id = c.id left join invoices i on i.cart_id = c.id left join projects p on p.id = b.project_id where c.id = ? group by p.id';
// mysqli['cnx218'] = 'select * from checkout where id = ?';


mysqli['cnx219'] = 'select b.*,p.title,p.avatar,p.image from buynow as b inner join projects as p on p.id = b.project_id where b.cart_id = ?';
// mysqli['cnx220'] = 'select * from buynow where id = ? and paid = 0';
// mysqli['cnx220'] = 'select * from buynow where id = ? and paid = 1 and seller_paid_status = 0';
mysqli['cnx220'] = 'select * from buynow where id = ? and paid = 0';
mysqli['cnx220db'] = 'select * from buynow where id = ? and paid = 1 and seller_paid_status = "0"';
mysqli['check_buynow_rec'] = 'select * from buynow where id = ? and user_id = ? and paid = 0';
mysqli['cnx221'] = 'select * from bids where id = ?';
mysqli['cnx222'] = 'update buynow set `release` = 1,r_date = ? where id = ? and user_id = ? limit 1';
mysqli['cnx223'] = 'update buynow set `release` = 2,r_date = ? where id = ? and user_id = ? limit 1';
mysqli['cnx224'] = 'select b.*,p.id as p_id,b.id as b_id,p.title,p.image,p.avatar from buynow as b inner join projects as p on b.project_id = p.id where p.user_id = ? and b.qty > 0 and b.active = 0 order by b.id desc';
// mysqli['cnx225'] = 'select b.*,p.id as p_id,b.id as b_id,p.title, p.units,p.image,p.avatar,p.shipping_description from buynow as b inner join projects as p on b.project_id = p.id where p.user_id = ? and b.qty > 0 and p.auction = 0 and b.active = 0 {{whr}} order by b.id desc {{limit}}';
// mysqli['dbbuyyertab'] = 'select p.*,b.id as b_id, b.qty as b_qty,b.paid as b_paid_status, b.paid_date as b_paid_date, b.delivery_status as b_delivery_status, b.shipping_status as b_shipping_status, b.shipped_at as b_shipped_at, b.delivered_at as b_delivered_at, b.total_amount as b_total_amount from buynow AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and auction = 0 {{whr}} order by b.id DESC limit ?,?';
mysqli['cnx225'] = 'select (SELECT position FROM recurring_schedule WHERE id=b.rec_schedule_id) AS current_position,(SELECT count FROM recurring_purchase WHERE id=b.rec_purchase_id) AS count, IFNULL((select ROUND((sum(avg_rating)/count(id) + sum(tpayment)/count(id) )/2) from buyer_performance where buyer_id=b.user_id), 0) as buyer_rating, p.*, DATE_ADD(b.paid_date, INTERVAL 72 hour) as b_timer, b.user_id as buyer_id, b.request_userid as seller_id, b.id as b_id,b.stax_status as b_stax_status, b.stax_per as b_stax_per, b.qty as b_qty,b.paid as b_paid_status, b.paid_date as b_paid_date, b.delivery_status as b_delivery_status, b.shipping_status as b_shipping_status, b.shipped_at as b_shipped_at, b.delivered_at as b_delivered_at, b.total_amount as b_total_amount, b.recurring as b_recurring, b.seller_paid_status as b_seller_paid_status, b.seller_paid_at as b_seller_paid_at, b.cancel_ins_per as b_cancel_ins_per, b.cancel_ins_status as b_cancel_ins_status, b.cancel_ins_amt as b_cancel_ins_amt, b.reserve_amt as b_reserve_amt, b.commission as b_commission_amt, b.commission_per as b_commission_per, b.stax_per as b_stax_per, b.stax_status as b_stax_status, b.stax_amt as b_stax_amt from buynow as b inner join projects as p on b.project_id = p.id where p.user_id = ? and b.qty > 0 and p.auction = 0 and b.active = 0 {{whr}} order by b.id desc {{limit}}';
mysqli['search225'] = 'select b.*,p.id as p_id,b.id as b_id,p.title,p.image,p.avatar,p.shipping_description from buynow as b inner join projects as p on b.project_id = p.id where p.user_id = ? and b.qty > 0 and b.active = 0  {{where}} order by b.id desc';
mysqli['cnx226'] = 'select * from buynow where user_id = ? and win = 0 and qty > 0';
mysqli['cnx227'] = 'select p.id as id,b.date_added,b.project_id,p.is_digital,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,1 as buynow,d.id AS dispute_id,d.subject,d.message  from buynow as b inner join projects as p on b.project_id = p.id LEFT JOIN disputes d ON d.project_id = b.project_id where b.user_id = ? and b.win = 0  and b.qty > 0 order by b.id desc {{limit}}';
mysqli['cnx2227'] = 'select p.id as id,b.date_added,b.project_id,p.is_digital,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,1 as buynow,d.id AS dispute_id,d.subject,d.message  from buynow as b inner join projects as p on b.project_id = p.id LEFT JOIN disputes d ON d.project_id = b.project_id where b.user_id = ? and b.win = 0  and b.qty > 0 {{where}} order by b.id desc';

mysqli['cnx228'] = 'select * from buynow where user_id = ? and win = 1';
mysqli['cnx229'] = 'select b.*,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,d.id AS dispute_id,d.subject,d.message from buynow as b inner join projects as p on p.id = b.project_id LEFT JOIN disputes d ON d.project_id = b.id where b.user_id = ? and b.win = 1 and b.active = 0 order by b.id desc {{limit}}';
mysqli['cnx229search'] = 'select b.*,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,d.id AS dispute_id,d.subject,d.message from buynow as b inner join projects as p on p.id = b.project_id LEFT JOIN disputes d ON d.project_id = b.id where b.user_id = ? and b.win = 1 and b.active = 0 {{where}} order by b.id desc';
// mysqli['cnx230'] = 'update buynow set `paid` = 1,cart_id = ?,`paid_date` = ?,`release` = ?,r_date = ?,escrow = ?,active = 0 where id = ? limit 1';
mysqli['cnx230'] = 'update buynow set `paid` = 1,`paid_date` = ?,`release` = ?,r_date = ?,escrow = ?,active = 0 where id = ? limit 1';
mysqli['cnx231'] = 'update buynow set `shipping_info` = ?,tracking_number = ?, tracking_service = ? where id = ? limit 1';
mysqli['cnx232'] = 'select concat(u.first_name," ",u.last_name) as name,b.id as buynow_id,p.image,p.avatar,p.title from buynow as b  inner join projects as p on p.id = b.project_id inner join users as u on u.id = p.user_id where b.id = ?';
mysqli['cnx233'] = 'insert into feedback (title,content,date_added,buynow_id) values(?,?,?,?)';
mysqli['cnx234'] = 'insert into feedback_detail (id,f_id,point,type_id) values(NULL,?,?,?)';
mysqli['cnx235'] = 'update buynow set feedback = 1 where id = ? limit 1';
mysqli['cnx236'] = 'update feedback set average = ? where id = ? limit 1';
mysqli['cnx237'] = 'update users set review = (review+?)/2 where id = ? limit 1';
mysqli['cnx238'] = 'select f.*,fd.type_id,fd.point,ff.field_name from feedback as f inner join feedback_detail as fd inner join feedback_fields as ff  on fd.f_id = f.id and ff.id = fd.type_id where f.buynow_id = ? order by ff.position asc';
mysqli['cnx239'] = 'select b.local_pick,c.trans_id,concat(u.first_name," ",u.last_name) as name,u.email as seller_email,u.address1 as uaddress,u.country as seller_country,u.state as seller_state,u.city as seller_city,u.zip as seller_zip,u.phone as seller_phone ,c.*,b.id as buynow_id,p.title,b.amount as amt,b.refund as refundamt, date_format(b.paid_date,"%M %d %Y %h:%i:%s %p") as pay_date,date_format(b.date_added,"%M %d %Y %h:%i:%s %p") as create_date,concat(us.first_name," ",us.last_name) as uname from buynow as b inner join projects as p on p.id = b.project_id inner join users as us on us.id = b.user_id inner join users as u on u.id = p.user_id inner join checkout as c on c.id = b.cart_id  where b.id  = ?';
mysqli['cnx240'] = 'select concat(u.first_name," ",u.last_name) as name,p.title,u.address1 as uaddress,c.*,b.id as buynow_id,b.commission,p.paypal_address,p.qty,b.admin,b.paid,b.release,p.title,b.project_id,p.avatar,date_format(b.date_added,"%M %d %Y %h:%i:%s %p") as create_date,date_format(b.paid_date,"%M %d %Y %h:%i:%s %p") as pay_date,date_format(b.r_date,"%M %d %Y %h:%i:%s %p") as r_date,b.admin,p.image,b.amount as amt,date_format(b.paid_date,"%M %d %Y %h:%i:%s %p") as pay_date,concat(us.first_name," ",us.last_name) as uname from buynow as b inner join projects as p on p.id = b.project_id inner join users as us on us.id = b.user_id inner join users as u on u.id = p.user_id inner join checkout as c on c.id = b.cart_id order by b.id desc limit ?,10';
mysqli['cnx241'] = 'select id from buynow';
mysqli['cnx242'] = 'select concat(u.first_name," ",u.last_name) as name,c.trans_id,p.title,u.address1 as uaddress,c.*,b.id as buynow_id,p.qty,b.admin,b.paid,b.release,p.title,b.project_id,p.paypal_address,p.avatar,date_format(b.date_added,"%M %d %m,%Y %h:%i:%s %p") as create_date,date_format(b.paid_date,"%M %d %m,%Y %h:%i:%s %p") as pay_date,date_format(b.r_date,"%M %d %m,%Y %h:%i:%s %p") as r_date,b.admin,p.image,b.amount as amt,date_format(b.paid_date,"%M %d %m,%Y %h:%i:%s %p") as pay_date,concat(us.first_name," ",us.last_name) as uname from buynow as b inner join projects as p on p.id = b.project_id inner join users as us on us.id = b.user_id inner join users as u on u.id = p.user_id inner join checkout as c on c.id = b.cart_id where b.id = ? order by b.id desc limit 1';
mysqli['cnx243'] = 'update buynow set admin=? where id=?';
// mysqli['cnx244'] = 'select i.*,b.id as buyid from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join users as us on us.id  = p.user_id inner join users as u on u.id = i.user_id where i.active = 0 and i.user_id = ? or p.user_id = ?';
// mysqli['cnx245'] = 'select i.*,b.id as buyid from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join users as us on us.id  = p.user_id inner join users as u on u.id = i.user_id where i.active = 0 and i.user_id = ? or p.user_id = ? order by i.id desc limit ?,10';
// mysqli['cnx244'] = 'select c.id as c_id, c.date_added as c_date_added, c.first_name, c.last_name, c.address, c.country, c.zipcode, c.city, c.state, c.paid, c.paid_date, c.user_id as c_user_id, c.email, c.phone, c.phone, c.amount as c_amount,i.*,b.id as buyid from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join checkout as c on c.id = i.cart_id where i.user_id = ?';
// mysqli['cnx245'] = 'select c.id as c_id, c.date_added as c_date_added, c.first_name, c.last_name, c.address, c.country, c.zipcode, c.city, c.state, c.paid, c.paid_date, c.user_id as c_user_id, c.email, c.phone, c.phone, c.amount as c_amount,i.*,b.id as buyid from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join checkout as c on c.id = i.cart_id where i.user_id = ? order by i.id desc limit ?,?';
// mysqli['cnx244'] = 'select b.request_userid as seller_id, (CASE b.request_userid WHEN ? THEN "credit" ELSE "debit" END) AS tr_type, i.*,date_format(i.date_added,"%M %d %Y %h:%i:%s %p") as i_date_added,c.id as c_id, c.date_added as c_date_added, c.first_name, c.last_name, c.address, c.country, c.zipcode, c.city, c.state, c.paid, c.paid_date, c.user_id as c_user_id, c.email, c.phone, c.phone, c.amount as c_amount,b.id as buyid from invoices as i left join checkout as c on c.id = i.cart_id left join buynow as b on i.buynow_id = b.id left join projects as p on p.id = i.primary_id where i.user_id = ? or b.request_userid = ? {{whr}}';
// mysqli['cnx245'] = 'select b.request_userid as seller_id, (CASE b.request_userid WHEN ? THEN "credit" ELSE "debit" END) AS tr_type, i.*,date_format(i.date_added,"%M %d %Y %h:%i:%s %p") as i_date_added,c.id as c_id, c.date_added as c_date_added, c.first_name, c.last_name, c.address, c.country, c.zipcode, c.city, c.state, c.paid, c.paid_date, c.user_id as c_user_id, c.email, c.phone, c.phone, c.amount as c_amount,b.id as buyid from invoices as i left join checkout as c on c.id = i.cart_id left join buynow as b on i.buynow_id = b.id left join projects as p on p.id = i.primary_id where i.user_id = ? or b.request_userid = ? {{whr}} order by i.id desc limit ?,?';
mysqli['cnx244'] = 'select i.user_id as buyer_id, b.request_userid as seller_id, (CASE b.request_userid WHEN ? THEN "credit" ELSE i.istatus END) AS tr_type, i.*,date_format(i.date_added,"%M %d %Y %h:%i:%s %p") as i_date_added,c.id as c_id, c.date_added as c_date_added, c.first_name, c.last_name, c.address, c.country, c.zipcode, c.city, c.state, c.paid, c.paid_date, c.user_id as c_user_id, c.email, c.phone, c.phone, c.amount as c_amount,b.id as buyid, IFNULL(b.stax_amt,0) AS stax_amt, IFNULL(b.distribution_tax,0) AS distribution_tax from invoices as i left join checkout as c on c.id = i.cart_id left join buynow as b on i.buynow_id = b.id left join projects as p on p.id = i.primary_id where ((i.user_id = ? {{where}}) {{whr}}) {{inv_id}} order by i.id desc';
mysqli['cnx245'] = 'select i.user_id as buyer_id, b.request_userid as seller_id, (CASE b.request_userid WHEN ? THEN "credit" ELSE i.istatus END) AS tr_type, i.*,date_format(i.date_added,"%M %d %Y %h:%i:%s %p") as i_date_added,c.id as c_id, c.date_added as c_date_added, c.first_name, c.last_name, c.address, c.country, c.zipcode, c.city, c.state, c.paid, c.paid_date, c.user_id as c_user_id, c.email, c.phone, c.phone, c.amount as c_amount,b.id as buyid, IFNULL(b.stax_amt,0) AS stax_amt, IFNULL(b.distribution_tax,0) AS distribution_tax from invoices as i left join checkout as c on c.id = i.cart_id left join buynow as b on i.buynow_id = b.id left join projects as p on p.id = i.primary_id where ((i.user_id = ? {{where}}) {{whr}}) {{inv_id}} order by i.id desc limit ?,?';
mysqli['cnx246'] = 'select s.*, e.business_name from shipping AS s left join user_extras As e ON e.id=s.user_id where s.user_id = ?';

// mysqli['cnx247'] = 'insert into shipping (first_name,last_name,email,phone,address,country,state,city,zipcode,user_id) values (?,?,?,?,?,?,?,?,?,?)';
/* add update and check shipping details here cnx247 */
mysqli['cnx247'] = 'insert into shipping (first_name,last_name,email,phone,address,country,state,state_abbr,city,region,zipcode,from_hour,to_hour,user_id, delivery_instruction) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['update_cnx247'] = 'update shipping  set first_name = ?,last_name = ?,email = ?,phone = ?,address = ?,country = ?,state = ?,state_abbr = ?,city = ?,region = ?,zipcode = ?, from_hour = ?, to_hour = ?, delivery_instruction = ? where user_id = ?';
mysqli['check_cnx247'] = 'select * from shipping where user_id = ?';


mysqli['cnx248'] = 'update shipping set first_name = ?,last_name = ?,email = ?,phone = ?,address = ?,country = ?,state = ?,city = ?,zipcode = ? where user_id = ?';
mysqli['cnx249'] = 'update projects  set title = ?,description = ?,avatar = ?,image = ?,category_id = ?,tags = ?,shipping_price = ?,shipping_description = ?,buynow = ?,feature = ?,home_page_listing_fee = ?, sprice = ?,rprice = ?,bprice = ?,mprice = ?,auction = ?,is_same_location = ?,document = ?,work_loc = ?,qty = ?,paypal_address = ?,duration=?,duration_type=?, time = ?, time_level = ?,future = ?, date_added = ?, date_closed = ?, market_status = ?,country = ?,state = ?,city = ?,sell_location = ?,updated_at = ?, vauction = ?, parent_category_id = ?, weight = ?, width = ?, height = ?  where id = ? limit 1';
mysqli['cnx250'] = 'update projects  set {{feature}} where id = ?';
mysqli['cnx251'] = 'update invoices  set buynow_id = ? where cart_id = ? and primary_id = ?';
mysqli['cnx252'] = 'select i.*,b.id as buyid,date_format(i.paid_date,"%m-%d-%Y") as date_paid,date_format(i.date_added,"%m-%d-%Y") as date_add from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1  inner join projects as p on p.id = i.primary_id inner join users as us on us.id  = p.user_id inner join users as u on u.id = i.user_id where i.user_id = ? or p.user_id = ? order by i.id desc';
mysqli['productedit'] = 'update projects  set pkey = ?, title = ?,metrc_id = ?,description = ?,category_id = ?,buynow = ?, sprice = ?,rprice = ?,bprice = ?,mprice = ?,auction = ?,negotiable = ?,qty = ?,  market_status = ?,updated_at = ?, parent_category_id = ?, cannabis_type = ?,units = ?,  unit_price =?,stax =?, country=?, state=?, state_abbr=?,store_prdt = ?,store_prdt_msg = ?,interim_testing_status = ?,interim_testing_status_msg = ?,cert_analysis = ?,cert_analysis_img = ?,default_distributor = ?,additional_service = ?,additional_service_type = ?,cultivation_tax_status = ?,test_result_types=?,herbee_facility_status=? {{image}} where id = ? limit 1';
mysqli['admin_productedit'] = 'update projects set avatar = ?, image = ?, test_result = ?, test_result_img = ?, title = ?,  brand = ?,  description = ?, category_id = ?, parent_category_id = ?, auction = ?, buynow = ?, negotiable=?, cannabis_type = ?, sprice = ?,    rprice = ?,bprice = ?,mprice = ?,qty = ?,  rfilled_qty=?, units = ?, unit_price = ?, stax =?, order_type=?, trading_type=? {{image}} where id = ? limit 1';

mysqli['cnx253'] = 'update buynow set admin=1 where id in (?)';
mysqli['cnx254'] = 'select p.*'+mysqli['cntbid']+' from projects as p inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt   and date_added <= "{{datge}}" and date_closed >= "{{datge}}" and p.market_status = "open" and p.category_id = ? and p.id != ? group by p.id order by p.id desc';
mysqli['cnx255'] = 'update users set zip = ?,state = ?,city =?,country =?,address1 =?,address2 =?  where id = ?';
//timer cart
mysqli['timer1'] = 'insert into cart_temp (cart_id,project_id,date_added,r_id,qty,paid,revert,user_id,product_data) values (NULL,?,?,?,?,?,?,?,?)';
mysqli['timer2'] = 'update projects set booked = booked + ? where id = ?';
mysqli['timer3'] = 'update projects set booked = booked - ? where id = ?';
mysqli['timer4'] = 'delete from cart_temp where r_id = ? and project_id = ? and user_id = ? limit 1';
mysqli['delete_temp_cart_by_user'] = 'delete from cart_temp where user_id = ?';
//mysqli['timer4'] = 'delete from cart_temp  where project_id = ? and user_id = ?';
mysqli['timer5'] = 'select * from projects where id in (?)';
mysqli['recurringdetails'] = 'select p.*,r.* from projects as p left join cart_temp as c ON c.project_id =p.id left join recurring_purchase as r ON c.project_id = r.project_id where  c.user_id = ? and p.id in (?) and r.paid = 0 and active = 1';
mysqli['timer6'] = 'update cart_temp set qty = ?  where r_id = ? and project_id = ? and user_id = ?';
mysqli['timer7'] = 'select a.qty,a.cart_id as id,a.project_id,b.date_added from cart_temp as a inner join cart_temp as b on a.r_id = b.r_id and b.cart_id = (select c.cart_id from cart_temp as c where c.r_id = b.r_id order by c.cart_id asc limit 1) where DATE_SUB(?,INTERVAL ? SECOND) > b.date_added';
mysqli['timer8'] = 'delete from cart_temp  where r_id = ?';
mysqli['timer9'] = 'delete from cart_temp  where cart_id = ?';
mysqli['timer10'] = 'delete from cart_temp  where project_id = ? and r_id = ?';
mysqli['recidRemove'] = 'delete from recurring_purchase  where id = ?';
mysqli['timer11'] = 'update projects set booked = 0 where booked < 0';
mysqli['timer12'] = 'select * from cart_temp  where project_id = ? and user_id = ?';
mysqli['timer13'] = 'select * from cart_temp  where user_id = ?';

mysqli[114] = 'select cid from profile_categories where user_id = ? and cid = ?  limit 1';
mysqli[115] = 'delete from profile_categories where user_id = ? and cid not in ( ? ) ';
mysqli[116] = 'insert into profile_categories (user_id,cid) values (?,?)';
mysqli[117] = 'SELECT GROUP_CONCAT( cid ) as mcat FROM  profile_categories WHERE  user_id = ? ';
mysqli[1182222] = 'select u.email,u.first_name,u.last_name,u1.first_name as refererFname,u1.last_name as refererLname,u1.email as refererEmail,u.avatar,date_format(r.date_added,"%d %M, %Y") as added,r.id,r.status,r.from_id from referral as r inner join users as u on r.to_id = u.id inner join users as u1 on r.from_id = u1.id  where r.from_id > 0   order by id asc   limit ?, 10';
mysqli[118] = 'select r.to_id, r.from_id ,date_format(r.date_added,"%d %M, %Y") as added,r.id,r.status,r.from_id from referral as r   where r.from_id > 0   order by id desc   limit ?, 10';

mysqli[119] = 'update referral set status = 1 where id =  ? limit 1';
mysqli['get_refer_details'] = 'select * from referral where id =  ? and status = 0 limit 1';
mysqli[120111] = 'select u.email,u.first_name,u.last_name,u1.first_name as refererFname,u1.last_name as refererLname,u1.email as refererEmail,u.avatar,date_format(r.date_added,"%d %M, %Y") as added,r.id,r.status from referral as r inner join users as u on r.to_id = u.id inner join users as u1 on r.from_id = u1.id  where r.from_id > 0   order by id asc';
mysqli[120] = 'select r.to_id, r.from_id ,date_format(r.date_added,"%d %M, %Y") as added,r.id,r.status from referral as r   where r.from_id > 0   order by id desc';
mysqli[121] = 'delete from user_addresses where user_id = ? and  type = ?  order by id asc limit 1';
//mysqli[122]= 'select * from bids where project_id = ?';


mysqli[252] = 'select * from  categories_questions where cid = ?';
mysqli[253] = 'select * from  categories where id = ?';
mysqli[254] = 'insert into categories_questions (id,cid,name,value,type,`default`,required) values(NULL,?,?,?,?,?,?)';
mysqli[255] = 'select * from  categories_questions where id = ?';
mysqli[256] = 'update categories_questions set name = ?,value = ?,type = ?,`default` = ?,required  = ? where id = ?';
mysqli[257] = 'select * from  categories_questions where cid in (select p.id from categories as p where p.lft <= (select c.lft from categories as c where id = ?) and p.rgt >=  (select c.rgt from categories as c where id = ?) )';
mysqli[258] = 'insert into project_answers (id,project_id,question_id,value) values(NULL,?,?,?)';
mysqli[259] = 'select c.*,q.name from project_answers as c inner join categories_questions as q on q.id = c.question_id where c.project_id = ?';
mysqli[260] = 'delete  from project_answers where project_id = ?';
mysqli[261] = 'update categories set parent_id = ?, name = ?, description = ?, ob_market = ?, db_market = ?, updated_at = ? where id = ?';
mysqli[262] = 'update categories set parent_id = ? where parent_id = ?';
mysqli[263] = 'select * from categories where parent_id = ?';
mysqli['getParentCategory'] = 'select parent_id from categories where category_id = ?';
mysqli[264] = 'update categories set lft = ?,rgt = ? where id = ?';
mysqli[265] = 'delete from categories  where id = ? or parent_id = ?';
mysqli[266] = 'update projects  set status = "closed" where category_id = ?';
mysqli[267] = 'select * from location where location_type = ? order by name asc';
mysqli[268] = 'select * from location where  parent_id = ?';
mysqli[269] = 'update users set status = "active" where id = ?';
mysqli[270] = 'insert into creditcards(card_name,card_type,support_customer_id,token_id,encrypt_card,date_added,status,support,expiration_month,expiration_year,user_id) values (?,?,?,?,?,?,?,?,?,?,?)';
mysqli[271] = 'update projects set market_status = "open"  where market_status = "moderate" and id = ?';
mysqli[272] = 'update categories set rgt = ? where id = ?';
mysqli[273] = 'update categories set lft = ? where id = ?';
mysqli[274] = 'select * from categories  order by name asc';
mysqli['category_queries_1'] = 'select c.*, (COUNT(parent.id) - 1) AS depth from categories as c, categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt and c.parent_id = ? group by c.id order by c.name asc';
mysqli['category_queries_2'] = 'select c.*, (COUNT(parent.id) - 1) AS depth from categories as c inner join categories AS parent on c.lft BETWEEN parent.lft AND parent.rgt where c.lft <= ? and c.rgt >= ? group by parent.id  order by parent_id ASC';
mysqli['category_queries_3'] = 'select * from categories where id = ?';
mysqli[283] = 'select * from users as u   left join    profile_categories as pc on pc.user_id = u.id WHERE   pc.cid = ?';
mysqli[291] = 'select p.* from projects as p where p.market_status = "open" and p.auction ="0" and p.date_added <= ? and p.date_closed >= ? order by p.date_closed ASC limit 20';

mysqli[292] = 'select p.* from projects as p where p.market_status = "open" and p.sold > 0 and p.date_added <= ? and p.date_closed >= ? order by p.sold desc limit 20';

mysqli['homePageListing'] = 'select p.* from projects as p where p.market_status = "open" AND home_page_listing_fee = 1 and p.date_added <= ? and p.date_closed >= ? order by p.id desc limit 20';
/*mysqli[292] = 'select p.* from projects as p inner join users as u on u.id = p.user_id where p.market_status = "open" and p.date_added <= ? and p.date_closed >= ? group by u.id order by u.review desc limit 20';*/
//---added by mohit
//mysqli[293] = 'select p.* from projects as p inner join users as u  on u.id = p.user_id inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt AND p.market_status = "open" and p.date_added <= ? and p.date_closed >= ? and parent.id = ? order by p.id desc limit 50';
mysqli[293] = 'select p.* from projects as p inner join categories AS c on c.id = p.category_id,  categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt AND p.market_status = "open" and p.date_added <= ? and p.date_closed >= ? and parent.id = ? order by p.id desc limit 50';
mysqli[294] = 'select * from creditcards where user_id = ?';
mysqli['getcarddetails'] = 'select * from creditcards where user_id = ? and card_type !="Paypal"';
mysqli[295] = 'select * from creditcards where id = ?';
mysqli[296] = 'update projects  set feature = 0 where id = ?';
mysqli[297] = 'insert into demo_form (first_name,last_name,email,phone,country_code,date_added) values (?,?,?,?,?,?)';

mysqli[299] = 'select * from saved_search where id=?';
mysqli[298] ='select p.avatar,f.* from feedback as f inner join buynow as b inner join projects as p on b.id= f.buynow_id and p.id= b.project_id where f.buynow_id  IN (SELECT id FROM buynow WHERE user_id = ?) order by f.id desc {{limit}}';
mysqli[299] = "SELECT u.email,u.first_name,u.last_name, u.id, bd.awarded,bd.project_id,bd.created_at, i.description, i.amount, i.status,p.user_id FROM users u INNER JOIN bids bd ON u.id = bd.user_id INNER JOIN projects p ON p.id = bd.project_id INNER JOIN invoices i ON bd.user_id = i.user_id WHERE bd.awarded =1 AND i.status =  'unpaid' AND DATEDIFF( NOW( ) , bd.created_at ) < ?";

mysqli[308] = 'insert into userdel (fname,lname,sub,msg) values (?,?,?,?)';

mysqli[309] = 'select * from userdel';

mysqli[341] = 'insert into product_images (avatar,image,date_added,project_id,`type`) values (?,?,?,?,"digital") ';
mysqli[342] = 'select * from  product_images where project_id = ?  and type = "digital"';
mysqli[343] = 'delete from  product_images where  id NOT IN ({{delete}}) and project_id = ? and type = "digital"';
mysqli[799] = "SELECT brs.first_name, brs.last_name, slr.first_name AS sfirst,pro.id as pid, slr.last_name AS slast,fd.id,fd.average,fd.date_added FROM feedback fd INNER JOIN buynow bn ON fd.buynow_id = bn.id INNER JOIN projects pro ON pro.id = bn.project_id  INNER JOIN users slr ON slr.id = pro.user_id INNER JOIN users brs ON brs.id = bn.user_id ORDER BY fd.date_added DESC";
mysqli[800] = "SELECT brs.first_name, brs.last_name, slr.first_name AS sfirst,pro.id as pid, slr.last_name AS slast,fd.id,fd.average,fd.date_added FROM feedback fd INNER JOIN buynow bn ON fd.buynow_id = bn.id INNER JOIN projects pro ON pro.id = bn.project_id  INNER JOIN users slr ON slr.id = pro.user_id INNER JOIN users brs ON brs.id = bn.user_id ORDER BY fd.date_added DESC limit ?,?";
mysqli[801] = 'delete from feedback where id = ?';
mysqli[802] = 'SELECT * FROM feedback_fields ORDER BY position ASC';
mysqli[803] = 'insert into feedback_fields (field_name,position) values(?,?)';
mysqli[804] = 'delete from feedback_fields where id = ?';
mysqli[805] = 'SELECT * from feedback_fields where id = ?';
mysqli[806] = 'update feedback_fields set field_name = ?, position = ? where id = ?';
mysqli[807] = "SELECT brs.first_name, brs.last_name, slr.first_name AS sfirst,pro.id, slr.last_name AS slast,fd.id,fd.average,fd.date_added FROM feedback fd INNER JOIN buynow bn ON fd.buynow_id = bn.id INNER JOIN projects pro ON pro.id = bn.project_id  INNER JOIN users slr ON slr.id = pro.user_id INNER JOIN users brs ON brs.id = bn.user_id WHERE DATE(fd.date_added) = ? ORDER BY fd.date_added ASC";
mysqli[808] = 'select p.*,date_format(p.date_added,"%m/%d/%Y") as date_add,u.first_name,u.email,u.last_name from reviews as p left join users as u on u.id = p.user_id where p.id > 0  and p.dispute = 0 order by p.id desc limit ?, 10';
mysqli[809] = 'select u.last_name from reviews as p left join users as u on u.id = p.user_id where p.id > 0 and u.id != ? and p.dispute = 0  order by p.id desc';
mysqli[810] = 'select f.id,f.buynow_id,ff.field_name,fd.point from feedback as f inner join feedback_detail as fd inner join feedback_fields as ff inner join buynow as bd on f.id= fd.f_id and fd.type_id= ff.id and f.buynow_id = bd.id where bd.user_id = ? order by f.id desc';
mysqli[811] = 'update feedback_fields set position = (position+1) where position >= ? and position < ?';
mysqli[812] = 'update feedback_fields set position = (position-1) where position <= ? and position > ?';
mysqli[813] = 'update feedback_fields set position = (position+1) where position >= ?';
mysqli[814] = 'update feedback_fields set position = (position-1) where position > ?';
mysqli[815] = 'SELECT b.id,b.project_id,b.user_id,p.title,u.first_name, u.last_name,u.email,u.phone FROM bids b INNER JOIN projects p ON p.id = b.project_id INNER JOIN users u ON u.id = b.user_id WHERE project_id =? AND b.user_id != ? and b.declined = 0 GROUP BY b.user_id';
mysqli[816] = 'SELECT b.id,b.project_id,b.user_id,p.title,u.first_name, u.last_name,u.email,u.phone FROM buynow b INNER JOIN projects p ON p.id = b.project_id INNER JOIN users u ON u.id = b.user_id WHERE b.id=? limit 1';

mysqli[819] = 'SELECT * FROM templates ORDER BY id ASC' ;
mysqli[820] = 'insert into templates (title,subject,type,method,template,date_added,buyer,seller,admin,general,status) values (?,?,?,?,?,?,?,?,?,?,?)';
mysqli[821] = 'SELECT * FROM templates where method=? ORDER BY id ASC {{limit}}';
mysqli[822] = 'SELECT * from templates where id = ?';
mysqli[823] = 'update templates set title = ?, subject = ?, type = ?, template = ?,buyer = ?,seller = ?,admin = ?,general = ? where id = ?';
mysqli[824] = 'delete from templates where id = ?';
mysqli[825] = 'SELECT * FROM templates where method=? {{where}} ORDER BY id ASC {{limit}}';

mysqli[827] = 'insert into templates (title, subject, type, method, template, date_added, buyer, seller, admin, general, status) values(?,?,?,?,?,?,?,?,?,?,?)';
mysqli[828] = 'insert into templates (title,subject,type,method,template,date_added,buyer,seller,admin,general,status) values (?,?,?,?,?,?,?,?,?,?,?)';
mysqli[829] = 'update templates set title = ?, subject = ?, type = ?, template = ?,buyer = ?,seller = ?,admin = ?,general = ? where id = ?';
mysqli[830] = 'insert into mailer_management (name,user,pass,type,status) values(?,?,?,?,?)';
mysqli[831] = 'update mailer_management set name = ?, user = ?, pass = ?, type = ? where id= ?';
mysqli[832] = 'SELECT * FROM mailer_management ORDER BY id DESC {{limit}}';
mysqli[833] = 'SELECT * FROM mailer_management where id = ? limit 1' ;
mysqli[834] = 'delete from mailer_management where id = ?';
mysqli[835] = 'update mailer_management set status = 0 where id= ?';
mysqli[836] = 'SELECT count(id) as sum FROM mailer_management where type=? and status = 1';
mysqli[837] = 'update mailer_management set status = 1 where id= ?';
mysqli[838] = 'delete from hmb_feedback where id = ?';
mysqli['review_delete'] = 'delete from hmb_feedback where id in (?)';
mysqli[840] = 'SELECT * FROM templates where title=? and method = "email"';
mysqli[841] = 'SELECT * FROM mailer_management where type = "email" and status = 1 limit 1';
mysqli[842] = 'SELECT * FROM mailer_management where id = 2';
mysqli[843] = 'SELECT * FROM templates where title=? and method = "sms"';
mysqli[844] = 'select mu.*,mp.name as plan_name,m.name as rolename from membership_user as mu inner join membership_plan as mp on mp.id=mu.plan_id inner join membership as m on m.id=mp.membership_id inner join membership_permission as mpe on mpe.id=mp.permission_id where mu.user_id=? ';
mysqli[845] = 'update membership_user set paid = ? where user_id= ?';

mysqli[847] = 'delete from referral where id = ?';
mysqli[848] = 'SELECT SUM(points) as points FROM referral r    WHERE r.from_id = ? and r.status = 1  ' ;
mysqli[849] = 'SELECT r.to_id as user_id, r.source,r.date_added FROM referral r   WHERE r.from_id = ? and r.status = 1  order by r.id asc limit ?, 10';
mysqli[850] = 'SELECT r.to_id as user_id, r.source,r.date_added FROM referral r   WHERE r.from_id = ? and r.status = 1  order by r.id asc' ;
mysqli[851] = 'SELECT u.first_name,u.last_name,u.email,u.phone,p.user_id,p.id FROM projects p INNER JOIN users u ON u.id = p.user_id  WHERE p.user_id = ? and p.id = ?';
mysqli[852] = 'SELECT * FROM templates where title=? and method = "email"';
mysqli[853] = 'SELECT * FROM categories where parent_id= 0';
mysqli[854] = 'SELECT * FROM `categories` where parent_id != 0';

mysqli[855] = "SELECT title FROM projects";
/*Remianders*/
mysqli[899] = 'SELECT b.project_id,b.user_id,p.title, u.first_name, u.last_name, u.email, u.phone, b.proposed_amount,p.shipping_price, i.status, i.date_added FROM bids b INNER JOIN invoices i ON i.primary_id = b.project_id INNER JOIN users u ON u.id = b.user_id INNER JOIN projects p ON p.id = b.project_id WHERE i.status = "unpaid" AND b.awarded =1  AND i.date_added >= DATE_SUB( SYSDATE( ) , INTERVAL ? DAY ) AND b.user_id = ? AND b.project_id = ? limit 1';
mysqli[900] = 'SELECT b.project_id,b.user_id,p.title, u.first_name, u.last_name, u.email, u.phone, b.proposed_amount,p.shipping_price, i.status, i.date_added FROM bids b INNER JOIN invoices i ON i.primary_id = b.project_id INNER JOIN users u ON u.id = b.user_id INNER JOIN projects p ON p.id = b.project_id WHERE i.status = "unpaid" AND b.awarded =1  AND i.date_added >= DATE_SUB( SYSDATE( ) , INTERVAL ? DAY )';
mysqli[901] = 'SELECT b.id,b.project_id,b.user_id,p.title, u.first_name, u.last_name, u.email, u.phone, b.proposed_amount,p.shipping_price, i.status, i.date_added FROM bids b INNER JOIN invoices i ON i.primary_id = b.project_id INNER JOIN users u ON u.id = b.user_id INNER JOIN projects p ON p.id = b.project_id WHERE i.status = "unpaid" AND b.awarded =1  AND b.declined = 0 AND i.date_added <= DATE_SUB( SYSDATE( ) , INTERVAL ? DAY )';
mysqli[902] = 'SELECT b.id,b.user_id,b.project_id,p.title, u.first_name, u.last_name, u.email, u.phone, b.proposed_amount,p.shipping_price, i.status, i.date_added FROM bids b INNER JOIN invoices i ON i.primary_id = b.project_id INNER JOIN users u ON u.id = b.user_id INNER JOIN projects p ON p.id = b.project_id WHERE i.status = "unpaid" AND b.awarded =1  AND b.declined = 0 AND i.date_added <= DATE_SUB( SYSDATE( ) , INTERVAL ? DAY ) AND i.date_added >= DATE_SUB( SYSDATE( ) , INTERVAL ? DAY )';
mysqli[903] = 'update projects set date_closed = ?,market_status="open" where id= ?';
mysqli[904] = 'update bids set awarded = 0,declined = 1 where project_id = ?';
mysqli[905] = 'update buynow set active = 1 where user_id = ? and project_id = ?'; //in this table active to 1 means it is deactivated
mysqli[906] = 'update invoices set active = 1 where user_id = ? and primary_id = ?';//in this table active to 1 means it is deactivated
mysqli[907] = 'update proxybid set status = 0 where project_id = ?';
/*Remianders*/
/*Forums*/
mysqli[950] = 'SELECT * FROM `forum_categories` where type = ?';
mysqli[951] = 'INSERT INTO forum_questions (cid,uid,title,description,image,date_added) VALUES ( ?, ?, ?, ?, ?,? )';
mysqli[952] = 'SELECT f.*,fc.catname,fc.id as catid,u.first_name,u.last_name,u.created_at,u.avatar,(select count(id)from forum_questions where uid =f.uid) as post_count  from  forum_questions f inner join users u on u.id = f.uid inner join forum_categories fc on fc.id = f.cid  where f.id = ?';
mysqli[953] = 'SELECT f.*,u.first_name,u.last_name,u.created_at,u.avatar,(select count(id)from forum_questions where uid =f.uid) as post_count , (SELECT count(fqk.id) FROM `forum_question_kudos` as fqk where fqk.ansid= f.id) as kudos from  forum_answers f inner join users u on u.id = f.uid where f.qid = ? order by kudos desc limit ?,5';
mysqli[954] = 'INSERT INTO forum_answers (uid,qid,title,image,description,date_added) VALUES ( ?, ?, ?, ?, ?, ?)';
mysqli[955] = 'INSERT INTO forum_question_kudos (uid,qid,ansid,date_added) VALUES ( ?, ?, ?, ?)';
mysqli[956] = 'SELECT * FROM forum_question_kudos where qid = ? and ansid = 0 and uid = ?'
mysqli[957] = 'SELECT count(id) as kudos from forum_question_kudos where qid = ? and ansid = 0';
mysqli[958] = 'SELECT * FROM forum_question_kudos where qid = ? and ansid != 0 and uid = ? group by ansid';
mysqli[959] = 'update forum_questions set solution = 1 where id = ?';
mysqli[960] = 'update forum_answers set solution = 1 where id = ?';
mysqli[961] = 'SELECT *,(SELECT count(id) FROM forum_questions where cid  = fc.id and status = 1) as total_post FROM forum_categories fc';
mysqli[962] = 'SELECT fq.*,(select count(id) from forum_answers where qid = fq.id) as replies,(select count(id) from forum_question_kudos where qid = fq.id and ansid = 0) as kudos,u.first_name,u.last_name FROM forum_questions fq inner join users u on u.id = fq.uid where fq.cid = ? order by fq.date_added DESC';
mysqli[963] = 'update forum_questions set solution = 0 where id = ?';
mysqli[964] = 'update forum_answers set solution = 0 where id = ?';
mysqli[965] = 'DELETE FROM forum_question_kudos where uid = ? and qid = ? and ansid = 0';
mysqli[966] = 'DELETE FROM forum_question_kudos where uid = ? and ansid = ?';
mysqli[967] = 'SELECT * FROM `forum_categories` where id = ? limit 1';
mysqli[968] = 'update forum_categories set catname = ? where id = ?';
mysqli[969] = 'INSERT INTO forum_categories (catname,date_added) VALUES ( ?, ?)';
mysqli[970] = 'DELETE FROM forum_categories where id = ?';
mysqli[971] = 'SELECT * FROM forum_questions {{where}} limit 5';
mysqli[973] = 'SELECT fq.*,(select count(id) from forum_answers where qid = fq.id) as replies,(select count(id) from forum_question_kudos where qid = fq.id and ansid = 0) as kudos,u.first_name,u.last_name FROM forum_questions fq inner join users u on u.id = fq.uid where fq.cid = ? order by fq.date_added DESC limit ?, 10';
mysqli[974] = 'SELECT f.*,fc.catname,fc.id as catid,u.first_name,u.last_name,u.created_at,u.avatar,(select count(id)from forum_questions where uid =f.uid) as post_count  from  forum_questions f inner join users u on u.id = f.uid inner join forum_categories fc on fc.id = f.cid order by f.id DESC';
mysqli[975] = 'SELECT f.*,fc.catname,fc.id as catid,u.first_name,u.last_name,u.created_at,u.avatar,(select count(id)from forum_questions where uid =f.uid) as post_count  from  forum_questions f inner join users u on u.id = f.uid inner join forum_categories fc on fc.id = f.cid order by f.id DESC limit ?, 10';
mysqli[976] = 'DELETE FROM forum_questions where id = ?';
mysqli[977] = 'DELETE FROM forum_answers where id = ?';
mysqli[978] = 'update forum_questions set cid = ?,title = ?,description = ? where id = ?';
mysqli[979] = 'update forum_questions set cid = ?,title = ?,description = ?,image = ? where id = ?';
mysqli[980] = 'SELECT f.*,u.first_name,u.last_name,u.created_at,u.avatar,(select count(id)from forum_questions where uid =f.uid) as post_count , (SELECT count(fqk.id) FROM `forum_question_kudos` as fqk where fqk.ansid= f.id) as kudos from  forum_answers f inner join users u on u.id = f.uid where f.qid = ? order by kudos desc';
mysqli[981] = 'SELECT * FROM `forum_questions` where title = ? limit 1';
mysqli[982] = 'SELECT a.*,p.title FROM `product_images` as a inner join projects as p on p.id = a.project_id inner join buynow as b on b.project_id = p.id where a.type = "digital"and b.id = ? and b.user_id = ?';
mysqli[983] = 'SELECT * FROM `product_images` where project_id = ? and type = "digital"';

/*Forums*/
mysqli[700] = 'select * from notification_types';
mysqli[701] = 'update users set status = "deactivate"  where id = ?';
mysqli[702] = 'select * from location WHERE parent_id= 0 ORDER BY name ASC';
mysqli[703] = 'delete from membership_plan where id = ?';
mysqli[704] = 'delete from membership_plan where membership_id = ?';
mysqli[705] = 'delete from membership where id = ?';
mysqli[706] = 'delete from membership_plan where permission_id = ?';
mysqli[708] = 'delete from membership_permission where id = ?';
mysqli[709] = 'delete from membership_user where plan_id = ?';
mysqli[710] = 'select id from membership_plan where membership_id = ?';
mysqli[711] = 'select id from membership_plan where permission_id = ?';
mysqli[712] = 'SELECT * FROM shippers  ORDER BY shipperid ASC {{limit}}';
mysqli[713] = 'INSERT INTO shippers (title,shipcode, domestic,international,carrier,trackurl,sort) VALUES ( ?, ?, ?, ?, ?, ?,? )';
mysqli[714] = 'DELETE FROM shippers  WHERE shipperid = ?';
mysqli['cat1']  = 'SELECT * FROM categories WHERE parent_id = ? ORDER BY name ASC';
mysqli['cat1']  = 'SELECT * FROM categories WHERE parent_id = ? ORDER BY name ASC';
mysqli['static1'] = 'select * from static_pages';
mysqli['static2'] = 'select * from static_pages where id = ?';
mysqli['static_by_name'] = 'select * from static_pages where name = ?';
mysqli['static3'] = 'update static_pages set content = ? where id = ?';
mysqli['savesearch'] = 'insert into saved_search (title,url,uid,date_added,searchtext) values (?,?,?,?,?)';
mysqli['savedsearch'] = 'select s.*,date_format(s.date_added,"%a, %M %d %Y %h:%i %p") as added from saved_search as s where s.uid=? order by s.id DESC limit ?,10';
mysqli['savedsearch1'] = 'select s.*,date_format(s.date_added,"%a, %M %d %Y %h:%i %p") as added from saved_search as s where s.uid=? order by s.id ';
mysqli['deletesearch'] = 'delete from saved_search where id = ? and uid = ? limit 1';

mysqli['inboxDelete'] = 'update pmb set to_status = ? where id IN ({{del_id}})';

mysqli['sentboxDelete'] = 'update pmb set from_status = ? where id IN ({{del_id}})';
mysqli['adminmsgdelete'] = 'update pmb_pool set del_status = 1 where id = ?';
mysqli['delete_credit_card'] = 'delete FROM creditcards WHERE token_id = ? AND user_id = ?'


mysqli['stores_1'] = 'insert into stores (name,description,pname,phone,location,city,state,state_abbr,zip,user_id,status,logo,date_added,address) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['stores_2'] = 'select IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = s.id),0) as store_rating, ue.business_type as u_business_type, s.*,DATE_FORMAT(s.date_started,"%Y/%m/%d %H:%i") as dated_started,DATE_FORMAT(s.date_started,"%d %M, %Y at %H:%i") as date_starts from stores s left join user_extras ue on s.user_id = ue.user_id where {{where}}';
mysqli['stores_3'] = 'SELECT p2.*,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 0,1) as img1,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 1,1) as img2,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 2,1) as img3  FROM projects  as p2 where p2.id IN (select si.project_id from store_items as si where si.store_id = ? and si.visible = 1) {{where}}';
/*mysqli['stores_strpdt'] = 'SELECT p2.*,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 0,1) as img1,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 1,1) as img2,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 2,1) as img3, (SELECT pd.name from categories as pd where p2.category_id = pd.id) as catname, (SELECT count(id) from negotiable as bd where p2.id = bd.project_id and bd.user_id = ?) as bidcount,(SELECT st.store_id from store_items as st where st.store_id = ? group by st.store_id ) as storeid  FROM projects  as p2 where p2.id IN (select si.project_id from store_items as si where si.store_id = ? and si.visible = 1) {{where}} ';*/
mysqli['stores_strpdt'] = 'SELECT p2.*,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 0,1) as img1,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 1,1) as img2,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 2,1) as img3, (SELECT pd.name from categories as pd where p2.category_id = pd.id) as catname, (SELECT count(id) from negotiable as bd where p2.id = bd.project_id and bd.user_id = ?) as bidcount, (SELECT count(id) from negotiable as bd where p2.id = bd.project_id) as p_bidcount, (SELECT st.store_id from store_items as st where st.store_id = ? group by st.store_id ) as storeid  FROM projects  as p2 where p2.id IN (select si.project_id from store_items as si where si.store_id = ? and si.visible = 1) {{where}} ';
mysqli['stores_4'] = 'select c.id,c.name,c.parent_id,(select count(p.id) from projects as p where p.category_id IN (select cc.id from categories as cc where cc.lft between c.lft and c.rgt)  and p.id IN (select si.project_id from store_items as si where si.store_id = ?  and si.visible = 1)) as cnt,(COUNT(parent.id) - 1) AS depth from categories as c, categories AS parent where c.lft BETWEEN parent.lft AND parent.rgt  group by c.id   order by c.lft asc';
mysqli['stores_5'] = 'SELECT p2.*,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 0,1) as img1,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 1,1) as img2,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 2,1) as img3  FROM projects  as p2 where  p2.id IN (select si.project_id from store_items as si where si.store_id = ?  and si.visible = 1)  and p2.feature = 1';
mysqli['stores_6'] = 'SELECT p2.*,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 0,1) as img1,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 1,1) as img2,(SELECT pi.avatar from product_images as pi where pi.project_id = p2.id and pi.type = "image" order by pi.id asc limit 2,1) as img3  FROM projects  as p2 where  p2.id NOT IN (select si.project_id from store_items as si where si.store_id {{storeid}}  and si.visible = 1) and p2.auction = 0 and p2.vauction = 0 and p2.market_status != "closed" and p2.user_id = ? {{where}} order by p2.id desc';
mysqli['stores_7'] = 'update projects set storeid = ? where id = ? and user_id = ?';
mysqli['stores_8'] = 'insert into store_items (project_id,store_id,date_added) values(?,?,?)';
mysqli['stores_9'] = 'update stores set name=?,location=?,description=?,website=?,logo=?,date_started=?,banner = ? where id = ? and user_id =?';
mysqli['stores_10'] = 'select IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = s.id),0) as store_rating, s.*,DATE_FORMAT(date_added,"%m/%d/%Y: %H:%i") as date_added, (select count(si.project_id) as cnt from store_items as si where si.store_id = s.id) as products,(select sum(p.sold) as cnt from projects  as  p where p.id in (select si.project_id from store_items as si where si.store_id = s.id  and si.visible = 1)) as saled, (select count(ib.id) as cnt from buynow as ib where ib.project_id IN (select isi.project_id from store_items as isi where isi.store_id = s.id and isi.visible = 1) AND ib.user_id=? ) as my_total_purchased from stores as s where 1=1 {{where}} {{whr}} order by s.id desc';
mysqli['stores_11'] =' update stores set name=?, pname=?, phone=?, address=?, city=?, state=?, zip=?, description=?, logo=? where id = ?';
mysqli['stores_12'] =' DELETE FROM stores WHERE id= ?';
mysqli['stores_13'] = 'select s.*,DATE_FORMAT(date_started,"%Y/%m/%d %H:%i") as dated_started,DATE_FORMAT(date_started,"%d %M, %Y at %H:%i") as date_starts from stores s where user_id = ?';
mysqli['stores_14'] = 'select s.* from stores as s where s.id = ?';
mysqli['storeDetails'] = 'select store_id from store_items where project_id = ? limit 1';
mysqli['stores_15'] = 'update store_items set visible = 0 where project_id = ? and store_id = ? and visible = 1 limit 1';
mysqli['country_list'] = 'SELECT * FROM locations WHERE visible = 1';
mysqli['stores_16'] = 'select IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = s.id),0) as store_rating, s.*,DATE_FORMAT(date_added,"%m/%d/%Y: %H:%i") as date_added, (select count(si.project_id) as cnt from store_items as si where si.store_id = s.id) as products,(select sum(p.sold) as cnt from projects  as  p where p.id in (select si.project_id from store_items as si where si.store_id = s.id  and si.visible = 1)) as saled, (select count(ib.id) as cnt from buynow as ib where ib.project_id IN (select isi.project_id from store_items as isi where isi.store_id = s.id and isi.visible = 1) AND ib.user_id=? ) as my_total_purchased from stores as s where 1=1 {{where}} {{whr}} order by s.id desc limit ?, 10';
mysqli['getstoreid'] = 'select id from stores where user_id = ? ORDER BY id DESC';
mysqli['ads_product_details'] = 'select p.* from projects as p  where p.id = ? limit 1';

mysqli['state_list'] = 'SELECT * FROM locations_states WHERE visible = 1 AND locationid = (SELECT locationid from locations WHERE location_eng = ?)';

mysqli['update_local_pickup_cart'] = 'update buynow set `paid` = 2,local_pick = 1,cart_id = ?,`paid_date` = ?,`release` = ?,r_date = ?,escrow = ? where id = ? limit 1';

mysqli['delete_buybow'] = 'delete from checkout where buynowid = ? limit 1';

mysqli['update_attach_limit'] = 'update projects SET used_image_space = used_image_space + ? WHERE id = ?';

/*Reports*/
mysqli[600] = 'select i.*,b.id as buyid,us.first_name,us.last_name from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join users as us on us.id  = p.user_id inner join users as u on u.id = i.user_id where  i.active = 0 and i.status = ? and DATE( i.date_added ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) {{order}} {{limit}}';
mysqli[601] = 'select i.*,b.id as buyid,us.first_name,us.last_name from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join users as us on us.id  = p.user_id inner join users as u on u.id = i.user_id where  i.active = 0 and i.status = ? and DATE( i.date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[602] = 'select i.*,b.id as buyid,us.first_name,us.last_name from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join users as us on us.id  = p.user_id inner join users as u on u.id = i.user_id where  i.active = 0 and i.status = ? and DATE( i.date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[603] = 'select i.*,b.id as buyid,us.first_name,us.last_name from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join users as us on us.id  = p.user_id inner join users as u on u.id = i.user_id where  i.active = 0 and i.status = ? and DATE( i.date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[604] = 'select i.*,b.id as buyid,us.first_name,us.last_name from invoices as i left join buynow as b on b.project_id = i.primary_id and b.win = 1 and b.active = 0 inner join projects as p on p.id = i.primary_id inner join users as us on us.id  = p.user_id inner join users as u on u.id = i.user_id where  i.active = 0 and i.status = ? and DATE( i.date_added ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';

// mysqli[605] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE(date_closed) >= SYSDATE() and (market_status = "open" ) and DATE( date_added ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) {{order}} {{limit}}';
// mysqli[606] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE(date_closed) >= SYSDATE() and (market_status = "open" ) and DATE( date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
// mysqli[607] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE(date_closed) >= SYSDATE() and (market_status = "open" ) and DATE( date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
// mysqli[608] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE(date_closed) >= SYSDATE() and (market_status = "open" ) and DATE( date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
// mysqli[609] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE(date_closed) >= SYSDATE() and (market_status = "open" ) and DATE( date_added ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';
mysqli[605] = 'select p.* from projects AS p where p.market_status !="removed" and (market_status = "open" ) and DATE( date_added ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) {{order}} {{limit}}';
mysqli[606] = 'select p.* from projects AS p where p.market_status !="removed" and (market_status = "open" ) and DATE( date_added ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) {{order}} {{limit}}';
mysqli[607] = 'select p.* from projects AS p where p.market_status !="removed" and (market_status = "open" ) and DATE( date_added ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) {{order}} {{limit}}';
mysqli[608] = 'select p.* from projects AS p where p.market_status !="removed" and (market_status = "open" ) and DATE( date_added ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) {{order}} {{limit}}';
mysqli[609] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE(date_closed) >= SYSDATE() and (market_status = "open" ) and DATE( date_added ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';

mysqli[610] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and market_status NOT IN ("draft","sold") and ((market_status = "closed") or date_closed < SYSDATE( ) ) and DATE( date_closed ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) {{order}} {{limit}}';
mysqli[611] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and market_status NOT IN ("draft","sold") and ((market_status = "closed") or date_closed < SYSDATE( ) ) and DATE( date_closed ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[612] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and market_status NOT IN ("draft","sold") and ((market_status = "closed") or date_closed < SYSDATE( ) ) and DATE( date_closed ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[613] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and market_status NOT IN ("draft","sold") and ((market_status = "closed") or date_closed < SYSDATE( ) ) and DATE( date_closed ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[614] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and market_status NOT IN ("draft","sold") and ((market_status = "closed") or date_closed < SYSDATE( ) ) and DATE( date_closed ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';

mysqli[615] = 'select p.*,b.id as b_id,u.first_name,u.last_name,b.paid_date from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id = b.user_id where b.qty > 0 and DATE( b.paid_date ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) {{order}} {{limit}}';
mysqli[616] = 'select p.*,b.id as b_id,u.first_name,u.last_name,b.paid_date from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id = b.user_id where b.qty > 0 and DATE( b.paid_date ) > DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) {{order}} {{limit}}';
mysqli[617] = 'select p.*,b.id as b_id,u.first_name,u.last_name,b.paid_date from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id = b.user_id where b.qty > 0 and DATE( b.paid_date ) > DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) {{order}} {{limit}}';
mysqli[618] = 'select p.*,b.id as b_id,u.first_name,u.last_name,b.paid_date from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id = b.user_id where b.qty > 0 and DATE( b.paid_date ) > DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) {{order}} {{limit}}';
mysqli[619] = 'select p.*,b.id as b_id,u.first_name,u.last_name,b.paid_date from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id = b.user_id where b.qty > 0  and DATE( b.paid_date ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';

mysqli[620] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE( date_closed ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) )  {{order}} {{limit}}';
mysqli[621] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE( date_closed ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[622] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE( date_closed ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[623] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE( date_closed ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) AND DATE( SYSDATE( ) )  {{order}} {{limit}}';
mysqli[624] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE( date_closed ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';

mysqli[625] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 0  and b.qty > 0 and DATE( r_date ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) {{order}} {{limit}}'
mysqli[626] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 0  and b.qty > 0 and DATE( r_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}'
mysqli[627] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 0  and b.qty > 0 and DATE( r_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}'
mysqli[628] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 0  and b.qty > 0 and DATE( r_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}'
mysqli[629] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 0  and b.qty > 0 and DATE( r_date ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}'

mysqli[630] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 1 and b.paid= 1 and b.qty > 0 and DATE( r_date ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}';
mysqli[631] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 1 and b.paid= 1 and b.qty > 0 and DATE( r_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}';
mysqli[632] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 1 and b.paid= 1 and b.qty > 0 and DATE( r_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}';
mysqli[633] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 1 and b.paid= 1 and b.qty > 0 and DATE( r_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}';
mysqli[634] = 'select p.id as id,p.user_id as sid,u.first_name,u.last_name,us.first_name as sell_first,us.last_name as sell_last,b.date_added,b.project_id,b.user_id,b.amount,b.ordered,b.cart_id,b.qty,b.refund,b.release,b.r_date,b.feedback,b.paid,b.tracking_number,b.tracking_service,b.win,b.shipping_info,b.escrow,b.commission,b.id as b_id,p.title,p.avatar,p.image,date_format(b.date_added,"%M %D,%Y") as date_add,b.amount as proposed_amount,b.refund as refund_amount,p.buynow  from buynow as b inner join projects as p on b.project_id = p.id left join users u on u.id= b.user_id left join users us on us.id = p.user_id where b.win = 1 and b.paid= 1 and b.qty > 0 and DATE( r_date ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';

mysqli[635] = 'SELECT CONCAT( u.first_name,  " ", u.last_name ) AS name,u.id as sid, p.title, c . * , b.id AS buynow_id, b.commission,  b.paid, b.release, p.title, b.project_id, DATE_FORMAT( b.date_added,  "%M %d %Y %h:%i:%s %p" ) AS create_date, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date, DATE_FORMAT( b.r_date,"%M %d %Y %h:%i:%s %p" ) AS r_date, b.admin, b.amount AS amt, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date FROM buynow AS b INNER JOIN projects AS p ON p.id = b.project_id INNER JOIN users AS us ON us.id = b.user_id INNER JOIN users AS u ON u.id = p.user_id  INNER JOIN checkout AS c ON c.id = b.cart_id and DATE( b.paid_date ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}';
mysqli[636] = 'SELECT CONCAT( u.first_name,  " ", u.last_name ) AS name,u.id as sid, p.title, c . * , b.id AS buynow_id, b.commission,  b.paid, b.release, p.title, b.project_id, DATE_FORMAT( b.date_added,  "%M %d %Y %h:%i:%s %p" ) AS create_date, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date, DATE_FORMAT( b.r_date,"%M %d %Y %h:%i:%s %p" ) AS r_date, b.admin, b.amount AS amt, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date FROM buynow AS b INNER JOIN projects AS p ON p.id = b.project_id INNER JOIN users AS us ON us.id = b.user_id INNER JOIN users AS u ON u.id = p.user_id  INNER JOIN checkout AS c ON c.id = b.cart_id and DATE( b.paid_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}';
mysqli[637] = 'SELECT CONCAT( u.first_name,  " ", u.last_name ) AS name,u.id as sid, p.title, c . * , b.id AS buynow_id, b.commission,  b.paid, b.release, p.title, b.project_id, DATE_FORMAT( b.date_added,  "%M %d %Y %h:%i:%s %p" ) AS create_date, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date, DATE_FORMAT( b.r_date,"%M %d %Y %h:%i:%s %p" ) AS r_date, b.admin, b.amount AS amt, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date FROM buynow AS b INNER JOIN projects AS p ON p.id = b.project_id INNER JOIN users AS us ON us.id = b.user_id INNER JOIN users AS u ON u.id = p.user_id  INNER JOIN checkout AS c ON c.id = b.cart_id and DATE( b.paid_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}';
mysqli[638] = 'SELECT CONCAT( u.first_name,  " ", u.last_name ) AS name,u.id as sid, p.title, c . * , b.id AS buynow_id, b.commission,  b.paid, b.release, p.title, b.project_id, DATE_FORMAT( b.date_added,  "%M %d %Y %h:%i:%s %p" ) AS create_date, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date, DATE_FORMAT( b.r_date,"%M %d %Y %h:%i:%s %p" ) AS r_date, b.admin, b.amount AS amt, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date FROM buynow AS b INNER JOIN projects AS p ON p.id = b.project_id INNER JOIN users AS us ON us.id = b.user_id INNER JOIN users AS u ON u.id = p.user_id  INNER JOIN checkout AS c ON c.id = b.cart_id and DATE( b.paid_date ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) AND DATE( SYSDATE( ) ) {{order}} {{limit}}';
mysqli[639] = 'SELECT CONCAT( u.first_name,  " ", u.last_name ) AS name,u.id as sid, p.title, c . * , b.id AS buynow_id, b.commission,  b.paid, b.release, p.title, b.project_id, DATE_FORMAT( b.date_added,  "%M %d %Y %h:%i:%s %p" ) AS create_date, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date, DATE_FORMAT( b.r_date,"%M %d %Y %h:%i:%s %p" ) AS r_date, b.admin, b.amount AS amt, DATE_FORMAT( b.paid_date,  "%M %d %Y %h:%i:%s %p" ) AS pay_date FROM buynow AS b INNER JOIN projects AS p ON p.id = b.project_id INNER JOIN users AS us ON us.id = b.user_id INNER JOIN users AS u ON u.id = p.user_id  INNER JOIN checkout AS c ON c.id = b.cart_id and DATE( b.paid_date ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';

mysqli['ads_day'] = 'select a.* from adwords AS a where DATE( a.created_at ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) {{order}} {{limit}}';
mysqli['ads_week'] = 'select a.* from adwords AS a where DATE( a.created_at ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) {{order}} {{limit}}';
mysqli['ads_month'] = 'select a.* from adwords AS a where DATE( a.created_at ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) {{order}} {{limit}}';
mysqli['ads_year'] = 'select a.* from adwords AS a where DATE( a.created_at ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) {{order}} {{limit}}';
mysqli['ads'] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE(date_closed) >= SYSDATE() and (market_status = "open" ) and DATE( date_added ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';

/* Risk management reports */
mysqli['risk_day'] = 'select rp.* from recurring_purchase AS rp where DATE( rp.date_added ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) ) {{order}} {{limit}}';
mysqli['risk_week'] = 'select rp.* from recurring_purchase AS rp where DATE( rp.date_added ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) {{order}} {{limit}}';
mysqli['risk_month'] = 'select rp.* from recurring_purchase AS rp where DATE( rp.date_added ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) {{order}} {{limit}}';
mysqli['risk_year'] = 'select rp.* from recurring_purchase AS rp where DATE( rp.date_added ) >= DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) {{order}} {{limit}}';
mysqli['risk'] = 'select p.*,u.first_name,u.last_name,(select count(distinct b.user_id) as bid from bids as b  where p.id = b.project_id AND b.user_id > 0) as bids from projects AS p inner join users u on u.id= p.user_id where p.market_status !="removed" and DATE(date_closed) >= SYSDATE() and (market_status = "open" ) and DATE( date_added ) BETWEEN DATE( ? ) AND DATE( ? ) {{order}} {{limit}}';


/*Reports Ends*/

/*Notication Starts */
/*mysqli[650] = 'SELECT * from notification_titles where status = 1';
mysqli[651] = 'SELECT * from notification_titles where buyer = 1 and status = 1';
mysqli[652] = 'SELECT * from notification_titles where seller = 1 and status = 1';*/
mysqli['templates_id'] = 'SELECT id from templates';
mysqli[650] = 'SELECT * from templates where status = 1';
mysqli[651] = 'SELECT * from templates where buyer = 1 and status = 1';
mysqli[652] = 'SELECT * from templates where seller = 1 and status = 1';

mysqli[653] = 'insert into user_notification (user_id,email,sms) values(?,?,?)';
mysqli[654] = 'SELECT * from user_notification where user_id = ? limit 1';
mysqli[655] = 'update user_notification set user_id=?,email=?,sms=? where id = ?';
mysqli[656] = 'update users set phone=?,verifyphone = 1 where id = ?';
mysqli[657] = 'select verifyphone,phone from users where id = ?';

mysqli[660] = 'SELECT * from user_notification where user_id = ? and FIND_IN_SET (?, email)';
mysqli[661] = 'SELECT * from user_notification where user_id = ? and FIND_IN_SET (?, sms)';
mysqli[662] = 'update users set balance_amount = balance_amount+?,balance = balance+? where id  = ?';
mysqli[663] = 'update users set balance_amount = balance_amount-? where id  = ?';
mysqli[664] = 'select * from withdrawals where id = ?';
/*Notification Ends */



mysqli[278] = 'insert into banner(title,subtitle,image,o_image,cid,enable,date_added,offer_price) values(?,?,?,?,?,?,?,?)';
mysqli[279] = 'update banner set title = ?,subtitle = ?,image = ?,o_image=?,cid = ?,enable = ?,offer_price = ? where id = ?';
mysqli[280] = 'select * from banner where id = ?';
mysqli[275] = 'select b.*,c.name as ctitle from banner as b left join categories as c on b.cid = c.id order by b.id asc limit ?,10';
mysqli[276] = 'select b.id from banner as b left join categories as c on b.cid = c.id';

mysqli['insert_adwords'] = 'INSERT INTO adwords (ad_name,ad_title,ad_content,ad_url,banner,show_continue,days_week,target_sec_id,keywords,budget_per_click,budget_per_day,user_id,created_at,end_date,store_id,featured,type,product_id,brand_name,existing_img,start_day,total_clicks_allowed,amount) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

mysqli['get_adwords_details'] = 'SELECT * from adwords WHERE status != "remove" AND user_id = ? {{limit}}';
mysqli['adwords_details'] = 'SELECT store_id from adwords WHERE id = ? limit 1';
mysqli['purchaseclick'] = 'update adwords SET s_click = s_click + 1 WHERE id = ? limit 1';
mysqli['purchaseclickads'] = 'update ads_track SET s_click = s_click + 1 WHERE ads_id = ? and date_added = ? limit 1';

mysqli['get_all_adwords_details'] = 'SELECT * from adwords WHERE status != "remove" {{limit}}';

mysqli['adwords_delete_pause'] = 'UPDATE adwords SET status = ? WHERE id =? AND user_id = ?';

mysqli['get_adwords_by_id'] = 'SELECT * FROM adwords WHERE id = ?';

mysqli['update_deposit'] = 'UPDATE users set deposit_amount = deposit_amount + ? WHERE id = ?' ;

mysqli['update_adwords'] = 'UPDATE adwords set ad_name = ?,ad_title = ?,ad_content = ?,ad_url = ?,banner =?,show_continue =?,days_week = ?,target_sec_id = ?,keywords = ?,budget_per_click = ?,budget_per_day = ?,user_id =?,updated_at = ?,end_date = ?,start_day=?,product_id=?,brand_name=? WHERE id = ?';

// mysqli['show_ads'] = 'SELECT a.* FROM adwords a JOIN users u ON u.id = a.user_id AND u.deposit_amount > 0 WHERE if(a.days_week != "" ,FIND_IN_SET(DAYNAME(curdate()),a.days_week),true) AND if(a.target_sec_id != "",FIND_IN_SET(?,a.target_sec_id),true) AND if(a.end_date !="0000-00-00",a.end_date = CURDATE(),true) AND a.status = "active" AND budget_per_day DIV budget_per_click > no_of_clicks LIMIT 0,5';
mysqli['show_ads'] = 'SELECT a.* FROM adwords a WHERE if(a.days_week != "" ,FIND_IN_SET(DAYNAME(curdate()),a.days_week),true) AND if(a.target_sec_id != "",FIND_IN_SET(?,a.target_sec_id),true) AND if(a.end_date !="0000-00-00",a.end_date = CURDATE(),true) AND a.status = "active" AND budget_per_day DIV budget_per_click > no_of_clicks LIMIT 0,5';
mysqli['directbuy_ads'] = 'SELECT ue.user_id, ue.business_type, ue.state, ue.state_abbr, IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = a.store_id),0) as store_rating, a.* {{innerq}} FROM adwords a left join user_extras as ue on a.user_id = ue.user_id WHERE if(a.days_week != "" ,FIND_IN_SET(DAYNAME(curdate()),a.days_week),true) AND if(a.target_sec_id != "",FIND_IN_SET(?,a.target_sec_id),true) AND if(a.end_date !="0000-00-00",a.end_date >= CURDATE(),true) AND a.status = "active" AND IF(ue.business_type="producer" OR ue.business_type="grower", 1, a.budget_per_day DIV a.budget_per_click >= a.no_of_clicks) = 1 {{where}} and {{condition}}  ORDER BY rand()  {{limit}}';
mysqli['directbuy_top_sellers'] ='SELECT count(b.id) as scount ,s.name ,p.user_id FROM buynow as b inner JOIN projects p on b.project_id =p.id  INNER JOIN stores as s  on p.user_id = s.user_id WHERE YEAR(b.date_added) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(b.date_added) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)   GROUP BY s.id ORDER BY scount DESC Limit 0,10';
mysqli['directbuy_trending'] ='SELECT  views,name FROM `stores`  ORDER BY   views  DESC LIMIT 0,10';
mysqli['directbuy_top_movers'] ='SELECT count(b.id) as scount ,s.name ,p.user_id ,IFNULL((SELECT count(b1.id) as scount1  FROM buynow as b1 inner JOIN projects p1 on b1.project_id =p1.id  INNER JOIN stores as s1  on p1.user_id = s1.user_id WHERE YEAR(b1.date_added) = YEAR(CURRENT_DATE - INTERVAL 2 MONTH) AND MONTH(b1.date_added) = MONTH(CURRENT_DATE - INTERVAL 2 MONTH)  AND s1.id=s.id ),0)as scount2   FROM buynow as b inner JOIN projects p on b.project_id =p.id  INNER JOIN stores as s  on p.user_id = s.user_id WHERE YEAR(b.date_added) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(b.date_added) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)   GROUP BY s.id ORDER BY scount DESC Limit 0,10';
// mysqli['featuredStores'] = 'SELECT IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = a.store_id),0) as store_rating, a.* {{innerq}} FROM adwords a left join user_extras as ue on a.user_id = ue.user_id WHERE  if(a.end_date !="0000-00-00",a.end_date >= CURDATE(),true) and (ue.business_type="supplier" or ue.state = ?) AND a.status = "active" AND budget_per_day DIV budget_per_click > no_of_clicks {{where}}   {{limit}}';
mysqli['featuredStores'] = 'SELECT IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = a.store_id),0) as store_rating, a.* {{innerq}} FROM adwords a left join user_extras as ue on a.user_id = ue.user_id WHERE  if(a.end_date !="0000-00-00",a.end_date >= CURDATE(),true) and (ue.business_type!="supplier" and ue.state = ?) AND a.status = "active" AND budget_per_day DIV budget_per_click > no_of_clicks {{where}}   {{limit}}';

mysqli['reduce_deposit'] = 'UPDATE users set deposit_amount = deposit_amount - ? WHERE id = ?' ;

mysqli['update_ads_clicks'] = 'UPDATE adwords SET no_of_clicks = no_of_clicks + 1 WHERE id = ?';

mysqli['user_in_proxybid'] = 'SELECT * FROM proxybid WHERE project_id = ? AND user_id = ? and status = 1';

mysqli['update_proxybid'] = 'UPDATE proxybid SET maxamount = ?,date_added = ?  WHERE project_id = ? AND user_id = ? and status = 1';

mysqli['insert_proxybid'] = 'INSERT INTO proxybid (project_id,user_id,maxamount,date_added,status) VALUES (?,?,?,?,1)';

mysqli['get_proxy_details'] = 'SELECT * FROM proxybid {{where}}';

mysqli['get_last_bidamount'] = 'SELECT * FROM bids WHERE project_id = ? and declined = 0 ORDER BY proposed_amount desc LIMIT 1';

mysqli['insert_bid_as_proxy'] = 'INSERT INTO bids (project_id,user_id,proposed_amount,created_at,proposal) VALUES (?,?,?,?,?)';

mysqli['proxy_bid_award'] = 'select b.id,b.maxamount as proposed_amount,b.user_id,u.first_name,u.email,u.phone,u.last_name,b.project_id from proxybid as b inner join users as u on u.id = b.user_id where b.status = 1 and b.project_id = ? order by b.maxamount desc limit 1';

mysqli['get_all_adwords_details'] = 'SELECT a.* FROM adwords a JOIN users u ON u.id = a.user_id AND u.deposit_amount > 0 WHERE if(a.days_week != "" ,FIND_IN_SET(DAYNAME(curdate()),a.days_week),true) AND if(a.target_sec_id != "",FIND_IN_SET(?,a.target_sec_id),true) AND if(a.end_date !="0000-00-00",a.end_date = CURDATE(),true) AND a.status = "active" AND budget_per_day DIV budget_per_click > no_of_clicks {{limit}}';

mysqli['classified1'] = 'INSERT INTO classified_projects (user_id,want,title,cid,description,price,`condition`,utype,name,email,city,state,country,zip,phone,status,date_added,date_closed) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['classified2'] = 'insert into product_images (avatar,image,date_added,classified_id) values (?,?,?,?) ';
mysqli['classified3'] = 'select p.*,c.name as ctitle,pc.name as pctitle,date_format(p.date_closed,"%m/%d/%Y") as date_close,u.first_name,u.email,u.phone,u.last_name,c.name,u.review,u.avatar as uimage from classified_projects as p left join categories as c on c.id = p.cid left join categories as pc on c.parent_id = pc.id left join users as u on u.id = p.user_id where p.id = ? limit 1';
mysqli['classified4'] = 'select * from product_images where classified_id = ?';
mysqli['classified5'] = 'select p.*,(select pi.avatar from product_images as pi where pi.classified_id = p.id order by pi.id asc limit 1) as avatar  from classified_projects as p where p.status ="active" and p.id != ?';
mysqli['classified6'] = 'select p.*,(select pi.avatar from product_images as pi where pi.classified_id = p.id order by pi.id asc limit 1) as avatar  from classified_projects as p inner join categories as c on p.cid = c.id where p.status ="active" {{where}}';
mysqli['classified8'] = 'select p.*,(select pi.avatar from product_images as pi where pi.classified_id = p.id order by pi.id asc limit 1) as avatar  from classified_projects as p inner join categories as c on p.cid = c.id  where p.status ="active" {{where}}';
mysqli['classified7'] = 'select p.*,(select pi.avatar from product_images as pi where pi.classified_id = p.id order by pi.id asc limit 1) as avatar  from classified_projects as p inner join categories as c on p.cid = c.id  where p.id > 0 {{where}}';
mysqli['classified9'] = 'select p.*,u.first_name,u.email,u.phone,u.last_name,c.name,u.review,u.avatar as uimage from classified_projects as p left join categories as c on c.id = p.cid left join users as u on u.id = p.user_id where p.id = ? limit 1';
mysqli['classified10'] = 'select id from watchlists where user_id = ? and classified_id = ? limit 1';
mysqli['classified11'] = 'INSERT INTO watchlists (id,classified_id,user_id,date_added) VALUES (NULL, ?, ?, ?)';

mysqli['insert_img'] = 'insert into product_images (id,image,avatar,date_added,random_id) values(NULL,?,?,?,?)';

mysqli['reset_no_of_clicks'] = 'UPDATE adwords SET no_of_clicks = 0 WHERE status = "active" ';

mysqli['update_projectid_in_imgtable'] = 'update product_images set project_id = ? where random_id = ?';

mysqli['delete_images'] = 'delete from product_images where id = ?';

mysqli['yab6'] = 'update checkout set  cart_temp_details = ? where id = ? limit 1';



mysqli['yab2'] = 'insert into checkout (date_added,first_name,last_name,phone,email,address,country,state,city,zipcode,user_id,buynowid,amount) values (?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['yab3'] = 'delete from checkout where buynowid = ? limit 1';
mysqli['update_cart_details'] = 'update checkout set  `paid` = ?, `paid_date` = ?,trans_id = ?  where id = ? limit 1';
mysqli['yab5'] = 'select * from checkout where buynowid = ? limit 1';
mysqli['yab13'] = 'update invoices  set `status` = "paid",  buynow_id = ?, cart_id = ? where primary_id = ?';
mysqli['yab14'] = 'insert into product_images (avatar,image,date_added,project_id) values (?,?,?,?) ';
mysqli['yab15'] = 'delete from product_images where id = ? limit 1';
mysqli['yab16'] = 'update product_images set  project_id = ? where id = ? limit 1';
mysqli['yab17'] = 'select * from product_images where id = ? limit 1';
mysqli['yab18'] = 'update projects set  avatar = ?, image = ?  where id = ? limit 1';
// mysqli['yab19'] = 'select u.first_name,u.last_name,u.email,p.shipping_price, p.bprice,p.id,p.user_id,p.title,u.phone,p.qty,p.booked,p.sold  from projects AS p inner join users as u on p.user_id = u.id where p.id = ? group by p.id limit 1';
mysqli['yab19'] = 'select p.shipping_price, p.bprice,p.id,p.user_id,p.title,p.qty,p.booked,p.sold  from projects AS p where p.id = ? group by p.id limit 1';
mysqli['yab20'] = 'select u.first_name,u.last_name,u.email,u.id,u.phone from users as u where u.id = ? group by u.id limit 1';
mysqli['yab21'] = 'delete from cart_temp where user_id = ?';

// mysqli['yab22'] = 'insert into buynow (project_id,user_id,amount,date_added,ordered,cart_id,qty,refund,win,paid,paid_date,`release`,r_date,`escrow`,commission,local_pick,admin) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1)';
// mysqli['yab22'] = 'insert into buynow (user_id,project_id,qty,amount,commission,accept, date_added, total_amount, commission_per, stax_status, stax_per, stax_amt, cart_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?)';
// mysqli['yab22'] = 'insert into buynow (user_id,project_id,qty,amount,commission,accept, date_added, total_amount, commission_per, stax_status, stax_per, stax_amt, cart_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?)';

/* ===================== start change by divyesh (changes) ===================== */
mysqli['yab22'] = 'insert into buynow (user_id,project_id,qty,amount,commission,accept, date_added, total_amount, commission_per, stax_status, stax_per, stax_amt, consultant_fee, consultant_fee_amount, cart_id, recurring, rec_purchase_id, rec_schedule_id, cancel_ins_status, cancel_ins_per, cancel_ins_amt, request_userid, reserve_amt,excise_markup_per,excise_markup_amt,excise_tax_per,excise_tax_amt,distribution_tax_per,distribution_tax,cultivation_tax,cultivation_tax_per,cod) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
/* ===================== end change by divyesh (changes) ===================== */
mysqli['add_dispute'] = 'insert into disputes (user_id,date_added,subject,message,project_id) values(?,?,?,?,?)';

mysqli['view_dispute'] = 'SELECT d.*,u.email,p.title FROM `disputes` d JOIN users u ON u.id = d.user_id JOIN projects p ON d.project_id = p.id  WHERE d.status = "active"';

mysqli['delete_disputes'] = 'UPDATE disputes SET status = "removed" WHERE id = ?';

mysqli['unsub_user'] = 'UPDATE user_notification SET email = "" AND sms = "" WHERE user_id = ?';


/*Payment gateway Authorize.net */

mysqli['auth_insert'] = 'insert into authorize_details (uid,pro_id,pay_id,card_no) values(?,?,?,?)';
mysqli['auth_details'] = "select * from authorize_details where card_no = ? and uid= ? limit 1";
mysqli['auth_proid'] = "select * from authorize_details where uid= ? limit 1";


/* Block Users */

mysqli[500] = 'SELECT bu.email,bu.id as blockid,u.id as userid,u.first_name,u.last_name FROM block_users bu inner join users u on u.email = bu.email  where bu.sid = ?';
mysqli[501] = 'insert into block_users (email,sid,date_added) values(?,?,?)';
mysqli[502] = 'delete from block_users where id = ?';
mysqli[503] = 'SELECT bu.email,bu.id as blockid,u.id as userid,u.first_name,u.last_name FROM block_users bu inner join users u on u.email = bu.email  where bu.sid = ? limit ?,15';
mysqli[504] = "select * from block_users where email= ? and sid = ?";
mysqli[505] = "select * from users where email= ?";
// mysqli[506] = "SELECT * FROM block_users where sid=(select user_id from projects where id= ?) and email=(select email from users where id= ?)";
mysqli[506] = "SELECT * FROM block_users where sid=(select user_id from projects where id= ?) and email=?";
mysqli[507] = "UPDATE bids SET declined = 1 where user_id = (SELECT id FROM users where email = ?) and project_id IN (select id from projects where user_id = ?)";
mysqli[508] = "UPDATE buynow SET active = 1 where user_id = (SELECT id FROM users where email = ?) and project_id IN (select id from projects where user_id = ?)";
mysqli[510] = 'select * from users where email like "{{search}}%"';
/*Transfer Ownership*/

mysqli[550] = "UPDATE projects SET user_id = (SELECT u.id FROM users u where u.email = ?) where id = ?";
mysqli[551] = "SELECT id,first_name,last_name FROM users where email = ?";
mysqli[552] = "SELECT title FROM projects where id = ?";
mysqli[553] = "UPDATE bids SET declined = 1 where user_id = (SELECT id FROM users where email = ?) and project_id = ?";


/*Active Users In our site */
mysqli[1000] = "select * from current_users where ip_address= ? limit 1";
mysqli[1001] = 'insert into current_users (uid,location,date_visited,browser,os,ip_address) values(?,?,?,?,?,?)';
mysqli[1002] = 'UPDATE current_users SET uid = ? ,location = ?, date_visited = ?,browser = ?,os = ? WHERE ip_address = ?';

mysqli[1003] = "select *,TIMEDIFF(NOW(),date_visited) as difference from current_users where date_visited > DATE_SUB(NOW(),INTERVAL 15 MINUTE) AND uid = 0";
mysqli[1004] = "select current_users .*,u.first_name,u.last_name,TIMEDIFF(NOW(),date_visited) as difference from current_users inner join users u on u.id = current_users.uid where date_visited > DATE_SUB(NOW(),INTERVAL 15 MINUTE) AND current_users.uid > 0";

/*Active Users In our site */

/*currency listing on the site */
mysqli[1100] = "select * from currency where type= ?";
mysqli[1103] = "update currency set status = 0";
mysqli[1102] = "update currency set status = 1 where id= ?";
mysqli[1105] = "select * from currency where status= 1";
mysqli[1106] = "update currency set rate = ? where id= ?";
/*currency listing on the site ends here*/


/* Language Tools */
mysqli['new_language_group'] = 'insert into language_group (groupname,group_desc) values(?,?)';
mysqli['new_language'] = 'insert into languages (language,direction,locale,created_at,language_slug,status,enable) values(?,?,?,?,?,1,0)';
mysqli['get_languages'] = 'select * from languages where status= 1';
mysqli['get_groups'] = 'select * from language_group';
mysqli['language_column'] = "ALTER TABLE language_phrases ADD {{clname}} TEXT NOT NULL DEFAULT  ''";
mysqli['new_phrase'] = 'insert into language_phrases (group_id,phrase,{{clname}}) values(?,?,?)';
mysqli['check_phrase'] = "SELECT * FROM language_phrases where phrase = ? and group_id = ?";
mysqli['check_language'] = "SELECT * FROM languages where language = ?";
mysqli['check_group'] = "SELECT * FROM language_group where groupname = ?";

mysqli['updatephrase'] = "update language_phrases set {{clname}} = ? where phrase = ?";
mysqli['deactivate_langs'] = "update languages set enable = 0";
mysqli['activate_langs'] = "update languages set enable = 1 where language_slug = ?";
mysqli['update_phrases'] = "update language_phrases set {{clname}} = ? where phrase = ? and group_id = ?";
mysqli['get_phrases'] = "SELECT lp.id,lp.phrase,gr.groupname FROM language_phrases lp inner join language_group gr on gr.id = lp.group_id";
mysqli['get_related_phrase'] = "select {{clname}} from language_phrases where id = ?";
mysqli['update_single_phrase'] = "update language_phrases set {{clname}} = ? where id = ?";

/*Admin  Phrases */
mysqli['get_admin_phrase'] = "SELECT * FROM language_phrases where group_id = (select id from language_group where groupname = 'Admin')";
mysqli['get_home_phrase'] = "SELECT * FROM language_phrases where group_id = (select id from language_group where groupname = 'Home')";
mysqli['get_all_thephrases'] = "SELECT group_id,phrase FROM language_phrases";
/* Language tools */


/*video conference*/
mysqli['video1'] = 'select * from users where nick_name = ?';
mysqli['video2'] = 'insert into invite_conference (id,project_id,name,email,date_added) VALUES(NULL,?,?,?,?)';
mysqli['video3'] = 'update invite_conference set accept = ? ,date_replied = ? where project_id = ? and email = ?';
mysqli['video4'] = 'select * from invite_conference where project_id = ? group by email';

mysqli['twilio1'] = 'select * from twilio_numbers';
mysqli['twilio2'] = 'insert into twilio_numbers (id,number,enable,date_added) VALUES(NULL,?,1,?)';
mysqli['twilio3'] = 'update twilio_numbers set enable = ? where id = ?';
mysqli['twilio4'] = 'select * from twilio_numbers where (allocate_id IN (select id from projects where market_status != "open") or allocate_id = 0 or DATE_SUB(allocated_time,INTERVAL 1 HOUR) < ?) and enable = 1 order by allocated_time asc limit 1';
mysqli['twilio5'] = 'update twilio_numbers set allocate_id = ?,allocated_time = ? where id = ?';
mysqli['twilio6'] = 'select * from twilio_numbers where number = ?';
mysqli['twilio7'] = 'select * from twilio_numbers where allocate_id = ?';
/*video conference*/

/*Figure Report */

mysqli['get_debits'] = 'SELECT sum(amount) as total_purchase, COUNT( id ) AS total_orders FROM invoices where type in ("sold","winner") and status = "paid" and istatus = "debit" and user_id = ?';
mysqli['sale_figure'] = 'SELECT sum(amount) as sale_amount,count(id) as total_sales FROM invoices where primary_id in (select id from projects where user_id = ?) and type in("winner","sold") and status = "paid" and istatus = "debit"';

/*SEO TOOLS */
mysqli['add_seo'] = 'insert into seo (title,url,meta_title,meta_desc,meta_tags) VALUES(?,?,?,?,?)';
mysqli['get_added_seo'] = 'select * from seo';
mysqli['get_seo_by_id'] = 'select * from seo where id = ?';
mysqli['edit_seo_by_id'] = 'update seo set title = ?,url = ?,meta_title = ?,meta_desc = ?,meta_tags = ? where id = ?';
mysqli['delete_seo_by_id'] = 'delete from seo where id = ?';
mysqli['get_seo_url'] = 'select * from seo where url = ? order by id desc limit 1';
mysqli['updateStoresname'] = 'update stores set name=? where id = ?';
mysqli['updateStoresdesc'] = 'update stores set description=? where id = ?';
mysqli['updateStoreslogo'] = 'update stores set logo=? where id = ?';
mysqli['updateStoressocial'] = 'update stores set {{where}}=? where id = ?';
mysqli['updateStoressocialrem'] = 'update stores set {{where}}="" where id = ?';
mysqli['updateStoresbanner'] = 'update stores set banner=? where id = ?';
mysqli['updateStoresbannerrem'] = 'update stores set banner= "" where id = ?';
mysqli['updateStoresbannerpos'] = 'update stores set bleft=? , btop=? where id = ?';
mysqli['updateStoreshomepage'] = 'update stores set homepage=?  where id = ?';
mysqli['updateStoresaboutus'] = 'update stores set aboutus=?  where id = ?';
mysqli['addstorepdt'] = 'update store_items set visible = 1,store_id = ? where project_id = ? limit 1';
mysqli['checkproduct'] = 'select * from store_items  where project_id = ?';
mysqli['addstorepdtnew'] = 'insert into store_items (project_id,store_id,date_added) values(?,?,?)';

mysqli['storeday'] = 'select {{feilds}} FROM buynow as b left join store_items as s ON b.project_id = s.project_id left join projects as p ON b.project_id = p.id where s.store_id IN ({{storeid}}) and DATE( b.date_added ) = DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 DAY ) )';
mysqli['storeweek'] = 'select {{feilds}} FROM buynow as b left join store_items as s ON b.project_id = s.project_id left join projects as p ON b.project_id = p.id where s.store_id IN ({{storeid}}) and DATE( b.date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 WEEK ) ) AND DATE( SYSDATE( ) )';
mysqli['storemonth'] = 'select {{feilds}} FROM buynow as b left join store_items as s ON b.project_id = s.project_id left join projects as p ON b.project_id = p.id where s.store_id IN ({{storeid}}) and DATE( b.date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 MONTH ) ) AND DATE( SYSDATE( ) ) ';
mysqli['storeall'] = 'select {{feilds}} FROM buynow as b left join store_items as s ON b.project_id = s.project_id left join projects as p ON b.project_id = p.id where s.store_id IN ({{storeid}}) and DATE(b.date_added ) BETWEEN DATE( DATE_SUB( SYSDATE( ) , INTERVAL 1 YEAR ) ) AND DATE( SYSDATE( ) ) ';
mysqli['storefromto'] = 'select {{feilds}} FROM buynow as b left join store_items as s ON b.project_id = s.project_id left join projects as p ON b.project_id = p.id where s.store_id IN ({{storeid}}) and  DATE( b.date_added ) BETWEEN DATE( ? ) AND DATE( ? )';
mysqli['get_adwords_details2'] = 'SELECT *,date_format(updated_at,"%d %M, %Y") as cdate, date_format(created_at,"%d %M, %Y") as cdate1  from adwords WHERE status != "remove" {{where}} AND user_id = ? {{limit}}';

mysqli[1075] = 'select c.*, (COUNT(parent.id) - 1) AS depth from storecategories as c, storecategories AS parent where c.lft BETWEEN parent.lft AND parent.rgt group by c.id order by c.lft asc limit ?,10';
mysqli[1076] = 'select c.*, (COUNT(parent.id) - 1) AS depth from storecategories as c, storecategories AS parent where c.lft BETWEEN parent.lft AND parent.rgt group by c.id order by c.lft asc';
mysqli[1077] = 'select c.* from storecategories as c where c.id = ?';
mysqli[1078] = 'insert into storecategories (name,description,created_at,updated_at,type,lft,rgt,parent_id) values(?,?,?,?,"product",?,?,?)';
mysqli[1079] = 'update storecategories set  name = ?,description = ?,updated_at = ? where id = ?';
mysqli[10175] = 'select c.*, (COUNT(parent.id) - 1) AS depth from storecategories as c, storecategories AS parent where c.lft BETWEEN parent.lft AND parent.rgt  group by c.id order by c.lft asc';
mysqli[10176] = 'select max(rgt) as mrgt from storecategories ';
mysqli[10177] = 'update storecategories set rgt = rgt + 2 where rgt > ?';
mysqli[10178] = 'update storecategories set lft = lft + 2 where lft > ?';
mysqli[10179] = 'select max(lft) as mrgt from storecategories where id = ?';
mysqli[10265] = 'delete from storecategories where id = ? or parent_id = ?';
mysqli[10274] = 'select * from storecategories  order by name asc';
mysqli[10264] = 'update storecategories set lft = ?,rgt = ? where id = ?';
mysqli[10261] = 'update storecategories set parent_id = ?, name = ?, description = ?,updated_at = ? where id = ?';
mysqli[10262] = 'update storecategories set parent_id = ? where parent_id = ?';
mysqli['insert_max_length'] = 'INSERT INTO max_storecategory (max_length, comment) VALUES(?,"store_category_max_length")';
mysqli['update_max_length'] = 'UPDATE max_storecategory SET max_length = ? WHERE id = ?';
mysqli['insert_max_length2'] = 'INSERT INTO max_storecategory (storecategory_ids) VALUES(?)';
mysqli['update_max_length2'] = 'UPDATE max_storecategory SET storecategory_ids = ? WHERE id = ?';
mysqli['select_max_length'] = 'SELECT * FROM max_storecategory';
mysqli['select_all_store'] = 'SELECT * FROM stores';
mysqli['update_primary_store'] = 'UPDATE stores SET {{where}}';
mysqli['updateCatInStore'] = 'UPDATE stores SET selected_category = ? where id = ?';
mysqli['updateFeatureProject'] = 'UPDATE projects SET {{where}}';
mysqli['updateUnstockProject'] = 'UPDATE store_items SET visible = "0" {{where}}';
mysqli['selectStoreProductOrder'] = 'SELECT * FROM store_product_order WHERE store_id = ?';
mysqli['selectProductOrder']    = 'SELECT * FROM store_product_order WHERE store_id = ? AND category_id = ?';
mysqli['insertProductOrder'] = 'INSERT INTO store_product_order (project_order_ids, store_id, category_id) VALUES(?, ?, ?)';
mysqli['updateProductOrder'] = 'UPDATE store_product_order SET project_order_ids = ? WHERE store_id = ? AND category_id = ?';
// mysqli['getallstores'] = "SELECT s.* ,CASE WHEN if(a.days_week != '' , FIND_IN_SET(DAYNAME(curdate()),a.days_week),true) AND if(a.target_sec_id != '',FIND_IN_SET('Sell an Item',a.target_sec_id),true) AND if(a.end_date !='0000-00-00',a.end_date = CURDATE(),true) AND a.budget_per_day DIV a.budget_per_click > a.no_of_clicks AND a.status = 'active' AND a.store_id != 0 THEN 1 ELSE 0 END as adstore FROM stores as s LEFT JOIN adwords as a ON a.store_id = s.id {{limit}}";
mysqli['getallstores'] = "SELECT * FROM (\
                SELECT \
                    s.* ,\
                    CASE WHEN \
                            if( \
                                a.days_week != '' , \
                                FIND_IN_SET(DAYNAME(curdate()), a.days_week),\
                                true \
                            ) AND if( \
                                a.target_sec_id != '', \
                                FIND_IN_SET('Sell an Item',a.target_sec_id),\
                                true\
                            ) AND if(\
                                a.end_date !='0000-00-00',\
                                a.end_date = CURDATE(),\
                                true\
                            ) AND a.budget_per_day DIV a.budget_per_click > a.no_of_clicks \
                            AND a.status = 'active' \
                            AND a.store_id != 0 \
                        THEN 1 ELSE 0 END as adstore \
                FROM stores as s \
                LEFT JOIN adwords as a \
                    ON a.store_id = s.id  \
                 {{limit}}\
                ) as temp_table GROUP BY temp_table.id ";

mysqli['getStorePlanlist'] = "SELECT {{fields}} FROM store_plan_list {{where}}";
mysqli['saveStorePlan'] = "INSERT INTO store_plan (store_id,user_id,plan_type,amount,status,subscription_id,next_billing_date,transaction_id) VALUES(?,?,?,?,?,?,?,?)";
mysqli['updateStorePlan'] = "UPDATE store_plan SET {{updatecolumn}} WHERE subscription_id = ? ";
mysqli['deleteStorePlan'] = "DELETE FROM store_plan WHERE subscription_id = ? ";
mysqli['deleteStoreMultiple'] = "DELETE FROM stores WHERE id in (?)";
mysqli['getStorePlan'] = "SELECT * FROM store_plan WHERE subscription_id = ? ";
mysqli['insertPlanList'] = "INSERT INTO store_plan_list \
(title,description,amount,online,in_person,store,product,category,live_auction,file_storage,storage_type,ship_station_cost,shipping_label,hr_support,fraud_analysis,manual_order_creation,discount_code,website_blog,free_ssl,gift_card,professinal_reports,cart_recovery,report_builder,shipping_rate_calc,customization_hours,additional_coding,status,plan_id) \
VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
mysqli['updatePlanList'] = "UPDATE store_plan_list SET title=? ,description=? ,amount=? ,online=? ,in_person=? ,store=? ,product=? ,category=? ,live_auction=? ,file_storage=? ,storage_type=? ,ship_station_cost=? ,shipping_label=? ,hr_support=? ,fraud_analysis=? ,manual_order_creation=? ,discount_code=? ,website_blog=? ,free_ssl=? ,gift_card=? ,professinal_reports=? ,cart_recovery=? ,report_builder=? ,shipping_rate_calc=? ,customization_hours=? ,additional_coding=? ,status=? ,plan_id=? WHERE  id = ?";
mysqli['deleteStorePlanList'] = "DELETE FROM store_plan_list WHERE id = ? ";
mysqli['getSubscriptionCount'] = "SELECT sum(sp.store) as store,sum(sp.category) as category ,sp.product as product FROM store_plan as p LEFT JOIN store_plan_list as sp ON sp.id = p.plan_type WHERE p.status = 'success' AND p.store_id = ? AND DATEDIFF(p.next_billing_date, CURDATE()) > 0";
mysqli['getproductIds'] = "SELECT GROUP_CONCAT(si.project_id) as projectids FROM store_items as si where project_id IN (SELECT id FROM projects as p WHERE p.user_id = ?) and si.store_id != 0;";
mysqli['updatestoreproject'] = "UPDATE projects SET date_closed = ? WHERE id = ?";
mysqli['storeCategoryDetails'] = "SELECT c.id,c.name FROM categories as c WHERE FIND_IN_SET(c.id,(SELECT m.storecategory_ids FROM max_storecategory as m))";
mysqli['storedashboardfilter'] = "SELECT * FROM (SELECT s.* ,CASE WHEN if(a.days_week != '' , FIND_IN_SET(DAYNAME(curdate()),a.days_week),true) AND if(a.target_sec_id != '', FIND_IN_SET('Sell an Item',a.target_sec_id),true) AND if(a.end_date != '0000-00-00',a.end_date = CURDATE(),true) AND a.budget_per_day DIV a.budget_per_click > a.no_of_clicks AND a.status = 'active' AND a.store_id != 0 THEN 1 ELSE 0 END as adstore FROM stores as s LEFT JOIN users as u ON u.id=s.user_id LEFT JOIN adwords as a ON a.store_id = s.id LEFT JOIN store_items as si ON si.store_id = s.id LEFT JOIN projects as p ON p.id = si.project_id  WHERE {{where}}\
) as temp_table GROUP BY temp_table.id ";
// mysqli['selectAdStores'] = 'SELECT s.* FROM stores as s LEFT JOIN adwords as a ON a.store_id = s.id WHERE if(a.days_week != "" ,FIND_IN_SET(DAYNAME(curdate()),a.days_week),true) AND if(a.target_sec_id != "",FIND_IN_SET("Sell an Item",a.target_sec_id),true) AND if(a.end_date !="0000-00-00",a.end_date = CURDATE(),true) AND a.status = "active" AND a.budget_per_day DIV a.budget_per_click > a.no_of_clicks AND a.store_id != 0 ORDER BY a.no_of_clicks DESC ';
mysqli['selectplantransaction'] = 'SELECT {{feilds}} FROM store_plan AS sp LEFT JOIN stores AS s ON s.id=sp.store_id WHERE sp.store_id IN ({{storeid}}) AND (sp.status = "success" OR sp.status = "hold") AND {{where}}';
mysqli['selectstoreplan'] = 'SELECT sp.*, spl.title AS planname, s.name AS storename FROM store_plan AS sp LEFT JOIN store_plan_list AS spl ON spl.id = sp.plan_type LEFT JOIN stores AS s ON sp.store_id = s.id WHERE (sp.status = "success" OR sp.status = "hold") AND sp.store_id IN ({{storeid}}) AND sp.user_id = ?';
mysqli['updatestorestatus'] = 'UPDATE store_plan SET status = ? WHERE id = ?';
mysqli['dbbuyyertab'] = 'select IFNULL((SELECT position FROM recurring_schedule WHERE id=b.rec_schedule_id ORDER BY id DESC LIMIT 0,1),0) AS current_position,IFNULL((SELECT recp.count FROM recurring_schedule AS recs inner join recurring_purchase as recp on recs.recur_purchase_id = recp.id where recs.product_id=b.project_id AND recs.user_id=b.user_id AND recs.seller_id = b.request_userid ORDER BY recs.id DESC LIMIT 0,1),0) AS count, (SELECT recp.status FROM recurring_schedule AS recs inner join recurring_purchase as recp on recs.recur_purchase_id = recp.id where recs.product_id=b.project_id AND recs.user_id=b.user_id AND recs.seller_id = b.request_userid ORDER BY recs.id DESC LIMIT 0,1) AS r_status, (SELECT recp.frequency FROM recurring_schedule AS recs inner join recurring_purchase as recp on recs.recur_purchase_id = recp.id where recs.product_id=b.project_id AND recs.user_id=b.user_id AND recs.seller_id = b.request_userid ORDER BY recs.id DESC LIMIT 0,1) AS frequency, IFNULL((select ROUND(sum(avg_rating)/count(id)) from seller_performance where seller_id = b.request_userid),0) as seller_rating, si.store_id, p.*,b.id as b_id, b.cod, DATE_ADD(b.shipped_at, INTERVAL 72 hour) as b_timer, DATE_ADD(b.paid_date, INTERVAL 72 hour) as bid_timer, b.user_id as buyer_id,b.order_status as b_order_status,b.request_userid as seller_id, b.qty as b_qty,b.paid as b_paid_status, b.paid_date as b_paid_date, b.delivery_status as b_delivery_status, b.shipping_status as b_shipping_status, b.shipped_at as b_shipped_at, b.delivered_at as b_delivered_at, b.total_amount as b_total_amount,b.recurring as b_recurring, b.seller_paid_status as b_seller_paid_status, b.seller_paid_at as b_seller_paid_at, b.cancel_ins_per as b_cancel_ins_per, b.cancel_ins_status as b_cancel_ins_status, b.cancel_ins_amt as b_cancel_ins_amt, b.reserve_amt as b_reserve_amt , b.commission as b_commission_amt, b.commission_per as b_commission_per, b.stax_per as b_stax_per, b.stax_status as b_stax_status, b.stax_amt as b_stax_amt from buynow AS b inner join projects as p on p.id = b.project_id inner join store_items as si on si.project_id = p.id where b.user_id = ? and auction = 0 {{whr}} order by b.id DESC limit ?,?';
// mysqli['dbbuyyertabcount'] = 'select count(p.id) as productsCount from buynow AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and win = 0 {{whr}} order by p.id DESC';
mysqli['dbbuyyertabcount'] = 'select count(p.id) as productsCount from buynow AS b inner join projects as p on p.id = b.project_id inner join store_items as si on si.project_id = p.id where b.user_id = ? and auction = 0 {{whr}} order by b.id DESC';
// mysqli['addrecurre'] = 'INSERT INTO recurring_purchase (user_id,project_id,date_added,frequency,quantity,sdate,edate,cancellation,tcartid ) VALUES(?,?,?,?,?,?,?,?,?)';
mysqli['addrecurre'] = 'INSERT INTO recurring_purchase (user_id,project_id,date_added,frequency,quantity,sdate,count,edate,cancellation,tcartid,cancellation_per ) VALUES(?,?,?,?,?,?,?,?,?,?,?)';
mysqli['seller_performance'] ='INSERT INTO seller_performance ( seller_id, store_id,product_id,buyer_id, accurate, performance, delivery, packing, questions,resolving,customer_support, satisfaction, comment, admin_approval, avg_rating) VALUES ( "{{seller_id}}", "{{store_id}}","{{product_id}}","{{buyer_id}}","{{accurate}}", "{{performance}}", "{{delivery}}", "{{packing}}", "{{questions}}", "{{resolving}}","{{customer_support}}", "{{satisfaction}}", "{{comment}}", "0", "{{avg_rating}}")';
mysqli['get_seller_performance'] ='SELECT * from seller_performance where buyer_id = ? and seller_id = ?';
mysqli['buyer_performance'] = 'INSERT INTO buyer_performance ( buyer_id, store_id,seller_id, delivery, deliveryinfo, prodinspect, delreceipt,personnel, tpayment, comment, admin_approval, avg_rating) VALUES ( "{{buyer_id}}", "{{store_id}}","{{seller_id}}","{{delivery}}", "{{deliveryinfo}}", "{{prodinspect}}", "{{delreceipt}}","{{personnel}}", "{{tpayment}}", "{{comment}}", "0", {{avg_rating}})';
mysqli['seller_performance_data'] = 'select id, comment, avg_rating from seller_performance where id = ? limit 1';
mysqli['buyer_performance_data'] = 'select id, comment, avg_rating from buyer_performance where id = ? limit 1';
mysqli['get_buyer_performance'] ='SELECT * from buyer_performance where where seller_id = ? and buyer_id = ?';
mysqli['dbbuyyerrecurringtab'] = 'select si.store_id, IFNULL((SELECT date_format(recurring_at,"%m/%d/%Y @ %H:%i") FROM recurring_schedule WHERE recur_purchase_id=b.id AND recurring_at < NOW() ORDER BY id DESC LIMIT 0,1),0) AS current_r_date, '+
'(SELECT id FROM recurring_schedule WHERE recur_purchase_id=b.id AND recurring_at < NOW() ORDER BY id DESC LIMIT 0,1) AS current_r_id,'+ 
'IFNULL((SELECT position FROM recurring_schedule WHERE recur_purchase_id=b.id AND recurring_at < NOW() ORDER BY id DESC LIMIT 0,1),0) AS current_position,'+ 
'(SELECT id FROM buynow WHERE recurring="1" AND rec_purchase_id=b.id AND project_id=p.id AND request_userid=p.user_id ORDER BY id DESC LIMIT 0,1) AS b_id, '+
'p.user_id AS seller_id, '+
'(SELECT shipping_status FROM buynow WHERE recurring="1" AND rec_purchase_id=b.id AND project_id=p.id AND request_userid=p.user_id ORDER BY id DESC LIMIT 0,1) AS b_shipping_status, '+
'(SELECT delivery_status FROM buynow WHERE recurring="1" AND rec_purchase_id=b.id AND project_id=p.id AND request_userid=p.user_id ORDER BY id DESC LIMIT 0,1) AS b_delivery_status, '+
'(SELECT DATE_ADD(paid_date, INTERVAL 72 hour) FROM buynow WHERE recurring="1" AND rec_purchase_id=b.id AND project_id=p.id AND request_userid=p.user_id ORDER BY id DESC LIMIT 0,1) AS b_timer, '+

'IFNULL((SELECT date_format(recurring_at,"%m/%d/%Y @ %H:%i") FROM recurring_schedule WHERE recur_purchase_id=b.id AND recurring_at >= NOW() ORDER BY id ASC LIMIT 0,1),0) AS next_r_date, '+
'(SELECT id FROM recurring_schedule WHERE recur_purchase_id=b.id AND recurring_at >= NOW() ORDER BY id ASC LIMIT 0,1) AS next_r_id, '+

'IFNULL((select ROUND(sum(avg_rating)/count(id)) from seller_performance where seller_id = p.user_id),0) as seller_rating, p.*,b.id as rid,b.user_id,b.project_id,b.frequency,b.count,b.quantity, date_format(b.sdate,"%m/%d/%Y @ %H:%i")as sdate, date_format(b.edate,"%m/%d/%Y @ %H:%i")as edate,b.cancellation, b.status as r_status, b.cancelreq, date_format(b.cancelreq_at,"%m/%d/%Y @ %H:%i") as cancelreq_at, b.sapprove_status, date_format(b.sapprove_at,"%m/%d/%Y @ %H:%i") as sapprove_at, b.aapprove_status, date_format(b.aapprove_at,"%m/%d/%Y @ %H:%i") as aapprove_at, b.cod  from recurring_purchase AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.cancelled = 0 inner join store_items as si on si.project_id = p.id {{whr}} order by b.id DESC  limit ?,?';
// mysqli['dbbuyyerrecurringtab'] = 'select p.*,b.id as rid,b.user_id,b.project_id,b.frequency,b.count,b.quantity, date_format(b.sdate,"%d/%m/%Y")as sdate, date_format(b.edate,"%d/%m/%Y")as edate,b.cancellation, b.status as r_status, b.cancelreq, date_format(b.cancelreq_at,"%m/%d/%Y @ %H:%i") as cancelreq_at, b.sapprove_status, date_format(b.sapprove_at,"%m/%d/%Y @ %H:%i") as sapprove_at, b.aapprove_status, date_format(b.aapprove_at,"%m/%d/%Y @ %H:%i") as aapprove_at  from recurring_purchase AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.cancelled = 0 order by p.id DESC  limit ?,?';
mysqli['dbbuyyerrecurringtabc'] = 'select count(p.id) as productsCountr from recurring_purchase AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.cancelled = 0 {{whr}} order by b.id DESC';
// mysqli['dbmarketbuyernegodb'] = 'select p.*,b.*from negotiable  AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.declined!=1 {{whr}} order by p.id DESC  limit ?,?';
// mysqli['dbmarketbuyernegodbc'] = 'select count(p.id) as productsCountb from negotiable  AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.declined!=1 {{whr}} order by p.id DESC';
mysqli['dbmarketbuyernegodb'] = 'select (select store_id from store_items where project_id = p.id) as store_id,IFNULL((select sum(avg_rating)/count(id) from seller_performance where seller_id = p.user_id),0) as srating, IFNULL((select avg_rating from seller_performance where seller_id = p.user_id and buyer_id = n.user_id and product_id = p.id),0) as buyer_srating, IFNULL((select count(id) from seller_performance where seller_id = p.user_id and buyer_id = n.user_id and product_id = p.id),0) as buyer_srating_status, IFNULL(b.id,0) as b_id, b.total_amount as b_total_amount, b.paid as b_paid_status, n.id as n_id, n.project_id as n_project_id, n.declined, n.awarded, n.awarded_date as n_awarded_date, n.declined_date as n_declined_date, n.proposed_amount, n.created_at as n_created_at, n.qty_request as n_qty_request,p.* from negotiable  AS n inner join projects as p on p.id = n.project_id and n.user_id = ? and n.declined!=1 left join buynow as b on b.request_id = n.id and b.negotiable = 1 {{whr}} order by p.id DESC  limit ?,?';
mysqli['dbmarketbuyernegodbc'] = 'select count(p.id) as productsCountb from negotiable  AS n inner join projects as p on p.id = n.project_id and n.user_id = ? and n.declined!=1 inner join buynow as b on b.request_id = n.project_id and b.negotiable = 1 {{whr}} order by p.id DESC';
mysqli['dbmarketbuyernegodbacc'] = 'select IFNULL((select ROUND(sum(avg_rating)/count(id)) from seller_performance where seller_id = p.user_id),0) as seller_rating, p.*,b.* from negotiable  AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and declined = 1 {{whr}} order by p.id DESC  limit ?,?';
mysqli['dbmarketbuyernegodbaccc'] = 'select count(p.id) as productsCountb from negotiable  AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and declined = 1 {{whr}} order by p.id DESC';
mysqli['selleropen'] = 'select id, title, description,tags, sprice, qty, sold, booked, filled_qty, rfilled_qty, market_status, user_id, trading_type, order_type, unit_price, units, date_format(created_at,"%m/%d/%Y @ %H:%i")as postedDate, date_format(date_added,"%m/%d/%Y @ %H:%i")as start_date,  DATE_SUB(date_added, INTERVAL 72 hour) as checkAvail, date_added, created_at, updated_at, avatar, image, test_result,test_result_img, cannabis_type,(select count(id) from negotiable n where p.id = n.project_id) as countnego,(select count(id) from recurring_purchase r where p.id = r.project_id) as countrecur from projects p where market_status="open" and user_id =? {{whr}} order by id desc limit ?, ?';
mysqli['selleropenc'] = 'select count(id) as productsCount from projects where  market_status="open" and user_id =? {{whr}}';
mysqli['sellersoldb'] = 'select p.id, p.title, p.description, p.qty, p.market_status, p.user_id, p.unit_price, p.units ,p.avatar, p.image,b.qty as bqty,b.amount as bamt, date_format(b.paid_date,"%m/%d/%Y @ %H:%i")as paiddate,b.user_id as buseid,u.review from projects as p left join buynow as b on p.id = b.project_id left join users as u on u.id = b.user_id where p.market_status="closed" and p.user_id = ? order by id desc limit ?, ?';
mysqli['sellersoldbc'] = 'select count(p.id) as productsCount from projects as p left join buynow as b on p.id = b.project_id left join users as u on u.id = b.user_id where p.market_status="closed" and p.user_id = ? order by date_closed desc';

mysqli['sellernegotdb'] = 'select IFNULL((select ROUND((sum(avg_rating)/count(id) + sum(tpayment)/count(id) )/2) from buyer_performance where buyer_id=b.user_id), 0) as buyer_rating, p.id, p.title, p.description, p.qty, p.market_status, p.user_id,  p.unit_price, p.units ,p.avatar, p.image,b.id as bid,b.qty_request as bqty,b.proposed_amount as bamt,date_format(b.created_at,"%m/%d/%Y @ %H:%i")as paiddate from projects as p left join negotiable as b on p.id = b.project_id where b.awarded!= 1 and b.declined!= 1 and p.user_id = ? {{whr}}  order by b.id desc limit ?, ?';
mysqli['sellernegotdbc'] = 'select count(p.id) as productsCount from projects as p left join negotiable as b on p.id = b.project_id where b.awarded!= 1 and b.declined!= 1 and p.user_id = ? {{whr}} order by b.id desc';
// mysqli['btncheckrecurupdb'] = 'UPDATE recurring_purchase SET cancelled = 1 WHERE id = ?';
mysqli['buyer_cancel_req'] = 'UPDATE recurring_purchase SET cancelreq = "1", cancelreq_at = ? WHERE id = ?';
mysqli['seller_cancel_approval'] = 'UPDATE recurring_purchase SET sapprove_status = "1", sapprove_at = ? WHERE id = ?';
mysqli['admin_cancel_approval'] = 'UPDATE recurring_purchase SET aapprove_status = "1", aapprove_at = ?, cancelled_at = ? WHERE id = ?';

mysqli['updatestoreviewc'] = 'UPDATE stores SET views = views + 1 WHERE id = ?';
// mysqli['cnx239new'] = 'select p.user_id as suserid,b.user_id as buserid, b.local_pick,c.trans_id,c.*,b.id as buynow_id,p.title,b.amount as amt,b.refund as refundamt, date_format(b.paid_date,"%M %d %Y %h:%i:%s %p") as pay_date,date_format(b.date_added,"%M %d %Y %h:%i:%s %p") as create_date from buynow as b inner join projects as p on p.id = b.project_id inner join checkout as c on c.id = b.cart_id where b.id = ?';
// mysqli['cnx239new'] = 'select b.qty as b_qty, b.request_userid as suserid,b.user_id as buserid,b.total_amount,b.cart_id as buynow_cart_id, b.local_pick,b.id as buynow_id,p.title, p.units, b.amount as amt,b.refund as refundamt, date_format(b.paid_date,"%M %d %Y %h:%i:%s %p") as pay_date,date_format(b.date_added,"%M %d %Y %h:%i:%s %p") as create_date from buynow as b inner join projects as p on p.id = b.project_id where b.id = ?';

/* ===================== start change by divyesh (changes) ===================== */
mysqli['cnx239new'] = 'select (SELECT position FROM recurring_schedule WHERE id=b.rec_schedule_id) AS current_position,(SELECT count FROM recurring_purchase WHERE id=b.rec_purchase_id) AS count, i.transactionid as i_transaction_id, b.seller_paid_status as b_seller_paid_status,  b.admin_paid_status as b_admin_paid_status,b.seller_paid_amt as b_seller_paid_amt,  b.admin_paid_amt as b_admin_paid_amt,b.excise_markup_per as b_excise_markup_per,b.excise_markup_amt as b_excise_markup_amt,b.excise_tax_per as b_excise_tax_per,b.excise_tax_amt as b_excise_tax_amt,b.distribution_tax_per as b_distribution_tax_per,b.distribution_tax as b_distribution_tax,b.cultivation_tax as b_cultivation_tax,b.cultivation_tax_per as b_cultivation_tax_per, b.amount as b_amount, b.rec_purchase_id as rp_id, b.cancel_ins_per as b_cancel_ins_per, b.cancel_ins_amt as b_cancel_ins_amt, b.cancel_ins_status as b_cancel_ins_status,b.reserve_amt as b_reserve_amt, b.commission as b_commission, b.commission_s as b_commission_s,b.id, b.recurring as b_recurring_status, b.negotiable as b_negotiable_status,b.qty as b_qty, b.request_userid as suserid,b.user_id as buserid,b.total_amount,b.cart_id as buynow_cart_id, b.local_pick,b.id as buynow_id, p.title, p.units, b.amount as amt,b.refund as refundamt, date_format(b.paid_date,"%M %d %Y %h:%i:%s %p") as pay_date, date_format(b.date_added,"%M %d %Y %h:%i:%s %p") as create_date, b.paid as b_paid_status, p.auction as p_auction, p.negotiable as p_negotiable, b.stax_amt as b_stax_amt, b.stax_per as b_stax_per, b.commission_per as b_commission_per, b.consultant_fee, b.consultant_fee_amount, pr.behalf_cc_id, pr.behalf_documents from buynow as b left join projects as p on p.id = b.project_id left join checkout c on b.cart_id = c.id left join invoices i on i.cart_id = c.id left join product_requests AS pr ON pr.id=b.request_id where b.id = ?';
/* ===================== end change by divyesh (changes) ===================== */

mysqli['cnx239new_admin'] = 'select i.transactionid as i_transaction_id, b.amount as b_amount, b.rec_purchase_id as rp_id, b.cancel_ins_per as b_cancel_ins_per, b.cancel_ins_amt as b_cancel_ins_amt, b.cancel_ins_status as b_cancel_ins_status,b.reserve_amt as b_reserve_amt, b.commission as b_commission, b.commission_s as b_commission_s,b.id, b.recurring as b_recurring_status, b.negotiable as b_negotiable_status,b.qty as b_qty, b.request_userid as suserid,b.user_id as buserid,b.total_amount,b.cart_id as buynow_cart_id, b.local_pick,b.id as buynow_id, p.title, p.units, b.amount as amt,b.refund as refundamt, date_format(b.paid_date,"%M %d %Y %h:%i:%s %p") as pay_date, date_format(b.date_added,"%M %d %Y %h:%i:%s %p") as create_date, b.paid as b_paid_status, p.auction as p_auction, p.negotiable as p_negotiable, b.stax_amt as b_stax_amt, b.stax_per as b_stax_per, b.commission_per as b_commission_per from buynow as b left join projects as p on p.id = b.project_id left join checkout c on b.cart_id = c.id left join invoices i on i.cart_id = c.id where b.id = ?';
// mysqli['btnacceptnegomd'] = 'UPDATE negotiable SET awarded = 1 WHERE id = ?';
mysqli['btnacceptnegomd'] = 'UPDATE negotiable SET awarded = 1, awarded_date = ? WHERE id = ?';

/* Check whether the negotiable request is accepted or declined or already proceeded */
mysqli['check_buynow_req'] = 'select * from buynow where negotiable = 1 and request_id = ? and project_id = ?';

/* checking negotiable request status whether it is already accepted or not */
mysqli['check_req_status'] = 'select * from negotiable where (awarded=0 OR declined = 0) and id = ? and project_id = ?';	

// mysqli['reject_requests'] = 'update product_requests set rejected = ?, rejected_date = ? where qty > ? and accepted = 0 and product_id = ?';
mysqli['btnaccept_declinemax'] = 'UPDATE negotiable SET declined = 1, declined_date = ? WHERE qty_request > ? and project_id=?';
mysqli['btnrejectnegomd'] = 'UPDATE negotiable SET declined = 1 WHERE id = ?';
mysqli['btnrejectnegomesgmd'] = 'UPDATE negotiable SET declined = 1,reject_mesg =? WHERE id = ?';
//mysqli['relation'] ='select p.*,SUBSTR(p.message,1,200)as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add,interest,target_no,cost from pmb as p join pmb_pool as m ON m.id = p.rpool_id where  p.to_status!= "delete" AND p.to_status !="archive" and p.to_id = ?  order by p.id desc limit ?, 5';
mysqli['relation'] ='select p.*,SUBSTR(p.message,1,200)as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add,interest,target_no,cost from pmb as p join pmb_pool as m ON m.id = p.rpool_id where  p.to_status!= "delete" and interest = 0 AND p.to_status !="archive" and p.to_id = ?  group by p.r_id order by p.id desc limit ?, 5';
/*mysqli['relation'] ='select p.*,SUBSTR(p.message,1,200)as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add from pmb as p where p.to_id = ? group by p.r_id order by p.id desc limit ?, 5'; */
mysqli['relationc'] ='select p.*,SUBSTR(p.message,1,200)as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add,interest,target_no,cost from pmb as p join pmb_pool as m ON m.id = p.rpool_id where  p.to_status!= "delete" AND p.to_status !="archive" and p.to_id = ? and p.interest = 0  group by p.r_id order by p.id desc'; 
mysqli['rebustype']='SELECT count(business_type) AS Total,SUM(CASE business_type WHEN "grower" THEN 1 ELSE 0 END) AS grower,SUM(CASE business_type WHEN "producer" THEN 1 ELSE 0 END) AS producer,SUM(CASE business_type WHEN "dispensary" THEN 1 ELSE 0 END) AS dispensary,SUM(CASE business_type WHEN "supplier" THEN 1 ELSE 0 END) AS supplier FROM user_extras';
mysqli['relationinterestd'] = 'UPDATE pmb SET interest = 1 WHERE id = ?';
/*mysqli['relationntinterestd'] = 'UPDATE pmb SET interest = 0 WHERE id = ?';*/
mysqli['relationntinterestd'] = 'UPDATE pmb SET interest = 2 WHERE id = ?';
mysqli['relationcenter'] ='select p.*,SUBSTR(p.message,1,200)as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add,interest,target_no,cost from pmb as p join pmb_pool as m ON m.id = p.rpool_id where  p.to_status!= "delete" AND p.to_status !="archive" and (p.to_id = ? or p.from_id = ?) and interest = 1  order by p.id desc limit ?, 5'; 
mysqli['relationcenterc'] ='select p.*,SUBSTR(p.message,1,200)as message_short,date_format(p.date_sent,"%m/%d/%Y") as date_add,interest,target_no,cost from pmb as p join pmb_pool as m ON m.id = p.rpool_id where  p.to_status!= "delete" AND p.to_status !="archive" and (p.to_id = ? or p.from_id = ?) and interest = 1  order by p.id desc'; 
mysqli['relationsent'] ='select id,title,message,date_format(date_added,"%m/%d/%Y") as date_add,target_no,cost from pmb_pool where from_id = ? order by id desc  limit ?, 5'; 
mysqli['relationsentc'] ='select id,title,message,date_format(date_added,"%m/%d/%Y") as date_add,target_no,cost from pmb_pool where from_id = ? order by id desc '; 
mysqli['deleterecurringc'] = 'UPDATE recurring_purchase SET active = 0 WHERE project_id = ? and user_id = ?';
mysqli['checksendDetailsdb'] = 'SELECT s.user_id FROM shipping as s left join user_extras as e ON s.user_id = e.user_id where e.business_type=? and s.country=? and s.state=? {{where}} group by s.user_id';
mysqli['addpolldetailsdb'] = "INSERT INTO pmb_pool (title,message,from_id,business_type,t_country,t_state,t_city,t_region,target_no,cost,date_added) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
mysqli['insertpollpmbdb'] = "INSERT INTO pmb (from_id,to_id,subject,message,date_sent,rpool_id,r_id) VALUES(?,?,?,?,?,?,?)";
/*mysqli['adminmyrelationdb'] = 'select id,from_id,SUBSTR(m.message,1,200)as message_short,title,date_format(m.date_added,"%m/%d/%Y") as date_add,target_no,cost,(select count(interest) from pmb as p where p.rpool_id = m.id and interest = 1) as total_requests from pmb_pool as m {{whr}} order by m.id desc limit ?, 10';*/
mysqli['adminmyrelationdb'] = 'select m.id,from_id,SUBSTR(m.message,1,200)as message_short,title,date_format(m.date_added,"%m/%d/%Y %H:%i") as date_add,target_no,cost,(select count(interest) from pmb as p where p.rpool_id = m.id and interest = 1) as total_requests from pmb_pool as m {{whr}} {{where2}} order by m.id desc limit ?, 10';
/*mysqli['adminmyrelationdbc'] = 'select id,from_id,SUBSTR(m.message,1,200)as message_short,title,date_format(m.date_added,"%m/%d/%Y") as date_add,target_no,cost,(select count(interest) from pmb as p where p.rpool_id = m.id and interest = 1) as total_requests from pmb_pool as m {{whr}} order by m.id desc ';*/
mysqli['adminmyrelationdbc'] = 'select m.id,from_id,SUBSTR(m.message,1,200)as message_short,title,date_format(m.date_added,"%m/%d/%Y %H:%i") as date_add,target_no,cost,(select count(interest) from pmb as p where p.rpool_id = m.id and interest = 1) as total_requests from pmb_pool as m {{whr}} {{where2}} order by m.id desc ';
mysqli['relationshipdownloaddb'] = 'select id,SUBSTR(m.message,1,200)as message_short,title,date_format(m.date_added,"%m/%d/%Y") as date_add,target_no,cost,(select count(interest) from pmb as p where p.rpool_id = m.id and interest = 1) as total_requests from pmb_pool as m where m.id =? order by m.id desc ';
mysqli['rinterestdetailsdb'] = 'SELECT p.to_id,to_status from pmb as p  where p.rpool_id = ? and p.interest =1 ';
mysqli['rinterestdetailsdbc'] = 'SELECT p.to_id,to_status from pmb as p  where p.rpool_id = ? and p.interest =1 limit ?, 10';
mysqli['bustargetcountd'] = 'SELECT count(s.user_id) as countuser FROM shipping as s left join user_extras as e ON s.user_id = e.user_id where e.business_type=? and s.country=? and s.state = ? and e.user_id != ? {{where}} ';
mysqli['timer7new'] = 'select a.qty,a.cart_id as id,a.project_id,b.date_added from cart_temp as a inner join cart_temp as b on a.r_id = b.r_id and b.cart_id = (select c.cart_id from cart_temp as c where c.r_id = b.r_id order by c.cart_id asc limit 1) where a.user_id = ?';
// mysqli['current_campaigns'] ='SELECT count(id) as total_ad, sum(s_click) as s_click, budget_per_click, IFNULL(sum(total_clicks_allowed),0) as total_clicks_allowed, IFNULL(sum(budget_per_click),0) as total_ad_amount,IFNULL(sum(budget_per_day),0) as ads_spend, IFNULL(sum(no_of_clicks),0) as total_clicks, sum(no_of_views) as total_impressions FROM `adwords` where user_id = ?';
// mysqli['current_campaigns'] ='select (select count(id) from adwords where status = "active") as total_ads, ROUND(IFNULL(sum(at.clicks * a.budget_per_click),0.00),2) as ads_spend, IFNULL(sum(at.clicks),0) as total_clicks, IFNULL(sum(at.s_click),0) as total_s_clicks, IFNULL(sum(at.views),0) as views, IFNULL(sum(a.total_clicks_allowed),0) as total_clicks_allowed from ads_track at left join adwords a on at.ads_id = a.id where user_id = ?';
mysqli['current_campaigns'] ='select (select count(id) from adwords where status = "active") as total_ads, IFNULL(ROUND(sum(at.clicks * a.budget_per_click),2),0.00) as ads_spend, IFNULL(sum(at.clicks),0) as total_clicks, IFNULL(sum(at.s_click),0) as total_s_clicks, IFNULL(sum(at.views),0) as views, IFNULL(sum(a.total_clicks_allowed),0) as total_clicks_allowed from ads_track at left join adwords a on at.ads_id = a.id where user_id = ?';
mysqli['insert_ads_clicks_day']='INSERT INTO ads_track ( ads_id, views, clicks, date_added) VALUES ( ?, ?, ?, ?)';
mysqli['update_ads_clicks_day']='UPDATE ads_track  SET  clicks = clicks+1 WHERE  id = ?';
mysqli['get_ads_track']='SELECT * FROM ads_track WHERE  date_added= ? AND  ads_id = ?';
mysqli['recurringdetailsnew'] = 'select p.*,r.*,c.qty as tqty from cart_temp as c left join projects as p ON c.project_id =p.id left join recurring_purchase as r ON c.r_id = r.tcartid where c.user_id = ? and p.id in (?)'
mysqli['deleterecurringcde'] = 'delete from recurring_purchase  where  project_id = ? and user_id = ? and tcartid = ?';
mysqli['ads_graphdata'] ='SELECT IFNULL(sum(at1.clicks * a.budget_per_click),0) as total_ads_spend, sum(at1.clicks) as total_clicks,sum(at1.views) as total_impressions,sum(at1.s_click) as s_click, at1.date_added FROM ads_track as at1 join adwords as a on a.id=at1.ads_id WHERE a.user_id = ? {{where}} GROUP BY date(at1.date_added)';

mysqli['myproductsbrandb'] = 'select user_id ,id,brand from projects where user_id = ?  {{where}} and brand != "" GROUP BY brand order by id desc';
mysqli['featuredBrands'] = 'SELECT a.* {{innerq}} FROM adwords a WHERE  if(a.end_date !="0000-00-00",a.end_date >= CURDATE(),true) AND a.status = "active" AND budget_per_day DIV budget_per_click > no_of_clicks {{where}}   {{limit}}';
// mysqli['featuredsupplier'] = 'SELECT a.* {{innerq}} FROM adwords a WHERE  if(a.end_date !="0000-00-00",a.end_date >= CURDATE(),true) AND a.status = "active" AND budget_per_day DIV budget_per_click > no_of_clicks {{where}}   {{limit}}';
mysqli['featuredsupplier'] = 'SELECT IFNULL((select sum(avg_rating)/count(id) from seller_performance where store_id = a.store_id),0) as store_rating, a.* {{innerq}} FROM adwords a left join user_extras as ue on a.user_id = ue.user_id WHERE  if(a.end_date !="0000-00-00",a.end_date >= CURDATE(),true) AND a.status = "active" and (ue.business_type="supplier") AND budget_per_day DIV budget_per_click > no_of_clicks {{where}}   {{limit}}';
mysqli['featuredaccessories'] = 'SELECT a.* {{innerq}} FROM adwords a left join user_extras ue on a.user_id = ue.user_id WHERE a.brand_name = "" and ue.business_type like "%supplier%" and if(a.end_date !="0000-00-00",a.end_date >= CURDATE(),true) AND a.status = "active" AND budget_per_day DIV budget_per_click > no_of_clicks {{where}}   {{limit}}';
mysqli['updateimpressclick']='UPDATE adwords  SET  no_of_views = no_of_views+1 WHERE  id IN (?)';
mysqli['get_ads_track_impree']='SELECT * FROM ads_track WHERE  date_added= ? and ads_id =?';
mysqli['updateimpreesadsclick_insert']='INSERT INTO ads_track ( ads_id, views, clicks, date_added) VALUES ( ?, ?, ?, ?)';
mysqli['updateimpreesadsclick_update']='UPDATE ads_track  SET  views = views+1 WHERE  id = ?';

// mysqli['dbbuyyerrecurringtab'] = 'select p.*,b.id as rid,b.user_id,b.project_id,b.frequency,b.count,b.quantity, date_format(b.sdate,"%d/%m/%Y")as sdate, date_format(b.edate,"%d/%m/%Y")as edate,b.cancellation from recurring_purchase AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.cancelled = 0 order by p.id DESC  limit ?,?';
// mysqli['dbbuyyerrecurringtabc'] = 'select count(p.id) as productsCountr from recurring_purchase AS b inner join projects as p on p.id = b.project_id and b.user_id = ? and b.cancelled = 0 order by p.id DESC';

mysqli['sellerrecuring'] = 'select IFNULL((SELECT date_format(recurring_at,"%m/%d/%Y @ %H:%i") FROM recurring_schedule WHERE recur_purchase_id=r.id AND recurring_at < NOW() ORDER BY id DESC LIMIT 0,1),0) AS current_r_date, '+
'(SELECT id FROM recurring_schedule WHERE recur_purchase_id=r.id AND recurring_at < NOW() ORDER BY id DESC LIMIT 0,1) AS current_r_id,'+ 
'IFNULL((SELECT position FROM recurring_schedule WHERE recur_purchase_id=r.id AND recurring_at < NOW() ORDER BY id DESC LIMIT 0,1),0) AS current_position,'+ 
'(SELECT id FROM buynow WHERE recurring="1" AND rec_purchase_id=r.id AND project_id=p.id AND request_userid=p.user_id ORDER BY id DESC LIMIT 0,1) AS b_id, '+
'(SELECT user_id FROM buynow WHERE recurring="1" AND rec_purchase_id=r.id AND project_id=p.id AND request_userid=p.user_id ORDER BY id DESC LIMIT 0,1) AS buyer_id, '+
'(SELECT shipping_status FROM buynow WHERE recurring="1" AND rec_purchase_id=r.id AND project_id=p.id AND request_userid=p.user_id ORDER BY id DESC LIMIT 0,1) AS b_shipping_status, '+
'(SELECT DATE_ADD(paid_date, INTERVAL 72 hour) FROM buynow WHERE recurring="1" AND rec_purchase_id=r.id AND project_id=p.id AND request_userid=p.user_id ORDER BY id DESC LIMIT 0,1) AS b_timer, '+

'IFNULL((SELECT date_format(recurring_at,"%m/%d/%Y @ %H:%i") FROM recurring_schedule WHERE recur_purchase_id=r.id AND recurring_at >= NOW() ORDER BY id ASC LIMIT 0,1),0) AS next_r_date, '+
'(SELECT id FROM recurring_schedule WHERE recur_purchase_id=r.id AND recurring_at >= NOW() ORDER BY id ASC LIMIT 0,1) AS next_r_id, '+
'IFNULL((select ROUND(sum(avg_rating)/count(id)) from seller_performance where seller_id = p.user_id),0) as seller_rating, p.id, p.title, p.description,p.tags, p.sprice, p.bprice, p.qty, p.filled_qty, p.rfilled_qty, p.market_status, p.user_id, p.trading_type, p.order_type, p.unit_price, p.units, date_format(p.created_at,"%m/%d/%Y @ %H:%i")as postedDate, date_format(p.date_added,"%m/%d/%Y @ %H:%i")as start_date,  DATE_SUB(p.date_added, INTERVAL 72 hour) as checkAvail, p.date_added, p.created_at, p.updated_at, p.avatar, p.image, p.test_result,p.test_result_img, p.cannabis_type, r.*, r.id as r_id, r.status as r_status,r.cancellation, r.status as r_status, r.cancelreq, date_format(r.cancelreq_at,"%m/%d/%Y @ %H:%i") as cancelreq_at, r.sapprove_status, date_format(r.sapprove_at,"%m/%d/%Y @ %H:%i") as sapprove_at, r.aapprove_status, date_format(r.aapprove_at,"%m/%d/%Y @ %H:%i") as aapprove_at, date_format(r.sdate,"%m/%d/%Y @ %H:%i")as ssdate, date_format(r.edate,"%m/%d/%Y @ %H:%i")as eedate from projects p  join recurring_purchase r ON p.id = r.project_id where p.user_id =? {{whr}} order by r.id desc limit ?, ?';
mysqli['sellerrecuringc'] = 'select  count(p.id) as rcurrcount from projects p  join recurring_purchase r ON p.id = r.project_id where p.user_id =? {{whr}} order by p.id desc';
mysqli['sellerrejected'] = 'select p.id, p.title, p.description,p.tags, p.sprice, p.qty, p.filled_qty, p.rfilled_qty, p.market_status, p.user_id, p.trading_type, p.order_type, p.unit_price, p.units, date_format(p.created_at,"%m/%d/%Y @ %H:%i")as postedDate, date_format(p.date_added,"%m/%d/%Y @ %H:%i")as start_date, DATE_SUB(p.date_added, INTERVAL 72 hour) as checkAvail, p.date_added, p.created_at, p.updated_at, p.avatar, p.image, p.test_result,p.test_result_img, p.cannabis_type,n.reject_mesg,n.qty_request from projects p join negotiable n ON p.id = n.project_id where p.user_id = ? and n.declined = 1 {{whr}} order by n.id desc  limit ?, ?';
mysqli['sellerrejectedc'] = 'select count(p.id) as rcurrcount from projects p join negotiable n ON p.id = n.project_id where p.user_id = ? and n.declined = 1 {{whr}} order by n.id desc ';

/* mysqli['sellerinventory'] = 'select p.id, p.title, p.description,p.tags, p.sprice, p.qty, p.filled_qty, p.rfilled_qty, p.market_status, p.user_id, p.trading_type, p.order_type, p.unit_price, p.units, date_format(p.created_at,"%m/%d/%Y @ %H:%i")as postedDate, date_format(p.date_added,"%m/%d/%Y @ %H:%i")as start_date, DATE_SUB(p.date_added, INTERVAL 72 hour) as checkAvail, p.date_added, p.created_at, p.updated_at, p.avatar, p.image, p.test_result,p.test_result_img, p.cannabis_type,n.reject_mesg,n.qty_request from projects p left join negotiable n ON p.id = n.project_id where p.user_id = ? and p.auction = 0 and (p.market_status= "closed" or p.market_status = "sold") {{whr}} order by n.id desc  limit ?, ?';
mysqli['sellerinventoryc'] = 'select count(p.id) as rcurrcount from projects p left join negotiable n ON p.id = n.project_id where p.user_id = ? and p.auction = 0 {{whr}} order by n.id desc '; */
mysqli['sellerinventory'] = 'select '
+'(qty - (SELECT IFNULL(SUM(qty),0) FROM cart_temp WHERE project_id=p.id) - (SELECT IFNULL(ROUND(SUM(qty)),0) FROM recurring_schedule WHERE product_id=p.id AND recurring_at>CURDATE()) - (SELECT IFNULL(ROUND(SUM(qty)),0) FROM buynow WHERE project_id=p.id AND delivery_status="0") - (SELECT IFNULL(ROUND(SUM(qty)),0) FROM buynow WHERE project_id=p.id AND delivery_status="1") ) AS remain_quantity,'
+' (SELECT IFNULL(SUM(qty),0) FROM cart_temp WHERE project_id=p.id) AS items_in_cart, (SELECT IFNULL(ROUND(SUM(qty)),0) FROM recurring_schedule WHERE product_id=p.id) AS items_in_recurring, (SELECT IFNULL(ROUND(SUM(qty)),0) FROM buynow WHERE project_id=p.id AND delivery_status="0") AS items_in_pending_delivery, (SELECT IFNULL(ROUND(SUM(qty)),0) FROM buynow WHERE project_id=p.id AND delivery_status="1") AS items_in_success_delivery, p.pkey AS sku, p.id, p.title, p.description,p.tags, p.sprice, p.qty, p.sold, p.filled_qty, p.rfilled_qty, p.market_status, p.user_id, p.trading_type, p.order_type, p.unit_price, p.units, date_format(p.created_at,"%m/%d/%Y @ %H:%i")as postedDate, date_format(p.date_added,"%m/%d/%Y @ %H:%i")as start_date, DATE_SUB(p.date_added, INTERVAL 72 hour) as checkAvail, p.date_added, p.created_at, p.updated_at, p.avatar, p.image, p.test_result,p.test_result_img, p.cannabis_type, p.metrc_id,n.reject_mesg,n.qty_request from projects p left join negotiable n ON p.id = n.project_id where p.user_id = ? and p.auction = 0 {{whr}} {{ordering}} limit ?, ?';
mysqli['sellerinventoryc'] = 'select count(p.id) as rcurrcount from projects p left join negotiable n ON p.id = n.project_id where p.user_id = ? and p.auction = 0 {{whr}} order by n.id desc ';

mysqli['selleraccepted'] = 'select p.id, p.title, p.description,p.tags, p.sprice, p.qty, p.filled_qty, p.rfilled_qty, p.market_status, p.user_id, p.trading_type, p.order_type, p.unit_price, p.units, date_format(p.created_at,"%m/%d/%Y @ %H:%i")as postedDate, date_format(p.date_added,"%m/%d/%Y @ %H:%i")as start_date, DATE_SUB(p.date_added, INTERVAL 72 hour) as checkAvail, p.date_added, p.created_at, p.updated_at, p.avatar, p.image, p.test_result,p.test_result_img, p.cannabis_type from projects p join negotiable n ON p.id = n.project_id where p.user_id = ? and n.awarded = 1 order by n.id desc  limit ?, ?';
mysqli['selleracceptedc'] = 'select count(p.id) as rcurrcount from projects p join negotiable n ON p.id = n.project_id where p.user_id = ? and n.awarded = 1 order by p.id desc ';
mysqli['updateprojectqty'] = 'update projects set qty = qty - ? where id = ?';
mysqli['updateprojectsold'] = 'update projects set sold = sold + ? where id = ?';
mysqli['checprocount'] = 'select * from projects where id = ?';
mysqli['rpollsentdetails'] = 'SELECT * from pmb as p  where p.rpool_id = ? ';
mysqli['rpollsentdetailsc'] = 'SELECT * from pmb as p  where p.rpool_id = ? limit ?, 10';
mysqli['getprobid'] = 'SELECT * from negotiable   where project_id = ? and awarded != 1';
mysqli['updatebidstatus'] ='UPDATE negotiable SET declined = 1 WHERE id = ?';

/* Decline the remainng negotiable requests whinch does not satisfied with the remaining quantity */
mysqli['reject_remain_nreq'] ='UPDATE negotiable SET declined = 1, declined_date=?, reject_mesg = ? WHERE project_id = ? and awarded = 0 and qty_request > ?';


mysqli['storeupdate'] = 'update stores set name=?,description=?,logo=?,pname=?,phone =?,street =?,city=?,state=?,zip=?,address=?,updated_at=? where id = ?';
mysqli['selectstoreads'] = 'SELECT * FROM adwords WHERE store_id = ? and status != "remove" and type = "store" ORDER BY id DESC ';
mysqli['updatestoreads'] = 'update adwords set ad_name = ?, ad_title = ?, ad_content = ? WHERE id in (?)';
mysqli['selectstoreadsid'] = 'SELECT id FROM adwords WHERE store_id = ?';
mysqli['selectstorebrand'] = 'SELECT * FROM adwords WHERE store_id = ? and type="product" and brand_name!="" and end_date > ? GROUP BY brand_name ORDER BY id DESC ';
mysqli['selectstorebrandnew'] = ' select user_id ,id,brand from projects where user_id = ? {{where}} and brand != "" and brand NOT IN(SELECT brand_name FROM adwords WHERE store_id = ? and type="product" and brand_name!="" and end_date > ? GROUP BY brand_name ORDER BY id DESC ) GROUP BY brand order by id desc'; 
mysqli['new19'] = 'select p.*,(select count(distinct pr.user_id) as bidder from product_requests as pr where p.id = pr.product_id) as bidders, (select count(distinct pr.id) as bid from product_requests as pr where p.id = pr.product_id) as bids,date_format(p.date_added,"%m/%d/%Y @ %H:%i") as date_add,date_format(p.date_added,"%m/%d/%Y %H:%i") as date_add,date_format(p.date_closed,"%m/%d/%Y @ %H:%i") as date_close, c.name,pc.name as pc_name,(select store_id from store_items as st where p.id = st.project_id limit 1) as store_id from projects as p left join categories as c on c.id = p.category_id left join categories as pc on pc.id = p.parent_category_id where p.id = ? limit 1'
mysqli['new19_db'] = 'select p.*,date_format(p.date_added,"%m/%d/%Y @ %H:%i") as date_add,date_format(p.date_closed,"%m/%d/%Y @ %H:%i") as date_close, c.name,(select store_id from store_items as st where p.id = st.project_id) as store_id from projects as p left join categories as c on c.id = p.category_id where p.id = ? limit 1'
mysqli['storedeletepdt'] = 'update projects set market_status="removed" where id= ?';
mysqli['listactiveads'] = 'select * from adwords a where status = "active" {{where}} order by id desc limit ?,10';
mysqli['listactiveadsc'] = 'select * from adwords a where status = "active" {{where}}';
mysqli['listinactiveads'] = 'select * from adwords a where status = "pause" {{where}} order by id desc limit ?,10';
mysqli['listinactiveadsc'] = 'select * from adwords a where status = "pause" {{where}}';
mysqli['liststores'] = 'select * from adwords a where type = "store" {{where}} order by id desc limit ?,10';
mysqli['liststoresc'] = 'select * from adwords a where type = "store" {{where}}';
mysqli['listproduct'] = 'select * from adwords a where type = "product" {{where}} order by id desc limit ?,10';
mysqli['listproductc'] = 'select * from adwords a where type = "product" {{where}}';
mysqli['listbrand'] = 'select * from adwords a where type = "product" and brand_name!="" {{where}} order by id desc limit ?,10';
mysqli['listbrandc'] = 'select * from adwords a where type = "product" and brand_name!="" {{where}}';
mysqli['adwords_delete_pause2'] = 'UPDATE adwords SET status = ? WHERE id =?';
mysqli['editStore'] = 'select * from adwords where type = "store" and id = ?';
mysqli['negobuynow'] = 'insert into buynow (project_id,user_id,amount,qty,paid,date_added) values(?,?,?,?,?,?)';
mysqli['negoamt'] = 'SELECT * from negotiable   where id=?';

/* generating pkey for products table using state_abbr and year format = MD000000001-17 */
mysqli['generate_pkey'] = 'update projects set pkey = CONCAT(state_abbr, id, "-",DATE_FORMAT(now(), "%y"))  where id = ? ';
mysqli['generate_invoiceid'] = 'update invoices set transactionid = CONCAT(id, "-",DATE_FORMAT(now(), "%y"))  where id = ? ';


/* getting state abbr by state */
mysqli['state_abbr'] = 'SELECT * FROM locations_states WHERE state = ?';
mysqli['usermaildata'] = 'select u.user_id from user_extras as u inner join user_notification as un on un.user_id=u.user_id where u.state = ? and u.business_type != "supplier" and FIND_IN_SET (52, un.email)';

/* Deleting reference after deletion of users */
mysqli['remove_all_products'] = 'update projects set market_status = "removed" where market_status = "open" and user_id = ?';
mysqli['remove_all_recurring'] = 'update recurring_purchase set status = "reject" where user_id = ? and status = "approve"';
mysqli['remove_all_adwords'] = 'update adwords set status = "remove",  updated_at = ? where status = "active" and  user_id = ?';
mysqli['reject_all_prdtrequest'] = 'update product_requests set rejected = 1,  rejected_date = ?, rejected_msg = "User account has been deleted" where user_id = ? and accepted = 0 and rejected = 0';
mysqli['get_buynow_details'] = 'select seller.id as seller_id, seller.email as seller_email, seller.first_name as seller_first_name, seller.last_name as seller_last_name, buyer.id as buyer_id, buyer.email as buyer_email, buyer.first_name as buyer_first_name, buyer.last_name as buyer_last_name, b.*,p.title,p.avatar,p.image from buynow as b left join projects as p on p.id = b.project_id left join herbes_local_users as buyer on b.user_id = buyer.id left join herbes_local_users as seller on b.request_userid = seller.id where b.id = ?';

/**********************************************************************************************************************************************
|								     	------------------api queries added here--------------												  |
**********************************************************************************************************************************************/


mysqli['insert_api_user'] = 'insert into api_users (api_key,app_key,user_name,project_name,zonal,created_at,status,payable, {{needed}}) values (?,?,?,?,?,?,?,?, {{enables}})';
mysqli['get_api_user'] = 'select * from api_users {{where}} ';
mysqli['get_all_timezones'] = 'select * from timezone';
mysqli['alter_user_table'] = 'ALTER TABLE {{table_name}} {{fields}}';

mysqli["check_bid_placed"] = 'select user_id,proposed_amount AS amt,id from {{table_name}} where project_id =  ? order by proposed_amount desc limit 1';
mysqli['get_user_bid'] = "SELECT bid_position FROM {{table_name}} WHERE user_id = ? AND project_id = ? ORDER BY id ASC LIMIT 1";
mysqli['bids_max_position_for_item'] = "SELECT max(bid_position) as bid_position FROM {{table_name}} WHERE project_id = ?";
mysqli['get_proxy_details_for_item'] = 'SELECT *,(SELECT bid_position FROM {{table_name1}} b WHERE pb.project_id = b.project_id AND pb.user_id = b.user_id LIMIT 1) as user_pos  FROM {{table_name2}} as pb {{where}}';
mysqli["user's_proxybid"] = 'SELECT * FROM {{table_name}} WHERE project_id = ? AND user_id = ?';
mysqli['insert_user_proxybid'] = 'INSERT INTO {{table_name}} (project_id,user_id,maxamount,date_added,status) VALUES (?,?,?,?,1)';
mysqli['update_user_proxybid'] = 'UPDATE {{table_name}} SET maxamount = ?,date_added = ?  WHERE project_id = ? AND user_id = ?';
mysqli['insert_bids_45'] = 'insert into {{table_name}}  (project_id,user_id,created_at,proposed_amount,proposal,reserved,reserved_date,bid_position) values (?,?,?,?,?,1,?,?)';
mysqli['insert_bids_45a'] = 'insert into {{table_name}}  (project_id,user_id,created_at,proposed_amount,reserved,reserved_date,bid_position,proposal,tied_bidder,currentbid_increment) values (?,?,?,?,?,1,?,?,?,?)';
mysqli['get_last_bid_amount'] = 'SELECT * FROM {{table_name}} WHERE project_id = ? and declined = 0 ORDER BY proposed_amount desc LIMIT 1';
mysqli['insert_bid_as_proxy_for_item'] = 'INSERT INTO {{table_name}} (project_id,user_id,proposed_amount,created_at,proposal, bid_position) VALUES (?,?,?,?,?,?)';
mysqli['insert_bids_20'] = 'insert into {{table_name}} (project_id,user_id,created_at,proposed_amount,proposal,bid_position) values (?,?,?,?,?,?)';
//mysqli['amount_duplicate'] = 'select a.id,a.user_id from {{table_name}} as a where a.project_id = ? and a.proposed_amount = ? and (a.id != (select b.id from {{table_name}} as b where b.project_id = a.project_id and b.proposed_amount = a.proposed_amount and b.proposal = "tie_bid" order by b.id asc limit 1) and a.id != (select c.id from {{table_name}} as c where c.project_id = a.project_id and c.proposed_amount = a.proposed_amount and c.proposal = "proxy_leads" order by c.id asc limit 1))';
mysqli['amount_duplicate'] = 'select a.id,a.user_id from {{table_name}} as a where a.project_id = ? and a.proposed_amount = ? order by a.id desc';
mysqli['delete_amount_duplicate'] = 'delete from {{table_name}} where project_id = ? and user_id = ? limit 1';
mysqli['update_max_amount_duplicate'] = 'update {{table_name}} set maxamount = ? where project_id = ? and user_id = ? limit 1';
mysqli['update_samount_duplicate'] = 'delete from {{table_name}} where id = ? limit 1';
mysqli['insert_samount_duplicate'] = 'insert into bids_duplicate (date_added,user_id,amount,project_id) values(?,?,?,?)';
mysqli['item_bid_information'] = 'select (select count(dt.id) as total_bids from {{table_name}} as dt where dt.project_id = b.project_id) as totalBids,(select max(dt.bid_position) as totalBidders from {{table_name}} as dt where dt.project_id = b.project_id) as totalBidders, b.proposed_amount as lastBidAmount,b.user_id as currentHighestBidder from {{table_name}} as b where b.project_id = ? and b.declined != 1 order by b.id desc limit 1';
mysqli['bid_history_of_item'] = 'select b.user_id as user_id,b.proposed_amount as bid_amount,b.bid_position,date_format(b.created_at,"%m/%d/%Y %H:%i:%s %p") as bidded_on from {{table_name}} AS b where b.project_id =  ? order by b.proposed_amount desc, b.id desc';
mysqli['get_award_bid'] = 'SELECT b.id,b.proposed_amount,b.user_id,b.awarded FROM {{table_name}} AS b WHERE  b.project_id = ? AND b.declined = 0 AND proposal != "tie_bid" ORDER  BY b.proposed_amount DESC LIMIT  1';
mysqli['get_award_bid_reaward'] = 'SELECT b.id,b.proposed_amount,b.user_id,b.awarded FROM {{table_name}} AS b WHERE  b.project_id = ? AND b.awarded = 1 ORDER BY b.proposed_amount DESC LIMIT  1';
mysqli['make_award_bid'] = 'update {{table_name}} set awarded = 1,awarded_date = ? where id =  ? and awarded = 0 and declined = 0 limit 1';
mysqli['decline_awarded_bid'] = 'update {{table_name}} set awarded = 0, declined = 1, declined_date = ? where id =  ? and awarded = 1 limit 1';
mysqli['reaward_bid'] = 'UPDATE {{table_name}} SET awarded = 1, declined = 0, awarded_date = ? WHERE user_id = ? and project_id = ? ORDER BY proposed_amount DESC LIMIT 1'
mysqli['last_bidders'] = 'SELECT GROUP_CONCAT(DISTINCT user_id) lostBidders FROM {{table_name}} where user_id != (select b.user_id from {{table_name}} as b where b.project_id = ? and b.declined = 0 order by b.id desc limit 1) and project_id = ?';
mysqli['users_winning_bid'] = 'SELECT b.project_id as item_id,Max(b.proposed_amount) as winningBid,(SELECT count(c.id) AS cnt FROM {{table_name}} AS c WHERE b.project_id = c.project_id) AS totalBids FROM {{table_name}} AS b WHERE b.user_id = ? AND (select count(bb.id) as cnt from {{table_name}} as bb where b.project_id = bb.project_id and bb.user_id = b.user_id and bb.awarded = 1) = 1 GROUP BY b.project_id ORDER BY b.id DESC {{order_by}}';
mysqli['users_lost_bid'] = 'SELECT b.project_id as item_id,Max(b.proposed_amount) as userLastBid,(SELECT max(bc.proposed_amount) AS cnt FROM {{table_name}} AS bc WHERE b.project_id = bc.project_id ) AS winningBid,(SELECT count(c.id) AS cnt FROM {{table_name}} AS c WHERE b.project_id = c.project_id) AS totalBids FROM {{table_name}} AS b WHERE  b.user_id = ? AND (select count(bb.id) as cnt from {{table_name}} as bb where b.project_id = bb.project_id and bb.user_id = b.user_id and bb.awarded = 1) = 0 AND (select count(bd.id) as cnt from {{table_name}} as bd where b.project_id = bd.project_id and bd.awarded = 1) = 1 GROUP BY b.project_id ORDER BY b.id DESC {{order_by}}';
mysqli['users_active_bid'] = 'SELECT b.project_id AS item_id,Max(b.proposed_amount) AS userLastBid,(SELECT max(bc.proposed_amount) AS cnt FROM {{table_name}} AS bc WHERE b.project_id = bc.project_id ) AS currentBid,(SELECT count(c.id) AS cnt FROM {{table_name}} AS c WHERE b.project_id = c.project_id) AS totalBids FROM {{table_name}} AS b WHERE  b.user_id = ? AND (SELECT count(bb.id) AS cnt FROM {{table_name}} AS bb WHERE b.project_id = bb.project_id AND bb.awarded = 1)=0 GROUP BY b.project_id ORDER BY b.id DESC {{order_by}}';
mysqli['adminuser'] = 'select * from admin_users where email = ?';
mysqli['adminuserotp'] = 'update admin_users set encrypted_password = ? where id = ?';
mysqli['findemail'] = 'select * from templates where title = ?';
mysqli['api_users'] = 'select a.*, ( SELECT COUNT(*) FROM `requests` WHERE `api_user_id` = `a`.`id` ) AS `req_count` from api_users a left join requests r on r.api_user_id = a.id group by a.id order by a.id desc';
mysqli['api_update'] = 'UPDATE api_users set enabled = 1 where api_key = ?'
mysqli['api_disable'] = 'UPDATE api_users set enabled = 0 where api_key = ?'
mysqli['adminuserupdate'] = 'update admin_users set sign_in_count = ?, current_sign_in_at = ?, last_sign_in_at = ?, current_sign_in_ip = ?, last_sign_in_ip = ? where id = ?';
mysqli['checkusername'] = 'SELECT * from api_users where user_name = ?';
mysqli['checkprojectname'] = 'SELECT * from api_users where project_name = ?';
mysqli['getalldata'] = 'SELECT * from api_users where user_name = ? and project_name = ?';
mysqli['multiple_item_bid_information'] = 'select (select count(dt.id) as total_bids from {{table_name}} as dt where dt.project_id = b.project_id) as totalBids,(select max(dt.bid_position) as totalBidders from {{table_name}} as dt where dt.project_id = b.project_id) as totalBidders,b.project_id as item_id, b.proposed_amount as lastBidAmount,b.user_id as currentHighestBidder from {{table_name}} as b where b.project_id in (?) and b.declined = 0 order by b.id desc limit 1';
mysqli['user_exists_in_bids'] = 'select * from {{table_name}} as b where b.user_id = ? and b.project_id = ?';
mysqli['get_all_user_maxamount'] = 'SELECT DISTINCT a.user_id,(select max(proposed_amount) from {{table_name}} as b where b.user_id = a.user_id AND b.project_id = ?) as max_amount from {{table_name}} as a where a.project_id = ?'
mysqli['create_users_table1'] = "CREATE TABLE IF NOT EXISTS {{table_name}} (`id` int(11) NOT NULL,`email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`role` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`password_confirmation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`notification` tinyint(1) DEFAULT NULL,`password_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`password_salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`created_at` datetime DEFAULT NULL,`updated_at` datetime DEFAULT NULL,`auth_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`password_reset_sent_at` datetime DEFAULT NULL,`provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`oauth_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`oauth_expires_at` datetime DEFAULT NULL,`username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`activation` date DEFAULT NULL,`userimageurl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`tagline` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`contractor_id` int(11) DEFAULT NULL,`timezone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`category_email` int(11) DEFAULT NULL,`day_light_saving` int(11) DEFAULT NULL,`video_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`balance` float(10,2) NOT NULL DEFAULT '0.00',`customerid` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`paymentid` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`balance_amount` float(10,2) NOT NULL DEFAULT '0.00',`reserve_amount` float(10,2) NOT NULL DEFAULT '0.00',`aboutme` text COLLATE utf8_unicode_ci NOT NULL,`image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,`avatar` varchar(255) COLLATE utf8_unicode_ci NOT NULL,`paymethod` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'stripe',`status` enum('active','unsubscribe','moderate','unverified','deactivate') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',`admin` int(1) NOT NULL DEFAULT '0',`fb_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`tw_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`fb_json` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`tw_json` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`li_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`li_json` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`review` float(10,2) NOT NULL DEFAULT '0.00',`profile_url` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`paypal_address` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`used_image_space` float(20,2) NOT NULL,`deposit_amount` float(20,2) NOT NULL,`verifyphone` int(11) NOT NULL,`nick_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL)";
mysqli['create_users_table2'] = "ALTER TABLE {{table_name}} ADD PRIMARY KEY (`id`),ADD KEY `index_users_on_contractor_id` (`contractor_id`)";
mysqli['create_users_table3'] = "ALTER TABLE {{table_name}} MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";
mysqli['create_cart_temp_table1'] = "CREATE TABLE IF NOT EXISTS {{table_name}} (`cart_id` int(100) NOT NULL,`r_id` int(100) NOT NULL,`project_id` int(100) NOT NULL,`user_id` int(100) NOT NULL,`date_added` datetime NOT NULL,`paid` int(100) NOT NULL,`revert` int(100) NOT NULL,`qty` int(100) NOT NULL)";
mysqli['create_cart_temp_table2'] = "ALTER TABLE {{table_name}} ADD PRIMARY KEY (`cart_id`)";
mysqli['create_cart_temp_table3'] = "ALTER TABLE {{table_name}} MODIFY `cart_id` int(100) NOT NULL AUTO_INCREMENT";
mysqli['create_projects_table1'] = "CREATE TABLE IF NOT EXISTS {{table_name}} (`id` int(11) NOT NULL,`title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`description` text COLLATE utf8_unicode_ci,`avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`document` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`date_added` datetime DEFAULT NULL,`date_closed` datetime DEFAULT NULL,`category_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`subcategory` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`tags` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`sprice` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`rprice` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`work_loc` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,`country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`user_id` int(11) DEFAULT NULL,`invite_people` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`status` tinyint(1) DEFAULT NULL,`created_at` datetime DEFAULT NULL,`updated_at` datetime DEFAULT NULL,`budget_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`buynow` int(100) NOT NULL DEFAULT '0',`feature` int(11) NOT NULL,`home_page_listing_fee` int(11) NOT NULL,`shipping_price` float(10,2) NOT NULL,`shipping_description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`bprice` float(10,2) NOT NULL,`mprice` float(10,2) NOT NULL DEFAULT '0.00',`iprice` float(10,2) NOT NULL DEFAULT '0.00',`wprice` float(10,2) NOT NULL,`market_status` enum('open','closed','sold','draft','removed','moderate') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open',`auction` int(1) NOT NULL DEFAULT '0',`is_same_location` int(1) NOT NULL DEFAULT '0',`qty` int(100) NOT NULL DEFAULT '1',`sold` int(100) NOT NULL DEFAULT '0',`paypal_address` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`future` int(1) NOT NULL,`duration` int(100) NOT NULL,`time` int(10) NOT NULL,`time_level` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`duration_type` enum('D','W','M','Y') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'D',`booked` int(100) NOT NULL DEFAULT '0',`city` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`sell_location` varchar(500) COLLATE utf8_unicode_ci NOT NULL,`used_image_space` float(20,2) NOT NULL,`is_digital` int(1) NOT NULL DEFAULT '0',`vauction` int(10) NOT NULL DEFAULT '0',`listing_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`start_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`start_day` int(11) NOT NULL,`start_hour` int(11) NOT NULL,`start_minute` int(11) NOT NULL,`sales_tax` decimal(32,2) NOT NULL,`sell_as_a_lot` tinyint(1) NOT NULL,`available_on` datetime DEFAULT NULL,`auction_day` int(11) NOT NULL,`auction_hour` int(11) NOT NULL,`auction_minute` int(11) NOT NULL,  `auction_date` datetime DEFAULT NULL,`offer_down_day` int(11) NOT NULL,`offer_down_hour` int(11) NOT NULL,`offer_down_minute` int(11) NOT NULL,`offer_down_price` decimal(10,0) DEFAULT NULL,`offer_down_type` int(11) NOT NULL,`sub_title` varchar(225) COLLATE utf8_unicode_ci NOT NULL,`sku` varchar(255) COLLATE utf8_unicode_ci NOT NULL,`product_condition_id` int(11) NOT NULL,`payment_detail_id` int(11) NOT NULL,`quick_notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`youtube_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`discontinue_on` datetime DEFAULT NULL,`deleted_at` datetime DEFAULT NULL,`product_model` varchar(225) COLLATE utf8_unicode_ci NOT NULL,`product_brand` varchar(225) COLLATE utf8_unicode_ci NOT NULL,`product_upc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,`slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,`meta_title` varchar(225) COLLATE utf8_unicode_ci NOT NULL,`meta_description` text COLLATE utf8_unicode_ci NOT NULL,`meta_keywords` varchar(255) COLLATE utf8_unicode_ci NOT NULL,`tax_category_id` int(11) NOT NULL,`shipping_category_id` int(11) NOT NULL,`promotionable` tinyint(4) NOT NULL DEFAULT '1',`store_id` int(11) NOT NULL,`approved` tinyint(4) NOT NULL DEFAULT '0',`accept_return` tinyint(4) NOT NULL DEFAULT '0',`return_days_count` int(11) DEFAULT NULL,`return_method` varchar(225) COLLATE utf8_unicode_ci DEFAULT NULL,`restocking_fee` tinyint(4) DEFAULT NULL,`restocking_fee_price` decimal(10,0) DEFAULT NULL,`restocking_fee_price_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`return_shipping_paid_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`return_policy` text COLLATE utf8_unicode_ci NOT NULL,`terms_and_condition` text COLLATE utf8_unicode_ci NOT NULL,`shipping_method_id` int(11) DEFAULT NULL,`weight_lbs` decimal(32,2) DEFAULT NULL,`weight_oz` decimal(32,2) DEFAULT NULL,`length` decimal(32,2) DEFAULT NULL,`width` decimal(32,2) DEFAULT NULL,`height` decimal(32,2) DEFAULT NULL,`delivery_time_id` int(11) DEFAULT NULL,`shipping_type_id` int(11) DEFAULT NULL,`international_shipping` tinyint(4) DEFAULT NULL,PRIMARY KEY (`id`))";
//mysqli['create_projects_table1'] = "CREATE TABLE {{table_name}} (`id` int(11) NOT NULL,`title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`description` text COLLATE utf8_unicode_ci,`avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`document` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`date_added` datetime DEFAULT NULL,`date_closed` datetime DEFAULT NULL,`category_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`subcategory` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`tags` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`sprice` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`rprice` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`work_loc` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,`country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`user_id` int(11) DEFAULT NULL,`invite_people` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`status` tinyint(1) DEFAULT NULL,`created_at` datetime DEFAULT NULL,`updated_at` datetime DEFAULT NULL,`budget_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,`buynow` int(100) NOT NULL DEFAULT '0',`feature` int(11) NOT NULL,`home_page_listing_fee` int(11) NOT NULL,`shipping_price` float(10,2) NOT NULL,`shipping_description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`bprice` float(10,2) NOT NULL,`mprice` float(10,2) NOT NULL DEFAULT '0.00',`iprice` float(10,2) NOT NULL DEFAULT '0.00',`wprice` float(10,2) NOT NULL,`market_status` enum('open','closed','sold','draft','removed','moderate') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open',`auction` int(1) NOT NULL DEFAULT '0',`is_same_location` int(1) NOT NULL DEFAULT '0',`qty` int(100) NOT NULL DEFAULT '1',`sold` int(100) NOT NULL DEFAULT '0',`paypal_address` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`future` int(1) NOT NULL,`duration` int(100) NOT NULL,`time` int(10) NOT NULL,`time_level` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`duration_type` enum('D','W','M','Y') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'D',`booked` int(100) NOT NULL DEFAULT '0',`city` varchar(100) COLLATE utf8_unicode_ci NOT NULL,`sell_location` varchar(500) COLLATE utf8_unicode_ci NOT NULL,`used_image_space` float(20,2) NOT NULL,`is_digital` int(1) NOT NULL DEFAULT '0',`vauction` int(10) NOT NULL DEFAULT '0')"
mysqli['create_projects_table2'] = "ALTER TABLE {{table_name}} ADD PRIMARY KEY (`id`)";
mysqli['create_projects_table3'] = "ALTER TABLE {{table_name}} MODIFY `id` int(10) NOT NULL AUTO_INCREMENT";
mysqli['create_bidding_table1'] = "CREATE TABLE IF NOT EXISTS {{table_name}} (`id` int(11) NOT NULL,`project_id` int(11) DEFAULT NULL,`user_id` int(11) DEFAULT NULL,`details` text COLLATE utf8_unicode_ci,`accepted` tinyint(1) DEFAULT '0',`withdrawn` tinyint(1) DEFAULT '0',`featured` tinyint(1) DEFAULT '0',`estimated_days` int(11) DEFAULT NULL,`proposed_amount` float(10,2) DEFAULT '0.00',`bid_position` int(11) NOT NULL,`proposal` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,`earned_amount` int(11) DEFAULT NULL,`created_at` datetime DEFAULT NULL,`updated_at` datetime DEFAULT NULL,`awarded` tinyint(1) DEFAULT '0',`declined` tinyint(1) DEFAULT '0',`hidden` tinyint(1) DEFAULT '0',`violation` tinyint(1) DEFAULT '0',`awarded_date` date DEFAULT NULL,`accepted_date` date DEFAULT NULL,`declined_date` date DEFAULT NULL,`reserved` int(1) NOT NULL DEFAULT '0',`reserved_date` datetime NOT NULL,`status` tinyint(4) NOT NULL DEFAULT '1',`tied_bidder` int(11) NOT NULL,`currentbid_increment` float(10,2) NOT NULL)";
mysqli['create_bidding_table2'] = "ALTER TABLE {{table_name}} ADD PRIMARY KEY (`id`),ADD KEY `project_id` (`project_id`),ADD KEY `user_id` (`user_id`);";
mysqli['create_bidding_table3'] = "ALTER TABLE {{table_name}} MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;";
mysqli['create_proxy_table1'] = "CREATE TABLE IF NOT EXISTS {{table_name}} (`id` int(10) NOT NULL,`project_id` int(11) NOT NULL DEFAULT '0',`user_id` int(11) NOT NULL DEFAULT '0',`maxamount` double(17,2) NOT NULL DEFAULT '0.00',`date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',`status` int(11) NOT NULL)";
mysqli['create_proxy_table2'] = "ALTER TABLE {{table_name}} ADD PRIMARY KEY (`id`),ADD KEY `project_id` (`project_id`),ADD KEY `user_id` (`user_id`);";
mysqli['create_proxy_table3'] = "ALTER TABLE {{table_name}} MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;";
mysqli['api_user_get_query'] = "select * from api_users where id = ?";
mysqli['update_api_user'] = "UPDATE api_users set {{needed}}, {{notneeded}} zonal = ? where id = ?";
mysqli['drop_table'] = "DROP TABLE IF EXISTS {{table_name}}"
mysqli['insert_transaction'] = 'INSERT into requests(txn_id, request_url, status,success_code, error_code, error_message, error_state,payable_transaction,api_user_id) VALUES (?,?,?,?,?,?,?,?,?)'
mysqli['manage_dashboard'] = 'SELECT COUNT(DISTINCT(r.id)) as total_requests, (SELECT COUNT(DISTINCT(r.id)) FROM api_users a join requests r on r.api_user_id = a.id where r.status = "Success" )  as total_success, (SELECT COUNT(DISTINCT(r.id)) FROM api_users a join requests r on r.api_user_id = a.id where r.status = "failed" )  as total_failed, (SELECT COUNT(DISTINCT(r.id)) FROM requests r where r.error_state = "critical" )  as total_critical, (SELECT COUNT(DISTINCT(r.id)) FROM api_users a join requests r on r.api_user_id = a.id where r.error_state = "minor" )  as total_minor, (SELECT COUNT(DISTINCT(r.id)) FROM api_users a join requests r on r.api_user_id = a.id where r.error_state = "major" )  as total_major, (SELECT COUNT(DISTINCT(a.id)) FROM api_users a)  as total_projects, (SELECT COUNT(DISTINCT(a.id)) FROM api_users a where a.enabled = 1)  as total_active, (SELECT COUNT(DISTINCT(a.id)) FROM api_users a where a.enabled = 0)  as total_inactive FROM api_users a join requests r on r.api_user_id = a.id order by r.id DESC'
mysqli['request_tracker'] = 'SELECT DATE(created_at) Date, COUNT(DISTINCT id) totalRequestsPerDay FROM requests GROUP BY DATE(created_at)'
mysqli['request_track_by_hour'] = 'SELECT HOUR(created_at) as hour, COUNT(*) as totalRequestsPerHour FROM requests GROUP BY HOUR(created_at)'
mysqli['most_requests_hour'] = 'SELECT HOUR(created_at) as hour, COUNT(*) as totalRequestsPerHour FROM requests GROUP BY HOUR(created_at) order by totalRequestsPerHour DESC limit 1'
mysqli['most_requests_day'] = 'SELECT DATE(created_at) Date, COUNT(DISTINCT id) totalRequestsPerDay FROM requests GROUP BY DATE(created_at) order by totalRequestsPerDay DESC limit 1'
mysqli['status_per_page'] = 'SELECT * FROM requests where api_user_id = ? order by id DESC limit 20'
mysqli['per_project_per_hour'] = 'SELECT HOUR(created_at) as hour, COUNT(*) as totalRequestsPerHour FROM requests where api_user_id = ? GROUP BY HOUR(created_at)'
mysqli['per_project_per_day'] = 'SELECT DATE(created_at) Date, COUNT(DISTINCT id) totalRequestsPerDay FROM requests where api_user_id = ? GROUP BY DATE(created_at)'
mysqli['perproject_stats'] = 'SELECT COUNT(DISTINCT(r.id)) as total_requests, (SELECT COUNT(DISTINCT(r.id)) FROM api_users a join requests r on r.api_user_id = a.id where r.status = "Success" ) as total_success, (SELECT COUNT(DISTINCT(r.id)) FROM api_users a join requests r on r.api_user_id = a.id where r.status = "failed" ) as total_failed, (SELECT COUNT(DISTINCT(r.id)) FROM requests r where r.error_state = "critical" ) as total_critical, (SELECT COUNT(DISTINCT(r.id)) FROM api_users a join requests r on r.api_user_id = a.id where r.error_state = "minor" ) as total_minor, (SELECT COUNT(DISTINCT(r.id)) FROM api_users a join requests r on r.api_user_id = a.id where r.error_state = "major" ) as total_major FROM api_users a join requests r on r.api_user_id = a.id where r.api_user_id = ?'
mysqli['get_api_user_data'] = 'SELECT * from api_users where id = ?'

/* getting contact us messages here */
mysqli['get_contactus_msgs'] = 'SELECT *, SUBSTR(message,1,50) as message_short,DATE_FORMAT(date_added,"%m/%d/%Y @ %H:%i") as date_add from contact_us_msgs order by id desc limit ?,?';
mysqli['get_contactus_msg_view'] = 'SELECT *, SUBSTR(message,1,50) as message_short,DATE_FORMAT(date_added,"%m/%d/%Y @ %H:%i") as date_add from contact_us_msgs where id =?';
mysqli['get_contactus_msgs_cnt'] = 'SELECT count(id) as msgcount from contact_us_msgs order by id desc';
mysqli['add_contactus_msg'] = 'INSERT INTO contact_us_msgs (subject, message, first_name, last_name, email, phone, type,login_id) VALUES (?,?,?,?,?,?,?,?)';

/* ===================== start change by divyesh (added) ===================== */

/* >>>>>>>>>>>>> Start for admin */
mysqli['admin_login']  = 'select * from hmb_users where email = "{{username}}" Limit 1';
mysqli['get_mail_template'] = 'SELECT * FROM templates where title=? and method = "email"';
mysqli['getUsers'] = 'SELECT u.*, date_format(u.created_at, "%m-%d-%Y %H:%i") AS created_at, date_format(IF(u.license_date>DATE_ADD(u.created_at, INTERVAL 1 YEAR),DATE_ADD(u.created_at, INTERVAL 1 YEAR),u.license_date), "%m-%d-%Y") AS expiration_date FROM hmb_users AS u WHERE u.role!=0 {{where}} ORDER BY id DESC {{limit}}';
mysqli['updateUsersStatus'] = 'UPDATE hmb_users SET status=? WHERE id=?';
mysqli['getUserDetail'] = 'SELECT u.*, date_format(u.license_date, "%m-%d-%Y") AS license_date, date_format(u.l_issue_date, "%m-%d-%Y") AS l_issue_date, date_format(u.dob, "%m-%d-%Y") AS dob, date_format(u.ref_date, "%m-%d-%Y") AS ref_date FROM hmb_users AS u WHERE u.id=?';
mysqli['changePasswordByAdmin'] = 'UPDATE hmb_users SET password = ? WHERE id = ?';
mysqli['saveUserDetailByAdmin'] = 'UPDATE hmb_users SET name=?, email2=?, business_name=?, phone=?, address=?, city=?, state=?, zipcode=?, country=?, rep_name=?, ein=?, ssn=?, rep_ssn=?, rep_address=?, rep_city=?, rep_state=?, rep_zipcode=?, rep_phone=?, dob=?, status=?, updated_at=? WHERE id=?';
mysqli['saveUserLicenseDetailByAdmin'] = 'UPDATE hmb_users SET license_date=?, refered_by=?, ref_social_media=?, ref_social_media_other=?, ref_other=?, ref_name=?, ref_email=?, ref_date=?, ref_phone=?, ref_user_id=?, license=?, license_requested=?, l_issue_date=?, l_country=?, l_state=?, l_type=?, l_type_other=?, l_number=?, l_state_business=?, l_state_number=?, verification_doc=? WHERE id=?';
mysqli['updateProductInfo'] = 'UPDATE products SET title = ?, start_date = ?, end_date = ?, category_id = ?, subcategory_id = ?, type = ?, is_buynow = ?, start_price = ?, reserve_price = ?, buynow_price = ?, buynow_qty = ?, fixed_price = ?, fixed_qty = ?, offer_price = ?, offer_qty = ?, description = ?, unit_of_measurement = ?, product_image = ?, market_status = ?, amount_sold = ?, moq = ?, renew = ?, lots_available = ?, updated_at = ? WHERE id = ?';
mysqli['updateManufactureInfo'] = 'UPDATE products SET packaging_description = ?, keywords = ?, manufacture_date = ?, qty_available = ?, product_place = ? WHERE id = ?';
mysqli['updateCertificateInfo'] = 'UPDATE products SET certificate_types = ?, certificate_date = ?, contaminant_screening = ?, contaminant_screening_data = ? WHERE id = ?';
mysqli['updatePaymentInfo'] = 'UPDATE products SET sops = ?, payment_method = ?, payment_method_other = ? WHERE id = ?';
/* >>>>>>>>>>>>> End for admin */

mysqli['get_consultant_codes'] = 'SELECT * FROM consultant_codes  {{where}}';
mysqli['save_consultant_code'] = 'INSERT INTO consultant_codes (`name`, `email`, `sc_code`, `created_by`, `created_date`) VALUES {{valuesData}}';
mysqli['delete_consultant_code'] = 'DELETE FROM consultant_codes {{whereCondition}}';
mysqli['get_specific_consultant_code'] = 'SELECT * FROM consultant_codes {{whereCondition}}';
mysqli['update_specific_consultant_code'] = 'UPDATE consultant_codes SET {{updateCondition}}  {{whereCondition}}';

mysqli['add_sales_support'] = 'insert into sales_support (user_id, help_grow, sales_consultant, sc_code, sc_user_id, start_date, end_date, consultant_fee, consultant_agreement) values (?,?,?,?,?,?,?,?,?)';
mysqli['get_sales_support'] = 'SELECT ss.*,date_format(ss.start_date, "%m-%d-%Y %H:%i") AS start_date,date_format(ss.end_date, "%m-%d-%Y %H:%i") AS end_date, cc.created_by AS sc_created_by FROM sales_support AS ss LEFT JOIN consultant_codes AS cc ON ss.sc_code=cc.sc_code WHERE user_id=? ';

mysqli['update_sales_support'] = 'UPDATE sales_support SET help_grow = ?, sales_consultant = ?, sc_code = ?, sc_user_id = ?, start_date = ?, end_date = ?, consultant_fee = ?, consultant_agreement = ? where id = ?';

mysqli['check_sales_consultant_code_exist'] ='SELECT * FROM consultant_codes WHERE email=? AND sc_code=? ';
mysqli['get_sales_consultant_by_code'] = 'SELECT * FROM consultant_codes WHERE sc_code=? ';
mysqli['get_sales_admin_by_sales_code'] = 'SELECT u.*, cc.created_by, cc.sc_code, cc.email AS cc_email FROM consultant_codes AS cc INNER JOIN herbes_local_users AS u ON u.id=cc.created_by WHERE cc.sc_code=? ';
mysqli['getMembersBySalesAdmin'] = 'SELECT {{select_field}} FROM herbes_local_users AS u LEFT JOIN user_extras AS ue ON ue.user_id=u.id LEFT JOIN sales_support AS ss ON ss.user_id=u.id {{where}}';
mysqli['updateUserConsultantCodeFee'] = 'UPDATE sales_support SET {{updateCondition}}  {{whereCondition}}';

mysqli['getSalesTransactions'] = 'select i.*, date_format(i.date_added,"%m/%d/%Y") as date_add, i.id AS invoice_id, IFNULL(ROUND(i.amount,2),"0.00") as i_amount, p.title AS product_title, b.id as buynow_id, b.consultant_fee, b.consultant_fee_amount, IFNULL(b.request_userid,0) as seller_id, IFNULL(b.user_id,0) as buyer_id, seluser.username AS seller_username, buyuser.username AS buyer_username, ss.id AS ss_id, IFNULL(ss.zone,"") As zone FROM invoices as i left join buynow as b on b.id = i.buynow_id left join projects as p on p.id = b.project_id LEFT JOIN herbes_local_users AS seluser ON seluser.id=b.request_userid LEFT JOIN herbes_local_users AS buyuser ON buyuser.id=b.user_id LEFT JOIN sales_support AS ss ON ss.user_id=b.user_id LEFT JOIN sales_support AS seller_ss ON seller_ss.user_id=b.request_userid WHERE i.id > 0 {{where}} {{orderby}} {{limit}}';

mysqli['getSalesTransactionsCount'] = 'select count(i.id) AS id FROM invoices as i left join buynow as b on b.id = i.buynow_id left join projects as p on p.id = b.project_id LEFT JOIN herbes_local_users AS seluser ON seluser.id=b.request_userid LEFT JOIN herbes_local_users AS buyuser ON buyuser.id=b.user_id LEFT JOIN sales_support AS ss ON ss.user_id=b.user_id LEFT JOIN sales_support AS seller_ss ON seller_ss.user_id=b.request_userid WHERE i.id > 0 {{where}}';

mysqli['getBehalfUsers'] = 'SELECT cc.*, u.id AS user_id, ue.state FROM consultant_codes AS cc LEFT JOIN herbes_local_users AS u ON u.email=cc.email LEFT JOIN user_extras AS ue ON ue.user_id=u.id {{where}}';


mysqli['getPurchaseHistory'] = 'select CAST(round(IFNULL(b.distribution_tax,0),2) as CHAR) as b_distribution_tax, CAST(round(IFNULL(b.cultivation_tax,0),2) as CHAR) as b_cultivation_tax ,CAST(round(IFNULL(b.excise_tax_amt,0),2) as CHAR) as b_excise_tax_amt,CAST(round(IFNULL(b.excise_markup_amt,0),2) as CHAR) as b_excise_markup_amt, IFNULL(ad.ad_name,"") as ad_name, b.cancel_ins_status as b_cancel_ins_status, IFNULL(b.recurring,0) as b_recurring, round(IFNULL(b.cancel_ins_amt,0),2) as b_cancel_ins_amt, round(IFNULL(b.cancel_ins_per,0),2) as b_cancel_ins_per, ROUND((if(i.type != "bought" and i.istatus !="credit", i.amount, IFNULL(b.admin_paid_amt,"0.00")) + IFNULL(b.cancel_ins_amt, 0.00)),2) as herbee_fee, IFNULL(ROUND(i.amount,2),"0.00") as i_amount,IFNULL(b.request_userid,0) as seller_id, IFNULL(b.user_id,0) as buyer_id, b.id as b_id,ck.id as ckid,i.*, date_format(i.date_added,"%m/%d/%Y") as date_add, IFNULL(p.title,"NA") as title, IFNULL(p.id,"NA") as pid, IFNULL(c.name, "NA") as category_name, IFNULL(cp.name,"NA") as parent_category_name from invoices as i left join buynow as b on b.id = i.buynow_id left join checkout as ck on i.cart_id = ck.id left join projects as p on p.id = b.project_id left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id left join adwords as ad on ad.id = i.primary_id and (i.type = "ad_payment" or i.type = "refund_ad_payment") LEFT JOIN product_requests AS pr ON pr.id=b.request_id LEFT JOIN consultant_codes AS cc ON cc.id=pr.behalf_cc_id where i.id > 0 {{where}} order by i.id desc  {{limit}}';
mysqli['getPurchaseHistory_c'] = 'select count(i.id) AS id,sum(i.amount) AS paid, ROUND(sum(if(i.type != "bought" and i.istatus !="credit", i.amount, IFNULL(b.admin_paid_amt,"0.00")) + IFNULL(b.cancel_ins_amt, 0.00)),2) as comm_rev from invoices as i left join buynow as b on b.id = i.buynow_id left join checkout as ck on i.cart_id = ck.id left join projects as p on p.id = b.project_id left join categories as c on c.id = p.category_id left join categories as cp on cp.id = c.parent_id LEFT JOIN product_requests AS pr ON pr.id=b.request_id LEFT JOIN consultant_codes AS cc ON cc.id=pr.behalf_cc_id where i.id > 0 {{where}}';

mysqli['delete_product'] = 'update projects set market_status = "removed" where id = ? limit 1';
mysqli['paid_buynow'] = 'UPDATE `buynow` SET `paid`=1, `paid_date`=? WHERE id = ?';
mysqli['paid_invoice'] = 'UPDATE `invoices` SET `status`="paid", `paid_date`=? WHERE id = ?';
mysqli['paid_checkout'] = 'UPDATE `checkout` SET `paid`=1, `paid_date`=? WHERE id = (SELECT cart_id FROM `invoices` WHERE buynow_id=? LIMIT 0,1)';
mysqli['paid_recurring_schedule'] = 'UPDATE `recurring_schedule` SET `payment_status`="paid" WHERE id = (SELECT rec_schedule_id FROM `buynow` WHERE id=? LIMIT 0,1)';
mysqli['updateCodOnRecurringPurchase'] = 'UPDATE `recurring_purchase` SET cod=? WHERE id = ?';
mysqli['updateRScheduleStarted']='update recurring_schedule set buy_started = 1 where id = ?';
mysqli['getUserDetailById'] = 'select u.* from herbes_local_users AS u LEFT JOIN user_extras AS ue ON u.id=ue.user_id WHERE u.id = ?';
mysqli['getProductAndSellerDetail'] = 'select p.*,u.email, u.first_name, u.last_name from projects AS p Inner JOIN herbes_local_users AS u ON u.id=p.user_id WHERE p.id = ?';
mysqli['getNegotiableAndBuyerDetail'] = 'select n.*,u.email, u.first_name, u.last_name from negotiable AS n Inner JOIN herbes_local_users AS u ON u.id=n.user_id WHERE n.id = ?';
mysqli['getBuyerReviewsDetail'] = 'select s.*, ROUND((s.avg_rating + s.tpayment)/2) AS over_all_rating, date_format(b.delivered_at,"%m/%d/%Y %h:%i:%s") AS delivered_at, p.title As product_name from buyer_performance as s LEFT JOIN reviews AS r ON r.buyer_p_id=s.id LEFT JOIN buynow As b ON b.id=r.buy_now_id LEFT JOIN projects AS p ON p.id=b.project_id where s.id = ?';
mysqli['getSellerReviewsDetail'] = 'select s.*, date_format(b.delivered_at,"%m/%d/%Y %h:%i:%s") AS delivered_at, p.title As product_name from seller_performance as s LEFT JOIN reviews AS r ON r.buyer_p_id=s.id LEFT JOIN buynow As b ON b.id=r.buy_now_id LEFT JOIN projects AS p ON p.id=b.project_id where s.id = ?';
mysqli['getship_details'] = 'SELECT * FROM checkout where user_id=? ORDER by id desc limit 1';
mysqli['get_distributors'] = 'SELECT * FROM herbes_local_users WHERE role=4';
mysqli['updateDistributorProduct'] = 'UPDATE `projects` SET `d_invoice`= ?, `d_price`= ? WHERE id = ?';
mysqli['getPendingPayments'] = 'SELECT * FROM projects WHERE auction = 1 AND interim_testing_status="y" AND user_id=? ORDER BY id desc';
mysqli['getPendingPayments_count'] = 'SELECT COUNT(id) FROM projects WHERE user_id=?';
mysqli['getPayPendingDetail'] = 'UPDATE `projects` SET `d_payment_status`= ? WHERE id = ?';
mysqli['decreaseUserBalance'] = 'update herbes_local_users set balance=balance-? where id = ? limit 1';
mysqli['exportDistributorPayment'] = 'SELECT SUM(d_price) AS total_distributor_payment FROM projects WHERE d_payment_status=1';
mysqli['insertStoreImage'] = 'insert into stores_image (store_id, image) values (?,?)';
mysqli['getProductDetails'] = 'SELECT p.*, CONCAT("PRODUCT", LPAD(p.id, 5, 0)) AS product_tracking_id, date_format(p.start_date, "%m-%d-%Y %H:%i") AS start_date, date_format(p.end_date, "%m-%d-%Y %H:%i") AS end_date, date_format(p.manufacture_date, "%m-%d-%Y") AS manufacture_date, date_format(p.certificate_date, "%m-%d-%Y") AS certificate_date, (SELECT COUNT(id) from bids where project_id = p.id AND status = 1) as totalBid, (SELECT COUNT(user_id) from bids where project_id = p.id AND status = 1 AND user_id=? ORDER BY id DESC LIMIT 0,1) as current_user_bidded, (SELECT user_id from bids where project_id = p.id AND status = 1 ORDER BY id DESC LIMIT 0,1) as highest_bid_user_id, seo.meta_title, seo.meta_key, seo.meta_description FROM products AS p LEFT JOIN hmb_seo AS seo ON seo.product_id=p.id WHERE p.id = ?'
mysqli['getProductImages'] = 'SELECT * FROM product_images WHERE project_id = ? ORDER BY type ASC'
mysqli['getAllOpenProducts'] = 'SELECT CONCAT("PRODUCT", LPAD(products.id, 5, 0)) AS product_tracking_id, products.end_date as closed,products.*, IFNULL(DATE_FORMAT(products.updated_at, "%M %Y, %d"), "") AS updatedAt, (SELECT COUNT(id) from bids where project_id = products.id AND status = 1) as totalBid, (SELECT COUNT(id) from hmb_buynow where projectId = products.id AND paid = 1) as totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) from hmb_buynow where projectId = products.id AND paid = 1) as totalQty, (SELECT COUNT(id) from watchlists where project_id = products.id AND user_id = ? AND status="active") AS watchlistFlag, (SELECT avatar FROM product_images WHERE project_id = products.id AND product_images.type="image" LIMIT 1) AS avatar FROM products WHERE {{whereCond}} GROUP BY products.id'
mysqli['getAllOpenProductsLimit'] = 'SELECT CONCAT("PRODUCT", LPAD(products.id, 5, 0)) AS product_tracking_id, (SELECT COUNT(id) FROM offer_chat WHERE is_read=0 AND product_id=products.id AND sender_id!=products.user_id) AS unread_count, products.end_date as closed,products.*, IFNULL(DATE_FORMAT(products.updated_at, "%M %Y, %d"), "") AS updatedAt, (SELECT COUNT(id) from bids where project_id = products.id AND status = 1) as totalBid, (SELECT COUNT(id) from hmb_buynow where projectId = products.id AND paid = 1) as totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) from hmb_buynow where projectId = products.id AND paid = 1) as totalQty, (SELECT COUNT(id) from watchlists where project_id = products.id AND user_id = ? AND status="active") AS watchlistFlag, (SELECT avatar FROM product_images WHERE project_id = products.id AND type="image" LIMIT 1) AS avatar FROM products WHERE {{whereCond}} GROUP BY products.id {{orderBy}} LIMIT ?, ?'
// mysqli['getCategoryList'] = 'SELECT name, id from categories where id in(SELECT DISTINCT(category_id) from products ORDER by category_id) ORDER by id'
mysqli['getCategoryList'] = 'SELECT name, id,parent_id from categories where parent_id=0 ORDER by id'
mysqli['getSubCategoryList'] = 'SELECT name, id,parent_id from categories where parent_id <> 0 ORDER by id'

// mysqli['getStateListUnique'] = 'SELECT name, id,abbrev from states where abbrev in(SELECT DISTINCT(product_place) from products) order by abbrev'
mysqli['getStateListUnique'] = 'SELECT name, id,abbrev from states where 1=1 order by abbrev'

mysqli['getStateList'] = 'SELECT * from states'


mysqli['registerUser1'] = 'INSERT INTO hmb_users(email, username, password, password_salt, name, email2, email3, business_name, phone, address, city, state, zipcode, country, rep_name, ein, ssn, rep_ssn, rep_address, rep_city, rep_state, rep_zipcode, rep_phone, dob, license_date, license, license_requested, l_issue_date, l_country, l_state, l_type, l_type_other, l_number, l_state_business, l_state_number, verification_doc, refered_by, ref_name, ref_email, ref_date, ref_user_id, ref_social_media, ref_social_media_other, ref_other, ref_code, role, status, created_at) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

mysqli['checkEmail'] = 'select id,email from hmb_users  where email = "{{email}}" order by id desc';
mysqli['checkusername'] = 'select id,email from hmb_users  where username = "{{username}}" order by id desc';
mysqli['verify_referral'] = 'select id,email,DATE_FORMAT(created_at, "%m-%d-%Y") AS created_at from hmb_users where email = "{{email}}" order by id desc LIMIT 1';

mysqli['updateWinPrice'] = 'UPDATE products SET win_price = ? WHERE id = ?';
mysqli['getBidHistory'] = 'SELECT u.id, u.name, u.email, u.username, u.state, MAX(b.created_at) as created_at, MAX(b.proposed_amount) as proposed_amount, COUNT(b.id) as bidCount, (SELECT COUNT(id) from bids where project_id = b.project_id AND status = 1) as totalBid from bids b INNER JOIN hmb_users u ON b.user_id = u.id WHERE b.project_id = ? and b.status = 1 GROUP BY b.user_id ORDER BY MAX(b.proposed_amount) DESC';

mysqli['getDetailBidHistory'] = 'SELECT u.name, b.proposed_amount AS amount, IFNULL(DATE_FORMAT(b.created_at, "%m-%d-%Y %H:%m:%s"), "") AS bidPlacedAt FROM bids AS b INNER JOIN hmb_users AS u ON b.user_id = u.id WHERE b.project_id = ? AND b.status = 1 ORDER BY b.id DESC';

mysqli['checkLoginCredentials'] = 'SELECT u.*, IFNULL(IF(ub.account_number!="", 1, 0), 0) AS bank_account_added FROM hmb_users AS u LEFT JOIN hmb_user_banks AS ub ON ub.user_id=u.id WHERE (u.email = "{{username}}" OR u.username = "{{username}}") AND u.role != 0 LIMIT 1';
mysqli['checkReferralLoginCredentials'] = 'SELECT * FROM hmb_referral WHERE email = "{{username}}" LIMIT 1';

mysqli['get_license_expired_user'] = 'SELECT u.*, date_format(IF(u.license_date>DATE_ADD(u.created_at, INTERVAL 1 YEAR),DATE_ADD(u.created_at, INTERVAL 1 YEAR),u.license_date), "%m-%d-%Y") AS expiration_date, date_format(u.dob, "%m-%d-%Y") AS dob FROM hmb_users AS u HAVING expiration_date=?';

mysqli['getProductForClose'] = 'SELECT * FROM products p WHERE p.market_status = "open" AND  p.end_date < ? group by id order by id desc';

mysqli['closeProjects'] = 'UPDATE products SET market_status = ? WHERE id = ?';

mysqli['updateBuyNow'] = 'UPDATE products SET auction_active = 0, lots_available = lots_available - ? WHERE id = ?';
mysqli['updateBuyNowOffer'] = 'UPDATE products SET end_date=?, lots_available = lots_available - ? WHERE id = ?';


mysqli['relistProductToAuction'] = 'UPDATE products SET auction_active=1, lots_available = ?, start_price = ?, win_price = ?, reserve_price = ? WHERE id = ?';
mysqli['clearProductBidHistory'] = 'UPDATE bids SET status = 0 WHERE project_id = ?';



/* ===================== end change by divyesh (added) ===================== */

/* ============================ Won Product List =========================== */
mysqli['get_all_won_products'] = 'SELECT IFNULL(es.user_type, "") AS user_type, es.user_name, es.user_company, es.user_email, es.user_phone, es.bank_name, es.account_name, es.account_number, es.routing_number, es.id AS escrow_id, ROUND( (b.amount + b.shipping_amount + ((b.amount * ?) / 100)), 2) AS buynow_total_amount, b.shipping_amount, b.shipping_amount_added, b.shipping_id, b.amount, b.id AS buynow_id, b.paid, products.*, IFNULL(DATE_FORMAT(b.date_added, "%M %Y, %d"), "") AS wonDate, (SELECT avatar FROM product_images WHERE project_id = products.id AND type="image" LIMIT 1) AS avatar FROM hmb_buynow AS b INNER JOIN products ON b.projectId = products.id LEFT JOIN hmb_escrow_details AS es ON es.buynow_id=b.id WHERE {{whereCond}} {{having}} {{orderBy}} {{limit}}';

/* ============================ Lost Product List =========================== */
mysqli['getAllLostProductsCount'] = 'SELECT COUNT(DISTINCT(bids.project_id)) AS totalCount, (SELECT user_id from bids where project_id = bids.project_id AND status = 1 ORDER BY id DESC LIMIT 0,1) AS highBidder FROM bids INNER JOIN products ON bids.project_id = products.id WHERE {{whereCond}} {{having}}';
mysqli['getAllLostProductsLimit'] = 'SELECT products.*, IFNULL(DATE_FORMAT(bids.created_at, "%M %Y, %d"), "") AS lostDate, (SELECT COUNT(id) from bids where project_id = bids.project_id AND user_id = bids.user_id AND status = 1) as totalBid, (SELECT COUNT(id) from hmb_buynow where projectId = bids.project_id AND paid = 1) as totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) from hmb_buynow where projectId = bids.project_id AND paid = 1) as totalQty, (SELECT COUNT(id) from watchlists where project_id = products.id AND user_id = ? AND status="active") AS watchlistFlag, (SELECT avatar FROM product_images WHERE project_id = products.id AND product_images.type="image" LIMIT 1) AS avatar, (SELECT user_id from bids where project_id = bids.project_id AND status = 1 ORDER BY id DESC LIMIT 0,1) AS highBidder FROM bids INNER JOIN products ON bids.project_id = products.id WHERE {{whereCond}} GROUP BY bids.project_id {{having}} {{orderBy}} LIMIT ?, ?';

/* ============================ Buy Product List =========================== */
mysqli['getAllBuyProductsLimit'] = `SELECT 
IFNULL(es.user_type, "") AS user_type, es.user_name, es.user_company, es.user_email, es.user_phone, es.bank_name, es.account_name, es.account_number, es.routing_number, es.id AS escrow_id, 
i.id AS invoice_id, i.transactionid, i.shipping_id, i.amount, i.total_amount, i.shipping_amount, i.shipping_amount_added, i.primary_id AS product_id, i.user_id, i.qty, IFNULL(DATE_FORMAT(i.date_added, "%M %Y, %d"), "") AS buyDate, 
p.id, p.user_id AS seller_id, su.name As seller_name, su.email AS seller_email, p.start_price, p.title, p.lots_available, p.unit_of_measurement, 
IFNULL(DATE_FORMAT(i.paid_date, "%M %Y, %d"), "") AS paid_date, i.status, 
(SELECT COUNT(id) FROM bids WHERE project_id = i.primary_id AND user_id = i.user_id AND awarded = 1 AND status = 1) AS totalBid, 
(SELECT avatar FROM product_images WHERE project_id = p.id AND type="image" LIMIT 1) AS avatar, 
(SELECT COUNT(id) FROM pmb WHERE project_id = p.id AND from_id = i.user_id) AS totalMessage, 
(SELECT COUNT(id) FROM hmb_feedback WHERE product_id = p.id AND invoice_id = i.id AND user_id=i.user_id) AS feedback_sended, 
(SELECT COUNT(id) FROM hmb_feedback WHERE product_id = p.id AND invoice_id = i.id AND user_id!=i.user_id) AS feedback_received, 
(SELECT id FROM hmb_feedback WHERE product_id = p.id AND invoice_id = i.id AND user_id!=i.user_id LIMIT 0,1) AS feedback_id 
FROM invoices AS i 
INNER JOIN products AS p ON p.id = i.primary_id 
INNER JOIN hmb_users AS su ON su.id = p.user_id 
LEFT JOIN hmb_escrow_details AS es ON es.invoice_id=i.id 
WHERE {{whereCond}} {{orderBy}} {{limit}}`;

/* ============================ Seller Sold Product List =========================== */
mysqli['getAllSellerSoldProductsLimit'] = `SELECT 
IFNULL(es.user_type, "") AS user_type, 
i.transactionid, i.status, i.total_amount, i.amount, i.shipping_amount, i.shipping_id, i.id AS invoice_id, i.primary_id AS product_id, i.user_id, i.qty, IFNULL(DATE_FORMAT(i.paid_date, "%M %Y, %d"), "") AS paid_date, 
p.id, p.start_price, p.title, p.lots_available, p.unit_of_measurement, 
(SELECT COUNT(id) FROM bids WHERE project_id = i.primary_id AND status = 1) AS totalBid, 
(SELECT COUNT(id) FROM hmb_buynow WHERE projectId = i.primary_id AND paid = 1) AS totalSold, 
(SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) FROM hmb_buynow WHERE projectId = i.primary_id AND paid = 1) AS totalQty, 
(SELECT COUNT(id) from watchlists where project_id = p.id AND user_id = ? AND status="active") AS watchlistFlag, 
(SELECT avatar FROM product_images WHERE project_id = p.id AND type="image" LIMIT 1) AS avatar, 
(SELECT COUNT(id) FROM hmb_feedback WHERE product_id = p.id AND invoice_id = i.id AND user_id=?) AS feedback_sended, 
(SELECT COUNT(id) FROM hmb_feedback WHERE product_id = p.id AND invoice_id = i.id AND user_id!=?) AS feedback_received, 
(SELECT id FROM hmb_feedback WHERE product_id = p.id AND invoice_id = i.id AND user_id!=? LIMIT 0,1) AS feedback_id 
FROM invoices AS i 
INNER JOIN products AS p ON p.id = i.primary_id 
LEFT JOIN hmb_escrow_details AS es ON es.invoice_id=i.id 
WHERE {{whereCond}} {{orderBy}} {{limit}}`;

/* ============================ Get User Info =========================== */
mysqli['getUserProfileInfo'] = 'SELECT * FROM hmb_users WHERE id = ? AND role != 0 Limit 1';
mysqli['updateUserProfileInfo'] = 'UPDATE hmb_users SET {{fields}} WHERE id = ?';

/* ============================ Get Seller Product List =========================== */
mysqli['getAllOpenProductsCount'] = 'SELECT COUNT(DISTINCT(products.id)) AS totalCount FROM products WHERE {{whereCond}}';
mysqli['getAllSellerProductsCount'] = 'SELECT COUNT(DISTINCT(products.id)) AS totalCount FROM products WHERE {{whereCond}}';
mysqli['getAllSellerProductsLimit'] = 'SELECT products.end_date as closed,products.*, IFNULL(DATE_FORMAT(products.updated_at, "%M %d, %Y"), "") AS updatedAt, IFNULL(DATE_FORMAT(products.start_date, "%M %Y, %d"), "") AS openDate, IFNULL(DATE_FORMAT(products.end_date, "%M %Y, %d"), "") AS closedDate, IFNULL(DATE_FORMAT(products.f_start_date, "%m-%d-%Y %H:%i:%s"), "") AS f_start_date, IFNULL(DATE_FORMAT(products.f_end_date, "%m-%d-%Y %H:%i:%s"), "") AS f_end_date, IFNULL(categories.name, "") AS categoryName, (SELECT COUNT(id) from bids where project_id = products.id AND status = 1) as totalBid, (SELECT COUNT(id) FROM hmb_buynow WHERE projectId = products.id AND paid = 1) AS totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) FROM hmb_buynow WHERE projectId = products.id AND paid = 1) AS totalQty, (SELECT COUNT(id) from watchlists where project_id = products.id AND user_id = ? AND status="active") AS watchlistFlag, (SELECT avatar FROM product_images WHERE project_id = products.id AND type="image" LIMIT 1) AS avatar FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE {{whereCond}} GROUP BY products.id {{orderBy}} LIMIT ?, ?'

/* ============================ Get Product Certificate =========================== */
mysqli['getProductCertificate'] = 'SELECT * FROM product_certificates WHERE product_id = ?';

/* ============================ Get Product Media Files =========================== */
mysqli['getProductMediaFiles'] = 'SELECT * FROM product_images WHERE project_id = ? AND type = ?';

/* ============================ Save Contact Us Data =========================== */
mysqli['saveContactUs'] = 'INSERT INTO contact_us_msgs (first_name, email, phone, subject, message, email_notification_flag, type, date_added, login_id) values (?,?,?,?,?,?,?,?,?)';

/* ============================ Update Product Data =========================== */
mysqli['updateProduct'] = 'UPDATE products SET user_id = ?, title = ?, start_date = ?, end_date = ?, category_id = ?, subcategory_id = ?, type = ?, auction_active=?, is_buynow = ?, start_price = ?, reserve_price = ?, buynow_price = ?, buynow_qty = ?, fixed_price = ?, fixed_qty = ?, offer_price = ?, offer_qty = ?, description = ?, packaging_description = ?, unit_of_measurement = ?, manufacture_date = ?, certificate_types = ?, certificate_date = ?, contaminant_screening = ?, contaminant_screening_data = ?, sops = ?, payment_method = ?, payment_method_other = ?, product_image = ?, market_status = ?, amount_sold = ?, moq = ?, product_place = ?, renew = ?, qty_available = ?, keywords = ?, lots_available = ? WHERE id = ?';

/* ============================ Get Open Product Ids =========================== */
mysqli['getOpenProductIds'] = 'SELECT IFNULL(GROUP_CONCAT(id), "") AS id FROM products WHERE market_status = "open" AND end_date < ?';
mysqli['getOpenProductList'] = 'SELECT (SELECT CONCAT(b.user_id,",",u.name,",",u.email) FROM bids AS b INNER JOIN hmb_users AS u ON b.user_id=u.id WHERE b.project_id=p.id ORDER BY b.proposed_amount DESC LIMIT 0,1) AS highest_bidder, p.*, u.name AS seller_name, u.email AS seller_email FROM products AS p INNER JOIN hmb_users AS u ON p.user_id=u.id WHERE p.market_status = "open" AND p.end_date < ?';

/* ============================ Update Open Product Status =========================== */
mysqli['updateOpenProductStatus'] = 'UPDATE products SET market_status = ? WHERE id IN ({{id}})';
mysqli['reduceProductRenewCount'] = 'UPDATE products SET end_date = DATE_ADD(end_date , INTERVAL 3 DAY), renew = (renew-1) WHERE id=?';
/**********************************************************************************************************************************************
|						api queries ended here--------------																				  |
**********************************************************************************************************************************************/

mysqli['insertBuyNowRecord'] = 'INSERT INTO hmb_buynow (projectId, userId, amount, type, paid, qty, date_added, date_updated) VALUES (?,?,?,?,?,?,?,?)';

/* ============================ Get Measurement List =========================== */
mysqli['getAllMeasurementsCount'] = 'SELECT COUNT(DISTINCT(id)) AS totalCount FROM hmb_measurements WHERE {{whereCond}}';
mysqli['getAllMeasurementsLimit'] = 'SELECT * FROM hmb_measurements WHERE {{whereCond}} GROUP BY id {{orderBy}} LIMIT ?, ?';

mysqli['checkMeasurementName'] = 'SELECT unit_name FROM hmb_measurements WHERE {{whereCond}}';
mysqli['insertMeasurement'] = 'INSERT INTO hmb_measurements (unit_name, status, created_date) VALUES (?,?,?)';
mysqli['updateMeasurement'] = 'UPDATE hmb_measurements SET status = ?, updated_date = ? WHERE id = ?';

/* ============================ Get Watchlist List =========================== */
mysqli['getAllWatchlist'] = 'SELECT IFNULL(DATE_FORMAT(w.date_added, "%M %Y, %d"), "") AS watchlistDate, products.*, (SELECT COUNT(id) from bids where project_id = w.project_id AND user_id = w.user_id AND status = 1) as totalBid, (SELECT COUNT(id) from hmb_buynow where projectId = w.project_id AND paid = 1) as totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) from hmb_buynow where projectId = w.project_id AND paid = 1) as totalQty, (SELECT COUNT(id) from hmb_buynow where projectId = w.project_id AND userId = w.user_id AND paid = 1) as paidStatus, (SELECT COUNT(id) from watchlists where project_id = products.id AND user_id = ? AND status = "active") AS watchlistFlag, (SELECT avatar FROM product_images WHERE project_id = products.id AND type="image" LIMIT 1) AS avatar FROM watchlists AS w INNER JOIN products ON products.id = w.project_id WHERE {{whereCond}} GROUP BY w.project_id';
mysqli['getAllWatchlistCount'] = 'SELECT COUNT(DISTINCT(w.id)) AS totalCount FROM watchlists AS w INNER JOIN products ON products.id = w.project_id WHERE {{whereCond}}';
mysqli['getAllWatchlistLimit'] = 'SELECT IFNULL(DATE_FORMAT(w.date_added, "%M %Y, %d"), "") AS watchlistDate, products.*, (SELECT COUNT(id) from bids where project_id = w.project_id AND user_id = w.user_id AND status = 1) as totalBid, (SELECT COUNT(id) from hmb_buynow where projectId = w.project_id AND paid = 1) as totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) from hmb_buynow where projectId = w.project_id AND paid = 1) as totalQty, (SELECT COUNT(id) from hmb_buynow where projectId = w.project_id AND userId = w.user_id AND paid = 1) as paidStatus, (SELECT COUNT(id) from watchlists where project_id = products.id AND user_id = ? AND status = "active") AS watchlistFlag, (SELECT avatar FROM product_images WHERE project_id = products.id AND type="image" LIMIT 1) AS avatar FROM watchlists AS w INNER JOIN products ON products.id = w.project_id WHERE {{whereCond}} GROUP BY w.project_id {{orderBy}} LIMIT ?, ? ';

/* ============================ Get Watchlist =========================== */
mysqli['getWatchlist'] = 'SELECT * FROM watchlists WHERE user_id = ? AND project_id = ?';

/* ============================ Add to Watchlist =========================== */
mysqli['insertWatchlist'] = 'INSERT INTO watchlists (user_id, project_id, status, date_added) VALUES (?, ?, ?, ?)';

/* ============================ Update Watchlist Status =========================== */
mysqli['updateWatchlist'] = 'UPDATE watchlists SET user_id = ?, project_id = ?, status = ?, date_added = ? WHERE id = ?';

/* ============================ Product Purchased History List =========================== */
mysqli['getAllProductsPurchasedHistoryCount'] = 'SELECT COUNT(b.projectId) AS totalCount FROM hmb_buynow AS b INNER JOIN products AS p ON p.id = b.projectId WHERE {{whereCond}}';
mysqli['getAllProductsPurchasedHistoryLimit'] = 'SELECT b.id AS buyId, b.amount AS paidAmount, b.type AS paidType, b.qty AS buyQty, b.paid AS paidStatus, IFNULL(DATE_FORMAT(b.date_added, "%M %Y, %d"), "") AS purchasedDate, p.*, IFNULL(c.name, "") AS categoryName, u.username, u.email, u.name FROM hmb_buynow AS b INNER JOIN products AS p ON p.id = b.projectId LEFT JOIN categories AS c ON c.id = p.category_id LEFT JOIN hmb_users AS u ON u.id = b.userId WHERE {{whereCond}} {{orderBy}} LIMIT ?, ?';

/* ============================ Product Bidding History List =========================== */
mysqli['getAllProductsBiddingHistoryCount'] = 'SELECT COUNT(b.project_id) AS totalCount FROM bids AS b INNER JOIN products AS p ON p.id = b.project_id WHERE {{whereCond}}';
mysqli['getAllProductsBiddingHistoryLimit'] = 'SELECT IFNULL(DATE_FORMAT(b.created_at, "%M %Y, %d"), "") AS bidDate, b.*, p.*, IFNULL(c.name, "") AS categoryName, u.username, u.email, u.name FROM bids AS b INNER JOIN products AS p ON p.id = b.project_id LEFT JOIN categories AS c ON c.id = p.category_id LEFT JOIN hmb_users AS u ON u.id = b.user_id WHERE {{whereCond}} {{orderBy}} LIMIT ?, ?';

mysqli['getReferrals'] = 'SELECT u.*, date_format(u.created_at, "%m-%d-%Y") AS join_date, date_format(ru.created_at, "%m-%d-%Y") AS ref_join_date FROM hmb_users AS u INNER JOIN hmb_users AS ru ON u.ref_user_id=ru.id WHERE u.role!=0 AND u.refered_by=2 {{where}} ORDER BY u.id DESC {{limit}}';
mysqli['getAds'] = 'SELECT ad.*, date_format(ad.created_at, "%m-%d-%Y") AS created_at, u.name FROM adwords AS ad INNER JOIN hmb_users AS u ON ad.user_id=u.id WHERE ad.status!="remove" {{where}} ORDER BY ad.id DESC {{limit}}';
mysqli['getClassifieds'] = 'SELECT ad.*, date_format(ad.created_date, "%m-%d-%Y") AS created_date, u.name AS created_by FROM hmb_classified AS ad INNER JOIN hmb_users AS u ON ad.user_id=u.id WHERE 1=1 {{where}} ORDER BY ad.id DESC {{limit}}';
mysqli['getClassifiedDetail'] = 'SELECT ad.*, date_format(ad.created_date, "%m-%d-%Y") AS created_date, u.name AS created_by FROM hmb_classified AS ad INNER JOIN hmb_users AS u ON ad.user_id=u.id WHERE id=?';

/* ============================ Get User Name List =========================== */
mysqli['getUserList'] = 'SELECT {{fieldName}} FROM hmb_users WHERE {{whereCond}} {{orderBy}}';
mysqli['update_isfeatured'] = 'UPDATE products SET is_featured=?, f_start_date=?, f_end_date=? WHERE id=?';
mysqli['getFeaturedProducts'] = 'SELECT products.end_date as closed,products.*, IFNULL(DATE_FORMAT(products.updated_at, "%M %Y, %d"), "") AS updatedAt, (SELECT COUNT(id) from bids where project_id = products.id AND status = 1) as totalBid, (SELECT COUNT(id) from hmb_buynow where projectId = products.id AND paid = 1) as totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) from hmb_buynow where projectId = products.id AND paid = 1) as totalQty, (SELECT COUNT(id) from watchlists where project_id = products.id AND user_id = ? AND status="active") AS watchlistFlag, (SELECT avatar FROM product_images WHERE project_id = products.id AND type="image" LIMIT 1) AS avatar FROM products WHERE {{whereCond}} GROUP BY products.id {{limit}}';
mysqli['getUpcomingProducts'] = 'SELECT products.end_date as closed,products.*, IFNULL(DATE_FORMAT(products.updated_at, "%M %Y, %d"), "") AS updatedAt, (SELECT COUNT(id) from bids where project_id = products.id AND status = 1) as totalBid, (SELECT COUNT(id) from hmb_buynow where projectId = products.id AND paid = 1) as totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) from hmb_buynow where projectId = products.id AND paid = 1) as totalQty, (SELECT COUNT(id) from watchlists where project_id = products.id AND user_id = ? AND status="active") AS watchlistFlag, (SELECT avatar FROM product_images WHERE project_id = products.id AND type="image" LIMIT 1) AS avatar FROM products WHERE {{whereCond}} GROUP BY products.id ORDER BY DATE(products.start_date) ASC {{limit}}';
mysqli['getSimilarProduct'] = 'SELECT products.end_date as closed,products.*, IFNULL(DATE_FORMAT(products.updated_at, "%M %Y, %d"), "") AS updatedAt, (SELECT COUNT(id) from bids where project_id = products.id AND status = 1) as totalBid, (SELECT COUNT(id) from hmb_buynow where projectId = products.id AND paid = 1) as totalSold, (SELECT IFNULL(SUM(IFNULL(qty, 0)), 0) from hmb_buynow where projectId = products.id AND paid = 1) as totalQty, (SELECT avatar FROM product_images WHERE project_id = products.id AND type="image" LIMIT 1) AS avatar FROM products WHERE 1=1 AND products.market_status="open" {{whereCond}} GROUP BY products.id ORDER BY DATE(products.start_date) ASC {{limit}}';

/* ============================ View Message =========================== */
mysqli['viewMessage'] = 'SELECT p.*, SUBSTR(p.message,1,50) AS message_short, date_format(p.date_sent,"%m/%d/%Y %H:%i") AS date_add, f.name AS fname, t.name AS tname, CONCAT(SUBSTR(t.name, 1, 1),"***",(SUBSTRING(t.name, -1))) AS toName, f.role AS frole, t.role AS trole FROM pmb AS p INNER JOIN hmb_users AS f ON f.id = p.from_id INNER JOIN hmb_users AS t ON t.id = p.to_id WHERE (p.from_id = ? or p.to_id = ?) {{where}} ORDER BY p.id ASC';
mysqli['viewMessageById'] = 'SELECT p.id FROM pmb AS p INNER JOIN hmb_users AS f ON f.id = p.from_id INNER JOIN hmb_users AS t ON t.id = p.to_id WHERE (p.from_id = ? or p.to_id = ?) {{where}} ORDER BY p.id ASC';

/* ============================ Get Overall Inbox Count & Overall Unread Message Count =========================== */
//mysqli['getInboxOverallAndUnreadMessageCount'] = 'SELECT (SELECT COUNT(id) FROM pmb WHERE to_id = ? AND to_status = "open" AND visible = 1) AS totalInboxMessageCount, (SELECT COUNT(id) FROM pmb WHERE to_id = ? AND `read` = 0 AND to_status = "open" AND visible = 1) AS totalInboxUnreadMessageCount';
mysqli['getInboxOverallAndUnreadMessageCount'] = 'SELECT (SELECT COUNT(DISTINCT(r_id)) FROM pmb WHERE to_id = ? AND to_status = "open" AND visible = 1) AS totalInboxMessageCount, (SELECT COUNT(DISTINCT(r_id)) FROM pmb WHERE to_id = ? AND `read` = 0 AND to_status = "open" AND visible = 1) AS totalInboxUnreadMessageCount';

/* ============================ Get User Messages List =========================== */
//mysqli['getUserMessagesByActionCount'] = 'SELECT COUNT(p.id) AS totalCount FROM pmb AS p WHERE (p.to_id = ?) {{where}} ORDER BY p.id DESC';
//mysqli['getUserMessagesByActionLimit'] = 'SELECT p.*, SUBSTR(p.message, 1, 50) AS message_short, DATE_FORMAT(p.date_sent, "%m/%d/%Y @ %H:%i") AS date_add, CONCAT(SUBSTR(u.name, 1, 1),"***",(SUBSTRING(u.name, -1))) AS name FROM pmb AS p JOIN hmb_users AS u ON u.id = p.from_id WHERE p.to_id = ? {{where}} ORDER BY p.id DESC LIMIT ?, ?';

/*mysqli['getUserMessagesByActionCount'] = 'SELECT COUNT(p.id) AS totalCount FROM pmb AS p {{where}} ORDER BY p.id DESC';
mysqli['getUserMessagesByActionLimit'] = 'SELECT p.*, SUBSTR(p.message, 1, 50) AS message_short, DATE_FORMAT(p.date_sent, "%m/%d/%Y @ %H:%i") AS date_add, CONCAT(SUBSTR(u.name, 1, 1),"***",(SUBSTRING(u.name, -1))) AS name, u.role AS frole, u.name AS fname, u1.role AS trole, u1.name AS tname, CONCAT(SUBSTR(u.name, 1, 1),"***",(SUBSTRING(u.name, -1))) AS fromName, CONCAT(SUBSTR(u1.name, 1, 1),"***",(SUBSTRING(u1.name, -1))) AS toName FROM pmb AS p JOIN hmb_users AS u ON u.id = p.from_id JOIN hmb_users AS u1 ON u1.id = p.to_id {{where}} ORDER BY p.id DESC LIMIT ?, ?';*/

mysqli['deleteUserMessages'] = 'UPDATE pmb SET to_status = "delete" WHERE {{whereCond}}';

//mysqli['updateUserMessageReadFlag'] = 'UPDATE pmb SET `read` = 1, date_read = ? WHERE id = ? AND to_id = ? AND `read` = 0 ';
mysqli['updateUserMessageReadFlag'] = 'UPDATE pmb SET `read` = 1, date_read = ? WHERE r_id = ? AND to_id = ? AND `read` = 0 ';

mysqli['getUserMessagesAlreadyExists'] = 'SELECT r_id FROM pmb WHERE (from_id = ? OR to_id = ?) AND project_id = ? LIMIT 0, 1';

mysqli['archiveUserMessages'] = 'UPDATE pmb SET to_status = "archive" WHERE {{whereCond}}';

mysqli['deleteUserTrashMessages'] = 'UPDATE pmb SET visible = 0 WHERE {{whereCond}}';

mysqli['getUserMessagesByActionLimit'] = 'SELECT p.*, SUBSTR(p.message, 1, 50) AS message_short, DATE_FORMAT(p.date_sent, "%m/%d/%Y %H:%i") AS date_add, CONCAT(SUBSTR(u.name, 1, 1),"***",(SUBSTRING(u.name, -1))) AS name, u.role AS frole, u.name AS fname, u1.role AS trole, u1.name AS tname, CONCAT(SUBSTR(u.name, 1, 1),"***",(SUBSTRING(u.name, -1))) AS fromName, CONCAT(SUBSTR(u1.name, 1, 1),"***",(SUBSTRING(u1.name, -1))) AS toName FROM pmb AS p JOIN hmb_users AS u ON u.id = p.from_id JOIN hmb_users AS u1 ON u1.id = p.to_id {{where}} {{groupBy}} ORDER BY p.id DESC LIMIT ?, ?';

mysqli['getUserMessagesByActionCount'] = 'SELECT COUNT(DISTINCT(p.r_id)) AS totalCount FROM pmb AS p {{where}}';

mysqli['adminDashboardCount'] = `SELECT 
(SELECT COUNT(id) FROM products WHERE market_status = "open") AS activeProducts, 
(SELECT COUNT(id) FROM products WHERE is_featured=1) AS featured_products, 
(SELECT COUNT(id) FROM products WHERE date_format(start_date, "%m-%d-%Y %H:%i:%s") > NOW()) AS upcoming_products, 
(SELECT COUNT(id) FROM hmb_users WHERE status = "active" AND role IN (1,2,3)) AS activeUser, 
(SELECT COUNT(id) FROM hmb_users WHERE status = "pending" AND role IN (1,2,3)) AS pendingUser, 
(SELECT COUNT(id) FROM hmb_users WHERE status = "inactive" AND role IN (1,2,3)) AS inactiveUser, 
(SELECT COUNT(id) FROM hmb_users WHERE role IN (1,2,3) AND DATE_FORMAT(IF(license_date> DATE_ADD(created_at, INTERVAL 1 YEAR), DATE_ADD(created_at, INTERVAL 1 YEAR), license_date), "%m-%d-%Y") = ?) AS suspendedUser`;

mysqli['subscribe'] = 'INSERT INTO subscription_users (email, existing_user, user_id, created_at) VALUES (?, ?, ?, ?)';
mysqli['checkSubscribe'] = 'SELECT * FROM subscription_users WHERE email=?';
mysqli['getSubscriptionUsers'] = 'SELECT u.*, date_format(u.created_at, "%m-%d-%Y %H:%i:%s") AS created_at FROM subscription_users AS u WHERE 1=1 {{where}} ORDER BY u.id DESC {{limit}}';
mysqli['addFeedback'] = 'INSERT INTO hmb_feedback (user_id, invoice_id, product_id, rate, comment, created_at) VALUES (?, ?, ?, ?, ?, ?)';
mysqli['get_feedback'] = 'SELECT * FROM hmb_feedback WHERE id=?';
mysqli['getUserDetail'] = 'SELECT u.*, date_format(u.dob, "%m-%d-%Y") AS dob, date_format(u.l_issue_date, "%m-%d-%Y") AS l_issue_date, date_format(u.license_date, "%m-%d-%Y") AS license_date, date_format(u.ref_date, "%m-%d-%Y") AS ref_date, rf.name AS rf_name, rf.email AS rf_email FROM hmb_users AS u LEFT JOIN hmb_referral AS rf ON rf.code=u.ref_code WHERE u.id=? GROUP BY u.id';
mysqli['transaction_list'] = `SELECT i.*, IFNULL(DATE_FORMAT(i.date_added, "%M %Y, %d"), "") AS paid_date, p.title
FROM invoices AS i 
INNER JOIN products AS p ON p.id = i.primary_id 
WHERE {{where}} ORDER BY i.id DESC {{limit}}`;
mysqli['save_ad'] = 'INSERT INTO adwords (ad_name,ad_title,ad_content,ad_url,banner,show_continue,end_date,days_week,target_sec_id,keywords,budget_per_click,budget_per_day,user_id,created_at) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['addNewClassified'] = 'INSERT INTO hmb_classified (id, name, title, category, description, website,email, is_special, user_id, created_date, updated_date, images, company_logo, short_description, state, city) VALUES (null,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

mysqli['getClassified'] = 'SELECT c.* FROM hmb_classified AS c WHERE status="active" ORDER BY c.id DESC';
mysqli['save_ad'] = 'INSERT INTO adwords (ad_name,ad_title,ad_content,ad_url,banner,show_continue,end_date,days_week,target_sec_id,keywords,budget_per_click,budget_per_day,user_id,created_at) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['advertisements_list'] = 'SELECT ad.*, date_format(ad.created_at, "%m-%d-%Y %H:%i:%s") AS created_at FROM adwords AS ad WHERE status!="remove" {{where}} ORDER BY id DESC {{limit}}';
mysqli['total_ads_amount'] = 'SELECT SUM(ad.budget_per_day - (ad.budget_per_click*ad.no_of_clicks)) AS total_amount FROM adwords AS ad WHERE status!="remove" {{where}} ORDER BY id DESC {{limit}}';
mysqli['update_ad_status'] = 'UPDATE adwords SET status=? WHERE id=?';
mysqli['update_classified_status'] = 'UPDATE hmb_classified SET status=? WHERE id=?';
mysqli['get_ads'] = 'SELECT IF(ad.show_continue,1,IF(date_format(ad.end_date, "%m-%d-%Y")>=date_format("2020-03-25", "%m-%d-%Y"), 1, 0) ) AS not_ended, (ad.budget_per_day - (ad.budget_per_click*ad.no_of_clicks)) AS available_amount, ad.*, date_format(ad.created_at, "%m-%d-%Y %H:%i:%s") AS created_at FROM adwords AS ad WHERE status="active" {{where}} HAVING available_amount>0 AND not_ended=1 ORDER BY id DESC {{limit}}';
mysqli['get_ad_detail'] = 'SELECT ad.*, date_format(ad.created_at, "%m-%d-%Y %H:%i:%s") AS created_at FROM adwords AS ad WHERE ad.id=?';
mysqli['add_user_balance'] = 'UPDATE hmb_users SET balance=balance+? WHERE id=?';
mysqli['click_ad'] = 'UPDATE adwords SET no_of_clicks=no_of_clicks+1 WHERE id=?';
mysqli['minus_user_balance'] = 'UPDATE hmb_users SET balance=balance-? WHERE id=?';
mysqli['getClassifiedDetail'] = 'SELECT cl.*, date_format(cl.created_date, "%m-%d-%Y %H:%i:%s") AS created_at, sl.name AS seller_name, sl.email AS seller_email FROM hmb_classified AS cl INNER JOIN hmb_users AS sl ON sl.id=cl.user_id WHERE cl.id=?';
mysqli['dummyQuery'] = '{{query}}';
mysqli['getProductSellerDetail'] = 'SELECT u.id, u.name, u.email, p.id AS product_id, p.title AS product_title from products AS p INNER JOIN hmb_users u ON p.user_id = u.id WHERE p.id = ?';
mysqli['removeFromFeaturedAuction'] = 'UPDATE products SET is_featured=0, f_start_date=NULL, f_end_date=NULL WHERE 1=1 {{where}}';

mysqli['get_offer_chats'] = 'SELECT oc.*, date_format(oc.created_date, "%m-%d-%Y %H:%i:%s") AS created_date, CONCAT(LEFT(s.username,1), "***", RIGHT(s.username,1))  AS sender_username, s.email AS sender_email, s.name AS sender_name, CONCAT(LEFT(r.username,1), "***", RIGHT(r.username,1)) AS receiver_username, r.email AS receiver_email, r.name AS receiver_name, p.title AS product_title from offer_chat AS oc INNER JOIN hmb_users s ON oc.sender_id=s.id INNER JOIN hmb_users r ON oc.receiver_id=r.id INNER JOIN products AS p ON p.id=oc.product_id WHERE 1=1 {{where}} ORDER BY id asc';
mysqli['get_offer_user_chats'] = 'SELECT (SELECT COUNT(id) FROM offer_chat WHERE is_read=0 AND product_id=p.id AND sender_id=oc.sender_id) AS unread_count, oc.*, date_format(oc.created_date, "%m-%d-%Y %H:%i:%s") AS created_date, CONCAT(LEFT(s.username,1), "***", RIGHT(s.username,1))  AS sender_username, s.email AS sender_email, CONCAT(LEFT(r.username,1), "***", RIGHT(r.username,1)) AS receiver_username, r.email AS receiver_email, p.offer_buyer_id from offer_chat AS oc INNER JOIN hmb_users s ON oc.sender_id=s.id INNER JOIN hmb_users r ON oc.receiver_id=r.id INNER JOIN products AS p ON p.id=oc.product_id WHERE 1=1 {{where}} GROUP BY oc.sender_id ORDER BY id desc';
mysqli['send_offer_message'] = 'INSERT INTO offer_chat(product_id, seller_id, sender_id, receiver_id, is_read, message, status, created_date) VALUES(?,?,?,?,?,?,?,?)';
mysqli['submit_final_offer'] = 'UPDATE products SET offer_price=?, offer_buyer_id=? WHERE id=?';

mysqli['get_offer_product_list'] = 'SELECT p.*, (SELECT COUNT(id) FROM offer_chat WHERE admin_is_read=0 AND product_id=p.id) AS unread_count, (SELECT created_date FROM offer_chat WHERE product_id=p.id AND (sender_id=p.user_id OR receiver_id=p.user_id) ORDER BY id DESC LIMIT 0,1) AS last_message FROM products AS p WHERE 1=1 {{where}} HAVING last_message IS NOT NULL {{orderBy}} {{limit}}';
mysqli['get_offer_buyer_list'] = 'SELECT bu.*, (SELECT COUNT(id) FROM offer_chat WHERE admin_is_read=0 AND product_id=p.id AND (sender_id=oc.sender_id OR receiver_id=oc.sender_id)) AS unread_count, (SELECT created_date FROM offer_chat WHERE product_id=p.id AND (sender_id=oc.sender_id OR receiver_id=oc.sender_id) ORDER BY id DESC LIMIT 0,1) AS last_message FROM products AS p INNER JOIN offer_chat AS oc ON oc.product_id=p.id INNER JOIN hmb_users AS bu ON bu.id=oc.sender_id AND oc.sender_id!=p.user_id WHERE 1=1 {{where}} GROUP BY oc.sender_id {{orderBy}} {{limit}}';
mysqli['get_offer_buyer_list_admin'] = 'SELECT bu.*, (SELECT COUNT(id) FROM offer_chat WHERE admin_is_read=0 AND product_id=p.id AND (sender_id=bu.id OR receiver_id=bu.id)) AS unread_count, (SELECT created_date FROM offer_chat WHERE product_id=p.id AND (sender_id=oc.sender_id OR receiver_id=oc.sender_id) ORDER BY id DESC LIMIT 0,1) AS last_message FROM products AS p INNER JOIN offer_chat AS oc ON oc.product_id=p.id INNER JOIN hmb_users AS bu ON bu.id=oc.sender_id AND oc.sender_id!=p.user_id WHERE 1=1 {{where}} GROUP BY oc.sender_id {{orderBy}} {{limit}}';
mysqli['get_offer_product_chat_list'] = 'SELECT oc.*, date_format(oc.created_date, "%m-%d-%Y %H:%i:%s") AS created_date, CONCAT(LEFT(s.username,1), "***", RIGHT(s.username,1))  AS sender_username, s.email AS sender_email, CONCAT(LEFT(r.username,1), "***", RIGHT(r.username,1)) AS receiver_username, r.email AS receiver_email from offer_chat AS oc INNER JOIN hmb_users s ON oc.sender_id=s.id INNER JOIN hmb_users r ON oc.receiver_id=r.id WHERE 1=1 {{where}} {{orderBy}}';
mysqli['update_admin_unread_flag'] = 'UPDATE offer_chat AS oc SET oc.admin_is_read=1 WHERE 1=1 {{where}}';
mysqli['get_offer_product_sellers'] = 'SELECT sl.* FROM hmb_users AS sl INNER JOIN products AS p ON p.user_id=sl.id INNER JOIN offer_chat AS oc ON oc.product_id=p.id WHERE 1=1 GROUP BY sl.id';
mysqli['get_buyer_unread_offer_chat'] = 'SELECT COUNT(oc.id) AS unread_count FROM offer_chat AS oc WHERE oc.is_read=0 AND oc.product_id=? AND oc.receiver_id=?';
mysqli['update_unread_offer_flag'] = 'UPDATE offer_chat AS oc SET oc.is_read=1 WHERE 1=1 {{where}}';
mysqli['get_seller_rattings'] = 'SELECT f.*, CONCAT(LEFT(u.username,1), "***", RIGHT(u.username,1)) AS buyer_name FROM hmb_feedback AS f INNER JOIN products AS p ON p.id=f.product_id INNER JOIN hmb_users AS u ON u.id=f.user_id WHERE p.user_id=?';
mysqli['get_seller_average_rattings'] = 'SELECT ROUND(SUM(f.rate)/COUNT(f.id), 2) AS average_rating FROM hmb_feedback AS f INNER JOIN products AS p ON p.id=f.product_id WHERE p.user_id=?';
mysqli['register_referral'] = 'insert into hmb_referral (name, company, email, password, password_salt, code, phone, address, city, state, zipcode, status, created_date) values (?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['check_referral_affiliats_exists'] = 'SELECT * FROM hmb_referral WHERE email=?';
mysqli['check_referral_affiliats_exists_using_code'] = 'SELECT * FROM hmb_referral WHERE code=?';
mysqli['get_referral_program'] = 'SELECT rf.*, date_format(rf.created_date, "%m-%d-%Y %H:%i:%s") AS created_date, (SELECT COUNT(id) FROM hmb_users WHERE ref_code=rf.code) AS total_referred FROM hmb_referral AS rf WHERE 1=1 {{where}} ORDER BY rf.id DESC {{limit}}';
mysqli['add_bank_details'] = 'insert into hmb_user_banks (user_id, swift_code, account_name, account_number, routing_number, city, state, country, phone, remmitance_information, is_primary, status, stripe_account_id, stripe_profile_id, created_date) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['edit_bank_details'] = 'UPDATE hmb_user_banks SET user_id=?, swift_code=?, account_name=?, account_number=?, routing_number=?, city=?, state=?, country=?, phone=?, remmitance_information=?, status=?, stripe_account_id=?, stripe_profile_id=? WHERE id=?';
mysqli['get_user_bank_list'] = 'SELECT bk.*, date_format(bk.created_date, "%m-%d-%Y %H:%i:%s") AS created_date FROM hmb_user_banks AS bk WHERE 1=1 {{where}} ORDER BY bk.id DESC {{limit}}';
mysqli['get_bank_details'] = 'SELECT * FROM hmb_user_banks WHERE id=?';
mysqli['make_transaction'] = 'insert into hmb_buynow (projectId, userId, amount, type, paid, paid_type, qty, date_added, date_updated) values (?,?,?,?,?,?,?,?,?)';
mysqli['update_transaction'] = 'UPDATE hmb_buynow SET paid=?, paid_type=?, date_updated=? WHERE id=?';
mysqli['get_bid_details'] = 'SELECT b.*, b.proposed_amount AS amount, p.moq FROM bids AS b INNER JOIN products AS p ON p.id=b.project_id WHERE b.id=?';
mysqli['generate_invoice'] = 'INSERT INTO invoices (transactionid, gateway, date_added, user_id, primary_id, type, amount, shipping_amount, transaction_fee, transaction_fee_per, total_amount, status,istatus, paid_date, qty) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['get_invoice_details'] = 'SELECT i.*, date_format(i.paid_date,"%M %d %Y %r") AS paid_date, date_format(i.date_added,"%M %d %Y %r") AS date_added, p.title, bu.name AS buyer_name, bu.city AS buyer_city, bu.state AS buyer_state, bu.zipcode AS buyer_zipcode, bu.address AS buyer_address, su.name AS seller_name, su.city AS seller_city, su.state AS seller_state, su.zipcode AS seller_zipcode, bu.address AS seller_address FROM invoices AS i INNER JOIN products AS p ON p.id=i.primary_id INNER JOIN hmb_users AS bu ON bu.id=i.user_id INNER JOIN hmb_users AS su ON su.id=p.user_id WHERE i.id=?';
mysqli['get_ad_details'] = 'SELECT a.*, date_format(a.created_at,"%M %d %Y %r") AS created_at FROM adwords AS a WHERE a.id=?';
mysqli['make_duplicate_product'] = 'INSERT INTO products (`user_id`, `title`, `start_date`, `end_date`, `category_id`, `subcategory_id`, `sold_in_lots`, `type`, `auction_active`, `is_buynow`, `start_price`, `reserve_price`, `buynow_price`, `buynow_qty`, `fixed_price`, `fixed_qty`, `offer_price`, `offer_qty`, `offer_buyer_id`, `description`, `packaging_description`, `lot_size_measurement`, `units_in_lot`, `lots_available`, `unit_of_measurement`, `manufacture_date`, `certificate_types`, `certificate_date`, `contaminant_screening`, `contaminant_screening_data`, `sops`, `payment_method`, `payment_method_other`, `product_image`, `created_at`, `updated_at`, `market_status`, `amount_sold`, `moq`, `product_place`, `win_price`, `qty_available`, `keywords`, `renew`, `is_featured`, `f_start_date`, `f_end_date`)'+
' SELECT `user_id`, CONCAT("Duplicate - ", `title`) AS title, `start_date`, `end_date`, `category_id`, `subcategory_id`, `sold_in_lots`, `type`, `auction_active`, `is_buynow`, `start_price`, `reserve_price`, `buynow_price`, `buynow_qty`, `fixed_price`, `fixed_qty`, `offer_price`, `offer_qty`, `offer_buyer_id`, `description`, `packaging_description`, `lot_size_measurement`, `units_in_lot`, `lots_available`, `unit_of_measurement`, `manufacture_date`, `certificate_types`, `certificate_date`, `contaminant_screening`, `contaminant_screening_data`, `sops`, `payment_method`, `payment_method_other`, `product_image`, `created_at`, `updated_at`, "draft", `amount_sold`, `moq`, `product_place`, NULL, `qty_available`, `keywords`, NULL, `is_featured`, `f_start_date`, `f_end_date`'+
' FROM products WHERE id=?';
mysqli['make_duplicate_product_image'] = 'INSERT INTO product_images (`project_id`, `image`, `avatar`, `date_added`, `classified_id`, `type`)'+
' SELECT ?, IF(`type`="image", CONCAT(?, `image`), `image`), CONCAT(?, `avatar`), `date_added`, `classified_id`, `type`'+
' FROM product_images WHERE project_id=?';
mysqli['make_duplicate_product_certificates'] = 'INSERT INTO product_certificates (`user_id`, `product_id`, `certificate_name`, `type`, `status`, `created_at`, `updated_at`)'+
' SELECT `user_id`, ?, `certificate_name`, `type`, `status`, `created_at`, `updated_at`'+
' FROM product_certificates WHERE product_id=?';
mysqli['get_banner_list'] = 'SELECT * FROM banner';
mysqli['insert_banner'] = 'INSERT INTO banner(cid, image, enable, date_added) VALUES(?,?,1,?)';
mysqli['update_banner'] = 'UPDATE banner SET image=? WHERE cid=?';
mysqli['get_banner_detail'] = 'SELECT * FROM banner WHERE cid=? LIMIT 0,1';
mysqli['get_buynow_detail'] = 'SELECT b.*, p.moq FROM hmb_buynow AS b INNER JOIN products AS p ON p.id=b.projectId WHERE b.id=?';
mysqli['get_transactions'] = `SELECT i.*, (i.amount + i.shipping_amount) AS release_amount, date_format(i.date_added, "%m-%d-%Y %H:%i:%s") AS date_added, p.id AS product_id, p.title AS product_title, buyer.email AS buyer_email, seller_bank.is_primary, p.user_id AS seller_user_id, seller.email AS seller_email,  
es.escrow_company, es.user_type, es.user_name, es.user_company, es.user_email, es.user_phone, es.bank_name, es.account_name, es.account_number, es.routing_number
FROM invoices AS i INNER JOIN products AS p ON p.id=i.primary_id INNER JOIN hmb_users AS buyer ON buyer.id=i.user_id INNER JOIN hmb_users AS seller ON seller.id=p.user_id LEFT JOIN hmb_user_banks AS seller_bank ON seller_bank.user_id=p.user_id AND seller_bank.is_primary=1 LEFT JOIN hmb_escrow_details AS es ON es.invoice_id=i.id WHERE 1=1 {{where}} ORDER BY i.id DESC {{limit}}`;
mysqli['get_net_revenue'] = 'SELECT SUM(amount + shipping_amount + transaction_fee) AS total FROM invoices WHERE 1=1';
mysqli['change_product_end_date'] = 'UPDATE products SET end_date=? WHERE id=?';
mysqli['get_shipping_list'] = 'SELECT s.* FROM shipping AS s WHERE s.user_id=?';
mysqli['add_shipping_info'] = 'INSERT INTO shipping (name, address, country, zipcode, city, state, user_id, email, phone, delivery_instruction, status, created_date) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['edit_shipping_info'] = 'UPDATE shipping SET name=?, address=?, country=?, zipcode=?, city=?, state=?, email=?, phone=?, delivery_instruction=? WHERE id=?';
mysqli['set_shipping_id'] = 'UPDATE invoices SET shipping_id=?, status="waiting_for_shipping_amount" WHERE id=?';
mysqli['add_buynow'] = 'insert into hmb_buynow (projectId, userId, amount, type, paid, paid_type, qty, date_added, date_updated) values (?,?,?,?,?,?,?,?,?)';
mysqli['get_shipping_details'] = 'SELECT s.* FROM shipping AS s WHERE s.id=?';
mysqli['set_shipping_amount'] = 'UPDATE invoices SET shipping_amount_added=1, shipping_amount=?, total_amount=(amount + transaction_fee + ?), status=? WHERE id=?';
mysqli['get_product_and_buyer_details_using_invoice'] = 'SELECT p.*, buyer.name AS buyer_name, buyer.email AS buyer_email, i.amount, i.transaction_fee, i.shipping_amount FROM invoices AS i INNER JOIN products AS p ON i.primary_id=p.id INNER JOIN hmb_users AS buyer ON buyer.id=i.user_id WHERE i.id=?';
mysqli['update_invoice_release_status'] = 'UPDATE invoices SET release_status=? WHERE {{where}}';
mysqli['update_invoice_release_transaction'] = 'UPDATE invoices SET refer_id=?, trans_id=?, destination_payment=? WHERE id=?';
mysqli['get_buyer_bank_detail_using_invoice_id'] = 'SELECT bk.*, i.amount, i.shipping_amount, i.transaction_fee, bk.stripe_account_id, p.title, seller.name AS seller_name, seller.email AS seller_email FROM invoices AS i INNER JOIN products AS p ON i.primary_id=p.id INNER JOIN hmb_users AS seller ON seller.id=p.user_id INNER JOIN hmb_user_banks AS bk ON bk.user_id=p.user_id WHERE bk.is_primary=1 AND i.id=?';
mysqli['remove_primary_bank'] = 'UPDATE hmb_user_banks SET is_primary=0 WHERE user_id=?';
mysqli['set_primary_bank'] = 'UPDATE hmb_user_banks SET is_primary=1 WHERE id=?';
mysqli['delete_bank'] = 'DELETE FROM hmb_user_banks WHERE id=?';
mysqli['add_escrow_details'] = 'insert into hmb_escrow_details (invoice_id, escrow_company, user_type, user_name, user_company, user_email, user_phone, bank_name, account_name, account_number, routing_number, status, created_date) values (?,?,?,?,?,?,?,?,?,?,?,?,?)';
mysqli['edit_escrow_details'] = 'UPDATE hmb_escrow_details SET escrow_company=?, user_type=?, user_name=?, user_company=?, user_email=?, user_phone=?, bank_name=?, account_name=?, account_number=?, routing_number=? WHERE id=?';
mysqli['add_transaction_id'] = 'UPDATE invoices SET transactionid=?, paid_date=?, gateway=? WHERE id=?';
mysqli['update_invoice_status'] = 'UPDATE invoices SET status=? WHERE id=?';
mysqli['product_details_using_invoice_id'] = 'SELECT p.*, i.type AS invoice_type, seller.email AS seller_email, seller.name AS seller_name, buyer.email AS buyer_email, buyer.name AS buyer_name FROM products AS p INNER JOIN invoices AS i ON i.primary_id=p.id INNER JOIN hmb_users AS seller ON seller.id=p.user_id INNER JOIN hmb_users AS buyer ON buyer.id=i.user_id WHERE i.id=?';
mysqli['get_seo_management'] = 'SELECT seo.*, date_format(seo.created_date, "%m-%d-%Y %H:%i:%s") AS created_date, p.title AS product_title FROM hmb_seo AS seo INNER JOIN products AS p ON p.id=seo.product_id WHERE 1=1 {{where}} ORDER BY seo.id DESC {{limit}}';
mysqli['saveProductToSEO'] = 'insert into hmb_seo (product_id, meta_title, meta_key, meta_description, created_date) values (?,?,?,?,?)';
mysqli['update_medata'] = 'UPDATE hmb_seo SET meta_title=?, meta_key=?, meta_description=? WHERE id=?';
mysqli['get_unread_chat_offer_message'] = 'SELECT oc.*, receiver.email AS receiver_email, receiver.name AS receiver_name, p.title AS product_title FROM offer_chat AS oc INNER JOIN hmb_users AS receiver ON receiver.id=oc.receiver_id INNER JOIN products AS p ON p.id=oc.product_id WHERE oc.is_read=0 AND oc.mail_sent_to_receiver=0 {{where}} GROUP BY oc.receiver_id';
mysqli['update_mail_send_for_offer_message'] = 'UPDATE offer_chat SET mail_sent_to_receiver=1 WHERE is_read=0 AND mail_sent_to_receiver=0 AND receiver_id=? {{where}}';
mysqli['update_transaction_contract'] = 'UPDATE invoices SET transaction_contract=? WHERE id=?';
mysqli['unread_chat_list'] = 'SELECT oc.*, date_format(oc.created_date,"%d %M %Y %H:%i:%s") AS created_date, p.title AS product_title FROM offer_chat AS oc INNER JOIN products AS p ON p.id=oc.product_id WHERE oc.is_read=0 AND oc.receiver_id=? ORDER BY oc.id DESC';
mysqli['get_product_seller_detail_using_invoiceid'] = 'SELECT i.*, p.title AS product_title, u.name AS seller_name, u.email AS seller_email FROM invoices AS i INNER JOIN products AS p ON p.id=i.primary_id INNER JOIN hmb_users AS u ON u.id=p.user_id WHERE 1=1 {{where}}';
