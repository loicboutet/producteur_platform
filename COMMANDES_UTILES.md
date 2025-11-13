# 🛠️ Commandes Utiles - Stripe Demo

## 🔐 Gestion des Credentials

```bash
# Éditer les credentials (ajouter/modifier les clés Stripe)
bin/rails credentials:edit

# Éditer les credentials de production
bin/rails credentials:edit --environment production

# Voir les credentials actuels (console Rails)
bin/rails console
Rails.application.credentials.stripe
```

## 🚀 Démarrage & Serveur

```bash
# Démarrer le serveur
bin/rails server

# Démarrer sur un port spécifique
bin/rails server -p 3001

# Redémarrer le serveur (après changement de config)
touch tmp/restart.txt
```

## 💾 Base de Données

```bash
# Créer la base de données
bin/rails db:create

# Exécuter les migrations
bin/rails db:migrate

# Charger les données de démonstration
bin/rails db:seed

# Réinitialiser complètement la base (⚠️ supprime toutes les données)
bin/rails db:reset

# Rollback de la dernière migration
bin/rails db:rollback

# Voir le statut des migrations
bin/rails db:migrate:status

# Ouvrir la console Rails
bin/rails console

# Vérifier les données dans la console
bin/rails console
User.count
Producer.count
Product.count
Order.count
```

## 🧪 Tests & Vérifications

```bash
# Vérifier les routes
bin/rails routes | grep stripe
bin/rails routes | grep producer
bin/rails routes | grep product
bin/rails routes | grep order

# Vérifier la configuration Stripe (console)
bin/rails console
Stripe.api_key
Rails.configuration.stripe

# Tester une clé Stripe (console)
bin/rails console
Stripe::Account.list(limit: 1)
```

## 🔍 Debugging

```bash
# Voir les logs en temps réel
tail -f log/development.log

# Effacer les logs
> log/development.log

# Vérifier les erreurs Stripe dans la console
bin/rails console
# Puis essayer une opération Stripe manuellement
```

## 📦 Dépendances

```bash
# Installer les gems
bundle install

# Mettre à jour Stripe
bundle update stripe

# Voir la version de Stripe installée
bundle info stripe
```

## 🎨 Assets

```bash
# Compiler les assets CSS (Tailwind)
bin/rails assets:precompile

# Nettoyer les assets
bin/rails assets:clobber
```

## 🔄 Webhooks (Développement Local)

```bash
# Installer Stripe CLI
# Sur macOS :
brew install stripe/stripe-cli/stripe

# Sur Linux/Windows : voir https://stripe.com/docs/stripe-cli

# Se connecter à Stripe CLI
stripe login

# Écouter les webhooks en local
stripe listen --forward-to localhost:3000/stripe/webhooks

# Déclencher un événement de test
stripe trigger payment_intent.succeeded
```

## 👥 Gestion des Utilisateurs

```bash
# Console Rails
bin/rails console

# Lister tous les utilisateurs
User.all

# Créer un nouvel utilisateur
User.create(email: "test@example.com", password: "password123", password_confirmation: "password123")

# Trouver un utilisateur
user = User.find_by(email: "producer1@example.com")

# Voir si c'est un producteur
user.producer?
user.producer

# Créer un producteur pour un user
producer = user.create_producer(
  name: "Test Farm",
  email: "farm@example.com",
  stripe_account_status: "pending"
)
```

## 📊 Statistiques

```bash
# Console Rails
bin/rails console

# Nombre total de commandes payées
Order.paid.count

# Revenu total de la plateforme
Order.paid.sum(:platform_fee)

# Revenu total des producteurs
Order.paid.sum(:producer_amount)

# Produit le plus vendu
Product.joins(:orders).group("products.id").order("COUNT(*) DESC").first

# Producteur avec le plus de ventes
Producer.joins(:orders).where(orders: { status: "paid" }).group("producers.id").order("SUM(orders.producer_amount) DESC").first
```

## 🧹 Nettoyage

