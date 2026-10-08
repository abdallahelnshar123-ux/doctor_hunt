import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
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

void main() {
  late MockAuthRepository mockAuthRepository;

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

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  test('initial state should contain current user from repository', () {
    when(() => mockAuthRepository.currentUser).thenReturn(tUser);
    when(() => mockAuthRepository.userStream)
        .thenAnswer((_) => Stream.empty());

    final userBloc = UserBloc(mockAuthRepository);

    expect(userBloc.state, equals(const UserState(user: tUser)));

    verify(() => mockAuthRepository.currentUser).called(1);
    verify(() => mockAuthRepository.userStream).called(1);
    verifyNoMoreInteractions(mockAuthRepository);

    userBloc.close();
  });

  group('UserStreamUpdatedEvent', () {
    blocTest<UserBloc, UserState>(
      'should emit updated state when userStream emits new user',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(() => mockAuthRepository.userStream)
            .thenAnswer((_) => Stream.value(tUserWithFavDoc2));

        return UserBloc(mockAuthRepository);
      },
      expect: () => [
        const UserState(user: tUserWithFavDoc2, favoriteError: null),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.currentUser).called(1);
        verify(() => mockAuthRepository.userStream).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });

  group('ToggleFavoriteDoctorEvent', () {
    blocTest<UserBloc, UserState>(
      'should optimistically add doctorId and emit updated state on success',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(() => mockAuthRepository.userStream)
            .thenAnswer((_) => Stream.empty());
        when(() => mockAuthRepository.toggleFavoriteDoctor('doc_2'))
            .thenAnswer((_) async => const Right(tUserWithFavDoc2));

        return UserBloc(mockAuthRepository);
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [
        const UserState(user: tUserWithFavDoc2, favoriteError: null),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.currentUser).called(1);
        verify(() => mockAuthRepository.userStream).called(1);
        verify(() => mockAuthRepository.toggleFavoriteDoctor('doc_2')).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    blocTest<UserBloc, UserState>(
      'should optimistically remove doctorId if already present and emit updated state on success',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUserWithFavDoc2);
        when(() => mockAuthRepository.userStream)
            .thenAnswer((_) => Stream.empty());
        when(() => mockAuthRepository.toggleFavoriteDoctor('doc_2'))
            .thenAnswer((_) async => const Right(tUser));

        return UserBloc(mockAuthRepository);
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [
        const UserState(user: tUser, favoriteError: null),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.currentUser).called(1);
        verify(() => mockAuthRepository.userStream).called(1);
        verify(() => mockAuthRepository.toggleFavoriteDoctor('doc_2')).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    blocTest<UserBloc, UserState>(
      'should optimistically update and then rollback with error message on repository failure',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(() => mockAuthRepository.userStream)
            .thenAnswer((_) => Stream.empty());
        when(() => mockAuthRepository.toggleFavoriteDoctor('doc_2'))
            .thenAnswer((_) async => const Left(ServerFailure('Network error')));

        return UserBloc(mockAuthRepository);
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [
        const UserState(user: tUserWithFavDoc2, favoriteError: null),
        const UserState(user: tUser, favoriteError: 'Network error'),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.currentUser).called(1);
        verify(() => mockAuthRepository.userStream).called(1);
        verify(() => mockAuthRepository.toggleFavoriteDoctor('doc_2')).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    blocTest<UserBloc, UserState>(
      'should not emit anything if currentUser is null',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(null);
        when(() => mockAuthRepository.userStream)
            .thenAnswer((_) => Stream.empty());

        return UserBloc(mockAuthRepository);
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [],
      verify: (_) {
        verify(() => mockAuthRepository.currentUser).called(1);
        verify(() => mockAuthRepository.userStream).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}
