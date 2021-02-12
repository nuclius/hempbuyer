<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin</title>

    <!-- Bootstrap Core CSS -->
    <link href="{$config.dpath}css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="{$config['externalcss']}font-awesome.css">

    <!-- Custom CSS -->
    <link href="{$config.dpath}css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="{$config.dpath}css/flaticon.css">
    <!-- Font awsome -->
    <link rel="stylesheet" type="text/css" href="{$config['externalcss']}intlTelInput.css">

    <link href="https://cdn.datatables.net/1.10.9/css/dataTables.bootstrap.min.css" rel="stylesheet">
    {foreach $external2css as $key => $val}
    <link rel="stylesheet" href="{$config['externalcss']}{$val}.css" type="text/css" />
    {/foreach}
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="{$config['externaljs']}country.js" type="text/javascript"></script>
    <script src="{$config['externaljs']}ckeditor/ckeditor.js"></script>
    <link href="{$config.dpath}css/mystyle.css" rel="stylesheet">

    <link href="{$config.dpath}css/admin-mystyle.css" rel="stylesheet">

    <style type="text/css">
        
    </style>
</head>

<script type="text/javascript">
    var ILBASE = ASBASE = '{$config.url}';
    function CKupdate() {
        for (instance in CKEDITOR.instances)
            CKEDITOR.instances[instance].updateElement();
    }
</script>

<body class="admin-body-wrapper">
    <div class="cus-wrapper" id="wrapper">
        <nav class="navbar navbar-inverse navbar-fixed-top cus-navbar-fixed-top shadow" role="navigation"
            style="text-transform: capitalize;">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header"> 
                <a class="navbar-brand" href="/admincp">
                    <img src="{$config.dpath}images/logo.png" alt="">
                </a>
            </div> 
        </nav>

        <div class="cus-page-wrapper" id="page-wrapper">
            <div class="login-box-wrapper">
                {if $error == 'saved'}
                <div class="alert alert-success"> 
                    <strong>Saved!</strong> {$users.first_name} profile was successfully
                    changed. 
                </div>
                {elseif $error != ''}
                <div class="alert alert-danger"> <strong>{$error}</strong> </div>
                {/if}
                 
                <div class="flex login_box" style="">
                    <h5 class="hb-login-head text-center">Login</h5>
                    <form action="{$config['url']}/admin/login/save" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="redirect_url" value="{$redirect_url}">
                        <div class="form-label">
                            <label>User Name </label>
                            <input type="text" id="username" name="username" placeholder="Enter username" value="admin@auctionsoftware.com" class="form-control ">
                        </div>
                        <div class="form-label">
                            <label>Password</label>
                            <input type="password" placeholder="Enter password" id="password" name="password" value="12345678" class="form-control">
                        </div>
                        <br />
                        <button type="submit" value="Login" name="id" class="btn btn btn-default btn-d-b green-b m0">LOGIN</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="{$config['externaljs']}md5-min.js" type="text/javascript"></script>

{include file="/admincp/footer.tpl" nocache}