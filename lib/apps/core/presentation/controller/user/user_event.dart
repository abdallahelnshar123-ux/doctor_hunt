import 'package:equatable/equatable.dart';

import '../../../../features/common/auth/data/models/user/my_user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserStreamUpdatedEvent extends UserEvent {
  final MyUser? user;

  const UserStreamUpdatedEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class ToggleFavoriteDoctorEvent extends UserEvent {
  final String doctorId;

  const ToggleFavoriteDoctorEvent(this.doctorId);

  @override
  List<Object?> get props => [doctorId];
}
