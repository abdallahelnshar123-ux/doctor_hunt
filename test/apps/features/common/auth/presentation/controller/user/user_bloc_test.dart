import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/patient_info.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user/user_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockUserSessionManager extends Mock implements UserSessionManager {}
class FakeMyUser extends Fake implements MyUser {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUserSessionManager mockUserSessionManager;

  const tUser = MyUser(
    id: '123',
    email: 'test@example.com',
    name: 'Test User',
    provider: UserAuthProvider.emailPassword,
    role: UserRoles.patient,
    patientInfo: PatientInfo(favDoctors: ['doc_1']),
  );

  const tUserWithFavDoc2 = MyUser(
    id: '123',
    email: 'test@example.com',
    name: 'Test User',
    provider: UserAuthProvider.emailPassword,
    role: UserRoles.patient,
    patientInfo: PatientInfo(favDoctors: ['doc_1', 'doc_2']),
  );

  setUpAll(() {
    registerFallbackValue(FakeMyUser());
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserSessionManager = MockUserSessionManager();
  });

  test('initial state should contain current user from repository', () {
    when(() => mockUserSessionManager.currentUser).thenReturn(tUser);
    when(() => mockUserSessionManager.userStream)
        .thenAnswer((_) => Stream.empty());

    final userBloc = UserBloc(mockAuthRepository, mockUserSessionManager);

    expect(userBloc.state, equals(const UserState(user: tUser)));

    verify(() => mockUserSessionManager.currentUser).called(1);
    verify(() => mockUserSessionManager.userStream).called(1);
    verifyNoMoreInteractions(mockUserSessionManager);
    verifyZeroInteractions(mockAuthRepository);

    userBloc.close();
  });

  group('UserStreamUpdatedEvent', () {
    blocTest<UserBloc, UserState>(
      'should emit updated state when userStream emits new user',
      build: () {
        when(() => mockUserSessionManager.currentUser).thenReturn(tUser);
        when(() => mockUserSessionManager.userStream)
            .thenAnswer((_) => Stream.value(tUserWithFavDoc2));

        return UserBloc(mockAuthRepository, mockUserSessionManager);
      },
      expect: () => [
        const UserState(user: tUserWithFavDoc2, favoriteError: null),
      ],
      verify: (_) {
        verify(() => mockUserSessionManager.currentUser).called(1);
        verify(() => mockUserSessionManager.userStream).called(1);
        verifyNoMoreInteractions(mockUserSessionManager);
        verifyZeroInteractions(mockAuthRepository);
      },
    );
  });

  group('ToggleFavoriteDoctorEvent', () {
    blocTest<UserBloc, UserState>(
      'should optimistically add doctorId and emit updated state on success',
      build: () {
        when(() => mockUserSessionManager.currentUser).thenReturn(tUser);
        when(() => mockUserSessionManager.userStream)
            .thenAnswer((_) => Stream.empty());
        when(() => mockAuthRepository.toggleFavoriteDoctor('doc_2', tUser))
            .thenAnswer((_) async => const Right(tUserWithFavDoc2));

        return UserBloc(mockAuthRepository, mockUserSessionManager);
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [
        const UserState(user: tUserWithFavDoc2, favoriteError: null),
      ],
      verify: (_) {
        verify(() => mockUserSessionManager.currentUser).called(1);
        verify(() => mockUserSessionManager.userStream).called(1);
        // updateUser is called first optimistically, then again on success
        verify(() => mockUserSessionManager.updateUser(tUserWithFavDoc2)).called(2);

        verify(() => mockAuthRepository.toggleFavoriteDoctor('doc_2', tUser)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyNoMoreInteractions(mockUserSessionManager);
      },
    );

    blocTest<UserBloc, UserState>(
      'should optimistically remove doctorId if already present and emit updated state on success',
      build: () {
        when(() => mockUserSessionManager.currentUser).thenReturn(tUserWithFavDoc2);
        when(() => mockUserSessionManager.userStream)
            .thenAnswer((_) => Stream.empty());
        when(() => mockAuthRepository.toggleFavoriteDoctor('doc_2', tUserWithFavDoc2))
            .thenAnswer((_) async => const Right(tUser));

        return UserBloc(mockAuthRepository, mockUserSessionManager);
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [
        const UserState(user: tUser, favoriteError: null),
      ],
      verify: (_) {
        verify(() => mockUserSessionManager.currentUser).called(1);
        verify(() => mockUserSessionManager.userStream).called(1);
        verify(() => mockUserSessionManager.updateUser(tUser)).called(2);

        verify(() => mockAuthRepository.toggleFavoriteDoctor('doc_2', tUserWithFavDoc2)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyNoMoreInteractions(mockUserSessionManager);
      },
    );

    blocTest<UserBloc, UserState>(
      'should optimistically update and then rollback with error message on repository failure',
      build: () {
        when(() => mockUserSessionManager.currentUser).thenReturn(tUser);
        when(() => mockUserSessionManager.userStream)
            .thenAnswer((_) => Stream.empty());
        when(() => mockAuthRepository.toggleFavoriteDoctor('doc_2', tUser))
            .thenAnswer((_) async => const Left(ServerFailure('Network error')));

        return UserBloc(mockAuthRepository, mockUserSessionManager);
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [
        const UserState(user: tUserWithFavDoc2, favoriteError: null),
        const UserState(user: tUser, favoriteError: 'Network error'),
      ],
      verify: (_) {
        verify(() => mockUserSessionManager.currentUser).called(1);
        verify(() => mockUserSessionManager.userStream).called(1);
        verify(() => mockUserSessionManager.updateUser(tUserWithFavDoc2)).called(1);
        verify(() => mockUserSessionManager.updateUser(tUser)).called(1);

        verify(() => mockAuthRepository.toggleFavoriteDoctor('doc_2', tUser)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
        verifyNoMoreInteractions(mockUserSessionManager);
      },
    );

    blocTest<UserBloc, UserState>(
      'should not emit anything if currentUser is null',
      build: () {
        when(() => mockUserSessionManager.currentUser).thenReturn(null);
        when(() => mockUserSessionManager.userStream)
            .thenAnswer((_) => Stream.empty());

        return UserBloc(mockAuthRepository, mockUserSessionManager);
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [],
      verify: (_) {
        verify(() => mockUserSessionManager.currentUser).called(1);
        verify(() => mockUserSessionManager.userStream).called(1);
        verifyNoMoreInteractions(mockUserSessionManager);
        verifyZeroInteractions(mockAuthRepository);
      },
    );
  });
}
