import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_state.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/patient_login_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/continue_with_google_button.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_text_password.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/email_text_field_widget.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockUserPrefs extends Mock implements UserPrefs {}

class FakeAuthEvent extends Fake implements AuthEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
  });

  late MockAuthBloc authBloc;
  late MockUserPrefs mockUserPrefs;

  setUp(() {
    authBloc = MockAuthBloc();
    mockUserPrefs = MockUserPrefs();

    when(() => authBloc.state).thenReturn(AuthInitial());
    when(() => mockUserPrefs.onboarding).thenReturn(true);
  });

  Widget createWidgetUnderTest() {
    final router = createRouter(
      userPrefs: mockUserPrefs,
      authBloc: authBloc,
      initialLocation: '/register',
    );
    return TranslationProvider(
      child: BlocProvider<AuthBloc>(
        create: (context) => authBloc,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
  }

  group('RegisterScreen', () {
    testWidgets('renders all required widgets', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(t.auth.join_us), findsOneWidget);
      expect(find.text(t.auth.auth_subtitle), findsOneWidget);
      expect(find.text(t.auth.sign_up), findsOneWidget);
      expect(find.text(t.auth.have_account), findsOneWidget);
      expect(find.text(t.auth.agree_terms), findsOneWidget);
      expect(find.text(t.auth.username), findsOneWidget);
      expect(find.text(t.auth.google), findsOneWidget);
      expect(find.text(t.auth.password), findsOneWidget);
      expect(find.text(t.auth.email), findsOneWidget);

      expect(find.byType(EmailTextFieldWidget), findsOneWidget);
      expect(find.byType(CustomTextPassword), findsOneWidget);
      expect(find.byType(CustomTextFormField), findsNWidgets(3));
      expect(find.byType(CustomElevatedButton), findsNWidgets(2));
      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.byType(ContinueWithGoogleButton), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('register button does not add event when form is invalid', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.scrollUntilVisible(
        find.text(t.auth.sign_up),
        50.0,
        scrollable: find.byType(Scrollable).first,
      );

      await tester.tap(find.text(t.auth.sign_up));
      await tester.pumpAndSettle();

      expect(find.text('this_field_is_required'), findsOneWidget);
      expect(find.text('email_is_required'), findsOneWidget);
      expect(find.text('password_is_required'), findsOneWidget);

      verifyNever(() => authBloc.add(any()));
    });

    testWidgets(
      'register button shows error snackBar when form is valid but terms are not agreed',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        final nameField = find.bySemanticsLabel(t.auth.username);
        final emailField = find.bySemanticsLabel(t.auth.email);
        final passwordField = find.bySemanticsLabel(t.auth.password);

        await tester.enterText(nameField, 'testUser');
        await tester.enterText(emailField, 'test@example.com');
        await tester.enterText(passwordField, 'password123');

        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pump();

        await tester.scrollUntilVisible(
          find.text(t.auth.sign_up),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );

        await tester.tap(find.text(t.auth.sign_up));

        await tester.pump();

        expect(find.text(t.auth.you_must_agree_to_terms), findsOneWidget);
        verifyNever(() => authBloc.add(any()));
      },
    );

    testWidgets(
      'register button adds RegisterRequested when form is valid and terms agreed',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        final nameField = find.bySemanticsLabel(t.auth.username);
        final emailField = find.bySemanticsLabel(t.auth.email);
        final passwordField = find.bySemanticsLabel(t.auth.password);

        await tester.enterText(nameField, 'testuser');
        await tester.enterText(emailField, 'test@example.com');
        await tester.enterText(passwordField, 'password123');

        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pump();

        await tester.scrollUntilVisible(
          find.text(t.auth.agree_terms),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.tap(find.text(t.auth.agree_terms));
        await tester.pump();
        expect(find.byIcon(Icons.circle), findsOneWidget);

        await tester.scrollUntilVisible(
          find.text(t.auth.sign_up),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );

        await tester.tap(find.text(t.auth.sign_up));

        final captured = verify(() => authBloc.add(captureAny())).captured;

        expect(captured.first, isA<RegisterRequested>());
        expect(captured, hasLength(1));

        final event = captured.first as RegisterRequested;
        expect(event.name, 'testuser');
        expect(event.email, 'test@example.com');
        expect(event.password, 'password123');
      },
    );

    testWidgets(
      'continue with google button adds ContinueWithGoogleRequested event',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.scrollUntilVisible(
          find.byType(ContinueWithGoogleButton),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );

        await tester.tap(find.byType(ContinueWithGoogleButton));

        final captured = verify(() => authBloc.add(captureAny())).captured;

        expect(captured.first, isA<ContinueWithGoogleRequested>());
        expect(captured, hasLength(1));
      },
    );

    testWidgets(
      'navigates to PatientLoginRoute when Have an account is tapped',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.scrollUntilVisible(
          find.text(t.auth.have_account),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );

        await tester.tap(find.text(t.auth.have_account));
        await tester.pumpAndSettle();

        expect(find.byType(PatientLoginScreen), findsOneWidget);
      },
    );

    testWidgets(
      'shows loading dialog when RegisterWithEmailPasswordLoadingState is emitted',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();

        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(RegisterWithEmailPasswordLoadingState());

        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await controller.close();
      },
    );

    testWidgets(
      'shows loading dialog when ContinueWithGoogleLoadingState is emitted',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();

        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(ContinueWithGoogleLoadingState());

        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await controller.close();
      },
    );

    testWidgets(
      'shows error dialog when RegisterWithEmailPasswordErrorState is emitted',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();

        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(RegisterWithEmailPasswordLoadingState());
        await tester.pump();

        controller.add(
          RegisterWithEmailPasswordErrorState('Invalid credentials'),
        );

        await tester.pump();

        expect(find.text('Invalid credentials'), findsOneWidget);
        expect(find.text(t.dialog.error), findsOneWidget);
        expect(find.text(t.dialog.ok), findsOneWidget);

        await controller.close();
      },
    );

    testWidgets(
      'shows error dialog when ContinueWithGoogleErrorState is emitted',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();

        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(ContinueWithGoogleLoadingState());
        await tester.pump();

        controller.add(ContinueWithGoogleErrorState('Google Sign-In Failed'));

        await tester.pump();

        expect(find.text('Google Sign-In Failed'), findsOneWidget);
        expect(find.text(t.dialog.error), findsOneWidget);
        expect(find.text(t.dialog.ok), findsOneWidget);

        await controller.close();
      },
    );

    testWidgets(
      'shows success dialog when RegisterWithEmailPasswordSuccessState is emitted',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();

        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(RegisterWithEmailPasswordLoadingState());
        await tester.pump();

        controller.add(RegisterWithEmailPasswordSuccessState());

        await tester.pump();

        expect(find.text(t.dialog.success), findsOneWidget);
        expect(find.text(t.dialog.registered_successfully), findsOneWidget);
        expect(find.text(t.dialog.ok), findsOneWidget);

        await controller.close();
      },
    );

    testWidgets(
      'navigates to PatientLoginRoute after successful registration and clicking OK',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();

        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(RegisterWithEmailPasswordLoadingState());
        await tester.pump();

        controller.add(RegisterWithEmailPasswordSuccessState());
        await tester.pump();

        expect(find.text(t.dialog.registered_successfully), findsOneWidget);

        await tester.tap(find.text(t.dialog.ok));
        await tester.pumpAndSettle();

        expect(find.byType(PatientLoginScreen), findsOneWidget);

        await controller.close();
      },
    );
  });
}
