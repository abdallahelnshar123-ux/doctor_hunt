import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/repo/doctor_repository.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDoctorsUseCase {
  final DoctorRepository _repository;

  GetDoctorsUseCase(this._repository);

  Stream<Either<Failure, List<Doctor>>> call({
    required String userId,
    required UserRoles role,
  }) {
    return _repository.getAccounts().map((event) {
      return event.fold(
        (failure) => Left(failure),
        (doctors) {
          if (role == UserRoles.admin) {
            final filteredDoctors =
                doctors.where((doctor) => doctor.adminId == userId).toList();
            return Right(filteredDoctors);
          }
          return Right(doctors);
        },
      );
    });
  }
}
