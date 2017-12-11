<?php $this->load->helper('url');?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- link rel="icon" href="favicon.ico" -->

    <title>IceAdmin2</title>

    <!-- Bootstrap core CSS -->
    <link href="<?php echo base_url("public/css/bootstrap.min.css");?>"
    	rel="stylesheet">

    <link href="<?php echo base_url("public/css/main.css");?>"
    	rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->


    <script type="text/JavaScript">

	    var _DEBUG = true;

	    var wifiPass = "<?php echo file_get_contents( site_url('wifi/pass/get_pass') . '/lala');?>";
	
	    var ticketUrl = "<?php echo site_url('ticket/ticket');?>";
	
	    var reportUrl = "<?php echo site_url('report/report');?>";
	
	    var ticketJSUrl = "<?php echo base_url("public/js/ticket.js");?>";
	
	    var quickAccessUrl = "<?php echo site_url('ticket/quick_access');?>";
	
	    var ticketListUrl = "<?php echo site_url('ticket/ticket_list');?>";

	    var ticketNumberImgUrl = "<?php echo site_url('ticket/ticket_number');?>";
	    

    </script>

 
    <script	src="<?php echo base_url("public/js/vendor/jquery.min.js");?>"></script>
    <script	src="<?php echo base_url("public/js/vendor/jquery.number.min.js");?>"></script>
    <script	src="<?php echo base_url("public/js/vendor/js-cookie.js");?>"></script>
    
    <script type="text/javascript" src="<?php echo base_url("public/qz/dependencies/rsvp-3.1.0.min.js");?>"></script>
    <script type="text/javascript" src="<?php echo base_url("public/qz/dependencies/sha-256.min.js");?>"></script>
    <script type="text/javascript" src="<?php echo base_url("public/qz/qz-tray.js");?>"></script>

    <script type="text/javascript" src="<?php echo base_url("public/js/qz-iceadmin.js");?>"></script>

    <script type="text/JavaScript" src="<?php echo base_url("public/js/main.js");?>"></script>
    <script type="text/JavaScript" src="<?php echo base_url("public/js/ticket.js");?>"></script>
    

</head>

<body>

	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="<?php echo site_url('ticket');?>">Ice Admin 2</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li id="ticket" class="active"><a href="#">Facturación</a></li>
					<li id="report" class="inactive"><a href="#">Reportes</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>



	<div class="container" id="container">

