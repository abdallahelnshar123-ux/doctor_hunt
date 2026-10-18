import 'package:equatable/equatable.dart';

import '../../../../features/common/auth/data/models/user/my_user.dart';

class UserState extends Equatable {
  final MyUser? user;
  final String? favoriteError;

  const UserState({this.user, this.favoriteError});

  bool get isAuthenticated => user != null;

  UserState copyWith({
    MyUser? user,
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
