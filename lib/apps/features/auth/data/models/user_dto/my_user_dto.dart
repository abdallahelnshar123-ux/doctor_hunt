import 'package:equatable/equatable.dart';

import '../../../../../core/constants/firestore_constants.dart';

class MyUserDto extends Equatable {
  final String name;
  final String email;
  final String id;
  final String provider;
  final String? image;

  const MyUserDto({
    required this.id,
    required this.email,
    required this.name,
    required this.provider,
    this.image,
  });

  factory MyUserDto.fromFireStore(Map<String, dynamic> data) {
    return MyUserDto(
      id: data[FirestoreConstants.id]?.toString() ?? '',
      name: data[FirestoreConstants.name]?.toString() ?? '',
      email: data[FirestoreConstants.email]?.toString() ?? '',
      provider: data[FirestoreConstants.provider]?.toString() ?? '',
      image: data[FirestoreConstants.image]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.name: name,
      FirestoreConstants.email: email,
      FirestoreConstants.provider: provider,
      FirestoreConstants.image: image,
    };
  }

  @override
  List<Object?> get props => [
    name,
    email,
    id,
    provider,
    image,
  ];
}
