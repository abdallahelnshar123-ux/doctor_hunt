import 'package:equatable/equatable.dart';

import '../../../../../core/constants/firestore_constants.dart';
import '../user/my_user.dart';

class MyUserDto extends Equatable {
  final String name;
  final String email;
  final String id;
  final String provider;
  final String? image;
  final UserRoles? role;

  const MyUserDto({
    required this.id,
    required this.email,
    required this.name,
    required this.provider,
    this.image,
    this.role,
  });

  factory MyUserDto.fromFireStore(Map<String, dynamic> data) {
    return MyUserDto(
      id: data[FirestoreConstants.id]?.toString() ?? '',
      name: data[FirestoreConstants.name]?.toString() ?? '',
      email: data[FirestoreConstants.email]?.toString() ?? '',
      provider: data[FirestoreConstants.provider]?.toString() ?? '',
      image: data[FirestoreConstants.image]?.toString() ?? '',
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
      FirestoreConstants.provider: provider,
      FirestoreConstants.image: image,
      FirestoreConstants.role: role?.toString(),
    };
  }

  @override
  List<Object?> get props => [name, email, id, provider, image, role];
}
