import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/image_service/image_service.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/mapper/doctor_dto_mapper.dart';
import 'package:doctor_hunt/apps/core/mapper/doctor_mapper.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/service/doctor_firestore_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/mapper/exception_mapper.dart';
import '../../../../../core/network/cloudinary/cloudinary_service.dart';
import '../models/doctor/doctor.dart';

@injectable
class DoctorRepository {
  final CloudinaryService _cloudinaryService;
  final DoctorFirestoreService _firestoreService;
  final ImageService _imageService;

  DoctorRepository({
    required this._firestoreService,
    required this._cloudinaryService,
    required this._imageService,
  });

  Future<Either<Failure, Unit>> addDoctor({
    required Doctor doctor,
    required File image,
  }) async {
    try {
      final String imageUrl;
      try {
        imageUrl = await _cloudinaryService.uploadImage(file: image);
      } catch (e) {
        return Left(
          ServerFailure('Error while adding doctor please try again later'),
        );
      }

      final doctorDto = doctor.copyWith(image: imageUrl).toDoctorDto();

      await _firestoreService.addDoctor(doctorDto);
      return right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Stream<Either<Failure, List<Doctor>>> getAccounts() async* {
    try {
      await for (final accountDto in _firestoreService.getDoctorsStream()) {
        final accounts = accountDto.map((dto) => dto.toDoctor()).toList();
        yield Right(accounts);
      }
    } on AppException catch (e) {
      yield Left(e.toFailure());
    } catch (e) {
      yield Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, File>> pickDoctorImage() async {
    try {
      final result = await _imageService.pickImage();
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
