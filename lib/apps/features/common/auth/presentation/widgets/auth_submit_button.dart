import 'package:flutter/material.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/theme/app_colors.dart';
import 'custom_elevated_button.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      buttonWidth: context.width - 80,
      onPressed: onPressed,
      backgroundColor: AppColors.brandPrimary,
      child: Text(text, style: context.medium18.white.rubik),
    );
  }
}
