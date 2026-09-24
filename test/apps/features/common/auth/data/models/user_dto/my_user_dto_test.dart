import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/my_user_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMyUserDto = MyUserDto(
    id: 'user_123',
    email: 'john@example.com',
    name: 'John Doe',
    provider: UserAuthProvider.google,
    image: 'https://example.com/photo.jpg',
    role: UserRoles.patient,
  );

  final tMap = <String, dynamic>{
    FirestoreConstants.id: 'user_123',
    FirestoreConstants.name: 'John Doe',
    FirestoreConstants.email: 'john@example.com',
    FirestoreConstants.provider: 'google',
    FirestoreConstants.image: 'https://example.com/photo.jpg',
    FirestoreConstants.role: 'patient',
  };

  group('MyUserDto', () {
    test('should support value equality via Equatable', () {
      const dto1 = MyUserDto(
        id: '1',
        email: 'test@example.com',
        name: 'Test',
        provider: UserAuthProvider.emailPassword,
      );
      const dto2 = MyUserDto(
        id: '1',
        email: 'test@example.com',
        name: 'Test',
        provider: UserAuthProvider.emailPassword,
      );

      expect(dto1, equals(dto2));
    });

    group('fromFireStore / fromJson', () {
      test(
        'should return a valid MyUserDto when map contains complete valid data',
        () {
          final result = MyUserDto.fromFireStore(tMap);

          expect(result, equals(tMyUserDto));
        },
      );

      test('should return a valid MyUserDto via fromJson alias', () {
        final result = MyUserDto.fromJson(tMap);

        expect(result, equals(tMyUserDto));
      });

      test(
        'should handle missing or null fields with appropriate default values',
        () {
          final emptyMap = <String, dynamic>{};

          final result = MyUserDto.fromFireStore(emptyMap);

          expect(result.id, equals(''));
          expect(result.name, equals(''));
          expect(result.email, equals(''));
          expect(result.provider, equals(UserAuthProvider.emailPassword));
          expect(result.image, isNull);
          expect(result.role, isNull);
        },
      );

      test(
        'should fallback provider to emailPassword when provider string is unknown',
        () {
          final mapWithUnknownProvider = <String, dynamic>{
            FirestoreConstants.provider: 'unknown_provider',
          };

          final result = MyUserDto.fromFireStore(mapWithUnknownProvider);

          expect(result.provider, equals(UserAuthProvider.emailPassword));
        },
      );

      test('should fallback role to patient when role string is unknown', () {
        final mapWithUnknownRole = <String, dynamic>{
          FirestoreConstants.role: 'unknown_role',
        };

        final result = MyUserDto.fromFireStore(mapWithUnknownRole);

        expect(result.role, equals(UserRoles.patient));
      });

      test('should preserve null image and role when values are null', () {
        final result = MyUserDto.fromFireStore({
          FirestoreConstants.image: null,
          FirestoreConstants.role: null,
        });

        expect(result.image, isNull);
        expect(result.role, isNull);
      });
    });

    group('toFireStore / toJson', () {
      test('should return a Map containing correct data', () {
        final result = tMyUserDto.toFireStore();

        expect(result, equals(tMap));
      });

      test('should return a Map containing correct data via toJson alias', () {
        final result = tMyUserDto.toJson();

        expect(result, equals(tMap));
      });
      test('should serialize null image and role correctly', () {
        const dto = MyUserDto(
          id: '1',
          email: 'test@example.com',
          name: 'Test',
          provider: UserAuthProvider.emailPassword,
        );

        expect(dto.toFireStore(), {
          FirestoreConstants.id: '1',
          FirestoreConstants.name: 'Test',
          FirestoreConstants.email: 'test@example.com',
          FirestoreConstants.provider: 'emailPassword',
          FirestoreConstants.image: null,
          FirestoreConstants.role: null,
        });
      });
    });
  });
}
