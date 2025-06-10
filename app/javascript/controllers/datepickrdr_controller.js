import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import "flatpickr/dist/l10n/fr.js"

// Connects to data-controller="datepickrdr"
export default class extends Controller {
  static targets = ["dates"]
  static values = {
    dates: Array
  }
  connect() {
     flatpickr(this.element, {
          dateFormat: "Y-m-d",
          defaultDate: this.datesValue,
          minDate: "today",
          mode: "multiple",
          inline: true,
          locale: "fr",

    })
  }
}
