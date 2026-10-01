#!/usr/bin/env bash
# =============================================================================
# update_portfolio.sh
# Met à jour le repo Hugo "portfolio" d'Achraf Hasnaoui avec le contenu des CV :
#   - data/portfolio.yaml complet (hero, à propos, compétences, formation...)
#   - nouvelle section "Experience" (stages + freelance)
#   - nouvelle section "Activities" (activités hors école)
#   - 8 vrais projets dans content/projects/ (remplace les placeholders)
#   - certifications + langues dans la section Education
#
# Usage (à la racine du repo, là où se trouve hugo.toml) :
#     bash update_portfolio.sh
#
# Le script est relançable : il sauvegarde les fichiers modifiés dans
# ../portfolio-backup-<date> avant d'écrire.
# =============================================================================
set -euo pipefail

# ---------- 0. Vérifications ----------
if [[ ! -f hugo.toml || ! -f data/portfolio.yaml || ! -f layouts/index.html ]]; then
  echo "❌ Lance ce script à la racine du repo portfolio (là où il y a hugo.toml)." >&2
  exit 1
fi

TS="$(date +%Y%m%d-%H%M%S)"
BACKUP="../portfolio-backup-$TS"
mkdir -p "$BACKUP"
cp -r data layouts content static/css "$BACKUP"/ 2>/dev/null || true
echo "💾 Sauvegarde : $BACKUP"

# ---------- 1. data/portfolio.yaml ----------
echo "📝 Écriture de data/portfolio.yaml"
cat > data/portfolio.yaml <<'EOF'
# =============================================================================
# PORTFOLIO CONTENT — edit everything here, then commit + push.
# No code, no JS, no admin panel: change a value below, GitHub Actions
# rebuilds the site automatically. Inline **bold** works in text fields.
# =============================================================================

meta:
  title: "Achraf Hasnaoui — Software Engineering Student"
  description: "Portfolio of Achraf Hasnaoui — 3rd-year software engineering student at ENSIT, full-stack / backend developer, looking for a final-year (PFE) internship in France."
  themeColor: "#FBF7EF"

logo:
  badge: "AH"
  text: "achraf.dev"

navLinks:
  - num: "01."
    label: "about"
    href: "#about"
  - num: "02."
    label: "skills"
    href: "#skills"
  - num: "03."
    label: "experience"
    href: "#experience"
  - num: "04."
    label: "projects"
    href: "#projects"
  - num: "05."
    label: "education"
    href: "#education"
  - num: "06."
    label: "activities"
    href: "#activities"
  - num: "07."
    label: "contact"
    href: "#contact"

hero:
  # Photo ronde dans la carte de droite. Laisser "" pour garder le badge "AH".
  # Mets l'image dans static/images/profile/ puis : "images/profile/me.jpg"
  photo: ""
  greeting: "Hi there, my name is"
  name: "Achraf Hasnaoui"
  roles:
    - "software engineer."
    - "full-stack / backend developer."
    - "problem solver."
    - "CTF player."
    - "IoT & AI enthusiast."
  tagline: "A 3rd-year **Software Engineering** student at ENSIT with hands-on experience in **full-stack, backend, web and mobile** development — Java/Spring, Python, React, Flutter. Looking for a **final-year internship (PFE) in France**."
  statusPill: "seeking PFE · France"
  cardName: "achraf hasnaoui"
  cardRole: "3rd year software engineering student"
  cardInfo:
    - "📍 Gabès, Tunisia"
    - "🎓 Software Engineering @ ENSIT"
    - "💻 Java/Spring · Python · React · Flutter"
    - "🚀 Seeking a PFE internship in France"
  stats:
    - num: "4+"
      label: "years coding"
    - num: "3"
      label: "work experiences"
    - num: "8"
      label: "projects built"

marquee:
  - "Java"
  - "Spring"
  - "Python"
  - "Flask"
  - "React"
  - "Flutter"
  - "PostgreSQL"
  - "MongoDB"
  - "Linux"
  - "IoT"
  - "Cybersecurity"
  - "Git & GitHub"

about:
  photo: ""
  sub: "The short version of who I am"
  paragraphs:
    - "I'm a 3rd-year **Software Engineering** student at **ENSIT** (Tunis) with practical experience in **full-stack, backend, web and mobile** development. I'm comfortable across the whole development cycle — from requirements analysis and design to implementation, testing and validation."
    - "I've interned at **Airstruct Consulting** (a Spring-based CRM and KPI dashboards for an air & sea freight company) and at **Bako Motors** (a vehicle tracking platform), and I've freelanced on Fiverr since 2022. Outside of code, I'm drawn to **IoT, AI, cybersecurity** and low-level systems."
    - "Technologies I work with the most:"
  tech:
    - "Java / Spring / JEE"
    - "Python / Flask / Django"
    - "JavaScript / React"
    - "Flutter / Ionic"
    - "PostgreSQL / MySQL"
    - "MongoDB / Firebase"
    - "C / C++"
    - "Linux & Bash"
  facts:
    title: "Quick facts"
    sub: "the fun stuff"
    items:
      - k: "name"
        v: "Achraf Hasnaoui"
      - k: "status"
        v: "3rd year · ENSIT"
      - k: "location"
        v: "Gabès, Tunisia"
      - k: "looking for"
        v: "PFE internship · France"
      - k: "interests"
        v: "full-stack, IoT, AI, security"
      - k: "languages"
        v: "AR · FR · EN · DE (A1)"

