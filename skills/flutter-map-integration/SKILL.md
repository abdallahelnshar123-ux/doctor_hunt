---
name: flutter-map-integration
description: Use this skill whenever integrating maps, location selection/picker, GPS coordinates, geocoding, reverse geocoding, or turn-by-turn navigation in a Flutter project using flutter_map, OpenStreetMap (OSM), geolocator, and geocoding. Also MUST be triggered when diagnosing or fixing Android Gradle build errors associated with location/map packages, such as geocoding_android compileSdk incompatibilities (AAR metadata failure), permission_handler CINNAMON_BUN / ACCESS_LOCAL_NETWORK API 37 compilation errors, or Gradle Project.afterEvaluate lifecycle exceptions.
---

# 🗺️ Flutter Map & Location Integration - Best Practices & Architectural Skill

A production-grade guide for implementing 100% free, zero-API-key, zero-billing interactive maps, location pickers, GPS positioning, reverse geocoding, and external turn-by-turn navigation in Flutter applications.

---

## 1. Core Philosophy & Package Ecosystem

To avoid Google Maps Platform API billing, credit card requirements, and restricted API keys, this architecture relies entirely on pure Flutter rendering and native device services:

| Package | Role | Key Benefit |
| :--- | :--- | :--- |
| **`flutter_map`** | Interactive canvas rendering OpenStreetMap (OSM) tiles | 100% Free, no API keys, smooth widget-tree integration |
| **`latlong2`** | Mathematical coordinate models (`LatLng`, distance, bounds) | Lightweight, standard for Flutter mapping |
| **`geolocator`** | Hardware GPS integration (detect current device position) | Device native, highly accurate, permission-aware |
| **`geocoding`** | Reverse geocoding (Coordinates $\rightarrow$ Human-readable address) | Device native geocoder (no server billing) |
| **`url_launcher`** | Launches external navigation apps (Google Maps / Apple Maps) | Delegates routing/turn-by-turn to native apps |

---

## 2. Platform Native Setup & Permissions

### 2.1. Android (`android/app/src/main/AndroidManifest.xml`)
Add location permissions and intent query definitions inside `<manifest>`:

```xml
<!-- Hardware Location Permissions -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<!-- Intent Queries for Native Maps & Web Browser Fallback -->
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="geo" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

### 2.2. iOS (`ios/Runner/Info.plist`)
Add usage descriptions and URL query schemes inside `<dict>`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app requires location access to set your clinic location or find nearby clinics.</string>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>comgooglemaps</string>
    <string>baidumap</string>
    <string>iosamap</string>
    <string>waze</string>
    <string>maps</string>
</array>
```

---

## 3. ⚠️ Critical Android Gradle Pitfalls & Compatibility Rules

When combining `flutter_map`, `geocoding`, and `permission_handler` on modern Flutter / Android Gradle Plugin (AGP 8+ / 9+), several build collisions can happen. Follow these rules strictly:

### 3.1. The `geocoding_android` AAR Metadata Error
* **Problem**: `:geocoding_android` is hardcoded internally to `compileSdk = 33`, but modern AndroidX dependencies (e.g. `androidx.fragment:1.7.1`, `androidx.activity:1.8.1`, `androidx.core:1.13.1`) enforce `compileSdk >= 34`. Gradle fails with `Execution failed for task ':geocoding_android:checkDebugAarMetadata'`.
* **Fix**: Force all subprojects/plugins to use modern `compileSdk = 37`.

### 3.2. Modern AGP (8+ / 9+) Reflection Signature
* In modern AGP versions, `compileSdkVersion(int)` does not exist on `CommonExtension`. Instead, the setter is `setCompileSdk(Integer)`.
* Reflection code must check for both `setCompileSdk` and `compileSdkVersion`:
  ```kotlin
  val method = android.javaClass.methods.firstOrNull {
      it.name in listOf("setCompileSdk", "compileSdkVersion") && it.parameterTypes.size == 1
  }
  method?.invoke(android, 37)
  ```

