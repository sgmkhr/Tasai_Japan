/*global $*/
document.addEventListener("turbolinks:load", function() {
  const fileInput = document.getElementById('user_profile_image');
  
  fileInput.addEventListener('change', function () {
    $('#file_name').text(fileInput.files[0].name);
  });
});