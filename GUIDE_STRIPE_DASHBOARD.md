# 🎯 Guide Complet du Dashboard Stripe

## 📍 Navigation dans Stripe Dashboard

Ce guide t'explique **exactement où cliquer** dans Stripe Dashboard pour configurer ta démo.

---

## 🚀 Étape 1 : Créer/Accéder à ton Compte Stripe

### Si tu n'as PAS de compte Stripe :

1. **Va sur** : https://dashboard.stripe.com/register
2. **Entre** :
   - Ton email
   - Un mot de passe
   - Ton pays (France)
3. **Clique** sur "Create account"
4. **Vérifie** ton email (tu recevras un lien de confirmation)
5. **Clique** sur le lien dans l'email
6. Tu arrives sur le Dashboard Stripe ! 🎉

### Si tu as DÉJÀ un compte Stripe :

1. **Va sur** : https://dashboard.stripe.com/login
2. **Entre** ton email et mot de passe
3. **Clique** sur "Sign in"
4. Tu arrives sur le Dashboard ! 🎉

---

## ⚠️ ÉTAPE CRITIQUE : Activer le Test Mode

**C'EST LA CHOSE LA PLUS IMPORTANTE !**

### Localisation :

```
┌─────────────────────────────────────────┐
│  🏠 Home    👤 Your Name    [TEST MODE] │  ← Regarde ici !
└─────────────────────────────────────────┘
```

**En haut à droite du Dashboard**, tu verras :
- Soit un bouton qui dit **"Test mode"** en gris
- Soit un bouton qui dit **"Live mode"** en bleu/vert

### Actions :

1. **Clique sur le bouton** (en haut à droite)
2. **Sélectionne "View test data"** ou **"Test mode"**
3. Le bouton devient **GRIS** avec "Test mode"
4. ✅ Parfait ! Tu es en mode test

> 🚨 **IMPORTANT** : Toute la démo utilise le mode TEST. Ne passe JAMAIS en "Live mode" pour cette démo !

---

## 🔑 Étape 2 : Récupérer tes Clés API

### Chemin complet :

```
Dashboard Stripe
  └─ Developers (dans la sidebar gauche)
       └─ API keys (dans le sous-menu)
```

### Instructions détaillées :

1. **Dans la barre latérale gauche**, cherche **"Developers"**
   
   ```
   ┌─────────────────┐
   │ 🏠 Home         │
   │ 💰 Payments     │
   │ 👥 Customers    │
   │ ...            │
   │ 🔧 Developers   │ ← Clique ici !
   └─────────────────┘
   ```

2. **Clique sur "Developers"**

3. **Dans le nouveau menu qui apparaît**, clique sur **"API keys"**
   
   ```
   Developers
   ├─ API keys        ← Clique ici !
   ├─ Webhooks
   ├─ Events
   └─ Logs
   ```

4. **Tu arrives sur la page des clés API**

### Ce que tu vois :

```
┌───────────────────────────────────────────────────────────┐
│                     Standard keys                          │
├───────────────────────────────────────────────────────────┤
│                                                            │
│ Publishable key                                            │
│ pk_test_51KxYz... [Reveal test key]          [📋 Copy]    │
│                                                            │
│ Secret key                                                 │
│ sk_test_51KxYz... ••••••••••••••            [👁️ Reveal]   │
│                                          [🔄 Roll key]     │
│                                                            │
└───────────────────────────────────────────────────────────┘
```

### Actions :

**Pour la Publishable Key (Clé Publique) :**
1. **Clique sur** 📋 **"Copy"** à droite de "Publishable key"
2. La clé est copiée dans ton presse-papier
3. Elle commence par `pk_test_`
4. **Garde-la de côté** (colle-la dans un fichier temporaire)

**Pour la Secret Key (Clé Secrète) :**
1. **Clique sur** 👁️ **"Reveal"** pour voir la clé
2. **Clique sur** 📋 **"Copy"** pour la copier
3. Elle commence par `sk_test_`
4. **Garde-la de côté**

> ⚠️ **Important** : Les clés test commencent TOUJOURS par `pk_test_` et `sk_test_`. Si tu vois `pk_live_` ou `sk_live_`, tu es en Live mode ! Retourne activer le Test mode !

---

## 🎯 Étape 3 : Ajouter les Clés dans Rails

### Ouvre le terminal et lance :

```bash
bin/rails credentials:edit
```

### Dans l'éditeur qui s'ouvre, ajoute :

```yaml
stripe:
  publishable_key: pk_test_COLLE_TA_CLE_PUBLIQUE_ICI
  secret_key: sk_test_COLLE_TA_CLE_SECRETE_ICI
```

