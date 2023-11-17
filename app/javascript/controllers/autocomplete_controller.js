import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input", "suggestions"];

  connect() {
    this.inputTarget.addEventListener('input', this.updateSuggestions.bind(this));
  }

  updateSuggestions(event) {
    const query = event.target.value;
    if (query.length > 2) { // 少なくとも2文字以上でサジェスト開始
      fetch(`/recipes/autocomplete?query=${encodeURIComponent(query)}`)
        .then(response => response.json())
        .then(data => this.showSuggestions(data))
        .catch(error => console.error(error));
    } else {
      this.suggestionsTarget.innerHTML = ''; // 文字が少なければサジェストをクリア
    }
  }

  showSuggestions(data) {
    this.suggestionsTarget.innerHTML = ''; // 既存のサジェストをクリア
    data.forEach(item => {
      const suggestionElement = document.createElement('li');
      suggestionElement.textContent = item.title;
      // ここで必要に応じてsuggestionElementをカスタマイズ
      this.suggestionsTarget.appendChild(suggestionElement);
    });
  }
}