# 🛒 Guide du Panier Multi-Producteurs avec Split Payment

## 🎯 Fonctionnalité Implémentée

Tu as maintenant un **système de panier complet** qui permet :
- ✅ Ajouter des produits de **plusieurs producteurs** dans le même panier
- ✅ **Un seul paiement** pour tous les produits
- ✅ **Splits automatiques** vers chaque producteur
- ✅ Commission de 10% prélevée automatiquement

## 🏗️ Architecture

### Modèle de Données

```
Cart (Panier)
  └─ CartItems (Articles)
      └─ Product → Producer

OrderGroup (Groupe de commandes)
  └─ Orders (Une commande par producteur)
      └─ Product → Producer

Payment Intent (Stripe)
  └─ Transfers (Un transfer par producteur)
```

### Flux Complet

```
1. Client ajoute des produits au panier
   ├─ Produit A (Producteur 1)
   ├─ Produit B (Producteur 1)
   └─ Produit C (Producteur 2)

2. Client va au checkout
   └─ Voir le récapitulatif par producteur

3. Client paie 50€
   └─ Stripe Payment Intent créé

4. Paiement réussi
   └─ OrderGroup créé
       ├─ Order 1 (Producteur 1): 2 produits
       └─ Order 2 (Producteur 2): 1 produit

5. Transfers automatiques
   ├─ Transfer 1 → Producteur 1: 18€ (20€ - 2€ fee)
   ├─ Transfer 2 → Producteur 2: 27€ (30€ - 3€ fee)
   └─ Plateforme garde: 5€ (10% de 50€)
```

## 💰 Comment Ça Marche (Technique)

### 1. Pattern Utilisé : Separate Charges & Transfers

Au lieu d'utiliser `application_fee_amount` et `transfer_data` (destination charges), on utilise :

```ruby
# 1. Créer un Payment Intent normal
payment_intent = Stripe::PaymentIntent.create({
  amount: 5000, # 50€ en centimes
  currency: "eur"
})

# 2. Une fois payé, créer les transfers manuellement
Stripe::Transfer.create({
  amount: 1800, # 18€ pour producteur 1
  destination: producteur1_stripe_account_id,
  source_transaction: charge_id
})

Stripe::Transfer.create({
  amount: 2700, # 27€ pour producteur 2
  destination: producteur2_stripe_account_id,
  source_transaction: charge_id
})
```

### 2. Calcul des Montants

```ruby
# Par producteur
subtotal = somme_des_produits_du_producteur
platform_fee = subtotal * 0.10
producer_amount = subtotal - platform_fee

# Exemple:
# Producteur 1: 20€ de produits
# → Fee: 2€
# → Reçoit: 18€

# Producteur 2: 30€ de produits
# → Fee: 3€
# → Reçoit: 27€

# Total client paie: 50€
# Total plateforme garde: 5€
# Total producteurs reçoivent: 45€
```

## 🎨 Interface Utilisateur

### Page Panier (`/cart`)

- Liste des produits groupés par producteur
- Quantité modifiable
- Calcul automatique des totaux
- Affichage du split pour chaque producteur
- Bouton "Proceed to Checkout"

### Page Checkout (`/checkout`)

- Récapitulatif de tous les produits
- Breakdown du paiement par producteur
- Information sur le split automatique
- Bouton "Continue to Payment"

### Page Paiement (`/checkout/payment`)

- Formulaire Stripe Elements
- Montant total affiché
- Liste des producteurs qui recevront l'argent
- Message : "Multi-Producer Split Payment"

### Page Confirmation (`/order_groups/:id`)

- Confirmation du paiement
- Détails par producteur
- Montants transférés
- Statut des transfers

## 🔧 Utilisation

### Pour Tester

1. **Ajouter des produits au panier** :
   ```
   - Visite un produit
   - Clique "Add to Cart"
   - Répète pour des produits de différents producteurs
   ```

2. **Voir le panier** :
   ```
   - Clique sur l'icône 🛒 dans la navigation
   - Voir les produits groupés par producteur
   - Voir le calcul du split
   ```

3. **Checkout** :
   ```
   - Clique "Proceed to Checkout"
   - Voir le récapitulatif
   - Clique "Continue to Payment"
   ```

4. **Payer** :
   ```
   - Entre la carte de test: 4242 4242 4242 4242
   - Clique "Pay"
   - Voir la confirmation avec les splits
   ```

### Routes Importantes

```ruby
# Panier
cart_path                    # Voir le panier
add_item_cart_path           # Ajouter un produit
update_item_cart_path        # Modifier la quantité
remove_item_cart_path        # Retirer un produit
clear_cart_path              # Vider le panier

# Checkout
checkout_path                # Page de récapitulatif
payment_checkout_path        # Page de paiement
confirm_payment_checkout_path # Confirmation du paiement

# Order Groups
order_groups_path            # Liste des groupes de commandes
order_group_path(id)         # Détail d'un groupe
```

## 🎯 Cas d'Usage

### Cas 1 : Un Seul Producteur

