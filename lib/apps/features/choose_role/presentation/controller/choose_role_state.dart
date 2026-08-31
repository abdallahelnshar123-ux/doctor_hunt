import 'package:equatable/equatable.dart';

abstract class ChooseRoleState extends Equatable {
  const ChooseRoleState();

  @override
  List<Object?> get props => [];
}

class ChooseRoleInitial extends ChooseRoleState {}

class UpdateUserRoleLoading extends ChooseRoleState {}

class UpdateUserRoleSuccess extends ChooseRoleState {}

class UpdateUserRoleError extends ChooseRoleState {
  final String message;

  const UpdateUserRoleError(this.message);

  @override
  List<Object?> get props => [message];
}
