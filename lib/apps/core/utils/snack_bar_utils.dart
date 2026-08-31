import 'package:flutter/material.dart';

import '../../../generated/style_atoms.dart';
import '../theme/app_colors.dart';

class SnackBarUtils {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        content: Text(message, style: context.regular14.brandPrimary.rubik),
        backgroundColor: AppColors.brandPrimary,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showErrorSnackBar({required BuildContext context, required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        content: Text(message, style: context.regular14.brandPrimary.rubik),
        backgroundColor: AppColors.brandPrimaryDark,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showInfoSnackBar({required BuildContext context, required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        content: Text(message, style: context.regular14.brandPrimary.rubik),
        backgroundColor: AppColors.brandPrimary,
      ),
    );
  }
}