```bash
# Supprimer toutes les commandes
bin/rails console
Order.destroy_all

# Supprimer tous les produits
Product.destroy_all

# Supprimer tous les producteurs (ne supprimera pas les users)
Producer.destroy_all

# Réinitialiser complètement (db + seed)
bin/rails db:reset
```

## 🔧 Maintenance

```bash
# Vérifier la santé de l'app
curl http://localhost:3000/up

# Voir la version de Rails
bin/rails --version

# Voir la version de Ruby
ruby --version

# Voir toutes les tâches disponibles
bin/rails --tasks

# Lancer Rubocop (code quality)
bin/rubocop

# Corriger automatiquement les violations Rubocop
bin/rubocop -a
```

## 🎯 Stripe Specific

```bash
# Console Rails - Tester Stripe Connect
bin/rails console

# Créer un compte Stripe test
producer = Producer.first
account = StripeConnectService.create_account(producer)

# Vérifier le statut d'un compte
StripeConnectService.update_account_status(producer)

# Créer un payment intent de test
order = Order.first
payment_intent = StripePaymentService.create_payment_intent(order)

# Récupérer un payment intent
pi = StripePaymentService.retrieve_payment_intent("pi_xxx...")
```

## 🚨 Résolution de Problèmes

```bash
# Problème de credentials
bin/rails credentials:edit
# Vérifier que stripe: est bien configuré

# Problème de base de données
bin/rails db:reset

# Problème de gems
bundle install
bundle clean --force

# Problème de serveur qui ne démarre pas
pkill -9 ruby  # Tuer tous les processus Ruby
bin/rails server

# Voir les processus Rails en cours
ps aux | grep rails
```

## 📝 Logs & Monitoring

```bash
# Voir les logs de développement
tail -f log/development.log

# Filtrer les logs Stripe
tail -f log/development.log | grep -i stripe

# Voir les requêtes SQL
tail -f log/development.log | grep -i "select\|insert\|update"

# Voir les erreurs uniquement
tail -f log/development.log | grep -i error
```

## 🎓 Apprentissage

```bash
# Explorer le code dans la console
bin/rails console

# Voir tous les producteurs avec leur Stripe account
Producer.all.each { |p| puts "#{p.name}: #{p.stripe_account_id}" }

# Voir toutes les commandes avec leur statut
Order.all.each { |o| puts "Order ##{o.id}: #{o.status} - #{o.formatted_total}" }

# Calculer des splits de test
StripePaymentService.calculate_split(100.00)
# => { total_amount: 100.0, platform_fee: 10.0, producer_amount: 90.0 }
```

## 🔐 Sécurité

```bash
# Vérifier que master.key n'est pas versionné
git ls-files | grep master.key
# Ne devrait rien retourner

# Vérifier le .gitignore
cat .gitignore | grep -E "(master.key|credentials)"

# Régénérer les credentials si compromis
rm config/credentials.yml.enc
bin/rails credentials:edit
# Reconfigure tout
```

## 📚 Documentation

```bash
# Générer la documentation du code
yard doc

# Ouvrir la doc Stripe
open https://stripe.com/docs/connect

# Ouvrir les guides Rails
open https://guides.rubyonrails.org/
```

## 🎉 Commandes de Production

```bash
# Compiler les assets pour production
RAILS_ENV=production bin/rails assets:precompile

# Lancer les migrations en production
RAILS_ENV=production bin/rails db:migrate

# Lancer les credentials de production
bin/rails credentials:edit --environment production
```

---

## 📋 Checklist Quotidienne

```bash
# 1. Vérifier que le serveur tourne
curl http://localhost:3000/up

# 2. Vérifier les logs
tail -n 50 log/development.log

# 3. Vérifier les credentials Stripe
bin/rails console
Rails.application.credentials.stripe

# 4. Tester un paiement
# Aller sur http://localhost:3000 et faire un achat test
```

---

**Besoin d'aide ?** Consultez les guides dans le dossier du projet ! 📖
