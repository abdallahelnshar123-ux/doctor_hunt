import '../../core/data/models/doctor/doctor.dart';
import '../../core/data/models/doctor/doctor_dto.dart';

extension DoctorMapper on Doctor {
  DoctorDto toDoctorDto() {
    return DoctorDto(
      id: id,
      adminId: adminId,
      name: name,
      imageUrl: imageUrl,
      specialty: specialty,
      active: active,
    );
  }
}
