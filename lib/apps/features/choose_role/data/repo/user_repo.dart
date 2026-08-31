import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data_sources/local/user/user_local_data_source.dart';
import 'package:doctor_hunt/apps/core/data_sources/remote/user/user_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/mapper/exception_mapper.dart';
import '../../../../core/mapper/my_user_dto_mapper.dart';
import '../../../auth/data/models/user/my_user.dart';

@injectable
class UserRepo {
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  UserRepo(this._userRemoteDataSource, this._userLocalDataSource);

  Future<Either<Failure, Unit>> updateDatabaseUser({
    required MyUser user,
  }) async {
    try {
      await _userRemoteDataSource.updateUser(user.toMyUserDto());
      await _userLocalDataSource.saveUser(user: user.toMyUserDto());
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
