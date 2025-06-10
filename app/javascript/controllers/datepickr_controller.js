import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepickr"
export default class extends Controller {
  connect() {
    console.log("Flatpickr connecté")
    flatpickr(this.element, {
      dateFormat: "Y-m-d",
      defaultDate: new Date(),


})

  }
}
