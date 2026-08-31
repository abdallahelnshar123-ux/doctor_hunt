import '../../../../features/auth/data/models/user_dto/my_user_dto.dart';

abstract class UserLocalDataSource {
  MyUserDto? getUserFromCache();

  Future<void> saveUser({required MyUserDto user});

  Future<void> deleteUser();
}
