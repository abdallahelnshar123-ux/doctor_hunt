import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DialogUtils {
  /// Shared helper method to present non-dismissible dialogs wrapped in [PopScope].
  static Future<T?> _showAppDialog<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = false,
    bool canPop = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PopScope(canPop: canPop, child: child),
    );
  }

  /// Shared helper method to build styled action buttons for dialogs.
  static Widget _buildActionButton({
    required BuildContext context,
    required String text,
    VoidCallback? onPressed,
  }) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        onPressed?.call();
      },
      child: Text(text, style: context.medium16.brandPrimary.rubik),
    );
  }

  static void showLoading({required BuildContext context}) {
    _showAppDialog(
      context: context,
      child: const AlertDialog(
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
    final List<Widget> actions = [];
    if (negActionText != null) {
      actions.add(
        _buildActionButton(
          context: context,
          text: negActionText,
          onPressed: negAction,
        ),
      );
    }
    if (posActionText != null) {
      actions.add(
        _buildActionButton(
          context: context,
          text: posActionText,
          onPressed: posAction,
        ),
      );
    }

    _showAppDialog(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        title: Text(title, style: context.medium26.textTertiary.rubik),
        content: Text(message, style: context.regular16.textSecondary.rubik),
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
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return _showAppDialog<String>(
      context: context,
      child: AlertDialog(
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
          _buildActionButton(context: context, text: cancelText),
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
      ),
    );
  }
}
