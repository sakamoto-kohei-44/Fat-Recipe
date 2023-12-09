import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "./controllers"
import "./custom/chartkick"
import "chartkick/chart.js"
import "./custom/modal_spinner"