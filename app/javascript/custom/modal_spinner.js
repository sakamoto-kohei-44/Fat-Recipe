document.addEventListener("DOMContentLoaded", function() {
  var form = document.querySelector('#recipeForm');
  var modal = document.getElementById('my_modal_2');

  form.addEventListener('submit', function(event) {
    event.preventDefault();
    modal.showModal();
    setTimeout(function() {
      form.submit();
    }, 1000);
  });
});
