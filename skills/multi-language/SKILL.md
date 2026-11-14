---
name: multi-language
description: Use this skill whenever the user mentions multi-language support, internationalization, localization, i18n, Arabic support, language switching, typography tokens for languages, or SearchUtils in Flutter. It covers the full-stack architecture framework vs domain localization engines (such as Slang), zero-overhead startup with intl, dynamic semantic font tokens, PopupMenu language switching, Arabic search normalization, and dual-language database fallbacks.
---

# 🌐 Flutter Multi-Language (Localization & Arabic) Architecture - Master Skill

You are an expert Flutter engineer. When implementing or expanding multi-language support (such as Arabic and English) in a Flutter application, you MUST follow this proven, full-stack architectural guide.

---

## 1. Architectural Overview & Separation of Concerns

Multi-language in production is not just text translation. It touches six interconnected layers:
1. **Framework Layer (`flutter_localizations`):** Translates Flutter's built-in SDK widgets (DatePickers, TimePickers, context menus, tooltips).
2. **Domain Translation Engine (e.g., `slang`):** Translates app-specific business copy, errors, and labels with type-safety and global access.
3. **Startup & Date Formatting (`intl`):** Formats dates, times, and relative days with zero-overhead launch performance.
4. **Dynamic Typography (Style Atoms):** Decouples fonts from `ThemeData` so fonts switch dynamically based on active language without touching existing UI code.
5. **Persistence & UI Switching (`PopupMenuButton`):** Persists locale in local storage (`UserPrefs`) and allows instant in-app switching without app restarts.
6. **Search & Data Normalization (`SearchUtils`):** Handles language-specific search challenges (such as Arabic diacritics and letter variants).

---

## 2. Layer 1: Framework vs Translation Engine (`slang` Case)

### 🔴 The Essential Rule
* `slang` handles domain text (`t.someKey`), but **DOES NOT** translate internal Flutter framework elements.
* Without `flutter_localizations`, switching to Arabic (`ar`) will crash at runtime:
  `A MaterialLocalizations delegate that supports the locale "ar" was not found.`

### ✅ App Entry Point Wiring (`lib/main.dart`)
Ensure `MaterialApp.router` (or `MaterialApp`) wires both the framework delegates and the translation engine:
```dart
MaterialApp.router(
  locale: TranslationProvider.of(context).flutterLocale,
  supportedLocales: AppLocaleUtils.supportedLocales,
  localizationsDelegates: GlobalMaterialLocalizations.delegates,
  theme: AppTheme.lightTheme,
  routerConfig: appRouter,
);
```

### ⚙️ Slang-Specific Best Practices
- **Strict Generation CLI:** NEVER use `build_runner` for Slang; it generates conflicts and duplicate folders. ALWAYS use:
  ```bash
  dart run slang
  ```
- **JSON Key Casing:** Always use `snake_case` in `.i18n.json` files (`welcome_back`, `phone_number`).
- **Interfaces:** Use `(interface=PageData)` directly inside JSON for lists of polymorphic items (e.g. Onboarding).
- **Lazy Loading:** Keep `lazy: true` in `slang.yaml` so non-active languages are deferred and do not bloat startup memory.
- **Completeness Check:** Run `dart run slang analyze --full` and verify `_missing_translations.json` is empty for all locales.

---

## 3. Layer 2: Zero-Overhead Startup & Dates Localization (`intl`)

### 🔴 Problem
Formatting dates in non-English locales (e.g. `DateFormat('d MMM', 'ar')`) throws a fatal `LocaleDataException` if `initializeDateFormatting()` was not called. Running it sequentially delays the first frame.

### ✅ Solution: Concurrency Pattern
1. **Parallelize with Firebase:** In `main()`, run `initializeDateFormatting()` concurrently with `Firebase.initializeApp()` inside `Future.wait` for **0ms perceived delay**:
   ```dart
   await Future.wait([
     Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
     initializeDateFormatting(),
   ]);

   // Run DI sequentially afterwards to prevent Firebase race conditions
   await configureDependencies();
   ```
2. **Synchronize Global Locale Stream:** Set `Intl.defaultLocale` from saved preferences and listen to Slang's stream:
   ```dart
   final savedLanguage = getIt<UserPrefs>().getSavedLanguage();
   LocaleSettings.setLocaleRaw(savedLanguage);
   Intl.defaultLocale = savedLanguage;
   LocaleSettings.getLocaleStream().listen((locale) {
     Intl.defaultLocale = locale.languageCode;
   });
   ```
3. **Relative Dates Formatter:** In utilities like `DateFormatterUtils`, never hardcode "Today" or "Tomorrow". Always interpolate translation keys:
   ```dart
   if (targetDate == today) {
     return '${t.common.today}, $formattedDate';
   } else if (targetDate == tomorrow) {
     return '${t.common.tomorrow}, $formattedDate';
   }
   ```

---

## 4. Layer 3: Dynamic Semantic Typography (Style Atoms)

### 🔴 Problem with Theme-Based Font Switching
Switching fonts via `ThemeData(fontFamily: ...)` forces app-wide theme recreation and fails when screens use hardcoded font extensions like `context.medium14.white.rubik`. Modifying 600+ UI files is error-prone.

