import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';
import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/my_user_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserPrefs extends Mock implements UserPrefs {}

void main() {
  late MockUserPrefs mockUserPrefs;
  late UserSessionManager userSessionManager;

  const tUser = MyUser(
    id: 'test_id',
    email: 'test@example.com',
    name: 'Test User',
    provider: UserAuthProvider.emailPassword,
  );

  const tUserDto = MyUserDto(
    id: 'test_id',
    email: 'test@example.com',
    name: 'Test User',
    provider: UserAuthProvider.emailPassword,
  );

  setUpAll(() {
    registerFallbackValue(tUserDto);
  });

  setUp(() {
    mockUserPrefs = MockUserPrefs();
    userSessionManager = UserSessionManager(mockUserPrefs);
  });

  tearDown(() {
    userSessionManager.dispose();
  });

  group('UserSessionManager', () {
    test('should have null currentUser initially', () {
      expect(userSessionManager.currentUser, isNull);
    });

    group('updateUser', () {
      test(
          'should update currentUser, call setUser on UserPrefs, and emit to stream when user is not null',
          () async {
        // Arrange
        when(() => mockUserPrefs.setUser(any())).thenAnswer((_) => Future.value());

        // Act & Assert
        final streamFuture = expectLater(
          userSessionManager.userStream,
          emitsInOrder([null, tUser]),
        );
        
        await Future.delayed(Duration.zero);
        userSessionManager.updateUser(tUser);
        
        await streamFuture;

        // Assert
        expect(userSessionManager.currentUser, equals(tUser));
        verify(() => mockUserPrefs.setUser(tUserDto)).called(1);
        verifyNoMoreInteractions(mockUserPrefs);
      });

      test(
          'should clear currentUser, call clearUser on UserPrefs, and emit null to stream when user is null',
          () async {
        // Arrange
        when(() => mockUserPrefs.clearUser()).thenAnswer((_) => Future.value());
        when(() => mockUserPrefs.setUser(any())).thenAnswer((_) => Future.value());
        userSessionManager.updateUser(tUser); // Set initial state
        verify(() => mockUserPrefs.setUser(tUserDto)).called(1); // consume the verify

        // Act & Assert
        final streamFuture = expectLater(
          userSessionManager.userStream,
          emitsInOrder([tUser, null]),
        );
        
        await Future.delayed(Duration.zero);
        userSessionManager.updateUser(null);
        
        await streamFuture;

        // Assert
        expect(userSessionManager.currentUser, isNull);
        verify(() => mockUserPrefs.clearUser()).called(1);
        verifyNoMoreInteractions(mockUserPrefs);
      });
    });

    group('getCurrentUser', () {
      test('should return Some(currentUser) when _currentUser is not null', () {
        // Arrange
        when(() => mockUserPrefs.setUser(any())).thenAnswer((_) => Future.value());
        userSessionManager.updateUser(tUser); // Sets _currentUser
        verify(() => mockUserPrefs.setUser(tUserDto)).called(1);
        clearInteractions(mockUserPrefs); // Clear interactions to test getCurrentUser

        // Act
        final result = userSessionManager.getCurrentUser();

        // Assert
        expect(result, equals(const Some(tUser)));
        verifyZeroInteractions(mockUserPrefs); // Should not read from prefs
      });

      test(
          'should read from UserPrefs and update _currentUser when _currentUser is null and prefs has user',
          () {
        // Arrange
        when(() => mockUserPrefs.getCurrentUser()).thenReturn(tUserDto);

        // Act
        final result = userSessionManager.getCurrentUser();

        // Assert
        expect(result, equals(const Some(tUser)));
        expect(userSessionManager.currentUser, equals(tUser));
        verify(() => mockUserPrefs.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockUserPrefs);
      });

      test(
          'should return none when _currentUser is null and UserPrefs returns null',
          () {
        // Arrange
        when(() => mockUserPrefs.getCurrentUser()).thenReturn(null);

        // Act
        final result = userSessionManager.getCurrentUser();

        // Assert
        expect(result, equals(const None()));
        expect(userSessionManager.currentUser, isNull);
        verify(() => mockUserPrefs.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockUserPrefs);
      });

      test('should return none when UserPrefs throws an exception', () {
        // Arrange
        when(() => mockUserPrefs.getCurrentUser()).thenThrow(Exception());

        // Act
        final result = userSessionManager.getCurrentUser();

        // Assert
        expect(result, equals(const None()));
        expect(userSessionManager.currentUser, isNull);
        verify(() => mockUserPrefs.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockUserPrefs);
      });
    });

    group('clearSession', () {
      test('should call updateUser(null) effectively', () {
        // Arrange
        when(() => mockUserPrefs.clearUser()).thenAnswer((_) => Future.value());

        // Act
        userSessionManager.clearSession();

        // Assert
        expect(userSessionManager.currentUser, isNull);
        verify(() => mockUserPrefs.clearUser()).called(1);
        verifyNoMoreInteractions(mockUserPrefs);
      });
    });

    group('dispose', () {
      test('should close the user stream', () async {
        // Act
        userSessionManager.dispose();

        // Assert
        // A closed stream will yield the initial currentUser (null) and then complete immediately.
        expect(userSessionManager.userStream, emitsInOrder([null, emitsDone]));
      });
    });
  });
}
