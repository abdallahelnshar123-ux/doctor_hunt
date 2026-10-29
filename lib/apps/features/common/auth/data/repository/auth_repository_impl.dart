import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/mapper/exception_mapper.dart';
import '../../domain/entity/user/app_user.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/remote/auth_remote_data_source.dart';
import '../dto/user/patient_dto.dart';
import '../mappers/user_mapper.dart';
import '../models/user/auth_providers.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AppUserEntity>> continueWithGoogle() async {
    try {
      final authUserDto = await _remoteDataSource.continueWithGoogle();
      final databaseUser = await _remoteDataSource.getUser(authUserDto.id);

      if (databaseUser == null) {
        final newUser = PatientDto(
          id: authUserDto.id,
          email: authUserDto.email,
          name: authUserDto.name,
          provider: UserAuthProvider.google,
        );
        await _remoteDataSource.addUser(newUser);
        final user = newUser.toEntity();
        return Right(user);
      }
      
      final user = databaseUser.toEntity();
      return Right(user);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final authUserDto = await _remoteDataSource.registerWithEmailAndPassword(
        email: email,
        password: password,
      );

      final newUser = PatientDto(
        id: authUserDto.id,
        email: authUserDto.email,
        name: name,
        provider: UserAuthProvider.emailPassword,
      );
      
      await _remoteDataSource.addUser(newUser);
      return Right(newUser.toEntity());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authUserDto = await _remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final databaseUser = await _remoteDataSource.getUser(authUserDto.id);
      
      if (databaseUser == null) {
        return const Left(UnauthorizedFailure('Something went wrong'));
      }

      final user = databaseUser.toEntity();
      return Right(user);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _remoteDataSource.logout();
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUserEntity>> toggleFavoriteDoctor(
    String doctorId,
    AppUserEntity current,
  ) async {
    try {
      final currentDto = current.toDto();
      
      if (currentDto is PatientDto) {
        final currentFavs = currentDto.favDoctors;
        final updatedFavs = List<String>.from(currentFavs);
        
        if (updatedFavs.contains(doctorId)) {
          updatedFavs.remove(doctorId);
        } else {
          updatedFavs.add(doctorId);
        }

        final updatedPatient = PatientDto(
          id: currentDto.id,
          email: currentDto.email,
          name: currentDto.name,
          provider: currentDto.provider,
          image: currentDto.image,
          phone: currentDto.phone,
          favDoctors: updatedFavs,
        );

        await _remoteDataSource.updateUser(updatedPatient);
        return Right(updatedPatient.toEntity());
      }
      
      return Right(current);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAuthUser() async {
    try {
      await _remoteDataSource.deleteAccount();
      return const Right(unit);
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
      final authUserDto = await _remoteDataSource.reAuthenticate(password: password);
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
      final authUserDto = await _remoteDataSource.reAuthenticateWithGoogle();
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
      await _remoteDataSource.resetPassword(email: email);
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
