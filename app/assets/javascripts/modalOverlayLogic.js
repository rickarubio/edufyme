$(function(){
  modalOverlayLogic.addCourseToUserDashboard();
});


var modalOverlayLogic = (function() {
  // _private vars and functions

  return {
    removeCourseFromUserDashboard: function() {
      $('.overlay-remove-course').on('click', function() {
        var courseID = $(this).attr('data-course-id');
        var userID = $('#current-user-id').attr('data-user-id');
        $.ajax({
          url: '/users/' + userID + '/courses/' + courseID,
          method: 'DELETE',
          data: {"course_id": courseID}
        }).done(function(result){
          console.log("class has been removed");
        }).failt(function(){
          console.log("error has occurred");
        })
      })
    },

    addCourseToUserDashboard: function(){
      $('.overlay-add-course').on('click', function() {
        var courseID = $(this).attr('data-course-id');
        var userID = $('#current-user-id').attr('data-user-id');
        $.ajax({
          url: '/users/' + userID + '/courses',
          method: 'POST',
          data: {"course_id": courseID}
        }).done(function(result){
          console.log("listenForClick in modalOverlayLogic")
          console.log(result);
        }).fail(function(){
          alert('You must be logged in to add classes');
        })
      })
    }
  }
})();