# 📋 पढ़ो गुरु — Complete Research-to-Code Audit
## Generated: June 22, 2026
## Auditor: GitHub Copilot (DeepSeek V4 Flash)

> **Legend:** ✅ = Implemented | ⚠️ = Partial/Incomplete | ❌ = Missing/Not Done | 🔲 = Not Applicable Yet

---

## DOCUMENT 1: 2026-06-18-padho-guru-research.md (Day 1 Research)

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 1.1 | App Name: पढ़ो गुरु (Padho Guru) | ✅ | `lib/config/constants.dart` | `appName = 'पढ़ो गुरु'` |
| 1.2 | Tagline: NCERT Class 6-12 का हिंदी AI Tutor | ⚠️ | `lib/config/constants.dart` | Tagline set but not shown prominently |
| 1.3 | Core Feature: 📸 Photo → AI explains step-by-step in Hindi | ⚠️ | `lib/screens/camera_screen.dart`, `lib/services/ai_service.dart` | Camera works, AI uses mock data (not real OpenAI) |
| 1.4 | Platform: Android + iOS (Flutter) | ✅ | `pubspec.yaml` | Flutter project created |
| 1.5 | Pricing: Free (5/day), ₹99/mo, ₹999/yr | ✅ | `lib/config/constants.dart` | `freeQuestionsPerDay = 5`, `monthlyPriceINR = 99`, `yearlyPriceINR = 999` |
| 1.6 | Family plan: ₹199/mo (3 students) | ❌ | — | Not implemented anywhere |
| 1.7 | Payment: Google Play Billing + Apple IAP | ✅ | `lib/services/payment_service.dart` | `in_app_purchase` package integrated |
| 1.8 | Payment: No SuperProfile in app | ✅ | — | Not present in code |
| 1.9 | OCR Strategy: Skip OCR → GPT-4o Vision directly | ⚠️ | `lib/services/ai_service.dart` | Vision API call not actually implemented (mock) |
| 1.10 | Regional Language Support: Phase 1 Hindi/English | ✅ | `lib/config/constants.dart`, `lib/screens/settings_screen.dart` | Hindi/English toggles exist |
| 1.11 | Regional Language Support: Phase 2 (Marathi, Tamil, etc.) | ❌ | — | Not implemented |
| 1.12 | Hindi-first interface | ⚠️ | Multiple screens | Most UI text is Hindi, but bottom nav labels are English |
| 1.13 | Large buttons & text (budget phones) | ✅ | `lib/config/theme.dart` | 14-16sp body, Noto Sans Devanagari |
| 1.14 | Chat format (familiar like WhatsApp) | ✅ | `lib/screens/chat_screen.dart` | Chat UI with bubbles |
| 1.15 | Color-coded subjects (Blue=Math, Green=Science) | ✅ | `lib/screens/home_screen.dart` | Each subject has unique color |
| 1.16 | Gamification (streaks, rewards) | ✅ | `lib/widgets/streak_bar.dart`, `lib/screens/achievements_screen.dart` | Streak bar + badges |
| 1.17 | 5 Screens designed (Home, Camera, Chat, Syllabus, Profile) | ✅ | `lib/screens/` | All 5 screens exist |
| 1.18 | AI gives wrong answer → Cite NCERT source | ❌ | — | No NCERT citation mechanism |
| 1.19 | "Verify with textbook" suggestion | ❌ | — | Not implemented |
| 1.20 | App icon: Blue bg + Guru face + Book + "पढ़ो" text | ❌ | — | Not created (user needs Canva) |
| 1.21 | Cost to start: ~₹12,000 Year 1 | 🔲 | — | Planning only |
| 1.22 | Target: Class 6-12, CBSE + UP Board, Hindi | ⚠️ | `lib/config/constants.dart` | Classes 6-12 listed, boards listed, but only mock syllabus data |

---

## DOCUMENT 2: 2026-06-20-padho-guru-research.md (Day 2 Research)

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 2.1 | Tech Stack: Flutter (Dart 3.x) | ✅ | `pubspec.yaml` | Flutter project |
| 2.2 | Backend: Firebase (Auth, Firestore, Functions, Storage) | ⚠️ | `lib/main.dart`, `lib/services/` | Auth + Firestore done; Functions replaced with Cloud Run |
| 2.3 | AI: OpenAI GPT-5.4 mini / GPT-4o Vision | ⚠️ | `server/bin/server.dart` | GPT-5.4-mini configured but no Vision endpoint |
| 2.4 | Payments: in_app_purchase (Google Play + Apple IAP) | ✅ | `lib/services/payment_service.dart` | Service exists |
| 2.5 | Offline: SQLite (sqflite) + SharedPreferences | ❌ | `pubspec.yaml`, `lib/services/storage_service.dart` | sqflite in pubspec but NEVER used in code. StorageService uses SharedPreferences only |
| 2.6 | Animations: flutter_animate + Lottie + Shimmer | ❌ | `pubspec.yaml` | All 3 in pubspec but NONE actually used in widgets |
| 2.7 | CI/CD: Codemagic | ❌ | — | Not configured |
| 2.8 | Firebase Phone OTP login | ✅ | `lib/services/auth_service.dart`, `lib/screens/login_screen.dart` | Complete OTP flow |
| 2.9 | AI Answer Caching (~70% savings) | ⚠️ | `lib/services/firestore_service.dart` | `getCachedAnswer()` and `cacheAnswer()` exist but NOT wired into AI flow |
| 2.10 | NCERT on Device (₹0 reads) | ❌ | — | sqflite not used; no NCERT content stored locally |
| 2.11 | Blaze + ₹0 Alert | 🔲 | — | User must configure in Firebase console |
| 2.12 | Image Compress + Delete | ⚠️ | `lib/screens/camera_screen.dart` | Compression done (70%, 1080px); temp deletion NOT implemented |
| 2.13 | Pre-generate 500 Q&A | ❌ | — | Not done |
| 2.14 | 11 Screens: Login, Home, Camera, Chat, Syllabus, Profile, Achievements, History, Bookmarks, Practice, Settings | ✅ | `lib/screens/` | All 11 screen files exist |
| 2.15 | Bottom Nav: Home, Camera, Syllabus, Chat, Profile | ⚠️ | `lib/screens/home_screen.dart` | Only 4 tabs in nav (no Chat tab in bottom nav — Chat is reached from Camera) |
| 2.16 | Phone OTP only (no email/password) | ✅ | `lib/services/auth_service.dart` | Only phone auth |
| 2.17 | Streak & achievements in Firestore | ✅ | `lib/models/user_model.dart` | Streak, totalQuestions in UserModel |
| 2.18 | Downloaded NCERT in SQLite | ❌ | — | Not implemented |
| 2.19 | Lottie book animation on app launch | ❌ | `lib/screens/splash_screen.dart` | Uses Icon (Icons.auto_stories), not Lottie |
| 2.20 | Chat messages: Slide up + fade | ❌ | `lib/screens/chat_screen.dart` | No animation on messages |
| 2.21 | Camera capture: Scale pulse | ❌ | `lib/screens/camera_screen.dart` | No pulse animation |
| 2.22 | Subject tap: Lift effect | ❌ | `lib/widgets/subject_card.dart` | No lift animation (uses AnimatedContainer but no shadow change) |
| 2.23 | Page change: Slide transition | ❌ | — | Default MaterialPageRoute |