skills:
  sub: "Things I'm good at (and still leveling up)"
  # NB: les pourcentages sont indicatifs — ajuste-les à ton ressenti.
  groups:
    - emoji: "💬"
      title: "languages"
      items:
        - name: "Java"
          level: 85
        - name: "Python"
          level: 85
        - name: "JavaScript"
          level: 80
        - name: "SQL"
          level: 80
        - name: "C / C++"
          level: 70
        - name: "PHP"
          level: 65
    - emoji: "⚙️"
      title: "backend"
      items:
        - name: "Spring / Spring Boot"
          level: 80
        - name: "JEE"
          level: 70
        - name: "Flask"
          level: 80
        - name: "Django"
          level: 65
    - emoji: "📱"
      title: "frontend & mobile"
      items:
        - name: "React"
          level: 80
        - name: "Flutter"
          level: 70
        - name: "Ionic"
          level: 70
        - name: "HTML & CSS"
          level: 85
    - emoji: "🗄️"
      title: "databases"
      items:
        - name: "PostgreSQL"
          level: 75
        - name: "MySQL / MariaDB"
          level: 80
        - name: "MongoDB"
          level: 75
        - name: "Firebase"
          level: 70
    - emoji: "🛠️"
      title: "tools & systems"
      items:
        - name: "Git & GitHub"
          level: 85
        - name: "Linux / Unix"
          level: 80
        - name: "Bash scripting"
          level: 75
    - emoji: "🔐"
      title: "networks & security"
      items:
        - name: "OSI / TCP-IP / routing"
          level: 75
        - name: "Wireshark"
          level: 70
        - name: "Ghidra"
          level: 60
        - name: "Metasploit"
          level: 60
  extra:
    - title: "Also familiar with"
      items:
        - "Algorithms & data structures"
        - "Complexity analysis"
        - "Competitive programming"
        - "Object-oriented programming"
        - "System modelling"
        - "Authentication & data management"
        - "Access control (RBAC, MAC, DAC, SBAC, Chinese Wall)"
        - "IoT"
        - "Artificial intelligence"
        - "Embedded systems"
        - "SolidWorks"
    - title: "Soft skills"
      items:
        - "Rigor"
        - "Autonomy"
        - "Analytical mindset"
        - "Scientific curiosity"
        - "Adaptability"
        - "Teamwork"
        - "Communication"
        - "Leadership"
        - "Organisation"
        - "Eager to learn"

experience:
  sub: "Where I've worked and what I shipped"
  items:
    - date: "06/2026 — 07/2026"
      title: "Software Development / Full Stack Intern"
      org: "Airstruct Consulting · Tunisia"
      bullets:
        - "Designed and built a full-stack web application (Spring backend) for an air & sea freight import-export company."
        - "Developed a CRM covering staff, client appointments, meeting reports, scheduled trips and sales activity."
        - "Built dashboards and KPIs to follow individual and overall performance."
        - "Took part in the whole development cycle: requirements, design, implementation and validation."
      tags: ["Spring", "Full Stack", "CRM", "KPI dashboards"]
    - date: "06/2025 — 07/2025"
      title: "Software Development Intern"
      org: "Bako Motors (automotive) · Tunisia"
      bullets:
        - "Contributed to a software platform tracking vehicles and production operations, to improve traceability."
        - "Worked on features for vehicle management, test tracking, anomalies and maintenance operations."
        - "Developed and validated features within a project team, from design to integration."
      tags: ["Software development", "Traceability", "Teamwork"]
    - date: "01/2022 — 06/2024"
      title: "Freelance Developer"
      org: "Fiverr / Freelancer · Remote"
      bullets:
        - "Built e-commerce, showcase and e-learning websites to client requirements."
        - "Wrote small Python tools for data encryption and compression."
      tags: ["Web", "E-commerce", "Python"]

# Projects live in content/projects/*.md (one file each).
projects:
  sub: "Things I've built"
  more:
    label: "View all projects →"
    href: "projects/"

