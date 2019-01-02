<?php $this->load->helper('url');?>

<html>


<head>

    <script	src="<?php echo base_url("public/js/vendor/jquery.min.js");?>"></script>
    <script	src="<?php echo base_url("public/js/vendor/jquery.number.min.js");?>"></script>
    <script	src="<?php echo base_url("public/js/vendor/js-cookie.js");?>"></script>

	
    <script type="text/javascript" src="<?php echo base_url("public/qz/dependencies/rsvp-3.1.0.min.js");?>"></script>
    <script type="text/javascript" src="<?php echo base_url("public/qz/dependencies/sha-256.min.js");?>"></script>
    <script type="text/javascript" src="<?php echo base_url("public/qz/qz-tray.js");?>"></script>

    <script type="text/javascript" src="<?php echo base_url("public/js/qz-iceadmin.js");?>"></script>

    
    <script type="text/JavaScript">

	var _LINECHARS = 30;
	var _LINEBIGCHARS = 15;


	function formatCurrency(number){
		var ret = "$" + $.number( number , 2, ',' );
		return ret;
	}
	
	function createLine(character = "_"){
		var line = repeatText(character, _LINECHARS) + "\n";
		return line;
	}
	
	function repeatText(text, times){
		var repeatedText = "";
		
		for ( repeat = 0 ; repeat < times ; repeat++ ){
			repeatedText = repeatedText + text;
		}
		
		return repeatedText;
	}
	
	function underlineText( text, mustCenter = true, underlineChar = "*" ) {
		var underlinedText = "";
		
		if ( mustCenter == true ){
			underlinedText = centerText( text + "\n" );
			underlinedText = underlinedText + centerText( repeatText(underlineChar, text.length) );
		} else {
			underlinedText = text + "\n";
			underlinedText = underlinedText + repeatText(underlineChar, text.length);
		}
		
		
		return underlinedText;
	}
	
	function centerText(text) {
		var centered = "";
		
		var charsToCenter = (_LINECHARS / 2) - (text.length / 2);
		
		centered = repeatText(" ", charsToCenter) + text;
		
		return centered;
	}
	
	function centerBigText(text) {
		var centered = "";
		
		var charsToCenter = (_LINEBIGCHARS / 2) - (text.length / 2);
		
		centered = repeatText(" ", charsToCenter) + text;
		
		return centered;
	}
	
	function rightText(text) {
		var right = "";
		
		var charsToRight = _LINECHARS - text.length;
		
		right = repeatText(" ", charsToRight) + text;
		
		return right;
	}

	var report_date = '<?php echo json_encode($report_date); ?>';

	var report = ["Reporte del dia " + report_date + "\n"];

	report.push(createLine());

	var reportData = <?php echo json_encode($report_data); ?>;

	var total = 0;

	reportData.forEach(function(item) {
		
		total = total + parseFloat(item.price);

    		itemLine = item.quantity + " " + item.product_name;
	    	subtotal = formatCurrency( parseFloat(item.price) );
	
	    	itemLine = itemLine + repeatText(".", _LINECHARS - (itemLine.length + subtotal.length) );
	    	
	    	itemLine = itemLine + subtotal;
	    	
    		report.push( itemLine + "\n");
	});


        report.push("\x1B\x21\x30"); // change text size
	    
        report.push(rightText(formatCurrency(total)));
        report.push("\x0D\x0A"); //newline
	    
        report.push("\x1B\x21\x00"); // change text size
	    
        report.push(createLine());

	

	qz.websocket.connect({retries: 5, delay: 1}).then(function() {
		
		// Mi agregado @ricardobevi
		qz.printers.find("zebra").then(function(found) {
			console.log("Imprimiendo en " + found);
			qz.print(config, report).catch(function(e) { console.error(e); });

		});

        });



    </script>



</head>


<body>

data: <?php echo json_encode($report_data); ?>

</body>

</html>


