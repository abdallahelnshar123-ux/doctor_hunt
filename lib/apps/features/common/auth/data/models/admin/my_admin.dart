import 'package:equatable/equatable.dart';

import '../user/my_user.dart';

class MyAdmin extends Equatable {
  final String name;
  final String email;
  final String id;
  final UserRoles? role;

  const MyAdmin({
    required this.id,
    required this.email,
    required this.name,
    this.role,
  });

  @override
  List<Object?> get props => [id, email, name, role];

  MyAdmin copyWith({String? name, UserRoles? role}) {
    return MyAdmin(
      id: id,
      name: name ?? this.name,
      email: email,
      role: role ?? this.role,
    );
  }
}
