# Architecture du Modèle de Données - Marketplace Producteurs Locaux

> Ce document décrit l'architecture complète du modèle de données pour la marketplace e-commerce multi-vendeurs.
> Il est destiné aux agents IA et développeurs pour guider l'implémentation.

## Vue d'ensemble

La plateforme connecte des **producteurs agricoles** avec des **consommateurs** en mode **click & collect**.
Elle utilise **Stripe Connect** pour le split payment automatique.

---

## Modèles existants (déjà implémentés)

### User
Gère l'authentification via Devise. Base pour tous les rôles.

```ruby
# Attributs existants :
# - email: string (unique, required)
# - encrypted_password: string
# - reset_password_token: string
# - reset_password_sent_at: datetime
# - remember_created_at: datetime

# Relations existantes :
# - has_one :producer
# - has_many :orders
# - has_many :order_groups
# - has_one :cart
```

**À AJOUTER :**
```ruby
# Nouveaux attributs :
# - role: string (enum: admin, producer, customer) - default: customer
# - first_name: string
# - last_name: string
# - phone: string
# - latitude: decimal (géolocalisation)
# - longitude: decimal (géolocalisation)
# - address: string
# - city: string
# - postal_code: string
```

---

### Producer
Producteur agricole avec intégration Stripe Connect.

```ruby
# Attributs existants :
# - name: string (required)
# - email: string (unique, required)
# - stripe_account_id: string (unique) - ID Stripe Connect
# - stripe_account_status: string (enum: pending, active, restricted)
# - user_id: integer (FK)

# Relations existantes :
# - belongs_to :user
# - has_many :products
# - has_many :orders
```

**À AJOUTER :**
```ruby
# Nouveaux attributs :
# - siret: string (unique, 14 chiffres, required)
# - validated_at: datetime (date de validation par admin)
# - validated_by_id: integer (FK vers User admin)
# - description: text (présentation du producteur)
# - logo: (ActiveStorage attachment)
# - cover_image: (ActiveStorage attachment)
# - latitude: decimal (localisation de la ferme)
# - longitude: decimal (localisation de la ferme)
# - address: string
# - city: string
# - postal_code: string
# - phone: string
# - website: string
# - commission_rate: decimal (default: 10.0) - taux personnalisé optionnel

# Nouvelles relations :
# - has_many :pickup_points
# - has_many :market_presences
# - has_many :markets, through: :market_presences
```

---

### Product
Produits vendus par les producteurs.

```ruby
# Attributs existants :
# - name: string (required)
# - description: text
# - price: decimal(10,2) (required, > 0)
# - stock: integer (required, >= 0)
# - producer_id: integer (FK)

# Relations existantes :
# - belongs_to :producer
# - has_many :orders
# - has_many :cart_items
```

**À AJOUTER :**
```ruby
# Nouveaux attributs :
# - category_id: integer (FK)
# - unit: string (enum: piece, kg, g, litre, bouquet, barquette, etc.)
# - unit_quantity: decimal (ex: 500 pour "500g")
# - available: boolean (default: true) - activation/désactivation manuelle
# - images: (ActiveStorage attachments - multiple)

# Nouvelles relations :
# - belongs_to :category
# - has_many_attached :images
```

---

### Cart
Panier d'achat (session ou utilisateur).

```ruby
# Attributs existants :
# - user_id: integer (FK, optional)
# - session_id: string (unique, required)

# Relations existantes :
# - belongs_to :user, optional: true
# - has_many :cart_items
# - has_many :products, through: :cart_items
```

**Pas de modification nécessaire.**

---

### CartItem
Articles dans le panier.

```ruby
# Attributs existants :
# - cart_id: integer (FK)
# - product_id: integer (FK)
# - quantity: integer (default: 1, > 0)

# Relations existantes :
# - belongs_to :cart
# - belongs_to :product
```

**Pas de modification nécessaire.**

---

### OrderGroup
Groupe de commandes (multi-producteurs).

