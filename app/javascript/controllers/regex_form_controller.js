import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const update = this.delayedSubmit.bind(this)
    this.element.querySelectorAll("textarea").forEach(area => {
      // area.addEventListener("change", update)
      area.addEventListener("input", update)
    })
  }

  delayedSubmit(event) {
    const now = new Date()
    let elapsed = 0

    if (this.timer) {
      clearTimeout(this.timer)
      elapsed = now - this.lastChange
    }

    this.lastChange = new Date()
    this.timer = setTimeout(() => {
      this.timer = null
      this.lastChange = null
      // this.element.submit()
      console.log("this is where we'd submit")
    }, 300) // ms
  }
}
