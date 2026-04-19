# 🗄️ SupCount - Database Architecture & Refactoring

![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white) ![Database](https://img.shields.io/badge/Database-Design-success?style=for-the-badge) ![Security](https://img.shields.io/badge/Security-RBAC-red?style=for-the-badge)

## 📝 Contexte du projet
**SupCount** est une application Fintech permettant le partage de dépenses au sein de groupes d'utilisateurs[cite: 157]. [cite_start]La base de données initiale, conçue sans réelle réflexion de modélisation, présentait d'importants problèmes de cohérence, de performance et d'évolutivité[cite: 158]. 

L'objectif de ce projet a été de **repenser entièrement l'architecture de la base de données** afin de garantir sa maintenabilité, sa robustesse et sa sécurité pour les futurs développements de l'entreprise[cite: 159].

## 🎯 Réalisations Techniques
Ce dépôt contient la refonte complète du système d'information, de l'audit initial jusqu'à l'implémentation physique et l'optimisation :

**Modélisation Avancée** : Réalisation du dictionnaire de données et conception rigoureuse des modèles (MCD, MLD, MPD)[cite: 160, 337, 382, 407].
* **Implémentation (DDL & DML)** : Scripts de création des tables avec contraintes d'intégrité et insertion d'un jeu de données de test.
* **Logique Métier & Automatisation** : 
  * Création de **vues** pour simplifier l'analyse des dépenses et l'état des comptes.
  * Développement de **procédures stockées** pour fiabiliser les calculs.
  * Mise en place de **triggers** (déclencheurs) et d'événements planifiés pour automatiser les contrôles.
* **Sécurité (RBAC)** : Création d'utilisateurs techniques et applicatifs avec gestion fine des rôles et des privilèges.
* **Optimisation des performances** : Mise en place d'index composites pour accélérer les requêtes récurrentes (démontré via `EXPLAIN`).

## 🛠️ Choix Technologique
[cite_start]Le SGBD **MySQL** a été retenu pour sa fiabilité dans la gestion de données transactionnelles (lectures/écritures fréquentes des dépenses et remboursements), sa capacité à gérer de forts volumes de données, et sa pertinence pour une Fintech en croissance[cite: 457, 458, 459].

## 📂 Structure du dépôt

📁 **Documentation et Modélisation**
* `argumentation.pdf` : Rapport justifiant les choix d'architecture et de SGBD.
* `dictionnaire.xlsx` : Dictionnaire de données complet.
* `MCD.png` : Modèle Conceptuel de Données.
* `MLD.png` : Modèle Logique de Données.
* `MPD_supcount.png` : Modèle Physique de Données.

📁 **Scripts SQL (Déploiement séquentiel)**
* `01_create.sql` : Création de la base et des tables.
* `02_insert.sql` : Insertion des jeux de données (groupes, utilisateurs, dépenses).
* `03_views.sql` : Implémentation des vues d'analyse.
* `04_procedures.sql` : Implémentation des procédures stockées.
* `05_triggers_events.sql` : Création des événements et déclencheurs.
* `06_users_roles.sql` : Création des utilisateurs, rôles et permissions.
* `07_index_explain.sql` : Ajout des index d'optimisation et tests de performance.

## ⚙️ Comment utiliser
Pour déployer cette architecture localement, exécutez les scripts SQL dans l'ordre de leur numérotation (`01` à `07`) sur une instance MySQL.
