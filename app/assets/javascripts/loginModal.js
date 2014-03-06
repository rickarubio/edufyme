(function($){
  $.fn.extend({

    leanModal: function(options) {

      var defaults = {
        top: 100,
        overlay: 0.5,
        closeButton: null
      }

      var overlay = $("<div id='lean_overlay'></div>");
      $("body").append(overlay);
      options =  $.extend(defaults, options);
      return this.each(function() {
        var o = options;
        $(this).click(function(e) {
          var modal_id = $(this).attr("href");
          $("#lean_overlay").click(function() {
          close_modal(modal_id);
          $('#signupmodal .notice').empty()
          $('#signupmodal').find("input[type=text], input[type=password]").val("");
         });

          $(o.closeButton).click(function() {
           close_modal(modal_id);
         });

          var modal_height = $(modal_id).outerHeight();
          var modal_width = $(modal_id).outerWidth();

          $('#lean_overlay').css({ 'display' : 'block', opacity : 0 });
          $('#lean_overlay').fadeTo(200,o.overlay);

          $(modal_id).css({
            'display' : 'block',
            'position' : 'fixed',
            'opacity' : 0,
            'z-index': 11000,
            'left' : 50 + '%',
            'margin-left' : -(modal_width/2) + "px",
            'top' : o.top + "px"
          });

          $(modal_id).fadeTo(200,1);
          e.preventDefault();
        });

      });

      function close_modal(modal_id){
        $("#lean_overlay").fadeOut(200);
        $(modal_id).css({ 'display' : 'none' });
      }

    }
  });

})(jQuery);

$(function(){
  $("#signupform").submit(validateParams.checkSignUp);
  $('#loginform').submit(validateParams.checkLogin);
});

var validateParams = (function() {

  return {
    checkSignUp: function() {
      var userEmail = $('#signupmodal #user_email').val();
      var userPassword = $('#signupmodal #user_password').val();
      var userPasswordConfirm = $('#signupmodal #user_password_confirmation').val();
      var userRememberMe = $('#signupmodal #user_remember_me').val();
      event.preventDefault();
      $.ajax({
        url: '/users',
        method: 'POST',
        data: {sign_up_params: {email: userEmail, password: userPassword, password_confirmation: userPasswordConfirm, remember_me: userRememberMe}}
      }).done(function(data){
        window.location.href = "/"
      }).fail(function(customError){
        $('#signupmodal .notice').empty();
        $.each(customError.responseJSON, function(index, value) {
          $('#signupmodal .notice').append(value + '<br />');
        });
      })
    },

    checkLogin: function() {
      var userEmail = $('#loginmodal #user_email').val();
      var userPassword = $('#loginmodal #user_password').val();
      var userRememberMe = $('#loginmodal #user_remember_me').val();
      event.preventDefault();
      $.ajax({
        url: '/users/sign_in',
        method: 'POST',
        data: {user: {email: userEmail, password: userPassword, remember_me: userRememberMe}}
      }).done(function(data){
        window.location.href = "/"
      }).fail(function(customError){
        $('#loginmodal .notice').empty();
        $('#loginmodal .notice').append(customError.responseText);
      })
    }
  }
})();
