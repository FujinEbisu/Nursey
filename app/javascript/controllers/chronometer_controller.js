import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chronometer"
export default class extends Controller {
    static targets = ["output"]

  connect() {
    this.startTime = Date.now()
    this.timer = setInterval(() => this.update(), 1000)
  }

  disconnect() {
    clearInterval(this.timer)
  }

  update() {
    const elapsed = Math.floor((Date.now() - this.startTime) / 1000)
    const minutes = String(Math.floor(elapsed / 60)).padStart(2, '0')
    const seconds = String(elapsed % 60).padStart(2, '0')
    this.outputTarget.textContent = `${minutes}:${seconds}`
  }
}