education:
  sub: "My journey so far"
  items:
    - date: "2024 — 2027"
      title: "Engineering Degree — Computer Engineering"
      org: "ENSIT, Tunis (in progress · 3rd year)"
      desc: "Solid training in software engineering, security and computer systems, with a focus on IoT and AI-driven solutions."
    - date: "2022 — 2024"
      title: "Technological Preparatory Cycle"
      org: "IPEIM, Monastir"
      desc: "Two-year preparatory cycle — graduated with honors (Mention Bien)."
    - date: "2021 — 2022"
      title: "Technological Baccalaureate"
      org: "Lycée Dkhilet Toujane, Gabès"
      desc: "Graduated with honors (Mention Bien)."
  certs:
    title: "Certifications"
    items:
      - "Cisco CCNA 1 (2025)"
      - "Cisco CCNA 2"
      - "DataCamp — AI Fundamentals"
      - "SolidWorks"
  languages:
    title: "Languages"
    items:
      - "Arabic — native"
      - "French — advanced"
      - "English — advanced"
      - "German — beginner"

activities:
  title: "beyond school"
  sub: "What I do outside the classroom"
  groups:
    - emoji: "🛡️"
      title: "Securinets ENSIT"
      role: "Technical team member · since 2024"
      color: "pink"
      intro: "Cybersecurity club of ENSIT, where I take part in the technical side of the club."
      items:
        - "Co-organised and designed CTF challenges for the Darknets competition"
        - "Ran workshops on forensics and cryptography"
        - "Regular practice in offensive security and digital investigation"
      tags: ["CTF", "Forensics", "Cryptography"]
    - emoji: "🏆"
      title: "Competitions"
      role: "CTF & competitive programming"
      color: "yellow"
      items:
        - "**1st place** — Cat The Flag (ENIT)"
        - "CTF: Darknets (Securinets), The Darkest Hour (INSAT)"
        - "Programming: Recursia, ENSTABYTE 3.0, Geeks Hack 4.0 / 5.0, IEEEXtreme"
        - "Regular training on LeetCode and Codeforces"
        - "Student marathons and MTB races"
      tags: ["CTF", "Algorithms", "Problem solving"]
    - emoji: "✍️"
      title: "Technical writing"
      role: "Personal blog"
      color: "teal"
      intro: "I write regularly about AI, security, IoT, mechanics and engineering at large — sharing ideas and opinions, and keeping up with the field."
      link:
        label: "Read the blog ↗"
        href: "https://achrafhasnaoui31.github.io/blog/"
    - emoji: "❤️"
      title: "Volunteering"
      role: "Former member · Red Crescent"
      color: "coral"
      intro: "Helped people in difficulty and took part in solidarity actions."
    - emoji: "🥋"
      title: "Sports & outdoors"
      role: "Martial arts, MTB, climbing"
      color: "mint"
      items:
        - "Regular practice of taekwondo, kickboxing, wing chun and boxing"
        - "Long-distance mountain biking and climbing"
        - "Camping and survival techniques — I train others (survival trainer)"
    - emoji: "♟️"
      title: "Mind & making"
      role: "Chess, reading, tinkering"
      color: "yellow"
      items:
        - "Chess: concentration and strategic thinking"
        - "Reading on physics, technology, engineering and personal development"
        - "Robotics, IoT, mechanics, electronics, prototyping and fabrication"

contact:
  eyebrow: "looking for a PFE internship?"
  title: "Let's build something **awesome** together ✦"
  text: "I'm looking for a final-year internship (PFE) in software engineering in France, and I'm always open to collaborations and interesting conversations. My inbox is open — whether you have a question or just want to say hi, I'll get back to you!"
  email:
    label: "Say hello ✉"
    href: "mailto:achrafhas2003@gmail.com"
  github:
    label: "GitHub ↗"
    href: "https://github.com/AchrafHasnaoui31"
  linkedin:
    label: "LinkedIn ↗"
    href: "https://linkedin.com/in/achraf-hasnaoui-679866250"
  blog:
    label: "Blog ↗"
    href: "https://achrafhasnaoui31.github.io/blog/"

footer:
  text: "© 2026 Achraf Hasnaoui — designed & built with 🧡 and too much coffee ☕"
  status: "seeking a PFE internship · France"
EOF

# ---------- 2. layouts/index.html ----------
echo "🧩 Écriture de layouts/index.html (sections Experience + Activities)"
cat > layouts/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  {{ $d := .Site.Data.portfolio }}
  <meta name="description" content="{{ $d.meta.description }}" />
  <meta name="theme-color" content="{{ $d.meta.themeColor }}" />
  <link rel="icon" type="image/svg+xml" href="{{ "favicon.png" | relURL }}" />
  <link rel="icon" type="image/png" sizes="32x32" href="{{ "favicon.png" | relURL }}" />
  <title>{{ $d.meta.title }}</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,400..800&family=Space+Grotesk:wght@400;500;600;700&display=swap"
    rel="stylesheet"
  />
  <link rel="stylesheet" href="{{ "css/style.css" | relURL }}" />
