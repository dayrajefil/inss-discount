import '@hotwired/turbo-rails'
import 'controllers'

document.addEventListener("DOMContentLoaded", function() {
  var alertBox = document.querySelector('.alert');

  if (alertBox) {
    setTimeout(function() {
      alertBox.style.display = 'none';
    }, 20000);
  }
});
