import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

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
      style: context.light16.textSecondary.rubik,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => Validators.email(value),
      controller: widget.controller,
      hintText: Translations.of(context).auth.email,
      hintStyle: context.light16.textSecondary.rubik,
      filled: true,
      fillColor: widget.fillColor,
    );
  }
}
