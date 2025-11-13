# ✅ Stripe Split Payment Demo - Setup Checklist

Use this checklist to get your demo working in under 10 minutes!

## 📋 Pre-Flight Checklist

### ✅ Step 1: Verify Installation (30 seconds)

```bash
# Check that everything is installed
bundle check
```

If you see errors, run:
```bash
bundle install
```

### ✅ Step 2: Database Setup (30 seconds)

```bash
# Should already be done, but verify:
bin/rails db:migrate
bin/rails db:seed
```

You should see:
```
✅ Seed data created successfully!
📝 Login credentials:
  Buyer: buyer@example.com / password123
  Producer 1: producer1@example.com / password123
  Producer 2: producer2@example.com / password123
```

## 🔑 Step 3: Get Stripe API Keys (2 minutes)

### Option A: Create New Account
1. ☐ Go to https://dashboard.stripe.com/register
2. ☐ Sign up with any email
3. ☐ Skip onboarding questions (click "Skip for now")
4. ☐ You'll land in the dashboard

### Option B: Use Existing Account
1. ☐ Go to https://dashboard.stripe.com/login
2. ☐ Sign in

### Both Options:
3. ☐ Toggle **"Test mode"** switch (top right) - VERY IMPORTANT!
4. ☐ Click **"Developers"** in left sidebar
5. ☐ Click **"API keys"**
6. ☐ Copy **"Publishable key"** (starts with `pk_test_`)
7. ☐ Copy **"Secret key"** (starts with `sk_test_`)

## 🔧 Step 4: Configure Your App (2 minutes)

### Option A: Direct Configuration (Easiest)

Open `config/initializers/stripe.rb` and replace the placeholder keys:

```ruby
Rails.configuration.stripe = {
  publishable_key: "pk_test_YOUR_ACTUAL_KEY_HERE",
  secret_key: "sk_test_YOUR_ACTUAL_KEY_HERE"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
```

### Option B: Environment Variables (More Secure)

Create or edit `.env` in your project root:

```bash
STRIPE_PUBLISHABLE_KEY=pk_test_YOUR_ACTUAL_KEY_HERE
STRIPE_SECRET_KEY=sk_test_YOUR_ACTUAL_KEY_HERE
```

Then in `config/initializers/stripe.rb`:
```ruby
Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}
```

## 🚀 Step 5: Start the Server (10 seconds)

```bash
bin/rails server
```

Visit: **http://localhost:3000**

You should see the products marketplace homepage! 🎉

## 🧪 Step 6: Test as Producer (3 minutes)

### 6.1 Sign In
☐ Click **"Sign In"** (top right)
☐ Email: `producer1@example.com`
☐ Password: `password123`

### 6.2 Complete Stripe Onboarding
☐ Click **"My Dashboard"** in nav bar
☐ You'll see "Your Stripe account needs to be completed"
☐ Click **"Complete Setup"**
☐ You'll be redirected to Stripe Connect onboarding

### 6.3 Fill in Stripe Onboarding (Use Test Data!)

**Business Details:**
☐ Country: France (or your country)
☐ Business type: Individual
☐ Phone: +33 6 12 34 56 78 (or any fake number)

**Personal Details:**
☐ First name: Test
☐ Last name: Producer
☐ Date of birth: 01/01/1990
☐ Email: (auto-filled)

**Address:**
☐ Use any address:
   - Address: 123 Rue de Test
   - City: Paris
   - Postal code: 75001
   - Country: France

**Bank Account:**
☐ In test mode, Stripe provides a "Skip" button - click it!
☐ Or use test bank: FR14 2004 1010 0505 0001 3M02 606

**Verification:**
☐ Stripe may ask for ID - in test mode, click "Use test data"
☐ Or upload any image (it's test mode, doesn't matter)

**Complete:**
☐ Click "Done" or "Complete"
☐ You'll be redirected back to your dashboard
☐ Status should now show: ✓ Active

### 6.4 Verify Dashboard
You should now see:
☐ Stripe Status: ✓ Active
☐ Can Receive Payments: ✓ Yes
☐ Products section (empty)
☐ Orders section (empty)

Great! Your producer account is ready! 🎉

## 🛍️ Step 7: Test as Buyer (3 minutes)

### 7.1 Sign Out and Sign In as Buyer
☐ Click **"Sign Out"**
☐ Click **"Sign In"**
☐ Email: `buyer@example.com`
☐ Password: `password123`

### 7.2 Browse and Buy
☐ You should see 6 products on the homepage
☐ Click **"Buy Now"** on any product (e.g., "Organic Tomatoes")

### 7.3 Place Order
☐ Adjust quantity if you want
☐ Review the split payment calculation:
   - Subtotal (e.g., €4.99)
   - Platform Fee 10% (€0.50)
   - Producer Receives 90% (€4.49)
   - Total: €4.99
☐ Click **"Continue to Payment"**

