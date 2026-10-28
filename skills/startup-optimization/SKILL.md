---
name: startup-optimization
description: Use this skill whenever the user mentions optimizing app startup speed, slow launch times, "Instant Launch", or fixing the initial loading delay in a Flutter application. It contains critical checks for font loading, dependency injection, routing race conditions, and native splash screens. Make sure to use this skill anytime the user complains about the app taking too long to open, even if they don't explicitly say "startup optimization."
---

# Flutter App Startup Optimization

A checklist of common architectural, network, and rendering bottlenecks that delay the first frame in Flutter apps, along with their solutions.

## Core Checks & Solutions

### 1. Fonts Loading (`google_fonts` vs Local Fonts)
**🔴 Problem:** Using the `google_fonts` package without bundling the font assets locally can cause the app to freeze while fetching font files from the internet during the initial render (especially on slow networks).
**✅ Solution:** Explain that fonts should be local. 
- Remove the `google_fonts` package.
- Download the required `.ttf` or `.otf` files.
- Place them in `../../assets/fonts` and register them explicitly in `../../pubspec.yaml` under the `fonts:` section.
- Update `ThemeData(fontFamily: 'YourFont')` and any TextStyles to use the local font family directly.

### 2. Local Storage Initialization (Dependency Injection)
**🔴 Problem:** Incorrectly registering `SharedPreferences` (or similar local storage) in DI can lead to it being treated as a `factoryAsync` instead of a persistent singleton, causing unnecessary asynchronous overhead.
**✅ Solution:** Explain how `injectable` handles async dependencies.
- Ensure that asynchronous dependencies like `SharedPreferences` use BOTH `@preResolve` AND `@singleton`. This guarantees they are awaited exactly once before `runApp()` and cached in memory.

### 3. Eager vs Lazy Initialization of Heavy Services
**🔴 Problem:** Registering native SDKs (e.g., `FirebaseAuth`, `FirebaseFirestore`, `GoogleSignIn`) as `@singleton` forces them to initialize their native channels immediately. If they are injected into the Router or a global Bloc, they block `runApp()`.
**✅ Solution:** Explain the benefit of lazy loading for startup time.
- Mark these heavy services as `@lazySingleton`. This ensures they are only instantiated when the user actually triggers a feature that needs them, significantly reducing the initial CPU load.

### 4. Router & Auth State Race Conditions
**🔴 Problem:** If `GoRouter` or the initial AuthBloc relies on an *asynchronous* event (e.g., `add(CheckAuthStatusRequested())`) to determine the starting screen, the app state will initially be "Unknown". This causes erroneous redirects (e.g., showing the Login screen briefly before jumping to Home) and visual delays.
**✅ Solution:** Emphasize synchronous initial state reads.
- Read the cached user session **synchronously** from `SharedPreferences` directly inside the constructor of your Session Manager (e.g., `UserSessionManager`).
- Set the initial state of your `AuthBloc` and the initial redirect logic of your `GoRouter` based on this *synchronous* value, entirely avoiding the asynchronous gap.

### 5. Native Splash Screen Management
**🔴 Problem:** Leaving the native splash screen to the OS's default behavior can cause artificial delays or ungraceful transitions to the Flutter UI.
**✅ Solution:**
- Use the `flutter_native_splash` package.
- Call `FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);` immediately after `WidgetsFlutterBinding.ensureInitialized();` in `main.dart`.
- Perform your `await` setups (like Firebase and DI).
- Call `FlutterNativeSplash.remove();` immediately before `runApp()`.

### 6. Expensive Background Rendering (Repaint Boundaries)
**🔴 Problem:** Heavy, static backgrounds (like large `RadialGradient` shapes, massive vectors, or complex shadows) placed in root scaffolds are continuously repainted when overlaying animations (like loaders) occur during startup.
**✅ Solution:**
- Wrap expensive, static background UI elements in a `RepaintBoundary` widget to cache their rasterization on the GPU.

### 7. Profiling & Build Mode
**🔴 Problem:** Evaluating or debugging startup performance in Debug mode.
**✅ Solution:**
- Always test and measure startup speed using `flutter run --release` or `--profile`. Debug mode uses JIT (Just-In-Time) compilation and includes heavy debugging tools, making it fundamentally unrepresentative of real-world app startup speed (AOT).
