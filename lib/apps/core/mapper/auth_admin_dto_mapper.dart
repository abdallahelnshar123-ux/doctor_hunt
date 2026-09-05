import 'package:doctor_hunt/apps/features/auth/data/models/admin_dto/auth_admin_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';


extension AuthAdminDtoMapper on UserCredential {
  AuthAdminDto toAuthAdminDto() {
    return AuthAdminDto(
      id: user?.uid ?? '',
      email: user?.email ?? '',
      name: user?.displayName ?? '',
    );
  }
}
