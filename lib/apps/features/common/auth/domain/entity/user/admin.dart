import 'app_user.dart';
import 'user_roles.dart';

class AdminEntity extends AppUserEntity {
  const AdminEntity({
    required super.id,
    required super.email,
    required super.name,
    required super.provider,
    super.image,
    super.phone,
  }) : super(role: UserRoles.admin);
}
