import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/data_source/remote/auth/auth_remote_data_source.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/user_firestore_service.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/repository/auth_repository.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/mapper/exception_mapper.dart';
import '../../domain/entity/user/auth_providers.dart';
import '../../domain/entity/user/my_user.dart';
import '../dto/user_dto/auth_user_dto.dart';
import '../dto/user_dto/my_user_dto.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserFirestoreService _firestoreService;
  final UserPrefs _userLocalDataSource;

  const AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._firestoreService,
    this._userLocalDataSource,
  );

  @override
  Future<Either<Failure, MyUser>> continueWithGoogle() async {
    try {
      final AuthUserDto authUserDto = await _authRemoteDataSource
          .continueWithGoogle();
      final MyUserDto? databaseUser = await _firestoreService.getUser(
        authUserDto.id,
      );

      if (databaseUser == null) {
        final newUser = MyUserDto(
          provider: UserAuthProvider.google,
          id: authUserDto.id,
          name: authUserDto.name,
          email: authUserDto.email,
          role: UserRoles.patient,
        );
        await _firestoreService.addUser(newUser);
        await _userLocalDataSource.setUser(newUser);

        return Right(newUser.toUser());
      }
      await _userLocalDataSource.setUser(databaseUser);

      return Right(databaseUser.toUser());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final authUserDto = await _authRemoteDataSource
          .registerWithEmailAndPassword(email: email, password: password);

      final newUser = MyUser(
        provider: UserAuthProvider.emailPassword,
        id: authUserDto.id,
        name: name,
        email: authUserDto.email,
        role: UserRoles.patient,
      );
      await _firestoreService.addUser(newUser.toMyUserDto());
      await _userLocalDataSource.setUser(newUser.toMyUserDto());

      return Right(newUser);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyUser>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authUserDto = await _authRemoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      final MyUserDto? databaseUser = await _firestoreService.getUser(
        authUserDto.id,
      );
      if (databaseUser == null) {
        return Left(UnauthorizedFailure(t.errors.some_thing_went_wrong));
      }

      await _userLocalDataSource.setUser(databaseUser);
      return Right(databaseUser.toUser());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _authRemoteDataSource.logout();
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAuthUser() async {
    try {
      await _authRemoteDataSource.deleteAccount();

      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> reAuthenticateWithEmailAndPassword(
    String password,
  ) async {
    try {
      var authUserDto = await _authRemoteDataSource.reAuthenticate(
        password: password,
      );

      return Right(authUserDto.id);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> reAuthenticateWithGoogle() async {
    try {
      final authUserDto = await _authRemoteDataSource
          .reAuthenticateWithGoogle();

      return Right(authUserDto.id);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({required String email}) async {
    try {
      await _authRemoteDataSource.resetPassword(email: email);
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
