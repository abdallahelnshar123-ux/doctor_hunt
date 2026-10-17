import 'package:equatable/equatable.dart';

import 'doctor_availability.dart';
import 'rating.dart';

class Doctor extends Equatable {
  final String name;
  final String id;
  final String adminId;
  final Specialty specialty;
  final String? imageUrl;
  final bool active;
  final double consultationFee;
  final Rating rating;
  final DoctorAvailability? availability;

  const Doctor({
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

  @override
  List<Object?> get props => [
    id,
    name,
    adminId,
    specialty,
    imageUrl,
    active,
    consultationFee,
    rating,
    availability,
  ];

  Doctor copyWith({
    String? image,
    bool? active,
    double? consultationFee,
    Rating? rating,
    DoctorAvailability? availability,
  }) {
    return Doctor(
      id: id,
      name: name,
      specialty: specialty,
      imageUrl: image ?? imageUrl,
      adminId: adminId,
      active: active ?? this.active,
      consultationFee: consultationFee ?? this.consultationFee,
      rating: rating ?? this.rating,
      availability: availability ?? this.availability,
    );
  }
}

enum Specialty {
  allergists,
  anesthesiologists,
  cardiologists,
  rectalSurgeons,
  dermatologists,
}
