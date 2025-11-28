require "test_helper"

class MockupsControllerTest < ActionDispatch::IntegrationTest
  # Ne pas charger les fixtures pour ce test
  self.use_transactional_tests = true

  test "should get index" do
    get mockups_index_url
    assert_response :success
  end

  test "should get styleguide without errors" do
    get mockups_styleguide_url
    assert_response :success
  end

  test "styleguide should contain silloun logo images" do
    get mockups_styleguide_url
    assert_response :success

    # Vérifier que les images logo sont présentes
    assert_select "img[src*='silloun-RVB-logo']", minimum: 1
  end

  test "styleguide should use silloun color classes" do
    get mockups_styleguide_url
    assert_response :success

    # Vérifier les classes de couleurs Silloun
    assert_select ".bg-silloun-green", minimum: 1
    assert_select ".bg-silloun-yellow", minimum: 1
    assert_select ".text-silloun-green", minimum: 1
    assert_select ".text-silloun-yellow", minimum: 1
  end

  test "styleguide layout should be mockup_styleguide with navigation" do
    get mockups_styleguide_url
    assert_response :success

    # Vérifier que le bon layout est utilisé (nav avec liens d'ancrage)
    assert_select "nav a[href='#marque']"
    assert_select "nav a[href='#logo']"
    assert_select "nav a[href='#couleurs']"
    assert_select "nav a[href='#typographie']"
    assert_select "nav a[href='#composants']"
    assert_select "nav a[href='#applications']"
  end

  test "styleguide should display all main sections" do
    get mockups_styleguide_url
    assert_response :success

    # Vérifier les sections principales
    assert_select "section#marque"
    assert_select "section#logo"
    assert_select "section#couleurs"
    assert_select "section#typographie"
    assert_select "section#composants"
    assert_select "section#applications"
  end

  test "styleguide should display silloun chapeau images" do
    get mockups_styleguide_url
    assert_response :success

    # Vérifier que les chapeaux sont présents
    assert_select "img[src*='silloun-RVB-chapeau']", minimum: 1
  end

  test "styleguide should display silloun cadre images" do
    get mockups_styleguide_url
    assert_response :success

    # Vérifier que les cadres sont présents
    assert_select "img[src*='silloun-RVB-cadre']", minimum: 1
  end

  test "should get user_dashboard" do
    get mockups_user_dashboard_url
    assert_response :success
  end

  test "should get user_profile" do
    get mockups_user_profile_url
    assert_response :success
  end

  test "should get user_settings" do
    get mockups_user_settings_url
    assert_response :success
  end

  test "should get admin_dashboard" do
    get mockups_admin_dashboard_url
    assert_response :success
  end

  test "should get admin_users" do
    get mockups_admin_users_url
    assert_response :success
  end

  test "should get admin_analytics" do
    get mockups_admin_analytics_url
    assert_response :success
  end
end
