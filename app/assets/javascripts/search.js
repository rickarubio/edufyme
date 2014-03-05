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
          Search.clearSearch();
        }
      });
    },

    clearSearch: function() {
      $('.search input').val("");
    }
  }
})();