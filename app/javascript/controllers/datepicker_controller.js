import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["startDate", "endDate"]

  connect() {
    // Initialize start date picker
    this.startPicker = flatpickr(this.startDateTarget, {
      dateFormat: "Y-m-d",
      minDate: "today",
      onChange: (selectedDates) => {
        this.endPicker.set("minDate", selectedDates[0])
      }
    })

    // Initialize end date picker
    this.endPicker = flatpickr(this.endDateTarget, {
      dateFormat: "Y-m-d",
      minDate: "today"
    })
  }

  disconnect() {
    this.startPicker.destroy()
    this.endPicker.destroy()
  }
}
