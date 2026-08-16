import 'package:doctor_hunt/apps/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'custom_elevated_button.dart';

class ContinueWithFacebookButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueWithFacebookButton({super.key, required this.onPressed});

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
            AppAssets.facebookIcon,
            fit: BoxFit.fitWidth,
            width: 28.r,
          ),
          Text(
            "Facebook",
            style: AppStyles.rubikLight16(AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
