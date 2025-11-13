# 🚀 START HERE - Stripe Split Payment Demo

## 👋 Welcome!

You've got a **complete Stripe Connect implementation** ready to test! This is a working demo of automatic payment splitting for multi-vendor marketplaces.

## ⚡ 3-Step Quick Start

### Step 1️⃣: Get Your Stripe Test Keys

1. Go to **https://dashboard.stripe.com/register** (or sign in)
2. Toggle **"Test Mode"** switch (top right corner)
3. Click **"Developers"** in the left sidebar
4. Click **"API keys"**
5. Copy both keys:
   - **Publishable key** (starts with `pk_test_`)
   - **Secret key** (starts with `sk_test_`)

### Step 2️⃣: Add Your Keys to Rails Credentials

Rails utilise un système de credentials chiffré pour stocker les secrets de manière sécurisée.

```bash
# Ouvrir l'éditeur de credentials
bin/rails credentials:edit
```

Dans l'éditeur qui s'ouvre, ajoutez vos clés Stripe :

```yaml
# À la fin du fichier, ajoutez :
stripe:
  publishable_key: pk_test_VOTRE_CLE_PUBLIQUE_ICI
  secret_key: sk_test_VOTRE_CLE_SECRETE_ICI
```

Sauvegardez (Cmd+S ou Ctrl+S) et fermez l'éditeur.

> 💡 **Besoin d'aide ?** Consultez [STRIPE_CREDENTIALS_SETUP.md](STRIPE_CREDENTIALS_SETUP.md) pour un guide détaillé.

### Step 3️⃣: Start the Server

```bash
bin/rails server
```

Then visit: **http://localhost:3000**

You should see the marketplace homepage! 🎉

## 🧪 Test the Demo (5 minutes)

### Test as a Producer (Seller)

1. **Click "Sign In"** (top right)
2. **Email**: `producer1@example.com`
3. **Password**: `password123`
4. **Click "My Dashboard"**
5. **Click "Complete Setup"** (you'll go to Stripe)
6. **Fill in test data**:
   - Country: France
   - Business: Individual
   - Name: Test Producer
   - DOB: 01/01/1990
   - Phone: +33 6 12 34 56 78
   - Address: Any French address
   - Bank: Click "Skip" (test mode)
7. **Complete the form**
8. You'll return to your dashboard with **✓ Active** status!

### Test as a Buyer

1. **Click "Sign Out"**
2. **Click "Sign In"**
3. **Email**: `buyer@example.com`
4. **Password**: `password123`
5. **Click "Buy Now"** on any product
6. **Enter quantity** and click "Continue to Payment"
7. **Enter test card**:
   - Card: `4242 4242 4242 4242`
   - Expiry: `12/25` (any future date)
   - CVC: `123` (any 3 digits)
8. **Click "Pay"**
9. **See confirmation** showing the split payment! ✨

### Verify the Split

1. **Sign out and back in as**: `producer1@example.com`
2. **Go to "My Dashboard"**
3. **See your revenue**: 90% of the payment
4. **See the order** in your orders list

## 💡 What Just Happened?

When the customer paid **€4.99** for tomatoes:

```
Customer paid:      €4.99
    ↓
Platform kept:      €0.50  (10% - automatically)
Producer received:  €4.49  (90% - automatically)
```

**All handled by Stripe Connect automatically!** No manual transfers, no holding money, no compliance headaches!

## 📚 Next Steps

### If you're stuck:
→ Read **STRIPE_CREDENTIALS_SETUP.md** for credentials help  
→ Read **STRIPE_SETUP_CHECKLIST.md** for detailed troubleshooting

### If you want to understand the code:
→ Read **STRIPE_DEMO_GUIDE.md** for architecture deep dive

### If you need API reference:
→ Read **STRIPE_DEMO_README.md** for complete documentation

### If you want a quick overview:
→ Read **STRIPE_DEMO_SUMMARY.md** for feature list

## 🎯 Demo Accounts

```
Buyer Account:
  Email: buyer@example.com
  Password: password123

Producer Accounts:
  Email: producer1@example.com / producer2@example.com
  Password: password123
```

## 🧪 Test Cards

```
✅ Success:        4242 4242 4242 4242
❌ Declined:       4000 0000 0000 0002
💰 Insufficient:   4000 0000 0000 9995
🔐 3D Secure:      4000 0027 6000 3184
```

## ❗ Common Issues

### L'éditeur de credentials ne s'ouvre pas
**Fix**: 
```bash
export EDITOR="code --wait"  # Pour VS Code
# ou
export EDITOR="nano"         # Pour nano
bin/rails credentials:edit
```

### "Couldn't decrypt credentials"
**Fix**: 
```bash
# Vérifiez que config/master.key existe
ls -la config/master.key
# Si absent, voir STRIPE_CREDENTIALS_SETUP.md
```

### "Invalid API key"
**Fix**: 
1. Vérifiez vos clés dans les credentials : `bin/rails credentials:edit`
2. Assurez-vous qu'elles commencent par `pk_test_` et `sk_test_`
3. Redémarrez le serveur après modification

### "Producer cannot receive payments"
**Fix**: Complete Stripe Connect onboarding first (step 3 above)

### Still stuck?
Check **STRIPE_CREDENTIALS_SETUP.md** then **STRIPE_SETUP_CHECKLIST.md**

## 🎉 What's Included

This demo has:
- ✅ Complete Stripe Connect integration
- ✅ Automatic payment splitting (90/10)
- ✅ Producer onboarding flow
- ✅ Secure checkout with Stripe Elements
- ✅ Producer and buyer dashboards
- ✅ Order management
- ✅ Real-time payment status
- ✅ Webhook handling
- ✅ Beautiful UI with Tailwind CSS
- ✅ Secure credentials management with Rails Credentials
- ✅ 6 comprehensive documentation guides

## 🚀 Ready to Start?

1. ✅ Get Stripe test keys
2. ✅ Add them with `bin/rails credentials:edit`
3. ✅ Run `bin/rails server`
4. ✅ Sign in as producer and complete onboarding
5. ✅ Sign in as buyer and make a purchase
6. ✅ See split payments in action!

## 📖 Documentation Map

```
START_HERE.md                 ← You are here! Quick start
    ↓
STRIPE_CREDENTIALS_SETUP.md   ← How to add Stripe keys securely
    ↓
STRIPE_QUICKSTART.md          ← Alternative 5-minute setup
    ↓
STRIPE_SETUP_CHECKLIST.md     ← Detailed step-by-step
    ↓
STRIPE_DEMO_GUIDE.md          ← Architecture deep dive
    ↓
STRIPE_DEMO_README.md         ← Complete reference
    ↓
STRIPE_DEMO_SUMMARY.md        ← Feature overview
```

## 🎊 You're All Set!

Everything is ready. Just add your Stripe keys to the credentials and start the server!

**Questions?** Check the documentation guides above.

**Ready?** Let's go! 🚀

---

**P.S.** Don't forget to use **TEST MODE** keys! Look for the toggle in Stripe Dashboard.