---

## DOCUMENT 3: 2026-06-20-master-build-document.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 3.1 | Store Title: "NCERT AI Tutor: Study Solver" (30 chars) | ✅ | `lib/config/constants.dart` | `storeTitle` constant set |
| 3.2 | Positioning: "AI Study Assistant" (NOT "NCERT app") | ✅ | — | Branding consistent |
| 3.3 | Pricing: Free (5/day), ₹99/mo, ₹999/yr | ✅ | `lib/config/constants.dart` | Set |
| 3.4 | 3-day free trial | ✅ | `lib/config/constants.dart` | `trialDays = 3` |
| 3.5 | Family plan: ₹199/mo | ❌ | — | Not implemented anywhere |
| 3.6 | Brand Assets section | ❌ | — | Not created (icons, screenshots) |
| 3.7 | Firebase Services: Auth, Firestore, Storage, Functions, Crashlytics, Analytics, Messaging | ⚠️ | `pubspec.yaml`, `lib/main.dart` | All in pubspec; Core, Auth, Firestore in main.dart; Crashlytics/Analytics/Messaging initialized but not actively used |
| 3.8 | Firestore Schema: users collection | ✅ | `lib/models/user_model.dart`, `lib/services/auth_service.dart` | User documents created on signup |
| 3.9 | Firestore Schema: cached_answers collection | ⚠️ | `lib/services/firestore_service.dart` | Methods exist but not wired |
| 3.10 | Firestore Schema: users/{phone}/history | ⚠️ | `lib/services/firestore_service.dart` | `saveChatHistory()` exists but not called |
| 3.11 | AI Architecture: Compress → Upload → Check cache → Call AI → Delete temp → Return | ❌ | — | Only compress implemented. No upload to Storage. No cache check in flow. No temp deletion. |
| 3.12 | Cloud Function for AI (Node.js/Python) | ⚠️ | `server/bin/server.dart` | Using Dart Shelf (not Node.js Cloud Function) |
| 3.13 | Pre-generate 500 Q&A | ❌ | — | Not done |
| 3.14 | Batch API (50% off) | ❌ | — | Not implemented |
| 3.15 | Sprint 1: Project Setup + Login | ✅ | Multiple files | Complete |
| 3.16 | Sprint 2: Home Screen + Profile | ✅ | `lib/screens/home_screen.dart`, `lib/screens/profile_screen.dart` | Complete |
| 3.17 | Sprint 3: Camera + AI (CORE) | ⚠️ | `lib/screens/camera_screen.dart`, `lib/screens/chat_screen.dart` | Camera works. AI uses MOCK data (not real OpenAI). No Cloud Function call actually integrated |
| 3.18 | Sprint 4: Syllabus + Offline | ⚠️ | `lib/screens/syllabus_screen.dart`, `lib/services/syllabus_service.dart` | UI complete but no real NCERT data (mock only for Class 6, 7, 10) |
| 3.19 | Sprint 5: History + Bookmarks + Achievements + Practice + Settings | ✅ | `lib/screens/` | All 5 screens exist with mock data |
| 3.20 | Cloud Function: receive image → call OpenAI → return answer | ❌ | `server/bin/server.dart` | Server has `/ask` endpoint but no image processing |
| 3.21 | Cloud Function: Answer caching logic | ❌ | `server/bin/server.dart` | No caching in server |
| 3.22 | Google Play Billing products: padho_guru_monthly (₹99), padho_guru_yearly (₹999) | ✅ | `lib/config/constants.dart` | Product IDs defined |
| 3.23 | Splash: Lottie book animation | ❌ | `lib/screens/splash_screen.dart` | Uses Icon, not Lottie |
| 3.24 | Chat animations: Slide-up + fade | ❌ | `lib/screens/chat_screen.dart` | Not implemented |
| 3.25 | Streak confetti: Lottie celebration | ❌ | — | Not implemented |
| 3.26 | Loading shimmers | ⚠️ | `lib/widgets/loading_indicator.dart` | Widget exists but only uses static containers, not Shimmer package |
| 3.27 | Voice input: speech_to_text | ❌ | `lib/screens/chat_screen.dart` | Mic icon shown but `// TODO: Voice input` |
| 3.28 | Page transitions: Hero animations | ❌ | — | Not implemented |
| 3.29 | Provider for state management | ✅ | `lib/providers/` | AuthProvider, ChatProvider, SyllabusProvider, SubscriptionProvider |
| 3.30 | Never put API keys in Flutter app | ✅ | — | API key loaded from .env in server, not in Flutter |
| 3.31 | Error Handling: try-catch, Hindi messages | ⚠️ | Various | Some error messages in Hindi, some not |
| 3.32 | Log errors to Firebase Crashlytics | ❌ | — | Crashlytics in pubspec but no error logging calls |

---

## DOCUMENT 4: 2026-06-20-cost-saving-architecture.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 4.1 | AI Answer Caching (SHA256 hash → Firestore) | ❌ | `lib/services/firestore_service.dart` | Methods exist but NOT called from `askQuestion()` flow |
| 4.2 | Hash generation: question+class+subject+board+lang | ❌ | — | No hash function in codebase |
| 4.3 | Cached answer structure with diagrams field | ❌ | — | Not in AnswerModel |
| 4.4 | NCERT on Device (SQLite, not Firestore) | ❌ | — | sqflite in pubspec but never imported or used |
| 4.5 | NCERT JSON in Firebase Storage | ❌ | — | Not implemented |
| 4.6 | Blaze Plan + ₹0 budget alert | 🔲 | — | User setup in Firebase Console |
| 4.7 | GPT-5.4 mini (not full model) | ✅ | `server/bin/server.dart` | Uses `gpt-5.4-mini` |
| 4.8 | Batch API for non-urgent (50% discount) | ❌ | — | Not implemented |
| 4.9 | Pre-generate 500 common questions | ❌ | — | Not done |
| 4.10 | Image compression: JPEG, 70% quality, 1080px width | ✅ | `lib/screens/camera_screen.dart` | `maxWidth: 1080, imageQuality: 70` |
| 4.11 | Upload to Firebase Storage /temp/ | ❌ | — | Not implemented (image stays locally) |
| 4.12 | DELETE image from Storage after processing | ❌ | — | Not applicable (no upload) |
| 4.13 | Usage analytics (track cache hit rate) | ❌ | — | Not implemented |
| 4.14 | Multi-language caching | ❌ | — | Not implemented |
| 4.15 | Weekly cache cleanup | ❌ | — | Not implemented |
| 4.16 | FCM for push (free) | ✅ | `pubspec.yaml` | firebase_messaging added |

---

