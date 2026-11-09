import 'package:flutter/material.dart';

import '../../../generated/style_atoms.dart';
import '../theme/app_colors.dart';
import 'app_container_with_shadow.dart';
import 'custom_text_form_field.dart';

class ProfileTextFormWidget extends StatefulWidget {
  const ProfileTextFormWidget({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.hintText,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;

  @override
  State<ProfileTextFormWidget> createState() => _ProfileTextFormWidgetState();
}

class _ProfileTextFormWidgetState extends State<ProfileTextFormWidget> {
  bool _readOnly = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: ListTile(
        title: Text(widget.label),
        titleTextStyle: context.medium10.brandPrimary.rubik,
        subtitle: CustomTextFormField(
          hintStyle: context.light10.textSecondary.rubik,
          hintText: widget.hintText,
          readOnly: _readOnly,
          focusNode: _focusNode,
          borderSideColor: AppColors.transparent,
          controller: widget.controller,
          validator: widget.validator,
          contentPadding: EdgeInsets.zero,
          style: context.regular16.textSecondary.rubik,
        ),

        trailing: IconButton(
          onPressed: () {
            setState(() {
              _readOnly = !_readOnly;
              if (!_readOnly) {
                _focusNode.requestFocus();
              } else {
                _focusNode.unfocus();
              }
            });
          },
          icon: Icon(
            _readOnly ? Icons.edit : Icons.check,
            color: AppColors.textSecondary,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
