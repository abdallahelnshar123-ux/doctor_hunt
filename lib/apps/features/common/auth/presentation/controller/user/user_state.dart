import 'package:equatable/equatable.dart';

import '../../../data/models/user/my_user.dart';

class UserState extends Equatable {
  final MyUser? user;
  final String? favoriteError;

  const UserState({this.user, this.favoriteError});

  bool get isAuthenticated => user != null;

  UserState copyWith({
    MyUser? user,
    String? favoriteError,
    bool clearError = false,
  }) {
    return UserState(
      user: user ?? this.user,
      favoriteError: clearError ? null : (favoriteError ?? this.favoriteError),
    );
  }

  @override
  List<Object?> get props => [user, favoriteError];
}
