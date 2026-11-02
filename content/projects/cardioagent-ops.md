---
title: "CardioAgent-Ops — Plateforme Microservices IA Médicale & MLOps"
date: 2026-01-15
draft: false
weight: 1
summary: "Plateforme microservices pour l'analyse acoustique cardiaque : Librosa DSP, benchmark modèles ML/DL, Fine-Tuning LLM (QLoRA), RAG vectoriel, orchestration Multi-Agents (LangGraph), tracking MLflow, export ONNX et CI/CD."
tags: ["Python", "PyTorch", "MLflow", "ONNX", "QLoRA", "RAG", "FastAPI", "Docker", "CI/CD"]
repo: "https://github.com/AchrafHasnaoui31"
---

# CardioAgent-Ops — Plateforme Microservices IA Médicale & MLOps

Une architecture microservices distribuée pour l'acquisition, le prétraitement de signaux acoustiques cardiaques et le diagnostic assisté par intelligence artificielle générative et agents autonomes.

## Points Clés & Architecture

- **Traitement du Signal Audio** : Extraction de caractéristiques phonocardiogrammes avec Librosa (coefficients MFCC, spectrogrammes de Mel, Zero Crossing Rate).
- **Benchmark Rigoureux de Modèles** : Comparatif systématique entre Decision Trees, Support Vector Machines (SVM), réseaux convolutifs (CNN 1D/2D), Transfer Learning et architecture hybride Transformer-CNN.
- **LLM & IA Générative Spécialisée** : Fine-Tuning de modèles ouverts (Qwen / Llama) via les techniques QLoRA / PEFT pour la synthèse de dossiers médicaux et explicabilité des décisions cliniques.
- **RAG & Recherche Vectorielle** : Moteur de Retrieval-Augmented Generation adossé à Qdrant / ChromaDB pour sourcer les recommandations cliniques.
- **Système Multi-Agents** : Orchestration modulaire avec LangGraph pour coordonner l'agent d'analyse de signal, l'agent de corrélation clinique et l'agent de reporting.
- **MLOps & Industrialisation** :
  - Tracking des hyperparamètres, métriques et artefacts avec MLflow (Model Registry).
  - Export et optimisation des poids en format ONNX pour inférence haute performance.
  - Validation continue (Pytest, couverture de tests, linting).
  - Conteneurisation Docker / Docker Compose et pipeline automatisé sous GitHub Actions.

## Technologies Utilisées

`Python 3.11`, `PyTorch`, `Librosa`, `FastAPI`, `MLflow`, `ONNX Runtime`, `QLoRA`, `LangGraph`, `Qdrant`, `Docker`, `GitHub Actions`.
