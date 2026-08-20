import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const BackButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(9.w),
        child: AspectRatio(
          aspectRatio: 1,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.transparent),
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: AppColors.bgPrimary,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.w,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
