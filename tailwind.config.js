/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      height: {
        'textarea': '700px',
      },
      colors: {
        customLink: '#0A3069',
        customLinkHover: '#B6E3FF',
      },
    },
  },
  plugins: [],
}

// a {
//   color: #0A3069;
// }
//
// a:hover {
//   color: #B6E3FF;
// }
