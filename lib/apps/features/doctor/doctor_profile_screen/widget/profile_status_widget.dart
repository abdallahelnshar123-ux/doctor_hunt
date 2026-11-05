import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../../generated/translations.g.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileStatusWidget extends StatelessWidget {
  const ProfileStatusWidget({
    super.key,
    required this.isActive,
    required this.onChanged,
    this.title,
    this.contentPadding = EdgeInsets.zero,
  });

  final ValueListenable<bool> isActive;
  final ValueChanged<bool> onChanged;
  final String? title;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isActive,
      builder: (context, value, _) {
        return AppContainerWithShadow(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            subtitleTextStyle: context.regular16.textSecondary.rubik.copyWith(
              height: 2,
            ),
            title: Text(t.doctor.doctorProfileScreen.status),
            titleTextStyle: context.medium10.brandPrimary.rubik,
            subtitle: Text(
              value ? t.admin.doctorsTab.active : t.admin.doctorsTab.inactive,
            ),
            trailing: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.brandPrimary,
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return const Icon(
                    Icons.check_rounded,
                    color: AppColors.brandPrimary,
                  );
                }
                return null;
              }),
            ),
          ),
        );
      },
    );
  }
}
