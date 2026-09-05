import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/widgets/custom_text_form_field.dart';
import '../utils/validators.dart';

class UsernameTextFieldWidget extends StatelessWidget {
  final Color? fillColor;
  final String? hintText;

  final TextEditingController? controller;

  const UsernameTextFieldWidget({
    super.key,
    this.controller,
    this.fillColor,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    var t = Translations.of(context);
    return CustomTextFormField(
      style: context.light16.textSecondary.rubik,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => Validators.required(value),
      controller: controller,
      hintText: hintText ?? t.auth.username,
      hintStyle: context.light16.textSecondary.rubik,
      filled: true,
      fillColor: fillColor,
    );
  }
}
