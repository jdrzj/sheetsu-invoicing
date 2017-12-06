$(document).ready(function(){
	// Convert Sheetsu to JSON
	$('#convert-table').click( function() {
	  var table = $('#invoices').tableToJSON();
	  console.log(JSON.stringify(table[0]));
	  var data = table[0];
		
		// AJAX each PDF
		$.ajax({
		    dataType: "json",
		    url: "/visitors/sendinvoice",
		    type: "post",
		    data: { "invoice" : data },
		    success: function(json) {
		    	alert('successfully');	
		    }
		});
	});

	// Jquery TableSorter
	$("#invoices").tablesorter(); 
	// Should call after every ajax or page refresh



});


