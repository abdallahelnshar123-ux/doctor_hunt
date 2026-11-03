import 'package:flutter/material.dart';

import '../../../generated/style_atoms.dart';
import '../theme/app_colors.dart';

/// A custom button widget styled for negative or destructive actions.
///
/// Use this widget for actions with a negative intent or high caution,
/// such as logging out, deleting data, or cancelling operations.
///
/// It applies error status styling ([AppColors.statusErrorSurface] background
/// and [AppColors.statusError] foreground/icon) to signal destructive actions visually.
class CustomNegativeButton extends StatelessWidget {
  /// Creates a [CustomNegativeButton].
  const CustomNegativeButton({super.key, this.text, this.icon, this.onPressed});

  /// Optional icon widget displayed alongside the button text.
  final Widget? icon;

  /// Text label displayed on the button.
  final String? text;

  /// Callback function invoked when the button is pressed.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: icon,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        backgroundColor: WidgetStatePropertyAll(AppColors.statusErrorSurface),
        iconColor: WidgetStatePropertyAll(AppColors.statusError),
        iconSize: WidgetStatePropertyAll(20),
        textStyle: WidgetStatePropertyAll(context.semiBold14.statusError.rubik),
        foregroundColor: WidgetStatePropertyAll(AppColors.statusError),
      ),

      onPressed: onPressed,
      label: Text(text ?? ""),
    );
  }
}
