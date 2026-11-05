import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/image_service/image_service.dart';
import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/mapper/exception_mapper.dart';
import 'package:doctor_hunt/apps/core/network/cloudinary/cloudinary_service.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/firebase_services/user_firestore_service.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/admin.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/patient.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

import '../../../../features/common/auth/data/mappers/user_mapper.dart';

@injectable
class UserRepository {
  final UserFirestoreService _firestoreService;
  final CloudinaryService _cloudinaryService;
  final ImageService _imageService;
  final UserPrefs _userPrefs;

  UserRepository(
    this._firestoreService,
    this._cloudinaryService,
    this._imageService,
    this._userPrefs,
  );

  Future<Either<Failure, File>> pickUserImage() async {
    try {
      final result = await _imageService.pickImage();
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, AppUserEntity>> updateUserProfile({
    required AppUserEntity user,
    File? image,
  }) async {
    try {
      String? imageUrl = user.image;
      if (image != null) {
        try {
          imageUrl = await _cloudinaryService.uploadImage(file: image);
          // Delete old image if exists and a new one is successfully uploaded
          if (user.image != null && user.image!.isNotEmpty) {
            await _cloudinaryService.deleteImage(user.image!);
          }
        } catch (e) {
          return Left(ServerFailure(t.errors.someThingWentWrong));
        }
      }

      AppUserEntity updatedUser;

      if (user is AdminEntity) {
        updatedUser = AdminEntity(
          id: user.id,
          email: user.email,
          name: user.name,
          provider: user.provider,
          phone: user.phone,
          image: imageUrl ?? user.image,
        );
      } else if (user is PatientEntity) {
        updatedUser = PatientEntity(
          id: user.id,
          email: user.email,
          name: user.name,
          provider: user.provider,
          phone: user.phone,
          image: imageUrl ?? user.image,
          favDoctors: user.favDoctors,
        );
      } else if (user is DoctorEntity) {
        updatedUser = DoctorEntity(
          id: user.id,
          email: user.email,
          name: user.name,
          provider: user.provider,
          phone: user.phone,
          image: imageUrl ?? user.image,
          specialty: user.specialty,
          active: user.active,
          consultationFee: user.consultationFee,
          rating: user.rating,
          availability: user.availability,
        );
      } else {
        updatedUser = user;
      }
      final userDto = updatedUser.toDto();

      await Future.wait([
        _firestoreService.updateUser(userDto),
        _userPrefs.setUser(userDto),
      ]);

      return Right(updatedUser);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
