$(function(){
  $('#dashboard-page .overlay-add-course').on('click', dashboardCourses.addCourse);
  $('#dashboard-page .overlay-remove-course').on('click', dashboardCourses.removeCourse);
  $('#dashboard-page .favorite-course').on('click', dashboardCourses.favoriteCourse);
  $('#dashboard-page .unfavorite-course').on('click', dashboardCourses.unfavoriteCourse);
  $('#dashboard-page .complete-course').on('click', dashboardCourses.completeCourse);
  $('#dashboard-page .uncomplete-course').on('click', dashboardCourses.uncompleteCourse);
  dashboardCourses.uncompleteCourse
});

var dashboardCourses = (function() {

  function _appendCourse(course, school) {
    var courseTemplate = $('.dashboard-course-template').clone()
    courseTemplate.attr('data-course-id', course.id)
    courseTemplate.find('img').attr('src', course.course_img_url)
    courseTemplate.find('a').attr('href', course.course_url)
    courseTemplate.find('.course-description a').append(course.title.slice(0, 36))
    courseTemplate.find('.course-description p').append(school.name.slice(0, 39))
    if (course.start_date === null) {
      courseTemplate.find('.course-description .date-display').text("Start Date: TBD")
    } else {
      courseTemplate.find('.course-description .date-display').text("Start Date: " + course.start_date)
    }
    return courseTemplate
  }

  return {
    addCourse: function() {
      var courseID = $(this).attr('data-course-id')
      $.get('/courses/' + courseID, function(data) {
        var courses = data.shift()
        var schools = data.pop()
        var formattedCourse = _appendCourse(courses, schools)
        $('#current-courses').append(formattedCourse.attr('class', 'course'))
      })
    },

    removeCourse: function() {
      $('#current-courses').find("[data-course-id='" + $(this).attr('data-course-id') + "']").remove();
      if ($('#current-courses').children().size() === 0){
        $('#current-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
      };

      $('#favorite-courses').find("[data-course-id='" + $(this).attr('data-course-id') + "']").remove();
      if ($('#favorite-courses').children().size() === 0){
        $('#favorite-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
      };

      $('#complete-courses').find("[data-course-id='" + $(this).attr('data-course-id') + "']").remove();
      if ($('#complete-courses').children().size() === 0){
        $('#complete-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
      };
    },

    favoriteCourse: function() {
      var courseID = $(this).attr('data-course-id')
      $.get('/courses/' + courseID, function(data) {
        var courses = data.shift()
        var schools = data.pop()
        var formattedCourse = _appendCourse(courses, schools)
        $('#favorite-courses').append(formattedCourse.attr('class', 'course'))
        if ($('#favorite-courses').children().size() === 0){
          $('#favorite-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
        } else {
          $('#favorite-courses .dashboard-message').remove();
        };
      })
    },

    unfavoriteCourse: function() {
      $('#favorite-courses').find("[data-course-id='" + $(this).attr('data-course-id') + "']").remove();
      if ($('#favorite-courses').children().size() === 0){
        $('#favorite-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
      } else {
        $('#favorite-courses .dashboard-message').remove();
      };
    },

    completeCourse: function() {
      $('#current-courses').find("[data-course-id='" + $(this).attr('data-course-id') + "']").remove();
      var courseID = $(this).attr('data-course-id')
      $.ajax({
        url: '/courses/' + courseID,
        method: 'GET',
        data: {"course_id": courseID},
      }).done(function(data) {
        var courses = data.shift()
        var schools = data.pop()
        var formattedCourse = _appendCourse(courses, schools)
        $('#complete-courses').append(formattedCourse.attr('class', 'course'))
        if ($('#current-courses').children().size() === 0){
          $('#current-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
        };
        if ($('#complete-courses').children().size() === 0){
          $('#complete-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
        } else {
          $('#complete-courses .dashboard-message').remove();
        };
      })
    },

    uncompleteCourse: function() {
      $('#complete-courses').find("[data-course-id='" + $(this).attr('data-course-id') + "']").remove();
      var courseID = $(this).attr('data-course-id')
      $.ajax({
        url: '/courses/' + courseID,
        method: 'GET',
        data: {"course_id": courseID},
      }).done(function(data) {
        var courses = data.shift()
        var schools = data.pop()
        var formattedCourse = _appendCourse(courses, schools)
        $('#current-courses').append(formattedCourse.attr('class', 'course'))
        if ($('#complete-courses').children().size() === 0){
          $('#complete-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
        } else {
          $('#complete-courses .dashboard-message').remove();
        };

        if ($('#current-courses').children().size() === 0){
          $('#current-courses').append('<div class="dashboard-message"><h3>You have not completed any courses.</h3></div>');
        } else {
          $('#current-courses .dashboard-message').remove();
        };
      })
    }
  }
})();