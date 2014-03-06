$(document).ready(function(){
  Search.bindEvents();
});

var Search = (function(){
  // _private
  return {
    bindEvents: function() {
      $('.search input').on('focus', function() {
        // console.log('search bar has focus');
      });

      $('.search input').on('focusout', function() {
        Search.clearSearch();
      });

      $('.search input').on('keyup', function(e) {
        var enterKeyCode = 13;
        if (e.keyCode === enterKeyCode) {
          var searchTerms = $('.search input').val();
          Search.submitQuery(searchTerms);
          Search.clearSearch();
        }
      });
    },

    clearSearch: function() {
      $('.search input').val("");
    },

    emptyCourseContainer: function() {
      $('div.courses-container').empty();
      $('.featured-courses-title h3').text("Search Results");
    },

    appendResults: function(data) {
      // unbind infinite scrolling
      $(window).off('scroll');
      // build a course card
      var $courseTemplate;
      $.each(data, function(idx, course){
        $courseTemplate = $('.course-template').clone();
        $courseTemplate.attr('data-course-id', course.id);
        $courseTemplate.find('img').attr('src', course.course_img_url);
        $courseTemplate.find('a').attr('href', course.course_url);
        $courseTemplate.find('.course-description a').append(course.title.slice(0, 36));
        // $courseTemplate.find('.course-description p').append(school.slice(0, 39));
        if (course.start_date === null) {
          $courseTemplate.find('.course-description .date-display').text("Start Date: Self-Paced")
        } else {
          $courseTemplate.find('.course-description .date-display').text("Start Date: " + course.start_date)
        }
        // coursetemplate should now be appended into container
        $('.courses-container').append($courseTemplate.attr('class', 'course'));
      });
      return $courseTemplate
    },

    submitQuery: function(searchTerms) {
      $.ajax({
        url: "/courses/search/" + searchTerms
      }).done(function(data) {
        Search.emptyCourseContainer();
        Search.appendResults(data);
      }).fail(function(data) {
        console.log('sending search query failed');
      });
    }
  }
})();