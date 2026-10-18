import 'package:doctor_hunt/apps/features/common/auth/data/mappers/auth_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/auth_user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
  });

  group('AuthUserDtoMapper (UserCredential.toAuthUserDto)', () {
    test('should map user fields correctly when user is not null', () {
      when(() => mockUser.uid).thenReturn('uid_123');
      when(() => mockUser.email).thenReturn('user@example.com');
      when(() => mockUser.displayName).thenReturn('User Name');
      when(() => mockUserCredential.user).thenReturn(mockUser);

      final result = mockUserCredential.toAuthUserDto();

      expect(
        result,
        equals(
          const AuthUserDto(
            id: 'uid_123',
            email: 'user@example.com',
            name: 'User Name',
          ),
        ),
      );
    });

    test('should fallback to empty strings when user fields are null', () {
      when(() => mockUser.uid).thenReturn('uid_123');
      when(() => mockUser.email).thenReturn(null);
      when(() => mockUser.displayName).thenReturn(null);
      when(() => mockUserCredential.user).thenReturn(mockUser);

      final result = mockUserCredential.toAuthUserDto();

      expect(
        result,
        equals(
          const AuthUserDto(
            id: 'uid_123',
            email: '',
            name: '',
          ),
        ),
      );
    });

    test('should fallback to empty strings when user is null', () {
      when(() => mockUserCredential.user).thenReturn(null);

      final result = mockUserCredential.toAuthUserDto();

      expect(
        result,
        equals(
          const AuthUserDto(
            id: '',
            email: '',
            name: '',
          ),
        ),
      );
    });
  });
}
