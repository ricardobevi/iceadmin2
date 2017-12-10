// TODO: mandar a un util.js
var _LINECHARS = 32;
var _LINEBIGCHARS = 20;

function obtainTicketNumber(){
		
	var ticketNumber = Cookies.get("ticket_number");
	
	if ( ticketNumber != undefined ) {
			
		ticketNumber = parseInt(ticketNumber) + 1;
		
		if ( ticketNumber > 999 ) ticketNumber = 0;
		
		Cookies.set("ticket_number", ticketNumber, { expires: 7 });
		
	} else {
		
		Cookies.set("ticket_number", 1, { expires: 7 });
		
	}
	
	return ticketNumber;
	
}

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


$('#container').ready(function(){
	$("#quick_access").load( quickAccessUrl );
	$("#ticket_list").load( ticketListUrl );
});

function add_product(productId, quantity){
	$("#ticket_list").load( ticketListUrl + "/add_product/" + productId + "/" + quantity );
}


function mod_product(productId, quantity){
	$("#ticket_list").load( ticketListUrl + "/mod_product/" + productId + "/" + quantity );
}

function close_ticket(){
	$("#ticket_list").load( ticketListUrl + "/close" );
}


function print_number( ticketNumber ){
	
    var s = "000" + ticketNumber;
    ticketNumberString = s.substr( s.length - 3 );
		
	qz.appendImage(ticketNumberImgUrl + "/print_number/" + ticketNumberString, "ESCP", "simple");
	
}


function print_header(ticketNumber){
	qz.appendHex("x1Bx40"); // start printer
	
    qz.append( centerText( underlineText("Heladeria Los Amores") ) + "\n");
    
    qz.append(centerText("Brown 67, Mar de Ajo\n"));
    
    qz.append(createLine());
    
    qz.append(centerText("Sera llamado por el numero: \n"));
    
    print_number( ticketNumber );
    
    qz.appendHex("x0Dx0A"); //newline
    
}

function print_wifi(){
	 qz.append(createLine());
	 qz.append(centerText("Clave del WiFi:" + wifiPass + "\n"));
	 qz.append(createLine());
}

function print_body( items, total ){
	
	total = formatCurrency(total);

	qz.append("Cnt Descripcion           SubTot");
	qz.append(createLine());
	
	var itemLine = "";
	var subtotal = "";
	
    for ( itemNum = 0 ; itemNum < items.length ; itemNum++ ) {
    	var item = items[itemNum];
    	
    	itemLine = item.qty + " " + item.name;
    	subtotal = formatCurrency( item.subtotal );

    	itemLine = itemLine + repeatText(".", _LINECHARS - (itemLine.length + subtotal.length) );
    	
    	itemLine = itemLine + subtotal;
    	
    	qz.append( itemLine + "\n");
    }
   
    qz.appendHex("x1Bx21x30"); // change text size
    
    qz.append(rightText("Total: " + total));
    qz.appendHex("x0Dx0A"); //newline
    
    qz.appendHex("x1Bx21x00"); // change text size
    
    qz.append(createLine());
	
}

function print_footer(){

   var data = [
      centerText("GRACIAS POR ELEGIRNOS\n"),
      centerText("Hasta la proxima!\n"),
      "\x0D\x0A\x0D\x0A\x0D\x0A\x0D\x0A\x0D\x0A\x0D\x0A"
   ];

   qz.print(config, data).catch(function(e) { console.error(e); });
	
}


function print_ticket(){
	
/*
	$.getJSON( ticketListUrl + "/json_print", function( data ) {
		var items = [];
		var total = 0;

		$.each( data, function( key, val ) {
			//items.push( "<li>" + val.name + " " + val.qty + " " + val.subtotal + "</li>" );
			
			if ( key == "list" ){
				
				$.each( val, function( key, value ) {
					items.push( value );
				});
				
			} else if ( key == "total" ) {
				total = val;
			}
			
		});
				
		print_header( obtainTicketNumber() );
			
		window["qzDoneAppending"] = function() {
						
			print_wifi();
			print_body( items, total );
			print_footer();

		    // Tell the apple to print.
		    qz.print();
		    
		    // Remove any reference to this function
		    window['qzDoneAppending'] = null;
		};

	});

*/
	
print_footer();

}



