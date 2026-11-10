---
name: build-ui-guidelines
description: Use this skill whenever you are asked to build, create, refactor, or style UI components or screens in Flutter. This skill contains strict project rules regarding widget decomposition (standalone widgets vs anti-patterns), reuse of global/core widgets, layout spacing, localization using the slang package, and theming. Always consult this skill to ensure consistency and maintainability when writing Flutter UI code.
---

# UI Construction Guidelines

## Contents
- [Global & Reusable Widgets](#global--reusable-widgets)
- [Widget Decomposition & Architecture](#widget-decomposition--architecture)
- [Layout & Spacing](#layout--spacing)
- [Localization & Text](#localization--text)
- [Colors & Styling](#colors--styling)
- [Assets & Images](#assets--images)
- [State & Hooks Reference](#state--hooks-reference)

---

## Global & Reusable Widgets
* **Check Core First**: Always check `lib/apps/core/widgets/` before building any new UI component (e.g., `MainAppBar`, `AppScaffold`, `ProfileTextFormWidget`, `ProfileSaveButton`, `MainProfileAvatarWidget`, `AppContainerWithShadow`).
* **Reuse or Generalize**:
  * If a widget can be shared across multiple features (e.g., both patient and doctor profile screens), place it in `lib/apps/core/widgets/`.
  * If an existing core widget is almost what you need, make a small adjustment (e.g., adding an optional callback like `onCameraTap` or generic listener) rather than duplicating the entire widget in a feature folder.
* **Keep Core Widgets Decoupled**: Core widgets in `lib/apps/core/widgets/` MUST remain completely independent of feature-specific BLoCs or entities. Accept callbacks or `ValueListenable` instead of consuming feature-specific BLoCs directly.

---

## Widget Decomposition & Architecture

### 1. Strictly Avoid `part` / `part of` Directives
* **Anti-Pattern**: Do **NOT** use `part` / `part of` to split UI screens or helper methods into separate files.
* **Why**: `part` files break auto-import in IDEs, hide dependencies without real decoupling, and hinder widget testing and tree optimizations.
* **Best Practice**: Extract sub-components into **standalone `StatelessWidget` or `HookWidget` classes** in their own dedicated files and use standard `import` statements.

### 2. Encapsulation & Eliminating Parameter Drilling
* **Keep State Where It Belongs**: Do NOT hoist all `TextEditingController`s, `GlobalKey<FormState>`, and form change listeners into the parent screen only to pass 6-8 parameters down to child widgets.
* **Self-Contained Child Widgets**:
  * Forms, headers, or complex sections should own their own controllers, validation logic, and internal state.
  * Pass only the essential domain entity (e.g., `user`) and any shared notifier (e.g., `selectedImageNotifier`) to the child widget.
* **Orchestrator Pattern for Screens**:
  * The main screen (`*Screen`) should be a concise orchestrator (aim for ~60–80 lines).
  * Its responsibility is limited to: page structure (`AppScaffold`), BLoC listener/consumer for global dialogs/navigation, and coordinating top-level extracted widgets.

### 3. File & Directory Placement
* **Feature-Specific Widgets**: Place inside the feature's `widget/` (or `presentation/widget/`) directory (e.g., `patient_profile_form_widget.dart`, `doctor_profile_form_widget.dart`).
* **Shared / Core Widgets**: Place inside `lib/apps/core/widgets/` (e.g., `main_profile_avatar_widget.dart`, `profile_save_button.dart`).

### Reference Architecture Example

```dart
// 1. Core / Shared Widget (lib/apps/core/widgets/main_profile_avatar_widget.dart)
class MainProfileAvatarWidget extends StatelessWidget {
  const MainProfileAvatarWidget({
    super.key,
    required this.user,
    required this.selectedImageNotifier,
    this.onCameraTap,
  });

  final AppUserEntity user;
  final ValueNotifier<File?> selectedImageNotifier;
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) { ... }
}

// 2. Feature-Specific Form Widget (owns its own controllers and formKey)
class DoctorProfileFormWidget extends HookWidget {
  const DoctorProfileFormWidget({
    super.key,
    required this.user,
    required this.selectedImageNotifier,
  });

  final DoctorEntity user;
  final ValueNotifier<File?> selectedImageNotifier;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: user.name);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final hasChanges = useValueNotifier<bool>(false);

    // Form handles its own listeners and uses shared widgets like ProfileSaveButton
    return Form(
      key: formKey,
      child: ListView(
        children: [
          ProfileTextFormWidget(controller: nameController, ...),
          ProfileSaveButton(onPressed: () => _onSave(...), valueListenable: hasChanges),
        ],
      ),
    );
  }
}

// 3. Main Screen (Clean Orchestrator ~60-80 lines)
class DoctorProfileScreen extends HookWidget {
  const DoctorProfileScreen({super.key, required this.user});
  final DoctorEntity user;

  @override
  Widget build(BuildContext context) {
    final selectedImageNotifier = useValueNotifier<File?>(null);

    return BlocListener<DoctorProfileBloc, DoctorProfileState>(
      listener: (context, state) {
        // Handles loading, error, success dialogs, and navigation
      },
      child: AppScaffold(
        body: Column(
          children: [
            MainAppBar(title: t.profile.title),
            MainProfileAvatarWidget(
              user: user,
              selectedImageNotifier: selectedImageNotifier,
              onCameraTap: () => context.read<DoctorProfileBloc>().add(const PickImageRequested()),
            ),
            Expanded(
              child: DoctorProfileFormWidget(
                user: user,
                selectedImageNotifier: selectedImageNotifier,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Layout & Spacing
* **Flex Widgets (`Row`, `Column`)**: 
  * Use the `spacing` property on `Row` and `Column` for uniform spacing between all child elements.
  * *Example*: `Column(spacing: 15, children: [ ... ])`
* **Custom Spacing**: If spacing between elements is NOT uniform, use `SizedBox` (e.g., `SizedBox(height: 12)`, `SizedBox(width: 8)`) instead of the `spacing` property.

---

## Localization & Text
* **No Hardcoded Text**: Hardcoded user-visible strings are strictly prohibited.
* **Slang Package**: Utilize the `slang` package for localization.
* All text strings MUST be added to `assets/i18n/en.i18n.json` and accessed via the global translation getter `t`.
* *Example*: `Text(t.admin.doctors_tab.add_doctor)`

---

## Colors & Styling
* **No Hardcoded Colors**: Avoid using raw `Color(0xFF...)` or `Colors.red` directly in widgets.
* **App Colors**: All colors must be sourced from the central theme file `lib/apps/core/theme/app_colors.dart` (e.g., `AppColors.brandPrimary`).
* **Typography**: Utilize the generated style atom extensions on `BuildContext` for text styling.
* *Example*: `style: context.regular12.white.rubik`

---

## Assets & Images
* **No Direct Asset Paths**: Never use raw string paths (e.g., `'assets/images/logo.png'`).
* **App Assets**: All image and asset paths must be sourced from the generated `lib/generated/app_assets.dart` file.
* *Example*: `Image.asset(AppAssets.imagesDoctor1)`

---

## State & Hooks Reference
* **State Management**: For all local state, lifecycle hooks, and controllers, follow the dedicated guidelines in `skills/flutter-hooks/SKILL.md`.
* **BLoC / Business Logic**: Keep business logic completely separated inside BLoCs; the UI layer only dispatches events and reacts to states.