```
Panier:
  - Tomates (5€) × 2 = 10€
  - Œufs (6€) × 1 = 6€

Total: 16€
Fee: 1.60€
Producteur reçoit: 14.40€
```

### Cas 2 : Deux Producteurs

```
Panier:
  Producteur 1:
    - Tomates (5€) × 2 = 10€
    - Œufs (6€) × 1 = 6€
    Subtotal: 16€
  
  Producteur 2:
    - Pain (5.50€) × 1 = 5.50€
    - Légumes (15€) × 1 = 15€
    Subtotal: 20.50€

Total: 36.50€
Fee totale: 3.65€

Splits:
  - Producteur 1: 14.40€ (16€ - 10%)
  - Producteur 2: 18.45€ (20.50€ - 10%)
  - Plateforme: 3.65€
```

### Cas 3 : Trois Producteurs ou Plus

Le système fonctionne pour un nombre illimité de producteurs !

## 🔒 Sécurité

### Vérifications Automatiques

1. **Stock disponible** : Vérifié avant la création de l'order group
2. **Producteur actif** : Chaque producteur doit avoir `can_receive_payments?`
3. **Montants cohérents** : Validation des calculs
4. **Réduction de stock** : Automatique après paiement réussi

### Gestion des Erreurs

```ruby
# Si un producteur ne peut pas recevoir de paiements
redirect_to cart_path, alert: "Producer X cannot receive payments yet"

# Si pas assez de stock
redirect_to cart_path, alert: "Not enough stock for Product Y"

# Si paiement échoue
order_group.status = "cancelled"
# Pas de réduction de stock
# Pas de transfers
```

## 📊 Avantages de Cette Approche

### ✅ Pour l'Utilisateur
- Un seul paiement (UX simplifiée)
- Pas de paiements multiples
- Vue claire du split

### ✅ Pour les Producteurs
- Reçoivent l'argent directement
- Pas d'attente de transfert manuel
- Transparence totale

### ✅ Pour la Plateforme
- Commission automatique
- Pas de gestion manuelle
- Scalable à l'infini

## 🚀 Extensibilité

### Ce que tu peux ajouter facilement :

1. **Codes promo** :
   ```ruby
   cart.apply_coupon(coupon_code)
   # Réduire le total avant split
   ```

2. **Frais de livraison** :
   ```ruby
   cart.add_shipping_fee(5.00)
   # Ajouter au total
   ```

3. **Commission variable par producteur** :
   ```ruby
   producer.commission_percentage # au lieu de 10% fixe
   ```

4. **Paiement différé** :
   ```ruby
   # Créer les orders sans payer tout de suite
   # Lien de paiement envoyé par email
   ```

## 🧪 Tests

### Scénarios à Tester

1. **Panier vide** :
   - Aller au panier → Message "vide"

2. **Un produit, un producteur** :
   - Ajouter 1 produit
   - Checkout
   - Payer
   - Vérifier le split

3. **Plusieurs produits, un producteur** :
   - Ajouter 2-3 produits du même producteur
   - Vérifier le calcul du total

4. **Plusieurs producteurs** :
   - Ajouter produits de 2-3 producteurs différents
   - Vérifier les splits individuels
   - Vérifier le total général

5. **Stock insuffisant** :
   - Ajouter plus que le stock disponible
   - Vérifier le message d'erreur

6. **Producteur non actif** :
   - Ajouter produit d'un producteur pending
   - Vérifier qu'on ne peut pas checkout

## 📝 Code Important

### Service de Multi-Transfer

Le cœur du système se trouve dans `app/services/stripe_multi_transfer_service.rb` :

```ruby
# Créer le payment intent
def self.create_payment_intent(order_group)
  Stripe::PaymentIntent.create({
    amount: total_cents,
    currency: "eur",
    metadata: { order_group_id: order_group.id }
  })
end

# Créer les transfers après succès
def self.create_transfers(order_group)
  order_group.orders.group_by(&:producer).each do |producer, orders|
    producer_total = orders.sum(:producer_amount)
    
    Stripe::Transfer.create({
      amount: producer_total_cents,
      destination: producer.stripe_account_id,
      source_transaction: charge_id
    })
  end
end
```

## 🎓 Ce que Tu as Appris

1. **Stripe Transfers** : Comment créer des transfers manuels
2. **Multi-Split Payments** : Pattern pour plusieurs destinataires
3. **Cart Management** : Panier en session avec base de données
4. **Order Grouping** : Regrouper plusieurs commandes en un paiement
5. **Atomic Transactions** : Tout réussit ou tout échoue

## 🎉 Résultat Final

Tu as maintenant un système complet de **marketplace multi-vendeurs** avec :
- ✅ Panier persistant en session
- ✅ Support de multiples producteurs
- ✅ Un seul paiement
- ✅ Splits automatiques
- ✅ Commission de 10%
- ✅ Interface claire et intuitive
- ✅ Gestion complète des erreurs

C'est exactement ce qu'utilisent des plateformes comme **Etsy**, **Uber**, ou **Airbnb** ! 🚀

---

**Pour tester : Ajoute des produits de différents producteurs dans ton panier et regarde la magie opérer ! 🛒✨**
