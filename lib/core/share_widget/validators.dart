class Validators {
  static String? required(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the password.';
    }

    if (value.length < 6) {
      return 'The password must be at least 6 characters long.';
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return 'Please confirm the password.';
    }

    if (value != password) {
      return 'The passwords do not match.';
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    }

    if (!value.contains('@')) {
      return 'Invalid email';
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the name.';
    }

    if (value.trim().length < 3) {
      return 'The name must be at least 3 characters long.';
    }

    return null;
  }
}