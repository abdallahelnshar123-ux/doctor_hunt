import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/admin_info.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/patient_info.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/admin_info_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/my_user_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/patient_info_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyUserDtoMapper (MyUser.toMyUserDto)', () {
    test('should map all fields correctly when all fields are present', () {
      const user = MyUser(
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

      final dto = user.toMyUserDto();

      const expectedDto = MyUserDto(
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

      expect(dto, equals(expectedDto));
    });

    test('should map correctly when nullable fields are null', () {
      const user = MyUser(
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

      final dto = user.toMyUserDto();

      const expectedDto = MyUserDto(
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

      expect(dto, equals(expectedDto));
    });
  });
}
