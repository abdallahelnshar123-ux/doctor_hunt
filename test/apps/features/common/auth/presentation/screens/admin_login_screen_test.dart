import 'dart:async';

import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_state.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/admin_login_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_text_password.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/email_text_field_widget.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
  });

  late MockAuthBloc authBloc;

  final tUser = MyUser(
    id: '1',
    email: 'admin@example.com',
    role: UserRoles.admin,
    name: 'admin',
    provider: UserAuthProvider.emailPassword,
  );

  setUp(() {
    authBloc = MockAuthBloc();

    when(() => authBloc.state).thenReturn(AuthInitial());

    when(
      () => authBloc.stream,
    ).thenAnswer((_) => const Stream<AuthState>.empty());

    when(() => authBloc.close()).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => BlocProvider<AuthBloc>(
            create: (context) => authBloc,
            child: const AdminLoginScreen(),
          ),
        ),
        GoRoute(
          path: '/admin_main',
          builder: (_, _) => const Scaffold(body: Text('Admin Main')),
        ),
      ],
    );
    return TranslationProvider(child: MaterialApp.router(routerConfig: router));
  }

  group('AdminLoginScreen', () {
    testWidgets('renders all required widgets', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(t.auth.welcome_back), findsOneWidget);
      expect(find.text(t.auth.admin_subtitle), findsOneWidget);
      expect(find.text(t.auth.login), findsOneWidget);
      expect(find.text(t.auth.forgot_password), findsOneWidget);

      expect(find.byType(EmailTextFieldWidget), findsOneWidget);
      expect(find.byType(CustomTextPassword), findsOneWidget);
      expect(find.byType(CustomElevatedButton), findsOneWidget);
    });

    testWidgets('login button does not add event when form is invalid', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text(t.auth.login));

      verifyNever(() => authBloc.add(any()));
    });

    testWidgets(
      'login button adds LoginRequested with admin role when form is valid',
      (tester) async {
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

        when(() => authBloc.stream).thenAnswer((_) => controller.stream);

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

        when(() => authBloc.stream).thenAnswer((_) => controller.stream);

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

    testWidgets('shows success dialog when UserAuthenticatedState is emitted', (
      tester,
    ) async {
      final controller = StreamController<AuthState>.broadcast();

      when(() => authBloc.stream).thenAnswer((_) => controller.stream);

      await tester.pumpWidget(createWidgetUnderTest());

      controller.add(LoginWithEmailPasswordLoadingState());
      await tester.pump();

      controller.add(UserAuthenticatedState(tUser));

      await tester.pump();

      expect(find.text(t.dialog.success), findsNWidgets(2));

      await tester.pumpAndSettle(const Duration(seconds: 2));

      await controller.close();
    });

    testWidgets('navigates to AdminMainRoute after successful authentication', (
      tester,
    ) async {
      final controller = StreamController<AuthState>.broadcast();

      when(() => authBloc.stream).thenAnswer((_) => controller.stream);

      await tester.pumpWidget(createWidgetUnderTest());

      controller.add(LoginWithEmailPasswordLoadingState());
      await tester.pump();

      controller.add(UserAuthenticatedState(tUser));

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Admin Main'), findsOneWidget);

      await controller.close();
    });
  });
}
