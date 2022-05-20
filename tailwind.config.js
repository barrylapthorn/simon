const colors = require('tailwindcss/colors');

module.exports = {
  darkMode: 'class', // or 'media' or 'class'
  content: ['layouts/**/*.html'],
  theme: {
    extend: {
      colors: {
        'regal-blue': '#243c5a',
      }
    },
  },
  variants: {
    extend: {
      display: ['dark'],
      minWidth : ['hover'],
    },
  },
  plugins: [],
};