</head>
<body>

  {{/* helper: turn **bold** into <strong>bold</strong> for inline text fields */}}
  {{ $bold := "\\*\\*(.*?)\\*\\*" }}

  <!-- ===== NAVBAR ===== -->
  {{ partial "navbar.html" (dict "d" $d "prefix" "") }}

  <main>
    <!-- ===== HERO ===== -->
    <section class="hero" id="hero">
      <div class="container hero-grid">
        <div class="hero-content">
          <p class="hero-greeting reveal"><span class="wave" aria-hidden="true">👋</span> {{ $d.hero.greeting }}</p>
          <h1 class="hero-name reveal">{{ $d.hero.name }}<span class="dot-pink" aria-hidden="true">.</span></h1>
          <h2 class="hero-role reveal">I'm a <span class="type-sticker" id="typewriter"></span><span class="type-cursor" aria-hidden="true"></span></h2>
          <p class="hero-tagline reveal">{{ replaceRE $bold "<strong>$1</strong>" $d.hero.tagline | safeHTML }}</p>
          <div class="hero-actions reveal">
            <a href="#projects" class="btn btn-primary">See my work <span aria-hidden="true">↓</span></a>
            <a href="#contact" class="btn btn-outline">Get in touch</a>
          </div>
        </div>

        <!-- Sticker profile card -->
        <div class="reveal">
          <aside class="hero-card card" aria-label="Quick profile">
            <div class="hero-card-head">
              {{ if $d.hero.photo }}
              <img class="hero-avatar hero-avatar--photo" src="{{ $d.hero.photo | relURL }}" alt="{{ $d.hero.name }}" />
              {{ else }}
              <span class="hero-avatar" aria-hidden="true">{{ $d.logo.badge }}</span>
              {{ end }}
              <span class="status-pill"><span class="pulse-dot" aria-hidden="true"></span>{{ $d.hero.statusPill }}</span>
            </div>
            <h3 class="hero-card-name">{{ $d.hero.cardName }}</h3>
            <p class="hero-card-role">{{ $d.hero.cardRole }}</p>
            <ul class="hero-card-info">
              {{ range $d.hero.cardInfo }}
              {{ $parts := split . " " }}
              <li><span class="info-icon" aria-hidden="true">{{ index $parts 0 }}</span>{{ delimit (after 1 $parts) " " }}</li>
              {{ end }}
            </ul>
            <div class="hero-card-stats">
              {{ range $d.hero.stats }}
              <div class="stat"><strong>{{ .num }}</strong><span>{{ .label }}</span></div>
              {{ end }}
            </div>
          </aside>
        </div>
      </div>
    </section>

    <!-- ===== MARQUEE ===== -->
    <div class="marquee" aria-hidden="true">
      <div class="marquee-track" id="marqueeTrack">
        <div class="marquee-group">
          {{ range $i, $t := $d.marquee }}{{ if $i }}<b>★</b>{{ end }}<span>{{ $t }}</span>{{ end }}
        </div>
      </div>
    </div>

    <!-- ===== ABOUT ===== -->
    <section class="section section--paper" id="about">
      <div class="container">
        <h2 class="section-title reveal"><span class="section-num" aria-hidden="true">01</span> about</h2>
        <p class="section-sub reveal">{{ $d.about.sub | default "The short version of who I am" }}</p>

        <div class="about-grid">
          <div class="about-text reveal">
            {{ range $d.about.paragraphs }}
            <p>{{ replaceRE $bold "<strong>$1</strong>" . | safeHTML }}</p>
            {{ end }}
            <ul class="tech-list">
              {{ range $d.about.tech }}
              <li>{{ . }}</li>
              {{ end }}
            </ul>
          </div>

          <!-- Sticker quick-facts card -->
          <div class="reveal">
            <aside class="about-card card card--cyan" aria-label="Profile details">
              <div class="about-card-title">
                {{ if $d.about.photo }}
                <img class="about-card-icon about-card-icon--photo" src="{{ $d.about.photo | relURL }}" alt="{{ $d.hero.name }}" />
                {{ else }}
                <span class="about-card-icon" aria-hidden="true">🧑‍💻</span>
                {{ end }}
                <div>
                  <h3>{{ $d.about.facts.title }}</h3>
                  <p>{{ $d.about.facts.sub }}</p>
                </div>
              </div>
              <ul class="about-card-list">
                {{ range $d.about.facts.items }}
                <li><span>{{ .k }}</span><strong>{{ .v }}</strong></li>
                {{ end }}
              </ul>
            </aside>
          </div>
        </div>
      </div>
    </section>

    <!-- ===== SKILLS ===== -->
    <section class="section section--pink" id="skills">
      <div class="container">
        <h2 class="section-title reveal"><span class="section-num section-num--ink" aria-hidden="true">02</span> skills</h2>
        <p class="section-sub reveal">{{ $d.skills.sub }}</p>

        <div class="skills-grid">
          {{ $colors := slice "lime" "cyan" "yellow" "pink" "orange" }}
          {{ range $d.skills.groups }}
          <div class="skill-group card reveal">
            <h3 class="skill-group-title"><span class="skill-emoji" aria-hidden="true">{{ .emoji }}</span> {{ .title }}</h3>
            {{ range $i, $s := .items }}
            {{ $c := index $colors (mod $i (len $colors)) }}
            <div class="skill">
              <div class="skill-head"><span>{{ $s.name }}</span><span>{{ $s.level }}%</span></div>
              <div class="skill-track"><div class="skill-fill skill-fill--{{ $c }}" data-width="{{ $s.level }}"></div></div>
            </div>
            {{ end }}
          </div>
          {{ end }}
        </div>

        {{ range $d.skills.extra }}
        <div class="skills-extra reveal">
          <h3 class="skills-extra-title">{{ .title }}</h3>
          <ul class="chip-list">
            {{ range .items }}<li>{{ . }}</li>{{ end }}
          </ul>
        </div>
        {{ end }}
      </div>
    </section>

    <!-- ===== EXPERIENCE ===== -->
    <section class="section section--paper" id="experience">
      <div class="container">
        <h2 class="section-title reveal"><span class="section-num" aria-hidden="true">03</span> experience</h2>
        <p class="section-sub reveal">{{ $d.experience.sub }}</p>

        <div class="timeline">
          {{ range $d.experience.items }}
          <div class="timeline-item reveal">
            <div class="timeline-marker" aria-hidden="true"></div>
            <div class="timeline-content card">
              <span class="timeline-date">{{ .date }}</span>
              <h3>{{ .title }}</h3>
              <p class="timeline-org">{{ .org }}</p>
              <ul class="timeline-bullets">
                {{ range .bullets }}<li>{{ . }}</li>{{ end }}
              </ul>
              {{ with .tags }}
              <ul class="project-tags">
                {{ range . }}<li>{{ . }}</li>{{ end }}
              </ul>
              {{ end }}
            </div>
          </div>
          {{ end }}
        </div>
      </div>
    </section>

    <!-- ===== PROJECTS ===== -->
    <section class="section section--ink" id="projects">
      <div class="container">
        <h2 class="section-title section-title--light reveal"><span class="section-num section-num--yellow" aria-hidden="true">04</span> projects</h2>
        <p class="section-sub section-sub--light reveal">{{ $d.projects.sub }}</p>

        <div class="projects-grid">
          {{ $pcolors := slice "yellow" "pink" "cyan" }}
          {{ $projects := where site.RegularPages "Section" "projects" }}
          {{ $projects = $projects.ByWeight }}
          {{ $projects = first 6 $projects }}
          {{ range $i, $p := $projects }}
          {{ $c := index $pcolors (mod $i (len $pcolors)) }}
          <article class="project-card card project-card--{{ $c }} reveal">
            {{ with $p.Params.cover }}
            <a href="{{ $p.RelPermalink }}" class="project-cover-link">
              <img class="project-cover" src="{{ . | relURL }}" alt="{{ $p.Title }} cover" />
            </a>
            {{ end }}
            <div class="project-top">
              <span class="project-folder" aria-hidden="true">📁</span>
              <div class="project-links">
                {{ with $p.Params.repo }}<a href="{{ . }}" target="_blank" rel="noopener noreferrer" title="GitHub repository" aria-label="GitHub repository">&#128279;</a>{{ end }}
                {{ with $p.Params.demo }}<a href="{{ . }}" target="_blank" rel="noopener noreferrer" title="Live demo" aria-label="Live demo">&#8599;</a>{{ end }}
              </div>
            </div>
            <h3 class="project-title"><a href="{{ $p.RelPermalink }}">{{ $p.Title }}</a></h3>
            <p class="project-desc">{{ $p.Params.summary | default $p.Summary }}</p>
            <ul class="project-tags">
              {{ range $p.Params.tags }}<li>{{ . }}</li>{{ end }}
            </ul>
            <a href="{{ $p.RelPermalink }}" class="project-more">Read more →</a>
          </article>
          {{ end }}
        </div>

        {{ if not $projects }}
        <p class="section-sub section-sub--light reveal">No projects yet — add one in <code>content/projects/</code>.</p>
        {{ end }}

        {{ with $d.projects.more }}
        <div class="projects-more reveal">
          <a href="{{ if hasPrefix .href "http" }}{{ .href }}{{ else }}{{ .href | relURL }}{{ end }}" class="btn btn-yellow">{{ .label }}</a>
        </div>
        {{ end }}
      </div>
    </section>

    <!-- ===== EDUCATION ===== -->
    <section class="section section--yellow" id="education">
      <div class="container">
        <h2 class="section-title reveal"><span class="section-num" aria-hidden="true">05</span> education</h2>
        <p class="section-sub reveal">{{ $d.education.sub }}</p>

        <div class="timeline">
          {{ range $d.education.items }}
          <div class="timeline-item reveal">
            <div class="timeline-marker" aria-hidden="true"></div>
            <div class="timeline-content card">
              <span class="timeline-date">{{ .date }}</span>
              <h3>{{ .title }}</h3>
              <p class="timeline-org">{{ .org }}</p>
              <p>{{ .desc }}</p>
            </div>
          </div>
          {{ end }}
        </div>

        <div class="edu-extras">
          {{ with $d.education.certs }}
          <div class="edu-extra card reveal">
            <h3>{{ .title }}</h3>
            <ul class="timeline-bullets">{{ range .items }}<li>{{ . }}</li>{{ end }}</ul>
          </div>
          {{ end }}
          {{ with $d.education.languages }}
          <div class="edu-extra card reveal">
            <h3>{{ .title }}</h3>
            <ul class="timeline-bullets">{{ range .items }}<li>{{ . }}</li>{{ end }}</ul>
          </div>
          {{ end }}
        </div>
      </div>
    </section>

    <!-- ===== ACTIVITIES (hors école) ===== -->
    <section class="section section--pink" id="activities">
      <div class="container">
        <h2 class="section-title reveal"><span class="section-num section-num--ink" aria-hidden="true">06</span> {{ $d.activities.title | default "activities" }}</h2>
        <p class="section-sub reveal">{{ $d.activities.sub }}</p>

        <div class="activities-grid">
          {{ range $d.activities.groups }}
          <article class="activity-card card activity-card--{{ .color | default "yellow" }} reveal">
            <div class="activity-head">
              <span class="activity-emoji" aria-hidden="true">{{ .emoji }}</span>
              <div>
                <h3 class="activity-title">{{ .title }}</h3>
                {{ with .role }}<p class="activity-role">{{ . }}</p>{{ end }}
              </div>
            </div>
            {{ with .intro }}<p class="activity-intro">{{ . }}</p>{{ end }}
            {{ with .items }}
            <ul class="activity-list">
              {{ range . }}<li>{{ replaceRE $bold "<strong>$1</strong>" . | safeHTML }}</li>{{ end }}
            </ul>
            {{ end }}
            {{ with .tags }}
            <ul class="project-tags">
              {{ range . }}<li>{{ . }}</li>{{ end }}
            </ul>
            {{ end }}
            {{ with .link }}
            <a href="{{ .href }}" target="_blank" rel="noopener noreferrer" class="activity-link">{{ .label }}</a>
            {{ end }}
          </article>
          {{ end }}
        </div>
      </div>
    </section>

    <!-- ===== CONTACT ===== -->
    <section class="section" id="contact">
      <div class="container">
        <div class="contact-panel reveal">
          <p class="contact-eyebrow">{{ $d.contact.eyebrow }}</p>
          <h2 class="contact-title">{{ replaceRE $bold `<span class="marker-yellow">$1</span>` $d.contact.title | safeHTML }}</h2>
          <p class="contact-text">{{ $d.contact.text }}</p>
          <div class="contact-actions">
            <a href="{{ $d.contact.email.href }}" class="btn btn-yellow">{{ $d.contact.email.label }}</a>
            <a href="{{ $d.contact.github.href }}" target="_blank" rel="noopener noreferrer" class="btn btn-outline-light">{{ $d.contact.github.label }}</a>
            <a href="{{ $d.contact.linkedin.href }}" target="_blank" rel="noopener noreferrer" class="btn btn-outline-light">{{ $d.contact.linkedin.label }}</a>
            {{ with $d.contact.blog }}<a href="{{ .href }}" target="_blank" rel="noopener noreferrer" class="btn btn-outline-light">{{ .label }}</a>{{ end }}
          </div>
        </div>
      </div>
    </section>
  </main>

  <!-- ===== FOOTER ===== -->
  {{ partial "footer.html" $d }}

  <script id="hero-roles" type="application/json">{{ $d.hero.roles | jsonify | safeJS }}</script>
  <script src="{{ "js/main.js" | relURL }}"></script>
