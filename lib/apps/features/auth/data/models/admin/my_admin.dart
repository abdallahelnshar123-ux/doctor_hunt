import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:equatable/equatable.dart';

class MyAdmin extends Equatable {
  final String name;
  final String email;
  final String id;
  final AppRoles? role;

  const MyAdmin({
    required this.id,
    required this.email,
    required this.name,
    this.role,
  });

  @override
  List<Object?> get props => [id, email, name, role];

  MyAdmin copyWith({String? name, AppRoles? role}) {
    return MyAdmin(
      id: id,
      name: name ?? this.name,
      email: email,
      role: role ?? this.role,
    );
  }
}


