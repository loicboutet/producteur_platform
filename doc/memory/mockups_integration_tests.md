# Mockups Integration Tests

## ✅ UPDATED - January 2025

## Purpose

Comprehensive integration tests to verify all mockup pages load correctly without errors.

## Test File Location

`test/integration/mockups_pages_test.rb`

## Coverage

The test file covers all **62 mockup pages** across all sections:

### Main Mockups (2 pages)
- `/mockups/index` - Main index page with all mockup links
- `/mockups/styleguide` - Brand style guide

### Public Mockups (15 pages)
- Home index
- Products index & show
- Categories index & show
- Producers index & show
- Markets index & show
- Cart show
- Checkout show, payment, success
- Become producer index & pending

### Account Mockups (5 pages)
- Dashboard
- Orders index & show
- Profile show & edit

### Producer Mockups (17 pages)
- Dashboard
- Profile show & edit
- Stats
- Products index, new, show, edit
- Orders index & show
- Pickup points index & edit
- Market presences index, new & edit
- Stripe show & connect

### Admin Mockups (23 pages)
- Dashboard
- Producers index, show, edit
- Users index, show, edit
- Categories index, new, edit
- Markets index, show, new, edit
- Products index, show
- Orders index, show
- Transactions index, show
- Finances show
- Settings show & edit

## Running the Tests

```bash
# Run all mockup tests
bin/rails test test/integration/mockups_pages_test.rb

# Run a specific test
bin/rails test test/integration/mockups_pages_test.rb:XX

# Run with verbose output
bin/rails test test/integration/mockups_pages_test.rb -v
```

## Latest Test Results

```
Running 62 tests in parallel using 8 processes
62 runs, 63 assertions, 0 failures, 0 errors, 0 skips
```

## Changes Made (January 2025 - Scope Audit)

### Removed Legacy Tests

The following tests were removed because the corresponding pages were deleted during the scope creep audit (they contained out-of-scope features):

| Deleted Test | Reason |
|--------------|--------|
| `legacy user dashboard` | Replaced by `/mockups/account/dashboards/show` |
| `legacy user profile` | Replaced by `/mockups/account/profiles/show` |
| `legacy user settings` | **OUT OF SCOPE** - Had 2FA, dark mode, language, timezone |
| `legacy admin dashboard` | Replaced by `/mockups/admin/dashboards/show` |
| `legacy admin users` | Replaced by `/mockups/admin/users/index` |
| `admin analytics` | **OUT OF SCOPE** - Had visitor analytics, pageviews, bounce rate |

### Added Tests

New tests added to cover all current mockup pages:

- Producer pickup points edit
- Producer market presence edit
- Admin user show & edit
- Admin category new & edit
- Admin market show, new & edit
- Admin product show
- Admin transaction show

## SillounHelper API Reference

### silloun_logo
```ruby
silloun_logo(variant: :vert, size: nil, class_name: "")
# variant: :blanc, :jaune, :noir, :vert
# size: height in pixels (width calculated from aspect ratio)
```

### silloun_chapeau
```ruby
silloun_chapeau(variant: :vert_jaune, size: nil, class_name: "")
# variant: :blanc, :noir, :vert_jaune, :vert
# size: height in pixels (width calculated from aspect ratio)
```

### silloun_cadre
```ruby
silloun_cadre(type: :carre_m, class_name: "")
# type: :horizontal, :vertical_xl, :vertical_m, :vertical_s, :carre_xl, :carre_m, :carre_s
```

## Maintenance

When adding new mockup pages:
1. Add the route to `config/routes.rb`
2. Create the controller action
3. Create the view file
4. Add a test case to `test/integration/mockups_pages_test.rb`
5. Update the mockups index page (`app/views/mockups/index.html.erb`)

When removing mockup pages:
1. Remove the route from `config/routes.rb`
2. Delete the controller action
3. Delete the view file
4. Remove the test case from `test/integration/mockups_pages_test.rb`
5. Update the mockups index page (`app/views/mockups/index.html.erb`)

## Test Categories Breakdown

| Section | Tests | Status |
|---------|-------|--------|
| Main (index, styleguide) | 2 | ✅ |
| Public | 15 | ✅ |
| Account | 5 | ✅ |
| Producer | 17 | ✅ |
| Admin | 23 | ✅ |
| **Total** | **62** | ✅ |
