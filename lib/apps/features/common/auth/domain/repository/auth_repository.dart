import 'package:dartz/dartz.dart';

import '../../../../../core/failure/failure.dart';
import '../entity/user/my_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, MyUser>> continueWithGoogle();

  Future<Either<Failure, MyUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, MyUser>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> deleteAuthUser();

  Future<Either<Failure, String>> reAuthenticateWithEmailAndPassword(
    String password,
  );

  Future<Either<Failure, String>> reAuthenticateWithGoogle();

  Future<Either<Failure, Unit>> resetPassword({required String email});
}
