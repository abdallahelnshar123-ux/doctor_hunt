import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/rating.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'app_user.dart';
import 'user_roles.dart';

// enum Specialty {
//   allergists,
//   anesthesiologists,
//   cardiologists,
//   rectalSurgeons,
//   dermatologists,
// }

class DoctorEntity extends AppUserEntity {
  final String adminId;
  final SpecialtyModel specialty;
  final bool active;
  final double? consultationFee;
  final Rating rating;
  final DoctorAvailability? availability;

  const DoctorEntity({
    required super.id,
    required super.email,
    required super.name,
    required super.provider,
    super.image,
    super.phone,
    required this.adminId,
    required this.specialty,
    required this.active,
    this.consultationFee,
    required this.rating,
    this.availability,
  }) : super(role: UserRoles.doctor);

  DoctorEntity copyWith({
    String? id,
    String? email,
    String? name,
    UserAuthProvider? provider,
    String? image,
    String? phone,
    String? adminId,
    SpecialtyModel? specialty,
    bool? active,
    double? consultationFee,
    Rating? rating,
    DoctorAvailability? availability,
  }) {
    return DoctorEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      provider: provider ?? this.provider,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      adminId: adminId ?? this.adminId,
      specialty: specialty ?? this.specialty,
      active: active ?? this.active,
      consultationFee: consultationFee ?? this.consultationFee,
      rating: rating ?? this.rating,
      availability: availability ?? this.availability,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    adminId,
    specialty,
    active,
    consultationFee,
    rating,
    availability,
  ];
}
