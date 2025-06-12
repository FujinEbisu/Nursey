import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages-modal"
export default class extends Controller {
  static targets = ["container"]

  connect() {
  }

  disconnect() {
  }

  close() {
    this.element.remove();
  }
}
