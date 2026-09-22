import '../../core/data/models/doctor/doctor.dart';
import '../../core/data/models/doctor/doctor_dto.dart';

extension DoctorMapper on DoctorDto {
  Doctor toDoctor() {
    return Doctor(
      id: id,
      name: name,
      adminId: adminId,
      imageUrl: imageUrl,
      specialty: specialty,
      active: active,
    );
  }
}
