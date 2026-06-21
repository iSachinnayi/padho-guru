# 🏗️ पढ़ो गुरु — Complete Build Reference
## Final Document for AI Agent Build Process
## Updated: June 22, 2026

---

## 📋 TABLE OF CONTENTS
1. Product Vision
2. Tech Stack
3. Architecture
4. UI Design System
5. Screen-by-Screen Design
6. Animations
7. Packages
8. Folder Structure
9. Build Plan

---

## 1. 🎯 PRODUCT VISION

| Field | Value |
|-------|-------|
| **App Name** | पढ़ो गुरु (Padho Guru) |
| **Store Title** | "NCERT AI Tutor: Study Solver" (30 chars) |
| **Tagline** | NCERT AI Tutor: Study Solver |
| **Concept** | Click photo of textbook question → AI explains in Hindi |
| **Target User** | Class 6-12 Indian students, Hindi medium, CBSE + State Boards |
| **Platform** | Android (launch first) → iOS (via Codemagic) |
| **Pricing** | Free (5 doubts/day), ₹99/month, ₹999/year |

### Key Differentiator
```
✅ AI-powered + ✅ Photo solving + ✅ Hindi + ✅ NCERT + ✅ All subjects + ✅ Affordable (₹99)
→ NO competitor does all of these
```

---

## 2. 💻 TECH STACK (FINAL)

```
📱 Frontend:     Flutter 3.44.2 (Dart 3.12.2)
🤖 AI Framework: Genkit Dart (genkit + genkit_openai)
🧠 AI Model:     OpenAI GPT-5.4 mini / GPT-4o Vision
🗄️  Auth:        Firebase Phone Auth
🗄️  Database:    Cloud Firestore (caching, user data, chat history)
☁️ Backend:      Cloud Run (Dart Shelf server with Genkit flows)
📴 Offline:      SQLite (sqflite) + SharedPreferences
💳 Payments:     in_app_purchase (Google Play + Apple IAP)
🎨 Animations:   flutter_animate + Lottie + Shimmer
🛠️ CI/CD:        Codemagic (free tier → builds APK/IPA in cloud)
```

### Why Genkit Dart?
- ✅ Type-safe structured output (no manual JSON parsing)
- ✅ Streaming responses (Hindi explanation word-by-word)
- ✅ Model-agnostic (can swap OpenAI ↔ Gemini ↔ Claude)
- ✅ Built-in Developer UI for prompt testing
- ✅ OpenAI plugin ready
- ✅ Cost: ₹0 extra (free open-source)

---

## 3. 🏛️ ARCHITECTURE

```
                     Flutter App (with Genkit client SDK)
                              │
                              │ runFlow() (type-safe HTTP)
                              ▼
               Cloud Run (Dart Shelf Server)
                              │
                    ┌─────────┴──────────┐
                    │                     │
           Genkit Flows            Firebase Admin
           (AI logic,              (Auth, Firestore)
            streaming,
            prompts)
                    │
                    ▼
              OpenAI API
         (GPT-5.4 mini + Vision)
```

### Cost-Saving Jugaads (MUST IMPLEMENT):
1. **AI Answer Caching** (SHA256 → Firestore → 70% savings)
2. **NCERT on Device** (SQLite, NOT Firestore reads)
3. **Image Compress + Delete** (compress before upload, delete after AI)
4. **Blaze Plan + ₹0 Budget Alert** (never exceed free tier)
5. **Pre-generate 500 Q&A** (common NCERT questions cached at launch)

---

## 4. 🎨 UI DESIGN SYSTEM

### Design Philosophy
"An MNC-quality education app that feels premium, not gimmicky. Clean, modern, trustworthy."

