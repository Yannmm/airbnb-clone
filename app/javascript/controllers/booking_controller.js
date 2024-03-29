import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "numberOfNights",
    "baseFare",
    "serviceFee",
    "totalBeforeTaxes",
  ];

  SERVICE_FEE = 0.18;

  connect() {
    this.updateDetails();
  }

  updateDetails() {
    this.numberOfNightsTarget.textContent = this.numberOfNights();
    this.baseFareTarget.textContent = this.calculateBaseFare();
    this.serviceFeeTarget.textContent = this.calculateServieFee();
    this.totalBeforeTaxesTarget.textContent = this.calculateTotalBeforeTaxes();
  }

  numberOfNights() {
    return 10;
  }

  calculateBaseFare() {
    return this.numberOfNights() * this.element.dataset.perNightPrice;
  }

  calculateServieFee() {
    return this.calculateBaseFare() * SERVICE_FEE;
  }

  calculateTotalBeforeTaxes() {
    return this.calculateBaseFare() + this.calculateServieFee();
  }
}

const SERVICE_FEE = 0.18;
