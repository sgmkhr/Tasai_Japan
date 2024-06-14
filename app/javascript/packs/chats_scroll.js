document.addEventListener("turbolinks:load", function() {
  var scrollPosition = document.getElementById('area').scrollTop;
  var scrollHeight = document.getElementById('area').scrollHeight;
  document.getElementById('area').scrollTop = scrollHeight;
});

window.onload = function() {
  var scrollPosition = document.getElementById('area').scrollTop;
  var scrollHeight = document.getElementById('area').scrollHeight;
  document.getElementById('area').scrollTop = scrollHeight;
};