import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

/// Interactive word counter widget that listens to a [TextEditingController]
/// and displays the remaining words count in real time.
class DoctorBioWordCounter extends StatelessWidget {
  final TextEditingController controller;
  final int minWords;
  final int maxWords;

  const DoctorBioWordCounter({
    super.key,
    required this.controller,
    this.minWords = 10,
    this.maxWords = 100,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final currentWords = Validators.countWords(value.text);
        final remainingWords = maxWords - currentWords;
        final isOverLimit = currentWords > maxWords;

        final Color color = isOverLimit
            ? AppColors.statusError
            : (currentWords > 0
                ? AppColors.brandPrimary
                : AppColors.textSecondary);

        final String text = remainingWords >= 0
            ? '${t.core.common.wordsRemaining(Count: remainingWords)} ($currentWords/$maxWords)'
            : t.core.common.wordsCount(Current: currentWords, Max: maxWords);

        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 2),
            child: Text(
              text,
              style: context.regular12.rubik.copyWith(color: color),
            ),
          ),
        );
      },
    );
  }
}

/// A reusable form field widget for doctor biography input with
/// multiline support and an integrated live remaining words counter.
class DoctorBioFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final int minWords;
  final int maxWords;
  final int minLines;
  final int maxLines;
  final bool showLabel;
  final bool readOnly;
  final bool enabled;
  final Color? fillColor;
  final bool? filled;
  final Color? borderSideColor;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const DoctorBioFormField({
    super.key,
    required this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.minWords = 10,
    this.maxWords = 100,
    this.minLines = 3,
    this.maxLines = 5,
    this.showLabel = true,
    this.readOnly = false,
    this.enabled = true,
    this.fillColor = AppColors.bgPrimary,
    this.filled = true,
    this.borderSideColor,
    this.contentPadding,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Text(
            label ?? t.core.common.doctorBio,
            style: context.bold14.textTertiary.rubik,
          ),
          const SizedBox(height: 8),
        ],
        CustomTextFormField(
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
          enabled: enabled,
          fillColor: fillColor,
          filled: filled,
          borderSideColor: borderSideColor,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: TextInputType.multiline,
          hintText: hintText ?? t.core.common.doctorBioHint,
          hintStyle: context.light14.textSecondary.rubik,
          style: context.regular14.textPrimary.rubik,
          contentPadding: contentPadding ?? const EdgeInsets.all(16),
          onChanged: onChanged,
          validator: validator ??
              (value) => Validators.doctorBio(
                    value,
                    minWords: minWords,
                    maxWords: maxWords,
                  ),
        ),
        if (enabled && !readOnly)
          DoctorBioWordCounter(
            controller: controller,
            minWords: minWords,
            maxWords: maxWords,
          ),
      ],
    );
  }
}
