import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("✅ Hello World Controller Connected!")
    this.element.textContent = "Hello World!"
  }
}
