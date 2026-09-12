import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/models/doctor_dto/doctor_dto.dart';

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
