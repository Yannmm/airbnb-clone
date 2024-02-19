import { Controller } from "@hotwired/stimulus";
import { enter, leave, toggle } from "el-transition";

export default class extends Controller {
  static targets = [
    "desktopUserMenuButton",
    "desktopUserOptionsDropdown",
    "mobileUserMenuButton",
    "mobileUserOptionsDropdown",
  ];

  connect() {
    this.desktopUserMenuButtonTarget.addEventListener("click", (e) => {
      toggle(this.desktopUserOptionsDropdownTarget);
    });

    this.mobileUserMenuButtonTarget.addEventListener("click", (e) => {
      toggle(this.mobileUserOptionsDropdownTarget);
    });
  }
}
