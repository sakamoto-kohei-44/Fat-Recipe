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
        primary: '#4ade80',
      },
      svgBackground: {
        width: '100%',
        height: 'auto',
        display: 'block',
      },
      keyframes: {
        float1: {
          '0%, 100%': { transform: 'translateY(0)' },
          '50%': { transform: 'translateY(-10px)' },
        },
        float2: {
          '0%, 100%': { transform: 'translateY(0)' },
          '50%': { transform: 'translateY(-25px)' },
        },
      },
      animation: {
        float1: 'float1 7s ease-in-out infinite',
        float2: 'float2 6s ease-in-out infinite',
      },
    },
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["retro", "cupcake", "valentine"],
  },
}
