// app/javascript/controllers/rating_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["radio", "label"]

  connect(){
  };


  update(event) {

    const checkedIndex = this.radioTargets.findIndex(radio => radio.checked)
    const labels = Array.from(this.element.querySelectorAll("label"))
    labels.forEach((label) => {
      label.classList.remove("selected")
    })
    const checkedlabel = event.target.nextElementSibling
    const index = labels.indexOf(checkedlabel)
    const previousLabels = labels.slice(0,index)
    previousLabels.forEach((label) => {
      label.classList.add("selected")
    })

    this.labelTargets.forEach((label, index) => {
      if (index <= checkedIndex) {
        label.classList.add("selected")
      } else {
        label.classList.remove("selected")
      }
    })
  }
}
