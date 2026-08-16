class Validators {
  static String? required(
    String? value, {
    String message = "this_field_is_required",
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "email_is_required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "invalid_email_format";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "password_is_required";
    }

    if (value.length < 6) {
      return "password_must_be_at_least_6_characters";
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "confirm_password_is_required";
    }

    if (value != password) {
      return "passwords_do_not_match";
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "phone_is_required";
    }

    final phoneRegex = RegExp(r'^[0-9]{10,15}$');

    if (!phoneRegex.hasMatch(value)) {
      return "invalid_phone_number";
    }

    return null;
  }
}
