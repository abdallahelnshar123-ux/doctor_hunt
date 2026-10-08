---
name: flutter-add-widget-test
description: Implement a component-level test using `WidgetTester` to verify UI rendering and user interactions (tapping, scrolling, entering text). Use when validating that a specific widget displays correct data and responds to events as expected.
metadata:
  model: models/gemini-3.1-pro-preview
  last_modified: Tue, 21 Apr 2026 21:15:41 GMT
---
# Writing Flutter Widget Tests

## Contents
- [Setup & Configuration](#setup--configuration)
- [Agent Specific Rules & Best Practices](#agent-specific-rules--best-practices)
- [Core Components](#core-components)
- [Workflow: Implementing a Widget Test](#workflow-implementing-a-widget-test)
- [Interaction & State Management](#interaction--state-management)
- [Examples](#examples)

## Setup & Configuration

Ensure the testing environment is properly configured before authoring widget tests.

1. Add the `flutter_test` dependency to the `dev_dependencies` section of `pubspec.yaml`.
2. Place all test files in the `test/` directory at the root of the project.
3. Suffix all test file names with `_test.dart` (e.g., `widget_test.dart`).

## Agent Specific Rules & Best Practices

The following are strict rules that must be followed by the agent when writing or modifying widget tests in this project:

### 1. Routing with GoRouter in Tests
*   When a widget requires navigation or depends on router context, you **MUST** use the project's actual router creation function (e.g., `createRouter` from `app_routes.dart`) if it exists, rather than mocking a fake `GoRouter` manually. This ensures tests run against the real routing logic.
    ```dart
    final router = createRouter(
      authBloc: authBloc, // Pass required mocked dependencies here
      initialLocation: '/my_route',
    );
    return MaterialApp.router(routerConfig: router);
    ```

### 2. Providing Blocs in Tests (BlocProvider)
*   When injecting a mocked Bloc into the widget tree, use the standard `BlocProvider` with the `create` callback, **NOT** `BlocProvider.value`.
*   **CRITICAL:** You must explicitly define the Bloc's generic type (e.g., `BlocProvider<AuthBloc>`) so that the provider correctly matches the exact type expected by `BlocListener` or `BlocBuilder` in the widget tree. Failing to do so when using mocks will cause a `ProviderNotFoundException`.
    ```dart
    BlocProvider<AuthBloc>(
      create: (context) => authBloc, // authBloc is the mocked instance
      child: MaterialApp.router(routerConfig: router),
    )
    ```

### 3. Mocking Blocs & Streams (bloc_test)
*   When mocking a Bloc, **always** use `MockBloc` or `MockCubit` from the `bloc_test` package. Do not use generic `Mock` and manually override methods or properties like `stream` or `close`.
    ```dart
    class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}
    ```
*   To stub the stream of states, always use `whenListen` from `bloc_test` to ensure the current state and stream stay perfectly in sync.
    ```dart
    whenListen(authBloc, controller.stream, initialState: AuthInitial());
    ```

### 4. Finding Widgets
*   **Unique Identifiers:** Find widgets by uniquely identifying them. When multiple similar widgets exist, rely on specific identifiers (like `find.bySemanticsLabel` using translated hint texts) rather than generic type matchers.
*   **Exact Counts:** When you expect more than one widget of the same type or text, and you know the exact expected number, use `findsNWidgets(exact_count)` instead of `findsWidgets`.
*   **Reusable & Nested Widgets:** When verifying widget counts, you must consider the internal composition of reusable widgets imported from other files. For example, if a `ContinueWithGoogleButton` internally uses a `CustomElevatedButton`, expecting `findsOneWidget` for `CustomElevatedButton` might fail if there's another one on the screen. Always be aware of the widget tree composition and adjust the expected count using `findsNWidgets(exact_count)` accordingly.

### 5. Using `pump` vs `pumpAndSettle`
*   **No UI Change = No Pump:** Do not call `await tester.pump()` if you are not verifying a UI change. For example, if you interact with a button and only want to verify that a Bloc event was added, pumping is unnecessary.
*   **Verifying UI Changes:** It is the perfect use for `await tester.pump()` when verifying a UI change (e.g., a state emission that shows a `CircularProgressIndicator` or opens a dialog).
*   **Dialogs Without Animation:** Use `await tester.pump()` instead of `tester.pumpAndSettle()` when showing simple dialogs without animations. Calling `pumpAndSettle` is inappropriate if there is no animation to wait for.
*   **Redundant PumpAndSettle:** Do not use `await tester.pumpAndSettle()` twice consecutively. A single call, optionally with a `Duration` (e.g., `await tester.pumpAndSettle(const Duration(seconds: 2))`), is enough.

### 6. Mocking & Verifying Events
*   **Event Types:** When verifying that an event was added to a Bloc using `captureAny()`, you **must** verify the exact type of the captured event using `isA<MyEvent>()`.
    ```dart
    final captured = verify(() => myBloc.add(captureAny())).captured;
    expect(captured.first, isA<LoginRequested>());
    ```

### 7. Resource Management
*   **Close Controllers:** Always make sure to close `StreamController`s at the end of your widget tests.
    ```dart
    await controller.close();
    ```

## Core Components

Utilize the following `flutter_test` components to interact with and validate the widget tree:

*   **`WidgetTester`**: The primary interface for building and interacting with widgets in the test environment. Provided automatically by the `testWidgets()` function.
*   **`Finder`**: Locates widgets in the test environment (e.g., `find.text('Submit')`, `find.byType(TextField)`, `find.byKey(Key('submit_btn'))`).
*   **`Matcher`**: Verifies the presence or state of widgets located by a `Finder` (e.g., `findsOneWidget`, `findsNothing`, `findsNWidgets(2)`, `matchesGoldenFile`).

## Workflow: Implementing a Widget Test

Copy the following checklist to track progress when implementing a new widget test.

### Task Progress
- [ ] **Step 1: Define the test.** Use `testWidgets('description', (WidgetTester tester) async { ... })`.
- [ ] **Step 2: Build the widget.** Call `await tester.pumpWidget(MyWidget())` to render the UI. Wrap the widget in a `MaterialApp` or `Directionality` widget if it requires inherited directional or theme data. Use `MaterialApp.router` if `GoRouter` context is needed.
- [ ] **Step 3: Locate elements.** Instantiate `Finder` objects for the target widgets.
- [ ] **Step 4: Verify initial state.** Use `expect(finder, matcher)` to validate the initial render.
- [ ] **Step 5: Simulate interactions.** Execute gestures or inputs (e.g., `await tester.tap(buttonFinder)`).
- [ ] **Step 6: Rebuild the tree.** Call `await tester.pump()` or `await tester.pumpAndSettle()` to process state changes (following the rules on when to pump).
- [ ] **Step 7: Verify updated state.** Use `expect()` to validate the UI after the interaction.
- [ ] **Step 8: Cleanup.** Close any `StreamController`s created for mock streams.
- [ ] **Step 9: Run and validate.** Execute `flutter test test/your_test_file_test.dart`.
- [ ] **Step 10: Feedback Loop.** Review test output -> identify failing matchers -> adjust widget logic or test assertions -> re-run until passing.

## Interaction & State Management

Apply the following conditional logic based on the type of interaction or state change being tested (while strictly adhering to the Agent Specific Rules above):

*   **If testing static rendering:** Call `await tester.pumpWidget()` once, then immediately run `expect()` assertions.
*   **If testing standard state changes (e.g., button taps):**
    1. Call `await tester.tap(finder)`.
    2. Call `await tester.pump()` to trigger a single frame rebuild.
*   **If testing animations, transitions, or asynchronous UI updates:**
    1. Trigger the action (e.g., `await tester.drag(finder, Offset(500, 0))`).
    2. Call `await tester.pumpAndSettle()` to repeatedly pump frames until no more frames are scheduled (animation completes).
*   **If testing text input:** Call `await tester.enterText(textFieldFinder, 'Input string')`.
*   **If testing items in a dynamic or long list:** Call `await tester.scrollUntilVisible(itemFinder, 500.0, scrollable: listFinder)` to ensure the target widget is rendered before interacting with it.

## Examples

### High-Fidelity Widget Test Implementation

**Target Widget (`lib/todo_list.dart`):**
```dart
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextField(controller: controller),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (_) => setState(() => todos.removeAt(index)),
                    child: ListTile(title: Text(todo)),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

**Test Implementation (`test/todo_list_test.dart`):**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/todo_list.dart';

void main() {
  testWidgets('Add and remove a todo item', (WidgetTester tester) async {
    // 1. Build the widget
    await tester.pumpWidget(const TodoList());

    // 2. Verify initial state
    expect(find.byType(ListTile), findsNothing);

    // 3. Enter text into the TextField
    await tester.enterText(find.byType(TextField), 'Buy groceries');

    // 4. Tap the add button
    await tester.tap(find.byType(FloatingActionButton));

    // 5. Rebuild the widget to reflect the new state
    await tester.pump();

    // 6. Verify the item was added
    expect(find.text('Buy groceries'), findsOneWidget);

    // 7. Swipe the item to dismiss it
    await tester.drag(find.byType(Dismissible), const Offset(500, 0));

    // 8. Build the widget until the dismiss animation ends
    await tester.pumpAndSettle();

    // 9. Verify the item was removed
    expect(find.text('Buy groceries'), findsNothing);
  });
}
```