import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/app_assets.dart';
import '../../../../generated/style_atoms.dart';
import '../../../../generated/translations.g.dart';
import '../theme/app_colors.dart';

class AccountStatusSwitchTile extends StatelessWidget {
  const AccountStatusSwitchTile({
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
        return Material(
          color: AppColors.transparent,
          child: ListTile(
            contentPadding: contentPadding,
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.brandPrimary8,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                AppAssets.icons.switchIcon.path,
                colorFilter: const ColorFilter.mode(
                  AppColors.brandPrimary,
                  BlendMode.srcIn,
                ),
                width: 25,
              ),
            ),
            title: Text(
              title ?? t.admin.doctorDetailsScreen.accountStatus,
              overflow: TextOverflow.ellipsis,
            ),
            titleTextStyle: context.regular12.textSecondary.rubik,
            subtitle: Text(
              value
                  ? t.admin.doctorsTab.active
                  : t.admin.doctorsTab.inactive,
              style: context.semiBold14.textTertiary.rubik,
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
