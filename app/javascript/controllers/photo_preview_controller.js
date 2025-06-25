import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]
  
  initialize() {
    this.preview = this.preview.bind(this)
  }

  connect() {
    console.log("✅ Controller connected to:", this.element)
    
    // Test FileReader API immediately
    this.testFileReader()
    
    // Bind to input with Turbo safety
    if (this.hasInputTarget) {
      this.inputTarget.addEventListener("change", this.preview)
    }
  }

  disconnect() {
    if (this.hasInputTarget) {
      this.inputTarget.removeEventListener("change", this.preview)
    }
  }

  testFileReader() {
    const testFile = new File(['test'], 'image.png', { type: 'image/png' })
    const reader = new FileReader()
    
    reader.onload = (e) => console.log("TEST SUCCESS:", e.target.result.substring(0, 50))
    reader.onerror = (e) => console.error("TEST ERROR:", e)
    reader.onabort = () => console.warn("TEST ABORTED")
    
    reader.readAsDataURL(testFile)
  }

  preview(event) {
    console.log("📸 File change detected")
    
    // Verify targets
    if (!this.hasInputTarget || !this.hasPreviewTarget) {
      console.error("⚠️ Missing required targets")
      return
    }

    const maxFiles = 5
    const files = Array.from(event.target.files)
    this.previewTarget.innerHTML = ""

    if (files.length > maxFiles) {
      this.previewTarget.innerHTML = `<div class="alert alert-danger">Max 5 images allowed.</div>`
      event.target.value = ""
      return
    }

    files.forEach((file) => {
      console.log("🔍 Processing:", file.name, file.type, `${(file.size/1024).toFixed(1)}KB`)
      
      if (!["image/jpeg", "image/png"].includes(file.type)) {
        const warning = document.createElement('div')
        warning.className = 'alert alert-warning mb-2'
        warning.textContent = `${file.name} is not a JPEG or PNG.`
        this.previewTarget.appendChild(warning)
        return
      }

      const reader = new FileReader()
      
      reader.onload = (e) => {
        console.log("🖼️ Loaded:", file.name, e.target.result.substring(0, 20))
        this.createImageThumbnail(e.target.result)
      }
      
      reader.onerror = (e) => console.error("Reader error:", e)
      reader.onabort = () => console.warn("Reader aborted")
      
      reader.readAsDataURL(file)
    })
  }

  createImageThumbnail(dataURL) {
    const img = document.createElement("img")
    img.src = dataURL
    img.className = "img-thumbnail col-4 mb-2 me-2"
    img.style.maxHeight = "200px"
    this.previewTarget.appendChild(img)
  }
}