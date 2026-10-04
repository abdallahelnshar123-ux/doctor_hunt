import 'package:equatable/equatable.dart';

import 'admin_info.dart';
import 'auth_providers.dart';
import 'patient_info.dart';

class MyUser extends Equatable {
  final String name;
  final String email;
  final String id;
  final UserAuthProvider provider;
  final String? image;
  final UserRoles? role;
  final String? phone;
  final PatientInfo? patientInfo;
  final AdminInfo? adminInfo;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.provider,
    this.image,
    this.role,
    this.phone,
    this.patientInfo,
    this.adminInfo,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        provider,
        image,
        role,
        phone,
        patientInfo,
        adminInfo,
      ];

  MyUser copyWith({
    String? name,
    String? image,
    UserRoles? role,
    String? phone,
    PatientInfo? patientInfo,
    AdminInfo? adminInfo,
  }) {
    return MyUser(
      id: id,
      name: name ?? this.name,
      email: email,
      provider: provider,
      image: image ?? this.image,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      patientInfo: patientInfo ?? this.patientInfo,
      adminInfo: adminInfo ?? this.adminInfo,
    );
  }
}

enum UserRoles { admin, patient }
