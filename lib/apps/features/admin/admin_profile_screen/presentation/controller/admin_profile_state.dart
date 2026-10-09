part of 'admin_profile_bloc.dart';

abstract class AdminProfileState extends Equatable {
  const AdminProfileState();

  @override
  List<Object?> get props => [];
}

class AdminProfileInitial extends AdminProfileState {}

class AdminProfileLoading extends AdminProfileState {}

class AdminProfileUpdateSuccess extends AdminProfileState {
  final MyUser user;

  const AdminProfileUpdateSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AdminProfileUpdateError extends AdminProfileState {
  final String message;

  const AdminProfileUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}

class PickAdminImageSuccessState extends AdminProfileState {
  final File image;

  const PickAdminImageSuccessState(this.image);

  @override
  List<Object?> get props => [image];
}

class PickAdminImageErrorState extends AdminProfileState {
  final String message;

  const PickAdminImageErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
