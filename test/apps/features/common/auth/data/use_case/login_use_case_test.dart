import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/use_case/login_use_case.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tPatientUser = MyUser(
    id: '123',
    email: tEmail,
    name: 'Patient User',
    provider: UserAuthProvider.emailPassword,
    role: UserRoles.patient,
  );

  const tFailure = ServerFailure('Server error');

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  group('LoginUseCase', () {
    test(
      'should return Right(MyUser) when repository returns user with matching role',
      () async {
        // Arrange
        when(
          () => mockAuthRepository.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Right(tPatientUser));

        // Act
        final result = await loginUseCase.login(
          role: UserRoles.patient,
          email: tEmail,
          password: tPassword,
        );

        // Assert
        expect(result, equals(const Right(tPatientUser)));
        verify(
          () => mockAuthRepository.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    test(
      'should return Left(UnauthorizedFailure) when user role does not match requested role',
      () async {
        // Arrange
        when(
          () => mockAuthRepository.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Right(tPatientUser));

        // Act
        final result = await loginUseCase.login(
          role: UserRoles.admin,
          email: tEmail,
          password: tPassword,
        );

        // Assert
        expect(
          result,
          equals(Left(UnauthorizedFailure(t.errors.no_account_associated))),
        );
        verify(
          () => mockAuthRepository.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    test(
      'should return Left(Failure) when repository login fails',
      () async {
        // Arrange
        when(
          () => mockAuthRepository.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).thenAnswer((_) async => const Left(tFailure));

        // Act
        final result = await loginUseCase.login(
          role: UserRoles.patient,
          email: tEmail,
          password: tPassword,
        );

        // Assert
        expect(result, equals(const Left(tFailure)));
        verify(
          () => mockAuthRepository.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}
