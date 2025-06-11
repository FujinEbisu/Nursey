import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages-modal"
export default class extends Controller {
  static targets = ["container"]

  connect() {
    document.body.style.height = "100vh"
    document.body.style.overflow = "hidden"
    this.containerTarget.scrollTo({ top: this.containerTarget.scrollHeight })
  }

  disconnect() {
    document.body.style.overflow = ""
  }

  close() {
    this.element.remove();
  }
}
