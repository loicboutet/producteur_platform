# Tâche : Corriger le chargement des assets dans le Style Guide

## ✅ RÉSOLU - Novembre 2024

## Problème rencontré

Le style guide mockup (`/mockups/styleguide`) générait une erreur `Propshaft::MissingAssetError` :
```
The asset 'silloun-RVB-logo-jaune.png' was not found in the load path.
```

## Cause racine

**Le problème était que Propshaft utilisait `Propshaft::Resolver::Static` qui lit depuis `public/assets/.manifest.json` au lieu de `Propshaft::Resolver::Dynamic`.**

Quand un fichier `public/assets/.manifest.json` existe (même incomplet), Propshaft utilise ce fichier pour résoudre les assets au lieu de les chercher dynamiquement dans les load paths.

Le manifest avait été généré partiellement (CSS/JS uniquement) et ne contenait pas les fichiers images.

## Solution appliquée

**Supprimer le dossier `public/assets/` en développement pour forcer Propshaft à utiliser le resolver dynamique :**

```bash
rm -rf public/assets
touch tmp/restart.txt
```

Cette commande :
1. Supprime le manifest statique
2. Force Propshaft à utiliser `Propshaft::Resolver::Dynamic`
3. Les assets sont alors résolus depuis les load paths en temps réel

## Comment éviter ce problème à l'avenir

### En développement

- Ne jamais exécuter `bin/rails assets:precompile` en développement
- Si des problèmes surviennent, supprimer `public/assets/`
- Propshaft sert les assets dynamiquement sans nécessiter de précompilation

### En production

- `bin/rails assets:precompile` génère tous les assets dans `public/assets/`
- Le manifest inclura tous les fichiers (images, CSS, JS, fonts)

### Vérification diagnostic

```bash
# Vérifier le type de resolver utilisé
bin/rails runner "puts Rails.application.assets.resolver.class.to_s"

# Devrait retourner:
# - Development (sans public/assets): Propshaft::Resolver::Dynamic
# - Production (avec public/assets): Propshaft::Resolver::Static

# Vérifier si les assets sont dans le load path
bin/rails runner "
Rails.application.assets.load_path.assets.select { |a| 
  a.logical_path.to_s.include?('silloun') 
}.each { |a| puts a.logical_path.to_s }
"
```

## Fichiers concernés

- `app/views/mockups/styleguide.html.erb` - Vue du style guide
- `app/views/layouts/mockup_styleguide.html.erb` - Layout du style guide  
- `app/helpers/silloun_helper.rb` - Helper pour les assets Silloun
- `app/assets/images/silloun-*.png` - Images de la marque

## Tests validés

Les tests dans `test/controllers/mockups_controller_test.rb` vérifient :
- ✅ Page `/mockups/styleguide` se charge sans erreur
- ✅ Images logo sont présentes (`img[src*='silloun-RVB-logo']`)
- ✅ Images chapeau sont présentes
- ✅ Images cadre sont présentes
- ✅ Classes de couleurs utilisées (`.bg-silloun-green`, `.bg-silloun-yellow`, etc.)
- ✅ Navigation avec liens d'ancrage fonctionne

## Couleurs officielles Silloun

- **Jaune** : `#FBE216` (RGB: 251, 226, 22)
- **Vert** : `#005D46` (RGB: 0, 93, 70)

Ces couleurs sont définies dans :
- `config/tailwind.config.js` (theme.extend.colors.silloun)
- `app/assets/stylesheets/application.tailwind.css` (@layer utilities)

## Fixtures corrigées

Les fixtures suivantes ont été corrigées pour éviter les erreurs de contrainte UNIQUE :

- `test/fixtures/users.yml` - Emails uniques
- `test/fixtures/producers.yml` - stripe_account_id uniques
- `test/fixtures/orders.yml` - stripe_payment_intent_id uniques  
- `test/fixtures/order_groups.yml` - stripe_payment_intent_id uniques
