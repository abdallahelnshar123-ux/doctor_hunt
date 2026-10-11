import 'package:equatable/equatable.dart';

import '../../../../core/constants/firestore_constants.dart';
import 'doctor.dart';
import 'doctor_availability_dto.dart';
import 'rating_dto.dart';

class DoctorDto extends Equatable {
  final String name;
  final String id;
  final String adminId;
  final Specialty specialty;
  final bool active;
  final String? imageUrl;
  final double consultationFee;
  final RatingDto rating;
  final DoctorAvailabilityDto? availability;

  const DoctorDto({
    required this.id,
    required this.name,
    required this.adminId,
    required this.specialty,
    required this.active,
    required this.consultationFee,
    required this.rating,
    this.availability,
    this.imageUrl,
  });

  DoctorDto copyWith({
    String? id,
    bool? active,
    String? image,
    double? consultationFee,
    RatingDto? rating,
    DoctorAvailabilityDto? availability,
  }) {
    return DoctorDto(
      id: id ?? this.id,
      name: name,
      adminId: adminId,
      specialty: specialty,
      active: active ?? this.active,
      consultationFee: consultationFee ?? this.consultationFee,
      rating: rating ?? this.rating,
      imageUrl: image ?? imageUrl,
      availability: availability ?? this.availability,
    );
  }

  factory DoctorDto.fromFireStore(Map<String, dynamic> data) {
    return DoctorDto(
      id: data[FirestoreConstants.id]?.toString() ?? '',
      name: data[FirestoreConstants.name]?.toString() ?? '',
      adminId: data[FirestoreConstants.adminId]?.toString() ?? '',
      active: data[FirestoreConstants.active] ?? false,
      specialty: Specialty.values.firstWhere(
        (e) => e.name == data[FirestoreConstants.specialty],
        orElse: () => Specialty.allergists,
      ),
      imageUrl: data[FirestoreConstants.image]?.toString() ?? '',
      consultationFee:
          (data[FirestoreConstants.consultationFee] as num?)?.toDouble() ?? 0.0,
      rating: RatingDto.fromFireStore(
        Map<String, dynamic>.from(data[FirestoreConstants.rating] ?? {}),
      ),
      availability: data[FirestoreConstants.availability] != null
          ? DoctorAvailabilityDto.fromFireStore(
              Map<String, dynamic>.from(data[FirestoreConstants.availability]),
            )
          : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.name: name,
      FirestoreConstants.image: imageUrl,
      FirestoreConstants.specialty: specialty.name,
      FirestoreConstants.adminId: adminId,
      FirestoreConstants.active: active,
      FirestoreConstants.consultationFee: consultationFee,
      FirestoreConstants.rating: rating.toFireStore(),
      if (availability != null)
        FirestoreConstants.availability: availability!.toFireStore(),
    };
  }

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto.fromFireStore(json);
  }

  Map<String, dynamic> toJson() {
    return toFireStore();
  }

  @override
  List<Object?> get props => [
    name,
    id,
    adminId,
    specialty,
    active,
    imageUrl,
    consultationFee,
    rating,
    availability,
  ];
}
