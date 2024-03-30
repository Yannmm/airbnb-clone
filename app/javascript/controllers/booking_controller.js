import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [
    "numberOfNights",
    "baseFare",
    "serviceFee",
    "totalBeforeTaxes",
    "checkin",
    "checkout",
  ];

  connect() {
    flatpickr(this.checkinTarget, {
      minDate: "today",
      maxDate: new Date().fp_incr(30), // 14 days from now
      onChange: (selectedDates, dateStr, instance) => {
        this.triggerCheckoutDatePicker(selectedDates[0]);
      },
      disable: JSON.parse(this.element.dataset.blockedDates).map((e) => {
        return {
          from: e[0], // checkin date
          to: e[1], // checkout date
        };
      }),
    });

    this.updateDetails();
  }

  triggerCheckoutDatePicker(checkinDate) {
    flatpickr(this.checkoutTarget, {
      minDate: checkinDate.fp_incr(1),
      maxDate: new Date().fp_incr(30), // 14 days from now
      onChange: (selectedDates, dateStr, instance) => {
        this.updateDetails();
      },
      disable: JSON.parse(this.element.dataset.blockedDates).map((e) => {
        return {
          from: e[0], // checkin date
          to: e[1], // checkout date
        };
      }),
    });

    this.checkoutTarget.click();
  }

  updateDetails() {
    const nightCount = this.numberOfNights;
    this.numberOfNightsTarget.textContent = nightCount;
    this.baseFareTarget.textContent =
      this.calculateBaseFare(nightCount).toFixed(2);
    this.serviceFeeTarget.textContent =
      this.calculateServieFee(nightCount).toFixed(2);
    this.totalBeforeTaxesTarget.textContent =
      this.calculateTotalBeforeTaxes(nightCount).toFixed(2);
  }

  get numberOfNights() {
    const checkinDate = new Date(this.checkinTarget.value);
    const checkoutDate = new Date(this.checkoutTarget.value);

    const diff = Math.ceil(
      Math.abs(checkoutDate - checkinDate) / (1000 * 60 * 60 * 24)
    );
    return diff;
  }

  calculateBaseFare(nightCount) {
    return nightCount * parseFloat(this.element.dataset.perNightPrice);
  }

  calculateServieFee(nightCount) {
    return this.calculateBaseFare(nightCount) * SERVICE_FEE;
  }

  calculateTotalBeforeTaxes(nightCount) {
    return (
      this.calculateBaseFare(nightCount) + this.calculateServieFee(nightCount)
    );
  }
}

const SERVICE_FEE = 0.18;
