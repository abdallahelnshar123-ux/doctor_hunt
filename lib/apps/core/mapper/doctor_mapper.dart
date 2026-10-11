import '../../core/data/models/doctor/doctor.dart';
import '../../core/data/models/doctor/doctor_availability.dart';
import '../../core/data/models/doctor/doctor_dto.dart';
import 'rating_mapper.dart';

extension DoctorMapper on DoctorDto {
  Doctor toDoctor() {
    return Doctor(
      id: id,
      name: name,
      adminId: adminId,
      imageUrl: imageUrl,
      specialty: specialty,
      active: active,
      consultationFee: consultationFee,
      rating: rating.toDomain(),
      availability: availability != null
          ? DoctorAvailability(
              workingDays: availability!.workingDays,
              startTime: availability!.startTime,
              endTime: availability!.endTime,
              slotDuration: availability!.slotDuration,
            )
          : null,
    );
  }
}
