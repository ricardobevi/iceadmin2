// TODO: mandar a un util.js
var _LINECHARS = 32;
var _LINEBIGCHARS = 20;

launchQZ();

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
	
	var numberUrl = ticketNumberImgUrl + "/print_number/" + ticketNumberString;

	return numberUrl;
	
}

function current_date(){

var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();
var hour = today.getHours();
var minute = today.getMinutes();
var second = today.getSeconds();


if(dd < 10) {
	dd = '0' + dd;
} 

if(mm < 10) {
	mm = '0' + mm;
} 

if(hour < 10) {
	hour = '0' + hour;	
}

if(minute < 10) {
	minute = '0' + minute;
}

if(second < 10) {
	second = '0' + second;
}

return dd + '/' + mm + '/' + yyyy + '   ' + hour + ':' + minute + ':' + second + '\n'

}


function print_header(ticketNumber){
    var header = [
       	"\x1B\x40",
		centerText( underlineText("Heladeria Los Amores") ) + "\n",
		centerText("Brown 67, Mar de Ajo\n"),
	    	centerText(current_date()),
		createLine(),/*
		centerText("Sera llamado por el numero: \n"),
		{ 
			type: 'image',
			data: print_number(ticketNumber),
				options: { language: "ESCPOS", dotDensity: 'simple' }
		}*/
		"\x0D\x0A"
    ];
   
   return header; 
}

function print_wifi(){
	
	var wifi = [
		createLine(),
		centerText("Clave del WiFi:" + wifiPass + "\n"),
		createLine()
	];

	return wifi;

}

function print_body( items, total ){

    var body = [];
	
    total = formatCurrency(total);
	
    body.push("Cnt Descripcion           SubTot");
    body.push(createLine());
	
    var itemLine = "";
    var subtotal = "";
	

    for ( itemNum = 0 ; itemNum < items.length ; itemNum++ ) {
    	var item = items[itemNum];
    	
    	itemLine = item.qty + " " + item.name;
    	subtotal = formatCurrency( item.subtotal );

    	itemLine = itemLine + repeatText(".", _LINECHARS - (itemLine.length + subtotal.length) );
    	
    	itemLine = itemLine + subtotal;
    	
    	body.push( itemLine + "\n");
    }
   
    body.push("\x1B\x21\x30"); // change text size
    
    body.push(rightText("Total: " + total));
    body.push("\x0D\x0A"); //newline
    
    body.push("\x1B\x21\x00"); // change text size
    
    body.push(createLine());

	return body;
	
}

function print_footer(){

   var footer = [
      centerText("GRACIAS POR ELEGIRNOS\n"),
      centerText("Hasta la proxima!\n"),
      "\x0D\x0A\x0D\x0A\x0D\x0A\x0D\x0A\x0D\x0A\x0D\x0A"
   ];

   return footer;
}


function print_ticket(){
	

	var ticket = []; 

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



				
		ticket = ticket.concat(print_header( obtainTicketNumber() ));

		ticket = ticket.concat(print_wifi());

		ticket = ticket.concat(print_body(items, total));

		ticket = ticket.concat(print_footer());

		qz.print(config, ticket).catch(function(e) { console.error(e); });
		

	});






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