```ruby
# Attributs existants :
# - user_id: integer (FK)
# - total_amount: decimal(10,2) (required)
# - platform_fee: decimal(10,2) (required)
# - status: string (enum: pending, paid, processing, completed, cancelled, refunded)
# - stripe_payment_intent_id: string (unique)

# Relations existantes :
# - belongs_to :user
# - has_many :orders
```

**À AJOUTER :**
```ruby
# Nouveaux attributs :
# - customer_email: string (pour achat invité)
# - customer_name: string (pour achat invité)
# - customer_phone: string (pour achat invité)
```

---

### Order
Commande individuelle (un produit, un producteur).

```ruby
# Attributs existants :
# - user_id: integer (FK)
# - producer_id: integer (FK)
# - product_id: integer (FK)
# - order_group_id: integer (FK, optional)
# - quantity: integer (required, > 0)
# - total_amount: decimal(10,2) (required)
# - platform_fee: decimal(10,2) (required)
# - producer_amount: decimal(10,2) (required)
# - status: string (enum: pending, paid, processing, completed, cancelled, refunded)
# - stripe_payment_intent_id: string (unique)

# Relations existantes :
# - belongs_to :user
# - belongs_to :producer
# - belongs_to :product
# - belongs_to :order_group, optional: true
```

**À AJOUTER :**
```ruby
# Nouveaux attributs :
# - pickup_point_id: integer (FK) - point de retrait choisi
# - pickup_status: string (enum: pending, ready, picked_up) - default: pending
# - pickup_ready_at: datetime (quand le producteur marque "prêt")
# - picked_up_at: datetime (quand le client récupère)
# - pickup_notes: text (instructions spéciales)

# Nouvelles relations :
# - belongs_to :pickup_point
```

---

## Nouveaux modèles à créer

### Category
Catégories de produits (arborescence simple).

```ruby
# Attributs :
# - name: string (required)
# - slug: string (unique, required)
# - description: text
# - parent_id: integer (FK, self-reference, optional)
# - position: integer (default: 0) - pour l'ordre d'affichage
# - active: boolean (default: true)

# Relations :
# - has_many :products
# - belongs_to :parent, class_name: "Category", optional: true
# - has_many :children, class_name: "Category", foreign_key: "parent_id"

# Exemples de catégories :
# - Fruits & Légumes
#   - Fruits
#   - Légumes
# - Produits laitiers
# - Viandes
# - Œufs
# - Miel & Confitures
# - Pain & Pâtisseries
# - Boissons
```

**Index :** `slug` (unique)

---

### Market
Marchés où les producteurs peuvent être présents.

```ruby
# Attributs :
# - name: string (required)
# - address: string (required)
# - city: string (required)
# - postal_code: string (required)
# - latitude: decimal (required, géolocalisation)
# - longitude: decimal (required, géolocalisation)
# - description: text
# - active: boolean (default: true)

# Relations :
# - has_many :market_presences
# - has_many :producers, through: :market_presences

# Index : latitude, longitude (pour recherche géo)
```

---

### MarketPresence
Présence d'un producteur sur un marché (jours et horaires).

```ruby
# Attributs :
# - producer_id: integer (FK, required)
# - market_id: integer (FK, required)
# - active: boolean (default: true)

# Relations :
# - belongs_to :producer
# - belongs_to :market
# - has_many :market_schedules

# Contrainte : unique sur [producer_id, market_id]
```

---

### MarketSchedule
Créneaux horaires pour une présence marché.

```ruby
# Attributs :
# - market_presence_id: integer (FK, required)
# - day_of_week: integer (0=dimanche, 1=lundi... 6=samedi, required)
# - opening_time: time (required)
# - closing_time: time (required)

# Relations :
# - belongs_to :market_presence

# Validations :
# - day_of_week: 0..6
# - closing_time > opening_time
```

---

### PickupPoint
Points de retrait (ferme ou marché).

