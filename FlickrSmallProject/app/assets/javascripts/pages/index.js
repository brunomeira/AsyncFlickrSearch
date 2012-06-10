var ajax = "";
$(document).ready(function() {
	bindFormEvent();
	$("body").attr("page", 1);
	returnImages(1, "");
	startScroll();
});
function bindFormEvent() {
	var showLoad;
	$(".btn").click(function() {
		$("#imagesArea").empty();
		returnImages(1, $("#q").val());
		return false;
	});
}

function returnImages(page, query) {
	$("#loadingArea").fadeIn("slow");
	var url = '/search';
	var backRequests = 0;
	var numberOfRequests = 0;
	var valueOnSearchBox = $("#q").val();
	while(numberOfRequests < 5) {
		disableFields();
		$('body').attr('page', page++);
		ajax = $.getJSON(url, {
			q : query,
			page : page
		}, function(results) {
			$(results).each(function(index, element) {
				$("#imagesArea").append(mountImageDiv(element.title, element.url));
			});
			backRequests++;
			if(backRequests == 5) {
				$("#loadingArea").fadeOut("slow");
				startScroll();
				
				enableFields(valueOnSearchBox);
			}
		});
		numberOfRequests++;
	}
}

function disableFields(){
	$("#q").attr('disabled','disabled');
	$("#q").val("Wait until all 10 images are retrieved");
	$(".btn").attr("disabled", true);
}

function enableFields(searchText){
	$("#q").val(searchText);
	$("#q").removeAttr('disabled');	
	$(".btn").attr("disabled", false);
}

function startScroll() {
	$(window).scroll(function() {
		if(($(window).scrollTop() + $(window).height() + 20) >= $(document).height()) {
			$(window).unbind('scroll');
			ajax.abort();
			returnImages($('body').attr('page'), $("#q").val());
		}
	});
}

function mountImageDiv(title, url) {
	html = "<div style=\"display: inline; margin:20px;\">"
	html += "<img src=\"" + url + "\"  style=\"padding:5px;border:1px solid #021a40;\" title='"+title+"'\>"
	html += "</div>"
	return html;
}