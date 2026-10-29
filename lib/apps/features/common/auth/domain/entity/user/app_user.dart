import 'package:equatable/equatable.dart';

import '../../../data/models/user/auth_providers.dart';
import 'user_roles.dart';

abstract class AppUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final UserRoles role;
  final UserAuthProvider provider;
  final String? image;
  final String? phone;

  const AppUserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.provider,
    this.image,
    this.phone,
  });

  @override
  List<Object?> get props => [id, email, name, role, provider, image, phone];
}
