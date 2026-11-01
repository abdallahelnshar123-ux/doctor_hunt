import '../../domain/entity/user/admin.dart';
import '../../domain/entity/user/app_user.dart';
import '../../domain/entity/user/doctor.dart';
import '../../domain/entity/user/patient.dart';
import '../dto/user/admin_dto.dart';
import '../dto/user/app_user_dto.dart';
import '../dto/user/doctor_dto.dart';
import '../dto/user/patient_dto.dart';

extension AppUserDtoMapper on AppUserDto {
  AppUserEntity toEntity() {
    if (this is AdminDto) {
      final dto = this as AdminDto;
      return AdminEntity(
        id: dto.id,
        email: dto.email,
        name: dto.name,
        provider: dto.provider,
        image: dto.image,
        phone: dto.phone,
      );
    } else if (this is PatientDto) {
      final dto = this as PatientDto;
      return PatientEntity(
        id: dto.id,
        email: dto.email,
        name: dto.name,
        provider: dto.provider,
        image: dto.image,
        phone: dto.phone,
        favDoctors: dto.favDoctors,
      );
    } else if (this is DoctorDto) {
      final dto = this as DoctorDto;
      return DoctorEntity(
        id: dto.id,
        email: dto.email,
        name: dto.name,
        provider: dto.provider,
        image: dto.image,
        phone: dto.phone,
        adminId: dto.adminId,
        specialty: dto.specialty,
        active: dto.active,
        consultationFee: dto.consultationFee,
        rating: dto.rating,
        availability: dto.availability,
      );
    }
    throw Exception('Unknown AppUserDto type');
  }
}

extension AppUserEntityMapper on AppUserEntity {
  AppUserDto toDto() {
    if (this is AdminEntity) {
      final entity = this as AdminEntity;
      return AdminDto(
        id: entity.id,
        email: entity.email,
        name: entity.name,
        provider: entity.provider,
        image: entity.image,
        phone: entity.phone,
      );
    } else if (this is PatientEntity) {
      final entity = this as PatientEntity;
      return PatientDto(
        id: entity.id,
        email: entity.email,
        name: entity.name,
        provider: entity.provider,
        image: entity.image,
        phone: entity.phone,
        favDoctors: entity.favDoctors,
      );
    } else if (this is DoctorEntity) {
      final entity = this as DoctorEntity;
      return DoctorDto(
        id: entity.id,
        email: entity.email,
        name: entity.name,
        provider: entity.provider,
        image: entity.image,
        phone: entity.phone,
        adminId: entity.adminId,
        specialty: entity.specialty,
        active: entity.active,
        // consultationFee: entity.consultationFee,
        rating: entity.rating,
        availability: entity.availability,
      );
    }
    throw Exception('Unknown AppUserEntity type');
  }
}
