import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["viewer", "arButton"]
  
  connect() {
    this.setupARButton()
  }
  
  setupARButton() {
    const arButton = this.arButtonTarget
    const viewer = this.viewerTarget
    
    arButton.addEventListener('click', async (event) => {
      // Check if it's iOS
      const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent)
      
      // If it's an iOS device and the button is an <a> tag, we let the native 
      // Safari Quick Look handle it directly! This bypasses the download and security prompts.
      if (isIOS && arButton.tagName.toUpperCase() === 'A') {
        return // Let the default <a> click happen!
      }
      
      // For Android / WebXR or fallback, we intercept
      event.preventDefault()
      event.stopPropagation()
      
      try {
        // Let model-viewer handle WebXR natively
        viewer.activateAR()
      } catch (error) {
        console.error('AR activation failed:', error)
      }
    })
  }
}