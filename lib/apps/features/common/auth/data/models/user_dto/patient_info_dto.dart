import 'package:equatable/equatable.dart';

import '../user/patient_info.dart';

class PatientInfoDto extends Equatable {
  final List<String> favDoctors;

  const PatientInfoDto({
    this.favDoctors = const [],
  });

  factory PatientInfoDto.fromFireStore(Map<String, dynamic>? data) {
    if (data == null) return const PatientInfoDto();
    return PatientInfoDto(
      favDoctors: (data['fav_doctors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'fav_doctors': favDoctors,
    };
  }

  PatientInfo toDomain() => PatientInfo(favDoctors: favDoctors);

  factory PatientInfoDto.fromDomain(PatientInfo info) =>
      PatientInfoDto(favDoctors: info.favDoctors);

  @override
  List<Object?> get props => [favDoctors];
}
