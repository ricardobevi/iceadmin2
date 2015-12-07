// TODO: mandar a un util.js


function formatCurrency(number){
	var ret = "$" + $.number( number , 2, ',' );
	return ret;
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


function printESCP(ticketNumber) {
        
    // Append a png in ESCP format with single pixel density
    //qz.appendImage(getPath() + "img/image_sample_bw2.png", "ESCP", "double");

    qz.appendImage(ticketNumberImgUrl + "/print_number/" + ticketNumber, "ESCP", "simple");
    
    // Automatically gets called when "qz.appendImage()" is finished.
    window["qzDoneAppending"] = function() {

    
        qz.appendHex("x1Bx40");

        qz.append("lala ");

        qz.appendHex("xA4");
        
        qz.appendHex("x0Dx0A");
        
        qz.appendHex("x1Bx21x00");
        qz.appendHex("x1Bx21x30"); 
        //qz.appendHex("x48x6Fx6Cx61");
        qz.append("lala" + '\xA4');
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
        qz.appendHex("x0Dx0A");
    
        // Tell the apple to print.
        qz.print();
            
        // Remove any reference to this function
        window['qzDoneAppending'] = null;
    };
    

}

function print_header( ticketNumber ){
	
    qz.appendImage(ticketNumberImgUrl + "/print_number/" + ticketNumber, "ESCP", "simple");
	
}

function print_body( items, total ){
	
	total = formatCurrency(total);
	
    qz.appendHex("x1Bx40"); // start printer
    
    for ( i = 0 ; i < items.length ; i++ ) {
    	var item = items[i];
    	
    	qz.append(item.qty + " " + item.name + " " + formatCurrency( item.subtotal ) );
    	qz.appendHex("x0Dx0A"); //newline
    }
        
    // change text size
    /*
    qz.appendHex("x1Bx21x00");
    qz.appendHex("x1Bx21x30");
      */  
    
    qz.append("lala");
    qz.appendHex("x0Dx0A"); //newline
    
    qz.appendHex("x1Bx21x30");
    
    qz.append("Total: " + total);
    qz.appendHex("x0Dx0A"); //newline
    
    qz.appendHex("x1Bx21x00");
    
    qz.append("Total: " + total);
    
    
    qz.append("\n1234567890123456789012345678901234567890");
	
}

function print_footer(){
	
	
	qz.appendHex("x0Dx0Ax0Dx0Ax0Dx0Ax0Dx0Ax0Dx0Ax0Dx0A");
}


function print_ticket(){
	
	if (notReady()) { return; }
	

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
		
		
		Cookies.set("ticket_number", "001", { expires: 7 });
		
		var ticketNumber = Cookies.get("ticket_number");
		
		print_header(ticketNumber);
		
		window["qzDoneAppending"] = function() {
			
			print_body( items, total );
			print_footer();
			
		    // Tell the apple to print.
		    qz.print();
		    
		    // Remove any reference to this function
		    window['qzDoneAppending'] = null;
		};

	});
	
}

var down = {};
down['ctrl'] = 0;

$(document).keydown(function(event) {

    if ( _DEBUG ) $("#debug").text( "DOWN " + event.keyCode );
	
    switch( event.keyCode ){
        case 17:
            $("#quick_access_group_1").addClass("collapse");
            $("#quick_access_group_2").removeClass("collapse");
            break;


    }
	
	
    if ( event.ctrlKey ) {

        switch(event.which){
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