### 3.3. Avoiding the `Project.afterEvaluate` Lifecycle Crash
* In `android/build.gradle.kts`, `subprojects { project.evaluationDependsOn(":app") }` evaluates `:app` early.
* Calling `afterEvaluate` on an already-evaluated project throws: `Cannot run Project.afterEvaluate(Action) when the project is already evaluated`.
* **Fix**: Exclude `:app` and verify `project.state.executed`:

```kotlin
// In android/build.gradle.kts:
subprojects {
    if (project.name != "app") {
        val configureAndroid: () -> Unit = {
            val android = project.extensions.findByName("android")
            if (android != null) {
                try {
                    val method = android.javaClass.methods.firstOrNull {
                        it.name in listOf("setCompileSdk", "compileSdkVersion") && it.parameterTypes.size == 1
                    }
                    method?.invoke(android, 37)
                } catch (_: Exception) {}
            }
        }

        if (project.state.executed) {
            configureAndroid()
        } else {
            project.afterEvaluate {
                configureAndroid()
            }
        }
    }
}
```

```kotlin
// In android/settings.gradle.kts:
gradle.lifecycle.beforeProject {
    if (name != "app") {
        plugins.withId("com.android.library") {
            val android = extensions.findByName("android")
            if (android != null) {
                try {
                    val method = android.javaClass.methods.firstOrNull {
                        it.name in listOf("setCompileSdk", "compileSdkVersion") && it.parameterTypes.size == 1
                    }
                    method?.invoke(android, 37)
                } catch (e: Exception) {
                    // Ignore if method not found
                }
            }
        }
    }
}
```

### 3.4. `permission_handler_android: 14.1+` API 37 (`CINNAMON_BUN`) Requirement
* Recent versions of `permission_handler_android` reference Android 17 / API 37 symbols (`Manifest.permission.ACCESS_LOCAL_NETWORK` and `Build.VERSION_CODES.CINNAMON_BUN`).
* **DO NOT** force subprojects to 34 or 35; you **MUST use `compileSdk = 37`** so both `permission_handler` and `geocoding` build seamlessly.

---

## 4. ⚠️ Geocoding v5.0+ Breaking Change

In `geocoding >= 5.0.0`, all standalone top-level functions (like `placemarkFromCoordinates(...)`) were removed. Geocoding methods are now **instance methods** on the `Geocoding` class:

```dart
// ❌ FAILS in geocoding 5.0+
final placemarks = await placemarkFromCoordinates(latitude, longitude);

// ✅ REQUIRED in geocoding 5.0+
final placemarks = await Geocoding().placemarkFromCoordinates(
  latitude,
  longitude,
);
```

---

## 5. Architectural Pattern: Decoupled Location Picker

Place the interactive location picker under `lib/apps/features/common/clinic_location_picker/` so it remains completely independent of business entities (such as `DoctorDto` or Firestore).

### 5.1. DTO / Model (`location_result_model.dart`)
```dart
class LocationResultModel extends Equatable {
  final double latitude;
  final double longitude;
  final String? address;

  const LocationResultModel({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, address];
}
```

### 5.2. Service Layer (`location_service.dart`)
Wraps GPS checks, permission requests, and geocoding:
```dart
@lazySingleton
class LocationService {
  const LocationService();

  Future<bool> isLocationServiceEnabled() => Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  Future<LocationPermission> requestPermission() => Geolocator.requestPermission();

  Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 12),
      ),
    );
  }

  Future<String?> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final placemarks = await Geocoding().placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isEmpty) return null;

      final place = placemarks.first;
      final parts = <String>[];
      if (place.street?.isNotEmpty == true) parts.add(place.street!.trim());
      if (place.subLocality?.isNotEmpty == true && !parts.contains(place.subLocality)) {
        parts.add(place.subLocality!.trim());
      }
      if (place.locality?.isNotEmpty == true && !parts.contains(place.locality)) {
        parts.add(place.locality!.trim());
      }
      if (place.country?.isNotEmpty == true && !parts.contains(place.country)) {
        parts.add(place.country!.trim());
      }
      return parts.isNotEmpty ? parts.join(', ') : null;
    } catch (_) {
      return null; // Graceful fallback
    }
  }
}
```

