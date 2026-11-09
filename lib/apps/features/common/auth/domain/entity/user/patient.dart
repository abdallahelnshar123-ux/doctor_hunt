import '../../../data/models/user/auth_providers.dart';
import 'app_user.dart';
import 'user_roles.dart';

class PatientEntity extends AppUserEntity {
  final List<String> favDoctors;
  final bool disabled;

  const PatientEntity({
    required super.id,
    required super.email,
    required super.name,
    required super.provider,
    super.image,
    super.phone,
    this.favDoctors = const [],
    this.disabled = false,
  }) : super(role: UserRoles.patient);

  PatientEntity copyWith({
    String? id,
    String? email,
    String? name,
    UserAuthProvider? provider,
    String? image,
    String? phone,
    List<String>? favDoctors,
    bool? disabled,
  }) {
    return PatientEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      provider: provider ?? this.provider,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      favDoctors: favDoctors ?? this.favDoctors,
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  List<Object?> get props => [...super.props, favDoctors, disabled];
}
