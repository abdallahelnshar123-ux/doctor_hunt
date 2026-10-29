import 'package:equatable/equatable.dart';

import '../../../../../../core/constants/firestore_constants.dart';
import '../../../domain/entity/user/user_roles.dart';
import '../../models/user/auth_providers.dart';
import 'admin_dto.dart';
import 'doctor_dto.dart';
import 'patient_dto.dart';

abstract class AppUserDto extends Equatable {
  final String id;
  final String email;
  final String name;
  final UserRoles role;
  final UserAuthProvider provider;
  final String? image;
  final String? phone;

  const AppUserDto({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.provider,
    this.image,
    this.phone,
  });

  factory AppUserDto.fromJson(Map<String, dynamic> json) {
    final roleString = json[FirestoreConstants.role] as String?;
    final role = UserRoles.values.firstWhere(
      (e) => e.name == roleString,
      orElse: () => UserRoles.patient,
    );

    switch (role) {
      case UserRoles.admin:
        return AdminDto.fromJson(json);
      case UserRoles.doctor:
        return DoctorDto.fromJson(json);
      case UserRoles.patient:
        return PatientDto.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [id, email, name, role, provider, image, phone];
}
