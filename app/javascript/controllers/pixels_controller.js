import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  #availableColors = [
    "#000000",
    "#FFFFFF",
    "#FF0000",
    "#00FF00",
    "#0000FF",
  ]
  connect() {
    const style = this.element.style
    let color = 0

    this.element.addEventListener("click", e => {
      color++
      if (color >= this.#availableColors.length) { color = 0 }

      style.backgroundColor = this.#availableColors[color]
    })
  }
}
