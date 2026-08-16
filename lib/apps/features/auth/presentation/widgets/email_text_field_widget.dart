import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/validators.dart';
import 'custom_text_form_field.dart';

class EmailTextFieldWidget extends StatefulWidget {
  final Color? fillColor;

  final TextEditingController? controller;

  const EmailTextFieldWidget({super.key, this.controller, this.fillColor});

  @override
  State<EmailTextFieldWidget> createState() => _EmailTextFieldWidgetState();
}

class _EmailTextFieldWidgetState extends State<EmailTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      style: AppStyles.rubikLight16(AppColors.textSecondary),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => Validators.email(value),
      controller: widget.controller,
      hintText: "email",
      hintStyle: AppStyles.rubikLight16(AppColors.textSecondary),
      filled: true,
      fillColor: widget.fillColor,
    );
  }
}
