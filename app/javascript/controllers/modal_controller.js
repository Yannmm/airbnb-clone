import { Controller } from "@hotwired/stimulus";
import { enter, leave, toggle } from "el-transition";

export default class extends Controller {
  show(event) {
    const id = event.target.dataset.where;
    enter(document.getElementById(id));
  }

  hide(event) {
    const modal = event.target.closest("[data-controller=modal]");
    leave(modal);
  }
}
