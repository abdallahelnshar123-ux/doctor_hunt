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
  
  final StreamController<bool> _authStateController =
      StreamController<bool>.broadcast();

  MyUser? _currentUser;

  UserSessionManager(this._userPrefs){
    final userDto = _userPrefs.getCurrentUser();
    if (userDto != null) {
      _currentUser = userDto.toUser();
    }
  }

  MyUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  
  Stream<MyUser?> get userStream async* {
    yield _currentUser;
    yield* _userStreamController.stream;
  }
  
  Stream<bool> get authStateStream async* {
    yield isLoggedIn;
    yield* _authStateController.stream;
  }

  void updateUser(MyUser? user) {
    final bool wasLoggedIn = isLoggedIn;
    _currentUser = user;
    if (user != null) {
      _userPrefs.setUser(user.toMyUserDto());
    } else {
      _userPrefs.clearUser();
    }
    _userStreamController.add(_currentUser);
    
    // Only notify auth stream if login state actually changed
    if (wasLoggedIn != isLoggedIn) {
      _authStateController.add(isLoggedIn);
    }
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
