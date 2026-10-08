import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/patient_info.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/patient_info_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tPatientInfoDto = PatientInfoDto(
    favDoctors: ['doc_1', 'doc_2'],
  );

  final tMap = <String, dynamic>{
    FirestoreConstants.favDoctors: ['doc_1', 'doc_2'],
  };

  group('PatientInfoDto', () {
    test('should support value equality via Equatable', () {
      const dto1 = PatientInfoDto(favDoctors: ['doc_1']);
      const dto2 = PatientInfoDto(favDoctors: ['doc_1']);

      expect(dto1, equals(dto2));
    });

    group('fromFireStore', () {
      test('should return a valid PatientInfoDto when data is provided', () {
        final result = PatientInfoDto.fromFireStore(tMap);
        expect(result, equals(tPatientInfoDto));
      });

      test('should return default empty PatientInfoDto when data is null', () {
        final result = PatientInfoDto.fromFireStore(null);
        expect(result, equals(const PatientInfoDto()));
        expect(result.favDoctors, isEmpty);
      });

      test('should return empty list when favDoctors field is missing', () {
        final result = PatientInfoDto.fromFireStore({});
        expect(result.favDoctors, isEmpty);
      });
    });

    group('toFireStore', () {
      test('should return a Map containing correct data', () {
        final result = tPatientInfoDto.toFireStore();
        expect(result, equals(tMap));
      });
    });

    group('domain mapping', () {
      const tDomain = PatientInfo(favDoctors: ['doc_1', 'doc_2']);

      test('toDomain should return a valid PatientInfo entity', () {
        final result = tPatientInfoDto.toDomain();
        expect(result, equals(tDomain));
      });

      test('fromDomain should create a valid PatientInfoDto', () {
        final result = PatientInfoDto.fromDomain(tDomain);
        expect(result, equals(tPatientInfoDto));
      });
    });
  });
}
