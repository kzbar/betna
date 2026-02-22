# Betna 2.0 — Project Roadmap

> Last updated: 2026-02-19

---

## ✅ Phase 0 — Foundation (Complete)

### Design System
- [x] Brand color palette (`luxuryCharcoal`, `primaryMaroon`, `luxuryGold`)
- [x] `Style`, `Shadows`, `Corners`, `FontSize` utilities
- [x] `BentoGrid`, `LuxuryCard`, `FormFields` shared widgets
- [x] Responsive helpers (`ScreenTypeLayout`, `ResponsiveBuilder`)
- [x] Popover / context menu framework (`lib/style/popover/`, `lib/style/context_menus/`)
- [x] Playfair Display font integration (hero title)

### Public Homepage (`/`)
- [x] Hero section — parallax image, badge, gold accent bar, CTA button, scroll hint
- [x] Property Ticker — animated news marquee (visible on load, seamless loop)
- [x] "Why Betna" section — asymmetric stats layout
- [x] Featured Properties showcase — horizontal scroll with hover effect
- [x] CTA band — WhatsApp direct link
- [x] Footer — logo, brand copy, social links
- [x] Floating WhatsApp FAB (mobile)
- [x] Sticky transparent navbar with scroll-aware background

### Sale Request Form (`/sell`)
- [x] Multi-step form (contact info → property details → verification)
- [x] Phone verification (OTP)
- [x] Firestore submission

---

## 🔄 Phase 1 — Live Data (Next)

> Goal: Replace all hardcoded content with real Firestore data.

- [ ] Firestore data model for `listings` collection
- [ ] `ListingRepository` — fetch, filter, paginate
- [ ] Homepage ticker pulls from live listings
- [ ] Featured Properties section pulls from Firestore

---

## 🔲 Phase 2 — Admin Panel (Internal)

> Goal: Give the team a way to manage listings and leads without touching code.

- [ ] Auth gate (login for admin routes)
- [ ] **Listings Manager**
  - [ ] Add / Edit / Delete listing (title, price, location, images, status)
  - [ ] Bulk image uploader with automatic watermarking
  - [ ] Status toggles: Available · Sold · Reserved
- [ ] **Lead Hub** — view all Sale Requests with status tracking (New · Contacted · Negotiating)
- [ ] **Dashboard** — real-time stats (listing views, new leads)

---

## 🔲 Phase 3 — Public Listings Portal

> Goal: Let clients browse and filter properties independently.

- [ ] `/projects` — new developments with floor plan viewer
- [ ] `/resales` — searchable grid with filters (price, area, beds, district)
- [ ] `/property/:id` — detail page: full gallery, map, WhatsApp link, PDF brochure download

---

## 🔲 Phase 4 — Infrastructure & SEO

- [ ] `go_router` with semantic URLs (`/property/bosphorus-view-residence`)
- [ ] CDN for property images (Cloudinary or R2)
- [ ] OG meta tags for property pages (social sharing previews)
- [ ] Analytics event tracking (page views, CTA clicks, form starts/completions)

---

## 🧹 Ongoing / Housekeeping

- [x] Removed dead context menu files (`book_context_menu`, `app_context_menu`, `image_context_menu`)
- [ ] Adopt `ScreenTypeLayout` consistently — replace ad-hoc `isWide` checks throughout homepage
- [ ] Localize all hardcoded strings in homepage widgets
