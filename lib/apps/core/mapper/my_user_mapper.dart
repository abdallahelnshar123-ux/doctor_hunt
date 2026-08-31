import '../../features/auth/data/models/user/my_user.dart';
import '../../features/auth/data/models/user_dto/my_user_dto.dart';

extension UserMapper on MyUserDto {
  MyUser toUser() {
    return MyUser(
      id: id,
      email: email,
      name: name,
      provider: provider,
      image: image,
    );
  }
}
