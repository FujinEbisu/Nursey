import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reset() {
    this.element.reset()
  }

  handleEnter(event) {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault()
      this.element.submit()
    }
  }
}