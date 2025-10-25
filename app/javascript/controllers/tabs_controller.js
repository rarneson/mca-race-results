import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  connect() {
    // Ensure the first tab is active on connect
    this.showTab(0)
  }

  switch(event) {
    const clickedTab = event.currentTarget
    const tabIndex = this.tabTargets.indexOf(clickedTab)
    this.showTab(tabIndex)
  }

  showTab(index) {
    // Update all tabs and content
    this.tabTargets.forEach((tab, i) => {
      if (i === index) {
        // Active tab
        tab.classList.remove('border-transparent', 'text-gray-500')
        tab.classList.add('border-gray-900', 'text-gray-900')
      } else {
        // Inactive tab
        tab.classList.remove('border-gray-900', 'text-gray-900')
        tab.classList.add('border-transparent', 'text-gray-500')
      }
    })

    this.contentTargets.forEach((content, i) => {
      if (i === index) {
        content.classList.remove('hidden')
      } else {
        content.classList.add('hidden')
      }
    })
  }
}
