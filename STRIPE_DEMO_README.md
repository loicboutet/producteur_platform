# 💳 Stripe Split Payment Demo - Setup Guide

This demo implements a complete Stripe Connect split payment system for a multi-vendor marketplace.

## 🎯 What This Demo Shows

- **Stripe Connect Express Accounts** for producers (sellers)
- **Automatic Split Payments** using Destination Charges pattern
- **10% Platform Commission** automatically deducted
- **Secure Payment Processing** with Stripe Elements
- **Producer Dashboard** with revenue tracking
- **Complete Order Flow** from cart to payment

## 🚀 Setup Instructions

### 1. Get Your Stripe API Keys

1. Go to [https://dashboard.stripe.com/register](https://dashboard.stripe.com/register)
2. Create a free Stripe account (or sign in)
3. Switch to **Test Mode** (toggle in the dashboard)
4. Go to **Developers > API Keys**
5. Copy your **Publishable Key** and **Secret Key**

### 2. Configure Environment Variables

Create a `.env` file in your project root (or add to your existing one):

```bash
# Stripe API Keys (Test Mode)
STRIPE_PUBLISHABLE_KEY=pk_test_your_key_here
STRIPE_SECRET_KEY=sk_test_your_key_here

# Optional: For webhook signature verification
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret_here
```

### 3. Install Dependencies

```bash
bundle install
```

### 4. Setup Database

```bash
bin/rails db:migrate
bin/rails db:seed
```

This will create:
- 3 users (1 buyer, 2 producers)
- 2 producer profiles
- 6 sample products

### 5. Start the Server

```bash
bin/rails server
```

Visit: [http://localhost:3000](http://localhost:3000)

## 👤 Demo Accounts

After running `db:seed`, you can log in with:

**Buyer Account:**
- Email: `buyer@example.com`
- Password: `password123`

**Producer Accounts:**
- Email: `producer1@example.com` or `producer2@example.com`
- Password: `password123`

## 🧪 Testing the Flow

### As a Producer:

1. **Sign in** as a producer
2. **Complete Stripe Onboarding:**
   - Click "Become a Producer" (if needed)
   - Fill in business details
   - You'll be redirected to Stripe Connect onboarding
   - Use test data (Stripe provides test values)
   - Complete the onboarding process
3. **Add Products** from your dashboard
4. **View Revenue** in your producer dashboard

### As a Buyer:

1. **Browse Products** on the homepage
2. **Select a Product** and click "Buy Now"
3. **Place Order** with desired quantity
4. **Complete Payment** using a test card:
   - Card: `4242 4242 4242 4242`
   - Expiry: Any future date
   - CVC: Any 3 digits
5. **View Order** confirmation with split payment details

## 💰 How Split Payments Work

When a customer pays €100 for a product:

```
Customer Pays:      €100.00
                    ↓
Platform Fee (10%): €10.00  → Goes to platform Stripe account
Producer Gets (90%): €90.00  → Goes directly to producer's Stripe account
```

This is handled automatically by Stripe using the **Destination Charges** pattern:

```ruby
Stripe::PaymentIntent.create({
  amount: 10000, # €100 in cents
  application_fee_amount: 1000, # €10 platform fee
  transfer_data: {
    destination: producer_stripe_account_id
  }
})
```

## 🎨 Key Features

### 1. **Stripe Connect Express**
- Quick onboarding for producers
- Stripe handles identity verification
- Producers manage their account via Stripe Dashboard

### 2. **Split Payment Architecture**
- Money flows directly from customer → producer
- Platform automatically receives commission
- No manual transfers needed

### 3. **Producer Dashboard**
- Real-time revenue tracking
- Order management
- Direct link to Stripe Dashboard

### 4. **Secure Payments**
- PCI compliant (Stripe handles card data)
- SCA (Strong Customer Authentication) ready
- 3D Secure support

## 🔧 Advanced Configuration

### Webhook Setup (Optional)

For production, set up webhooks to handle payment events:

1. Go to **Stripe Dashboard > Developers > Webhooks**
2. Add endpoint: `https://yourdomain.com/stripe/webhooks`
3. Select events:
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `account.updated`
4. Copy the webhook secret and add to `.env`

### Custom Commission Rates

Edit `app/services/stripe_payment_service.rb`:

```ruby
PLATFORM_FEE_PERCENTAGE = 15 # Change from 10 to 15%
```

### Connect Account Types

Currently using **Express** accounts (easiest). Other options:

- **Standard**: More control, producer manages everything
- **Custom**: Full white-label, you handle UI

Change in `app/services/stripe_connect_service.rb`:

```ruby
account = Stripe::Account.create({
  type: "standard", # or "custom"
  # ...
})
```

## 📊 API Endpoints

All payment endpoints are available:

```
POST   /stripe/webhooks              # Webhook receiver
GET    /producers/new                # Create producer profile
POST   /producers                    # Save producer
GET    /producers/:id/dashboard      # Producer dashboard
GET    /products                     # Browse products
POST   /products/:id/orders          # Create order
GET    /orders/:id/payment           # Payment page
POST   /orders/:id/confirm_payment   # Verify payment
```

## 🧪 Test Cards

```
Success:              4242 4242 4242 4242
Declined:             4000 0000 0000 0002
Insufficient Funds:   4000 0000 0000 9995
3D Secure Required:   4000 0027 6000 3184
```

More test cards: [https://stripe.com/docs/testing](https://stripe.com/docs/testing)

## 🚨 Common Issues

### "Producer cannot receive payments yet"

**Cause:** Producer hasn't completed Stripe onboarding
**Fix:** Log in as producer and complete Stripe Connect setup

### "Invalid API Key"

**Cause:** Missing or incorrect Stripe keys
**Fix:** Check your `.env` file and restart server

### Payments not splitting

**Cause:** Using wrong Stripe account or API mode
**Fix:** Ensure you're in Test Mode and using correct keys

## 📚 Learn More

- [Stripe Connect Docs](https://stripe.com/docs/connect)
- [Destination Charges](https://stripe.com/docs/connect/destination-charges)
- [Express Accounts](https://stripe.com/docs/connect/express-accounts)
- [Testing Stripe](https://stripe.com/docs/testing)

## 🎉 What's Next?

To extend this demo:

1. **Add refunds** support
2. **Email notifications** for orders
3. **Producer analytics** with charts
4. **Multi-currency** support
5. **Subscription products**
6. **Payout scheduling**

## 🤝 Need Help?

This is a demo implementation. For production use:

1. Add proper error handling
2. Implement webhook signature verification
3. Add logging and monitoring
4. Handle edge cases (refunds, disputes, etc.)
5. Add comprehensive tests
6. Review Stripe's security best practices

---

**Built with ❤️ using Rails 8, Stripe Connect, and Tailwind CSS**
