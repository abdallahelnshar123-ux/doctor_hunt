import 'package:equatable/equatable.dart';

import '../user/admin_info.dart';

class AdminInfoDto extends Equatable {
  const AdminInfoDto();

  factory AdminInfoDto.fromFireStore(Map<String, dynamic>? data) {
    return const AdminInfoDto();
  }

  Map<String, dynamic> toFireStore() {
    return {};
  }

  AdminInfo toDomain() => const AdminInfo();

  factory AdminInfoDto.fromDomain(AdminInfo info) => const AdminInfoDto();

  @override
  List<Object?> get props => [];
}
