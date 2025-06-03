import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="formulaire"
export default class extends Controller {
  static targets = ["mother", "doctor", "type"]
  connect() {

  }

  display() {
    console.log("display triggered")
    if (this.typeTarget.value === "Mother") {
      this.motherTarget.classList.remove("d-none")
      this.doctorTarget.classList.add("d-none")
    } else if (this.typeTarget.value === "Doctor") {
      this.doctorTarget.classList.remove("d-none")
      this.motherTarget.classList.add("d-none")
    } else {
      this.motherTarget.classList.add("d-none")
      this.doctorTarget.classList.add("d-none")
    }
  }
}
