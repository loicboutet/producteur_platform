# 💳 Stripe Split Payment Demo - Complete Guide

## 🎯 What You've Built

A complete **multi-vendor marketplace** with automatic payment splitting using **Stripe Connect**. Think Etsy, Uber, or Airbnb - but for local producers.

### The Magic ✨

When a customer buys a €10 product:
- Customer pays €10 once
- Producer automatically receives €9 in their bank account
- Platform automatically keeps €1 as commission
- Zero manual work, zero transfers to manage!

## 🏗️ Architecture Overview

```
Customer
   ↓ (pays €10)
Stripe Payment Intent
   ↓ (automatically splits)
   ├→ Platform Account (€1) - 10% commission
   └→ Producer Account (€9) - Direct to their bank
```

### Why This is Powerful

1. **Legal Compliance**: Stripe handles all regulations
2. **Instant**: Money arrives in producer's account immediately
3. **Secure**: You never touch the money
4. **Scalable**: Works for 1 or 10,000 producers
5. **Global**: Supports 40+ countries

## 📊 Database Schema

```
┌─────────────┐       ┌──────────────┐       ┌──────────────┐
│   Users     │──────▶│  Producers   │──────▶│  Products    │
├─────────────┤       ├──────────────┤       ├──────────────┤
│ id          │       │ id           │       │ id           │
│ email       │       │ user_id      │       │ producer_id  │
│ password    │       │ name         │       │ name         │
└─────────────┘       │ email        │       │ price        │
                      │ stripe_id    │       │ stock        │
                      │ status       │       └──────────────┘
                      └──────────────┘              │
                                                    ▼
                      ┌──────────────┐       ┌──────────────┐
                      │   Orders     │◀──────│  Customers   │
                      ├──────────────┤       └──────────────┘
                      │ id           │
                      │ user_id      │
                      │ product_id   │
                      │ producer_id  │
                      │ total_amount │
                      │ platform_fee │
                      │ producer_amt │
                      │ stripe_pi_id │
                      └──────────────┘
```

## 🔐 Stripe Connect Flow

### 1. Producer Onboarding

```ruby
# app/services/stripe_connect_service.rb
Stripe::Account.create({
  type: "express",           # Easiest option for producers
  country: "FR",
  email: producer.email,
  capabilities: {
    card_payments: { requested: true },
    transfers: { requested: true }
  }
})
```

**What happens:**
1. Producer clicks "Become a Producer"
2. We create a Stripe Express account
3. Stripe handles identity verification
4. Producer can receive payments!

### 2. Split Payment

```ruby
# app/services/stripe_payment_service.rb
Stripe::PaymentIntent.create({
  amount: 10000,                      # €100 in cents
  currency: "eur",
  application_fee_amount: 1000,       # €10 platform fee
  transfer_data: {
    destination: producer.stripe_account_id  # Rest goes here
  }
})
```

**What happens:**
1. Customer enters card details
2. Stripe charges €100
3. Stripe automatically:
   - Keeps €10 in your account (platform fee)
   - Transfers €90 to producer's account
4. Done! No manual intervention needed.

## 💰 Revenue Flow

### Traditional Marketplace (Manual)

```
Day 1: Customer pays €100
       ↓
Day 1: €100 arrives in platform account
       ↓
Day 7: Platform manually transfers €90 to producer
       ↓
Day 14: Producer receives €90
       ⚠️  Platform holds money, tax complications, manual work
```

### With Stripe Connect (Automatic)

```
Day 1: Customer pays €100
       ↓
Day 1: €90 → Producer account (instant)
       €10 → Platform account (instant)
       ✅ Automatic, compliant, no holding money
```

## 🎨 Key Components

### 1. Models

**Producer** (`app/models/producer.rb`)
- Links User to Stripe account
- Tracks verification status
- Methods: `can_receive_payments?`, `stripe_account`

