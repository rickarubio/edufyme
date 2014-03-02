$(function() {
	infiniteScroll.scrollEvent();
});

var infiniteScroll = (function() {

	function scrollEvent() {
		$(window).on('scroll', function() {
			if ($(window).scrollTop() == $(document).height() - $(window).height()) {
				$('#load-ajax').show();
				$.ajax({
					type: 'GET',
					url: '/'
				})
				.done(function(data) {
					var courses = data.shift()
					var schools = data.pop()
					for (var i = 0; i < courses.length; i++) {
						var formattedCourse = scrollFormat(courses[i], schools[i])
						$('.courses-container').append(formattedCourse.attr('class', 'course'))
					}
					$('#load-ajax').hide()
				})
				.fail(function(xhr) {
					console.log(xhr)
				})
			}
		})
	}

	function scrollFormat(course, school) {
		var $courseTemplate = $('.course-template').clone()
		$courseTemplate.attr('data-course-id', course.id)
		$courseTemplate.find('img').attr('src', course.course_img_url)
		$courseTemplate.find('a').attr('href', course.course_url)
		$courseTemplate.find('.course-description a').append(course.title.slice(1, 36))
		$courseTemplate.find('.course-description p').append(school)
		$courseTemplate.find('.course-description .date-display').text("Start Date: " + course.start_date)
		return $courseTemplate
	}

	return {
		scrollEvent: scrollEvent
	}

}());