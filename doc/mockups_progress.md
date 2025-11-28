# Progrès des Mockups

Dernière mise à jour : 2025-01-XX

## Résumé
- Total pages : **60 pages**
- Terminées : 60 (100%)
- En cours : 0
- À faire : 0

## État actuel

### Infrastructure créée ✅
- `app/controllers/mockups_controller.rb` - Controller de base (index + styleguide)
- `app/controllers/mockups/base_controller.rb` - Controller de base avec données mockées
- `app/controllers/mockups/public/base_controller.rb` - Controller de base public
- `app/controllers/mockups/account/base_controller.rb` - Controller de base account
- `app/controllers/mockups/producer/base_controller.rb` - Controller de base producer
- `app/controllers/mockups/admin/base_controller.rb` - Controller de base admin
- `app/views/layouts/mockups/application.html.erb` - Layout de base mockups
- `app/views/layouts/mockups/public.html.erb` - Layout public complet (header, footer, nav)
- `app/views/layouts/mockups/account.html.erb` - Layout account avec sidebar
- `app/views/layouts/mockups/producer.html.erb` - Layout producer avec sidebar pro
- `app/views/layouts/mockups/admin.html.erb` - Layout admin avec sidebar dark
- Routes configurées dans `config/routes.rb`

---

## Public (~15 pages) - Phase 1 ✅ COMPLÈTE

| Route | Action | Status | Notes |
|-------|--------|--------|-------|
| `/mockups/public/home` | index | ✅ Fait | Page d'accueil avec géolocalisation, héro, catégories, produits, producteurs, marchés |
| `/mockups/public/products` | index | ✅ Fait | Liste des produits avec filtres et pagination |
| `/mockups/public/products/:id` | show | ✅ Fait | Détail produit avec galerie, producteur, ajout panier |
| `/mockups/public/categories` | index | ✅ Fait | Liste des catégories avec icônes et compteurs |
| `/mockups/public/categories/:slug` | show | ✅ Fait | Produits d'une catégorie avec filtres sidebar |
| `/mockups/public/producers` | index | ✅ Fait | Liste/carte des producteurs avec filtres |
| `/mockups/public/producers/:id` | show | ✅ Fait | Profil public producteur avec points de retrait et produits |
| `/mockups/public/markets` | index | ✅ Fait | Liste/carte des marchés avec filtres jour/distance |
| `/mockups/public/markets/:id` | show | ✅ Fait | Détail marché + producteurs présents + produits |
| `/mockups/public/cart` | show | ✅ Fait | Panier groupé par producteur |
| `/mockups/public/checkout` | show | ✅ Fait | Choix points de retrait par producteur |
| `/mockups/public/checkout/payment` | payment | ✅ Fait | Page paiement Stripe (mockup) |
| `/mockups/public/checkout/success` | success | ✅ Fait | Confirmation commande avec prochaines étapes |
| `/mockups/public/become_producer` | index | ✅ Fait | Formulaire inscription producteur complet |
| `/mockups/public/become_producer/pending` | pending | ✅ Fait | Page attente validation avec timeline |

**Public : 15/15 terminés (100%)** 🎉

---

## Account (~5 pages) - Phase 2 ✅ COMPLÈTE

| Route | Action | Status | Notes |
|-------|--------|--------|-------|
| `/mockups/account/dashboard` | show | ✅ Fait | Dashboard client avec stats, commandes récentes, alertes |
| `/mockups/account/profile` | show | ✅ Fait | Mon profil avec infos, sécurité, notifications |
| `/mockups/account/profile/edit` | edit | ✅ Fait | Éditer profil (formulaire) |
| `/mockups/account/orders` | index | ✅ Fait | Mes commandes avec filtres et liste |
| `/mockups/account/orders/:id` | show | ✅ Fait | Détail commande avec timeline, items, pickup point |

**Account : 5/5 terminés (100%)** 🎉

---

## Producer (~16 pages) - Phase 3 ✅ COMPLÈTE

