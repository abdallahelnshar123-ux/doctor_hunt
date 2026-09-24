import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/auth_user_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/my_user_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/firebase_services/auth_service.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/firebase_services/user_firestore_service.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUserFirestoreService extends Mock implements UserFirestoreService {}

class MockUserPrefs extends Mock implements UserPrefs {}

void main() {
  late AuthRepository repository;
  late MockAuthService mockAuthService;
  late MockUserFirestoreService mockFirestoreService;
  late MockUserPrefs mockUserPrefs;

  const tAuthUserDto = AuthUserDto(
    id: 'user_123',
    email: 'test@example.com',
    name: 'Test User',
  );

  const tMyUserDto = MyUserDto(
    id: 'user_123',
    email: 'test@example.com',
    name: 'Test User',
    provider: UserAuthProvider.google,
    role: UserRoles.patient,
  );

  final tMyUser = tMyUserDto.toUser();

  setUpAll(() {
    registerFallbackValue(
      const MyUserDto(
        id: 'fallback_id',
        email: 'fallback@example.com',
        name: 'Fallback Name',
        provider: UserAuthProvider.google,
      ),
    );
  });

  setUp(() {
    mockAuthService = MockAuthService();
    mockFirestoreService = MockUserFirestoreService();
    mockUserPrefs = MockUserPrefs();
    repository = AuthRepository(
      mockAuthService,
      mockFirestoreService,
      mockUserPrefs,
    );
  });

  group('getCurrentUser', () {
    test('should return MyUser when user exists in UserPrefs', () {
      // Arrange
      when(() => mockUserPrefs.getCurrentUser()).thenReturn(tMyUserDto);

      // Act
      final result = repository.getCurrentUser();

      // Assert
      expect(result, Right(tMyUser));
      verify(() => mockUserPrefs.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockUserPrefs);
      verifyZeroInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
    });

    test('should return UnauthorizedFailure when user does not exist in UserPrefs', () {
      // Arrange
      when(() => mockUserPrefs.getCurrentUser()).thenReturn(null);

      // Act
      final result = repository.getCurrentUser();

      // Assert
      expect(
        result,
        Left(UnauthorizedFailure(t.errors.some_thing_went_wrong)),
      );
      verify(() => mockUserPrefs.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockUserPrefs);
      verifyZeroInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
    });

    test('should return UnexpectedFailure when an unexpected error occurs', () {
      // Arrange
      final tException = Exception('Failed to read prefs');
      when(() => mockUserPrefs.getCurrentUser()).thenThrow(tException);

      // Act
      final result = repository.getCurrentUser();

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockUserPrefs.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockUserPrefs);
      verifyZeroInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
    });
  });

  group('continueWithGoogle', () {
    test('should create new user, save to firestore and userPrefs, and return MyUser when user does not exist in database', () async {
      // Arrange
      when(() => mockAuthService.continueWithGoogle())
          .thenAnswer((_) async => tAuthUserDto);
      when(() => mockFirestoreService.getUser(tAuthUserDto.id))
          .thenAnswer((_) async => null);
      when(() => mockFirestoreService.addUser(any()))
          .thenAnswer((_) async {});
      when(() => mockUserPrefs.setUser(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.continueWithGoogle();

      // Assert
      expect(result, Right(tMyUser));
      verify(() => mockAuthService.continueWithGoogle()).called(1);
      verify(() => mockFirestoreService.getUser(tAuthUserDto.id)).called(1);
      verify(() => mockFirestoreService.addUser(tMyUserDto)).called(1);
      verify(() => mockUserPrefs.setUser(tMyUserDto)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyNoMoreInteractions(mockFirestoreService);
      verifyNoMoreInteractions(mockUserPrefs);
    });

    test('should save user to userPrefs and return MyUser when user already exists in database', () async {
      // Arrange
      when(() => mockAuthService.continueWithGoogle())
          .thenAnswer((_) async => tAuthUserDto);
      when(() => mockFirestoreService.getUser(tAuthUserDto.id))
          .thenAnswer((_) async => tMyUserDto);
      when(() => mockUserPrefs.setUser(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.continueWithGoogle();

      // Assert
      expect(result, Right(tMyUser));
      verify(() => mockAuthService.continueWithGoogle()).called(1);
      verify(() => mockFirestoreService.getUser(tAuthUserDto.id)).called(1);
      verify(() => mockUserPrefs.setUser(tMyUserDto)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyNoMoreInteractions(mockFirestoreService);
      verifyNoMoreInteractions(mockUserPrefs);
    });

    test('should return Failure when AuthService throws AppException', () async {
      // Arrange
      const tException = ServerException(message: 'Google Sign In Failed');
      when(() => mockAuthService.continueWithGoogle())
          .thenThrow(tException);

      // Act
      final result = await repository.continueWithGoogle();

      // Assert
      expect(result, const Left(ServerFailure('Google Sign In Failed')));
      verify(() => mockAuthService.continueWithGoogle()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return UnexpectedFailure when an unexpected error occurs', () async {
      // Arrange
      final tException = Exception('Unexpected error');
      when(() => mockAuthService.continueWithGoogle())
          .thenThrow(tException);

      // Act
      final result = await repository.continueWithGoogle();

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockAuthService.continueWithGoogle()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });
  });

  group('registerWithEmailAndPassword', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tName = 'Test User';

    const tRegisterAuthUserDto = AuthUserDto(
      id: 'user_123',
      email: tEmail,
      name: tName,
    );

    const tRegisterUser = MyUser(
      id: 'user_123',
      email: tEmail,
      name: tName,
      provider: UserAuthProvider.emailPassword,
      role: UserRoles.patient,
    );

    final tRegisterUserDto = tRegisterUser.toMyUserDto();

    test('should add user to firestore, save to userPrefs, and return MyUser when registration is successful', () async {
      // Arrange
      when(() => mockAuthService.registerWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenAnswer((_) async => tRegisterAuthUserDto);
      when(() => mockFirestoreService.addUser(any()))
          .thenAnswer((_) async {});
      when(() => mockUserPrefs.setUser(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.registerWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
        name: tName,
      );

      // Assert
      expect(result, const Right(tRegisterUser));
      verify(() => mockAuthService.registerWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verify(() => mockFirestoreService.addUser(tRegisterUserDto)).called(1);
      verify(() => mockUserPrefs.setUser(tRegisterUserDto)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyNoMoreInteractions(mockFirestoreService);
      verifyNoMoreInteractions(mockUserPrefs);
    });

    test('should return Failure when AuthService throws AppException', () async {
      // Arrange
      const tException = ServerException(message: 'Email already in use');
      when(() => mockAuthService.registerWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenThrow(tException);

      // Act
      final result = await repository.registerWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
        name: tName,
      );

      // Assert
      expect(result, const Left(ServerFailure('Email already in use')));
      verify(() => mockAuthService.registerWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return UnexpectedFailure when unexpected exception occurs', () async {
      // Arrange
      final tException = Exception('Registration failed');
      when(() => mockAuthService.registerWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenThrow(tException);

      // Act
      final result = await repository.registerWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
        name: tName,
      );

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockAuthService.registerWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });
  });

  group('loginWithEmailAndPassword', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    test('should fetch user from firestore, save to userPrefs, and return MyUser when login is successful', () async {
      // Arrange
      when(() => mockAuthService.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenAnswer((_) async => tAuthUserDto);
      when(() => mockFirestoreService.getUser(tAuthUserDto.id))
          .thenAnswer((_) async => tMyUserDto);
      when(() => mockUserPrefs.setUser(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.loginWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result, Right(tMyUser));
      verify(() => mockAuthService.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verify(() => mockFirestoreService.getUser(tAuthUserDto.id)).called(1);
      verify(() => mockUserPrefs.setUser(tMyUserDto)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyNoMoreInteractions(mockFirestoreService);
      verifyNoMoreInteractions(mockUserPrefs);
    });

    test('should return UnauthorizedFailure when user is not found in database', () async {
      // Arrange
      when(() => mockAuthService.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenAnswer((_) async => tAuthUserDto);
      when(() => mockFirestoreService.getUser(tAuthUserDto.id))
          .thenAnswer((_) async => null);

      // Act
      final result = await repository.loginWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(
        result,
        Left(UnauthorizedFailure(t.errors.some_thing_went_wrong)),
      );
      verify(() => mockAuthService.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verify(() => mockFirestoreService.getUser(tAuthUserDto.id)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyNoMoreInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return Failure when AuthService throws AppException', () async {
      // Arrange
      const tException = ServerException(message: 'Invalid credentials');
      when(() => mockAuthService.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenThrow(tException);

      // Act
      final result = await repository.loginWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result, const Left(ServerFailure('Invalid credentials')));
      verify(() => mockAuthService.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return UnexpectedFailure when unexpected exception occurs', () async {
      // Arrange
      final tException = Exception('Login failed');
      when(() => mockAuthService.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenThrow(tException);

      // Act
      final result = await repository.loginWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockAuthService.loginWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });
  });

  group('logout', () {
    test('should call AuthService logout and clear UserPrefs when successful', () async {
      // Arrange
      when(() => mockAuthService.logout()).thenAnswer((_) async {});
      when(() => mockUserPrefs.clearUser()).thenAnswer((_) async {});

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, const Right(unit));
      verify(() => mockAuthService.logout()).called(1);
      verify(() => mockUserPrefs.clearUser()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyNoMoreInteractions(mockUserPrefs);
      verifyZeroInteractions(mockFirestoreService);
    });

    test('should return Failure when AuthService logout throws AppException', () async {
      // Arrange
      const tException = ServerException(message: 'Logout failed');
      when(() => mockAuthService.logout()).thenThrow(tException);

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, const Left(ServerFailure('Logout failed')));
      verify(() => mockAuthService.logout()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockUserPrefs);
      verifyZeroInteractions(mockFirestoreService);
    });

    test('should return UnexpectedFailure when unexpected exception occurs', () async {
      // Arrange
      final tException = Exception('Logout unexpected error');
      when(() => mockAuthService.logout()).thenThrow(tException);

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockAuthService.logout()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockUserPrefs);
      verifyZeroInteractions(mockFirestoreService);
    });
  });

  group('deleteAuthUser', () {
    test('should call deleteAccount on AuthService when successful', () async {
      // Arrange
      when(() => mockAuthService.deleteAccount()).thenAnswer((_) async {});

      // Act
      final result = await repository.deleteAuthUser();

      // Assert
      expect(result, const Right(unit));
      verify(() => mockAuthService.deleteAccount()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return Failure when deleteAccount throws AppException', () async {
      // Arrange
      const tException = ServerException(message: 'Delete failed');
      when(() => mockAuthService.deleteAccount()).thenThrow(tException);

      // Act
      final result = await repository.deleteAuthUser();

      // Assert
      expect(result, const Left(ServerFailure('Delete failed')));
      verify(() => mockAuthService.deleteAccount()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return UnexpectedFailure when unexpected exception occurs', () async {
      // Arrange
      final tException = Exception('Delete error');
      when(() => mockAuthService.deleteAccount()).thenThrow(tException);

      // Act
      final result = await repository.deleteAuthUser();

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockAuthService.deleteAccount()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });
  });

  group('reAuthenticateWithEmailAndPassword', () {
    const tPassword = 'password123';

    test('should return user ID when re-authentication is successful', () async {
      // Arrange
      when(() => mockAuthService.reAuthenticate(password: tPassword))
          .thenAnswer((_) async => tAuthUserDto);

      // Act
      final result = await repository.reAuthenticateWithEmailAndPassword(tPassword);

      // Assert
      expect(result, const Right('user_123'));
      verify(() => mockAuthService.reAuthenticate(password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return Failure when reAuthenticate throws AppException', () async {
      // Arrange
      const tException = ServerException(message: 'Re-auth failed');
      when(() => mockAuthService.reAuthenticate(password: tPassword))
          .thenThrow(tException);

      // Act
      final result = await repository.reAuthenticateWithEmailAndPassword(tPassword);

      // Assert
      expect(result, const Left(ServerFailure('Re-auth failed')));
      verify(() => mockAuthService.reAuthenticate(password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return UnexpectedFailure when unexpected exception occurs', () async {
      // Arrange
      final tException = Exception('Re-auth error');
      when(() => mockAuthService.reAuthenticate(password: tPassword))
          .thenThrow(tException);

      // Act
      final result = await repository.reAuthenticateWithEmailAndPassword(tPassword);

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockAuthService.reAuthenticate(password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });
  });

  group('reAuthenticateWithGoogle', () {
    test('should return user ID when Google re-authentication is successful', () async {
      // Arrange
      when(() => mockAuthService.reAuthenticateWithGoogle())
          .thenAnswer((_) async => tAuthUserDto);

      // Act
      final result = await repository.reAuthenticateWithGoogle();

      // Assert
      expect(result, const Right('user_123'));
      verify(() => mockAuthService.reAuthenticateWithGoogle()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return Failure when reAuthenticateWithGoogle throws AppException', () async {
      // Arrange
      const tException = ServerException(message: 'Google Re-auth failed');
      when(() => mockAuthService.reAuthenticateWithGoogle())
          .thenThrow(tException);

      // Act
      final result = await repository.reAuthenticateWithGoogle();

      // Assert
      expect(result, const Left(ServerFailure('Google Re-auth failed')));
      verify(() => mockAuthService.reAuthenticateWithGoogle()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return UnexpectedFailure when unexpected exception occurs', () async {
      // Arrange
      final tException = Exception('Google Re-auth error');
      when(() => mockAuthService.reAuthenticateWithGoogle())
          .thenThrow(tException);

      // Act
      final result = await repository.reAuthenticateWithGoogle();

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockAuthService.reAuthenticateWithGoogle()).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });
  });

  group('resetPassword', () {
    const tEmail = 'test@example.com';

    test('should call resetPassword on AuthService when successful', () async {
      // Arrange
      when(() => mockAuthService.resetPassword(email: tEmail))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.resetPassword(email: tEmail);

      // Assert
      expect(result, const Right(unit));
      verify(() => mockAuthService.resetPassword(email: tEmail)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return Failure when resetPassword throws AppException', () async {
      // Arrange
      const tException = ServerException(message: 'Reset password failed');
      when(() => mockAuthService.resetPassword(email: tEmail))
          .thenThrow(tException);

      // Act
      final result = await repository.resetPassword(email: tEmail);

      // Assert
      expect(result, const Left(ServerFailure('Reset password failed')));
      verify(() => mockAuthService.resetPassword(email: tEmail)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });

    test('should return UnexpectedFailure when unexpected exception occurs', () async {
      // Arrange
      final tException = Exception('Reset password error');
      when(() => mockAuthService.resetPassword(email: tEmail))
          .thenThrow(tException);

      // Act
      final result = await repository.resetPassword(email: tEmail);

      // Assert
      expect(result, Left(UnexpectedFailure(tException.toString())));
      verify(() => mockAuthService.resetPassword(email: tEmail)).called(1);
      verifyNoMoreInteractions(mockAuthService);
      verifyZeroInteractions(mockFirestoreService);
      verifyZeroInteractions(mockUserPrefs);
    });
  });
}
