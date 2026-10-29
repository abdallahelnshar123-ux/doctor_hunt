import 'package:equatable/equatable.dart';

import '../../../../features/common/auth/domain/entity/user/app_user.dart';

class UserState extends Equatable {
  final AppUserEntity? user;
  final String? favoriteError;

  const UserState({this.user, this.favoriteError});

  bool get isAuthenticated => user != null;

  UserState copyWith({
    AppUserEntity? user,
    String? favoriteError,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return UserState(
      user: clearUser ? null : (user ?? this.user),
      favoriteError: clearError ? null : (favoriteError ?? this.favoriteError),
    );
  }

  @override
  List<Object?> get props => [user, favoriteError];
}
