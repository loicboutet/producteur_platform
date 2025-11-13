# 💳 Stripe Split Payment Demo

> **A complete Rails 8 implementation of Stripe Connect for multi-vendor marketplaces**

## 🎯 What This Is

A **production-ready demo** showing how to implement **automatic payment splitting** using Stripe Connect. Perfect for marketplaces, platforms, or any app that needs to split payments between sellers and the platform.

### The Magic ✨

When a customer pays **€10**:
- Producer automatically receives **€9** in their bank account
- Platform automatically keeps **€1** as commission
- **Zero manual work**, **zero bank transfers**, **fully automated**!

## 🚀 Quick Start

### 1. Get Stripe Keys (2 minutes)

```bash
# 1. Go to https://dashboard.stripe.com/register
# 2. Toggle "Test Mode"
# 3. Go to Developers > API Keys
# 4. Copy both keys
```

### 2. Configure (1 minute)

Edit `config/initializers/stripe.rb`:
```ruby
Rails.configuration.stripe = {
  publishable_key: "pk_test_YOUR_KEY_HERE",
  secret_key: "sk_test_YOUR_KEY_HERE"
}
```

### 3. Start (1 minute)

```bash
bin/rails server
# Visit http://localhost:3000
```

### 4. Test (5 minutes)

```bash
# Sign in as producer: producer1@example.com / password123
# Complete Stripe onboarding
# Sign in as buyer: buyer@example.com / password123
# Buy a product with card: 4242 4242 4242 4242
# See the split payment in action! 🎉
```

## 📚 Documentation

Choose your path:

### 🏃 **I want to test it NOW** → [STRIPE_QUICKSTART.md](STRIPE_QUICKSTART.md)
5-minute setup, get it running immediately

### ✅ **I want step-by-step guidance** → [STRIPE_SETUP_CHECKLIST.md](STRIPE_SETUP_CHECKLIST.md)
Complete checklist with troubleshooting

### 📖 **I want to understand how it works** → [STRIPE_DEMO_GUIDE.md](STRIPE_DEMO_GUIDE.md)
Deep dive into architecture and code

### 🔧 **I want the technical details** → [STRIPE_DEMO_README.md](STRIPE_DEMO_README.md)
Full API docs, configurations, extensions

### 📊 **I want the overview** → [STRIPE_DEMO_SUMMARY.md](STRIPE_DEMO_SUMMARY.md)
What's included, features, tech stack

## ✨ Features

### 💰 Payment Features
- ✅ Stripe Connect Express accounts
- ✅ Automatic split payments (90/10)
- ✅ Secure checkout with Stripe Elements
- ✅ Real-time payment status
- ✅ Producer revenue dashboards
- ✅ Order tracking
- ✅ Webhook handling

### 👥 User Features
- ✅ Multi-role authentication (Buyer/Producer)
- ✅ Producer onboarding flow
- ✅ Product marketplace
- ✅ Shopping cart & checkout
- ✅ Order history
- ✅ Producer dashboard with analytics

### 🔒 Security
- ✅ PCI compliant (Stripe handles cards)
- ✅ SCA/3D Secure ready
- ✅ CSRF protection
- ✅ Role-based access control
- ✅ Secure webhooks

## 🧪 Demo Accounts

After running `bin/rails db:seed`:

```
Buyer:      buyer@example.com / password123
Producer 1: producer1@example.com / password123
Producer 2: producer2@example.com / password123
```

Test Cards:
```
Success:    4242 4242 4242 4242
Declined:   4000 0000 0000 0002
3D Secure:  4000 0027 6000 3184
```

## 🏗️ What's Built

```
📦 4 Models       (User, Producer, Product, Order)
🎛️  5 Controllers  (Producers, Products, Orders, Webhooks)
🔧 2 Services     (StripeConnect, StripePayment)
🎨 11 Views       (Complete UI with Tailwind CSS)
📖 5 Guides       (Comprehensive documentation)
```

## 🎯 Perfect For Learning

