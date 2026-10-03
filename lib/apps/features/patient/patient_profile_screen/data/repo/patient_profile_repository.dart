import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/image_service/image_service.dart';
import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/mapper/exception_mapper.dart';
import 'package:doctor_hunt/apps/core/network/cloudinary/cloudinary_service.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/firebase_services/user_firestore_service.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

@injectable
class PatientProfileRepository {
  final UserFirestoreService _firestoreService;
  final CloudinaryService _cloudinaryService;
  final ImageService _imageService;
  final UserPrefs _userPrefs;

  PatientProfileRepository(
    this._firestoreService,
    this._cloudinaryService,
    this._imageService,
    this._userPrefs,
  );

  Future<Either<Failure, File>> pickPatientImage() async {
    try {
      final result = await _imageService.pickImage();
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, MyUser>> updatePatientProfile({
    required MyUser user,
    File? image,
  }) async {
    try {
      String? imageUrl = user.image;
      if (image != null) {
        try {
          imageUrl = await _cloudinaryService.uploadImage(file: image);
        } catch (e) {
          return Left(ServerFailure(t.errors.some_thing_went_wrong));
        }
      }

      final updatedUser = user.copyWith(image: imageUrl);
      final userDto = updatedUser.toMyUserDto();

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
