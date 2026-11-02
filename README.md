# Achraf Hasnaoui — Hugo Portfolio

> Data-driven technical portfolio built with Hugo and deployed through GitHub Actions to GitHub Pages.

## Purpose

This site presents software projects as engineering case studies: each project can explain the problem, architecture, trade-offs, current capabilities, and next improvements. The repository is designed so content changes do not require changes to the layout system.

## Architecture

```text
portfolio data + project Markdown -> Hugo templates -> static HTML/CSS/JS -> GitHub Pages
```

- `data/portfolio.yaml` stores profile, skills, education, and contact content.
- `content/projects/` contains one technical case study per project.
- `layouts/` contains reusable page templates and partials.
- `static/` contains CSS, JavaScript, and visual assets.
- `.github/workflows/deploy.yml` builds and deploys the site.

## Content workflow

Create a project page under `content/projects/` with front matter such as:

```yaml
---
title: "Project name"
date: 2026-11-02
draft: false
weight: 1
summary: "Short recruiter-facing value proposition."
tags: ["Angular", "Spring Boot"]
repo: "https://github.com/example/project"
demo: "https://example.com"
---
```

Use the body for the problem, solution, architecture, engineering decisions, validation, limitations, and roadmap.

## Run locally

Install Hugo, then:

```bash
git clone https://github.com/AchrafHasnaoui31/portfolio.git
cd portfolio
hugo server -D
```

Open the local URL printed by Hugo. Build production output with:

```bash
hugo --minify
```

## Problems solved

- Keeps profile data and project content editable without rewriting templates.
- Makes technical work reviewable through Git history.
- Provides consistent presentation across projects.
- Automates deployment from the default branch.

## Quality and accessibility goals

Future improvements should include link checking, accessibility checks, image optimization, metadata validation, reduced-motion support, and a performance budget.

## Roadmap

- Add architecture diagrams and measured outcomes to project pages.
- Add multilingual content parity checks.
- Add automated link, HTML, and accessibility validation.
- Add structured metadata and RSS improvements.
- Add a content checklist for truthful technology and status claims.

## Status

Active portfolio site.

## License

No open-source license is currently specified.