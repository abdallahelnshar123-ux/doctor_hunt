import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/image_service/image_service.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/service/doctor_firestore_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/cloudinary/cloudinary_service_impl.dart';
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

  Future<void> addDoctor({required Doctor doctor}) async {}

  Future<Either<Failure, Option<File>>> pickDoctorImage() async {
    try {
      final result = await _imageService.pickImage();
      return Right(optionOf(result));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
