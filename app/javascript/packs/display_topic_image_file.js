/*global $*/
document.addEventListener("turbolinks:load", function() {
  const fileInput = document.getElementById('counseling_room_topic_image');
  
  fileInput.addEventListener('change', function () {
    $('#file_name').text(fileInput.files[0].name);
  });
});