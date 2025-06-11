import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-bar"
export default class extends Controller {
  static targets = ["dropdown"]
  
  connect() {
    // Add click listeners to menu items to close menu
    this.element.addEventListener('click', (e) => {
      if (e.target.classList.contains('menu-item')) {
        this.close();
      }
    });
  }

  toggle() {
    this.dropdownTarget.classList.toggle('active');
  }

  close() {
    this.dropdownTarget.classList.remove('active');
  }
} 
