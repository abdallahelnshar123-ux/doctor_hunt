import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
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
  });

  test('should have initial state as AuthInitial', () {
    when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
    authBloc = AuthBloc(mockAuthRepository, mockLoginUseCase);
    // Since add() is async, the state immediately after instantiation is AuthInitial
    expect(authBloc.state, equals(AuthInitial()));
    authBloc.close();
  });

  group('CheckAuthStatusRequested', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [UserAuthenticatedState] when getCurrentUser returns Some(MyUser)',
      build: () {
        when(() => mockAuthRepository.getCurrentUser())
            .thenReturn(Some(tUser));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      // CheckAuthStatusRequested is added in constructor, so we don't need to act
      // Or we can act and it will emit it again, but wait, the constructor already adds it.
      // If we act, it will be added a second time.
      // Let's just expect the initial event's output.
      expect: () => [UserAuthenticatedState(tUser)],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [UserUnauthenticatedState] when getCurrentUser returns none',
      build: () {
        when(() => mockAuthRepository.getCurrentUser())
            .thenReturn(none());
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
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
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).thenAnswer((_) async => const Right(tUser));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(
        LoginRequested(email: tEmail, password: tPassword, role: tRole),
      ),
      // Skip the initial UserUnauthenticatedState emitted by the constructor
      skip: 1,
      expect: () => [
        LoginWithEmailPasswordLoadingState(),
        UserAuthenticatedState(tUser),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verify(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockLoginUseCase);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [LoginWithEmailPasswordLoadingState, LoginWithEmailPasswordErrorState] when login fails',
      build: () {
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(
        LoginRequested(email: tEmail, password: tPassword, role: tRole),
      ),
      skip: 1,
      expect: () => [
        LoginWithEmailPasswordLoadingState(),
        LoginWithEmailPasswordErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verify(
          () => mockLoginUseCase.login(
            email: tEmail,
            password: tPassword,
            role: tRole,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockLoginUseCase);
        verifyNoMoreInteractions(mockAuthRepository);
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
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(
          () => mockAuthRepository.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Right(tUser));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(
        RegisterRequested(name: tName, email: tEmail, password: tPassword),
      ),
      skip: 1,
      expect: () => [
        RegisterWithEmailPasswordLoadingState(),
        RegisterWithEmailPasswordSuccessState(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
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
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(
          () => mockAuthRepository.registerWithEmailAndPassword(
            name: tName,
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(
        RegisterRequested(name: tName, email: tEmail, password: tPassword),
      ),
      skip: 1,
      expect: () => [
        RegisterWithEmailPasswordLoadingState(),
        RegisterWithEmailPasswordErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
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
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(() => mockAuthRepository.continueWithGoogle())
            .thenAnswer((_) async => const Right(tUser));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(ContinueWithGoogleRequested()),
      skip: 1,
      expect: () => [
        ContinueWithGoogleLoadingState(),
        UserAuthenticatedState(tUser),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verify(() => mockAuthRepository.continueWithGoogle()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [ContinueWithGoogleLoadingState, ContinueWithGoogleErrorState] when google sign in fails',
      build: () {
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(() => mockAuthRepository.continueWithGoogle())
            .thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(ContinueWithGoogleRequested()),
      skip: 1,
      expect: () => [
        ContinueWithGoogleLoadingState(),
        ContinueWithGoogleErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
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
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(() => mockAuthRepository.logout())
            .thenAnswer((_) async => const Right(unit));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      skip: 1,
      expect: () => [
        LogoutLoadingState(),
        UserUnauthenticatedState(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verify(() => mockAuthRepository.logout()).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [LogoutLoadingState, LogoutErrorState] when logout fails',
      build: () {
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(() => mockAuthRepository.logout())
            .thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      skip: 1,
      expect: () => [
        LogoutLoadingState(),
        LogoutErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
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
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(() => mockAuthRepository.resetPassword(email: tEmail))
            .thenAnswer((_) async => const Right(unit));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(ResetPasswordRequested(email: tEmail)),
      skip: 1,
      expect: () => [
        ResetUSerPasswordLoadingState(),
        ResetUserPasswordSuccessState(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verify(() => mockAuthRepository.resetPassword(email: tEmail)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [ResetUSerPasswordLoadingState, ResetUSerPasswordErrorState] when reset password fails',
      build: () {
        when(() => mockAuthRepository.getCurrentUser()).thenReturn(none());
        when(() => mockAuthRepository.resetPassword(email: tEmail))
            .thenAnswer((_) async => const Left(tFailure));
        return AuthBloc(mockAuthRepository, mockLoginUseCase);
      },
      act: (bloc) => bloc.add(ResetPasswordRequested(email: tEmail)),
      skip: 1,
      expect: () => [
        ResetUSerPasswordLoadingState(),
        ResetUSerPasswordErrorState(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getCurrentUser()).called(1);
        verify(() => mockAuthRepository.resetPassword(email: tEmail)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyZeroInteractions(mockLoginUseCase);
      },
    );
  });
}
