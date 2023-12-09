(() => {
  // app/javascript/custom/modal_spinner.js
  document.addEventListener("DOMContentLoaded", function() {
    var form = document.querySelector("#recipeForm");
    if (form) {
      var modal = document.getElementById("my_modal_2");
      form.addEventListener("submit", function(event) {
        event.preventDefault();
        modal.showModal();
        form.submit();
      });
    }
  });
})();
//# sourceMappingURL=assets/custom/modal_spinner.js.map
