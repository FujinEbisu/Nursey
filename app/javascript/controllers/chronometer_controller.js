import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chronometer"
export default class extends Controller {
    static targets = ["output", "tirage", "droite", "gauche", "stop", "chooseSide", "title", "second", "output2","newtitle"]

  connect() {
    this.startTime = Date.now()
    this.timer = setInterval(() => this.update(), 1000)
  }

  disconnect() {
    clearInterval(this.timer)
    clearInterval(this.timer2)
  }

  pad(value) {
  return value.toString().padStart(2, '0')
}

  update() {
    const elapsed = Math.floor((Date.now() - this.startTime) / 1000)
    const minutes = String(Math.floor(elapsed / 60)).padStart(2, '0')
    const seconds = String(elapsed % 60).padStart(2, '0')
    this.outputTarget.textContent = `${minutes}:${seconds}`
     const elapsed1 = Math.floor((Date.now() - this.startTime2) / 1000)
    const minutes1 = String(Math.floor(elapsed1 / 60)).padStart(2, '0')
    const seconds1 = String(elapsed1 % 60).padStart(2, '0')
    this.output2Target.textContent = `${this.pad(minutes1)}:${this.pad(seconds1)}`
  }


  display(event) {
    const button = event.target.innerText
    if (button === "Tirage") {
      this.tirageTarget.classList.add("d-none")
      this.titleTarget.innerText = "Nouveau tirage"
    } else if (button === "Droite") {
      this.droiteTarget.classList.add("d-none")
      this.gaucheTarget.classList.add("d-none")
      this.chooseSideTarget.classList.remove("d-none")
      this.secondTarget.classList.remove("d-none")
      this.newtitleTarget.innerText = "Temps seins droit"
      const timegauche = this.outputTarget.textContent
         this.startTime2 = Date.now()
        this.timer2 = setInterval(() => this.update(), 1000)
      const timedroite = this.output2Target.textContent
    } else if (button === "Gauche") {
      this.gaucheTarget.classList.add("d-none")
      this.droiteTarget.classList.add("d-none")
      this.stopTarget.classList.remove("d-none")
      this.secondTarget.classList.remove("d-none")
      this.newtitleTarget.innerText = "Temps seins gauche"
      this.startTime2 = Date.now()
      this.timer2 = setInterval(() => this.update(), 1000)
      const timedroite = this.outputTarget.textContent
      const timegauche = this.output2Target.textContent
    } else if (button === "Stop") {
      const time = this.outputTarget.textContent
      const timenext = this.output2Target.textContent
    }
  }
}
// this.outputTarget.classList.remove("hidden")
