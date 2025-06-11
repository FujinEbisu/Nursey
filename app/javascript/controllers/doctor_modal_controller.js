import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="doctor-modal"
export default class extends Controller {
  static targets = ["content"]

  connect() {
    document.body.style.overflow = "hidden"
    this.element.classList.add('modal-active')
  }

  disconnect() {
    document.body.style.overflow = ""
  }

  close() {
    this.element.remove()
  }

  closeOnOverlay(event) {
    if (event.target === this.element) {
      this.close()
    }
  }
}
