# frozen_string_literal: true

require "test_helper"

class MockupsPagesTest < ActionDispatch::IntegrationTest
  # ===========================================
  # MAIN MOCKUPS INDEX & STYLEGUIDE
  # ===========================================

  test "mockups index page loads correctly" do
    get mockups_index_path
    assert_response :success
    assert_select "h1", /MOCKUP EXPLORER/i
  end

  test "styleguide page loads correctly" do
    get mockups_styleguide_path
    assert_response :success
  end

  # ===========================================
  # PUBLIC MOCKUPS
  # ===========================================

  test "public home index loads correctly" do
    get mockups_public_home_index_path
    assert_response :success
  end

  test "public products index loads correctly" do
    get mockups_public_products_path
    assert_response :success
  end

  test "public product show loads correctly" do
    get mockups_public_product_path(1)
    assert_response :success
  end

  test "public categories index loads correctly" do
    get mockups_public_categories_path
    assert_response :success
  end

  test "public category show loads correctly" do
    get mockups_public_category_path(slug: "fruits-legumes")
    assert_response :success
  end

  test "public producers index loads correctly" do
    get mockups_public_producers_path
    assert_response :success
  end

  test "public producer show loads correctly" do
    get mockups_public_producer_path(1)
    assert_response :success
  end

  test "public markets index loads correctly" do
    get mockups_public_markets_path
    assert_response :success
  end

  test "public market show loads correctly" do
    get mockups_public_market_path(1)
    assert_response :success
  end

  test "public cart show loads correctly" do
    get mockups_public_cart_path
    assert_response :success
  end

  test "public checkout show loads correctly" do
    get mockups_public_checkout_path
    assert_response :success
  end

  test "public checkout payment loads correctly" do
    get payment_mockups_public_checkout_path
    assert_response :success
  end

  test "public checkout success loads correctly" do
    get success_mockups_public_checkout_path
    assert_response :success
  end

  test "public become producer index loads correctly" do
    get mockups_public_become_producer_index_path
    assert_response :success
  end

  test "public become producer pending loads correctly" do
    get pending_mockups_public_become_producer_index_path
    assert_response :success
  end

  # ===========================================
  # ACCOUNT MOCKUPS
  # ===========================================

  test "account dashboard loads correctly" do
    get mockups_account_dashboard_path
    assert_response :success
  end

  test "account orders index loads correctly" do
    get mockups_account_orders_path
    assert_response :success
  end

  test "account order show loads correctly" do
    get mockups_account_order_path(1)
    assert_response :success
  end

  test "account profile show loads correctly" do
    get mockups_account_profile_path
    assert_response :success
  end

  test "account profile edit loads correctly" do
    get edit_mockups_account_profile_path
    assert_response :success
  end

  # ===========================================
  # PRODUCER MOCKUPS
  # ===========================================

  test "producer dashboard loads correctly" do
    get mockups_producer_dashboard_path
    assert_response :success
  end

  test "producer profile show loads correctly" do
    get mockups_producer_profile_path
    assert_response :success
  end

  test "producer profile edit loads correctly" do
    get edit_mockups_producer_profile_path
    assert_response :success
  end

  test "producer stats show loads correctly" do
    get mockups_producer_stats_path
    assert_response :success
  end

  test "producer products index loads correctly" do
    get mockups_producer_products_path
    assert_response :success
  end

  test "producer product new loads correctly" do
    get new_mockups_producer_product_path
    assert_response :success
  end

  test "producer product show loads correctly" do
    get mockups_producer_product_path(1)
    assert_response :success
  end

  test "producer product edit loads correctly" do
    get edit_mockups_producer_product_path(1)
    assert_response :success
  end

  test "producer orders index loads correctly" do
    get mockups_producer_orders_path
    assert_response :success
  end

  test "producer order show loads correctly" do
    get mockups_producer_order_path(1)
    assert_response :success
  end

  test "producer pickup points index loads correctly" do
    get mockups_producer_pickup_points_path
    assert_response :success
  end

  test "producer pickup points edit loads correctly" do
    get edit_mockups_producer_pickup_point_path(1)
    assert_response :success
  end

  test "producer market presences index loads correctly" do
    get mockups_producer_market_presences_path
    assert_response :success
  end

  test "producer market presence new loads correctly" do
    get new_mockups_producer_market_presence_path
    assert_response :success
  end

  test "producer market presence edit loads correctly" do
    get edit_mockups_producer_market_presence_path(1)
    assert_response :success
  end

  test "producer stripe show loads correctly" do
    get mockups_producer_stripe_path
    assert_response :success
  end

  test "producer stripe connect loads correctly" do
    get connect_mockups_producer_stripe_path
    assert_response :success
  end

  # ===========================================
  # ADMIN MOCKUPS
  # ===========================================

  test "admin dashboard loads correctly" do
    get mockups_admin_dashboard_path
    assert_response :success
  end

  test "admin producers index loads correctly" do
    get mockups_admin_producers_path
    assert_response :success
  end

  test "admin producer show loads correctly" do
    get mockups_admin_producer_path(1)
    assert_response :success
  end

  test "admin producer edit loads correctly" do
    get edit_mockups_admin_producer_path(1)
    assert_response :success
  end

  test "admin users index loads correctly" do
    get mockups_admin_users_path
    assert_response :success
  end

  test "admin user show loads correctly" do
    get mockups_admin_user_path(1)
    assert_response :success
  end

  test "admin user edit loads correctly" do
    get edit_mockups_admin_user_path(1)
    assert_response :success
  end

  test "admin categories index loads correctly" do
    get mockups_admin_categories_path
    assert_response :success
  end

  test "admin category new loads correctly" do
    get new_mockups_admin_category_path
    assert_response :success
  end

  test "admin category edit loads correctly" do
    get edit_mockups_admin_category_path(1)
    assert_response :success
  end

  test "admin markets index loads correctly" do
    get mockups_admin_markets_path
    assert_response :success
  end

  test "admin market show loads correctly" do
    get mockups_admin_market_path(1)
    assert_response :success
  end

  test "admin market new loads correctly" do
    get new_mockups_admin_market_path
    assert_response :success
  end

  test "admin market edit loads correctly" do
    get edit_mockups_admin_market_path(1)
    assert_response :success
  end

  test "admin products index loads correctly" do
    get mockups_admin_products_path
    assert_response :success
  end

  test "admin product show loads correctly" do
    get mockups_admin_product_path(1)
    assert_response :success
  end

  test "admin orders index loads correctly" do
    get mockups_admin_orders_path
    assert_response :success
  end

  test "admin order show loads correctly" do
    get mockups_admin_order_path(1)
    assert_response :success
  end

  test "admin transactions index loads correctly" do
    get mockups_admin_transactions_path
    assert_response :success
  end

  test "admin transaction show loads correctly" do
    get mockups_admin_transaction_path(1)
    assert_response :success
  end

  test "admin finances show loads correctly" do
    get mockups_admin_finances_path
    assert_response :success
  end

  test "admin settings show loads correctly" do
    get mockups_admin_settings_path
    assert_response :success
  end

  test "admin settings edit loads correctly" do
    get edit_mockups_admin_settings_path
    assert_response :success
  end
end
