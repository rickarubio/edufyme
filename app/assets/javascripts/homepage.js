$(document).ready(function(){
  bindEvents();
  $('#loginmodaltrigger').leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
  $('#signupmodaltrigger').leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
})


var bindEvents = function() {
  $('.courses-container').on('click', '.course', function(e) {
    e.preventDefault();
    Overlay.display();
    Overlay.requestCourseInfo(this);
  }),

  $('.overlay').on('click', function(e){
    e.preventDefault();
    Overlay.hide();
  })

  // $("#modaltrigger").on('click', function(e) {
  //   e.preventDefault();
  //   $(this).leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
  // })
}

var Overlay = (function() {
  //private _methods and _vars
  // options =  $.extend(defaults, options);
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
  return {
    // var o = options;
    display: function() {
      $('.overlay').css('display', 'block');
      // $('.overlay').fadeTo(3000, 0.0);
      $('.modal').css('display', 'block');
      // $('.modal').fadeTo(3000, 0.0);
    },

    hide: function(){
     $('.overlay').fadeOut(300);
     $('.modal').fadeOut(300);
     // $('.overlay').css('display', 'none');
     // $('.modal').css('display', 'none');
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
