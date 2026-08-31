import 'package:equatable/equatable.dart';

class AuthUserDto extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? image;

  const AuthUserDto({
    required this.id,
    required this.email,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, email, name , image];
}
