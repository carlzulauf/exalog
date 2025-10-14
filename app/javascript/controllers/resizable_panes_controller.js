import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.stopper = this.stopResizing.bind(this)
    this.element.querySelectorAll(".vertical-gutter, .horizontal-gutter").forEach(el => {
      el.addEventListener("mousedown", this.startResizing.bind(this))
    });
  }

  startResizing(event) {
    this.resizeTarget = event.target
    if (this.resizeTarget.classList.contains("vertical-gutter")) {
      this.resizer = this.horizontalResize.bind(this)
    } else {
      this.resizer = this.verticalResize.bind(this)
    }

    window.addEventListener("mouseup", this.stopper)
    window.addEventListener("mousemove", this.resizer)
  }

  stopResizing(event) {
    window.removeEventListener("mouseup", this.stopper)
    window.removeEventListener("mousemove", this.resizer)
  }

  horizontalResize(event) {
    const width = this.resizeTarget.parentElement.offsetWidth
    const left = this.resizeTarget.previousElementSibling
    const right = this.resizeTarget.nextElementSibling
    left.style.width = `${event.clientX}px`
    right.style.width = `${(width - event.clientX)}px`
  }

  verticalResize(event) {
    const height = this.resizeTarget.parentElement.offsetHeight
    const top = this.resizeTarget.previousElementSibling
    const btm = this.resizeTarget.nextElementSibling
    console.log(this.element, this.element.offsetTop)
    top.style.height = `${event.clientY - this.element.offsetTop}px`
    btm.style.height = `${(height - event.clientY - this.element.offsetTop)}px`
  }
}
