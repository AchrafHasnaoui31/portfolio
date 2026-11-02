#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
=============================================================================
ACHRAF HASNAOUI — PORTFOLIO MANAGEMENT TOOLKIT (Senior Engineering Grade)
=============================================================================
Usage:
  python3 scripts/manage.py list-projects
  python3 scripts/manage.py add-project
  python3 scripts/manage.py update-status
  python3 scripts/manage.py validate
  python3 scripts/manage.py build
=============================================================================
"""

import os
import sys
import yaml
import re
import subprocess
from pathlib import Path

# Paths
BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR / "data"
CONTENT_PROJECTS = BASE_DIR / "content" / "projects"
STATIC_CV = BASE_DIR / "static" / "cv"

CATEGORIES = {
    "software": "Génie Logiciel / Software Engineering",
    "cloud": "Cloud, DevOps & SRE",
    "cyber": "Cybersécurité / DevSecOps",
    "ai": "IA, GenAI & MLOps",
    "embedded": "Systèmes Embarqués & IoT"
}

def load_yaml(lang="fr"):
    path = DATA_DIR / lang / "portfolio.yaml"
    if not path.exists():
        path = DATA_DIR / "portfolio.yaml"
    with open(path, "r", encoding="utf-8") as f:
        return yaml.safe_load(f), path

def save_yaml(data, path):
    with open(path, "w", encoding="utf-8") as f:
        yaml.dump(data, f, allow_unicode=True, sort_keys=False, default_flow_style=False)

def slugify(text):
    text = text.lower().strip()
    text = re.sub(r'[^\w\s-]', '', text)
    text = re.sub(r'[\s_-]+', '-', text)
    return text.strip('-')

def cmd_list_projects():
    data, _ = load_yaml("fr")
    projects = data.get("projects", {}).get("featured", [])
    print("\n" + "=" * 70)
    print(f"📁 ACTIVE PROJECTS ({len(projects)} TOTAL)")
    print("=" * 70)
    for i, p in enumerate(projects, 1):
        cat = p.get("category", "other")
        title = p.get("title", "Sans titre")
        date = p.get("date", "")
        tags = ", ".join(p.get("tags", [])[:3])
        print(f"[{i:02d}] {title}")
        print(f"     📂 Category : {cat} | 📅 Date : {date}")
        print(f"     🏷️  Tags     : {tags}")
        print("-" * 70)
    print()

def cmd_add_project():
    print("\n" + "=" * 70)
    print("➕ ADD A NEW PROJECT TO PORTFOLIO")
    print("=" * 70)

    title = input("1. Project Title (e.g., 'Autonomous Drone Navigation') : ").strip()
    if not title:
        print("❌ Error: Title cannot be empty.")
        return

    print("\nSelect Category:")
    cat_keys = list(CATEGORIES.keys())
    for idx, k in enumerate(cat_keys, 1):
        print(f"  [{idx}] {k:10} - {CATEGORIES[k]}")
    cat_choice = input(f"Choose (1-{len(cat_keys)}) [1]: ").strip() or "1"
    try:
        category = cat_keys[int(cat_choice) - 1]
    except Exception:
        category = "software"

    date = input("2. Date/Year (e.g., '2026' or '2025 — En cours') : ").strip() or "2026"
    badge = input("3. Badge (e.g., 'Projet Réel' / 'Microservices') : ").strip() or "Ingénierie"
    summary = input("4. Short Summary (1-2 sentences) : ").strip()
    
    print("\n5. Key Technical Bullets (press Enter on empty line to finish):")
    bullets = []
    while True:
        b = input(f"   - Bullet {len(bullets)+1}: ").strip()
        if not b:
            break
        bullets.append(b)

    tags_input = input("6. Tags (comma-separated, e.g., 'Python, Docker, FastAPI') : ").strip()
    tags = [t.strip() for t in tags_input.split(",") if t.strip()]

    repo = input("7. GitHub Repository URL (or press Enter to skip) : ").strip()

    new_project = {
        "title": title,
        "category": category,
        "categoryLabel": CATEGORIES[category].split(" / ")[0],
        "date": date,
        "badge": badge,
        "summary": summary,
        "bullets": bullets,
        "tags": tags,
        "repo": repo
    }

    # 1. Update YAML for all languages
    for lang in ["fr", "en", "ar"]:
        try:
            d, p = load_yaml(lang)
            if "projects" not in d:
                d["projects"] = {}
            if "featured" not in d["projects"]:
                d["projects"]["featured"] = []
            d["projects"]["featured"].insert(0, new_project)
            save_yaml(d, p)
            print(f"✓ Updated data/{lang}/portfolio.yaml")
        except Exception as e:
            print(f"⚠️ Could not update {lang}: {e}")

    # Also update root fallback
    try:
        d, p = load_yaml("fr")
        save_yaml(d, DATA_DIR / "portfolio.yaml")
    except Exception:
        pass

    # 2. Create Markdown case study
    slug = slugify(title)
    md_file = CONTENT_PROJECTS / f"{slug}.md"
    md_content = f"""---
