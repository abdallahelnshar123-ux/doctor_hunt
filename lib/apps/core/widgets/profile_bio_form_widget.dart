import 'package:flutter/material.dart';

import '../../../generated/style_atoms.dart';
import '../../../generated/translations.g.dart';
import '../theme/app_colors.dart';
import '../utils/validators.dart';
import 'app_container_with_shadow.dart';
import 'custom_text_form_field.dart';
import 'doctor_bio_form_field.dart';

/// A card-styled form widget for doctor biography used in the doctor profile screen,
/// featuring read-only toggling, multiline support, validation, and a live word counter.
class ProfileBioFormWidget extends StatefulWidget {
  const ProfileBioFormWidget({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.hintText,
    this.minWords = 10,
    this.maxWords = 100,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final int minWords;
  final int maxWords;

  @override
  State<ProfileBioFormWidget> createState() => _ProfileBioFormWidgetState();
}

class _ProfileBioFormWidgetState extends State<ProfileBioFormWidget> {
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.label,
                  style: context.medium10.brandPrimary.rubik,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
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
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            CustomTextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              readOnly: _readOnly,
              minLines: _readOnly ? 1 : 3,
              maxLines: _readOnly ? 4 : 5,
              keyboardType: TextInputType.multiline,
              hintText: widget.hintText ?? t.core.common.doctorBioHint,
              hintStyle: context.light12.textSecondary.rubik,
              style: context.regular14.textPrimary.rubik,
              borderSideColor: AppColors.transparent,
              fillColor: AppColors.transparent,
              contentPadding: EdgeInsets.zero,
              validator: widget.validator ??
                  (value) => Validators.doctorBio(
                        value,
                        minWords: widget.minWords,
                        maxWords: widget.maxWords,
                      ),
            ),
            if (!_readOnly) ...[
              const SizedBox(height: 4),
              DoctorBioWordCounter(
                controller: widget.controller,
                minWords: widget.minWords,
                maxWords: widget.maxWords,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
