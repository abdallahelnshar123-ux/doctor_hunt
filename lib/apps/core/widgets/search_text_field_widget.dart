import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/auth/presentation/widgets/custom_text_form_field.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  final Widget? suffixIcon;

  const SearchTextFieldWidget({super.key, this.onChanged, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(20),
            blurRadius: 25,
            spreadRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: CustomTextFormField(
        borderSideColor: AppColors.transparent,
        suffixIcon: suffixIcon,
        onChanged: onChanged,
        borderRadius: 6.r,
        style: context.regular16.textSecondary.rubik,
        keyboardType: TextInputType.emailAddress,
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.textSecondary,
          size: 30,
        ),
        hintText: "search",
        hintStyle: context.regular16.textSecondary.rubik,
        filled: true,
        fillColor: AppColors.bgPrimary,
      ),
    );
  }
}
