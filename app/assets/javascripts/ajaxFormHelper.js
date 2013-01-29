function submitFormViaAjax(formTagID, showTagID, buildActionURL){
	

		// get form and bind submit action
	$('#'+formTagID).submit(function() {
			// modify form action
		buildActionURL($(this));

		$('#'+formTagID+' select').prop("disabled", true);
		$('#'+formTagID).siblings('form').children('select').prop("disabled", true);

		$('#'+showTagID).empty();
		$('#'+showTagID).append('<img src="/assets/ajax-loader.gif" id="ajaxLoad" />');

		var container = $('#'+showTagID);

		// console.log($(this).unbind('submit'));
		// unbind submit action and execute ajaxcall
		$(this).unbind('submit').ajaxSubmit({
								              success: function(data) {
										                     container.html(data);
								              				 $("#ajaxLoad").remove();
								              				 $('#'+formTagID+' select').prop("disabled", false);
								              				 $('#'+formTagID).siblings('form').children('select').prop("disabled", false);
										                     submitFormViaAjax(formTagID, showTagID, buildActionURL);
								              			},
								              error: function(jqXHR, textStatus, errorThrown){
											              	 container.html("An error ( "+errorThrown+" ) has occured! Text status: "+textStatus);
											              	 $("#ajaxLoad").remove();
								              				 $('#'+formTagID+' select').prop("disabled", false);
								              				 $('#'+formTagID).siblings('form').children('select').prop("disabled", false);
										                     submitFormViaAjax(formTagID, showTagID, buildActionURL);
								              }
								            })
	    return false
	});
}

