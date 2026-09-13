# Portfolio — Hugo edition

Same design as before, same GitHub Actions deploy pipeline as
[blog](../blog): push to `main`, GitHub Pages rebuilds automatically. No
`admin.html`, no `localStorage`, no build step to run yourself.

Everything on the site is now editable the same way you edit the blog:
**personal info & sections** live in one data file, and **projects** live
as individual pages in `content/projects/`, exactly like blog posts live in
`content/posts/`.

## Editing your info (name, bio, skills, education, contact…)

Everything except projects lives in:

```
data/portfolio.yaml
```

Open it, change a value, commit, push. A few notes:

- `**bold**` inside text fields renders as **bold** automatically.
- `skills.groups[].items[].level` is a 0–100 number that drives the animated
  skill bar width.
- Emoji in `hero.cardInfo` lines are read as "first word = icon, rest = text",
  so keep the emoji first (e.g. `"📍 Tunis, Tunisia"`).
- `hero.photo` and `about.photo` control the two round photos on the page
  (see "Adding your photo" below). Leave them as `""` to keep the default
  letter-badge / emoji look.

## Adding a project

Each project is its own file in `content/projects/`, and gets:
- a card on the homepage `#projects` section
- its own full page at `/projects/<slug>/` with your full write-up
- a spot on the `/projects/` "all projects" archive page

**To add one**, create a new file, e.g. `content/projects/my-cool-app.md`:

```yaml
---
title: "My Cool App"
date: 2026-09-13
draft: false
weight: 1            # controls order — lower numbers show first
summary: "One or two sentences. This is what shows on the homepage card."
tags: ["React", "Node.js", "PostgreSQL"]
cover: "images/projects/my-cool-app/cover.jpg"   # optional, see below
repo: "https://github.com/you/my-cool-app"
demo: "https://my-cool-app.example.com"           # optional, omit if none
---

Write the full story of the project here in Markdown: what it does, how
you built it, what was tricky, what you learned. Use `##` for subheadings,
add more images, code blocks, whatever you want — this text only shows on
the project's own page, not on the homepage card.
```

Commit, push, done. If you have the Hugo CLI installed locally you can also
run `hugo new projects/my-cool-app.md` to generate this file from a
template automatically (see `archetypes/projects.md`).

**To remove a project**, delete its file. **To hide one temporarily**
without deleting it, set `draft: true`. **To reorder**, change the `weight`
numbers (lower = earlier).

## Adding your photo

1. Drop your image file in `static/images/profile/` — e.g.
   `static/images/profile/me.jpg`.
2. In `data/portfolio.yaml`, set:
   ```yaml
   hero:
     photo: "images/profile/me.jpg"
   ```
3. (Optional) Use a second photo, or the same one, for the About section
   card by setting `about.photo` the same way.

Leave either field as `""` to fall back to the original letter-badge /
emoji design — no photo required.

## Adding a project cover image

1. Drop the image somewhere under `static/images/projects/`, e.g.
   `static/images/projects/my-cool-app/cover.jpg`.
2. Set `cover: "images/projects/my-cool-app/cover.jpg"` in that project's
   front matter.

Leave `cover: ""` (or omit it) to show the card without an image.

## You never need to touch

`layouts/`, `static/css/style.css`, or `static/js/main.js` unless you want
to change the actual design or animations.

## Local preview

```bash
hugo server -D
```

Visit `http://localhost:1313/`. `-D` also shows draft projects while you're
working on them.

## Deploying

1. Push this repo to GitHub as `portfolio` (or update `baseURL` in
   `hugo.toml` to match whatever repo name/URL you actually use).
2. In **Settings → Pages**, set Source to **GitHub Actions**.
3. Push to `main` — `.github/workflows/deploy.yml` builds with Hugo and
   deploys to Pages, identical to how `blog` deploys.

## Structure

```
data/portfolio.yaml           ← edit this for name/bio/skills/education/contact
content/projects/*.md         ← one file per project (add/edit/delete freely)
static/images/profile/        ← your photo(s) go here
static/images/projects/       ← project cover images go here
archetypes/projects.md        ← template used by `hugo new projects/name.md`
layouts/index.html            ← homepage template (one-page layout)
layouts/projects/list.html    ← "all projects" archive page template
layouts/projects/single.html  ← individual project page template
layouts/partials/navbar.html  ← shared navbar (homepage + project pages)
layouts/partials/footer.html  ← shared footer (homepage + project pages)
static/css/style.css          ← original design, unchanged + project-page styles
static/js/main.js             ← typewriter, scroll-reveal, skill bars, etc.
.github/workflows/deploy.yml  ← same build/deploy pipeline as blog
```
