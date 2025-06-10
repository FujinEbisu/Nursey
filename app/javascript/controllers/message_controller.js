import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
 static values = {
  userId: Number,
  userType: String
 }
  connect() {
    // triggered when a new message is added to the page
    const currentUserId = parseInt(document.body.dataset.currentUserId, 10);
    const typeUser = parseInt(document.body.dataset.currentUserType, 10);
    if (this.userTypeValue === typeUser) {
      this.element.classList.add('sent');
      this.element.classList.remove('received');
    } else {
      this.element.classList.add('received');
      this.element.classList.remove('sent');
    }
    this.element.scrollIntoView({ behavior: 'smooth' }); // scroll to the bottom of the page
  }
}
