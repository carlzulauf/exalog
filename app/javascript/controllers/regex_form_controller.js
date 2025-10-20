import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'resultIndex' ]

  connect() {
    const update = this.delayedSubmit.bind(this)
    this.timer = null;
    this.element.querySelectorAll("textarea").forEach(area => {
      // area.addEventListener("change", update)
      area.addEventListener("input", update)
    })
  }

  selectResult(click) {
    this.resultIndexTarget.value = click.target.closest("li").dataset.resultIndex
    this.submit()
  }

  submit() {
    if (this.timer !== null) {
      clearTimeout(this.timer)
      this.timer = null;
    }
    this.lastChange = null;
    this.element.requestSubmit();
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
      this.element.requestSubmit();
    }, 300) // ms
  }
}