$(document).keydown(function(event) {

    if ( _DEBUG ) $("#debug").text( "DOWN " + event.keyCode );
    

    switch( event.keyCode ){
   
 		case 110:
			add_product($( "button[position='1,-1']" ).attr('productid'), 1);
			break;
    	case 96:
    		add_product($( "button[position='1,0']" ).attr('productid'), 1);
    		break;
    		
    	case 97:
    		add_product($( "button[position='1,1']" ).attr('productid'), 1);
    		break;
    	case 98:
    		add_product($( "button[position='1,2']" ).attr('productid'), 1);
    		break;
    	case 99:
    		add_product($( "button[position='1,3']" ).attr('productid'), 1);
    		break;
    		
    	case 100:
    		add_product($( "button[position='1,4']" ).attr('productid'), 1);
    		break;
    	case 101:
    		add_product($( "button[position='1,5']" ).attr('productid'), 1);
    		break;
    	case 102:
    		add_product($( "button[position='1,6']" ).attr('productid'), 1);
    		break;
    		
    	case 103:
    		add_product($( "button[position='1,7']" ).attr('productid'), 1);
    		break;
    	case 104:
    		add_product($( "button[position='1,8']" ).attr('productid'), 1);
    		break;
    	case 105:
    		add_product($( "button[position='1,9']" ).attr('productid'), 1);
    		break;
    
    
        case 17:
            $("#quick_access_group_1").addClass("collapse");
            $("#quick_access_group_2").removeClass("collapse");
            break;


    }
	
	
    if ( event.ctrlKey ) {

        switch(event.which){
	        case 110:
				add_product($( "button[position='2,-1']" ).attr('productid'), 1);
				break;
	    	case 96:
	    		add_product($( "button[position='2,0']" ).attr('productid'), 1);
	    		break;
	    		
	    	case 97:
	    		add_product($( "button[position='2,1']" ).attr('productid'), 1);
	    		break;
	    	case 98:
	    		add_product($( "button[position='2,2']" ).attr('productid'), 1);
	    		break;
	    	case 99:
	    		add_product($( "button[position='2,3']" ).attr('productid'), 1);
	    		break;
	    		
	    	case 100:
	    		add_product($( "button[position='2,4']" ).attr('productid'), 1);
	    		break;
	    	case 101:
	    		add_product($( "button[position='2,5']" ).attr('productid'), 1);
	    		break;
	    	case 102:
	    		add_product($( "button[position='2,6']" ).attr('productid'), 1);
	    		break;
	    		
	    	case 103:
	    		add_product($( "button[position='2,7']" ).attr('productid'), 1);
	    		break;
	    	case 104:
	    		add_product($( "button[position='2,8']" ).attr('productid'), 1);
	    		break;
	    	case 105:
	    		add_product($( "button[position='2,9']" ).attr('productid'), 1);
	    		break;
	        
            case 13:
                print_ticket();
                close_ticket();
                break;
        }
    	
    }
	
});


$(document).keyup(function(event) {

	if ( _DEBUG ) $("#debug").text( "UP " + event.keyCode );
	
    switch(event.keyCode){
		case 17:
			$("#quick_access_group_2").addClass("collapse");
			$("#quick_access_group_1").removeClass("collapse");
			break;
	}

});


$(document).on("keyup", ".ticket_list_qty", function(event) {
	
	if( $.isNumeric( $(this).val() ) ){
		mod_product($(this).attr('productid'), $(this).val() );
	}

});


$(document).on("click", ".quickaccess", function(event) { 
	if ( _DEBUG ) $("#debug").text( $(this).attr('productid') );
	add_product($(this).attr('productid'), 1);
});

