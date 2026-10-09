---
name: build-ui-guidelines
description: Guidelines for building UI components in the Flutter project. Follow these rules for consistency, performance, and maintainability.
---

# UI Construction Guidelines

## Contents
- [State & Hooks](#state--hooks)
- [Layout & Spacing](#layout--spacing)
- [Localization & Text](#localization--text)
- [Colors & Styling](#colors--styling)
- [Assets & Images](#assets--images)
- [Widget Decomposition](#widget-decomposition)

## State & Hooks
* **Flutter Hooks**: Always refer to `.agent/skills/flutter_hooks_guidelines.md` when managing local state in UI components. Prefer `HookWidget` over `StatefulWidget` for managing controllers (e.g., `TextEditingController`, `AnimationController`) or simple state (`useState`).
* Maintain clean business logic by keeping it out of the UI layer. Use the state management solution already established in the project (e.g., `bloc` or `cubit`), or follow whatever specific state management approach the user requests for the task.

## Layout & Spacing
* **Flex Widgets (`Row`, `Column`)**: 
  * Use the `spacing` property on `Row` and `Column` for uniform spacing between all child elements.
  * *Example*: `Column(spacing: 15, children: [ ... ])`
* **Custom Spacing**: If the spacing between elements is NOT uniform, use `SizedBox` (e.g., `SizedBox(height: 12)`, `SizedBox(width: 8)`) instead of the `spacing` property.

## Localization & Text
* **No Hardcoded Text**: Hardcoded user-visible strings are strictly prohibited.
* **Slang Package**: Utilize the `slang` package for localization.
* All text strings MUST be added to `assets/i18n/en.i18n.json` and accessed via the global translation getter `t`.
* *Example*: `Text(t.admin.doctors_tab.add_doctor)`

## Colors & Styling
* **No Hardcoded Colors**: Avoid using raw `Color(0xFF...)` or `Colors.red` directly in widgets.
* **App Colors**: All colors must be sourced from the central theme file `lib/apps/core/theme/app_colors.dart` (e.g., `AppColors.brandPrimary`).
* **Typography**: Utilize the generated style atom extensions on `BuildContext` for text styling.
* *Example*: `style: context.regular12.white.rubik`

## Assets & Images
* **No Direct Asset Paths**: Never use raw string paths (e.g., `'assets/images/logo.png'`).
* **App Assets**: All image and asset paths must be sourced from the generated `lib/generated/app_assets.dart` file.
* *Example*: `Image.asset(AppAssets.imagesDoctor1)`

## Widget Decomposition
* **Avoid Large Build Methods**: UI files with excessively large `build` methods are hard to read and maintain.
* **Extract Widgets**: Break down large screens into smaller, manageable components.
  * Extract independent visual blocks into their own `StatelessWidget` or `HookWidget`.
  * For widgets strongly tied to the current file's scope that don't need independent files, consider using `part` directives.
  * For small, simple elements, extract them into helper methods (e.g., `_buildFloatingActionButton()`).
* **Reference Example (`admin_doctors_tab.dart`)**:
  ```dart
  // Example of extracting large parts of the UI into smaller part files/widgets
  part '../widget/admin_appbar.dart';
  part '../widget/doctors_widget.dart';
  part '../widget/status_widget.dart';

  class AdminDoctorsTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: CustomAppbar(), // Extracted widget
        floatingActionButton: _buildFloatingActionButton(context), // Helper method
        body: Column(
          spacing: 15, // Uniform spacing
          children: [
            StatusWidget(), // Extracted widget
            SearchTextFieldWidget(hintText: t.admin.doctors_tab.search_doctors), // Localized text
            DoctorsWidget(), // Extracted widget
          ],
        ),
      );
    }

    Widget _buildFloatingActionButton(BuildContext context) {
      return TextButton(
        onPressed: () {},
        child: Text(t.admin.doctors_tab.add_doctor, style: context.regular12.white.rubik),
        style: TextButton.styleFrom(backgroundColor: AppColors.brandPrimary),
      );
    }
  }
  ```
