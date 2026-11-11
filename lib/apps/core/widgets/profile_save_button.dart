import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../generated/style_atoms.dart';
import '../../../generated/translations.g.dart';
import '../../features/common/auth/presentation/widgets/custom_elevated_button.dart';
import '../theme/app_colors.dart';

class ProfileSaveButton extends StatelessWidget {
  const ProfileSaveButton({
    super.key,
    required this.onPressed,
    required this.valueListenable,
  });

  final void Function()? onPressed;
  final ValueListenable<bool> valueListenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: valueListenable,
      builder: (context, showButton, child) {
        return Visibility(
          visible: showButton,
          child: CustomElevatedButton(
            backgroundColor: AppColors.brandPrimary,
            onPressed: onPressed,
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_rounded,
                  color: AppColors.white,
                  size: 20,
                ),
                Text(
                  t.admin.updateDoctorDetails.saveChanges,
                  style: context.semiBold16.white.rubik,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
