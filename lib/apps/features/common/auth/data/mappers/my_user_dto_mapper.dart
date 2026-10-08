import '../models/user/my_user.dart';
import '../models/user_dto/admin_info_dto.dart';
import '../models/user_dto/my_user_dto.dart';
import '../models/user_dto/patient_info_dto.dart';

extension MyUserDtoMapper on MyUser {
  MyUserDto toMyUserDto() {
    return MyUserDto(
      id: id,
      email: email,
      name: name,
      provider: provider,
      image: image,
      role: role,
      phone: phone,
      patientInfo: patientInfo != null
          ? PatientInfoDto.fromDomain(patientInfo!)
          : null,
      adminInfo: adminInfo != null ? AdminInfoDto.fromDomain(adminInfo!) : null,
    );
  }
}
