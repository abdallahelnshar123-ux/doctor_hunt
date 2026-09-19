import '../../features/common/auth/data/dto/user_dto/my_user_dto.dart';
import '../../features/common/auth/domain/entity/user/my_user.dart';

extension UserMapper on MyUserDto {
  MyUser toUser() {
    return MyUser(
      id: id,
      email: email,
      name: name,
      provider: provider,
      image: image,
      role: role,
    );
  }
}
