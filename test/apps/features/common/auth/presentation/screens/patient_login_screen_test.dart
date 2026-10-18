import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';
import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_event.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_state.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/widgets/back_button_widget.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_state.dart';
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

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class MockUserPrefs extends Mock implements UserPrefs {}

class MockUserSessionManager extends Mock implements UserSessionManager {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeUserEvent extends Fake implements UserEvent {}

class FakeMyUser extends Fake implements MyUser {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeUserEvent());
    registerFallbackValue(FakeMyUser());
  });

  late MockAuthBloc authBloc;
  late MockUserBloc userBloc;
  late MockUserPrefs userPrefs;
  late MockUserSessionManager mockUserSessionManager;

  setUp(() {
    authBloc = MockAuthBloc();
    userBloc = MockUserBloc();
    userPrefs = MockUserPrefs();
    mockUserSessionManager = MockUserSessionManager();

    when(() => userPrefs.onboarding).thenReturn(true);
    when(() => userBloc.currentUser).thenReturn(null);
    when(() => mockUserSessionManager.currentUser).thenReturn(null);
    when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
    when(
      () => mockUserSessionManager.authStateStream,
    ).thenAnswer((_) => Stream.value(false));
  });

  tearDown(() {
    getIt.reset();
  });

  Widget createWidgetUnderTest() {
    final router = createRouter(
      userSessionManager: mockUserSessionManager,
      userPrefs: userPrefs,
      initialLocation: '/patient_login',
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => authBloc),
        BlocProvider<UserBloc>(create: (context) => userBloc),
      ],
      child: TranslationProvider(
        child: MaterialApp.router(routerConfig: router),
      ),
    );
  }

  group('PatientLoginScreen', () {
    testWidgets('renders all required widgets', (tester) async {
      whenListen(
        authBloc,
        const Stream<AuthState>.empty(),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(t.auth.welcome_back), findsOneWidget);
      expect(find.text(t.auth.auth_subtitle), findsOneWidget);
      expect(find.text(t.auth.login), findsOneWidget);

      expect(find.text(t.auth.google), findsOneWidget);
      expect(find.text(t.auth.password), findsOneWidget);
      expect(find.text(t.auth.email), findsOneWidget);

      expect(find.text(t.auth.forgot_password), findsOneWidget);
      expect(find.text(t.auth.no_account), findsOneWidget);

      expect(find.byType(EmailTextFieldWidget), findsOneWidget);
      expect(find.byType(CustomTextPassword), findsOneWidget);

      expect(find.byType(CustomElevatedButton), findsNWidgets(2));
      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.byType(BackButtonWidget), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(MainAppBar), findsOneWidget);

      expect(find.byType(ContinueWithGoogleButton), findsOneWidget);
    });

    testWidgets(
      'login button does not add event and shows validation error when form is invalid',
      (tester) async {
        whenListen(
          authBloc,
          const Stream<AuthState>.empty(),
          initialState: AuthInitial(),
        );
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.scrollUntilVisible(
          find.text(t.auth.login),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );

        await tester.tap(find.text(t.auth.login));
        await tester.pump();

        verifyNever(() => authBloc.add(any()));
        expect(find.text(t.validators.email_is_required), findsOneWidget);
      },
    );

    testWidgets(
      'login button adds LoginRequested with patient role when form is valid',
      (tester) async {
        whenListen(
          authBloc,
          const Stream<AuthState>.empty(),
          initialState: AuthInitial(),
        );
        await tester.pumpWidget(createWidgetUnderTest());

        final emailField = find.bySemanticsLabel(t.auth.email);
        final passwordField = find.bySemanticsLabel(t.auth.password);

        await tester.enterText(emailField, 'patient@example.com');
        await tester.enterText(passwordField, 'password123');

        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pump();

        await tester.scrollUntilVisible(
          find.text(t.auth.login),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );

        await tester.tap(find.text(t.auth.login));

        final captured = verify(() => authBloc.add(captureAny())).captured;

        expect(captured.first, isA<LoginRequested>());
        expect(captured, hasLength(1));

        final event = captured.first as LoginRequested;
        expect(event.role, UserRoles.patient);
        expect(event.email, 'patient@example.com');
        expect(event.password, 'password123');
      },
    );

    testWidgets(
      'continue with google button adds ContinueWithGoogleRequested event',
      (tester) async {
        whenListen(
          authBloc,
          const Stream<AuthState>.empty(),
          initialState: AuthInitial(),
        );
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
      'forgot password button removes focus and navigates to ForgotPasswordRoute',
      (tester) async {
        whenListen(
          authBloc,
          const Stream<AuthState>.empty(),
          initialState: AuthInitial(),
        );
        await tester.pumpWidget(createWidgetUnderTest());

        final emailField = find.bySemanticsLabel(t.auth.email);

        await tester.tap(emailField);
        await tester.enterText(emailField, 'patient@example.com');

        expect(FocusManager.instance.primaryFocus?.hasFocus, isTrue);

        await tester.scrollUntilVisible(
          find.text(t.auth.forgot_password),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.tap(find.text(t.auth.forgot_password));
        await tester.pumpAndSettle();

        expect(find.text(t.forgot_password.title), findsOneWidget);
      },
    );

    testWidgets(
      'navigates to ChooseRoleRoute when MainAppBar back button is tapped',
      (tester) async {
        whenListen(
          authBloc,
          const Stream<AuthState>.empty(),
          initialState: AuthInitial(),
        );
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.byType(BackButtonWidget));
        await tester.pumpAndSettle();

        expect(find.text(t.choose_role.title), findsOneWidget);
      },
    );

    testWidgets(
      'navigates to RegisterRoute when Do not have an account is tapped',
      (tester) async {
        whenListen(
          authBloc,
          const Stream<AuthState>.empty(),
          initialState: AuthInitial(),
        );
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.scrollUntilVisible(
          find.text(t.auth.no_account),
          50.0,
          scrollable: find.byType(Scrollable).first,
        );

        await tester.tap(find.text(t.auth.no_account));
        await tester.pumpAndSettle();

        // Check if we navigated to the register screen (verifying its app bar or title)
        expect(find.text(t.auth.sign_up), findsOneWidget);
      },
    );

    testWidgets(
      'shows loading dialog when LoginWithEmailPasswordLoadingState is emitted',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();
        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(LoginWithEmailPasswordLoadingState());
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
      'shows error dialog when LoginWithEmailPasswordErrorState is emitted',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();
        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(LoginWithEmailPasswordLoadingState());
        await tester.pump();

        controller.add(LoginWithEmailPasswordErrorState('Invalid credentials'));
        await tester.pump();

        expect(find.text('Invalid credentials'), findsOneWidget);
        expect(find.text(t.dialog.error), findsOneWidget);
        expect(find.text(t.dialog.ok), findsOneWidget);

        await controller.close();
      },
    );

    testWidgets(
      'shows error dialog when ContinueWithGoogleErrorState is emitted and not cancelled by user',
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

        await controller.close();
      },
    );

    testWidgets(
      'does NOT show error dialog when ContinueWithGoogleErrorState is emitted with cancelled by user message',
      (tester) async {
        final controller = StreamController<AuthState>.broadcast();
        whenListen(authBloc, controller.stream, initialState: AuthInitial());

        await tester.pumpWidget(createWidgetUnderTest());

        controller.add(ContinueWithGoogleLoadingState());
        await tester.pump();

        controller.add(
          ContinueWithGoogleErrorState(t.errors.cancelled_by_user),
        );
        await tester.pump();

        expect(find.text(t.dialog.error), findsNothing);

        await controller.close();
      },
    );
  });
}
