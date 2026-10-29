import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/repository/auth_repository.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

import '../models/user/my_user.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, AppUserEntity>> login({
    required UserRoles role,
    required String email,
    required String password,
  }) async {
    var result = await _repository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.fold((l) => Left(l), (r) {
      if (r.role.name == role.name) {
        return Right(r);
      } else {
        return Left(UnauthorizedFailure(t.errors.noAccountAssociated));
      }
    });
  }
}
