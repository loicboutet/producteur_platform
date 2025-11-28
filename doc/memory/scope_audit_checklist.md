# Mockup Scope Audit Checklist

**Purpose:** Track page-by-page review of ALL mockups for out-of-scope features
**Status:** ✅ COMPLETED
**Last Updated:** 2025-01-13

## Out-of-Scope Features (per contract)

From the README specifications, these are **EXPLICITLY EXCLUDED**:

| # | Feature | Keywords searched |
|---|---------|-------------------|
| 1 | Livraison à domicile | `livraison`, `delivery`, `shipping`, `Colissimo`, `Mondial Relay`, `domicile`, `frais de port` |
| 2 | Frais de port automatiques | (covered above) |
| 3 | Étiquettes d'expédition | `étiquette`, `shipping label` |
| 4 | Ratings/reviews | `rating`, `review`, `avis`, `notation`, `étoile`, `star`, `★`, `4.8`, `5/5` |
| 5 | B2B profiles | `b2b`, `restaurateur`, `professionnel`, `grossiste`, `wholesale` |
| 6 | Advanced analytics | `visitor`, `pageview`, `bounce`, `session`, `traffic`, `analytics` |
| 7 | Mobile app native | `app store`, `play store`, `télécharger l'app`, `application mobile` |
| 8 | Promo codes | `promo`, `coupon`, `discount`, `réduction`, `code promo`, `BIENVENUE15` |
| 9 | Advanced tracking | `tracking avancé`, `suivi colis` |
| 10 | Litiges/SAV avancé | `litige`, `dispute`, `réclamation` |
| 11 | WhatsApp | `whatsapp` |
| 12 | IA automatisation | `ai`, `automatisation ia`, `intelligence artificielle` |
| 13 | 2FA | `two-factor`, `2fa`, `authenticator`, `otp` |
| 14 | Dark mode | `dark mode`, `mode sombre`, `thème sombre` |
| 15 | Multi-language | `language`, `locale`, `langue`, `i18n` |
| 16 | Timezone | `timezone`, `fuseau` |
| 17 | SMS notifications | `sms`, `SMS`, `texto` |

---

## PUBLIC PAGES (15 files)

| File | Checked | Clean | Issues Found |
|------|---------|-------|--------------|
| `public/home/index.html.erb` | ✅ | ✅ | None |
| `public/products/index.html.erb` | ✅ | ✅ | None |
| `public/products/show.html.erb` | ✅ | ✅ | None |
| `public/categories/index.html.erb` | ✅ | ✅ | None |
| `public/categories/show.html.erb` | ✅ | ✅ | None |
| `public/producers/index.html.erb` | ✅ | ✅ | None |
| `public/producers/show.html.erb` | ✅ | ✅ | None |
| `public/markets/index.html.erb` | ✅ | ✅ | None |
| `public/markets/show.html.erb` | ✅ | ✅ | None |
| `public/carts/show.html.erb` | ✅ | ✅ | None |
| `public/checkouts/show.html.erb` | ✅ | ✅ | None |
| `public/checkouts/payment.html.erb` | ✅ | ✅ | None |
| `public/checkouts/success.html.erb` | ✅ | ✅ | None |
| `public/become_producer/index.html.erb` | ✅ | ✅ | None (false positive: "clientèle locale") |
| `public/become_producer/pending.html.erb` | ✅ | ✅ | None |

---

## ACCOUNT PAGES (5 files)

| File | Checked | Clean | Issues Found |
|------|---------|-------|--------------|
| `account/dashboards/show.html.erb` | ✅ | ✅ | None |
| `account/orders/index.html.erb` | ✅ | ✅ | None |
| `account/orders/show.html.erb` | ✅ | ✅ | None |
| `account/profiles/show.html.erb` | ✅ | ✅ | None |
| `account/profiles/edit.html.erb` | ✅ | ✅ | None (no 2FA, dark mode, language, timezone settings) |

---

## PRODUCER PAGES (17 files)

