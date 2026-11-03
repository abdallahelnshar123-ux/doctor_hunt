import '../../../../../../core/constants/firestore_constants.dart';
import '../../../domain/entity/user/user_roles.dart';
import '../../models/user/auth_providers.dart';
import 'app_user_dto.dart';

class PatientDto extends AppUserDto {
  final List<String> favDoctors;
  final bool active;

  const PatientDto({
    required super.id,
    required super.email,
    required super.name,
    required super.provider,
    super.image,
    super.phone,
    this.favDoctors = const [],
    this.active = true,
  }) : super(role: UserRoles.patient);

  factory PatientDto.fromJson(Map<String, dynamic> json) {
    final patientInfo =
        json[FirestoreConstants.patientInfo] as Map<String, dynamic>?;
    final favDoctorsList = patientInfo?[FirestoreConstants.favDoctors] as List?;

    return PatientDto(
      id: json[FirestoreConstants.id]?.toString() ?? '',
      name: json[FirestoreConstants.name]?.toString() ?? '',
      email: json[FirestoreConstants.email]?.toString() ?? '',
      provider: UserAuthProvider.values.firstWhere(
        (element) => element.name == json[FirestoreConstants.provider],
        orElse: () => UserAuthProvider.emailPassword,
      ),
      image: json[FirestoreConstants.image]?.toString(),
      phone: json[FirestoreConstants.phone]?.toString(),
      favDoctors: favDoctorsList?.map((e) => e.toString()).toList() ?? const [],
      active: json[FirestoreConstants.active] ?? true,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.name: name,
      FirestoreConstants.email: email,
      FirestoreConstants.provider: provider.name,
      FirestoreConstants.image: image,
      FirestoreConstants.role: role.name,
      FirestoreConstants.phone: phone,
      FirestoreConstants.active: active,
      FirestoreConstants.patientInfo: {
        FirestoreConstants.favDoctors: favDoctors,
      },
    };
  }

  @override
  List<Object?> get props => [...super.props, favDoctors, active];
}
