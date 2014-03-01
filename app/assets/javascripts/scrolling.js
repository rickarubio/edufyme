$(function() {
	infiniteScroll.scrollEvent();
});

var infiniteScroll = (function() {

	function scrollEvent() {
		$(window).on('scroll', function() {
			if ($(window).scrollTop() == $(document).height() - $(window).height()) {
				console.log("hello")
				$('#load-ajax').show();
				$.ajax({
					type: 'GET',
					url: '/'
				})
				.done(function(serverResponse) {
					console.log(serverResponse)
					$(".courses-container").append(serverResponse)
					$('#load-ajax').hide()
				})
				.fail(function(xhr) {
					console.log(xhr)
				})
			}
		})
	}

	return {
		scrollEvent: scrollEvent
	}

}());