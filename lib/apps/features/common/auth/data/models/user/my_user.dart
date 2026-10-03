import 'package:equatable/equatable.dart';

import 'auth_providers.dart';

class MyUser extends Equatable {
  final String name;
  final String email;
  final String id;
  final UserAuthProvider provider;
  final String? image;
  final UserRoles? role;
  final String? phone;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.provider,
    this.image,
    this.role,
    this.phone,
  });

  @override
  List<Object?> get props => [id, email, name, provider, image, role, phone];

  MyUser copyWith({
    String? name,
    String? image,
    UserRoles? role,
    String? phone,
  }) {
    return MyUser(
      id: id,
      name: name ?? this.name,
      email: email,
      provider: provider,
      image: image ?? this.image,
      role: role ?? this.role,
      phone: phone ?? this.phone,
    );
  }
}

enum UserRoles { admin, patient }
