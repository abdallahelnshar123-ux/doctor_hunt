import 'package:doctor_hunt/generated/translations.g.dart';

class Validators {
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? t.validators.thisFieldIsRequired;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return t.validators.emailIsRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return t.validators.invalidEmailFormat;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return t.validators.passwordIsRequired;
    }

    if (value.length < 6) {
      return t.validators.passwordMustBeAtLeast6Characters;
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return t.validators.confirmPasswordIsRequired;
    }

    if (value != password) {
      return t.validators.passwordsDoNotMatch;
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return t.validators.phoneIsRequired;
    }

    final phoneRegex = RegExp(r'^[0-9]{10,15}$');

    if (!phoneRegex.hasMatch(value)) {
      return t.validators.invalidPhoneNumber;
    }

    return null;
  }
}
