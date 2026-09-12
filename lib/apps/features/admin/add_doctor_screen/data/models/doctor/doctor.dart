import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String name;
  final String id;
  final String adminId;
  final Specialties specialty;
  final String? imageUrl;
  final bool active;

  const Doctor({
    required this.id,
    required this.name,
    required this.adminId,
    required this.specialty,
    required this.active,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, adminId, specialty, imageUrl, active];

  Doctor copyWith({String? image, bool? active}) {
    return Doctor(
      id: id,
      name: name,
      specialty: specialty,
      imageUrl: image ?? imageUrl,
      adminId: adminId,
      active: active ?? this.active,
    );
  }
}

enum Specialties {
  allergists,
  anesthesiologists,
  cardiologists,
  rectalSurgeons,
  dermatologists,
}
