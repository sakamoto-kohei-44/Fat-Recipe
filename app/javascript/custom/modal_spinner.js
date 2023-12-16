document.addEventListener('turbo:load', function() {
  var form = document.querySelector('#recipeForm');
  var modal = document.getElementById('my_modal_2');

  if (form) {
    form.addEventListener('submit', function(event) {
      modal.showModal();
    });
  }
});