### Colors
| Token | Color | Hex | Usage |
|:-----|:-----:|:---:|:------|
| Primary | Deep Blue | `#1565C0` | Trust, education, app bar |
| Secondary | Amber Orange | `#FF6F00` | CTAs, streak highlights |
| Surface | White | `#FFFFFF` | Cards, sheets |
| Background | Light Gray | `#F5F7FA` | Screen bg |
| Success | Green | `#2E7D32` | Correct answers |
| Error | Red | `#C62828` | Wrong answers |
| Gradient | Blue → Dark Blue | `#1565C0 → #0D47A1` | Splash, hero cards |

### Typography
| Element | Font | Size | Weight |
|:--------|:----:|:----:|:------:|
| Headings | Noto Sans Devanagari | 20-24sp | Bold |
| Body | Noto Sans Devanagari | 14-16sp | Regular |
| Hindi Answers | Noto Sans Devanagari | 16-18sp | Regular |
| English | Inter / Roboto | 14-16sp | Regular |
| Line height (Hindi) | — | 1.6 | — |

### Design Tokens
- **Shape**: Rounded corners (12-16dp cards, 24dp bottom sheets)
- **Elevation**: Subtle shadows (2-4dp)
- **Material 3**: Enabled with dynamic color scheme
- **Dark Mode**: Auto-detect from system, bg `#121212`, cards `#1E1E1E`

---

## 5. 🖼️ SCREEN-BY-SCREEN DESIGN

### A. SPLASH SCREEN (1.5s)
- Full blue gradient background
- Center: Lottie book opening animation
- "पढ़ो गुरु" in white (Noto Sans Devanagari)
- "NCERT AI Tutor" subtitle in light gray
- Auto-transition to Login or Home

### B. LOGIN SCREEN
- Gradient top half with subtle pattern
- "पढ़ो गुरु" logo + tagline
- Phone input: +91 pre-selected
- "जारी रखें" CTA (rounded, full-width)
- Terms & Privacy links
- OTP: 6-digit auto-read boxes + resend timer

### C. HOME SCREEN (Bottom Nav #1)
```
┌──────────────────────────────────┐
│ नमस्ते, रवि! 👋          🔥 7   │
├──────────────────────────────────┤
│ ╔══════════════════════════════╗ │
│ ║  📸 फोटो खींचो और सवाल पूछो ║ │
│ ║      [Pulse animation]      ║ │
│ ╚══════════════════════════════╝ │
│                                  │
│ 📚 आगे बढ़ो →                    │
│ [Science] [Math] [Hindi] ...     │
│                                  │
│ तुम्हारे विषय                     │
│ ┌────┐ ┌────┐ ┌────┐            │
│ │🧪  │ │📐  │ │📖  │            │
│ │Sci │ │Math│ │Hindi│            │
│ │10Ch│ │8Ch │ │6Ch │            │
│ └────┘ └────┘ └────┘            │
├──────────────────────────────────┤
│ 📸    📚    💬    👤             │
│ Home  Sylb  Chat  Profile        │
└──────────────────────────────────┘
```

### D. CAMERA SCREEN (Bottom Nav #2)
- Style: Photomath + Google Lens quality
- Full-screen preview with transparent guide overlay
- "सवाल को फ्रेम में रखें" instruction text
- Large circular capture button (white + blue ring)
- Gallery thumbnail + Flash toggle
- After capture: Review with crop option + "सवाल पूछें" button
- Loading: Shimmer skeleton with "आपका सवाल समझ रहे हैं..."

### E. CHAT SCREEN (After Camera — 90% of user time)
```
Header: ← पढ़ो गुरु | 🤖 typing

┌─────────────────────────────┐
│ 📸 [Photo thumbnail]        │ ← User
│ प्रकाश का परावर्तन क्या है? │
└─────────────────────────────┘

┌─────────────────────────────┐
│ 📝 प्रश्न:                  │
│ प्रकाश का परावर्तन क्या है? │
│                             │
│ ✨ उत्तर: (streaming text)  │ ← AI
│ प्रकाश का परावर्तन...      │
│                             │
│ 📖 चरण-दर-चरण:             │
│ १. पहला कदम...             │
│ २. दूसरा कदम...             │
│                             │
│ 🔗 संबंधित: परावर्तन के नियम│
│                             │
│ [👍] [💾] [📤]              │
└─────────────────────────────┘

[📸] [Type here...] [🎤] [➤]
```
- Streaming: Character-by-character appearance
- Hindi numerals (१, २, ३) for steps
- Shimmer loading state with pulsing skeleton

