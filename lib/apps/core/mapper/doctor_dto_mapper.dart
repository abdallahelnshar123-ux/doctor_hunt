import '../../core/data/models/doctor/doctor.dart';
import '../../core/data/models/doctor/doctor_dto.dart';
import 'rating_dto_mapper.dart';

extension DoctorDtoMapper on Doctor {
  DoctorDto toDoctorDto() {
    return DoctorDto(
      id: id,
      adminId: adminId,
      name: name,
      imageUrl: imageUrl,
      specialty: specialty,
      active: active,
      consultationFee: consultationFee,
      rating: rating.toDto(),
    );
  }
}
