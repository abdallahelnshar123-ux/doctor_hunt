import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DialogUtils {
  static void showLoading({required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.transparent,
        contentPadding: EdgeInsets.all(20),
        content: Center(
          child: CircularProgressIndicator(color: AppColors.brandPrimary),
        ),
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    String title = '',
    required String message,
    String? posActionText,
    VoidCallback? posAction,
    String? negActionText,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionText != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionText,
            style: context.regular16.brandPrimary.rubik,
          ),
        ),
      );
    }
    if (negActionText != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionText,
            style: context.regular16.brandPrimary.rubik,
          ),
        ),
      );
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        content: Text(message, style: context.regular14.brandPrimary.rubik),
        title: Text(title, style: context.regular16.brandPrimary.rubik),
        actions: actions,
      ),
    );
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<String?> showPasswordDialog({
    required BuildContext context,
    String title = '',
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          title: Text(title, style: context.regular16.brandPrimary.rubik),
          content: Form(
            key: formKey,
            child: Column(
              spacing: 15,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message, style: context.regular14.brandPrimary.rubik),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                cancelText,
                style: context.regular16.brandPrimary.rubik,
              ),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context, passwordController.text.trim());
                }
              },
              child: Text(
                confirmText,
                style: context.regular16.brandPrimary.rubik,
              ),
            ),
          ],
        );
      },
    );
  }
}
