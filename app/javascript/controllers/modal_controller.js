import { Controller } from "@hotwired/stimulus";
import { enter, leave, toggle } from "el-transition";

export default class extends Controller {
  connect() {
    // this.desktopUserMenuButtonTarget.addEventListener("click", (e) => {
    //   toggle(this.desktopUserOptionsDropdownTarget);
    // });
    // this.mobileUserMenuButtonTarget.addEventListener("click", (e) => {
    //   toggle(this.mobileUserOptionsDropdownTarget);
    // });
    
  }

  show(event) {
    const id = event.target.dataset.where;
    enter(document.getElementById(id));
  }

  hide(event) {
    const id = event.target.dataset.where;
    leave(document.getElementById(id));
  }
}
