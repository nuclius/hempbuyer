var temp = '';
var paginationData = {
    recordPerPage: 10,
    currentPage: 1,
    url: '',
    type: '',
    totalRecord: 0,
    html_div: ''
}
function pagination(paginationData) {
    var totalPage = 0;
    var totalPages = 0;
    var html = '';
    var startPage = 1;
    var gap = 3;
    var base_url = '';

    var totalRecord = +paginationData.totalRecord;
    var currentPage = +paginationData.currentPage;
    var recordPerPage = +paginationData.recordPerPage;
    var url = paginationData.url;
    console.log('paginationData common_admin.js', paginationData);

    if (totalRecord > 0 && totalRecord > recordPerPage) {
        totalPage = Math.ceil(totalRecord / recordPerPage);
        totalPages = Math.ceil(totalRecord / recordPerPage);
        if (totalPage > 6) {
            // totalPage = 8;
            if (currentPage > gap) startPage = currentPage - gap;
            if ((currentPage + gap) < totalPage) totalPage = gap + currentPage;
        }
        if (currentPage > 1) {
            html += '<li>' +
                '<a href="javascript:void(0)" class="previous" title="First" data-page="1">' +
                '<figure>' +
                '<img src="' + base_url + '/images/chevron_double_left.png" alt="">' +
                '</figure>' +
                '</a>' +
                '</li>';
            html += '<li>' +
                '<a href="javascript:void(0)" class="previous" title="Previous" data-page="' + (+currentPage - 1) + '">' +
                '<figure>' +
                '<img src="' + base_url + '/images/chevron_left.png" alt="">' +
                '</figure>' +
                '</a>' +
                '</li>';
        }
        for (var index = startPage; index <= totalPage; index++) {
            html += '<li>' +
                '<a href="javascript:void(0)" data-page="' + index + '" class="' + (currentPage == index ? 'active' : '') + '">' + index + '</a>' +
                '</li>';
        }
        if (totalPage != currentPage) {
            html += '<li>' +
                '<a href="javascript:void(0)" class="next" title="next" data-page="' + (+currentPage + 1) + '">' +
                '<figure>' +
                '<img class="right" src="' + base_url + '/images/chevron_right.png" alt="">' +
                '</figure>' +
                '</a>' +
                '</li>';
            html += '<li>' +
                '<a href="javascript:void(0)" class="next" title="Last" data-page="' + (+totalPages) + '">' +
                '<figure>' +
                '<img class="right" src="' + base_url + '/images/chevron_double_right.png" alt="">' +
                '</figure>' +
                '</a>' +
                '</li>';
        }
        html = '<ul id="pagination_ul" data-url="' + url + '">' + html + '</ul>';
        return html;
    } else {
        return '';
    }
}

$(document).ready(function () {

    $(document).on('click', '#pagination_ul li a', function () {
        paginationData.currentPage = $(this).attr('data-page');
        $("#page").val(paginationData.currentPage);
        paginationData.url = $(this).closest('#pagination_ul').attr('data-url');

        var params = {};
        params.ajax = 1;
        params.type = paginationData.type;
        params.recordPerPage = paginationData.recordPerPage;
        params.page = paginationData.currentPage;
        if (paginationData.searchsales) {
            params.search = paginationData.search;
            params.searchsales = 1;
        }

        var formArray = $("#"+paginationData.form_name).serializeArray();
        var Obj = {};
        var productData = formArray ? formArray : [];
        if(productData.length) {
            for (var index = 0; index < productData.length; index++) {
                const element = productData[index];
                Obj[productData[index].name] = productData[index].value;
            }
        }
        // $("#" + inHtml).html('<center style="margin-top: 268px;"><i class="fa fa-spinner fa-pulse fa-3x fa-fw"></i><span class="sr-only">Loading...</span></center>');

        $.ajax({
            type: 'POST',
            url: config_url + paginationData.url,
            // data: params,
            data: Obj,
            // dataType: 'json',
            success: function (data) {
                $("#overlay").hide();
                $("#" + paginationData.html_div).html(data);
                paginationData.totalRecord = $("#pagination_html").attr('data-total-record');
                $("#pagination_html").html(pagination(paginationData));
            }
        });
    });
});