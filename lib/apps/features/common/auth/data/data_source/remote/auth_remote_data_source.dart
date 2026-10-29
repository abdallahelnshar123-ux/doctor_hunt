import '../../dto/user/app_user_dto.dart';
import '../../models/user_dto/auth_user_dto.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserDto> continueWithGoogle();

  Future<AuthUserDto> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthUserDto> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<AuthUserDto> reAuthenticate({required String password});

  Future<void> deleteAccount();

  Future<AuthUserDto> reAuthenticateWithGoogle();

  Future<void> resetPassword({required String email});

  Future<void> addUser(AppUserDto user);

  Future<AppUserDto?> getUser(String uId);

  Future<void> updateUser(AppUserDto user);

  Future<void> deleteUser(String uId);
}
