import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/admin_info.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/patient_info.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/admin_info_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/my_user_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/patient_info_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserMapper (MyUserDto.toUser)', () {
    test('should map all fields correctly when all fields are present', () {
      const dto = MyUserDto(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
        provider: UserAuthProvider.google,
        image: 'https://example.com/avatar.jpg',
        role: UserRoles.patient,
        phone: '+1234567890',
        patientInfo: PatientInfoDto(favDoctors: ['doc1', 'doc2']),
        adminInfo: AdminInfoDto(),
      );

      final user = dto.toUser();

      const expectedUser = MyUser(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
        provider: UserAuthProvider.google,
        image: 'https://example.com/avatar.jpg',
        role: UserRoles.patient,
        phone: '+1234567890',
        patientInfo: PatientInfo(favDoctors: ['doc1', 'doc2']),
        adminInfo: AdminInfo(),
      );

      expect(user, equals(expectedUser));
    });

    test('should map correctly when nullable fields are null', () {
      const dto = MyUserDto(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
        provider: UserAuthProvider.emailPassword,
        image: null,
        role: null,
        phone: null,
        patientInfo: null,
        adminInfo: null,
      );

      final user = dto.toUser();

      const expectedUser = MyUser(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
        provider: UserAuthProvider.emailPassword,
        image: null,
        role: null,
        phone: null,
        patientInfo: null,
        adminInfo: null,
      );

      expect(user, equals(expectedUser));
    });
  });
}