```ruby
# Attributs :
# - producer_id: integer (FK, required)
# - name: string (required) - ex: "À la ferme", "Marché de Limoges"
# - pickup_type: string (enum: farm, market) - required
# - market_id: integer (FK, optional) - si type=market
# - address: string (required si farm)
# - city: string (required si farm)
# - postal_code: string (required si farm)
# - latitude: decimal (pour géolocalisation)
# - longitude: decimal (pour géolocalisation)
# - instructions: text (instructions de retrait)
# - active: boolean (default: true)

# Relations :
# - belongs_to :producer
# - belongs_to :market, optional: true
# - has_many :pickup_schedules
# - has_many :orders

# Logique :
# - Si pickup_type=market : utilise l'adresse du market associé
# - Si pickup_type=farm : utilise ses propres coordonnées
```

---

### PickupSchedule
Créneaux d'ouverture pour un point de retrait.

```ruby
# Attributs :
# - pickup_point_id: integer (FK, required)
# - day_of_week: integer (0..6, required)
# - opening_time: time (required)
# - closing_time: time (required)

# Relations :
# - belongs_to :pickup_point

# Note : Pour un pickup_point de type "market", 
# les horaires peuvent être copiés depuis MarketSchedule
# ou définis indépendamment si le producteur a des horaires différents
```

---

### PlatformSettings
Configuration globale de la plateforme (singleton).

```ruby
# Attributs :
# - default_commission_rate: decimal (default: 10.0) - % commission
# - stripe_webhook_secret: string
# - contact_email: string
# - terms_url: string
# - privacy_url: string
# - maintenance_mode: boolean (default: false)

# Note : Table avec une seule ligne, accès via PlatformSettings.current
```

---

## Schéma des relations

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              UTILISATEURS                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   User ──────────┬──────────────────────────────────────────┐               │
│   (Devise)       │                                          │               │
│                  ▼                                          ▼               │
│              Producer ◄──────────────────────────────── validates           │
│              (1:1)                                      (admin)             │
│                  │                                                          │
└──────────────────┼──────────────────────────────────────────────────────────┘
                   │
┌──────────────────┼──────────────────────────────────────────────────────────┐
│                  │           CATALOGUE                                       │
├──────────────────┼──────────────────────────────────────────────────────────┤
│                  │                                                           │
│                  ├──────────────► Product ◄─────────────── Category          │
│                  │               (1:N)                       (N:1)           │
│                  │                                                           │
└──────────────────┼───────────────────────────────────────────────────────────┘
                   │
┌──────────────────┼───────────────────────────────────────────────────────────┐
│                  │           POINTS DE RETRAIT                               │
├──────────────────┼───────────────────────────────────────────────────────────┤
│                  │                                                           │
│                  ├──────────────► PickupPoint ◄──────────── PickupSchedule   │
│                  │               (1:N)                       (1:N)           │
│                  │                  │                                        │
│                  │                  │ (si type=market)                       │
│                  │                  ▼                                        │
│                  ├──────────────► MarketPresence ◄───────── MarketSchedule   │
│                  │               (N:M)                       (1:N)           │
│                  │                  │                                        │
│                  │                  ▼                                        │
│                  │               Market                                      │
│                  │                                                           │
└──────────────────┼───────────────────────────────────────────────────────────┘
                   │
┌──────────────────┼───────────────────────────────────────────────────────────┐
│                  │           COMMANDES & PAIEMENT                            │
├──────────────────┼───────────────────────────────────────────────────────────┤
│                  │                                                           │
│   User ──────────┼──────────────► Cart ◄────────────────── CartItem          │
│                  │               (1:1)                       (1:N)           │
│                  │                  │                          │             │
│                  │                  │ (checkout)               │             │
│                  │                  ▼                          ▼             │
│                  │              OrderGroup ◄───────────────► Order           │
│                  │               (1:N)                       (N:1)           │
│                  │                  │                          │             │
│                  │                  │                          │             │
│                  │                  │                          ▼             │
│                  │                  │                      PickupPoint       │
│                  │                  │                                        │
│                  │                  ▼                                        │
│                  │           Stripe Payment Intent                           │
│                  │                  │                                        │
│                  │                  ├──────────► Platform (commission)       │
│                  │                  │                                        │
│                  └──────────────────┴──────────► Producer Stripe Account     │
│                                                 (via Transfer)               │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Flux de données Stripe Connect

