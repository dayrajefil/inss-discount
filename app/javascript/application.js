// app/javascript/application.js

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import 'bootstrap/dist/css/bootstrap.min.css';

document.addEventListener("DOMContentLoaded", function() {
  var alertBox = document.querySelector('.alert');

  if (alertBox) {
    setTimeout(function() {
      alertBox.style.display = 'none';
    }, 20000);
  }
});
