import '../../features/auth/data/models/user/my_user.dart';
import '../../features/auth/data/models/user_dto/my_user_dto.dart';

extension MyUserDtoMapper on MyUser {
  MyUserDto toMyUserDto() {
    return MyUserDto(
      id: id,
      email: email,
      name: name,
      provider: provider,
      passwordVerifier: passwordVerifier,
      salt: salt,
      avatar: avatar,
    );
  }
}
