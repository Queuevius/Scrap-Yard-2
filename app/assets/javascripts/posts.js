$(document).on('turbolinks:load', function(){
	
	// hide tinymce footer
	setTimeout(function(){$('div.tox-statusbar').hide();},500);	


	$('#layer_sel').on("change",function(e){ 

		

		window.location = $(e.currentTarget).val()
	


	})

  $('#token_type').on("change",function(e){ 
    switch( $(e.currentTarget).val() ){
    	case "Note":
    		$("#tkn-info").text("Give the details of the Note token.")
    		$('#tkntype').val($(e.currentTarget).val());
    		break;
    	case "Debate":
    		$("#tkn-info").text("State the central argument of the Debate!")
    		$('#tkntype').val($(e.currentTarget).val());
    		break;
    	case "Question":
    		$("#tkn-info").text("What Question do have in mind?")
    		$('#tkntype').val($(e.currentTarget).val());
    		break;
    	default:
    		$("#tkn-info").text("Give the details of the Note token.")
    		$('#tkntype').val($(e.currentTarget).val());
    		break;
    }

  })

  
  function add_token(type , span_id, token_path){
  	$('#'+span_id).after("<span class='tkn-n'><a href='"+ token_path +"'><strong>"+type+"</strong></a></span>");
  }

  $('body').on('ajax:success', '#token_form', function(e, data, status, xhr){
		  if( data.add_token ){
		  	add_token( data.type[0] , data.span_id , data.token_path )  	
		  	$('#add-token').modal('hide');
		  }
		}).on('ajax:error', '#token_form', function(e, data, status, xhr){
		  console.log('Great failure');
	});
		

})