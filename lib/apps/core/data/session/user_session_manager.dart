import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../features/common/auth/data/mappers/user_mapper.dart';
import '../../../features/common/auth/domain/entity/user/app_user.dart';
import '../shared_prefs/user_pref.dart';

@lazySingleton
class UserSessionManager {
  final UserPrefs _userPrefs;

  final StreamController<AppUserEntity?> _userStreamController =
      StreamController<AppUserEntity?>.broadcast();

  final StreamController<bool> _authStateController =
      StreamController<bool>.broadcast();

  AppUserEntity? _currentUser;

  UserSessionManager(this._userPrefs) {
    final userDto = _userPrefs.getCurrentUser();
    if (userDto != null) {
      _currentUser = userDto.toEntity();
    }
  }

  AppUserEntity? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Stream<AppUserEntity?> get userStream async* {
    yield _currentUser;
    yield* _userStreamController.stream;
  }

  Stream<bool> get authStateStream async* {
    yield isLoggedIn;
    yield* _authStateController.stream;
  }

  void updateUser(AppUserEntity? user) {
    final bool wasLoggedIn = isLoggedIn;
    _currentUser = user;
    if (user != null) {
      _userPrefs.setUser(user.toDto());
    } else {
      _userPrefs.clearUser();
    }
    _userStreamController.add(_currentUser);

    // Only notify auth stream if login state actually changed
    if (wasLoggedIn != isLoggedIn) {
      _authStateController.add(isLoggedIn);
    }
  }

  Option<AppUserEntity> getCurrentUser() {
    try {
      if (_currentUser != null) {
        return Some(_currentUser!);
      }
      final userDto = _userPrefs.getCurrentUser();
      if (userDto != null) {
        final user = userDto.toEntity();
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
    _authStateController.close();
  }
}
