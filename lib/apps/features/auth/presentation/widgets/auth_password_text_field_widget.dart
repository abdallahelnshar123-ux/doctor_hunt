import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/validators.dart';
import 'custom_text_form_field.dart';

class AuthPasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const AuthPasswordTextFieldWidget({
    super.key,
    this.onChanged,
    this.controller,
  });

  @override
  State<AuthPasswordTextFieldWidget> createState() =>
      _AuthPasswordTextFieldWidget();
}

class _AuthPasswordTextFieldWidget extends State<AuthPasswordTextFieldWidget> {
  bool isObscure = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      style: AppStyles.rubikLight16(AppColors.textSecondary),
      onChanged: widget.onChanged,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) => Validators.password(value),
      controller: widget.controller,
      hintText: "Password",
      hintStyle: AppStyles.rubikLight16(AppColors.textSecondary),
      filled: true,
      obscureText: isObscure,
      fillColor: AppColors.bgPrimary,
      suffixIcon: IconButton(
        isSelected: !isObscure,
        selectedIcon: Icon(
          Icons.visibility_rounded,
          color: AppColors.textSecondary,
        ),
        onPressed: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        icon: Icon(
          Icons.visibility_off_rounded,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
