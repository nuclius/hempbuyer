var maxlength = 150;
$('p.trimed-description').text(function (_, text) {
    return $.trim(text).substring(0, maxlength);
});
