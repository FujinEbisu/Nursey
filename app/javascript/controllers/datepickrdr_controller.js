import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="datepickrdr"
export default class extends Controller {
  static values = {
    dates: Array
  }
  connect() {
    console.log("Flatpickr2 connecté", this.datesValue)
     flatpickr(this.element, {
          dateFormat: "Y-m-d",
          defaultDate: current_user.userable.availibities,
          minDate: "today",
          mode: "multiple",

    })
  }
}
