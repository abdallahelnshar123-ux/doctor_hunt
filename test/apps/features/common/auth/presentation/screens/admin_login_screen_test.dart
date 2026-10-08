import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_state.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_state.dart';
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

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class MockDoctorBloc extends MockBloc<DoctorEvent, DoctorState>
    implements DoctorBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
  });

  late MockAuthBloc authBloc;
  late MockUserPrefs mockUserPrefs;
  late MockUserBloc mockUserBloc;
  late MockDoctorBloc mockDoctorBloc;

  final tUser = MyUser(
    id: '1',
    email: 'admin@example.com',
    role: UserRoles.admin,
    name: 'admin',
    provider: UserAuthProvider.emailPassword,
  );

  setUp(() {
    authBloc = MockAuthBloc();
    mockUserPrefs = MockUserPrefs();
    mockUserBloc = MockUserBloc();
    mockDoctorBloc = MockDoctorBloc();

    when(() => mockUserPrefs.onboarding).thenReturn(true);
    when(() => mockUserBloc.currentUser).thenReturn(tUser);

    when(() => mockUserBloc.state).thenReturn(const UserState());
    whenListen(
      mockUserBloc,
      const Stream<UserState>.empty(),
      initialState: const UserState(),
    );
    final initialDoctorState = GetDoctorsSuccessState(
      allDoctors: const [],
      specialtyCounts: const [],
      activeDoctorsCount: 0,
    );

    when(() => mockDoctorBloc.state).thenReturn(initialDoctorState);
    whenListen(
      mockDoctorBloc,
      const Stream<DoctorState>.empty(),
      initialState: initialDoctorState,
    );

    getIt.registerFactory<DoctorBloc>(() => mockDoctorBloc);
  });

  tearDown(() {
    getIt.reset();
  });

  Widget createWidgetUnderTest() {
    final router = createRouter(
      authBloc: authBloc,
      userPrefs: mockUserPrefs,
      initialLocation: '/admin_login',
    );
    return TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => authBloc),
          BlocProvider<UserBloc>(create: (context) => mockUserBloc),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
  }

  group('AdminLoginScreen', () {
    testWidgets('renders all required widgets', (tester) async {
      whenListen(
        authBloc,
        const Stream<AuthState>.empty(),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(t.auth.welcome_back), findsOneWidget);
      expect(find.text(t.auth.admin_subtitle), findsOneWidget);
      expect(find.text(t.auth.login), findsOneWidget);
      expect(find.text(t.auth.forgot_password), findsOneWidget);

      expect(find.byType(EmailTextFieldWidget), findsOneWidget);
      expect(find.byType(CustomTextPassword), findsOneWidget);
      expect(find.byType(CustomElevatedButton), findsOneWidget);
      expect(find.byType(MainAppBar), findsOneWidget);
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

        await tester.tap(find.text(t.auth.login));
        await tester.pump();

        verifyNever(() => authBloc.add(any()));
        expect(find.text('email_is_required'), findsOneWidget);
      },
    );

    testWidgets(
      'login button adds LoginRequested with admin role when form is valid',
      (tester) async {
        whenListen(
          authBloc,
          const Stream<AuthState>.empty(),
          initialState: AuthInitial(),
        );

        await tester.pumpWidget(createWidgetUnderTest());

        final emailField = find.bySemanticsLabel(t.auth.email);
        final passwordField = find.bySemanticsLabel(t.auth.password);

        await tester.enterText(emailField, 'admin@example.com');
        await tester.enterText(passwordField, 'password123');

        await tester.tap(find.text(t.auth.login));

        final captured = verify(() => authBloc.add(captureAny())).captured;

        expect(captured.first, isA<LoginRequested>());
        expect(captured, hasLength(1));

        final event = captured.first as LoginRequested;

        expect(event.role, UserRoles.admin);
        expect(event.email, 'admin@example.com');
        expect(event.password, 'password123');
      },
    );

    testWidgets('forgot password button removes focus', (tester) async {
      whenListen(
        authBloc,
        const Stream<AuthState>.empty(),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      final emailField = find.bySemanticsLabel(t.auth.email);

      await tester.tap(emailField);
      await tester.enterText(emailField, 'admin@example.com');

      expect(FocusManager.instance.primaryFocus?.hasFocus, isTrue);

      await tester.tap(find.text(t.auth.forgot_password));

      expect(
        FocusManager.instance.primaryFocus?.context?.widget.runtimeType
            .toString(),
        isNot(contains('EditableText')),
      );
    });

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

    testWidgets('navigates to AdminMainRoute after successful authentication', (
      tester,
    ) async {
      final controller = StreamController<AuthState>.broadcast();
      whenListen(authBloc, controller.stream, initialState: AuthInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      controller.add(LoginWithEmailPasswordLoadingState());
      await tester.pump();

      controller.add(UserAuthenticatedState(tUser));

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(
        find.text(t.admin.main.doctors),
        findsWidgets,
      ); // Found in bottom navigation of admin main screen and possibly the tab itself

      await controller.close();
    });
  });
}
