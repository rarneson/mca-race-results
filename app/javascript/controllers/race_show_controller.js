import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "row", "tbody", "expanded",
    "search", "sortIndicator",
    "tableWrap", "emptyState", "emptyQuery",
    "visibleCount", "filteredFlag"
  ]

  connect() {
    this.sortKey = "pos"
    this.sortDir = "asc"
    this.totalRows = this.rowTargets.length
    this.updateVisibleCount(this.totalRows, false)
  }

  search(event) {
    const q = (event ? event.target.value : this.searchTarget.value).trim().toLowerCase()
    let visible = 0

    this.rowTargets.forEach((row) => {
      const matches = q === "" || (row.dataset.search || "").includes(q)
      row.classList.toggle("hidden", !matches)
      const expanded = this.expandedRowFor(row)
      if (expanded) {
        if (!matches) {
          expanded.classList.add("hidden")
          row.classList.remove("expanded")
        }
      }
      if (matches) visible++
    })

    if (visible === 0 && q !== "") {
      this.tableWrapTarget.classList.add("hidden")
      this.emptyStateTarget.classList.remove("hidden")
      this.emptyQueryTarget.textContent = q
    } else {
      this.tableWrapTarget.classList.remove("hidden")
      this.emptyStateTarget.classList.add("hidden")
    }

    this.updateVisibleCount(visible, q !== "")
  }

  clearSearch() {
    this.searchTarget.value = ""
    this.search()
    this.searchTarget.focus()
  }

  sort(event) {
    const key = event.currentTarget.dataset.key
    if (this.sortKey === key) {
      this.sortDir = this.sortDir === "asc" ? "desc" : "asc"
    } else {
      this.sortKey = key
      this.sortDir = "asc"
    }
    this.applySort()
    this.updateSortIndicators()
    this.collapseAll()
  }

  applySort() {
    const dir = this.sortDir === "asc" ? 1 : -1
    const rows = Array.from(this.rowTargets)

    rows.sort((a, b) => {
      const aDnf = a.dataset.dnf === "true"
      const bDnf = b.dataset.dnf === "true"
      if (aDnf && !bDnf) return 1
      if (bDnf && !aDnf) return -1

      const av = a.dataset[this.sortKey] ?? ""
      const bv = b.dataset[this.sortKey] ?? ""

      if (this.sortKey === "name" || this.sortKey === "team") {
        return av.localeCompare(bv) * dir
      }
      return (parseFloat(av) - parseFloat(bv)) * dir
    })

    rows.forEach((row) => {
      const expanded = this.expandedRowFor(row)
      this.tbodyTarget.appendChild(row)
      if (expanded) this.tbodyTarget.appendChild(expanded)
    })
  }

  updateSortIndicators() {
    this.sortIndicatorTargets.forEach((ind) => {
      const key = ind.dataset.key
      if (key === this.sortKey) {
        ind.textContent = this.sortDir === "asc" ? "▲" : "▼"
        ind.classList.remove("text-hud-border")
        ind.classList.add("text-hud-accent")
      } else {
        ind.textContent = "◇"
        ind.classList.remove("text-hud-accent")
        ind.classList.add("text-hud-border")
      }
    })
  }

  toggleExpand(event) {
    if (event.target.closest("a")) return

    const row = event.currentTarget
    const expanded = this.expandedRowFor(row)
    if (!expanded) return

    const isOpen = !expanded.classList.contains("hidden")
    this.collapseAll()

    if (!isOpen) {
      expanded.classList.remove("hidden")
      row.classList.add("expanded")
    }
  }

  collapseAll() {
    this.expandedTargets.forEach((e) => e.classList.add("hidden"))
    this.rowTargets.forEach((r) => r.classList.remove("expanded"))
  }

  expandedRowFor(row) {
    const next = row.nextElementSibling
    if (next && next.dataset && Object.prototype.hasOwnProperty.call(next.dataset, "raceShowTarget") === false) {
      // dataset.raceShowTarget might not survive case mapping; fall back to attribute check
    }
    if (next && next.getAttribute && next.getAttribute("data-race-show-target") === "expanded") {
      return next
    }
    return null
  }

  updateVisibleCount(visible, filtered) {
    if (this.hasVisibleCountTarget) this.visibleCountTarget.textContent = visible
    if (this.hasFilteredFlagTarget) {
      this.filteredFlagTarget.classList.toggle("hidden", !filtered)
    }
  }
}
