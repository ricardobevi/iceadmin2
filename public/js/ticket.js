
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

function print_ticket(){

	$.getJSON( ticketListUrl + "/json_print", function( data ) {
		var items = [];
		$.each( data, function( key, val ) {
		items.push( "<li>" + val.name + " " + val.qty + " " + val.subtotal + "</li>" );
		});
		$( "<ul/>", {
		"class": "my-new-list",
		html: items.join( "" )
		}).appendTo( "body" );
		});
	
}

var down = {};
down['ctrl'] = 1;

$(document).keydown(function(event) {
	
	//if ( _DEBUG ) $("#debug").text( event.keyCode );
	
	switch(event.keyCode){
		case 17:
			$("#quick_access").load( quickAccessUrl + "/group/2" );
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
			$("#quick_access").load( quickAccessUrl );
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

