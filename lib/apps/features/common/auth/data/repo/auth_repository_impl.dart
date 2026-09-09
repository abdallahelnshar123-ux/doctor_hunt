import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/user_pref.dart';
import 'package:doctor_hunt/apps/core/mapper/my_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/core/mapper/my_user_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/firebase_services/auth_service.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/firebase_services/firestore_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/mapper/exception_mapper.dart';
import '../models/user/auth_providers.dart';
import '../models/user/my_user.dart';
import '../models/user_dto/auth_user_dto.dart';
import '../models/user_dto/my_user_dto.dart';

@injectable
class AuthRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  final UserPrefs _userLocalDataSource;

  const AuthRepository(
    this._authService,
    this._firestoreService,
    this._userLocalDataSource,
  );

  Future<Either<Failure, MyUser>> continueWithGoogle() async {
    try {
      final AuthUserDto authUserDto = await _authService.continueWithGoogle();
      final MyUserDto? databaseUser = await _firestoreService.getUser(
        authUserDto.id,
      );

      if (databaseUser == null) {
        final newUser = MyUserDto(
          provider: AuthProviders.google,
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

  Future<Either<Failure, MyUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final authUserDto = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );

      final newUser = MyUser(
        provider: AuthProviders.emailPassword,
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

  Future<Either<Failure, MyUser>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authUserDto = await _authService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      final MyUserDto? databaseUser = await _firestoreService.getUser(
        authUserDto.id,
      );
      if (databaseUser == null) {
        return Left(UnauthorizedFailure('some thing went wrong'));
      }

      await _userLocalDataSource.setUser(databaseUser);
      return Right(databaseUser.toUser());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> logout() async {
    try {
      await _authService.logout();
      // await _userLocalDataSource.deleteUser();

      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> deleteAuthUser() async {
    try {
      await _authService.deleteAccount();

      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> reAuthenticateWithEmailAndPassword(
    String password,
  ) async {
    try {
      var authUserDto = await _authService.reAuthenticate(password: password);

      return Right(authUserDto.id);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> reAuthenticateWithGoogle() async {
    try {
      final authUserDto = await _authService.reAuthenticateWithGoogle();

      return Right(authUserDto.id);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> resetPassword({required String email}) async {
    try {
      await _authService.resetPassword(email: email);
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