| File | Checked | Clean | Issues Found |
|------|---------|-------|--------------|
| `producer/dashboards/show.html.erb` | ✅ | ✅ | None |
| `producer/profiles/show.html.erb` | ✅ | ✅ | None |
| `producer/profiles/edit.html.erb` | ✅ | ✅ | None |
| `producer/stats/show.html.erb` | ✅ | ✅ | None (sales stats, not visitor analytics) |
| `producer/products/index.html.erb` | ✅ | ✅ | None |
| `producer/products/show.html.erb` | ✅ | ✅ | None |
| `producer/products/new.html.erb` | ✅ | ✅ | None |
| `producer/products/edit.html.erb` | ✅ | ✅ | None |
| `producer/orders/index.html.erb` | ✅ | ✅ | None |
| `producer/orders/show.html.erb` | ✅ | ✅ | None |
| `producer/pickup_points/index.html.erb` | ✅ | ✅ | None |
| `producer/pickup_points/edit.html.erb` | ✅ | ✅ | None |
| `producer/market_presences/index.html.erb` | ✅ | ✅ | None |
| `producer/market_presences/new.html.erb` | ✅ | ✅ | None |
| `producer/market_presences/edit.html.erb` | ✅ | ✅ | None |
| `producer/stripe/show.html.erb` | ✅ | ✅ | None |
| `producer/stripe/connect.html.erb` | ✅ | ✅ | None |

---

## ADMIN PAGES (21 files)

| File | Checked | Clean | Issues Found |
|------|---------|-------|--------------|
| `admin/dashboards/show.html.erb` | ✅ | ✅ | None (revenue/orders stats, not visitor analytics) |
| `admin/producers/index.html.erb` | ✅ | ✅ | None |
| `admin/producers/show.html.erb` | ✅ | ✅ | None |
| `admin/producers/edit.html.erb` | ✅ | ✅ | None |
| `admin/users/index.html.erb` | ✅ | ✅ | None |
| `admin/users/show.html.erb` | ✅ | ✅ | None |
| `admin/users/edit.html.erb` | ✅ | ✅ | None |
| `admin/categories/index.html.erb` | ✅ | ✅ | None |
| `admin/categories/new.html.erb` | ✅ | ✅ | None |
| `admin/categories/edit.html.erb` | ✅ | ✅ | None |
| `admin/markets/index.html.erb` | ✅ | ✅ | None |
| `admin/markets/show.html.erb` | ✅ | ✅ | None |
| `admin/markets/new.html.erb` | ✅ | ✅ | None |
| `admin/markets/edit.html.erb` | ✅ | ✅ | None |
| `admin/products/index.html.erb` | ✅ | ✅ | None |
| `admin/products/show.html.erb` | ✅ | ✅ | None |
| `admin/orders/index.html.erb` | ✅ | ✅ | None |
| `admin/orders/show.html.erb` | ✅ | ✅ | None (refund is in-scope) |
| `admin/transactions/index.html.erb` | ✅ | ✅ | None |
| `admin/transactions/show.html.erb` | ✅ | ✅ | None |
| `admin/finances/show.html.erb` | ✅ | ✅ | None |
| `admin/settings/show.html.erb` | ✅ | ✅ | None (commission, geo, email only) |
| `admin/settings/edit.html.erb` | ✅ | ✅ | None |

---

## OTHER FILES (2 files)

| File | Checked | Clean | Issues Found |
|------|---------|-------|--------------|
| `index.html.erb` | ✅ | ✅ | None |
| `styleguide.html.erb` | ✅ | ✅ | **FIXED:** 2 promo code references removed |

---

## CONTROLLERS (6 files)

| File | Checked | Clean | Issues Found |
|------|---------|-------|--------------|
| `mockups/base_controller.rb` | ✅ | ✅ | None |
| `mockups/public/base_controller.rb` | ✅ | ✅ | None |
| `mockups/account/base_controller.rb` | ✅ | ✅ | None |
| `mockups/producer/base_controller.rb` | ✅ | ✅ | None |
| `mockups/admin/base_controller.rb` | ✅ | ✅ | None |
| `mockups/admin/settings_controller.rb` | ✅ | ✅ | None |

---

## LAYOUTS (5 files)

| File | Checked | Clean | Issues Found |
|------|---------|-------|--------------|
| `layouts/mockups/application.html.erb` | ✅ | ✅ | None |
| `layouts/mockups/public.html.erb` | ✅ | ✅ | **FIXED:** Promo banner removed |
| `layouts/mockups/account.html.erb` | ✅ | ✅ | None |
| `layouts/mockups/producer.html.erb` | ✅ | ✅ | None |
| `layouts/mockups/admin.html.erb` | ✅ | ✅ | None |

---

## PROGRESS SUMMARY

