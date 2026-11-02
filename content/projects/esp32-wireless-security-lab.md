---
title: "Laboratoires de Recherche en Sécurité Sans Fil ESP32 (Wi-Fi / BLE / HID)"
date: 2025-04-01
draft: false
weight: 4
summary: "Suite d'outils matériels sur ESP32 pour l'évaluation de vulnérabilités en lab contrôlé : rogue AP, Evil Twin, deauth, injection HID programmable et analyse de trames BLE."
tags: ["ESP32", "Cybersécurité", "Wi-Fi", "Bluetooth BLE", "HID Injection", "C/C++"]
repo: "https://github.com/AchrafHasnaoui31"
---

# Laboratoires de Recherche en Sécurité Sans Fil ESP32

Suite de bancs de tests matériels conçue sur microcontrôleurs ESP32 à des fins de recherche et d'audit de sécurité dans un environnement de laboratoire maîtrisé.

## Projets Développés

1. **ESP32 Wireless Security Lab** :
   - Étude des protocoles 802.11 b/g/n, simulation de points d'accès malveillants (*Rogue AP / Evil Twin*).
   - Analyse des trames de management Wi-Fi et audit de robustesse face aux paquets de désauthentification.
   - Énumération et cartographie des services exposés sur les réseaux locaux.
2. **ESP32 HID Security Testing Tool** :
   - Prototypage d'un périphérique d'entrée programmable (émulation clavier USB/HID) pour étudier la surface d'attaque des interfaces physiques.
   - Analyse des risques d'exécution de scripts non autorisés et modélisation des contre-mesures.
3. **ESP32 Bluetooth / BLE Security Lab** :
   - Analyse des trames publicitaires Bluetooth Low Energy (BLE advertisements).
   - Audit de la robustesse des objets connectés face aux connexions non appariées.
