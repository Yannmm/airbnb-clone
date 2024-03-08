import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon", "text"];

  connect() {
    console.log("wishlist connected");
  }

  updateWishlistStatus(e) {
    e.preventDefault();

    const userLoggedIn = this.element.dataset.userLoggedIn;

    if (userLoggedIn == "false") {
      document.getElementsByClassName("js-login")[0].click();
      return;
    }

    if (this.element.dataset.wishlistStatus == "false") {
      const userId = this.element.dataset.userId;
      const propertyId = this.element.dataset.propertyId;
      this.addPropertyToWishlist(propertyId, userId);
    } else {
      const wishlistId = this.element.dataset.wishlistId;
      this.removePropertyFromWishlist(wishlistId);
    }

    return false;
  }

  removePropertyFromWishlist(wishlistId) {
    const csrfToken = document
      .querySelector("[name='csrf-token']")
      .getAttribute("content");

    console.log("csrf->", csrfToken);

    const options = {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": csrfToken,
      },
    };

    fetch(`/api/wishlists/${wishlistId}`, options)
      .then((response) => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
      })
      .then((data) => {
        this.iconTarget.classList.remove("fill-primary");
        this.iconTarget.classList.add("fill-none");
        if (this.hasTextTarget) {
          this.textTarget.innerText = "Like";
        }
        this.element.dataset.wishlistStatus = "false";
        delete this.element.dataset.wishlistId;
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }

  addPropertyToWishlist(propertyId, userId) {
    const params = {
      property_id: propertyId,
      user_id: userId,
    };

    const csrfToken = document
      .querySelector("[name='csrf-token']")
      .getAttribute("content");

    const options = {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify(params),
    };

    fetch("/api/wishlists", options)
      .then((response) => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.json();
      })
      .then((data) => {
        // Process the retrieved user data

        this.iconTarget.classList.remove("fill-none");
        this.iconTarget.classList.add("fill-primary");
        if (this.hasTextTarget) {
          this.textTarget.innerText = "Saved";
        }
        this.element.dataset.wishlistStatus = "true";
        this.element.dataset.wishlistId = data.id;
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }
}