### Sauvegarde et ferme :
- **VS Code** : Cmd+S (Mac) ou Ctrl+S (Windows), puis ferme l'onglet
- **Nano** : Ctrl+O, Enter, Ctrl+X
- **Vim** : Esc, `:wq`, Enter

---

## 📊 Étape 4 : Vérifier que ça Marche (Optionnel)

### Une fois que tu as testé l'app, retourne dans Stripe :

**Voir les paiements de test :**

1. **Va dans** : Dashboard → **Payments** (sidebar gauche)
2. Tu verras tous les paiements effectués
3. **Clique sur un paiement** pour voir les détails

**Ce que tu dois voir :**

```
┌────────────────────────────────────────────────────────┐
│  Payment details                                        │
├────────────────────────────────────────────────────────┤
│  Amount:              €4.99                            │
│  Status:              Succeeded ✅                      │
│  Payment method:      •••• 4242                        │
│  Customer:            buyer@example.com                │
│                                                         │
│  ⚡ Application fee:  €0.50                            │
│  💸 Transfer:         €4.49 to Green Valley Farm       │
└────────────────────────────────────────────────────────┘
```

Tu verras :
- Le **montant total** payé par le client
- L'**application fee** (ta commission de 10%)
- Le **transfer** vers le producteur (90%)

---

## 🎓 Bonus : Comprendre le Dashboard Stripe

### Menu Principal (Sidebar Gauche)

```
┌─────────────────────────┐
│ 🏠 Home                 │ ← Vue d'ensemble
│ 💰 Payments             │ ← Tous les paiements
│ 💳 Payment methods      │ ← Cartes enregistrées
│ 👥 Customers            │ ← Liste des clients
│ 🔄 Subscriptions        │ ← Abonnements (pas utilisé ici)
│ 📊 Reporting            │ ← Statistiques
│ 💼 Connect              │ ← Gestion des comptes producteurs
│ 🔧 Developers           │ ← API keys, webhooks, logs
│ ⚙️  Settings            │ ← Configuration générale
└─────────────────────────┘
```

### Sections Importantes pour la Démo

**1. Home (Accueil)**
- Résumé des paiements du jour
- Graphique des ventes
- Solde disponible

**2. Payments (Paiements)**
- Liste de tous les paiements test
- Détails de chaque transaction
- Voir les splits et commissions

**3. Connect**
- Liste des comptes producteurs créés
- Statut de leur onboarding
- Détails de leurs comptes

**4. Developers > API keys**
- Clés API pour l'intégration
- Gestion des clés

**5. Developers > Webhooks**
- Configuration des webhooks (optionnel)
- Logs des événements

**6. Developers > Logs**
- Tous les appels API
- Erreurs et succès
- Super utile pour débugger !

---

## 🔍 Étape 5 : Voir les Comptes Producteurs (Après Test)

### Chemin :

```
Dashboard → Connect → Accounts
```

### Instructions :

1. **Clique sur "Connect"** dans la sidebar gauche
2. **Clique sur "Accounts"**
3. Tu verras la liste des producteurs qui ont complété l'onboarding

### Ce que tu vois :

```
┌────────────────────────────────────────────────────────────┐
│  Connected accounts                                         │
├────────────────────────────────────────────────────────────┤
│  Green Valley Farm                                         │
│  acct_1234567890abcdef          Express   ✅ Enabled       │
│  contact@greenvalley.com                                   │
│  Created: Jan 30, 2024                                     │
├────────────────────────────────────────────────────────────┤
│  Sunny Hills Orchard                                       │
│  acct_0987654321fedcba          Express   ⏳ Pending       │
│  hello@sunnyhills.com                                      │
│  Created: Jan 30, 2024                                     │
└────────────────────────────────────────────────────────────┘
```

**Statuts possibles :**
- ✅ **Enabled** : Peut recevoir des paiements
- ⏳ **Pending** : Onboarding non terminé
- ⚠️ **Restricted** : Problème, vérification nécessaire

---

## 🎯 Actions Avancées (Optionnel)

### 1. Voir les Logs API

**Pourquoi ?** Pour débugger et voir toutes les requêtes entre ton app et Stripe.

**Chemin :**
```
Dashboard → Developers → Logs
```

**Tu verras :**
- Toutes les requêtes API
- Success (200) ou erreurs (400, 500)
- Détails de chaque appel
- Super utile si quelque chose ne marche pas !

### 2. Tester des Webhooks

**Pourquoi ?** Pour recevoir les événements de paiement en temps réel.

**Chemin :**
```
Dashboard → Developers → Webhooks
```

**Actions :**
1. **Clique sur** "Add endpoint"
2. **URL** : `http://localhost:3000/stripe/webhooks` (pour dev local)
3. **Événements** à sélectionner :
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `account.updated`
4. **Clique sur** "Add endpoint"
5. **Copie** le "Signing secret" (commence par `whsec_`)