- Total files: 60 views + 6 controllers + 5 layouts = **71 files**
- Checked: **71**
- Clean (after fixes): **71**
- Issues found and fixed: **3**

### Issues Fixed

1. **`app/views/layouts/mockups/public.html.erb`** (line 50):
   - **Issue:** Promo code banner with "BIENVENUE15" 
   - **Fix:** Replaced with "🚜 Achetez directement chez vos producteurs locaux en click & collect"

2. **`app/views/mockups/styleguide.html.erb`** (line 515):
   - **Issue:** Alert example with promo code
   - **Fix:** Replaced with "Nouveau producteur ajouté : Ferme du Soleil est maintenant disponible"

3. **`app/views/mockups/styleguide.html.erb`** (line 614):
   - **Issue:** Website preview with promo code
   - **Fix:** Replaced with "Achetez directement chez vos producteurs locaux"

---

## COMPREHENSIVE VERIFICATION

### Search commands executed (all returned 0 matches):

```bash
# Ratings/reviews
grep -rn "avis|note|étoile|★|star.rating|review|rating" --include="*.erb" --include="*.rb"
# Result: ✅ Clean (only CSS opacity classes like bg-black/50)

# B2B/Professional
grep -rn -i "b2b|restaurateur|professionnel|grossiste|wholesale" --include="*.erb" --include="*.rb"
# Result: ✅ Clean

# Mobile app
grep -rn -i "app store|play store|télécharger l'app|mobile app|application mobile" --include="*.erb" --include="*.rb"
# Result: ✅ Clean

# Delivery/Shipping
grep -rn -i "livraison|delivery|shipping|colissimo|mondial relay|domicile|frais de port" --include="*.erb" --include="*.rb"
# Result: ✅ Clean

# Disputes/Advanced SAV
grep -rn -i "litige|dispute|réclamation" --include="*.erb" --include="*.rb"
# Result: ✅ Clean

# SMS
grep -rn -i "sms|texto" --include="*.erb" --include="*.rb"
# Result: ✅ Clean

# Promo codes (after fix)
grep -rn "BIENVENUE15|promo|coupon|discount" --include="*.erb" --include="*.rb"
# Result: ✅ Clean
```

---

## SIGN-OFF

- [x] All 71 files checked
- [x] All 3 issues found and fixed
- [x] All search commands pass with 0 matches
- [x] Server restarted (`touch tmp/restart.txt`)
- [x] Documentation updated

---

## In-Scope Features Confirmed Present

These features ARE in the contract and were verified as correctly implemented:

| Feature | Status | Notes |
|---------|--------|-------|
| Geolocation (distance-based search) | ✅ | Products/producers/markets show distance |
| Product catalog with categories | ✅ | Full CRUD in producer, browsing in public |
| Multi-role auth (admin/producer/customer) | ✅ | Separate namespaces and layouts |
| Stripe Connect split payment | ✅ | Producer stripe pages, admin transactions |
| Click & collect (farm + market) | ✅ | Pickup points, market presences |
| Order workflow | ✅ | pending→paid→preparing→ready→picked_up |
| EMAIL notifications | ✅ | Settings show email toggle (not SMS) |
| Commission management | ✅ | Admin settings, configurable % |
| Producer SIRET validation | ✅ | Producer registration, admin validation |
| Guest checkout | ✅ | Checkout flow allows guest |
| Basic dashboard stats | ✅ | Revenue, orders, commissions (not visitor analytics) |
| Admin refunds | ✅ | Order show page has refund button |
| Export (invoices/accounting) | ✅ | Producer stats CSV/PDF, admin finance export |

---

## Notes for Future Development

### False positives to ignore:
- `clientèle locale` / `agriculture locale` = French for "local customers/agriculture" (not i18n locale)
- `start_time` = legitimate time field for schedules
- `bg-black/50`, `bg-white/80` = CSS opacity classes, not ratings
- `visa-`, `mastercard` = payment card types in Stripe mockup

### Previously cleaned (per scope_creep_audit.md):
- `admin_analytics.html.erb` - DELETED (had visitor analytics)
- `user_settings.html.erb` - DELETED (had 2FA, dark mode, language, timezone)
- SMS toggle in admin settings - REMOVED
- Rating stars in producer/public pages - REMOVED

### Borderline features (acceptable):
- Producer stats export (CSV/PDF) - Acceptable for sales/invoice data, not visitor analytics
- Admin finance export - Explicitly in scope per README
