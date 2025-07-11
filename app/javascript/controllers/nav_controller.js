import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  #availableThemes = ["dark-theme", "light-theme"];

  async connect() {
    this.setTheme(await this.currentTheme(), false);
  }

  async toggleTheme() {
    const lastTheme = await this.currentTheme();
    const nextTheme = this.#availableThemes.filter(name => name !== lastTheme)[0]
    this.setTheme(nextTheme, true)
  }

  async setTheme(theme, remember) {
    const others = this.#availableThemes.filter(name => name !== theme)
    document.body.classList.add(theme)
    others.forEach(name => document.body.classList.remove(name))
    if (remember) { await cookieStore.set("theme", theme) }
  }

  async currentTheme() {
    const storedTheme = await cookieStore.get("theme")
    if (storedTheme) { return storedTheme.value }
    return this.defaultTheme();
  }

  defaultTheme() {
    if (this.isDarkPreferred()) {
      return 'dark-theme'
    } else {
      return 'light-theme'
    }
  }

  isDarkPreferred() {
    return window.matchMedia("(prefers-color-scheme: dark)").matches
  }
}
