import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import 'custom_text_form_field.dart';

class UsernameTextFieldWidget extends StatefulWidget {
  final Color? fillColor;

  final TextEditingController? controller;

  const UsernameTextFieldWidget({super.key, this.controller, this.fillColor});

  @override
  State<UsernameTextFieldWidget> createState() =>
      _UsernameTextFieldWidgetState();
}

class _UsernameTextFieldWidgetState extends State<UsernameTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      style: context.light16.textSecondary.rubik,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => Validators.required(value),
      controller: widget.controller,
      hintText: "username",
      hintStyle: context.light16.textSecondary.rubik,
      filled: true,
      fillColor: widget.fillColor,
    );
  }
}
