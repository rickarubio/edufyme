$(document).ready(function(){
  bindEvents();
})


bindEvents = function() {
  $('.courses-container').on('click', '.course', function(e) {
    e.preventDefault();
    Overlay.display();
    Overlay.requestCourseInfo(this);
  }),

  $('.exit-modal').on('click', function(e){
    e.preventDefault();
    Overlay.hide();
  })
}

var Overlay = (function() {
  //private _methods and _vars
  var _populateCourseInfo = function(course) {
    $('.overlay-course-title').text(course.title);
    $('.modal img').attr('src', course.course_img_url);
    $('.modal a').attr('href', course.course_url);
    $('.modal a').text(course.title);
    $('.overlay-course-description').text(course.description);
    $('.overlay-ratings').text("Ratings");
    $('.overlay-prerequisites').text("Prerequisites");
    $('.overlay-teacher img').attr('src', 'http://www.biography.com/imported/images/Biography/Images/Profiles/T/Mark-Twain-9512564-1-402.jpg');
    $('.overlay-teacher-bio').text('Insert Teacher Bio Here!' + course.description);
  }
  return {
    display: function() {
      $('.overlay').css('display', 'block');
      $('.modal').css('display', 'block');
    },

    hide: function(){
     $('.overlay').css('display', 'none');
     $('.modal').css('display', 'none');
    },

    requestCourseInfo: function(course) {
      var course_id = $(course).attr('data-course-id');
      $.ajax({
        url: '/courses/' + course_id
      }).done(function(course){
        _populateCourseInfo(course);
      }).fail(function(){
        alert('failed');
      })
    }
  }

}());
