import 'package:turn_digital/core/constant/strings_text.dart';

class ValidationUtils {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value)) {
      return 'Email must like: ${AppTexts.tEmailHint}';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain a lowercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain a number';
    }
    if (!RegExp(r'(?=.*[\W])').hasMatch(value)) {
      return 'Password must contain a special character';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().split(' ').length < 3) {
      return 'Full name must be at least 3 words';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return validatePassword(value);
  }
}
