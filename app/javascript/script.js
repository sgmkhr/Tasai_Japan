/*global $*/
$(function() {
  
  // ページトップへスクロールするボタンを押した時
  $('.back_to_pagetop').on('click', function(event) {
    $('body, html').animate({
      scrollTop: 0
    }, 800);
    event.preventDefault();
  });
  
  // ヘッダーの通知アイコンを押した時
  $('#notification-icon').on('click', function(event) {
    $('#notifications-box').show();
    event.preventDefault();
  });
  $('#close-notification-box').on('click', function(event) {
    $('#notifications-box').hide();
    event.preventDefault();
  });
  
});