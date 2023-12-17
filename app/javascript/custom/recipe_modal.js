function loadRecipeDetails(recipeId) {
  fetch(`/recipes/${recipeId}`)
    .then(response => response.json())
    .then(data => {
      document.getElementById('modalTitle').textContent = data.title;
      document.getElementById('modalContent').textContent = data.description;
      document.getElementById('recipeDetailsModal').showModal();
    })
    .catch(error => console.error('Error:', error));
}

window.loadRecipeDetails = loadRecipeDetails;