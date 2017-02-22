(function($){	

$("tr").hover(function() {
		$(this).addClass("greenBackground");
	},function(){$(this).removeClass("greenBackground");});
})(jQuery);