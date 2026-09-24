import '../../domain/entity/user/my_user.dart';
import '../dto/user_dto/my_user_dto.dart';

extension MyUserDtoMapper on MyUser {
  MyUserDto toMyUserDto() {
    return MyUserDto(
      id: id,
      email: email,
      name: name,
      provider: provider,
      image: image,
      role: role,
    );
  }
}
