import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/core/mapper/exception_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/user_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/patient.dart';
import 'package:doctor_hunt/apps/features/admin/admin_patients_tab/data/service/admin_patients_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AdminPatientsRepository {
  final AdminPatientsRemoteDataSource _remoteDataSource;

  AdminPatientsRepository(this._remoteDataSource);

  Future<Either<Failure, List<PatientEntity>>> getPatients() async {
    try {
      final patientDtoList = await _remoteDataSource.getPatients();
      final patients = patientDtoList
          .map((dto) => dto.toEntity() as PatientEntity)
          .toList();
      return Right(patients);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
