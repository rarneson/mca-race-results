import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["input"]
  static values = {
    url: String,
    params: { type: Object, default: {} },
    delay: { type: Number, default: 300 }
  }

  connect() {
    this.timeout = null
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  search() {
    clearTimeout(this.timeout)
    this.syncFilterControls()
    this.timeout = setTimeout(() => this.performSearch(), this.delayValue)
  }

  // Year tabs and the team filter are plain server-rendered links/forms. Sync
  // them on every keystroke so navigating mid-type keeps the current query,
  // rather than waiting for the debounced request to re-render them.
  syncFilterControls() {
    const query = this.inputTarget.value.trim()

    document.querySelectorAll("[data-search-link]").forEach((link) => {
      const url = new URL(link.href, window.location.origin)
      query.length > 0 ? url.searchParams.set("search", query) : url.searchParams.delete("search")
      link.href = url.toString()
    })

    document.querySelectorAll("[data-search-field]").forEach((field) => {
      field.value = query
    })
  }

  clear() {
    if (this.inputTarget.value !== "") {
      this.inputTarget.value = ""
      this.search()
    }
    this.inputTarget.focus()
  }

  handleKeydown(event) {
    if (event.key === "Escape") this.clear()
  }

  async performSearch() {
    const url = this.requestUrl

    try {
      const response = await fetch(url, {
        headers: { "Accept": "text/vnd.turbo-stream.html" }
      })

      if (!response.ok) return

      await Turbo.renderStreamMessage(await response.text())
      window.history.replaceState(window.history.state, "", url.toString())
    } catch (error) {
      console.error("Search failed:", error)
    }
  }

  // Carries the page's active filters (year, team, ...) so search stays scoped
  // to whatever the user is currently looking at.
  get requestUrl() {
    const url = new URL(this.urlValue, window.location.origin)

    Object.entries(this.paramsValue).forEach(([ key, value ]) => {
      if (value !== null && value !== undefined && value !== "") {
        url.searchParams.set(key, value)
      }
    })

    const query = this.inputTarget.value.trim()
    if (query.length > 0) url.searchParams.set("search", query)

    return url
  }
}
