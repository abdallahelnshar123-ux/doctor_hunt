import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/image_service/image_service.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability_dto.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/mapper/exception_mapper.dart';
import 'package:doctor_hunt/apps/core/network/cloudinary/cloudinary_service.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/dto/user/doctor_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/user_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/doctor/data/data_source/remote/doctor_remote_data_source.dart';
import 'package:doctor_hunt/apps/features/doctor/domain/repository/doctor_repository.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DoctorRepository)
class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource _remoteDataSource;
  final CloudinaryService _cloudinaryService;
  final ImageService _imageService;

  DoctorRepositoryImpl(
    this._remoteDataSource,
    this._cloudinaryService,
    this._imageService,
  );

  @override
  Future<Either<Failure, Unit>> addDoctor({
    required DoctorEntity doctor,
    // required File image,
    required String password,
  }) async {
    try {
      // final String imageUrl;
      // try {
      //   imageUrl = await _cloudinaryService.uploadImage(file: image);
      // } catch (e) {
      //   return Left(
      //     ServerFailure(t.errors.errorWhileAddingDoctorPleaseTryAgainLater),
      //   );
      // }

      // final newDoctor = doctor.copyWith(image: imageUrl);
      // final doctorDto = newDoctor.toDto() as DoctorDto;

      await _remoteDataSource.addDoctor(
        doctor: doctor.toDto() as DoctorDto,
        password: password,
      );
      return right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorEntity>> getDoctorById(String doctorId) async {
    try {
      final doctorDto = await _remoteDataSource.getDoctorById(doctorId);
      return Right(doctorDto.toEntity() as DoctorEntity);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<DoctorEntity>>> getDoctors({String? adminId}) async* {
    try {
      if (adminId == null) {
        await for (final doctorDtoList in _remoteDataSource.getDoctorsStreamForPatient()) {
          final doctors = doctorDtoList.map((dto) => dto.toEntity() as DoctorEntity).toList();
          yield Right(doctors);
        }
      } else {
        await for (final doctorDtoList in _remoteDataSource.getDoctorsStreamForAdmin(adminId: adminId)) {
          final doctors = doctorDtoList.map((dto) => dto.toEntity() as DoctorEntity).toList();
          yield Right(doctors);
        }
      }
    } on AppException catch (e) {
      yield Left(e.toFailure());
    } catch (e) {
      yield Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
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

  @override
  Future<Either<Failure, Unit>> updateDoctorActiveStatus({
    required String doctorId,
    required bool active,
  }) async {
    try {
      await _remoteDataSource.updateDoctorActiveStatus(
        doctorId: doctorId,
        active: active,
      );
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateDoctorDetails({
    required DoctorEntity doctor,
    File? image,
  }) async {
    try {
      String? imageUrl = doctor.image;
      if (image != null) {
        try {
          imageUrl = await _cloudinaryService.uploadImage(file: image);
        } catch (e) {
          return Left(
            ServerFailure(t.errors.errorWhileUpdatingDoctorPleaseTryAgainLater),
          );
        }
      }

      final newDoctor = doctor.copyWith(image: imageUrl);
      final doctorDto = newDoctor.toDto() as DoctorDto;

      await _remoteDataSource.updateDoctorDetails(doctorDto);
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateDoctorProfile({
    required DoctorEntity doctor,
    File? image,
  }) {
    return updateDoctorDetails(doctor: doctor, image: image);
  }

  @override
  Future<Either<Failure, Unit>> updateAvailability({
    required String doctorId,
    required DoctorAvailability availability,
  }) async {
    try {
      final availabilityDto = DoctorAvailabilityDto(
        workingDays: availability.workingDays,
        startTime: availability.startTime,
        endTime: availability.endTime,
        slotDuration: availability.slotDuration,
      );
      await _remoteDataSource.updateAvailability(
        doctorId: doctorId,
        availability: availabilityDto,
      );
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDoctor({required String doctorId}) async {
    try {
      await _remoteDataSource.deleteDoctor(doctorId: doctorId);
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
