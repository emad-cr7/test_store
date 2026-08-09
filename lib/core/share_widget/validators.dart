class Validators {
  static String? required(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك ادخل الباسورد';
    }

    if (value.length < 6) {
      return 'الباسورد لازم يكون 6 حروف على الأقل';
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أكّد الباسورد';
    }

    if (value != password) {
      return 'الباسورد مش متطابق';
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك ادخل الإيميل';
    }

    if (!value.contains('@')) {
      return 'إيميل غير صحيح';
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'من فضلك ادخل الاسم';
    }

    if (value.trim().length < 3) {
      return 'الاسم لازم يكون 3 حروف على الأقل';
    }

    return null;
  }
}