</body>
</html>
EOF

# ---------- 3. CSS (bloc idempotent ajouté en fin de fichier) ----------
echo "🎨 Ajout des styles (experience / activities / chips)"
CSS=static/css/style.css
if grep -q "EXT-BEGIN" "$CSS"; then
  sed -i '/\/\* EXT-BEGIN/,$d' "$CSS"
fi
cat >> "$CSS" <<'EOF'
/* EXT-BEGIN — experience, activities, chips (généré par update_portfolio.sh) */
.timeline-item:nth-child(4) .timeline-marker { background: var(--mint); }
.timeline-item:nth-child(5) .timeline-marker { background: var(--coral); }

.timeline-bullets { display: grid; gap: 0.4rem; margin-top: 0.6rem; }
.timeline-bullets li {
  position: relative;
  padding-left: 1.2rem;
  color: var(--ink-soft);
  font-size: 0.93rem;
}
.timeline-bullets li::before {
  content: '▸';
  position: absolute;
  left: 0;
  color: var(--coral);
  font-weight: 700;
}

/* skills — extra chips */
.skills-extra { margin-top: 2.6rem; }
.skills-extra-title {
  font-family: var(--font-head);
  font-weight: 800;
  font-size: 1.1rem;
  text-transform: uppercase;
  margin-bottom: 0.9rem;
}
.chip-list { display: flex; flex-wrap: wrap; gap: 0.55rem; }
.chip-list li {
  padding: 0.3rem 0.85rem;
  background: #fff;
  border: 1.5px solid var(--ink);
  border-radius: 999px;
  font-weight: 600;
  font-size: 0.85rem;
}

