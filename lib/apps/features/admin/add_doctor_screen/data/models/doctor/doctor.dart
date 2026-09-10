import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String name;
  final String id;
  final String adminId;
  final String? image;

  const Doctor({
    required this.id,
    required this.name,
    required this.adminId,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, adminId, image];

  Doctor copyWith({String? image}) {
    return Doctor(
      id: id,
      name: name,
      image: image ?? this.image,
      adminId: adminId,
    );
  }
}
