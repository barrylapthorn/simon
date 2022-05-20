---
date: "2021-01-31T15:50:28Z"
title: "Tailwind Dark Mode"
description: ""
tags:
  - tailwind
  - css
  - html
  - javascript
categories:
  - tailwind
  - css
  - html
  - javascript
summary: "A quick description of how to get Tailwindcss dark mode working with Hugo"
---

Adding a [dark mode toggle](https://tailwindcss.com/docs/dark-mode) to your site using Tailwind is fairly straightforward.

Firstly, we ensure that dark mode is enabled, and also enabled for `display` elements,
by editing our `tailwind.config.js`:

```javascript
module.exports = {
  darkMode: 'class', // or 'media' or 'class'
  variants: {
    extend: {
      display: ['dark']
    },
  },
};
```

Then we create two buttons, one to toggle to light mode, and the other to dark:

```html
<div>
    <button class="colour-mode__btn hidden dark:block focus:outline-none">
        <span><!-- sun.svg --></span>
    </button>
    <button class="colour-mode__btn dark:hidden focus:outline-none">
        <span><!-- moon.svg --></span>
    </button>
</div>
```

You can get a sun and moon svg from the [heroicons site](https://heroicons.com/)
and just paste them inline.

In the html we are doing a few things:

* tagging the buttons with the empty class `colour-mode__btn` (that's [BEM](https://www.freecodecamp.org/news/css-naming-conventions-that-will-save-you-hours-of-debugging-35cea737d849/) naming).
* leveraging Tailwind's dark mode to hide the Sun button in light mode, and hide the Moon button in dark mode.

Finally, we need a tiny bit of javascript:

```javascript
var toggleColourMode = function toggleColourMode(e) {
  if (e.currentTarget.classList.contains("dark:hidden")) {
    document.documentElement.classList.add('dark')
    localStorage.setItem("theme", "dark");
    return;
  }
  document.documentElement.classList.remove('dark')
  localStorage.setItem("theme", "light");
};

// Export if you're using this in a build.
/* export */ function buttonColourMode() {
  var toggleButtons = document.querySelectorAll(".colour-mode__btn");
  toggleButtons.forEach(function(btn) {
    btn.addEventListener("click", toggleColourMode);
  });
  if (localStorage.getItem("theme") === "dark") { document.documentElement.classList.add('dark'); };
}
```

We use the empty class `colour-mode__btn` to identify the two toggle buttons, then add
a `click` handler.  The `click` handler then checks to see if the element is either the
dark mode button (has `dark:hidden` in the `classList`), or not, and sets the document class and storage appropriately.

Finally call this method when the document loads, e.g.

```javascript
const load = () => {
  buttonColourMode();
};

window.onload = load;
```

### Hugo

If you're using [Hugo](https://www.gohugo.io) then and running [purgecss](https://purgecss.com/)
then you seem to need to add some empty spans with the `light` and `dark` classes
to ensure the purging executes correctly in `production` mode:

```html
<div>
    <button class="colour-mode__btn hidden dark:block focus:outline-none">
        <span>{{ partial "svg/sun.svg" . }}</span>
    </button>
    <button class="colour-mode__btn dark:hidden focus:outline-none">
        <span>{{ partial "svg/moon.svg" . }}</span>
    </button>
    <!-- ensure hugo captures these classes in hugo_stats.json when we run purgecss -->
    <span class="light"></span><span class="dark"></span>
</div>
```

Your `<theme>/assets/css/postcss.config.js` should look something like:

```javascript
const themeDir = __dirname + "/../../";

const removeNewlines = (string) => string.replace(/\n$/g, "");

// See https://gohugo.io/hugo-pipes/postprocess/#css-purging-with-postcss
const purgecss = require("@fullhuman/postcss-purgecss")({
  content: [
    "./hugo_stats.json",
    "../../hugo_stats.json",
    "./exampleSite/hugo_stats.json",
  ],
  defaultExtractor: (content) => {
    let els = JSON.parse(content).htmlElements;
    return els.tags.concat(els.classes, els.ids).map(removeNewlines);
  },
});

// See https://tailwindcss.com/docs/configuration#using-a-different-file-name

module.exports = {
  plugins: [
    require("postcss-import")({ path: [themeDir] }),
    require("tailwindcss")({config: themeDir + 'assets/css/tailwind.config.js'}),
    require("autoprefixer")({ path: [themeDir] }),
    ...(process.env.HUGO_ENVIRONMENT === "production" || process.env.NODE_ENV === "production"? [purgecss] : []),
  ],
};
```

Our folder structure is:

```shell
themes/<theme>/assets/css
├── main.css
├── postcss.config.js
└── tailwind.config.js
```
