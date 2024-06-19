/*global $*/
$('#tab-menu a').on('click', function(event) {
  $('#tab-contents .tab').hide();
  $('#tab-menu .btn-active').removeClass('btn-active');
  $(this).addClass('btn-active');
  $('#tab-menu a').html('<i class="fa-regular fa-circle"></i>');
  $('.btn-active').html('<i class="fa-solid fa-circle"></i>');
  $($(this).attr('href')).show();
  event.preventDefault();
});