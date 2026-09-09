import 'dart:convert';

import 'package:doctor_hunt/apps/core/data/prefs_keys.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/my_user_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class UserPrefs {
  UserPrefs(this._preferences);

  final SharedPreferences _preferences;

  Future<void> setUserToken(String token) async {
    await _preferences.setString(PrefsKeys.tokenKey, token);
  }

  Future<void> setUser(MyUserDto user) async {
    await _preferences.setString(PrefsKeys.userKey, jsonEncode(user.toJson()));
  }

  // Future<void> setUserFcmToken(String fcm) async {
  //   await _preferences.setString('fcm', fcm);
  // }

  // String getUserFcmToken() => _preferences.getString('fcm') ?? '';

  String getUserToken() => _preferences.getString(PrefsKeys.tokenKey) ?? '';

  /// Logout user by clearing all user-related data
  // Future<void> logout() async {
  //   await _preferences.remove(sharedTokenId);
  //   await _preferences.remove('user');
  //   await _preferences.remove('temp');
  //   await _preferences.remove('userType');
  //   await _preferences.remove(likedArticlesPrefsKey);
  // }

  // Future<void> setUserTopic(List<String> topics) async {
  //   await _preferences.setStringList('topics', topics);
  // }

  // List<String>? getUserTopic() => _preferences.getStringList('topics');

  bool get isUserLoggedIn =>
      getUserToken().isNotEmpty && getCurrentUser() != null;

  MyUserDto? getCurrentUser() {
    final userJson = _preferences.getString(PrefsKeys.userKey);
    if (userJson == null || userJson.isEmpty) return null;
    try {
      return MyUserDto.fromJson(jsonDecode(userJson));
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUserType(String userType) async {
    await _preferences.setString('userType', userType);
  }

  // UserTypeEnum getUserType() {
  //   final userTypeString = _preferences.getString('userType') ?? '';
  //   return UserTypeEnum.fromString(userTypeString);
  // }

  // bool get isSuperVisor => getCurrentUser()?.type == UserTypeEnum.supervisor;
}
