import 'package:doctor_hunt/generated/translations.g.dart';

class Validators {
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? t.core.validators.thisFieldIsRequired;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return t.core.validators.emailIsRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return t.core.validators.invalidEmailFormat;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return t.core.validators.passwordIsRequired;
    }

    if (value.length < 6) {
      return t.core.validators.passwordMustBeAtLeast6Characters;
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return t.core.validators.confirmPasswordIsRequired;
    }

    if (value != password) {
      return t.core.validators.passwordsDoNotMatch;
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return t.core.validators.phoneIsRequired;
    }

    final phoneRegex = RegExp(r'^[0-9]{10,15}$');

    if (!phoneRegex.hasMatch(value)) {
      return t.core.validators.invalidPhoneNumber;
    }

    return null;
  }

  static int countWords(String? text) {
    if (text == null) return 0;
    final trimmed = text.trim();
    if (trimmed.isEmpty) return 0;
    return trimmed.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
  }

  static String? doctorBio(String? value, {int minWords = 10, int maxWords = 100}) {
    if (value == null || value.trim().isEmpty) {
      return t.core.validators.bioIsRequired;
    }
    final words = countWords(value);
    if (words < minWords) {
      return t.core.validators.bioTooShort(Min: minWords);
    }
    if (words > maxWords) {
      return t.core.validators.bioTooLong(Max: maxWords);
    }
    return null;
  }
}
