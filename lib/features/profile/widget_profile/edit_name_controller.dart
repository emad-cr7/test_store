import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/share/widgets/custom_snackbar.dart';
import '../../../main.dart';

class EditNameController extends ChangeNotifier {

  static final ValueNotifier<String?> displayNameNotifier = ValueNotifier(
    FirebaseAuth.instance.currentUser?.displayName,
  );

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  bool isLoading = false;

  EditNameController() {
    nameController.text = FirebaseAuth.instance.currentUser?.displayName ?? '';
  }

  Future<void> updateName() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    final context = navigatorKey.currentContext;
    final t = context != null ? AppLocalizations.of(context) : null;

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('User is not logged in');
      }

      final newName = nameController.text.trim();

      await user.updateDisplayName(newName);
      await user.reload();

      displayNameNotifier.value = newName;

      if (context != null && t != null) {
        AppSnackBar.show(
          context,
          message: t.nameUpdatedSuccessfully,
          icon: Icons.check_circle_outline,
          backgroundColor: Colors.green,
        );
      }

      navigatorKey.currentState?.pop();
    } catch (e) {
      if (context != null && t != null) {
        AppSnackBar.show(
          context,
          message: t.somethingWentWrong,
          icon: Icons.error_outline,
          backgroundColor: Colors.red,
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
