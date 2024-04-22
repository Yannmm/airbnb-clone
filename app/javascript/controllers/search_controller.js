import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [
    "checkin",
    "checkout",
  ];

  connect() {
    flatpickr(this.checkinTarget, {
    //   minDate: "today",
    //   maxDate: new Date().fp_incr(30), // 14 days from now
      onChange: (selectedDates, dateStr, instance) => {
        this.triggerCheckoutDatePicker(selectedDates[0]);
      },
    });
  }

  triggerCheckoutDatePicker(checkinDate) {
    const start = checkinDate.fp_incr(1);
    var end = start.fp_incr(30);

    flatpickr(this.checkoutTarget, {
      minDate: start,
      maxDate: end,
      onChange: (selectedDates, dateStr, instance) => {
        // this.updateDetails();
      },
    });

    this.checkoutTarget.click();
  }

}
