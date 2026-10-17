---
name: flutter_hooks
description: Guidelines and best practices for using flutter_hooks. Covers when to use HookWidget, useValueNotifier vs useState, useRef, useMemoized, and anti-patterns. Use when refactoring widgets or creating screens with local controllers and state.
metadata:
  model: models/gemini-3.1-pro-preview
  last_modified: Mon, 11 May 2026 00:00:00 GMT
---
# Flutter Hooks Best Practices & Guidelines

## Contents
- [Core Principles](#core-principles)
- [Rule 1: HookWidget Extension Requirement](#rule-1-hookwidget-extension-requirement)
- [Rule 2: StatefulWidget with Simple setState Prohibition](#rule-2-statefulwidget-with-simple-setstate-prohibition)
- [Rule 3: ValueNotifier Management with useValueNotifier](#rule-3-valuenotifier-management-with-usevaluenotifier)
- [Rule 4: GlobalKey and Heavy Instances with useMemoized](#rule-4-globalkey-and-heavy-instances-with-usememoized)
- [Rule 5: useState Usage Scope](#rule-5-usestate-usage-scope)
- [Rule 6: Temporary Storage Buffers with useRef](#rule-6-temporary-storage-buffers-with-useref)
- [Rule 7: Specialized Hook Controllers](#rule-7-specialized-hook-controllers)
- [Decision Matrix](#decision-matrix)
- [Code Review Checklist](#code-review-checklist)
- [Codebase Examples](#codebase-examples)

## Core Principles
`flutter_hooks` is used to manage local widget lifecycles, controllers, and state efficiently without boilerplate. However, hooks must be applied strictly according to state necessity and performance impact to avoid unnecessary full-widget rebuilds.

## Rule 1: HookWidget Extension Requirement
* **Rule**: Extend `HookWidget` **ONLY** if the `build` method directly invokes at least one hook function (e.g., `useTextEditingController`, `useMemoized`, `useValueNotifier`, `useState`, `useRef`).
* **Stateless Alternative**: If a widget does not call any hook functions inside `build`, it **MUST** remain a `StatelessWidget`.
* **Examples in Codebase**:
  * `EmailTextFieldWidget`: A `StatelessWidget` that receives a `TextEditingController` as a constructor parameter.
  * `ChooseRoleScreen`: A `StatelessWidget` with no local hooks or state.

## Rule 2: StatefulWidget with Simple setState Prohibition
* **Rule**: Do **NOT** convert a `StatefulWidget` to a `HookWidget` if it **ONLY** manages simple local UI toggles using `setState` and has **NO** controllers or resources requiring initialization (`initState`) or disposal (`dispose`).
* **Why**: Simple `setState` widgets are lightweight and readable as standard `StatefulWidget`s. Introducing `flutter_hooks` without resource disposal adds unnecessary abstraction.
* **Example in Codebase**:
  * `CustomTextPassword`: Manages only `bool _isObscure` via `setState`. It has no controllers to dispose, so it remains a `StatefulWidget`.

## Rule 3: ValueNotifier Management with useValueNotifier
* **Rule**: When state is consumed by a `ValueListenableBuilder` or passed to a child widget expecting a `ValueNotifier<T>`, instantiate it using `useValueNotifier(initialValue)` instead of `useState`.
* **Why**: `useValueNotifier` creates and disposes a `ValueNotifier` without causing the parent `HookWidget` to rebuild when `.value` changes. Rebuilds are strictly isolated to the `ValueListenableBuilder`.
* **Code Pattern**:
  ```dart
  // ✅ CORRECT: Rebuilds are localized to ValueListenableBuilder
  final isActive = useValueNotifier(doctor.active);
  final isAgreedToTerms = useValueNotifier<bool>(false);

  // ❌ INCORRECT: Triggers full HookWidget rebuild on every value change
  final isActive = useState(doctor.active);
  ```
* **Examples in Codebase**:
  * `AdminDoctorDetailsScreen`: `final isActive = useValueNotifier(doctor.active);`
  * `RegisterScreen`: `final isAgreedToTerms = useValueNotifier<bool>(false);`

## Rule 4: GlobalKey and Heavy Instances with useMemoized
* **Rule**: Wrap single-instance objects that persist across widget rebuilds—such as `GlobalKey<FormState>`—with `useMemoized`.
* **Code Pattern**:
  ```dart
  // ✅ CORRECT
  final formKey = useMemoized(() => GlobalKey<FormState>());
  ```

## Rule 5: useState Usage Scope
* **Rule**: Use `useState` **ONLY** as a direct replacement for `setState` in a widget that is **ALREADY** a `HookWidget` (because it uses controllers or other hooks) AND has a local state variable whose modification **MUST** trigger a full UI rebuild of the `HookWidget`.
* **Code Pattern**:
  ```dart
  // ✅ CORRECT: Switching tabs requires swapping the entire screen body widget
  final selectedIndex = useState(0);
  ```
* **Examples in Codebase**:
  * `AdminMainScreen`: `final selectedIndex = useState(0);`
  * `PatientMainScreen`: `final selectedIndex = useState(0);`

## Rule 6: Temporary Storage Buffers with useRef
* **Rule**: For storing mutable data across builds that does **NOT** directly trigger a UI rebuild when mutated (such as file references, draft selections, or temporary objects), use `useRef`.
* **Code Pattern**:
  ```dart
  // ✅ CORRECT: Updating selectedImage.value does not rebuild the widget tree
  final selectedImage = useRef<File?>(null);
  final selectedSpecialty = useRef<Specialty>(doctor.specialty);

  // Mutation
  selectedImage.value = pickedFile;
  ```

## Rule 7: Specialized Hook Controllers
* **Rule**: Always use built-in hook helpers for automatic initialization and disposal of Flutter controllers:
  * `useTextEditingController(text: initialText)`
  * `useFocusNode()`
  * `usePageController()`
  * `useTabController()`
  * `useScrollController()`

## Anti-Patterns

### Use `useMemoized` and `useEffect` for Custom/External Controllers
When dealing with controllers from third-party packages (e.g., `KFDrawerController`, `VideoPlayerController`, etc.) that require manual disposal, **do not** wrap them in a `useValueNotifier`. The `ValueNotifier` will dispose of itself, but it will **not** call `dispose()` on the external controller, leading to memory leaks.

Instead, create the controller using `useMemoized` to ensure it's only instantiated once, and use `useEffect` to manage its lifecycle and guarantee it gets disposed of properly when the widget is unmounted.

**Example: Managing an external controller**
```dart
// ❌ BAD: Memory Leak! ValueNotifier disposes itself, but not the KFDrawerController.
final drawerController = useValueNotifier(KFDrawerController(...));

// ✅ GOOD: Instantiated once, and properly disposed.
final drawerController = useMemoized(() => KFDrawerController(...));

useEffect(() {
  // This cleanup function runs when the widget is disposed.
  return () => drawerController.dispose();
}, [drawerController]); // Pass the controller as a dependency
```

If you find yourself using a specific external controller frequently across multiple screens, consider creating a Custom Hook for it to encapsulate the setup and teardown logic.

| Scenario | Widget / Hook Selection | Reason |
| :--- | :--- | :--- |
| No local state, no hooks used | `StatelessWidget` | Pure UI component |
| Simple toggle/state with NO `initState`/`dispose` | `StatefulWidget` (`setState`) | Lightweight, no hook required |
| Controller needed (`TextEditingController`, etc.) | `HookWidget` + `useTextEditingController` | Auto-disposal |
| Form validation key | `useMemoized(() => GlobalKey<FormState>())` | Preserves instance across rebuilds |
| State used in `ValueListenableBuilder` | `useValueNotifier(...)` | Isolated rebuilds |
| Tab/Page switching requiring full body swap | `useState(...)` | Full widget rebuild required |
| Temporary image/file buffer | `useRef(...)` | Value change doesn't rebuild UI |

## Code Review Checklist

- [ ] 1. Does the widget extend `HookWidget`? Verify that at least one hook function is called inside `build`.
- [ ] 2. Is this a simple `StatefulWidget` with only `setState`? If so, ensure it stays `StatefulWidget`.
- [ ] 3. Are all `GlobalKey` instances created with `useMemoized`?
- [ ] 4. Is `useValueNotifier` used instead of `useState` when feeding a `ValueListenableBuilder`?
- [ ] 5. Is `useRef` used for non-rebuilding temporary data buffers?
- [ ] 6. Are all `TextEditingController`s created with `useTextEditingController`?

## Codebase Examples

### Complex Form Screen (`UpdateDoctorDetailsScreen`)
```dart
class UpdateDoctorDetailsScreen extends HookWidget {
  const UpdateDoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    // 1. Text Controller via hook (auto-disposed)
    final nameController = useTextEditingController(text: doctor.name);

    // 2. ValueNotifier via useValueNotifier (isolated rebuilds via ValueListenableBuilder)
    final isActive = useValueNotifier(doctor.active);

    // 3. GlobalKey via useMemoized
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // 4. Mutable references via useRef (no UI rebuild on mutation)
    final selectedImage = useRef<File?>(null);
    final selectedSpecialty = useRef<Specialty>(doctor.specialty);

    return Scaffold(
      appBar: AppBar(title: Text(t.admin.update_doctor_details.edit_doctor)),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            CustomTextFormField(controller: nameController),
            _buildStatusWidget(context, isActive), // Uses ValueListenableBuilder
          ],
        ),
      ),
    );
  }
}
```

### Tab Navigation Screen (`AdminMainScreen`)
```dart
class AdminMainScreen extends HookWidget {
  const AdminMainScreen({super.key});

  static const List<Widget> _tabsList = [
    AdminDoctorsTab(),
    AdminSettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    // useState triggers a full HookWidget rebuild to swap _tabsList body
    final selectedIndex = useState(0);

    return Scaffold(
      body: _tabsList[selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: (index) {
          if (selectedIndex.value != index) {
            selectedIndex.value = index;
          }
        },
        items: [...],
      ),
    );
  }
}
```
