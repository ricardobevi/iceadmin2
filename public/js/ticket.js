// TODO: mandar a un util.js
String.prototype.hexEncode = function(){
    var hex, i;

    var result = "";
    for (i=0; i<this.length; i++) {
        hex = this.charCodeAt(i).toString(16);
        result += ("x"+hex).slice(-4);
    }

    return result
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


function printESCP() {
        
    // Append a png in ESCP format with single pixel density
    //qz.appendImage(getPath() + "img/image_sample_bw2.png", "ESCP", "double");

    qz.appendImage(ticketNumberImgUrl + "/print_number/" + 999, "ESCP", "simple");
    
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

function print_header( number ){}

function print_body( items ){}

function print_footer(){}


function print_ticket(){
	
	if (notReady()) { return; }

	$.getJSON( ticketListUrl + "/json_print", function( data ) {
		var items = [];

		$.each( data, function( key, val ) {
			items.push( "<li>" + val.name + " " + val.qty + " " + val.subtotal + "</li>" );
		});
		
		
		printESCP();
		
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

