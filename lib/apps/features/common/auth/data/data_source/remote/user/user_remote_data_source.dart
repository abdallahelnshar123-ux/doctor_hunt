import '../../../dto/user_dto/my_user_dto.dart';

abstract class UserRemoteDataSource {
  Future<void> addUser(MyUserDto myUser);

  Future<MyUserDto?> getUser(String uId);

  Future<void> updateUser(MyUserDto user);

  Future<void> deleteUser(String uId);
}
