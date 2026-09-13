# Portfolio — Hugo edition

Same design as the previous single-page portfolio, rebuilt on **Hugo** with the
same GitHub Actions deploy pipeline as [blog](../blog): push to `main`, GitHub
Pages rebuilds automatically. No `admin.html`, no `localStorage`, no build step
to run yourself.

## Editing content

Everything on the page — name, roles, bio, skills, projects, education,
contact links, footer — lives in **one file**:

```
data/portfolio.yaml
```

Open it, change a value, commit, push. That's the whole workflow — the same
"edit a file, push, done" loop you already use for blog posts. A few notes:

- `**bold**` inside text fields renders as **bold** automatically.
- `skills.groups[].items[].level` is a 0–100 number that drives the animated
  skill bar width.
- `projects.items` — add or remove entries freely; the card color (yellow /
  pink / cyan) cycles automatically based on position.
- Emoji in `hero.cardInfo` lines are read as "first word = icon, rest = text",
  so keep the emoji first (e.g. `"📍 Tunis, Tunisia"`).

You never need to touch `layouts/index.html`, `static/css/style.css`, or
`static/js/main.js` unless you want to change the actual design or animations.

## Local preview

```bash
hugo server -D
```

Visit `http://localhost:1313/`.

## Deploying

1. Push this repo to GitHub as `portfolio` (or update `baseURL` in
   `hugo.toml` to match whatever repo name/URL you actually use).
2. In **Settings → Pages**, set Source to **GitHub Actions**.
3. Push to `main` — `.github/workflows/deploy.yml` builds with Hugo and
   deploys to Pages, identical to how `blog` deploys.

## Structure

```
data/portfolio.yaml      ← edit this for content changes
layouts/index.html       ← Hugo template (renders the whole one-page site)
static/css/style.css     ← original design, unchanged
static/js/main.js        ← typewriter, scroll-reveal, skill bars, scrollspy, etc.
.github/workflows/deploy.yml  ← same build/deploy pipeline as blog
```
