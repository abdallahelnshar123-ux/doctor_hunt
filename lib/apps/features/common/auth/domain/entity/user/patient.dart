import 'app_user.dart';
import 'user_roles.dart';

class PatientEntity extends AppUserEntity {
  final List<String> favDoctors;

  const PatientEntity({
    required super.id,
    required super.email,
    required super.name,
    required super.provider,
    super.image,
    super.phone,
    this.favDoctors = const [],
  }) : super(role: UserRoles.patient);

  @override
  List<Object?> get props => [...super.props, favDoctors];
}