### 3. Utiliser Stripe CLI (Pour Webhooks en Local)

**Installation :**
```bash
# Mac
brew install stripe/stripe-cli/stripe

# Autres systèmes : https://stripe.com/docs/stripe-cli
```

**Utilisation :**
```bash
# Se connecter
stripe login

# Écouter les webhooks en local
stripe listen --forward-to localhost:3000/stripe/webhooks

# Déclencher un événement de test
stripe trigger payment_intent.succeeded
```

---

## 📱 Vue Mobile du Dashboard

Stripe Dashboard fonctionne aussi sur mobile !

1. **Télécharge l'app Stripe** (iOS/Android)
2. **Connecte-toi** avec ton compte
3. **Utilise-la** pour suivre les paiements en déplacement

---

## 🎓 Ressources Stripe Officielles

### Documentation Utile :

1. **Stripe Connect Guide**
   - https://stripe.com/docs/connect

2. **Destination Charges** (ce qu'on utilise)
   - https://stripe.com/docs/connect/destination-charges

3. **Express Accounts** (type de compte producteur)
   - https://stripe.com/docs/connect/express-accounts

4. **Test Cards** (toutes les cartes de test)
   - https://stripe.com/docs/testing#cards

5. **API Reference**
   - https://stripe.com/docs/api

---

## 🎯 Checklist Rapide

### Configuration Initiale :
- [ ] Compte Stripe créé
- [ ] **Test Mode activé** (bouton gris en haut à droite)
- [ ] API keys copiées (pk_test_ et sk_test_)
- [ ] Clés ajoutées dans `bin/rails credentials:edit`
- [ ] Serveur Rails redémarré

### Après Premier Test :
- [ ] Voir le paiement dans Dashboard → Payments
- [ ] Voir le split (Application fee + Transfer)
- [ ] Voir le compte producteur dans Connect → Accounts
- [ ] Vérifier les logs dans Developers → Logs

---

## 🚨 Problèmes Courants

### "Invalid API key"

**Cause :** Mauvaises clés ou pas en Test Mode

**Solution :**
1. Retourne dans Dashboard
2. **Vérifie** que le bouton dit "Test mode" (gris)
3. Va dans Developers → API keys
4. **Re-copie** les clés
5. **Vérifie** qu'elles commencent par `pk_test_` et `sk_test_`

### "No such account"

**Cause :** Le producteur n'a pas terminé l'onboarding

**Solution :**
1. Va dans Connect → Accounts
2. Vérifie le statut du compte
3. Si "Pending", le producteur doit terminer son onboarding

### "Cannot charge this customer"

**Cause :** Problème avec la carte de test

**Solution :**
1. Utilise `4242 4242 4242 4242` (toujours valide)
2. Expiration : n'importe quelle date future
3. CVC : n'importe quels 3 chiffres

---

## 💡 Astuces Pro

### 1. Mode Test vs Live

**Test Mode (GRIS) :**
- ✅ Gratuit
- ✅ Cartes de test uniquement
- ✅ Argent fictif
- ✅ Parfait pour le dev

**Live Mode (BLEU/VERT) :**
- ❌ Vrai argent
- ❌ Vraies cartes
- ❌ Frais Stripe appliqués
- ❌ **NE PAS UTILISER pour la démo !**

### 2. Toujours Vérifier les Logs

Après chaque action dans ton app :
1. Va dans Developers → Logs
2. Vérifie que les appels API ont réussi (200)
3. Si erreur, lis le message détaillé

### 3. Utiliser les Test Cards

Stripe fournit des cartes spécifiques pour tester différents cas :

```
✅ Succès :               4242 4242 4242 4242
❌ Déclinée :             4000 0000 0000 0002
💰 Fonds insuffisants :   4000 0000 0000 9995
🔐 3D Secure requis :     4000 0027 6000 3184
⏰ Processing lent :      4000 0000 0000 0077
🔄 Refus puis réussite :  4000 0000 0000 0341
```

---

## 🎉 Récapitulatif des Emplacements

| Action | Chemin Complet |
|--------|----------------|
| **Activer Test Mode** | Bouton en haut à droite du Dashboard |
| **Récupérer API Keys** | Developers → API keys |
| **Voir les paiements** | Payments (sidebar) |
| **Voir les producteurs** | Connect → Accounts |
| **Voir les logs** | Developers → Logs |
| **Configurer webhooks** | Developers → Webhooks |
| **Voir les événements** | Developers → Events |

---

**Voilà ! Tu as maintenant un guide complet pour naviguer dans Stripe Dashboard ! 🎯**

**Question ? Commence par vérifier que tu es bien en Test Mode ! 🧪**