| Route | Action | Status | Notes |
|-------|--------|--------|-------|
| `/mockups/producer/dashboard` | show | ✅ Fait | Dashboard producteur avec stats, commandes, alertes stock |
| `/mockups/producer/profile` | show | ✅ Fait | Profil producteur avec infos ferme, points de retrait |
| `/mockups/producer/profile/edit` | edit | ✅ Fait | Éditer profil producteur |
| `/mockups/producer/stats` | show | ✅ Fait | Statistiques avec graphiques, top produits, CA |
| `/mockups/producer/products` | index | ✅ Fait | Liste produits avec filtres, stock, statut |
| `/mockups/producer/products/new` | new | ✅ Fait | Formulaire nouveau produit |
| `/mockups/producer/products/:id` | show | ✅ Fait | Détail produit avec stats vente |
| `/mockups/producer/products/:id/edit` | edit | ✅ Fait | Éditer produit |
| `/mockups/producer/orders` | index | ✅ Fait | Liste commandes avec filtres par statut |
| `/mockups/producer/orders/:id` | show | ✅ Fait | Détail commande avec timeline, actions, client |
| `/mockups/producer/pickup_points` | index | ✅ Fait | Point de retrait ferme avec horaires |
| `/mockups/producer/pickup_points/:id/edit` | edit | ✅ Fait | Modifier horaires ferme |
| `/mockups/producer/market_presences` | index | ✅ Fait | Liste présences marchés + marchés disponibles |
| `/mockups/producer/market_presences/new` | new | ✅ Fait | S'inscrire à un marché |
| `/mockups/producer/market_presences/:id/edit` | edit | ✅ Fait | Modifier présence marché |
| `/mockups/producer/stripe` | show | ✅ Fait | Statut paiements, transactions, soldes |
| `/mockups/producer/stripe/connect` | connect | ✅ Fait | Onboarding Stripe Connect |

**Producer : 16/16 terminés (100%)** 🎉

> Note: `pickup_points/new` a été supprimé car les producteurs ne peuvent pas créer de nouveaux points de retrait (la ferme est créée automatiquement, et les marchés sont gérés via market_presences).

---

## Admin (~23 pages) - Phase 4 ✅ COMPLÈTE

| Route | Action | Status | Notes |
|-------|--------|--------|-------|
| `/mockups/admin/dashboard` | show | ✅ Fait | Dashboard admin avec stats, alertes, commandes récentes |
| `/mockups/admin/producers` | index | ✅ Fait | Liste producteurs avec filtres par statut |
| `/mockups/admin/producers/:id` | show | ✅ Fait | Détail producteur avec validation/suspension |
| `/mockups/admin/producers/:id/edit` | edit | ✅ Fait | Modifier producteur, statut, commission |
| `/mockups/admin/users` | index | ✅ Fait | Liste utilisateurs avec rôles |
| `/mockups/admin/users/:id` | show | ✅ Fait | Détail utilisateur avec historique |
| `/mockups/admin/users/:id/edit` | edit | ✅ Fait | Modifier utilisateur et rôle |
| `/mockups/admin/categories` | index | ✅ Fait | Liste catégories avec drag & drop |
| `/mockups/admin/categories/new` | new | ✅ Fait | Nouvelle catégorie |
| `/mockups/admin/categories/:id/edit` | edit | ✅ Fait | Modifier catégorie |
| `/mockups/admin/markets` | index | ✅ Fait | Liste marchés en cards |
| `/mockups/admin/markets/new` | new | ✅ Fait | Nouveau marché avec géolocalisation |
| `/mockups/admin/markets/:id` | show | ✅ Fait | Détail marché + producteurs présents |
| `/mockups/admin/markets/:id/edit` | edit | ✅ Fait | Modifier marché |
| `/mockups/admin/products` | index | ✅ Fait | Liste tous produits avec filtres |
| `/mockups/admin/products/:id` | show | ✅ Fait | Détail produit (lecture seule admin) |
| `/mockups/admin/orders` | index | ✅ Fait | Liste commandes avec filtres statut |
| `/mockups/admin/orders/:id` | show | ✅ Fait | Détail commande avec timeline et actions |
| `/mockups/admin/transactions` | index | ✅ Fait | Liste transactions Stripe |
| `/mockups/admin/transactions/:id` | show | ✅ Fait | Détail transaction avec breakdown |
| `/mockups/admin/finances` | show | ✅ Fait | Vue finances avec CA, commissions, graphiques |
| `/mockups/admin/settings` | show | ✅ Fait | Configuration plateforme |
| `/mockups/admin/settings/edit` | edit | ✅ Fait | Modifier configuration |

