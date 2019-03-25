$(document).ready(function(){
	$('#layer_sel').on("change",function(e){ 
		window.location = $(e.currentTarget).val()
	})


	$('.post-body > p').on('click', function(e) {
		//var selection = window.getSelection() || document.getSelection() || document.selection.createRange();
        //var word = $.trim(selection);
        //console.log(word)
        console.log($(this).text())
	})



})