## DOCUMENT 5: 2026-06-20-competitor-deep-analysis.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 5.1 | Camera overlay guide (steal from PhotoSolve) | ✅ | `lib/widgets/camera_overlay.dart` | Guide overlay with frame + instruction text |
| 5.2 | "Position question in frame" text (steal from PhotoSolve) | ✅ | `lib/widgets/camera_overlay.dart` | "सवाल को फ्रेम में रखें" |
| 5.3 | Clean bullet-point answer format (steal from Quizard) | ⚠️ | `lib/widgets/chat_bubble.dart` | Steps shown but using Arabic numerals (1,2,3) not Hindi (१,२,३) as specified |
| 5.4 | Subject auto-detection from photo (steal from Quizard) | ❌ | — | Not implemented |
| 5.5 | Chat-based follow-up (steal from Nerd AI) | ✅ | `lib/screens/chat_screen.dart` | Input bar + send functionality |
| 5.6 | "Others also asked" suggestions (steal from Brainly) | ✅ | `lib/widgets/chat_bubble.dart` | Related topics as ActionChips |
| 5.7 | NCERT chapter organization (steal from Philoid) | ⚠️ | `lib/screens/syllabus_screen.dart` | Class → Subject → Chapter navigation exists but only mock data |
| 5.8 | Hindi-first navigation (steal from SUPERCOP) | ⚠️ | Multiple | Most UI Hindi, but bottom nav labels are English ("Home", "Camera", etc.) |
| 5.9 | Free tier with limited uses (steal from all) | ✅ | `lib/models/user_model.dart` | `canAskFreeQuestion` logic |
| 5.10 | Offline NCERT book access (steal from Philoid) | ❌ | — | Not implemented |
| 5.11 | Flashcard feature (steal from Quizard) | ❌ | — | Not implemented |
| 5.12 | Step-by-step answer format (steal from PhotoSolve) | ✅ | `lib/widgets/chat_bubble.dart` | Steps section in AI bubble |
| 5.13 | Pricing: 8x cheaper than PhotoSolve (₹99 vs ₹830) | ✅ | `lib/config/constants.dart` | ₹99/mo set |
| 5.14 | Brainly's answer format with user ratings | ⚠️ | `lib/widgets/chat_bubble.dart` | 👍 Useful button but no rating display |

---

## DOCUMENT 6: 2026-06-20-development-roadmap.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 6.1 | Flutter SDK installed (3.44.2) | ✅ | Environment | Verified |
| 6.2 | Android Studio installed | ✅ | Environment | Verified |
| 6.3 | Firebase project created | 🔲 | — | User must create in console |
| 6.4 | Phone Auth enabled | 🔲 | — | User must enable in console |
| 6.5 | Blaze Plan + ₹0 budget alert | 🔲 | — | User must configure |
| 6.6 | GitHub repo created | ✅ | — | iSachinnayi/padho-guru |
| 6.7 | Google Play Developer fee ($25) | 🔲 | — | User must pay |
| 6.8 | Apple Developer fee (₹99/yr) | 🔲 | — | User must pay |
| 6.9 | App icon creation (Canva) | ❌ | — | User must create |
| 6.10 | Splash screen & loading animations | ⚠️ | `lib/screens/splash_screen.dart` | Exists but no Lottie |
| 6.11 | 8 Store screenshots | ❌ | — | Not created |
| 6.12 | Feature graphic (1024×500) | ❌ | — | Not created |
| 6.13 | Folder structure as per spec | ✅ | `lib/` | Matches planned structure |
| 6.14 | Voice input integration | ❌ | `lib/screens/chat_screen.dart` | `// TODO: Voice input` |
| 6.15 | Google Play Billing: padho_guru_monthly, padho_guru_yearly | ✅ | `lib/config/constants.dart` | Product IDs defined |
| 6.16 | 3-day trial for monthly, 7-day trial for yearly | ⚠️ | `lib/config/constants.dart` | Only 3-day trial constant, no 7-day |
| 6.17 | Receipt validation via Cloud Function | ❌ | — | Not implemented |
| 6.18 | Testing on 5+ Android devices | ❌ | — | Not done |
| 6.19 | Testing on iOS simulator | ❌ | — | Not done |
| 6.20 | User testing (5 students) | ❌ | — | Not done |
| 6.21 | Release APK build | ❌ | — | Not done |
| 6.22 | Store description (English + Hindi) | ❌ | — | Not written |
| 6.23 | Privacy policy | ⚠️ | `padho_guru/research-papers/privacy-policy.md` | Exists in research-papers |
| 6.24 | Content rating (Everyone) | ❌ | — | Not set |
| 6.25 | Play Store launch | ❌ | — | Not done |
| 6.26 | App Store launch | ❌ | — | Not done |
| 6.27 | Pre-launch marketing | ❌ | — | Not done |
| 6.28 | Post-launch monitoring (Crashlytics) | ❌ | — | Crashlytics initialized but no active monitoring |

---

## DOCUMENT 7: 2026-06-20-state-boards-textbook-sources.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 7.1 | CBSE (NCERT) support | ⚠️ | `lib/config/constants.dart` | Listed as option, mock data for Class 6, 7, 10 only |
| 7.2 | UP Board (UPMSP) | ❌ | — | Listed in boards constant but no content |
| 7.3 | Bihar Board (BSEB) | ❌ | — | Listed but no content |
| 7.4 | MP Board (MPBSE) | ❌ | — | Listed but no content |
| 7.5 | Rajasthan Board (RBSE) | ❌ | — | Listed but no content |
| 7.6 | Haryana Board (HBSE) | ❌ | — | Listed but no content |
| 7.7 | Jharkhand Board (JAC) | ❌ | — | Not listed in constants |
| 7.8 | Uttarakhand Board (UBSE) | ❌ | — | Not listed in constants |
| 7.9 | Chhattisgarh Board (CGBSE) | ❌ | — | Not listed in constants |
| 7.10 | Delhi Board (DBSE) | ❌ | — | Not listed in constants |
| 7.11 | Maharashtra Board (MSBSHSE) | ❌ | — | Listed but no content |
| 7.12 | DIKSHA API integration | ❌ | — | Not done |
| 7.13 | NCERT PDF download | ❌ | — | Not done |
| 7.14 | Textbook JSON conversion | ❌ | — | Not done |
| 7.15 | Phase 1 coverage: 70% of India (Hindi boards) | ❌ | — | No state board content at all |

---

## DOCUMENT 8: 2026-06-20-aso-and-icon-strategy.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 8.1 | Store Title: "NCERT AI Tutor: Study Solver" | ✅ | `lib/config/constants.dart` | Set |
| 8.2 | Short Description (80 chars) with keywords | ❌ | — | Not published |
| 8.3 | Full Description (English first, Hindi second) | ❌ | — | Not written |
| 8.4 | Keywords for App Store (100 chars) | ❌ | — | Not set |
| 8.5 | App Icon: Blue bg + Guru face + "पढ़ो" text | ❌ | — | Not created |
| 8.6 | 8 Screenshots with Hindi text | ❌ | — | Not created |
| 8.7 | Feature Graphic (1024×500) | ❌ | — | Not created |
| 8.8 | Category: Education | ❌ | — | Not set |
| 8.9 | In-app review prompt after 3rd answer | ❌ | — | Not implemented |
| 8.10 | Subscription products: ₹99/mo (3-day trial), ₹999/yr (7-day trial) | ✅ | `lib/config/constants.dart` | Product IDs + pricing set |
| 8.11 | Family plan: ₹199/mo | ❌ | — | Not created |
| 8.12 | A/B test icon via Google Play Experiments | ❌ | — | Not set up |
| 8.13 | Hindi description for conversion | ❌ | — | Not written |
| 8.14 | App Store Subtitle (30 chars) | ❌ | — | Not set |

