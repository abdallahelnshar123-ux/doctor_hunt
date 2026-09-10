import 'package:equatable/equatable.dart';

import '../../../../../../core/constants/firestore_constants.dart';

class DoctorDto extends Equatable {
  final String name;
  final String id;
  final String adminId;
  final String? image;

  const DoctorDto({
    required this.id,
    required this.name,
    required this.adminId,
    this.image,
  });

  DoctorDto copyWith({String? id}) {
    return DoctorDto(
      id: id ?? this.id,
      name: name,
      adminId: adminId,
      image: image,
    );
  }

  factory DoctorDto.fromFireStore(Map<String, dynamic> data) {
    return DoctorDto(
      id: data[FirestoreConstants.id]?.toString() ?? '',
      name: data[FirestoreConstants.name]?.toString() ?? '',
      adminId: data[FirestoreConstants.adminId]?.toString() ?? '',
      image: data[FirestoreConstants.image]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.name: name,
      FirestoreConstants.image: image,
      FirestoreConstants.adminId: adminId,
    };
  }

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto.fromFireStore(json);
  }

  Map<String, dynamic> toJson() {
    return toFireStore();
  }

  @override
  List<Object?> get props => [name, id, adminId, image];
}
