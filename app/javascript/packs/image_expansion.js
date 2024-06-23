/*global $*/
$('#shrinked-image').on('click', function(event) {
  $('#expanded-image').removeClass('image-non-expansion');
  $('#expanded-image').addClass('image-expansion');
  $('#expanded-image').on('click', function() {
    $('#expanded-image').removeClass('image-expansion');
    $('#expanded-image').addClass('image-non-expansion');
  });
});