### Pattern utilisé : "Separate Charges and Transfers"

Ce pattern est déjà implémenté dans `StripeMultiTransferService`. Il permet :
- Un seul paiement client
- Distribution automatique vers plusieurs producteurs
- Commission plateforme déduite automatiquement

```
Client paie 100€ ──► Stripe Platform Account
                           │
                           ├──► 10€ (10% commission) ──► Plateforme
                           │
                           ├──► 45€ ──► Transfer ──► Producteur A (Stripe Connect)
                           │
                           └──► 45€ ──► Transfer ──► Producteur B (Stripe Connect)
```

### Statuts Stripe Account (Producer)
- `pending` : Compte créé, onboarding non terminé
- `active` : Peut recevoir des paiements (charges_enabled=true)
- `restricted` : Compte limité (documents manquants)

---

## Workflow des commandes Click & Collect

### Statuts Order/OrderGroup

| Statut | Description |
|--------|-------------|
| `pending` | Commande créée, en attente de paiement |
| `paid` | Paiement confirmé par Stripe |
| `processing` | En cours de préparation par le producteur |
| `ready` | Prêt à retirer (notifier client) |
| `completed` | Récupéré par le client |
| `cancelled` | Annulée |
| `refunded` | Remboursée |

### Statuts PickupStatus (Order)

| Statut | Description |
|--------|-------------|
| `pending` | En attente de préparation |
| `ready` | Producteur a marqué "prêt" |
| `picked_up` | Client a récupéré |

---

## Migrations à créer

### Ordre d'exécution recommandé :

1. `AddFieldsToUsers` - Ajouter role, géoloc, coordonnées
2. `AddFieldsToProducers` - SIRET, validation, géoloc
3. `CreateCategories` - Catégories de produits
4. `AddCategoryToProducts` - FK + champs unit
5. `CreateMarkets` - Marchés
6. `CreateMarketPresences` - Présence producteur/marché
7. `CreateMarketSchedules` - Créneaux marchés
8. `CreatePickupPoints` - Points de retrait
9. `CreatePickupSchedules` - Créneaux retrait
10. `AddPickupToOrders` - Lier commandes aux points de retrait
11. `AddGuestFieldsToOrderGroups` - Achat invité
12. `CreatePlatformSettings` - Config globale

---

## Notes d'implémentation

### Géolocalisation
- Utiliser `geocoder` gem pour :
  - Convertir adresses en coordonnées
  - Rechercher producteurs/marchés par distance
  - Scope `near(latitude, longitude, distance_km)`

### ActiveStorage
- Products : multiple images
- Producers : logo + cover_image

### Validations SIRET
- Format : 14 chiffres
- Validation Luhn (optionnel)
- Unicité

### Commission personnalisée
- Par défaut : `PlatformSettings.current.default_commission_rate`
- Override possible par producteur : `producer.commission_rate`

### Achat invité
- Si `user_id` est nil sur OrderGroup, utiliser `customer_email/name/phone`
- Après achat, proposer création de compte

---

## Index recommandés

```ruby
# Géolocalisation
add_index :producers, [:latitude, :longitude]
add_index :markets, [:latitude, :longitude]
add_index :users, [:latitude, :longitude]

# Recherche produits
add_index :products, :category_id
add_index :products, [:producer_id, :available]

# Commandes
add_index :orders, [:producer_id, :status]
add_index :orders, :pickup_point_id
add_index :orders, :pickup_status

# Marchés
add_index :market_presences, [:producer_id, :market_id], unique: true
add_index :pickup_points, [:producer_id, :pickup_type]
```

---

## Prochaines étapes

1. ✅ Documenter le modèle de données (ce fichier)
2. 🔲 Créer les migrations dans l'ordre
3. 🔲 Mettre à jour les modèles existants
4. 🔲 Créer les nouveaux modèles avec validations
5. 🔲 Ajouter les scopes géolocalisation (gem geocoder)
6. 🔲 Configurer ActiveStorage pour les images
7. 🔲 Seeds de test avec données réalistes
