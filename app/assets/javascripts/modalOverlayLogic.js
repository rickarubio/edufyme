$(function(){
  $('.overlay-add-course').on('click', modalOverlayLogic.addCourseToUserDashboard);
  $('.overlay-remove-course').on('click', modalOverlayLogic.removeCourseFromUserDashboard);
  $('.star-course').on('click', modalOverlayLogic.starCourse);
  $('.unstar-course').on('click', modalOverlayLogic.unstarCourse);
});


var modalOverlayLogic = (function() {
  // _private vars and functions

  return {
    removeCourseFromUserDashboard: function() {
      var courseID = $(this).attr('data-course-id');
      var userID = $('#current-user-id').attr('data-user-id');
      $.ajax({
        url: '/users/' + userID + '/courses/' + courseID,
        method: 'DELETE',
        data: {"course_id": courseID}
      }).done(function(result){
        $('.overlay-add-course').css('display', 'inherit');
        $('.overlay-remove-course').css('display', 'none')
      }).fail(function(){
        console.log("error has occurred");
      })
    },

    addCourseToUserDashboard: function() {
      var courseID = $(this).attr('data-course-id');
      var userID = $('#current-user-id').attr('data-user-id');
      $.ajax({
        url: '/users/' + userID + '/courses',
        method: 'POST',
        data: {"course_id": courseID}
      }).done(function(result){
        var a = $('#current-user-added-classes').attr('data-added-course-ids')
        $('#current-user-added-classes').replaceWith("<div id='current-user-added-classes' display='hidden' data-added-course-ids='" + [a.slice(0, 1), courseID + ', ', a.slice(1)].join('') + "' ></div>");
        $('.overlay-add-course').css('display', 'none');
        $('.overlay-remove-course').css('display', 'inherit')
      }).fail(function(){
        alert('You must be logged in to add classes');
      })
    },

    starCourse: function() {
      var courseID = $(this).attr('data-course-id');
      var userID = $('#current-user-id').attr('data-user-id');
      $.ajax({
        url: '/users/' + userID + '/courses/' + courseID,
        method: 'PUT',
        data: {"course_id": courseID, "update_action": {"starred": true}}
      }).done(function(result){
        $('.star-course').css('display', 'none');
        $('.unstar-course').css('display', 'inherit')
      }).fail(function(){
        alert("You must be logged in to star a course")
      })
    },

    unstarCourse: function() {
      var courseID = $(this).attr('data-course-id');
      var userID = $('#current-user-id').attr('data-user-id');
      $.ajax({
        url: '/users/' + userID + '/courses/' + courseID,
        method: 'PUT',
        data: {"course_id": courseID, "update_action": {"starred": false}}
      }).done(function(result){
        $('.star-course').css('display', 'inherit');
        $('.unstar-course').css('display', 'none')
      }).fail(function(){
        alert("error has occured")
      })
    }
  }
})();