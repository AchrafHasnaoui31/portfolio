# Achraf Hasnaoui — Technical Portfolio

> A data-driven Hugo portfolio that presents software engineering, AI, cybersecurity, IoT, embedded-systems, and full-stack projects as structured technical case studies.

[![Hugo](https://img.shields.io/badge/Hugo-static%20site-FF4088?style=flat-square&logo=hugo&logoColor=white)](https://gohugo.io/)
[![GitHub Pages](https://img.shields.io/badge/deployed%20with-GitHub%20Pages-222222?style=flat-square&logo=github&logoColor=white)](https://pages.github.com/)
[![GitHub Actions](https://img.shields.io/badge/automation-GitHub%20Actions-2088FF?style=flat-square&logo=github-actions&logoColor=white)](https://github.com/features/actions)
[![Status](https://img.shields.io/badge/status-active%20portfolio-0F766E?style=flat-square)](#current-state)

Live site: [achrafhasnaoui31.github.io/portfolio](https://achrafhasnaoui31.github.io/portfolio/)

## Table of contents

- [Project overview](#project-overview)
- [Purpose and audience](#purpose-and-audience)
- [Current state](#current-state)
- [What the portfolio demonstrates](#what-the-portfolio-demonstrates)
- [Site architecture](#site-architecture)
- [Content model](#content-model)
- [Portfolio sections](#portfolio-sections)
- [Project case studies](#project-case-studies)
- [Repository structure](#repository-structure)
- [Technology choices](#technology-choices)
- [Local development](#local-development)
- [Content workflow](#content-workflow)
- [Deployment workflow](#deployment-workflow)
- [Validation checklist](#validation-checklist)
- [Design and UX principles](#design-and-ux-principles)
- [Known limitations](#known-limitations)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

## Project overview

This repository contains the personal technical portfolio of Achraf Hasnaoui, a computer engineering student at ENSIT. The site is built as a static Hugo application and deployed to GitHub Pages through GitHub Actions.

The portfolio is intentionally more than a collection of links. It combines:

- A recruiter-facing profile and professional positioning.
- A centralized data file for identity, skills, experience, education, activities, and contact information.
- Markdown project pages that describe technical work consistently.
- Reusable Hugo templates and partials.
- A responsive visual system implemented with static CSS and JavaScript.
- An automated publishing workflow triggered by changes to `main`.

The result is a maintainable portfolio where content can evolve without repeatedly rewriting the presentation layer.

## Purpose and audience

The site is designed for:

- Recruiters evaluating software engineering candidates.
- Engineering managers looking for evidence of practical delivery.
- Technical reviewers interested in architecture, security, AI, IoT, and systems work.
- Internship supervisors evaluating project scope and learning trajectory.
- Collaborators looking for a concise view of technical interests and experience.

The content emphasizes problems addressed, technologies used, project context, engineering interests, and future potential. It should remain factual: a project description is not intended to imply production readiness, measured performance, or certification unless those claims are explicitly supported.

## Current state

**Status: active portfolio site.**

The current repository contains:

| Area | State | Implementation |
|---|---:|---|
| Hugo site generation | ✅ Implemented | Static pages generated from templates, data, and Markdown |
| Home page | ✅ Implemented | Profile, hero, skills, experience, projects, education, activities, and contact sections |
| Project collection | ✅ Implemented | Eight project pages under `content/projects/` |
| Centralized profile data | ✅ Implemented | `data/portfolio.yaml` drives most homepage content |
| Responsive styling | ✅ Implemented | Custom CSS with responsive layout rules |
| Interactive behavior | ✅ Implemented | Navigation and lightweight frontend behavior in `static/js/main.js` |
| GitHub Pages deployment | ✅ Implemented | GitHub Actions workflow publishes the generated site |
| Draft preview | ✅ Supported | `hugo server -D` includes draft content locally |
| Automated quality checks | 🟡 Partial | Build/deploy automation exists; link, accessibility, and performance checks remain roadmap items |
| Multilingual content | 🟡 Partial | Profile data is primarily English with some French-oriented context; full language parity is not implemented |
| CMS/admin panel | ❌ Not included | Content is intentionally edited in Git |

This README describes the repository as it exists today. Proposed improvements are kept in the roadmap rather than presented as completed functionality.

## What the portfolio demonstrates

### Engineering breadth

The portfolio brings together projects across:

- Full-stack and backend development.
- Web and mobile applications.
- AI-assisted and remote-monitoring concepts.
- Cybersecurity and capture-the-flag infrastructure.
- Access-control models and database security.
- IoT, ESP32, embedded systems, and authentication hardware.
- Object-oriented modeling and simulation.
- Freelance delivery and technical communication.

### Engineering habits

The site itself demonstrates:

- Separation of content from presentation.
- Reusable templates and partials.
- Static-first deployment with low operational complexity.
- Version-controlled content changes.
- Automated publication from the default branch.
- A consistent structure for communicating technical work.

### Problems solved by the repository design

- **Content duplication:** profile information is centralized in `data/portfolio.yaml`.
- **Inconsistent project presentation:** project pages follow a shared Hugo template.
- **High deployment overhead:** the site is generated as static files and hosted on GitHub Pages.
- **Slow content iteration:** profile and project content can be changed without modifying layouts.
- **Weak traceability:** all content changes are reviewable through Git history and pull requests.

## Site architecture

```text
portfolio.yaml + project Markdown
                │
                ▼
             Hugo
                │
                ├── layouts/index.html
                ├── layouts/projects/*
                ├── layouts/partials/*
                └── static/css + static/js + assets
                │
                ▼
          Static HTML/CSS/JS
                │
                ▼
          GitHub Pages deployment
```

### Rendering model

1. Hugo reads `hugo.toml` for site configuration.
2. Hugo loads structured profile data from `data/portfolio.yaml`.
3. Hugo reads project Markdown files from `content/projects/`.
4. Templates in `layouts/` compose the homepage and project pages.
5. Static assets from `static/` are copied and referenced using Hugo URL helpers.
6. The generated site is published to GitHub Pages by `.github/workflows/deploy.yml`.

### Runtime characteristics

- No application server is required after generation.
- No runtime database is required.
- No user authentication or account system is present.
- No admin panel is included.
- The site can be hosted on any static-file platform, although the configured deployment target is GitHub Pages.

## Content model

### Central profile data

`data/portfolio.yaml` is the primary content source for the homepage. It contains:

- Metadata and SEO description.
- Logo and navigation links.
- Hero greeting, roles, tagline, status, and profile card.
- Technology marquee.
- About paragraphs, technologies, and quick facts.
- Skill groups and indicative levels.
- Professional experience and tags.
- Project section labels.
- Education, certifications, and languages.
- Activities, competitions, writing, volunteering, and hobbies.
- Contact links and footer text.

This structure allows a content update such as changing the internship status, adding a skill, or updating contact links without editing the HTML templates.

### Project Markdown

Project pages live in `content/projects/`. A page starts with front matter:

```yaml
---
title: "Project name"
date: 2026-11-02
draft: false
weight: 1
summary: "Short recruiter-facing value proposition."
tags: ["Python", "Security"]
cover: ""
---
```

The Markdown body should explain:

1. The problem or context.
2. The implemented solution.
3. The technical architecture.
4. The main features.
5. The technology choices.
6. Validation or testing performed.
7. Current limitations.
8. Realistic future improvements.

### Archetype

`archetypes/projects.md` provides a starting template for new project pages. Using the archetype keeps metadata consistent and reduces accidental omissions.

## Portfolio sections

The homepage is organized into the following sections:

| Section | Purpose |
|---|---|
| Hero | Introduces identity, engineering focus, current status, and contact direction |
| About | Summarizes background, interests, and frequently used technologies |
| Skills | Groups technologies and engineering capabilities |
| Experience | Presents internships and freelance work with responsibilities and tags |
| Projects | Links to technical project case studies |
| Education | Documents degree path, certifications, and languages |
| Activities | Shows cybersecurity, competitions, writing, volunteering, sports, and making |
| Contact | Provides professional contact channels and internship availability |

## Project case studies

The current collection includes eight project pages:

| Project | Main themes |
|---|---|
| Remote Medical Monitoring App | Flutter, Python, Firebase, IoT, AI, anomaly detection |
| Sports Teams & Competitions Platform | PHP, MySQL, React, authentication, dashboards |
| Freelance Marketplace Mobile App | Ionic, Flask, MongoDB, mobile/backend integration |
| ESP32 Smart Key | Embedded systems, IoT, credential and OTP storage |
| CTF Platform | Cybersecurity training, competitions, forensics, cryptography |
| Airport Management & Simulation | C++, OOP, flights, runways, passengers, OODB |
| Access Control Management App | RBAC, MAC, DAC, SBAC, Chinese Wall |
| Car Rental E-commerce App | Web commerce and online vehicle rental |

The project pages are intentionally concise content artifacts rather than full source repositories. When a project has a separate implementation repository, the portfolio page can serve as the recruiter-facing entry point while the implementation repository contains the deeper code documentation.

## Repository structure

```text
portfolio/
├── .github/
│   └── workflows/
│       └── deploy.yml              # GitHub Pages build and deployment
├── archetypes/
│   └── projects.md                 # New project content template
├── content/
│   └── projects/
│       ├── _index.md
│       └── *.md                    # Project case studies
├── data/
│   └── portfolio.yaml              # Homepage content model
├── layouts/
│   ├── index.html                  # Homepage composition
│   ├── projects/
│   │   ├── list.html               # Project collection page
│   │   └── single.html             # Individual project page
│   └── partials/
│       ├── footer.html
│       └── navbar.html
├── static/
│   ├── css/style.css               # Visual system and responsive rules
│   ├── js/main.js                  # Client-side interactions
│   └── favicon.*                   # Site icons
├── hugo.toml                       # Hugo configuration
├── update_portfolio.sh              # Content-oriented update helper
└── README.md
```

## Technology choices

### Hugo

Hugo provides fast static generation, Markdown content support, front matter, data files, templates, partials, and deployment-friendly output. It is well suited to a portfolio because the resulting site has no server-side runtime dependency.

### YAML data

The profile is maintained as structured YAML instead of being hard-coded into a large template. This makes recurring updates more approachable and gives the content a clear schema.

### Custom HTML/CSS/JavaScript

The site uses custom templates and styles rather than a heavyweight frontend framework. This keeps the generated output small and makes the visual design directly reviewable in the repository.

### GitHub Actions and Pages

The workflow turns a push to `main` into a reproducible build and deployment. GitHub Pages provides hosting without requiring a separate application server or database.

## Local development

### Prerequisites

- Hugo Extended, preferably a current stable release.
- Git.
- A modern browser.

Check the installation:

```bash
hugo version
git --version
```

### Clone the repository

```bash
git clone https://github.com/AchrafHasnaoui31/portfolio.git
cd portfolio
```

### Start the development server

```bash
hugo server -D
```

The `-D` flag includes draft pages. Open the local URL printed by Hugo, usually:

```text
http://localhost:1313/portfolio/
```

Hugo watches the repository and rebuilds the site when content, templates, styles, or configuration change.

### Build the production site

```bash
hugo --minify
```

The generated site is written to `public/`, which is ignored by Git and should not be committed.

### Build with a clean output directory

```bash
hugo --cleanDestinationDir --minify
```

### Preview production-like output

```bash
hugo --cleanDestinationDir --minify
hugo server --disableLiveReload --navigateToChanged=false
```

## Content workflow

### Update profile information

Edit:

```text
data/portfolio.yaml
```

Typical updates include:

- Current degree or internship status.
- Skills and technology groups.
- Experience entries.
- Project labels.
- Certifications and languages.
- Contact links.

Keep the content factual and avoid claiming metrics, production deployment, or expertise levels that are not supported by project evidence.

### Add a project

Create a page from the archetype:

```bash
hugo new projects/my-project.md
```

Then update the generated front matter and write the case study. Set:

```yaml
draft: false
```

when the page is ready to appear in production.

### Update visual design

- Global styling: `static/css/style.css`.
- Client-side interactions: `static/js/main.js`.
- Homepage composition: `layouts/index.html`.
- Navigation: `layouts/partials/navbar.html`.
- Footer: `layouts/partials/footer.html`.
- Project list and detail pages: `layouts/projects/`.

### Use the update helper

`update_portfolio.sh` is a content-oriented helper whose comments describe the intended editing workflow. Review the script before using it in a new environment and keep any generated changes visible in Git diff.

## Deployment workflow

Deployment is defined in `.github/workflows/deploy.yml`.

### Trigger

The workflow runs on:

- Pushes to `main`.
- Manual `workflow_dispatch`.

### Expected pipeline

```text
Git push / manual dispatch
        │
        ▼
Checkout repository
        │
        ▼
Install Hugo
        │
        ▼
Build static site
        │
        ▼
Upload Pages artifact
        │
        ▼
Deploy to GitHub Pages
```

The workflow uses GitHub Pages permissions and the repository's configured Pages environment. The exact action versions and build flags should be treated as the source of truth in `.github/workflows/deploy.yml`.

### Deployment checklist

Before pushing a content change:

1. Run the local Hugo build.
2. Review the generated page in a browser.
3. Check project links and contact links.
4. Confirm no secrets or private information were added.
5. Inspect `git diff`.
6. Push to `main` or open a pull request according to repository workflow.
7. Review the GitHub Actions deployment result.

## Validation checklist

### Required local checks

```bash
hugo --cleanDestinationDir --minify
```

### Content checks

- Every project page has valid front matter.
- Published pages use `draft: false`.
- Dates and weights are intentional.
- Links resolve to the intended repository, demo, blog, or profile.
- Technology names match the actual project.
- Claims distinguish implemented work from future plans.
- Contact details are current.

### Visual checks

- Homepage loads at desktop width.
- Navigation anchors reach the intended sections.
- Project list renders all published projects.
- Individual project pages render Markdown correctly.
- Layout remains usable on a narrow mobile viewport.
- Text remains readable against the selected theme colors.
- Images and favicons load without broken paths.

### Future automated checks

The repository does not currently include dedicated link-check, HTML validation, accessibility, Lighthouse, or visual-regression jobs. These are recommended additions as the site grows.

## Design and UX principles

- **Content first:** technical evidence should be easy to scan.
- **Recruiter-friendly hierarchy:** role, strengths, experience, projects, and contact are visible without requiring repository exploration.
- **Consistent case studies:** project pages use shared metadata and layout.
- **Low operational complexity:** static output avoids a runtime backend.
- **Responsive presentation:** the layout is intended for desktop and mobile browsing.
- **Human tone:** the site communicates personality and interests without replacing technical substance.
- **Truthful status:** completed work, active work, and future ideas should remain distinguishable.

## Known limitations

- No automated link checker is currently configured.
- No automated accessibility audit is currently configured.
- No performance budget or Lighthouse threshold is enforced in CI.
- The site is primarily English and does not provide complete multilingual content parity.
- Some project pages are brief and would benefit from architecture diagrams, screenshots, test evidence, and measured outcomes.
- Skill percentages in the data file are indicative self-assessments, not standardized assessments.
- The site has no CMS, so non-technical editors must modify files and understand Git/Hugo basics.
- The deployment workflow depends on GitHub Pages configuration and repository permissions.
- No formal content schema validation is present for `portfolio.yaml`.
- No analytics or privacy-preserving usage measurement is configured.
- No automated image optimization pipeline is included.

## Roadmap

### Content quality

- Expand each project into a complete case study with context, architecture, trade-offs, validation, limitations, and roadmap.
- Add screenshots and diagrams where they improve understanding.
- Link each portfolio project to its implementation repository when available.
- Add measurable outcomes only when reproducible evidence exists.
- Add a content review checklist for recruiter-facing claims.

### Accessibility and performance

- Add automated axe or equivalent accessibility checks.
- Add semantic HTML and keyboard-navigation regression checks.
- Add reduced-motion support where animations are introduced.
- Optimize image formats and sizes.
- Add a Lighthouse performance budget.
- Validate color contrast and focus states automatically.

### SEO and discoverability

- Add Open Graph and Twitter card metadata.
- Add canonical URLs and structured person/project metadata.
- Re-enable and validate sitemap/RSS output when useful.
- Add a custom domain if appropriate.
- Add social preview images.

### Engineering workflow

- Add Hugo version pinning.
- Add a CI build job for pull requests.
- Add Markdown/front-matter validation.
- Add link checking for internal and external URLs.
- Add HTML validation after generation.
- Add preview deployments for pull requests.

### Internationalization and privacy

- Add a proper multilingual content strategy rather than partial translations.
- Keep personal contact data limited to information intentionally published.
- Add a privacy-preserving analytics option only if there is a clear benefit.
- Document ownership and licensing for project screenshots, logos, and external assets.

## Contributing

1. Create a focused branch for content or template changes.
2. Keep profile facts and project claims accurate and reviewable.
3. Add or update project content instead of duplicating information in templates.
4. Run `hugo --cleanDestinationDir --minify` before submitting changes.
5. Review the generated site at desktop and mobile widths.
6. Do not commit secrets, private CV data, credentials, or unlicensed assets.
7. Update this README when the architecture or deployment workflow changes.
8. Keep the distinction between implemented functionality and roadmap items.

## License

No open-source license is currently specified. Until a license file is added, treat the portfolio source, content, design, and original assets as all rights reserved by the author. Hugo, GitHub Actions, GitHub Pages, and any third-party assets remain subject to their own licenses and terms.
