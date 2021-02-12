 {include file="common/header-1.tpl" nocache}
<form action="/setAccess" method="post" id="setAccess">
    <input type="submit" value="Submit">
</form>
<script>
    console.log('window.location');
    console.log('asdsad {$config.general.authentication_password}');

    var sign = prompt("This is Beta Version. Please enter the code to access the site.");
    // if (window.location.origin == 'http://localhost:3003') {
    // var sign = '664033';
    // } else {
    // var sign = prompt("This is Beta Version. Please enter the code to access the site.");
    // }
    if (sign == null || sign == '') {
        window.location = "{$config.url}"
    }
    if (sign.toLowerCase() == "{$config.general.authentication_password}") {
        $('#setAccess').submit();
    } else {
        window.location = "{$config.url}"
    }
</script>