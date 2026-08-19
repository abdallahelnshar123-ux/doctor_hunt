import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

typedef OnChanged = void Function(String)?;
typedef OnValidator = String? Function(String?)?;
typedef OnFieldSubmitted = void Function(String)?;

class CustomTextFormField extends StatelessWidget {
  final Color? borderSideColor;
  final Color? fillColor;
  final bool? filled;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final OnChanged onChanged;
  final OnFieldSubmitted onFieldSubmitted;
  final TextEditingController? controller;
  final OnValidator validator;
  final TextInputType? keyboardType;
  final String obscuringCharacter;
  final bool obscureText;
  final double borderRadius;

  const CustomTextFormField({
    super.key,
    this.style,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.fillColor,
    this.filled,
    this.borderSideColor,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.controller,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.keyboardType,
    this.errorStyle,
    this.onFieldSubmitted,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines ?? 1,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      style: style,
      cursorColor: AppColors.brandPrimary,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(17.h),
        filled: filled,
        fillColor: fillColor,
        errorMaxLines: 2,
        errorStyle: errorStyle,
        enabledBorder: builtDecorationBorder(
          borderColor: borderSideColor ?? AppColors.borderDefault,
        ),
        focusedBorder: builtDecorationBorder(
          borderColor: borderSideColor ?? AppColors.borderDefault,
        ),
        errorBorder: builtDecorationBorder(borderColor: Colors.red),
        focusedErrorBorder: builtDecorationBorder(borderColor: Colors.red),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // prefixIconConstraints: BoxConstraints.tight(Size(0.1.w, 0.06.w)),
      ),
    );
  }

  OutlineInputBorder builtDecorationBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }
}
