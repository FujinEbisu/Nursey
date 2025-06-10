# 🤱 NURSEY - Plateforme d'Accompagnement à l'Allaitement Maternel

NURSEY est une application web dédiée à l'accompagnement des mères dans leur parcours d'allaitement maternel. Elle combine l'expertise médicale avec l'intelligence artificielle pour offrir un soutien personnalisé et accessible 24h/24.

## 🎯 Fonctionnalités Principales

### 👩‍⚕️ **Consultation Médicale**
- **Réseau de Médecins Spécialisés** : Accès à des professionnels de santé experts en allaitement
- **Système de Disponibilités** : Consultation des créneaux disponibles des médecins
- **Chat en Temps Réel** : Communication directe avec les professionnels de santé
- **Système d'Avis** : Évaluation et recommandations des médecins

### 🤖 **Assistant IA Spécialisé**
- **Chatbot Expert** : IA alimentée par GPT-4 spécialisée dans l'allaitement maternel
- **Réponses Personnalisées** : Conseils adaptés aux questions spécifiques des mères
- **Support 24h/24** : Assistance immédiate pour les questions urgentes
- **Détection d'Urgence** : Redirection automatique vers un professionnel en cas de symptômes graves

### 👶 **Suivi Personnalisé**
- **Profils Enfants** : Gestion des informations de chaque enfant
- **Journal d'Allaitement** : Suivi des tétées et de l'évolution
- **Historique des Questions** : Conservation des échanges avec l'IA et les médecins
- **Dashboard Personnalisé** : Vue d'ensemble du parcours d'allaitement

### 🏥 **Lieux Sécurisés**
- **Carte des Lieux d'Allaitement** : Localisation des espaces dédiés à l'allaitement
- **Système de Géolocalisation** : Trouver les lieux les plus proches
- **Avis Communautaires** : Partage d'expériences sur les lieux d'allaitement

## 🛠️ Technologies Utilisées

### Backend
- **Ruby on Rails 7.1.5** - Framework web principal
- **PostgreSQL** - Base de données relationnelle
- **Devise** - Authentification et gestion des utilisateurs
- **Solid Queue** - Gestion des tâches asynchrones
- **Solid Cable** - WebSockets temps réel

### Frontend
- **Turbo & Stimulus** - Hotwired pour une expérience SPA
- **Bootstrap 5.2** - Framework CSS responsive
- **Font Awesome** - Icônes
- **SCSS** - Preprocessing CSS

### Services Tiers
- **OpenAI GPT-4** - Intelligence artificielle conversationnelle
- **Cloudinary** - Gestion et stockage des images
- **Geocoder** - Services de géolocalisation

## 🚀 Installation et Configuration

### Prérequis
```bash
- Ruby 3.3.5
- Rails 7.1.5+
- PostgreSQL
- Node.js & Yarn
```

### Installation
```bash
# Cloner le projet
git clone [repository-url]
cd NURSEY

# Installer les dépendances
bundle install
yarn install

# Configuration de la base de données
rails db:create
rails db:migrate
rails db:seed

# Variables d'environnement
cp .env.example .env
# Configurer les clés API (OpenAI, Cloudinary, etc.)

# Démarrer l'application
rails server
```

### Variables d'Environnement
```env
OPENAI_ACCESS_TOKEN=your_openai_api_key
CLOUDINARY_URL=your_cloudinary_url
DATABASE_URL=your_database_url
```

## 👥 Types d'Utilisateurs

### 🤱 **Mères**
- Création de profil avec informations personnelles
- Gestion des profils enfants
- Accès au chatbot IA spécialisé
- Consultation avec médecins
- Suivi du journal d'allaitement

### 👩‍⚕️ **Médecins/Professionnels**
- Profil professionnel avec spécialités
- Gestion des disponibilités
- Chat avec les mères
- Système d'évaluation

## 📱 Architecture de l'Application

### Modèles Principaux
- **User** : Gestion polymorphique des utilisateurs (mères/médecins)
- **Mother** : Profil des mères avec enfants et historique
- **Doctor** : Profil des professionnels avec disponibilités
- **Child** : Informations des enfants
- **Question** : Interactions avec l'IA
- **Message** : Communication entre utilisateurs
- **SafePlace** : Lieux d'allaitement avec géolocalisation

### Contrôleurs Clés
- **QuestionsController** : Gestion du chatbot IA
- **MessagesController** : Chat temps réel
- **DoctorsController** : Gestion des professionnels
- **MothersController** : Profils et suivi des mères
- **SafePlacesController** : Lieux d'allaitement

## 🤖 Système d'IA

L'assistant IA de NURSEY est spécialement conçu pour l'allaitement maternel :

- **Spécialisation** : Réponses uniquement sur l'allaitement maternel
- **Sécurité** : Détection automatique des urgences médicales
- **Limite** : Maximum 3 questions consécutives avant redirection
- **Format** : Réponses structurées en HTML pour une meilleure lisibilité

## 🗺️ Fonctionnalités Géographiques

- **Geocoder** : Localisation automatique des utilisateurs
- **Carte Interactive** : Affichage des lieux d'allaitement
- **Recherche Proximité** : Trouver les lieux les plus proches

## 🔐 Sécurité

- **Devise** : Authentification sécurisée
- **Validation** : Contrôles stricts sur les données utilisateur
- **Polymorphisme** : Séparation claire des rôles utilisateur

## 📈 Déploiement

L'application est prête pour le déploiement avec :
- **Dockerfile** pour la containerisation
- **Procfile** pour Heroku
- **Configuration production** optimisée

## 🤝 Contribution

Ce projet a été développé avec les templates [Le Wagon](https://www.lewagon.com) pour assurer les meilleures pratiques de développement Rails.

---

*NURSEY - Accompagner chaque mère dans son parcours d'allaitement avec expertise médicale et intelligence artificielle.*
