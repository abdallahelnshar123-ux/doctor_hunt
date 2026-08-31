import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String name;
  final String email;
  final String id;
  final String provider;
  final String? image;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.provider,
    this.image,
  });

  @override
  List<Object?> get props => [id, email, name, provider, image];

  MyUser copyWith({String? name, String? image}) {
    return MyUser(
      id: id,
      name: name ?? this.name,
      email: email,
      provider: provider,
      image: image ?? this.image,
    );
  }
}
