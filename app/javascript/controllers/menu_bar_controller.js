import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-bar"
export default class extends Controller {
  static targets = ["menu", "dropdown"]
  connect() {
    console.log("Menu bar controller connected");
  }

  toggle() {
    console.log("toggle");
    this.dropdownTarget.classList.toggle('active');
  }
} 
