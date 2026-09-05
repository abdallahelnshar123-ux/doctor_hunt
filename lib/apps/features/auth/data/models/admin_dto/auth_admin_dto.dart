import 'package:equatable/equatable.dart';

class AuthAdminDto extends Equatable {
  final String id;
  final String email;
  final String name;

  const AuthAdminDto({
    required this.id,
    required this.email,
    required this.name,
  });

  @override
  List<Object?> get props => [id, email, name];
}