### 5.3. BLoC Concurrency & `emit.isDone` Safety Rule
* **Unawaited `result.fold` Pitfall**: When working with `dartz` `Either`, if the closure is `async`, you **MUST prefix with `await`**:
  ```dart
  // ❌ BAD: result.fold returns unawaited Future, causing handler to complete early
  result.fold((f) => emit(...), (pos) async { await fetchAddress(...); });

  // ✅ GOOD: Awaits the async fold closure
  await result.fold((f) async => emit(...), (pos) async { await fetchAddress(...); });
  ```
* **Guarding against canceled handlers**: In debounced map dragging (`switchMap`), previous handlers get canceled. Always check `if (!emit.isDone)` before emitting:
  ```dart
  if (!emit.isDone) {
    emit(state.copyWith(isAddressLoading: false));
  }
  ```

### 5.4. UX Best Practice: Fixed Center Pin with Camera Drag
Instead of placing markers upon tapping, use a **fixed pin at the center of the screen** over the map:
1. Moving the map fires `onPositionChanged(MapCamera camera, bool hasGesture)`.
2. When `hasGesture` becomes false, trigger a debounce timer (~600ms) to reverse-geocode `camera.center`.
3. Provide a floating "Locate Me" button that animates the camera to `currentPosition`.
4. Provide a bottom sheet showing the detected address with a "Confirm Location" button.

---

## 6. Mini Map Preview Card & Scroll Conflict Prevention

When embedding a read-only map inside a scrollable screen (such as `DoctorDetailsScreen`):

### 6.1. Disable Gestures
Set `interactionOptions` to `InteractiveFlag.none` so finger swipes scroll the page instead of getting trapped in the map:
```dart
FlutterMap(
  options: MapOptions(
    initialCenter: LatLng(latitude, longitude),
    initialZoom: 15.0,
    interactionOptions: const InteractionOptions(
      flags: InteractiveFlag.none, // 👈 CRITICAL: Prevents scroll conflict
    ),
  ),
  children: [
    TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.app',
    ),
    MarkerLayer(
      markers: [
        Marker(
          point: LatLng(latitude, longitude),
          width: 40,
          height: 40,
          child: const Icon(Icons.location_on, color: Colors.red, size: 38),
        ),
      ],
    ),
  ],
)
```

### 6.2. Empty State
If the location is not set (`latitude == null`), display an elegant fallback card:
> *"Clinic location not set yet"* (`t.clinic_location.location_not_set`)

---

## 7. External Navigation Intent Utility (`map_launcher_utils.dart`)

To give users turn-by-turn navigation without paying for routing SDKs, launch the device's native map application with a web fallback:

```dart
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class MapLauncherUtils {
  MapLauncherUtils._();

  static Future<bool> openMapDirections({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    final query = Uri.encodeComponent(label ?? '$latitude,$longitude');
    
    // 1. Platform-native URI Scheme
    final nativeUri = Platform.isIOS
        ? Uri.parse('maps://?q=$query&ll=$latitude,$longitude')
        : Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude($query)');

    if (await canLaunchUrl(nativeUri)) {
      return await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
    }

    // 2. Universal Web Fallback (Google Maps Web)
    final webUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );
    if (await canLaunchUrl(webUri)) {
      return await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }

    return false;
  }
}
```

---

## 8. Edge Cases & Defensive Checklist

| Edge Case | Solution |
| :--- | :--- |
| **User cancels picker** | Pop with `null`: `Navigator.pop(context, null)`. Do not modify existing state. |
| **User clears location** | Provide "Remove Location" button. Pop with empty model or trigger clear callback to delete `latitude`/`longitude` in Firestore. |
| **GPS disabled on device** | Check `isLocationServiceEnabled()`. If false, prompt user to enable GPS; keep manual map dragging enabled. |
| **Permission denied** | Show informative SnackBar; fallback to default city center; allow manual dragging. |
| **Permanently denied** | Show dialog with `openAppSettings()` button. |
| **Geocoding failure** | Do not block save! Store coordinates; let user manually type clinic address in a fallback text field. |
| **Tile loading failure / Offline** | Configure `errorTileCallback` on `TileLayer` to avoid white screens. |
