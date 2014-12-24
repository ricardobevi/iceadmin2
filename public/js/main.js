$(document).ready(function(){
	$("#container").load( ticketUrl );
	$.getScript(ticketJSUrl);
});


$('#ticket').click(function(){
	$("#ticket").addClass("active");
	$("#ticket").removeClass("inactive");
	
	$("#report").addClass("inactive");
	$("#report").removeClass("active");
	
	$("#container").load( ticketUrl );
	$.getScript(ticketJSUrl);
});

$('#report').click(function(){
	$("#ticket").addClass("inactive");
	$("#ticket").removeClass("active");
	
	$("#report").addClass("active");
	$("#report").removeClass("inactive");
	
	$("#container").load( reporttUrl );
});
