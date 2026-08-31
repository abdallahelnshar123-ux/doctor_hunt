import 'package:equatable/equatable.dart';

import '../../../auth/data/models/user/my_user.dart';

abstract class ChooseRoleEvent extends Equatable {
  const ChooseRoleEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserRoleRequested extends ChooseRoleEvent {
  final MyUser user;

  const UpdateUserRoleRequested({required this.user});

  @override
  List<Object?> get props => [user];
}
