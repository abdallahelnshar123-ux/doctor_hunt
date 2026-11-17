import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/rating.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';

import 'app_user.dart';
import 'user_roles.dart';

class DoctorEntity extends AppUserEntity {
  final SpecialtyModel specialty;
  final bool active;
  final bool disabled;
  final double? consultationFee;
  final Rating rating;
  final DoctorAvailability? availability;
  final double? latitude;
  final double? longitude;
  final String? clinicAddress;

  const DoctorEntity({
    required super.id,
    required super.email,
    required super.name,
    required super.provider,
    super.image,
    super.phone,
    required this.specialty,
    required this.active,
    this.disabled = false,
    this.consultationFee,
    required this.rating,
    this.availability,
    this.latitude,
    this.longitude,
    this.clinicAddress,
  }) : super(role: UserRoles.doctor);

  DoctorEntity copyWith({
    String? id,
    String? email,
    String? name,
    UserAuthProvider? provider,
    String? image,
    String? phone,
    SpecialtyModel? specialty,
    bool? active,
    bool? disabled,
    double? consultationFee,
    Rating? rating,
    DoctorAvailability? availability,
    double? latitude,
    double? longitude,
    String? clinicAddress,
    bool clearLocation = false,
  }) {
    return DoctorEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      provider: provider ?? this.provider,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      specialty: specialty ?? this.specialty,
      active: active ?? this.active,
      disabled: disabled ?? this.disabled,
      consultationFee: consultationFee ?? this.consultationFee,
      rating: rating ?? this.rating,
      availability: availability ?? this.availability,
      latitude: clearLocation ? null : (latitude ?? this.latitude),
      longitude: clearLocation ? null : (longitude ?? this.longitude),
      clinicAddress: clearLocation ? null : (clinicAddress ?? this.clinicAddress),
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    specialty,
    active,
    disabled,
    consultationFee,
    rating,
    availability,
    latitude,
    longitude,
    clinicAddress,
  ];
}
