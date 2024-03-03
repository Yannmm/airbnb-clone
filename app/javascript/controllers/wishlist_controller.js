import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("wishlist connected");
  }

  updateWishlistStatus() {
    const userLoggedIn = this.element.dataset.userLoggedIn;

    if (userLoggedIn == "false") {
      //   document.querySelector(".js-login").click();
      // dummy comments
      document.getElementsByClassName("js-login")[0].click();
      return;
    }

    if (this.element.dataset.wishlistStatus == "false") {
      this.element.classList.remove("fill-none");
      this.element.classList.add("fill-primary");
      this.element.dataset.wishlistStatus = "true";
    } else {
      this.element.classList.remove("fill-primary");
      this.element.classList.add("fill-none");
      this.element.dataset.wishlistStatus = "false";
    }
  }
}
