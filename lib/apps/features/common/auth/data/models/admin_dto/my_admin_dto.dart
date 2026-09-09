import 'package:equatable/equatable.dart';

import '../../../../../../core/constants/firestore_constants.dart';
import '../user/my_user.dart';

class MyAdminDto extends Equatable {
  final String name;
  final String email;
  final String id;
  final UserRoles? role;

  const MyAdminDto({
    required this.id,
    required this.email,
    required this.name,
    this.role,
  });

  factory MyAdminDto.fromFireStore(Map<String, dynamic> data) {
    return MyAdminDto(
      id: data[FirestoreConstants.id]?.toString() ?? '',
      name: data[FirestoreConstants.name]?.toString() ?? '',
      email: data[FirestoreConstants.email]?.toString() ?? '',
      role: data[FirestoreConstants.role] != null
          ? UserRoles.values.firstWhere(
              (e) => e.toString() == data[FirestoreConstants.role],
              orElse: () => UserRoles.patient,
            )
          : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.name: name,
      FirestoreConstants.email: email,
      FirestoreConstants.role: role?.toString(),
    };
  }

  @override
  List<Object?> get props => [name, email, id, role];
}
