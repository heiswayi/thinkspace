# gallimore.dev

Personal site and blog for professional IT Support Engineer write-ups and home lab / hobby experiments, published at [www.gallimore.dev](https://www.gallimore.dev) via GitHub Pages.

Built with [Jekyll](https://jekyllrb.com/), plain CSS, and [Bootstrap](https://getbootstrap.com/) (via CDN — no Sass build step).

## Local development

```
bundle install
bundle exec jekyll serve
```

Then open http://localhost:4000.

## Writing a post

Add a Markdown file to `_posts/` named `YYYY-MM-DD-title.md` with front matter, e.g.:

```
---
layout: post
title: "Post title"
description: "One-line summary for SEO/social previews"
categories: [homelab]   # or [professional]
---

Post content here.
```

`categories` drives the small badge shown next to the post on the home page and post header — use `professional` or `homelab` to signal which hat was on.
