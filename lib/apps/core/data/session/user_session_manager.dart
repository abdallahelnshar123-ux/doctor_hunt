import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../features/common/auth/data/mappers/my_user_dto_mapper.dart';
import '../../../features/common/auth/data/mappers/my_user_mapper.dart';
import '../../../features/common/auth/data/models/user/my_user.dart';
import '../shared_prefs/user_pref.dart';

@lazySingleton
class UserSessionManager {
  final UserPrefs _userPrefs;

  final StreamController<MyUser?> _userStreamController =
      StreamController<MyUser?>.broadcast();

  MyUser? _currentUser;

  UserSessionManager(this._userPrefs);

  MyUser? get currentUser => _currentUser;

  Stream<MyUser?> get userStream async* {
    yield _currentUser;
    yield* _userStreamController.stream;
  }

  void updateUser(MyUser? user) {
    _currentUser = user;
    if (user != null) {
      _userPrefs.setUser(user.toMyUserDto());
    } else {
      _userPrefs.clearUser();
    }
    _userStreamController.add(_currentUser);
  }

  Option<MyUser> getCurrentUser() {
    try {
      if (_currentUser != null) {
        return Some(_currentUser!);
      }
      final userDto = _userPrefs.getCurrentUser();
      if (userDto != null) {
        final user = userDto.toUser();
        _currentUser = user;
        return Some(user);
      } else {
        return none();
      }
    } catch (e) {
      return none();
    }
  }

  void clearSession() {
    updateUser(null);
  }

  void dispose() {
    _userStreamController.close();
  }
}
