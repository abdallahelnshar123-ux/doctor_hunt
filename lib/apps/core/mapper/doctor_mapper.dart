import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/data/models/doctor_dto/doctor_dto.dart';

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
