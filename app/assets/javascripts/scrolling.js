$(function() {
	$.ajaxSetup({ cache: false });
	infiniteScroll.scrollEvent();
});

var infiniteScroll = (function() {
	var is_loading = false
	function _scrollEvent() {
		$(window).on('scroll', function() {
			if ($(window).scrollTop() == $(document).height() - $(window).height()) {
				if (is_loading) {
					return;
				}
				is_loading = true;
				$('#load-ajax').show();
				$.get('/', function(data) {
					var courses = data.shift()
					var schools = data.pop()
					for (var i = 0; i < courses.length; i++) {
						var formattedCourse = scrollFormat(courses[i], schools[i])
						$('.courses-container').append(formattedCourse.attr('class', 'course'))
					}
					$('#load-ajax').hide()
				}).always(function() { is_loading = false; });
			}
		})
	}

	function scrollFormat(course, school) {
		var $courseTemplate = $('.course-template').clone()
		$courseTemplate.attr('data-course-id', course.id)
		$courseTemplate.find('img').attr('src', course.course_img_url)
		$courseTemplate.find('a').attr('href', course.course_url)
		$courseTemplate.find('.course-description a').append(course.title.slice(0, 36))
		$courseTemplate.find('.course-description p').append(school)
		if (course.start_date === null) {
			$courseTemplate.find('.course-description .date-display').text("Start Date: TBD")
		} else {
			$courseTemplate.find('.course-description .date-display').text("Start Date: " + course.start_date)
		}
		return $courseTemplate
	}

	return {
		scrollEvent: _scrollEvent
	}

}());