### ✅ Solution: Centralized Semantic Tokens in `generate_styles.dart`
1. **Generate Semantic Tokens:** In `generate_styles.dart`, generate `fontPrimary` and `fontSecondary` that inspect `LocaleSettings.currentLocale` synchronously:
   ```dart
   extension FontFamilyAtoms on TextStyle {
     /// Primary font: dynamically resolves to Cairo for Arabic and Rubik for other languages
     TextStyle get fontPrimary {
       final isArabic = LocaleSettings.currentLocale == AppLocale.ar;
       return copyWith(
         fontFamily: isArabic ? 'Cairo' : 'Rubik',
         fontFamilyFallback: const ['Cairo', 'Rubik'],
       );
     }

     /// Secondary font: dynamically resolves to Cairo for Arabic and PlusJakartaSans for other languages
     TextStyle get fontSecondary {
       final isArabic = LocaleSettings.currentLocale == AppLocale.ar;
       return copyWith(
         fontFamily: isArabic ? 'Cairo' : 'PlusJakartaSans',
         fontFamilyFallback: const ['Cairo', 'PlusJakartaSans'],
       );
     }

     // Aliases for 100% backward compatibility with existing code:
     TextStyle get rubik => fontPrimary;
     TextStyle get plusJakartaSans => fontSecondary;
     TextStyle get cairo => copyWith(fontFamily: 'Cairo');
   }
   ```
2. **Zero-Code-Change for Existing UI:** All existing calls to `.rubik` immediately switch to Cairo in Arabic without modifying a single screen.
3. **Keep `AppTheme` Simple:** Revert `AppTheme.lightTheme` to a static `ThemeData` with only `fontFamilyFallback: const ['Cairo']` as a passive safety net for system dialogs/tooltips.
4. **Local Fonts Only:** Download `.ttf` files to `assets/fonts/` (e.g. `Cairo-VariableFont_wght.ttf`) and register them in `pubspec.yaml`. Never rely on `google_fonts` network requests.

---

## 5. Layer 4: UI Language Switcher & Persistence

### ✅ Implementation Pattern
1. **Local Storage:** Store language code in `SharedPreferences` via `UserPrefs`:
   ```dart
   Future<void> setLanguage(String code) => _preferences.setString('app_language_code', code);
   String getSavedLanguage() => _preferences.getString('app_language_code') ?? 'en';
   ```
2. **Reusable Popup Menu (`LanguagePickerPopupMenu`):**
   * Use a `PopupMenuButton<AppLocale>` wrapping the trigger widget.
   * Display available languages (`English`, `العربية`) with a checkmark on the selected one.
   * On selection:
     ```dart
     await getIt<UserPrefs>().setLanguage(newLocale.languageCode);
     LocaleSettings.setLocale(newLocale);
     Intl.defaultLocale = newLocale.languageCode;
     ```
   * Integrate the widget in settings screens across all user roles (Patient, Doctor, Admin).
3. **Startup Restoration:** In `main()`, read `getSavedLanguage()` before `runApp()` and apply with `LocaleSettings.setLocaleRaw(savedLang)` before `FlutterNativeSplash.remove()`.

---

## 6. Layer 5: Smart Search & Arabic Normalization (`SearchUtils`)

### 🔴 Problem
Arabic text search frequently fails because users type variations without diacritics or standard letters (e.g. "احمد" vs "أحمد", "فاطمه" vs "فاطمة", "علي" vs "على").

### ✅ Solution: Dedicated `SearchUtils`
Route all search and filter operations through a normalized matching utility:
```dart
class SearchUtils {
  SearchUtils._();

  static String normalize(String text) {
    if (text.isEmpty) return '';
    return text
        .toLowerCase()
        // Strip Arabic diacritics (Harakat / Tashkeel)
        .replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '')
        // Normalize Alef variants (أ, إ, آ, ٱ -> ا)
        .replaceAll(RegExp(r'[أإآٱ]'), 'ا')
        // Normalize Teh Marbuta to Heh (ة -> ه)
        .replaceAll('ة', 'ه')
        // Normalize Alef Maksura to Yeh (ى -> ي)
        .replaceAll('ى', 'ي')
        .trim();
  }

  static bool matches(String? source, String? query) {
    if (query == null || query.trim().isEmpty) return true;
    if (source == null || source.trim().isEmpty) return false;
    return normalize(source).contains(normalize(query));
  }
}
```

### ✅ Multi-Field BLoC Search
In BLoC queries, match against both the localized string and raw backend language fields:
```dart
doctors.where((doctor) {
  return SearchUtils.matches(doctor.name, query) ||
      SearchUtils.matches(doctor.specialty.localizedName(), query) ||
      SearchUtils.matches(doctor.specialty.en, query) ||
      SearchUtils.matches(doctor.specialty.ar, query);
}).toList();
```

---

## 7. Layer 6: Backend & Dual-Language Safe Fallbacks

When models store multilingual fields from Firestore (e.g. `ar` and `en`), implement two-way fallback in `localizedName()`:
```dart
String localizedName() {
  if (LocaleSettings.currentLocale.languageCode == 'ar') {
    return ar.trim().isNotEmpty ? ar : en;
  }
  return en.trim().isNotEmpty ? en : ar;
}
```
This guarantees that if backend records contain only one language, the UI never renders an empty string.

---

## 8. QA & Release Checklist

Before marking multi-language features complete:
- [ ] Run `dart run slang analyze --full` to verify 0 missing keys (`"ar": {}`).
- [ ] Run `dart analyze` to ensure zero compilation or type errors.
- [ ] Test language switching via `LanguagePickerPopupMenu` to verify instant re-render without app restart.
- [ ] Test cold restart to verify language persists from local storage.
- [ ] Verify that DatePickers and date cards show localized months and relative days ("اليوم", "غداً").
- [ ] Test search with and without Arabic diacritics/Alef variants using `SearchUtils`.
