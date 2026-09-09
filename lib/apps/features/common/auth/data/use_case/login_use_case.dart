import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:injectable/injectable.dart';

import '../repo/auth_repository_impl.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, MyUser>> login({
    required UserRoles role,
    required String email,
    required String password,
  }) async {
    var result = await _repository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.fold((l) => Left(l), (r) {
      if (r.role == role) {
        return Right(r);
      } else {
        return Left(
          UnauthorizedFailure('no account associated with this email'),
        );
      }
    });
  }
}