### F. SYLLABUS SCREEN (Bottom Nav #3)
- Class selector dropdown (6-12) at top
- Subject tabs (horizontal scroll)
- Chapter list with expand/collapse
- Download status per chapter
- Search bar
- Progress indicator

### G. PROFILE SCREEN (Bottom Nav #4)
- Avatar (first letter + gradient), name, class, board
- Stats grid (2×2): Questions, Streak, Bookmarks, Subjects
- Subscription card with "अपग्रेड करें" button
- Menu: History, Bookmarks, Achievements, Practice, Settings, Share, Rate

---

## 6. 🔥 ANIMATIONS SPECIFICATION

| Element | Animation Type | Duration | Easing |
|:--------|:--------------|:--------:|:------:|
| Page transition | Slide left/right | 300ms | easeInOut |
| Chat message | Slide up + fade | 250ms | easeOut |
| Camera capture | Scale pulse (1→0.95→1) | 200ms | easeOut |
| Streak fire | Scale bounce | 400ms | spring |
| Subject card tap | Lift (shadow increase) | 150ms | easeOut |
| Loading shimmer | L-to-R gradient sweep | 1.5s loop | linear |
| Bottom nav switch | Icon scale + color fade | 200ms | easeInOut |
| Error | Horizontal shake | 300ms | easeInOut |
| Confetti | Particle burst | 1.5s | easeOut |

### Premium Micro-interactions
1. Haptic feedback on button taps
2. Spring animations (not linear)
3. Skeleton shimmer (not spinning loaders)
4. Hero animations between camera → chat
5. Safe area + edge-to-edge design

---

## 7. 📦 ALL FLUTTER PACKAGES

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Genkit AI
  genkit: ^latest
  genkit_openai: ^latest
  
  # Firebase
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
  firebase_storage: ^12.0.0
  firebase_messaging: ^15.0.0
  firebase_analytics: ^11.0.0
  firebase_crashlytics: ^4.0.0
  
  # Camera & Image
  camera: ^0.12.0
  image_picker: ^1.0.0
  image_cropper: ^6.0.0
  
  # Payments
  in_app_purchase: ^3.2.0
  
  # Storage & Offline
  sqflite: ^2.3.0
  shared_preferences: ^2.2.0
  path_provider: ^2.1.0
  
  # UI & Animations
  flutter_animate: ^4.5.0
  lottie: ^3.0.0
  shimmer: ^3.0.0
  cached_network_image: ^3.3.0
  flutter_svg: ^2.0.0
  google_fonts: ^6.0.0
  
  # Navigation
  go_router: ^14.0.0
  
  # Utilities
  http: ^1.2.0
  fl_chart: ^0.68.0
  intl: ^0.19.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.0
