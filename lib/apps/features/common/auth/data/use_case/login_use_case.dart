import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/patient.dart';
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

    return _useCaseLogic(role: role, result: result);
  }

  Future<Either<Failure, AppUserEntity>> continueWithGoogle({
    required UserRoles role,
  }) async {
    var result = await _repository.continueWithGoogle();

    return _useCaseLogic(role: role, result: result);
  }

  Future<Either<Failure, AppUserEntity>> _useCaseLogic({
    required UserRoles role,
    required Either<Failure, AppUserEntity> result,
  }) async {
    return await result.fold((l) => Left(l), (r) {
      if (r.role.name != UserRoles.admin.name) {
        if (r is PatientEntity && r.disabled) {
          // Also sign out ideally so no lingering invalid session exists.
          _repository.logout();
          return Left(UnauthorizedFailure(t.errors.accountDisabled));
        } else if (r is DoctorEntity && r.disabled) {
          _repository.logout();
          return Left(UnauthorizedFailure(t.errors.accountDisabled));
        }
      }

      if (r.role.name == role.name) {
        return Right(r);
      } else {
        _repository.logout();
        return Left(UnauthorizedFailure(t.errors.noAccountAssociated));
      }
    });
  }
}
