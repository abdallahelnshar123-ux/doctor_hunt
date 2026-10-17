import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class CustomTextPassword extends StatefulWidget {
  const CustomTextPassword({
    super.key,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.style,
    this.fillColor = AppColors.bgPrimary,
    this.filled = true,
    this.borderRadius = 16,
    this.borderSideColor,
    this.keyboardType = TextInputType.visiblePassword,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color fillColor;
  final bool filled;
  final double borderRadius;
  final Color? borderSideColor;
  final TextInputType keyboardType;

  @override
  State<CustomTextPassword> createState() => _CustomTextPasswordState();
}

class _CustomTextPasswordState extends State<CustomTextPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      style: widget.style,
      hintText: widget.hintText ?? t.auth.password,
      hintStyle: widget.hintStyle,
      fillColor: widget.fillColor,
      filled: widget.filled,
      borderRadius: widget.borderRadius,
      borderSideColor: widget.borderSideColor,
      obscureText: _isObscure,
      keyboardType: widget.keyboardType,
      suffixIcon: IconButton(
        isSelected: !_isObscure,
        selectedIcon: Icon(
          Icons.visibility_rounded,
          color: AppColors.textSecondary,
        ),
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
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
