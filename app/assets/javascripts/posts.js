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

		  	if( data.type == 'Note'){
		  		$('#n_rem_count').text($('#n_rem_count').text().trim() - 1)
		  	}
		  	else if( data.type == 'Debate'){
		  		$('#d_rem_count').text($('#d_rem_count').text().trim() - 1)		
		  	}
		  	else{
		  		$('#q_rem_count').text($('#q_rem_count').text().trim() - 1)
		  	}
		  }
		}).on('ajax:error', '#token_form', function(e, data, status, xhr){
		  console.log('Great failure');
	});
		



// js for the show page.

function tokenize_body(){
  $('.post-body > p').each( 
    function(i,e){ 
      // add tag index
      $(e).attr('tag-index',i)
      // add sentense index
      e.innerHTML = e.innerHTML.split(' ').map(function(x,ii){ return( 
        "<span id='"+i+"-"+ii+"' class='tokenable'>"+x+"</span>"
        )  }).join(' ')
    })
}

tokenize_body();

$('.rating').on('click',function(e){
  scount = $(e.currentTarget).data("sindex")
  $(".rate_count").text(scount)
  $("#score").val(scount)
  $("#rate-post").modal("show")
})
$('.rating').css('cursor','pointer')


$( ".token" ).draggable({
  helper: "clone",
  start: function( event, ui ) {
  	if ( $(event.currentTarget).next('span').text().trim() == 0){
  		$(event.currentTarget).css('cursor' , 'not-allowed')
  		return false;
  	}
  }
})

$( ".tokenable" ).droppable({
  accept: ".token",
  drop: function( event, ui ) {
      draged = $(ui.draggable[0]);
      drop_target = $(event.target);
      $('#token_type').val(draged.data('type')).change();
      $('#add-token').modal('show');
      $('#tkntype').val(draged.data('type'))
      $('#span_id').val(drop_target.attr("id"))

    }
});


$(".vote").on("click",function(e) {
    e.preventDefault(); // cancel the link itself
    $.get(this.href , function(){
    	console.log("added....")
    	window.location.reload()
    });
  });




});