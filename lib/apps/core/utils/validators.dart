import 'package:doctor_hunt/generated/translations.g.dart';

class Validators {
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? t.validators.this_field_is_required;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return t.validators.email_is_required;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return t.validators.invalid_email_format;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return t.validators.password_is_required;
    }

    if (value.length < 6) {
      return t.validators.password_must_be_at_least6_characters;
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return t.validators.confirm_password_is_required;
    }

    if (value != password) {
      return t.validators.passwords_do_not_match;
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return t.validators.phone_is_required;
    }

    final phoneRegex = RegExp(r'^[0-9]{10,15}$');

    if (!phoneRegex.hasMatch(value)) {
      return t.validators.invalid_phone_number;
    }

    return null;
  }
}