/* education — certifications & languages */
.edu-extras {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 1.8rem;
  max-width: 820px;
  margin: 3rem auto 0;
}
.edu-extra { padding: 1.5rem 1.6rem; }
.edu-extra h3 {
  font-family: var(--font-head);
  font-weight: 800;
  font-size: 1.1rem;
  text-transform: uppercase;
  margin-bottom: 0.3rem;
}

/* activities (hors école) */
.activities-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 1.8rem;
}
.activity-card {
  display: flex;
  flex-direction: column;
  padding: 1.6rem;
  border-top-width: 10px;
}
.activity-card--yellow { border-top-color: var(--yellow); }
.activity-card--pink   { border-top-color: var(--pink); }
.activity-card--teal   { border-top-color: var(--teal); }
.activity-card--mint   { border-top-color: var(--mint); }
.activity-card--coral  { border-top-color: var(--coral); }
.activity-card:hover { transform: translateY(-4px); box-shadow: 9px 9px 0 var(--shadow-soft); }

.activity-head { display: flex; align-items: center; gap: 0.8rem; margin-bottom: 0.8rem; }
.activity-emoji { font-size: 1.8rem; line-height: 1; }
.activity-title {
  font-family: var(--font-head);
  font-weight: 800;
  font-size: 1.15rem;
  text-transform: uppercase;
  line-height: 1.15;
}
.activity-role { color: var(--ink-soft); font-weight: 700; font-size: 0.85rem; }
.activity-intro { color: var(--ink-soft); font-size: 0.93rem; }
.activity-list { display: grid; gap: 0.5rem; margin-top: 0.3rem; flex: 1; }
.activity-list li {
  position: relative;
  padding-left: 1.2rem;
  color: var(--ink-soft);
  font-size: 0.93rem;
}
.activity-list li strong { color: var(--ink); }
.activity-list li::before {
  content: '▸';
  position: absolute;
  left: 0;
  color: var(--coral);
  font-weight: 700;
}
.activity-card .project-tags { margin-top: 1rem; }
.activity-link {
  margin-top: 1rem;
  font-weight: 700;
  text-decoration: underline;
  text-decoration-color: var(--yellow);
  text-decoration-thickness: 3px;
  text-underline-offset: 4px;
}

