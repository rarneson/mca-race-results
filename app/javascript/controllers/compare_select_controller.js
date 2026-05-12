import { Controller } from "@hotwired/stimulus"

// Lets the user select two racers across categories on a race show page,
// then navigate to the head-to-head compare page. State persists in
// sessionStorage so selecting across category filter switches works.
export default class extends Controller {
  static targets = ["toggle", "row", "bar", "count", "submit", "names"]
  static values = {
    raceSlug: String,
    compareUrl: String
  }

  connect() {
    this.storageKey = `compare:${this.raceSlugValue}`
    this.modeKey = `${this.storageKey}:mode`
    this.selectionsKey = `${this.storageKey}:selections`

    this.mode = sessionStorage.getItem(this.modeKey) === "1"
    try {
      this.selections = JSON.parse(sessionStorage.getItem(this.selectionsKey) || "[]")
    } catch (_e) {
      this.selections = []
    }

    this.render()
  }

  toggle() {
    this.mode = !this.mode
    if (!this.mode) this.selections = []
    this.persist()
    this.render()
  }

  // Called from each row's data-action in the capture phase. When mode is
  // on, swallows the click (including child link navigation) and toggles
  // selection on the whole row instead.
  tryToggle(event) {
    if (!this.mode) return
    event.preventDefault()
    event.stopImmediatePropagation()

    const row = event.currentTarget
    const id = row.dataset.racerSeasonId
    if (!id) return

    const name = row.dataset.name || id
    const idx = this.selections.findIndex((s) => s.id === id)
    if (idx >= 0) {
      this.selections.splice(idx, 1)
    } else {
      if (this.selections.length >= 2) this.selections.shift()
      this.selections.push({ id, name })
    }
    this.persist()
    this.render()
  }

  clear() {
    this.selections = []
    this.persist()
    this.render()
  }

  submit(event) {
    if (this.selections.length !== 2) {
      event.preventDefault()
      return
    }
    const params = new URLSearchParams()
    this.selections.forEach((s) => params.append("racer_season_ids[]", s.id))
    event.currentTarget.href = `${this.compareUrlValue}?${params.toString()}`
  }

  persist() {
    sessionStorage.setItem(this.modeKey, this.mode ? "1" : "0")
    sessionStorage.setItem(this.selectionsKey, JSON.stringify(this.selections))
  }

  render() {
    if (this.hasToggleTarget) {
      this.toggleTarget.classList.toggle("active", this.mode)
      this.toggleTarget.textContent = this.mode ? "✓ COMPARE_MODE" : "⇄ COMPARE"
    }

    if (this.hasBarTarget) {
      this.barTarget.classList.toggle("hidden", !this.mode)
      this.barTarget.classList.toggle("flex", this.mode)
    }

    const selectedIds = new Set(this.selections.map((s) => s.id))
    this.rowTargets.forEach((row) => {
      const id = row.dataset.racerSeasonId
      const isSelected = selectedIds.has(id)
      row.classList.toggle("compare-selected", isSelected)
      if (this.mode) {
        row.classList.add("compare-mode")
      } else {
        row.classList.remove("compare-mode")
      }
    })

    if (this.hasCountTarget) {
      this.countTarget.textContent = `${this.selections.length}/2`
    }

    if (this.hasNamesTarget) {
      const labels = this.selections.map((s) => s.name.split(" ").slice(0, 2).join(" "))
      this.namesTarget.textContent = labels.length ? labels.join(" vs ") : "select 2 racers"
    }

    if (this.hasSubmitTarget) {
      const ready = this.selections.length === 2
      this.submitTarget.classList.toggle("opacity-40", !ready)
      this.submitTarget.classList.toggle("pointer-events-none", !ready)
    }
  }
}