---

## DOCUMENT 9: 2026-06-20-aso-keywords-strategy.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 9.1 | Title: "NCERT AI Tutor: Study Solver" (29 chars) | ✅ | `lib/config/constants.dart` | Set |
| 9.2 | Short Description: keyword optimized | ❌ | — | Not published |
| 9.3 | Full Description: keyword seeded | ❌ | — | Not written |
| 9.4 | App Store Keywords (94/100 chars) | ❌ | — | Not set |
| 9.5 | Monitor keyword rankings | ❌ | — | Not started |
| 9.6 | Keyword gap analysis applied | ❌ | — | Not applicable (not live) |

---

## DOCUMENT 10: 2026-06-20-brand-identity.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 10.1 | App Name: पढ़ो गुरु (Padho Guru) | ✅ | `lib/config/constants.dart` | Used throughout |
| 10.2 | Meaning: "Study Guru" / "Learn with a master" | ✅ | — | Brand concept clear |
| 10.3 | Hindi word, English pronounceable | ✅ | — | Works |
| 10.4 | Short (4 syllables) | ✅ | — | Yes |
| 10.5 | Unique search | ✅ | — | Will rank well |
| 10.6 | Domain: padhoguru.com/app/in | ❌ | — | Not registered |
| 10.7 | Social handles: @padhoguru | ❌ | — | Not created |

---

## DOCUMENT 11: 2026-06-22-build-reference.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| 11.1 | Store Title: "NCERT AI Tutor: Study Solver" | ✅ | `lib/config/constants.dart` | Set |
| 11.2 | Pricing: Free (5/day), ₹99/mo, ₹999/yr | ✅ | `lib/config/constants.dart` | Set |
| 11.3 | Genkit Dart for AI framework | ✅ | `server/pubspec.yaml`, `server/bin/server.dart` | Genkit setup with OpenAI plugin |
| 11.4 | AI Model: GPT-5.4 mini | ✅ | `server/bin/server.dart` | Configured |
| 11.5 | Backend: Cloud Run (Dart Shelf) | ⚠️ | `server/bin/server.dart` | Server exists but not deployed |
| 11.6 | Offline: SQLite (NOT used) + SharedPreferences | ❌ | — | sqflite never used |
| 11.7 | Colors: Primary #1565C0, Secondary #FF6F00 | ✅ | `lib/config/theme.dart` | Exact hex values |
| 11.8 | Surface: White, Background: #F5F7FA | ✅ | `lib/config/theme.dart` | Set |
| 11.9 | Success: #2E7D32, Error: #C62828 | ✅ | `lib/config/theme.dart` | Set |
| 11.10 | Gradient: #1565C0 → #0D47A1 | ✅ | `lib/config/theme.dart` | `primaryGradient` defined |
| 11.11 | Font: Noto Sans Devanagari (Google Fonts) | ✅ | `lib/config/theme.dart` | `GoogleFonts.notoSansDevanagariTextTheme` |
| 11.12 | Body: 14-16sp, Headings: 20-24sp Bold | ✅ | `lib/config/theme.dart` | Set |
| 11.13 | Hindi answers: 16-18sp | ⚠️ | `lib/config/theme.dart` | bodyLarge is 16sp, but chat text is hardcoded 15sp |
| 11.14 | Line height: 1.6 for Hindi | ✅ | `lib/config/theme.dart` | `height: 1.6` in bodyLarge |
| 11.15 | Rounded corners: 12-16dp cards, 24dp bottom sheets | ✅ | `lib/config/theme.dart` | Card radius 16, bottom sheet 24 |
| 11.16 | Material 3 enabled | ✅ | `lib/config/theme.dart` | `useMaterial3: true` |
| 11.17 | Dark Mode auto-detect | ✅ | `lib/config/theme.dart` | `brightness: Brightness.dark`, `ThemeMode.system` |
| 11.18 | Dark bg: #121212, cards: #1E1E1E | ✅ | `lib/config/theme.dart` | Exact values |
| 11.19 | Splash: Full blue gradient | ✅ | `lib/screens/splash_screen.dart` | Done |
| 11.20 | Splash: Lottie book animation (NOT done) | ❌ | `lib/screens/splash_screen.dart` | Uses Icon instead |
| 11.21 | Login: Gradient top half (NOT done) | ❌ | `lib/screens/login_screen.dart` | No gradient, just white |
| 11.22 | Login: "जारी रखें" CTA (NOT correct) | ❌ | `lib/screens/login_screen.dart` | Button says "OTP भेजें" and "सत्यापित करें" |
| 11.23 | Login: Terms & Privacy links | ✅ | `lib/screens/login_screen.dart` | Text at bottom |
| 11.24 | Home: "नमस्ते, रवि!" greeting | ⚠️ | `lib/screens/home_screen.dart` | Shows "नमस्ते! 👋" without user name |
| 11.25 | Home: Notification bell | ✅ | `lib/screens/home_screen.dart` | IconButton present |
| 11.26 | Home: Hero card with camera | ✅ | `lib/screens/home_screen.dart` | Gradient card with camera icon |
| 11.27 | Home: Continue Learning row | ✅ | `lib/screens/home_screen.dart` | Horizontal scroll with subjects |
| 11.28 | Home: Subject grid (2×3 layout) | ✅ | `lib/screens/home_screen.dart` | 3-column grid |
| 11.29 | Home: Quick Stats Bar | ❌ | — | StreakBar has some stats but no dedicated stats bar |
| 11.30 | Camera: Full-screen with guide overlay | ✅ | `lib/screens/camera_screen.dart` | Done |
| 11.31 | Camera: Gallery thumbnail (uses icon, not thumbnail) | ❌ | `lib/screens/camera_screen.dart` | Just an icon, not recent image thumbnail |
| 11.32 | Camera: Flash toggle | ✅ | `lib/screens/camera_screen.dart` | Flash button present |
| 11.33 | Camera: Review with crop option | ⚠️ | `lib/screens/camera_screen.dart` | "क्रॉप करें" text but no actual crop (onPressed: null/empty) |
| 11.34 | Chat: Streaming text word-by-word | ⚠️ | `lib/providers/chat_provider.dart`, `lib/services/ai_service.dart` | Streaming code exists but uses mock data |
| 11.35 | Chat: Hindi numerals (१, २, ३) for steps | ❌ | `lib/widgets/chat_bubble.dart` | Uses Arabic numerals (1, 2, 3) |
| 11.36 | Chat: Shimmer loading state | ⚠️ | `lib/screens/chat_screen.dart` | `_ChatShimmer` widget exists but uses static containers |
| 11.37 | Syllabus: Class selector dropdown | ✅ | `lib/screens/syllabus_screen.dart` | Chip-based selector |
| 11.38 | Syllabus: Subject tabs | ✅ | `lib/screens/syllabus_screen.dart` | Horizontal scroll tabs |
| 11.39 | Syllabus: Chapter list with expand/collapse | ✅ | `lib/screens/syllabus_screen.dart` | ExpansionTile for each chapter |
| 11.40 | Syllabus: Search bar | ✅ | `lib/screens/syllabus_screen.dart` | SearchDelegate implemented |
| 11.41 | Syllabus: Download status per chapter | ✅ | `lib/screens/syllabus_screen.dart` | Download indicator + toggle |
| 11.42 | Profile: Avatar with gradient bg | ✅ | `lib/screens/profile_screen.dart` | First letter + gradient |
| 11.43 | Profile: Stats grid (2×2) | ✅ | `lib/screens/profile_screen.dart` | 4 stat cards in 2×2 grid |
| 11.44 | Profile: Subscription card | ✅ | `lib/screens/profile_screen.dart` | Orange gradient card |
| 11.45 | Profile: Menu items (History, Bookmarks, Achievements, Practice, Settings, Share, Rate) | ⚠️ | `lib/screens/profile_screen.dart` | All listed but Settings navigates to routes (not direct Settings link from app bar — uses IconButton with empty onPressed) |
| 11.46 | Animations: Slide page transition | ❌ | — | Not implemented |
| 11.47 | Animations: Chat message slide-up | ❌ | — | Not implemented |
| 11.48 | Animations: Camera capture pulse | ❌ | — | Not implemented |
| 11.49 | Animations: Subject card lift | ❌ | — | Not implemented |
| 11.50 | Animations: Shimmer loading | ⚠️ | `lib/widgets/loading_indicator.dart` | Exists but no actual shimmer animation |
| 11.51 | Animations: Bottom nav icon scale | ❌ | — | Not implemented |
| 11.52 | Animations: Error shake | ❌ | — | Not implemented |
| 11.53 | Animations: Confetti particle burst | ❌ | — | Not implemented |
| 11.54 | Haptic feedback on button taps | ❌ | — | Not implemented |
| 11.55 | Spring animations (not linear) | ❌ | — | Not implemented |
| 11.56 | Hero animations between camera → chat | ❌ | — | Not implemented |
| 11.57 | Safe area handling | ✅ | Multiple screens | SafeArea used |
| 11.58 | Edge-to-edge design | ❌ | — | Not configured |
| 11.59 | Packages: genkit, genkit_openai (NOT in Flutter pubspec — in server pubspec) | ⚠️ | `server/pubspec.yaml` | In server, not in Flutter app |
| 11.60 | Packages: flutter_animate, lottie, shimmer (in pubspec but NOT used) | ❌ | `pubspec.yaml` | Listed but no imports in code |
| 11.61 | Packages: fl_chart (in pubspec but NOT used) | ❌ | `pubspec.yaml` | Listed but no imports |
| 11.62 | Packages: flutter_svg (in pubspec but NOT used) | ❌ | `pubspec.yaml` | Listed but no imports |
| 11.63 | Packages: cached_network_image (in pubspec but NOT used) | ❌ | `pubspec.yaml` | Listed but no imports |
| 11.64 | Packages: camera (in pubspec but NOT used directly — uses image_picker) | ⚠️ | `pubspec.yaml` | camera listed but CameraScreen uses image_picker instead |
| 11.65 | Packages: image_cropper (in pubspec but NOT used) | ❌ | `pubspec.yaml` | Listed but crop button has empty onPressed |
| 11.66 | Packages: intl (in pubspec but NOT used) | ❌ | `pubspec.yaml` | Listed but no imports |
| 11.67 | Server flows: question_flow.dart | ❌ | — | File does not exist |
| 11.68 | Server flows: syllabus_flow.dart | ❌ | — | File does not exist |
| 11.69 | Dockerfile | ✅ | `server/Dockerfile` | Exists |
| 11.70 | Folder structure matches spec | ⚠️ | `lib/` | app.dart doesn't exist (logic in main.dart) |

