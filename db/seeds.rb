# Clear existing data
puts "🧹 Cleaning database..."
Order.destroy_all
Product.destroy_all
Producer.destroy_all
User.destroy_all

puts "👥 Creating users..."

# Create a buyer user
buyer = User.create!(
  email: "buyer@example.com",
  password: "password123",
  password_confirmation: "password123"
)
puts "✓ Created buyer: #{buyer.email}"

# Create producer users
producer_user1 = User.create!(
  email: "producer1@example.com",
  password: "password123",
  password_confirmation: "password123"
)
puts "✓ Created producer user 1: #{producer_user1.email}"

producer_user2 = User.create!(
  email: "producer2@example.com",
  password: "password123",
  password_confirmation: "password123"
)
puts "✓ Created producer user 2: #{producer_user2.email}"

puts "\n🌾 Creating producers..."

# Note: In development, you'll need to manually complete Stripe onboarding
# For now, we'll create the producer profiles without Stripe accounts
producer1 = Producer.create!(
  user: producer_user1,
  name: "Green Valley Farm",
  email: "contact@greenvalley.com",
  stripe_account_status: "pending"
)
puts "✓ Created producer: #{producer1.name}"

producer2 = Producer.create!(
  user: producer_user2,
  name: "Sunny Hills Orchard",
  email: "hello@sunnyhills.com",
  stripe_account_status: "pending"
)
puts "✓ Created producer: #{producer2.name}"

puts "\n🛍️ Creating products..."

# Products for Producer 1
products1 = [
  {
    name: "Organic Tomatoes",
    description: "Fresh, juicy organic tomatoes grown without pesticides. Perfect for salads and cooking.",
    price: 4.99,
    stock: 50
  },
  {
    name: "Free-Range Eggs",
    description: "Farm-fresh eggs from happy, free-range chickens. Rich in omega-3.",
    price: 6.50,
    stock: 30
  },
  {
    name: "Raw Honey",
    description: "Pure, unfiltered honey from our own beehives. Natural sweetness at its best.",
    price: 12.00,
    stock: 20
  }
]

products1.each do |product_data|
  product = producer1.products.create!(product_data)
  puts "✓ Created product: #{product.name} (#{product.formatted_price})"
end

# Products for Producer 2
products2 = [
  {
    name: "Artisan Bread",
    description: "Freshly baked sourdough bread made with organic flour. No preservatives.",
    price: 5.50,
    stock: 25
  },
  {
    name: "Seasonal Vegetables Box",
    description: "A curated box of seasonal vegetables from our farm. Contents vary by season.",
    price: 15.00,
    stock: 15
  },
  {
    name: "Apple Juice",
    description: "Fresh-pressed apple juice from our orchard. No added sugar or preservatives.",
    price: 8.00,
    stock: 40
  }
]

products2.each do |product_data|
  product = producer2.products.create!(product_data)
  puts "✓ Created product: #{product.name} (#{product.formatted_price})"
end

puts "\n✅ Seed data created successfully!"
puts "\n📝 Login credentials:"
puts "  Buyer: buyer@example.com / password123"
puts "  Producer 1: producer1@example.com / password123"
puts "  Producer 2: producer2@example.com / password123"
puts "\n⚠️  Note: Producers need to complete Stripe Connect onboarding before they can accept payments."
puts "   Each producer should:"
puts "   1. Log in with their account"
puts "   2. Go to 'Become a Producer' (if not already done)"
puts "   3. Complete the Stripe Connect onboarding process"
puts "\n🧪 For testing, you'll need to set up your Stripe test API keys in the environment."