@media (max-width: 920px) {
  .activities-grid { grid-template-columns: 1fr 1fr; }
}
@media (max-width: 620px) {
  .activities-grid { grid-template-columns: 1fr; }
  .edu-extras { grid-template-columns: 1fr; }
}
EOF

# ---------- 4. Projets ----------
echo "📁 Écriture des projets dans content/projects/"
# Supprime les anciens placeholders (seulement s'ils sont intacts)
for f in project-one project-two project-three; do
  if [[ -f "content/projects/$f.md" ]] && grep -q "Replace this" "content/projects/$f.md"; then
    rm "content/projects/$f.md"
  fi
done

cat > content/projects/_index.md <<'EOF'
---
title: "Projects"
summary: "Everything I've built, in one place."
---
EOF

cat > content/projects/medical-monitoring-app.md <<'EOF'
---
title: "Remote Medical Monitoring App"
date: 2025-05-01
draft: false
weight: 1
summary: "Android app connecting patients and doctors: local data tracking, sensor data collection, real-time AI analysis, anomaly detection and alert notifications."
tags: ["Flutter", "Python", "Firebase", "IoT", "AI"]
cover: ""
---

An Android application linking patients and doctors for remote medical follow-up, built around connected sensors and AI.

## What it does

- Connects patients and doctors in a single app
- Tracks health data locally on the device
- Collects data from sensors (IoT) and transmits it to a server
- Runs real-time AI analysis on the incoming data
- Detects anomalies and sends alerts / notifications

## Stack

Flutter (mobile app), Python (server and AI analysis), Firebase, IoT sensors.
EOF

cat > content/projects/sports-teams-platform.md <<'EOF'
---
title: "Sports Teams & Competitions Platform"
date: 2024-04-01
draft: false
weight: 2
summary: "Web platform to manage teams and competitions: authentication, scheduling, player performance tracking and dashboards."
tags: ["PHP", "MySQL", "React"]
cover: ""
---