### 7.4 Complete Payment
☐ You'll see a secure payment form
☐ Card number: `4242 4242 4242 4242`
☐ Expiry: `12/25` (any future date)
☐ CVC: `123` (any 3 digits)
☐ Click **"Pay €X.XX"**

### 7.5 Verify Success
You should see:
☐ ✅ "Payment Successful!"
☐ Order details
☐ Payment breakdown showing the split
☐ Message: "Split Payment Completed!"

## 🎉 Step 8: Verify the Split (1 minute)

### 8.1 Check Producer Dashboard
☐ Sign out and sign in as `producer1@example.com`
☐ Go to **"My Dashboard"**
☐ You should see:
   - Total Revenue: €4.49 (or 90% of what was paid)
   - 1 order in "Recent Orders"
   - Status: "paid"

### 8.2 Check Stripe Dashboard (Optional)
☐ Go to https://dashboard.stripe.com (in new tab)
☐ Make sure **Test Mode** is ON
☐ Click **"Payments"**
☐ You should see the payment
☐ Click on it to see the split details:
   - Total: €4.99
   - Application fee: €0.50
   - Transfer to producer: €4.49

## ✨ Bonus: Test Different Scenarios

### Test Failed Payment
☐ Try buying with card: `4000 0000 0000 0002`
☐ Should show: "Your card was declined"

### Test 3D Secure
☐ Try buying with card: `4000 0027 6000 3184`
☐ Should prompt for authentication

### Test Multiple Products
☐ Buy from different producers
☐ Check each producer's dashboard
☐ Verify each gets their split

### Test as Second Producer
☐ Sign in as `producer2@example.com`
☐ Complete Stripe onboarding
☐ Add a new product
☐ Buy it with the buyer account

## 🐛 Troubleshooting

### ❌ "Invalid API key"
**Problem:** Stripe keys not configured correctly
**Solution:** 
1. Double-check your keys in `config/initializers/stripe.rb`
2. Make sure they start with `pk_test_` and `sk_test_`
3. Restart your Rails server: `Ctrl+C` then `bin/rails server`

### ❌ "Producer cannot receive payments yet"
**Problem:** Stripe onboarding not completed
**Solution:** 
1. Sign in as the producer
2. Go to "My Dashboard"
3. Click "Complete Setup"
4. Complete Stripe onboarding

### ❌ Stripe onboarding page won't load
**Problem:** API keys might be invalid or from different account
**Solution:**
1. Verify you're in Test Mode in Stripe Dashboard
2. Generate new API keys:
   - Go to https://dashboard.stripe.com/test/apikeys
   - Click "Create secret key"
   - Copy both keys again

### ❌ "We couldn't confirm the payment"
**Problem:** Using live mode keys instead of test mode
**Solution:**
1. Go to Stripe Dashboard
2. Toggle Test Mode ON (top right)
3. Copy the TEST keys (they start with `pk_test_` and `sk_test_`)
4. Update your config
5. Restart server

### ❌ Products not showing
**Problem:** Database not seeded
**Solution:**
```bash
bin/rails db:seed
```

### ❌ Can't sign in
**Problem:** User doesn't exist
**Solution:**
```bash
bin/rails db:reset  # Warning: This clears all data!
bin/rails db:seed
```

## 📊 Success Metrics

You'll know everything is working when:

✅ You can sign in as producer
✅ Producer can complete Stripe onboarding
✅ Producer dashboard shows "Active" status
✅ Products appear on homepage
✅ Buyer can complete checkout
✅ Payment form accepts test card
✅ Payment succeeds and shows confirmation
✅ Producer dashboard shows the revenue (90%)
✅ Order history shows the order
✅ Stripe Dashboard shows the split payment

## 🎓 Next Steps

Once everything is working:

1. ☐ Read `STRIPE_DEMO_GUIDE.md` for deep dive
2. ☐ Experiment with different test cards
3. ☐ Try adding your own products
4. ☐ Check the code in `app/services/`
5. ☐ Explore the Stripe Dashboard
6. ☐ Test webhook integration (optional)
7. ☐ Build your own features on top!

## 🆘 Still Stuck?

1. Check the Rails server logs in your terminal
2. Check Stripe Dashboard > Developers > Logs
3. Review `STRIPE_DEMO_README.md`
4. Check your database: `bin/rails console` then `Producer.count`, `Product.count`

---

## 📝 Quick Reference

### Test Cards
```
✅ Success:        4242 4242 4242 4242
❌ Declined:       4000 0000 0000 0002
💰 Insufficient:   4000 0000 0000 9995
🔐 3D Secure:      4000 0027 6000 3184
```

### Login Credentials
```
Buyer:      buyer@example.com / password123
Producer 1: producer1@example.com / password123
Producer 2: producer2@example.com / password123
```

### Important URLs
```
Homepage:    http://localhost:3000
Sign In:     http://localhost:3000/users/sign_in
Dashboard:   http://localhost:3000/producer/dashboard
Products:    http://localhost:3000/products
Orders:      http://localhost:3000/orders
```

---

**Good luck! You're about to see split payments in action! 🚀**
