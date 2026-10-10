# Activer le classement Forest Cadet

1. Créer un projet dans https://supabase.com/dashboard (choisir le plan gratuit si proposé).
2. SQL Editor : exécuter `schema.sql` une fois.
3. Authentication / Sign In / Providers : activer **Anonymous Sign-Ins**.
4. Dans les paramètres du projet, récupérer son URL HTTPS et sa clé **publishable** (ou ancienne clé anon). Ne jamais utiliser une clé secret ou service_role dans le jeu.
5. Remplir `public/leaderboard-config.json` pour les futures compilations et `leaderboard-config.json` à la racine du dépôt publié :

```json
{"url":"https://VOTRE-PROJET.supabase.co","publishableKey":"VOTRE-CLE-PUBLIQUE"}
```

Le bouton Classement ouvre le top 20, suspend la partie et permet d'envoyer un score après la fin d'une partie. Arcade et Classique sont séparés. Un joueur conserve uniquement son meilleur score par catégorie. Le navigateur garde son identité anonyme ; effacer ses données crée un nouveau joueur. Pseudos et scores sont publics, pas les identifiants de connexion. Une connexion est créée seulement lors de l'envoi volontaire.

Les accès directs à la table sont bloqués ; les fonctions SQL limitent les champs, les catégories et le nombre de résultats. Le compte authentifié détermine l'identité du joueur. Le score reste calculé côté navigateur : ce classement est amical et ne constitue pas une validation anti-triche pour compétition. Prévoir une simulation ou validation serveur pour des prix/tournois. Les comptes anonymes peuvent être multipliés : surveiller l'utilisation et configurer les limites Supabase avant une large diffusion.

La connexion doit être validée sur le vrai projet : envoi, classement, séparation des catégories, meilleur score conservé et erreur réseau. Sans configuration, le jeu fonctionne et le classement affiche explicitement qu'il n'est pas encore connecté.

Documentation officielle : https://supabase.com/docs/guides/auth/auth-anonymous et https://supabase.com/docs/guides/database/postgres/row-level-security
