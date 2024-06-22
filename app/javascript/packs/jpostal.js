/*global $*/
$(document).on("turbolinks:load", function() {
  $('#post_zipcode').jpostal({
    postcode : ['#post_zipcode'],
    address : {
      '#post_address': '%3%4%5'
    }
  });
});