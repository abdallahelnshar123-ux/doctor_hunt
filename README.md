# Doctor Hunt 🩺 — Medical Ecosystem

> A production-grade medical appointment booking and doctor management platform.  
> Designed to connect patients with healthcare professionals seamlessly.

---

## 🎬 Demo Videos

See the app in action — exploring both the patient booking flow and the admin management dashboard:

### 👨‍⚕️ Admin Role
https://github.com/user-attachments/assets/75a16d70-19a6-4c7b-92b6-7eb4ce5459ca

### 🏥 Patient Role
https://github.com/user-attachments/assets/75a16d70-19a6-4c7b-92b6-7eb4ce5459ca

---

## 🧠 What Is Doctor Hunt?

Doctor Hunt is a **comprehensive mobile platform** that allows patients to find doctors and book appointments, while allowing administrators to manage the medical directory — all from a single Flutter application.

The platform supports **two distinct user roles** built within the same codebase:

| Role | Who Uses It | Purpose |
|---|---|---|
| **Patient** | Users/Patients | Browse specialties, search for doctors, book appointments, and chat. |
| **Admin** | System Managers | Add new doctors, update doctor profiles, and manage the system. |

Both roles connect to a **Firebase** backend for real-time data sync, authentication, and structured database management.

---

## 🏆 Project Highlights

This project was built with a strong focus on clean architecture, type safety, and scalability. 

### Core Technical Achievements
- ✅ Designed and implemented a **Feature-First Layered Architecture**.
- ✅ Enforced strict **Functional Error Handling** across all layers using `dartz` (`Either<Failure, T>`).
- ✅ Implemented **Type-Safe Routing** using `go_router_builder`.
- ✅ Managed complex dependency graphs using **Code-Generated DI** (`get_it` + `injectable`).
- ✅ Created a shared **Design System** utilizing atomic typography extensions.
- ✅ Integrated a fully **Type-Safe Localization** system using `slang`.
- ✅ Handled remote media and image processing via the **Cloudinary API**.

---

## ✨ Key Features

### Patient Flow
- 🔍 **Doctor Discovery** — browse and search for doctors by categories, names, or specialties.
- 📅 **Appointment Booking** — seamless flow to schedule appointments with selected healthcare providers.
- ❤️ **Favorites System** — save preferred doctors for quick and easy access later.

### Admin Flow
- 👨‍⚕️ **Doctor Onboarding** — securely add new doctors with complete profiles, specialties, and images.
- 📝 **Profile Management** — update and manage existing doctors' details.
- ⚙️ **System Configuration** — dedicated settings and control panels for administrators.

---

## 🛠️ Tech Stack

### Mobile — Flutter / Dart

| Layer | Technology | Purpose |
|---|---|---|
| **State Management** | BLoC (`flutter_bloc`) + Hooks | Predictable state streams and local UI state management |
| **Navigation** | GoRouter + Builder | Type-safe, declarative routing (`@TypedGoRoute`) |
| **Dependency Injection** | GetIt + Injectable | Code-generated service locator |
| **Localization** | Slang | Type-safe i18n JSON translations |
| **Error Handling** | Dartz | Functional programming data types (`Either`, `Left`, `Right`) |
| **Local Storage** | Shared Preferences + Secure Storage | Session persistence and secure token storage |
| **Image Uploads** | Cloudinary API | Remote image hosting and transformation |

### Backend / BaaS — Firebase

| Technology | Purpose |
|---|---|
| **Firebase Auth** | User authentication (Email/Password & Google Sign-In) |
| **Cloud Firestore** | NoSQL database for users, doctors, and appointments |
| **Firebase Core** | Essential Firebase initialization and configuration |

---

## 📐 Architecture

### Why Feature-First?

The project uses a **feature-first architecture** (pragmatic layered approach). Each feature owns its Data and Presentation layers. This makes features independently navigable, testable, and scalable without the strict overhead of an isolated Domain layer.

```text
lib/
 ├── apps/
 │    ├── core/                   # Shared design system & infrastructure
 │    │    ├── constants/         # App-wide constants (e.g. FirestoreConstants)
 │    │    ├── data/              # Core models, user prefs, base services
 │    │    ├── di/                # Injectable configurations
 │    │    ├── exceptions/        # Custom AppException hierarchy
 │    │    ├── failure/           # Dartz Failure models (ServerFailure, etc.)
 │    │    ├── router/            # Type-safe GoRouter setup
 │    │    ├── theme/             # AppTheme, Colors, Typography
 │    │    └── widgets/           # Reusable core UI components
 │    │
 │    └── features/
 │         ├── patient/           # All patient-facing features
 │         │    ├── home_tab/
 │         │    ├── browse_tab/
 │         │    ├── appointment_screen/
 │         │    └── ...
 │         │
 │         ├── admin/             # All admin-facing features
 │         │    ├── admin_main_screen/
 │         │    ├── add_doctor_screen/
 │         │    └── ...
 │         │
 │         └── common/            # Features shared across both roles (Auth, Splash)
 │
 ├── generated/                   # Code-generated files (slang i18n, assets, atoms)
 └── main.dart
```

### State Management & Data Pattern

Every feature strictly follows this unidirectional data flow utilizing BLoC and Dartz:

```text
UI (HookWidget / StatelessWidget)
  └── BlocBuilder / BlocListener      ← Reacts to state changes
        ├── emit(LoadingState)        ← Shows loaders/shimmers
        ├── emit(ErrorState)          ← Triggers DialogUtils / SnackBarUtils
        └── emit(SuccessState)        ← Renders feature data

BLoC / Cubit (Controller)
  └── Calls Repository                ← Business logic handler
        ├── Awaits Future<Either<Failure, Data>>
        └── Folds the Either to emit proper State

Repository (Data Layer)
  └── Catches AppExceptions           ← Uses try/catch
        ├── Returns Left(Failure)     ← If an exception occurs
        └── Returns Right(Data)       ← If service call succeeds

Service / Datasource
  └── Firebase / Cloudinary           ← Throws AppException on fail
```

---

## 🎨 Design System

A customized design system ensures consistency across the app, heavily relying on code generation and extensions:

- **Colors:** Managed via `AppColors` — strictly no hardcoded hex values in UI files.
- **Typography Atoms:** Uses a generated `style_atoms.dart` extension on `BuildContext` (e.g., `context.medium18.white.rubik`).
- **Assets:** Type-safe image and icon references generated via `flutter_assets_generator` (e.g., `AppAssets.imagesDoctor1`).
- **Core Widgets:** Standardized components like `AppScaffold`, `CustomTextFormField`, etc.

---

## 📝 Notes

- This project was developed as a graduation project for the Flutter Internship program at **Code Plus**.
- All architecture decisions, clean code principles, and UI/UX integrations were implemented to meet production-grade standards.
#