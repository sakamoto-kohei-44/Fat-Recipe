/** @type {import('tailwindcss').Config} */
module.exports = {
  purge: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        'custom': ['Roboto', 'sans'],
      },
    },
  },
  variants: {},
  plugins: [
    require('daisyui'),
  ],
}
