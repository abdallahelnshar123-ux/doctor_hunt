import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/mapper/exception_mapper.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/service/specialty_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SpecialtyRepository {
  final SpecialtyService _service;

  SpecialtyRepository(this._service);

  Future<Either<Failure, List<SpecialtyModel>>> getSpecialties() async {
    try {
      final specialties = await _service.getSpecialties();
      return Right(specialties);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, SpecialtyModel>> addSpecialty({
    required String en,
    required String ar,
  }) async {
    try {
      final specialty = await _service.addSpecialty(en: en, ar: ar);
      return Right(specialty);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, SpecialtyModel>> updateSpecialty(
    SpecialtyModel specialty,
  ) async {
    try {
      final updated = await _service.updateSpecialty(specialty);
      return Right(updated);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
