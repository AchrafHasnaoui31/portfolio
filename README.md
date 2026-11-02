# Achraf Hasnaoui — Hugo Portfolio

Data-driven personal portfolio built with Hugo and deployed to GitHub Pages through GitHub Actions. Projects are presented as technical case studies rather than disconnected links.

## What it demonstrates

- Hugo content collections for individual project pages.
- Centralized profile data in `data/portfolio.yaml`.
- Reusable layouts and partials.
- Responsive styling and static assets.
- Automated build and deployment on pushes to `main`.

## Content model

- `content/projects/`: one Markdown page per project.
- `data/portfolio.yaml`: profile, skills, education, and contact data.
- `layouts/`: templates and page composition.
- `.github/workflows/deploy.yml`: deployment automation.

## Local development

```bash
hugo server -D
```

Build the production site with `hugo --minify`.

## Problems solved

- Keeps content editable without changing templates.
- Makes the portfolio reproducible and reviewable through Git.
- Gives every project a consistent recruiter-friendly presentation.

## Roadmap

- Add architecture diagrams, screenshots, and measured outcomes.
- Add accessibility, link-check, and performance CI jobs.
- Add multilingual content parity checks.
- Add structured metadata and project quality indicators.

## Status

Active portfolio site evolving with the underlying projects.