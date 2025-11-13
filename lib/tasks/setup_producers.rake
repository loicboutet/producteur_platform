namespace :demo do
  desc "Setup producers with Stripe accounts (test mode)"
  task setup_producers: :environment do
    puts "🌾 Setting up producers with Stripe Connect..."
    puts "⚠️  Make sure you're using TEST MODE Stripe keys!"
    puts ""

    Producer.all.each do |producer|
      puts "Processing: #{producer.name}"
      
      if producer.stripe_account_id.present?
        puts "  → Already has Stripe account: #{producer.stripe_account_id}"
        
        # Update status
        status = StripeConnectService.update_account_status(producer)
        puts "  → Status: #{status}"
        
        if producer.can_receive_payments?
          puts "  ✅ Can receive payments!"
        else
          puts "  ⚠️  Cannot receive payments yet. Complete onboarding at:"
          puts "     http://localhost:3000/producers/#{producer.id}/dashboard"
        end
      else
        puts "  → Creating Stripe account..."
        
        begin
          StripeConnectService.create_account(producer)
          puts "  ✅ Stripe account created: #{producer.stripe_account_id}"
          puts "  → Complete onboarding at:"
          puts "     http://localhost:3000/producers/#{producer.id}/dashboard"
        rescue => e
          puts "  ❌ Error: #{e.message}"
        end
      end
      
      puts ""
    end
    
    puts "✅ Done!"
    puts ""
    puts "📝 Next steps:"
    puts "1. Sign in as each producer (producer1@example.com / password123)"
    puts "2. Go to 'My Dashboard'"
    puts "3. Click 'Complete Setup'"
    puts "4. Fill in test data and submit"
  end
  
  desc "Check producers status"
  task check_producers: :environment do
    puts "📊 Producers Status:"
    puts ""
    
    Producer.all.each do |producer|
      puts "#{producer.name} (#{producer.email})"
      puts "  Stripe ID: #{producer.stripe_account_id || 'N/A'}"
      puts "  Status: #{producer.stripe_account_status}"
      puts "  Can receive payments: #{producer.can_receive_payments? ? '✅ Yes' : '❌ No'}"
      
      if producer.stripe_account_id
        begin
          account = producer.stripe_account
          puts "  Charges enabled: #{account.charges_enabled ? '✅' : '❌'}"
          puts "  Payouts enabled: #{account.payouts_enabled ? '✅' : '❌'}"
        rescue => e
          puts "  ⚠️  Error checking Stripe: #{e.message}"
        end
      end
      
      puts ""
    end
  end
end
