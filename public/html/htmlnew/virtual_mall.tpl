<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>The Herbal Electronic Exchange</title>
    <!-- <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" /> -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome-animation.min.css">
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" href="css/aos.css" />
    <link rel="stylesheet" href="css/owl.carousel.min.css" />
    <link rel="stylesheet" href="css/owl.theme.default.css" />
    <link href="https://fonts.googleapis.com/css?family=Pacifico" rel="stylesheet">
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.theme.default.css">
    <link rel="stylesheet" href="css/mystyle.css" />

</head>

<body>
<!--Header start Here-->
<header>
    <nav class="navbar navbar-default">
      <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header"  data-aos="fade-right">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#" style="margin-top: -20px;"><img src="images/logo.png" class="img-responsive" /></a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse mrtp5" id="bs-example-navbar-collapse-1">
         <ul class="nav navbar-nav navbar-right mrtp5"   data-aos="fade-left">
            <li><a href="index.html">Home</a></li>
            <li><a href="#">About Us</a></li>
            <li><a class="howworks" href="index.html#howworksSec">How it Works</a></li>
            <li><a href="#">Membership</a></li>
            <li><a href="#">Contact</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <div class="form-group">
              <input type="text" class="form-control" placeholder="User Name">
            </div>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Password">
            </div>
            <button onclick="window.location.href='login.html'" type="button" class="btn btn-default">Login</button>
          </form>

        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
    </nav>
</header>
<!--Header end Here-->


<!-- Page content -->

    <div class="container-fluid bgBannerFluid">
        <h1>Virtual Mall</h1>
            <div class="row">
                <div class="col-md-12 confLinkCol">
                    <ul>
                      <a href="market-selection.html"><li>
                        <!-- <span class="icon flaticon-auction"></span> -->
                        <i class="fa fa-home" aria-hidden="true"></i>
                        Welcome Page</li></a>
                        <a href="store-view.html"><li><img src="images/manage.png" alt="">Manage Store</li></a>
                        <a href="create-store.html"><li><i class="flaticon-business"></i>Create New Store</li></a>
                        <a href="#"><li><img src="images/ads.png" alt="">Manage Ads</li></a>
                        <a href="#"><li><img src="images/transaction.png" alt="">Recent Sales</li></a>

                        <a href="#"><li><img src="images/reports.png" alt="">Reports</li></a>
                        <li style="position:relative">
                          <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"><i class="flaticon-settings"></i>Settings
                          <span class="caret"></span></button>
                          <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">

                          <li role="presentation"><a role="menuitem" tabindex="-1" href="dashboard-profile.html">Profile</a></li>
                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Messages</a></li>
                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Payments</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Contact information</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Change Password</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Shipping address changes</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Billing and Account Information</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Notifications</a></li>
                           <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Open Bid Market</a></li>
                           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Direct Buy Market</a></li> -->

                          </ul>
                        </li>

                    </ul>
                </div>
            </div>
    </div>


    <div class="container storesCon m50 m-b-0">

      <ol class="breadcrumb">
      <li><a class="grey-text" href="directbuy.html">Direct Buy Market</a></li>
      <li><a href="virtual-mall.html">Virtual Mall</a></li>
    </ol>

      <!-- Search field -->
      <div class="row flex">
          <div class="col-md-3 margin-auto">
              <input class="w80 p5-15 border1 input-radius search-input" placeholder="Search" type="text" name="" value="">
              <button type="button" name="button" class="input-radius green-b b search-btn">
                  <i class="fa fa-search white" aria-hidden="true"></i>
              </button>
          </div>
      </div><!-- Search field -->

        <!-- Stores -->

            <div class="row stores-row m35" id="feature-store">

                <!-- <p>Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus elit.</p> -->
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store1.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store2.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store1.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store2.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store1.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store2.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store1.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store2.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store1.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store2.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'" class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 shadow">

                    <div class="row">
                        <div class="col-md-12 thumb p0">
                            <img class="img-responsive w100" src="images/store3.jpg" alt="">
                            <div class="title white green-b input-radius">
                                <h3>
                                     <span class="flaticon-shopping-cart"></span> <b>Store Name</b>
                                 </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="description m30">
                                Proin et ipsum non neque interdum luctus a eu risus. Cras dolor justo, congue vel massa in, eleifend dapibus.
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="rating text-center">
                                <a href="#">
                                    <span><i class="fa fa-star" aria-hidden="true"></i> Rate this store's performance</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button onclick="window.location.href='store-view.html'"f class="btn btn-default btn-d black-b" type="button" name="button">VIEW STORE</button>
                        </div>
                    </div>
                </div>

            </div>


    </div>