- Stripe Connect implementation
- Multi-tenant payments
- Rails 8 best practices
- Service object patterns
- E-commerce fundamentals
- Secure payment flows
- Webhook handling
- Role-based systems

## 🚀 Real-World Ready

This architecture is used by:
- 🛒 E-commerce marketplaces (Etsy)
- 🚗 Ride-sharing (Uber)
- 🏠 Rentals (Airbnb)
- 🎓 Course platforms (Udemy)
- 💼 Freelancing (Upwork)

## 📊 Tech Stack

- **Rails 8** - Latest Rails with modern conventions
- **Stripe Connect** - Express accounts, destination charges
- **Tailwind CSS** - Beautiful responsive UI
- **Devise** - User authentication
- **SQLite** - Development database
- **Ruby 3.2+** - Modern Ruby

## 🎓 What You'll Learn

1. How to integrate Stripe Connect
2. How automatic payment splitting works
3. How to handle multi-vendor payments
4. How to implement producer onboarding
5. How to build a secure checkout
6. How to handle webhooks
7. How to structure a marketplace app
8. How to implement role-based access

## 📈 Extends Easily

### Quick Additions (1-2 hours)
- Product images
- Email notifications
- Search & filters
- Reviews & ratings

### Medium Projects (1-2 days)
- Refund system
- Multi-currency
- Analytics dashboard
- Subscription products

### Advanced Features (1+ weeks)
- Multi-product cart
- Inventory management
- Shipping integration
- Tax calculation

## 🐛 Troubleshooting

**Can't receive payments?**
→ Complete Stripe onboarding first

**Invalid API key?**
→ Check keys in `config/initializers/stripe.rb`, restart server

**Payment not splitting?**
→ Ensure using Test Mode keys (pk_test_ and sk_test_)

See [STRIPE_SETUP_CHECKLIST.md](STRIPE_SETUP_CHECKLIST.md) for complete troubleshooting.

## 📞 Support Resources

- **Stripe Docs**: https://stripe.com/docs/connect
- **Test Cards**: https://stripe.com/docs/testing
- **Connect Guide**: https://stripe.com/docs/connect/destination-charges
- **Our Guides**: Check the documentation files above

## 🎉 Start Now!

```bash
# 1. Get your Stripe test keys
# 2. Add them to config/initializers/stripe.rb
# 3. Start the server
bin/rails server

# 4. Visit http://localhost:3000
# 5. Follow STRIPE_QUICKSTART.md
# 6. See split payments in action! 🚀
```

## 📝 Files Overview

```
STRIPE_QUICKSTART.md         → Start here! 5-minute guide
STRIPE_SETUP_CHECKLIST.md    → Step-by-step with troubleshooting
STRIPE_DEMO_GUIDE.md         → Architecture deep dive
STRIPE_DEMO_README.md        → Complete technical reference
STRIPE_DEMO_SUMMARY.md       → Features and overview
```

## ⭐ Key Differentiators

- ✅ **Complete**: Not a toy, real marketplace
- ✅ **Educational**: Learn by doing
- ✅ **Production-Ready**: Proper patterns
- ✅ **Well-Documented**: 5 comprehensive guides
- ✅ **Tested**: Works with real Stripe
- ✅ **Modern**: Rails 8, latest Stripe API
- ✅ **Secure**: Best practices throughout

## 🤝 Contributing

This is a demo/learning project. Feel free to:
- Use it for your own projects
- Extend it with new features
- Learn from the code
- Share it with others

## 📄 License

This demo is provided as-is for educational purposes.

---

## 🎊 Ready to See Split Payments in Action?

**Start with**: [STRIPE_QUICKSTART.md](STRIPE_QUICKSTART.md)

**Questions?**: Check [STRIPE_SETUP_CHECKLIST.md](STRIPE_SETUP_CHECKLIST.md)

**Want details?**: Read [STRIPE_DEMO_GUIDE.md](STRIPE_DEMO_GUIDE.md)

---

**Built with ❤️ to demonstrate Stripe Connect done right.**

Happy coding! 🚀
