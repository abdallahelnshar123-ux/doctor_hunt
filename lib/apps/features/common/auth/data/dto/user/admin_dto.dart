import '../../../../../../core/constants/firestore_constants.dart';
import '../../../domain/entity/user/user_roles.dart';
import '../../models/user/auth_providers.dart';
import 'app_user_dto.dart';

class AdminDto extends AppUserDto {
  const AdminDto({
    required super.id,
    required super.email,
    required super.name,
    required super.provider,
    super.image,
    super.phone,
  }) : super(role: UserRoles.admin);

  factory AdminDto.fromJson(Map<String, dynamic> json) {
    return AdminDto(
      id: json[FirestoreConstants.id]?.toString() ?? '',
      name: json[FirestoreConstants.name]?.toString() ?? '',
      email: json[FirestoreConstants.email]?.toString() ?? '',
      provider: UserAuthProvider.values.firstWhere(
        (element) => element.name == json[FirestoreConstants.provider],
        orElse: () => UserAuthProvider.emailPassword,
      ),
      image: json[FirestoreConstants.image]?.toString(),
      phone: json[FirestoreConstants.phone]?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.name: name,
      FirestoreConstants.email: email,
      FirestoreConstants.provider: provider.name,
      FirestoreConstants.image: image,
      FirestoreConstants.role: role.name,
      FirestoreConstants.phone: phone,
      FirestoreConstants.adminInfo: {},
    };
  }
}
