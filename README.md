# Forest Cadet · Mountain Bike Pinball

[Jouer sur mobile ou ordinateur](https://tobbylehobbyt-maker.github.io/MTB-pinball/)

Batteurs tactiles gauche/droite ; maintenir puis relâcher le lanceur. Sur ordinateur : A/D ou flèches, Espace pour lancer, P pour pause. Le son démarre après une interaction.

Le bouton **Classement** est intégré au jeu. Le classement Supabase est connecté : voir [SUPABASE.md](SUPABASE.md) et [supabase-schema.sql](supabase-schema.sql). Les scores sont envoyés volontairement en fin de partie. Arcade et Classique ont des records séparés.

Distribution statique pour GitHub Pages, branche main, dossier racine. Aucune installation nécessaire pour jouer. Pour modifier le jeu, télécharger [les sources complètes](forest-cadet-source.tar.gz), installer Node.js puis exécuter npm ci et npm run build. Pour une compilation allégée : PAGES_BUILD=1 npm run build. Copier le contenu de dist à la racine du dépôt pour publier une nouvelle version.

GPL-2.0-or-later. Voir [licence](LICENSE.txt) et [crédits](THIRD_PARTY_NOTICES.txt).
