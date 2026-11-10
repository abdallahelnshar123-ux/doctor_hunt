import 'package:equatable/equatable.dart';

import '../../../../features/common/auth/domain/entity/user/app_user.dart';

abstract class UserState extends Equatable {
  final AppUserEntity? user;
  final String? favoriteError;

  const UserState({this.user, this.favoriteError});

  bool get isAuthenticated => user != null;

  @override
  List<Object?> get props => [user, favoriteError];
}

class UserDataState extends UserState {
  const UserDataState({super.user, super.favoriteError});
}

class UserLoadingState extends UserState {
  const UserLoadingState({super.user, super.favoriteError});
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({
    super.user,
    super.favoriteError,
    required this.message,
  });

  @override
  List<Object?> get props => [user, favoriteError, message];
}
