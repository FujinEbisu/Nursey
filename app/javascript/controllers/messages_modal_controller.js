import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages-modal"
export default class extends Controller {
  static targets = ["container"]

  connect() {
  }

  disconnect() {
    document.body.style.overflow = ""
  }

  close() {
    this.element.remove();
  }
}
