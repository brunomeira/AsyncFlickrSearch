var ajax = "";
$(document).ready(function() {
	bindFormEvent();
	$("body").attr("page", 1);
	returnImages(1, "");
	startScroll();
});
function bindFormEvent() {
	$("#searchForm").bind("ajax:beforeSend", function(jqXHR, settings) {
		$("#imagesArea").fadeOut("slow");
		$("#loadingArea").fadeIn("slow");
		$("#imagesArea").empty();
	}).bind("ajax:success", function(evt, results, status) {
		$(results).each(function(index, element) {
			$("#imagesArea").append(mountImageDiv(element.title, element.url));
		});
		$("#imagesArea").fadeIn("slow");
		$("#loadingArea").fadeOut("slow");
		$("body").attr("page", 2);
	});
}

function returnImages(page, query) {
	$("#loadingArea").fadeIn("slow");
	var screen_name = 'tableless';
	var url = '/search';

	$('body').data('attr', page + 1);
	ajax = $.getJSON(url, {
		q : query,
		page : page
	}, function(results) {
		$(results).each(function(index, element) {
			$("#imagesArea").append(mountImageDiv(element.title, element.url));
		});
		$("#loadingArea").fadeOut("slow");
		startScroll();
	});
}

function startScroll() {
	$(window).scroll(function() {
		if(($(window).scrollTop() + $(window).height() + 20) >= $(document).height()) {
			$(window).unbind('scroll');
			ajax.abort();
			returnImages($('body').data('page'));
		}
	});
}

function mountImageDiv(title, url) {
	html = "<div style=\"display: inline; margin:20px;\">"
	html += "<img src=\"" + url + "\"\>"
	html += "</div>"
	return html;
}