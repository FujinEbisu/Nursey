import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]
  reset() {
    this.element.reset()
  }

  handleEnter(event) {
    if (event.key === 'Enter') {
      this.element.submit()
      this.containerTarget.scrollTo({ top: this.containerTarget.scrollHeight })
    }
  }
}
