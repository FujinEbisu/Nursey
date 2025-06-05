import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chronometer"
export default class extends Controller {
    static targets = ["output", "tirage", "droite", "gauche", "stop", "chooseSide", "title", "second", "output2","newtitle", "time", "change", "output3", "first"]


 connect() {
    // Chrono total
     this.startTime3 = Date.now()
      this.timer3 = setInterval(() => this.update3(), 1000)
      this.running3 = true


    // Chrono 1 : 1er sein
     this.startTime1 = Date.now()
      this.timer1 = setInterval(() => this.update1(), 1000)
      this.running1 = true

    // Chrono 2 : 2ème sein
    this.startTime2 = null
    this.timer2 = null
    this.running2 = false
  }

  display(event) {
    const button = event.target.innerText
    if (button === "Tirage") {
      this.tirageTarget.classList.add("d-none")
      this.chooseSideTarget.classList.add("d-none")
      this.firstTarget.classList.add("d-none")
      this.secondTarget.classList.add("d-none")
      this.titleTarget.innerText = "Nouveau tirage"
    } else if (button === "Droite") {
      this.droiteTarget.classList.add("d-none")
      this.gaucheTarget.classList.add("d-none")
      this.timeTarget.innerText = "Droite"
      this.newtitleTarget.innerText = "droite"
      this.changeTarget.classList.remove("d-none")
    } else if (button === "Gauche") {
      this.gaucheTarget.classList.add("d-none")
      this.droiteTarget.classList.add("d-none")
      this.stopTarget.classList.remove("d-none")
      this.timeTarget.innerText = "Gauche"
      this.newtitleTarget.innerText = "droite"
    } else if (button === "Stop") {
      clearInterval(this.timer1)
      clearInterval(this.timer2)
      this.running1 = false
      this.running2 = false

      const time1 = this.outputTarget.textContent
      const time2 = this.output2Target.textContent
      const time3 = this.output3Target.textContent
      console.log("Temps 1er sein :", time1)
      console.log("Temps 2ème sein :", time2)
      console.log("Temps total :", time3)
    } else if (button === "Changer de seins") {
      clearInterval(this.timer1)
      this.secondTarget.classList.remove("d-none")
      this.changeTarget.classList.add("d-none")
      this.chooseSideTarget.classList.add("d-none")
      this.newtitleTarget.innerText = "2ème sein"
      const sein = this.timeTarget.innerText
      if (sein === "Droite") {
        this.newtitleTarget.innerText = "Gauche"
      } else {
        this.newtitleTarget.innerText = "Droite"
      }
      this.startTime2 = Date.now()
      this.timer2 = setInterval(() => this.update2(), 1000)
    }
  }

update1() {
    const elapsed = Math.floor((Date.now() - this.startTime1) / 1000)
    const minutes = this.pad(Math.floor(elapsed / 60))
    const seconds = this.pad(elapsed % 60)
    this.outputTarget.textContent = `${minutes}:${seconds}`
  }

  update2() {
    const elapsed = Math.floor((Date.now() - this.startTime2) / 1000)
    const minutes = this.pad(Math.floor(elapsed / 60))
    const seconds = this.pad(elapsed % 60)
    this.output2Target.textContent = `${minutes}:${seconds}`
  }

  update3() {
    const elapsed = Math.floor((Date.now() - this.startTime3) / 1000)
    const minutes = this.pad(Math.floor(elapsed / 60))
    const seconds = this.pad(elapsed % 60)
    this.output3Target.textContent = `${minutes}:${seconds}`
  }

  pad(value) {
    return value.toString().padStart(2, '0')
  }
}
// this.outputTarget.classList.remove("hidden")
