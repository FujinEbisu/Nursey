import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-bar-mother"
export default class extends Controller {
  static targets = ["user_welcome", "nouvelle_tete"]
  
  connect() {
    // Add click listeners to menu items to close menu
    this.element.addEventListener('click', (e) => {
      if (e.target.classList.contains('menu-item')) {
        this.close();
      }
    });
  }

  toggle() {
    // Toggle the main navbar active state
    this.element.classList.toggle('active');
    
    // Toggle the user welcome and button visibility
    this.user_welcomeTarget.classList.toggle('active');
    this.nouvelle_teteTarget.classList.toggle('active');
  }

  close() {
    this.element.classList.remove('active');
    this.user_welcomeTarget.classList.remove('active');
    this.nouvelle_teteTarget.classList.remove('active');
  }
} 
