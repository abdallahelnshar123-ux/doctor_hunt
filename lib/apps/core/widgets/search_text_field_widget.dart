import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/widgets/custom_text_form_field.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  final Widget? suffixIcon;

  const SearchTextFieldWidget({super.key, this.onChanged, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return AppContainerWithShadow(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      child: CustomTextFormField(
        borderSideColor: AppColors.transparent,
        suffixIcon: suffixIcon,
        onChanged: onChanged,
        borderRadius: 6,
        style: context.regular16.textSecondary.rubik,
        keyboardType: TextInputType.emailAddress,
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.textSecondary,
          size: 30,
        ),
        hintText: t.home.search,
        hintStyle: context.regular16.textSecondary.rubik,
        filled: true,
        fillColor: AppColors.bgPrimary,
      ),
    );
  }
}
