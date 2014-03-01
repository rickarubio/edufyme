$(document).ready(function(){
  bindEvents();
})


bindEvents = function() {
  $('.featured-courses-title').on('click', function(e) {
    e.preventDefault();
    Overlay.display();
  }),

  $('.exit-modal').on('click', function(e){
    e.preventDefault();
    Overlay.hide();
  })
}

var Overlay = (function() {
  //private _methods and _vars
  return {
    display: function() {
      $('.overlay').css('display', 'block');
      $('.modal').css('display', 'block');
    },

    hide: function(){
     $('.overlay').css('display', 'none');
     $('.modal').css('display', 'none');
    }
  }


}());
