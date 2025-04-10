# Cahier des charges – Marque Profit
## 1. Définition du problème et état de l’art
Le marché actuel des préservatifs reste largement standardisé malgré une demande croissante de personnalisation. La majorité des marques se contentent de proposer des tailles préétablies, quelques variations de goût, et de texture. Ce manque d'adaptation aux besoins spécifiques de chaque utilisateur peut nuire à l’expérience, au confort et, par conséquent, à l'utilisation régulière des préservatifs.

De rares initiatives proposent une personnalisation partielle (par exemple : goût ou taille), mais aucun acteur majeur ne permet aujourd'hui une personnalisation complète et centralisée du produit. L'expérience d’achat elle-même reste souvent clinique et peu engageante.

## 2. Objectif du projet
Le projet Profit a pour objectif de révolutionner l’achat de préservatifs en offrant un unique modèle personnalisable, aussi bien en version externe qu’interne, sur la base de multiples critères :

- Taille et diamètre
- Goût
- Matière
- Texture
- Couleur
- Type de lubrification

Le tout via une plateforme web immersive et intuitive, où l’utilisateur peut configurer son produit comme il le souhaite, visualiser le résultat en temps réel en 3D, et commander directement.

## 3. Périmètre du projet (Cible principale)
Le projet s'adresse prioritairement aux jeunes adultes (18-35 ans), ouverts à l'innovation et à la personnalisation, avec une attention portée au confort, à l’esthétique, et à l’expérience utilisateur.

Cible secondaire :
- Couples souhaitant ajouter une touche de nouveauté ou d'humour à leur vie intime.
- Utilisateurs sensibles aux matières ou allergènes spécifiques.

## 4. Description technique du projet
Back-end
- Langage principal : Lua
  - Framework : Luvit
    - Serveur HTTP léger
    - Gestion des requêtes API personnalisées
    - Interface avec la base de données pour le stockage des profils utilisateurs, commandes, modèles personnalisés

Front-end
- Node.js : Serveur de build pour les outils JS, logique complémentaire si besoin côté serveur
  - React : Application SPA pour l'interface utilisateur
    - Configuration dynamique du préservatif via une interface fluide
  - Three.js : Visualisation 3D en temps réel de la personnalisation du produit
    - Changement de couleur, texture, ajout de labels visuels
    - Animation de rotation et zoom pour voir le produit sous tous les angles

Fonctionnalités prévues :
- Création d’un compte utilisateur
- Système de configuration avancée (taille, goût, texture, etc.)
- Visualisation 3D du produit personnalisé
- Panier, commande, paiement sécurisé
- Historique de commandes
- Sauvegardes de configurations