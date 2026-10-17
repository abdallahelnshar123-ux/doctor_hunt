part of 'admin_profile_bloc.dart';

abstract class AdminProfileEvent extends Equatable {
  const AdminProfileEvent();

  @override
  List<Object?> get props => [];
}

class AdminProfileUpdateRequested extends AdminProfileEvent {
  final MyUser user;
  final File? image;

  const AdminProfileUpdateRequested({required this.user, this.image});

  @override
  List<Object?> get props => [user, image];
}

class PickAdminProfileImageRequested extends AdminProfileEvent {
  const PickAdminProfileImageRequested();
}
