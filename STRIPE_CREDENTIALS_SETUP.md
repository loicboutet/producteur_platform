# 🔐 Configuration des Clés Stripe dans Rails Credentials

## Pourquoi les Credentials ?

Au lieu de mettre les clés Stripe dans un fichier `.env`, on utilise **Rails Credentials** :
- ✅ Plus sécurisé (fichier chiffré)
- ✅ Versionné avec le code (mais chiffré)
- ✅ Pas besoin de fichier `.env` séparé
- ✅ La méthode Rails recommandée

## 🚀 Configuration en 3 Étapes

### Étape 1 : Récupérer vos clés Stripe

1. Allez sur **https://dashboard.stripe.com**
2. Connectez-vous (ou créez un compte)
3. Activez le **"Test Mode"** (switch en haut à droite)
4. Cliquez sur **"Developers"** (barre latérale)
5. Cliquez sur **"API keys"**
6. Copiez :
   - **Publishable key** (commence par `pk_test_`)
   - **Secret key** (commence par `sk_test_`)

### Étape 2 : Éditer les Credentials

Dans votre terminal, exécutez :

```bash
bin/rails credentials:edit
```

Cela ouvrira un fichier dans votre éditeur.

### Étape 3 : Ajouter vos Clés Stripe

Dans l'éditeur qui s'ouvre, ajoutez cette structure :

```yaml
# Autres clés existantes...
secret_key_base: xxxxxxxxxxxxxxx

# Ajoutez ceci à la fin :
stripe:
  publishable_key: pk_test_VOTRE_CLE_PUBLIQUE_ICI
  secret_key: sk_test_VOTRE_CLE_SECRETE_ICI
  # webhook_secret: whsec_VOTRE_SECRET_WEBHOOK_ICI  # (Optionnel pour l'instant)
```

**Remplacez** `pk_test_VOTRE_CLE_PUBLIQUE_ICI` et `sk_test_VOTRE_CLE_SECRETE_ICI` par vos vraies clés Stripe !

### Étape 4 : Sauvegarder et Quitter

- Sauvegardez le fichier (Cmd+S ou Ctrl+S)
- Fermez l'éditeur
- Les credentials sont automatiquement rechiffrés

### Étape 5 : Redémarrer le Serveur

```bash
# Arrêtez le serveur (Ctrl+C)
# Puis redémarrez
bin/rails server
```

## ✅ Vérification

Pour vérifier que ça marche, vous pouvez ouvrir la console Rails :

```bash
bin/rails console
```

Puis taper :

```ruby
Rails.application.credentials.stripe
# Devrait afficher : { publishable_key: "pk_test_...", secret_key: "sk_test_..." }
```

Si vous voyez vos clés, c'est bon ! ✅

## 🎯 Exemple Complet

Voici à quoi devrait ressembler votre fichier credentials :

```yaml
# config/credentials.yml.enc (une fois décrypté)

secret_key_base: [votre_secret_key_base_existant]

stripe:
  publishable_key: pk_test_[VOTRE_VRAIE_CLE_PUBLIQUE_STRIPE]
  secret_key: sk_test_[VOTRE_VRAIE_CLE_SECRETE_STRIPE]
  # webhook_secret: whsec_[VOTRE_SECRET_WEBHOOK]  # Optionnel
```

**Note importante :** Remplacez les valeurs entre crochets par vos vraies clés depuis le dashboard Stripe.

## 🔧 Configuration du Webhook Secret (Optionnel)

Le webhook secret n'est nécessaire que pour la production. Pour le développement, vous pouvez l'ignorer.

Si vous voulez le configurer :

1. Dans Stripe Dashboard → **Developers** → **Webhooks**
2. Cliquez sur **"Add endpoint"**
3. URL : `https://votre-domaine.com/stripe/webhooks`
4. Sélectionnez les événements :
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `account.updated`
5. Copiez le **"Signing secret"** (commence par `whsec_`)
6. Ajoutez-le dans vos credentials :

```yaml
stripe:
  publishable_key: pk_test_...
  secret_key: sk_test_...
  webhook_secret: whsec_VOTRE_SECRET_ICI
```

## 🚨 Résolution de Problèmes

### L'éditeur ne s'ouvre pas

```bash
# Définissez votre éditeur préféré
export EDITOR="code --wait"  # Pour VS Code
# ou
export EDITOR="nano"  # Pour nano
# ou
export EDITOR="vim"   # Pour vim

# Puis réessayez
bin/rails credentials:edit
```

### "Couldn't decrypt config/credentials.yml.enc"

Vous avez probablement perdu votre `config/master.key`. Solutions :

**Option 1 : Régénérer les credentials**
```bash
rm config/credentials.yml.enc
bin/rails credentials:edit
# Cela créera de nouveaux credentials
```

**Option 2 : Si vous avez le master.key ailleurs**
```bash
# Copiez-le dans config/master.key
echo "votre_master_key" > config/master.key
```

### Les clés ne sont pas chargées

```bash
# Vérifiez que le fichier config/master.key existe
ls -la config/master.key

# Redémarrez le serveur
bin/rails server
```

### "undefined method `dig' for nil"

Vos credentials Stripe ne sont pas configurés. Relancez :
```bash
bin/rails credentials:edit
```

## 📚 Avantages de cette Méthode

### ✅ Sécurité
- Fichier chiffré avec AES
- Clé de chiffrement (`master.key`) dans `.gitignore`
- Pas de clés en clair dans le code

### ✅ Simplicité
- Une seule commande : `bin/rails credentials:edit`
- Pas besoin de gem supplémentaire
- Fonctionne out-of-the-box avec Rails

### ✅ Par Environnement
Vous pouvez avoir des credentials différents par environnement :
```bash
# Development
bin/rails credentials:edit

# Production
bin/rails credentials:edit --environment production
```

## 🎓 Pour en Savoir Plus

- [Rails Guides - Credentials](https://guides.rubyonrails.org/security.html#custom-credentials)
- [Stripe Docs](https://stripe.com/docs/keys)

## ⚡ Résumé Rapide

```bash
# 1. Éditer les credentials
bin/rails credentials:edit

# 2. Ajouter vos clés Stripe
stripe:
  publishable_key: pk_test_VOTRE_CLE
  secret_key: sk_test_VOTRE_CLE

# 3. Sauvegarder et quitter

# 4. Redémarrer le serveur
bin/rails server

# 5. Tester !
# Visitez http://localhost:3000
```

---

**C'est tout !** Vos clés Stripe sont maintenant stockées de manière sécurisée. 🔐

Pour tester que tout fonctionne, suivez le guide **START_HERE.md** !
