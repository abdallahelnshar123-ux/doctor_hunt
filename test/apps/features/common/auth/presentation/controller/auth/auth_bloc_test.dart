import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/use_case/login_use_case.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockUserSessionManager extends Mock implements UserSessionManager {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockLoginUseCase mockLoginUseCase;
  late MockUserSessionManager mockUserSessionManager;
  const tUser = MyUser(
    id: '123',
    email: 'test@example.com',
    name: 'Test User',
    provider: UserAuthProvider.emailPassword,
    role: UserRoles.patient,
  );

  const tFailure = ServerFailure('An error occurred');

  setUpAll(() {
    registerFallbackValue(UserRoles.patient);
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockLoginUseCase = MockLoginUseCase();
    mockUserSessionManager = MockUserSessionManager();

    // Add default stubs for UserSessionManager streams
    when(
      () => mockUserSessionManager.userStream,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => mockUserSessionManager.authStateStream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
  });

  group('Initialization', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [UserAuthenticatedState] when UserSessionManager is logged in',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(true);
        when(() => mockUserSessionManager.currentUser).thenReturn(tUser);
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      expect: () => [], // No new states emitted initially after super()
      verify: (bloc) {
        expect(bloc.state, equals(UserAuthenticatedState(tUser)));
        verify(() => mockUserSessionManager.isLoggedIn).called(1);
        verify(() => mockUserSessionManager.currentUser).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [UserUnauthenticatedState] when UserSessionManager is not logged in',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      expect: () => [],
      verify: (bloc) {
        expect(bloc.state, equals(UserUnauthenticatedState()));
        verify(() => mockUserSessionManager.isLoggedIn).called(1);
      },
    );
  });

  group('LoginRequested', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tRole = UserRoles.patient;

    blocTest<AuthBloc, AuthState>(
      'should emit [LoginWithEmailPasswordLoadingState, UserAuthenticatedState] when login is successful',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(() => mockUserSessionManager.updateUser(tUser)).thenReturn(unit);
        when(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).thenAnswer((_) async => const Right(tUser));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(
        LoginRequested(email: tEmail, password: tPassword, role: tRole),
      ),
      expect: () => [
        LoginWithEmailPasswordLoadingState(),
        UserAuthenticatedState(tUser),
      ],
      verify: (_) {
        verify(() => mockUserSessionManager.updateUser(tUser)).called(1);
        verify(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockLoginUseCase);
        verifyZeroInteractions(mockAuthRepository);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [LoginWithEmailPasswordLoadingState, LoginWithEmailPasswordErrorState] when login fails',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(
        LoginRequested(email: tEmail, password: tPassword, role: tRole),
      ),
      expect: () => [
        LoginWithEmailPasswordLoadingState(),
        LoginWithEmailPasswordErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockLoginUseCase);
        verifyZeroInteractions(mockAuthRepository);
      },
    );
  });

  group('RegisterRequested', () {
    const tName = 'Test User';
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    blocTest<AuthBloc, AuthState>(
      'should emit [RegisterWithEmailPasswordLoadingState, RegisterWithEmailPasswordSuccessState] when registration is successful',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(
          () => mockAuthRepository.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Right(tUser));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(
        RegisterRequested(name: tName, email: tEmail, password: tPassword),
      ),
      expect: () => [
        RegisterWithEmailPasswordLoadingState(),
        RegisterWithEmailPasswordSuccessState(),
      ],
      verify: (_) {
        verify(
          () => mockAuthRepository.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [RegisterWithEmailPasswordLoadingState, RegisterWithEmailPasswordErrorState] when registration fails',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(
          () => mockAuthRepository.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(
        RegisterRequested(name: tName, email: tEmail, password: tPassword),
      ),
      expect: () => [
        RegisterWithEmailPasswordLoadingState(),
        RegisterWithEmailPasswordErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(
          () => mockAuthRepository.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );
  });

  group('ContinueWithGoogleRequested', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [ContinueWithGoogleLoadingState, UserAuthenticatedState] when google sign in is successful',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(() => mockUserSessionManager.updateUser(tUser)).thenReturn(unit);
        when(
          () => mockAuthRepository.continueWithGoogle(),
        ).thenAnswer((_) async => const Right(tUser));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(ContinueWithGoogleRequested()),
      expect: () => [
        ContinueWithGoogleLoadingState(),
        UserAuthenticatedState(tUser),
      ],
      verify: (_) {
        verify(() => mockUserSessionManager.updateUser(tUser)).called(1);
        verify(() => mockAuthRepository.continueWithGoogle()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [ContinueWithGoogleLoadingState, ContinueWithGoogleErrorState] when google sign in fails',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(
          () => mockAuthRepository.continueWithGoogle(),
        ).thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(ContinueWithGoogleRequested()),
      expect: () => [
        ContinueWithGoogleLoadingState(),
        ContinueWithGoogleErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.continueWithGoogle()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );
  });

  group('LogoutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [LogoutLoadingState, UserUnauthenticatedState] when logout is successful',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(() => mockUserSessionManager.clearSession()).thenReturn(unit);
        when(
          () => mockAuthRepository.logout(),
        ).thenAnswer((_) async => const Right(unit));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      expect: () => [LogoutLoadingState(), UserUnauthenticatedState()],
      verify: (_) {
        verify(() => mockUserSessionManager.clearSession()).called(1);
        verify(() => mockAuthRepository.logout()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [LogoutLoadingState, LogoutErrorState] when logout fails',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(
          () => mockAuthRepository.logout(),
        ).thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      expect: () => [LogoutLoadingState(), LogoutErrorState(tFailure.message)],
      verify: (_) {
        verify(() => mockAuthRepository.logout()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );
  });

  group('ResetPasswordRequested', () {
    const tEmail = 'test@example.com';

    blocTest<AuthBloc, AuthState>(
      'should emit [ResetUSerPasswordLoadingState, ResetUserPasswordSuccessState] when reset password is successful',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(
          () => mockAuthRepository.resetPassword(email: tEmail),
        ).thenAnswer((_) async => const Right(unit));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(ResetPasswordRequested(email: tEmail)),
      expect: () => [
        ResetUSerPasswordLoadingState(),
        ResetUserPasswordSuccessState(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.resetPassword(email: tEmail)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [ResetUSerPasswordLoadingState, ResetUSerPasswordErrorState] when reset password fails',
      build: () {
        when(() => mockUserSessionManager.isLoggedIn).thenReturn(false);
        when(
          () => mockAuthRepository.resetPassword(email: tEmail),
        ).thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(
          mockAuthRepository,
          mockLoginUseCase,
          mockUserSessionManager,
        );
      },
      act: (bloc) => bloc.add(ResetPasswordRequested(email: tEmail)),
      expect: () => [
        ResetUSerPasswordLoadingState(),
        ResetUSerPasswordErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.resetPassword(email: tEmail)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );
  });

  test('close should dispose userSessionManager', () async {
    when(() => mockUserSessionManager.dispose()).thenReturn(null);
    final authBloc = AuthBloc(
      mockAuthRepository,
      mockLoginUseCase,
      mockUserSessionManager,
    );

    await authBloc.close();

    verify(() => mockUserSessionManager.dispose()).called(1);
  });
}
