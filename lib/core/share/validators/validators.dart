import '../../../main.dart';
import '../../l10n/app_localizations.dart';

class Validators {
  static AppLocalizations get _t =>
      AppLocalizations.of(navigatorKey.currentContext!)!;

  static String? required(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return _t.pleaseEnterPassword;
    }

    if (value.length < 6) {
      return _t.passwordMinLength;
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return _t.pleaseConfirmPassword;
    }

    if (value != password) {
      return _t.passwordsDoNotMatch;
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return _t.pleaseEnterEmail;
    }

    if (!value.contains('@')) {
      return _t.invalidEmail;
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _t.pleaseEnterName;
    }

    if (value.trim().length < 3) {
      return _t.nameMinLength;
    }

    return null;
  }
}
