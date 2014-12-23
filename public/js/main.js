$(document).ready(function(){
	$("#quick_access").load( quickAccessUrl );
	$("#ticket_list").load( ticketListUrl );
	$.getScript(ticketJSUrl);
});


