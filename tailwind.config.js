const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],

  theme: {
    extend: {
      fontFamily: {
      },
      colors: {
      },
    },
  },

  plugins: [require("daisyui")],
  daisyui: {
    themes: ["retro", "cupcake", "valentine"],
  },
}