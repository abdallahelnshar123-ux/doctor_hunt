import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/dto/user/doctor_dto.dart';

abstract class DoctorRemoteDataSource {
  Future<void> addDoctor({
    required DoctorDto doctor,
    required String password,
  });

  Future<DoctorDto> getDoctorById(String doctorId);

  Stream<List<DoctorDto>> getDoctorsStreamForAdmin({required String adminId});

  Stream<List<DoctorDto>> getDoctorsStreamForPatient();

  Future<void> updateDoctorActiveStatus({
    required String doctorId,
    required bool active,
  });

  Future<void> updateDoctorDetails(DoctorDto doctor);

  Future<void> updateAvailability({
    required String doctorId,
    required DoctorAvailabilityDto availability,
  });

  Future<void> deleteDoctor({required String doctorId});
}