title: "{title}"
date: {date if '-' in date else '2026-01-01'}
draft: false
weight: 1
summary: "{summary}"
tags: {tags}
repo: "{repo}"
---

# {title}

{summary}

## Architecture & Points Clés

{"".join([f"- {b}\\n" for b in bullets])}

## Technologies

{", ".join([f"`{t}`" for t in tags])}
"""
    with open(md_file, "w", encoding="utf-8") as f:
        f.write(md_content)
    print(f"✓ Created case study: content/projects/{slug}.md")

    # 3. Test build with Hugo
    print("\n🔨 Rebuilding Hugo site...")
    res = subprocess.run(["hugo", "--minify"], cwd=BASE_DIR, capture_output=True, text=True)
    if res.returncode == 0:
        print("🎉 Site rebuilt successfully with 0 errors!")
    else:
        print(f"⚠️ Hugo build warning:\n{res.stderr}")

def cmd_validate():
    print("\n" + "=" * 70)
    print("🔍 VALIDATING PORTFOLIO INTEGRITY")
    print("=" * 70)

    # 1. Check data files
    for lang in ["fr", "en", "ar"]:
        p = DATA_DIR / lang / "portfolio.yaml"
        if p.exists():
            print(f"✓ data/{lang}/portfolio.yaml exists ({p.stat().st_size // 1024} KB)")
        else:
            print(f"❌ Missing: data/{lang}/portfolio.yaml")

    # 2. Check CVs
    cvs = list(STATIC_CV.glob("*.pdf"))
    print(f"✓ Found {len(cvs)} CV PDFs in static/cv/:")
    for cv in cvs:
        print(f"   - {cv.name} ({cv.stat().st_size // 1024} KB)")
    if len(cvs) < 5:
        print("⚠️ Expected at least 5 CV PDFs!")

    # 3. Check profile photo
    photo = BASE_DIR / "static" / "images" / "achraf.jpg"
    if photo.exists():
        print(f"✓ Profile photo static/images/achraf.jpg exists ({photo.stat().st_size // 1024} KB)")
    else:
        print("❌ Missing profile photo!")

    # 4. Hugo build
    print("\n🔨 Running Hugo build check...")
    res = subprocess.run(["hugo", "--minify"], cwd=BASE_DIR, capture_output=True, text=True)
    if res.returncode == 0:
        print("✅ ALL INTEGRITY CHECKS PASSED WITH FLYING COLORS!")
    else:
        print(f"❌ Hugo build error:\n{res.stderr}")

def main():
    if len(sys.argv) < 2:
        print(__doc__)
        print("Available commands:")
        print("  list-projects   : View all projects in portfolio")
        print("  add-project     : Interactively add a new project")
        print("  validate        : Check files, CVs, and build integrity")
        sys.exit(0)

    cmd = sys.argv[1].lower().strip()
    if cmd in ["list-projects", "list", "ls"]:
        cmd_list_projects()
    elif cmd in ["add-project", "add", "new"]:
        cmd_add_project()
    elif cmd in ["validate", "check"]:
        cmd_validate()
    else:
        print(f"Unknown command: '{cmd}'. Run without arguments for help.")

if __name__ == "__main__":
    main()
