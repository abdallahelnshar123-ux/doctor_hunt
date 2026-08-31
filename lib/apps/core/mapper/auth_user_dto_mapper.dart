import 'package:firebase_auth/firebase_auth.dart';

import '../../features/auth/data/models/user_dto/auth_user_dto.dart';

extension AuthUserDtoMapper on UserCredential {
  AuthUserDto toAuthUserDto() {
    return AuthUserDto(
      id: user?.uid ?? '',
      email: user?.email ?? '',
      name: user?.displayName ?? '',
      image: user?.photoURL,
    );
  }
}
