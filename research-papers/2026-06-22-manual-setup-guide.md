# 🔧 पढ़ो गुरु — Manual Setup Guide
## Step-by-step for Sachin (Total Time: ~45 min)

---

## Task 1: Firebase Project (15 min)

### Step 1: Create Firebase Project
1. **Browser kholo** → https://console.firebase.google.com
2. **"Create a project"** click karo
3. Project name: **padho-guru** (ya kuch bhi)
4. Google Analytics → Enable karo
5. **"Create project"** click karo
6. ~30 second wait

### Step 2: Enable Phone Auth
1. Firebase console mein **Authentication** → "Get started"
2. **"Sign-in method"** tab
3. **"Phone"** click karo → Enable karo → Save

### Step 3: Create Firestore Database
1. **"Firestore Database"** → "Create database"
2. Location: **asia-south1** (Mumbai — closest to India)
3. Start mode: **Test mode** (hum baad mein rules set karenge)
4. "Enable" click karo

### Step 4: Upgrade to Blaze Plan
1. Console ke left mein **"Upgrade"** ya **"Blaze"** click karo
2. Blaze plan select karo (Pay-as-you-go)
3. **Budget alert set karo: ₹0** (so agar kuch galat hua to notification aayega)
4. No worries — free tier bahut generous hai, ₹0 aayega cost

### Step 5: Register Android App
1. Firebase console mein **Gear icon** ⚙️ → **"Project settings"**
2. **"General"** tab → **"Your apps"** → **"Add app"** → **Android**
3. Android package name: **com.padhoguru.padho_guru**
4. App nickname (optional): **Padho Guru Android**
5. **"Register app"** click karo
6. **google-services.json** download karo → **Save to: `padho_guru/android/app/` folder mein daal do**
7. **"Next"** → **"Next"** → **"Skip"** (humara code ready hai)

### Step 6: Register iOS App (Skip for now)
- Jab iOS build karenge tab karenge

---

## Task 2: OpenAI API Key (5 min)

### Step 1: Create Account
1. Browser → https://platform.openai.com
2. **"Sign up"** ya agar account hai to **"Log in"**
3. Email: aapka koi bhi (ya hello.tradersguide@gmail.com)

### Step 2: Get API Key
1. OpenAI dashboard → **API Keys** (left sidebar)
2. **"Create new secret key"**
3. Name: **padho-guru-backend**
4. **Copy the key** and save it somewhere safe (kisi notepad mein)
5. Format kuch aisa hoga: `sk-proj-xxxxx...`

> **Cost:** OpenAI ka free credit $5 milta hai. Usse ~10,000+ questions pooch sakte ho. Baad mein ₹0.15-0.50 per question.

---

## Task 3: FlutterFire Configure (5 min)

### Step 1: Install FlutterFire CLI
Terminal mein ye command run karo:
```powershell
$env:Path = "C:\flutter\flutter\bin;$env:Path"
cd "C:\Users\iSach\Desktop\Ai Ideas\padho_guru"
dart pub global activate flutterfire_cli
```

### Step 2: Run FlutterFire Configure
```powershell
$env:Path = "C:\flutter\flutter\bin;$env:Path"
cd "C:\Users\iSach\Desktop\Ai Ideas\padho_guru"
flutterfire configure --project=padho-guru
```
(Ye automatically `firebase_options.dart` generate karega)

### Step 3: Verify
Terminal:
```powershell
flutter analyze
```
✅ Should show **"No issues found!"**

---

## ✅ Done! Ab Main Kya Karunga?

Jab aap kaam karte ho, main **Sprint 6 ka code likh dunga** (Genkit server, Cloud Run, OpenAI integration). Toh jab tak aap Firebase setup karoge, mera backend code bhi ready hoga!

---

## ⏱️ Summary

| Task | Time | Kab Karna |
|:-----|:----:|:----------|
| Firebase Project | 15 min | ✅ Now |
| Phone Auth Enable | 2 min | ✅ Now |
| Firestore Create | 3 min | ✅ Now |
| Blaze Plan Upgrade | 5 min | ✅ Now |
| google-services.json download | 2 min | ✅ Now |
| OpenAI API Key | 5 min | ✅ Now |
| FlutterFire CLI + Configure | 5 min | ✅ Now |
| **Total** | **~37 min** | |

**Ek kaam karo, step complete karte jaao, mujhe batao — main side mein Sprint 6 ka code ready kar dunga!** 🚀
