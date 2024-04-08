import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("rating  connected");
  }

  setRating(event) {
    const star = event.currentTarget;

    const rating = star.dataset.rating;

    const input = star.parentNode.querySelector("input");

    if (!input) return;

    input.value = rating;

    // fill-gray-200
    for (let i = 1; i <= 5; i++) {
      const svg = star.parentNode.querySelector(`svg[data-rating="${i}"]`);
      svg.classList.remove("fill-gray-800");
      svg.classList.remove("fill-gray-200");

      svg.classList.add(
        i <= Number(rating) ? "fill-gray-800" : "fill-gray-200"
      );
    }

    console.log("input->", input);
  }
}
