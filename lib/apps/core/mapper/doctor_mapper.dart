//CR Architecture Violation: Core mappers must not depend on feature-level models (features/admin/add_doctor_screen/...). Move Doctor models and mappers to a shared feature or domain layer.
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
