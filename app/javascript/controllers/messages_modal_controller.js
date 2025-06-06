import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages-modal"
export default class extends Controller {
  connect() {
  }

  close(e) {
    e.preventDefault();

    const messageContainer = document.querySelector(".message-container");
    messageContainer.classList.add("d-none");
  }
}
