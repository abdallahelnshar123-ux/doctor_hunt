import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import 'custom_elevated_button.dart';

class ContinueWithGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueWithGoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      elevation: 1,
      onPressed: onPressed,
      backgroundColor: AppColors.white,
      child: Row(
        spacing: 13,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.icons.googleIcon.path,
            fit: BoxFit.fitWidth,
            width: 28.r,
          ),
          Text(
            "Google",
            style: context.light16.textSecondary.rubik,
          ),
        ],
      ),
    );
  }
}
