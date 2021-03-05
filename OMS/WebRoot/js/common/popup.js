openPop = function(id, options){
	$("#" + id).dialog(options);
	$(".ui-dialog-buttonset").children().each(function (index, dom){
		$(dom).removeClass("ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only");
		$(dom).unbind("mousedown").unbind("mouseenter").unbind("mouseleave");
	});
}

closePop = function(id){
	$("#" + id).dialog("close");
}