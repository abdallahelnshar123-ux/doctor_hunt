import 'package:equatable/equatable.dart';

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

  const Doctor({
    required this.id,
    required this.name,
    required this.adminId,
    required this.specialty,
    required this.active,
    required this.consultationFee,
    required this.rating,
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
      ];

  Doctor copyWith({
    String? image,
    bool? active,
    double? consultationFee,
    Rating? rating,
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
