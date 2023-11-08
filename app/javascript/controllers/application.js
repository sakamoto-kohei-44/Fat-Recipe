import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
import Chartkick from "chartkick"
window.Chartkick = Chartkick
import "chartkick/chart.js"