**Product** (`app/models/product.rb`)
- Belongs to Producer
- Price in euros (converted to cents for Stripe)
- Stock management

**Order** (`app/models/order.rb`)
- Links Customer + Producer + Product
- Calculates split automatically
- Tracks payment status

### 2. Services

**StripeConnectService** (`app/services/stripe_connect_service.rb`)
- Creates Stripe accounts
- Generates onboarding links
- Checks account status

**StripePaymentService** (`app/services/stripe_payment_service.rb`)
- Creates payment intents with splits
- Handles webhooks
- Calculates commission

### 3. Controllers

**ProducersController**
- Signup flow
- Dashboard
- Stripe onboarding redirect

**OrdersController**
- Checkout flow
- Payment page with Stripe Elements
- Order confirmation

**StripeWebhooksController**
- Receives events from Stripe
- Updates order status
- Handles failures

## 🧪 Testing Scenarios

### Scenario 1: Successful Purchase

1. **Producer Setup**
   ```
   Login as: producer1@example.com
   Complete Stripe onboarding
   Add a product
   ```

2. **Customer Purchase**
   ```
   Login as: buyer@example.com
   Buy product
   Card: 4242 4242 4242 4242
   → Payment succeeds
   → Order status: "paid"
   → Producer sees revenue in dashboard
   ```

3. **Verify Split**
   ```
   Check Stripe Dashboard:
   - Platform account: +€1.00
   - Producer account: +€9.00
   ```

### Scenario 2: Failed Payment

1. **Customer attempts purchase**
   ```
   Card: 4000 0000 0000 0002 (declined card)
   → Payment fails
   → Order status: "cancelled"
   → Stock NOT reduced
   → Money NOT transferred
   ```

### Scenario 3: Incomplete Onboarding

1. **Producer hasn't completed Stripe**
   ```
   Product shows: "Producer cannot receive payments yet"
   Buy button: Disabled
   → Protects customer and producer
   ```

## 📱 User Flows

### Producer Journey

```
1. Sign Up
   ↓
2. Click "Become a Producer"
   ↓
3. Enter business name & email
   ↓
4. Redirected to Stripe
   ↓
5. Complete identity verification
   ↓
6. Redirected back to dashboard
   ↓
7. Add products
   ↓
8. Receive payments automatically!
```

### Customer Journey

```
1. Browse products (no login needed)
   ↓
2. Click "Buy Now"
   ↓
3. Sign in / Sign up
   ↓
4. Select quantity
   ↓
5. Enter card details (Stripe Elements)
   ↓
6. Payment processed
   ↓
7. Confirmation page
   ↓
8. View order history
```

## 🔒 Security Features

### 1. PCI Compliance
- Card data never touches your server
- Stripe Elements handles sensitive data
- Stripe is PCI Level 1 certified

### 2. Authentication
- Devise for user management
- Role-based access control
- Producer can only edit own products

### 3. Payment Security
- SCA (Strong Customer Authentication) ready
- 3D Secure support
- Fraud detection by Stripe

### 4. Data Protection
- Stripe account IDs encrypted
- Payment intents validated
- Webhook signature verification (optional but recommended)

## 📈 Scaling Considerations

### For 100 Producers
✅ Current setup works perfectly
- Database: SQLite fine
- Payments: Instant splits
- Cost: ~2.9% + €0.30 per transaction

### For 1,000 Producers
🔄 Minor optimizations needed
- Database: Move to PostgreSQL
- Caching: Add Redis for dashboards
- Search: Add Elasticsearch for products
- Cost: Same per-transaction

### For 10,000+ Producers
🚀 Major scaling needed
- Database: Sharding/replication
- Queue: Background jobs for webhooks
- CDN: Product images
- Monitoring: Application performance
- Custom Stripe account: Better rates

## 💡 Extension Ideas

