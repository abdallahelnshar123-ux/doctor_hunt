import 'package:doctor_hunt/apps/features/common/auth/data/models/user/admin_info.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/admin_info_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tAdminInfoDto = AdminInfoDto();

  group('AdminInfoDto', () {
    test('should support value equality via Equatable', () {
      const dto1 = AdminInfoDto();
      const dto2 = AdminInfoDto();

      expect(dto1, equals(dto2));
    });

    group('fromFireStore', () {
      test('should return a valid AdminInfoDto when data is provided', () {
        final result = AdminInfoDto.fromFireStore({'any_key': 'any_value'});
        expect(result, equals(tAdminInfoDto));
      });

      test('should return AdminInfoDto when data is null', () {
        final result = AdminInfoDto.fromFireStore(null);
        expect(result, equals(tAdminInfoDto));
      });
    });

    group('toFireStore', () {
      test('should return an empty Map', () {
        final result = tAdminInfoDto.toFireStore();
        expect(result, equals({}));
      });
    });

    group('domain mapping', () {
      const tDomain = AdminInfo();

      test('toDomain should return a valid AdminInfo entity', () {
        final result = tAdminInfoDto.toDomain();
        expect(result, equals(tDomain));
      });

      test('fromDomain should create a valid AdminInfoDto', () {
        final result = AdminInfoDto.fromDomain(tDomain);
        expect(result, equals(tAdminInfoDto));
      });
    });
  });
}
