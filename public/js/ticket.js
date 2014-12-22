
function add_product(productId, quantity){
	$("#ticket_list").load( ticketListUrl + "/add_product/" + productId + "/" + quantity );
}

function del_product(productId){
	
}



$(document).keydown(function(event) {
	
	if ( _DEBUG ) $("#debug").text( event.keyCode );
	
	switch(event.keyCode){
		case 17:
			$("#quick_access").load( quickAccessUrl + "/group/2" );
			break;	
	}
});

$(document).keyup(function(event) {
	if ( _DEBUG ) $("#debug").text( "" );
	switch(event.keyCode){
		case 17:
			$("#quick_access").load( quickAccessUrl );
			break;
	}
});

$(document).keydown(function(e) {
    if (e.ctrlKey && e.which == 13) {
    	if ( _DEBUG ) $("#debug").text( "toque" );
    }
});


$(document).on("click", '.quickaccess', function(event) { 
	if ( _DEBUG ) $("#debug").text( $(this).attr('productid') );
	add_product($(this).attr('productid'), 1);
});

