---
name: flutter-env-secrets
description: Manage and secure sensitive configuration, API keys, credentials, tokens, and environment variables in Flutter using compile-time environment defines (--dart-define-from-file). Use this skill whenever the user asks about securing secrets, API keys, .env files, dart-define, Additional run args in Android Studio/VS Code, or preventing credential leakage in git.
---

# 🔐 Flutter Environment Secrets & Configuration Security

A comprehensive guide and standard practice for securing API keys, sensitive tokens, and environment variables in Flutter applications without exposing secrets in Git or embedding readable files in production builds.

---

## 1. Core Architecture & Philosophy

In Flutter, handling sensitive credentials (API Secrets, Backend URLs, Payment Keys, Cloudinary Secrets) requires strict separation between **Code** and **Configuration**.

### Why `--dart-define-from-file` over Asset `.env` (`flutter_dotenv`)?
- ❌ **`flutter_dotenv` Approach (Insecure):** Packages like `flutter_dotenv` require adding the `.env` file to `pubspec.yaml` assets. When building an APK or IPA, the `.env` file is packaged as a raw asset inside the bundle. Anyone decompressing the APK (`apktool` or `unzip`) can read all secrets in plain text!
- ✅ **Flutter Compile-time Defines (Secure & Zero-Dependency):** Since Flutter 3.16+, Flutter natively supports reading `.env` files (key-value pairs) via the `--dart-define-from-file` flag. The values are injected into Dart code at compile-time as constant binary values (`String.fromEnvironment`), leaving zero loose secret files inside the compiled application package.

---

## 2. File Setup & Git Safety Rules

### 2.1. The Three-File Structure
1. **`.env` (Private - NEVER COMMITTED):**
   - Contains the real secrets and credentials.
   - Resides in the project root directory.
   - Example:
     ```env
     CLOUDINARY_CLOUD_NAME=der5mc1es
     CLOUDINARY_UPLOAD_PRESET=doctor_hunt
     CLOUDINARY_API_KEY=729666688939527
     CLOUDINARY_API_SECRET=I-yhlYVZ1iqXmnPhS_9NuwtEBbA
     ```

2. **`.env.example` (Public Template - COMMITTED):**
   - Serves as documentation for team members and CI/CD pipelines.
   - Contains all required keys with dummy/placeholder values.
   - Example:
     ```env
     CLOUDINARY_CLOUD_NAME=your_cloud_name
     CLOUDINARY_UPLOAD_PRESET=your_preset
     CLOUDINARY_API_KEY=your_api_key
     CLOUDINARY_API_SECRET=your_api_secret_here
     ```

3. **`.gitignore` (Strict Guardrail):**
   - Must ignore all `.env` files while explicitly allowing `.env.example`:
     ```gitignore
     # --- SECURITY & SECRETS ---
     .env
     .env.*
     !.env.example
     env.json
     *.env.json
     ```

---

## 3. Dart Code Implementation

### 3.1. Config Class Pattern
Create an abstract configuration class (e.g., `CloudinaryConfig`, `AppConfig`) in the core network/config directory:

```dart
abstract class CloudinaryConfig {
  static const String cloudName = String.fromEnvironment(
    'CLOUDINARY_CLOUD_NAME',
  );

  static const String uploadPreset = String.fromEnvironment(
    'CLOUDINARY_UPLOAD_PRESET',
  );

  static const String apiKey = String.fromEnvironment(
    'CLOUDINARY_API_KEY',
  );

  static const String apiSecret = String.fromEnvironment(
    'CLOUDINARY_API_SECRET',
  );
}
```

> [!CAUTION]
> **NEVER provide fallback secrets in `defaultValue`!**
> If you write `defaultValue: 'real_secret_here'`, that secret will still be hardcoded and visible in the Git repository! Always leave `defaultValue` empty or omitted for secret keys.

### 3.2. Defensive Service Usage
Always validate credentials before executing requests that require authorization:

```dart
Future<void> deleteImage(String secureUrl) async {
  // Guard check: Avoid making unauthorized requests if credentials are missing
  if (CloudinaryConfig.apiKey.isEmpty || CloudinaryConfig.apiSecret.isEmpty) {
    return;
  }
  
  // Proceed with authorized call
}
```

---

## 4. Execution Commands (Terminal & CI/CD)

### 4.1. Running the App
Pass the `.env` file via `--dart-define-from-file`:
```bash
flutter run --dart-define-from-file=.env
```

### 4.2. Building for Release
```bash
# Android APK
flutter build apk --release --dart-define-from-file=.env

# Android App Bundle (Play Store)
flutter build appbundle --release --dart-define-from-file=.env

# iOS
flutter build ipa --release --dart-define-from-file=.env
```

### 4.3. Multi-Environment Support (Dev / Staging / Prod)
You can maintain separate files for each environment:
- `.env.dev`
- `.env.staging`
- `.env.prod`

Run with the desired target:
```bash
flutter run --dart-define-from-file=.env.dev
flutter run --dart-define-from-file=.env.prod
```

---

## 5. IDE Setup: Adding `--dart-define-from-file` in Run Configurations

To run or debug directly from the IDE (clicking the Green Run ▶ / Debug 🪲 buttons) without typing terminal commands each time:

### 5.1. In Android Studio & IntelliJ IDEA
1. Open the **Run/Debug Configurations** dropdown from the top toolbar (usually shows `main.dart`).
2. Click **Edit Configurations...**
3. Select your Flutter configuration (e.g., `main.dart`).
4. Find the input field labeled:
   **`Additional run args:`** (or **`Additional arguments`**)
5. Add the following parameter:
   ```text
   --dart-define-from-file=.env
   ```
6. Click **Apply**, then **OK**.

*Now every time you press **Run** (Shift+F10) or **Debug** (Shift+F9), Android Studio automatically injects the `.env` variables!*

---

### 5.2. In VS Code
1. Open or create `.vscode/launch.json`.
2. Add the `"args"` property inside your configuration block:
   ```json
   {
     "version": "0.2.0",
     "configurations": [
       {
         "name": "doctor_hunt (dev)",
         "request": "launch",
         "type": "dart",
         "args": [
           "--dart-define-from-file=.env"
         ]
       },
       {
         "name": "doctor_hunt (prod)",
         "request": "launch",
         "type": "dart",
         "args": [
           "--dart-define-from-file=.env.prod"
         ]
       }
     ]
   }
   ```
3. Save the file. Select the configuration in the "Run & Debug" panel (Ctrl+Shift+D) and press **F5**.

---

## 6. Step-by-Step Workflow for Adding New Secrets

Whenever you need to integrate a new third-party service (e.g., Stripe, SendGrid, Agora, Mapbox):

1. **Update `.env.example`:** Add the key names with descriptive placeholders:
   ```env
   STRIPE_PUBLISHABLE_KEY=pk_test_placeholder
   STRIPE_SECRET_KEY=sk_test_placeholder
   ```
2. **Update `.env`:** Add your actual credentials in your local `.env`.
3. **Declare in Dart:** Create or update the config class with `static const String key = String.fromEnvironment('KEY_NAME');`.
4. **Consume in Service/Datasource:** Use the static property directly.
5. **Verify Git Status:** Run `git status` to ensure `.env` remains completely untracked and only `.env.example` is staged.
