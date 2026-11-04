import 'dart:convert';

import 'package:doctor_hunt/apps/core/data/shared_prefs/prefs_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/common/auth/data/dto/user/app_user_dto.dart';

@lazySingleton
class UserPrefs {
  UserPrefs(this._preferences);

  final SharedPreferences _preferences;

  Future<void> setUserToken(String token) async {
    await _preferences.setString(PrefsKeys.tokenKey, token);
  }

  Future<void> setUser(AppUserDto user) async {
    try {
      await _preferences.setString(
        PrefsKeys.userKey,
        jsonEncode(user.toJson()),
      );
    } catch (e, stack) {
      debugPrint('Error saving user to UserPrefs: $e\n$stack');
    }
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

  bool get isUserLoggedIn => getCurrentUser() != null;

  Future<void> clearUser() async {
    await _preferences.remove(PrefsKeys.userKey);
    // await _preferences.remove(PrefsKeys.tokenKey);
  }

  AppUserDto? getCurrentUser() {
    final userJson = _preferences.getString(PrefsKeys.userKey);
    if (userJson == null || userJson.isEmpty) return null;
    try {
      return AppUserDto.fromJson(jsonDecode(userJson));
    } catch (e, stack) {
      debugPrint('Error parsing user in UserPrefs: $e\n$stack');
      return null;
    }
  }

  // Future<void> saveUserType(String userType) async {
  //   await _preferences.setString('userType', userType);
  // }

  bool get onboarding => _preferences.getBool(PrefsKeys.onBoardingKey) ?? false;

  Future<void> setOnboardingDone() async {
    await _preferences.setBool(PrefsKeys.onBoardingKey, true);
  }
  // UserTypeEnum getUserType() {
  //   final userTypeString = _preferences.getString('userType') ?? '';
  //   return UserTypeEnum.fromString(userTypeString);
  // }

  // bool get isSuperVisor => getCurrentUser()?.type == UserTypeEnum.supervisor;
}
