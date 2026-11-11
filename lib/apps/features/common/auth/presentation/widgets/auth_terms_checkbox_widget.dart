import 'package:flutter/material.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/theme/app_colors.dart';

class AuthTermsCheckboxWidget extends StatelessWidget {
  const AuthTermsCheckboxWidget({
    super.key,
    required this.isAgreedToTerms,
  });

  final ValueNotifier<bool> isAgreedToTerms;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isAgreedToTerms,
      builder: (context, isAgreed, child) {
        return TextButton.icon(
          icon: Icon(isAgreed ? Icons.circle : Icons.circle_outlined),
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            iconColor: const WidgetStatePropertyAll(AppColors.textSecondary),
            iconSize: const WidgetStatePropertyAll(25),
            textStyle: WidgetStatePropertyAll(
              context.regular12.textSecondary.rubik,
            ),
            foregroundColor:
                const WidgetStatePropertyAll(AppColors.textSecondary),
          ),
          onPressed: () {
            isAgreedToTerms.value = !isAgreedToTerms.value;
          },
          label: Text(t.auth.agreeTerms),
        );
      },
    );
  }
}
