import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    this.open();
  }

  open() {
    this.element.classList.add("is-active");
  }

  close() {
    this.element.classList.remove("is-active");
  }
}
