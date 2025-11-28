# 🚨 SCOPE CREEP AUDIT - Mockups vs Specifications

**Audit Date:** Auto-generated
**Status:** ✅ CLEANUP COMPLETED

---

## Summary

This audit identified and removed out-of-scope features from the mockups to ensure the project stays within contractual specifications.

---

## ✅ ITEMS REMOVED

### 1. Admin Analytics Page - DELETED
**File:** `app/views/mockups/admin_analytics.html.erb`
**Route:** Removed from `config/routes.rb`

**Why removed:** The specifications explicitly state:
> "Analytics avancés et reporting détaillé" → **EXCLUDED**

This page included visitor tracking, page views, session duration, bounce rate, traffic sources, browser stats - all OUT OF SCOPE.

---

### 2. User Settings Page - DELETED
**File:** `app/views/mockups/user_settings.html.erb`
**Route:** Removed from `config/routes.rb`

**Why removed:** Contained multiple out-of-scope features:
- ❌ Two-Factor Authentication - NOT IN SPEC
- ❌ Dark Mode - NOT IN SPEC  
- ❌ Language selection (multi-language) - NOT IN SPEC
- ❌ Timezone selection - NOT IN SPEC

User profile editing is handled in `/mockups/account/profile/edit` with only in-scope features.

---

### 3. Legacy Mockup Files - DELETED
All legacy files that were superseded by the new structured mockups:

| Deleted File | Replaced By |
|--------------|-------------|
| `user_dashboard.html.erb` | `/mockups/account/dashboards/show` |
| `user_profile.html.erb` | `/mockups/account/profiles/show` |
| `admin_dashboard.html.erb` | `/mockups/admin/dashboards/show` |
| `admin_users.html.erb` | `/mockups/admin/users/index` |

---

### 4. Legacy Layouts - DELETED
| Deleted File | Reason |
|--------------|--------|
| `mockup_admin.html.erb` | Replaced by `layouts/mockups/admin.html.erb` |
| `mockup_user.html.erb` | Replaced by `layouts/mockups/account.html.erb` |

---

### 5. Producer Pickup Points New - DELETED
**File:** `app/views/mockups/producer/pickup_points/new.html.erb`
**Route:** Removed `new` and `create` actions from routes

**Why removed:** Per the data model and spec:
- Farm pickup point is **auto-created** with producer account
- Additional pickup points are via **market presences** (joining existing markets)
- Producers do NOT create arbitrary pickup points

---

## Files Modified

1. **`config/routes.rb`** - Removed all legacy routes
2. **`app/controllers/mockups_controller.rb`** - Simplified to only index + styleguide
3. **`app/views/mockups/index.html.erb`** - Removed legacy links section

---

## Final Mockup Count

| Section | Pages | Status |
|---------|-------|--------|
| Public | 15 | ✅ |
| Account | 5 | ✅ |
| Producer | 16 | ✅ |
| Admin | 23 | ✅ |
| **Total** | **60** | ✅ |

---

## 💰 ESTIMATED SAVINGS

By removing out-of-scope items:

| Item | Estimated Dev Time Saved |
|------|--------------------------|
| Analytics dashboard | 2-3 days |
| 2FA implementation | 2-4 days |
| Multi-language support | 3-5 days |
| Dark mode | 1 day |

**Total saved:** ~8-13 days of development

---

## ⚠️ REMAINING ITEMS TO CLARIFY WITH STAKEHOLDER

### 1. SMS Notifications
Some mockups reference SMS notifications. The spec mentions emails but SMS is not explicit.
- **Location:** Account profile page has SMS toggle
- **Recommendation:** Confirm if SMS is needed (has ongoing cost implications)

### 2. API Routes
The spec mentions "API ouvertes" but no API namespace exists.
- **Question:** Is API for Brique 1-2 or future phase?

### 3. Producer Stats Export
Mockup shows CSV/PDF stats export, but spec only mentions "download invoices".
- **Question:** Are stats exports included or just invoices?

---

## ✅ VERIFICATION CHECKLIST

- [x] All legacy view files deleted
- [x] All legacy layouts deleted
- [x] Routes cleaned up (no legacy routes)
- [x] Mockups index updated (no legacy links)
- [x] Controller simplified
- [x] No broken links in mockups
- [x] Routes compile without errors
- [x] Documentation updated

---

## Reference: Items Explicitly EXCLUDED from Spec

Per the specifications document, these are **NOT** to be implemented:

1. ❌ Livraison à domicile (home delivery)
2. ❌ Calcul automatique des frais de port
3. ❌ Génération automatique d'étiquettes d'expédition
4. ❌ Système d'avis et notation
5. ❌ Profils acheteurs B2B
6. ❌ **Analytics avancés et reporting détaillé** ← REMOVED
7. ❌ Application mobile native
8. ❌ Système de codes promo et promotions
9. ❌ Tracking avancé des colis
10. ❌ Gestion des litiges et SAV avancé
11. ❌ Intégration WhatsApp
12. ❌ Automatisation IA