```

---

## 8. 📁 FOLDER STRUCTURE

```
padho_guru/
├── android/
├── ios/
├── assets/
│   ├── lottie/          # Lottie animation JSON files
│   └── icons/           # App icons, SVG icons
├── lib/
│   ├── main.dart        # App entry point
│   ├── app.dart         # MaterialApp + routing
│   ├── config/
│   │   ├── theme.dart   # Colors, fonts, styles
│   │   ├── constants.dart
│   │   └── routes.dart  # GoRouter routes
│   ├── models/          # Data classes
│   │   ├── user_model.dart
│   │   ├── question_model.dart
│   │   ├── answer_model.dart
│   │   └── subject_model.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   ├── ai_service.dart (Genkit flow calls)
│   │   ├── payment_service.dart
│   │   └── syllabus_service.dart
│   ├── providers/       # Riverpod/ChangeNotifier
│   │   ├── auth_provider.dart
│   │   ├── chat_provider.dart
│   │   ├── syllabus_provider.dart
│   │   └── subscription_provider.dart
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── home_screen.dart
│   │   ├── camera_screen.dart
│   │   ├── chat_screen.dart
│   │   ├── syllabus_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── history_screen.dart
│   │   ├── bookmarks_screen.dart
│   │   ├── achievements_screen.dart
│   │   ├── practice_screen.dart
│   │   └── settings_screen.dart
│   └── widgets/
│       ├── subject_card.dart
│       ├── chat_bubble.dart
│       ├── streak_bar.dart
│       ├── camera_overlay.dart
│       └── loading_indicator.dart
├── functions/           # Firebase Cloud Functions (future)
├── server/              # Genkit Dart Shelf server for Cloud Run
│   ├── bin/
│   │   └── server.dart
│   ├── lib/
│   │   └── flows/
│   │       ├── question_flow.dart    # Main Q&A flow
│   │       └── syllabus_flow.dart    # Syllabus lookup
│   ├── pubspec.yaml
│   └── Dockerfile
├── test/
├── pubspec.yaml
└── README.md
```

---

## 9. 📅 BUILD PLAN (25 Days)

### PHASE 0: Environment Setup ✅ (DONE)
- Flutter 3.44.2 installed ✅
- Android Studio + SDK ✅
- VS Code extensions ✅
- Git + GitHub repo ✅
- Firebase project setup (PENDING)

### SPRINT 1 (Days 1-2): Project Setup + Auth
- pubspec.yaml with all dependencies
- main.dart + app.dart
- theme.dart + constants.dart + routes.dart
- auth_service.dart (Firebase Phone Auth)
- auth_provider.dart
- login_screen.dart (Phone + OTP)

### SPRINT 2 (Days 3-4): Home + Profile
- home_screen.dart (Hero card, subjects grid, continue learning, stats)
- streak_bar.dart
- subject_card.dart
- profile_screen.dart (Stats, subscription, menu)

### SPRINT 3 (Days 5-6): Camera + Chat (Core)
- camera_screen.dart (Full camera with guide overlay + review)
- camera_overlay.dart
- chat_screen.dart (Messages, streaming, input bar)
- chat_bubble.dart
- ai_service.dart (Genkit flow calls)
- chat_provider.dart

### SPRINT 4 (Days 7-8): Syllabus + Offline
- syllabus_screen.dart
- syllabus_provider.dart
- NCERT JSON data loading
- sqflite offline storage

### SPRINT 5 (Days 9-10): History, Bookmarks, Achievements, Practice, Settings
- history_screen.dart
- bookmarks_screen.dart
- achievements_screen.dart
- practice_screen.dart
- settings_screen.dart

### PHASE 3 (Days 11-13): Backend + Genkit Server
- server/bin/server.dart (Cloud Run entry)
- server/lib/flows/question_flow.dart
- server/lib/flows/syllabus_flow.dart
- server/Dockerfile
- Firestore security rules

### PHASE 4 (Days 14-15): Payments
- payment_service.dart
- subscription_provider.dart
- Google Play Console products

### PHASE 5 (Days 16-18): Polish + Animations
- Lottie animations
- Shimmer loading
- Page transitions
- Haptic feedback
- Dark mode

### PHASE 6 (Days 19-22): Testing + Store Assets
- Beta testing (10 students)
- App icon generation
- Screenshots (8 frames)
- Privacy Policy + Terms
- Feature graphic

### PHASE 7 (Days 23-25): Launch
- Google Play listing ($25)
- App Store listing (₹99/yr)
- ASO optimization
- Launch marketing

---

## 10. 🛠️ TOOLS & EXTENSIONS

### VS Code Extensions to Install
```vscode-extensions
amitpatole.genkit-vscode,pflannery.vscode-versionlens
```

### VS Code Settings to Enable
```json
{
  "dart.mcpServer": true
}
```

### VS Code Extensions Already Installed
- Dart Code ✅
- Flutter ✅

### Design Tools (User Needs)
- **Canva** (free) — App icon, screenshots, feature graphic
- **appicon.co** (free) — Generate all icon sizes
- **LottieFiles** (free) — Education animations
- **Figma** (free, optional) — Better for detailed design

---

## 11. 📊 COMPETITOR GAP ANALYSIS

| Competitor | Downloads | Our Advantage |
|:-----------|:---------:|:--------------|
| **Philoid** | 10M+ | No AI, static PDFs → We have AI photo solving |
| **SUPERCOP** | 1M+ | No AI, static solutions → We have AI |
| **PhotoSolve** | 1M+ | English only, ₹830/mo → Hindi + ₹99 |
| **Quizard AI** | 500K+ | English only, ₹665/mo → Hindi + NCERT |
| **Nerd AI** | 1M+ | English, ₹1K/mo → Hindi + ₹99 |
| **Brainly** | 100M+ | Slow community answers → Instant AI |

**Demand Proof:** Philoid has 10M+ downloads with just NCERT PDFs (no AI). Imagine what an AI-powered version could do.

---

## 12. 💰 COST & REVENUE

### Monthly Costs (1,000 Paying Users)
| Item | Cost |
|:-----|:----:|
| Firebase | ₹0 (free tier) |
| OpenAI API (with 70% caching) | ~₹900 |
| Apple Dev Account | ₹830 |
| Google Play Account | ₹2 |
| **Total** | **~₹1,732/mo** |

### Revenue Projection
| Users | Revenue/mo | Profit/mo |
|:----:|:----------:|:---------:|
| 100 | ₹8,400 | ₹7,900 |
| 1,000 | ₹84,000 | ₹82,268 |
| 10,000 | ₹8,40,000 | ₹8,31,000 |
| 50,000 | ₹42,00,000 | ₹41,60,000 |

### One-Time Setup Costs
| Item | Cost |
|:-----|:----:|
| Google Play Developer Account | $25 (one-time) |
| Apple Developer Account | ₹99/year |
| **Total Year 1** | **~₹12,000** |

---

## 13. 🔍 REDDIT COMMUNITY INSIGHTS (r/FlutterDev)

1. **"Small UI Details Matter Most"** — Focus on tiny interactions. Say "animate using springs" not just "animate". Details build taste.
2. **"Study Real App UX Patterns"** — Learn from production open-source apps (Lichess, etc.)
3. **"Feature-First Architecture"** — Each feature = data/ + presentation/ folders. Clean ownership.
4. **"Domain Separate From UI"** — Business logic never mixed with widgets.
5. **"Clarity Over Purity"** — Make it obvious which code owns which concept.
6. **"AI for UI Scaffolding"** — Use AI agents to generate UI from designs.
7. **"Publish Early"** — App store feedback teaches real lessons.
8. **800+ Open Source Flutter Apps** — github.com/fluttergems/awesome-open-source-flutter-apps

---

## 14. ❌ WHAT TO AVOID
- Default Flutter widgets without customization
- Generic book icons (every NCERT app has this)
- Too much text on one screen
- Loading spinners (use shimmer instead)
- Sharp edges/corners
- Inconsistent spacing
- English-only UI (our audience is Hindi)
- Ads in the middle of answers (kills trust)

## 15. ✅ WHAT TO STEAL FROM BEST APPS
| App | Feature |
|:---:|:--------|
| **Duolingo** | Streak system, gamification, progress visual |
| **Photomath** | Camera overlay guide, step-by-step format |
| **Khan Academy** | Clean typography, subject organization |
| **BYJU'S** | Color scheme, premium feel, illustrations |
| **Brainly** | "Others also asked" suggestions |
| **Google Photos** | Image viewer gestures (pinch, swipe) |
