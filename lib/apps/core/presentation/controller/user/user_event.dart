import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../features/common/auth/domain/entity/user/app_user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserStreamUpdatedEvent extends UserEvent {
  final AppUserEntity? user;

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

class UpdateUserProfileEvent extends UserEvent {
  final AppUserEntity user;
  final File? image;

  const UpdateUserProfileEvent({
    required this.user,
    this.image,
  });

  @override
  List<Object?> get props => [user, image];
}