---

## DOCUMENT 12: 2026-06-22-pre-build-checklist.md

| # | Requirement | Status | Notes |
|:-:|:-----------|:------:|:-------|
| 12.1 | All 13 research documents complete | ✅ | All exist |
| 12.2 | Build reference documents (3) complete | ✅ | Created |
| 12.3 | App Name decided: पढ़ो गुरु | ✅ | Finalized |
| 12.4 | Tech Stack: Flutter + Genkit + Firebase + OpenAI | ✅ | Stack chosen |
| 12.5 | Architecture: Flutter → Cloud Run (Genkit) → OpenAI | ⚠️ | Server not deployed |
| 12.6 | UI Theme: Blue (#1565C0) + Orange (#FF6F00), Material 3 | ✅ | theme.dart complete |
| 12.7 | Font: Noto Sans Devanagari | ✅ | Configured |
| 12.8 | Pricing: Free (5/day) → ₹99/mo → ₹999/yr | ✅ | Constants set |
| 12.9 | Notifications: Zomato-style, 6 tiers, max 3/day | ❌ | Not implemented |
| 12.10 | AI Model: GPT-5.4 mini + GPT-4o Vision | ⚠️ | Only GPT-5.4-mini configured, no Vision |
| 12.11 | Backend: Cloud Run (Dart Shelf with Genkit flows) | ⚠️ | Server exists, flows incomplete |
| 12.12 | Auth: Firebase Phone OTP | ✅ | Complete |
| 12.13 | Database: Cloud Firestore | ✅ | Service exists |
| 12.14 | Offline: sqflite (NOT used) | ❌ | Not implemented |
| 12.15 | Payments: in_app_purchase (Google Play + Apple IAP) | ✅ | Service exists |
| 12.16 | CI/CD: Codemagic (NOT configured) | ❌ | Not set up |
| 12.17 | Store Title: "NCERT AI Tutor: Study Solver" | ✅ | Constant set |
| 12.18 | Flutter 3.44.2 installed | ✅ | Environment |
| 12.19 | Dart 3.12.2 installed | ✅ | Environment |
| 12.20 | Android Studio 2026.1.1 | ✅ | Environment |
| 12.21 | Git 2.54.0 | ✅ | Environment |
| 12.22 | GitHub: iSachinnayi/padho-guru | ✅ | Repo created |
| 12.23 | Flutter Doctor: No issues | ✅ | Verified |
| 12.24 | Ready for Sprint 1 | ✅ | Complete |

---

## MEMORY FILE: padho-guru-ui-design.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| M.1 | Design Philosophy: "MNC-quality, premium, clean" | ⚠️ | Various | Solid foundation but not fully polished |
| M.2 | Colors: Primary #1565C0, Secondary #FF6F00, Background #F5F7FA, Success #2E7D32, Error #C62828 | ✅ | `lib/config/theme.dart` | Exact matches |
| M.3 | Gradient: Primary → Primary-dark for app bar | ✅ | `lib/config/theme.dart` | AppBar uses primary, gradient available |
| M.4 | Font: Noto Sans Devanagari | ✅ | `lib/config/theme.dart` | Configured via GoogleFonts |
| M.5 | English text: Inter or Roboto (fallback to Noto Sans) | ❌ | `lib/config/theme.dart` | Noto Sans Devanagari used for everything |
| M.6 | Headings: Bold, 20-24sp | ✅ | `lib/config/theme.dart` | headlineLarge 24 Bold |
| M.7 | Body: Regular, 14-16sp | ✅ | `lib/config/theme.dart` | bodyLarge 16, bodyMedium 14 |
| M.8 | Hindi answers: 16-18sp for readability | ⚠️ | `lib/config/theme.dart` | bodyLarge is 16sp, chat uses hardcoded 15sp |
| M.9 | Line height: 1.6 for Hindi text | ✅ | `lib/config/theme.dart` | bodyLarge height: 1.6 |
| M.10 | Material 3 theming | ✅ | `lib/config/theme.dart` | useMaterial3: true |
| M.11 | Dynamic color scheme from primary blue | ✅ | `lib/config/theme.dart` | ColorScheme.light with primary |
| M.12 | Rounded corners: 12-16dp cards, 24dp bottom sheets | ✅ | `lib/config/theme.dart` | Card 16, bottom sheet 24 |
| M.13 | Elevation: subtle shadows (2-4dp) | ✅ | `lib/config/theme.dart` | elevation: 2 in cardTheme |
| M.14 | Shape: Rounded rectangles (no sharp edges) | ✅ | Multiple | 12-16dp radius throughout |
| M.15 | Splash: Full blue gradient (#1565C0 → #0D47A1) | ✅ | `lib/screens/splash_screen.dart` | Exact gradient |
| M.16 | Splash: Lottie book animation (NOT done) | ❌ | `lib/screens/splash_screen.dart` | Uses Icons.auto_stories |
| M.17 | Splash: "पढ़ो गुरु" in white, Noto Sans Devanagari | ✅ | `lib/screens/splash_screen.dart` | Done |
| M.18 | Splash: "NCERT AI Tutor" in light gray | ✅ | `lib/screens/splash_screen.dart` | Done with 0.7 opacity |
| M.19 | Splash: 1.5s auto-transition | ✅ | `lib/screens/splash_screen.dart` | Future.delayed(1500ms) |
| M.20 | Login: Top half gradient (NOT done) | ❌ | `lib/screens/login_screen.dart` | White background |
| M.21 | Login: "पढ़ो गुरु" logo text | ✅ | `lib/screens/login_screen.dart` | With gradient container |
| M.22 | Login: Tagline "NCERT का AI Tutor — फोटो खींचो, हिंदी में समझो" | ✅ | `lib/config/constants.dart` | In tagline constant |
| M.23 | Login: Country code +91 pre-selected | ✅ | `lib/screens/login_screen.dart` | +91 hardcoded |
| M.24 | Login: "जारी रखें" CTA (NOT correct label) | ❌ | `lib/screens/login_screen.dart` | Buttons say "OTP भेजें" and "सत्यापित करें" |
| M.25 | Login: Terms & Privacy links at bottom | ✅ | `lib/screens/login_screen.dart` | Text with conditions |
| M.26 | Login: OTP 6-digit auto-read boxes | ✅ | `lib/screens/login_screen.dart` | 6 individual text fields |
| M.27 | Login: Resend timer | ✅ | `lib/screens/login_screen.dart` | 30-second timer |
| M.28 | Home: App Bar "पढ़ो गुरु" + greeting | ⚠️ | `lib/screens/home_screen.dart` | Shows "पढ़ो गुरु" + "NCERT" badge. Greeting shows "नमस्ते! 👋" without name |
| M.29 | Home: Streak fire icon + days count | ✅ | `lib/widgets/streak_bar.dart` | StreakBar with 🔥 icon |
| M.30 | Home: Notification bell | ✅ | `lib/screens/home_screen.dart` | IconButton with notifications_outlined |
| M.31 | Home: Hero card with gradient + camera icon | ✅ | `lib/screens/home_screen.dart` | Done |
| M.32 | Home: "फोटो खींचो और सवाल पूछो" text | ✅ | `lib/screens/home_screen.dart` | Exact text |
| M.33 | Home: Pulse animation on camera icon | ❌ | `lib/screens/home_screen.dart` | No animation |
| M.34 | Home: Continue Learning "आगे बढ़ो" section | ✅ | `lib/screens/home_screen.dart` | Horizontal scroll with subject cards |
| M.35 | Home: "तुम्हारे विषय" grid | ✅ | `lib/screens/home_screen.dart` | 3-column grid |
| M.36 | Home: Long press → Quick actions (Download, Practice) | ✅ | `lib/screens/home_screen.dart` | Bottom sheet with options |
| M.37 | Home: Quick Stats Bar (NOT separate) | ❌ | `lib/screens/home_screen.dart` | StreakBar has questions count but no dedicated stats bar |
| M.38 | Camera: Full-screen preview | ✅ | `lib/screens/camera_screen.dart` | Full black scaffold |
| M.39 | Camera: Transparent guide overlay | ✅ | `lib/widgets/camera_overlay.dart` | Custom clipped overlay |
| M.40 | Camera: "सवाल को फ्रेम में रखें" instruction | ✅ | `lib/widgets/camera_overlay.dart` | Exact text |
| M.41 | Camera: Large circular capture button | ✅ | `lib/screens/camera_screen.dart` | 72px circle with white border |
| M.42 | Camera: Gallery button (thumbnail — NOT thumbnail, just icon) | ❌ | `lib/screens/camera_screen.dart` | Icon button, not image thumbnail |
| M.43 | Camera: Flash toggle | ✅ | `lib/screens/camera_screen.dart` | Flash icon button |
| M.44 | Camera: Torch, Flip camera, Close buttons | ❌ | `lib/screens/camera_screen.dart` | Only Close present. No flip camera |
| M.45 | Camera: Image review with "क्रॉप करें" option | ⚠️ | `lib/screens/camera_screen.dart` | Button text exists but onPressed does nothing |
| M.46 | Camera: "सवाल पूछें" button → loading → chat | ✅ | `lib/screens/camera_screen.dart` | Flow works |
| M.47 | Camera: Shimmer skeleton "आपका सवाल समझ रहे हैं..." | ⚠️ | `lib/screens/camera_screen.dart` | Shows "समझ रहे हैं..." text but no shimmer animation |
| M.48 | Chat: Header with "पढ़ो गुरु" + AI typing indicator | ✅ | `lib/screens/chat_screen.dart` | AppBar with "G" icon + status |
| M.49 | Chat: User question card with gray bg + photo thumbnail | ✅ | `lib/widgets/chat_bubble.dart` | Photo + text in user bubble |
| M.50 | Chat: AI response card with white bg + blue left border | ✅ | `lib/widgets/chat_bubble.dart` | Done |
| M.51 | Chat: "📝 प्रश्न:" section | ❌ | `lib/widgets/chat_bubble.dart` | Not in bubble design |
| M.52 | Chat: "✨ उत्तर:" streaming text | ⚠️ | `lib/providers/chat_provider.dart` | Streaming code exists but uses mock |
| M.53 | Chat: "📖 चरण-दर-चरण समझें" section | ✅ | `lib/widgets/chat_bubble.dart` | Steps section with header |
| M.54 | Chat: Steps numbered with Hindi numerals (१, २, ३) | ❌ | `lib/widgets/chat_bubble.dart` | Uses regular numbers (1, 2, 3) |
| M.55 | Chat: "🔗 संबंधित" related topics | ✅ | `lib/widgets/chat_bubble.dart` | ActionChip list |
| M.56 | Chat: Action buttons [👍 उपयोगी] [💾 सेव करें] [📤 शेयर] | ✅ | `lib/widgets/chat_bubble.dart` | Three action buttons |
| M.57 | Chat: Streaming character-by-character | ⚠️ | `lib/providers/chat_provider.dart` | Word-by-word (60ms delay) but mock data |
| M.58 | Chat: Hindi text larger (16sp) with good line spacing | ⚠️ | `lib/widgets/chat_bubble.dart` | Hardcoded 15sp, height: 1.7 |
| M.59 | Chat: Input bar with camera, text, mic, send | ✅ | `lib/screens/chat_screen.dart` | Complete input bar |
| M.60 | Chat: Camera quick button on left | ✅ | `lib/screens/chat_screen.dart` | Navigates to camera |
| M.61 | Chat: Text field with "हिंदी में सवाल टाइप करें..." | ✅ | `lib/screens/chat_screen.dart` | Exact hint text |
| M.62 | Chat: Mic button (TODO — not functional) | ❌ | `lib/screens/chat_screen.dart` | `// TODO: Voice input` |
| M.63 | Chat: Shimmer loading "पढ़ो गुरु आपका जवाब तैयार कर रहे हैं..." | ⚠️ | `lib/screens/chat_screen.dart` | Widget exists but no actual shimmer |
| M.64 | Syllabus: Class selector chips (6-12) | ✅ | `lib/screens/syllabus_screen.dart` | Chip-style selector |
| M.65 | Syllabus: Subject tabs (horizontal scroll) | ✅ | `lib/screens/syllabus_screen.dart` | Tab-style with Hindi names |
| M.66 | Syllabus: Chapter list with expand/collapse | ✅ | `lib/screens/syllabus_screen.dart` | ExpansionTile |
| M.67 | Syllabus: Download status per chapter | ✅ | `lib/screens/syllabus_screen.dart` | Download icon + "डाउनलोड" badge |
| M.68 | Syllabus: Search bar | ✅ | `lib/screens/syllabus_screen.dart` | SearchDelegate |
| M.69 | Syllabus: Progress indicator | ✅ | `lib/screens/syllabus_screen.dart` | Download count header |
| M.70 | Syllabus: Pull to refresh | ✅ | `lib/screens/syllabus_screen.dart` | RefreshIndicator |
| M.71 | Syllabus: Long press on chapter (NOT — uses download button) | ⚠️ | `lib/screens/syllabus_screen.dart` | Download button in trailing |
| M.72 | Profile: Avatar (first letter + gradient) | ✅ | `lib/screens/profile_screen.dart` | Letter 'र' with gradient |
| M.73 | Profile: Name, class, board | ✅ | `lib/screens/profile_screen.dart' | 'रवि कुमार', 'कक्षा 10 • CBSE' |
| M.74 | Profile: Edit button | ✅ | `lib/screens/profile_screen.dart` | OutlinedButton "संपादित करें" |
| M.75 | Profile: Stats grid (2×2) | ✅ | `lib/screens/profile_screen.dart` | 4 stat cards |
| M.76 | Profile: Subscription card with "अपग्रेड करें" | ✅ | `lib/screens/profile_screen.dart` | Orange gradient card |
| M.77 | Profile: Menu (History, Bookmarks, Achievements, Practice, Settings, Share, Rate) | ✅ | `lib/screens/profile_screen.dart` | All 7 items present |
| M.78 | Profile: Settings button in app bar (onPressed empty) | ❌ | `lib/screens/profile_screen.dart` | Settings icon but onPressed is empty |
| M.79 | Settings: Account section (Profile, Subscription) | ✅ | `lib/screens/settings_screen.dart` | Present |
| M.80 | Settings: Study section (Class, Board, Language) | ✅ | `lib/screens/settings_screen.dart` | Dropdown selectors |
| M.81 | Settings: Notifications section (Notifications, Streak Reminders) | ✅ | `lib/screens/settings_screen.dart` | SwitchListTile toggles |
| M.82 | Settings: Appearance section (Dark Mode) | ✅ | `lib/screens/settings_screen.dart` | SwitchListTile |
| M.83 | Settings: About section (Version, Privacy, Terms) | ✅ | `lib/screens/settings_screen.dart` | Three items |
| M.84 | Settings: Language options (Hindi, English) | ✅ | `lib/screens/settings_screen.dart` | Dropdown with हिंदी/English |
| M.85 | Settings: Boards list (CBSE, UP Board, etc.) | ✅ | `lib/config/constants.dart` | 9 boards listed |
| M.86 | ChatBubble: User message with photo attachment | ✅ | `lib/widgets/chat_bubble.dart` | Photo thumbnail + text |
| M.87 | ChatBubble: AI message with blue left border | ✅ | `lib/widgets/chat_bubble.dart` | Border(left: 3px blue) |
| M.88 | ChatBubble: Steps section with numbered list | ✅ | `lib/widgets/chat_bubble.dart` | Numbered steps section |
| M.89 | ChatBubble: Related topics as chips | ✅ | `lib/widgets/chat_bubble.dart` | ActionChip list |
| M.90 | ChatBubble: Action buttons (Helpful, Bookmark, Share) | ✅ | `lib/widgets/chat_bubble.dart` | Three buttons with icons |
| M.91 | ChatBubble: Helpful toggle (👍) | ✅ | `lib/widgets/chat_bubble.dart` | Toggle state + color |
| M.92 | ChatBubble: Bookmark toggle (💾) | ✅ | `lib/widgets/chat_bubble.dart` | Toggle state + color |
| M.93 | Dark Mode: bg #121212 with blue accent | ✅ | `lib/config/theme.dart` | darkTheme configured |
| M.94 | Dark Mode: cards #1E1E1E | ✅ | `lib/config/theme.dart` | cardTheme color: #1E1E1E |
| M.95 | Chinese/competitor app inspirations (Duolingo streak, Photomath camera, etc.) | ⚠️ | Various | Some implemented, some not |

---

## MEMORY FILE: padho-guru-notifications.md

| # | Requirement | Status | Code File | Notes |
|:-:|:-----------|:------:|:----------|:------|
| N.1 | Firebase Cloud Messaging (FCM) | ✅ | `pubspec.yaml` | firebase_messaging added |
| N.2 | Server-side push triggers (Cloud Functions) | ❌ | — | Not implemented |
| N.3 | Client-side triggers (Flutter app) | ❌ | — | Not implemented |
| N.4 | Deep Links (go_router) | ⚠️ | `lib/config/routes.dart` | Routes defined but not wired for notifications |
| N.5 | Package: flutter_local_notifications | ❌ | `pubspec.yaml` | Not in dependencies |
| N.6 | Package: workmanager | ❌ | `pubspec.yaml` | Not in dependencies |
| N.7 | Package: app_links | ❌ | `pubspec.yaml` | Not in dependencies |
| N.8 | Notification: "📸 आपका जवाब तैयार है!" (Answer ready) | ❌ | — | Not implemented |
| N.9 | Notification: "🔥 आज स्ट्रीक बचाने के लिए..." (Streak expiring) | ❌ | — | Not implemented |
| N.10 | Notification: "☀️ सुप्रभात! आज का पहला सवाल पूछो" (Morning) | ❌ | — | Not implemented |
| N.11 | Notification: Social proof "आज आपकी कक्षा के 50 छात्रों..." | ❌ | — | Not implemented |
| N.12 | Notification: Achievement "🏆 7 दिन की स्ट्रीक!" | ❌ | — | Not implemented |
| N.13 | Notification: Re-engagement "😢 3 दिन हो गए..." | ❌ | — | Not implemented |
| N.14 | Notification: Seasonal "📝 1 महीने में परीक्षा!" | ❌ | — | Not implemented |
| N.15 | Notification channels (Android): answers, streak_alerts, daily_tips, achievements, re_engagement | ❌ | — | Not implemented |
| N.16 | Max 3 notifications/day | ❌ | — | No rate limiting |
| N.17 | 2-hour gap between notifications | ❌ | — | Not implemented |
| N.18 | Never 11PM-6AM | ❌ | — | Not implemented |
| N.19 | Transactional don't count towards limit | ❌ | — | Not implemented |
| N.20 | Deep Link routes: /camera, /chat/:questionId, /syllabus, /achievements, /practice | ⚠️ | `lib/config/routes.dart` | Routes defined but no deep link handling |
| N.21 | Smart Timing Algorithm (study patterns) | ❌ | — | Not implemented |
| N.22 | Opt-out control in settings | ⚠️ | `lib/screens/settings_screen.dart` | Notification toggle exists but not functional |

---

## COMPREHENSIVE CODE QUALITY AUDIT

### Critical Gaps (Must Fix Before Launch)

| # | Issue | Severity | Details |
|:-:|:------|:--------:|:--------|
| C.1 | **AI uses MOCK data** — no real OpenAI connection | 🔴 | `AIService._getMockAnswer()` returns hardcoded data. Server running on localhost:3400 but never actually called with real questions |
| C.2 | **Camera uses image_picker, not camera package** | 🟡 | The `camera` package is in pubspec.yaml but CameraScreen uses `ImagePicker` from `image_picker`. No actual camera preview — just a gradient placeholder |
| C.3 | **No image upload to Firebase Storage** | 🟡 | Photos stay on device. No upload → no Cloud Function processing |
| C.4 | **AI Answer Caching NOT wired** | 🟡 | FirestoreService has methods but `ChatProvider.askQuestion()` never calls `getCachedAnswer()` |
| C.5 | **No temp file deletion** | 🟡 | Photos remain on device indefinitely |
| C.6 | **No real NCERT content data** | 🟡 | Only mock data for Class 6, 7, 10 Maths & Science. No Hindi, English, SST, Sanskrit. No state boards. |
| C.7 | **sqflite NOT used anywhere** | 🟡 | Listed in pubspec but never imported. No offline NCERT storage |
| C.8 | **3 animation packages NOT used** | 🟡 | `flutter_animate`, `lottie`, `shimmer` all in pubspec but NONE imported in any widget |
| C.9 | **Server flows missing** | 🔴 | `server/lib/flows/question_flow.dart` and `syllabus_flow.dart` don't exist |
| C.10 | **app.dart file missing** | 🟡 | Spec requires `lib/app.dart` but all logic is in `main.dart` |
| C.11 | **SubscriptionProvider NOT wired in main.dart** | 🟡 | `SubscriptionProvider` exists but not added to `MultiProvider` in `main.dart` |
| C.12 | **No payment receipt validation** | 🟡 | `_handlePurchase()` in PaymentService has `// TODO` comment — no server-side validation |
| C.13 | **Haptic feedback NOT implemented** | 🟢 | No `HapticFeedback` calls anywhere in codebase |
| C.14 | **Settings screen not linked from Profile** | 🟢 | Profile app bar has settings icon with `onPressed: () {}` — does nothing |
| C.15 | **Profile edit button does nothing** | 🟢 | "संपादित करें" button has `onPressed: () {}` |
| C.16 | **Crop button does nothing** | 🟢 | "क्रॉप करें" button has no functionality |
| C.17 | **fl_chart in pubspec but unused** | 🟢 | Package listed but no chart widgets created |
| C.18 | **flutter_svg in pubspec but unused** | 🟢 | Package listed but no SVG assets |
| C.19 | **cached_network_image in pubspec but unused** | 🟢 | Package listed but no network images |
| C.20 | **intl in pubspec but unused** | 🟢 | Package listed but no date formatting |

### Summary Statistics

| Category | Count | Status |
|:---------|:-----:|:-------|
| **Total Requirements Tracked** | ~250 | — |
| **✅ Fully Implemented** | ~120 | 48% |
| **⚠️ Partial/Incomplete** | ~45 | 18% |
| **❌ Missing/Not Done** | ~70 | 28% |
| **🔲 Not Applicable Yet** | ~15 | 6% |
| **🔴 Critical Issues** | 3 | AI mock data, missing server flows, no camera preview |
| **🟡 Medium Issues** | 8 | Caching not wired, no NCERT data, packages unused |
| **🟢 Minor Issues** | 9 | Empty callbacks, unused packages |

### What's Working Well ✅
- Complete 11-screen app structure with navigation
- Firebase Auth (Phone OTP) fully implemented
- Clean, Hindi-first UI with Material 3 theming
- Good color system, typography with Noto Sans Devanagari
- Streak bar, achievements, subject cards, chat bubbles all well designed
- Payment service structure in place
- Server architecture using Genkit on Cloud Run
- GoRouter setup with all routes

### Top 5 Priorities for Completion
1. **Connect AI to real OpenAI** — Replace mock data in `ai_service.dart`, wire up Cloud Run server
2. **Implement AI Answer Caching** — Wire `getCachedAnswer()` / `cacheAnswer()` into ChatProvider flow
3. **Add Lottie animations** — Splash screen, streak confetti, loading states
4. **Load real NCERT content** — Download NCERT JSON, store in SQLite, connect to syllabus screens
5. **Wire SubscriptionProvider** — Add to main.dart, connect payment flow end-to-end
