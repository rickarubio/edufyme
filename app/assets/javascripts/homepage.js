$(function() {
  bindEvents();
})

var bindEvents = function() {

  $('#loginmodaltrigger').leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
  $('#signupmodaltrigger').leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
  $('.courses-container').on('click', '.course', function(e) {
    e.preventDefault();
    Overlay.display();
    Overlay.requestCourseInfo(this);
  }),

  $('.overlay').on('click', function(e){
    e.preventDefault();
    Overlay.hide();
  }),

  //BUG: do this for particular course, not all at once

  $('.course').hover(function(e){
    e.preventDefault();
    // console.log('hereee')
    //make star appear where course.id = course.data
    $('.star').fadeTo(30, 1.0);
  }, function() {
    $('.star').fadeOut(30);
  })

  // $("#modaltrigger").on('click', function(e) {
  //   e.preventDefault();
  //   $(this).leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
  // })
}

var Overlay = (function() {

  var _populateCourseInfo = function(course) {
    $('.overlay-course-title').text(course.title);
    $('.modal img').attr('src', course.course_img_url);
    $('.modal a').attr('href', course.course_url);
    $('.modal a').text(course.title);
    $('.overlay-course-description').text(course.description);
    $('.overlay-ratings p').text("Ratings");
    $('.overlay-prerequisites p').text("Prerequisites");
    $('.overlay-teacher img').attr('src', 'http://www.biography.com/imported/images/Biography/Images/Profiles/T/Mark-Twain-9512564-1-402.jpg');
    $('.overlay-teacher-bio').text('Insert Teacher Bio Here!' + course.description.slice(1, 450) + '...');
  }

  var _display = function() {
    $('.overlay').fadeTo(300, 0.5);
    $('.modal').fadeTo(300, 1.0);
  }

  var _hide = function() {
     $('.overlay').fadeOut(300);
     $('.modal').fadeOut(300);
  }

  var _requestCourseInfo = function(course) {
    var course_id = $(course).attr('data-course-id');
    $.ajax({
      url: '/courses/' + course_id
    }).done(function(course){
      _populateCourseInfo(course);
    }).fail(function(){
      alert('failed');
    })
  }

  return {
    display: _display,
    hide: _hide,
    requestCourseInfo: _requestCourseInfo
  }

}());
