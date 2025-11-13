# 🚀 Démarrage Rapide - Démo Stripe Split Payment

## 🎯 En 3 Minutes Chrono !

### 1. Récupérer les Clés Stripe (1 minute)

1. Allez sur **https://dashboard.stripe.com/register**
2. Créez un compte (gratuit)
3. Activez le **"Test Mode"** (bouton en haut à droite)
4. Cliquez sur **"Developers"** → **"API keys"**
5. Copiez les 2 clés :
   - `pk_test_...` (Publishable key)
   - `sk_test_...` (Secret key)

### 2. Ajouter les Clés dans Rails (1 minute)

```bash
bin/rails credentials:edit
```

Dans l'éditeur qui s'ouvre, ajoutez à la fin :

```yaml
stripe:
  publishable_key: pk_test_VOTRE_CLE_ICI
  secret_key: sk_test_VOTRE_CLE_ICI
```

Sauvegardez (Cmd+S) et fermez.

> 📖 **Guide détaillé** : Voir [STRIPE_CREDENTIALS_SETUP.md](STRIPE_CREDENTIALS_SETUP.md)

### 3. Démarrer le Serveur (30 secondes)

```bash
bin/rails server
```

Visitez : **http://localhost:3000**

## 🧪 Tester la Démo (5 minutes)

### En tant que Producteur

1. **Se connecter** : `producer1@example.com` / `password123`
2. **Cliquer** sur "My Dashboard"
3. **Cliquer** sur "Complete Setup" (vous serez redirigé vers Stripe)
4. **Remplir** avec des données de test :
   - Pays : France
   - Type : Individual
   - Nom : Test Producteur
   - Date naissance : 01/01/1990
   - Téléphone : +33 6 12 34 56 78
   - Adresse : N'importe quelle adresse française
   - Compte bancaire : Cliquez "Skip" (mode test)
5. **Terminer** le formulaire
6. Vous revenez sur votre dashboard avec le statut **✓ Active** !

### En tant qu'Acheteur

1. **Se déconnecter** et se reconnecter avec : `buyer@example.com` / `password123`
2. **Cliquer** sur "Buy Now" sur n'importe quel produit
3. **Entrer** une quantité → "Continue to Payment"
4. **Carte de test** :
   - Numéro : `4242 4242 4242 4242`
   - Expiration : `12/25` (n'importe quelle date future)
   - CVC : `123` (n'importe quels 3 chiffres)
5. **Cliquer** sur "Pay"
6. **Voir** la confirmation avec les détails du split payment ! 🎉

### Vérifier le Split

1. **Se reconnecter** avec : `producer1@example.com` / `password123`
2. **Aller** sur "My Dashboard"
3. **Voir** votre revenu : 90% du paiement
4. **Voir** la commande dans la liste

## 💰 La Magie du Split Payment

Quand un client paie **10€** :
```
Client paie :          10,00€
    ↓
Plateforme garde :      1,00€  (10% - automatique)
Producteur reçoit :     9,00€  (90% - automatique)
```

**Tout est automatique avec Stripe Connect !** Zéro transfert manuel, zéro souci de conformité !

## 🎓 Comptes de Démo

```
Acheteur :    buyer@example.com / password123
Producteur 1: producer1@example.com / password123
Producteur 2: producer2@example.com / password123
```

## 💳 Cartes de Test

```
✅ Succès :            4242 4242 4242 4242
❌ Refusée :           4000 0000 0000 0002
💰 Fonds insuffisants : 4000 0000 0000 9995
🔐 3D Secure :         4000 0027 6000 3184
```

## 🚨 Problèmes Courants

### L'éditeur de credentials ne s'ouvre pas

```bash
# Définir votre éditeur
export EDITOR="code --wait"  # VS Code
# ou
export EDITOR="nano"         # Nano (simple)

# Puis réessayer
bin/rails credentials:edit
```

### "Couldn't decrypt credentials"

```bash
# Vérifier que la master key existe
ls -la config/master.key

# Si elle n'existe pas, voir STRIPE_CREDENTIALS_SETUP.md
```

### "Invalid API key"

1. Vérifier que vos clés commencent par `pk_test_` et `sk_test_`
2. S'assurer d'être en **Test Mode** dans Stripe Dashboard
3. Redémarrer le serveur après modification des credentials

### "Producer cannot receive payments"

Le producteur doit d'abord compléter l'onboarding Stripe (étape "En tant que Producteur" ci-dessus)

## 📚 Documentation Complète

- **STRIPE_CREDENTIALS_SETUP.md** - Guide détaillé pour les credentials
- **STRIPE_SETUP_CHECKLIST.md** - Checklist étape par étape avec dépannage
- **STRIPE_DEMO_GUIDE.md** - Plongée dans l'architecture
- **STRIPE_DEMO_README.md** - Référence technique complète
- **STRIPE_DEMO_SUMMARY.md** - Vue d'ensemble des fonctionnalités

## ✨ Ce qui est Inclus

- ✅ Intégration complète Stripe Connect
- ✅ Split payment automatique (90/10)
- ✅ Flow d'onboarding des producteurs
- ✅ Checkout sécurisé avec Stripe Elements
- ✅ Dashboards producteurs et acheteurs
- ✅ Gestion des commandes
- ✅ Statut de paiement en temps réel
- ✅ Gestion des webhooks
- ✅ UI magnifique avec Tailwind CSS
- ✅ Stockage sécurisé avec Rails Credentials

## 🎯 Cas d'Usage Réels

Cette architecture convient pour :
- 🛒 Marketplace e-commerce (comme Etsy)
- 🚗 Plateformes de covoiturage (comme Uber)
- 🏠 Plateformes de location (comme Airbnb)
- 🎓 Plateformes de cours (comme Udemy)
- 💼 Plateformes de freelancing (comme Upwork)

## 🎉 C'est Parti !

```bash
# 1. Récupérer vos clés Stripe test
# 2. Les ajouter avec : bin/rails credentials:edit
# 3. Démarrer : bin/rails server
# 4. Visiter : http://localhost:3000
# 5. Tester le flow complet !
```

## 🆘 Besoin d'Aide ?

1. **Pour les credentials** → [STRIPE_CREDENTIALS_SETUP.md](STRIPE_CREDENTIALS_SETUP.md)
2. **Pour le setup complet** → [STRIPE_SETUP_CHECKLIST.md](STRIPE_SETUP_CHECKLIST.md)
3. **Pour comprendre le code** → [STRIPE_DEMO_GUIDE.md](STRIPE_DEMO_GUIDE.md)

---

**Tout est prêt !** Il suffit d'ajouter vos clés Stripe et de démarrer le serveur.

Bon développement ! 🚀
