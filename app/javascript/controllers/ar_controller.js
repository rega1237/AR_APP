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
      const isAndroid = /Android/.test(navigator.userAgent)
      
      // If it's an iOS device and the button is an <a> tag, we let the native 
      // Safari Quick Look handle it directly! This bypasses the download and security prompts.
      if (isIOS && arButton.tagName.toUpperCase() === 'A') {
        return // Let the default <a> click happen!
      }
      
      // For Android / WebXR or fallback, we intercept
      event.preventDefault()
      event.stopPropagation()
      
      try {
        // Check if it's Android with WebXR support
        if (isAndroid && 'xr' in navigator) {
          // Use WebXR for Android
          this.openWebXR(viewer)
        } else if ('xr' in navigator) {
          // For other WebXR devices
          this.openWebXR(viewer)
        } else {
          // Fallback to model-viewer's default AR
          viewer.activateAR()
        }
      } catch (error) {
        console.error('AR activation failed:', error)
        // Final fallback
        viewer.activateAR()
      }
    })
  }
  
  async openWebXR(viewer) {
    try {
      // Check if WebXR AR is available
      if (navigator.xr && await navigator.xr.isSessionSupported('immersive-ar')) {
        // Request immersive AR session directly
        const session = await navigator.xr.requestSession('immersive-ar', {
          requiredFeatures: ['hit-test'],
          optionalFeatures: ['dom-overlay']
        })
        
        // Activate AR in model-viewer
        viewer.activateAR()
      } else {
        throw new Error('WebXR AR not supported')
      }
    } catch (error) {
      console.error('WebXR failed:', error)
      // Fallback to model-viewer's native AR
      viewer.activateAR()
    }
  }
}