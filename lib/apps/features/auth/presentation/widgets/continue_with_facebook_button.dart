import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
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
            AppAssets.icons.facebookIcon.path,
            fit: BoxFit.fitWidth,
            width: 28.r,
          ),
          Text(
            "Facebook",
            style: context.light16.textSecondary.rubik,
          ),
        ],
      ),
    );
  }
}
