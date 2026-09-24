import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["band", "chip", "search", "list", "emptyState", "emptyQuery"]

  connect() {
    this.field = "all"
    this.query = ""
  }

  search(event) {
    this.query = event.target.value.trim().toLowerCase()
    this.apply()
  }

  filter(event) {
    this.field = event.currentTarget.dataset.field
    this.chipTargets.forEach((chip) => {
      chip.setAttribute("aria-pressed", String(chip === event.currentTarget))
    })
    this.apply()
  }

  reset() {
    this.field = "all"
    this.query = ""
    this.searchTarget.value = ""
    this.chipTargets.forEach((chip) => {
      chip.setAttribute("aria-pressed", String(chip.dataset.field === "all"))
    })
    this.apply()
    this.searchTarget.focus()
  }

  apply() {
    let visible = 0

    this.bandTargets.forEach((band) => {
      const fieldMatches =
        this.field === "all" || (band.dataset.field || "").split(" ").includes(this.field)
      const queryMatches = this.query === "" || (band.dataset.search || "").includes(this.query)
      const matches = fieldMatches && queryMatches

      band.classList.toggle("hidden", !matches)
      if (matches) visible++
    })

    this.listTarget.classList.toggle("hidden", visible === 0)
    this.emptyStateTarget.classList.toggle("hidden", visible !== 0)
    this.emptyQueryTarget.textContent = this.query === "" ? "that filter" : `"${this.query}"`
  }
}
