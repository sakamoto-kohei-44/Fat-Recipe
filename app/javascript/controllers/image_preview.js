import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "preview"];

  preview() {
    const input = this.inputTarget;
    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = (e) => {
        this.previewTarget.src = e.target.result;
      };

      reader.readAsDataURL(input.files[0]);
    }
  }
}