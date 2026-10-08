import 'package:equatable/equatable.dart';

import '../../../../../../core/constants/firestore_constants.dart';
import '../user/patient_info.dart';

class PatientInfoDto extends Equatable {
  final List<String> favDoctors;

  const PatientInfoDto({this.favDoctors = const []});

  factory PatientInfoDto.fromFireStore(Map<String, dynamic>? data) {
    if (data == null) return const PatientInfoDto();
    return PatientInfoDto(
      favDoctors:
          (data[FirestoreConstants.favDoctors] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {FirestoreConstants.favDoctors: favDoctors};
  }

  PatientInfo toDomain() => PatientInfo(favDoctors: favDoctors);

  factory PatientInfoDto.fromDomain(PatientInfo info) =>
      PatientInfoDto(favDoctors: info.favDoctors);

  @override
  List<Object?> get props => [favDoctors];
}
