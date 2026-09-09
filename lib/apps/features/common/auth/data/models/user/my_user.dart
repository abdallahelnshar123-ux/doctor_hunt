import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String name;
  final String email;
  final String id;
  final String provider;
  final String? image;
  final UserRoles? role;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.provider,
    this.image,
    this.role,
  });

  @override
  List<Object?> get props => [id, email, name, provider, image, role];

  MyUser copyWith({String? name, String? image, UserRoles? role}) {
    return MyUser(
      id: id,
      name: name ?? this.name,
      email: email,
      provider: provider,
      image: image ?? this.image,
      role: role ?? this.role,
    );
  }
}

enum UserRoles { admin, patient }
