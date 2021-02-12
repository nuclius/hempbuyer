<script src="https://www.paypalobjects.com/js/external/dg.js"  type="text/javascript" language="javascript">
</script><script  type="text/javascript" language="javascript">
    if (window != top) {

        setTimeout(
                function()
                {

                    /*top.location.href="/product/checkout/paid/?id={$cart_id}";*/
                    top.location.href="/dashboard/buynow";

                }, 100);

    }

</script>
<body>
{$pharse.if_this_page_does_not_redirect} <a href="/dashboard/buynow">{$pharse.click_here}</a>
</body>