// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get loginSubtitle => 'Login to continue shopping';

  @override
  String get email => 'Email';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get login => 'Login';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get createAccount => 'Create Account';

  @override
  String get registerSubtitle => 'Sign up to start shopping';

  @override
  String get fullName => 'Full Name';

  @override
  String get enterYourFullName => 'Enter your full name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get reEnterYourPassword => 'Re-enter your password';

  @override
  String get register => 'Register';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email and we will send you a link to reset your password';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get changePassword => 'Change Password';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmTitle => 'Logout';

  @override
  String get logoutConfirmDesc => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get store => 'Store';

  @override
  String get cart => 'Cart';

  @override
  String get favorite => 'Favorite';

  @override
  String get noProductsInCart => 'No products in cart.';

  @override
  String get noFavoriteProducts => 'No favorite products found.';

  @override
  String get searchProducts => 'Search products...';

  @override
  String get product => 'Product';

  @override
  String get viewAll => 'View all';

  @override
  String get category => 'Category';

  @override
  String noProductsInCategory(String category) {
    return 'No products in \"$category\" yet';
  }

  @override
  String get productDetails => 'Product Details';

  @override
  String get description => 'Description';

  @override
  String get noDescriptionAvailable => 'No description available.';

  @override
  String get showMore => ' Show more';

  @override
  String get showLess => ' Show less';

  @override
  String get splashTagline => 'Shop the best, effortlessly';

  @override
  String get navHome => 'Home';

  @override
  String get navFavorite => 'Favorite';

  @override
  String get navCart => 'Cart';

  @override
  String get navProfile => 'Profile';

  @override
  String get changePasswordSubtitle =>
      'Enter your current password and choose a new password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get enterCurrentPassword => 'Enter current password';

  @override
  String get pleaseEnterCurrentPassword => 'Please enter your current password';

  @override
  String get newPassword => 'New Password';

  @override
  String get enterNewPassword => 'Enter new password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get confirmNewPasswordHint => 'Confirm new password';

  @override
  String get error => 'Error';

  @override
  String get pleaseVerifyEmail => 'Please verify your email first.';

  @override
  String get incorrectCredentials => 'Incorrect email or password.';

  @override
  String get invalidEmailAddress => 'Please enter a valid email address.';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get weakPasswordProvided => 'The password provided is too weak.';

  @override
  String get emailAlreadyInUse => 'The account already exists for that email.';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email.';

  @override
  String get resetLinkSentTitle => 'Sent';

  @override
  String get resetLinkSentDesc =>
      'A password reset link has been sent to your email.';

  @override
  String get genericTryAgain => 'Something went wrong, please try again.';

  @override
  String get userNotFoundForEmail => 'No account found for this email.';

  @override
  String get invalidEmailFormat => 'Invalid email format.';

  @override
  String get tooManyRequests => 'Too many attempts, please try again later.';

  @override
  String get checkInternetConnection =>
      'Check your internet connection and try again.';

  @override
  String get checkEnteredEmail => 'Please check the email you entered.';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully';

  @override
  String get currentPasswordIncorrect => 'Current password is incorrect';

  @override
  String get newPasswordTooWeak => 'New password is too weak';

  @override
  String get pleaseLoginAgainAndTry => 'Please login again and try again';

  @override
  String get productAddedToFavorites => 'Product added to favorites';

  @override
  String get productRemovedFromFavorites => 'Product removed from favorites';

  @override
  String get productAddedToCart => 'Product added to cart';

  @override
  String get productRemovedFromCart => 'Product removed from cart';

  @override
  String get pleaseEnterPassword => 'Please enter the password.';

  @override
  String get passwordMinLength =>
      'The password must be at least 6 characters long.';

  @override
  String get pleaseConfirmPassword => 'Please confirm the password.';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match.';

  @override
  String get pleaseEnterEmail => 'Please enter your email.';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get pleaseEnterName => 'Please enter the name.';

  @override
  String get nameMinLength => 'The name must be at least 3 characters long.';

  @override
  String get categoryClothes => 'Clothes';

  @override
  String get categoryElectronics => 'Electronics';

  @override
  String get categoryFurniture => 'Furniture';

  @override
  String get categoryShoes => 'Shoes';

  @override
  String get categoryOthers => 'Others';

  @override
  String get editProfileSubtitle => 'Update your name below';

  @override
  String get save => 'Save';

  @override
  String get nameUpdatedSuccessfully => 'Name updated successfully';
}
