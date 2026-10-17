import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/firebase_services/auth_service.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/mapper/exception_mapper.dart';
import '../models/user/auth_providers.dart';
import '../models/user/my_user.dart';
import '../models/user/patient_info.dart';
import '../models/user_dto/auth_user_dto.dart';
import '../models/user_dto/my_user_dto.dart';
import '../service/firebase_services/user_firestore_service.dart';

@lazySingleton
class AuthRepository {
  final AuthService _authService;
  final UserFirestoreService _firestoreService;

  AuthRepository(this._authService, this._firestoreService);

  Future<Either<Failure, MyUser>> continueWithGoogle() async {
    try {
      final AuthUserDto authUserDto = await _authService.continueWithGoogle();
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
        final user = newUser.toUser();

        return Right(user);
      }
      final user = databaseUser.toUser();

      return Right(user);
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
        provider: UserAuthProvider.emailPassword,
        id: authUserDto.id,
        name: name,
        email: authUserDto.email,
        role: UserRoles.patient,
      );
      await _firestoreService.addUser(newUser.toMyUserDto());

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
        return Left(UnauthorizedFailure(t.errors.some_thing_went_wrong));
      }

      final user = databaseUser.toUser();
      return Right(user);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> logout() async {
    try {
      await _authService.logout();
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, MyUser>> toggleFavoriteDoctor(
    String doctorId,
    MyUser current,
  ) async {
    final currentFavs = current.patientInfo?.favDoctors ?? [];
    final updatedFavs = List<String>.from(currentFavs);
    if (updatedFavs.contains(doctorId)) {
      updatedFavs.remove(doctorId);
    } else {
      updatedFavs.add(doctorId);
    }

    final updatedPatientInfo = (current.patientInfo ?? const PatientInfo())
        .copyWith(favDoctors: updatedFavs);
    final updatedUser = current.copyWith(patientInfo: updatedPatientInfo);

    try {
      await _firestoreService.updateUser(updatedUser.toMyUserDto());
      return Right(updatedUser);
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
