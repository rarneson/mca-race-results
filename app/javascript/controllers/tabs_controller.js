import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]
  static values = { key: String }

  connect() {
    this.showTab(this.initialIndex())
  }

  switch(event) {
    const clickedTab = event.currentTarget
    const tabIndex = this.tabTargets.indexOf(clickedTab)
    this.showTab(tabIndex)
    this.persistIndex(tabIndex)
  }

  showTab(index) {
    this.tabTargets.forEach((tab, i) => {
      tab.classList.toggle("active", i === index)
    })

    this.contentTargets.forEach((content, i) => {
      content.classList.toggle("hidden", i !== index)
    })
  }

  // When a `key` value is set, remembers the active tab across full-page
  // navigations (e.g. switching years) that re-render this controller.
  initialIndex() {
    if (!this.hasKeyValue) return 0

    const stored = this.readStoredIndex()
    return stored !== null && stored < this.tabTargets.length ? stored : 0
  }

  persistIndex(index) {
    if (!this.hasKeyValue) return

    try {
      window.localStorage.setItem(this.storageKey, String(index))
    } catch (e) {
      // localStorage unavailable (private browsing, disabled, etc.) — ignore
    }
  }

  readStoredIndex() {
    try {
      const raw = window.localStorage.getItem(this.storageKey)
      return raw === null ? null : parseInt(raw, 10)
    } catch (e) {
      return null
    }
  }

  get storageKey() {
    return `tabs:${this.keyValue}`
  }
}
