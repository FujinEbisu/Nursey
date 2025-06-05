import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages-modal"
export default class extends Controller {
  static targets = ["messageWindow"]
  connect() {
  }

  toggle() {
    this.element.classList.toggle("active");
    this.messageWindowTarget.classList.toggle("active");
  }
}
