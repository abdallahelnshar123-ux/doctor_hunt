import 'package:equatable/equatable.dart';

import '../../../../../../core/constants/firestore_constants.dart';
import '../doctor/doctor.dart';

class DoctorDto extends Equatable {
  final String name;
  final String id;
  final String adminId;
  final Specialties specialty;
  final bool active;
  final String? imageUrl;

  const DoctorDto({
    required this.id,
    required this.name,
    required this.adminId,
    required this.specialty,
    required this.active,
    this.imageUrl,
  });

  DoctorDto copyWith({String? id, bool? active}) {
    return DoctorDto(
      id: id ?? this.id,
      name: name,
      adminId: adminId,
      specialty: specialty,
      active: active ?? this.active,
      imageUrl: imageUrl,
    );
  }

  factory DoctorDto.fromFireStore(Map<String, dynamic> data) {
    return DoctorDto(
      id: data[FirestoreConstants.id]?.toString() ?? '',
      name: data[FirestoreConstants.name]?.toString() ?? '',
      adminId: data[FirestoreConstants.adminId]?.toString() ?? '',
      active: data[FirestoreConstants.active] ?? false,
      specialty: Specialties.values.firstWhere(
        (e) => e.name == data[FirestoreConstants.specialty],
        orElse: () => Specialties.allergists,
      ),
      imageUrl: data[FirestoreConstants.image]?.toString() ?? '',
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
    };
  }

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto.fromFireStore(json);
  }

  Map<String, dynamic> toJson() {
    return toFireStore();
  }

  @override
  List<Object?> get props => [name, id, adminId, specialty, active, imageUrl];
}
