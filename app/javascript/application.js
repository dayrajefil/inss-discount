// app/javascript/application.js
import 'bootstrap/dist/css/bootstrap.min.css';

document.addEventListener("DOMContentLoaded", function() {
  var alertBox = document.querySelector('.alert');

  if (alertBox) {
    setTimeout(function() {
      alertBox.style.display = 'none';
    }, 20000);
  }
});
