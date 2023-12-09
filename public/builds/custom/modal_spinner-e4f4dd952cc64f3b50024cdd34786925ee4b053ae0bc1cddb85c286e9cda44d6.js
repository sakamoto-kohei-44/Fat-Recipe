(() => {
  // app/javascript/custom/modal_spinner.js
  document.addEventListener("turbo:load", function() {
    var form = document.querySelector("#recipeForm");
    var modal = document.getElementById("my_modal_2");
    if (form) {
      form.addEventListener("submit", function(event) {
        event.preventDefault();
        modal.showModal();
        setTimeout(function() {
          form.requestSubmit();
        }, 1e3);
      });
    }
  });
})();

