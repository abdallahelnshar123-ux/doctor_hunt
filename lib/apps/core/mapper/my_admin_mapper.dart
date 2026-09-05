import 'package:doctor_hunt/apps/features/auth/data/models/admin/my_admin.dart';
import 'package:doctor_hunt/apps/features/auth/data/models/admin_dto/my_admin_dto.dart';

extension UserMapper on MyAdminDto {
  MyAdmin toMyAdmin() {
    return MyAdmin(id: id, email: email, name: name, role: role);
  }
}
