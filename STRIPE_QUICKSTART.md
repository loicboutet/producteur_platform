# 🚀 Stripe Split Payment Demo - Quick Start

## ⚡ 5-Minute Setup

### Step 1: Get Stripe Test Keys (2 minutes)

1. Go to [stripe.com/register](https://dashboard.stripe.com/register)
2. Create account (use any email)
3. Toggle **Test Mode** (top right)
4. Go to **Developers > API Keys**
5. Copy both keys

### Step 2: Configure App (1 minute)

Open `config/initializers/stripe.rb` and replace with your keys:

```ruby
Rails.configuration.stripe = {
  publishable_key: "pk_test_YOUR_KEY_HERE",
  secret_key: "sk_test_YOUR_KEY_HERE"
}
```

Or set environment variables:
```bash
export STRIPE_PUBLISHABLE_KEY="pk_test_YOUR_KEY_HERE"
export STRIPE_SECRET_KEY="sk_test_YOUR_KEY_HERE"
```

### Step 3: Start Server (1 minute)

```bash
bin/rails server
```

### Step 4: Test the Demo (1 minute)

Visit: http://localhost:3000

#### Test as Producer:

1. **Sign in**: `producer1@example.com` / `password123`
2. **Click**: "My Dashboard"
3. **Click**: "Complete Setup" (redirects to Stripe)
4. **Use Test Data**:
   - Country: France (or any)
   - Phone: +33 6 12 34 56 78
   - Business: Individual
   - Legal name: Test Producer
   - DOB: 01/01/1990
   - Address: Use any French address
   - Use "Skip this step" for bank details (test mode)
5. **Complete** onboarding
6. **Add a product** from your dashboard

#### Test as Buyer:

1. **Sign out** and sign in as: `buyer@example.com` / `password123`
2. **Browse products** on homepage
3. **Click "Buy Now"** on any product
4. **Enter quantity** and click "Continue to Payment"
5. **Use test card**: `4242 4242 4242 4242`
   - Expiry: Any future date (e.g., 12/25)
   - CVC: Any 3 digits (e.g., 123)
6. **Click "Pay"**
7. **See confirmation** with split payment details!

## 💡 What You'll See

### Split Payment in Action:

When you pay **€10.00**:
- Platform keeps: **€1.00** (10%)
- Producer receives: **€9.00** (90%)

This happens **automatically** via Stripe Connect!

### In the Producer Dashboard:

- Total revenue (90% of sales)
- Orders list
- Link to full Stripe Dashboard
- Payment status

## 🧪 Test Cards

```
✅ Success:        4242 4242 4242 4242
❌ Declined:       4000 0000 0000 0002
💳 3D Secure:      4000 0027 6000 3184
```

## 🎯 Key URLs

- **Homepage**: http://localhost:3000
- **Products**: http://localhost:3000/products
- **Sign In**: http://localhost:3000/users/sign_in
- **Producer Dashboard**: http://localhost:3000/producer/dashboard

## 🎉 What's Happening?

1. **Customer pays** via Stripe
2. **Stripe automatically**:
   - Takes 10% platform fee
   - Transfers 90% to producer
   - Handles all compliance
3. **Producer sees money** in their Stripe account
4. **No manual transfers** needed!

## 🐛 Troubleshooting

**"Producer cannot receive payments yet"**
→ Complete Stripe onboarding first

**"Invalid API key"**
→ Check your Stripe keys in `config/initializers/stripe.rb`

**Can't see products**
→ Run `bin/rails db:seed` again

**Stripe onboarding won't complete**
→ Make sure you're in Test Mode and using test data

## 📖 Full Documentation

See `STRIPE_DEMO_README.md` for complete docs.

## 🆘 Need Help?

Check your Stripe Dashboard > Logs to see API calls and errors.

---

**That's it! You now have a working split payment system! 🎊**