**Admin : 23/23 terminés (100%)** 🎉

---

## Éléments Supprimés (Hors Scope)

Les éléments suivants ont été supprimés car ils dépassaient le périmètre contractuel :

| Élément | Raison de suppression |
|---------|----------------------|
| `admin_analytics.html.erb` | "Analytics avancés" explicitement exclu du scope |
| `user_settings.html.erb` | Contenait 2FA, dark mode, multi-langue (hors scope) |
| `user_dashboard.html.erb` (legacy) | Remplacé par `/mockups/account/dashboard` |
| `user_profile.html.erb` (legacy) | Remplacé par `/mockups/account/profile` |
| `admin_dashboard.html.erb` (legacy) | Remplacé par `/mockups/admin/dashboard` |
| `admin_users.html.erb` (legacy) | Remplacé par `/mockups/admin/users` |
| `mockup_admin.html.erb` (layout) | Layout legacy supprimé |
| `mockup_user.html.erb` (layout) | Layout legacy supprimé |
| `pickup_points/new.html.erb` | Les producteurs ne créent pas de pickup points |

---

## Notes d'implémentation

### Design respecté
- ✅ Couleurs Silloun : `#FBE216` (jaune) / `#005D46` (vert)
- ✅ Typographies : font-piepie (titres), font-marydale (accroches), Montserrat (corps)
- ✅ Helpers utilisés : `silloun_logo`, `silloun_chapeau`, `silloun_cadre`
- ✅ Boutons : `btn-silloun-primary`, `btn-silloun-secondary`, `btn-silloun-outline`
- ✅ Mobile-first responsive
- ✅ Yellow frame (cadre jaune) sur les photos producteurs
- ✅ Sidebar navigation pour account, producer et admin

### Structure fichiers finale
```
app/controllers/mockups/
├── base_controller.rb ✅
├── mockups_controller.rb (index + styleguide only)
├── public/
│   ├── base_controller.rb ✅
│   ├── home_controller.rb ✅
│   ├── products_controller.rb ✅
│   ├── categories_controller.rb ✅
│   ├── producers_controller.rb ✅
│   ├── markets_controller.rb ✅
│   ├── carts_controller.rb ✅
│   ├── checkouts_controller.rb ✅
│   └── become_producer_controller.rb ✅
├── account/
│   ├── base_controller.rb ✅
│   ├── dashboards_controller.rb ✅
│   ├── profiles_controller.rb ✅
│   └── orders_controller.rb ✅
├── producer/
│   ├── base_controller.rb ✅
│   ├── dashboards_controller.rb ✅
│   ├── profiles_controller.rb ✅
│   ├── stats_controller.rb ✅
│   ├── products_controller.rb ✅
│   ├── orders_controller.rb ✅
│   ├── pickup_points_controller.rb ✅
│   ├── market_presences_controller.rb ✅
│   └── stripe_controller.rb ✅
└── admin/
    ├── base_controller.rb ✅
    ├── dashboards_controller.rb ✅
    ├── producers_controller.rb ✅
    ├── users_controller.rb ✅
    ├── categories_controller.rb ✅
    ├── markets_controller.rb ✅
    ├── products_controller.rb ✅
    ├── orders_controller.rb ✅
    ├── transactions_controller.rb ✅
    ├── finances_controller.rb ✅
    └── settings_controller.rb ✅

app/views/mockups/
├── index.html.erb ✅
├── styleguide.html.erb ✅
├── public/ (15 pages) ✅
├── account/ (5 pages) ✅
├── producer/ (16 pages) ✅
└── admin/ (23 pages) ✅

app/views/layouts/mockups/
├── application.html.erb ✅
├── public.html.erb ✅
├── account.html.erb ✅
├── producer.html.erb ✅
└── admin.html.erb ✅
```

### Conclusion
🎉 **TOUS LES MOCKUPS IN-SCOPE SONT TERMINÉS !** 🎉

La phase de mockups est complète avec 60 pages couvrant tous les user journeys définis dans les specs.

### Prochaines étapes recommandées
1. ✅ Validation UX/UI des mockups avec les stakeholders
2. 🔲 Passage à l'implémentation réelle des fonctionnalités
3. 🔲 Migration progressive des mockups vers les vues de production