### 1. Advanced Features
```ruby
# Subscription products
Stripe::Price.create({
  product: product_id,
  recurring: { interval: "month" },
  unit_amount: 999
})

# Coupons & discounts
Stripe::Coupon.create({
  percent_off: 20,
  duration: "once"
})

# Refunds
Stripe::Refund.create({
  payment_intent: payment_intent_id,
  reverse_transfer: true  # Returns money from producer too
})
```

### 2. Analytics Dashboard
```ruby
# Producer revenue over time
orders.where(status: "paid")
      .group_by_week(:created_at)
      .sum(:producer_amount)

# Platform commission
orders.where(status: "paid")
      .sum(:platform_fee)

# Top products
products.joins(:orders)
        .group("products.id")
        .order("SUM(orders.quantity) DESC")
```

### 3. Email Notifications
```ruby
# app/mailers/order_mailer.rb
def order_confirmation(order)
  @order = order
  mail(to: @order.user.email, subject: "Order Confirmed!")
end

def order_received(order)
  @order = order
  mail(to: @order.producer.email, subject: "New Order!")
end
```

## 🐛 Common Issues & Solutions

### Issue: "Invalid API Key"
**Cause**: Stripe keys not configured
**Fix**:
```ruby
# config/initializers/stripe.rb
Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}
```

### Issue: "Cannot receive payments"
**Cause**: Producer hasn't completed onboarding
**Fix**: Complete Stripe Connect onboarding

### Issue: "Payment not splitting"
**Cause**: Using Personal API keys instead of Connect
**Fix**: Ensure using Connect-enabled API keys

### Issue: "Webhook signature failed"
**Cause**: Webhook secret not configured
**Fix**: 
```bash
export STRIPE_WEBHOOK_SECRET="whsec_..."
```

## 📚 Additional Resources

### Stripe Documentation
- [Connect Overview](https://stripe.com/docs/connect)
- [Destination Charges](https://stripe.com/docs/connect/destination-charges)
- [Express Accounts](https://stripe.com/docs/connect/express-accounts)
- [Testing](https://stripe.com/docs/testing)

### Rails Resources
- [Devise Authentication](https://github.com/heartcombo/devise)
- [Rails Guides](https://guides.rubyonrails.org/)
- [Tailwind CSS](https://tailwindcss.com/)

### Alternative Patterns

**1. Separate Charges & Transfers**
```ruby
# Charge customer
charge = Stripe::Charge.create(amount: 10000, ...)

# Transfer to producer later
Stripe::Transfer.create({
  amount: 9000,
  destination: producer.stripe_account_id
})
```
❌ More complex, delays payment

**2. Direct Charges**
```ruby
# Charge directly on producer's account
Stripe::Charge.create({
  amount: 10000,
  destination: producer.stripe_account_id
}, {
  stripe_account: producer.stripe_account_id
})
```
❌ Producer sees full amount, harder accounting

**3. Destination Charges** ✅ (What we're using)
```ruby
Stripe::PaymentIntent.create({
  amount: 10000,
  application_fee_amount: 1000,
  transfer_data: { destination: producer.stripe_account_id }
})
```
✅ Best for marketplaces, automatic splits

## 🎓 Learning Outcomes

By studying this demo, you've learned:

1. ✅ Stripe Connect integration
2. ✅ Multi-tenant payment architecture
3. ✅ Secure payment flows
4. ✅ Role-based access control
5. ✅ Service objects pattern
6. ✅ Rails 8 conventions
7. ✅ Tailwind CSS styling
8. ✅ Webhook handling
9. ✅ E-commerce fundamentals
10. ✅ Production-ready patterns

## 🚀 Next Steps

1. **Add your Stripe keys** to test it live
2. **Complete producer onboarding** to see the full flow
3. **Make a test purchase** with 4242 4242 4242 4242
4. **Check both dashboards** (producer and platform)
5. **Review Stripe Dashboard** to see the split
6. **Experiment** with different scenarios
7. **Build on it** for your own marketplace!

---

**Questions? Check the Stripe docs or explore the code!** 🎉
