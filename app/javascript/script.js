$(function() {
  
  $('.back_to_pagetop').on('click', function(event) {
    $('body, html').animate({
      scrollTop: 0
    }, 800);
    event.preventDefault();
  });
  
  $('#notification-icon').on('click', function(event) {
    $('#notifications-box').show();
  });
  
  $('#close-notification-box').on('click', function(event) {
    $('#notifications-box').hide();
  });
  
});