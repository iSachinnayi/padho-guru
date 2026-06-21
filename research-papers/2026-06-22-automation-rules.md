# 🎯 पढ़ो गुरु — AI Agent Rules: Automation vs Manual

## Golden Rule
> **AI Agent automatically builds everything possible. User only does what ONLY a human can do (creating accounts, paying fees, testing on real device).**

---

## ✅ AI AGENT KAREGA (100% Automatic — No User Effort)

### Code (Sprint by Sprint)
| Area | Files | Status |
|:-----|:------|:------:|
| `pubspec.yaml` | All dependencies | ⏳ When START |
| `lib/main.dart` | App entry, Firebase init, Genkit init | ⏳ When START |
| `lib/app.dart` | MaterialApp, theme, routing | ⏳ When START |
| `lib/config/` | theme.dart, constants.dart, routes.dart | ⏳ When START |
| `lib/models/` | user_model, question_model, answer_model, subject_model | ⏳ When START |
| `lib/services/` | auth_service, firestore_service, ai_service, payment_service, syllabus_service | ⏳ When START |
| `lib/providers/` | auth_provider, chat_provider, syllabus_provider, subscription_provider | ⏳ When START |
| `lib/screens/` | login, home, camera, chat, syllabus, profile, history, bookmarks, achievements, practice, settings (11 screens) | ⏳ When START |
| `lib/widgets/` | subject_card, chat_bubble, streak_bar, camera_overlay, loading_indicator | ⏳ When START |
| `server/` | Genkit Dart server (Cloud Run): flows, pubspec, Dockerfile | ⏳ When START |

### Design Assets (AI Generates Exact Specs)
| Asset | AI Does | User Does |
|:------|:--------|:----------|
| **App Icon** | Write exact Canva design instructions (colors, layout, text) | Just follow steps in Canva (5 mins) |
| **Screenshots** | Write exact Canva design for 8 frames | Just follow steps in Canva (10 mins) |
| **Lottie Animations** | Provide exact search terms + URLs from LottieFiles | Just download (2 mins) |

### App Store Content
| Content | AI Does | User Does |
|:--------|:--------|:----------|
| Play Store Title | "NCERT AI Tutor: Study Solver" ✅ | Just paste in console |
| Short Description | 80 chars optimized ✅ | Just paste |
| Full Description | 4000 chars with keywords ✅ | Just paste |
| Keywords | Complete list ✅ | Just paste |
| Privacy Policy | Write complete policy ✅ | Just upload |
| Terms of Service | Write complete TOS ✅ | Just upload |
| AI Disclaimer | Write complete disclaimer ✅ | Just paste |

### Backend & Infrastructure
| Task | AI Does | User Does |
|:-----|:--------|:----------|
| Firestore Security Rules | Write complete rules ✅ | Just paste in console |
| Genkit server code | Full Dart Shelf server ✅ | Nothing |
| Dockerfile | Write complete Dockerfile ✅ | Nothing |
| Firebase Schema | Complete design ✅ | Nothing |
| CI/CD (Codemagic) | Complete config file ✅ | Just upload to Codemagic |

### Deployment
| Task | AI Does | User Does |
|:-----|:--------|:----------|
| Git push | Regular commits + push ✅ | Nothing |
| Build APK | `flutter build apk` command | Run the command |
| Release notes | Write for each version ✅ | Just copy-paste |

---

## 👤 USER KAREGA (Manual — Only Human Can)

| # | Task | Time | Why AI Can't |
|:-:|:-----|:----:|:-------------|
| 1 | **Create Firebase Project** | 15 mins | Need Google account + console access |
| 2 | **Enable Phone Auth** | 5 mins | In Firebase console |
| 3 | **Download google-services.json** | 2 mins | From Firebase console |
| 4 | **Run `flutterfire configure`** | 5 mins | Links Flutter to Firebase |
| 5 | **Pay Google Play $25** | 10 mins | Payment, one-time |
| 6 | **Pay Apple Developer ₹99/yr** | 10 mins | Payment, yearly |
| 7 | **Upload APK to Play Console** | 10 mins | AI can't access console |
| 8 | **Test on real Android phone** | 30 mins | Need physical device |
| 9 | **Create App Icon in Canva** | 10 mins | Follow AI's exact specs |
| 10 | **Create Screenshots in Canva** | 15 mins | Follow AI's exact specs |

### Total User Manual Work: **~2 hours** (entire project lifecycle)
### Total AI Automated Work: **~200+ hours** (entire codebase)

---

## 🚀 EXECUTION RULE

> **START bolte hi AI agent Sprint 1 shuru karega.**
> Har sprint ke baad agent push karega.
> User sirf "continue" ya feedback dega.
> Kabhi code nahi likhna padega user ko.

### Workflow
```
User: "START"
  ↓
AI Agent: Sprint 1 code likhe → commit → push
  ↓
User: "Looks good, next" ya feedback
  ↓
AI Agent: Sprint 2 code likhe → commit → push
  ↓
...repeat till complete...
  ↓
AI Agent: "App ready. These 10 manual steps needed → [list]"
  ↓
User: Does 10 manual steps (~2 hours)
  ↓
🚀 App on Play Store!
```

---

## 📜 NOTIFICATION RULES (Zomato-Style)

### Psychology Rules
1. **Urgency** — Streak expiring, limited free questions
2. **Social Proof** — "X students studied today"
3. **Personalization** — User name, subject, class
4. **FOMO** — "Top 5% this week"
5. **Achievement** — Milestones, streaks
6. **Curiosity** — Incomplete info, tap to see

### Technical Rules
1. Max 3 notifications/day (transactional don't count)
2. Never 11PM-6AM (students sleep)
3. 2-hour gap minimum between notifications
4. Always deep link to specific screen
5. Respect system DND
6. If app open → suppress non-critical for 4 hours

### Frequency Rules
| Day | Inactive Since | Notification Type |
|:---:|:--------------|:-----------------|
| Day 1-2 | Active user | Streak reminder, daily question |
| Day 3 | Inactive | Soft re-engagement |
| Day 5 | Still inactive | Offer free questions |
| Day 7 | Inactive | New content alert |
| Day 14+ | Churned | Limited time offer |

### Implementation
- `firebase_messaging` for server push
- `flutter_local_notifications` for scheduled local
- `workmanager` for background tasks
- `app_links` for deep linking
