# 📘 Guide d'Architecture & de Maintenance — Portfolio d'Achraf Hasnaoui

Ce guide explique l'architecture du projet et vous fournit toutes les clés pour **ajouter de nouveaux projets**, **modifier vos textes de présentation**, **mettre à jour vos CVs** et **déployer vos changements** en quelques secondes.

---

## 🏛️ 1. Architecture Senior Pro du Projet

Le projet a été découpé de manière modulaire afin que chaque section soit indépendante et facile à maintenir :

```
portfolio/
├── hugo.toml                     # Configuration multilingue globale (FR par défaut, EN, AR)
├── PORTFOLIO_GUIDE.md            # Ce guide pratique
├── scripts/
│   └── manage.py                 # CLI d'administration (ajout projets, validation, list)
│
├── data/                         # 🧠 Données centralisées (textes, projets, métriques)
│   ├── fr/portfolio.yaml         # Version Française (par défaut)
│   ├── en/portfolio.yaml         # Version Anglaise
│   ├── ar/portfolio.yaml         # Version Arabe (avec support RTL)
│   └── portfolio.yaml            # Fallback racine
│
├── layouts/                      # 🎨 Structure des templates HTML
│   ├── index.html                # Contrôleur principal propre et aéré
│   ├── partials/
│   │   ├── head.html             # Métadonnées, SEO, balises et typographies
│   │   ├── navbar.html           # Barre de navigation + sélecteur de langue + CTA
│   │   ├── footer.html           # Pied de page et liens
│   │   └── sections/             # 🧩 Chaque bloc de la page est un composant isolé
│   │       ├── hero.html         # Hero avec portail néon et introduction
│   │       ├── marquee.html      # Défilement continu des technologies
│   │       ├── about.html        # À propos + 4 compteurs statistiques
│   │       ├── tracks.html       # 02 SERVICES / Les 5 spécialités
│   │       ├── cv_hub.html       # 03 RESUME HUB / Téléchargement des 5 CVs
│   │       ├── skills.html       # 04 SKILLS / Jauges + Cluster Alvéolé (Honeycomb)
│   │       ├── projects.html     # 05 PORTFOLIO / Projets filtrables
│   │       ├── process.html      # 06 PROCESS / Pipeline en 5 étapes connectées
│   │       ├── experience.html   # 07 TRACK RECORD / Parcours en entreprise
│   │       ├── education.html    # 08 FORMATION & CERTIFICATIONS (Cisco, DataCamp)
│   │       └── contact.html      # 09 CONTACT / Coordonnées et copie email
│   └── projects/
│       ├── single.html           # Page détaillée pour chaque étude de cas
│       └── list.html             # Liste globale des projets
│
├── content/
│   └── projects/                 # 📝 Fiches de cas d'études détaillées (Markdown)
│       ├── cardioagent-ops.md
│       ├── smart-farm.md
│       ├── bako-motors.md
│       ├── esp32-wireless-security-lab.md
│       └── ...
│
└── static/                       # 📦 Fichiers statiques servis directement
    ├── css/style.css             # Feuille de style Cyberpunk / Néon
    ├── js/main.js                # Interactions, filtres, animations, copie d'email
    ├── images/
    │   └── achraf.jpg            # Votre photo de profil (au centre du portail)
    └── cv/                       # 📄 Les 5 CVs PDF spécialisés téléchargeables
        ├── Achraf_Hasnaoui_CV_Software_Engineer.pdf
        ├── Achraf_Hasnaoui_CV_Cybersecurity_DevSecOps.pdf
        ├── Achraf_Hasnaoui_CV_DevOps_Cloud.pdf
        ├── Achraf_Hasnaoui_CV_AI_GenAI_MLOps.pdf
        └── Achraf_Hasnaoui_CV_Embedded_IoT.pdf
```

---

## ⚡ 2. Ajouter un Nouveau Projet

Vous avez **deux méthodes simples** :

### Méthode A : Avec le Script CLI Interactif (Recommandé - 1 minute)
Depuis le dossier `portfolio/`, lancez :
```bash
python3 scripts/manage.py add-project
```
Le script vous posera quelques questions simples (Titre, catégorie, date, résumé, points clés, tags, lien GitHub) et s'occupera automatiquement de :
1. L'insérer dans `data/fr/portfolio.yaml`, `data/en/portfolio.yaml` et `data/ar/portfolio.yaml`.
2. Créer la page d'étude de cas Markdown correspondante dans `content/projects/<slug>.md`.
3. Tester la compilation avec Hugo.

### Méthode B : En modifiant manuellement le fichier YAML
1. Ouvrez `data/fr/portfolio.yaml`.
2. Descendez à la section `projects.featured:` et collez un bloc comme suit :
```yaml
- title: "Nom du Projet"
  category: "software" # au choix: software | cloud | cyber | ai | embedded
  categoryLabel: "Génie Logiciel"
  date: "2026"
  badge: "Nouveau Projet"
  summary: "Court résumé de ce que fait le système en 2 phrases."
  bullets:
    - "Point clé technique 1"
    - "Point clé technique 2 avec métrique mesurable"
  tags: ["Spring Boot", "Docker", "PostgreSQL"]
  repo: "https://github.com/AchrafHasnaoui31/mon-repo"
```
3. Sauvegardez et compilez avec `hugo --minify`.

---

## ✏️ 3. Modifier vos Textes & Statut de Recrutement

Toutes vos informations sont centralisées dans **`data/fr/portfolio.yaml`** :

| Ce que vous souhaitez modifier | Emplacement dans `data/fr/portfolio.yaml` |
|---|---|
| **Statut de disponibilité / PFE** | `hero.statusPill` et `contact.text` |
| **Texte d'introduction & Pitch** | `hero.tagline` |
| **Sous-titre sous votre nom** | `hero.subtitle` |
| **Chiffres des 4 compteurs statistiques** | Section `stats-counter-card` dans `layouts/partials/sections/about.html` |
| **Expériences en entreprise** | Section `experience.items` |
| **Diplômes & Certifications** | Section `education.items` et `education.certs` |
| **Coordonnées (Email, Téléphone)** | Section `contact` |

---

## 🖼️ 4. Remplacer votre Photo de Profil ou vos CVs

- **Photo de profil** : Remplacez simplement le fichier `static/images/achraf.jpg` par votre nouvelle photo carrée ou portrait (le style CSS applique automatiquement le masque circulaire parfait et le halo rotatif).
- **Mettre à jour un CV PDF** : Déposez votre nouveau PDF dans `static/cv/` en conservant le même nom de fichier (ex: `Achraf_Hasnaoui_CV_Software_Engineer.pdf`).

---

## 🛠️ 5. Commandes Utiles du Script de Gestion

Depuis le dossier `portfolio/` :

```bash
# 1. Lister tous les projets actuels avec leurs catégories
python3 scripts/manage.py list-projects

# 2. Vérifier l'intégrité globale du portfolio (présence des 5 CVs, photos, build Hugo)
python3 scripts/manage.py validate

# 3. Lancer le serveur local de test
hugo server -D
```

---

## 🚀 6. Déploiement en 1 Commande sur GitHub Pages

Une fois vos modifications effectuées :
```bash
cd portfolio
git add .
git commit -m "feat: mise à jour du portfolio"
git push origin main
```
GitHub Actions prendra automatiquement le relais et mettra à jour votre site en ligne sur :
👉 **[https://achrafhasnaoui31.github.io/portfolio/](https://achrafhasnaoui31.github.io/portfolio/)**
