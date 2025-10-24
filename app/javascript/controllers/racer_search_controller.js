import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["input", "clearButton"]
  static values = { url: String }

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)

    const query = this.inputTarget.value.trim()

    if (query.length === 0) {
      this.hideClearButton()
      // If search is empty, reload without search param
      this.clearSearch()
      return
    }

    this.showClearButton()

    this.timeout = setTimeout(() => {
      this.performSearch(query)
    }, 300)
  }

  async performSearch(query) {
    const url = `${this.urlValue}?search=${encodeURIComponent(query)}`

    try {
      const response = await fetch(url, {
        headers: {
          "Accept": "text/vnd.turbo-stream.html"
        }
      })

      if (response.ok) {
        const html = await response.text()
        await Turbo.renderStreamMessage(html)
      }
    } catch (error) {
      console.error("Search failed:", error)
    }
  }

  clear() {
    this.inputTarget.value = ""
    this.hideClearButton()
    this.clearSearch()
    this.inputTarget.focus()
  }

  async clearSearch() {
    try {
      const response = await fetch(this.urlValue, {
        headers: {
          "Accept": "text/vnd.turbo-stream.html"
        }
      })

      if (response.ok) {
        const html = await response.text()
        await Turbo.renderStreamMessage(html)
      }
    } catch (error) {
      console.error("Clear search failed:", error)
    }
  }

  showClearButton() {
    if (this.hasClearButtonTarget) {
      this.clearButtonTarget.classList.remove("hidden")
    }
  }

  hideClearButton() {
    if (this.hasClearButtonTarget) {
      this.clearButtonTarget.classList.add("hidden")
    }
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.clear()
    }
  }
}
