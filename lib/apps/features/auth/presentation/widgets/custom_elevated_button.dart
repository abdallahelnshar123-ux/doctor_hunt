import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color backgroundColor;
  final Color? borderSideColor;
  final double? buttonWidth;
  final Widget child;
  final double? borderRadius;
  final void Function()? onPressed;
  final double? elevation;
  final double? paddingVertical;
  final double? paddingHorizontal;

  const CustomElevatedButton({
    super.key,
    required this.child,
    this.buttonWidth,
    this.borderRadius,
    required this.backgroundColor,
    this.borderSideColor,
    required this.onPressed,
    this.elevation,
    this.paddingHorizontal,
    this.paddingVertical,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 0,
        disabledBackgroundColor: AppColors.transparent,
        disabledForegroundColor: AppColors.transparent,
        minimumSize: Size(buttonWidth ?? 0, 0),
        side: BorderSide(color: borderSideColor ?? AppColors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? 15,
          horizontal: paddingHorizontal ?? 10,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