<!--/ Page content -->





<!--footer Start Here-->
<footer >
 <div class="container pdtb4p wid70">
 	<div class="col-xs-6 col-sm-6 col-md-6" data-aos="fade-right">
        <div class="footer_head">Main Menu</div>
        <ul class="ms_zero">
            <li><a href="#">Mobile App</a></li>
            <li><a href="#">Learn to Sell</a></li>
            <li><a href="#">Bidding & Buying Help </a></li>
            <li><a href="#">Advertise with Us </a></li>
            <li><a href="#">Investors </a></li>
            <li><a href="#">Policies </a></li>
            <li><a href="#">Contact Herbee </a></li>
        </ul>
    </div>
    <div class="col-xs-6 col-sm-6 col-md-6 text-right" data-aos="fade-left">
        <div class=" pull-right"><img src="images/logo-foot.png" class="img-responsive" /></div>
        <div class="clearfix"></div>
      <div class="mrtp30">
        <ul class="ms_zero">
            <li><a href="#">
                <span><img src="images/facebook.png" /></span>
                <span><img src="images/insta.png" /></span>
            	<span><img src="images/socl1.png" /></span>
                <!-- <span><img src="images/socl2.png" /></span> -->
                <span><img src="images/socl3.png" /></span>
                <!-- <span><img src="images/socl4.png" /></span> -->
                <!-- <span><img src="images/socl5.png" /></span> -->
                <!-- <span><img src="images/socl6.png" /></span> -->
                <!-- <span><img src="images/socl7.png" /></span> -->
            </a></li>
        </ul>
        </div>
    </div>
 </div>
</footer>
<!--footer End Here-->


<script src="js/custom.js"></script>
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/aos.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js">

</script>
<script type="text/javascript">
    $(document).ready(function(){
        // $('#feature-brands').owlCarousel();


            var owl = $('#feature-brands');
            owl.owlCarousel({
                items:4,
                // loop:true,
                margin:10,
                autoplay:true,
                autoplayTimeout:1000,
                autoplayHoverPause:true
            });
            $('.play').on('click',function(){
                owl.trigger('play.owl.autoplay',[1000])
            })
            $('.stop').on('click',function(){
                owl.trigger('stop.owl.autoplay')
            })


    });
</script>
<script>
   AOS.init({
      offset: 200,
      duration: 600,
      easing: 'ease-in-sine',
      delay: 100,
    });
</script>
<script type="text/javascript">
//On scroll call the draw function
$(window).scroll(function() {
drawLines();
});

//If you have more than one SVG per page this will pick it up
function drawLines(){
$.each($("path"), function(i, val){
  var line = val;
  drawLine($(this), line);
});
}

//draw the line
    function drawLine(container, line){
var length = 1;
var pathLength = line.getTotalLength();
var distanceFromTop = container.offset().top - $(window).scrollTop();
var percentDone = 1 - (distanceFromTop / $(window).height());
length = percentDone * pathLength;
line.style.strokeDasharray = [length,pathLength].join(' ');
console.log("strokeDasharray: "+[length,pathLength].join(' '));
}
</script>
</body>
</html>
