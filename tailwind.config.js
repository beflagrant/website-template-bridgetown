/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/**/*.{html,md,liquid,erb,serb,rb}',
    './frontend/javascript/**/*.js',
    './src/_components/**/*.{rb,erb,liquid}'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}

