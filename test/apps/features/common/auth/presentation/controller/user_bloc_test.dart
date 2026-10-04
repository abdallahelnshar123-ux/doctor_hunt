import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/patient_info.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/user_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late UserBloc userBloc;

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
    when(() => mockAuthRepository.currentUser).thenReturn(tUser);
    when(() => mockAuthRepository.userStream)
        .thenAnswer((_) => Stream.value(tUser));

    userBloc = UserBloc(mockAuthRepository);
  });

  tearDown(() {
    userBloc.close();
  });

  test('initial state should contain current user from repository', () {
    expect(userBloc.state, equals(const UserState(user: tUser)));
  });

  group('ToggleFavoriteDoctorEvent', () {
    blocTest<UserBloc, UserState>(
      'should optimistically add doctorId and emit updated state on success',
      build: () {
        when(() => mockAuthRepository.toggleFavoriteDoctor('doc_2'))
            .thenAnswer((_) async => const Right(tUserWithFavDoc2));
        return userBloc;
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [
        const UserState(user: tUserWithFavDoc2, favoriteError: null),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.toggleFavoriteDoctor('doc_2')).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'should optimistically update and then rollback with error message on repository failure',
      build: () {
        when(() => mockAuthRepository.toggleFavoriteDoctor('doc_2'))
            .thenAnswer((_) async => const Left(ServerFailure('Network error')));
        return userBloc;
      },
      act: (bloc) => bloc.add(const ToggleFavoriteDoctorEvent('doc_2')),
      expect: () => [
        const UserState(user: tUserWithFavDoc2, favoriteError: null),
        const UserState(user: tUser, favoriteError: 'Network error'),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.toggleFavoriteDoctor('doc_2')).called(1);
      },
    );
  });
}
