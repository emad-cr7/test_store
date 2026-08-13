// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcomeBack => 'مرحبًا بعودتك!';

  @override
  String get language => 'اللغة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get loginSubtitle => 'سجّل الدخول لمتابعة التسوق';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get createAccount => 'إنشاء حساب جديد';

  @override
  String get registerSubtitle => 'أنشئ حسابًا لبدء التسوق';

  @override
  String get fullName => 'الاسم بالكامل';

  @override
  String get enterYourFullName => 'أدخل اسمك بالكامل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get reEnterYourPassword => 'أعد إدخال كلمة المرور';

  @override
  String get register => 'تسجيل';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirmTitle => 'تسجيل الخروج';

  @override
  String get logoutConfirmDesc => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get yes => 'نعم';

  @override
  String get store => 'المتجر';

  @override
  String get cart => 'السلة';

  @override
  String get favorite => 'المفضلة';

  @override
  String get noProductsInCart => 'لا توجد منتجات في السلة.';

  @override
  String get noFavoriteProducts => 'لا توجد منتجات مفضلة.';

  @override
  String get searchProducts => 'ابحث عن المنتجات...';

  @override
  String get product => 'المنتج';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get category => 'الفئة';

  @override
  String noProductsInCategory(String category) {
    return 'لا توجد منتجات في \"$category\" حتى الآن';
  }

  @override
  String get productDetails => 'تفاصيل المنتج';

  @override
  String get description => 'الوصف';

  @override
  String get noDescriptionAvailable => 'لا يوجد وصف متاح.';

  @override
  String get showMore => ' عرض المزيد';

  @override
  String get showLess => ' عرض أقل';

  @override
  String get splashTagline => 'تسوّق الأفضل بكل سهولة';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navFavorite => 'المفضلة';

  @override
  String get navCart => 'السلة';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get changePasswordSubtitle =>
      'أدخل كلمة المرور الحالية واختر كلمة مرور جديدة';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get enterCurrentPassword => 'أدخل كلمة المرور الحالية';

  @override
  String get pleaseEnterCurrentPassword => 'من فضلك أدخل كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get enterNewPassword => 'أدخل كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get confirmNewPasswordHint => 'أكد كلمة المرور الجديدة';

  @override
  String get error => 'خطأ';

  @override
  String get pleaseVerifyEmail => 'من فضلك قم بتفعيل بريدك الإلكتروني أولاً.';

  @override
  String get incorrectCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get invalidEmailAddress => 'من فضلك أدخل بريدًا إلكترونيًا صحيحًا.';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get weakPasswordProvided => 'كلمة المرور المدخلة ضعيفة جدًا.';

  @override
  String get emailAlreadyInUse => 'يوجد حساب بالفعل لهذا البريد الإلكتروني.';

  @override
  String get pleaseEnterValidEmail => 'من فضلك أدخل بريدًا إلكترونيًا صحيحًا.';

  @override
  String get resetLinkSentTitle => 'تم الإرسال';

  @override
  String get resetLinkSentDesc =>
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.';

  @override
  String get genericTryAgain => 'حدث خطأ، حاول مرة أخرى.';

  @override
  String get userNotFoundForEmail =>
      'لا يوجد حساب مرتبط بهذا البريد الإلكتروني.';

  @override
  String get invalidEmailFormat => 'صيغة البريد الإلكتروني غير صحيحة.';

  @override
  String get tooManyRequests => 'محاولات كثيرة، حاول مرة أخرى بعد قليل.';

  @override
  String get checkInternetConnection =>
      'تأكد من اتصالك بالإنترنت وحاول مرة أخرى.';

  @override
  String get checkEnteredEmail => 'تأكد من البريد الذي قمت بإدخاله.';

  @override
  String get passwordChangedSuccessfully => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get currentPasswordIncorrect => 'كلمة المرور الحالية غير صحيحة';

  @override
  String get newPasswordTooWeak => 'كلمة المرور الجديدة ضعيفة جدًا';

  @override
  String get pleaseLoginAgainAndTry =>
      'من فضلك سجل الدخول مرة أخرى وحاول مجددًا';

  @override
  String get productAddedToFavorites => 'تمت إضافة المنتج إلى المفضلة';

  @override
  String get productRemovedFromFavorites => 'تمت إزالة المنتج من المفضلة';

  @override
  String get productAddedToCart => 'تمت إضافة المنتج إلى السلة';

  @override
  String get productRemovedFromCart => 'تمت إزالة المنتج من السلة';

  @override
  String get pleaseEnterPassword => 'من فضلك أدخل كلمة المرور.';

  @override
  String get passwordMinLength => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل.';

  @override
  String get pleaseConfirmPassword => 'من فضلك أكد كلمة المرور.';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get pleaseEnterEmail => 'من فضلك أدخل بريدك الإلكتروني.';

  @override
  String get invalidEmail => 'بريد إلكتروني غير صحيح';

  @override
  String get pleaseEnterName => 'من فضلك أدخل الاسم.';

  @override
  String get nameMinLength => 'يجب أن يكون الاسم 3 أحرف على الأقل.';

  @override
  String get categoryClothes => 'ملابس';

  @override
  String get categoryElectronics => 'إلكترونيات';

  @override
  String get categoryFurniture => 'أثاث';

  @override
  String get categoryShoes => 'أحذية';

  @override
  String get categoryOthers => 'أخرى';

  @override
  String get editProfileSubtitle => 'قم بتحديث اسمك بالأسفل';

  @override
  String get save => 'حفظ';

  @override
  String get nameUpdatedSuccessfully => 'تم تحديث الاسم بنجاح';
}
