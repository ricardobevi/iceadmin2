
$('#container').ready(function(){
	$("#quick_access").load( quickAccessUrl );
	$("#ticket_list").load( ticketListUrl );
});

function add_product(productId, quantity){
	$("#ticket_list").load( ticketListUrl + "/add_product/" + productId + "/" + quantity );
}


function mod_product(productId, quantity){
	$("#ticket_list").load( ticketListUrl + "/mod_product/" + productId + "/" + quantity  );
}

function close_ticket(){
	$("#ticket_list").load( ticketListUrl + "/close" );
}

/***************************************************************************
* Prototype function for printing raw ESC/POS commands
* Usage:
*    qz.append('\n\n\nHello world!\n');
*    qz.print();
***************************************************************************/
function printESCP() {
    
    
    // Append a png in ESCP format with single pixel density
    //qz.appendImage(getPath() + "img/image_sample_bw2.png", "ESCP", "double");
    
    //qz.appendImage(getPath() + "img/image_sample_bw2.png", "ESCP", "simple");
    
    // Automatically gets called when "qz.appendImage()" is finished.
    window["qzDoneAppending"] = function() {
    
        qz.appendHex("x1Bx40");
    
        qz.appendHex("x48x6Fx6Cx61");
        qz.appendHex("x0Dx0A");
        
        qz.appendHex("x1Bx21x00");
        qz.appendHex("x1Bx21x30"); 
        qz.appendHex("x48x6Fx6Cx61");
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

function print_ticket(){
	
	if (notReady()) { return; }

	$.getJSON( ticketListUrl + "/json_print", function( data ) {
		var items = [];
		$.each( data, function( key, val ) {
			items.push( "<li>" + val.name + " " + val.qty + " " + val.subtotal + "</li>" );
		});
		
		$( "<ul/>", {
		"class": "my-new-list",
		html: items.join( "" )
		}).appendTo( "body" );
		
		printESCP();
		
	});
	
}

var down = {};
down['ctrl'] = 1;

$(document).keydown(function(event) {
	
	//if ( _DEBUG ) $("#debug").text( event.keyCode );
	
	switch(event.keyCode){
		case 17:
			$("#quick_access_group_1").addClass("collapse");
			$("#quick_access_group_2").removeClass("collapse");
			break;	
	}
	
	
    if (event.ctrlKey && event.which == 13 && down['ctrl'] != null) {
    	down['ctrl'] = null;
    	
    	print_ticket();
    	close_ticket();
    	
    	if ( _DEBUG ) $("#debug").text( $("#debug").text() + " cierre_ticket" );
    }
	
});


$(document).keyup(function(event) {
	//if ( _DEBUG ) $("#debug").text( "" );
	switch(event.keyCode){
		case 17:
			$("#quick_access_group_2").addClass("collapse");
			$("#quick_access_group_1").removeClass("collapse");
			down['ctrl'] = 1;
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

