import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  static targets = ["container"]

  connect() {
    const container = this.containerTarget || document.getElementById('questions')
    this.isInitialLoad = true
    
    // Instantly scroll to bottom on initial load (no animation)
    this.scrollToBottom(false)
    
    // Set up observer for new messages after initial load
    setTimeout(() => {
      this.isInitialLoad = false
      this.setupObserver(container)
    }, 50)
  }

  setupObserver(container) {
    // Observe DOM changes (new messages being added)
    const observer = new MutationObserver(() => {
      this.scrollToBottom(true) // smooth scroll for new messages
    })
    observer.observe(container, { childList: true, subtree: true })
    
    // Listen for Turbo stream events (AI responses)
    document.addEventListener('turbo:before-stream-render', () => {
      setTimeout(() => this.scrollToBottom(true), 100)
    })
  }

  disconnect() {
    // Clean up event listeners if needed
  }

  scrollToBottom(smooth = false) {
    const container = this.containerTarget || document.getElementById('questions')
    if (container) {
      if (smooth) {
        container.scrollTo({
          top: container.scrollHeight,
          behavior: 'smooth'
        })
      } else {
        // Instant scroll for initial load
        container.scrollTop = container.scrollHeight
      }
    }
  }

  // Method that can be called externally if needed
  scrollToLatestMessage() {
    this.scrollToBottom(true)
  }
}
