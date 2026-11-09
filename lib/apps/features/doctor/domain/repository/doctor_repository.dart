import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';

abstract class DoctorRepository {
  Future<Either<Failure, Unit>> addDoctor({
    required DoctorEntity doctor,
    // required File image,
    required String password,
  });

  Future<Either<Failure, DoctorEntity>> getDoctorById(String doctorId);

  Stream<Either<Failure, List<DoctorEntity>>> getDoctors();

  Stream<Either<Failure, List<DoctorEntity>>> getDoctorsForAdmin();

  Future<Either<Failure, File>> pickDoctorImage();

  Future<Either<Failure, Unit>> updateDoctorActiveStatus({
    required String doctorId,
    required bool active,
  });

  Future<Either<Failure, Unit>> updateDoctorDisabledStatus({
    required String doctorId,
    required bool disabled,
  });

  Future<Either<Failure, Unit>> updateDoctorDetails({
    required DoctorEntity doctor,
    File? image,
  });

  Future<Either<Failure, Unit>> updateDoctorProfile({
    required DoctorEntity doctor,
    File? image,
  });

  Future<Either<Failure, Unit>> updateAvailability({
    required String doctorId,
    required DoctorAvailability availability,
  });

  Future<Either<Failure, Unit>> deleteDoctor({required String doctorId});
}
