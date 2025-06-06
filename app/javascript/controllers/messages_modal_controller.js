import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages-modal"
export default class extends Controller {

  connect() {
    document.body.style.height = "100vh"
    document.body.style.overflow = "hidden"
  }

  disconnect() {
    document.body.style.overflow = ""
  }

  close() {

    this.element.remove();
  }


}
