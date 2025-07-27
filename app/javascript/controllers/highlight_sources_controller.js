import { Controller } from "@hotwired/stimulus"
import hljs from 'highlight.js';

export default class extends Controller {
  connect() {
    console.log(hljs);
    this.element.querySelectorAll("code pre").forEach((el) => {
      hljs.highlightElement(el);
    });
  }
}
