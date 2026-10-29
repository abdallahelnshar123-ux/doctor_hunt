import 'package:dartz/dartz.dart';

import '../../../../../core/failure/failure.dart';
import '../entity/user/app_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppUserEntity>> continueWithGoogle();

  Future<Either<Failure, AppUserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, AppUserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, AppUserEntity>> toggleFavoriteDoctor(
    String doctorId,
    AppUserEntity current,
  );

  Future<Either<Failure, Unit>> deleteAuthUser();

  Future<Either<Failure, String>> reAuthenticateWithEmailAndPassword(
    String password,
  );

  Future<Either<Failure, String>> reAuthenticateWithGoogle();

  Future<Either<Failure, Unit>> resetPassword({required String email});
}
