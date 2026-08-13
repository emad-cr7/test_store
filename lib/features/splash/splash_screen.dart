import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ql/main/main_screen.dart';
import '../../core/l10n/app_localizations.dart';
import '../auth/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<Widget> _resolveNextScreen() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      return  MainScreen();
    }

    return  LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return AnimatedSplashScreen.withScreenFunction(
      duration: 2400,
      splashIconSize: 260,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: colors.primary,
      screenFunction: _resolveNextScreen,
      splash: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.onPrimary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: colors.onPrimary.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 70,
              color: colors.onPrimary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'QL Shop',
            style: textTheme.titleLarge?.copyWith(
              color: colors.onPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            t.splashTagline,
            style: textTheme.bodySmall?.copyWith(
              color: colors.onPrimary.withValues(alpha: 0.85),
              fontSize: 13,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 35),
          SizedBox(
            width: 30,
            height: 30,
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}