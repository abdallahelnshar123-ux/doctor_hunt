import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/use_case/login_use_case.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockLoginUseCase mockLoginUseCase;
  late AuthBloc authBloc;

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
    authBloc = AuthBloc(mockAuthRepository, mockLoginUseCase);
  });

  tearDown(() {
    authBloc.close();
  });

  test('should have initial state as UserInitial', () {
    expect(authBloc.state, equals(UserInitial()));
  });

  group('CheckAuthStatusRequested', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [UserAuthenticatedState] when getCurrentUser returns MyUser',
      build: () {
        when(() => mockAuthRepository.getCurrentUser())
            .thenReturn(const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(CheckAuthStatusRequested()),
      expect: () => [UserAuthenticatedState(tUser)],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [UserUnauthenticatedState] when getCurrentUser returns Failure',
      build: () {
        when(() => mockAuthRepository.getCurrentUser())
            .thenReturn(const Left(tFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(CheckAuthStatusRequested()),
      expect: () => [UserUnauthenticatedState()],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
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
        when(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        LoginRequested(email: tEmail, password: tPassword, role: tRole),
      ),
      expect: () => [
        LoginWithEmailPasswordLoadingState(),
        UserAuthenticatedState(tUser),
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

    blocTest<AuthBloc, AuthState>(
      'should emit [LoginWithEmailPasswordLoadingState, LoginWithEmailPasswordErrorState] when login fails',
      build: () {
        when(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
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
      'should emit [RegisterWithEmailPasswordLoadingState, UserAuthenticatedState] when registration is successful',
      build: () {
        when(
          () => mockAuthRepository.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        RegisterRequested(name: tName, email: tEmail, password: tPassword),
      ),
      expect: () => [
        RegisterWithEmailPasswordLoadingState(),
        UserAuthenticatedState(tUser),
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
        when(
          () => mockAuthRepository.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
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
        when(() => mockAuthRepository.continueWithGoogle())
            .thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(ContinueWithGoogleRequested()),
      expect: () => [
        ContinueWithGoogleLoadingState(),
        UserAuthenticatedState(tUser),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.continueWithGoogle()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [ContinueWithGoogleLoadingState, ContinueWithGoogleErrorState] when google sign in fails',
      build: () {
        when(() => mockAuthRepository.continueWithGoogle())
            .thenAnswer((_) async => const Left(tFailure));
        return authBloc;
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
        when(() => mockAuthRepository.logout())
            .thenAnswer((_) async => const Right(unit));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      expect: () => [
        LogoutLoadingState(),
        UserUnauthenticatedState(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.logout()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [LogoutLoadingState, LogoutErrorState] when logout fails',
      build: () {
        when(() => mockAuthRepository.logout())
            .thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      expect: () => [
        LogoutLoadingState(),
        LogoutErrorState(tFailure.message),
      ],
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
        when(() => mockAuthRepository.resetPassword(email: tEmail))
            .thenAnswer((_) async => const Right(unit));
        return authBloc;
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
        when(() => mockAuthRepository.resetPassword(email: tEmail))
            .thenAnswer((_) async => const Left(tFailure));
        return authBloc;
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
}
