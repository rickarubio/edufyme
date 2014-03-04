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
    $('#school img').attr('src', '');
  }),

  //BUG: do this for particular course, not all at once

  $('.course').hover(function(e){
    e.preventDefault();
    // console.log('hereee')
    //make favorite appear where course.id = course.data
    $('.favorite').fadeTo(30, 1.0);
  }, function() {
    $('.favorite').fadeOut(30);
  })

  // $("#modaltrigger").on('click', function(e) {
  //   e.preventDefault();
  //   $(this).leanModal({ top: 110, overlay: 0.45, closeButton: ".hidemodal" });
  // })
}

var Overlay = (function() {

  var _populateCourseInfo = function(course, school) {
    $('.overlay-add-course').attr('data-course-id', course.id);
    $('.overlay-remove-course').attr('data-course-id', course.id);
    var addedCourseIDs = $('#current-user-added-classes').attr('data-added-course-ids')
    if ($('#current-user-added-classes').attr('data-added-course-ids') === undefined){
      var addedCourseIDs = " "
    } else {
      var addedCourseIDs = $('#current-user-added-classes').attr('data-added-course-ids')
    };
    var courseArray = addedCourseIDs.replace("[", "");
    courseArray = courseArray.replace("]", "");
    courseArray = courseArray.split(", ");
    if ($.inArray((course.id).toString(), courseArray) === -1 ){
      $('.overlay-remove-course').css('display', 'none');
      $('.overlay-add-course').css('display', 'inherit');
      $('.favorite-course').attr('disabled', 'disabled');
      $('.complete-course').attr('disabled', 'disabled');
    } else {
      $('.overlay-add-course').css('display', 'none');
      $('.overlay-remove-course').css('display', 'inherit');
      $('.favorite-course').removeAttr('disabled');
      $('.complete-course').removeAttr('disabled');
    };

    var favoritedCourseIDs = $('#current-user-favorited-classes').attr('data-favorited-course-ids')
    if ($('#current-user-favorited-classes').attr('data-favorited-course-ids') === undefined){
      var favoritedCourseIDs = " "
    } else {
      var favoritedCourseIDs = $('#current-user-favorited-classes').attr('data-favorited-course-ids')
    };
    var favoritedArray = favoritedCourseIDs.replace("[", "");
    favoritedArray = favoritedArray.replace("]", "");
    favoritedArray = favoritedArray.split(", ");
    if ($.inArray((course.id).toString(), favoritedArray) === -1){
      $('.unfavorite-course').css('display', 'none');
      $('.favorite-course').css('display', 'inherit');
    } else {
      $('.favorite-course').css('display', 'none');
      $('.unfavorite-course').css('display', 'inherit');
    };

    $('.favorite-course').attr('data-course-id', course.id);
    $('.unfavorite-course').attr('data-course-id', course.id);

    var completedCourseIDs = $('#current-user-completed-classes').attr('data-completed-course-ids')
    if ($('#current-user-completed-classes').attr('data-completed-course-ids') === undefined){
      var completedCourseIDs = " "
    } else {
      var completedCourseIDs = $('#current-user-completed-classes').attr('data-completed-course-ids')
    };
    var completedArray = completedCourseIDs.replace("[", "");
    completedArray = completedArray.replace("]", "");
    completedArray = completedArray.split(", ");
    if ($.inArray((course.id).toString(), completedArray) === -1){
      $('.uncomplete-course').css('display', 'none');
      $('.complete-course').css('display', 'inherit');
    } else {
      $('.complete-course').css('display', 'none');
      $('.uncomplete-course').css('display', 'inherit');
    };

    $('.complete-course').attr('data-course-id', course.id);
    $('.uncomplete-course').attr('data-course-id', course.id);
    $('.overlay-course-title').text(course.title);
    $('.course-image').attr('src', course.course_img_url);
    if (school.school_img_url === "") {
      $('#school img').attr('src', "/images/default-school.jpg" );
    } else {
      $('#school img').attr('src', school.school_img_url );
    }
    $('.modal a').attr('href', course.course_url);
    $('.modal a').text(course.title);
    $('.overlay-course-description').text(course.description);
    if (course.teachers === null || course.teachers === "") {
      $('.teachers p').text("Instructors Not Yet Assigned")
    } else {
      $('.teachers p').text(course.teachers);
    }
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
    }).done(function(data){
      course = data[0]
      school = data[1]
      _populateCourseInfo(course, school);
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

var disableDeviseLoginLogout = (function() {
  // _private vars and _functions
  return {

  }
})();





















