$(document).ready(function(){
	// Convert Sheetsu to JSON
	$('.pdf').click( function(e) {
		
		var table = $('#invoices').tableToJSON();
		console.log(JSON.stringify(table[0]));
		var data = table[0];
		
		// AJAX each PDF
		$.ajax({
		    dataType: "json",
		    url: "/visitors",
		    type: "post",
		    data: { "invoice" : data },
		    success: function(json) {
		    	console.log(data);	
		    }
		});
	});

	// Jquery TableSorter
	$("#invoices").tablesorter(); 
	// Should call after every ajax or page refresh



});


