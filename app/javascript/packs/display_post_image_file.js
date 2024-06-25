/*global $*/
document.addEventListener("turbolinks:load", function() {
  const fileInput = document.getElementById('post_post_image');
  
  fileInput.addEventListener('change', function () {
    $('#file_name').text(fileInput.files[0].name);
  });
});