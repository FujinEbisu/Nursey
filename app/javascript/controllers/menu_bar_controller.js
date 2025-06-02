import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-bar"
export default class extends Controller {
  static targets = ["menu"]
  connect() {
    console.log("Menu bar controller connected");
  }

  toggle() {
    this.menuTarget.classList.toggle('active');
  }
}