A web platform for managing sports teams and competitions.

## What it does

- User authentication
- Team and competition management
- Scheduling of matches and events
- Player performance tracking
- Dashboards to follow the numbers

## Stack

PHP and MySQL on the backend, React on the frontend.
EOF

cat > content/projects/freelance-marketplace-app.md <<'EOF'
---
title: "Freelance Marketplace Mobile App"
date: 2025-05-01
draft: false
weight: 3
summary: "Mobile app connecting freelancers and clients, with its own frontend, backend API and database."
tags: ["Ionic", "Flask", "MongoDB"]
cover: ""
---

A mobile application that puts freelancers and clients in touch with each other, developed end to end.

## What it covers

- Mobile frontend built with Ionic
- Backend API built with Flask
- MongoDB database

## Stack

Ionic, Flask, MongoDB.
EOF

cat > content/projects/esp32-smart-key.md <<'EOF'
---
title: "ESP32 Smart Key"
date: 2025-03-01
draft: false
weight: 4
summary: "A hardware smart key built on ESP32 that securely stores credentials, passwords and OTP codes, and eases sign-in across multiple devices."
tags: ["ESP32", "IoT", "Security", "Embedded"]
cover: ""
---

A small embedded device that acts as a smart key for authentication.

## What it does

- Securely stores credentials, passwords and OTP codes
- Makes signing in from several devices easier

## Stack

ESP32 (embedded systems / IoT), with a security-first design.
EOF

cat > content/projects/ctf-platform.md <<'EOF'
---
title: "CTF Platform"
date: 2024-06-01
draft: false
weight: 5
summary: "A platform for training and competitions, built for the CTF events organised by Securinets ENSIT."
tags: ["Cybersecurity", "CTF", "Securinets"]
cover: ""
---

A Capture The Flag platform: an environment for training and for running competitions, created in the context of the **Securinets ENSIT** club, where I'm a member of the technical team.

Related: I also design CTF challenges and run forensics and cryptography workshops for the club.
EOF

cat > content/projects/airport-simulation.md <<'EOF'
---
title: "Airport Management & Simulation"
date: 2024-04-01
draft: false
weight: 6
summary: "Object-oriented model and full simulation of an airport: flights, runways, landings, passengers, tickets, pilots and staff."
tags: ["C++", "OOP", "OODB"]
cover: ""
---

A complete airport management and simulation system.

## What it models

- Flights and runways
- Landings
- Passengers and tickets
- Pilots and staff

## Stack

C++, object-oriented programming, object-oriented database (OODB).
EOF

cat > content/projects/access-control-app.md <<'EOF'
---
title: "Access Control Management App"
date: 2025-01-01
draft: false
weight: 7
summary: "Application managing access control with several security models: RBAC, MAC, DAC, SBAC and Chinese Wall."
tags: ["Security", "RBAC", "MAC", "DAC", "SBAC"]
cover: ""
---

An application for managing access control, implementing and comparing the classical security models:

- **RBAC** — role-based access control
- **MAC** — mandatory access control
- **DAC** — discretionary access control
- **SBAC** — session-based access control
- **Chinese Wall** — conflict-of-interest policy
EOF

cat > content/projects/car-rental-ecommerce.md <<'EOF'
---
title: "Car Rental E-commerce App"
date: 2024-12-01
draft: false
weight: 8
summary: "E-commerce application for renting cars online."
tags: ["E-commerce", "Web"]
cover: ""
---

An e-commerce application dedicated to car rental.
EOF

# ---------- 5. Vérification du build (si hugo est installé) ----------
if command -v hugo >/dev/null 2>&1; then
  echo "🔨 Test de build Hugo..."
  if hugo --minify --destination /tmp/portfolio-check >/dev/null 2>&1; then
    echo "✅ Build OK"
  else
    echo "⚠️  Le build Hugo a échoué — lance 'hugo' pour voir l'erreur."
    echo "    (tes fichiers d'origine sont dans $BACKUP)"
  fi
else
  echo "ℹ️  Hugo n'est pas installé en local : le build sera fait par GitHub Actions."
fi

cat <<EOF

✅ Terminé. Étapes suivantes :
   1. Prévisualiser :  hugo server -D     (http://localhost:1313)
   2. Publier       :  git add -A && git commit -m "Update portfolio from CV" && git push

À vérifier / compléter à la main :
   - Email de contact : achrafhas2003@gmail.com (l'ancien était achrafhs12@gmail.com)
   - Dates du stage Airstruct (06/2026 — 07/2026 ici ; un de tes CV dit 08/2026)
   - Les % de compétences dans data/portfolio.yaml (indicatifs)
   - Ajoute 'repo:' / 'demo:' / 'cover:' dans chaque content/projects/*.md
   - Ta photo : static/images/profile/ puis hero.photo dans portfolio.yaml
EOF
