import 'package:flutter/material.dart';

import '../../../generated/style_atoms.dart';
import '../theme/app_colors.dart';

class SnackBarUtils {
  /// Shared helper method to display a styled [SnackBar].
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  _showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required TextStyle textStyle,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry margin = const EdgeInsets.all(5),
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: margin,
        content: Text(message, style: textStyle),
        backgroundColor: backgroundColor,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    return _showSnackBar(
      context: context,
      message: message,
      backgroundColor: AppColors.brandPrimary,
      textStyle: context.regular14.white.rubik,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showErrorSnackBar({required BuildContext context, required String message}) {
    return _showSnackBar(
      context: context,
      message: message,
      backgroundColor: AppColors.statusError,
      textStyle: context.regular14.white.rubik,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showInfoSnackBar({required BuildContext context, required String message}) {
    return _showSnackBar(
      context: context,
      message: message,
      backgroundColor: AppColors.borderMuted,
      textStyle: context.regular14.textPrimary.rubik,
    );
  }
}
