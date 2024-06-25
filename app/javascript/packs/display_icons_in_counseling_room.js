/*global $*/
document.addEventListener("turbolinks:load", function() {
  
  $('#down-arrow').on('click', function() {
    $('#icons').removeClass('limitedly-displayed-icons');
    $(this).hide();
    $('#up-arrow').show();
    event.preventDefault();
  });
  
  $('#up-arrow').on('click', function() {
    $('#icons').addClass('limitedly-displayed-icons');
    $(this).hide();
    $('#down-arrow').show();
    event.preventDefault();
  });
  
});