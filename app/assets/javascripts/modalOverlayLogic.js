$(function(){
  $('.overlay-add-course').on('click', modalOverlayLogic.addCourseToUserDashboard);
  $('.overlay-remove-course').on('click', modalOverlayLogic.removeCourseFromUserDashboard);
  $('.favorite-course').on('click', modalOverlayLogic.favoriteCourse);
  $('.unfavorite-course').on('click', modalOverlayLogic.unfavoriteCourse);
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
        $('.overlay-remove-course').css('display', 'none');
        $('.unfavorite-course').css('display', 'none');
        $('.favorite-course').css('display', 'inherit');
        $('.favorite-course').attr('disabled', 'disabled');
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
        $('.overlay-add-course').css('display', 'none'); /* none */
        $('.overlay-remove-course').css('display', 'inherit');
        $('.favorite-course').removeAttr('disabled');
      }).fail(function(){
        alert('You must be logged in to add classes');
      })
    },

    favoriteCourse: function() {
      var courseID = $(this).attr('data-course-id');
      var userID = $('#current-user-id').attr('data-user-id');
      $.ajax({
        url: '/users/' + userID + '/courses/' + courseID,
        method: 'PUT',
        data: {"course_id": courseID, "update_action": {"favorited": true}}
      }).done(function(result){
        var a = $('#current-user-favorited-classes').attr('data-favorited-course-ids')
        $('#current-user-favorited-classes').replaceWith("<div id='current-user-favorited-classes' display='hidden' data-favorited-course-ids='" + [a.slice(0, 1), courseID + ', ', a.slice(1)].join('') + "' ></div>");
        $('.favorite-course').css('display', 'none');
        $('.unfavorite-course').css('display', 'inherit')
      }).fail(function(){
        alert("You must be taking this class to favorite it")
      })
    },

    unfavoriteCourse: function() {
      var courseID = $(this).attr('data-course-id');
      var userID = $('#current-user-id').attr('data-user-id');
      $.ajax({
        url: '/users/' + userID + '/courses/' + courseID,
        method: 'PUT',
        data: {"course_id": courseID, "update_action": {"favorited": false}}
      }).done(function(result){
        $('.favorite-course').css('display', 'inherit');
        $('.unfavorite-course').css('display', 'none')
      }).fail(function(){
        alert("error has occured")
      })
    }
  }
})();