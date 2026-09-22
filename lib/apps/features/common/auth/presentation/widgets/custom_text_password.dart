import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class CustomTextPassword extends CustomTextFormField {
  CustomTextPassword({
    super.key,
    super.controller,
    super.onChanged,
    super.onFieldSubmitted,
    super.validator,
    super.hintText,
    super.hintStyle,
    super.style,
    super.fillColor = AppColors.bgPrimary,
    super.filled = true,
    super.borderRadius = 16,
    super.borderSideColor,
    super.keyboardType = TextInputType.visiblePassword,
  });

  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isObscure,
      builder: (context, isObscure, child) {
        return CustomTextFormField(
          key: key,
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator ?? (value) => Validators.password(value),
          style: style ?? context.light16.textSecondary.rubik,
          hintText: hintText ?? Translations.of(context).auth.password,
          hintStyle: hintStyle ?? context.light16.textSecondary.rubik,
          fillColor: fillColor,
          filled: filled,
          borderRadius: borderRadius,
          borderSideColor: borderSideColor,
          obscureText: isObscure,
          keyboardType: keyboardType,
          suffixIcon: IconButton(
            isSelected: !isObscure,
            selectedIcon: Icon(
              Icons.visibility_rounded,
              color: AppColors.textSecondary,
            ),
            onPressed: () {
              _isObscure.value = !_isObscure.value;
            },
            icon: Icon(
              Icons.visibility_off_rounded,
              color: AppColors.textSecondary,
            ),
          ),
        );
      },
    );
  }
}
