import '../../../../../../core/constants/firestore_constants.dart';
import '../../../../../../core/data/models/doctor/doctor_availability.dart';
import '../../../../../../core/data/models/doctor/doctor_availability_dto.dart';
import '../../../../../../core/data/models/doctor/rating.dart';
import '../../../../../../core/data/models/doctor/rating_dto.dart';
import '../../../../../../core/mapper/review_dto_mapper.dart';
import '../../../../../../core/mapper/review_mapper.dart';
import '../../../domain/entity/user/doctor.dart';
import '../../../domain/entity/user/user_roles.dart';
import '../../models/user/auth_providers.dart';
import 'app_user_dto.dart';

class DoctorDto extends AppUserDto {
  final String adminId;
  final Specialty specialty;
  final bool active;
  final double consultationFee;
  final Rating rating;
  final DoctorAvailability? availability;

  const DoctorDto({
    required super.id,
    required super.email,
    required super.name,
    required super.provider,
    super.image,
    super.phone,
    required this.adminId,
    required this.specialty,
    required this.active,
    required this.consultationFee,
    required this.rating,
    this.availability,
  }) : super(role: UserRoles.doctor);

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto(
      id: json[FirestoreConstants.id]?.toString() ?? '',
      name: json[FirestoreConstants.name]?.toString() ?? '',
      email: json[FirestoreConstants.email]?.toString() ?? '',
      provider: UserAuthProvider.values.firstWhere(
        (element) => element.name == json[FirestoreConstants.provider],
        orElse: () => UserAuthProvider.emailPassword,
      ),
      image: json[FirestoreConstants.image]?.toString(),
      phone: json[FirestoreConstants.phone]?.toString(),
      adminId: json[FirestoreConstants.adminId]?.toString() ?? '',
      specialty: Specialty.values.firstWhere(
        (e) => e.name == json[FirestoreConstants.specialty],
        orElse: () => Specialty.allergists,
      ),
      active: json[FirestoreConstants.active] as bool? ?? false,
      consultationFee:
          (json[FirestoreConstants.consultationFee] as num?)?.toDouble() ?? 0.0,
      rating: json[FirestoreConstants.rating] != null
          ? _ratingFromJson(
              json[FirestoreConstants.rating] as Map<String, dynamic>,
            )
          : const Rating(rating: 0.0, reviews: []),
      availability: json[FirestoreConstants.availability] != null
          ? _availabilityFromJson(
              json[FirestoreConstants.availability] as Map<String, dynamic>,
            )
          : null,
    );
  }

  static Rating _ratingFromJson(Map<String, dynamic> json) {
    final dto = RatingDto.fromFireStore(json);
    return Rating(
      rating: dto.rating,
      reviews: dto.reviews.map((r) => r.toDomain()).toList(),
    );
  }

  static DoctorAvailability _availabilityFromJson(Map<String, dynamic> json) {
    final dto = DoctorAvailabilityDto.fromFireStore(json);
    return DoctorAvailability(
      workingDays: dto.workingDays,
      startTime: dto.startTime,
      endTime: dto.endTime,
      slotDuration: dto.slotDuration,
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
      FirestoreConstants.adminId: adminId,
      FirestoreConstants.specialty: specialty.name,
      FirestoreConstants.active: active,
      FirestoreConstants.consultationFee: consultationFee,
      FirestoreConstants.rating: _ratingToJson(rating),
      if (availability != null)
        FirestoreConstants.availability: _availabilityToJson(availability!),
    };
  }

  Map<String, dynamic> _ratingToJson(Rating rating) {
    return RatingDto(
      rating: rating.rating,
      reviews: rating.reviews.map((r) => r.toDto()).toList(),
    ).toFireStore();
  }

  Map<String, dynamic> _availabilityToJson(DoctorAvailability availability) {
    return DoctorAvailabilityDto(
      workingDays: availability.workingDays,
      startTime: availability.startTime,
      endTime: availability.endTime,
      slotDuration: availability.slotDuration,
    ).toFireStore();
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
